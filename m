Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBA17B401
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503046; cv=none; b=kjrsGCfBKYxm35Z4YVyR5YD3SkSd2C0URG+Y/ZoQLnyNNmjibC+3b+Ipk6PP8B2t47FWs8Xm7nX8FWVu/+lOo3VXf8Z1rUGYQFGZqVL7zcsRV3vHo14Ca91FAt3Sj+BmBTG+ft8hMplQGLAiq9BiczjckxtHfiCY5Vg3QGSG0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503046; c=relaxed/simple;
	bh=a8QNUXilQc6XXnD7uZ3hVOe+I+C2gXc/JO7t39sPSX8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn+MVJ5ir6ncY/+mkVkx9M6ytqJ7pUyOHKn82s4TQhmUQGn+WnslwEzARfPG+ZtF7jcaBwiFxAsl6CLoF66aNUhHG7ggTVxN4B/Sv/e1lxRW5/Q/euCinUT0W4IcXV3notvFPJL4USX+t/NguB19P9BUENzHGPT4lmw1QBJ/mpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUTZBJXD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUTZBJXD"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f86e59f1so3730776b6e.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731503044; x=1732107844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIoboIDJd54nBVto7uUo+LpHGjRNQY44Kyf55WiGjzY=;
        b=RUTZBJXDQff6JTUMtD9kX3ayBPZqe44PGwNVApLnTpusCEl1gQQaFT20NXasjywjvH
         scjyfSos8lCGDtvKswDkHds8GvUjiIpg/eR3BHGyPaITxrXLYNdgkoEBFLnyCvjNxf1v
         Qq0CKKHwh1VIwv/eeoUU67C1PPnVRdfzHHM/RwBrcniysuqJ2TgZ6XvqLhFF72906NQP
         miMcPKXgr6SdTmGapzq9U84a1mj12GxC7e19e2mJz623F5rnxpMHOHsW7j5fEopIMHtk
         8eKaP7Arh6RYhvMTk3968DhfxD/gJvMajEsPwbi7RdwRKmB7IOHU/qqF9sKYkvomwlAG
         NGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503044; x=1732107844;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIoboIDJd54nBVto7uUo+LpHGjRNQY44Kyf55WiGjzY=;
        b=tbnBlL4FNqBIAWucrjw3kfhUEE3Jla5O10nK/qGQUDPqADSq3rjdwNe+rb37EkVYmk
         Gb2bpjSg0TWgljWV1Bh92qxQ3BaeQNfavkauoMhT6YYumlKi60SmEdzL3U5xKLNLSx0O
         gsVe+acIZkk53sodrpinNCkcjkwLS8dbcED7fbPBQnNsGHWxKcPMoxEbyiiY49pP5i98
         sS3pk7LkE/jMrCO3rMN4avQbT/9K8p/+r0eA3IOm01KIGXjTAgPPMKwXMZxRXIp9FNI9
         1kZnhkGmcIXyx7sA2jkTYe2fhJLO/ZJfsoPShWmClTUFFD3huRXuKYFicUYIN9TFUoH7
         n2Xw==
X-Gm-Message-State: AOJu0YzaT85pB1LasrzMalDRBjs4mlbiEX6uJL+zCfdseWKDjdpeBXth
	uZOSTlqjVNWsc13uZ9bAAyWONEuNoBg1XuEV72+OR/dUKiz+OUojqy/dFLSoomqbkkZ7yWq0b9u
	wQZrOUIRgkqABI+TbBJUkhTRd+kU=
X-Google-Smtp-Source: AGHT+IG1puQa4xhCgC2gDIyNP4dt60p27Dt5n0/zzX8QiXkeJdZKduOHkTCpvzaEJmG2qLWSo6ketLOgY2bkhWa1hxA=
X-Received: by 2002:a05:6358:d598:b0:1c6:2907:e040 with SMTP id
 e5c5f4694b2df-1c67ce1903emr138111755d.17.1731503044029; Wed, 13 Nov 2024
 05:04:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Nov 2024 05:04:03 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <87ttcbi9w1.fsf@iotcl.com>
References: <cover.1731323350.git.karthik.188@gmail.com> <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
 <87ttcbi9w1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 05:04:03 -0800
Message-ID: <CAOLa=ZTmmpqC7xDLMop=O1_gV+wj9P+dGqT18W7doo09XW3hwA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000def7980626caf7e2"

--000000000000def7980626caf7e2
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> [snip]
>>
>> diff --git a/object-store-ll.h b/object-store-ll.h
>> index 53b8e693b1..538f2c60cb 100644
>> --- a/object-store-ll.h
>> +++ b/object-store-ll.h
>> @@ -10,6 +10,7 @@
>>  struct oidmap;
>>  struct oidtree;
>>  struct strbuf;
>> +struct repository;
>>
>>  struct object_directory {
>>  	struct object_directory *next;
>> @@ -135,6 +136,10 @@ struct packed_git {
>>  	 */
>>  	const uint32_t *mtimes_map;
>>  	size_t mtimes_size;
>> +
>> +	/* repo dentoes the repository this packed file belongs to */
>
> Small typo here, I think you mean "denotes".
>

Indeed. I'll add it in locally but will avoid a re-roll just for the
typo.

> That's all I've got about all other changes in this patch series.
>

Thanks for the review!
- Karthik

--000000000000def7980626caf7e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f607089149a77dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jMG84QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDR2Qy85aVF2N29FY0RWV2gyWlBwK0pNY1RJbkdyMgpoM01HcEV0VUV6
NXIrQ2hTbFp0RG41Nzh3WTEzUzcvTEZBcng2akFzeUZIejJrL3BzK0FMdkN4ekRCcXM2K1lICndv
SzNKekxwbHZNK3cycVVWNVpOcjlmdnFsQ0VNV1RyaUQrWExHUTZLMmVVc1grWHhtdm9sRVpzeW04
elVneWsKTVZpVGQ4MWhIZWFvRTZjZzFGVEoyblRkVkJHdk43NjVyRHU4MFh3TElYdVNJbzZ4Q2RD
aXRwdUpUYnZtSzNhcQp6OHVZaVMzK211OTBaclJuOExXdVY0d1MrWFBOYWRadVFHUDZKNDlzOUFK
ODVHbFJwMW1QNExWYW1JMTZYWXdiCks5NktrWVhIT215M0lvSGlhV0NIQVEyZ2dDd0x0bktHR3B2
NkVzdlh6T2tOQzZIbW1CaUhqOWg1RjVjbVNXS1cKc2t4L2tuQlZVNjI4a2YwZExtaHUyVTRiR2hu
VGhtSXNaRmcxY0cvOURmcFY1aENxUFFHdHNZV0t3UDFlcTRjOQpmcGU5U1pONlFMZnVycUZaeTV2
UzlQUy93ZUhsVUtQZElFUzBFTnVVdHF6M0NuaDZqOThNQXNsN25tN1ZvaU14CllWN0JNYVNjZGRl
Rm1JNStBOHlmTnJ1YlpRb0MybHpGY0Z2TlNWRT0KPUVYaHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000def7980626caf7e2--
