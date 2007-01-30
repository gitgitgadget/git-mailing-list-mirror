From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 10:27:21 -0500
Message-ID: <20070130152721.GB25779@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <20070129223513.GA31372@spearce.org> <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com> <20070129232425.GB31372@spearce.org> <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com> <46d6db660701300007v573832b5pc7ac41059dc4490e@mail.gmail.com> <Pine.LNX.4.63.0701301114590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 16:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HButN-0007gN-Vk
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965603AbXA3P10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965609AbXA3P10
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:27:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58218 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965603AbXA3P1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:27:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HButC-0000xd-JB; Tue, 30 Jan 2007 10:27:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A7A3E20FBAE; Tue, 30 Jan 2007 10:27:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701301114590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38158>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 30 Jan 2007, Christian MICHON wrote:
> > just to be more clear: when using the .bat shortcut, calling gitk
> > > from within git-gui fails.
> 
> I guess you need to change the .bat shortcut, so that the tcl script is 
> called via bash instead of directly from cmd.
> 
> Otherwise git-gui does not have a chance to find the MSYS environment.

Hmmph.  The [is_Cygwin] test within git-gui causes it to setup the
.bat shortcut using:

  $(cygpath --windows /bin/sh) --login -c 'git git-gui'

for exactly that reason.  I didn't think that with MSYS there was
environment to hand down through a shell's init scripts.  I thought
it was all coming from Windows itself.  Oops.

When starting gitk, git-gui assumes (rightly or wrongly) that gitk
is a Tcl/Tk script and launches it with the same Tcl interpreter
that is running git-gui.  I did that to bypass the unnecessary
fork/exec of a shell just to enter a wish process.  I had assumed
that would also work well on the MSYS case.  Apparently not.

Patches to git-gui would be welcome.  It will probably be a few weeks
before I can get an MSYS+Git configuration working that I can test
git-gui against.  I'm just swamped with too many tasks right now,
and this, although interesting enough to fix, is likely to take a
back seat.

-- 
Shawn.
