Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA9C4727F
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8071208C7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 05:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP7POyyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJGFJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 01:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGFJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 01:09:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05913C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 22:09:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x5so401949plo.6
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 22:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5IX/LyF7jIRfiZ96eICNtdfw3Ph1ZhWc0no8R3Ff+s=;
        b=tP7POyyAEzbGDaL/9IavOWkAq9OSBUsoxUASGTL1E94v1OSHYbSVIWuv/S/bCfA20c
         m0qw6hqfITQSXtad5l+xtLaMFQuN8V2KCUDxpI58KTE0M9vuLRbrrcNhEvYywSW88Kes
         4Hx1U2VxKfbujYKO+3K8HahaEdL8VirlQMJBQ4VEg5W1n1JYlbyt23Z2v0c/mVxKsDYy
         1l8zsCrrllEO2iw0bL1jdDDU6NDFHdY/GSjHqhrOPdXC26kcDrBBsbhHeirKh1NRd7yN
         eXqLcYe9JDxJjawPEBCHYmdOcVKMJWPtCbFGx6jg4/j+NjcRNZmdoFp0RtbKVfqEgRZW
         YRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5IX/LyF7jIRfiZ96eICNtdfw3Ph1ZhWc0no8R3Ff+s=;
        b=K326xd+NK2pvU9U48+QjA7FWjZbooyZwUUGcsQ+DMs5NrIYwu6zzpuXvgzvPLnDiP4
         v7AvKvkMXVpIswxtezx6EwPn9RAvoty2V52irDL9E/TgF9FjHUfK/aWn+ql04g5RQGvI
         jZJfjY2OpSa2K93EKh8Y1Q4Sn1k6KSvq1XntxHHEdVIYZ5wDHYWCmu/2RKS4DG201Wr/
         MylmDQ6pAVglGPP0iO/POkTqtwGgTOGz/Fj5CN0ZOLayJcxueAjf5KLTDc6GC3QeS7Sk
         ypk4ierhgVAiTGvrfMtRU8JixrkLOvbTVxSNWrYIXPisNL3NMjI7ZTfyYeZ9xsMZHbc9
         IJjQ==
X-Gm-Message-State: AOAM531fwoth9zRFRiVkMMmkSYmcMtAVUyP9PmGbblAmrleUnpyvmXK9
        7+q8/yvqxtazORVzJRfnY5RbvJPm7d8=
X-Google-Smtp-Source: ABdhPJwXioDO9UfNH1NTbJdEsgdBKmidUZScr5O+Mqi4YsWhxBeuV2xnYDex3jN3Yr/ItATunqA98g==
X-Received: by 2002:a17:90a:62c2:: with SMTP id k2mr1328574pjs.78.1602047367182;
        Tue, 06 Oct 2020 22:09:27 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id x23sm1053621pfc.47.2020.10.06.22.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:09:26 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] checkout: learn to respect checkout.guess
Date:   Tue,  6 Oct 2020 22:09:09 -0700
Message-Id: <2678680a08e025e9652c6769501dbc604560394b.1602047333.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602047333.git.liu.denton@gmail.com>
References: <cover.1601810233.git.liu.denton@gmail.com> <cover.1602047333.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current behavior of git checkout/switch is that --guess is currently
enabled by default. However, some users may not wish for this to happen
automatically. Instead of forcing users to specify --no-guess manually
each time, teach these commands the checkout.guess configuration
variable that gives users the option to set a default behavior.

Teach the completion script to recognize the new config variable and
disable DWIM logic if it is set to false.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/checkout.txt      |  5 +++
 Documentation/git-checkout.txt         |  3 ++
 Documentation/git-switch.txt           |  3 ++
 builtin/checkout.c                     |  7 +++-
 contrib/completion/git-completion.bash | 25 ++++++++-----
 t/t2024-checkout-dwim.sh               | 11 ++++++
 t/t2060-switch.sh                      |  5 ++-
 t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index e3684a5459..2cddf7b4b4 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -16,3 +16,8 @@ will checkout the `<something>` branch on another remote,
 and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
+
+checkout.guess::
+	Provides the default value for the `--guess` or `--no-guess`
+	option in `git checkout` and `git switch`. See
+	linkgit:git-switch[1] and linkgit:git-checkout[1].
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index afa5c11fd3..28f656d04e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -193,6 +193,9 @@ branches from there if `<branch>` is ambiguous but exists on the
 linkgit:git-config[1].
 +
 Use `--no-guess` to disable this.
++
+The default behavior can be set via the `checkout.guess` configuration
+variable.
 
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 3759c3a265..5c438cd505 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -103,6 +103,9 @@ ambiguous but exists on the 'origin' remote. See also
 `checkout.defaultRemote` in linkgit:git-config[1].
 +
 `--guess` is the default behavior. Use `--no-guess` to disable it.
++
+The default behavior can be set via the `checkout.guess` configuration
+variable.
 
 -f::
 --force::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0951f8fee5..0c0394a0d6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1093,11 +1093,16 @@ static int switch_branches(const struct checkout_opts *opts,
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
+	struct checkout_opts *opts = cb;
+
 	if (!strcmp(var, "diff.ignoresubmodules")) {
-		struct checkout_opts *opts = cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.guess")) {
+		opts->dwim_new_local_branch = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8be4a0316e..851c358cfc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1467,14 +1467,15 @@ _git_bundle ()
 # Helper function to decide whether or not we should enable DWIM logic for
 # git-switch and git-checkout.
 #
-# To decide between the following rules in priority order
-# 1) the last provided of "--guess" or "--no-guess" explicitly enable or
-#    disable completion of DWIM logic respectively.
-# 2) If the --no-track option is provided, take this as a hint to disable the
-#    DWIM completion logic
-# 3) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
-#    logic, as requested by the user.
-# 4) Enable DWIM logic otherwise.
+# To decide between the following rules in decreasing priority order:
+# - the last provided of "--guess" or "--no-guess" explicitly enable or
+#   disable completion of DWIM logic respectively.
+# - If checkout.guess is false, disable completion of DWIM logic.
+# - If the --no-track option is provided, take this as a hint to disable the
+#   DWIM completion logic
+# - If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
+#   logic, as requested by the user.
+# - Enable DWIM logic otherwise.
 #
 __git_checkout_default_dwim_mode ()
 {
@@ -1485,11 +1486,17 @@ __git_checkout_default_dwim_mode ()
 	fi
 
 	# --no-track disables DWIM, but with lower priority than
-	# --guess/--no-guess
+	# --guess/--no-guess/checkout.guess
 	if [ -n "$(__git_find_on_cmdline "--no-track")" ]; then
 		dwim_opt=""
 	fi
 
+	# checkout.guess = false disables DWIM, but with lower priority than
+	# --guess/--no-guess
+	if [ "$(__git config --type=bool checkout.guess)" = "false" ]; then
+		dwim_opt=""
+	fi
+
 	# Find the last provided --guess or --no-guess
 	last_option="$(__git_find_last_on_cmdline "--guess --no-guess")"
 	case "$last_option" in
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index accfa9aa4b..a4f8d3a67e 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -166,6 +166,17 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
 	test_branch master
 '
 
+test_expect_success 'checkout.guess = false suppresses branch auto-vivification' '
+	git checkout -B master &&
+	status_uno_is_clean &&
+	test_might_fail git branch -D bar &&
+
+	test_config checkout.guess false &&
+	test_must_fail git checkout bar &&
+	test_must_fail git rev-parse --verify refs/heads/bar &&
+	test_branch master
+'
+
 test_expect_success 'setup more remotes with unconventional refspecs' '
 	git checkout -B master &&
 	status_uno_is_clean &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 2c1b8c0d6d..68c9101b02 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -85,9 +85,12 @@ test_expect_success 'switching ignores file of same branch name' '
 	test_cmp expected actual
 '
 
-test_expect_success 'guess and create branch ' '
+test_expect_success 'guess and create branch' '
 	test_when_finished git switch master &&
 	test_must_fail git switch --no-guess foo &&
+	test_config checkout.guess false &&
+	test_must_fail git switch foo &&
+	test_config checkout.guess true &&
 	git switch foo &&
 	echo refs/heads/foo >expected &&
 	git symbolic-ref HEAD >actual &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..2b469a71ca 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1360,6 +1360,58 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	EOF
 '
 
+test_expect_success 'git checkout - with checkout.guess = false, only completes refs' '
+	test_config checkout.guess false &&
+	test_completion "git checkout " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with checkout.guess = true, completes refs and unique remote branches for DWIM' '
+	test_config checkout.guess true &&
+	test_completion "git checkout " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --guess overrides previous checkout.guess = false, complete refs and unique remote branches for DWIM' '
+	test_config checkout.guess false &&
+	test_completion "git checkout --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --no-guess overrides previous checkout.guess = true, complete only refs' '
+	test_config checkout.guess true &&
+	test_completion "git checkout --no-guess " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'git switch - with --detach, complete all references' '
 	test_completion "git switch --detach " <<-\EOF
 	HEAD Z
-- 
2.28.0.942.g77c4c6094c

