Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084A2E8E00
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075695; cv=none; b=FdE57lxMMIn5/z1GomTvFeTK4wOfE1Q6NEH3Sj2tVoQ2sNOmkwyTDxPnL7o7FsMQRoqAVb3g13uLZIqNxwYNylp5touTCdLPeQXaboG1weoLl1lPJ/1aQZcLEq5O7EUQMLtU8p2FrJgs0tGFylNqsmbNb13Uf7RbZHjMmoNt33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075695; c=relaxed/simple;
	bh=1CfVAvddup7eClTCfoynOwjRYmWQce5fRhc1orucFZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcKRlxtUUNzvDQjN9N/uGnUNV7vhCXiQMcHX5vK19Kj0Tx2nhbpVmGEgCzV1aagzn8sodcHTu9yb+BYieFapg1AQnTltqM1DJVwlwbLBLmuVcP1E6OS8DmFMoLlKp4FhTYQ5wMPzu/N2BpMEFo6rOT4gSuj55nmP/i0oJI2cN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIp0UHzA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIp0UHzA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-716ee8947cdso862127b3.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752075689; x=1752680489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/54D4BCy3zEGebL68XibOy3oeCKWmLnwcKNN0eG4lyQ=;
        b=OIp0UHzAAmwiZAsj3/dHWZf+lFlI2aS+dGmSz87LFM0EFk3Z6Tn+fXiAea1fiqhXtU
         POqerBM5iUGH5w6wh4awmoIm3Sj2KPsXcRM3Lh8DivDv+bBlbCiqfAJvWfr8GVv1Igju
         zcCinY20HBt5ggCGgRVwGGu0Qo6w/X7Th9DxFX83rEABNufYAfRvkcNlsvi6zAQ2tYac
         chJbXPtXr8LlZ3hxdCBcGQrjuOUwdrAgH5Yp3CMrhRXqlmh749VeHzysMUg8l/6OcGTr
         WMl/9ujWQjVU6WAKcC5LN52UQMmoaOGUsKyjICCCJ8k0wdMBRDl3DIemw/37iHVWRzlf
         T2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075689; x=1752680489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/54D4BCy3zEGebL68XibOy3oeCKWmLnwcKNN0eG4lyQ=;
        b=aEgQzEbJVibnkUfB5wuATUAvZ/+4yVGHko7N8lWYF/XjE7SQuuJtYpTsAzgm7mWHQK
         0auPFyyXMWmFlg6XQJkLG1Ac+dLi+urLPtCn6Q8sTWv4XBq/uxxWtoBBiDplGNyrlYx6
         YDKnxUFHfJ5b1DmrgtamlLorzADBMhV4QE2HrnUwVa1L16ARwvyaY3StkG6nzN2dsyrz
         pAV6k1en34HW3lu4I3IyaP5Bi0xpYdQabaMfpsZirByYAYe2eLiUVusLmrFrurKFStUe
         6JBBQlQPTRK0VsXMVm2uUReJ3y5w/0jOFe6GR4ni2YYkJ5n0Ra8hTOU6GJ1642/ZptcQ
         fXZw==
X-Gm-Message-State: AOJu0YxNgcGcOh2/ZK3Sz6wgMUfdMNaFcIn3//YVMvUiLqf9pLxGECkU
	XUvG1XvINfXpsLWHSSwOkS0WKHSNFspoBt4F/ZzF/eJWyQc0gfCClqso
X-Gm-Gg: ASbGncsNkMu+C1UlaAqewYTExXd3Hxt9yGBpm2fy6pKUKao0D+hlGodVgVDX52s7OEY
	kOoQI1KZr+3+Zoos5b8tGsFZVAx4Hb9nRi94aRBWw4bHvxP45mU9rGyQKKP1ZC9dNw95bWo2djf
	8+UXmY34dfCz5OMGu2rvlsuxLN8BJDCd4OgKSCOMrJ8RYF9mPuDNiMIr1Eg3+acTOEbBUWhTRt2
	MO+mLJfVPIFJkgZ+nbZpC87UWbD53fX+r15qAp2LwSlazlWcs2Dm9NmqJVIbyXt3Z8cQhLrY8Ol
	CuZW6toa5oSYby/sOP+swCLgFOY0/PJ2jcqluVNdUWrokzf5Y9PtmfrC/YRGCBpaA4mEtqt2QYh
	1o0G5bkmHemuqetlRHeidVV33/L7vHElU7ZW/Mg==
X-Google-Smtp-Source: AGHT+IEAYQ+m6I9drKKnYN8YyOK3DlUhhtAR++/iDzEzDtfT26Qt5Z38eVd1h/9ny5bEQwBh06dguw==
X-Received: by 2002:a05:690c:882:b0:70e:1bd8:a9c8 with SMTP id 00721157ae682-717b1c37937mr41369137b3.23.1752075687934;
        Wed, 09 Jul 2025 08:41:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c467:2cb3:90ce:6b3a? ([2600:1700:60ba:9810:c467:2cb3:90ce:6b3a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7166598b424sm25865517b3.2.2025.07.09.08.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 08:41:27 -0700 (PDT)
Message-ID: <06c1d2a9-bc74-43c7-8198-cc508b56f34a@gmail.com>
Date: Wed, 9 Jul 2025 11:41:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sparse-checkout: add 'clean' command
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <xmqq1pqqs127.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq1pqqs127.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/2025 7:41 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The implementation is rather simple with the current CLI. Future
>> augmentations could include a --quiet option to silence the output and a
>> --verbose option to list the files that exist within each directory and
>> would/will be removed.
> 
> I liked the overall idea but this has some interactions with a topic
> in flight.  2c5b5565 (environment: remove the global variable
> 'sparse_expect_files_outside_of_patterns', 2025-07-01).  I may have
> botched (semantic) conflict resolution but with both merged to
> 'seen', a few steps in the sparse test seem to fail.
> 
> For tonight's integration, I'll leave the topic out of 'seen' so
> that we can pass other new topics that we acquired through the CI.
> 
> I may re-attempt merging this topic later, or I may eject the other
> topic from 'seen' and queue this one first, asking the other topic
> to be redone on top.  We'll see.

I'll update my next version to be built on top of that one so
we don't need to worry about semantic merge resolutions.

Thanks,
-Stolee

