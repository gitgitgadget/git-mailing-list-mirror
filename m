Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4A1A08A3
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603184; cv=none; b=aeu6H4nhQhRO6cV1OmHUNogfFK+JQSLdCYT5GH5i7hAIllNOqStoU40P6OrAImpa4IF3agV7BZpEFGuEZUvh6OdViLsOWlLcvRIaOq5PVU26DRT0xpsUCGTSqUPZ+I8FhCownmX6W7C8G6k75mvPNNYh/H7CK28LO61kCa82AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603184; c=relaxed/simple;
	bh=B/62dknGSyi782B8PVaij04d0e4Cx2sdL17GeC89yIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYxSZqIo9oDoTKr1M9K1k+u1BpzUAry/V3J0OQk9YMcCxq+rsHRU/wImmC3vPrMWqoArBNQfKLnjH7+4xpKHXn8xgei/qQwcOmkgZIDVyQsaEbX9EGD9tMgHPmokrG+bz+x2NlHV6cs7bc+VlRiUx5rmiiPW41zMiuEH0CCxcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k78V5KIr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k78V5KIr"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so3209037a12.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603181; x=1784207981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCNMFcdgEZ8fxBl02tPao6psYSSt2zIVqk6Oa4WDlsQ=;
        b=k78V5KIrfY+AHp5ilcL5HU+nQlNas/PafBui2JxdjCHuKdmEhRCij8ejVCh9dD3BmX
         BjQ58AFKIP8r/wUpH24ZJtZGPvGV9W+XO72oopl5xO6tIH60boBeL8U73sdPCJ2IMjqO
         q3ZNGBlAdVG4cGcxhAAG9RZJd/ocqbitS5Ch64+Ga6zcnrC1s8T0Y7I+/Cyhg+KIfMqx
         i+EPFQWySmlK82D2YDSTcbOtkDynJgVm3MmMF3l0kidJ+6ZaUhkZvV0RLWYUJY3DeNX9
         zBZ7C2WDA57wJQPPN0STPQgqp6aRTmiwDxcZqz2T1ROV5DXRVKfQ4025pZVcOjjScpZv
         Shlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603181; x=1784207981;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCNMFcdgEZ8fxBl02tPao6psYSSt2zIVqk6Oa4WDlsQ=;
        b=dVJkgsW69HRECCBrRnQUatGNOwb1QiA/0A86MdgH2asOKh1iai3RNXMGbLbHgI+7//
         aaG4qlZ+3KQ5WRKmrfoo2lxgbU4ouc36Z5Pouksw89VcAo+gBkJc1OEIdX+rNfVpKMSA
         WW4C/gfOOmOdqxpqM6P5MF3Sw1YRQ7URqi5PTlkpvOn+yKG1EtoDTBETD0Zh82zPNysJ
         CTCLN3525UfsZeW4KjTxiFSr5P89CfHZrKIsDtpuXRiATdFZ6zu8Tbybk7w+wwu5xyUd
         XhLp9UDm35t5e5H1X5fsZXnw4BkN5PzDRYsJQyiUecu6kkkWqX2K/xpZ4pBuS6CQX7MI
         1jAw==
X-Gm-Message-State: AOJu0YxMVjPexyMusiPvWJOmXeZyyTWvkajWlklR1FMIn6dbqwERURbE
	BDfZMQPnu91fXl5GDeVTm0ezImBScVOkWKuf24bhyQEI8BXT7afaFGLq
X-Gm-Gg: AfdE7cmb7mjyLqjf+8FjUGPsE2NUPRRtxmK8ygQ60Z4MeAU0DQXd4mUzHwC/I3Vo1oL
	5bbbeWN2OGzZyeg8ohF4wzrDDTLe4km0bc0ACYVf4uv2i8ZJi93EKzMzQfwmqfs5GRHkhJ2E5M1
	jqdbdr+EOnPL83NQH5NIcoQVOVKf97he3kI2mNrt4A9uHFOgFtBlo0xfQZI2ybLPystHzeypeMF
	utZBO8i6tfIdpFNCTmeR2jwPUZME5uXfQ/U9RjaJMIgY8+zjzMamSad/u9/V6QiUr54B7sQ0FnQ
	mkBrFXE06hCeDtqyIXS7KWWqzIxXdHJxWA67R7RsaaJ6zJnfmDjYYUd0DJiPYmI2caS3+XUS8aQ
	f4R+px5ESX5TyjDohSDfoqgHbJVa7iviwHTFMDgjn1UxwppHlu9LNNUxZgYODjFE63H1uKuv0bY
	JVe7agKxucy+yMwgkQ9f7iOPk8F4/3ml7dpNV2JThp7RXqBlX5TGmL1wFHLWr80a0+2/QHPu4PN
	UYPsA==
X-Received: by 2002:a17:906:f90b:b0:c04:fc6:d6bc with SMTP id a640c23a62f3a-c15ce0c4f36mr210327566b.36.1783603180558;
        Thu, 09 Jul 2026 06:19:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad9bc41esm500236066b.37.2026.07.09.06.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:19:39 -0700 (PDT)
Message-ID: <0fc3a36f-dd43-43d1-b260-8e30cf46d845@gmail.com>
Date: Thu, 9 Jul 2026 14:19:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
To: Ian Jackson <ijackson@chiark.greenend.org.uk>,
 Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
 <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
 <9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
 <20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
 <f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
 <27215.27575.968985.583226@chiark.greenend.org.uk>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <27215.27575.968985.583226@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian

On 09/07/2026 10:36, Ian Jackson wrote:
> 
> Colin Stagner writes ("Re: [PATCH 2/2] git-subtree: Bail out if we find output from Rust rewrite (test)"):
>> It may be slightly faster to create only one repo and just make orphan
>> branches, like `test_create_subtree_add()` does.
> ...
>> `test_commit()` from test-lib-functions.sh may be superior to manually
>> writing and committing this file.
> 
> Thanks for the suggestions.  I'll take a look.

I think

     test_commit --no-tag sabotage .git-subtree/config "# sabotage"

is the equivalent of what you have in the test at the moment

> TBH I found this test framework quite awkward to work with.  Maybe
> folks here have some tips:
> 
> One thing I was missing was a primitive for "check this fails *and
> produces an error message matching this regexp*".  test_must_fail
> makes it easy for a slips in the command (or some kinds of regression)
> to go undetected: the test then passes because the command *does* fail
> with a usage error or whatever.  And AFAICT there isn't a way to
> manually inspect the output when the tests pass?  I resorted to
> sabotaging the test by adding `&& false` to the end of the shell
> snippet string, and eyeballing t/test-results/t7900-subtree.out.

The usual approach to checking that a command fails for the expected 
reason is

     test_must_fail git ... 2>err &&
     test_grep regexp err

which prints the contents of err if it does not match regexp. To see the 
output of the tests run them with "-v". I frequently use "-v -i -x" to 
debug test failures. "-i" stops the test run at the first failure so you 
can inspect the test repository and "-x" turns on tracing so you can see 
which command failed which is useful when I test has not been written 
with debugging in mind.

Thanks

Phillip
	
> Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite"):
>>> +reject_if_v2_config () {
>>> +	local config=.git-subtree/config
>>
>> This is a nit, but `local` is not specified by POSIX. I know it is used
>> elsewhere within git-subtree, but it is specifically discouraged.
> 
> There are 7 existing uses of `local`.  I think I prefer to use it here
> too.  In practice I think there are no shells we might want to use
> that don't have local.  The alternative is to change all the variable
> names to be obviously globally unique, which is clumsy and also seems
> to me to put us at greater risk of bugs.
> 
>>> +	if git rev-parse --verify -q "$rev:$config"; then
>>
>> For subtree split, should we also test for this file in tree you are
>> splitting: i.e., "$dir/$config"? The answer might be no.
> 
> You're right that we should consider this question.  The answer is:
> no, we should not.  Briefly, whether to use the new or old algorithms
> depends on whether the downstream has adopted the new git-subtree, not
> on whether the upstream has added some optional config.
> 
> https://codeberg.org/diziet/git-subtree/src/branch/main/DATA-MODEL.md#control-of-unmarked-subtree-merges-guessing-config
> 
>> I think that subtree merge should only test the top-level project, as
>> this patch does now.
> 
> By "top-level" I think you mean what I've taken to calling the
> "downstream": the project where the subtree is in a subdir, and whose
> top-level has other stuff.  In which case I agree.
> 
>> On 7/6/26 06:58, Ian Jackson wrote:
>>> Another, bigger, reason is that current git-subtree generates unmarked
>>> subtree merges (ie, without any git-subtree trailers)
>>
>> Subtree merges can be performed without git-subtree, via the `-X
>> subtree` merge strategy option. While the design of RIIR git-subtree is
>> outside the scope of this patch series, this may be worth thinking about
>> in your rewrite.
> 
> This is what I'm calling an "unmarked subtree merge".  My rewrite is
> not going to support this user behaviour.  The problem is that it is
> not possible to reliably determine whetheer something is an unmarked
> subtree merge.
> 
> It is possible to guess based on tree similarity, but that's a
> heuristic.  It's also possible to guess based on root commits.
> Both of these approaches can go wrong in some cases.  I prefer to
> write reliable software, which doesn't guess.
> 
> I'll advise against this practice in the documentation, but I'm
> reasonably confident that if a user does this anyway the results won't
> be terrible.  The upstream input to an unmarked subtree merge in a
> downstream that has already used my rewrite, will be treated as if it
> were a downstream branch that predates the subtree addition.  The
> effect on split (in most cases) is a missing parent relationship,
> which is undesirable but not catastrophic.I've made a note to add a
> test case for this scenario.
> 
> Combining manual -X subtree merges with git-subtree --squash merges
> could easily produce quite weird and wrong results in the tree (even
> before anyone tries split, or something).  I don't think I can even
> reliably detect this situation after the user has done it, and of
> course since that user is using plain git, I certainly can't prevent
> it.  This is another reason why manual use of -X subtree should be
> discouraged.
> 
> Regards,
> Ian.
> 

