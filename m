From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: msgmft segfaulting on tiger
Date: Fri, 22 Feb 2008 01:58:36 -0500
Message-ID: <20080222065836.GE8410@spearce.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com> <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Basilio =?utf-8?B?QnJpY2XigJPDsW8gSC4=?= <bbh@tampico.org.mx>,
	gsaldana@gmail.com
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 07:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSRsN-0005nB-0u
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 07:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYBVG6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 01:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbYBVG6n
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 01:58:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47779 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbYBVG6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 01:58:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JSRri-0004PE-5o; Fri, 22 Feb 2008 01:58:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9006120FBAE; Fri, 22 Feb 2008 01:58:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74696>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On Fri, Feb 22, 2008 at 12:53 PM, Martin Langhoff
> <martin.langhoff@gmail.com> wrote:
> > Today I've debugged a compile of git 1.5.4.2 failing on OSX Tiger (on
> >  Basilio's machine). The problem is during the git-gui build, in the PO
> >  file handling. Apparently fmtmsg (from fink) segfaults on de.po so the
> >  fix is to say
> 
> Grumble. It seems like msgfmt that fink provides actually does not
> support the --tcl flag. So perhaps the right thing is to always say
> NO_MSGFMT on OSX?

I'd hate to do this.  GNU msgfmt does better checking on the
messages then po2msg.sh does, and its a tiny bit faster.  So
I'd rather stick to the standard tool that is widely used.

Currently we are looking to see if msgfmt generates an exit status
of 127, and if so we fallback to po2msg.sh.  Apparently however
that test is passing and thus you are using the fink msgfmt.

Did you try building with `make V=1` to look at the full output and
not the prettied up simplified output the Makefile uses by default?
It won't fix your issue but it may be interesting to see if msgfmt
is failing with a particular message or not.

-- 
Shawn.
