Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36339FDD
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021740; cv=none; b=GrpJqUJDOdafb5K3VeDcslGlOscigeMettTskYUvim3BS8r+ODvBbBqQNgUS7cG/wnbNHcQtO6Pe8T5kAAou15D2sY3dvI3MWawMrYsEAZCOcK/mpuZVGg7l5Y/wgxtBk70MZgggBgOTL4ukbX176AjIb5dkZmjeWYf0l2vcMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021740; c=relaxed/simple;
	bh=vtrMU55nB7vAx+qbcHaPmITJv8l0z5fh0BwrNFsVEhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBzcVeJXPZ2kaq7TYH4Vk/7FidvBbjL+/ZREf+HvhNkE/BkrFBvbNS0A5sBCMM1wyWOnBLlUT9aOwjKRpwi31Pleb57aSm2tEHOlwlGnvNAvfRNn+GaGfMmkxDcNp1l6OdzIs/NVC/RNOIHxPfxhhjVXOOnRXNBD4/i4a6Fbo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWlMf/6r; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWlMf/6r"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so17886551fa.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722021737; x=1722626537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnVALJEbEg50vN6BUmF2h7LUdvvVdUuQVaGSqKsdYSA=;
        b=WWlMf/6rnlSGzftD9TEqz5v2feGUUThzmIqyjKmvSj8UgNV0BkQYIKaEPtdeev1xPZ
         1Rshd79DNN4Iu2Aw5RnY8jqUSlQk7Gr7av4mrrQtUpMe3ZEP9WkU/vqFqtwlfhYXbsVM
         q6u9CpCA+9h1QAxxHHcs1WlGW4MDmkJ7NzXiIaetMxHDDjgRHtDTEkmNihoHovxw07RQ
         qSvqrbHCTps9VWFHShlTm3BzCZS83Bumu2jcWq6ZGMoeboEKofwPSwLvsz/6auFev1CN
         jFgpupkUoqtkhAU8GlzxVuirTKyRDA2w8Hh4tYmg5jfTerJHuea5tW5u3pZoXoBLn3+N
         9QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021737; x=1722626537;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnVALJEbEg50vN6BUmF2h7LUdvvVdUuQVaGSqKsdYSA=;
        b=m3TL5UxMfvqkohHDqIsMF1fgRWvvirSekGR7JWkXUkT4Ew0PsZ4smyhgwFaRwDUo0t
         ZqEKsdrlmSJkqHlw28e1kC/hO64UCF08oZQrg85NQ8smskCrbGSGB23O2VY7INuX84r9
         ej/pBOlvtzkgICyvzPtycSPbltapuODl6yy37OeIFI2rmdaAWkpwHCdL8oUl3E6wexuu
         H8TtZHRG/bA1Gz07zl8LMz6d9nQGULEod0OOHY0aJVa2B4cdO5I0Bj0yy/K1o/MpamqF
         /psZCm1Nd5x2uDS7hLKeweCFYqYc51Uy/wMQFFhubqmcJXUJtY1/iZZFjSb8SRUGz4q9
         Os6A==
X-Forwarded-Encrypted: i=1; AJvYcCVxNEHoywKQtV1JN/OtPp/iMKhBxBoqxKJQcAsNVK1Dxi7mRLww5kKn4BMr16EUQY7uX4qCUEqhu2Oo3iwIPvdtgl7f
X-Gm-Message-State: AOJu0YyCPCqPGXJK3klG3zBDI4VzDb99zSSiCLM9UzIhLfVhCfeqLqzU
	0H+DIXDEvX2aCkqcn8cB+Rl24Ogdd7uUuR8UPSXHjQSrCWetROpU8iwIrw==
X-Google-Smtp-Source: AGHT+IFASqsOOijD4xSDUcSd4CVr6KOoR54UNHOBGlWKqM6rOJ+sDb8uroVbFeEasydS/CBoE7ejIg==
X-Received: by 2002:a2e:9e81:0:b0:2f0:1fb6:3444 with SMTP id 38308e7fff4ca-2f12ee55d56mr4318741fa.36.1722021736554;
        Fri, 26 Jul 2024 12:22:16 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f94111c1sm133569355e9.40.2024.07.26.12.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:22:16 -0700 (PDT)
Message-ID: <1dc4cb5d-966a-402f-a880-42280750b949@gmail.com>
Date: Fri, 26 Jul 2024 21:22:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com> <xmqqsevwui31.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqsevwui31.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 11:24:50AM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > On 7/25/24 5:24 PM, Junio C Hamano wrote:
> >> Phillip Wood <phillip.wood123@gmail.com> writes:
> >> 
> >>> ... We
> >>> can add a comment about the dash problem to the commit message when
> >>> this fixup is squashed. Also the problem is now documented in
> >>> Documentation/CodingGuidelines which is more likely to be read by
> >>> other contributors.
> >> 
> >> That is a good thing to take into consideration, indeed.
> >
> > Rubén Justo (2):
> >   pager: introduce wait_for_pager
> >   add-patch: render hunks through the pager
> 
> Hmph, what happened to the first two out of the four patch series?
> Retracted?  Or you just didn't bother sending the whole thing?
> 

No, I just wanted to modify only the two commits in rj/add-p-pager that
were affected by the fixups. 

I thought it wasn't necessary to modify the first two, which remain
correct, and I didn't want to bring them up again.  Additionally,
keeping the dates of the first two different from the two modified here
could be interesting.

That's the reason.  I didn't want to cause any distraction or add any
inconvenience, if that has been the case.
