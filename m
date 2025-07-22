Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE6BA36
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200123; cv=none; b=tVJxy5ykA/PtxhqShSCaaiG+Md6WGBpR2bkRUWrLoFKfqLo3Z6rsh1xprFrI06B7WPntNz8Yofx2qdL73m9P9jIo5fqn0Q7IeP8m+U1wlGeVIG+m/Uowhs3ixJMcOh1foUdvCBWW77u+SihLTyNqMOtLRyJwf/zwRyUwqX8t8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200123; c=relaxed/simple;
	bh=24SdOlgCpqvctTKRsoUM+Ps7aqK8NgmnldW5x5dwbSE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L9/CvLtvxyuFuBs/4+iHHDzCCWee7huNiMa4RYgM8TM9HXDLPyvFsBYM3r+hqmnYYqcUH+ELJCEwzJaYJYWochx23owZoJTZprBfjz3UUcZX0qA0p05asuEA2tSEaAHeMP2OYmeKoqUEOdevpNVIefVLokVsJDF8EALQxZxGiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2WDjw2l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2WDjw2l"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so4262825f8f.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753200119; x=1753804919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuqJ7Od+YvIQTKcCFEle299v9+cNNU665wKld6lElqI=;
        b=K2WDjw2lxjr2WUqzTVW8w5712oTwOUkKlipSkv3++obTxYFmIWvXTuP4PI+FJRO+PM
         yk0gezqp0c8pKD2lvmH8j2AZyzR63KztkGKy1Wj+X05FEYYPzNSYMT4mBa9cVZW6Uf4P
         T/5fNlVT6CPlhox5L1XzMiEe761IveLE8gbsYCTdg/r3Muy7Mgf6OfMetAKm0jCsheY8
         ruaQr9MOF0PtigRoAei1BtE2EK2VIoranGHUdGlVHb9+aY0Qkgj96VY/qJ3A+Uv8oVdZ
         PWknZLHojmZjOn00xY6bMMVlGyHfIbOqHgjJi7Z/4nhPhHpI/i9fGoNe0/b7uz9nO6+2
         wT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200119; x=1753804919;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuqJ7Od+YvIQTKcCFEle299v9+cNNU665wKld6lElqI=;
        b=jpnrRp8JW8bwcQdt5jRh+fsLCXQ+ehnFzIfNwGI1IFZO7BsYDs3QgCWTWHtEi+pZKe
         reGc1Fb1QB203r7q2AT5F7JTCzzENIEPc+fe5+1dSFcG0zkzFxfxibZJODkJURtbYGDr
         NsWuNh8uxoA6BkQuax1pXwNjACVbbgrrKFcxlbOoCHZ4zDo4vM6uBjpu9KggXdgcNEIl
         aSvEsHtSOzpdh2wsqR+Zd3aESkgZ7Q0toK+Txbib8nICCBHkZxRME4ZflNhnO3mmgYqZ
         txUN3PFn2LvRdei7dHX+uxjMRGFy1e0ns8wVm0tNQ110BgifJPJ0GyVAbis7mdUEDnUt
         OBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWMTtS6aEDIkqSegJFSWjxFOz35s3XB+QA9m/x4a0FLoPYdWHANAxRkFCDD9A/UuwoGhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpuqXa4KgHIJn9rswKzJAvGLsArKM4FT8xbnyHV/fD0jNY8hu
	DWyM4GhYpK3RG1h2NWKw7ilR8NAOl09gEXOZmmpOb3tJUPJ6PPpEkYHP
X-Gm-Gg: ASbGncuYmXifnqQEKcmNtqTr9Fb7/RMsycmsPoCp+D6zUlsFTAfRuw6DB02vHwNdC8+
	w27jge62TmdO089TfU75OHKMnBe6hZCjQOSpW9suJPyYY/C8jY34kDFWAZcruuSlFb40j0+l/sB
	KxnPusRIvMrkeGUXQUh1mO9jhr5+IvB4p5ZtFBHanhg1IxXJamFV5u63sPnh1XWm2BehNxqPFFS
	3D5wRObs/MPIEFxf15FpL/1/iN2wRLAb30ZOnaGgPfpbP3+26u8O2mwgeMk4CuxoB3E2dT5+S4G
	+D9kH8Yz3GK8JzShLwezUde2+70KXxhO8ZWJRK0pPH7bNm8i/CqMbjIyOH7UsmQbccwo1MJ3+RD
	Q2odhr3EXZ/LAX4a2MaaTIvLc1JL35l+zvp93ytPYyhN66NfjDKJqeiufL+chLpdiEiCa2U+mE4
	jT
X-Google-Smtp-Source: AGHT+IGUMTZprtuzlzhmTtAZjqy7mnXeSrFU09vXSiBdTrLl2+jVc0Jh9Nf8JR+5b724E55AqW/e7w==
X-Received: by 2002:a5d:64ee:0:b0:3a6:ec1d:1cba with SMTP id ffacd0b85a97d-3b60e4c1e24mr21316400f8f.20.1753200117751;
        Tue, 22 Jul 2025 09:01:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca31394sm13879818f8f.37.2025.07.22.09.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:01:57 -0700 (PDT)
Message-ID: <076bb5e9-e8c4-466d-b8dd-bc84bba708b2@gmail.com>
Date: Tue, 22 Jul 2025 17:01:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] add-patch: add diff.context command line overrides
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
 <2774b930406819ea60f522e0e0741e4046ee01ee.1752928113.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <2774b930406819ea60f522e0e0741e4046ee01ee.1752928113.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 19/07/2025 13:28, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> This patch compliments the previous commit, where builtins that use
> add-patch infrastructure now respect diff.context and
> diff.interHunkContext file configurations.
> 
> In particular, this patch helps users who don't want to set persistent
> context configurations or just want a way to override them on a one-time
> basis, by allowing the relevant builtins to accept corresponding command
> line options that override the file configurations.
> 
> This mimics commands such as diff and log, which allow for both context
> file configuration and command line overrides.

Thanks for updating the quoting in the tests. Unfortunately this patch 
now deletes the tests added in the last commit which I don't think is 
correct.

>   
> -test_expect_success 'add -p respects diff.context' '
> -	test_write_lines a b c d e f g h i j k l m >file &&
I think there is some confusion here - why are we deleting the tests 
added in the last commit? This removes the test coverage for 
diff.context and diff.interHunkContext

> +for cmd in add checkout restore 'commit -m file'
> +do
> +	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
> +		test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> +		git add file &&
> +		test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
> +		echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> +			$cmd -p -U 4 --inter-hunk-context 2 >actual &&
> +		test_grep "@@ -2,20 +2,20 @@" actual
> +	'
> +done
> +
> +test_expect_success 'reset accepts -U and --inter-hunk-context' '
> +	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> +	git commit -m file file &&
> +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
>   	git add file &&
> -	test_write_lines a b c d e f G h i j k l m >file &&
> -	echo y | git -c diff.context=5 add -p >actual &&
> -	test_grep "@@ -2,11 +2,11 @@" actual
> +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> +		reset -p -U 4 --inter-hunk-context 2 >actual &&
> +	test_grep "@@ -2,20 +2,20 @@" actual
>   '
>   
> -test_expect_success 'add -p respects diff.interHunkContext' '
> -	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
> -	git add file &&
> -	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
> -	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
> -	test_grep "@@ -2,16 +2,16 @@" actual

This is also deleting a test added in the last patch

> +test_expect_success 'stash accepts -U and --inter-hunk-context' '
> +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
> +	git commit -m file file &&
> +	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
> +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
> +		stash -p -U 4 --inter-hunk-context 2 >actual &&
> +	test_grep "@@ -2,20 +2,20 @@" actual
>   '
>   
> -test_expect_success 'add -p rejects negative diff.context' '
> -	test_config diff.context -1 &&
> -	test_must_fail git add -p 2>output &&
> -	test_grep "diff.context cannot be negative" output
> -'

and so is this. The tests you're adding look good but we shouldn't be 
deleting the existing ones.

> +for cmd in add checkout commit reset restore "stash save" "stash push"
> +do
> +	test_expect_success "$cmd rejects invalid context options" '
> +		test_must_fail git $cmd -p -U -3 2>actual &&
> +		cat actual | echo &&
> +		test_grep -e ".--unified. cannot be negative" actual &&
> +
> +		test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
> +		test_grep -e ".--inter-hunk-context. cannot be negative" actual &&
> +
> +		test_must_fail git $cmd -U 7 2>actual &&
> +		test_grep -E ".--unified. requires .(--interactive/)?--patch." actual &&
> +
> +		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
> +		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
> +	'
> +done

This looks good as well
>   test_done
As I said last time I do not think the tests below add any value. They 
also do not compensate for the removal of the tests for diff.context 
that are deleted above as they all pass -U on the commandline.

> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index 1384a8195705..0158fe6568cb 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh
> @@ -58,6 +58,36 @@ test_expect_success 'The -U option overrides diff.context' '
>   	test_grep ! "^ firstline" output
>   '
>   
> +test_expect_success 'The -U option overrides diff.context for "add"' '
> +	test_config diff.context 8 &&
> +	git add -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'
> +
> +test_expect_success 'The -U option overrides diff.context for "commit"' '
> +	test_config diff.context 8 &&
> +	! git commit -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'
> +
> +test_expect_success 'The -U option overrides diff.context for "checkout"' '
> +	test_config diff.context 8 &&
> +	git checkout -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'
> +
> +test_expect_success 'The -U option overrides diff.context for "stash"' '
> +	test_config diff.context 8 &&
> +	! git stash -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'
> +
> +test_expect_success 'The -U option overrides diff.context for "restore"' '
> +	test_config diff.context 8 &&
> +	git restore -U4 -p >output &&
> +	test_grep ! "^ firstline" output
> +'
> +
>   test_expect_success 'diff.context honored by "diff"' '
>   	test_config diff.context 8 &&
>   	git diff >output &&

Thanks

Phillip

