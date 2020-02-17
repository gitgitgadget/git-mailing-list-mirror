Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F720C34026
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770020801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0m9OBip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBQRZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgBQRZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so20715225wrt.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xD0afhfxM7Rsi5TBEmB1MdsG43Zmrsg2GusixB9W1wI=;
        b=O0m9OBiptr5tqiE+MA4OA+FTaE/DS6vtoK4pxgLp9wWugqVowDRVd+ZkYSH9xxS5ym
         FKLA2ObxiYW30o1OKNJB+7w5bnooNUu836FBT7HRLDC2vRgCbhyZyNG6zSb78kGeawHZ
         EG7wOE0eLSZkeHVG7k8Ke+6ykKEncLJb3hBkdKRjqmuxqtdeYNnZIfgBI9T7cKlux3an
         NdFpwHKuGqbbqLYB9KUh20VJ6VRlo02CLkdFRJ3pYupfuX2C6YDB0S2pHgIvg4zj4LX1
         a0Rfn+gneqq9LTyEeyixAOFnsFuO91clbk/vl6AQffXi+hCij2aAJLQ/A9dVv/337S68
         VI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xD0afhfxM7Rsi5TBEmB1MdsG43Zmrsg2GusixB9W1wI=;
        b=YAf66I6bhGi2gKDkxFsgZt78yLpxYuRnyC7I6N1ngHx45bJZV+VgR0Xc5DRJumpBJ2
         +KIrd/5FhiFkRHscUd/K0XZ1MMLgiekduA+Wf2MKhKQaKHyhU4LL8lsyH9TpxElkW6ea
         lHQtBvyCnmaWwoT9mN2+a/wa6KoKAy/5q5eFICnx4bgcLsKxb5xRVyI6dvrYTNiNIGP/
         RSibQkig8bimH3XiAnWoXvE3IwKFCyOkan0aqvZRno4s5NKjsr0QOZW0HYdmX4TAKh0M
         7paX3dDX6pVVrffXBJa3haT9Q7FmNzSBR/n5U2Ax2y60PyKCF64deN853JAqyR/mvfrB
         fvrw==
X-Gm-Message-State: APjAAAXF3evSaFUG/poH/iLgS43phsWOOZ9TikxyZunxWfUaB4aA0g6M
        NTqt6csewJP5rzskP7v3KIrFzqAd
X-Google-Smtp-Source: APXvYqwmeAc5/WlpGUtX+cuNtwK3nq3JO8rP+ipoDJ2BVl/C2PwKQp6PN8IUveyjk/+TgottqO6QPA==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr23039189wru.402.1581960326646;
        Mon, 17 Feb 2020 09:25:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm1821864wrw.76.2020.02.17.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:26 -0800 (PST)
Message-Id: <fdaf45324047f850f6b870c628351f53e4980d96.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:18 +0000
Subject: [PATCH v3 4/8] doc: stash: split options from description (2)
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
the common layout used for most other commands (see for example docs
for `git add`, `git commit`, `git checkout`, `git reset`) where all
options are documented in a separate list.

After some thinking and having a look at docs for `git svn` and
`git `submodule`, I have arrived at following conclusions:
  * Options should be described in a list rather then text to
    facilitate lookup for user.
  * Single list is better then multiple lists because it avoids
    copy&pasting descriptions between subcommands (or, without
    copy&pasting, user will have to look up missing options in other
    subcommands).
  * As a consequence, commands section should only give brief info and
    list possible options. Since options have good enough names, user
	will only need to look up the "interesting" options.
  * Every option should list which subcommands support it.

I have decided to use alphabetical sorting in the list of options to
facilitate lookup for user.

There is some text editing done to make old descriptions better fit
into the list-style format.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 92 +++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2dedc219974..c1c16623cbc 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -43,8 +43,8 @@ created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible). Stashes may also be referenced by specifying just the
 stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
-OPTIONS
--------
+COMMANDS
+--------
 
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
@@ -86,7 +86,7 @@ show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-	created. When no `<stash>` is given, it shows the latest one.
+	created.
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
@@ -116,8 +116,7 @@ branch <branchname> [<stash>]::
 	the commit at which the `<stash>` was originally created, applies the
 	changes recorded in `<stash>` to the new working tree and index.
 	If that succeeds, and `<stash>` is a reference of the form
-	`stash@{<revision>}`, it then drops the `<stash>`. When no `<stash>`
-	is given, applies the latest one.
+	`stash@{<revision>}`, it then drops the `<stash>`.
 +
 This is useful if the branch on which you ran `git stash push` has
 changed enough that `git stash apply` fails due to conflicts. Since
@@ -133,9 +132,6 @@ clear::
 drop [-q|--quiet] [<stash>]::
 
 	Remove a single stash entry from the list of stash entries.
-	When no `<stash>` is given, it removes the latest one.
-	i.e. `stash@{0}`, otherwise `<stash>` must be a valid stash
-	log reference of the form `stash@{<revision>}`.
 
 create::
 
@@ -152,40 +148,66 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
-If the `--all` option is used instead then the
-ignored files are stashed and cleaned in addition to the untracked files.
-
-If the `--include-untracked` option is used, all untracked files are also
-stashed and then cleaned up with `git clean`, leaving the working directory
-in a very clean state.
+OPTIONS
+-------
+-a::
+--all::
+	This option is only valid for `push` and `save` commands.
++
+All ignored and untracked files are also stashed and then cleaned
+up with `git clean`.
 
-If the `--index` option is used, then tries to reinstate not only the working
-tree's changes, but also the index's ones. However, this can fail, when you
-have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
+-u::
+--include-untracked::
+	This option is only valid for `push` and `save` commands.
++
+All untracked files are also stashed and then cleaned up with
+`git clean`.
 
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
+--index::
+	This option is only valid for `pop` and `apply` commands.
++
+Tries to reinstate not only the working tree's changes, but also
+the index's ones. However, this can fail, when you have conflicts
+(which are stored in the index, where you therefore can no longer
+apply the changes as they were originally).
+
+-k::
+--keep-index::
+--no-keep-index::
+	This option is only valid for `push` and `save` commands.
++
+All changes already added to the index are left intact.
 
-With `--patch`, you can interactively select hunks from the diff
-between HEAD and the working tree to be stashed.  The stash entry is
-constructed such that its index state is the same as the index state
-of your repository, and its worktree contains only the changes you
-selected interactively.  The selected changes are then rolled back
-from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `--patch` mode.
+-p::
+--patch::
+	This option is only valid for `push` and `save` commands.
++
+Interactively select hunks from the diff between HEAD and the
+working tree to be stashed.  The stash entry is constructed such
+that its index state is the same as the index state of your
+repository, and its worktree contains only the changes you selected
+interactively.  The selected changes are then rolled back from your
+worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
+to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
-When pathspec is given to 'git stash push', the new stash entry records the
-modified states only for the files that match the pathspec.  The index
-entries and working tree files are then rolled back to the state in
-HEAD only for these files, too, leaving files that do not match the
-pathspec intact.
-
-When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@{<revision>}`.
+<pathspec>...::
+	This option is only valid for `push` command.
++
+The new stash entry records the modified states only for the files
+that match the pathspec.  The index entries and working tree files
+are then rolled back to the state in HEAD only for these files,
+too, leaving files that do not match the pathspec intact.
+
+<stash>::
+	This option is only valid for `apply`, `branch`, `drop`, `pop`,
+	`show` commands.
++
+A reference of the form `stash@{<revision>}`. When no `<stash>` is
+given, the latest stash is assumed (that is, `stash@{0}`).
 
 DISCUSSION
 ----------
-- 
gitgitgadget

