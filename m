Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1A1CF7DD
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884554; cv=none; b=TZU2Pw16wptsNDtlps7uyiAg4b0c3R5P21kmhZn2y7rcDa2EZF5BWMweMDYQSxfSejZDQokBOS6f0xb1I13w0t3g+P/EJHPuiSZ4MSCAJPnbk2EX1ecbvUjmV6NMW8KVIavyFb+AQoLvV5bdGpzhn4/j2JjetsWs9/vSi2eGdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884554; c=relaxed/simple;
	bh=qF0qW+e63HZXKI+MMkPifdtEM6ljsx3yBd0CzjTZ0jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjhM3BjOVnwQWumCwbHiRUZqdagGfo/caCW6LmO4w4ub9sdG06ABwvmMpgfm4/RwQ2BfD8N6PXaxEpzScEB6bySNrQ10VBUgzSWy6boNo4fl3H9YSFwDTNiJXTPLoUmv+pDEGncwAcOrX3XTRE+jYVSAsN7EBBxvA/9g5VB6DOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfeciPhY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfeciPhY"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so990446666b.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884551; x=1728489351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oKzspXuVgEidghcHIiyKXibd/vTzkHwibZoZrVtC9jc=;
        b=UfeciPhYj5tUKvj55+k67vAJACiUZnlImZnusoitjx5QsRzucyfdTmSlHtcYi3oDqi
         G+wLEUX5dW3H+2KoSFLRaOnYiSC1soz66fAZegAQ8ddH06OFv/NUpbaWZ10a4IrTMUjY
         cO3ctF4LDnwXZuLV398BQihHdbdiBADqW1HzbkaEpk2aXTVG+wX8zYsHxDcIC1e69TBF
         iQsVgGoHRTAD94KPJs0NByhk/PsMsX6DK5pahDoQ2If3RW2YkvKIjgYIqc0hDVb0b+Wt
         UBRpZaD84o4vDHv06HdTfra+xekPAqI+Z7JSv3NtL89lMacOcGkTneWyeO8UJr5PL9KI
         10bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884551; x=1728489351;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKzspXuVgEidghcHIiyKXibd/vTzkHwibZoZrVtC9jc=;
        b=MdBi/LVeM2rYUWENhpr2JvtM5+puYmeAGU8ebydKiFSutRDSRoeh9zw3vFQxtxLpoT
         eS30DhyDAgHptYSxUJFvf5OJkKNJMhyOKCsSNoC+3JR7Km8byxLyVK6XpsO4FJ6Y20Hs
         XEl/X5npbz2o5ylUlMOTQ9qU8KXNqxiopqVm+VXcbDX6fWAkYdOhpZe3fswYlpcmWWC0
         /uMq8Tj5SKgc94Und/FFbnk/TrD5KKoprkJzX0FbgGpLRRaLFtkyPtw39ltWKd6NfxMn
         7U3jawf+ZqN5CROj43jMaqG/XkDlpeIrcf5rlDtmuct/IHa1Hs6huxy3adXK609cR7v7
         JHJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhJ6zAWvicVhVixTgD/6HEH58bEgmSyjHAxpG84HAPidEqGrLSdTM8hiHNRRY4PUdSpxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCPUVDp+OUvB3AIAV3YTzDqL94vLky+4aaTAjN5Ed9g4RLyA8
	OeAaQr0jQRZ211SsydIi3/4qDpnLwDB9X/eBxKXe89OiWeRh4XVC
X-Google-Smtp-Source: AGHT+IGdUnzugo6kbn4XMJ99YIyVfseZikfq8UkyVSCuQmORJc9LPAbRg8aCSPd25CnAMxHT4KfApQ==
X-Received: by 2002:a17:907:94c3:b0:a86:94e2:2a47 with SMTP id a640c23a62f3a-a98f824db54mr346367466b.15.1727884549767;
        Wed, 02 Oct 2024 08:55:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277726asm897796966b.10.2024.10.02.08.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:55:49 -0700 (PDT)
Message-ID: <0d66e444-b971-456b-8838-e24638b2e824@gmail.com>
Date: Wed, 2 Oct 2024 16:55:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Intern Applicant - Proceeding to My Task
To: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>,
 git@vger.kernel.org
Cc: ps@pks.im
References: <CAK83d8qQOHdXGpWnSLLVe8cOZ+VT2PTJsYKV1sP1jGAbgEDUZw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAK83d8qQOHdXGpWnSLLVe8cOZ+VT2PTJsYKV1sP1jGAbgEDUZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ekikereabasi

On 02/10/2024 16:37, Ekikereabasi Nkereuwem wrote:
> Hello,
> 
> I would like to confirm my interest in contributing to the project [2]
> 'Finish adding a 'os-version' capability to Git protocol v2.' I have
> reviewed the project details, and I'm ready to proceed with my first
> task

Welcome to the mailing list and thank you for your interest. You can 
find details of the micro projects at [1]. If you haven't done so 
already I'd recommend reading through [2] as well. That should give you 
some ideas for how the Outreachy application process is designed to work 
in the Git project and lays out the expectation of us mentors.

Do please let us know via the mailing list if you have any additional 
questions

Best Wishes

Phillip

[1]: https://git.github.io/General-Microproject-Information/
[2]: https://git.github.io/Mentoring-Program-Guide/

