Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC723BCEE
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756561146; cv=none; b=OtHybU7kz4xIUiDvzvoCN/AIqDI7kmr8yuv1OiNnCeRt+akAqLxkX0KiW3wAqPPb4bkfBr+ztkpq1OxGvo9uNFo3hKNjJy8XdPQLDdTHA2e0wmI2JWk7MaGM2NUALyRT7f7ZCU2hJXR4wesjizdmXv8DWAiUjFTY0NaSdrRLNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756561146; c=relaxed/simple;
	bh=gZ7at/EfQ38OXJ16XDD7gxOkIOlCxyVSd9X6UIRp6p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfUGWUvu5hSJQL5kGtp8EFXXWg9wbce7w1cmnpDowmIjrCXfKO2VO20Z/NQogZ3BfFT4mIGoDTvKJjQv0gORM1ri/tuBxl+R05FJ2WAJxU34LtzhAxOch0g04dafxlxkW1iW5yIkdml8hpF72L3k5GKKQ/xVYtKqaOgoGZgl63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcBwg5Sj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcBwg5Sj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b310f0449bso9590501cf.2
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756561143; x=1757165943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfFCLNLMwtk0IjoeZM5KmLYRaYV3raBXO8NP2X2oUQ0=;
        b=ZcBwg5Sjvi2L0k4cr3KyW5mpadomvWK/LyMmfTSkG8JKn9Sv1LvMtQebfznXC7azlQ
         tTFrepXznvla62ORe8gdZ5/TTyqDji89EtWNz6/014Znyz59HUuVN8Q7ZVt0F1W/mj81
         jndm3P7OiR8yIQzoacnRIy3nbaaTu9BhPwvquTGXsncLHIXkVUmEzrZA1X0OkcDWYeku
         GFHBbOGtsD7HJvAtB2D2HDcj1aj4A9pUWo2RPO8MkDozkp1xI7pOq1uS1OYFDDNxTR2r
         /NPSC/+l2KtEUq2w7Z16glCml6W6RH5kBUmHAxAGqPGPJuzwJtNwtLifUQEE5EizL38g
         wkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756561143; x=1757165943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfFCLNLMwtk0IjoeZM5KmLYRaYV3raBXO8NP2X2oUQ0=;
        b=VqFncigRMIgStxQl4AblOZ0w6ky9efllCr8X4v19ohZyfWZxkkyYidfMOGKXjInOXJ
         oIRoaIjh99XhPzyGlfd91JFmLjJz4Fm6AU4Gm2Z8ZiWO+dyqORsEKBpQ2dXgNWCxxbq5
         zx8M4nn8lxtb4mfsoscGyCG3GKKsb8OE9xM5PowQjT3RfZCGbOZtqv+53nQ4VAawN5ND
         80lPNtwBd0BHOmA23M0/bhDlyPX668y9BkngzczuZVTcRAYIrtnv0+JfU6vFxmc3Q2wM
         j8yKPNCUR/FE9A5x/zi9u1yhPKKnASk6kPtMoXAvFXusQVLzAJ07sEnD2+W2SJnNLFbo
         +IWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVs9ngLQKxoeZP4cTuJwe7GHLPnJN7W7jfQ8Fdlva54ssafvTEdeFn0NAOoj+S74OFhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAr78qCFnyFkXeHumB5Ndrv2SAAT2yc5uL3FTADUW25eby0yi
	HxIbmwzAiqG8+0HHL2GFBGaPm1XhKCQ8orNGpmIJi6t+IOl38elOGaR0Bas2qt8Q
X-Gm-Gg: ASbGncst10q5U79DOzpOhbx+CTs1XulYVRr/OHHZZb4CnIlP4KegKEVEwCobfN8WJLS
	PgncobaUapoNu2Dka8oRgG1yL6lAe5d7m+X26nl7WaDm5O7ZvU89X1jbh3AclLZzNRNWIhnEMTX
	+F39cfCD2LD67rOeA2f/2pjo0o/fTPZo228nASoHTGeYPqqxpUiLNmDprS8J2WtHV5YJ2xQxaGj
	FSSSsCXeL2gWVO3/1rvkocVeROlxbvGdae6N3T+Haijo1ZoQ+eu8ZYCmABFN1d3G4Sw6QQtDTTX
	rN3R56wq9UAOqJSOtK/pXHcY82EOzs3l9gzODwTGQFq0Wd0C/EMzVDPR5HHmqwNM/fsBk4RSXuI
	ozbMRhSZDNX3JG4QDXoLN3YjqpVRqhGOLkvAzT4Jl5s4+xUyOD4ydjTB9Jt3m6L/hKqwprMLNd/
	YYTJCgdBQ84jTVLmIbM8yn
X-Google-Smtp-Source: AGHT+IFX5QM+PmfEGRlSu0vNjSwxpoXOTEiOmqHExccCS+Iviw+yh7NcywiNjVz7GXHeVhk3MerDZw==
X-Received: by 2002:a05:622a:259a:b0:4b2:ed82:29d5 with SMTP id d75a77b69052e-4b31d8526bcmr22832001cf.33.1756561143548;
        Sat, 30 Aug 2025 06:39:03 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:85d0:178d:3525:8f0e? ([2605:a601:a6de:d300:85d0:178d:3525:8f0e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc14849559sm355068985a.41.2025.08.30.06.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 06:39:02 -0700 (PDT)
Message-ID: <f6c9b931-1587-4517-9cca-9e9d0899021e@gmail.com>
Date: Sat, 30 Aug 2025 09:39:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] midx: stop duplicating info redundant with their
 sources
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
 <xmqq1povt67o.fsf@gitster.g> <aLD1s/LAcYlDujJG@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLD1s/LAcYlDujJG@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:34 PM, Taylor Blau wrote:
> On Thu, Aug 28, 2025 at 03:46:35PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> Changes in v2:
>>>    - Fix a comment typo.
>>>    - Introduce another commit that simplifies the calling convention for
>>>      `link_alt_odb_entry()`.
>>>    - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im
>>>
>>> Changes in v3:
>>>    - Introduce `odb_find_source_or_die()` so that we don't have to repeat
>>>      the calls to `die()`, as suggested by Taylor.
>>>    - Split out a patch to adapt `link_alt_odb_entry()` and friends to
>>>      consistently name the parameter that refers to the alternate object
>>>      directory's path.
>>>    - Link to v2: https://lore.kernel.org/r/20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im
>>
>> This has gone quiet even though the previous two iterations got
>> fairly detailed review.  Should we declare victory and mark the
>> topic for 'next' now?
> 
> No objections from me; though I still would feel a little better with
> Stolee's opinion on the MIDX --object-dir stuff.

Sorry I had missed this series and in particular how it handles the
--object-dir option.

I think the modification to add structure to the --object-dir option
by passing around an object source is going to make things better.

The one thing I was very careful about was that we are not trying
to create a full "repository" struct based on the object-dir, because
there may not be one! We only know that there is an alternate object
database where we want to break the norm and perform writes. The
changes here make that seem like it continues to work.

Thanks,
-Stolee

