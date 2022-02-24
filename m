Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F13C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiBXOdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiBXOdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:33:36 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD01637F1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:33:03 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nNFAz-0005kT-Da;
        Thu, 24 Feb 2022 14:33:01 +0000
Message-ID: <d9394947-f545-2dd9-b788-38fd7202243d@iee.email>
Date:   Thu, 24 Feb 2022 14:33:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-GB
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <"[sunshine@sunshineco.com]"@vger.kernel.org>,
        "mailto:gitster@pobox.com" <"[gitster@pobox.com]"@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA_=5b_=5d?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/2022 17:54, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> It is helpful to distinguish between a 'working tree' and a 'worktree'.
> A worktree contains a working tree plus additional metadata. This
> metadata includes per-worktree refs and worktree-specific config.
Doesn't this need a clear call-out in the text to highlight the
distinction, so that it is obvious at first glance to the casual reader?

I'd ended up with something like:
- worktree
    A directory whose files and sub-directories are (selectively) under
Git revision management.
- working tree
    The working tree comprises Git revision management meta-data for the
worktree,
     and the worktree itself.
    The meta-data may be independently located away from the worktree's
data.

The key feature is to have a layout structure that shows the distinction.

Or are we trying to remove all references to "working tree"? Or have I
misunderstood?

Philip

>
> This is the first of multiple changes to git-worktree.txt, restricted to
> the DESCRIPTION section.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-worktree.txt | 53 ++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index b8d53c48303..d9705062e9d 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -25,45 +25,48 @@ Manage multiple working trees attached to the same repository.
>  
>  A git repository can support multiple working trees, allowing you to check
Are we removing the above "working trees" phrases as well?
>  out more than one branch at a time.  With `git worktree add` a new working
> -tree is associated with the repository.  This new working tree is called a
> -"linked working tree" as opposed to the "main working tree" prepared by
> -linkgit:git-init[1] or linkgit:git-clone[1].
> -A repository has one main working tree (if it's not a
> -bare repository) and zero or more linked working trees. When you are done
> -with a linked working tree, remove it with `git worktree remove`.
> +tree is associated with the repository, along with additional metadata
> +that differentiates that working tree from others in the same repository.
> +The working tree, along with this metada, is called a "worktree".
> +
> +This new worktree is called a "linked worktree" as opposed to the "main
> +worktree" prepared by linkgit:git-init[1] or linkgit:git-clone[1].
> +A repository has one main worktree (if it's not a bare repository) and
> +zero or more linked worktrees. When you are done with a linked worktree,
> +remove it with `git worktree remove`.
>  
>  In its simplest form, `git worktree add <path>` automatically creates a
>  new branch whose name is the final component of `<path>`, which is
>  convenient if you plan to work on a new topic. For instance, `git
>  worktree add ../hotfix` creates new branch `hotfix` and checks it out at
> -path `../hotfix`. To instead work on an existing branch in a new working
> -tree, use `git worktree add <path> <branch>`. On the other hand, if you
> -just plan to make some experimental changes or do testing without
> -disturbing existing development, it is often convenient to create a
> -'throwaway' working tree not associated with any branch. For instance,
> -`git worktree add -d <path>` creates a new working tree with a detached
> -`HEAD` at the same commit as the current branch.
> -
> -If a working tree is deleted without using `git worktree remove`, then
> +path `../hotfix`. To instead work on an existing branch in a new worktree,
> +use `git worktree add <path> <branch>`. On the other hand, if you just
> +plan to make some experimental changes or do testing without disturbing
> +existing development, it is often convenient to create a 'throwaway'
> +worktree not associated with any branch. For instance,
> +`git worktree add -d <path>` creates a new worktree with a detached `HEAD`
> +at the same commit as the current branch.
> +
> +If a worktree is deleted without using `git worktree remove`, then
>  its associated administrative files, which reside in the repository
>  (see "DETAILS" below), will eventually be removed automatically (see
>  `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
> -`git worktree prune` in the main or any linked working tree to
> -clean up any stale administrative files.
> +`git worktree prune` in the main or any linked worktree to clean up any
> +stale administrative files.
>  
> -If a linked working tree is stored on a portable device or network share
> -which is not always mounted, you can prevent its administrative files from
> -being pruned by issuing the `git worktree lock` command, optionally
> -specifying `--reason` to explain why the working tree is locked.
> +If a linked worktree is stored on a portable device or network share which
> +is not always mounted, you can prevent its administrative files from being
> +pruned by issuing the `git worktree lock` command, optionally specifying
> +`--reason` to explain why the worktree is locked.
>  
>  COMMANDS
>  --------
>  add <path> [<commit-ish>]::
>  
> -Create `<path>` and checkout `<commit-ish>` into it. The new working directory
> -is linked to the current repository, sharing everything except working
> -directory specific files such as `HEAD`, `index`, etc. As a convenience,
> -`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
> +Create `<path>` and checkout `<commit-ish>` into it. The new worktree
> +is linked to the current repository, sharing everything except per-worktree
> +files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
> +be a bare "`-`", which is synonymous with `@{-1}`.
>  +
>  If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
>  and neither `-b` nor `-B` nor `--detach` are used, but there does

