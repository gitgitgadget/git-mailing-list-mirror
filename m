Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A41218AB4
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581280; cv=none; b=CpqxUynAnm83wbFynGNXSS6Yt0BgW9fIBHic1/S8qtW+NyoFXAJnh0mbH76WaHtYvsSswTkdoMtNXtXDcBdtrg+LrCqBqbH8ac0A4d6e2GqRJB6BEt0wXWbamIi0Czl1QAjCFZfYXOK1RFeD+4xr69d2FceV6GaMzutZRrD/CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581280; c=relaxed/simple;
	bh=an9Fcu3on4k3FlQnSyCQ8pAra/tDSg0pNAkU8vvclUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nfw/lwRTI/Mn5SRvvK7X1kyPQ1nm5oUH652EpErt9oRzdm/EXCpeRzWyjgJTJ0tqOWzoMGuXVWYs++mWQLLoNY1D+FG8vZs0dxcEjq+gv7m2SpSLS1mv+8orXPPrkrUSTbZ5rJpEF7Z7PlezwEvIsAEls/UeLNsXzczm/jRYBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRhlO7xZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRhlO7xZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948021a45so60577595e9.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740581277; x=1741186077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSPZw8HgM4OqUCCxVfNb62sh2ptfb91sLxzxjj6C3/o=;
        b=ZRhlO7xZ1/wAQyfQev8X+qswlwxq/aHvKDYmj+9jXJIgiS0vchlyxObuVifownb5lX
         PovSIrRCr0AtoJIv4vKrMvDQJ/HYB/YwMV7KDt34Jx7NyplQNfiawbUZb5DTKRGcwfxz
         eKBPiTB1WKehLc58zIlw/XjrCMCDaXv14UDtTPFlYD8pvALNwJFi3x9XclUddZegkfwC
         xh09jIFD9ahwCakq+Yd7VR6z0D3FM8Me5l5XRSYJaMIMgT8Ve6MBV7Y+7dK5Tjnu6cDv
         Yomo6zDG69hSAjtj96lICoX3f0k3o7curoQcsXb7NmquoD2cyJT3Xq5ZPg4X8/Mue1Ai
         /LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581277; x=1741186077;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSPZw8HgM4OqUCCxVfNb62sh2ptfb91sLxzxjj6C3/o=;
        b=VBxuUwbotqmmm28Ep/hqqIgnr7C20vqP89WaeUQG6AH+veCJgv1gSkz8+K0/3EwlVX
         9RahFuswmXqWsr5u496+2bSc672PmgInxLd/GCKKwFIIFpYnlCC274v6G6Bv0eaedlM1
         oeL4VkEIpJx4TNhPggK8vzwBdiw6Nxn9md25jUExbPx2wkCbGayYUYKAhQGxCaypXIBw
         HWjNNsA4bSRQdLsXlJb4xvHcWjPyPjrnSBfLi44w3DcQQC0w0GvaVtz7W4VRCkys3E9X
         D+97Q+Uih6vjZQrxTIqm6Bcm46UH5hx5lxt/dkcrnBTfRAWZ2xJHA06kn2RVY5MlhOao
         B3Bw==
X-Gm-Message-State: AOJu0YyhiZQrXT2PVJXmth3eqzp0CMUlCTlrEa4QgsliPMY0iuIzGWwy
	3JdVL45H2HSHUoTEGsJY+D0so59m8VDyd+0TnMLiwCxBqIYH16pa
X-Gm-Gg: ASbGncuh4Lcp8n0gOHIemp+dFn27N6WvBqhBQTrg56wWJSqGTWfZQSrie/9DxUXovUK
	SitBqp1HpYwz5QeoRIId3fa7Q1sgjgLWGZHh4mWLkat5LH50pyIi9jc6Z1idpiu1Bixb/hjzM4c
	/pPr5nutAdzcYRsry2aoZRCy6DJynpXGmwbB1wEKiqWMXejBNkdtA/CgY8Aq71tRYMaNQWeJkLE
	mEs2wST3q+HMy84g8pZjcICS8F/q+QogT9cZLwA7s+V9Ve/pgTGZ9MQ7xVuWivlnhkTEoywSxI3
	M5T+qoyxlvOSp33eILD3iIbBxe++B6r6yHc8sEki5c3G3VKyDbdRNM6kuFiY9X9cjNI/NaqO3qm
	9Daiq
X-Google-Smtp-Source: AGHT+IE6QLZfcoJzZOWoQy2cGaql3VcbqQNSSKUVoSEneDb8RiwdG268bgCxuwjSE3Hbz62Gxsy3ng==
X-Received: by 2002:a05:600c:3b83:b0:43a:9ef6:77ec with SMTP id 5b1f17b1804b1-43ab901d646mr32006365e9.23.1740581276728;
        Wed, 26 Feb 2025 06:47:56 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cafdsm5833285f8f.28.2025.02.26.06.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:47:56 -0800 (PST)
Message-ID: <00ef7191-1593-454e-ba45-8223726bb37d@gmail.com>
Date: Wed, 26 Feb 2025 14:47:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
To: Justin Tobler <jltobler@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, peff@peff.net, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>
 <wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
Content-Language: en-US
In-Reply-To: <wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 19/02/2025 20:51, Justin Tobler wrote:
> On 25/02/17 02:38PM, Phillip Wood wrote:
>> Hi Justin
>>> +	const char * const usage[] = {
>>> +		N_("git diff-pairs [diff-options]"),
>>
>> Normally the option summary printed by "git foo -h" is generated by the
>> option parser. In this case we don't define any options and use
>> setup_revisions() instead so we need to provide the option summary
>> ourselves. Looking at diff-files.c we can add
>>
>> 	"\n"
>> 	COMMON_DIFF_OPTIONS_HELP;
>>
>> to do that.
> 
> Would this be preferable even if git-diff-pairs doesn't support all of
> the common diff options?

Which options are you thinking about here? I might have missed something 
don't think that help text includes anything that's not in 
diff-options.adoc that we include in diff-pairs.adoc. If there are 
options in the documentation that we don't support then that is a problem.

Best Wishes

Phillip


>>> +	argc = setup_revisions(argc, argv, &revs, NULL);
>>
>> I think we should check that there are no options left on the commandline
>> after setup_revisions() returns
> 
> Good call, will do in the next version.
> 
>>> +	/* Don't allow pathspecs at all. */
>>> +	if (revs.prune_data.nr)
>>> +		usage_with_options(usage, options);
>>
>> It is not just pathspecs that we want to reject but all revision related
>> options. Looking at diff-files.c we can do
>>
>> 	if (rev.pending.nr ||
>> 	    rev.min_age != -1 || rev.max_age != -1 ||
>> 	    rev.max_count != -1)
>> 		usage_with_option(usage, options);
>>
>> To catch some of that but it still accepts things like "--first-parent",
>> "--merges" and "--ancestry-path". We may just have to live with that as I
>> don't think it is worth expanding a huge amount of effort to prevent them.
> 
> Yes, we should also reject revision as well as pathspec arguments. Will
> update.
> 
>>> +	if (!revs.diffopt.output_format)
>>> +		revs.diffopt.output_format = DIFF_FORMAT_RAW;
>>
>> This matches the other diff plumbing commands but I'm not sure it is the
>> most helpful default for a command that is supposed to transform raw diffs
>> into another format. Maybe we should default to DIFF_FORMAT_PATCH?
> 
> As you mentioned, defaulting to DIFF_FORMAT_RAW isn't the most useful
> behavior. I agree that it makes more sense to use DIFF_FORMAT_PATCH as
> the default. Will update in the next version.
> 
>>> +test_expect_success 'split input across multiple diff-pairs' '
>>
>> This needs a PERL prerequisite I think. I'm a bit unsure what this test adds
>> compared to the others.
> 
> This test demonstrates that the raw diff input can be split across
> separate git-diff-pairs(1) processes and still produce equivilant
> output which is one of the main usecases for the command. That being
> said, this test isn't really exercising different behavior of
> git-diff-pairs(1) itself, so maybe it would be best to drop it.
> 
> Thanks for the review :)
> 
> -Justin

