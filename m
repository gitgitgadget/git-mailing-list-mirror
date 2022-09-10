Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D355CECAAA1
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 02:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIJCEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJCEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 22:04:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B126AE7
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 19:04:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l10so3355657plb.10
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EUO9eXJbdVOMuQSXJEgjdrVGHBlSlSgnKWEjfgQsgdA=;
        b=ZfHjygr8SLUcICKyuT8qTjSqXoQB1LTE0h8HKWMeMECPH9OuEblUxTzYVHHQF2UXRI
         iL/KnWKpdEAPjP0kmomXXvqhmM/XU3Ca9Yv2L16HF0G5ssl8YROdKUxR5yzFCXdh3X3L
         ry3quEs9idrC92urns9EU2f8DKjWkqKvv8kZZpq/5PedbjUdKZCY2TzvJbrrYjmlUBMq
         GX5nSsOQTwg+4KTqQhp1YgPG+VqZsiOamnYxLtFkgCv6+f7sr9Ge+w3lAUfsUWDANKix
         9WwaRd2eb1ViJWOvDx+I5X1MWDUFalo6xL2HtbNKU1ca3TaafDnrhjNXQfj+oyCD5x3H
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EUO9eXJbdVOMuQSXJEgjdrVGHBlSlSgnKWEjfgQsgdA=;
        b=yQIVT/1VihKX/hhA2RFg9EiwXJw5m0tGmt7dJJzOQTCE72p5dEdjim60b87SzlxG4R
         Xdt48P4iUyZ8i/rwLksssHaS+qXvL7GHtdZq9r0yej3zL71f3+NOn8W+/v0sIoQrQp0r
         JpuL1guHpSogBJkz2MbbzkzSZQwR/7DiDZYvHpchFb7YZLEwPMnOSN9zznGDGYBfnitM
         Bsud4vSlxkNF1JSaNkTzYPdx9Xu9FXHou7nq3YKjS6biBY/ovDFUArMiuSkjsJygIXap
         MDMHG3DoG07ccpmgjDXGnyp2t5P2p/s+XB6NSfBkN4qyhni7ZPeFZQyB5hsVjtm3PVGT
         mNWg==
X-Gm-Message-State: ACgBeo3jtUsHYeX1M+Gfl41dpE3EaQsbze75GEuxJNtyRQIw465YzE6w
        bQLEF43vmuCS/a0T8CYdgdJ9
X-Google-Smtp-Source: AA6agR4nF+xi+uAr3gXJyuUaYVq2obf1QnEjjP3iI3cWOq6r6tHuTBBJk2zM7XTx7KB9Af3xVuMBNw==
X-Received: by 2002:a17:902:bcc9:b0:16e:fde3:172f with SMTP id o9-20020a170902bcc900b0016efde3172fmr16759430pls.36.1662775483255;
        Fri, 09 Sep 2022 19:04:43 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id e20-20020a656494000000b0042aca53b4cesm1166398pgv.70.2022.09.09.19.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 19:04:42 -0700 (PDT)
Message-ID: <5d4a3cc5-d68e-0e8d-0792-e1e8d60bcfd1@github.com>
Date:   Fri, 9 Sep 2022 19:04:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> +
> +	/*
> +	 * NEEDSWORK: when reading a submodule, the sparsity settings in the
> +	 * superproject are incorrectly forgotten or misused. For example:
> +	 *
> +	 * 1. "command_requires_full_index"
> +	 * 	When this setting is turned on for `grep`, only the superproject
> +	 *	knows it. All the submodules are read with their own configs
> +	 *	and get prepare_repo_settings()'d. Therefore, these submodules
> +	 *	"forget" the sparse-index feature switch. As a result, the index
> +	 *	of these submodules are expanded unexpectedly.
> +	 *
> +	 * 2. "core_apply_sparse_checkout"
> +	 *	When running `grep` in the superproject, this setting is
> +	 *	populated using the superproject's configs. However, once
> +	 *	initialized, this config is globally accessible and is read by
> +	 *	prepare_repo_settings() for the submodules. For instance, if a
> +	 *	submodule is using a sparse-checkout, however, the superproject
> +	 *	is not, the result is that the config from the superproject will
> +	 *	dictate the behavior for the submodule, making it "forget" its
> +	 *	sparse-checkout state.
> +	 *
> +	 * 3. "core_sparse_checkout_cone"
> +	 *	ditto.

These are interesting observations, thank you for describing the behavior in
detail.

- #1 might seem like an easy fix - since 'command_requires_full_index' is
  tied to the command (not properties of the repo), the logical thing to do
  would be to propagate the value from the superproject to the subproject.
  However, that fix will undoubtedly expose lots of places where we're not
  handling the sparse index correctly in submodules. Since this isn't a
  problem introduced by your patch series, I'm content leaving this for a
  later series.
- #2 is an odd situation, but I'm guessing that the effect here will be
  minimal (since, regardless of the 'core_*' sparse-checkout globals,
  'SKIP_WORKTREE' will still be applied to - and respected on - entries in
  the index). It's more worrisome for commands that recurse submodules and
  *write* the index (e.g., 'git read-tree'), but that's also outside the
  scope of this series.

Given this information, I think your approach is (for the time being) a safe
one. Beyond the submodule issues, I'm happy with the rest of your
'grep_tree()' updates.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 63becc3138..fda05faadf 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1987,7 +2000,48 @@ test_expect_success 'grep is not expanded' '
>  
>  	# All files within the folder1/* pathspec are sparse,
>  	# so this command does not find any matches
> -	ensure_not_expanded ! grep a -- folder1/*
> +	ensure_not_expanded ! grep a -- folder1/* &&
> +
> +	# test out-of-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --sparse --cached a -- "folder1/a" &&
> +	ensure_not_expanded grep --sparse --cached a -- "folder1/*" &&
> +
> +	# test in-cone pathspec with or without wildcard
> +	ensure_not_expanded grep --sparse --cached a -- "deep/a" &&
> +	ensure_not_expanded grep --sparse --cached a -- "deep/*"

Thanks for the new tests (re: [1])! 

[1] https://lore.kernel.org/git/4b65d7dc-e711-43a6-8763-62be79a3e4a9@github.com/

> +'
> +
> +# NEEDSWORK: when running `grep` in the superproject with --recurse-submodules,
> +# Git expands the index of the submodules unexpectedly. Even though `grep`
> +# builtin is marked as "command_requires_full_index = 0", this config is only
> +# useful for the superproject. Namely, the submodules have their own configs,
> +# which are _not_ populated by the one-time sparse-index feature switch.
> +test_expect_failure 'grep within submodules is not expanded' '
> +	init_repos_as_submodules &&
> +
> +	# do not use ensure_not_expanded() here, becasue `grep` should be
> +	# run in the superproject, not in "./sparse-index"
> +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> +	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" &&
> +	test_region ! index ensure_full_index trace2.txt
> +'

So this test is *only* demonstrating that the submodules' indexes are
expanded (incorrectly, hence the 'test_expect_failure'); it doesn't show
that 'git grep' returns the correct results...

> +
> +# NEEDSWORK: this test is not actually testing the code. The design purpose
> +# of this test is to verify the grep result when the submodules are using a
> +# sparse-index. Namely, we want "folder1/" as a tree (a sparse directory); but
> +# because of the index expansion, we are now grepping the "folder1/a" blob.
> +# Because of the problem stated above 'grep within submodules is not expanded',
> +# we don't have the ideal test environment yet.
> +test_expect_success 'grep sparse directory within submodules' '
> +	init_repos_as_submodules &&
> +
> +	cat >expect <<-\EOF &&
> +	full-checkout/folder1/a:a
> +	sparse-checkout/folder1/a:a
> +	sparse-index/folder1/a:a
> +	EOF
> +	git grep --sparse --cached --recurse-submodules a -- "*/folder1/*" >actual &&
> +	test_cmp actual expect
>  '

...but this test *does* show that those results are correct. I think it was
a good decision to keep the two separate, since only the index expansion
behavior is wrong (thus warranting the 'test_expect_failure'). The output of
'git grep' is still what we want it to be, so it gets a
'test_expect_success'.

>  
>  test_done

