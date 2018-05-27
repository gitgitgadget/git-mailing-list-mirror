Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B2D1F51C
	for <e@80x24.org>; Sun, 27 May 2018 08:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936287AbeE0Iiu (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 04:38:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34110 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeE0Iip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 04:38:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so15589340wrm.1
        for <git@vger.kernel.org>; Sun, 27 May 2018 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+/GwHhlZcF9hmd3PCgZDDcskhcHO8y8h/0atkMNWWU=;
        b=lllIdW27ocI6qdQnmrM4Mp/VHETTG6fgLKP4mA8scmosca/W0TbmSsXgvxPmK3LdKv
         sagM5HJzvQ0mLFCIaliH3sRdAX4quYjjWmE/G09AIG+1O1rsyyvy8Y9uTAz1VBp0Aeyv
         B+7eusebgqYX2+cxEfVuscy364ByDJ84VgQAJX4KPZY2eAWxAgYEEFgKhizvW1MDfSOB
         6fOA022qNEuCstv8RQ9+SVbOj/YSjznMQYkNC77y10+zRBd2JtfU1/dYp4PfiJ3YnBNv
         exGFmypfIGpHerGaLyHTx7JxozfVR8cdQtuIExH63R+P5Z2pl0s08Jwx/DNeIr8a9Zxx
         n57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+/GwHhlZcF9hmd3PCgZDDcskhcHO8y8h/0atkMNWWU=;
        b=B6A6wtRtNmOP9d4TKnDdwrK3KQ6zbupUSEz7m9CMcgo1vdxc/zd8oZTHy0MHUk/GM4
         ksi7kSGAuuSJPI4UJdxDvG1IDfdrZ73qL3tmHb8ji8ezt44jy7nGkOBX5AW6+jJoARrr
         T1uBfrKg/r9UAsIgSlyQRjTlZ0phM+6DtNVLS0tBLKFkE9NIe6NK1r8cZw1dGyn8UIFA
         fzxsesQivy3Rbibh5UjeO31ytcsO+8ftgOg57GdB1YRmN20NcqI5hap7nNfiY3He1dPm
         vLKPAcxX2diFoJdIwzEnJU9496axqNKT8CNrFH01G3L0VfQk4ZJVIsnuZ/ehqOh4qwFY
         hXMg==
X-Gm-Message-State: ALKqPwd7ze3f4jTHI2oVWLUt11oU2bztji6B+Sn4BS0s3HCsoj/AuH59
        7oN2oxNm3oQYOLtG/VYRl0w=
X-Google-Smtp-Source: ADUXVKKFfJZ3l5346YjXdA8Uyhw9FytZrmZMAjXOasnMC4XfvRu7At9mAFFKSO1u2TpbavbS8BA8VQ==
X-Received: by 2002:a19:9f8e:: with SMTP id i136-v6mr4799502lfe.5.1527410323628;
        Sun, 27 May 2018 01:38:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5297468ljk.80.2018.05.27.01.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 May 2018 01:38:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] completion: collapse extra --no-.. options
Date:   Sun, 27 May 2018 10:38:28 +0200
Message-Id: <20180527083828.6919-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180527083828.6919-1-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <20180527083828.6919-1-pclouds@gmail.com>
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
---
 contrib/completion/git-completion.bash | 20 +++++++
 parse-options.c                        | 72 +++++++++++++++++++-------
 t/t9902-completion.sh                  | 13 +----
 3 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 952e660f06..4eef353ee2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -266,9 +266,29 @@ __gitcomp ()
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
+				COMPREPLY[i++]="${2-}--no-...${4-} "
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
index 7e5e3ad5b1..eb4a43584a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1237,29 +1237,20 @@ test_expect_success 'double dash "git" itself' '
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
2.17.0.705.g3525833791

