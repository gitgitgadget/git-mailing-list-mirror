Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FAC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 03:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356808AbiBDD0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347848AbiBDD0o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 22:26:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7EC06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 19:26:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k18so8784375wrg.11
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 19:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bro1lk4eq0Kp7OYBHHGD4bs7cDeJQVMggp8eIc0ajCw=;
        b=JkNhDa4h0uT921jSR9gJDFLF91nVEYhO0K7BT6UvDPf/WCKZABDL0j/ZwEwu1aKmYM
         s8NmJlhLJZyT0zv5WMq4BS0+H+dzv6KrjKrB7LPkrDJygTgsiPS5HjpuOiDG3Ywg/4bN
         ngD7w3nQSWL1/sZmBZ+uNBKuaJtovjp6RIVi67sFe9VWSATAxJAwgZRNwi3gKJWJzQCW
         Crq9FweEaEeKyhbUbgXX/pIw1RRrk6Up8Ikkaf/sAfUGTlOzaifqtD+gzMLX6e11d7RS
         RMEeTrALkaJ6/DC4qKMb/C4VfUzLTOb/gRa5qkPmRiQrXiuM4FxY8Kn7TvINATX/Y1BL
         /82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bro1lk4eq0Kp7OYBHHGD4bs7cDeJQVMggp8eIc0ajCw=;
        b=Tg5QFpCJA5XKeHNLopI829i/BfSS6HoNwrZumC39TEcQf/WHB3cQLs5L69ZbUXi5cA
         c5eZcjoAq7NFH7GfotqNfvR/5a8SkMq5MoA1hvGZQv6eJFeQTHzecvBif+G5Mbgty3kO
         RyhTcJnKOqsUmhtRPyvTamGM5nzkwRMIj5/UyeXdhlyccDmMRTUuPIWA9GO59Tz/REu+
         M5n9ZQHu8RTGfVzAedhGZzkjANs4mF+TMKs+kahCxLi4FT/O0tf4EhEQe1bxK35f/cm4
         oIc6kp/Z97wCbWc9pPIf7Dgbh9RUDfCkTeNyl7FatATU31c1h6blE4RBrtSD73QcyuAH
         wBNQ==
X-Gm-Message-State: AOAM532133TTZ2eS2R7sYp2sjETTsWLvhYUQkkc4cIzQOJM0diFzlneP
        ztsn6TvCitsYRPRKXVC/tLlBYEmDMGM=
X-Google-Smtp-Source: ABdhPJy6j7Vgk9NFwn5JPpdOZ+BjdiyStspefzvuqvAUgMovyHnSGN/L5VeFYFindIK+7LCt1ga/TQ==
X-Received: by 2002:a05:6000:1c0f:: with SMTP id ba15mr710424wrb.63.1643945201606;
        Thu, 03 Feb 2022 19:26:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm4127wrm.58.2022.02.03.19.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:26:41 -0800 (PST)
Message-Id: <e805dbb58ccd24926ebe411022cc9f1408ce8b49.1643945198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Feb 2022 03:26:38 +0000
Subject: [PATCH v6 3/3] completion: handle unusual characters for
 sparse-checkout
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

Update the __gitcomp_directories method to de-quote and handle unusual
characters in directory names. Although this initially involved an attempt
to re-use the logic in __git_index_files, this method removed
subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
logic was placed directly in the __gitcomp_directories method.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 24 ++++++++++------------
 t/t9902-completion.sh                  | 28 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 13 deletions(-)

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
index b38a7302249..7f63d6057be 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1508,6 +1508,34 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	)
 '
 
+# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes in paths
+test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with special characters' '
+	# reset sparse-checkout
+	git -C sparse-checkout sparse-checkout disable &&
+	(
+		cd sparse-checkout &&
+		mkdir "directory with spaces" &&
+		mkdir "$(printf "directory\twith\ttabs")" &&
+		mkdir "directory\with\backslashes" &&
+		mkdir "directory-with-áccent" &&
+		>"directory with spaces/randomfile" &&
+		>"$(printf "directory\twith\ttabs")/randomfile" &&
+		>"directory\with\backslashes/randomfile" &&
+		>"directory-with-áccent/randomfile" &&
+		git add . &&
+		git commit -m "Add directories containing unusual characters" &&
+		git sparse-checkout set --cone "directory with spaces" \
+			"$(printf "directory\twith\ttabs")" "directory\with\backslashes" \
+			"directory-with-áccent" &&
+		test_completion "git sparse-checkout add dir" <<-\EOF
+		directory with spaces/
+		directory	with	tabs/
+		directory\with\backslashes/
+		directory-with-áccent/
+		EOF
+	)
+'
+
 test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
 	# reset sparse-checkout repo to non-cone mode
 	git -C sparse-checkout sparse-checkout disable &&
-- 
gitgitgadget
