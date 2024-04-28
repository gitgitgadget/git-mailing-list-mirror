Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9633C8
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714332978; cv=none; b=qrQ8MVINweBN5+eazRfwdgSNHnIzXFVdC1DBdMWLlsVBYhscHrT9NdhTsySz5ceYerMAKHplxgcpytHmaLv0EEdk8jQAtUpvL6sIJffJgxHwnfeEVH/4zP6HV+wJK+igAr2dUgB/SdZtECIry1DvTRJfUhQ3V6yO5JaE4mdjP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714332978; c=relaxed/simple;
	bh=T5PWa4b2Z0uQR9ETwz2TkdCMw+iZpKD7qIjeiL12ggc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu7X+/rvdIJOQyNsLftm8FsOhde9rdc2nkrPnftgVryK07Zg193BAjXeTYJHuRGzgY3v48vOSUxBw0r1w1kGTP857AfT77mqRwB2xgjJWKGSpQSpSg+mspVnloKkOZvHazElazum7/orQc1L5EmmHlP4ewyMfK1C+iNWji5z2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbtjJUM5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbtjJUM5"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso51798181fa.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714332975; x=1714937775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5PWa4b2Z0uQR9ETwz2TkdCMw+iZpKD7qIjeiL12ggc=;
        b=bbtjJUM5Ext7v4CXhIAAdZvZ8BSaU7CHaQhR5f3D7drcMYE19jNGM1lMzrwMGXRpCw
         WfWTlc6IcoBMI/vj8TLpmuuMReuBVjDhszuH69uHiLYLy60bPV7CGvZ2EtlEEl0Os/dW
         R0KbVeKBMcnRG3LzxVJkbvPhIpNvzIi8qEiNY/udhQ0kolM1xFCUGq2H2LAlrXXgSljH
         /U4ydHcQPC+HrpU/FcihsEwx8nf3m7lgoD8iAYxfRCqWuu1HdxRY1oe80dIcNW9GfL68
         BoVWwzDrMaCyFOjkTS1FUkd5xS/dcz8q7JXcrulqYnzSmKUXMQKXuEJWwamNGKr+4Btj
         j3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714332975; x=1714937775;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5PWa4b2Z0uQR9ETwz2TkdCMw+iZpKD7qIjeiL12ggc=;
        b=EQlKZC/Zg7IzGIXVMMddJ7vKI/NYDTU2PaN1j3bMiNQ5G1o93tc60FESmf0x+5Sm/K
         1QHP4Gaix/2DYwhyetc0vomnmd+Jtm1P/mOrxVBcHqNOwGF1ODFnALGdWRTqUfsfzQ2+
         pJDA3nTUncH7lINxAukiIGyNi09czsU3Dogvwf8/eOvX9SLNIN/aDF8xWkP0U7nM+xBM
         FQJt3xpkPbPU69DjPWgQTrUMkwgqcah75jTPfv8/TPHn//rs6ujaTawRc0U6mynUFZaD
         lzfB+VqFZYvad+dwEXEvkYTwQmNvPBvYz9PmgFIBd9Gg0MiBdjy5JnFUGAxltf5Laj3c
         4FlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2YgJ7IXe9mb5XenNdjIOyIZSniSjMAhqB68086/SZoZ8pPHRaJAsTeDsbHlRvoo8d+dVIyphDvDM91FW0rzv9WGyb
X-Gm-Message-State: AOJu0YwK9yPXwINPgSCaAeDHUZa1mVBH0wWlU/wZup44z34VGWG/HK00
	GbkHqv6PBVtu/zj0xEq7ywl9d60ktxYOF5mSMKvMl8pClA2hKC+YXxdehRggM5GtOfAEOYfda2w
	pMiwF1sCeFJ3h8EYL3JalTkp33/mivg==
X-Google-Smtp-Source: AGHT+IGUtg8FP2ATMJa8RrnAiOwgHHm3Wm2uKCXz6roTe6whiMvGjT3VKgCQ3ZAL3IZIHqETHD+F2MVIZevVTAagDns=
X-Received: by 2002:a2e:b712:0:b0:2dd:1611:1074 with SMTP id
 j18-20020a2eb712000000b002dd16111074mr1635626ljo.3.1714332974998; Sun, 28 Apr
 2024 12:36:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Apr 2024 12:36:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq1q6rc44n.fsf@gitster.g>
References: <20240423212818.574123-1-knayak@gitlab.com> <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com> <xmqq1q6rc44n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 28 Apr 2024 12:36:12 -0700
Message-ID: <CAOLa=ZTRZ37X-u3cPMKRbyEW2pWw0hpdQf=fdiFJMvFz2Oh5kw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000000869306172d406d"

--00000000000000869306172d406d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>> Subject: Re: [PATCH v4 1/7] refs: accept symref values in `ref_transaction[_add]_update`
>>
>> The `ref_transaction[_add]_update` functions obtain ref information and
>> flags to create a `ref_update` and add it to the transaction at hand.
>
> Just a very minor irritation, but ref_transaction_add_update() is a
> function used internally in the ref subsystem and is exported only
> because its visibility needs to cross file boundaries between refs.c
> and refs/*backend.c files.

Yes that is true. I'll amend this for the next version. Thanks

--00000000000000869306172d406d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9560abe61ec1f740_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdXBTc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUp4Qy80c2xxMlJMQVFHVG5ZbS9ranlvVm56Rmtmago0MTdhOGtleDhl
Z1NHWGFrSmt1YlVubHNlS2wzQW5KSEtJQVBKQ0JIQXEvWTNMd2ZtR3BPSjdCaVNXeDFLMGJPCmxw
Vk5jR1gvbjNEZEZZc1l5VzVNUldJYzZHU2x3YWJlMjREdVZWTjBsTHROWi9Gc25hZ1g1M29FTVZD
d2VsL1QKSlVhOGU1U1g3cDJVSHBBUEk3aUluNmM5UnJjVUN4K1NhNzltTjkrNEpiNWpuTXJnS2Fj
UWxNdHNiUTdOb0xqRwpLcmdrSnpMQk16UTFuRm44Y1d6cUxYbjVaU3pFeHZkQlkvUjU4MU5zaUJq
L09FUUQ0YkZkdUdLejZRL0RjNDZuCkVoTEZ4MjArNzFMOFNYSE9ndHNDWUI3MmMyT3R4SnMwaXdN
ZjB0N2N4UEpyZHROb1M4SU94dkw5UkQxVlpsT3AKc0dLaXZDQTErVFVNT3hDWFIwaWtCdDNPSUxK
dmYzTzdSWk9iTkZRaXdvWXY5REFlb1ZQZ3RhclZRTjBzbWo4egpXMGp0WkREQzdKMW5mZDRzKytq
NHNjdXE0N2JheU05TE5pT2dDdnlObkxKRnN4Z09uTGJNUjY3UDJ2TmhPYngxCmcyaDNaSi8rVThL
dk1WN0I2WHBIZlVseFRSemxOdGlaMXlqZVc2QT0KPU5WcmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000000869306172d406d--
