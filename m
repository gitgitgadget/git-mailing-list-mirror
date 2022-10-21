Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101CC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJUJV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJUJV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:21:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D372565CF
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so3927547wrr.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClE1PBxXF+UoHN4KUkbSe0ssL6TY0aTpWkS5X5sxGkc=;
        b=HiGCqpCI/fCJjZqaIRoiuVCZ0qGG5wZ4u8PK2GXh17C/aYu2GNpFXkv2J0alcKt0wA
         eLH4jzWs7qeEjnETZotDjqcLVXRc/e6y7fOaV9XlZHj1+y0sQ7Vs7MkaHnWnMDO4VhWx
         KxBYVcqrz37jAKZXDG7dllIgs8VcOohizTKaBeM8PvXyOLMlADveAm+31JzlEBDtN4o6
         McDPaLq87UTI3FIt7kL4eY3wrkfQkV8sYWNUV77hM3Xljx1P/X/4uKOfRSRmiziVJbxF
         Xfxm/CoudekciripMB6JKxI060+QVtMwhFiqGrnbrNtXHtbqxYzKe4CRkLhGo12A2Z5t
         q9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClE1PBxXF+UoHN4KUkbSe0ssL6TY0aTpWkS5X5sxGkc=;
        b=PHNfXkIiqe9iQYzS9SWZFIsZWvUzkr9tmJO/tQdSP5OYWt/S9rmPaAYyxkk+tt/rRr
         2jVl25Z1Tnwv6M58K50fMYJUmMA5LWd47oh/Tw9DLtj2ASH4zbtXwGWzfNmtdfHiUSBC
         YQ9knTR6jsvSnjNEyaTQWfK+u9gxMoi5+VCgM1fz/BPHKiddMJHUrHzIMToad4LcL77n
         RP3fks2BjZvpDjRMz61izW7FaljozY3w+n8PvZ+P8DsYTM5x88x+VhQt9y85kjP+C6+m
         F8pWoqZC0MaQb6tW6UBvUfdaCbUPNraWGR+gguX41GSeVZFWdrIgC0UvY5WGEwvsS6nV
         DHqQ==
X-Gm-Message-State: ACrzQf19vZZqilp60K9AR1G1ZzEkWOSU1VoW/reB5bSkiqCLpyAZKcQy
        6ohI8E/8MJbv+BaNn+y5qgF3SDv+OhU=
X-Google-Smtp-Source: AMsMyM5EP3zv6H2wvUJPLBcmZ/f6wv6kKxa+xS+QDSZ34GjxtUkOCCxsTFfl4cxcQe+sPV7NeYO6fg==
X-Received: by 2002:a5d:47cb:0:b0:236:4b94:7236 with SMTP id o11-20020a5d47cb000000b002364b947236mr3359429wrc.243.1666344109944;
        Fri, 21 Oct 2022 02:21:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adff502000000b0022cc0a2cbecsm18916899wro.15.2022.10.21.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:49 -0700 (PDT)
Message-Id: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:40 +0000
Subject: [PATCH v4 0/8] rebase: make reflog messages independent of the backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some bugs in the reflog messages when rebasing and changes
the reflog messages of "rebase --apply" to match "rebase --merge" with the
aim of making the reflog easier to parse.

Thanks to Junio for his comments, here are the changes since V3:

 * Patch 1: Swapped with patch 2. Small change to fast-forward tests to make
   them pass
 * Patch 2: Swapped with patch 1. Reworded commit message and added a change
   to the fast-forward test to reflect the change in reflog message
   introduced by this patch

The rest of the patches are unchanged.

V2 Cover Letter

Thanks to everyone who commented on V2, I've added the review club
participants that I've got address for to the cc list. I've rebased onto
pw/rebase-keep-base-fixes.

Change since V2:

 * Patch 1: Reworded the commit message to address the concerns in [1,2]
   about the behavior when head_name is NULL. There is also a small change
   due to being rebased.

 * Patch 2: Unchanged. There wasn't much love for parameterized tests in
   review club but we want to ensure both backends produce the same messages
   I think this is the safest way to achieve that. Using separate tests
   makes it too easy to introduce subtle differences in the testing of the
   two backends.

 * Patch 3: Added a note to the commit message to address the concerns in
   [1] about not resetting GIT_REFLOG_ACTION when we return early.

 * Patches 4 & 5: Unchanged.

 * Patch 6: Reworded the commit message to make a stronger argument for this
   change. There are concerns about backwards compatibility in [1,3,4] but
   (i) we have made similar changes in the past without complaints and (ii)
   we're changing the message to an existing format. There is also a small
   change due to being rebased.

 * Patches 7 & 8: Small changes due to rebase.

[1]
https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?pli=1#heading=h.t6g5l2t5ibzw
[2] https://lore.kernel.org/git/xmqq35i7r4rj.fsf@gitster.g/ [3]
https://lore.kernel.org/git/xmqq4k2nmmeg.fsf@gitster.g/ [4]
https://lore.kernel.org/git/220420.865yn4833u.gmgdl@evledraar.gmail.com/

V2 Cover Letter:

Thanks to Christian and Elijah for their comments on V1.

I've updated commit message for patch 1 to try and be clearer about the
removal of a call to strbuf_release() and spilt out the test changes from
the old patch 2 into a separate preparatory patch.

V1 Cover Letter:

This is a series of rebase reflog related patches with the aim of unifying
the reflog messages from the two rebase backends.

 * improve rebase reflog test coverage
 * rebase --merge: fix reflog messages for --continue and --skip
 * rebase --apply: respect GIT_REFLOG_ACTION
 * rebase --abort: improve reflog message
 * unify reflog messages between the two rebase backends

This series is based on pw/use-inprocess-checkout-in-rebase

Phillip Wood (8):
  t3406: rework rebase reflog tests
  rebase --apply: improve fast-forward reflog message
  rebase --merge: fix reflog when continuing
  rebase --merge: fix reflog message after skipping
  rebase --apply: respect GIT_REFLOG_ACTION
  rebase --apply: make reflog messages match rebase --merge
  rebase --abort: improve reflog message
  rebase: cleanup action handling

 builtin/rebase.c          | 146 ++++++++++++------------------
 sequencer.c               |   5 ++
 t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
 3 files changed, 215 insertions(+), 121 deletions(-)


base-commit: aa1df8146d70bb85c63b0999868fe29aebc1173e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1150

Range-diff vs v3:

 2:  b9255ad35d2 ! 1:  8d5ae067ce3 t3406: rework rebase reflog tests
     @@ Commit message
          the "merge" and "apply" backends. The test coverage for the "apply"
          backend now includes setting GIT_REFLOG_ACTION.
      
     -    Note that rebasing the "conflicts" branch does not create any
     -    conflicts yet. A commit to do that will be added in the next commit
     -    and the diff ends up smaller if we have don't rename the branch when
     -    it is added.
     +    Note that rebasing the "conflicts" branch does not create any conflicts
     +    yet. A commit to do that will be added shortly and the diff ends up
     +    smaller if we have don't rename the branch when it is added.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ t/t3406-rebase-message.sh: test_expect_success 'error out early upon -C<n> or --
      +	) &&
      +
      +	git log -g --format=%gs -2 >actual &&
     ++	if test "$mode" = "--apply"
     ++	then
     ++		finish_msg="refs/heads/fast-forward onto $(git rev-parse main)"
     ++	else
     ++		finish_msg="returning to refs/heads/fast-forward"
     ++	fi &&
      +	write_reflog_expect <<-EOF &&
     -+	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
     ++	${reflog_action:-rebase} (finish): $finish_msg
      +	${reflog_action:-rebase} (start): checkout main
       	EOF
       	test_cmp expect actual &&
 1:  a84cf971a75 ! 2:  12701ef7c7c rebase --apply: remove duplicated code
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    rebase --apply: remove duplicated code
     +    rebase --apply: improve fast-forward reflog message
      
     -    Use move_to_original_branch() when reattaching HEAD after a fast-forward
     -    rather than open coding a copy of that code. move_to_original_branch()
     -    does not call reset_head() if head_name is NULL but there should be no
     -    user visible changes even though we currently call reset_head() in that
     -    case. The reason for this is that the reset_head() call does not add a
     -    message to the reflog because we're not changing the commit that HEAD
     -    points to and so lock_ref_for_update() elides the update. When head_name
     -    is not NULL then reset_head() behaves like "git symbolic-ref" and so the
     -    reflog is updated.
     +    Using move_to_original_branch() when reattaching HEAD after a
     +    fast-forward improves HEAD's reflog message when rebasing a branch. This
     +    is because it uses separate reflog messages for "HEAD" and
     +    "branch". HEAD's reflog will now record which branch we're returning to.
      
     -    Note that the removal of "strbuf_release(&msg)" is safe as there is an
     -    identical call just above this hunk which can be seen by viewing the
     -    diff with -U6.
     +    When rebasing a detached HEAD there is no change in behavior. We
     +    currently call reset_head() when head_name is NULL but
     +    move_to_original_branch() does not. However the existing call does not
     +    add a message to the reflog because we're not changing the commit that
     +    HEAD points to and so lock_ref_for_update() skips the update.
      
     +    Note that the removal of "strbuf_reset(&msg)" is safe as there is a call
     +    to strbuf_release(&msf) just above this hunk which can be seen by
     +    viewing the diff with -U6.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		ret = finish_rebase(&options);
       		goto cleanup;
       	}
     +
     + ## t/t3406-rebase-message.sh ##
     +@@ t/t3406-rebase-message.sh: test_reflog () {
     + 	) &&
     + 
     + 	git log -g --format=%gs -2 >actual &&
     +-	if test "$mode" = "--apply"
     +-	then
     +-		finish_msg="refs/heads/fast-forward onto $(git rev-parse main)"
     +-	else
     +-		finish_msg="returning to refs/heads/fast-forward"
     +-	fi &&
     + 	write_reflog_expect <<-EOF &&
     +-	${reflog_action:-rebase} (finish): $finish_msg
     ++	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
     + 	${reflog_action:-rebase} (start): checkout main
     + 	EOF
     + 	test_cmp expect actual &&
 3:  ea4da25a19c = 3:  2c965f4b97c rebase --merge: fix reflog when continuing
 4:  225ff4baef7 = 4:  17138d910f0 rebase --merge: fix reflog message after skipping
 5:  1094681eb11 = 5:  0c71c732904 rebase --apply: respect GIT_REFLOG_ACTION
 6:  a5338e6bdd8 = 6:  3f6b2e39f40 rebase --apply: make reflog messages match rebase --merge
 7:  aa808725fb8 = 7:  c8fa57f129d rebase --abort: improve reflog message
 8:  f9c8664b883 = 8:  ed800844ba1 rebase: cleanup action handling

-- 
gitgitgadget
