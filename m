Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D059BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355114AbiDZUqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiDZUqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4E139752
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so1216806wms.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p31vr7WOOjc2eElGdYDRECwPvT/qiNYQuKTKEigyvr8=;
        b=H0+A8bmdGsyzLFtGsiySA9P8I4kyLWJY1ViqCXW2kSZTHjG4w7NdIqWKrlGTJRX7I2
         /zukNn6TWKzBY1vMwgc7gyB4fSDaSQTLKGoKGs5qGmsY+C+jy/KdIFzM8zwNFCXlOz/i
         dog62Cl4xqT5imgVCuk/FZUNK1li/KZwyvzYqB59DEbzrEbDL56JdQVLhzdHdE5w2jo7
         whM5CjDAAYCkhRklS35cdD+hiEA4DTEW9CjDU3hv8PgVhxw5JVhUiF/5dKkE/DOpoubT
         a99uI4bv4LPRLu5BQpZWyXicBtOnjsaTr2NVTBPsAg0dhExSodE8NjdD67HT1fWddVhG
         I+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p31vr7WOOjc2eElGdYDRECwPvT/qiNYQuKTKEigyvr8=;
        b=TqrRtssgWBFsGWEPD+ZA5VJ8uOQiF7NW5vYaEQVQBLfmj22iXszwSmOHXSWE2j5gYG
         uHMsyza/RuYQF2uo4dx4n95C+pQAcfZMctetimQjvQhHIowi56i+HQNwBrjGPZV5iwC8
         CvaHvigKSAD7DL+XVYKhb8QluX15FAAoGPSSp1ihCvbXm4BzBynhFEhQOkqtRa8dY/AM
         cZ+EGektn4Y8+RyMIKvmYCM6D5FF8mq0fJ9OXaCx1o9qhP3WqjAQtKQFlja3AtC/bgN7
         Zmal0sA4WfHD1x8vZI+BeqBbqaF0XuuksKcguzLzfj2laBFzJybMm4mk/FghEDxX5RLh
         wgMg==
X-Gm-Message-State: AOAM530jPyp3ZkHAGJp6YA8mxwLa7bVzhBWkkLKqXVTGUrkLGAp0Vzpw
        O5QoeIt/t7mDOB2lFBqA3cNN2Cd798s=
X-Google-Smtp-Source: ABdhPJxfNZ6FXWLS5JX9+K2w3BdxLhX3bnEl33NsEDAkL+FBTMGgdiaN4ja30119D5aeevrjw0LKzQ==
X-Received: by 2002:a1c:44d7:0:b0:38e:ab4e:912f with SMTP id r206-20020a1c44d7000000b0038eab4e912fmr22455882wma.175.1651005801935;
        Tue, 26 Apr 2022 13:43:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0039082eeff53sm88398wms.22.2022.04.26.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:21 -0700 (PDT)
Message-Id: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:15 +0000
Subject: [PATCH v2 0/5] Sparse index integration with 'git show'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues our sequence of integrating builtins with the sparse index.

'git show' is relatively simple to get working in a way that doesn't fail
when it would previously succeed, but there are some subtleties when the
user passes a directory path using the ":" syntax to get the path out of the
index. If that path happens to be a sparse directory entry, we suddenly
start succeeding and printing the tree information!

Since this behavior can change depending on the sparse checkout definition
and the state of index entries within that directory, this new behavior
would be more likely to confuse users than help them.

This ":" syntax is shared by other commands like "git rev-parse", but we are
not adding those integrations at this point.

Some background: as we shipped our sparse index integrations in the
microsoft/git fork and measured performance of real users, we noticed that
'git show' was a frequently-used command that went from ~0.5 seconds to ~4
seconds in monorepo situations. This was unexpected, because we didn't know
about the ":" syntax. Further, it seemed that some third-party tools were
triggering this behavior as a frequent way to check on staged content. That
motivated quickly shipping this integration. Performance improved to ~0.1
seconds because of the reduced index size. While inspecting our rebase of
microsoft/git commits onto the 2.36.0 release candidates, I noticed this
integration would be a simpler example to demonstrate how sparse index
integrations should go when the behavior is not too complicated.

Here is an outline of this series:

 * Patch 1: Add more tests around 'git show :' in t1092. These tests are
   only to establish the existing differences between the full and
   sparse-checkout cases, since 'git show' is still protected by
   'command_requires_full_index'.

 * Patch 2: Make 'git show' stop expanding the index by default. Make note
   of this behavior change in the tests.

 * Patches 3-4: Make the subtle changes to object-name.c that help us reject
   sparse directories (patch 3) and print the correct error message (patch
   4).

 * Patch 5: Now that the common index-parsing code is updated, do the
   minimum change to 'git rev-parse' to avoid expanding the index to parse
   index entries for a sparse index.

Patches 2-4 could realistically be squashed into a single commit, but I
thought it might be instructive to show these individual steps, especially
as an example for our GSoC project.

I know that Victoria intends to submit her 'git stash' integration soon, and
this provides a way to test if our split of test changes in t1092 are easy
to merge without conflict. If that is successful, then I will likely submit
my integration with the 'sparse-checkout' builtin after this series is
complete. (UPDATE: we inserted a test in the same location of t1092, but
otherwise there are no textual or semantic conflicts.)


Updates in v2
=============

 * The test comment in patch 2 is updated.
 * A commit message typo in patch 4 is fixed.
 * Patch 4 simplified the behavior, but the previous version didn't clean up
   a test comment about that. It now cleans up the test to be simpler.
 * Patch 5 includes an integration with 'git rev-parse'.
 * The cover letter is expanded with more context.
 * The only conflict with Victoria's new 'git stash' patch series is that we
   both added a test in the same position of t1092. Including both new tests
   is the right way to resolve the conflict. Order does not matter.

[1]
https://lore.kernel.org/git/pull.1171.git.1650908957.gitgitgadget@gmail.com/

Thanks, -Stolee

Derrick Stolee (5):
  t1092: add compatibility tests for 'git show'
  show: integrate with the sparse index
  object-name: reject trees found in the index
  object-name: diagnose trees in index properly
  rev-parse: integrate with sparse index

 builtin/log.c                            |  5 ++++
 builtin/rev-parse.c                      |  3 ++
 object-name.c                            | 25 ++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 36 ++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 3 deletions(-)


base-commit: 07330a41d66a2c9589b585a3a24ecdcf19994f19
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1207%2Fderrickstolee%2Fsparse-index%2Fgit-show-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1207/derrickstolee/sparse-index/git-show-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1207

Range-diff vs v1:

 1:  8c2fdb5a4fc = 1:  8c2fdb5a4fc t1092: add compatibility tests for 'git show'
 2:  27ab853a9b4 ! 2:  2e9d47ab09b show: integrate with the sparse index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'show (cached blob
      -	# does not work as implemented. The error message is
      -	# different for a full checkout and a sparse checkout
      -	# when the directory is outside of the cone.
     -+	# changes depending on the existence of a sparse index.
     ++	# had different behavior depending on the existence
     ++	# of a sparse index.
       	test_all_match test_must_fail git show :deep/ &&
       	test_must_fail git -C full-checkout show :folder1/ &&
      -	test_sparse_match test_must_fail git show :folder1/
 3:  f5da5327673 = 3:  5a7561637f0 object-name: reject trees found in the index
 4:  99c09ccc240 ! 4:  b730457fccc object-name: diagnose trees in index properly
     @@ Commit message
          checkout. The error message from diagnose_invalid_index_path() reports
          whether the path is on disk or not. The full checkout will have the
          directory on disk, but the path will not be in the index. The sparse
     -    checokut could have the directory not exist, specifically when that
     +    checkout could have the directory not exist, specifically when that
          directory is outside of the sparse-checkout cone.
      
          In the case of a sparse index, we have yet another state: the path can
     @@ object-name.c: static void diagnose_invalid_index_path(struct repository *r,
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'show (cached blobs/trees)' '
     + 	test_all_match git show :deep/a &&
     + 	test_sparse_match git show :folder1/a &&
     + 
     +-	# Asking "git show" for directories in the index
     +-	# had different behavior depending on the existence
     +-	# of a sparse index.
     ++	# The error message differs depending on whether
     ++	# the directory exists in the worktree.
     + 	test_all_match test_must_fail git show :deep/ &&
       	test_must_fail git -C full-checkout show :folder1/ &&
     - 	test_must_fail git -C sparse-checkout show :folder1/ &&
     +-	test_must_fail git -C sparse-checkout show :folder1/ &&
     ++	test_sparse_match test_must_fail git show :folder1/ &&
       
      -	test_must_fail git -C sparse-index show :folder1/ 2>err &&
      -	grep "is in the index, but not at stage 0" err
     -+	test_sparse_match test_must_fail git show :folder1/ &&
     -+
      +	# Change the sparse cone for an extra case:
      +	run_on_sparse git sparse-checkout set deep/deeper1 &&
      +
 -:  ----------- > 5:  69efe637a18 rev-parse: integrate with sparse index

-- 
gitgitgadget
