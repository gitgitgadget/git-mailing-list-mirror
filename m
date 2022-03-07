Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED469C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbiCGMo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiCGMot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B05366A0
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so6361476wmq.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qdeChzGpyWMwbTY0EH/PTtRI/Bof3JH011XNy5cZ6o=;
        b=mE9FrZrD3chCwo6oTCZz4VE21EfXNKwF96ObZa/GcC+3Vnvfwt1bUtCouPcuhK2Lsv
         ZoIy9OQeV02auWPPQEzXZW7/lY3znK5fWrqNYC9SXxMoVAzpDkOcs38G7VMKtb9IzyHA
         zgVq1uFBqmpHkcrX3DLtvLR7QE6wzqCx77M8KseAJcwq1Too8xaiWiJ7aXJ+p13M0nwk
         vBALiQPZG4DHFYgJcjmQ3urt8xAP+fOHtitmDSbmdVU5x7EvKwbzgyL5EAM2sk0xE3zg
         az79x8bNvnxEVlMEezqRhP8XXWGysNSWZP/xPmtl+xbtCDfT922NES+vy5xMyJ7SjKu0
         PCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qdeChzGpyWMwbTY0EH/PTtRI/Bof3JH011XNy5cZ6o=;
        b=JDdi/rTBF6rwUoKgb3pJqufy3gJ9hw9cFQDrSTh/Vom585fe2ZXdfAOxji88zCiZkU
         qU+nXE50YebK7JQexgx/o+wBOmZreTercgFxpWDZsOlZFniUAeb2biBbflA0Dk/S8fD3
         Kw8WnAAwP/AP22UTTAcrUOZ3WkyBClCA+ie2RDA5TzUjUEiaSUmzsW74rroRKY+dXU6u
         8mNNjpw+8VRWL5/W+9inLU813NDEmEvDPZHOKxa0dpj81SGjdwoRp662jZ5P3e/QoRWU
         zpBp3+p5hunKt5q7UYpb7A5S2V4uNkVLDddC/VWBmIPA6G0S0jKQf18Vs5homR3lNMk/
         6fVg==
X-Gm-Message-State: AOAM533A5DjycP99fAlPEVJ/7CCVBKQaQmMlij4z4BbwgwJrYPwVQ79J
        IdJOz1HpqLYlp+98IfBaZhLBk1l8Va1Zrw==
X-Google-Smtp-Source: ABdhPJxDu3skJI7orxabzBc2wpG/s/mjKKw6K7Q9gmgPETyi2JxPwicNyBrnZp7FJ8+SQamM3xzLsQ==
X-Received: by 2002:a05:600c:3d99:b0:381:546c:8195 with SMTP id bi25-20020a05600c3d9900b00381546c8195mr18141599wmb.112.1646657032921;
        Mon, 07 Mar 2022 04:43:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] tests: indent and add hook setup to "test_expect_success"
Date:   Mon,  7 Mar 2022 13:43:36 +0100
Message-Id: <patch-v2-05.10-19db5b2d7c2-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indent various hook setup code in the test suite that's using a manual
"cat && chmod" pattern.

These should also consistently use "#!$SHELL_PATH" instead of
"#!/bin/sh", i.e. "test_script". Let's fix that in a subsequent
commit, which will be easier to review after this smaller change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 16 ++++----
 t/t3413-rebase-hook.sh       | 16 ++++----
 t/t5401-update-hooks.sh      | 76 ++++++++++++++++++------------------
 t/t5407-post-rewrite-hook.sh | 16 ++++----
 t/t5541-http-push-smart.sh   | 24 ++++++------
 5 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 1e9f7833dd6..239a9343d34 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -32,10 +32,10 @@ test_expect_success 'rebase --root fails with too many args' '
 
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 cat > expect <<EOF
@@ -142,10 +142,10 @@ EOF
 
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	false
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index b4acb3be5cf..bb241b26b2e 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -42,10 +42,10 @@ test_expect_success 'rebase -i' '
 
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-echo "\$1,\$2" >.git/PRE-REBASE-INPUT
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
@@ -103,10 +103,10 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<EOF &&
-#!$SHELL_PATH
-false
-EOF
+	cat >.git/hooks/pre-rebase <<-EOF &&
+	#!$SHELL_PATH
+	false
+	EOF
 	chmod +x .git/hooks/pre-rebase
 '
 
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6012cc8172a..6392f71795d 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -20,46 +20,46 @@ test_expect_success setup '
 	git clone --bare ./. victim.git &&
 	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/main $commit1 &&
-	git update-ref refs/heads/tofail $commit0
+	git update-ref refs/heads/tofail $commit0 &&
+
+	cat >victim.git/hooks/pre-receive <<-\EOF &&
+	#!/bin/sh
+	printf %s "$@" >>$GIT_DIR/pre-receive.args
+	cat - >$GIT_DIR/pre-receive.stdin
+	echo STDOUT pre-receive
+	echo STDERR pre-receive >&2
+	EOF
+	chmod u+x victim.git/hooks/pre-receive &&
+
+	cat >victim.git/hooks/update <<-\EOF &&
+	#!/bin/sh
+	echo "$@" >>$GIT_DIR/update.args
+	read x; printf %s "$x" >$GIT_DIR/update.stdin
+	echo STDOUT update $1
+	echo STDERR update $1 >&2
+	test "$1" = refs/heads/main || exit
+	EOF
+	chmod u+x victim.git/hooks/update &&
+
+	cat >victim.git/hooks/post-receive <<-\EOF &&
+	#!/bin/sh
+	printf %s "$@" >>$GIT_DIR/post-receive.args
+	cat - >$GIT_DIR/post-receive.stdin
+	echo STDOUT post-receive
+	echo STDERR post-receive >&2
+	EOF
+	chmod u+x victim.git/hooks/post-receive &&
+
+	cat >victim.git/hooks/post-update <<-\EOF &&
+	#!/bin/sh
+	echo "$@" >>$GIT_DIR/post-update.args
+	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
+	echo STDOUT post-update
+	echo STDERR post-update >&2
+	EOF
+	chmod u+x victim.git/hooks/post-update
 '
 
-cat >victim.git/hooks/pre-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/pre-receive.args
-cat - >$GIT_DIR/pre-receive.stdin
-echo STDOUT pre-receive
-echo STDERR pre-receive >&2
-EOF
-chmod u+x victim.git/hooks/pre-receive
-
-cat >victim.git/hooks/update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/update.args
-read x; printf %s "$x" >$GIT_DIR/update.stdin
-echo STDOUT update $1
-echo STDERR update $1 >&2
-test "$1" = refs/heads/main || exit
-EOF
-chmod u+x victim.git/hooks/update
-
-cat >victim.git/hooks/post-receive <<'EOF'
-#!/bin/sh
-printf %s "$@" >>$GIT_DIR/post-receive.args
-cat - >$GIT_DIR/post-receive.stdin
-echo STDOUT post-receive
-echo STDERR post-receive >&2
-EOF
-chmod u+x victim.git/hooks/post-receive
-
-cat >victim.git/hooks/post-update <<'EOF'
-#!/bin/sh
-echo "$@" >>$GIT_DIR/post-update.args
-read x; printf %s "$x" >$GIT_DIR/post-update.stdin
-echo STDOUT post-update
-echo STDERR post-update >&2
-EOF
-chmod u+x victim.git/hooks/post-update
-
 test_expect_success push '
 	test_must_fail git send-pack --force ./victim.git \
 		main tofail >send.out 2>send.err
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 6da8d760e28..64f40ff7776 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -17,15 +17,15 @@ test_expect_success 'setup' '
 	git checkout A^0 &&
 	test_commit E bar E &&
 	test_commit F foo F &&
-	git checkout main
-'
+	git checkout main &&
 
-cat >.git/hooks/post-rewrite <<EOF
-#!/bin/sh
-echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
-cat > "$TRASH_DIRECTORY"/post-rewrite.data
-EOF
-chmod u+x .git/hooks/post-rewrite
+	cat >.git/hooks/post-rewrite <<-EOF &&
+	#!/bin/sh
+	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
+	cat > "$TRASH_DIRECTORY"/post-rewrite.data
+	EOF
+	chmod u+x .git/hooks/post-rewrite
+'
 
 clear_hook_input () {
 	rm -f post-rewrite.args post-rewrite.data
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ca50f8b18c..0043b718f08 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -96,18 +96,20 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
-cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
-#!/bin/sh
-exit 1
-EOF
-chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
+test_expect_success 'setup rejected update hook' '
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
+	#!/bin/sh
+	exit 1
+	EOF
+	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
 
-cat >exp <<EOF
-remote: error: hook declined to update refs/heads/dev2
-To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
- ! [remote rejected] dev2 -> dev2 (hook declined)
-error: failed to push some refs to 'http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'
-EOF
+	cat >exp <<-EOF
+	remote: error: hook declined to update refs/heads/dev2
+	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
+	 ! [remote rejected] dev2 -> dev2 (hook declined)
+	error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
+	EOF
+'
 
 test_expect_success 'rejected update prints status' '
 	cd "$ROOT_PATH"/test_repo_clone &&
-- 
2.35.1.1242.gfeba0eae32b

