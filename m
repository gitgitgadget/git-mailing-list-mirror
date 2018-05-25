Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80201F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030291AbeEYVBi (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:01:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50278 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:01:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so17572027wmt.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFV20DWQV48ihI09Vk1C1DeeZqvPkGIE7UevArkFaDg=;
        b=FzZD8q/ih1SF8I8Ej+3rBK4aR9Z6OrRfkMQNrgLzMUsZVO49pP1oO/PICsfyqd1Ci6
         UxapDOxCPveuSfMg2KhzDigHMjFIscrGrXPVIOuHYwB8Y0tbfLcZtH47AbneZXqua1OP
         1ZI8+aNIM2FSW/SvCPaYnTDdzLQd2/wH4gfWQV3527iY6XBiJ7AuAu0YB7ubQouVFD1P
         EaBWhd6xMzjyqBYRYc3CPERD52+Nyl0N/qGCgmwcurGfs5QhUGMEAn7VPyblBu6udUPN
         CuGOvGWhippv5Yn2/8RgkG/O4YJnoi1PKiz8Zoy5X7xryJr/ET0OiCIonUW5fQ9oR9OU
         CGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFV20DWQV48ihI09Vk1C1DeeZqvPkGIE7UevArkFaDg=;
        b=tB94Wui4LjK09o0t8d++uh985lFAZ1Nweiklky7hMrBYsd1hP/ZtdPgvG/Pag+ITou
         /8J6vnwGuTuCpAuyC6fdhV66TMcqxPabeK9b4hFkUTtQtyTxhb4a4yUDdeHoqKqj20ra
         Ix94WXOQPv3p2gJ/2M7PxoI0jmmpOfowAm/iKZDmWp0p46k44QhrBWoGnkdOnVQSHrO1
         R1J24ZFdAob6jW02RXXnScZqeQl9RwQhP18Micvpn+ysZ7qMG9bUOUN/LBr13rKggtum
         qUGTtUkf49FooAtqAdrvsoN+0iv6cpj4F7WNHOkWu0zKp5MVL1WNaGHvfWn8HG2WWIDM
         6/bg==
X-Gm-Message-State: ALKqPweTJVdi5PfuNnnGHJ502uXfMLZzgojY1gBwNI4ja0KwXpN9ltLr
        R9owLN4Y/VaD/dL10Jj2m8+GS3kD
X-Google-Smtp-Source: ADUXVKJnjCaSXWli8lUbpKIOmbWC/ddA/OscnY2k3uPUr513PeBw7Q9ILVplzIQlwjTLLpGIL8M9Nw==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195-v6mr2675378wmb.63.1527282095840;
        Fri, 25 May 2018 14:01:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q9-v6sm2520105wmq.45.2018.05.25.14.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 May 2018 14:01:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just the first
Date:   Fri, 25 May 2018 23:00:54 +0200
Message-Id: <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b05
In-Reply-To: <cover.1527279322.git.martin.agren@gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `vreportf()` to prefix all lines with the given prefix, not only
the first line. This matches how "hint: " is being shown, and affects
"error: ", "fatal: ", "usage: ", "warning: " and "BUG: " (as well as any
out-of-tree and future users).

Note that we need to adjust quite a few tests as a result of this
change. All of these changes are because we obviously need to prefix
more lines in various "expect"-files -- except for one instance of a
trailing empty line that disappears with this commit (see t7609). This
is a very minor change, and arguably a good one.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Looking back at this, I wonder if the opposite approach would be better,
that is, making `advise()` use `vreportf()` after teaching the latter
the multi-line trick.

 t/t1011-read-tree-sparse-checkout.sh |  6 ++---
 t/t1506-rev-parse-diagnosis.sh       |  2 +-
 t/t1600-index.sh                     |  6 ++---
 t/t3600-rm.sh                        | 36 ++++++++++++-------------
 t/t5512-ls-remote.sh                 |  6 ++---
 t/t7607-merge-overwrite.sh           |  6 ++---
 t/t7609-merge-co-error-msgs.sh       | 39 ++++++++++++++--------------
 usage.c                              |  2 +-
 8 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 0c6f48f302..31b0702e6c 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -243,9 +243,9 @@ test_expect_success 'print errors when failed to update worktree' '
 	test_must_fail git checkout top 2>actual &&
 	cat >expected <<\EOF &&
 error: The following untracked working tree files would be overwritten by checkout:
-	sub/added
-	sub/addedtoo
-Please move or remove them before you switch branches.
+error: 	sub/added
+error: 	sub/addedtoo
+error: Please move or remove them before you switch branches.
 Aborting
 EOF
 	test_i18ncmp expected actual
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 4ee009da66..80d35087b7 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -11,7 +11,7 @@ test_did_you_mean ()
 	sq="'" &&
 	cat >expected <<-EOF &&
 	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
-	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
+	fatal: Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
 	EOF
 	test_cmp expected error
 }
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index c4422312f4..39a707c94a 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -16,7 +16,7 @@ test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
 		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
-			Using version Z
+			warning: Using version Z
 		EOF
 		test_i18ncmp expect.err actual.err
 	)
@@ -30,7 +30,7 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
-			Using version Z
+			warning: Using version Z
 		EOF
 		test_i18ncmp expect.err actual.err
 	)
@@ -54,7 +54,7 @@ test_expect_success 'out of bounds index.version issues warning' '
 		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: index.version set, but the value is invalid.
-			Using version Z
+			warning: Using version Z
 		EOF
 		test_i18ncmp expect.err actual.err
 	)
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b8fbdefcdc..cd4a10df2d 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -771,10 +771,10 @@ test_expect_success 'setup for testing rm messages' '
 test_expect_success 'rm files with different staged content' '
 	cat >expect <<-\EOF &&
 	error: the following files have staged content different from both the
-	file and the HEAD:
-	    bar.txt
-	    foo.txt
-	(use -f to force removal)
+	error: file and the HEAD:
+	error:     bar.txt
+	error:     foo.txt
+	error: (use -f to force removal)
 	EOF
 	echo content1 >foo.txt &&
 	echo content1 >bar.txt &&
@@ -785,9 +785,9 @@ test_expect_success 'rm files with different staged content' '
 test_expect_success 'rm files with different staged content without hints' '
 	cat >expect <<-\EOF &&
 	error: the following files have staged content different from both the
-	file and the HEAD:
-	    bar.txt
-	    foo.txt
+	error: file and the HEAD:
+	error:     bar.txt
+	error:     foo.txt
 	EOF
 	echo content2 >foo.txt &&
 	echo content2 >bar.txt &&
@@ -798,8 +798,8 @@ test_expect_success 'rm files with different staged content without hints' '
 test_expect_success 'rm file with local modification' '
 	cat >expect <<-\EOF &&
 	error: the following file has local modifications:
-	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	error:     foo.txt
+	error: (use --cached to keep the file, or -f to force removal)
 	EOF
 	git commit -m "testing rm 3" &&
 	echo content3 >foo.txt &&
@@ -810,7 +810,7 @@ test_expect_success 'rm file with local modification' '
 test_expect_success 'rm file with local modification without hints' '
 	cat >expect <<-\EOF &&
 	error: the following file has local modifications:
-	    bar.txt
+	error:     bar.txt
 	EOF
 	echo content4 >bar.txt &&
 	test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
@@ -820,8 +820,8 @@ test_expect_success 'rm file with local modification without hints' '
 test_expect_success 'rm file with changes in the index' '
 	cat >expect <<-\EOF &&
 	error: the following file has changes staged in the index:
-	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	error:     foo.txt
+	error: (use --cached to keep the file, or -f to force removal)
 	EOF
 	git reset --hard &&
 	echo content5 >foo.txt &&
@@ -833,7 +833,7 @@ test_expect_success 'rm file with changes in the index' '
 test_expect_success 'rm file with changes in the index without hints' '
 	cat >expect <<-\EOF &&
 	error: the following file has changes staged in the index:
-	    foo.txt
+	error:     foo.txt
 	EOF
 	test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
 	test_i18ncmp expect actual
@@ -842,12 +842,12 @@ test_expect_success 'rm file with changes in the index without hints' '
 test_expect_success 'rm files with two different errors' '
 	cat >expect <<-\EOF &&
 	error: the following file has staged content different from both the
-	file and the HEAD:
-	    foo1.txt
-	(use -f to force removal)
+	error: file and the HEAD:
+	error:     foo1.txt
+	error: (use -f to force removal)
 	error: the following file has changes staged in the index:
-	    bar1.txt
-	(use --cached to keep the file, or -f to force removal)
+	error:     bar1.txt
+	error: (use --cached to keep the file, or -f to force removal)
 	EOF
 	echo content >foo1.txt &&
 	git add foo1.txt &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6a949484d0..7e505163f6 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -131,9 +131,9 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	cat >exp <<-EOF &&
 	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
 	fatal: Could not read from remote repository.
-
-	Please make sure you have the correct access rights
-	and the repository exists.
+	fatal: 
+	fatal: Please make sure you have the correct access rights
+	fatal: and the repository exists.
 	EOF
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote needs
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index dd8ab7ede1..985fbab0b0 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -116,9 +116,9 @@ test_expect_success 'will not overwrite untracked subtree' '
 
 cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
-	sub
-	sub2
-Please move or remove them before you merge.
+error: 	sub
+error: 	sub2
+error: Please move or remove them before you merge.
 Aborting
 EOF
 
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index e90413204e..54bc3d2c9c 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -27,11 +27,11 @@ test_expect_success 'setup' '
 
 cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
-	five
-	four
-	three
-	two
-Please move or remove them before you merge.
+error: 	five
+error: 	four
+error: 	three
+error: 	two
+error: Please move or remove them before you merge.
 Aborting
 EOF
 
@@ -50,13 +50,13 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by merge:
-	four
-	three
-	two
-Please commit your changes or stash them before you merge.
+error: 	four
+error: 	three
+error: 	two
+error: Please commit your changes or stash them before you merge.
 error: The following untracked working tree files would be overwritten by merge:
-	five
-Please move or remove them before you merge.
+error: 	five
+error: Please move or remove them before you merge.
 Aborting
 EOF
 
@@ -70,9 +70,9 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/one
-	rep/two
-Please commit your changes or stash them before you switch branches.
+error: 	rep/one
+error: 	rep/two
+error: Please commit your changes or stash them before you switch branches.
 Aborting
 EOF
 
@@ -92,9 +92,9 @@ test_expect_success 'cannot switch branches because of local changes' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/one
-	rep/two
-Please commit your changes or stash them before you switch branches.
+error: 	rep/one
+error: 	rep/two
+error: Please commit your changes or stash them before you switch branches.
 Aborting
 EOF
 
@@ -106,9 +106,8 @@ test_expect_success 'not uptodate file porcelain checkout error' '
 
 cat >expect <<\EOF
 error: Updating the following directories would lose untracked files in them:
-	rep
-	rep2
-
+error: 	rep
+error: 	rep2
 Aborting
 EOF
 
diff --git a/usage.c b/usage.c
index 80f9c1d14b..6a5669922f 100644
--- a/usage.c
+++ b/usage.c
@@ -34,7 +34,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	prefix_suffix_lines(stderr, prefix, msg, "");
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
2.17.0.1181.g093e983b05

