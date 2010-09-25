From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 09/16] t5602 (clone-remote-exec): add missing &&
Date: Sat, 25 Sep 2010 13:07:00 -0600
Message-ID: <1285441627-28233-10-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4t-0005Xq-8P
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab0IYTFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41285 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab0IYTFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:46 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so931665pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SkUqjuTzDoB7eZRXTJBtrVjILvCU4eCY8mVNmvjkspI=;
        b=dk2IqPYjeo/w5a77ASLo4p8WR0aAyFNt0sptpZ50mtiSKl31xyIjbhhTUbMi02Foug
         wp3HLjANjExcG6tyVXMjwK0QaT61AZeTicF7g54OAPRiYn9uvzeLnmGUaNm5UY2C7p8L
         ocrUIOL31oAWJMs43oe2K0q4sIZOfFrCStbt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZT9KESeqh14ITR/92+xPDBET69wJYtnv/g+uYbPiydoVfc8IsgZvLOaFw5LufLpspt
         pnlDZF4hzxOwlUSeAVsrXb2OhM0XBKnW0XxVAJ91WFOSCFWpQIFBywMrevPr+PutR8xH
         Y0T5422VwPlroWM/ERtFb69/183P+lxcXZoho=
Received: by 10.114.160.2 with SMTP id i2mr5659019wae.110.1285441545921;
        Sat, 25 Sep 2010 12:05:45 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157182>

Also add a couple test_must_fail invocations where needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5602-clone-remote-exec.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index deffdae..6aa6e0d 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -5,21 +5,21 @@ test_description=clone
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo "#!/bin/sh" > not_ssh
-	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
-	echo "exit 1" >> not_ssh
+	echo "#!/bin/sh" > not_ssh &&
+	echo "echo \"\$*\" > not_ssh_output" >> not_ssh &&
+	echo "exit 1" >> not_ssh &&
 	chmod +x not_ssh
 '
 
 test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
-	GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk
-	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=./not_ssh test_must_fail git clone localhost:/path/to/repo junk &&
+	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
-	GIT_SSH=./not_ssh git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk
-	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=./not_ssh test_must_fail git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk &&
+	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
-- 
1.7.3.95.g14291
