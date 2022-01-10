Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46324C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiAJTAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiAJS77 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:59:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84846C061751
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so28636652wra.6
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w328BTYQXXh4hjoWqk7ucGJGMLcUN/7vnWOKdaaNkxs=;
        b=AtBnMey/vCp51gypi9Xou5QSGov6YSDvcIyJ4P6c71KQAmQdaoMcoM9zfuSH1gqSN3
         2AMMm8aLMG6XguUB88Fbb1iEq3OaBVmoMTd2FBF7mUqlbOEKqDzdS7DtyYbhB8dhCwS/
         OXstB9+/Y+j1Odukq12OUqtsvaIjNOkF+kCQlJ5fv0u+gSHw66L2jlkQAMBh6PmUQ1lr
         f7pWz93WmGazHHlitH3wl1vlkFG6xELFlIk+jhmTsNCo8qwXOm+1YCec4cv8vagyqjc5
         Isvy0jqqD+pMS2NTWUChFUTeBFGjy7P4rYmDgf0Fl6kJRtp5YO3FK3/ekP1uX5Xh+TuO
         /nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w328BTYQXXh4hjoWqk7ucGJGMLcUN/7vnWOKdaaNkxs=;
        b=Fy7SpIlbF3XU54CAiJn0+4z4jJy6B5DLdnm/LZbK1gBSjCfp24tOm8XKzHTzEoDJLJ
         Mun63pArDazsT2LFkQaxmwxFqA0YfbooH1gjd2Tko0e1+FvMb0etCFCDLoACFJYqoKD1
         Yuz15+hrM140LlsTLxvHHa7guNc4me6+moWXVv0Ukv/KSwFKfsd1uZn8wHn/tyNiCqah
         NT9R7wiVUtKt/39voA19ezvytqf2VMLaOk/c7W4yAyc5OzremA78OlBUf/GrAk3YndrP
         w202dLjH/+JJvv+5gDFgQ6yXCZT/Mv9he5cMDwvwc1a1sBsspy1zv7UuXz9DCdQWwf3E
         iQuA==
X-Gm-Message-State: AOAM531acygtX1S0A+y2Pf7whx6enXhdBYqErK1eSCVZ0gUYMN9ycPjQ
        ZvLF1gpUaoSwUvA+k9tdSm/dLNgit10=
X-Google-Smtp-Source: ABdhPJy+JYqklob/328bJdDD3YlR1dY/YgJvSARH/g3UQbM5qNMzh0DUIyJoQ/4cGLFylHe67ERhkA==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr799934wrx.428.1641841197022;
        Mon, 10 Jan 2022 10:59:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm7874685wmq.20.2022.01.10.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:59:56 -0800 (PST)
Message-Id: <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Jan 2022 18:59:52 +0000
Subject: [PATCH v3 3/3] sparse-checkout: limit tab completion to a single
 level
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

Ensure only directories at the current level will be tab-completed with
the sparse-checkout command. For example, if paths a/b/c/ and a/d/ exist
in the current directory, running a/<TAB> will result in:

        a/b/
        a/d/

The 'sparse-checkout completes directory names' test has also been
updated/extended according to these changes.

Co-authored-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 34 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 29 ++++++++++++++--------
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f478883f51c..21875d08d03 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,6 +2986,36 @@ _git_show_branch ()
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
 __git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
 
 _git_sparse_checkout ()
@@ -3007,11 +3037,11 @@ _git_sparse_checkout ()
 	case "$subcommand" in
 		set)
 			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
-			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			__gitcomp_directories
 			;;
 		add)
 			__gitcomp "--stdin"
-			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			__gitcomp_directories
 			;;
 		init|reapply)
 			__gitcomp "$__git_sparse_checkout_subcommand_opts"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4dc93ee0595..e11ff0c2efe 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1513,21 +1513,30 @@ test_expect_success 'sparse-checkout completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set f" <<-\EOF
-		folder1 Z
-		folder1/0 Z
-		folder1/0/1 Z
-		folder2 Z
-		folder2/0 Z
-		folder3 Z
+		folder1/
+		folder2/
+		folder3/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/" <<-\EOF
+		folder1/0/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
+		folder1/0/1/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout/folder1 &&
-		test_completion "git sparse-checkout add " <<-\EOF
-		./ Z
-		0 Z
-		0/1 Z
+		test_completion "git sparse-checkout add 0" <<-\EOF
+		0/
 		EOF
 	)
 '
-- 
gitgitgadget
