Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBA3A9608
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731428; cv=none; b=c7U9u8bOL0we1IVTWntb5GFuGO52Wxl3u/5eAGQ8n6KmfZg1/Yew7vuaIkWbaMnfTFqCZqpuwMXE4AiWbMl4jXIooOtQx/EN5grY5Klt9HbP1OWwj2SEB5X5jtYp36+LMiiC9+Mcq49eeNvP5s/anEtrAaEGhMwxMPzxxMtrifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731428; c=relaxed/simple;
	bh=fJRAA+/kp1q8u23bzxdhHWvLupMgskYkMuvk8Th3gCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzBSbdIAkMmlqJ4QRrkhUkj5HqTQ37zqwVyjph6SId88iHDjRWtOrM+Rcn/3eu97YM1NkLX2ac17XNFenFTJNxQu8i4RQvHtZkI++EVXnXCgCnDIJah1iCT2QM3Fuf8rUZWZBnDYgX/3E0Ox6G0XWcF+cHlTFz1B6WTc+1TNuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+1NfzqF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+1NfzqF"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb5138df1aso805283085a.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772731426; x=1773336226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/UxoP3MosFFsS3RyF7DvqC77y24PMID7MZxkhNB6rA=;
        b=e+1NfzqFJBCgDPzarw45rHrJiwCnZpgWFjewna3mgdttHoScOzurmZNbE3TLqW25yU
         5zYdHxwpjjuzS/yz08UcspGi8lvdR2fBVJQE0HAQiyRpfNK8OYTvsTf9Uq8riez5p9iH
         9jlHYqS9XxwAGIEaV8Z3j6a/rlFxvMFeZjY3/i6saTSLelhcnaR13ttHVsK9KQziBWal
         hAU2j01iLoEsSFeUrPD/s/qO/N3uK+ct+CFOv09pOb0S+xB7azW1INRM6TWw18ctT3I1
         NrRN+naChgKmEXvO2FwUaVt4QHMGMhyvpNzUHZS3+z001uE5+DYs+G/W5VKyGDonuhmZ
         SRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772731426; x=1773336226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/UxoP3MosFFsS3RyF7DvqC77y24PMID7MZxkhNB6rA=;
        b=l2f6ExaMm9d6PyRiyPbcq/3qj+IpBaVT91ENjlWSSyevIncLbPB9+xus4oxIc8pZi/
         fpFxFPq+goYcnZUStjYFR/ob3xwY5ddRhvDbfvCv2ll33bedGChIy7FQCkVjK43GKhlE
         GGXHsp/KJPbiDbojrvYuM20ECdgTsYbFHGvYDY22KVzPphI5LioswvnBQxtVH1Bn2Gjh
         N1w6z/iU0f4QR/QGWOd/0o/U3ZEsxIorZxjxv4qAp3ySI/VbmZIKcLtMBDMxQudSMt0D
         uVpB8CMDf0j/3ijcD7GF+z1VOE36Yxn2/FkfdClNUBDrMj8nsTQWJZM/XstBLHq/leNW
         WnMA==
X-Forwarded-Encrypted: i=1; AJvYcCVgosJo3dqrdn/dTQ6tjLByhAjv+iQkaVUCJlVefCp5Hi/vh+ghLPjlSAQnYTgsUi/vl9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyup0HgTYb6Hxtd81VrU4PdAJL7IGXs0ETmNhVGTI1FMvgratPU
	siHIoxvtvGn/OjAwD750i0T3sq35ervEGrmoCy5oemOEkGYjCupgtLVZ
X-Gm-Gg: ATEYQzxBMY+WgrSpe7GfaTDgjMe39Uv+54eJnDDDf+gnv4GKO7JRu7Ov2qEPQ0ZvZzm
	O9xwtxTy/x551eIwkNgzadGv9O6ZwngtCrE7Kxi+IoHd8ZZh0iFZZnV64dnRC73vFbHIQqVnn/D
	tnirTjNdRthNO0uOtVKA2G4P8y0blGJhvEMY6B/4J42+4mZxN0fpaho/gUPoR+X59AnfFD7s0zP
	WZSmA0IAuqE0evb3KNrGhAO0LbbsSsGSyJAdQf/VkDlubhEhp+iwWWYMnTJ+jqYMfX0UhZw9gKv
	lYaHDSh/jfURLZVGbSQrdJE3lqi1Q7k2MrLeqPaEXH32fNe+YPSmp9dkQqIiEAl/PV1E6+GXRR6
	b2M8WAPb7+PxY84SuN2ayQk4BWXMnUtBcDt8vVc2b0WNPGd24275QOMS2CvUzW0O72A12Yj5Ijw
	yoPxEdBlQiDNUM8q5pKnjSeQWzBMqB5BjVpr4URpheZJ/T9C5p44X8paJD5U3TQFZ3YMlyPCDjs
	+rIoJrm
X-Received: by 2002:a05:620a:31a4:b0:8cb:4c79:b44f with SMTP id af79cd13be357-8cd5af81919mr890457085a.51.1772731425933;
        Thu, 05 Mar 2026 09:23:45 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf731c0bsm1944139385a.45.2026.03.05.09.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:23:45 -0800 (PST)
Message-ID: <fee9576a-787c-44f6-8630-cdec29df2b3b@gmail.com>
Date: Thu, 5 Mar 2026 12:23:45 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] for-each-repo: work correctly in a worktree
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
 <20260305012035.GA53966@coredump.intra.peff.net> <aakfT3oio1XQSl4R@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aakfT3oio1XQSl4R@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/2026 1:14 AM, Patrick Steinhardt wrote:
> On Wed, Mar 04, 2026 at 08:20:35PM -0500, Jeff King wrote:
>> On Tue, Mar 03, 2026 at 05:31:50PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>> Updates in V4
>>> =============
>>>
>>> Minor updates from Peff's review:
>>>
>>>  1. Update the comment of prepare_other_repo_env() to avoid duplication.
>>>  2. Rename the new method to sanitize_repo_env().
>>>  3. Move incorrect removal of 'int i;' to correct patch.
>>
>> This looks good to me. Thanks for accommodating my somewhat-bikeshedding
>> review.
> 
> Likewise, this patch series looks good to me. Thanks!

Thanks, all. This was far less trivial than I thought going
into it, so the careful review was essential.

Thanks,
-Stolee

