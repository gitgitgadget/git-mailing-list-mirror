Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B8C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiHCQRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiHCQRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:17:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F692183D
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:17:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q30so17735513wra.11
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UmIAxU/f5YKlsSQua/3W4kBj4H3Fx0EauBL+e+khaqs=;
        b=lHN2XlWXL3O4Zh/620OZwhwGJ5cTPHgG6SqFOTPFLo7uREaznrHKqBlhz/pV9PIb9A
         CEyZpiyE0i0BxB34wYPTXh3NsVjDzMaHKnoOYcqdUemgeYUSy+HtXdkHhUjBmJ5k1WBz
         XKXPIyRx0kL+IFQCqQ1zYg75cC8YwmTzKgjrZB79EyHewIPvZuXEs9PCZCrPxGGZ/fCq
         KgeqKM7feXp3SVplfVru0kOWKk0thjKcZKhCKBKtSqb3kVXteG6ptu/Ovb2YoMHdzodg
         tbA1GCekXzZAjhNxeAeEPMIk0lYVgQRf4CbvOawC3oqM920+SgtmRiWXY/1I7oCIbc1K
         dciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UmIAxU/f5YKlsSQua/3W4kBj4H3Fx0EauBL+e+khaqs=;
        b=tHhGM4wZWZQoVrEZoOeIYdd0Ffivo8lPMzwFL2outp9OZ4t4Y41ov3qGfQqQQJf60v
         y+XT+KYd2Y4lLMcECYif2zSo/eHuCu8SkOBwUIj0ibqmiTx/x7apw778wQSXs3k2lUCs
         3bURkuOq6iRr3CrmS5T9WTUCidjpCPnO3HTm3mVN+hG5OucghEg2WkoAXlcFfclXVmi4
         oo8pEC/7cUPRrKAhm81oT86MmL9mw5D4Tk5lNXDlWjZCTUTWf2M4us1PBkOwJGqTU+Yc
         zA7W+ZHCBLOaFBW1zECmr0vz0JQ1cr0Plxry24PNOZ2u+p/ACLsnG2GpDxV4GdwuaQyH
         jdng==
X-Gm-Message-State: ACgBeo2FZpDlqeKijGEVrti4rdjTTIGucslR//akvK3a5hKCdZ77Sr4x
        m8D6CVWHuCo21ElR1wFrm65HRTxSeZo=
X-Google-Smtp-Source: AA6agR6l71jn5kUjU72mNwDroOVwyva+nQpFAc1DH5L/S5KB71eTatNZLUHdb8Uj7T7MfsmPGieNpg==
X-Received: by 2002:a05:6000:114b:b0:220:5ff2:b9dc with SMTP id d11-20020a056000114b00b002205ff2b9dcmr11285307wrx.297.1659543461413;
        Wed, 03 Aug 2022 09:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c4e0c00b003a501ad8648sm2164529wmq.40.2022.08.03.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:17:40 -0700 (PDT)
Message-Id: <88504b3a08aa354362658c2a19aa368be893e38b.1659543457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Aug 2022 16:17:36 +0000
Subject: [PATCH 2/3] t1419: add test cases for refs-advertise hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Add test cases for the new 'refs-advertise' hook which is used to
filter the references during reference discovery phase and commit
fetching phase.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 t/t1419-refs-advertise-hooks.sh               | 138 ++++++++++
 t/t1419/common-functions.sh                   |  80 ++++++
 .../once-0000-abnormal-refs-advertise-hook.sh | 199 ++++++++++++++
 t/t1419/test-0000-standard-git-clone.sh       |  56 ++++
 t/t1419/test-0001-standard-git-push.sh        |  34 +++
 ...0002-ls-remote-with-refs-advertise-hook.sh |  95 +++++++
 ...03-upload-pack-with-refs-advertise-hook.sh | 127 +++++++++
 ...4-receive-pack-with-refs-advertise-hook.sh | 251 ++++++++++++++++++
 8 files changed, 980 insertions(+)
 create mode 100755 t/t1419-refs-advertise-hooks.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/once-0000-abnormal-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0000-standard-git-clone.sh
 create mode 100644 t/t1419/test-0001-standard-git-push.sh
 create mode 100644 t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh
 create mode 100644 t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh

diff --git a/t/t1419-refs-advertise-hooks.sh b/t/t1419-refs-advertise-hooks.sh
new file mode 100755
index 00000000000..4b4edb6267e
--- /dev/null
+++ b/t/t1419-refs-advertise-hooks.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+#
+# Copyright (c) 2022 Sun Chao
+#
+
+test_description='Test refs-advertise hook'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/t1419/common-functions.sh
+
+setup_bare_repo_and_work_repo () {
+	# Refs of bare_repo : main(A)
+	# Refs of work_repo: main(A)  tags/v123
+	test_expect_success "setup bare_repo and work_repo" '
+		rm -rf bare_repo.git bare_repo.git.dump &&
+		rm -rf work_repo work_repo.dump &&
+		git init --bare bare_repo.git &&
+		git init work_repo &&
+		create_commits_in work_repo A B C D &&
+		(
+			cd work_repo &&
+			git config --local core.abbrev 7 &&
+			git remote add origin ../bare_repo.git &&
+			git update-ref refs/heads/dev $A &&
+			git update-ref refs/heads/main $B &&
+			git update-ref refs/pull-requests/1/head $C &&
+			git tag -m "v123" v123 $D &&
+			git push origin +refs/heads/*:refs/heads/* &&
+			git push origin +refs/tags/*:refs/tags/* &&
+			git push origin +refs/pull-requests/*:refs/pull-requests/*
+		) &&
+		TAG=$(git -C work_repo rev-parse v123) &&
+
+		# setup pre-receive hook
+		write_script bare_repo.git/hooks/pre-receive <<-\EOF &&
+		exec >&2
+		echo "# pre-receive hook"
+		while read old new ref
+		do
+			echo "pre-receive< $old $new $ref"
+		done
+		EOF
+
+		# setup update hook
+		write_script bare_repo.git/hooks/update <<-\EOF &&
+		exec >&2
+		echo "# update hook"
+		echo "update< $@"
+		EOF
+
+		# setup post-receive hook
+		write_script bare_repo.git/hooks/post-receive <<-\EOF
+		exec >&2
+		echo "# post-receive hook"
+		while read old new ref
+		do
+			echo "post-receive< $old $new $ref"
+		done
+		EOF
+	'
+}
+
+run_refs_advertise_hook_tests() {
+	case $1 in
+		http)
+			PROTOCOL="HTTP protocol"
+			BAREREPO_GIT_DIR="$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
+			BAREREPO_PREFIX="$HTTPD_URL"/smart
+			;;
+		local)
+			PROTOCOL="builtin protocol"
+			BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
+			BAREREPO_PREFIX="$(pwd)"
+			;;
+	esac
+
+	BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
+
+	GIT_TEST_PROTOCOL_VERSION=$2
+
+	# Run test cases for 'refs-advertise' hook
+	for t in  "$TEST_DIRECTORY"/t1419/test-*.sh
+	do
+		# Initialize the bare_repo repository and work_repo
+		setup_bare_repo_and_work_repo
+		git -C work_repo remote set-url origin "$BAREREPO_URL"
+		cp -rf work_repo work_repo.dump
+
+		git -C bare_repo.git config --local http.receivepack true
+		cp -rf bare_repo.git bare_repo.git.dump
+
+		if test "$1" = "http"; then
+			setup_askpass_helper
+			rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
+			mv bare_repo.git "$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
+		fi
+
+		. "$t"
+	done
+}
+
+
+setup_bare_repo_and_work_repo
+BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
+BAREREPO_PREFIX="$(pwd)"
+BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
+
+# Load test cases that only need to be executed once.
+for t in  "$TEST_DIRECTORY"/t1419/once-*.sh
+do
+	. "$t"
+done
+
+for protocol in 1 2
+do
+	# Run test cases for 'refs-advertise' hook on local file protocol.
+	run_refs_advertise_hook_tests local $protocol
+done
+
+ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+start_httpd
+set_askpass user@host pass@host
+
+# Run test cases for 'refs-advertise' hook on HTTP protocol.
+for protocol in 1 2
+do
+	run_refs_advertise_hook_tests http $protocol
+done
+
+test_done
diff --git a/t/t1419/common-functions.sh b/t/t1419/common-functions.sh
new file mode 100644
index 00000000000..ab17c138411
--- /dev/null
+++ b/t/t1419/common-functions.sh
@@ -0,0 +1,80 @@
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
+}
+
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about changes of the commit ID (full or abbrev.)
+# of the output.  Single quotes are replaced with double quotes, because
+# it is boring to prepare unquoted single quotes in expect text.  We also
+# remove some locale error messages. The emitted human-readable errors are
+# redundant to the more machine-readable output the tests already assert.
+make_user_friendly_and_stable_output () {
+	tr '\0' '@' | sed \
+		-e "s/'/\"/g" \
+		-e "s/@.*//g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $C)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(get_abbrev_oid $TAG)[0-9a-f]*/<COMMIT-TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s#$TRASH_DIRECTORY/bare_repo.git#<URL/of/bare_repo.git>#" \
+		-e "s#$BAREREPO_PREFIX/bare_repo.git#<URL/of/bare_repo.git>#"
+}
+
+filter_out_refs_advertise_output() {
+	make_user_friendly_and_stable_output | sed 's/^[0-9a-f]\{4\}//g'
+}
+
+filter_out_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output |
+		sed -n ${1+"$@"}
+}
+
+format_and_save_expect () {
+	sed -e 's/^> //' -e 's/Z$//' >expect
+}
+
+test_cmp_refs () {
+	indir=
+	if test "$1" = "-C"
+	then
+		shift
+		indir="$1"
+		shift
+	fi
+	indir=${indir:+"$indir"/}
+	cat >show-ref.expect &&
+	git ${indir:+ -C "$indir"} show-ref >show-ref.pristine &&
+	make_user_friendly_and_stable_output <show-ref.pristine >show-ref.filtered &&
+	test_cmp show-ref.expect show-ref.filtered
+}
diff --git a/t/t1419/once-0000-abnormal-refs-advertise-hook.sh b/t/t1419/once-0000-abnormal-refs-advertise-hook.sh
new file mode 100644
index 00000000000..6e4cbf95b82
--- /dev/null
+++ b/t/t1419/once-0000-abnormal-refs-advertise-hook.sh
@@ -0,0 +1,199 @@
+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read version" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-version
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read version" '
+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-version option
+		fatal: can not read version message from hook refs-advertise
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when write version" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-write-version
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when write version" '
+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-write-version option
+		fatal: can not read version message from hook refs-advertise
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read first filter request" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-first-ref
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read first filter request" '
+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-first-ref option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die when read second filter request" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-second-ref
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die when read second filter request" '
+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-second-ref option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 1): setup refs-advertise hook which die while filtring refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-filter-refs
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while refs-advertise hook die while filtring refs" '
+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-filter-refs option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read version" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-version
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read version" '
+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-version option
+		fatal: can not read version message from hook refs-advertise
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when write version" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-write-version
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when write version" '
+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-write-version option
+		fatal: can not read version message from hook refs-advertise
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read first filter request" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-first-ref
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read first filter request" '
+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-first-ref option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die when read second filter request" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-read-second-ref
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die when read second filter request" '
+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-read-second-ref option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "builtin protocol (protocol: 2): setup refs-advertise hook which die while filtring refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise \
+			--can-upload-pack \
+			--can-receive-pack \
+			--can-ls-refs \
+			--die-filter-refs
+	EOF
+'
+
+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while refs-advertise hook die while filtring refs" '
+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
+	format_and_save_expect <<-EOF &&
+		fatal: die with the --die-filter-refs option
+		fatal: hook refs-advertise died abnormally
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/test-0000-standard-git-clone.sh b/t/t1419/test-0000-standard-git-clone.sh
new file mode 100644
index 00000000000..8de3d2c3d0a
--- /dev/null
+++ b/t/t1419/test-0000-standard-git-clone.sh
@@ -0,0 +1,56 @@
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
+	refs_num=$(cat out | wc -l) &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	refs_num=$(cat out | wc -l) &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-B>	HEAD
+		<COMMIT-A>	refs/heads/dev
+		<COMMIT-B>	refs/heads/main
+		<COMMIT-C>	refs/pull-requests/1/head
+		<COMMIT-TAG-v123>	refs/tags/v123
+		<COMMIT-D>	refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): upload-pack" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	filter_out_refs_advertise_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-B> HEAD
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): receive-pack" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION receive-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
+	filter_out_refs_advertise_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/test-0001-standard-git-push.sh b/t/t1419/test-0001-standard-git-push.sh
new file mode 100644
index 00000000000..d6e977e899a
--- /dev/null
+++ b/t/t1419/test-0001-standard-git-push.sh
@@ -0,0 +1,34 @@
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main" '
+	create_commits_in work_repo E &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		To <URL/of/bare_repo.git>
+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
+		EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		To <URL/of/bare_repo.git>
+		 - [deleted]         dev
+		EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh b/t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh
new file mode 100644
index 00000000000..3cb4473a676
--- /dev/null
+++ b/t/t1419/test-0002-ls-remote-with-refs-advertise-hook.sh
@@ -0,0 +1,95 @@
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while refs-advertise hook handle no command" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-B>	HEAD
+		<COMMIT-A>	refs/heads/dev
+		<COMMIT-B>	refs/heads/main
+		<COMMIT-C>	refs/pull-requests/1/head
+		<COMMIT-TAG-v123>	refs/tags/v123
+		<COMMIT-D>	refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B" \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote all refs" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-B>	HEAD
+		<COMMIT-A>	refs/heads/dev
+		<COMMIT-B>	refs/heads/main
+		<COMMIT-C>	refs/pull-requests/1/head
+		<COMMIT-TAG-v123>	refs/tags/v123
+		<COMMIT-D>	refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote branches" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-B>	HEAD
+		<COMMIT-A>	refs/heads/dev
+		<COMMIT-B>	refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs  \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote pull refs and tags" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-C>	refs/pull-requests/1/head
+		<COMMIT-TAG-v123>	refs/tags/v123
+		<COMMIT-D>	refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
diff --git a/t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh b/t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh
new file mode 100644
index 00000000000..6c6a9aa57aa
--- /dev/null
+++ b/t/t1419/test-0003-upload-pack-with-refs-advertise-hook.sh
@@ -0,0 +1,127 @@
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while refs-advertise hook handle no command" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B" \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone all refs" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone branches" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-A> refs/heads/dev
+		<COMMIT-B> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise branches" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a not advertised commit" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION init local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git remote add origin "$BAREREPO_URL" &&
+	test_must_fail git -C local.git fetch "$BAREREPO_URL" $D
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-upload-pack \
+		--can-ls-refs \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone pull refs and tags" '
+	rm -rf local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C local.git show-ref -d >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	format_and_save_expect <<-EOF &&
+		<COMMIT-C> refs/pull-requests/1/head
+		<COMMIT-TAG-v123> refs/tags/v123
+		<COMMIT-D> refs/tags/v123^{}
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): clone a not advertised branch" '
+	rm -rf local.git &&
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone "$BAREREPO_URL" local.git -b main &&
+	test ! -d local.git
+'
diff --git a/t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh b/t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh
new file mode 100644
index 00000000000..1dac755b36a
--- /dev/null
+++ b/t/t1419/test-0004-receive-pack-with-refs-advertise-hook.sh
@@ -0,0 +1,251 @@
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which handle no command" '
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+		test-tool refs-advertise
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook handle no command" '
+	create_commits_in work_repo E &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		To <URL/of/bare_repo.git>
+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while refs-advertise hook handle no command" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		To <URL/of/bare_repo.git>
+		 * [new branch]      HEAD -> new
+		EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while refs-advertise hook handle no command" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		To <URL/of/bare_repo.git>
+		 - [deleted]         dev
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise nothing" '
+	rm -rf work_repo &&
+	cp -rf work_repo.dump work_repo &&
+	rm -rf "$BAREREPO_GIT_DIR" &&
+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-receive-pack \
+		--can-ls-refs
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise nothing" '
+	create_commits_in work_repo E &&
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/main        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/main <ZERO-OID> <COMMIT-E>        Z
+		remote: error: cannot lock ref "refs/heads/main": reference already exists        Z
+		To <URL/of/bare_repo.git>
+		 ! [remote rejected] HEAD -> main (failed to update ref)
+		error: failed to push some refs to "<URL/of/bare_repo.git>"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise nothing" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		To <URL/of/bare_repo.git>
+		 * [new branch]      HEAD -> new
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise nothing" '
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		error: unable to delete "dev": remote ref does not exist
+		error: failed to push some refs to "<URL/of/bare_repo.git>"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise all refs" '
+	rm -rf work_repo &&
+	cp -rf work_repo.dump work_repo &&
+	rm -rf "$BAREREPO_GIT_DIR" &&
+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-receive-pack \
+		--can-ls-refs \
+		-r "ref refs/heads/dev $A" \
+		-r "obj $A" \
+		-r "ref refs/heads/main $B" \
+		-r "obj $B" \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise all refs" '
+	create_commits_in work_repo E &&
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
+		To <URL/of/bare_repo.git>
+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
+		EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise all refs" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		To <URL/of/bare_repo.git>
+		 * [new branch]      HEAD -> new
+		EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise all refs" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
+		To <URL/of/bare_repo.git>
+		 - [deleted]         dev
+		EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup refs-advertise hook which advertise pull refs and tags" '
+	rm -rf work_repo &&
+	cp -rf work_repo.dump work_repo &&
+	rm -rf "$BAREREPO_GIT_DIR" &&
+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
+	write_script "$BAREREPO_GIT_DIR/hooks/refs-advertise" <<-EOF
+	test-tool refs-advertise \
+		--can-receive-pack \
+		--can-ls-refs \
+		-r "ref refs/pull-requests/1/head $C" \
+		-r "obj $C" \
+		-r "ref refs/tags/v123 $TAG" \
+		-r "obj $TAG" \
+		-r "obj $D"
+	EOF
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while refs-advertise hook advertise pull refs and tags" '
+	create_commits_in work_repo E &&
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/main        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/main <ZERO-OID> <COMMIT-E>        Z
+		remote: error: cannot lock ref "refs/heads/main": reference already exists        Z
+		To <URL/of/bare_repo.git>
+		 ! [remote rejected] HEAD -> main (failed to update ref)
+		error: failed to push some refs to "<URL/of/bare_repo.git>"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while while refs-advertise hook advertise pull refs and tags" '
+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		remote: # pre-receive hook        Z
+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		remote: # update hook        Z
+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
+		remote: # post-receive hook        Z
+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
+		To <URL/of/bare_repo.git>
+		 * [new branch]      HEAD -> new
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while while refs-advertise hook advertise pull refs and tags" '
+	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >out.tmp &&
+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
+	format_and_save_expect <<-EOF &&
+		error: unable to delete "dev": remote ref does not exist
+		error: failed to push some refs to "<URL/of/bare_repo.git>"
+	EOF
+	test_cmp expect actual
+'
-- 
gitgitgadget

