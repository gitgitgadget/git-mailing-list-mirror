Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20EC19F2D
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 00:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHJA1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJA1j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 20:27:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DA1CFEC
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 17:27:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so12895550pgs.3
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=NhYdZjvtWzGPs5m7nienp4Y0QWuJU5ZQ93Xk8o8kCmc=;
        b=byAnHfZZZGoyfcmu6XEd7gFZyfBieF1FlNdce80M7BLbQv7TxKa/9nHPRq9X4h+U6e
         7/QT8IbknSHGkU0fxjrA1VfNRlZJG4bRU7KeVvH/hMEr8KIY8qymH4WVL8yUMxtnZpNz
         72LPwnwChqqclBU0iudsx0IpKMYPcjGZ95tCUDc0RyfTDZuvNW6dAig8NmUzVR6PC9s6
         Pw/sK1IeQTww4/WC1JeE4SFFmEoE/mXUk10s/x5ct7moFNgoNFYVhIgvFyzYEsd06zrN
         hruWE8iy5JJOAU3zR0gO9KgsEDi4G4aseOJ7z7TZcvttIh614naJx9Ov0swA+xSgfSQn
         cGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NhYdZjvtWzGPs5m7nienp4Y0QWuJU5ZQ93Xk8o8kCmc=;
        b=N/N8Cm/7sb2vv4YZJosw1+stwIa+G1SXE0YSDDn1eED3qtzc5ezBkevTAi/LZK6bR2
         1QMyaC6BrbeHzTDp2OO9bt0asrUcaxVayDGJvcs5erzYWaWLMjS55tBBMpW+LQpZB+Rk
         c0NUpALdlhuQakV349DSOm8BVhiOvPV1cNH7+WdVX4nX+mTOdwm47njMyd1VapuSuXyJ
         FiG7Bo/1jdQhtu2XDCUudsPD5JGtcVyrYO19SRD243z2nS0rOsHimHd2NCvVNHWZy4Ed
         R/HWQtPB+v75SVKbOCnAe2efiq9SJrCgYRHWXCF17NPpm96hEoRD7H3i5mtJhQPe9XqQ
         NMIg==
X-Gm-Message-State: ACgBeo3DRXBTHefKQVmz3Mti3EzhwxrH3jU1SIlzMYjdwtITWmkfLkT7
        FIrH6QJayBXkMqUp4rh8lkh7
X-Google-Smtp-Source: AA6agR7ccJ744kd3JUOObqh3vUSHRSajR9gFgKLj6n6Bc69ml+/MBZ2GMqct7Hq338HsS+YiHdjnWw==
X-Received: by 2002:a65:5789:0:b0:41a:4a7c:635d with SMTP id b9-20020a655789000000b0041a4a7c635dmr20545593pgr.60.1660091257655;
        Tue, 09 Aug 2022 17:27:37 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a115600b001f31776ccf3sm204174pje.12.2022.08.09.17.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 17:27:37 -0700 (PDT)
Message-ID: <8a76428d-e236-88bc-ec67-356b4c6f67fa@github.com>
Date:   Tue, 9 Aug 2022 17:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> ## Changes since PATCH v1 ##
> 
> 1. Move `ensure_not_expanded` test from the first patch to the last one.
> 
> 2. Mention the parameter of `pathspec_needs_expanded_index()` is
>    changed to use `struct index_state`.
> 
> 3. Modify `ensure_not_expanded` method to record Git commands' stderr
>    and stdout.
> 
> 4. Add a test 'rm pathspec expands index when necessary' to test
>    the expected index expansion when different pathspec is supplied.
> 
> 5. Modify p2000 test by resetting the index in each test loop, so the
>    index modification is properly tested. Update the perf stats using
>    the results from the modified test.
> 
> ## PATCH v1 info ##
> 
> Turn on sparse-index feature within `git-rm` command.
> Add necessary modifications and test them.

Other than a completely optional recommendation on commit ordering [1], I didn't have any comments on any individual patches. This series looks good to me!

[1] https://lore.kernel.org/git/2c0cb658-cd5a-420a-d313-6839149b9b40@github.com/

> 
> Shaoxuan Yuan (4):
>   t1092: add tests for `git-rm`
>   pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
>   rm: expand the index only when necessary
>   rm: integrate with sparse-index
> 
>  builtin/reset.c                          |  84 +------------------
>  builtin/rm.c                             |   7 +-
>  pathspec.c                               |  89 ++++++++++++++++++++
>  pathspec.h                               |  12 +++
>  t/perf/p2000-sparse-operations.sh        |   1 +
>  t/t1092-sparse-checkout-compatibility.sh | 100 ++++++++++++++++++++++-
>  6 files changed, 205 insertions(+), 88 deletions(-)
> 
> Range-diff against v1:
> 1:  6b424a1eb1 ! 1:  ea4162c6ab t1092: add tests for `git-rm`
>     @@ Commit message
>          Add tests for `git-rm`, make sure it behaves as expected when
>          <pathspec> is both inside or outside of sparse-checkout definition.
>      
>     -    Also add ensure_not_expanded test to make sure `git-rm` does not
>     -    accidentally expand the index when <pathspec> is within the
>     -    sparse-checkout definition.
>     -
>     +    Helped-by: Victoria Dye <vdye@github.com>
>     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## t/t1092-sparse-checkout-compatibility.sh ##
>     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'mv directory from
>      +	test_cmp folder1-sparse sparse-index-out &&
>      +	test_sparse_match git status --porcelain=v2
>      +'
>     -+
>     -+test_expect_failure 'sparse index is not expanded: rm' '
>     -+	init_repos &&
>     -+
>     -+	ensure_not_expanded rm deep/a &&
>     -+
>     -+	# test in-cone wildcard
>     -+	git -C sparse-index reset --hard &&
>     -+	ensure_not_expanded rm deep/* &&
>     -+
>     -+	# test recursive rm
>     -+	git -C sparse-index reset --hard &&
>     -+	ensure_not_expanded rm -r deep
>     -+'
>      +
>       test_done
> 2:  c2cf8b3c86 ! 2:  061c675c46 pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
>     @@ Commit message
>          * Add a check in front so if the index is not sparse, return early since
>            no expansion is needed.
>      
>     +    * It now takes an arbitrary 'struct index_state' pointer instead of
>     +      using `the_index` and `active_cache`.
>     +
>          * Add documentation to the function.
>      
>     +    Helped-by: Victoria Dye <vdye@github.com>
>     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## builtin/reset.c ##
> 3:  443ca7a682 ! 3:  1c4a85fad3 rm: expand the index only when necessary
>     @@ Metadata
>       ## Commit message ##
>          rm: expand the index only when necessary
>      
>     -    Originally, rm a pathspec that is out-of-cone in a sparse-index
>     -    environment, Git dies with "pathspec '<x>' did not match any files",
>     -    mainly because it does not expand the index so nothing is matched.
>     -
>          Remove the `ensure_full_index()` method so `git-rm` does not always
>          expand the index when the expansion is unnecessary, i.e. when
>          <pathspec> does not have any possibilities to match anything outside
>     @@ Commit message
>          <pathspec> contains wildcard that may need a full-index or the
>          <pathspec> is simply outside of sparse-checkout definition.
>      
>     +    Notice that the test 'rm pathspec expands index when necessary' in
>     +    t1092 *is* testing this code change behavior, though it will be marked
>     +    as 'test_expect_success' only in the next patch, where we officially
>     +    mark `command_requires_full_index = 0`, so the index does not expand
>     +    unless we tell it to do so.
>     +
>     +    Notice that because we also want `ensure_full_index` to record the
>     +    stdout and stderr from Git command, a corresponding modification
>     +    is also included in this patch. The reason we want the "sparse-index-out"
>     +    and "sparse-index-err", is that we need to make sure there is no error
>     +    from Git command itself, so we can rely on the `test_region` result
>     +    and determine if the index is expanded or not.
>     +
>     +    Helped-by: Victoria Dye <vdye@github.com>
>     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## builtin/rm.c ##
>     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
>       	for (i = 0; i < active_nr; i++) {
>       		const struct cache_entry *ce = active_cache[i];
>       
>     +
>     + ## t/t1092-sparse-checkout-compatibility.sh ##
>     +@@ t/t1092-sparse-checkout-compatibility.sh: ensure_not_expanded () {
>     + 		shift &&
>     + 		test_must_fail env \
>     + 			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
>     +-			git -C sparse-index "$@" || return 1
>     ++			git -C sparse-index "$@" \
>     ++			>sparse-index-out \
>     ++			2>sparse-index-error || return 1
>     + 	else
>     + 		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
>     +-			git -C sparse-index "$@" || return 1
>     ++			git -C sparse-index "$@" \
>     ++			>sparse-index-out \
>     ++			2>sparse-index-error || return 1
>     + 	fi &&
>     + 	test_region ! index ensure_full_index trace2.txt
>     + }
>     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec outside sparse definition' '
>     + 	test_sparse_match git status --porcelain=v2
>     + '
>     + 
>     ++test_expect_failure 'rm pathspec expands index when necessary' '
>     ++	init_repos &&
>     ++
>     ++	# in-cone pathspec (do not expand)
>     ++	ensure_not_expanded rm "deep/deep*" &&
>     ++	test_must_be_empty sparse-index-err &&
>     ++
>     ++	# out-of-cone pathspec (expand)
>     ++	! ensure_not_expanded rm --sparse "folder1/a*" &&
>     ++	test_must_be_empty sparse-index-err &&
>     ++
>     ++	# pathspec that should expand index
>     ++	! ensure_not_expanded rm "*/a" &&
>     ++	test_must_be_empty sparse-index-err &&
>     ++
>     ++	! ensure_not_expanded rm "**a" &&
>     ++	test_must_be_empty sparse-index-err
>     ++'
>     ++
>     + test_done
> 4:  adb62ca9bf ! 4:  861be8a91e rm: integrate with sparse-index
>     @@ Commit message
>      
>          Enable the sparse index within the `git-rm` command.
>      
>     -    The `p2000` tests demonstrate a ~96% execution time reduction for
>     +    The `p2000` tests demonstrate a ~92% execution time reduction for
>          'git rm' using a sparse index.
>      
>     -    Test                                     before  after
>     -    -------------------------------------------------------------
>     -    2000.74: git rm -f f2/f4/a (full-v3)     0.66    0.88 +33.0%
>     -    2000.75: git rm -f f2/f4/a (full-v4)     0.67    0.75 +12.0%
>     -    2000.76: git rm -f f2/f4/a (sparse-v3)   1.99    0.08 -96.0%
>     -    2000.77: git rm -f f2/f4/a (sparse-v4)   2.06    0.07 -96.6%
>     +    Test                              HEAD~1            HEAD
>     +    --------------------------------------------------------------------------
>     +    2000.74: git rm ... (full-v3)     0.41(0.37+0.05)   0.43(0.36+0.07) +4.9%
>     +    2000.75: git rm ... (full-v4)     0.38(0.34+0.05)   0.39(0.35+0.05) +2.6%
>     +    2000.76: git rm ... (sparse-v3)   0.57(0.56+0.01)   0.05(0.05+0.00) -91.2%
>     +    2000.77: git rm ... (sparse-v4)   0.57(0.55+0.02)   0.03(0.03+0.00) -94.7%
>      
>          ----
>          Also, normalize a behavioral difference of `git-rm` under sparse-index.
>     @@ Commit message
>      
>          [1] https://github.com/ffyuanda/git/pull/6#discussion_r934861398
>      
>     +    Helped-by: Victoria Dye <vdye@github.com>
>     +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>          Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>      
>       ## builtin/rm.c ##
>     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git blame $SPARSE_CONE/f3/a
>       test_perf_on_all git read-tree -mu HEAD
>       test_perf_on_all git checkout-index -f --all
>       test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>     -+test_perf_on_all git rm -f $SPARSE_CONE/a
>     ++test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>       
>       test_done
>      
>     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec outsi
>       	test_sparse_match git status --porcelain=v2
>       '
>       
>     --test_expect_failure 'sparse index is not expanded: rm' '
>     -+test_expect_success 'sparse index is not expanded: rm' '
>     +-test_expect_failure 'rm pathspec expands index when necessary' '
>     ++test_expect_success 'rm pathspec expands index when necessary' '
>       	init_repos &&
>       
>     - 	ensure_not_expanded rm deep/a &&
>     + 	# in-cone pathspec (do not expand)
>     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'rm pathspec expands index when necessary' '
>     + 	test_must_be_empty sparse-index-err
>     + '
>     + 
>     ++test_expect_success 'sparse index is not expanded: rm' '
>     ++	init_repos &&
>     ++
>     ++	ensure_not_expanded rm deep/a &&
>     ++
>     ++	# test in-cone wildcard
>     ++	git -C sparse-index reset --hard &&
>     ++	ensure_not_expanded rm deep/* &&
>     ++
>     ++	# test recursive rm
>     ++	git -C sparse-index reset --hard &&
>     ++	ensure_not_expanded rm -r deep
>     ++'
>     ++
>     + test_done
> 
> base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9

