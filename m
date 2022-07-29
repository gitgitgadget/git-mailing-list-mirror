Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDEC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiG2TaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiG2TaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:30:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8787358
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a18-20020a05600c349200b003a30de68697so4774616wmq.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oJoq1uXDl143NTF1u/dd6KyDPbbovo9RQ9+2oLr18xo=;
        b=bC8cY95X1DWvCBGys2THk9LbMX6Hhx5L00ZuR2ZcfdfnOEtEPafscMCwuhfz/vyxH/
         g2QLtYFjIlXoEE0937W5SHQDp7AETFQJp9NXOQRD5KKcVjiWlNz5qdmAp7yLJwckAvNA
         2jbb+jOuuopji8/deAWTaQVVsCwRhF9gJ190xGfaZTme94LduKUU9A2uJ4m5iuCuchXU
         m0dDDEUcfe0CvdgHJRJW0dTswOjTYwzUNtJH2e7g7eROZaINj6tf9UgxtGfY9hR/I5kX
         huxjL8ARN1AYBN58vdN1ZEvuFvLqGI6TZhNpWk5ASZDDG9tBQBtsMZ3IV+GoNq1Se/kb
         gwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oJoq1uXDl143NTF1u/dd6KyDPbbovo9RQ9+2oLr18xo=;
        b=0Nu/9eq3TeOEbdyB7omrrdzdkzIm3k2Qhs3Zi3aQVpYm1jcwWjC1H/NUmseGHE699z
         SA1E1hYagSsiPaIYtPEtPTNl+66VMGB8CCAITBXE+jS5V3R0DFTOyMKb5hGbGW6DU/SC
         nZ4eGNEd0oNEknX/uhNopjVCkzHaSZ9joK748KTVblmKzrJOshis7WqAMDW8GuQBmHMi
         t9oKtSm8vmujI04ojPp1WWLDN2vIWa8ZZnsptIV9HDvpeVEWF3K0RT7YSqY01GFrxcpo
         tYfawWbE3ARZ2CbgiY8EflG6E8reYBdlFDinZhERLRZNDC/Yr1FvxkdPMqg63F/raZjo
         nmlQ==
X-Gm-Message-State: AJIora9S6ODAMkLV4h0LxAGWBBaAHuHJmfv5/zIyHOQuoQV6+TZS17oB
        eBcQa5mBqKFUUdW9PAYfcqWfhImNF2U=
X-Google-Smtp-Source: AGRyM1uYnv1C1JBYOxvlB/VO6BIqjjxEYlkx0ep04fdVciUALUUleTsbcTXLxpTIEoDl2gjcIgXsQg==
X-Received: by 2002:a05:600c:4e86:b0:3a3:2edc:bcb4 with SMTP id f6-20020a05600c4e8600b003a32edcbcb4mr3920966wmq.85.1659122990157;
        Fri, 29 Jul 2022 12:29:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003a342933727sm12086430wmq.3.2022.07.29.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:49 -0700 (PDT)
Message-Id: <8142b32f023685c78936a618d7b93aaf86ba77fb.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:37 +0000
Subject: [PATCH v2 08/10] log: create log.decorateFilter=all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the --decorate-all option for users who
do not want their decorations limited to a narrow set of ref namespaces.

Add a config option that is equivalent to specifying --decorate-all by
default.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/log.txt |  5 +++++
 Documentation/git-log.txt    |  4 +++-
 builtin/log.c                | 12 ++++++++++++
 t/t4202-log.sh               |  3 +++
 t/t9902-completion.sh        |  3 +++
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800c..615cb26e5c9 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -18,6 +18,11 @@ log.decorate::
 	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
+log.decorateFilter::
+	By default, `git log` only shows decorations for certain known ref
+	namespaces. If 'all' is specified, then show all possible ref
+	decorations. Default value is 'default'.
+
 log.excludeDecoration::
 	Exclude the specified patterns from the log decorations. This is
 	similar to the `--decorate-refs-exclude` command-line option, but
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 633705bde90..c35f9b8ad9e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -59,7 +59,9 @@ used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 --decorate-all::
 	When specified, this option clears all previous `--decorate-refs`
 	or `--decorate-refs-exclude` options and relaxes the default
-	decoration filter to include all possible decoration refs.
+	decoration filter to include all possible decoration refs. This
+	option is assumed if the config value `log.decorateFilter` is set
+	to `all`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index b7fc4946c35..961fe3ae45b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -184,6 +184,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
 	int i;
+	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude =
 			git_config_get_value_multi("log.excludeDecoration");
@@ -195,6 +196,17 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 					   item->string);
 	}
 
+	/*
+	 * By default, decorate_all is disabled. Enable it if
+	 * log.decorateMode=all. Don't ever disable it by config, since
+	 * the command-line takes precedent.
+	 */
+	if (!decorate_all &&
+	    !git_config_get_string("log.decoratefilter", &value) &&
+	    !strcmp("all", value))
+		decorate_all = 1;
+	free(value);
+
 	if (decorate_all ||
 	    decoration_filter->exclude_ref_pattern->nr ||
 	    decoration_filter->include_ref_pattern->nr ||
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e939ed34ff7..6d96710fdfa 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1090,6 +1090,9 @@ test_expect_success '--decorate-all overrides defaults' '
 	EOF
 	git log --decorate=full --pretty="tformat:%f%d" \
 		--decorate-all >actual &&
+	test_cmp expect.all actual &&
+	git -c log.decorateFilter=all log \
+		--decorate=full --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.all actual
 '
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 31526e6b641..7a0c7b3c372 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2489,6 +2489,7 @@ test_expect_success 'git config - variable name' '
 	test_completion "git config log.d" <<-\EOF
 	log.date Z
 	log.decorate Z
+	log.decorateFilter Z
 	log.diffMerges Z
 	EOF
 '
@@ -2511,6 +2512,7 @@ test_expect_success 'git -c - variable name' '
 	test_completion "git -c log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.decorateFilter=Z
 	log.diffMerges=Z
 	EOF
 '
@@ -2533,6 +2535,7 @@ test_expect_success 'git clone --config= - variable name' '
 	test_completion "git clone --config=log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
+	log.decorateFilter=Z
 	log.diffMerges=Z
 	EOF
 '
-- 
gitgitgadget

