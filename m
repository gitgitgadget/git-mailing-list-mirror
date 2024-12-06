Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFC17E4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484790; cv=none; b=GCOM0lfTvIyu2xM+wdPZFU5C0q85tMIR0jssTnaLbuZbsgb8M0yKfisEsWcnTa4/O3e21/FuQgyqzSWV2Vi5HY2DWuv4DxONNKmTbo74NbCzxUASMOw6RgllgpwaEIppy1YbU7noCb4SO2Uymnp13tj7Cu+Nmlw7TrgeeSmkRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484790; c=relaxed/simple;
	bh=P4CDmm2JBSqBaDAl8IWgYP/r0nBZ9qNSz/n1aTZFpFY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=j4u74sfNILb9BAp+ee8ELJXZ8DkQKTIzRSQyo7shHvK1mYg+iqxsXR9Goh5b1Dy16ReKluwpTLKLkie5HQqRZWYC5GiDslA/cb1qWTQ+R7MlG1CfCtswAEwIvgPXYkcEyjOxfvQJqIT5ozPaVyLAKKeD+4JF6Bi8w99k+ZNkuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNmmLK76; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNmmLK76"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-515ff20fc1aso217976e0c.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733484788; x=1734089588; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2BnT46wQrr4BDlYHgKNhjuOrH+x3d90K85xZQtU6Rk=;
        b=cNmmLK76axtGIUZeWdK7pkpeVLY2xeGEc4nC3MSoH0u3OLyllfl7k6WKdEu7/JRgAJ
         D/P9zc0Ngs9TWaBPUi2akXjlAcdTIwk2p6AZJVU79yJ3eBGIbfx5U5HWSDRfOW71e4Uz
         uWLL4L7dfjUPdDP8tUoMafn3d0DxXcuxAMcxuO9EtLqUmXgxeZbDKNRQ7G+3kSZ1AWuf
         TSEqmRYKpH7MS4zV8U4xKY94QMn+iu0W37W/btBV08njKl9+RpxtJi2ZL+v9/aJqDqIs
         S/Ls48McCbSR1zup2HaNvGCIchmV4VkksqT9dBXKJbWCAZ607myzG6xY6YOPAigVrXWZ
         AtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733484788; x=1734089588;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2BnT46wQrr4BDlYHgKNhjuOrH+x3d90K85xZQtU6Rk=;
        b=f3nVMmEr/KrKxF9XfE9HQETWitAjsbIXDHXwLUAop/AybNHSG73Br34bOQg1hBGjgD
         N+ea5dHz/Hst12BHVZn6T2TAL4zZ6Hm1/GVGuc7dHDzqkh9s6MAw079DloQkzlxGl5Fe
         k7tDsaJBV9qQbhJbu/TCMDPbIm7LFr76/hCQSnrpApR5y08a5dOh/j0ACaJ+pDtNwaZC
         1WePoAtoLsuTWbN/yGG/Zr5qchexRhTE6+RVi9fxz9C3le3qnyV6xB99Y5B8HqW3v9B4
         qSNLBF1ZghZXsPnzhBk3BLmiAce5zKpxRWG5KJfFKhTUqva987607ouiyY7VTKWwU8my
         JvVw==
X-Forwarded-Encrypted: i=1; AJvYcCXgBm+u0qj9qXaCIENpk0FIiBqxVUjM/YPUz18Xe7b+p8GLD64eNraZq9qNgavLY1V6+dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgTGpD6CZ9+pGWi6+hiHZV9H0Ccs1oVY1+LstivOm5qRij5EC
	vNdh7BM2nxUBLIHar8Z41huK4cLRNhY3OMXz37G8COL0LJ9enyT9Bdl42y+n8UJmtw6zx5D3IR0
	vpHDNGC5oYvLLSEuiTi+aafd0hbM=
X-Gm-Gg: ASbGncsF5z34+sHjILrAtYPpJnoNZ//vGk99lGWBwCQRscZOUNWCnJBZm3djx1IjfCN
	Dlne7Ck1R4Y666Y6VytEWzWJI5Ae9DQ==
X-Google-Smtp-Source: AGHT+IFWSY6Qf2Vb1xfZXnnHLpwL0cAW/aesVFw0fvaIun89O8bPyIICYS1sPyLLMP2EeNex8p9iEteTW8hd5s+HHTY=
X-Received: by 2002:a05:6122:2089:b0:50d:8248:83bf with SMTP id
 71dfb90a1353d-515fcad643dmr2911347e0c.9.1733484788043; Fri, 06 Dec 2024
 03:33:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 11:33:07 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <8ea38d79-9e1e-4d69-b734-273ebddbe384@gmail.com>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com> <CAOLa=ZRaXZWmuLsmq9AFkzUFCa__=3rzAYkhULA4duJnGxcoyg@mail.gmail.com>
 <8ea38d79-9e1e-4d69-b734-273ebddbe384@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 11:33:07 +0000
Message-ID: <CAOLa=ZSCyvd+LF_8ebkV5+O+y-jL90jd6aVb3HAytiW-1CiCbQ@mail.gmail.com>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically initialized vector
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000003ff7a06289861c4"

--00000000000003ff7a06289861c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

[snip]

>> > Thanks.
>> >
>> >  strvec.c              | 10 ++++++----
>> >  t/unit-tests/strvec.c | 10 ++++++++++
>> >  2 files changed, 16 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/strvec.c b/strvec.c
>> > index d1cf4e2496..087c020f5b 100644
>> > --- a/strvec.c
>> > +++ b/strvec.c
>> > @@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t id=
x, size_t len,
>> >  {
>> >  	if (idx + len > array->nr)
>> >  		BUG("range outside of array boundary");
>> > -	if (replacement_len > len)
>> > +	if (replacement_len > len) {
>> > +		if (array->v =3D=3D empty_strvec)
>> > +			array->v =3D NULL;
>> >  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>> >  			   array->alloc);
>> > +	}
>> >  	for (size_t i =3D 0; i < len; i++)
>> >  		free((char *)array->v[idx + i]);
>> > -	if (replacement_len !=3D len) {
>> > +	if ((replacement_len !=3D len) && array->nr)
>> >  		memmove(array->v + idx + replacement_len, array->v + idx + len,
>> >  			(array->nr - idx - len + 1) * sizeof(char *));
>> > -		array->nr +=3D (replacement_len - len);
>> > -	}
>> > +	array->nr +=3D replacement_len - len;
>>
>> Why is this second block of changes needed? Will array-nr ever be 0 when
>> we reach here?
>
> I'm not sure I understand your questions.
>
> At that point, `array->nr` is the initial number of entries in the
> vector.  It can be 0 when `strvec_splice()` is applied to an empty
> vector.
>
> We are moving the line where we update "array->nr" outside the `if`
> block because we want to do it even when we are not moving existing
> entries.  Again, this happens when `strvec_splice()` is applied to an
> empty vector.
>

Ah. I was considering that ALLOC_GROW would update `array->nr`, but it
doesn't. So you're right.

> Finally, we don't mind too much (or value more the simplicity) of the
> now unconditional update of "array->nr" because a clever compiler will
> give us the third arm of the if: "else -> do nothing".  When
> `replacement_len =3D=3D len` =3D> "array->nr +=3D 0" =3D> do nothing.
>

Indeed.

Thanks

--00000000000003ff7a06289861c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6611b834c1143897_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzRQSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk9OQy8wVzZmYWZpUjVzSWxGTitWb3Jxay9hSzJTbQp4T1B2TW1mcW54
RmpnMHcvMHJoejFiRkNhTzVyK3N6dWFOcEtmWjlDL2FFV3hSMDAvUVF4MmdkaWVxWXd6dDZPClB5
bFRkcjZhclVkcldJUkVGY1VBU1JLcUllbm4wV0g2K3BlY1g5QzFxM25ndXVGZHBrdVpNS25yeU52
NFVrSzgKdjc0Mjd4Vk9kbER6V0VxMXh1MjBrVmxRN3dTejUySGR6OE10MU5reXlZV3RPMUp6czY2
SGtVWnQrOVRNVUtCegpHRTMvS2J3NklSbkRianl1cC9YQ2JiRnB1Mzd4NG9LUlZaemNTOUh1allm
QnF4S3hIc2hNM2tDcUQyTUZvOWFwCjVuVnkzR0Y0YVdDdXdTRU52UXY0TW9WQzl4RnFpU3kwTFVG
TXZ4RTN2VEFWaHZMNURUdE4vRnNES2d5YUVRMnIKNjhKbEhZdUdNV1pYU1FhZFpnWEJHQlIydFZQ
RHN2dDg3NTgrcTNTL2xQYmU2bE1UTHl6bVl2V2d6MThnZnRKWApPWHEyUmxwWVJyUm5EbnBneEhu
ZFE2VitHNUFtcFU2Slp2a2hyVEpVY3k3U3NzOEVHOGVsME96S0NVTThSdGtlCktzbVBhd0g5VHdm
MTkyUmtURGRpV3ZyQlJHWjJuQkozOFJIcEVPZz0KPU16MHcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000003ff7a06289861c4--
