From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/37] t6020: Modernize style a bit
Date: Mon, 20 Sep 2010 02:28:42 -0600
Message-ID: <1284971350-30590-10-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjR-0005rH-62
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab0ITI1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab0ITI1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:50 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bQqYJs+PSR9q5FETVy1ypidGjei/IEF90lKt9UMvitk=;
        b=SXL2w9CEIu2wGDu5Yoh2WbRCt7a/jxK5Se/tFH5yicVrDU90XE/AW2oRzl4/LUcmEa
         Sn47UJlJjztCvs/7aiRFTyMTarch1ddE57ctuYGi3q5JKlovwbGHMn/D+4ekRBlW6Rnv
         M+AswQDZhu/15UOS5At1jJtr9/m7A0vb4V0g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YQFuM3EZjll2aEcpxOlqAE7WC6/7pIm7XCF0EI8aOKnfcvYAPC7bLzo5ZY8O/Eytus
         blDgm3SqRkocN2bewgNGLCL9Qhi4yZe/tjf1GiSEe0asDgoNgbJGsm9my1m+OHnSAKbD
         cY9x62X0bEEXMeaXDBjm0hnzl8PeOJ+QQZecg=
Received: by 10.142.192.20 with SMTP id p20mr7341675wff.304.1284971269910;
        Mon, 20 Sep 2010 01:27:49 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156564>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6020-merge-df.sh |   35 ++++++++++++++++++++---------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 490d397..8662207 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -6,21 +6,26 @@
 test_description='Test merge with directory/file conflicts'
 . ./test-lib.sh
 
-test_expect_success 'prepare repository' \
-'echo "Hello" > init &&
-git add init &&
-git commit -m "Initial commit" &&
-git branch B &&
-mkdir dir &&
-echo "foo" > dir/foo &&
-git add dir/foo &&
-git commit -m "File: dir/foo" &&
-git checkout B &&
-echo "file dir" > dir &&
-git add dir &&
-git commit -m "File: dir"'
-
-test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
+test_expect_success 'prepare repository' '
+	echo Hello >init &&
+	git add init &&
+	git commit -m initial &&
+
+	git branch B &&
+	mkdir dir &&
+	echo foo >dir/foo &&
+	git add dir/foo &&
+	git commit -m "File: dir/foo" &&
+
+	git checkout B &&
+	echo file dir >dir &&
+	git add dir &&
+	git commit -m "File: dir"
+'
+
+test_expect_success 'Merge with d/f conflicts' '
+	test_must_fail git merge master
+'
 
 test_expect_success 'F/D conflict' '
 	git reset --hard &&
-- 
1.7.3.271.g16009
