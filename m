Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743B171AD
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384138; cv=none; b=VHnsURPTzZoQnPJqkQMe7f2Y4QQriJLKjtUorq4+3itoUa+s79CmshZEivmaBJ5tqRpPJ35bxMNTz3g/mhOwE9+Mz+to8ixAPEkqF6Kg+uT3sofcnLxqRXcaWH/zGpCIN5s/mwfj4P7q1npf9dw45qwj85pHvdPDRvGDY+1NXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384138; c=relaxed/simple;
	bh=SYVgW8BTLVNeSfgb0/GiPF28HGaeSbNPnAOvV95wo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiPupSIHQXFW47R36Ck81jWX8XVsGvmKqN+b2PihPRDES+q/VdoklMWrRKzvI4olVaDUM4M0UkBPYFAxrAhXZx/4acPuxNWKiIjnOiMY7gWdIWhtsnzycfiua7gkIUkP2F7iV3tcPzFC/+4X3pI0rX1YlMs4UqbPwwdR2OE9WKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPlDHa6d; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPlDHa6d"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c7e46f549dso1124519a91.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384136; x=1719988936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCDHDi+n5RM03f2SgHYCnUpHFSutI4dZfeCfatGoRqM=;
        b=nPlDHa6dAf7hEsqW3HpjW5hZVz7jpiW973fwLVxrhG1GinFAqeas8XZ46LQj0QwjKY
         94oXRwvIbBxKSBWI7x+UBJ7gxDoEGd9a5zfD8THagluQnkqs7kukvnpDefyDW5NpItaP
         7TWaYWPYJFPJ+UQLc5lXWtKtp9ySWPPYnlA/Djli73boLgF+9tSv9u3HrvpvR97mIYsu
         L8+1AKPmROzQxtLKwerVr8f7/vjUjSmNQkk49U9iS/7yK5ooUviiYZY2V5Un6MAjKt5s
         PQmSGFWfzW6DBVm6MBcI1ep8OX3HFgn4fBgGe298gfPYRlXPnRlX+tZm4HfWH/iptCWg
         sPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384136; x=1719988936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCDHDi+n5RM03f2SgHYCnUpHFSutI4dZfeCfatGoRqM=;
        b=adf2GbrFmFsgQX49Cui2PASjWDqhpL7MXl1fZY6crqI+BNYj7X8jEantKwKpumXc3b
         L5xhIiadSG9Y1GtM6hdFfNPUaxzuUHe8cdCD1tSjkCHdcBz0rZWTiUBzAU2gRVEDPgga
         TwUEuvlhSXYYnyDl2GQcFYN/7hVhChtMAIxGV7O5Km0E5QIrimHxcYy0+9uonqaSYHCr
         iyOMJjJD7YWAhTQuwAQ+KWtnrRC1IJ52kfrwsa1VIXJ9qjQPR6Y/Zflxrg63ZoXUgJtY
         m7cPpsGBSvUo2RnbtKkooBWi4MiX0PSVZwiHCBdQbTfPNsd+zB/JElXApU3Rk7EBKsQR
         5Duw==
X-Gm-Message-State: AOJu0YyUgAbgccffaE7/+szylMOm7T6QodyO39gA3f+crN+iX7+nKHA1
	51YkUTiPBdINPVK8iDXcR3JTF9QW951tI6qxBcLUspGf3ZUXOxfqgXrJve3QGpM=
X-Google-Smtp-Source: AGHT+IHmuROzCtWK8RGk+naSUyqLgOeSBrSgzVtpyWz9X8PeO7GeZwX2qBstPGHzZHI7dzdv3fik2Q==
X-Received: by 2002:a05:6a21:9cca:b0:1b6:fadd:886e with SMTP id adf61e73a8af0-1bce93519demr13853399637.2.1719384135509;
        Tue, 25 Jun 2024 23:42:15 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:205a:5198:5a00:e7e1:cbf1:679])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f2a06sm92106595ad.31.2024.06.25.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:42:15 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4] describe: refresh the index when 'broken' flag is used
Date: Wed, 26 Jun 2024 12:07:57 +0530
Message-ID: <20240626064143.18945-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
In-Reply-To: <xmqq34p1813n.fsf@gitster.g>
References: <xmqq34p1813n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c                            |  11 ++
 t/t6120-describe.sh                           |  24 +++
 ...esh-the-index-when-broken-flag-is-us.patch | 178 ++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 v3-0001-describe-refresh-the-index-when-broken-flag-is-us.patch

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..7cb9d50b36 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			strvec_pushv(&cp.args, update_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+			if (run_command(&cp))
+				child_process_clear(&cp);
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..6c396e7abc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty --broken >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/v3-0001-describe-refresh-the-index-when-broken-flag-is-us.patch b/v3-0001-describe-refresh-the-index-when-broken-flag-is-us.patch
new file mode 100644
index 0000000000..22e295d5eb
--- /dev/null
+++ b/v3-0001-describe-refresh-the-index-when-broken-flag-is-us.patch
@@ -0,0 +1,178 @@
+From 1da5fa48d913e1cefb2b6e1bc58df565076ee438 Mon Sep 17 00:00:00 2001
+From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
+Date: Mon, 24 Jun 2024 02:57:59 +0530
+Subject: [PATCH v3] describe: refresh the index when 'broken' flag is used
+To: git@vger.kernel.org
+
+When describe is run with 'dirty' flag, we refresh the index
+to make sure it is in sync with the filesystem before
+determining if the working tree is dirty.  However, this is
+not done for the codepath where the 'broken' flag is used.
+
+This causes `git describe --broken --dirty` to false
+positively report the worktree being dirty if a file has
+different stat info than what is recorded in the index.
+Running `git update-index -q --refresh` to refresh the index
+before running diff-index fixes the problem.
+
+Also add tests to deliberately update stat info of a
+file before running describe to verify it behaves correctly.
+
+Reported-by: Paul Millar <paul.millar@desy.de>
+Suggested-by: Junio C Hamano <gitster@pobox.com>
+Helped-by: Junio C Hamano <gitster@pobox.com>
+Helped-by: Phillip Wood <phillip.wood123@gmail.com>
+Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
+---
+ builtin/describe.c  | 11 +++++++++++
+ t/t6120-describe.sh | 24 ++++++++++++++++++++++++
+ 2 files changed, 35 insertions(+)
+
+diff --git a/builtin/describe.c b/builtin/describe.c
+index e5287eddf2..deec19b29a 100644
+--- a/builtin/describe.c
++++ b/builtin/describe.c
+@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
+ 	"diff-index", "--quiet", "HEAD", "--", NULL
+ };
+ 
++static const char *update_index_args[] = {
++	"update-index", "--unmerged", "-q", "--refresh", NULL
++};
++
+ struct commit_name {
+ 	struct hashmap_entry entry;
+ 	struct object_id peeled;
+@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
+ 	if (argc == 0) {
+ 		if (broken) {
+ 			struct child_process cp = CHILD_PROCESS_INIT;
++			strvec_pushv(&cp.args, update_index_args);
++			cp.git_cmd = 1;
++			cp.no_stdin = 1;
++			cp.no_stdout = 1;
++			run_command(&cp);
++			strvec_clear(&cp.args);
++
+ 			strvec_pushv(&cp.args, diff_index_args);
+ 			cp.git_cmd = 1;
+ 			cp.no_stdin = 1;
+diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
+index e78315d23d..6c396e7abc 100755
+--- a/t/t6120-describe.sh
++++ b/t/t6120-describe.sh
+@@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
+ 
+ check_describe newer-tag-older-commit~1 --contains unique-file~2
+ 
++test_expect_success 'describe --dirty with a file with changed stat' '
++	git init stat-dirty &&
++	(
++		cd stat-dirty &&
++
++		echo A >file &&
++		git add file &&
++		git commit -m A &&
++		git tag A -a -m A &&
++
++		cat file >file.new &&
++		mv file.new file &&
++		git describe --dirty >actual &&
++		echo "A" >expected &&
++		test_cmp expected actual &&
++
++		cat file >file.new &&
++		mv file.new file &&
++		git describe --dirty --broken >actual &&
++		echo "A" >expected &&
++		test_cmp expected actual
++	)
++'
++
+ test_done
+
+Range-diff against v2:
+1:  d60fc0fa02 ! 1:  1da5fa48d9 describe: refresh the index when 'broken' flag is used
+    @@ Commit message
+         Reported-by: Paul Millar <paul.millar@desy.de>
+         Suggested-by: Junio C Hamano <gitster@pobox.com>
+         Helped-by: Junio C Hamano <gitster@pobox.com>
+    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
+         Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
+     
+      ## builtin/describe.c ##
+    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
+      	if (argc == 0) {
+      		if (broken) {
+      			struct child_process cp = CHILD_PROCESS_INIT;
+    -+			struct child_process update_index_cp = CHILD_PROCESS_INIT;
+    -+
+    -+			strvec_pushv(&update_index_cp.args, update_index_args);
+    -+			update_index_cp.git_cmd = 1;
+    -+			update_index_cp.no_stdin = 1;
+    -+			update_index_cp.no_stdout = 1;
+    -+			run_command(&update_index_cp);
+    ++			strvec_pushv(&cp.args, update_index_args);
+    ++			cp.git_cmd = 1;
+    ++			cp.no_stdin = 1;
+    ++			cp.no_stdout = 1;
+    ++			run_command(&cp);
+    ++			strvec_clear(&cp.args);
+     +
+      			strvec_pushv(&cp.args, diff_index_args);
+      			cp.git_cmd = 1;
+    @@ t/t6120-describe.sh: test_expect_success 'setup misleading taggerdates' '
+      
+     +test_expect_success 'describe --dirty with a file with changed stat' '
+     +	git init stat-dirty &&
+    -+	cd stat-dirty &&
+    -+
+    -+	echo A >file &&
+    -+	git add file &&
+    -+	git commit -m A &&
+    -+	git tag A -a -m A &&
+    -+
+    -+	cat file >file.new &&
+    -+	mv file.new file &&
+    -+	git describe --dirty >actual &&
+    -+	echo "A" >expected &&
+    -+	test_cmp expected actual
+    -+'
+    ++	(
+    ++		cd stat-dirty &&
+     +
+    -+test_expect_success 'describe --dirty --broken with a file with changed stat' '
+    -+	git init stat-dirty-broken &&
+    -+	cd stat-dirty-broken &&
+    ++		echo A >file &&
+    ++		git add file &&
+    ++		git commit -m A &&
+    ++		git tag A -a -m A &&
+     +
+    -+	echo A >file &&
+    -+	git add file &&
+    -+	git commit -m A &&
+    -+	git tag A -a -m A &&
+    ++		cat file >file.new &&
+    ++		mv file.new file &&
+    ++		git describe --dirty >actual &&
+    ++		echo "A" >expected &&
+    ++		test_cmp expected actual &&
+     +
+    -+	cat file >file.new &&
+    -+	mv file.new file &&
+    -+	git describe --dirty --broken >actual &&
+    -+	echo "A" >expected &&
+    -+	test_cmp expected actual
+    ++		cat file >file.new &&
+    ++		mv file.new file &&
+    ++		git describe --dirty --broken >actual &&
+    ++		echo "A" >expected &&
+    ++		test_cmp expected actual
+    ++	)
+     +'
+     +
+      test_done
+-- 
+2.45.2.606.g9005149a4a.dirty
+

Range-diff against v3:
1:  1da5fa48d9 ! 1:  9ff85435b1 describe: refresh the index when 'broken' flag is used
    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
     +			cp.git_cmd = 1;
     +			cp.no_stdin = 1;
     +			cp.no_stdout = 1;
    -+			run_command(&cp);
    -+			strvec_clear(&cp.args);
    ++			if (run_command(&cp))
    ++				child_process_clear(&cp);
     +
      			strvec_pushv(&cp.args, diff_index_args);
      			cp.git_cmd = 1;
    @@ t/t6120-describe.sh: test_expect_success 'setup misleading taggerdates' '
     +'
     +
      test_done
    +
    + ## v3-0001-describe-refresh-the-index-when-broken-flag-is-us.patch (new) ##
    +@@
    ++From 1da5fa48d913e1cefb2b6e1bc58df565076ee438 Mon Sep 17 00:00:00 2001
    ++From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
    ++Date: Mon, 24 Jun 2024 02:57:59 +0530
    ++Subject: [PATCH v3] describe: refresh the index when 'broken' flag is used
    ++To: git@vger.kernel.org
    ++
    ++When describe is run with 'dirty' flag, we refresh the index
    ++to make sure it is in sync with the filesystem before
    ++determining if the working tree is dirty.  However, this is
    ++not done for the codepath where the 'broken' flag is used.
    ++
    ++This causes `git describe --broken --dirty` to false
    ++positively report the worktree being dirty if a file has
    ++different stat info than what is recorded in the index.
    ++Running `git update-index -q --refresh` to refresh the index
    ++before running diff-index fixes the problem.
    ++
    ++Also add tests to deliberately update stat info of a
    ++file before running describe to verify it behaves correctly.
    ++
    ++Reported-by: Paul Millar <paul.millar@desy.de>
    ++Suggested-by: Junio C Hamano <gitster@pobox.com>
    ++Helped-by: Junio C Hamano <gitster@pobox.com>
    ++Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    ++Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
    ++---
    ++ builtin/describe.c  | 11 +++++++++++
    ++ t/t6120-describe.sh | 24 ++++++++++++++++++++++++
    ++ 2 files changed, 35 insertions(+)
    ++
    ++diff --git a/builtin/describe.c b/builtin/describe.c
    ++index e5287eddf2..deec19b29a 100644
    ++--- a/builtin/describe.c
    +++++ b/builtin/describe.c
    ++@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
    ++ 	"diff-index", "--quiet", "HEAD", "--", NULL
    ++ };
    ++ 
    +++static const char *update_index_args[] = {
    +++	"update-index", "--unmerged", "-q", "--refresh", NULL
    +++};
    +++
    ++ struct commit_name {
    ++ 	struct hashmap_entry entry;
    ++ 	struct object_id peeled;
    ++@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
    ++ 	if (argc == 0) {
    ++ 		if (broken) {
    ++ 			struct child_process cp = CHILD_PROCESS_INIT;
    +++			strvec_pushv(&cp.args, update_index_args);
    +++			cp.git_cmd = 1;
    +++			cp.no_stdin = 1;
    +++			cp.no_stdout = 1;
    +++			run_command(&cp);
    +++			strvec_clear(&cp.args);
    +++
    ++ 			strvec_pushv(&cp.args, diff_index_args);
    ++ 			cp.git_cmd = 1;
    ++ 			cp.no_stdin = 1;
    ++diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
    ++index e78315d23d..6c396e7abc 100755
    ++--- a/t/t6120-describe.sh
    +++++ b/t/t6120-describe.sh
    ++@@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
    ++ 
    ++ check_describe newer-tag-older-commit~1 --contains unique-file~2
    ++ 
    +++test_expect_success 'describe --dirty with a file with changed stat' '
    +++	git init stat-dirty &&
    +++	(
    +++		cd stat-dirty &&
    +++
    +++		echo A >file &&
    +++		git add file &&
    +++		git commit -m A &&
    +++		git tag A -a -m A &&
    +++
    +++		cat file >file.new &&
    +++		mv file.new file &&
    +++		git describe --dirty >actual &&
    +++		echo "A" >expected &&
    +++		test_cmp expected actual &&
    +++
    +++		cat file >file.new &&
    +++		mv file.new file &&
    +++		git describe --dirty --broken >actual &&
    +++		echo "A" >expected &&
    +++		test_cmp expected actual
    +++	)
    +++'
    +++
    ++ test_done
    ++
    ++Range-diff against v2:
    ++1:  d60fc0fa02 ! 1:  1da5fa48d9 describe: refresh the index when 'broken' flag is used
    ++    @@ Commit message
    ++         Reported-by: Paul Millar <paul.millar@desy.de>
    ++         Suggested-by: Junio C Hamano <gitster@pobox.com>
    ++         Helped-by: Junio C Hamano <gitster@pobox.com>
    ++    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    ++         Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
    ++     
    ++      ## builtin/describe.c ##
    ++    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
    ++      	if (argc == 0) {
    ++      		if (broken) {
    ++      			struct child_process cp = CHILD_PROCESS_INIT;
    ++    -+			struct child_process update_index_cp = CHILD_PROCESS_INIT;
    ++    -+
    ++    -+			strvec_pushv(&update_index_cp.args, update_index_args);
    ++    -+			update_index_cp.git_cmd = 1;
    ++    -+			update_index_cp.no_stdin = 1;
    ++    -+			update_index_cp.no_stdout = 1;
    ++    -+			run_command(&update_index_cp);
    ++    ++			strvec_pushv(&cp.args, update_index_args);
    ++    ++			cp.git_cmd = 1;
    ++    ++			cp.no_stdin = 1;
    ++    ++			cp.no_stdout = 1;
    ++    ++			run_command(&cp);
    ++    ++			strvec_clear(&cp.args);
    ++     +
    ++      			strvec_pushv(&cp.args, diff_index_args);
    ++      			cp.git_cmd = 1;
    ++    @@ t/t6120-describe.sh: test_expect_success 'setup misleading taggerdates' '
    ++      
    ++     +test_expect_success 'describe --dirty with a file with changed stat' '
    ++     +	git init stat-dirty &&
    ++    -+	cd stat-dirty &&
    ++    -+
    ++    -+	echo A >file &&
    ++    -+	git add file &&
    ++    -+	git commit -m A &&
    ++    -+	git tag A -a -m A &&
    ++    -+
    ++    -+	cat file >file.new &&
    ++    -+	mv file.new file &&
    ++    -+	git describe --dirty >actual &&
    ++    -+	echo "A" >expected &&
    ++    -+	test_cmp expected actual
    ++    -+'
    ++    ++	(
    ++    ++		cd stat-dirty &&
    ++     +
    ++    -+test_expect_success 'describe --dirty --broken with a file with changed stat' '
    ++    -+	git init stat-dirty-broken &&
    ++    -+	cd stat-dirty-broken &&
    ++    ++		echo A >file &&
    ++    ++		git add file &&
    ++    ++		git commit -m A &&
    ++    ++		git tag A -a -m A &&
    ++     +
    ++    -+	echo A >file &&
    ++    -+	git add file &&
    ++    -+	git commit -m A &&
    ++    -+	git tag A -a -m A &&
    ++    ++		cat file >file.new &&
    ++    ++		mv file.new file &&
    ++    ++		git describe --dirty >actual &&
    ++    ++		echo "A" >expected &&
    ++    ++		test_cmp expected actual &&
    ++     +
    ++    -+	cat file >file.new &&
    ++    -+	mv file.new file &&
    ++    -+	git describe --dirty --broken >actual &&
    ++    -+	echo "A" >expected &&
    ++    -+	test_cmp expected actual
    ++    ++		cat file >file.new &&
    ++    ++		mv file.new file &&
    ++    ++		git describe --dirty --broken >actual &&
    ++    ++		echo "A" >expected &&
    ++    ++		test_cmp expected actual
    ++    ++	)
    ++     +'
    ++     +
    ++      test_done
    ++-- 
    ++2.45.2.606.g9005149a4a.dirty
    ++
-- 
2.45.2.606.g9005149a4a.dirty

