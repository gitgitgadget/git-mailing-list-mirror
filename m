Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786E4E1C8D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365788; cv=none; b=gO5/ueSPR8ZZ4N4CWFh4K+8DdKISPsAJrxRrQTA/5aaHGISROQnGev1xifCe+prneNn53vVZCLxmDJ2FgB3Vl5q1Uc15saG8OTh9iLmEw1IhmrvFFqQAqvo1pCGUDG1Z07zH++N5EfMrdvkqtmDAz1SYJdBI8GBE//t3MLwNV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365788; c=relaxed/simple;
	bh=7cfUY81pRUhH7WXrKZf/Vmgmjw5ifirXU1PwIJUOfY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G3iP3WBeuCyyOTLQkaNwrOMkV6cv+qFY7i8TenOKKdXUkUASWydUKWFPMDwyDTRsDzuYdYxTH0OPSkcwc0MdGlq3KeKgZi5Cy2DOwXfs9U2Xayed4jwJjZsYoLgn3ZXqbjp/jTsdBxmXLFBXxH5bYAhPCLUspeJhjzmaK5RcvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4lXxfH2; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4lXxfH2"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd04be84so1520669c88.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790365786; x=1790970586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EgaDJ8/+45MqU9ubFRIKQTv4jKr0YWBQoqszNUwd7sA=;
        b=k4lXxfH2YeHxslBHPWZJtFJd1XjBrzTV/ZlvJQdWbMNWrR29QDriIM4y36g6hOOpms
         iz8wjxfWP7GyQHuEKGbk53Z9PXJxnbF+7nD1upvjDFZ6e9fTiq18UwZWAJ178/hbLbGL
         A8bHNHxNjXcScUYte+GDFU6cXKBysF5yZBNUbvf/HU0czRS3osH5YZUG+vmAAG2YGBVN
         1QPA/Fq1YryEAOA2TUKKcjRVGdU1bMUTPrVGrZzTehpEiO8FMaPur8yqCVQxSxTlOw2N
         85l/xITQS5fHsGiChvaUcCoZLEJA0403ON9zJkDiKEsFyek61zu31JlQReoUUB4nxMUy
         J7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790365786; x=1790970586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgaDJ8/+45MqU9ubFRIKQTv4jKr0YWBQoqszNUwd7sA=;
        b=zx1mMXDpJj8QB71wwY3Igakp2M/80lacU0rEWcu5dIvHnY7GAy3T6aWcj5dLoLl0Le
         waEon8xiiMc/V2t+XWoYg8rtjQAZBpxa7nEl4OaBK0O0mPs0kEpyOkQ6Vx4jExohBmYa
         rTOsIxZROIibWjXBozCJMnkirv0AJos/idCfOmqOAfHTHmDga2o6akXiltGse5GBRVnx
         08hhc1IwDNXTfZq/vwBRxwlD7mf0SIqZvKejZ7IpcrCd3KSOTkPs12C2wSgpzhjmSZ2u
         1CQY5GpzZrsYFShLpkBqOiSain6eGzS+h6XYlv6Aw7B7YAt+wPeW72jtUybkTOYgecnT
         de7g==
X-Forwarded-Encrypted: i=1; AKwUvBzmUicIAGFrTy+FJqu5aJRtpNQQSPlyJp4KEmW2Wv0AJpEdpfoo/W4TLAxatyuxH1dS5J8=@vger.kernel.org
X-Gm-Message-State: AFuF++m57aQuvt661YcFU4taUbUOV5pHwd2oLS50SoslW56N3jhLVVoH
	F5kkuTvnVVXYN5YjogiAcboAZvCVLrLAxFNahv+G0d6BVnKMRsTAIbfEN+AstaXRGUg=
X-Gm-Gg: AYBFou2x2+beha2RhTUpDfPLwOlB0FPNJm0chvtUupM7OSklv2yHzjBZNW1vo55Q22k
	qlVr+FU6akMR/Hvfq67yDgfFZVhFvDz41qQoyCFYxyBQbpJOgzpel0a0UvvJVYtnAuyUTJi8WWy
	V5qjDrVSsejLLgj53nFB2LuypR86jarMdWB16/zrsEWk2urPBTjfWTjSLP/Q75W3oC3UBGoamxA
	qBWRT3C0TTH5Q3kR4TcJyMRqWFCxmU2Z/ko2CxvpS9zF4svfU5Eyagr03RLOitDD4WTzivfbxnR
	JNleYzCp5hQaEwvNvuBa3tTr3QJPDwFsekswkita4/G49VA5tOYChLEIeJL4zkosOMVg6hf44CU
	fVmveWCugwTdR6Pxda0drybRqh6wfPszXtSmpp9V6K6T5UrI29pjRiIRunFr1tWKSMvstoK3CS2
	yIyr6AIk5XW80Tb1kig4CXI573JE6AYuoSEfX8IE02wLJ2Eb1tuFvtbhZK3BJ54TGCKUFT4Cwuu
	ImwQoRqrCVYyfRClPvvqaOWiGL+ioKmY3bd848v3Ba+fSjI44AoKSQ=
X-Received: by 2002:a05:7022:458f:b0:13b:1bd2:38a2 with SMTP id a92af1059eb24-146ce39b1bfmr1449635c88.18.1790365786363;
        Fri, 25 Sep 2026 12:49:46 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:a5bd:5e99:a91b:f02d? ([2406:7400:12b:61a6:a5bd:5e99:a91b:f02d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm6929639c88.5.2026.09.25.12.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 12:49:46 -0700 (PDT)
Message-ID: <4770b19f-9a8d-4a4c-8cc6-745aa2868b94@gmail.com>
Date: Sat, 26 Sep 2026 01:19:42 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] path: introduce
 `safe_create_leading_directories_no_share_const()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-2-11499557cf31@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-2-11499557cf31@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 14:49, Patrick Steinhardt wrote:
> 
> diff --git a/path.h b/path.h
> index 7e7408dd05..e2d62c4978 100644
> --- a/path.h
> +++ b/path.h
> @@ -254,6 +254,7 @@ enum scld_error safe_create_leading_directories(struct repository *repo, char *p
>   enum scld_error safe_create_leading_directories_const(struct repository *repo,
>   						      const char *path);
>   enum scld_error safe_create_leading_directories_no_share(char *path);
> +enum scld_error safe_create_leading_directories_no_share_const(const char *path);
> 

nit: All other variants are mentioned in the documentation blurb just 
above the declarations. Would it also be worth mentioning this new one 
there?

-- 
Sivaraam

