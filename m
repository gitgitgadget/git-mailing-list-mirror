Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1862EAD10
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770549286; cv=none; b=ixEJg9GEK3P9kwdQ1JW2eCBQQkG5RSHO/MgqkfAVSiODjpyHGNlubHTz7bbt+IHjv3T9DGP9OSrNvC7klKPaldiLh+wVBnUAil92tzlSP+Q73+Qd0ySW6hlBfblo+Wqtb3OJWda85ifKX21ogBlaFpftWohOXtNBk8UtdCDKCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770549286; c=relaxed/simple;
	bh=5s+5nsez0QUFdCO6n5yAMpBGmqj30qIeviCFxpNz2Jg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J5QUy5I9XIePzUbE1bmZDpDDLZyRLo5wSqv5D+9t6p8SxjO1pF/t5geIEhlWM0/6v9NJr47iA4MaJAA4gf+XztqFZQFCTW84kiQrutMi4K2VKsToewFYUc54vYyTe3z2mJ/nvP6oI9mgLjBkbhvKPh1lc/4cr84Zc/522HhXudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtyBXxcs; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtyBXxcs"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43622089851so2891442f8f.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770549284; x=1771154084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIH5cAOixcHxMXE+lNz4z2SdpBVdL8Ov2QF/iTOgBQ4=;
        b=BtyBXxcsV3KmfbZpdkSpOfc/Tqb6ogd/4iZpxO5sFHeEiqSPv8kK7ofUgLSDO/m8WH
         Jgpv6m8uqOhKggJDOh4mdpLCiK2IyHzXlYUz3IpQUtPhtredfB4T4cMUsOXOImNn53BP
         vnt6XUUztmj7CojqDXwVpLexK8fMw+KZ495KUvE0d4rG6nQ04eqaw3PDofMoq70NVKE1
         ewjtZl5MiXycD6paf+xQ0fJ2J8eMYDGrm1dv/inUegCZk4HdvlocgluhkBIwptTvl3vG
         WhcrZSiNNf32y8Kpq+OnaEJRIpPVWhTkAVqYsSskZHy8YsUrmxhWybcndfSsFw/ZZHEv
         AYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770549284; x=1771154084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIH5cAOixcHxMXE+lNz4z2SdpBVdL8Ov2QF/iTOgBQ4=;
        b=E/Z3/BNg4fucFZotCWiV1pwelYISzz62xDsTxQRS4I+07OWOdlajg1sGF7EYWLq52w
         1B9NmyzazgmxaZJeXkoqMKcdX3BsWMtHa5gL8iQdWj5QTwEkRbZDIZsw2IM0jGD3Kes8
         Ta+g2C1mBglo0uAIWhOw7iCTc2emH049HxorAy4r30YhFUadWd7KTI17HFPl1z3MFmHm
         oSSlYtHp/wBn4S4ktd4QxGb6GFrC2EwFN9Yso93lH1UfnJz1/RMbCDaD1oQF0zcOcxwF
         temC9IMu9quF0jUFjnlqS3894NKGzKCk6u2zPkHfSe0bTlcGhf6TLPQ0/SAZVDJBpSQO
         VzBA==
X-Gm-Message-State: AOJu0Yws65LAOhX+Uo4K06n9wsU8GZ8VJjT3vl5jPasn8YcmzOAjsw+X
	iJl4Ulu5sD4gsDRPJskVTUQKTx52PZLh9wGP8qkDTd8FRLslJvwEUbb9
X-Gm-Gg: AZuq6aINcglb6/EFrJBV/cRNrWlsxHBFxHXxAg8ceSsjYD4MunoFZZVJdmHin4kc2Sl
	h9GDNvtpHGfSN6w2hcQwML+NkYLQAhXdneFdw+7E2gBwaoxQNaDnOrIedntMXu3oScFhoXPbOLo
	0wkTmgEnuCcufrHox/YZ0LQqtVT6sW71jKBYpqROL19mHgZ7wPiWobJMTXe2Bu18uVm1h9Cw6of
	Elhry/pBb6hbVXL21k+1BDMzmiBFJoqAWVOUIwaK72t/n1Ub06zVpVEeipZbhMVFzDFW/eR6s48
	KZErD7QMZFWwMiNP0Jn2cUXfktAzNoGx6C0ZG6bG+dQRhOUyRGWHmxECUwXXs/7JpU/RFlSwCIw
	Hf+KzctvXVjVt2VZqZruO+eBI9odxgbILq8TU9S8vzLiAp9aeMQQ20nnN6q1h8wM5KYp701j38O
	sOHFbdJTQ0Wx5eqYTCmgDhTVJDqVPMJEwVUX+2v25BruCJy1nDr0WB8Y2CA/fWuGoWJQ==
X-Received: by 2002:a5d:5f42:0:b0:430:fd0f:28fe with SMTP id ffacd0b85a97d-43629381b46mr12101281f8f.31.1770549283891;
        Sun, 08 Feb 2026 03:14:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376d3a32basm1973163f8f.14.2026.02.08.03.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 03:14:43 -0800 (PST)
Message-ID: <88570b6c-2ff3-416f-b63f-2fb7c80c5af8@gmail.com>
Date: Sun, 8 Feb 2026 11:14:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: Junio C Hamano <gitster@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com,
 karthik.188@gmail.com
References: <cover.1770127568.git.belkid98@gmail.com>
 <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
 <xmqq7bspcq3c.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7bspcq3c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/02/2026 01:14, Junio C Hamano wrote:
> Olamide Caleb Bello <belkid98@gmail.com> writes:
> 
>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>> ---
>>   attr.c        |  7 ++++---
>>   environment.c | 12 +++++++++---
>>   environment.h | 11 ++++++++++-
>>   repository.c  | 12 ++++++++++++
>>   repository.h  |  7 +++++++
>>   5 files changed, 42 insertions(+), 7 deletions(-)
> 
> I bisected our recent CI failures that break fuzz smoke test down to
> this change.

The documentation for the LibFuzzer [1] notes

     * The fuzzing engine will execute the fuzz target many times with
       different inputs in the same process.

and the first thing that the callback in oss-fuzz/fuzz-commit-graph.c 
does is

	initialize_repository(the_repository);

so I think the problem is that the assumption that a process will only 
initialize "the_repository" once is incompatible with the way LibFuzzer 
works. Maybe we should add

	memset(the_repository, 0, sizeof(*the_repository));

before the call in initialize_repository()?

Thanks

Phillip

[1] https://llvm.org/docs/LibFuzzer.html

> $ make -j32 \
>              NO_CURL=NoThanks \
>              CC=clang \
>              FUZZ_CXX=clang++ \
>              CFLAGS="-fsanitize=fuzzer-no-link,address" \
>              LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
>              fuzz-all >/dev/null &&
> $ oss-fuzz/fuzz-commit-graph -verbosity=0 -runs=1
> 
> INFO: Running with entropic power schedule (0xFF, 100).
> INFO: -max_len is not provided; libFuzzer will not generate inputs larger than 4096 bytes
> INFO: A corpus is not provided, starting from an empty corpus
> BUG: repository.c:63: repository initialized already
> ==2050473== ERROR: libFuzzer: deadly signal
>      #0 0x56169aaf4065 in __sanitizer_print_stack_trace (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x32a065) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #1 0x56169aa4835c in fuzzer::PrintStackTrace() (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x27e35c) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #2 0x56169aa2d2d7 in fuzzer::Fuzzer::CrashCallback() (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x2632d7) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #3 0x7fb4c6f59def  (/lib/x86_64-linux-gnu/libc.so.6+0x3fdef) (BuildId: 61e1dea1f540b3b4b4d8ec76716e409cec096ece)
>      #4 0x7fb4c6fae95b in __pthread_kill_implementation nptl/pthread_kill.c:43:17
>      #5 0x7fb4c6f59cc1 in raise signal/../sysdeps/posix/raise.c:26:13
>      #6 0x7fb4c6f424ab in abort stdlib/abort.c:73:3
>      #7 0x56169ae91316 in BUG_vfl usage.c
>      #8 0x56169ae8f527 in BUG_fl (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x6c5527) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #9 0x56169ad79d07 in initialize_repository (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x5afd07) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #10 0x56169ab2c4e2 in LLVMFuzzerTestOneInput (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x3624e2) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #11 0x56169aa2e9da in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x2649da) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #12 0x56169aa2dfe9 in fuzzer::Fuzzer::RunOne(unsigned char const*, unsigned long, bool, fuzzer::InputInfo*, bool, bool*) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x263fe9) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #13 0x56169aa2fdaf in fuzzer::Fuzzer::ReadAndExecuteSeedCorpora(std::vector<fuzzer::SizedFile, std::allocator<fuzzer::SizedFile>>&) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x265daf) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #14 0x56169aa30390 in fuzzer::Fuzzer::Loop(std::vector<fuzzer::SizedFile, std::allocator<fuzzer::SizedFile>>&) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x266390) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #15 0x56169aa1cb65 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x252b65) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #16 0x56169aa48ec6 in main (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x27eec6) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
>      #17 0x7fb4c6f43ca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #18 0x7fb4c6f43d64 in __libc_start_main csu/../csu/libc-start.c:360:3
>      #19 0x56169aa10ec0 in _start (/home/gitster/git.git/oss-fuzz/fuzz-commit-graph+0x246ec0) (BuildId: ec362419d512b5bd707ae18eef56a6a12a18fc92)
> 
> NOTE: libFuzzer has rudimentary signal handlers.

