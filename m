Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3322D6E60
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739451; cv=none; b=Bnzaz8r324Mbr4jJPbRsOWt2e03p2CL/wN84Gq5TFhyrWgw+d1OzPY9wod3IECwC4YPw6odBm+srS7SOIBQXtjLXMzCTKsV/eK9bmpbWTJ1JJAu2FBANqgYoXp8kxpSSyDqFSudg2BfIPRvEmDxtPSWLjOsEycVw7nXy8nFkLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739451; c=relaxed/simple;
	bh=eI98yffMN63ddBwIKL7ZZciyZhYKQYIcPCvsNs5dLNA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpR0C/SNmD6rB8L4jsBEthjG74fFFpoqe+HFhkDn4pKbkCjZqZxqsJh0rwhnNztxOWcyYlx+oldy+w6MRNNS9s3/ZdwRPMWvgHVcuNfN2bJ6DyrRLuYAwFrpGl6jroC/M+w0x69jOkIKrDZ51Ac/FSrhH4UfMf3UEAEMKS3GedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKhet0vp; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKhet0vp"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8e2702252b0so29982241.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739449; x=1759344249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDE2lwIrkvrNlYCpZzkj6c306lhVCPKoOa+p9hC5pPc=;
        b=mKhet0vpIt3+Y2dKG2cDKFrfboUNIBV8q2Vx82eqP0NtRrkkfndrznOB1HzMAcAE3U
         /4+HBVdOulueS2I/1mCgrhSiFmS0l9Az6P1L/3mjsc4qAgDxVXm0HFyUBsu46dqLNH70
         0YvgZqrLQsnFMVs7Lc+mpNcE2NzpTZvsqadGcquH4H5noCtR5lIcnZi3Tf/TE5Q4U2mI
         S4VlelC8TiNvG2WjdJ43csnESkzDjuquriKKwppeo5aCImNLaNuKgIpDU7J7JoDQAWnT
         ROhK8aBg07ZBKUOh3M0Tp/xDgpP4PxuFcbfEVPO3eGHMwVUGhG8wqeFHn2t+S2xwr58L
         7vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739449; x=1759344249;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDE2lwIrkvrNlYCpZzkj6c306lhVCPKoOa+p9hC5pPc=;
        b=fjtY79Dpc5lQu98Kwr9o1UCoUZg3ioclNy1ijJgKAdS5fJi3z10EAAc1lEu7XSIHVA
         ou2oUSpUGUhimIHwORAHJu9zDGHTGYeb8JgrvFjQh54nr+ZnhUkmbYlDaaAJhRj0x5xM
         lEB8nURR1Aydztxq28md2kFT3Q6QbO4hl8szLLC6TLF4i8TJr5onHVUhbU0PJNPljC8q
         7tGY1S/ffZ/wLoGcphU1Df5SWp/XKGoz1zQbhURQg/ldyR7ZQuhFhaMSG26904Q1AMRB
         deIvvk36PJUYZ4IC2oz+kPtyk15YodkXCbxHbsNjEjy8vnHMSO1L1VQYOUaK3h1T0/NZ
         Kcrw==
X-Gm-Message-State: AOJu0YyaxygYMXF9TTuy9cRNdI+Vs/nN0FheWKod2h4LqL8UA2On1qGV
	lVoVZ38L4tXwrgC91+G01EsH7VD5RrscVWPFl41RHxJFAlVl7ILWohgiRXHh1YYghPSJ05PUg4u
	GYXWIldSRrdyqf9f06sgdE+UXzaHpbqI=
X-Gm-Gg: ASbGnctciKgK+XwuwnzYqPlovC1ukLmRg5jFETihzP8prYW42oFjPzp8al95S3WBMQH
	Lt/1NYRRoO5AkNQmdcT33I9eSVugyBtWZnbS61CIWVV3PF5Gbm8YmnRLzNCo1+FYZccxeTs+ihz
	PQ8TZojtUQ+y7W3Z3powzdP5qKDXU1qpo8A4bEpnW6nJQw36jyLjHiDm0fHXG/yakIjVI2UHLaF
	9xDLDKpFdg3ptwa+l6xav1ZL2T33fhP/1Vyds7qig==
X-Google-Smtp-Source: AGHT+IG0IFX3CIMwo/k25rNnqpFZ5h2BJDl2Lr2P++dcZEZyHiFJjKhf9zUhaWkicB2ZGLx8gb88X3jQhiDbDZ5g1CY=
X-Received: by 2002:a05:6102:dcb:b0:5a2:c93c:8f82 with SMTP id
 ada2fe7eead31-5acc5f55624mr467225137.9.1758739447998; Wed, 24 Sep 2025
 11:44:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 13:44:06 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Sep 2025 13:44:06 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNOHr7lm4WXUyHa5@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-8-271af03eb34d@gmail.com>
 <aNOHr7lm4WXUyHa5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Sep 2025 13:44:06 -0500
X-Gm-Features: AS18NWCaA1rtds07C5L3xYFfzzDWS5AVvqlH9VWQkNHlbeRO7snB_5k9nixU1Lg
Message-ID: <CAOLa=ZS+CGh6kuT87xoR_GnxJkBABk3g0CtOqU9wfnCVS=AcBw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] refs/reftable: add fsck check for checking the
 table name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000d0917063f90709b"

--0000000000000d0917063f90709b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

>> +static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
>> +				       void *cb_data)
>> +{
>> +	struct fsck_ref_report report = { .path = info->path };
>> +	struct fsck_options *o = cb_data;
>> +	enum fsck_msg_id msg_id;
>> +
>> +	if (info->error < 0 || info->error >= REFTABLE_FSCK_MAX_VALUE)
>> +		BUG("unknown fsck error: %d", info->error);
>
> `info->error` is an enum, and whether or not it is signed is an
> implementation detail of the platform. But I wonder whether this check
> may cause some platforms to warn about an impossible condition.
>

I didn't really think of that. I guess typecasting it to an int would be
the best way forward here.

>> +
>> +	msg_id = fsck_msg_id_map[info->error];
>> +
>> +	if (!msg_id)
>> +		BUG("fsck_msg_id value missing for reftable error: %d", info->error);
>
> Yup, makes sense.
>
> Patrick

Thanks for the review.

--0000000000000d0917063f90709b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 89d925bad5cc1722_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qVU8vVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLy9qQy80MlprWVFSME41VHR1OXhTT0NJZlJ3ajkrMgpqTEVSTlVPS0Nx
SHpwT2RIaHZjWTBGdEtyOFUyZjUyaEZKVVdWSVpiZEpOaFgvM2tFR1IwVFU1WGZZWk5HM3ZECnRi
VjloMnBPd3k3bDIway9ia08wOE5Gak81TWEyS1lHWHA5SnF3TUNpQWdFU1VsMjlMdjJiTDhiMXZF
WDlpWHUKcGJjTStWaE9JZENjQkkxYVBYb0RQYWxUWXZzdnFhb1JQMVp1ZEUzYWpTTnU1YndPdWNj
ZWtSSG5EcFRWRk9QYQp4cEVVb0ZnVHQ1WVZJOHJaVDdlRFdQODBhME0yWkFCMGsyaVZjVVI4a2I3
SlFvL1F3VnN3YjhVWEU4QTlyNTBrClNGRGlYRm5VdWpNWG51Qk1xaHpRRFdGSVhwNHo3MGIzbG1u
Mnp5S1NTLy9Db1lvd05SMUpGdjZFalFzZDNaZ0sKRjhyODBLaHI0Zlo5T0ErSCtLc29YWDhnNXRI
Uk5scW03MWNjelI2ZnBZQ2hUNzBueS9MTE1KdUx1QUVFWEFqdAowMWhZRjEzbHkyVEVlcXZVWnVF
eFlwNFY0OUFxQmZ3cTZwL3R1U2hWRmRLV1cwbndrR2dveUNzbWlWTmY0c0xWCnc1dWxhVWJjc3Jq
NUdPcXg0ZmlJWi9pODBKZFhjQ0hURnNPR21TQT0KPTF5UloKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d0917063f90709b--
