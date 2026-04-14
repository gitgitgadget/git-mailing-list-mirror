Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478E38D005
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175544; cv=none; b=IvT+L5fAHDqAwL9l84EIwG3iPtljVEHuzuItNCwyGbZdG6x1B/7YiI7nyowOEAWkXsKSQfR6tloMIRPE0m3WX8iTsZd0p13PA78CsIe+LTOIFi+MlnRF1UylntQKygFkECFpboCVAKtn8la3kwRyxf/FZODucH0KSnXzJbnsnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175544; c=relaxed/simple;
	bh=c2eqdm67d8RTSyyNpuv07bXNuZc1ZeZJ50DrP1gYd5U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u0xKzgAuJXwvNaxWWxr+HRbDsKunCNKTo1hrxeehRsJufjTIulqHpLH7Ej//PauTwv9EeQ/VWv7QPF3D/hcF2BXypyJrWpyZ/yzeI6Rm+ONuEzONfPY7H2N6P23eE01p5Bjm01RvxYrqH1Y2IafkxBTwLRp1vE9viwld8znjE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+P8yWc0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+P8yWc0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso5294904f8f.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175542; x=1776780342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HINkGZk4Bm64ZkyO4+1MsVEuy5mfA75hwb56PAw/FNk=;
        b=s+P8yWc0ebclewDpnk/2Sr4UJ/NL1AubG2Vk5op1FcrohU6AsrufPsmgwO56I30eDX
         2K6ve3bgWqdilfZcjDdQLZZuoDeghQ+yzHym0YobwlFJFDAw71mrrO7LhSnFnMMLul5V
         ob2t7nJ3FBr7cPzYAuLgvT98gRhb/dM91q8l4p5aZA+l57dpO5sszJNKQBaB5Fem7siq
         zCUa/TJHwZCmofzjQw5atp8SJabKMrdg0HYk/WmFwrUUpgqAozNxwC0xR2VqmOWE4inf
         sGDuComEGpURtRmH7vtsJWo7ZzP170wyuRbXX2g6ef6loz9Lkw7sUbgXzUFDfFQJ6BIc
         u7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175542; x=1776780342;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HINkGZk4Bm64ZkyO4+1MsVEuy5mfA75hwb56PAw/FNk=;
        b=Pi3QQ0WhRO//0zSRo9VTZ2AkxfTSL2848pt3Jmxu2TvlmZjZgZQ+f0b+sFdcL3U6gL
         XGu6Ql/HNiQe/7scZ3d/Um+fXbNuBDJrRgVG/dYhixE/zq2eGzpGTrYGNZXMJtVYtH7m
         nXXNOONGkHEy4a8vb5cVPt8i58BYvnfNVdMBA3aWU665RQzEUXpWIXfDrs4E/qyDcz+2
         Ay6Jm/zENF14vetxb8lG9S1ixjyeHhxzl3vuFRIanYbQHfhBmCCEiy0Xb8Q41sj0rsWS
         NBvbQgzWfF11xTsNZgeuEmm9+MMvmL2h0w8Pr2pVM6XGGPpmyXAECgb5nGypsfsGqfE2
         KGKg==
X-Forwarded-Encrypted: i=1; AFNElJ8Smx+xqcAGneicwaca8Io9dg/DwIEMdaOgiSfU24RkMEYG4oY9j5cMXl9uOglpJNjSA1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8Of6Rtz0Y3FrC2ZpMlYzxPjPFAqywthm08TblwEitMs1EaYL
	Q6c/rMV5mxGUbn1gK8ZRRgZOMnwcSm0xS20yASB8x3XHwwyCGMEJwOla
X-Gm-Gg: AeBDievOD5Y7DrMeZPrTKDUHf4l3+4a6I08jlOi8YWdMPaV1pRD1gCf0C6/59ycpMWN
	ZbBzWigrSw1ssSNsGKtyv5jmwDWndcen/0Pk148CJ2llUlMnLp+9z3KsHxKImHgDgXQmsSHVg/I
	jM5f1BXFbSPHkr9aaPyrWQTCxdZMNI24LUjYcsd5cio9NTrOnMv5fHNN69Q4zN6WBiWGma2y5wQ
	DEoJJzhpSHia6LcDpo6vDkKEtm+4vj5OUSDOVxvUKnZZI4znSzxDvM0brYs64BboKjLFGiYdzPB
	wGoFFpF+epSBc0TFtvnGps0sCsYqRQsv1F1rMBH9zAlZ43aGf4crp666r3Lps8PAy4h5iYXgUjI
	8+Rst68CAB+fp45eMAg07M48V1cV60BUKu9jCWIrB2vRjkGzGO+F+Y8+PL1xJpfrtMbaY2hZGDT
	Qbw80ZdqePkIyUh2DknGRKPr7HAco2ejG3ZS33Ozcwyz0ok4WF2kvYgZgfkFFRgZmzYmo8lDcHC
	aU=
X-Received: by 2002:a5d:5f48:0:b0:43d:2be:e4e with SMTP id ffacd0b85a97d-43d642dd674mr27354371f8f.46.1776175541523;
        Tue, 14 Apr 2026 07:05:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7d5812dcsm11320782f8f.32.2026.04.14.07.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:05:40 -0700 (PDT)
Message-ID: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
Date: Tue, 14 Apr 2026 15:05:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 1/4] stash: add --label-ours, --label-theirs,
 --label-base for apply
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
 <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
 <9ab5431b4773c29097ae9bdd497822477c7ba56a.1776171585.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <9ab5431b4773c29097ae9bdd497822477c7ba56a.1776171585.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 14/04/2026 13:59, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Allow callers of "git stash apply" to pass custom labels for conflict
> markers instead of the default "Updated upstream" and "Stashed changes".
> Document the new options and add a test.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> [...]
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0d27b2fb1f..00314e2b13 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -44,7 +44,7 @@
> [...]
> -static int do_apply_stash(const char *prefix, struct stash_info *info,
> -			  int index, int quiet)
> +static int do_apply_stash_with_labels(const char *prefix,
> +				      struct stash_info *info,
> +				      int index, int quiet,
> +				      const char *label_ours, const char *label_theirs,
> +				      const char *label_base)

There are only four callers of do_apply_stash so it might be better just 
to change the function signature and update the existing callers rather 
than adding another function.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..00bcb1f802 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1666,6 +1666,35 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>   	)
>   '
>   
> +test_expect_success 'apply with custom conflict labels' '
> +	git init conflict_labels &&
> +	(

I'm still unclear why we're creating a new repository here. Our test 
suite is slow enough already without each test spending time creating 
its own repository. There doesn't seem to be anything here that requires 
isolating the test in this way.

Apart from that everything else looks good to me

Thanks

Phillip

> +		cd conflict_labels &&
> +		test_commit base file &&
> +		echo stashed >file &&
> +		git stash push -m "stashed" &&
> +		test_commit upstream file &&
> +		test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
> +		test_grep "^<<<<<<< UP" file &&
> +		test_grep "^||||||| Stash base" file &&
> +		test_grep "^>>>>>>> STASH" file
> +	)
> +'
> +
> +test_expect_success 'apply with empty conflict labels' '
> +	git init empty_labels &&
> +	(
> +		cd empty_labels &&
> +		test_commit base file &&
> +		echo stashed >file &&
> +		git stash push -m "stashed" &&
> +		test_commit upstream file &&
> +		test_must_fail git stash apply --label-ours= --label-theirs= &&
> +		test_grep "^<<<<<<<$" file &&
> +		test_grep "^>>>>>>>$" file
> +	)
> +'
> +
>   test_expect_success 'stash create reports a locked index' '
>   	test_when_finished "rm -rf repo" &&
>   	git init repo &&
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 29dad98c49..659ad4ec97 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   			      int size, int i, int style,
>   			      xdmerge_t *m, char *dest, int marker_size)
>   {
> -	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
> -	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
> -	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
> +	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
> +	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
> +	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
>   	int needs_cr = is_cr_needed(xe1, xe2, m);
>   
>   	if (marker_size <= 0)

