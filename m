Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E91C433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802BA60FBF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhJYQmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhJYQmn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:43 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A43C061220
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:40:21 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h20so6710332ila.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7XFJ1AyuBpn8O5T+y3lfPKNZqAm/wE1cMfytOQ0KPuM=;
        b=e0aEs2FkVCXrSsN5J+vaYX/PkIA44K9wjb1n08Ny87lwswWM2lTiZYhxF3bO40Jf2j
         +Ou4MDtD0tHns30nRe9vCZ7zljv/Md9YdULdA7SBcmgVdRh1bl/+DvppBcvQMWDauYoZ
         jI8sTLqRmX8R8kCNYentX1d0sfxV8a8Y7Sr4k0MUkhpZcPKEOZH/5cfPrZbm/m4Am0Qc
         oUcgJ1bwx4w8cRSeJn+FJkhSUzBLzxm6esZt+oxE3VUHrHK7az4rhMzcXEwyjPkV2Bz3
         IdU1zBc0rVAHXOxVXOB6FVT4V8hXZ4VQEen3kRWSYkTW1zw7jqnN8NiWzOA3oow60XaN
         nelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7XFJ1AyuBpn8O5T+y3lfPKNZqAm/wE1cMfytOQ0KPuM=;
        b=CUCSzpzKVxnLimXS9gnZIFY3n0WXlaJbYv8mnEUdfLR0BekvN0jRHuBGcRVbbOjp//
         MOtQcTkrTVGVTtiNgsuILxNHDvUzain5s0c9qE2plY88naILlgd9jqblZsVNxMZuXMZE
         vyzcnNN1N86KA9nFXDTlOiPSpPDin/U9lZhhqAMO6GrT1YJBs68Rj9pCbrZqjfXWObuG
         eo5Q+Q7Aa+z8gaILAD+F4xgirK6t5q2M0OCkcWgn6l/IcC07ZmZIV5CDUSBv/dWNfVr8
         117qDE5xXhKgYGfC0LlZtngYfv2ajtKPEbioD7LupUxXKd2sM83Wl0FzB8kO2SsIce6T
         B21w==
X-Gm-Message-State: AOAM533WNWaRcqO7e6q9FMRlE0vucx0ZiFFpMgbXoCMjBGMVPN6wAf10
        vL+bbcbqybIhnS9dbn2DC68=
X-Google-Smtp-Source: ABdhPJwwz998pX3gvk3SuBYja+b4TUN8TjdyNY503Vm0iokihHCCYeRdkfhEJ4BIh4aH/dbIeT7KOQ==
X-Received: by 2002:a92:d78a:: with SMTP id d10mr10632771iln.102.1635180019158;
        Mon, 25 Oct 2021 09:40:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id b3sm9040579ilc.36.2021.10.25.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:40:18 -0700 (PDT)
Message-ID: <a11d4fb0-184a-b811-64a0-e29e9cfd91a3@gmail.com>
Date:   Mon, 25 Oct 2021 12:40:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH] add|rm|mv: fix bug that prevent the update of
 non-sparse
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        Sean Christopherson <seanjc@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <YW3nAKAUj/HF15OR@google.com>
 <80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <80b5ba61861193daf7132aa64b65fc7dde90dacb.1634866698.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/2021 10:28 PM, Matheus Tavares wrote:
> On Mon, Oct 18, 2021 at 6:28 PM Sean Christopherson <seanjc@google.com> wrote:
>>
>> $ cat .git/info/sparse-checkout
>> !arch/*
>> !tools/arch/*
>> !virt/kvm/arm/*
>> /*
>> arch/.gitignore
>> arch/Kconfig
>> arch/x86
>> tools/arch/x86
>> tools/include/uapi/linux/kvm.h
>> !Documentation
>> !drivers
>>
>> $ git read-tree -mu HEAD
>>
>> $ rm arch/x86/kvm/x86.c
> [...]
>> $ git add arch/x86
>> The following paths and/or pathspecs matched paths that exist
>> outside of your sparse-checkout definition, so will not be
>> updated in the index:
>> arch/x86
> 
> I think the problem may be that we are performing pattern matching
> slightly different in add, mv, and rm, in comparison to "git
> sparse-checkout". On "git sparse-checkout init" (or reapply), we call
> clear_ce_flags() which calls path_matches_pattern_list() for each
> component of the working tree paths. If the full path gives a match
> result of UNDECIDED, we recursively try to use the match result from
> the parent dir (or NOT_MATCHED if we reach the top with UNDECIDED).

Yes! I think this is absolutely the problem. Thanks for pointing
this out!
 
> In Sean's example, we get UNDECIDED for "arch/x86/kvm/x86.c", but
> "arch/x86" gives MATCHED, so we end up using that for the full path.
> 
> However, in add|mv|rm we only call path_matches_pattern_list() for the
> full path and get UNDECIDED, which we consider the same as NOT_MATCHED,
> and end up disallowing the path update operation with a warning message.
> 
> The commands do work if we replace the sparsity pattern "arch/x86" with
> "arch/x86/" (with a trailing slash), but note that it only works
> because the pattern is relative to the root (see dir.c:1297). If we
> change it to "x86/", it would no longer work.
> 
> So far, the only way I could think of to fix this would be to perform
> pattern matching for the leading components of the paths too. That
> doesn't seem very nice, though, as it can probably be quite expensive...
> But here is a patch for discussion:

I agree that it is expensive, but that's already the case for the
non-cone sparse-checkout patterns. Hopefully it is sufficient that
these cases are restricted to modified files (in the case of `git add .`)
or specific pathspecs (in the case of `git mv` and `git rm`).

> -- >8 --
> Subject: [RFC PATCH] add|rm|mv: fix bug that prevent the update of non-sparse dirs
> 
> These three commands recently learned to avoid updating paths that do
> not match the sparse-checkout patterns even if they are missing the
> SKIP_WORKTREE bit. This is done using path_in_sparse_checkout(), which
> tries to match the path with the current set of sparsity rules using
> path_matches_pattern_list(). This is similar to what clear_ce_flags()
> does when we run "git sparse-checkout init" or "git sparse-checkout
> reapply". But note that clear_ce_flags() has a recursive behavior,
> calling path_matches_pattern_list() for each component in a path,
> whereas path_in_sparse_checkout() only calls it for the full path. This
> makes the function miss matches such as the one between path "a/b/c" and
> the pattern "b/". So if the user has the sparsity rules "!/a" and "b/",
> for example, add, rm, and mv will fail to update the path "a/b/c" and
> end up displaying a warning about "a/b/c" being outside the sparse
> checkout even though it isn't. Note that this problem only occurs with
> non-cone mode.
> 
> Fix this by making path_in_sparse_checkout() perform pattern matching
> for every component in the given path when cone mode is disabled. (This
> can be expensive, and we might want to do some form of caching for the
> match results of the leading components. However, this is not
> implemented in this patch.) Also add two tests for each command (add,
> rm, and mv) to check that they behave correctly with the said pattern
> matching. The first test would previously fail without this patch, while
> the second already succeeded. It is added mostly to make sure that we
> are not breaking the existing pattern matching for directories that are
> really sparse, and also as a protection against any future
> regressions.
> 
> Note that two other existing tests had to be changed: one test in t3602
> checks that "git rm -r <dir>" won't remove sparse entries, but it
> didn't allow the non-sparse entries inside <dir> to be removed. The
> other one, in t7002, tested that "git mv" would correctly display a
> warning message for sparse paths, but it accidentally expected the
> message to include two non-sparse paths as well.


> @@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *path,
>  				     struct index_state *istate,
>  				     int require_cone_mode)
>  {
> -	const char *base;
>  	int dtype = DT_REG;
> +	enum pattern_match_result ret = NOT_MATCHED;
> +	const char *p, *last_slash = NULL;
>  
>  	/*
>  	 * We default to accepting a path if there are no patterns or
> @@ -1516,11 +1517,31 @@ static int path_in_sparse_checkout_1(const char *path,
>  	     !istate->sparse_checkout_patterns->use_cone_patterns))
>  		return 1;
>  
> -	base = strrchr(path, '/');
> -	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
> -					 &dtype,
> -					 istate->sparse_checkout_patterns,
> -					 istate) > 0;
> +	if (istate->sparse_checkout_patterns->use_cone_patterns) {
> +		const char *base = strrchr(path, '/');
> +		return path_matches_pattern_list(path, strlen(path),
> +				base ? base + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate) > 0;
> +	}
> +
> +	for (p = path; ; p++) {
> +		enum pattern_match_result match;
> +
> +		if (*p && *p != '/')
> +			continue;
> +
> +		match  = path_matches_pattern_list(path, p - path,
> +				last_slash ? last_slash + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate);
> +
> +		if (match != UNDECIDED)
> +			ret = match;
> +		if (!*p)
> +			break;
> +		last_slash = p;
> +	}
> +
> +	return ret;

This implementation makes sense to me.

>  test_expect_success 'recursive rm does not remove sparse entries' '
>  	git reset --hard &&
>  	git sparse-checkout set sub/dir &&
> -	test_must_fail git rm -r sub &&
> -	git rm --sparse -r sub &&
> +	git rm -r sub &&

Interesting that the new pattern-matching already presents a change of
behavior in this test case.

>  	git status --porcelain -uno >actual &&
>  	cat >expected <<-\EOF &&
> +	D  sub/dir/e
> +	EOF
> +	test_cmp expected actual &&

And here is why. Excellent. I suppose that setting the pattern to be
"sub/dir/" would have shown this behavior before.

> +
> +	git rm --sparse -r sub &&
> +	git status --porcelain -uno >actual2 &&
> +	cat >expected2 <<-\EOF &&
>  	D  sub/d
>  	D  sub/dir/e
>  	EOF
> -	test_cmp expected actual
> +	test_cmp expected2 actual2
>  '

The rest of the test cases add new checks that are very valuable.

I love this idea and I agree that it would be better to change the
loop direction to match the full path first (as you mention in your
response).

Thanks,
-Stolee
