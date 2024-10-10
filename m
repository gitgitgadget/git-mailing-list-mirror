Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B31E5715
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584893; cv=none; b=XDXM05B3KaYYBOC1HKk5whoMpWPc9wB0qs4BoexpFGVOUjnbnmnVHXOFB7Vk8Thv18KmMLIfbFVs2tEj9f/g8+9Cnlf/Lg5Yf+NqZRm619FO2qYv+lTNBeX6W47Ldvt2SUVL82/j3v5AFGx7JwOCAv+yAS9xMttqueR78UcNfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584893; c=relaxed/simple;
	bh=dKneALBODXeKvoCvuIx6l5rjEXDyLe+IWwZ62uglU/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRizK6Pq8D6bXOtLdusHe0SFnR/S6Xo7GuVkbW40jgRUPD+QRGZA30HSHHrMUctL3PgXj1ZHsRqSsod5QQbSx5nmf+KNHZIHC8qjIa3yoXyz5kkLq45d9zT1aorcFkjueLTy0A6E9VwPzXLzp3bt1y36iOxmyDXLojjAB+FOaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok/3j+J9; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok/3j+J9"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29130cb129so608793276.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728584891; x=1729189691; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQg8kFy5u/WPmduWDgrdVMpnvpQnbogk1dH6ybSK8QI=;
        b=Ok/3j+J9coyUw2jpo5coVWEuM+bNGZNR3zO66B6JQZoJxDJxMiPsN8UEjzwDRo/cQc
         4bBlWlPLGiWUPQ1zWfm3a6S7MZJFP8ld8oxfMruep2kwnxJYv94N54GxvnnYqDzr7US9
         dCqDwJaRDOUvnPMlVsRvOPFKF7G1F1wPURH8kT+PG4dpsa9rjoC8humZB/bKMqZWNNSB
         a4cIENEeNxPv/jK3UpOZmXvlX2mEZ4es09wOf6p8ReEjVbAcGY+b9B/1BCToP1UAyILS
         GVm+XLUPhIfOpRa/wNcz47BmvmQmKX0GOsq9X3rmOK64uCdMdYgN0Ndztgw5DYNvd0XE
         8CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584891; x=1729189691;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQg8kFy5u/WPmduWDgrdVMpnvpQnbogk1dH6ybSK8QI=;
        b=t/z3RB2APYThAiY/R1NHVR6G0N12DgB46OcYe9dh947TT6fjQ/ma+WJeJd6nyQnRz9
         kYHltkHSGtbNVVhDQjgmPhZpMONMfr42RMC/VWItorFfdkGaaMtxWMsv7+k1xacadhOi
         M6nWjIJq8UiBGL/I3NYDZT12vseCzIzqYCe6IpoYYKSbWqemi61t2gf7Zi8RfMRwzVrp
         OZI5pcfRrZ8+e/YIGHo2EYZJoXOVdQ+EWaE9CmnQ/sPZxEBRfAAhqDawNtn+hZraFXFE
         jI2nPQvbJ7qa/fewkOhao6OCJxxM/nRLEMs+RRdCWmkfsQqoTiV4PBPnxRUC2K+qILoO
         6k2A==
X-Forwarded-Encrypted: i=1; AJvYcCUPpmZwUmAx37q3Qeebqc/9EtvxEuMFvVnnApuNpw3T5ssH7CKb49SkqblAUK095F5k8Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hiiJs6s+zLOozZ8E5y0GEiSjYaWEJSTC3FXEnBGYoqoODGPL
	c3bRHE6l1S2cAg8NoDQWAFP1Y/snMarJKscwLLEGustjPuz8a3EL58On8g==
X-Google-Smtp-Source: AGHT+IEIDM0O8yz/0UJ4ro77Uglkx30V0OF3SMRpuwPIVkP1ojMi8EBkCaGzZBfq1HqAISBbo3ySjg==
X-Received: by 2002:a05:6902:2786:b0:e22:65ee:9a17 with SMTP id 3f1490d57ef6-e28fe4d9ef3mr7207841276.44.1728584891277;
        Thu, 10 Oct 2024 11:28:11 -0700 (PDT)
Received: from [10.37.129.2] (syn-068-173-161-103.res.spectrum.com. [68.173.161.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148dc6fcsm66914085a.38.2024.10.10.11.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 11:28:10 -0700 (PDT)
From: johncai86@gmail.com
To: shejialuo <shejialuo@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/3] archive: remove the_repository global variable
Date: Thu, 10 Oct 2024 14:27:58 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <4A5B361F-159C-421C-BC47-BEE3765E6F34@gmail.com>
In-Reply-To: <ZwDnHs92pEs0UJbN@ArchLinux>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
 <5d33a375f41132b8b378885d00e934b9f20a0854.1728099043.git.gitgitgadget@gmail.com>
 <ZwDnHs92pEs0UJbN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jialuo,

On 5 Oct 2024, at 3:13, shejialuo wrote:

> On Sat, Oct 05, 2024 at 03:30:43AM +0000, John Cai via GitGitGadget wrote:
>> diff --git a/builtin/archive.c b/builtin/archive.c
>> index dc926d1a3df..13ea7308c8b 100644
>> --- a/builtin/archive.c
>> +++ b/builtin/archive.c
>
> [snip]
>
>>
>> -	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
>> +	ret = write_archive(argc, argv, prefix, repo, output, 0);
>>
>
> When I read this new series, I feel quite strange for why we only change
> "the_repository" to "repo". After reading the comments from [PATCH v2 4/4],
> I have understood the context.
>
> I think we should improve the commit message to take about we decide to
> remove the "the_repository" from "archive.c" code unless it will bring a
> lot of confusion for the reader.

Sounds good. I will add more explanation for why we are making the change.

>
> Thanks,
> Jialuo

Thanks
John
