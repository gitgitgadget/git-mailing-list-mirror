Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB80C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 03:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356793AbiBDD0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbiBDD0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 22:26:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E5C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 19:26:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r7so3545373wmq.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 19:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kfjm3zJOq+CKjY/azyHketm8Vi4rpBV82/Qd6itdo+w=;
        b=f7CqU0DB0IeF7D/vwDj0wQBDkXCjqDV7A75jVmE4g3ys2U4T/NuIZ14B9jtGknEtfs
         Eyj7Txs41Vd+zyS6ifTk7RZ7xYRbkVLnpZr9CYnSkzgpwvumKet9gLZ2AGjiFupppTpe
         PYXC4RN0jeTk2LwZ+f+Uh/UW3Kz1gdN7iKVZ5lgFTTCCMx5izgwCZ+DGHcvuoEepsnNz
         hxRR3e9xImpRA6vlGA/oF8vWNE0olOasfbWe36rbLPgS9evwNXV8bpyAmYDGREK5ntER
         PPsmtkEEs+YoljoLOOp7ilZtNFn09xrOGF/KLUZPz/41+bvfejMSTF9vOBiM1OxzqPM7
         OB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kfjm3zJOq+CKjY/azyHketm8Vi4rpBV82/Qd6itdo+w=;
        b=JiyMm4PhhUuLYG01S7AX/rvMFNOIste7bKNcpkfg22ncXjp8puZld4RsGzZc+qJnqs
         QASNZXfNAh1HxbghhTQ6IC76R3w6PSo63VYfuzA4jszent87yTTjpylNsAjRkFN4gfYn
         RL+4IZAP4itxooi3unCS82ScRnmMZBrxiDJjGKquPtWrGaCtzZdMLCU2Hq27Iy6cNWsE
         eRxf9CIpnd2wdYV/x5D6rVdh3isVpg0GXl6Yycm2KQl4S+TcTJR34FOdzNVFPC33J0Ro
         3MyW7BF/lEUL/s8jc5XZld8BKXJyKKoQWksnD4VjlPUqz9LT83UE4kp2JC9ixh5UGqNT
         2LTA==
X-Gm-Message-State: AOAM532MCwUyst9UDTPHvUHppRPWR6WVXnWFEpmlGlLB9RXdbLtBQwwK
        zF1sFjaM/Neio+It5wr8cZjKp7w5ZyY=
X-Google-Smtp-Source: ABdhPJxiOCCLMB876t5uUIVR0pHmab0Phjj5v1XKMqw09M0CY1g2Qtk5F8Q83qaGDSJ6xj46vmiqhA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr513582wmj.77.1643945200071;
        Thu, 03 Feb 2022 19:26:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm607310wrg.60.2022.02.03.19.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:26:39 -0800 (PST)
Message-Id: <23390000dd31b38a8a7711cc300b0f7fc192a824.1643945198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Feb 2022 03:26:36 +0000
Subject: [PATCH v6 1/3] completion: address sparse-checkout issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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

