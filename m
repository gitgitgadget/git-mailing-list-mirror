Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE8C4332F
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiA0VWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbiA0VWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:22:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED8C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so7027140wrg.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8YyHqO8/eWWBYUcmf9+spwTt+AfR9s7a6T0/n6ElNU4=;
        b=qeUCNdOrNApe3WNzaj5rnBrzh3ssCtZ9xXuHg6mXYE+SQb0NcWiU/pBkwfSH3bgGob
         PYmnIm74JxEylQGjaITZ6WG261hsCD3KE4RUllfV4PikxzkTyAE6l5YAvyCuDsmu9aXm
         M3c9J5XKdLpSKb1RQrTWxzI2rFbFwhePktJ5dEZ1SxfGN9s1ruxPXn0KE2C+BX7za2c4
         YJ9yz+J4eHu013U3ybS1DB959KjeJ7tldFdHg52ScfFeE4mFbbHsF5cobXM2GLpGTxsI
         6ATrj7JesmtnQ3t4L1h2KMobZc3Z4XXP8jplKGc/Dv3uR/sj6TA2bNSTYtDWEJ0vCHwr
         8iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8YyHqO8/eWWBYUcmf9+spwTt+AfR9s7a6T0/n6ElNU4=;
        b=Q6vV5ZtLbO/JIEGINc37xiO0/B83CLZWt0jJjkhCpaYnq6VYsNhZZX9RY3AGxcDTtS
         nOwAKQDrxNzGwqApCI6CaXq89Tkp4X/TPc+QBTY24ydQDUKdh0N0jhtMfUUMgw85AkFB
         nh6xzQLJHGtu7+rCWb+/bC92/DzK4E8IR1occVHT/hfUsn/1U8SH2G5eraovfXed3zEA
         MLw+lXILpGV21CuBVbGnUOJPXBx1PsyrHTULKH0Crce9KUbWfm5tH7KYASq2oDqNX7YP
         iZu1wJWfSRyECAR5U6WfSezwUWqhz4v2Y2XdIr4FBwW29ih6tEeKq12RrzlPnqey5c4Y
         DDqA==
X-Gm-Message-State: AOAM530Qjh2HCAw7a+4aNOFQvww+bHYcqa2M7KVFjK1j2phUYXs46G5W
        pQpma0xriH6o0AfKnngVHvPLbiTVFWg=
X-Google-Smtp-Source: ABdhPJwczXi+JSGstTaLVVwFf7a5uMM28BP6/8BZkFx8Rn/l9Jrlh0baL6gRmHTcCMKssjtQcjr1Mg==
X-Received: by 2002:adf:f88e:: with SMTP id u14mr4420749wrp.406.1643318518035;
        Thu, 27 Jan 2022 13:21:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm340071wmr.3.2022.01.27.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:21:57 -0800 (PST)
Message-Id: <760cae85bd4163d9cbef1585186cda60c8c3b35b.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 21:21:54 +0000
Subject: [PATCH v4 3/3] completion: ensure cone mode completion with multiple
 <TAB>s
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

Ensure users in a cone mode sparse checkout can tab-complete to
directories at multiple levels with multiple <TAB>s. For example, if path
a/b/c/ exists in the current directory, running a<TAB>b<TAB> will result
in:

        a/b/c/

The 'sparse-checkout completes directory names' test has also been
updated with trailing slashes according to these changes.

Co-authored-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 33 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 12 +++++-----
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a920cdab201..defcc8560c1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,11 +2986,40 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+__gitcomp_directories ()
+{
+     local _tmp_dir _tmp_completions
+
+     # Get the directory of the current token; this differs from dirname
+     # in that it keeps up to the final trailing slash.  If no slash found
+     # that's fine too.
+     [[ "$cur" =~ .*/ ]]
+     _tmp_dir=$BASH_REMATCH
+
+     # Find possible directory completions, adding trailing '/' characters
+     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
+         sed -e s%$%/%)"
+
+     if [[ -n "$_tmp_completions" ]]; then
+         # There were some directory completions, so find ones that
+         # start with "$cur", the current token, and put those in COMPREPLY
+         local i=0 c IFS=$' \t\n'
+         for c in $_tmp_completions; do
+             if [[ $c == "$cur"* ]]; then
+                 COMPREPLY+=("$c")
+             fi
+         done
+     elif [[ "$cur" =~ /$ ]]; then
+         # No possible further completions any deeper, so assume we're at
+         # a leaf directory and just consider it complete
+         __gitcomp_direct_append "$cur "
+     fi
+}
+
 _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
-
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
@@ -3002,7 +3031,7 @@ _git_sparse_checkout ()
 		;;
 		set,*|add,*)
 			if [ $(__git config core.sparseCheckoutCone) ]; then
-				__git_complete_index_file "--directory"
+				__gitcomp_directories
 			fi
 		;;
 	esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f56ba3f64c9..c04fc25fa32 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1478,30 +1478,30 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set f" <<-\EOF
-		folder1
-		folder2
-		folder3
+		folder1/
+		folder2/
+		folder3/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set folder1/" <<-\EOF
-		folder1/0
+		folder1/0/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
-		folder1/0/1
+		folder1/0/1/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout/folder1 &&
 		test_completion "git sparse-checkout add 0" <<-\EOF
-		0
+		0/
 		EOF
 	)
 '
-- 
gitgitgadget
