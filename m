Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F00CC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiCBNXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiCBNXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD5C26C1
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so2736581wra.12
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjRPcNPw3B+dJmRtuGj9hpzK6tbF0BlxBqrpr+4VoQg=;
        b=NZMQbRDKWOztw3cd9sdrKPQAIZBLian0mrhAM1erat1G04OcN842LnBLXjGNpXd5oH
         laqAn81tGyXODQd6LPjf3eoq7V6B+z8MsnrWQcf/B9dTvg++pJW5vS5tvUkDHVr6whLH
         PQ9H0jIoLemZSLG4UikPsFrO8zeVo+A6OizuOkIxgjkbWL1A2SOre20zAFz3bPiz1jIJ
         7zGb6dLwfwe+1QqPEPSWERDct/lB9bzycBnxSBXiqXiicIjyQvrJlFPV/ruaGYl20k/v
         ZZ6fgS6IF9rT21Mhstkz5F3nyyxz/jFjHIhqZqgBjDHS3yMnc1gR8BcP3Z+DqW2nxU0m
         0z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjRPcNPw3B+dJmRtuGj9hpzK6tbF0BlxBqrpr+4VoQg=;
        b=ac+pNUG2pT5ez4j6SYdSmZky5DLMvXyR2Bqs461bl58sM0DaeheG3NbHub6HW/BWSk
         Obk9QHYIDxEK6YL8j44JhtixecbMvSqya4kGWG+vXUYxH5/dveeSuxUKITvcIRUZ6jhl
         TDM7PbHzeHH6/OdBo1P2LpIAL9hOMklRdJpndmN2it1HA96xf0uQGOuOOVG2wEjTdwRc
         X0k9Vuza1b1MwGsCAbyRnotnp7dzWPVue3RMObnl6h7xNlvvMojYgNVXQufpDIb8FycM
         0s8BYR11uV/wRef+5UUbZir/Y7IJZme/eQP48NmPo45ndD47aWWlxN4jT+rBl5XddG5V
         dFlg==
X-Gm-Message-State: AOAM53021SNzit4QwZqHyWdgFapAFGhrVLhL/BBlLWSw35PLbtBn4RQm
        EjicBXYudz97hEMoS6C7cjruK2fTdhTRqw==
X-Google-Smtp-Source: ABdhPJyA386p0/gahUEJn3ry58fxQ/PR53WIhmQ6PmASQOCW0V2/zeMnBSvDVuYVVnVls10WrAoO1A==
X-Received: by 2002:a05:6000:124b:b0:1f0:4819:fd44 with SMTP id j11-20020a056000124b00b001f04819fd44mr738777wrx.101.1646227363254;
        Wed, 02 Mar 2022 05:22:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] tests: change "cat && chmod +x" to use "test_hook"
Date:   Wed,  2 Mar 2022 14:22:29 +0100
Message-Id: <patch-10.10-7fef92872f3-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor various test code to use the "test_hook" helper. This change:

 - Fixes the long-standing issues with those tests using "#!/bin/sh"
   instead of "#!$SHELL_PATH". Using "#!/bin/sh" here happened to work
   because this code was so simply that it e.g. worked on Solaris
   /bin/sh.

 - Removes the "mkdir .git/hooks" invocation, as explained in a
   preceding commit we'll rely on the default templates to create that
   directory for us.

For the test in "t5402-post-merge-hook.sh" it's easier and more
correct to unroll the for-loop into a test_expect_success, so let's do
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3412-rebase-root.sh       | 12 +++---------
 t/t3413-rebase-hook.sh       | 12 +++---------
 t/t5401-update-hooks.sh      | 16 ++++------------
 t/t5402-post-merge-hook.sh   | 16 +++++++++-------
 t/t5407-post-rewrite-hook.sh |  4 +---
 t/t5516-fetch-push.sh        | 19 ++++---------------
 t/t5541-http-push-smart.sh   |  4 +---
 t/t5601-clone.sh             |  4 +---
 8 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 239a9343d34..58371d8a547 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -31,12 +31,9 @@ test_expect_success 'rebase --root fails with too many args' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 cat > expect <<EOF
 4
@@ -141,12 +138,9 @@ commit work7~5
 EOF
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
+	test_hook --setup --clobber pre-rebase <<-\EOF
 	false
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook stops rebase' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index bb241b26b2e..9fab0d779bb 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -41,12 +41,9 @@ test_expect_success 'rebase -i' '
 '
 
 test_expect_success 'setup pre-rebase hook' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
+	test_hook --setup pre-rebase <<-\EOF
+	echo "$1,$2" >.git/PRE-REBASE-INPUT
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook gets correct input (1)' '
@@ -102,12 +99,9 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 '
 
 test_expect_success 'setup pre-rebase hook that fails' '
-	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-rebase <<-EOF &&
-	#!$SHELL_PATH
+	test_hook --setup --clobber pre-rebase <<-\EOF
 	false
 	EOF
-	chmod +x .git/hooks/pre-rebase
 '
 
 test_expect_success 'pre-rebase hook stops rebase (1)' '
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 6392f71795d..d5771b96114 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -22,42 +22,34 @@ test_expect_success setup '
 	git update-ref refs/heads/main $commit1 &&
 	git update-ref refs/heads/tofail $commit0 &&
 
-	cat >victim.git/hooks/pre-receive <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git pre-receive <<-\EOF &&
 	printf %s "$@" >>$GIT_DIR/pre-receive.args
 	cat - >$GIT_DIR/pre-receive.stdin
 	echo STDOUT pre-receive
 	echo STDERR pre-receive >&2
 	EOF
-	chmod u+x victim.git/hooks/pre-receive &&
 
-	cat >victim.git/hooks/update <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git update <<-\EOF &&
 	echo "$@" >>$GIT_DIR/update.args
 	read x; printf %s "$x" >$GIT_DIR/update.stdin
 	echo STDOUT update $1
 	echo STDERR update $1 >&2
 	test "$1" = refs/heads/main || exit
 	EOF
-	chmod u+x victim.git/hooks/update &&
 
-	cat >victim.git/hooks/post-receive <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git post-receive <<-\EOF &&
 	printf %s "$@" >>$GIT_DIR/post-receive.args
 	cat - >$GIT_DIR/post-receive.stdin
 	echo STDOUT post-receive
 	echo STDERR post-receive >&2
 	EOF
-	chmod u+x victim.git/hooks/post-receive &&
 
-	cat >victim.git/hooks/post-update <<-\EOF &&
-	#!/bin/sh
+	test_hook --setup -C victim.git post-update <<-\EOF
 	echo "$@" >>$GIT_DIR/post-update.args
 	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
 	echo STDOUT post-update
 	echo STDERR post-update >&2
 	EOF
-	chmod u+x victim.git/hooks/post-update
 '
 
 test_expect_success push '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 3e5e19c7191..915af2de95e 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -25,13 +25,15 @@ test_expect_success setup '
 	GIT_DIR=clone2/.git git update-index --add a
 '
 
-for clone in 1 2; do
-	cat >clone${clone}/.git/hooks/post-merge <<'EOF'
-#!/bin/sh
-echo $@ >> $GIT_DIR/post-merge.args
-EOF
-	chmod u+x clone${clone}/.git/hooks/post-merge
-done
+test_expect_success 'setup clone hooks' '
+	test_when_finished "rm -f hook" &&
+	cat >hook <<-\EOF &&
+	echo $@ >>$GIT_DIR/post-merge.args
+	EOF
+
+	test_hook --setup -C clone1 post-merge <hook &&
+	test_hook --setup -C clone2 post-merge <hook
+'
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 64f40ff7776..5f3ff051ca2 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -19,12 +19,10 @@ test_expect_success 'setup' '
 	test_commit F foo F &&
 	git checkout main &&
 
-	cat >.git/hooks/post-rewrite <<-EOF &&
-	#!/bin/sh
+	test_hook --setup post-rewrite <<-EOF
 	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
 	cat > "$TRASH_DIRECTORY"/post-rewrite.data
 	EOF
-	chmod u+x .git/hooks/post-rewrite
 '
 
 clear_hook_input () {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b689baf01a9..4dfb080433e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -55,35 +55,24 @@ mk_test () {
 mk_test_with_hooks() {
 	repo_name=$1
 	mk_test "$@" &&
-
-	cat >"$repo_name"/.git/hooks/pre-receive <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" pre-receive <<-'EOF' &&
 	cat - >>pre-receive.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/update <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" update <<-'EOF' &&
 	printf "%s %s %s\n" "$@" >>update.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/post-receive <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" post-receive <<-'EOF' &&
 	cat - >>post-receive.actual
 	EOF
 
-	cat >"$repo_name"/.git/hooks/post-update <<-'EOF' &&
-	#!/bin/sh
+	test_hook -C "$repo_name" post-update <<-'EOF'
 	for ref in "$@"
 	do
 		printf "%s\n" "$ref" >>post-update.actual
 	done
 	EOF
-
-	chmod +x \
-	      "$repo_name"/.git/hooks/pre-receive \
-	      "$repo_name"/.git/hooks/update \
-	      "$repo_name"/.git/hooks/post-receive \
-	      "$repo_name"/.git/hooks/post-update
 }
 
 mk_child() {
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 0043b718f08..ab4b5cfcd11 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -97,11 +97,9 @@ test_expect_success 'create and delete remote branch' '
 '
 
 test_expect_success 'setup rejected update hook' '
-	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
-	#!/bin/sh
+	test_hook --setup -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<-\EOF &&
 	exit 1
 	EOF
-	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
 
 	cat >exp <<-EOF
 	remote: error: hook declined to update refs/heads/dev2
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a7..4a61f2c901e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -79,12 +79,10 @@ test_expect_success 'clone from hooks' '
 	cd .. &&
 	git init r1 &&
 	cd r1 &&
-	cat >.git/hooks/pre-commit <<-\EOF &&
-	#!/bin/sh
+	test_hook pre-commit <<-\EOF &&
 	git clone ../r0 ../r2
 	exit 1
 	EOF
-	chmod u+x .git/hooks/pre-commit &&
 	: >file &&
 	git add file &&
 	test_must_fail git commit -m invoke-hook &&
-- 
2.35.1.1228.g56895c6ee86

