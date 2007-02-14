From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 17:47:35 +0100
Message-ID: <20070214164735.GA28359@uranus.ravnborg.org>
References: <200702130932.51601.litvinov2004@gmail.com> <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org> <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org> <20070213204248.GA21046@uranus.ravnborg.org> <Pine.LNX.4.64.0702131524130.3604@woody.linux-foundation.org> <20070214084121.GB25617@uranus.ravnborg.org> <Pine.LNX.4.64.0702140823220.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNHz-00035Z-Ni
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbXBNQrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbXBNQrU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:47:20 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:55755 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392AbXBNQrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:47:19 -0500
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 457988012E4;
	Wed, 14 Feb 2007 17:47:09 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id EABD9580D2; Wed, 14 Feb 2007 17:47:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702140823220.3604@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39678>

On Wed, Feb 14, 2007 at 08:28:24AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 14 Feb 2007, Sam Ravnborg wrote:
> >
> > > (Which means that I suspect I made the default for "auto_crlf" be wrong in 
> > > my patch: I probably should not default to checking out with CRLF, but 
> > > checking out with just LF, and only do the CRLF->LF conversion on input).
> >
> > Expect that it seems a few br0ken programs yet does not support LF as
> > end-of-line marker - so .gitattriutes make take special care here.
> 
> Yes, but I also think that even without .gitattributes, you just want to 
> have a default for what "text" actually means, and it's entirely possible 
> that the default should be: "check out with just LF, and on check-in turn 
> CRLF into LF".
The definition of what is "text" and what action to take upon check-in /
check-out of text is two sepearate things.

I could see it as beneficial as a per-project or even as an overall
git-policy to say "checkin-as-LF" - "checkout-as-LF" to overcome
interoperability issues when more tools gets UNIX* based.

> 
> But exactly because _some_ programs might want to always see CRLF on input 
> too, it should be overridable. 
Which is where I see .gitattributes come into play.
-> A rule that says files with extension .prj and of type "text" shall not see
any conversion.

In this way almost all "text" over time get a proper format and the remaining
brain-dead tools that continue to save in CRLF format will not destroy the sane
LF format.

If anything gets defualt I would vote for LF. But overrideable.

My editor-of-choice does eol auto-sense. If I recall correct it scans the
first 200 lines and counts number of CR,LF,CRLF and based on this judge the
actual eol character used. But not all editors are that sensible :-(

	Sam
