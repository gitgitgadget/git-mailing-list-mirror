Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A5C2D0E5
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F2120722
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmh4ztgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZV1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43681 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZV1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id bd14so8662908edb.10
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/G3jnGvUgTX/zJDKHHubcAboRvj1ffl8Gsjm0K6JpE=;
        b=Jmh4ztgBAObyfK8Fn1ONL8mtJCZkxOvGz7FRCh6D3ygny7d/0yc8H+ghwfxmhb14xr
         6DIZtf2WB+ZgFUqIybLsB6IbtW8EAgm4jtaWuB4Rp21gTfUovTu0RrLRL2yYLuHeqIyi
         IEAs2fZGdACc13xVGZegw2ULqDNPFmWoyaxB9cgonBW8R6c1m0WSeHkgGVORcqt0ZXLD
         zyZe1iFhshd5VwoT7ak8pOLIV4LhoVEnh7nszUvOQtp+fq/olPorsbZj4rXJTVogLz47
         c3O0ui0PFaNkefduZ+pDWJWl6bc+n9HowFIbh6Qd7Ofp0kufJ1Pu8+LQ7vdaVQI1PA17
         8oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/G3jnGvUgTX/zJDKHHubcAboRvj1ffl8Gsjm0K6JpE=;
        b=W8ES4Tz67GzWiUz4fTCTJGIeKYqwQqyY9sj8H5GMPi6obCILYIUDbB8AGQg77A6yum
         d1OXEP19kfDvUEINRTCE9DeZygNX1Cb1Op/mXwYF+WYWb0++F3YXXNgs9tya73d1Wddy
         jAGthPtJxXOFVJjXXPSH/4zK0zArayLoH+aGlq697PnTdJ/gBzB7avZjZvD2lWEjHjtk
         m0p2j0uSCgBeNuVT7f9qJRHBofzRfvVdx9sHL/eKX323OazNlMruCg8Y6Cj8OqWPI93o
         pdpY2IaIyuxdqbIGPxENV/wH9M4JofpfB4x3miYnKl4IVTqSIrqAenz075lsxmZfZYdi
         bQtg==
X-Gm-Message-State: ANhLgQ23MGhadsDwKwwZiLqe9q6RwI0YmZFQOOs7t4sPvtnKWDuSywcZ
        YhHuj6eaa43vPoOvBQwRcefydH5E
X-Google-Smtp-Source: ADFU+vuZRBX8KLkYPs15HSzEALHkPzXHo1QYWRM10q5CgkXI2wyVkGhgM1NCSmnYaeieesBFL2tc0w==
X-Received: by 2002:a50:e043:: with SMTP id g3mr10629871edl.220.1585258062564;
        Thu, 26 Mar 2020 14:27:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm548404edw.19.2020.03.26.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:41 -0700 (PDT)
Message-Id: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:33 +0000
Subject: [PATCH v4 0/7] Avoid multiple recursive calls for same path in read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides some "modest" speedups (see last commit message), and
should allow 'git status --ignored' to complete in a more reasonable
timeframe for Martin Melka (see 
https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
).

Changes since v3:

 * Turns out I was wrong about the untracked cache stuff and had some bugs
   around untracked directories with nothing bug ignored sub-entries.
 * First patch now is no longer a change of expectation of the untracked
   cache, but some more thorough testing/verification in that test that
   helped explain my misunderstanding and uncover the bug in my refactor.
 * Corrected the check_only and stop_at_first_file logic in the last patch
   and added a big comment explaining how/why it all works. Also stopped
   disabling part of the untracked cache in the same patch, and undid all
   the changes to t7063 in that patch.

Stuff still missing from v4:

 * I didn't make the DIR_KEEP_UNTRACKED_CONTENTS changes I mentioned in 
   https://lore.kernel.org/git/CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com/ 
   which I think would make the code cleaner & clearer. I guess I'm leaving
   that for future work.

As per the commit message of the final patch, this series has some risk.
Extra eyes would be greatly appreciated; one pair already helped me find one
bug. Also, we should probably merge it early in some cycle, either this one
or a later one.

Derrick Stolee (1):
  dir: refactor treat_directory to clarify control flow

Elijah Newren (6):
  t7063: more thorough status checking
  dir: fix simple typo in comment
  dir: consolidate treat_path() and treat_one_path()
  dir: fix broken comment
  dir: fix confusion based on variable tense
  dir: replace exponential algorithm with a linear one

 dir.c                             | 349 ++++++++++++++++++------------
 t/t7063-status-untracked-cache.sh |  52 +++++
 2 files changed, 258 insertions(+), 143 deletions(-)


base-commit: 0cbb60574e741e8255ba457606c4c90898cfc755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-700%2Fnewren%2Ffill-directory-exponential-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-700/newren/fill-directory-exponential-v4
Pull-Request: https://github.com/git/git/pull/700

Range-diff vs v3:

 1:  d4fe5d33577 ! 1:  752403e339b t7063: correct broken test expectation
     @@ -1,61 +1,23 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    t7063: correct broken test expectation
     +    t7063: more thorough status checking
      
     -    The untracked cache is caching wrong information, resulting in commands
     -    like `git status --porcelain` producing erroneous answers.  The tests in
     -    t7063 actually have a wide enough test to catch a relevant case, in
     -    particular surrounding the directory 'dthree/', but it appears the
     -    answers were not checked quite closely enough and the tests were coded
     -    with the wrong expectation.  Once the wrong info got into the cache in
     -    an early test, since later tests built on it, many others have a wrong
     -    expectation as well.  This affects just over a third of the tests in
     -    t7063.
     +    It turns out the t7063 has some testcases that even without using the
     +    untracked cache cover situations that nothing else in the testsuite
     +    handles.  Checking the results of
     +      git status --porcelain
     +    both with and without the untracked cache, and comparing both against
     +    our expected results helped uncover a critical bug in some dir.c
     +    restructuring.
      
     -    The error can be seen starting at t7063.12 (the first one switched from
     -    expect_success to expect_failure in this patch).  That test runs in a
     -    directory with the following files present:
     -      done/one
     -      dthree/three
     -      dtwo/two
     -      four
     -      .gitignore
     -      one
     -      three
     -      two
     +    Unfortunately, it's not easy to run status and tell it to ignore the
     +    untracked cache; the only knob we have it to instruct it to *delete*
     +    (and ignore) the untracked cache.
      
     -    Of those files, the following files are tracked:
     -      done/one
     -      one
     -      two
     -
     -    and the contents of .gitignore are:
     -      four
     -
     -    and the contents of .git/info/exclude are:
     -      three
     -
     -    And there is no core.excludesfile.  Therefore, the following should be
     -    untracked:
     -      .gitignore
     -      dthree/
     -      dtwo/
     -    Indeed, these three paths are reported if you run
     -      git ls-files -o --directory --exclude-standard
     -    within this directory.  However, 'git status --porcelain' was reporting
     -    for this test:
     -      A  done/one
     -      A  one
     -      A  two
     -      ?? .gitignore
     -      ?? dtwo/
     -    which was clearly wrong -- dthree/ should also be listed as untracked.
     -    This appears to have been broken since the test was introduced with
     -    commit a3ddcefd97 ("t7063: tests for untracked cache", 2015-03-08).
     -    Correct the test to expect the right output, marking the test as failed
     -    for now.  Make the same change throughout the remainder of the testsuite
     -    to reflect that dthree/ remains an untracked directory throughout and
     -    should be recognized as such.
     +    Create a simple helper that will create a clone of the index that is
     +    missing the untracked cache bits, and use it to compare that the results
     +    with the untracked cache match the results we get without the untracked
     +    cache.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -63,279 +25,230 @@
       --- a/t/t7063-status-untracked-cache.sh
       +++ b/t/t7063-status-untracked-cache.sh
      @@
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_success 'new info/exclude invalidates everything' '
     -+test_expect_failure 'new info/exclude invalidates everything' '
     - 	avoid_racy &&
     - 	echo three >>.git/info/exclude &&
     + 	test_must_be_empty ../status.actual
     + }
     + 
     ++# Ignore_Untracked_Cache, abbreviated to 3 letters because then people can
     ++# compare commands side-by-side, e.g.
     ++#    iuc status --porcelain >expect &&
     ++#    git status --porcelain >actual &&
     ++#    test_cmp expect actual
     ++iuc() {
     ++	git ls-files -s >../current-index-entries
     ++	git ls-files -t | grep ^S | sed -e s/^S.// >../current-sparse-entries
     ++
     ++	GIT_INDEX_FILE=.git/tmp_index
     ++	export GIT_INDEX_FILE
     ++	git update-index --index-info <../current-index-entries
     ++	git update-index --skip-worktree $(cat ../current-sparse-entries)
     ++
     ++	git -c core.untrackedCache=false "$@"
     ++	ret=$?
     ++
     ++	rm ../current-index-entries
     ++	rm $GIT_INDEX_FILE
     ++	unset GIT_INDEX_FILE
     ++
     ++	return $ret
     ++}
     ++
     + test_lazy_prereq UNTRACKED_CACHE '
     + 	{ git update-index --test-untracked-cache; ret=$?; } &&
     + 	test $ret -ne 1
     +@@
       	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 3
     +@@
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
     + A  done/one
       A  one
     - A  two
     - ?? .gitignore
     -+?? dthree/
     - ?? dtwo/
     +@@
     + ?? four
     + ?? three
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'verify untracked cache dump' '
     -+test_expect_failure 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
     + A  done/one
     + A  one
      @@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     + ?? dtwo/
     + ?? three
     + EOF
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_success 'status after the move' '
     -+test_expect_failure 'status after the move' '
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
       	git status --porcelain >../actual &&
     -@@
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
       A  done/one
       A  one
     +@@
       ?? .gitignore
     -+?? dthree/
       ?? dtwo/
     - ?? two
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'verify untracked cache dump' '
     -+test_expect_failure 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
     + A  done/one
     + A  one
      @@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - two
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     + ?? dtwo/
     + ?? two
     + EOF
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_success 'status after the move' '
     -+test_expect_failure 'status after the move' '
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
       	git status --porcelain >../actual &&
     -@@
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
     + A  done/one
       A  one
     - A  two
     +@@
       ?? .gitignore
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'verify untracked cache dump' '
     -+test_expect_failure 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     -@@
     - 	git commit -m "first commit"
     - '
     - 
     --test_expect_success 'status after commit' '
     -+test_expect_failure 'status after commit' '
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
       	git status --porcelain >../actual &&
     ++	iuc status --porcelain >../status.iuc &&
       	cat >../status.expect <<EOF &&
       ?? .gitignore
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'untracked cache correct after commit' '
     -+test_expect_failure 'untracked cache correct after commit' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     -@@
     - 	sync_mtime
     - '
     - 
     --test_expect_success 'test sparse status with untracked cache' '
     -+test_expect_failure 'test sparse status with untracked cache' '
     - 	: >../trace &&
       	avoid_racy &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     + 	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
        M done/two
       ?? .gitignore
       ?? done/five
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../status.actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'untracked cache correct after status' '
     -+test_expect_failure 'untracked cache correct after status' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     - five
     -@@
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_success 'test sparse status again with untracked cache' '
     -+test_expect_failure 'test sparse status again with untracked cache' '
     - 	avoid_racy &&
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     + 	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
        M done/two
       ?? .gitignore
       ?? done/five
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../status.actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	echo "sub" > done/sub/sub/file
     - '
     - 
     --test_expect_success 'test sparse status with untracked cache and subdir' '
     -+test_expect_failure 'test sparse status with untracked cache and subdir' '
     - 	avoid_racy &&
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     + 	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
     + 	cat >../status.expect <<EOF &&
     +  M done/two
       ?? .gitignore
     - ?? done/five
     +@@
       ?? done/sub/
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../status.actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 2
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
     -+test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect-from-test-dump <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     - .gitignore
     -+dthree/
     - dtwo/
     - /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     - five
     -@@
     - 	test_cmp ../expect-from-test-dump ../actual
     - '
     - 
     --test_expect_success 'test sparse status again with untracked cache and subdir' '
     -+test_expect_failure 'test sparse status again with untracked cache and subdir' '
     - 	avoid_racy &&
       	: >../trace &&
       	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
     ++	test_cmp ../status.expect ../status.iuc &&
     + 	test_cmp ../status.expect ../status.actual &&
     + 	cat >../trace.expect <<EOF &&
     + node creation: 0
      @@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_success 'move entry in subdir from untracked to cached' '
     -+test_expect_failure 'move entry in subdir from untracked to cached' '
     + test_expect_success 'move entry in subdir from untracked to cached' '
       	git add dtwo/two &&
       	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
       	cat >../status.expect <<EOF &&
     +  M done/two
     + A  dtwo/two
      @@
     - ?? .gitignore
       ?? done/five
       ?? done/sub/
     -+?? dthree/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../status.actual
       '
       
     --test_expect_success 'move entry in subdir from cached to untracked' '
     -+test_expect_failure 'move entry in subdir from cached to untracked' '
     + test_expect_success 'move entry in subdir from cached to untracked' '
       	git rm --cached dtwo/two &&
       	git status --porcelain >../status.actual &&
     ++	iuc status --porcelain >../status.iuc &&
       	cat >../status.expect <<EOF &&
     -@@
     +  M done/two
       ?? .gitignore
     - ?? done/five
     +@@
       ?? done/sub/
     -+?? dthree/
       ?? dtwo/
       EOF
     ++	test_cmp ../status.expect ../status.iuc &&
       	test_cmp ../status.expect ../status.actual
     -@@
     - 	test_cmp ../expect-no-uc ../actual
     - '
     - 
     --test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
     -+test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
     - 	git config core.untrackedCache true &&
     - 	test-tool dump-untracked-cache >../actual &&
     - 	test_cmp ../expect-no-uc ../actual &&
     -@@
     - 	test_cmp ../expect-empty ../actual
       '
       
     --test_expect_success 'setting core.untrackedCache to keep' '
     -+test_expect_failure 'setting core.untrackedCache to keep' '
     - 	git config core.untrackedCache keep &&
     - 	git update-index --untracked-cache &&
     - 	test-tool dump-untracked-cache >../actual &&
 2:  b20bc3b9afd = 2:  a4287d690be dir: fix simple typo in comment
 3:  fa9035949e0 = 3:  48f37e5b114 dir: consolidate treat_path() and treat_one_path()
 4:  02e652d1869 = 4:  b5ad1939379 dir: fix broken comment
 5:  705c008d993 = 5:  2603c1a9d13 dir: fix confusion based on variable tense
 6:  f5d69102946 = 6:  576f364329d dir: refactor treat_directory to clarify control flow
 7:  6cfca619e2c ! 7:  e20525429e5 dir: replace exponential algorithm with a linear one, fix untracked cache
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    dir: replace exponential algorithm with a linear one, fix untracked cache
     +    dir: replace exponential algorithm with a linear one
      
          dir's read_directory_recursive() naturally operates recursively in order
          to walk the directory tree.  Treating of directories is sometimes weird
     @@ -161,28 +161,6 @@
          to have completed the 240 nested directories case.  It's not often
          that you get to speed something up by a factor of 3*10^69.
      
     -    Finally, this also fixes the untracked cache, as noted by the test fixes
     -    in t7063.  Unfortunately, it does so by passing stop_at_first_file to
     -    close_cached_dir() in order to disable the caching of whether
     -    directories were empty (this caching was only relevant for directories
     -    that we knew we didn't need to walk all the entries under but just
     -    needed to know whether the directory had any entries within it in order
     -    to know if the directory itself should be marked as path_none or
     -    path_untracked).  I'm not convinced that disabling the is-the-dir-empty
     -    check is necessary; there is probably some way to still cache that and
     -    not get erroneous results.  However, I have not figured out how to do
     -    so.  If I revert the change to close_cached_dir() in this patch (thus
     -    continuing to cache cases where stop_at_first_file is true meaning we
     -    continue to cache whether directories are empty), then the untracked
     -    cache breakage in t7063 becomes more prevalant.  With my change to
     -    close_cached_dir() and the other changes to avoid traversing directories
     -    2^n times in this patch, I not only avoid making the untracked_cache
     -    breakage in t7063 worse but actually fix the existing breakage.  Update
     -    the test results in t7063 to no longer expect check_only cache entries,
     -    to reflect that we have to do a bit more work in terms of how many
     -    directories we have to open, and to reflect that we fixed the 1/3 of
     -    tests that were broken in that testsuite.
     -
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/dir.c b/dir.c
     @@ -199,7 +177,7 @@
      +	 *          you CAN'T DO BOTH.
      +	 */
      +	enum path_treatment state;
     -+	int nested_repo = 0, old_ignored_nr, stop_early;
     ++	int nested_repo = 0, old_ignored_nr, check_only, stop_early;
       	/* The "len-1" is to strip the final '/' */
       	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
       
     @@ -220,16 +198,32 @@
       		return excluded ? path_excluded : path_untracked;
       
      +	/*
     -+	 * If we only want to determine if dirname is empty, then we can
     -+	 * stop at the first file we find underneath that directory rather
     -+	 * than continuing to recurse beyond it.  If DIR_SHOW_IGNORED_TOO
     -+	 * is set, then we want MORE than just determining if dirname is
     -+	 * empty.
     ++	 * If we have we don't want to know the all the paths under an
     ++	 * untracked or ignored directory, we still need to go into the
     ++	 * directory to determine if it is empty (because an empty directory
     ++	 * should be path_none instead of path_excluded or path_untracked).
      +	 */
     -+	stop_early = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
     ++	check_only = ((dir->flags & DIR_HIDE_EMPTY_DIRECTORIES) &&
      +		      !(dir->flags & DIR_SHOW_IGNORED_TOO));
      +
      +	/*
     ++	 * However, there's another optimization possible as a subset of
     ++	 * check_only, based on the cases we have to consider:
     ++	 *   A) Directory matches no exclude patterns:
     ++	 *     * Directory is empty => path_none
     ++	 *     * Directory has an untracked file under it => path_untracked
     ++	 *     * Directory has only ignored files under it => path_excluded
     ++	 *   B) Directory matches an exclude pattern:
     ++	 *     * Directory is empty => path_none
     ++	 *     * Directory has an untracked file under it => path_excluded
     ++	 *     * Directory has only ignored files under it => path_excluded
     ++	 * In case A, we can exit as soon as we've found an untracked
     ++	 * file but otherwise have to walk all files.  In case B, though,
     ++	 * we can stop at the first file we find under the directory.
     ++	 */
     ++	stop_early = check_only && excluded;
     ++
     ++	/*
      +	 * If /every/ file within an untracked directory is ignored, then
      +	 * we want to treat the directory as ignored (for e.g. status
      +	 * --porcelain), without listing the individual ignored files
     @@ -243,7 +237,7 @@
       	untracked = lookup_untracked(dir->untracked, untracked,
       				     dirname + baselen, len - baselen);
      +	state = read_directory_recursive(dir, istate, dirname, len, untracked,
     -+					 stop_early, stop_early, pathspec);
     ++					 check_only, stop_early, pathspec);
      +
      +	/* There are a variety of reasons we may need to fixup the state... */
      +	if (state == path_excluded) {
     @@ -281,25 +275,25 @@
      +			dir->ignored_nr = old_ignored_nr;
      +		}
      +	}
     - 
     - 	/*
     --	 * If this is an excluded directory, then we only need to check if
     --	 * the directory contains any files.
     ++
     ++	/*
      +	 * If there is nothing under the current directory and we are not
      +	 * hiding empty directories, then we need to report on the
      +	 * untracked or ignored status of the directory itself.
     - 	 */
     --	return read_directory_recursive(dir, istate, dirname, len,
     --					untracked, 1, excluded, pathspec);
     ++	 */
      +	if (state == path_none && !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
      +		state = excluded ? path_excluded : path_untracked;
     -+
     -+	/*
     + 
     + 	/*
     +-	 * If this is an excluded directory, then we only need to check if
     +-	 * the directory contains any files.
      +	 * We can recurse into untracked directories that don't match any
      +	 * of the given pathspecs when some file underneath the directory
      +	 * might match one of the pathspecs.  If so, we should make sure
      +	 * to note that the directory itself did not match.
     -+	 */
     + 	 */
     +-	return read_directory_recursive(dir, istate, dirname, len,
     +-					untracked, 1, excluded, pathspec);
      +	if (pathspec &&
      +	    !match_pathspec(istate, pathspec, dirname, len,
      +			    0 /* prefix */, NULL,
     @@ -322,24 +316,6 @@
       	strbuf_setlen(path, baselen);
       	if (!cdir->ucd) {
       		strbuf_addstr(path, cdir->file);
     -@@
     - 	return -1;
     - }
     - 
     --static void close_cached_dir(struct cached_dir *cdir)
     -+static void close_cached_dir(struct cached_dir *cdir, int stop_at_first_file)
     - {
     - 	if (cdir->fdir)
     - 		closedir(cdir->fdir);
     -@@
     - 	 * We have gone through this directory and found no untracked
     - 	 * entries. Mark it valid.
     - 	 */
     --	if (cdir->untracked) {
     -+	if (!stop_at_first_file && cdir->untracked) {
     - 		cdir->untracked->valid = 1;
     - 		cdir->untracked->recurse = 1;
     - 	}
      @@
       	int stop_at_first_file, const struct pathspec *pathspec)
       {
     @@ -373,15 +349,6 @@
       			struct untracked_cache_dir *ud;
       			ud = lookup_untracked(dir->untracked, untracked,
       					      path.buf + baselen,
     -@@
     - 						    istate, &path, baselen,
     - 						    pathspec, state);
     - 	}
     --	close_cached_dir(&cdir);
     -+	close_cached_dir(&cdir, stop_at_first_file);
     -  out:
     - 	strbuf_release(&path);
     - 
      @@
       			      const char *path, int len,
       			      const struct pathspec *pathspec)
     @@ -423,342 +390,3 @@
       
       		if (state != path_recurse)
       			break; /* do not recurse into it */
     -
     - diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
     - --- a/t/t7063-status-untracked-cache.sh
     - +++ b/t/t7063-status-untracked-cache.sh
     -@@
     - dtwo/
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 
     - test_expect_success 'status first time (empty cache)' '
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 0
     - directory invalidation: 1
     --opendir: 1
     -+opendir: 3
     - EOF
     - 	test_cmp ../trace.expect ../trace
     - 
     -@@
     - four
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 1
     - directory invalidation: 1
     - opendir: 4
     -@@
     - dtwo/
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_failure 'new info/exclude invalidates everything' '
     -+test_expect_success 'new info/exclude invalidates everything' '
     - 	avoid_racy &&
     - 	echo three >>.git/info/exclude &&
     - 	: >../trace &&
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 1
     - directory invalidation: 0
     - opendir: 4
     -@@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'verify untracked cache dump' '
     -+test_expect_success 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_failure 'status after the move' '
     -+test_expect_success 'status after the move' '
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     - 	git status --porcelain >../actual &&
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 0
     - directory invalidation: 0
     --opendir: 1
     -+opendir: 3
     - EOF
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'verify untracked cache dump' '
     -+test_expect_success 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - dtwo/
     - two
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - flags 00000006
     - / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_failure 'status after the move' '
     -+test_expect_success 'status after the move' '
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     - 	git status --porcelain >../actual &&
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 0
     - directory invalidation: 0
     --opendir: 1
     -+opendir: 3
     - EOF
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'verify untracked cache dump' '
     -+test_expect_success 'verify untracked cache dump' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - 	git commit -m "first commit"
     - '
     - 
     --test_expect_failure 'status after commit' '
     -+test_expect_success 'status after commit' '
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     - 	git status --porcelain >../actual &&
     -@@
     - EOF
     - 	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 0
     - directory invalidation: 0
     --opendir: 2
     -+opendir: 4
     - EOF
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'untracked cache correct after commit' '
     -+test_expect_success 'untracked cache correct after commit' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - dthree/
     - dtwo/
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - 	sync_mtime
     - '
     - 
     --test_expect_failure 'test sparse status with untracked cache' '
     -+test_expect_success 'test sparse status with untracked cache' '
     - 	: >../trace &&
     - 	avoid_racy &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     - EOF
     - 	test_cmp ../status.expect ../status.actual &&
     - 	cat >../trace.expect <<EOF &&
     --node creation: 0
     -+node creation: 2
     - gitignore invalidation: 1
     - directory invalidation: 2
     --opendir: 2
     -+opendir: 4
     - EOF
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'untracked cache correct after status' '
     -+test_expect_success 'untracked cache correct after status' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - dtwo/
     - /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     - five
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     - 
     --test_expect_failure 'test sparse status again with untracked cache' '
     -+test_expect_success 'test sparse status again with untracked cache' '
     - 	avoid_racy &&
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     - 	echo "sub" > done/sub/sub/file
     - '
     - 
     --test_expect_failure 'test sparse status with untracked cache and subdir' '
     -+test_expect_success 'test sparse status with untracked cache and subdir' '
     - 	avoid_racy &&
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
     -+test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
     - 	test-tool dump-untracked-cache >../actual &&
     - 	cat >../expect-from-test-dump <<EOF &&
     - info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -@@
     - /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     - five
     - sub/
     --/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     --sub/
     --/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     --file
     --/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect-from-test-dump ../actual
     - '
     - 
     --test_expect_failure 'test sparse status again with untracked cache and subdir' '
     -+test_expect_success 'test sparse status again with untracked cache and subdir' '
     - 	avoid_racy &&
     - 	: >../trace &&
     - 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     -@@
     - 	test_cmp ../trace.expect ../trace
     - '
     - 
     --test_expect_failure 'move entry in subdir from untracked to cached' '
     -+test_expect_success 'move entry in subdir from untracked to cached' '
     - 	git add dtwo/two &&
     - 	git status --porcelain >../status.actual &&
     - 	cat >../status.expect <<EOF &&
     -@@
     - 	test_cmp ../status.expect ../status.actual
     - '
     - 
     --test_expect_failure 'move entry in subdir from cached to untracked' '
     -+test_expect_success 'move entry in subdir from cached to untracked' '
     - 	git rm --cached dtwo/two &&
     - 	git status --porcelain >../status.actual &&
     - 	cat >../status.expect <<EOF &&
     -@@
     - 	test_cmp ../expect-no-uc ../actual
     - '
     - 
     --test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
     -+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
     - 	git config core.untrackedCache true &&
     - 	test-tool dump-untracked-cache >../actual &&
     - 	test_cmp ../expect-no-uc ../actual &&
     -@@
     - 	test_cmp ../expect-empty ../actual
     - '
     - 
     --test_expect_failure 'setting core.untrackedCache to keep' '
     -+test_expect_success 'setting core.untrackedCache to keep' '
     - 	git config core.untrackedCache keep &&
     - 	git update-index --untracked-cache &&
     - 	test-tool dump-untracked-cache >../actual &&

-- 
gitgitgadget
