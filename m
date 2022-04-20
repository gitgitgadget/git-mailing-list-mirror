Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6607C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377374AbiDTJ7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbiDTJ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2C30F75
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso864355wml.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+mnyiZf/vU1it6bunG6Pw+8z7/2pA5oXGJO1wNl3fQ0=;
        b=MjjY0JFu3K+i4QR+Q3J0uKSMFYgiLLPPF9IibbyGOlNXMPaSgncNx+8x7LS3xRuCZa
         ldj4WdkpHxBcHJVPXi9QaGgO6EPlJbqP7JF/2ylkUly19sNbkW7gReFRMzibdcjWTi95
         AyT+bLLYhGeKJmyTXhIGWAdpTlCbBIIEPquiFzbta23veqcsnRT0rKX/KEEtl8vYcbA0
         Mc8t7pnnC2W0CpEConk+lP55zri4XFSi91xsRDwDXPj/5cUAndQ58KuuOEBDU736DDOE
         9oewgsiJlEA4rorRxabKHDbqIoEuG+1K39SKqjmy1IF5OitE+1hVhc9mDmUP5Uz+4Bi1
         bJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+mnyiZf/vU1it6bunG6Pw+8z7/2pA5oXGJO1wNl3fQ0=;
        b=4DV/zX/4jONjki19p1zQ6vhI/9S+Di1y984t9RsK91o8k6ZC0nBCzWnGnoid/8gTQw
         cjVRB0cAIGRh0GR6Hc9010QRkCKPMbPjTD4xK34TX6POpvqCL818nY6yuokoQWyQPKQp
         skxddVGbGE32R0GKTCyAFTcOYqtgWb0c6gJm1P22Dn76dZQQXIfooj/XWXEM+ima93HM
         6CeZP/c64jzrD1BPoxYUSkoA9UAf9Ap7vpb9LT2WZ8tGO5lgpyAVAE+Ca0S5iZSkSBlC
         DYaaEQyhLzwIjfwCBiagnuYcPBlvX0INtazCL4Aa416WxHIg392WXVbFUiioJJKcaL6x
         dhhA==
X-Gm-Message-State: AOAM533DosoTMHJYZ1+cF9JDTWFTHXbNu86fW+5xao3gWM5yklNnx488
        XQts8x1Utjj0DJM+YXq2ooVyONUiNWU=
X-Google-Smtp-Source: ABdhPJxAe0zKPgbZ+20CvecqU/R8QUweDHoQdBYWDJEZa64W+dwVHqtxbEl0RhxkvUiso7BqlMwI6A==
X-Received: by 2002:a7b:c1c9:0:b0:38e:b92f:a764 with SMTP id a9-20020a7bc1c9000000b0038eb92fa764mr2766242wmj.101.1650448614014;
        Wed, 20 Apr 2022 02:56:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm20792986wmq.35.2022.04.20.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:53 -0700 (PDT)
Message-Id: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:43 +0000
Subject: [PATCH v2 0/8] rebase: make reflog messages independent of the backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
  rebase --apply: remove duplicated code
  t3406: rework rebase reflog tests
  rebase --merge: fix reflog when continuing
  rebase --merge: fix reflog message after skipping
  rebase --apply: respect GIT_REFLOG_ACTION
  rebase --apply: make reflog messages match rebase --merge
  rebase --abort: improve reflog message
  rebase: cleanup action handling

 builtin/rebase.c          | 144 ++++++++++++-----------------
 sequencer.c               |   5 ++
 t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
 3 files changed, 214 insertions(+), 120 deletions(-)


base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1150

Range-diff vs v1:

 1:  243e7b0c372 ! 1:  a4320f2fcf3 rebase --apply: remove duplicated code
     @@ Commit message
          to do as we have already updated HEAD.
      
          Note that the removal of "strbuf_release(&msg)" is safe as there is an
     -    identical call just above this hunk.
     +    identical call just above this hunk which can be seen by viewing the
     +    diff with -U6.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
 2:  493254ffbb8 ! 2:  0904b50a377 rebase --merge: fix reflog when continuing
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    rebase --merge: fix reflog when continuing
     +    t3406: rework rebase reflog tests
      
     -    The reflog message for a conflict resolution committed by "rebase
     -    --continue" looks like
     +    Refactor the tests in preparation for adding more tests in the next
     +    few commits. The reworked tests use the same function for testing both
     +    the "merge" and "apply" backends. The test coverage for the "apply"
     +    backend now includes setting GIT_REFLOG_ACTION.
      
     -            rebase (continue): commit subject line
     -
     -    Unfortunately the reflog message each subsequent pick look like
     -
     -            rebase (continue) (pick): commit subject line
     -
     -    Fix this by setting the reflog message for "rebase --continue" in
     -    sequencer_continue() so it does not affect subsequent commits. This
     -    introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
     -    in pick_commits(). Both of these will be fixed in a future series that
     -    stops the sequencer calling setenv().
     +    Note that rebasing the "conflicts" branch does not create any
     +    conflicts yet. A commit to do that will be added in the next commit
     +    and the diff ends up smaller if we have don't rename the branch when
     +    it is added.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     - ## builtin/rebase.c ##
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		int fd;
     - 
     - 		options.action = "continue";
     --		set_reflog_action(&options);
     --
     - 		/* Sanity check */
     - 		if (get_oid("HEAD", &head))
     - 			die(_("Cannot read HEAD"));
     -
     - ## sequencer.c ##
     -@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
     - 	if (read_populate_opts(opts))
     - 		return -1;
     - 	if (is_rebase_i(opts)) {
     -+		char *previous_reflog_action;
     -+
     - 		if ((res = read_populate_todo(r, &todo_list, opts)))
     - 			goto release_todo_list;
     - 
     -@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
     - 			unlink(rebase_path_dropped());
     - 		}
     - 
     -+		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
     -+		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
     - 		if (commit_staged_changes(r, opts, &todo_list)) {
     - 			res = -1;
     - 			goto release_todo_list;
     - 		}
     -+		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
     - 	} else if (!file_exists(get_todo_path(opts)))
     - 		return continue_single_pick(r, opts);
     - 	else if ((res = read_populate_todo(r, &todo_list, opts)))
     -
       ## t/t3406-rebase-message.sh ##
      @@ t/t3406-rebase-message.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       test_expect_success 'setup' '
     @@ t/t3406-rebase-message.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
      +	git checkout -b conflicts O &&
      +	test_commit P &&
     -+	test_commit conflict-X fileX &&
      +	test_commit Q &&
      +
       	git checkout -b topic O &&
     @@ t/t3406-rebase-message.sh: test_expect_success 'error out early upon -C<n> or --
      +			GIT_REFLOG_ACTION="$reflog_action" &&
      +			export GIT_REFLOG_ACTION
      +		fi &&
     -+		test_must_fail git rebase $mode main &&
     -+		echo resolved >fileX &&
     -+		git add fileX &&
     -+		git rebase --continue
     ++		git rebase $mode main
      +	) &&
      +
     -+	git log -g --format=%gs -5 >actual &&
     ++	git log -g --format=%gs -4 >actual &&
      +	write_reflog_expect <<-EOF &&
      +	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
      +	${reflog_action:-rebase} (pick): Q
     -+	${reflog_action:-rebase} (continue): conflict-X
      +	${reflog_action:-rebase} (pick): P
      +	${reflog_action:-rebase} (start): checkout main
       	EOF
 -:  ----------- > 3:  6c15f00e170 rebase --merge: fix reflog when continuing
 3:  f4e6e94bc2c = 4:  d3afa85ffc5 rebase --merge: fix reflog message after skipping
 4:  58c560d0e19 = 5:  afa67abe01a rebase --apply: respect GIT_REFLOG_ACTION
 5:  1c3ec165422 = 6:  95161f21e00 rebase --apply: make reflog messages match rebase --merge
 6:  c863cebbdc8 = 7:  d2c1dfbcd5e rebase --abort: improve reflog message
 7:  d26a221a79d = 8:  b0d21affa78 rebase: cleanup action handling

-- 
gitgitgadget
