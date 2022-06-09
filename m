Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA7C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 12:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiFIMiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbiFIMiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 08:38:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61123BD4
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 05:37:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q15so9226926wmj.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDRjonPn5DRX/QBkp1IjCy8S+PP6xsD6VAROlWjqdZg=;
        b=E6w3ssztVBtUjySvd6lVKDv4Hnpb0xeLHuKdc7+0YoR6uVz8lfCbMNmlWi5G7W7tp8
         fQ+OBFA9++ADh/gp3e52LYwZCpoeDf74ouaCLpSSMvgpiKOsbHGk2BI8TsEUBwl2mf/D
         f8OBZLcdXSZ61975AZghdu3x55QexhE1h6+LO5L81e9E28KPOP1MFCX6WXGq+Bs0+s/G
         IFvJnXPY6lqUGj8y/7g7f5i8UIiCLbr0p4CBvuG0BQkD10nmZMm+xBzLr9w8l5X4d2pe
         3Nip7z2wRfCaZfxia24PWxLS0PYVKOXLlI6fJEf+IiOrEA5jeEE5c2nb8PXGXEAtnYny
         zDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDRjonPn5DRX/QBkp1IjCy8S+PP6xsD6VAROlWjqdZg=;
        b=0g6Mavklm6bVseT/MXM2wWfbSUZC2ByocCt92YaTAViCZjVuonudLQD/4fweM3uzy/
         XVCex4JaKiQM7qFI9tdUlhuGqiwhdYoeDkpgQExSZgvwb4aKgtKPnsb6zThgDFu3K3wv
         zniaK2ZvOPaF4w3vJBWIiMtE57ijnJCo0Zpgk1Tbubd4kTaoGpzN6X1n50UDJ1xHAuXI
         EfJJOsWZYI5J1n8/43DF3sNZHV0Kn2DnCkl0Gib9xw/qJLIr42vnKSfgeEW53EFMvEZt
         93w9UZ2yLTdm0yb6/hJgYoXuiS9EoX50i1AaN7pmSvOHOdsAH8CHU9pkhq/wf+BMg5AB
         6tGg==
X-Gm-Message-State: AOAM5320n+yZ9bd3cYnAFbCZbpgB4juLNonJHYohZSSn2xtaDB0paOBX
        e0e2djC9HdL6NJrnU3Rp0bVgVBMZ7uZZ/rnh
X-Google-Smtp-Source: ABdhPJyUyOZENrenyYZZHyumHHv74Ggpl3PrspqLFgspqaoU8vK6smTMmS4tGzwv2MPoiJtR+AUxDw==
X-Received: by 2002:a1c:4e03:0:b0:39c:5bbc:e0d2 with SMTP id g3-20020a1c4e03000000b0039c5bbce0d2mr3167101wmh.184.1654778274282;
        Thu, 09 Jun 2022 05:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm30823370wms.47.2022.06.09.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:37:53 -0700 (PDT)
Message-Id: <pull.1250.v2.git.1654778272871.gitgitgadget@gmail.com>
In-Reply-To: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 12:37:52 +0000
Subject: [PATCH v2] ls-files.c: add --object-only option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git ls-files --stage` default output format is:

[<tag> ]<mode> <object> <stage> <file>

sometime we want to find a path's corresponding objectname,
we will parse the output and extract objectname from it
again and again.

So introduce a new option `--object-only` which can only
output objectname when giving `--stage` or `--resolve-undo`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files.c: add --object-only option
    
    v1 -> v2: rename option '--only-object-name' to '--object-only'.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1250%2Fadlternative%2Fzh%2Fls-file-only-objectname-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1250/adlternative/zh/ls-file-only-objectname-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1250

Range-diff vs v1:

 1:  10efe3bd9ca ! 1:  aed0bd2c791 ls-files.c: add --only-object-name option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    ls-files.c: add --only-object-name option
     +    ls-files.c: add --object-only option
      
          `git ls-files --stage` default output format is:
      
     @@ Commit message
          we will parse the output and extract objectname from it
          again and again.
      
     -    So introduce a new option `--only-object-name` which can only
     +    So introduce a new option `--object-only` which can only
          output objectname when giving `--stage` or `--resolve-undo`.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ Documentation/git-ls-files.txt: SYNOPSIS
       		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
       		[--directory [--no-empty-directory]] [--eol]
      -		[--deduplicate]
     -+		[--deduplicate] [--only-object-name]
     ++		[--deduplicate] [--object-only]
       		[-x <pattern>|--exclude=<pattern>]
       		[-X <file>|--exclude-from=<file>]
       		[--exclude-per-directory=<file>]
     @@ Documentation/git-ls-files.txt: OPTIONS
       	When any of the `-t`, `--unmerged`, or `--stage` option is
       	in use, this option has no effect.
       
     -+--only-object-name:
     ++--object-only:
      +	When giving `--stage` or `--resolve-undo` , only output `<object>`
      +	instead of `[<tag> ]<mode> <object> <stage> <file>` format.
      +
     @@ builtin/ls-files.c: static int show_deleted;
       static int show_cached;
       static int show_others;
       static int show_stage;
     -+static int only_object_name;
     ++static int object_only;
       static int show_unmerged;
       static int show_resolve_undo;
       static int show_modified;
     @@ builtin/ls-files.c: static void show_ce(struct repository *repo, struct dir_stru
       			fputs(tag, stdout);
       		} else {
      +			const char *object_name = repo_find_unique_abbrev(repo, &ce->oid, abbrev);
     -+			if (only_object_name) {
     ++			if (object_only) {
      +				printf("%s%c", object_name, line_terminator);
      +				return;
      +			}
     @@ builtin/ls-files.c: static void show_ru_info(struct index_state *istate)
       		for (i = 0; i < 3; i++) {
       			if (!ui->mode[i])
       				continue;
     -+			if (only_object_name) {
     ++			if (object_only) {
      +				printf("%s%c", find_unique_abbrev(&ui->oid[i], abbrev), line_terminator);
      +				continue;
      +			}
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       			DIR_SHOW_IGNORED),
       		OPT_BOOL('s', "stage", &show_stage,
       			N_("show staged contents' object name in the output")),
     -+		OPT_BOOL(0, "only-object-name", &only_object_name,
     ++		OPT_BOOL(0, "object-only", &object_only,
      +			N_("only show staged contents' object name in the output")),
       		OPT_BOOL('k', "killed", &show_killed,
       			N_("show files on the filesystem that need to be removed")),
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       		die("ls-files --recurse-submodules does not support "
       		    "--error-unmatch");
       
     -+	if (only_object_name && !show_stage && !show_resolve_undo)
     -+		die("ls-files --only-object-name only used with --stage "
     -+		    "or --resolve-undo");
     ++	if (object_only && !show_stage && !show_resolve_undo)
     ++		die(_("ls-files --object-only only used with --stage "
     ++		    "or --resolve-undo"));
      +
       	parse_pathspec(&pathspec, 0,
       		       PATHSPEC_PREFER_CWD,
     @@ t/t2030-unresolve-info.sh: check_resolve_undo () {
       	test_cmp "$msg.expect" "$msg.actual"
       }
       
     -+check_resolve_undo_only_object_name() {
     ++check_resolve_undo_object_only() {
      +	msg=$1
      +	shift
      +	while case $# in
      +	0)	break ;;
     -+	1|2|3)	die "Bug in check-resolve-undo test" ;;
     ++	1|2|3)	BUG "wrong arguments" ;;
      +	esac
      +	do
      +		path=$1
     @@ t/t2030-unresolve-info.sh: check_resolve_undo () {
      +			case "$sha1" in
      +			'') continue ;;
      +			esac
     -+			sha1=$(git rev-parse --verify "$sha1")
     ++			sha1=$(git rev-parse --verify "$sha1") &&
      +			printf "%s\n" $sha1
      +		done
      +	done >"$msg.expect" &&
     -+	git ls-files --resolve-undo --only-object-name >"$msg.actual" &&
     ++	git ls-files --resolve-undo --object-only >"$msg.actual" &&
      +	test_cmp "$msg.expect" "$msg.actual"
      +}
      +
     @@ t/t2030-unresolve-info.sh: test_expect_success 'rerere forget (add-add conflict)
       	test_i18ngrep "no remembered" actual
       '
       
     -+test_expect_success '--resolve-undo with --only-object-name' '
     ++test_expect_success '--resolve-undo with --object-only' '
      +	prime_resolve_undo &&
     -+	check_resolve_undo_only_object_name kept fi/le initial:fi/le second:fi/le third:fi/le &&
     ++	check_resolve_undo_object_only kept fi/le initial:fi/le second:fi/le third:fi/le &&
      +	git checkout second^0 &&
      +	echo switching clears &&
      +	check_resolve_undo cleared
     @@ t/t3004-ls-files-basic.sh: test_expect_success SYMLINKS 'ls-files with absolute
       	test_cmp expect actual
       '
       
     -+test_expect_success 'git ls-files --stage with --only-object-name' '
     ++test_expect_success 'git ls-files --stage with --object-only' '
      +	git init test &&
      +	test_when_finished "rm -rf test" &&
     -+	(
     -+		cd test &&
     -+		echo a >a.txt &&
     -+		echo b >b.txt &&
     -+		git add a.txt b.txt &&
     -+		oid1=$(git hash-object a.txt) &&
     -+		oid2=$(git hash-object b.txt) &&
     -+		git ls-files --stage --only-object-name >actual &&
     -+		cat >expect <<-EOF &&
     -+		$oid1
     -+		$oid2
     -+		EOF
     -+		test_cmp expect actual
     -+	)
     ++	echo a >test/a.txt &&
     ++	echo b >test/b.txt &&
     ++	git -C test add a.txt b.txt &&
     ++	oid1=$(git -C test hash-object a.txt) &&
     ++	oid2=$(git -C test hash-object b.txt) &&
     ++	git -C test ls-files --stage --object-only >actual &&
     ++	cat >expect <<-EOF &&
     ++	$oid1
     ++	$oid2
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --only-object-name without --stage or --resolve-undo' '
     ++test_expect_success 'git ls-files --object-only without --stage or --resolve-undo' '
      +	git init test &&
      +	test_when_finished "rm -rf test" &&
     -+	(
     -+		cd test &&
     -+		echo a >a.txt &&
     -+		echo b >b.txt &&
     -+		git add a.txt b.txt &&
     -+		test_must_fail git ls-files --only-object-name 2>stderr &&
     -+		test_i18ngrep "fatal: ls-files --only-object-name only used with --stage or --resolve-undo" stderr
     -+	)
     ++	echo a >test/a.txt &&
     ++	echo b >test/b.txt &&
     ++	git -C test add a.txt b.txt &&
     ++	test_must_fail git -C test ls-files --object-only 2>stderr &&
     ++	grep "fatal: ls-files --object-only only used with --stage or --resolve-undo" stderr
      +'
      +
       test_done


 Documentation/git-ls-files.txt |  6 +++++-
 builtin/ls-files.c             | 18 +++++++++++++++++-
 t/t2030-unresolve-info.sh      | 33 +++++++++++++++++++++++++++++++++
 t/t3004-ls-files-basic.sh      | 26 ++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..9736b02b565 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
 		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
 		[--directory [--no-empty-directory]] [--eol]
-		[--deduplicate]
+		[--deduplicate] [--object-only]
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
@@ -88,6 +88,10 @@ OPTIONS
 	When any of the `-t`, `--unmerged`, or `--stage` option is
 	in use, this option has no effect.
 
+--object-only:
+	When giving `--stage` or `--resolve-undo` , only output `<object>`
+	instead of `[<tag> ]<mode> <object> <stage> <file>` format.
+
 -x <pattern>::
 --exclude=<pattern>::
 	Skip untracked files matching pattern.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..2fef5f40a3f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -26,6 +26,7 @@ static int show_deleted;
 static int show_cached;
 static int show_others;
 static int show_stage;
+static int object_only;
 static int show_unmerged;
 static int show_resolve_undo;
 static int show_modified;
@@ -241,10 +242,15 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 		if (!show_stage) {
 			fputs(tag, stdout);
 		} else {
+			const char *object_name = repo_find_unique_abbrev(repo, &ce->oid, abbrev);
+			if (object_only) {
+				printf("%s%c", object_name, line_terminator);
+				return;
+			}
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
-			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
+			       object_name,
 			       ce_stage(ce));
 		}
 		write_eolinfo(repo->index, ce, fullname);
@@ -274,6 +280,10 @@ static void show_ru_info(struct index_state *istate)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
+			if (object_only) {
+				printf("%s%c", find_unique_abbrev(&ui->oid[i], abbrev), line_terminator);
+				continue;
+			}
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(&ui->oid[i], abbrev),
 			       i + 1);
@@ -635,6 +645,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
+		OPT_BOOL(0, "object-only", &object_only,
+			N_("only show staged contents' object name in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
@@ -734,6 +746,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
+	if (object_only && !show_stage && !show_resolve_undo)
+		die(_("ls-files --object-only only used with --stage "
+		    "or --resolve-undo"));
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index f691e6d9032..cdab953980c 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -32,6 +32,31 @@ check_resolve_undo () {
 	test_cmp "$msg.expect" "$msg.actual"
 }
 
+check_resolve_undo_object_only() {
+	msg=$1
+	shift
+	while case $# in
+	0)	break ;;
+	1|2|3)	BUG "wrong arguments" ;;
+	esac
+	do
+		path=$1
+		shift
+		for stage in 1 2 3
+		do
+			sha1=$1
+			shift
+			case "$sha1" in
+			'') continue ;;
+			esac
+			sha1=$(git rev-parse --verify "$sha1") &&
+			printf "%s\n" $sha1
+		done
+	done >"$msg.expect" &&
+	git ls-files --resolve-undo --object-only >"$msg.actual" &&
+	test_cmp "$msg.expect" "$msg.actual"
+}
+
 prime_resolve_undo () {
 	git reset --hard &&
 	git checkout second^0 &&
@@ -194,4 +219,12 @@ test_expect_success 'rerere forget (add-add conflict)' '
 	test_i18ngrep "no remembered" actual
 '
 
+test_expect_success '--resolve-undo with --object-only' '
+	prime_resolve_undo &&
+	check_resolve_undo_object_only kept fi/le initial:fi/le second:fi/le third:fi/le &&
+	git checkout second^0 &&
+	echo switching clears &&
+	check_resolve_undo cleared
+'
+
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index a16e25c79bd..6c81ead140e 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -52,4 +52,30 @@ test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ls-files --stage with --object-only' '
+	git init test &&
+	test_when_finished "rm -rf test" &&
+	echo a >test/a.txt &&
+	echo b >test/b.txt &&
+	git -C test add a.txt b.txt &&
+	oid1=$(git -C test hash-object a.txt) &&
+	oid2=$(git -C test hash-object b.txt) &&
+	git -C test ls-files --stage --object-only >actual &&
+	cat >expect <<-EOF &&
+	$oid1
+	$oid2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --object-only without --stage or --resolve-undo' '
+	git init test &&
+	test_when_finished "rm -rf test" &&
+	echo a >test/a.txt &&
+	echo b >test/b.txt &&
+	git -C test add a.txt b.txt &&
+	test_must_fail git -C test ls-files --object-only 2>stderr &&
+	grep "fatal: ls-files --object-only only used with --stage or --resolve-undo" stderr
+'
+
 test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
