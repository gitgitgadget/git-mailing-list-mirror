From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 08:28:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140823220.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <20070213204248.GA21046@uranus.ravnborg.org>
 <Pine.LNX.4.64.0702131524130.3604@woody.linux-foundation.org>
 <20070214084121.GB25617@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMzu-0003I2-Th
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXBNQ2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbXBNQ2o
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:28:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34542 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932368AbXBNQ2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:28:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EGSQhB007371
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 08:28:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EGSOPB002481;
	Wed, 14 Feb 2007 08:28:25 -0800
In-Reply-To: <20070214084121.GB25617@uranus.ravnborg.org>
X-Spam-Status: No, hits=-0.412 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39669>



On Wed, 14 Feb 2007, Sam Ravnborg wrote:
>
> > (Which means that I suspect I made the default for "auto_crlf" be wrong in 
> > my patch: I probably should not default to checking out with CRLF, but 
> > checking out with just LF, and only do the CRLF->LF conversion on input).
>
> Expect that it seems a few br0ken programs yet does not support LF as
> end-of-line marker - so .gitattriutes make take special care here.

Yes, but I also think that even without .gitattributes, you just want to 
have a default for what "text" actually means, and it's entirely possible 
that the default should be: "check out with just LF, and on check-in turn 
CRLF into LF".

But exactly because _some_ programs might want to always see CRLF on input 
too, it should be overridable. 

Or maybe the default should be "turn into CRLF", and there should just be 
an option to make it check out as LF-only.

Regardless, I think that is independent of ".gitattributes". The 
_attribute_ should be "text", but what it then means in practice is a 
separate flag.

And yes, we *could* have a per-file attribute ("text,crlf-checkout") which 
could be used to say "I want to always check out as crlf regardless of any 
other policy") and the same for lf-only, but I seriously doubt that 
anybody really needs that kind of knob-tweaking. At some point it's just 
fine to say "you're crazy".

			Linus
