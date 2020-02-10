Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D3C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5374C20873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwNAt0Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgBJOp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46002 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgBJOpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so6988449wrs.12
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rmSJGPnCV5djEoGHTIwck4H4KwpzvNlqsbHiJGq/mnE=;
        b=YwNAt0SaZAk3w8mhtUs1I1xeVfiPsZFJmvTJxEthAgwobEpuyil8WwpkyNB2+NkUNf
         mm7StyL3V11POe06YhPSwt+/VG7SOU1uNiGvy63i3VqmxtBVz3HBf5nIuJYHLWA42mlU
         BDvphg4Luq5hpzXSDS/5T9wRUNrKRGLSuATx/Si9G4DubBIsFPOQ/rNt6C0OFDM4p2f2
         V6Lx6MzVzMj0+wMt6l6fwYiDVvqi1Uxnf+xijVduFqqwNNQkT6DOdj/aasBw6Xax3Idx
         HX7oXZsX9NkXunv0v3aIfh8SvsbGapVYZG/4PIhWM9lIkgNjSg+z9WQoO1xPO1/iWbv8
         j3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rmSJGPnCV5djEoGHTIwck4H4KwpzvNlqsbHiJGq/mnE=;
        b=fUKWkGyeOkroQgH0MoLNa5qphxZDVZJC1XKTGLylYM9k1PcK+KMH+awPF6PcMgkZlX
         p6wYvxdv8dBc19GQ/wiuBb0QTrNWZSwpVA1x80/HgvyacLViWZjXmDQCGkNd9ElfX+e8
         oJ7xN+RbfYhm4tyS17sA2XcBfoL/LltZ0w1OtTsY9ezQpQzFQfOcXkU3N50v6X28zMkq
         O4oAQXe3YOOziegS8qdflJvdbufvAPwToWGdJtrUocbVWuIhieEzNGhSkyxDp1D2nMS8
         ZduagI/mrf6WZJVTslHXHeUQyxcKT2OzNouAphbBNlQMmzMhaP+EGVDK0iISo9NNpLUX
         D0SQ==
X-Gm-Message-State: APjAAAUuDyufW9pr4IYkBDXK/kh3jpdK+YjXb1P+urikmz/CptKi9dQL
        koAjzbIN56QKsnc0/7E0ouFBtb7k
X-Google-Smtp-Source: APXvYqxLlLgXMVKqB+N0KwfsY18TP2MSIV2U7SAf5IHPVHHlWLqrRoePI0Z0gBq2zBkkuLc/V9ScOQ==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr2321748wrq.415.1581345951701;
        Mon, 10 Feb 2020 06:45:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm777728wrx.94.2020.02.10.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:51 -0800 (PST)
Message-Id: <8c212fc0ed416fcd6a2da798cf92d4f2edae3608.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:42 +0000
Subject: [PATCH v2 3/8] doc: stash: split options from description (1)
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

This patch moves blocks of text as-is to make it easier to review the
next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 68 +++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 53e1a1205d..2dedc21997 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -58,31 +58,6 @@ non-option arguments are not allowed to prevent a misspelled
 subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspecs,
 which are allowed after a double hyphen `--` for disambiguation.
-+
-When pathspec is given to 'git stash push', the new stash entry records the
-modified states only for the files that match the pathspec.  The index
-entries and working tree files are then rolled back to the state in
-HEAD only for these files, too, leaving files that do not match the
-pathspec intact.
-+
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
-+
-If the `--include-untracked` option is used, all untracked files are also
-stashed and then cleaned up with `git clean`, leaving the working directory
-in a very clean state. If the `--all` option is used instead then the
-ignored files are stashed and cleaned in addition to the untracked files.
-+
-With `--patch`, you can interactively select hunks from the diff
-between HEAD and the working tree to be stashed.  The stash entry is
-constructed such that its index state is the same as the index state
-of your repository, and its worktree contains only the changes you
-selected interactively.  The selected changes are then rolled back
-from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `--patch` mode.
-+
-The `--patch` option implies `--keep-index`.  You can use
-`--no-keep-index` to override this.
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
@@ -128,14 +103,6 @@ pop [--index] [-q|--quiet] [<stash>]::
 Applying the state can fail with conflicts; in this case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
 and call `git stash drop` manually afterwards.
-+
-If the `--index` option is used, then tries to reinstate not only the working
-tree's changes, but also the index's ones. However, this can fail, when you
-have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
-+
-When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@{<revision>}`.
 
 apply [--index] [-q|--quiet] [<stash>]::
 
@@ -185,6 +152,41 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
+If the `--all` option is used instead then the
+ignored files are stashed and cleaned in addition to the untracked files.
+
+If the `--include-untracked` option is used, all untracked files are also
+stashed and then cleaned up with `git clean`, leaving the working directory
+in a very clean state.
+
+If the `--index` option is used, then tries to reinstate not only the working
+tree's changes, but also the index's ones. However, this can fail, when you
+have conflicts (which are stored in the index, where you therefore can no
+longer apply the changes as they were originally).
+
+If the `--keep-index` option is used, all changes already added to the
+index are left intact.
+
+With `--patch`, you can interactively select hunks from the diff
+between HEAD and the working tree to be stashed.  The stash entry is
+constructed such that its index state is the same as the index state
+of your repository, and its worktree contains only the changes you
+selected interactively.  The selected changes are then rolled back
+from your worktree. See the ``Interactive Mode'' section of
+linkgit:git-add[1] to learn how to operate the `--patch` mode.
++
+The `--patch` option implies `--keep-index`.  You can use 
+`--no-keep-index` to override this.
+
+When pathspec is given to 'git stash push', the new stash entry records the
+modified states only for the files that match the pathspec.  The index
+entries and working tree files are then rolled back to the state in
+HEAD only for these files, too, leaving files that do not match the
+pathspec intact.
+
+When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
+be a reference of the form `stash@{<revision>}`.
+
 DISCUSSION
 ----------
 
-- 
gitgitgadget

