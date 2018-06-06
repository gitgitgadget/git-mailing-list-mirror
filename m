Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39591F403
	for <e@80x24.org>; Wed,  6 Jun 2018 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeFFJmM (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 05:42:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35736 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbeFFJmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 05:42:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id y72-v6so8090601lfd.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BKjcl0G1G/rCUzmBcXT50DRKP36DtIuZSfrm7rldy0=;
        b=i1F8m5OuTqqaNK1Cgrg6CVSYyawN4qVdPb++9XALUuEv7sAASHqafPDKkjrNQuZGGt
         pa0AVsRMyeRpjaKtAhm0vTyJgigEK1HO3LKwJHwc2QxOixCg7RExm07NMXgywvmjbaTx
         o3KFEctY3llHl7mscydVubAfPhQm4/oVEiLPZRR0BA42rfO13IJ5Mz173+qX3Des2buN
         FAiblpW6o55XcNYiN+5ckBXg5NcFYPKV58bPr0FRTjLE9HpcnWMAyWd962kJhB2d/9v6
         eXCeIQ+oRCO3M4JDhHSBAMt+AxPStCEqpesCPx4ZhZEQayk0Ik4x3LLDN0+AUXqPudyF
         EqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BKjcl0G1G/rCUzmBcXT50DRKP36DtIuZSfrm7rldy0=;
        b=e4vf7wTz8eUDQBNjj+ooFRyB//zzOa0FakPoG2PtHwe3+kzXbsX03IL/jjJvXQxlHw
         BiEysP8jI5Ncly/d7xVpdlqcDuzC7jVjGFlVwwrOwnfpZV4Vfo5HOEWiGIaATQNeuRWO
         kbeUbv+JCMEmR3fqzxt9eGzPTt4vg2ctJrOfv5zMCmbqS9nV3rUmjorcyfZramaLu8Cx
         rjG97VCUF34Egbijc+OW90xCI87SB/CxYgsnCcyohvaMPNef3yVaLCl5q1SZgsA+AGbF
         hO2UyHB4AS5IVpFqd0a+gHJ/+uapne3nM/ruvngn1iPVy2sFUWdluJIXZr8Biz4+f5ig
         V2pA==
X-Gm-Message-State: APt69E0uAEsYz1HjIzKSCZfZzBhG6plzLPrUnKk3Cx8qmbEXxmjPwQy6
        hvEphWKD8ZivrOgXGjZL9GA=
X-Google-Smtp-Source: ADUXVKJJYPTwd9G617yJ62k2zroL9Nsxcb45eRjo8cm6WE321nDcoJPvN4HQCQVmWXKX3S5HnJTxwQ==
X-Received: by 2002:a2e:3c0e:: with SMTP id j14-v6mr1669359lja.149.1528278126002;
        Wed, 06 Jun 2018 02:42:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2987062ljj.71.2018.06.06.02.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 02:42:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 3/3] completion: collapse extra --no-.. options
Date:   Wed,  6 Jun 2018 11:41:39 +0200
Message-Id: <20180606094139.30906-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606094139.30906-1-pclouds@gmail.com>
References: <20180527083828.6919-1-pclouds@gmail.com>
 <20180606094139.30906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands that make use of --git-completion-helper feature could
now produce a lot of --no-xxx options that a command can take. This in
many case could nearly double the amount of completable options, using
more screen estate and also harder to search for the wanted option.

This patch attempts to mitigate that by collapsing extra --no-
options, the ones that are added by --git-completion-helper and not in
original struct option arrays. The "--no-..." option will be displayed
in this case to hint about more options, e.g.

    > ~/w/git $ git clone --
    --bare                 --origin=
    --branch=              --progress
    --checkout             --quiet
    --config=              --recurse-submodules
    --depth=               --reference=
    --dissociate           --reference-if-able=
    --filter=              --separate-git-dir=
    --hardlinks            --shallow-exclude=
    --ipv4                 --shallow-since=
    --ipv6                 --shallow-submodules
    --jobs=                --shared
    --local                --single-branch
    --mirror               --tags
    --no-...               --template=
    --no-checkout          --upload-pack=
    --no-hardlinks         --verbose
    --no-tags

and when you complete it with --no-<tab>, all negative options will be
presented:

    > ~/w/git $ git clone --no-
    --no-bare                 --no-quiet
    --no-branch               --no-recurse-submodules
    --no-checkout             --no-reference
    --no-config               --no-reference-if-able
    --no-depth                --no-separate-git-dir
    --no-dissociate           --no-shallow-exclude
    --no-filter               --no-shallow-since
    --no-hardlinks            --no-shallow-submodules
    --no-ipv4                 --no-shared
    --no-ipv6                 --no-single-branch
    --no-jobs                 --no-tags
    --no-local                --no-template
    --no-mirror               --no-upload-pack
    --no-origin               --no-verbose
    --no-progress

Corner case: to make sure that people will never accidentally complete
the fake option "--no-..." there must be one real --no- in the first
complete listing even if it's not from the original struct option.

PS. This could could be made simpler with ";&" to fall through from
"--no-*" block and share the code but ";&" is not available on bash-3
(i.e. Mac)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 23 ++++++++
 parse-options.c                        | 72 +++++++++++++++++++-------
 t/t9902-completion.sh                  | 49 ++++++++++++++----
 3 files changed, 115 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 952e660f06..425d06256f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -266,9 +266,32 @@ __gitcomp ()
 	case "$cur_" in
 	--*=)
 		;;
+	--no-*)
+		local c i=0 IFS=$' \t\n'
+		for c in $1; do
+			if [[ $c == "--" ]]; then
+				continue
+			fi
+			c="$c${4-}"
+			if [[ $c == "$cur_"* ]]; then
+				case $c in
+				--*=*|*.) ;;
+				*) c="$c " ;;
+				esac
+				COMPREPLY[i++]="${2-}$c"
+			fi
+		done
+		;;
 	*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
+			if [[ $c == "--" ]]; then
+				c="--no-...${4-}"
+				if [[ $c == "$cur_"* ]]; then
+					COMPREPLY[i++]="${2-}$c "
+				fi
+				break
+			fi
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
diff --git a/parse-options.c b/parse-options.c
index b86612148f..7db84227ab 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -427,12 +427,61 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
+static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
+{
+	int printed_dashdash = 0;
+
+	for (; opts->type != OPTION_END; opts++) {
+		int has_unset_form = 0;
+		const char *name;
+
+		if (!opts->long_name)
+			continue;
+		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+			continue;
+		if (opts->flags & PARSE_OPT_NONEG)
+			continue;
+
+		switch (opts->type) {
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_CALLBACK:
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_COUNTUP:
+		case OPTION_SET_INT:
+			has_unset_form = 1;
+			break;
+		default:
+			break;
+		}
+		if (!has_unset_form)
+			continue;
+
+		if (skip_prefix(opts->long_name, "no-", &name)) {
+			if (nr_noopts < 0)
+				printf(" --%s", name);
+		} else if (nr_noopts >= 0) {
+			if (nr_noopts && !printed_dashdash) {
+				printf(" --");
+				printed_dashdash = 1;
+			}
+			printf(" --no-%s", opts->long_name);
+			nr_noopts++;
+		}
+	}
+}
+
 static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 			const struct option *opts)
 {
+	const struct option *original_opts = opts;
+	int nr_noopts = 0;
+
 	for (; opts->type != OPTION_END; opts++) {
 		const char *suffix = "";
-		int has_unset_form = 0;
 
 		if (!opts->long_name)
 			continue;
@@ -447,8 +496,6 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 		case OPTION_INTEGER:
 		case OPTION_MAGNITUDE:
 		case OPTION_CALLBACK:
-			has_unset_form = 1;
-
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
 			if (opts->flags & PARSE_OPT_OPTARG)
@@ -457,28 +504,17 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 				break;
 			suffix = "=";
 			break;
-		case OPTION_BIT:
-		case OPTION_NEGBIT:
-		case OPTION_COUNTUP:
-		case OPTION_SET_INT:
-			has_unset_form = 1;
-			break;
 		default:
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
 			suffix = "=";
+		if (starts_with(opts->long_name, "no-"))
+			nr_noopts++;
 		printf(" --%s%s", opts->long_name, suffix);
-
-		if (has_unset_form && !(opts->flags & PARSE_OPT_NONEG)) {
-			const char *name;
-
-			if (skip_prefix(opts->long_name, "no-", &name))
-				printf(" --%s", name);
-			else
-				printf(" --no-%s", opts->long_name);
-		}
 	}
+	show_negated_gitcomp(original_opts, -1);
+	show_negated_gitcomp(original_opts, nr_noopts);
 	fputc('\n', stdout);
 	exit(0);
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7e5e3ad5b1..157ee7085d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -459,6 +459,42 @@ test_expect_success '__gitcomp - suffix' '
 	EOF
 '
 
+test_expect_success '__gitcomp - ignore optional negative options' '
+	test_gitcomp "--" "--abc --def --no-one -- --no-two" <<-\EOF
+	--abc Z
+	--def Z
+	--no-one Z
+	--no-... Z
+	EOF
+'
+
+test_expect_success '__gitcomp - ignore/narrow optional negative options' '
+	test_gitcomp "--a" "--abc --abcdef --no-one -- --no-two" <<-\EOF
+	--abc Z
+	--abcdef Z
+	EOF
+'
+
+test_expect_success '__gitcomp - ignore/narrow optional negative options' '
+	test_gitcomp "--n" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	--no-... Z
+	EOF
+'
+
+test_expect_success '__gitcomp - expand all negative options' '
+	test_gitcomp "--no-" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	--no-two Z
+	EOF
+'
+
+test_expect_success '__gitcomp - expand/narrow all negative options' '
+	test_gitcomp "--no-o" "--abc --def --no-one -- --no-two" <<-\EOF
+	--no-one Z
+	EOF
+'
+
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
@@ -1237,29 +1273,20 @@ test_expect_success 'double dash "git" itself' '
 test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
-	--no-quiet Z
 	--detach Z
-	--no-detach Z
 	--track Z
-	--no-track Z
 	--orphan=Z
-	--no-orphan Z
 	--ours Z
 	--theirs Z
 	--merge Z
-	--no-merge Z
 	--conflict=Z
-	--no-conflict Z
 	--patch Z
-	--no-patch Z
 	--ignore-skip-worktree-bits Z
-	--no-ignore-skip-worktree-bits Z
 	--ignore-other-worktrees Z
-	--no-ignore-other-worktrees Z
 	--recurse-submodules Z
-	--no-recurse-submodules Z
 	--progress Z
-	--no-progress Z
+	--no-quiet Z
+	--no-... Z
 	EOF
 '
 
-- 
2.18.0.rc0.333.g22e6ee6cdf

