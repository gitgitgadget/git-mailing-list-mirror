Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4A179BD
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913070; cv=none; b=Rq461NiYw1GHmuDFHeTmjkjCi4olPd6LsXZlQOHDqmkSH5Efub+kizkNJ2lYP2FQEEqPBjkBdmGrarzL1+8ZAWl2Au2Z9Vrk3w2SFBVZatqfc8yfUawFIMqSACbiDYu2JjsAgcq5H5SSErsM1wHQ04Pbv+ebvrQ2K3gbrzd+2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913070; c=relaxed/simple;
	bh=qJAQS+bTeBbFrBp/uzfwSMsbjJPQCWZo36Hvod468Rs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ8okpVGES/WApiw+n503XSoDewS8N7s8+NwzBiLB8GQkNuLE5vundQMvy4C93gnnj0Hd4hqten0K5AQvUDU15aTPh0m/Nv4dUEmYpugDuVhUMQ4uXqFr5zPidSROLz+gfiD+Vw4m10/cDDxa8arkmYKaLZdxQ3LP5ykr+IAA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhWxVY8B; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhWxVY8B"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-532d498eb95so1206554e0c.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751913067; x=1752517867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrH6hE76Y5z8AAugiL9xpEc1BpSM0fxDo1td3swH7IQ=;
        b=KhWxVY8BFO4CuQc7K+MPhY39BZbD0p8gdwSrGYxmuIrfb1lOhdcDLa4OOeWlmxqojr
         ySZlxkzNRkrrdYNBrcG0O+9OskPEEKUfzV6boOqtk4fi9Jw6Min4GS82INSkqXBT6EfV
         9ttHQSk4H6pJI0FG3pprPTvAyXsuc04FCrbhiZ4zWc0JvFsBm30nFpYle29QXys4Ps7m
         iie27uuPBl6LrK8yLHJ2gXYke3LBSErmdBB9Gk2Xlo3Zv8AwxFfHvMAiPde1Hu+Yphtn
         YxeAe/pHx/OoXkvThJvT1E7ASYdDWJsacH+CnKA+HtuOqgZley567A8dS47yiZ1Likuz
         LfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913067; x=1752517867;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrH6hE76Y5z8AAugiL9xpEc1BpSM0fxDo1td3swH7IQ=;
        b=jAPr/bLUXoa/2vYz2PALrP9zdQeJZmpLv6m6o/2gri3Ru+sAuNpx6Ql4p2Omw950bW
         CDc3P/1NItyywjHRdPIosbeoVSitw5PJPDsmTnu9vTLfgzBzO4r6CNc+GTGT1E0bLNED
         xufGKXy/gK5Vh/ryfv/dH5Htp3Vhi5EtfsHzMbDiafypiLhnQNXNEZ82IoGDntN5PZZ6
         oTG8L9txbD7m0nivZIgglpIj4WewdQW0H9u49UBGwt6csWnJXdQsRlzZGH1PR01jTO0B
         ptKO+noQhFswUBwhbeisHf/7t3aaZfqPpxaHkCZFY0ZwFJXAFkFfMZ8pIIx5Yz9NVoOv
         vpMA==
X-Gm-Message-State: AOJu0YxIyAhWf6wO3mAXbFSqQNnMuhtzVJEK5hPPxQtbRUYYDUIKkXWy
	ba/2w64FGP7ig2Mk2Etet06ANJSW86HEaYT8voPqo98/oVzcH62OUzV4w6vWAGPqLWXgP0e2APG
	Ih5nxiNBqY/27+7L4FbZeED4FkDkd65Br/5zS
X-Gm-Gg: ASbGncuiLHSxkUpOEIZ8iuiwlsMR11ysfeGeQGDYVzY9urPjFiVkv0mELNPvCv7X70J
	0v154greN33xehzMPGLB0Q95Bno28QUWhkpLWchB6KRaHuvEpEUIql0nWLvGn6ZKYp8b8DLtLcc
	MCinmeju98cdOVFv8gvE9KKCub74k0+7XrRMv8ei14ludvWlrd3OSPsS5HU+Q/2LcVRLoV7jiR7
	PS5
X-Google-Smtp-Source: AGHT+IEwdoIctfdZ6jv9na7O7NSkn2AOsCdQ8PtyMadTKsxNWl6kgzFXddGr1JBB1QOh7fUjTiu1ilQxXggkAVR0itg=
X-Received: by 2002:a05:6122:251c:b0:52f:47de:3700 with SMTP id
 71dfb90a1353d-5347bf435c2mr8676947e0c.5.1751913067580; Mon, 07 Jul 2025
 11:31:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Jul 2025 11:31:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xg4588e.fsf@gitster.g>
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
 <20250704-306-git-for-each-ref-pagination-v2-4-bcde14acdd81@gmail.com> <xmqq5xg4588e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 7 Jul 2025 11:31:06 -0700
X-Gm-Features: Ac12FXxBHBLTcJ_0AYMvym1z-oxnvvNjDnTMICR4fgycDzJwIaZDVC5acu4GRbo
Message-ID: <CAOLa=ZSSQJxm04x1RArP2VxbbxE5ySGiYZ+p-3PaUOu9hXUt0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] for-each-ref: introduce a '--skip-until' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000012380806395b0cc2"

--00000000000012380806395b0cc2
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +	if (filter.seek && sorting_options.nr > 1)
>> +		die(_("cannot use --skip-until custom sort options"));
>
> Missing "with" before "custom sort".
>

Thanks, will fix in the next version.

> When I commented on the previous iteration about sorting, I didn't
> mean to suggest making them incompatible---it may have some use case
> to grab a batch out of the underlying refstore, sort refs in that
> batch, and then show them.  But from usability's point of view, I
> tend to agree with this design decision.  Such an unnatural batching
> and sorting operation is probably not worth supporting.

I think so too, there might be some usecase, when that usecase is more
concrete we can probably re-visit this.

For now, it is confusing and it is just easier to not support them
together.

--00000000000012380806395b0cc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a5f8785181420cc5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oc0Vta1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGZTQy85MXplbUx0M1RzRllCaGlycHAwMXVET0JPYwpMRzRDNHZKUDdo
QlR6eXAyN3ZONzJMR0d5bHJLdzhSSWhQL1NoNDg1eHdSYllmTlZjQjJiZmQ5b0pEVWg3YUd3CldG
UU8wSVFBWndMV1IyNmdBMjVTZEFjUGt4WmVTd0l6ZmlyMU9PcFkwbWhhcnRjaFVNV0RSYWZYMThF
dkNKZHIKbE9RL1I5MHFQTzlPREloblpSVUFsdE5HaWhvMURWODhVZGF0cGF5cDJCb0NyWVhIc2ZT
MGVvbkxEMGNGSzljWAp0QXBDNVNwdk5EUFJJWGtEbkdDSGtqYTZvVHoxRkVzK3F3akZTTkhzcDQ2
d01rTktsZE14MlV2Smxad1h5ZStRCnZrODdyRDdmS2lmZ3BVcm9YTGxVdU10MU1hSkgySWdsVVVZ
UXVQU1Q4ak5WaDFmZzdkYUtYRWhRK2loSjZSb2UKVnZFVU5xUVJqSGQwQ29wZVNCc0h1VWlaU1BV
RURLVGZCWWh5QThCalAwTkNyMmlpc3M0aUVmMFZhbFY4QWZGRQpUR09hZGdIMFV4L1pYeTFzOWI0
YkIyWktXMUZaUi84S0R4OWRBNW55UElSdjRSYXVVTDV0VTI4WExuenNXZWFDCnVmcHdwWTBvS0hz
bjhXYldtRkoyR2pNdkhMVFFOLzhaa0FmSWVxbz0KPUJBTWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000012380806395b0cc2--
