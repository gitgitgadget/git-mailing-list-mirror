From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin/describe.c: ignore untracked changes in submodules
Date: Thu,  9 Sep 2010 14:12:19 -0500
Message-ID: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
Cc: johannes.schindelin@gmx.de, Jens.Lehmann@web.de,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 21:13:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmYK-0006Xv-SR
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0IITMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:12:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34810 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0IITMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:12:36 -0400
Received: by mail.nrlssc.navy.mil id o89JCVms002843; Thu, 9 Sep 2010 14:12:31 -0500
X-OriginalArrivalTime: 09 Sep 2010 19:12:30.0924 (UTC) FILETIME=[F346E0C0:01CB5052]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155883>

From: Brandon Casey <drafnel@gmail.com>

Since 'git describe' does not append -dirty to the version string it
produces when untracked files exist in the working directory of the main
repository, it should not do so for submodules either.

Add --ignore-submodules=untracked to the call to diff-index which is used
to decide whether or not the '-dirty' string is necessary.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin/describe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..6c4f15b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -29,7 +29,8 @@ static const char *dirty;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
-	"diff-index", "--quiet", "HEAD", "--", NULL
+	"diff-index", "--quiet", "--ignore-submodules=untracked", "HEAD",
+	"--", NULL
 };
 
 
-- 
1.7.2.1
