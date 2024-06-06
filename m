Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A1160883
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684419; cv=none; b=AvESZZP67Lv5ipAeyoV/dywILnxRTePgcWXOPovEehurFvlY4z/u6UDey2CQnzvdCkDn8ll2ee9B6iK1R9Zf0rzMYn2UO/oPyK22N9HkkLLG37TepsseQg+yfbKGlzF7lmOrV7ywy073EncIi2uiJ5qCutMAkfkQXtiNwnfzLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684419; c=relaxed/simple;
	bh=FPoIQT12cT9fqCeYZ5konyfpyzzL7xY62PlUvcgaZ04=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=e1zzvyFdRyMU5ZwtuXkysnCsEQumfn1evunIBB+Dvt6gGJCLddzzTeoXhEBuDpeC5wi2kGnKlTOJISITGUrM66aowKT8ZIIeJx3+h1zB4oUjWipcr0CQ+y1jVQMZo9DnKDqGp634WBIUlHnoSRhrU0wNe+jYDnkNf12QRx4VdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZV1myrw; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZV1myrw"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f94669cf19so464933a34.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684417; x=1718289217; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPoIQT12cT9fqCeYZ5konyfpyzzL7xY62PlUvcgaZ04=;
        b=GZV1myrwZHyPuTAkzd/4fByCHnxuPKS+h5jMprINrYta2H1142NK86WRAnnFspsBd4
         XGIszIsXcfHXpgYN3crpRAQtys4nTKi1iitQ6Nhg3NivHxZZUiU/yeRnuzim5ZJDFVbu
         nPx8I/JLn4+NC8GXgR+b91h0r4YRk9FB1jMrmHWkFLEXf0Jlf4Vhf1cEdHdbC8yNDHdz
         pf0mqC0IvDtZhwjGv7z+Yq4ckT/79ch2qh6Jvm+JYHBGkOCBxcOgk43uC37Szrjs5raQ
         H7uKmYC/EEUZmEUkyTMHlvNPtCT8WxaFOldDiaWSSyBicvVdVdRZXtsdrumpggJlMS3B
         FZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684417; x=1718289217;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPoIQT12cT9fqCeYZ5konyfpyzzL7xY62PlUvcgaZ04=;
        b=luIb+CRvWHSd/A3EDedIW5XBQrWSSU+/9QNH9dO+1N8GwQN4ibvmsP0ptqyIGTI+9n
         QOFcdgLULlWNWE2oMJH64wxYydjly81JPKltigm2DRz/oDsaRefifkGrjTHneiAI0LbV
         I7jLeLnKQJFXAKwj325LcLAoc6CfW9O+Fu8Pm1H9Q+QySLXZVwwlua4yY6XB+jboyXk0
         qJ5Rob7l5yz/yDoyM8ZaiG3EZjdGXMEUA+CMPOfNk9Wz11NWiwLuEVoek+csNwMdqozu
         7HJDK16tx4psdcvPyCG85DApffrhCRgLJcDjJqw1o7X/iYjhdikBkP+L+PpVHMZ7lWaN
         CmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXn8UBV1wBq4gSexd+BnCLrMaRCMQ9y8qQDJI51A8R0Nx9OCVhvJNfTDapXGSVdeDTOAP0XrToobkDkApq9nzv9wb2K
X-Gm-Message-State: AOJu0Yw3+LAJ5FEVTAnSx5R5PV+fbTRTzGD4SQaG7XU9iQtJ95Hvzgt1
	TLHYO/nNzXnxzg5dhEdc8pAZPCXZa+aKUVg1I+xyBdrDMoPf878UcMSrZmNq93MEp4u2jq05jJN
	lMP5w3ultn57elKhdFz0Zl/SNh2dQX449
X-Google-Smtp-Source: AGHT+IGHPeN4pnTFfjh97STbhC2l6b8+01TxV3c6sM7v0pbywAlQ6rPOlAwyVzuSm/dkMQYG/64x9GHvnfZX60y0dys=
X-Received: by 2002:a05:6808:352:b0:3d1:be9f:c9a3 with SMTP id
 5614622812f47-3d20418102bmr5387923b6e.0.1717684416819; Thu, 06 Jun 2024
 07:33:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 07:33:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 07:33:34 -0700
Message-ID: <CAOLa=ZS39hobSHXzyq=vAL9KqBkr9PaSZyqyELvFxvAA=uSofw@mail.gmail.com>
Subject: Re: [PATCH 00/29] Memory leak fixes (pt.2)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000080615c061a399164"

--00000000000080615c061a399164
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is another random assortment of memory leak fixes for Git. With
> these changes, another 77 test suites start to pass with the leak
> sanitizer enabled. With that, we're down to ~270 test suites that do not
> yet pass with the sanitizer enabled. My goal is that we can reduce this
> number to 0 this year -- any help here would be appreciated.
>

I was thinking of picking up some here, how do I avoid not clashing in
with the work that you're doing?

> While most of the commits are trivial, I realize that the overall series
> is quite large. If you think that this is too big, please feel free to
> speak up up and I'll split this and future series into batches of at
> most 20 patches or less, if you think that's still too many.
>
> The series is built on top of 9eaef5822c (Sync with 'maint', 2024-05-31)
> with ps/leakfixes at 164937678c (Merge remote-tracking branch
> 'junio/ps/leakfixes' into HEAD, 2024-06-03) merged into it.
>
> Thanks!
>

I only have some small typo nits apart from that this was a nice read. Thanks!

--00000000000080615c061a399164
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f2257e072142acb2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaHlMMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUtuQy80b1B5a2JjR2dPM1U4VzBuczdDeXdOeDl3Ygp0Rlo2NmtNM2p6
Zlg5Qno2ejFrOGxVaHFkZGp2K0NCMzVVMm5YRVIvandaanE0U3N5eWV2ei93cCtNVHVOdU5pCkcv
Z01GMDg3RDJ3MUhEVEpPcmdRaWpISUoweUFyUjd3SEpvSDAyV2tWNDVkZHpUYktaT3ZoNlQ3STRJ
emxMT3gKcHpxdEFIc0x3RWJHZnM5UE9VWW9jVU91S1Bkandtb09BUUVtTjh4SHpSNFJwSkNPL2wx
bnVqbTF5dGVzMHdLcwpjL1hEOGh0Tk9jc3o2amhWbWZoQkhONzVvN0k1Sm5tS0FVT0tzMVY5MzMw
YzFwVzJ3ZU5heUw5THQvbTZlSUtTCjFXanBKZDRROGEwMTdUdDI5Q01VTXpqbW1ObllTWDZtd0dU
WVpwK3ViNHIxWTBCYk5iNXMzWUw1d1Iyc1RFQUIKbG1oMUw5UzFudXJYM2VzRTE4ZGhNcEh4WjlK
SmN4MU1ST2d3MXhZd0huaG5tVFM1T3JTRll2bWZuZzcxeEVLcQpJY2E3cFF0b2JQdUZYa0cxaGow
L1cxR2lSNXhJSzlobjJDK3lTMzlZUXA5ZWFFN1NmbWN0TG9kK1E0NS9EZVNvCnhiclY5NS9LQlpX
WUpqaEZQam1MVjFMelhhYVVKVWZudnUzL1lCND0KPThYa1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000080615c061a399164--
