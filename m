Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E127EFFB
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794905; cv=none; b=qc2Ly7gVr/GPfQSj0Or2dY0zPHb8y5tWlpuifH0bI6Lvt1+dntwxIdp3UoVlSFtC9fjYtHUcXuPWL3LTuoRCFechn99c6qWWvN+zpuCCZGyDyS2rDS5Kp2NiRRobbS2YeFYTlLAgS3mMC8e2zVVj0H4+YFKfIVd2fOU5sWweIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794905; c=relaxed/simple;
	bh=6CjY7ZkRnoKdp5Y/p5DtUvEL4EuCMLHfxWjzh4/plu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYGaLHFKl768SeB1Rz9otjNkEgorqdoNhZ+yTXm13Kw+v/4YXdNJLwcUoRjF3ixFEkup9ULtQoGYZ9SqiHV+bcf9RJ6+lBJx3jENXqE2x7jybnPMqUr8pzrsxF9X2fnN1ZFbD+bG+gWr7A5tXc45ZkwuDOfbrpMr21tA+pW3Wbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK5J6b+3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK5J6b+3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so532854f8f.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758794902; x=1759399702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6fMGSvKnG0FWyfaA6q/gN9NxgIqLKJlbnOsklsUy/Y=;
        b=DK5J6b+3Fadb/ZjrzAUXIs3RVSd1eUEBpH6RmWpzGd/8wuEjd6BUn1+rMqGnBRgmLa
         IC0ZIVtaKhGdvNM3a7g14jA/bheldG3ct2MNGPE9dk3ya/1b1p4VcCPiSitHcHTFBOI/
         qh+wDjhQZe6mG60Xk82EZbV5XZ9k1KFrdXGkK+e1iDc5uXCM9Xq9jXBk91+G8p6Fr1ER
         977pVUSkVV48S8SPQQnkCTbUxJIZccjJf6foH1MtdbmcbQuqX+eZqwoBv0e9FZHmip9Q
         Eh5D3LRUpUw9pr/+vRT4ztFcMY6VZS/BnwsU+1HvxVNm9vUDjQ2fX87/u2jPuw0bnFw+
         feXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794902; x=1759399702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6fMGSvKnG0FWyfaA6q/gN9NxgIqLKJlbnOsklsUy/Y=;
        b=bM24zylNfnhUM4FM3zowcUwBvOViVE9Pd5qC+DdOWrOCKLslvAw+63mFc6bcz6xI6f
         r1dkzAtw8dghcQmAvjCzu1z32SpagQd/TEM2TMKh7t8yKPd/hg9gKESYvPbrINCcjieS
         GusD3kJx2hxFyLmOKAR1sKBNOrqBpTCsnMRMEj2LzsHVTAcZqXPjwcyLabBDmL137O4g
         ozmKQCob7tHFpypE/IfVpUO7oUKTlJcx4PSyNFydbVGlhcTBSCvJRLUDOSAIfdwa+gsO
         qtwmMlkseJplpU6VXGmzuKjP3k88V4aj6awinMV9+QOxCyKiPZrZ6RwEGKyye6nrT5Bd
         QHlA==
X-Forwarded-Encrypted: i=1; AJvYcCUJb8iW8ao1BqpfzmEX4cGfQ4auzxxU/Or1mYFJxfs/hm0LnbVPEF/vlyB7A6IChWuFdBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJj5cR+y2wlTgcDNQlWCTI2KzGCfPztlvHUDjqyFWHuJQiaAc+
	uFukB8eCx91c/JyU5N01hbgi3jhj89tF1ftdsABO9Y2ApcqXXwOLFDEF
X-Gm-Gg: ASbGncuQoLMvQd3R0uvcDfOSJla6DCc01nKQjz7gOadgaALnnPl319heFvdo22faS8h
	9JJj2hE4cfRI6E2aFQGZovmDPdeYwEDrBxvck4a5BnIcUKVWkP4i1LGGPyXYs2OB1syTXgrDL9x
	1Xl2s176fFdP3/NNzkDuOS2VX7pJ2t0rO2VY5TPtxU3s2mqgt1Rm0dGf68/HgzgqPefHWmxuXrb
	srmPqdu2Q8jwe8mhEoVwxLirxEIKvaYnunX2P4IFA1p8mEhE7ZTLV+FSHlCJNRHG+7lrrr35BU5
	U5TvuKR5a8qlrpc1/IZdf4C2+SXJswcm8BNChVrP+VDz4ionzJ7e4HFfHmtFRU0zGYH95HA7VOg
	9WGArSeeO1CLNGioNzmoeH4ftyhwJ+r3KMMiW4xWaR8YzkgjEOXUgsxqtC2MorGNeiZ9vOeqaWj
	P3stsk
X-Google-Smtp-Source: AGHT+IFtnshPpwcxwge13JYKqwWzIIrOv3MdUNwCwtO/CmEq6ZarEIp7fCh385FY2swOHbR943BIMw==
X-Received: by 2002:a05:6000:1787:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-40e4cc6316amr2415850f8f.50.1758794901829;
        Thu, 25 Sep 2025 03:08:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70dcsm27169095e9.23.2025.09.25.03.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:08:21 -0700 (PDT)
Message-ID: <1955d836-8b5a-49bd-96b9-5d1c14739b70@gmail.com>
Date: Thu, 25 Sep 2025 11:08:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Mathias Rav <m@git.strova.dk>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
 <aNQiRFbBysXXAPDR@ugly.lan> <xmqqms6jk25g.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqms6jk25g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2025 21:48, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> 
>> On Tue, Sep 23, 2025 at 10:55:02AM +0200, Mathias Rav wrote:
>>> Change the behavior so that fixup with -C takes both message and author
>> >from the current commit, instead of taking the author from the previous.
>>>
>> related thread: https://lore.kernel.org/git/YjXRM5HiRizZ035p@ugly/T/#u
> 
> Thanks.  That's a great pointer that shows everybody involved in
> this round has pretty much held the same position over the years
> ;-).

I'd forgotten we'd discussed this before, thanks for posting the link 
Oswald.

