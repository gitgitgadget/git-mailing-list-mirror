Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9736FC433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 19:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbhL3T1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 14:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbhL3T06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 14:26:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DFC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k18so15485625wrg.11
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rnYm7CxWvs6cRjNeHSzf0xUTQrqs5MiILUgmKu+cltA=;
        b=LjD6/z4xtRScM8ISxqDOF9meXetPpJpTJ/BEuntlQzSiLHKrruPOPbBpZBM1aBex+V
         fQeguAlL55G1kj5VMtKJxzLtnQUJ0avXhaHmYZUk4D1AcUcMW6x6M8XIwG6GG+d8JSEk
         JvsKUEsJoEX+LFLwUMmgG2UU0d9MJg4gZeCKSA+R9GvcLYZDTFEmDRhSbfpiMZVVBCF/
         YegV8XmjrK3PEKMvoA1nq6XF2Twq74mFaME0P9bKxGN4eDod8gDRNLzR9XDmWi9fhhU2
         zmuO0PaEuZ1R/35ULMxl0tkM+6cZiEbyyaK+TEMhyAPPVYn7PWhKI8qQMlFKh9TAzuMq
         dmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rnYm7CxWvs6cRjNeHSzf0xUTQrqs5MiILUgmKu+cltA=;
        b=Rv95XV3TUyTeWqingAqg2SV6LzcWI9IgwA1FX1aiAn9fgnCwJU9kCB+kXch9KDm3b7
         O5OokCDRgAEta6oDSSCMg+Uoyb7mD+919vtcMyQPP3DC/itEGcRRiFyAm5IM6d9t850R
         rd/xsqHqOW0032JV4Ppf8n8v9P/SgAOgSFwt6DtPrGzH3bj3s1L1eVNzDMPEuBmY5IUp
         ww7jyyU8XfcMxfuzTgb5A/36I3lBuGgAaRUVDl6lz47totODY0YJmKy4PYh+oBc38gFf
         3y6gZnPXuzFejed1NEuwKa8r+tA9HH9MEiogbnTupTZbXmbgja6ENH7C4XYrc9+G4BSz
         t3cA==
X-Gm-Message-State: AOAM533JNR6OCugPMseyolcg1cFiDl1x5rDPfPFVLKm64H3CJVuqiPul
        +Kr/IekWLxknuEC5HPLkvZqPbAhoJ1Q=
X-Google-Smtp-Source: ABdhPJyMhoLw0dMpAQXtVmnPwilb9o0J/WHYjHOrSKNhRfeHVtY/M7fE6LhFOrLl/+SoRJ16oIeGcQ==
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr25294243wrd.682.1640892416411;
        Thu, 30 Dec 2021 11:26:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25sm23788737wmh.18.2021.12.30.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:26:56 -0800 (PST)
Message-Id: <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
        <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 19:26:53 +0000
Subject: [PATCH v2 2/2] sparse-checkout: custom tab completion
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
 contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
 t/t9902-completion.sh                  |  8 +++---
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c82ccaebcc7..7de997ee64e 100644
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
+	case "$prev" in
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
