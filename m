Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C2C433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhL3Acg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 19:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhL3Acg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 19:32:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034EC06173E
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w20so38312994wra.9
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cH2tTi1N3mzbOAPYpu3j5mvS47tjyIO90aY+C/fpb3c=;
        b=m+7GWph3mRfvF55pS3hCe/HwEYgxJorPJ62KzZHQb1OQqNC/L9li948533w3KbDJqx
         3Dlp8nXcfnfr7xKZqMYAZ/Q4pRg+O9TSEJ77xuhGi1Amh6PpT2E4Da20PwN2ROoLpCXx
         /1zPNkjGcAx0rpcRArL/E0gA70K3QXDwJIt5lnFEYP3KJKY0lcOMgYkNihzXbqx8znJE
         UW2au5pO5w3bDLPr+A9qUb4uPwmruuFMROcbtaiGqRT2q0yHrJ3XnQd4guVZPbFV8Wa/
         doBMJpZWf598E5B8FjtqNkzvI3i6dUKTfr7f10GFJx1B/RueYEQjwbUPwQ/o2n+z94+V
         b2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cH2tTi1N3mzbOAPYpu3j5mvS47tjyIO90aY+C/fpb3c=;
        b=jYg901sXaQo43miW2CIum6ZrwCfad3OoEGraw9oA4CAd72NEEIoUUgQ3G0E6R3Fzmy
         dCXZFbBXD/ALwnXW2HbXAgSrCAtazn4uNHgk+8lbHtUd7x7hBW1E3TAldK/HaQiPuJbB
         q3vc29OQ6OlOLlHK1oTb8AQqCHgqlNZmc7hvYY3bxVMz6YNPnxbafWm9KXz+3bcvHRMN
         sp8qQe+vbzz7F1dZke72Ka/OdYsdEOu7GvX6t8bWFDo22N1D6n045/tq7ITJnprBW+Bo
         z+gQ2Vi6OMBZhfFewNFOGHDx3ia3MWYc+ulD01mXuT15cpS7WmqKqnL6KIdCJf9BJzVl
         yiog==
X-Gm-Message-State: AOAM532mI6fAfUVQzFZvmY1+xcCernp4Fs+0CheUgcWYaDEQ4nMHKlc2
        D9plKz8PFtCeOpG6ANJMbHPoESTGqJQ=
X-Google-Smtp-Source: ABdhPJz+0yBhrG9eQoj5MIkDm5xlkSKNGEyjS4IKD0Jp4EfIZiGVDEhxK/8RMZDC3fINsb9qRGUpkw==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr21891123wrq.708.1640824354254;
        Wed, 29 Dec 2021 16:32:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm22318580wrw.11.2021.12.29.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 16:32:33 -0800 (PST)
Message-Id: <ab51236d18ce10ada89e8cde85f678130a0ab1fd.1640824351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 00:32:31 +0000
Subject: [PATCH 2/2] sparse-checkout: custom tab completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Fix custom tab completion for sparse-checkout command. This will ensure:

1. The full list of subcommands is provided when users enter git
sparse-checkout <TAB>.
2. The --help option is tab-completable.
3. Subcommand options are tab-completable.
4. A list of directories (but not files) is provided when users enter git
sparse-checkout add <TAB> or git sparse-checkout set <TAB>.

Failing tests that were added in the previous commit to verify these
scenarios are now passing with these updates.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 34 +++++++++++++++++---------
 t/t9902-completion.sh                  |  8 +++---
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 377d6c5494a..b8f1caece83 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,24 +2986,34 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+__git_sparse_checkout_init_opts="--cone --sparse-index --no-sparse-index"
+
 _git_sparse_checkout ()
 {
-	local subcommands="list init set disable"
+	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+
 	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
-		return
+		case "$cur" in
+			--*)
+				__gitcomp "--help"
+				;;
+			*)
+				__gitcomp "$subcommands"
+				;;
+		esac
 	fi
 
-	case "$subcommand,$cur" in
-	init,--*)
-		__gitcomp "--cone"
-		;;
-	set,--*)
-		__gitcomp "--stdin"
-		;;
-	*)
-		;;
+	case "$prev" in
+		init)
+			__gitcomp "$__git_sparse_checkout_init_opts"
+			;;
+		add|set)
+			__gitcomp "--stdin"
+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			;;
+		*)
+			;;
 	esac
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 22271ac2f3b..9f6eb06fbab 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1444,7 +1444,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes subcommands' '
+test_expect_success 'sparse-checkout completes subcommands' '
 	test_completion "git sparse-checkout " <<-\EOF
 	list Z
 	init Z
@@ -1455,13 +1455,13 @@ test_expect_failure 'sparse-checkout completes subcommands' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes options' '
+test_expect_success 'sparse-checkout completes options' '
 	test_completion "git sparse-checkout --" <<-\EOF
 	--help Z
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes subcommand options' '
+test_expect_success 'sparse-checkout completes subcommand options' '
 	test_completion "git sparse-checkout init --" <<-\EOF &&
 	--cone Z
 	--sparse-index Z
@@ -1477,7 +1477,7 @@ test_expect_failure 'sparse-checkout completes subcommand options' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes directory names' '
+test_expect_success 'sparse-checkout completes directory names' '
 	# set up sparse-checkout repo
 	git init sparse-checkout &&
 	(
-- 
gitgitgadget
