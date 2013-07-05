From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 3/5] t4205, t6006, t7102: make functions better readable
Date: Fri,  5 Jul 2013 16:01:48 +0400
Message-ID: <77116508da1bf88e6035cbd657c401cf96b08cbb.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4iN-0004Iy-SG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab3GEMCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:02:08 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34462 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab3GEMCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:06 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so1984497lbd.1
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Hf/lh2rgP7pLJ6u2K/0FVY4eFV+cDwXTQRAQT+JdABg=;
        b=WkkCov0QHmAoSdDQqe9KjHTaDjdqOdRP61MRR08XSwSf3fZfPDz1riHhnF7qCMfqRK
         Je9M6s71IfvFekbCsml9V5J1VS/YPS9UtgS5P0uH2XQNCBwQfWKQh5gEIkZ4pU9g3N27
         F1NkqTbEOXRFV8fudUYxfZlf9MdPtNS72XplaidEP68umSPmGE57B5kYXnQodRz7jvTp
         pdeNfGwFjYU6sOkFkQA5GNHbG/COgYnPWxhUFB2OJRsXC4bYdgq+kV5NG+Xs2ZLyRXsM
         SwNUHu0tXwFvjvehINLLHuz9LxlHRTamc/Dhyn3vBUVUE2JISp8X6y4wVHEBXvUXPPNf
         fdYA==
X-Received: by 10.112.159.169 with SMTP id xd9mr5443077lbb.43.1373025724878;
        Fri, 05 Jul 2013 05:02:04 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id y5sm2771804lae.2.2013.07.05.05.02.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:02:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com> <cover.1373024281.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229651>

Function 'test_format' has become harder to read after its
change in de6029a2 (pretty: Add failing tests: --format output
should honor logOutputEncoding, 2013-06-26). Simplify it by
moving its "should we expect it to fail?" parameter to the end.

Note, current code does not use this last parameter as far as there
are no tests expected to fail. We can keep that for future use.

Also, reformat comments

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Improved-by: Johannes Sixt <j.sixt@viscovery.net>
---
 t/t4205-log-pretty-formats.sh |  3 ++-
 t/t6006-rev-list-format.sh    | 28 ++++++++--------------------
 t/t7102-reset.sh              | 10 ++++++----
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ef9770a..2933c63 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -8,7 +8,8 @@ test_description='Test pretty formats'
 . ./test-lib.sh
 
 commit_msg () {
-	# String "initial. initial" partly in German (translated with Google Translate),
+	# String "initial. initial" partly in German
+	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
 	msg=$(printf "initial. anf\303\244nglich")
 	if test -n "$1"
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4751d22..b32405a 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -9,8 +9,9 @@ test_description='git rev-list --pretty=format test'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_tick
-# String "added" in German (translated with Google Translate), encoded in UTF-8,
-# used as a commit log message below.
+# String "added" in German
+# (translated with Google Translate),
+# encoded in UTF-8, used as a commit log message below.
 added=$(printf "added (hinzugef\303\274gt) foo")
 added_iso88591=$(echo "$added" | iconv -f utf-8 -t iso8859-1)
 # same but "changed"
@@ -35,26 +36,13 @@ test_expect_success 'setup' '
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
index 2ef96e9..535e609 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -10,14 +10,16 @@ Documented tests for git reset'
 . ./test-lib.sh
 
 commit_msg () {
-	# String "modify 2nd file (changed)" partly in German(translated with Google Translate),
+	# String "modify 2nd file (changed)" partly in German
+	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
-	msg=$(printf "modify 2nd file (ge\303\244ndert)")
+	msg="modify 2nd file (ge\303\244ndert)"
 	if test -n "$1"
 	then
-		msg=$(echo $msg | iconv -f utf-8 -t $1)
+		print "$msg" | iconv -f utf-8 -t "$1"
+	else
+		print "$msg"
 	fi
-	echo $msg
 }
 
 test_expect_success 'creating initial files and commits' '
-- 
1.8.3.2.16.gb1f0d63
