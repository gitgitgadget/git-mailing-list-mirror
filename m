Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20B3EEAC3
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413891; cv=none; b=smYU4xCESMr+AVogeHb9i96Wi6TaEuQnO0V2eJl/zDUXOe0a+nepo1agLUpPGP+ze4Wr5bNs4wBzRN+1DErzSyUiZzd1lh4nt54HZAEZCjVEG9bOD+sQTBEX7V5Bw1DlCwuht6FtPMrCJnGxII9HRjUfCdyw+pG3l3dqrajTcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413891; c=relaxed/simple;
	bh=cNWGTFZmPuWrEuWXPbNT/DkpTGTcU2hlJjNvG/LhLH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bJwLDxnYuWYqsMMpgErvbmRG9FO0OPgZrXCXrudcYBy96T9zEqryY8erPevxrHAP0Sj225urSp/Ev11cKRVwq5nzLHO+NjLQrKYPBK9RrcphdZxdmN2AnFzBz4mCEBfVVMaV0d59las5FoawGh5JrefTNU9oBi1EybIe6FNYTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP4WLhzA; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP4WLhzA"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6ca94e539f9so2076760137.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413889; x=1781018689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=siqxM+44YRxTLO5rCQhfHL/UO5QsLD+MipHOixUg4RI=;
        b=SP4WLhzAEGalN1Jx5nG6MKvYXVnr8wpSRjGH7A27aHfiqQeEr535kGPbYv8x+may3k
         9fIDtgNz6ldh/iOczqSsrLTUxFsbDfcTR+5TUDgEeAcQXYpjeCY/pSZ7IJYKZOzzRdbU
         xq63OMZYQiRII08F5kMJQ/knc5oz1DRy1WGLAlNOFxy/9PPaTmTVtj60dZRQy8Wp57Eu
         f5es+yMvfiRxpyBlMWLv62Pv/M54gqXTj5zSpGYhxiJUFw71TNxXAXbVAZA8rTAU9ppg
         ANdtE/ecKEzD4fDtAkRZqtaRyrTOqS9qq/Wrm4Yx6EPJZvDXhUgu45EYL9FdcV8XIZ1j
         ZBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413889; x=1781018689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siqxM+44YRxTLO5rCQhfHL/UO5QsLD+MipHOixUg4RI=;
        b=iNINui7ns7OzQ5+6fvfiMTCJ8qw/3zwoiyOgrV2N8PmNRbRf+WBDmOdM1x7ohS9a0L
         VOp9GbOEwjYZd5rv5mOlECn5uFbA51NnN5QSaEi59u3YT7Jaxre86fxfT5Q+dlNzJZUt
         lmBi67Yj1+riwlrsWp5vg0XshdIrWE3IepwCdybYNt/2ZjbVF/MUC/+Em7COmt4yZPRC
         sH9Vzjj2iDtPfbxu7SKa7N/Tmc78gNydLswphW6f1QZY7qmfdEztjivAo6t9/QMvY4Sz
         ZP+Aoeg3Iw0/NyqRIyVSRW4vVLhuTspGHuClVg5o8x2SBKyWI6y0rbRyIyRz9YSqQug9
         vf6w==
X-Forwarded-Encrypted: i=1; AFNElJ9XdhkGNpc3qlu5W5GlEZr/4mS/v8fUc+4pCdrmhUrrLc/KDapPV9Jx9GuUoERGzIysmhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjg79Xdgel2923NbTYhM4c//JiHqTDpXE2S2oO9yaexarKEVA
	a8fwS+WSq+Bf61UsaEg8Hgg5CZFz7HmpwFHgw8RkvtW8j1z9zMOl5xza
X-Gm-Gg: Acq92OFzcPDZFlrQTCYFqSnv/IFb0SgWCzo2pG8JnJ1fugrD130MIt+HdJpVMKOPeSU
	bKCwLOUiBBDdwNiT4PLD+dp7CPEjTVwiRdvGmjZSTniHVp6mTbZARgQQ97n+5uCHGfH8muUvBO4
	kw6Uku6JH9/6OBozj+02vtuU6nlE5j77srekzbxl80cOlVrbotpoyOAfG03MY2ApLHfRY9wE2Zx
	FdooZrm499zBk6tRiXUC1HegBex2LsHYl3H04DzxNDXdImm7fRCd0hD6RV/PAIVeMXY6UBt1EoK
	EbDLus75zl1PeglleRYjOLfCZsVuGMplL5BapZV+j9C3F7lUcD3qJTwMrlKc0yGOJvn+YuXhMSh
	Q5cgI73wcoJ5PkqJ0dcZxKmr1ZngX02r2qZSuHyDWqR5fIa4b5MB7ceTNwkt5v7Ck5O89G/4Vtx
	Bu26+IVSRDQaYseAKUR6r3hoZmIMJiKMqzJ+62Kbyc6iFs75Quz5vD+UPgATmVFS/qSfUsDnl+I
	8saYLyu
X-Received: by 2002:a05:6102:160a:b0:631:5ef5:8324 with SMTP id ada2fe7eead31-6ea2f22a57dmr228564137.23.1780413889046;
        Tue, 02 Jun 2026 08:24:49 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9157f038322sm139645685a.45.2026.06.02.08.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 08:24:48 -0700 (PDT)
Message-ID: <c54f3571-ff7b-4caa-b75d-a739ed87ec9d@gmail.com>
Date: Tue, 2 Jun 2026 11:24:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Small updates to SubmittingPatches
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602144304.3341000-1-gitster@pobox.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260602144304.3341000-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/2026 10:43 AM, Junio C Hamano wrote:
> Recently I gave some advice on how a cover letter should
> try to sell the idea to widest possible audience, and then
> I realized that we do not seem to teach how in our guides.
> 
> Here is a small series to do so.
> 
> In this round, a few typos have been corrected, and improvements are
> made thanks to help from Christian, Stolee, and Patrick.
This version LGTM.

Thanks,
-Stolee

