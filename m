From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: [PATCH] Fix git rpush.
Date: Thu, 5 May 2005 13:31:53 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0505051330260.20553@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 14:25:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTfQ1-0006Rb-IV
	for gcvg-git@gmane.org; Thu, 05 May 2005 14:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVEEMcC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 08:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVEEMcC
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 08:32:02 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:2252 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262076AbVEEMb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 08:31:59 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:40162)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:aia21) id 1DTfWD-0006Do-UF (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 05 May 2005 13:31:53 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DTfWD-0005hk-Az (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 05 May 2005 13:31:53 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Linus,

Following up from my previouos patch to rpull, please also apply the below 
patch which fixes rpush.c to call git-rpull rather than rpull which no 
longer exists after the Big Rename(TM)...  Thanks.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

--- git.git/rpush.c.old	2005-05-05 13:28:37.000000000 +0100
+++ git.git/rpush.c	2005-05-05 13:28:57.000000000 +0100
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
         }
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	if (setup_connection(&fd_in, &fd_out, "rpull", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-rpull", url, arg, argv + 1))
 		return 1;
 
 	service(fd_in, fd_out);
