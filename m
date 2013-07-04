From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Thu,  4 Jul 2013 16:45:48 +0400
Message-ID: <aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuive-0001SI-Kx
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979Ab3GDMqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:46:16 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:59065 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964962Ab3GDMqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:46:03 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so1202674lab.13
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=+InY1Aq8+1Rb2US7/kHrKaP2ubOLzPDcVsm51Nye77g=;
        b=oluDUY9xalQvpHLtnHUcxKVVRN4ankMos4/nM75MFSm9CLqNio4SGhPuyk/AVrvPp6
         UAK3KKhslYEOIY4ZhiRetsXTuL7YsCaypTEEMiDyoQdlLIdmlOlqOLVHwivrxp0c1jg/
         lFOMZifF0CaGBlyNpwO5+b9fiY3aoBmm7BUFfmPsyVlQMtgY0Fy/BVMgL8JPXdpq+kRg
         GQPIxcDMxmGQ5Fru1KMvio2BaZFbuiWt4dpS23d2uB2lMp1aMNXDJXbnFzfRUCVuHvVS
         f1UXAuJrSt/ucLX/vwtQpdXuaVOY0RUqlEJZDOr2po2ohV4HbWIxat416UXd/MJI+yRM
         6iKw==
X-Received: by 10.152.25.195 with SMTP id e3mr2783077lag.76.1372941960206;
        Thu, 04 Jul 2013 05:46:00 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id rx1sm1236083lbb.0.2013.07.04.05.45.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:45:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229579>

Function 'test_format' is become hard to read after its change in
de6029a2d7734a93a9e27b9c4471862a47dd8123. So, make it more elegant.
Also, change 'commit_msg' function to make it more pretty.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Improved-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t4205-log-pretty-formats.sh |  5 +++--
 t/t6006-rev-list-format.sh    | 23 +++++------------------
 t/t7102-reset.sh              | 12 +++++++-----
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ef9770a..bb87f02 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -7,8 +7,9 @@
 test_description='Test pretty formats'
 . ./test-lib.sh
 
-commit_msg () {
-	# String "initial. initial" partly in German (translated with Google Translate),
+commit_msg() {
+	# String "initial. initial" partly in German
+	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
 	msg=$(printf "initial. anf\303\244nglich")
 	if test -n "$1"
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4751d22..e069263 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -35,26 +35,13 @@ test_expect_success 'setup' '
 	git config --unset i18n.commitEncoding
 '
 
-# usage: test_format [failure] name format_string <expected_output
+# usage: test_format name format_string [failure] <expected_output
 test_format () {
-	must_fail=0
-	# if parameters count is more than 2 then test must fail
-	if test $# -gt 2
-	then
-		must_fail=1
-		# remove first parameter which is flag for test failure
-		shift
-	fi
 	cat >expect.$1
-	name="format $1"
-	command="git rev-list --pretty=format:'$2' master >output.$1 &&
-		test_cmp expect.$1 output.$1"
-	if test $must_fail -eq 1
-	then
-		test_expect_failure "$name" "$command"
-	else
-		test_expect_success "$name" "$command"
-	fi
+	test_expect_${3:-success} "format $1" "
+		git rev-list --pretty=format:'$2' master >output.$1 &&
+		test_cmp expect.$1 output.$1
+	"
 }
 
 # Feed to --format to provide predictable colored sequences.
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2ef96e9..73a1bdb 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -9,15 +9,17 @@ Documented tests for git reset'
 
 . ./test-lib.sh
 
-commit_msg () {
-	# String "modify 2nd file (changed)" partly in German(translated with Google Translate),
+commit_msg() {
+	# String "modify 2nd file (changed)" partly in German
+	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
-	msg=$(printf "modify 2nd file (ge\303\244ndert)")
+	printf "modify 2nd file (ge\303\244ndert)" |
 	if test -n "$1"
 	then
-		msg=$(echo $msg | iconv -f utf-8 -t $1)
+		iconv -f utf-8 -t $1
+	else
+		cat
 	fi
-	echo $msg
 }
 
 test_expect_success 'creating initial files and commits' '
-- 
1.8.3.1.15.g5c23c1e
