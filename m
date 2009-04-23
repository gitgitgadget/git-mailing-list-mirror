From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Explain seemingly pointless use of system in difftool
Date: Thu, 23 Apr 2009 21:18:09 +0200
Message-ID: <20090423191809.GC8433@blimp.localdomain>
References: <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com> <7vr5zk346d.fsf@gitster.siamese.dyndns.org> <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com> <7v4owgyp8x.fsf@gitster.siamese.dyndns.org> <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com> <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org> <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com> <7vhc0fv2xb.fsf@gitster.siamese.dyndns.org> <20090423185732.GA8433@blimp.localdomain> <20090423190835.GB8433@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4Sl-0001EZ-6d
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814AbZDWTST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757454AbZDWTSS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:18:18 -0400
Received: from mout5.freenet.de ([195.4.92.95]:57297 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757386AbZDWTSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:18:17 -0400
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #89)
	id 1Lx4R4-0004De-77; Thu, 23 Apr 2009 21:18:14 +0200
Received: from x6383.x.pppool.de ([89.59.99.131]:54864 helo=tigra.home)
	by 1.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1Lx4R4-0006AR-15; Thu, 23 Apr 2009 21:18:14 +0200
Received: from blimp.localdomain (ubuntu.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 92323277D8;
	Thu, 23 Apr 2009 21:18:09 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4FA1336D28; Thu, 23 Apr 2009 21:18:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090423190835.GB8433@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117368>

Portability reasons.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Thu, Apr 23, 2009 21:08:35 +0200:
> Alex Riesen, Thu, Apr 23, 2009 20:57:32 +0200:
> > I'll add this comment regarding use of system in the case where exec
> > is right choice on all accounts and resend the patch:
> > 
> >     # ActiveState Perl for Win32 does not implement POSIX semantics of
> >     # exec* system call. It just spawns the given executable and finishes
> >     # the starting program, exiting with code 0.
> >     # system will at least catch the errors in returned by git diff,
> >     # allowing the caller of git difftool better handling of failures.
> 
> Oh... I'm too late...
> 

There.

 git-difftool.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index bd828c2..9255d23 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -82,5 +82,11 @@ sub generate_command
 }
 
 setup_environment();
+
+# ActiveState Perl for Win32 does not implement POSIX semantics of
+# exec* system call. It just spawns the given executable and finishes
+# the starting program, exiting with code 0.
+# system will at least catch the errors returned by git diff,
+# allowing the caller of git difftool better handling of failures.
 my $rc = system(generate_command());
 exit($rc | ($rc >> 8));
-- 
1.6.3.rc1.74.g42ff
