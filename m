Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF41EC4332F
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiBGRpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355828AbiBGRcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 12:32:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C4C0401DF
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 09:31:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so7430290wrb.9
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y9pEqdJHX8Qi44UJwJPMvieLjxpez4B5c/alq0PRzBo=;
        b=L680iJ3XV4B9X3Pj5vXgzbFpoOFY/m/CBboBqNLBzoqqx+KGXO3a0cWB3VrBruudCF
         d0g8wfncPWeOzYM6RZg4OKmxjb9166vnk0A2mW5ZEooh6VEyrNRTMe2ughsXNSg9JpE8
         u6NN7BAYUc3Nsumvk7TZWNRfQzpeQihVcVZF2cdsAq3DvmmxlTTdU/CfVPZfMvGm3LPu
         TbJQ2LTlattgHnijH1wOAYpbq3PYiDkMOcdmGA/xXwDPeaAALGdrsUnMKsK3vEhPOpG4
         RdVdtfrAmfsWyAs6seTvfRO9wsMJRR1TBh+Blrh3ndiFx0OdPwUGFpWEJyBUGov+RmXW
         x/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y9pEqdJHX8Qi44UJwJPMvieLjxpez4B5c/alq0PRzBo=;
        b=wUyiA2R8bmH3PUDWIF03hb55dxa/0Ik0yjI16rL3+C9UTrEKe8KAK9h/t6k9hDv2lW
         R2/6kFonbKrOGW2duGf0CFYayAvQscGKOtRnl5n6rO/cKiHfY5j312fva0oV/A3P6DFT
         rTQ346/obBkgA0wx3GtlwMgP6fpcp6sZ87j/I8Z9NHezU/UPw2Fqyu0Lf9V/P3LIPKXI
         X5GEY6ssmcPWmcYJvLhJhncOB7lulIBV8G4LYVBWZPUKGz6MpZRDDrsiMC5Simr9EVAd
         zl3uh+6g7XmDZSBhvEDQF9ZOkPvFQoxw8F8uV+mLzk12bNyzng2YNEDvSfiqMmnJ1KXA
         cv9w==
X-Gm-Message-State: AOAM5326OMJiVpsGhgzhX9hITR0XTJb4FO38tK1CQccXgY/MuuXeKo6s
        8L1vPUZwH7wokzjXWFQ2tZMr4JunhtQ=
X-Google-Smtp-Source: ABdhPJyDtpJ8U1ykV/7laz9SnsRP7gvx37aNZ2G4JLPqXST7VI+xG3ocLGzlmky5L4uVFd+Pzo46dA==
X-Received: by 2002:a05:6000:1b8a:: with SMTP id r10mr381682wru.665.1644255108138;
        Mon, 07 Feb 2022 09:31:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm10577489wrs.1.2022.02.07.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:31:47 -0800 (PST)
Message-Id: <26422c759a018262dd0095817d7d67e1e39908fe.1644255105.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
        <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 17:31:43 +0000
Subject: [PATCH v7 1/3] completion: address sparse-checkout issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Correct multiple issues with tab completion of the git sparse-checkout
command. These issues were:

1. git sparse-checkout <TAB> previously resulted in an incomplete list of
subcommands (it was missing reapply and add).
2. Subcommand options were not tab-completable.
3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> showed
both file names and directory names. While this may be a less surprising
behavior for non-cone mode, cone mode sparse checkouts should complete
only directory names.

Note that while the new strategy of just using git ls-tree to complete on
directory names is simple and a step in the right direction, it does have
some caveats. These are:

1. Likelihood of poor performance in large monorepos (as a result of
recursively completing directory names).
2. Inability to handle paths containing unusual characters.

These caveats will be fixed by subsequent commits in this series.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++---
 t/t9902-completion.sh                  | 83 ++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c82ccaebcc7..7f6c86dc6c0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2988,7 +2988,7 @@ _git_show_branch ()
 
 _git_sparse_checkout ()
 {
-	local subcommands="list init set disable"
+	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2996,14 +2996,14 @@ _git_sparse_checkout ()
 	fi
 
 	case "$subcommand,$cur" in
-	init,--*)
-		__gitcomp "--cone"
-		;;
-	set,--*)
-		__gitcomp "--stdin"
-		;;
-	*)
+	*,--*)
+		__gitcomp_builtin sparse-checkout_$subcommand "" "--"
 		;;
+	set,*|add,*)
+		if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
+		[ -n "$(__git_find_on_cmdline --cone)" ]; then
+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+		fi
 	esac
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe07..f6eeb9aa035 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,6 +1447,89 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_success 'setup sparse-checkout tests' '
+	# set up sparse-checkout repo
+	git init sparse-checkout &&
+	(
+		cd sparse-checkout &&
+		mkdir -p folder1/0/1 folder2/0 folder3 &&
+		touch folder1/0/1/t.txt &&
+		touch folder2/0/t.txt &&
+		touch folder3/t.txt &&
+		git add . &&
+		git commit -am "Initial commit"
+	)
+'
+
+test_expect_success 'sparse-checkout completes subcommands' '
+	test_completion "git sparse-checkout " <<-\EOF
+	list Z
+	init Z
+	set Z
+	add Z
+	reapply Z
+	disable Z
+	EOF
+'
+
+test_expect_success 'cone mode sparse-checkout completes directory names' '
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set f" <<-\EOF
+		folder1 Z
+		folder1/0 Z
+		folder1/0/1 Z
+		folder2 Z
+		folder2/0 Z
+		folder3 Z
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout/folder1 &&
+		test_completion "git sparse-checkout add " <<-\EOF
+		./ Z
+		0 Z
+		0/1 Z
+		EOF
+	)
+'
+
+test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
+	# reset sparse-checkout repo to non-cone mode
+	git -C sparse-checkout sparse-checkout disable &&
+	git -C sparse-checkout sparse-checkout set --no-cone &&
+
+	(
+		cd sparse-checkout &&
+		# expected to be empty since we have not configured
+		# custom completion for non-cone mode
+		test_completion "git sparse-checkout set f" <<-\EOF
+
+		EOF
+	)
+'
+
+test_expect_success 'git sparse-checkout set --cone completes directory names' '
+	git -C sparse-checkout sparse-checkout disable &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set --cone f" <<-\EOF
+		folder1 Z
+		folder1/0 Z
+		folder1/0/1 Z
+		folder2 Z
+		folder2/0 Z
+		folder3 Z
+		EOF
+	)
+'
+
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-- 
gitgitgadget

