Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A683AC43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AA12070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRboQhH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgCUJWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42759 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgCUJWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so9792383qkg.9
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWtpMT1qwqplT8DYQDTsesksYkan0RzUr/I4M+dg4+A=;
        b=uRboQhH79M2q3dtwu7xF9MnT0Y5TNbqCvJKaGGxLYBTdpazpP8sTIH9YiSLq0CGj7j
         AARdVy8YoWW9cfiyKZDUlupnc35RYQ+Hfs6bVBM4v6Na7qvOqqBUqR8bz6rX7nqEnEdw
         LFAO4d0NWDGFEkjQL1WeIdGnUk5LmiewtqC1DIXGsveuE75rhHoY/FdXIX/8gS8wn6sB
         TwlR9HjD0dhAxXm/lnRgH5K91Wc9GQqjZhjYBZWEYRTt6GeCq7TQ5K3KvDzBZWAqxcKw
         G5Zxs3AFrcy3qdUFDdpZNcBXsLS/V7quGeYAyDYSqB2phxlqa/W0ZjwkcK6jpLBI4KfQ
         hz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWtpMT1qwqplT8DYQDTsesksYkan0RzUr/I4M+dg4+A=;
        b=t7VJHvM39Ni12pBO4zrVOH2dvRpRcspjCU+IoNLN2NECkBjaFRnlo5qoOEtQCZFGID
         mUJsKT4Ko7OOWpNVRNikIYsxusw0mCqj2pfgohjCLO4UGUmrMk2ZAi5jY9TicFCZ06xR
         Gt6fpQTdtBfzi+C64drvS765CUd/LQbwfa7j4UUggNv8drKaCnSsvifKXYQmp7luvpJj
         iWJellISahq6Yecufzk9qrVArBY14iWZtXX9o4TrBtJLTJ8HF543WN0YvNLkio/SxSUU
         45KbY2nTqReFbLPaU0Hv3Dl/QnpTDTo8fItXUxEj8+zdPi+6vv6y19VpJsKrVfzpgpbp
         Ypug==
X-Gm-Message-State: ANhLgQ3WDg29JLNkOXM0Tws+ObmU32YgDJzFcoGjMHMPUEVguDYyJbi0
        zgKGnGKNzhj0N3k8NVfXLj5te6Bj
X-Google-Smtp-Source: ADFU+vs7zfOZSdul9Ij8QXsFtl7ARn5RKckmWgl1OZX8VwwU93heAw4FeHvzM4SBBJZBeb0jzpjsyg==
X-Received: by 2002:a37:b0d:: with SMTP id 13mr12426271qkl.9.1584782561829;
        Sat, 21 Mar 2020 02:22:41 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 19/19] pull: pass --autostash to merge
Date:   Sat, 21 Mar 2020 05:21:38 -0400
Message-Id: <17caf6d66f5ee33e6aef7265ab33dee83f24f05c.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, `--autostash` only worked with `git pull --rebase`. However, in
the last patch, merge learned `--autostash` as well so there's no reason
why we should have this restriction anymore. Teach pull to pass
`--autostash` to merge, just like it did for rebase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-pull.txt      |  9 -------
 Documentation/merge-options.txt |  4 +--
 builtin/pull.c                  |  9 ++++---
 t/t5520-pull.sh                 | 43 +++++++++++++++++++++++++++------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b8..ba3772de9f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -133,15 +133,6 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
---autostash::
---no-autostash::
-	Before starting rebase, stash local modifications away (see
-	linkgit:git-stash[1]) if needed, and apply the stash entry when
-	done. `--no-autostash` is useful to override the `rebase.autoStash`
-	configuration variable (see linkgit:git-config[1]).
-+
-This option is only valid when "--rebase" is used.
-
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 34493eb58b..ae56cca826 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -155,6 +155,8 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+endif::git-pull[]
+
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
@@ -163,8 +165,6 @@ ifndef::git-pull[]
 	with care: the final stash application after a successful
 	rebase might result in non-trivial conflicts.
 
-endif::git-pull[]
-
 --allow-unrelated-histories::
 	By default, `git merge` command refuses to merge histories
 	that do not share a common ancestor.  This option can be
diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..9beb4841d1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -163,7 +163,7 @@ static struct option pull_options[] = {
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
 	OPT_BOOL(0, "autostash", &opt_autostash,
-		N_("automatically stash/stash pop before and after rebase")),
+		N_("automatically stash/stash pop before and after")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -661,6 +661,10 @@ static int run_merge(void)
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
 
@@ -908,9 +912,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (!opt_rebase && opt_autostash != -1)
-		die(_("--[no-]autostash option is only valid with --rebase."));
-
 	autostash = config_autostash;
 	if (opt_rebase) {
 		if (opt_autostash != -1)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f610dc14de..37535d63a9 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -28,7 +28,7 @@ test_pull_autostash_fail () {
 	echo dirty >new_file &&
 	git add new_file &&
 	test_must_fail git pull "$@" . copy 2>err &&
-	test_i18ngrep "uncommitted changes." err
+	test_i18ngrep "\(uncommitted changes.\)\|\(overwritten by merge:\)" err
 }
 
 test_expect_success setup '
@@ -404,13 +404,40 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_pull_autostash_fail --rebase --no-autostash
 '
 
-for i in --autostash --no-autostash
-do
-	test_expect_success "pull $i (without --rebase) is illegal" '
-		test_must_fail git pull $i . copy 2>err &&
-		test_i18ngrep "only valid with --rebase" err
-	'
-done
+test_expect_success 'pull succeeds with dirty working directory and merge.autostash set' '
+	test_config merge.autostash true &&
+	test_pull_autostash 2
+'
+
+test_expect_success 'pull --autostash & merge.autostash=true' '
+	test_config merge.autostash true &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --autostash & merge.autostash=false' '
+	test_config merge.autostash false &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --autostash & merge.autostash unset' '
+	test_unconfig merge.autostash &&
+	test_pull_autostash 2 --autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash=true' '
+	test_config merge.autostash true &&
+	test_pull_autostash_fail --no-autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash=false' '
+	test_config merge.autostash false &&
+	test_pull_autostash_fail --no-autostash
+'
+
+test_expect_success 'pull --no-autostash & merge.autostash unset' '
+	test_unconfig merge.autostash &&
+	test_pull_autostash_fail --no-autostash
+'
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.25.0.114.g5b0ca878e0

