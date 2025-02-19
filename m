Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9622D7B3
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995858; cv=none; b=qychHRChKZwO3fx2YvLDEqs6wWdj7LtQnc3sf8FfKXk2VSKPHD8+Kyd4yuObiz6eXJn0THyuJeDIasyTPJ627X6ThOWoB43HCFKcnaERrqNXs1s/LfMlnsK4B6GNl+aP7sFlq0bImLJiragg0+X3VC3I7pggFmUJImuS/eywBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995858; c=relaxed/simple;
	bh=g6ad12gpv5RD7ecxKdnS7UUiMHjHof4e4/nRYvClZ80=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0b8D0aFV8V/xcu6no9Qb793Mh237xfcHhuzBrbDqpbmiry/MBZVCKDEiavSuE52BUmK0P8qNOBKk7PSQCWzT0QUUXkvE30pWSwGVG5ANxTiOtsCUUCRh85reFm6XHIkmcJp/25zN369MVovo0pgQxiHUZWHTqionACUCoYkIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd3wFe7R; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd3wFe7R"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4bd3763900aso72155137.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739995855; x=1740600655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mci2qcVOxvigfepa6pIoTK3cqzxI5a5tQkhmJoLwUF4=;
        b=Rd3wFe7R+SsgsMMDEB8uGvidsydn4uTk695UCZ3hbL0tROtWB2tiuBRlgQglRCf3Oy
         KSFAuWpp6Bro6jFcvx+Y3JLrZfnn7Ya3PtVM/L44tBVesW4oSWCE7TaHzwryVdACCyM8
         nHhTx6Mok+JHCgz3DGW+O75xypPcGqGgpnz4xDYfk3VRQOU5yFPzi6CB2HUvCqR2p2BT
         hCZtVsP9lth9lP7+f42Vx/4LGsTneaFUpi3v1j8R0p7nUkYU1E2uw7aWGmB22GLrPBWR
         /vGKpavLTvDFIp99mvx/EaP6+mwJv6OQ7PDyjLNmoZqaAE4aZTFCunsHXQ/gI5qjhZRR
         UUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739995855; x=1740600655;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mci2qcVOxvigfepa6pIoTK3cqzxI5a5tQkhmJoLwUF4=;
        b=ileryk6d3ZaV0KV0ZZQRo33rW/wws0TlBqhBakYpFaFR/nFg2KRmEmmeBzkuDA44cX
         tB0IAtGAsnPUQAddkrpZhYdVKC+JymKNIA7NFSSmQCPgzBLsq053AplaDHlbsvw+sUHG
         4XYUCY37Q5nQ0MXFAIz+OmQFfm5P9BZylHeUfoJosCDNvAmlEqSmQR7b/s7dOK0CPCX0
         T459Gkge9QgeHoQxXQHNVmcsmVqDCnJ1ElPF3qUHFnrb+NXF/14G/CRFfG9Cwml5lA/o
         +yParjJ5QhsGqOPdJxeRcypc8v8PYpNHQU+7id0IBxPrTnixgsOnKBoHByuZRGHRVHDt
         rnog==
X-Forwarded-Encrypted: i=1; AJvYcCUtX5eWPT+yawq64TDnUc5U8NKa31QgDPezA1l/BiFX0pbO1RrWKz7++l3VG3Tcq4FUEWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIznt4SEgB5jv633vyqxPsmVJPUoo9lf5xewfvgF6xcH5uZTp
	09steNt+6GWV9BeCHkPvSBcg1FgV37C3xXji8ASLnqsZMkXt0ofgQt2Zd1Pvd6Qo8POzaLRVbwi
	cFLCaxhiSQEAEOEHx7So07s5VLzPHJT+8
X-Gm-Gg: ASbGnctkOgnIp8ZVT8KwwG9kxcweqTojvYfYhIhsBl14bYe6d9uIdMFrR/CGBJ7eQZy
	JtDfLcgkbKmqCH2TmEsd35Loh8z51jrcKWzU4Xp/QVL39wM24T4ZLhQ3VeyYp6Po8JkzfvoHq/h
	4oyIONteUsjLRGm5RsuH2yCuyTecn66x4=
X-Google-Smtp-Source: AGHT+IGPNNWieGQB0LAV5xPoyVPGZVJySNLw+82cRtvCoBh2HgvxA1Nx6xSuKc9cc59s/a6965TVTTe5vW7Xxt+oMUo=
X-Received: by 2002:a05:6102:f9e:b0:4bb:d062:420 with SMTP id
 ada2fe7eead31-4be85b54f63mr3577319137.1.1739995855390; Wed, 19 Feb 2025
 12:10:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 12:10:54 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-9-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250217-pks-update-ref-optimization-v1-9-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 12:10:54 -0800
X-Gm-Features: AWEUYZl1VRcoVrSVLSVae-iX-yGC7OFxUfglBdqyaDVxXdPzQeLyQF00WQN32Qw
Message-ID: <CAOLa=ZQCRrAXeucZjqMpa-Uhb+d+oxjnDpYX00Qwt6nKGyJ6Xw@mail.gmail.com>
Subject: Re: [PATCH 09/14] refs/iterator: implement seeking for merged iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000df3a57062e845a08"

--000000000000df3a57062e845a08
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement seeking on merged iterators. The implementation is rather
> straight forward, with the only exception that we must not deallocate
> the underlying iterators once they have been exhausted.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/refs/iterator.c b/refs/iterator.c
> index 757b105261a..63608ef9907 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
>  struct merge_ref_iterator {
>  	struct ref_iterator base;
>
> -	struct ref_iterator *iter0, *iter1;
> +	struct ref_iterator *iter0, *iter0_owned;
> +	struct ref_iterator *iter1, *iter1_owned;
>
>  	ref_iterator_select_fn *select;
>  	void *cb_data;
> @@ -160,13 +161,11 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	if (!iter->current) {
>  		/* Initialize: advance both iterators to their first entries */
>  		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
> -			ref_iterator_free(iter->iter0);
>  			iter->iter0 = NULL;

Okay so if advancing the iterator fails, we set the current iterator to
NULL but the underlying pointer `iter0_owned` still holds. Okay makes sense.

Now it's just a matter of ensuring that we reuse the original iterator
when needed and seems like that' what we do in this patch. Looks good!

[snip]

--000000000000df3a57062e845a08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 58f17138208ec8f6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMk9za1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXI5Qy85NkZFaTJoL3pqeVNLYUtZMlVrdkplQXRhYwpNVmxLdWNBbnR6
eGRCMXYvVTJkRTNNR3FmOGw3UjdDZUtZNkRFMkk4c1FJVXNyWEtrcmJmbTYveHFxZkpEU1FECkJM
ZDN3bjhEUU9qSm1BbWd1VWlyOFlzaEtIdGtqQ1lvMUVaSTRHRlBJLzRoNFdFcGNLZVdaUDJ2dGdh
a2kzcisKQ1NoWkNEcFdSVmNPMnRMOWJNQjZLejZPdnRYTmRPbmQwVUVuZlVTRHlFRmxIcVlIN3I5
aWRxR3E2TFZ5ZWExcApIcVpxVE5JSVNLQlBwR1pNeElBUUtzM2ZBTmtmM09zUU91c0I1YjlrcDEw
Yi9zRFBDRnppTExjUUl0dVpmaDg4ClNzOXg5TlRNRUUzNTVuZ3VQZDlJWFJjdytwZ3NQZmVMeFBK
b2RucUxPdFRFVnVpVkF2RUFvZTU1OFZScmhnVlgKdzBvY3NyRGxoc3dLZGtsRitCM1dQYlBubTFa
YVpmY2NSUkEwN25lVk9QSW5IV0hkN3A0ZDBSMFhya3RCOG1BUApVVytkVXlqa1NGMW1lL2xwemV5
S2VieU9EK01uQmk1UkxjUE9oRVF3STFBTXh2azRQZ3luS2VHMlRwTmYrVDRvCnFXdjlXTzFkb1Bw
d1RNdDAwYkhucEFsS1I5NUxhOEdiNzduWnV6ST0KPWNucVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df3a57062e845a08--
