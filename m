Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87562C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiAJS77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242874AbiAJS76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:59:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354DC061748
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso30339wmj.2
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hhIqvC9sJFEsBl8Lct3shZ3908Tg49/z/bVPqz9CA0U=;
        b=K/5chL3l592S4BE3W7uiU5hWgDvcVWT7SlXkNoFX4c6DHR8rUyTCz52lQgMPScv+xp
         2xQHEyGBabDmsbZuo4fjs5FQyiLFeUchSK1x+b9SGKpRrDbn6Nu0Weh6Y45QvSqBZiT7
         8LAwz2usbUcZI3ZVTNyJj94tl9PunTlQF5QehoJzvnPRjbGgMGm/czXwXkiN5t+kwYVf
         38qf1cncTiQ66GPb1252xKfs4anpk0KQfKKwONLAVCmOlCG5IDYn8RvssWnrDLjHRZ+F
         RkjFVyGUPFyrCqTIxLiyCJ8CcTcf+iLdtAagy96pX8a5nU/2AeSaUxfSpVs7uPUD0hwf
         Wc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hhIqvC9sJFEsBl8Lct3shZ3908Tg49/z/bVPqz9CA0U=;
        b=70MLapuZOQJyhZR3IBlt1Cjkqa45VoWuYftuQcD3vKlcpv26kywdL55PfWq1OKApu2
         oxIqRmPNaUx2UHumwkotA9gP470eePwh1AqnveZIj2Q7vmEe5ukpA7/9gkbc5vGu7a4T
         76RuEApzNvT8PSq0bwxpVXF4UDO+SeA1NBNba7gl6czUcn1iKP2t5f748s3k4hBy6TNv
         lcs95e7pXc+Q1lNInhBNnIAvjNsqZl2CmkoMuwdneNgzh5omWK4TPe0vwyvdZw2KVlwU
         wLIpeEAdMbAwEO8NKsM95A4k59Q7AhEZj+lw7Cf3RaElZmd5HCV83SaDPwlnr3dcOzJ6
         a7FQ==
X-Gm-Message-State: AOAM531GIRs+6JtWWquNnIOY8glraHr/RjwShUA7ODeMrkrECiPyl1Lm
        g3FOtm0iwioQLdCkAuN0zuaBpIFdq6M=
X-Google-Smtp-Source: ABdhPJxpCmLu45TjB/pJIaAml7/0Bzjsn503Qr27YVuyK7pW4a5uNOAkNdaycKJpQF64UkWtVzvskA==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr22986686wmq.154.1641841196347;
        Mon, 10 Jan 2022 10:59:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm7433028wmq.31.2022.01.10.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:59:56 -0800 (PST)
Message-Id: <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Jan 2022 18:59:51 +0000
Subject: [PATCH v3 2/3] sparse-checkout: custom tab completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
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
sparse-checkout add <TAB> or git sparse-checkout set <TAB>. It is
important to note that this will apply for both cone mode and non-cone
mode (even though non-cone mode matches on patterns rather than
directories).

Failing tests that were added in the previous commit to verify these
scenarios are now passing with these updates.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
 t/t9902-completion.sh                  |  8 +++---
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c82ccaebcc7..f478883f51c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,24 +2986,38 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
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
+	case "$subcommand" in
+		set)
+			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			;;
+		add)
+			__gitcomp "--stdin"
+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			;;
+		init|reapply)
+			__gitcomp "$__git_sparse_checkout_subcommand_opts"
+			;;
+		*)
+			;;
 	esac
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 51d0f2d93a1..4dc93ee0595 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,7 +1447,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes subcommands' '
+test_expect_success 'sparse-checkout completes subcommands' '
 	test_completion "git sparse-checkout " <<-\EOF
 	list Z
 	init Z
@@ -1458,13 +1458,13 @@ test_expect_failure 'sparse-checkout completes subcommands' '
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
 	--no-cone Z
@@ -1492,7 +1492,7 @@ test_expect_failure 'sparse-checkout completes subcommand options' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes directory names' '
+test_expect_success 'sparse-checkout completes directory names' '
 	# set up sparse-checkout repo
 	git init sparse-checkout &&
 	(
-- 
gitgitgadget

