Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A8C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 17:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiBGRpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355684AbiBGRcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 12:32:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CDDC0401E3
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 09:31:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k1so9626138wrd.8
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xQ/TgB7GjzfHsD4GsMvpIT3cyPnGIu743mjdX+vo0gE=;
        b=bw2iJZuMTzwP3BZrQOwnGHriz8NU89w4q0iH/XSmbxMP5gRHbieRKUOz4KelcgV2NK
         XWjWeHnkFFCvDAcO0yiEULHsyCDPNgkFOMoRBs1vVo2APTTSDZcnR5AfhfKfcgNt5TYt
         ZXAOeO70PMdGSpc8zFDxqBAlr1zEtgEkkqjNYTxLOlY9uc99aT6GhJzh3fmBCnMHbQAL
         t1p67X4BA/ld39GUjWt5nAnSi7+Qbak5XYeGv6//JeoB5vmtbEB5Huxkqh3i1Uh2QkmW
         DESz6aj9OphCbh9aKkEYrAIAKmuXTkz4uFeMJL8Pw5lL6/JPrcfttS7SbBs4b/qoL3Ay
         t/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xQ/TgB7GjzfHsD4GsMvpIT3cyPnGIu743mjdX+vo0gE=;
        b=eMJp4CxTp0evcdWJldEmzwooPTclZlJYMihWTnUX4LO1j6xlNmDQY0+V5kIatb1pUm
         zi7YAgkEER8swNtQ6ub3wrXJ9BJ2i+1AW6zxyLuq2A39B5qEWeRk3rfDteaslci7wv0h
         AB8WYWsYx5uM5k1mFy7iFt7x7b4RhNEkzVG/9RfWYikhbCwxTxyMaWmCPE8WxiFy8z77
         WBQUwtgLtAf9MLQ5JPhYcnFpQoJCYl/Pfy6EcNRXjE+rYw2/x5D2K3iXOLA63JnUAfsQ
         /fm2OtLBvD1DSIveZqRejZutLqhDocF6BnHOv80LKpA1ZiZmA1gvR3qqtmx+FMm7xf1b
         7szw==
X-Gm-Message-State: AOAM530pMIZaUcpG2sWQ3AYExrOfos6EIqkgjqOYKvxEMcVTY8jm8W0Z
        40BBYaCZi/qPFz4SaD5r2ngr0o1qI0Q=
X-Google-Smtp-Source: ABdhPJwi+hrBV3s08KTSBMGYNbGoNAq+fm3wnTot5boTbAsbnHx2xCg7/cmc3e79qPFx4TNWx7p0yQ==
X-Received: by 2002:a05:6000:1e1b:: with SMTP id bj27mr394635wrb.385.1644255106924;
        Mon, 07 Feb 2022 09:31:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm672308wmq.0.2022.02.07.09.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:31:46 -0800 (PST)
Message-Id: <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 17:31:42 +0000
Subject: [PATCH v7 0/3] completion: sparse-checkout updates
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change updates custom tab completion for the sparse-checkout command.
Specifically, it corrects the following issues with the current method:

 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
    (it is missing reapply and add).
 2. Options for subcommands are not tab-completable.
 3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
    both file names and directory names. While this may be a less surprising
    behavior for non-cone mode, we want to only show directories in cone
    mode.

The first commit in this series is an intermediate step that fixes issues 1
and 2 above and introduces a simple fix for issue 3 with some performance
and unusual character-related caveats. The next commit adds a new
__gitcomp_directories method that fixes the performance-related caveat from
the first commit by completing just a single level of directories. The final
commit modifies __gitcomp_directories to handle unusual characters in
directory names.


Changes since V6
================

 * Split tests for unusual characters so that spaces and accents are
   verified on Windows (in addition to macOS and Linux). Tabs and
   backslashes are still excluded on Windows (details on why are included in
   the third commit message).


Changes since V5
================

 * Fix incorrect conditional that was causing failure of non-cone mode test
   (and causing 'seen' CI to fail).
 * Remove __git_comp_directories indentation changes between the second and
   third commits.


Changes since V4
================

 * Clarify that completing on files and directories is a less-surprising
   behavior in non-cone mode (rather than definitely the correct behavior)
   in commit message and cover letter.
 * Add explicit --no-cone to non-cone mode sparse-checkout completion test.
 * Replace use of __git_complete_index_file with a new version of
   __gitcomp_directories that is able to handle unusual characters.
 * Ensure that users running git sparse-checkout set --cone get cone
   mode-style completion whether or not they already have the cone mode
   config set.
 * Refactor creation of sparse-checkout test repo into a sparse-checkout
   setup test.


Changes since V3
================

 * Update commit descriptions to begin with completion instead of
   sparse-checkout.
 * Remove explicit completion of --help, as this is inconsistent with the
   rest of the completion script.
 * Use __gitcomp_builtin to auto-complete subcommand options (and remove
   option completion test from previous iterations, as it is no longer
   necessary).
 * Use __git_complete_index_file helper function in place of __gitcomp
   "$(git ls-tree -d -r HEAD --name-only).
 * If in cone-mode sparse checkout, only show directory completions. If in
   non-cone mode sparse checkout show both files and directories.


Changes since V2
================

 * Change use of $prev to $subcommand in _git_sparse_checkout() method in
   git-completion.bash.
 * State explicitly that directory completion applies in both cone and
   non-cone mode in 'sparse-checkout: custom tab completion' commit
 * Add new patch with __gitcomp_directories method to improve performance by
   only outputting directories at the current level.


Changes since V1
================

 * Rebase onto en/sparse-checkout-set.
 * Add subcommand options (including --no-cone) for set and reapply.
 * Extend 'sparse-checkout completes subcommand options' test to validate
   new set/reapply subcommand options.
 * No longer set index.sparse to false in 'sparse-checkout completes
   directory names' test.
 * Refactor creation of sparse-checkout repo into a setup test.

Thanks, Lessley

Lessley Dennington (3):
  completion: address sparse-checkout issues
  completion: improve sparse-checkout cone mode directory completion
  completion: handle unusual characters for sparse-checkout

 contrib/completion/git-completion.bash |  44 ++++++--
 t/t9902-completion.sh                  | 138 +++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 8 deletions(-)


base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v6:

 1:  23390000dd3 ! 1:  26422c759a0 completion: address sparse-checkout issues
     @@ Commit message
          These caveats will be fixed by subsequent commits in this series.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: _git_show_branch ()
 2:  10a190ce6a1 ! 2:  2c20830b4ce completion: improve sparse-checkout cone mode directory completion
     @@ Commit message
          Co-authored-by: Elijah Newren <newren@gmail.com>
          Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: _git_show_branch ()
 3:  e805dbb58cc ! 3:  996cbe7dfb7 completion: handle unusual characters for sparse-checkout
     @@ Commit message
          subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
          logic was placed directly in the __gitcomp_directories method.
      
     +    Note there are two tests for this new functionality - one for spaces and
     +    accents and one for backslashes and tabs. The backslashes and tabs test
     +    uses FUNNYNAMES to avoid running on Windows. This is because:
     +
     +    1. Backslashes are explicitly not allowed in Windows file paths.
     +    2. Although tabs appear to be allowed when creating a file in a Windows
     +    bash shell, they actually are not renderable (and appear as empty boxes
     +    in the shell).
     +
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: _git_show_branch ()
     @@ t/t9902-completion.sh: test_expect_success 'cone mode sparse-checkout completes
       	)
       '
       
     -+# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes in paths
     -+test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with special characters' '
     ++test_expect_success 'cone mode sparse-checkout completes directory names with spaces and accents' '
      +	# reset sparse-checkout
      +	git -C sparse-checkout sparse-checkout disable &&
      +	(
      +		cd sparse-checkout &&
      +		mkdir "directory with spaces" &&
     -+		mkdir "$(printf "directory\twith\ttabs")" &&
     -+		mkdir "directory\with\backslashes" &&
      +		mkdir "directory-with-áccent" &&
      +		>"directory with spaces/randomfile" &&
     -+		>"$(printf "directory\twith\ttabs")/randomfile" &&
     -+		>"directory\with\backslashes/randomfile" &&
      +		>"directory-with-áccent/randomfile" &&
      +		git add . &&
     -+		git commit -m "Add directories containing unusual characters" &&
     ++		git commit -m "Add directory with spaces and directory with accent" &&
      +		git sparse-checkout set --cone "directory with spaces" \
     -+			"$(printf "directory\twith\ttabs")" "directory\with\backslashes" \
      +			"directory-with-áccent" &&
     -+		test_completion "git sparse-checkout add dir" <<-\EOF
     ++		test_completion "git sparse-checkout add dir" <<-\EOF &&
      +		directory with spaces/
     -+		directory	with	tabs/
     -+		directory\with\backslashes/
      +		directory-with-áccent/
      +		EOF
     ++		rm -rf "directory with spaces" &&
     ++		rm -rf "directory-with-áccent" &&
     ++		git add . &&
     ++		git commit -m "Remove directory with spaces and directory with accent"
     ++	)
     ++'
     ++
     ++# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes or tabs in paths
     ++test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with backslashes and tabs' '
     ++	# reset sparse-checkout
     ++	git -C sparse-checkout sparse-checkout disable &&
     ++	(
     ++		cd sparse-checkout &&
     ++		mkdir "directory\with\backslashes" &&
     ++		mkdir "$(printf "directory\twith\ttabs")" &&
     ++		>"directory\with\backslashes/randomfile" &&
     ++		>"$(printf "directory\twith\ttabs")/randomfile" &&
     ++		git add . &&
     ++		git commit -m "Add directory with backslashes and directory with tabs" &&
     ++		git sparse-checkout set --cone "directory\with\backslashes" \
     ++			"$(printf "directory\twith\ttabs")" &&
     ++		test_completion "git sparse-checkout add dir" <<-\EOF &&
     ++		directory\with\backslashes/
     ++		directory	with	tabs/
     ++		EOF
     ++		rm -rf "directory\with\backslashes" &&
     ++		rm -rf "$(printf "directory\twith\ttabs")" &&
     ++		git add . &&
     ++		git commit -m "Remove directory with backslashes and directory with tabs"
      +	)
      +'
      +

-- 
gitgitgadget
