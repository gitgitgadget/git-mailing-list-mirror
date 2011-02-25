From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Fri, 25 Feb 2011 22:24:55 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110225192455.GA7130@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:23:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3Gg-0007Ge-2y
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab1BYTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 14:23:53 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:45722 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab1BYTXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 14:23:52 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1Pt3GV-00047F-Rj; Fri, 25 Feb 2011 22:23:47 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1Pt3Hb-0000KJ-Bu; Fri, 25 Feb 2011 22:24:55 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1102251208380.1561@bonsai2>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167922>

On Fri, Feb 25, 2011 at 12:11:59PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> 
> > Johannes, can we please try my patch[1] for msys.dll not to load 
> > user32.dll for every msys program (i.e. sh.exe too)? Combined together 
> > with 3 clipboard functions removal (details in [2]) from sh.exe, I bet 
> > this will result in significantly faster shell startup, configure runs, 
> > etc...
> > 
> > This days I have lack of access to windows machines, only wine, so I
> > desperately need someones help to at least first rebuild msys.dll.
> > 
> > [1] http://repo.or.cz/w/msys/kirr.git/commitdiff/f7d7efebd35e8e5bf6d685ff4f1197941984be04
> > [2] http://repo.or.cz/w/msys/kirr.git/commitdiff/a97bed5d22f9c05f39776d8ea7856db4ce572dc5

For [1] please do

git://repo.or.cz/msysgit/kirr.git ks/no-user32-in-msysdll       # into msys

Kirill Smelkov (1):
      msys.dll: Don't pull user32.dll & friends just to detect whether right alt should be used as meta

 ...n-t-pull-user32.dll-friends-just-to-detec.patch |   98 ++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 src/rt/patches/0011-msys.dll-Don-t-pull-user32.dll-friends-just-to-detec.patch


> Three things:
> 
> [2] does not apply cleanly, so I am still desperately trying to find some 
> time to finish it off (the patches are to msys.git, not the 'msys' branch 
> of msysgit.git, so I had to find a quarter an hour in order to put them 
> there in the first place, taking up all the Git time budget I wanted to 
> allow myself for this week).

For [2] please do

    git pull git://repo.or.cz/msysgit/kirr.git ks/xser32.dll    # into devel

Kirill Smelkov (3):
      hack: xser32.dll -- Fake user32.dll like stub (for sh.exe not to load user32.dll)
      xser32.dll: Fake user32.dll like stub (for sh.exe not to load user32.dll)
      hack: sh.exe -- link to xser32.dll instead of user32.dll

 bin/sh.exe            |  Bin 567296 -> 567296 bytes
 bin/xser32.dll        |  Bin 0 -> 4373 bytes
 src/xser32/Makefile   |   13 +++++++++++++
 src/xser32/release.sh |    7 +++++++
 src/xser32/xser32.c   |   27 +++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 bin/xser32.dll
 create mode 100644 src/xser32/Makefile
 create mode 100644 src/xser32/release.sh
 create mode 100644 src/xser32/xser32.c
 
> Further, I think that my beloved Shift+Insert will no longer work with 
> your [2].

Probably yes, but this is only an experiment to see whether sh.exe starts to be
really faster. For proper solution we'll need to patch bash to use msys's
/dev/clipboard, or link to user32 symbols lazily.

> And lastly, in [2] you claim that you cross-built msys-1.0.dll. I would 
> like to have a script doing that in msysgit.git.

This is in progress. Preliminary stuff (cross-built msys.dll no longer needs
mingwm10.dll), is here:

http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys



Sorry, I hoped to finish 2a today, but have to run...


Thanks,
Kirill
