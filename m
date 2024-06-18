Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AE1CD5A2
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702737; cv=none; b=GXGI2TtLMd+7TGfsB2j5m+wFUh/bgIy5gZ4u2cyh5p9sEyzZY2j5TrfOoK/a1yNFNJMij7/5fSh1xEZAQY/REJFvb/624hlvVJoBBrYAP6mtqZcJUnLxUCH5YhyelpI99sLtrHeLg41QOury93k4po3LNXoZ9jjH8lidTVrbCBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702737; c=relaxed/simple;
	bh=vGejdOXa3QkmRweVthZPtDmI5qTfFqFUfUFpz20/nE0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWZADLqIwiGXr8PYeL+dQ230/uU41eQIavTI/HQqE3i8TvYP/cO3DULJM1RpNSwQlKgMRsRQMZ8AeL/zGlxuHuE5VWOf4r6GqDx9VluLwz1+piy1jE18BC4M1TjTEBEmGClojlzsIvktShf4YjPlags8snzJ6holLMU5zDdYIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh1tia6L; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh1tia6L"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c9f628e71so2706525fac.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718702735; x=1719307535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKqn6otveolH92WyWnciUXS04Z8hyHXqQ9qG0nEQoEg=;
        b=kh1tia6LETHGguqnXvQoU+3ePQco9q27P5XQX5FvbkMYNqy630CVF/3aNlWPxV0fH8
         IGpWB7osKVLTLePNhrNdK6J3Y/acDCpaheJd+cK6ViEDjk7pBui6WytSyDDT/OO0E7fD
         /CfomdwvomsYqp/Y7gyf9NueK0T9d8Nb14/c3pBVYj1+NyRaUE7l6zpJhMPQv0aAqRc4
         AC6Tep66Yt7bpd+HqVowd6bQmc08mkIpD9+vtqwHZTWVmWfElHOrEAHuyvjZEjzlVRKd
         gGYPqRZIV1WIxHLQAOcD8yP7BHqVOm+gLWgkMdSwoMGJYTTjphKqSagXOhsHpNSzm5Ok
         lokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702735; x=1719307535;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKqn6otveolH92WyWnciUXS04Z8hyHXqQ9qG0nEQoEg=;
        b=tFZu7CquxrDK1sbbBZmhSbWdIdB2CzOO4GDOHUYBZTnzreH5O90E5F+0r7t8/B4NRj
         AepW5uEAq5wdkjok5fIGmOSww2NKbKCDFLWRGm6y8O8nD2E0LZ2YdPUvevjoo2x2wk3A
         mmkc3edvNQGf8bp25NI5+noQnpPPTzPeMJSEGc9FvAc2mbpcXn/xOpppXZ3Qf7ypZCDR
         Sb/GpKBPj66c7T1+WleBca4WJ4nYYHnfTEL0tC/PzGAuLm87CeCTbkvb2BIi8GWpBmXZ
         UjoKXCNHQ5RJAVovAL6/jgladerMw3acxY9tVHgfcSg9lheBJdry6zpcG+NGe7ixmdNF
         pGCg==
X-Gm-Message-State: AOJu0Yw2n+cOX0um61is+n1Q63Ft0hbPNnwXQQrKoY4Gx2hUcsPF+ciy
	MS56RgB0fV6uW7FGFSSYjvKEwMWHqAYsGgkUbDDxLak1Ksk7fDsrbFF7vbth2e3d866hbjKs3sO
	mJC4mxHcuLprlXv+BDU9Zc1y1x3A=
X-Google-Smtp-Source: AGHT+IHJSqcgwCGEjcPVK/Q/aQZ2wv0f2xNBKqdCLHAApmH0iJuQeA3tlNgYTyKALEJcsOcOShXK6PSiWZRcFvaS5ts=
X-Received: by 2002:a05:6870:b1ce:b0:259:88b4:976 with SMTP id
 586e51a60fabf-25988b41878mr312400fac.43.1718702734819; Tue, 18 Jun 2024
 02:25:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 05:25:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZnEYNzLue3OIK-Ul@framework>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
 <7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
 <CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com> <ZnEYNzLue3OIK-Ul@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 05:25:33 -0400
Message-ID: <CAOLa=ZRA6QDojbvP6btOGX5q1Pa0DivBZA_J1gojF1gJu9aENw@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] global: introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000fbe119061b26a963"

--000000000000fbe119061b26a963
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 17, 2024 at 05:30:31AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/hash.h b/hash.h
>> > index 39a0164be3..cb85d26a2f 100644
>> > --- a/hash.h
>> > +++ b/hash.h
>> > @@ -4,6 +4,8 @@
>> >  #include "hash-ll.h"
>> >  #include "repository.h"
>> >
>> > -#define the_hash_algo the_repository->hash_algo
>> > +#ifdef USE_THE_REPOSITORY_VARIABLE
>> > +# define the_hash_algo the_repository->hash_algo
>>
>> s/# define/#define/
>
> This is in fact intentional. We aren't strictly following this in our
> codebase, but when nesting preprocessor macros into ifdefs then we often
> indent the inner macros with spaces.
>
> Patrick

That's something I didn't know. Thanks.

--000000000000fbe119061b26a963
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9468329fe610c7a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aeFVvc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDA3Qy80MnZmMXZuaytqRVJxZWN1UithS2QvR0FqYgp5ZTB2ZjZsempw
TmZjZG5rNkFrMTZ5YTNRL1E5cUVZUzhMbmFqcVNGWFJjeFRRd3oyazVRMzdaQitDQ3hhVFdCCkRB
Z3hFdWJ1RmNLVkJDYzJPYytHQTZFbnA2TDE5ZEhYRTBSUjBkbStIUU1ZeTB1cUw2WEdZWFljc1NP
VlVWeDgKY0gzdlhoNFRKbGlGRVVKOGtPUkcyVGlMQmp3c0hYWVplc0gvb0VYbmlEbG9MUVY0ZDQr
TGI3NE03Rmc2UU9CUQorR003YXpvbjF3ZUtNTUlmNGdpcDcyR0w5VGN2R2tFekhrYURBaWNOcE84
MnhHdWFkbTdDTzAwcENxY1ZaVTFoCmplQkd1K0QvbjYxRlU5MkZWSUF3dUh6eHIrQ2J6blA2bnhF
L2MxSEZXYXZXWVhZL0pRcTB2VCs0bndQOXIvZFEKYW5WRHJrU0xTTjdOTGUzekdPaEw5YmJIT05t
eWFtemZod3FyVFFtWVdITlNDaFYva2pNNi91ZmlSNmpaYjhNYQpHanRGRWVvWFpYK05Pd1JXZTlK
dHlOR2EyVEtDaENUd3Rtb1IrT1p6WGZCYlJHbTVEZllpWE1DQnI1dVpZZGhiCkZXdHd1amtxdjQ1
MFNnT2FyWkRZT0hSMlRDM2Q4WnlMc1VOckdiOD0KPVVmbmsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fbe119061b26a963--
