From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git on Solaris?
Date: Wed, 20 Feb 2008 17:52:08 -0500
Message-ID: <20080220225208.GY24004@spearce.org>
References: <200802202158.m1KLw2wM014330@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Quinlan <danq@brtt.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:52:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxo1-0003hk-Hx
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYBTWwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbYBTWwN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:52:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56093 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYBTWwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:52:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JRxnF-00044V-Hn; Wed, 20 Feb 2008 17:52:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 126E120FBAE; Wed, 20 Feb 2008 17:52:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802202158.m1KLw2wM014330@rs40.luxsci.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74561>

Daniel Quinlan <danq@brtt.com> wrote:
> However, it's by no means straightforward to compile git on solaris,  
> no one seems to provide
> a compiled version (eg, sunfreeware.com), and I haven't found any  
> clear cookbook description of how to
> compile, test and install git on the solaris (10) platform.
> 
> So my questions are:
> 
> * Is there a set of instructions for Solaris somewhere that I've missed?
> 
> * Is anyone actually using git on Solaris?

Yes.  I run it on Solaris 9 and on Solaris 10, SPARC editions anyway.
I haven't personally tested it on the x86 Solaris version yet but
I don't expect any major differences from the SPARC edition.
 
>  Right now, it appears that gnu make and bash are both required to  
> make git, and perhaps a bunch
>  of other gnu utilities.

At least GNU make is required to compile Git.  This is available
pretty readily, and also builds fairly easy out of the box as
source code if (for some reason) you cannot install a version from
sunfreeware.com.  Some little voice in the back of my head thinks it
may also be available out of the box on Solaris 10 but I'm not sure.

> * Once made, do the git scripts require gnu utilities to work  
> properly?  I'm a bit leery of putting the
>     GNU utilities ahead of the solaris ones in my path (and everyone  
> elses).

Either the GNU utilties or /usr/xpg4/bin needs to be early in your
PATH so that Git can pick up tools from there.  I think I'm actually
building Git with a config.mak along the lines of:

	$ cat - >config.mak
	SHELL=/usr/xpg4/bin/sh
	SHELL_PATH=$(SHELL)
	^D

and then ensuring users have /usr/xpg4/bin very early in their PATH
environment variable.

It does manage to build with both gcc and the Solaris workshop
compilers, so about the only GNU program really necessary to get
git built is GNU make.  Of course I'm only talking about the really
core functionality; tools like git-p4, git-svn, gitk, git-gui will
require support beyond that (Python, Perl SVN bindings, Tcl/Tk...).

-- 
Shawn.
