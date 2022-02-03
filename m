Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918ADC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354772AbiBCUrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356602AbiBCUq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C08C0619C3
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 12:44:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso8042679wma.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lF5bJw4lfdWtLjCxhhN+2Fi3uMYW1nDeZDBrNqd4Rvo=;
        b=p89YuWsnFQxkEeRwsBr+o7GHC3eka/WJF7HVMg+HWyYOk4p54EXoS+tMSAHka1s9z5
         w33axPCVLiTgWk2lQZkYfxqeepUA6+C62m2+y5fPiVC1ynjBu+7TkRUP4TxxMqbQr6g8
         vCSl6AP7o53A5h8zg/srNoxF8HTMbdGPoNEoRqfxqePiSfrs8HsH9hJoJklOFN2f6TtZ
         GY5OsXLfKfVUIeEo8if9wD4gr0KACt70ms/E23fEcU9jvpChA4PG1T2laNFouD0cqOB7
         f34xZ8JX6V2JhrMKpf00vNudsMqK90fNH5cBpZJ8994xClJPfbb/9VhzcJgzKRmqEhQA
         /y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lF5bJw4lfdWtLjCxhhN+2Fi3uMYW1nDeZDBrNqd4Rvo=;
        b=oxf1IiCSOya4IuYYhddNLujMTHsB39emH2vqC+c2DZgF4zJri4ZhrQOp+7dDj8p3ht
         wwvyUMYkg2Zk62V/3g1NghejERRQETLaKUszSzQg2zd3/iiaPEWtgp7DA5FM7XbkNG1A
         7AmdzIoESXZBE0Qhl9+eP9nacPnTBJUUz9O8TM4mB6KSdirKOGWVig+AVte299nEOm15
         RKHX+x7oatVybPDCmq0xZppdPTJfX2t0hBZDMeWppK6Bm/pdmbuuukdOUWD/39q24BBJ
         b7ieAUavRBFKhR/AQvqgGdE/BlG8YEyfxdiSrA11OaO5z8CkAJCIKmY4ftjHsvYaqj/A
         lwxQ==
X-Gm-Message-State: AOAM533xpR5K6AcKhn6zL9WfH7s1+HfO3KjbpaIcUGejNrca9rBSHxPs
        NHVDU+D4U7B7q6/JPjnZbBvRgHNVw2g=
X-Google-Smtp-Source: ABdhPJxCwSl/nKMkpWlY6bGPU8C3oqx1Vfeus1ZhJWNX9d6tJ2ZEy07jYrv/vWxCEILiJj1YLNREcw==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr12292125wmi.139.1643921093052;
        Thu, 03 Feb 2022 12:44:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm21191743wre.83.2022.02.03.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:44:52 -0800 (PST)
Message-Id: <a1c46c763fd4c832a6784e2a368199efedce17e9.1643921091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 20:44:49 +0000
Subject: [PATCH v5 1/3] completion: address sparse-checkout issues
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
index c82ccaebcc7..2976f63747f 100644
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
+		if [ $(__git config core.sparseCheckoutCone) ] ||
+		[ "$(__git_find_on_cmdline --cone)" ]; then
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

