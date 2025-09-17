Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66662D063E
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095142; cv=none; b=Ldh/Xx0YfbUTrRxV3ei2wDZ2F37xKWSC/bhMeh0XufW3UbxVqflaCTzrUF51vwygdU94WuWQkFBm83WJzEAQ5PidVIxGESb330XDvS69YjhhG20dI4dcUqqcnx0ANHZseKbJud+rDzPPtq0iY+iVSNBD4B9DiuBKXKpF8EnJC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095142; c=relaxed/simple;
	bh=B5JzgcPjlYyXZl6/H+GRYM9hehmslegOM2pTVGRkN08=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNGKLXbrr7mAM4jO8ON5f3AEV5HTKb5huiCnaC/0sdzHIszYwwkFi1OJWaHTkr433Z76EQSAHFo8E7MaSWwvZuxGmclYqTPxHNwy2opMyLDQQtmDrarxl+DCCw2HpRLbc82BfbeM8+XwqVOy5okDR47WKJIW291yvDr2Js3vcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlzStUMI; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlzStUMI"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-52a8b815a8aso2897984137.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095140; x=1758699940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OC1ENkkUIc32o+2gqNJhuHHfuJcBu94eCUCIa6YIc=;
        b=OlzStUMIOzqPOYDdfmFZaTg55lT1kBNytPicKFwmjhfVJkVd4ANsGzcCeQ5VLcO+p1
         xuA5la/xrtDJY0oPxec/7lthxUXRPWOkFsNlOcqhjE7DcJ9hqbPOHz6PkXnESIZQIM4G
         xf3SwE1yjvxnFEWBSBUh4BBIN0/vUfBbNwjl1ZFyuUrgJ0a4oGsxrvzkbFGtbYbUdwFd
         mpNt8LXUewLjG+2cssngOalLXBRE+9x39H0LGSY3diEYgztQ9/JKda3T0dnYHdeeRt76
         qWZDKPluIsotPtfh5c2qEhI8333c0xn0M9fT7AVNM72H3Df0HSld9mAbdnPMzUJhEKde
         QBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095140; x=1758699940;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OC1ENkkUIc32o+2gqNJhuHHfuJcBu94eCUCIa6YIc=;
        b=L9LINdd96VtHuBZGtPKx3aqOv01ehlgHGRyy+abRC5bIKotGWNcbmGXgBdfSdGnaSm
         ih9Zg+A/1wESxklhKJgGeHpz32IcXdRWZFJ+Dhroc86krliCKqQtLB7Wratkqi9bezgK
         M09oLM2wW3FTkWNpHRCbNE7SHuOTjpzq7x2Vxq2wOBA/fAPOskaArBdemfM5KpufHkYI
         HjRiatAiX/Bk+x97JuluV9vvKpYObMbpgqEAQr/e8vj0w9aNext1Mg7rcrtrgzBzRnqJ
         K3erm94b5Sv6A2q7Hmawm87wmVzLLviX4RZ02OLBrerOFLlNHJNcg/3MPySV/DGKDO3M
         WrOw==
X-Gm-Message-State: AOJu0Ywyh3hZM4KabwIpYnyQmnuDaBerkmqxSwRVj1e/hh4tRd5ubZTs
	EcbZt2EntId7FpCZ094q3tGFCI9k3S0cOGf4ggC63b/0VbgpD/vfjbnBu/1k1RRp6aXjDtKNifa
	EGDTkaONtr/axFB/xdB7rwUxFPex5vinYkpDV
X-Gm-Gg: ASbGncsvle10MLRspYGXpPPE75OE/rHC46bTnX0tWhUQeOXq6GxE7N/ekEAKCsSX0zo
	tFW/pUk1rCjztLuDyGt1sytYpJBruKAm44divD0i0Xg7/pXGgDQv31PpH2OInjQWWx3UFQ+zSuI
	SSuS9LYEZVArgW4L26GksGkDZ2oOLF342BQgjH6y6fZfDOuS9TTYM6v2c4kWIUGF4nG5+LpD3/V
	jiWA4CvHN7HIFG8sd/jkqeQON/UMidQ1QAeYv77
X-Google-Smtp-Source: AGHT+IEsxyNaGKT5Uaah1NbIyesjDNzPXINsvfqTS7LUL5iUoQrgzjl5+8IG61ASygIU+LDN3CNGnRTz18isiRKPbgY=
X-Received: by 2002:a05:6102:334b:b0:4ec:c4f8:c4d3 with SMTP id
 ada2fe7eead31-56d4baecc96mr239204137.5.1758095139598; Wed, 17 Sep 2025
 00:45:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 03:45:39 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 03:45:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh5x2m5d3.fsf@gitster.g>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <xmqqh5x2m5d3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 03:45:39 -0400
X-Gm-Features: AS18NWAJuSRfQ2BRhQ0RiFxPJ3k4L9EZ2gEoxWuT8UKMi87BSc-S8RsFB0luKpw
Message-ID: <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000471b3e063efa6cb4"

--000000000000471b3e063efa6cb4
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Changes in v3:
>> - Rename duplicate_reference_case_cmp() to
>>   transaction_has_case_conflicting_update() and add comments.
>> - Improve commit messages.
>> - Add an additional test in the 4th commit to showcase D/F conflicts in
>>   case-sensistive file systems.
>> - Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com
>
> I think I like this "latest first and then historical" order in the
> cover letter much better than the other way around.
>
> I see that this topic is pretty much done?  There still are a few
> questions from Justin's reply that may want to be answered, but I
> have a feeling that the answer to them would not require a new
> iteration.
>
> Looking good.  Thanks.

I did respond to Justin, I think there were a few small nits around
grammar in the commit messages and a question around error reporting.

I have applied the grammar fixes locally and don't think they warrant a
re-roll. Regarding the error reporting. I think it is good the way it
is.

So I would say this is good as is and I will refrain for sending in
a new version, unless there is some other concern.

Thanks,
Karthik

--000000000000471b3e063efa6cb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7bf0fb8898b41348_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qS1p5RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem1IQy85WDBKUjdrNU5rRHlXR3B5S0UwKy8zOWo3Kwo0b2ZrSDVwUzB6
Ui90c2E5bmhjQWxXNUM2bGN6aHZ6NHJRZVRobnBkTWNPSW4ya0lYNXhCMDBHYlAyTkFaWHJvClhl
NHdCUmFIRCtVa051MVg1Vm44cDdHZGtvZG1nTzM0UU50UklEeFAwd3Y0Y1lPVzF4Q1M3Q2xyeStu
S2xNc3AKZGNzMGlIYXlBQmhtc3VJSXBkRlVLQXlhSWJMeFNDV25IRXhpelo5MFhhUjQ1Qm8rZ1F0
TGtBNDg3YWtvdzlGSAo1QUtqNGtVb215TXlpNmdOSFEzb2w2TTc4US9yZGVkYXRMcVhBY2tlaUZ2
elVxU1c1b3ExdlNzcWNyY1kwNnMrCnB6UDFjdGxXVzkrVjZxcXB3NktxSUhSSW01ajlBMnEvRWVl
dndHV01QRVZzNU45dTU1ZzE5ZnRpYUZQVkp6eE0KeUFuV3FEd2swZmduc1E1NnVrMUtLeGF1ZVdz
d2Z4ei9SZFJrQSt1UGtxbFNhUk15cXJMNU1DeVVDSW10bkx0Mwo3a3NWNUduOTVuOTh0UE5idnNR
d0MwQ1ZEMzc1dXQ0R1lwdWRVNWZHMHMyNFQrbUZFUlc0M0JjVWRHeXI4VlJvCndROHhkQjZBTk9K
L2VFNS9ia0dwR1RJYjNwOGpxVlRvV293RU5Cdz0KPUZVUTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000471b3e063efa6cb4--
