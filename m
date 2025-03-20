Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C38F6B
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499970; cv=none; b=WYeGm/aRiWh++HThpPVvnhyAODFBW92LM9lZQV3JchjO2T86S1muO8nuTGrFGQ8XJhboOsxU8YcWZHqdi9XWKKMUZNzowbL9en2g67OAf+YdrzQh+RtzYvqZJUrP23hMqyNxjlhtdgIqOHiZoOFTMP8gmnrDSlqprylTuSsHwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499970; c=relaxed/simple;
	bh=GSXz3J2zEu1zfd4vXHG9LoR29VaQ1MLa3ydc9SsB70I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKP83ewxvDyGk4ZzdBOM/VszAWc7R3KWb9twKwP9Ilc54GQMCLnoIHVhVv+OQnBUHVGpleGREhha+rNVZmsy0NCvZMDHAzKGtaAuunRtEOOtsaPTiCdZA7oiCUns8fybMNqBoF6rQkyEIv0pL327OxAg5Y84Ip7I15lK/NLzj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FahaVOuN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FahaVOuN"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6feafc707d3so11551897b3.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742499967; x=1743104767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpyBYmjNENS5k6NHuYJgzDSG9pYNH5kjqTNw+iiMP0Y=;
        b=FahaVOuNqEBgZuY+XPA6xlhfRa/hNVqB62AupdZWBiTh5bc96xgMDyJtFDc8fx1kTM
         8oskZM4/I1u3T41QEDDS5YLmY5pMRvm0DxPFsn26pZGsnDVjHQ1+M4cALOieHyTTESnP
         2k7gWZlXVCEVtlWx9ehbh1jeZ4LyieO1WPHQozNTkUGQB5APdmD4wMeC02iq2yOT9Kr+
         hRnId00o8tyHY3Jpv3zSDZPADwAbnr71YPQx7uySB/GbgbImu0dIXPSwFQr+MOV0LfJe
         yY7J1/buj2quPEnFm22yvhl7Ay7JMrXI4pjgUHpT9F4249McE75f6xTT216vndYekl6P
         Qdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499967; x=1743104767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpyBYmjNENS5k6NHuYJgzDSG9pYNH5kjqTNw+iiMP0Y=;
        b=MuXttqNKf8icbhBV+lUYLELh0ToAhKGD7TD3ObigAmxCGzsWT6d+FgIvWuvzX+Rs74
         THQCTWWinh2tq8L0Zsg8KzuSfhTFVwmdNuJWWR8eATyLPGz57Kl56QggVxXZ43h18T95
         qr4SkuVQ7MfvIOGMQWiO9wDA0S0AT6fy9PCGiJnLzMjQIRg6OR744OfCpx5zvCCETZPm
         Zan/V9eRZLcdqg9m6X6HywF7t51FM8kJC30Uoqlf2G4+BtFwn77cWvkxw7AUN9wVXnbC
         lYjigj4GPl2CPRSFy+h65ly4cltSBP8v1LUyz37CYXJNJTFmQKFV53gnqr9qhmOcjheA
         U3/w==
X-Gm-Message-State: AOJu0YyY7BjhCMEKdIxppS6CbHLE/cunYLPcqOvFuaNyoUjzf8w7m3LJ
	qb++xeI1IScK21S18+SYjzp14s0WhiwS5ZS3FI4LVxcuBX+mLSo4
X-Gm-Gg: ASbGnctaG2RDiM3ZlZITejH0cqI530wxqq5v/XuE80CRDbBwkpmzxH1yw6qOqCBMA33
	2/iSkSWFMWSyH32gOYPHfgwKb9L268Oo35UJ+O+KajLQ2DfYQ8QX5KEMFdbmUG1943uBWmbc6ky
	AUYRrK85ed1w7oeQhY8K5z5IrvvH4vStboMedtQzRGXonxJMFpoCnlTn6fyekevjxenCVpigYAg
	SRTdh6YtlJTsC4WigjRNOAXjv74/kyOkqcs+BozV11yk0XyB9h7djhEpAOjQq9p5G916kBHFUf9
	9o5+haq9eLeUNYDMb4lhfBUzhgGjg+zPG0h7nwhCnxLrYWpFrcP8DBO5Yd7+ByKMGu/9+badu+S
	46EhlQu79lKlI2lWZriB6
X-Google-Smtp-Source: AGHT+IGAxOClsU1H7GEnslwchKt2M7/tmYPF1K8+Lp1p83x8K9+iZonHQYsps1hm327RTKq8m/F2Rg==
X-Received: by 2002:a05:690c:6c06:b0:6f9:4bb6:eb4e with SMTP id 00721157ae682-700bad42ac4mr8516427b3.31.1742499967350;
        Thu, 20 Mar 2025 12:46:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f12b:82ea:4a0b:3183? ([2600:1700:60ba:9810:f12b:82ea:4a0b:3183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba883cccsm698197b3.105.2025.03.20.12.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 12:46:06 -0700 (PDT)
Message-ID: <2649010e-e4c7-4c39-b697-ecf89549c0d4@gmail.com>
Date: Thu, 20 Mar 2025 15:46:05 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] pack-objects: add --path-walk option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <9b31dc87bb61f4d73eced02a24baea58bc51aa5e.1741571455.git.gitgitgadget@gmail.com>
 <Z9H5JsicyLWXagxS@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z9H5JsicyLWXagxS@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 5:14 PM, Taylor Blau wrote:
> On Mon, Mar 10, 2025 at 01:50:44AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>

>> +--path-walk::
>> +	By default, `git pack-objects` walks objects in an order that
>> +	presents trees and blobs in an order unrelated to the path they
>> +	appear relative to a commit's root tree. The `--path-walk` option
>> +	enables a different walking algorithm that organizes trees and
>> +	blobs by path. This has the potential to improve delta compression
>> +	especially in the presence of filenames that cause collisions in
>> +	Git's default name-hash algorithm. Due to changing how the objects
>> +	are walked, this option is not compatible with `--delta-islands`,
>> +	`--shallow`, or `--filter`.
> 
> I think from reading further below that this feature is somewhat
> incompatible with --use-bitmap-index, at least in the sense that we
> implicitly disable the latter whenever we see the former. Would that be
> worth mentioning here?

While it is not incompatible and does not even include a warning, the
--use-bitmap-index option gets silently ignored. This matches how
--shallow does similar things. I'll still add to this doc as I agree
it would be helpful.

Thanks,
-Stolee
