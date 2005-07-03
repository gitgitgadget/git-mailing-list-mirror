From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 03 Jul 2005 10:38:27 +0200
Message-ID: <m3ekagp9mk.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 03 11:08:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp0SK-00043r-IK
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 11:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGCJH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGCJH3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 05:07:29 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:33523 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261240AbVGCJHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 05:07:15 -0400
Received: from r3000.localdomain (212.181.176.10) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 42B813B000235C0B; Sun, 3 Jul 2005 11:07:10 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j63976xU028217;
	Sun, 3 Jul 2005 11:07:06 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j638cRnU027039;
	Sun, 3 Jul 2005 10:38:27 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1119994003.9631.6.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> A new StGIT release is available from http://procode.org/stgit/
> 
> What's new in version 0.3:
>       * closer to the Quilt functionality
>       * there is only one commit object per patch which can be
>         indefinitely modified using the 'refresh' command. The commit
>         objects are stacked on top of the base and can also be accessed
>         via standard GIT commands
>       * no 'commit' command. Use 'refresh' instead
> 
> StGIT is a Python application providing similar functionality to Quilt
> (i.e. pushing/popping patches to/from a stack) on top of GIT. These
> operations are performed using GIT commands and the patches are stored
> as GIT commit objects, allowing easy merging of the StGIT patches into
> other repositories using standard GIT functionality.

This is good stuff and the 3-way merge really simplifies things.
However, if there is a merge conflict, you will basically be stuck
with a 2-way merge when resolving manually. It's usually much easier
if you can see all three version, so I think it's better to use -A
instead of -E in the diff3 command.

--- stgit-0.3/gitmergeonefile.py~	2005-06-28 14:15:22.000000000 +0200
+++ stgit-0.3/gitmergeonefile.py	2005-07-03 02:33:13.000000000 +0200
@@ -108,7 +108,7 @@
         # 3-way merge
         else:
             merge_ok = os.system('diff3 -L local -L older -L remote '
-                                 '-m -E %s %s %s > %s'
+                                 '-m -A %s %s %s > %s'
                                   % (src1, orig, src2, path)) == 0
 
             if merge_ok:

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
