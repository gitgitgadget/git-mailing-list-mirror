Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D177C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiBGRpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356064AbiBGRcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 12:32:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96241C0401DD
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 09:31:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so26091635wrg.12
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7s9SOp4oA+tWD/gjgFBvXJC0eheDkkcEANsh3bpt5w0=;
        b=louii8NDI9BVcTFLLaf2qzS7LF+yjp1+vqjF5SGAVTN1uc+si/hc5BdTV6dp/MG/Cg
         L51r0H0CYXp/jBSZZYH26h773lP3KwBgxqfTGcBfWKVpjfwes7NM73iod7IqDUrCZ7z/
         JdzqbVZxXjJBHaGIiq6Jr5bWQnQr8BWmR8L42+OyYvKxGWvZU1guuvXy5WpphpN943O/
         ItsH9poAdKy5osmNeVD2XRG/y8UW97EFGTy06cf9LB/iu6okFDu1VTVeTmzSWAn7ib85
         cePm7uBeoMwDCKSmYMyATNC9zhBS6+V+84TpcUFD0RcdAuZ2LEGc+etFrJhrFkyN4Zxz
         Arxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7s9SOp4oA+tWD/gjgFBvXJC0eheDkkcEANsh3bpt5w0=;
        b=hdopqA1+yc9hhj3bpUb+BmcBqcHYt4YR762hHNPGsQkvijVoyrwBjVaADFZvW35D/+
         7ki4+dEW33of4nP/0chbGHjQ+3/o0SdMg5G5vA0r1/7aJtZgisDh47EVKbLTBeox9ZYC
         phT11KCC8CzizCwRKPS4Yp1fYGsSsQNXObm9ont9ZwmW+DVoPuFRaTB4Ki29evpEuyoa
         LDfOZxZjFcC9XM43uEQrmWiTjKqK+Z3IGiSZa0L1dXeojshO3iR/VXFY0h1Ifv0GZdec
         +OTabn4eu6OBoPfRsBC3MafBsLYKxarV/G+uAeW21bp7oYyGdXP94r2uizcWlxl2SmnM
         7rKg==
X-Gm-Message-State: AOAM5305bWnb4/yi/lM8g3TpDzPc7mu2tqOx36fktG2JYSwX9bTnn3zG
        1+Z86Xml6rH69vYWI32IKz9/JYUmb6U=
X-Google-Smtp-Source: ABdhPJy92afPLYtURlbr+h45SHEugTPbssV7giuroMluZew725KT3rTE7UP4/ze/wOtAp7X8Acb4iA==
X-Received: by 2002:adf:e504:: with SMTP id j4mr413047wrm.330.1644255109965;
        Mon, 07 Feb 2022 09:31:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm10386206wrw.14.2022.02.07.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:31:49 -0800 (PST)
Message-Id: <996cbe7dfb73c211eae012813b352b0d0de3954c.1644255105.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
        <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 17:31:45 +0000
Subject: [PATCH v7 3/3] completion: handle unusual characters for
 sparse-checkout
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
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Update the __gitcomp_directories method to de-quote and handle unusual
characters in directory names. Although this initially involved an attempt
to re-use the logic in __git_index_files, this method removed
subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
logic was placed directly in the __gitcomp_directories method.

Note there are two tests for this new functionality - one for spaces and
accents and one for backslashes and tabs. The backslashes and tabs test
uses FUNNYNAMES to avoid running on Windows. This is because:

1. Backslashes are explicitly not allowed in Windows file paths.
2. Although tabs appear to be allowed when creating a file in a Windows
bash shell, they actually are not renderable (and appear as empty boxes
in the shell).

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 24 ++++++-------
 t/t9902-completion.sh                  | 49 ++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eeb80fdc6e4..6d81f03f291 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2988,7 +2988,7 @@ _git_show_branch ()
 
 __gitcomp_directories ()
 {
-	local _tmp_dir _tmp_completions
+	local _tmp_dir _tmp_completions _found=0
 
 	# Get the directory of the current token; this differs from dirname
 	# in that it keeps up to the final trailing slash.  If no slash found
@@ -2996,20 +2996,18 @@ __gitcomp_directories ()
 	[[ "$cur" =~ .*/ ]]
 	_tmp_dir=$BASH_REMATCH
 
-	# Find possible directory completions, adding trailing '/' characters
-	_tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
-		sed -e s%$%/%)"
-
-	if [[ -n "$_tmp_completions" ]]; then
-		# There were some directory completions, so find ones that
-		# start with "$cur", the current token, and put those in COMPREPLY
-		local i=0 c IFS=$' \t\n'
-		for c in $_tmp_completions; do
+	# Find possible directory completions, adding trailing '/' characters,
+	# de-quoting, and handling unusual characters.
+	while IFS= read -r -d $'\0' c ; do
+		# If there are directory completions, find ones that start
+		# with "$cur", the current token, and put those in COMPREPLY
 		if [[ $c == "$cur"* ]]; then
-			COMPREPLY+=("$c")
+			COMPREPLY+=("$c/")
+			_found=1
 		fi
-		done
-	elif [[ "$cur" =~ /$ ]]; then
+	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
+
+	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
 		# No possible further completions any deeper, so assume we're at
 		# a leaf directory and just consider it complete
 		__gitcomp_direct_append "$cur "
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b38a7302249..da6c86c64b3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1508,6 +1508,55 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	)
 '
 
+test_expect_success 'cone mode sparse-checkout completes directory names with spaces and accents' '
+	# reset sparse-checkout
+	git -C sparse-checkout sparse-checkout disable &&
+	(
+		cd sparse-checkout &&
+		mkdir "directory with spaces" &&
+		mkdir "directory-with-áccent" &&
+		>"directory with spaces/randomfile" &&
+		>"directory-with-áccent/randomfile" &&
+		git add . &&
+		git commit -m "Add directory with spaces and directory with accent" &&
+		git sparse-checkout set --cone "directory with spaces" \
+			"directory-with-áccent" &&
+		test_completion "git sparse-checkout add dir" <<-\EOF &&
+		directory with spaces/
+		directory-with-áccent/
+		EOF
+		rm -rf "directory with spaces" &&
+		rm -rf "directory-with-áccent" &&
+		git add . &&
+		git commit -m "Remove directory with spaces and directory with accent"
+	)
+'
+
+# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes or tabs in paths
+test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with backslashes and tabs' '
+	# reset sparse-checkout
+	git -C sparse-checkout sparse-checkout disable &&
+	(
+		cd sparse-checkout &&
+		mkdir "directory\with\backslashes" &&
+		mkdir "$(printf "directory\twith\ttabs")" &&
+		>"directory\with\backslashes/randomfile" &&
+		>"$(printf "directory\twith\ttabs")/randomfile" &&
+		git add . &&
+		git commit -m "Add directory with backslashes and directory with tabs" &&
+		git sparse-checkout set --cone "directory\with\backslashes" \
+			"$(printf "directory\twith\ttabs")" &&
+		test_completion "git sparse-checkout add dir" <<-\EOF &&
+		directory\with\backslashes/
+		directory	with	tabs/
+		EOF
+		rm -rf "directory\with\backslashes" &&
+		rm -rf "$(printf "directory\twith\ttabs")" &&
+		git add . &&
+		git commit -m "Remove directory with backslashes and directory with tabs"
+	)
+'
+
 test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
 	# reset sparse-checkout repo to non-cone mode
 	git -C sparse-checkout sparse-checkout disable &&
-- 
gitgitgadget
