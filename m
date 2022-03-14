Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5484C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 19:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiCNTGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiCNTGG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 15:06:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F82CC83
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:04:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so11678397plg.5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/ygdzDMAa5ekVWOl0bwlaNX3vusyYyZIwsAHk1Awldg=;
        b=G+jdVg5HEgomC2A0x8mPOKW6am/eATqZ/zZnTl0J2RgvIK+4oovi1zFvxwMGdaoI9t
         klQFcKKs35rRXh9mNO4hsmf2354xwS/wDDNQi4owCVH08KJSQdjszXbXZIQF9X5LQL48
         P1NRqu9NYXm5amRE1EvQedONLOYpplYDCF8jjg+Xgd1SGPIYHSe5n/UK0Nvsb7OejFYv
         AshPP5YUKbyiuP8PJJ3T042HGUYMp+UWIXr6qx9cmMxyRDotJ71G/9D4whR3Y828Qrk3
         MAVy5MFU+f2DODpcnavPHzxJURyoYIhTYOku2Ym/yB8ELcxDVo4VW2DMvHAiGxDk59ou
         UNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/ygdzDMAa5ekVWOl0bwlaNX3vusyYyZIwsAHk1Awldg=;
        b=8Mj/wzbWTaP6nBPwD+BemiYdaEzeItTieOuphV8rvQWAcEKXRdvk9lm8bdHwf8KB6D
         wL2+caaBtHgogKhEFVO7H2qNYiLzC1Otf2AR6mQnUP6qH2NIRo1LJd31jwC3cjvA6BFN
         p6HPP81PyU/eTvPjVDLg50O6a4nCmWVV6lAolMliUOUkFxTcSsNt/UdU6GKndEK6KDTY
         T5LRMo/LUdEs4jYqpiMvjWeti97A8FqA5dmJUsOsaOa0cAb42MyIxC3P7RNfijQtYFy/
         MZqePck3YuIx0z8R6ShdhWNrf652NREiSILJc9ibJb4Gd/mMEDH+J+mg1k087FV87cyU
         GiQg==
X-Gm-Message-State: AOAM530IOhxmcK0w0MD/EspkjIwMXJzCpc+0F8SvfgfWkj3HG3KRr9UC
        fK7R2Jx7vABDNhFaNWpoqAoA
X-Google-Smtp-Source: ABdhPJzY8uYwZLFRbmwnTaIPJHtlKjTE4FZaSB84OPfvFhKJSg96qkCC7cxhiE5Z66Z2RQArvICH8Q==
X-Received: by 2002:a17:90b:388c:b0:1bf:4047:c7c6 with SMTP id mu12-20020a17090b388c00b001bf4047c7c6mr712659pjb.24.1647284694874;
        Mon, 14 Mar 2022 12:04:54 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm11118080pfa.0.2022.03.14.12.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 12:04:54 -0700 (PDT)
Message-ID: <0f8b57d9-0ce2-da94-ecb8-4fa7f51d9fdb@github.com>
Date:   Mon, 14 Mar 2022 12:04:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v2 0/9] sparse-checkout: make cone mode the default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> == Updates Log ==
> 
> Changes since v1:
> 
>  * rebased on master, to remove dependence on en/present-despite-skipped
>    (which has since merged to master). Earlier version of series wasn't
>    picked up anyway, so rebasing should be safe.
>  * Wording and code style tweaks suggested by Stolee in his review
> 
> == Overview ==
> 
> This patch changes the default mode for sparse-checkout from non-cone mode
> to cone-mode, and marks non-cone mode as deprecated. There is no plan to
> remove non-cone mode, we are merely recommending against its use.
> 
> The code change is pretty small, and most of this series is about
> documentation updates -- to focus on directories rather than patterns, to
> explain the new default, to explain why we are deprecating non-cone mode
> (the final patch), and to make other related cleanups to simplify the
> manual.
> 
> Patch 1: Update tests to not assume cone-mode is the default Patch 2: Make
> cone-mode the default Patches 3-9: Various updates to
> git-sparse-checkout.txt, divided up for ease of review
> 

After looking over the patches (and Stolee's prior feedback), I don't have
any additional comments - it all looks great! 

I also ran through some scenarios going from "non-cone" to "cone mode" that
have been buggy in the past (e.g., non-cone directory patterns missing a
leading '/', then 'git sparse-checkout init --cone'), but it looks like the
checks added back in a3eca58445 (sparse-checkout: refuse to add to bad
patterns, 2021-12-16) prevent any unexplained behavior for a user that might
not be aware of the new default. In other words, changing the default looks
to be safe and overall pushes users towards a better experience using
sparse-checkout.

> == Alternative ==
> 
> There is one primary alternative to this series: make sparse-checkout error
> when neither --cone nor --no-cone are specified (so that there is no
> default), and wait until a future date to make --cone the default. That'd be
> reasonable, but I had three reason to avoid going this route (note that item
> 2 means there's little practical difference between cone-mode-as-default and
> no-mode-is-default):
> 
>  1. git-sparse-checkout.txt has the following huge warning early in the
>     manual:
> 
> """ THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
> COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN THE
> FUTURE. """
> 
>  2. If users are unaware of the default change and attempt to provide
>     patterns instead of directories, then they will get error messages added
>     from en/sparse-checkout-fixes. They can learn at that time to get around
>     the error messages by providing --no-cone.
> 
>  3. If users are unaware of the default change and provide directories, then
>     that's where non-cone mode and cone mode overlap and things happen to
>     work. (There is a slight difference in that cone mode will include files
>     from parent directories of any specified directory, but that means the
>     user gets a few more files in their sparse-checkout with cone mode than
>     they would with non-cone mode.)
> 

Agreed with your comments here and Stolee's earlier that changing the
default is a better approach.

> == CCs ==
> 
> Elijah Newren (9):
>   tests: stop assuming --no-cone is the default mode for sparse-checkout
>   sparse-checkout: make --cone the default
>   git-sparse-checkout.txt: wording updates for the cone mode default
>   git-sparse-checkout.txt: update docs for deprecation of 'init'
>   git-sparse-checkout.txt: shuffle some sections and mark as internal
>   git-sparse-checkout.txt: add a new EXAMPLES section
>   git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a
>     bit
>   git-sparse-checkout.txt: mark non-cone mode as deprecated
>   Documentation: some sparsity wording clarifications
> 
>  Documentation/git-read-tree.txt       |   9 +-
>  Documentation/git-sparse-checkout.txt | 249 +++++++++++++++++++-------
>  builtin/sparse-checkout.c             |   2 +-
>  t/t1091-sparse-checkout-builtin.sh    |  15 +-
>  t/t3602-rm-sparse-checkout.sh         |   6 +-
>  t/t3705-add-sparse-checkout.sh        |   4 +-
>  t/t6428-merge-conflicts-sparse.sh     |   4 +-
>  t/t7002-mv-sparse-checkout.sh         |   2 +-
>  t/t7012-skip-worktree-writing.sh      |   2 +-
>  9 files changed, 207 insertions(+), 86 deletions(-)
> 
> 
> base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1148%2Fnewren%2Fsparse-checkout-default-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1148/newren/sparse-checkout-default-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1148
> 
> Range-diff vs v1:
> 
>   1:  8c3e730e86b =  1:  05dba7069c5 tests: stop assuming --no-cone is the default mode for sparse-checkout
>   2:  b174b42ed82 !  2:  a53179764bc sparse-checkout: make --cone the default
>      @@ builtin/sparse-checkout.c: static int update_modes(int *cone_mode, int *sparse_i
>        	/* Set cone/non-cone mode appropriately */
>        	core_apply_sparse_checkout = 1;
>       -	if (*cone_mode == 1) {
>      -+	if (*cone_mode == 1 || *cone_mode == -1) {
>      ++	if (*cone_mode) { /* also handles "not specified" (value of -1) */
>        		mode = MODE_CONE_PATTERNS;
>        		core_sparse_checkout_cone = 1;
>        	} else {
>   3:  f98b3fac78a =  3:  8eab21996c7 git-sparse-checkout.txt: wording updates for the cone mode default
>   4:  cd871966c06 =  4:  eb3b318b39e git-sparse-checkout.txt: update docs for deprecation of 'init'
>   5:  fe37a966699 =  5:  7333198b778 git-sparse-checkout.txt: shuffle some sections and mark as internal
>   6:  3265f41bcab !  6:  a814ea9e8d2 git-sparse-checkout.txt: add a new EXAMPLES section
>      @@ Documentation/git-sparse-checkout.txt: paths to pass to a subsequent 'set' or 'a
>       +
>       +`git sparse-checkout reapply`::
>       +
>      -+	It is possible for commands to update the working tree in a way
>      -+	that does not respect the selected sparsity directories, either
>      -+	because of special cases (such as hitting conflicts when
>      -+	merging/rebasing), or because some commands didn't fully support
>      -+	sparse checkouts (e.g. the old `recursive` merge backend had
>      -+	only limited support).  This command reapplies the existing
>      -+	sparse directory specifications to make the working directory
>      -+	match.
>      ++	It is possible for commands to update the working tree in a
>      ++	way that does not respect the selected sparsity directories.
>      ++	This can come from tools external to Git writing files, or
>      ++	even affect Git commands because of either special cases (such
>      ++	as hitting conflicts when merging/rebasing), or because some
>      ++	commands didn't fully support sparse checkouts (e.g. the old
>      ++	`recursive` merge backend had only limited support).  This
>      ++	command reapplies the existing sparse directory specifications
>      ++	to make the working directory match.
>       +
>        INTERNALS -- SPARSE CHECKOUT
>        ----------------------------
>   7:  bdbf61ee6a0 =  7:  78028ecaa58 git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a bit
>   8:  3e35d62c5ee =  8:  2d2b81986a5 git-sparse-checkout.txt: mark non-cone mode as deprecated
>   9:  e7d3ff70914 =  9:  4b89a3392b0 Documentation: some sparsity wording clarifications
> 

