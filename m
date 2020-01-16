Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC6C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C352077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/pzTXJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAPQJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43993 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgAPQJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so19731335wre.10
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9HMLKaW23nHkIRPTOEObEQjluD03VSoDSYMePDAPG8Y=;
        b=i/pzTXJcmZAaqiAdkm6YEYHXKzD692/N+JalqmAz3p76BXNztSTBuQE6t2oztbbem9
         EAIiIpUMawlzQ7qkCk0nUr+jgXEyrs5F5ggNCf4nd66MSJihoN44QDoH5P4HnUNoV6qO
         zKAdV6MoCxe6yex35lPlzGm1x+fSJg9yYWWLkWaMdlWoifBOwwwnXswzFgou5OrivdPD
         XnF0GN6jAE2QlkvdAJAqbysdOLBLmuF6wBQ5WUiI99gXfcFY1nKrH0LmgzPRpQJ8bXqE
         tfYd22IRG8v+w4RvcuRjtfyETP6sa3qS+MdtR7QVO1ZaEy5sf1bBRVcUzTNskgjJfPDY
         rALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9HMLKaW23nHkIRPTOEObEQjluD03VSoDSYMePDAPG8Y=;
        b=uWxJ36BMAWISlUgS5vY8paG+LcxQQUm+FUrp3BLJUZ33MBoiLKaiReuyeyuZxC6eXd
         m+RZ/3UXfZ+ZnKRahy/CVUZVOZQvOuYX5h8C6Wb6Vsft1DPrPE5djTtpM8Cmuo/DKSAr
         qaOBrs0BxWpqCPpRJpOV6PIPcJr+uiGOrWjVsE68Tq2yt5k8VnS6wQgwXcsXFpiwySWS
         FP7RQT0tvo21Mbf1EJOjl4y+D2EBdIGTyzj1CLAsFLJCKt7VBexESwQzJb8o2kNKx6rb
         aePnJOEcXyQSohHwE6+NNuolJSBJj4tmaGJ0sZP+IYZrdi3JoQ1iAp5k0Hb4LKt3wCFk
         yMsw==
X-Gm-Message-State: APjAAAW7xoKwTS+NyP9q8f942FDd/huNyubaxNmAqRuszpZX0d+am+Va
        2rLm8MsFvzQgX9ukhTj+q7gQul9d
X-Google-Smtp-Source: APXvYqyOydVQ071wuBUidSQPvLlmm8u37FZSFQEvJTJvLq/8qogUUdHe5XW0Ey6PdyT8FDqL8UkKTA==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr4059650wrm.278.1579190971778;
        Thu, 16 Jan 2020 08:09:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm4959036wmg.22.2020.01.16.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:31 -0800 (PST)
Message-Id: <708363241f4940e5b627af8519345b762deb77ab.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:21 +0000
Subject: [PATCH 4/8] doc: stash: split options from description (2)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Together with the previous patch, this brings docs for `git stash` to
the common layout used for most other commands (see for example docs for
`git add`, `git commit`, `git checkout`, `git reset`) where all options
are documented in a separate list.

I have decided to use alphabetical sorting in the list of options. Other
docs often sort in order of appearance or order of importance, but in
this case it wouldn't be easy to read the list where options from
multiple sub-commands are mixed together.

There is some text editing done to make old descriptions better fit into
the list-style format.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 72 ++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2dedc21997..f75b80a720 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -43,9 +43,6 @@ created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible). Stashes may also be referenced by specifying just the
 stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
-OPTIONS
--------
-
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
@@ -152,40 +149,51 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
-If the `--all` option is used instead then the
-ignored files are stashed and cleaned in addition to the untracked files.
-
-If the `--include-untracked` option is used, all untracked files are also
-stashed and then cleaned up with `git clean`, leaving the working directory
-in a very clean state.
-
-If the `--index` option is used, then tries to reinstate not only the working
-tree's changes, but also the index's ones. However, this can fail, when you
-have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
-
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
-
-With `--patch`, you can interactively select hunks from the diff
-between HEAD and the working tree to be stashed.  The stash entry is
-constructed such that its index state is the same as the index state
-of your repository, and its worktree contains only the changes you
-selected interactively.  The selected changes are then rolled back
-from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `--patch` mode.
+OPTIONS
+-------
+-a::
+--all::
+	All ignored and untracked files are also stashed and then cleaned
+	up with `git clean`.
+
+-u::
+--include-untracked::
+	All untracked files are also stashed and then cleaned up with
+	`git clean`.
+
+--index::
+	Tries to reinstate not only the working tree's changes, but also
+	the index's ones. However, this can fail, when you have conflicts
+	(which are stored in the index, where you therefore can no longer
+	apply the changes as they were originally).
+
+-k::
+--keep-index::
+--no-keep-index::
+	All changes already added to the index are left intact.
+
+-p::
+--patch::
+	Interactively select hunks from the diff between HEAD and the
+	working tree to be stashed.  The stash entry is constructed such
+	that its index state is the same as the index state of your
+	repository, and its worktree contains only the changes you selected
+	interactively.  The selected changes are then rolled back from your
+	worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
+	to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
-When pathspec is given to 'git stash push', the new stash entry records the
-modified states only for the files that match the pathspec.  The index
-entries and working tree files are then rolled back to the state in
-HEAD only for these files, too, leaving files that do not match the
-pathspec intact.
+<pathspec>...::
+	The new stash entry records the modified states only for the files
+	that match the pathspec.  The index entries and working tree files
+	are then rolled back to the state in HEAD only for these files,
+	too, leaving files that do not match the pathspec intact.
 
-When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@{<revision>}`.
+<stash>::
+	A reference of the form `stash@{<revision>}`. When no `<stash>` is
+	given, the latest stash is assumed (that is, `stash@{0}`).
 
 DISCUSSION
 ----------
-- 
gitgitgadget

