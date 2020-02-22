Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F0C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB6206D7
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 22:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Tvo09y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVWfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:35:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43614 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVWfL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 17:35:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so6013731wrq.10
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zo1wRYm3faDowzAzvLmmAndyA8b4nXEDDXMenraidks=;
        b=B5Tvo09y0XkWu4YIbgIsSWMn36Q/LzdZHhBT+Ckbjd48DwRx62So2ncCsmzgtG4489
         i/eO7FzXi6YeO30uaAKUOXfDwZCtLKTXpZJfnC3KPvACzkfYff0nvsNXFHtEoY58+KGi
         gZhJecpY8WoeMwoa4+7ziuLyDt9JlkTwNJ7dDKp0tjzaTeutUkqS1pCJA5BPOfYZaA1x
         djrqFvYJ3OfFrta/Bd5WXV3kJxG8ZQGjlqX2LlHif9aK9n5OOfeKT1CjY7bJ7wZ865Ca
         ZfpcLns8JX2jt4aLxIGwebgtgy0AaTVBrSqTmWiGSez5Ee6wSVant9uVTH1knB+ER0ZK
         SQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zo1wRYm3faDowzAzvLmmAndyA8b4nXEDDXMenraidks=;
        b=pmLE0VFlADgkuMih0zq0vp6L+O0xFEF2qpACa9doqSUWw8hBEzmS3UvS7WStIbJW96
         CG5rxUR1EWVZi+97NfF8N/vIz/XlpCJgWdGVgXEs702RAAFdrNW1/JY2cA0p8JwFzM3P
         bF5b5D1BXMcCX3rCrTqHalFp17WdeKvzi1sZJOax4fyudPmncKbo2RX9knzjQM5UFKP7
         JoLmmRqb1QwE6MF53yrXvJKRo9Wz9s1JL6hbmyVpbiksgVQ/FoQiUjCiNXDB1iRTgSYq
         fFsrvysAVcAYx9qrX1ku/dd5BEcNuHvLZ5f3LHv5Eecvr4hj/U8SKy9s8HtC1cAWfxxR
         3S+Q==
X-Gm-Message-State: APjAAAXk61Vo8NZHib6xLaTsjnOWG+voOkxXO7eMj8eky1fCbOWp9DVo
        aMHdSeKqx+MFtyKlW7gJEYKtKBak
X-Google-Smtp-Source: APXvYqw7WgKXSG78iWjZvinUvINbqAV9ImMezuxQuy5XiAl9r3DZHJOXeiCOIV4ZymhPtBTyp5q+aQ==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr53962102wrv.333.1582410909268;
        Sat, 22 Feb 2020 14:35:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm10494933wrw.54.2020.02.22.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:35:08 -0800 (PST)
Message-Id: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.git.1581620351.gitgitgadget@gmail.com>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:35:03 +0000
Subject: [PATCH v2 0/4] [GSoC] receive.denyCurrentBranch: respect all worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The receive.denyCurrentBranch config option controls what happens if you
push to a branch that is checkout into a non-bare repository. By default, it
rejects it. It can be disabled via ignore or warn. Another yet trickier
option is updateInstead.

When receive.denyCurrentBranch is set to updateInstead, a push that tries to
update the branch that is currently checked out is accepted only when the
index and the working tree exactly matches the currently checked out commit,
in which case the index and the working tree are updated to match the pushed
commit. Otherwise, the push is refused.

However, this setting was forgotten when the git worktree command was
introduced: only the main worktree's current branch is respected. [ fixes:
#331 ]

Incidently, this change also fixes another bug i.e. 
receive.denyCurrentBranch = true was ignored when pushing into a non-bare
repository using ref namespaces.

Thanks, @dscho for helping me out.

Regards, Hariom

Hariom Verma (4):
  get_main_worktree(): allow it to be called in the Git directory
  t5509: initialized `pushee` as bare repository
  bug: denyCurrentBranch and unborn branch with ref namespace
  receive.denyCurrentBranch: respect all worktrees

 builtin/receive-pack.c           | 37 +++++++++++++++++---------------
 t/t5509-fetch-push-namespaces.sh | 11 +++++++++-
 t/t5516-fetch-push.sh            | 11 ++++++++++
 worktree.c                       |  1 +
 4 files changed, 42 insertions(+), 18 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-535%2Fharry-hov%2Fdeny-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-535/harry-hov/deny-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/535

Range-diff vs v1:

 1:  902c8a3f171 = 1:  8718facbc95 get_main_worktree(): allow it to be called in the Git directory
 2:  d156d04ca87 ! 2:  5c749e044a3 t5509: initialized `pushee` as bare repository
     @@ -3,9 +3,9 @@
          t5509: initialized `pushee` as bare repository
      
          `receive.denyCurrentBranch` currently has a bug where it allows pushing
     -    into the current branch of a non-bare repository as long as it does not
     -    have any commits. This would cause t5509 to fail once that bug is fixed
     -    because it pushes into an unborn current branch.
     +    into non-bare repository using namespaces as long as it does not have any
     +    commits. This would cause t5509 to fail once that bug is fixed because it
     +    pushes into an unborn current branch.
      
          In t5509, no operations are performed inside `pushee`, as it is only a
          target for `git push` and `git ls-remote` calls. Therefore it does not
 -:  ----------- > 3:  b3e573d44a9 bug: denyCurrentBranch and unborn branch with ref namespace
 3:  3352c0bffc1 ! 4:  61e5f75a6f9 receive.denyCurrentBranch: respect all worktrees
     @@ -14,10 +14,10 @@
      
          That change also leads to revealing another bug,
          i.e. `receive.denyCurrentBranch = true` was ignored when pushing into a
     -    non-bare repository's unborn current branch.  As `is_ref_checked_out()`
     -    returns 0 which means `receive-pack` does not get into conditional
     -    statement to switch `deny_current_branch` accordingly(ignore, warn,
     -    refuse, unconfigured, updateInstead).
     +    non-bare repository's unborn current branch using ref namespaces. As
     +    `is_ref_checked_out()` returns 0 which means `receive-pack` does not get
     +    into conditional statement to switch `deny_current_branch` accordingly
     +    (ignore, warn, refuse, unconfigured, updateInstead).
      
          receive.denyCurrentBranch uses the function `refs_resolve_ref_unsafe()`
          (called via `resolve_refdup()`) to resolve the symbolic ref HEAD, but
     @@ -26,7 +26,7 @@
          `find_shared_symref()`, which has no problem finding the worktree for a
          given branch even if it is unborn yet, this bug is fixed at the same
          time: receive.denyCurrentBranch now also handles worktrees with unborn
     -    branches as intended.
     +    branches as intended even while using ref namespaces.
      
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
     @@ -127,6 +127,19 @@
       			return ret;
       	}
      
     + diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
     + --- a/t/t5509-fetch-push-namespaces.sh
     + +++ b/t/t5509-fetch-push-namespaces.sh
     +@@
     + 	test_cmp expect actual
     + '
     + 
     +-test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '
     ++test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
     + 	cd original &&
     + 	git init unborn &&
     + 	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
     +
       diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
       --- a/t/t5516-fetch-push.sh
       +++ b/t/t5516-fetch-push.sh
     @@ -135,7 +148,7 @@
       '
       
      +test_expect_success 'denyCurrentBranch and worktrees' '
     -+    git worktree add new-wt &&
     ++	git worktree add new-wt &&
      +	git clone . cloned &&
      +	test_commit -C cloned first &&
      +	test_config receive.denyCurrentBranch refuse &&

-- 
gitgitgadget
