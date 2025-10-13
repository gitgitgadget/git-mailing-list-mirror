Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C622E8DFE
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343507; cv=none; b=DzYG8dDI4SEBbPwHX8btME9QVXv72lcLYSnVUQ2qEXBZJsQennI9AaExoiKK4zMGlSN2ZB06PStkANoEFX/1ZTcKC7YGl5SERdfkmio5Hws7k4opCBccTcrD2hSapYxGisqtFIo/orajx/AyRMDN+czrm5EQ7nEOP2Q23HIm1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343507; c=relaxed/simple;
	bh=T1IXZVyjYqMfhUlfpxanQW+/uSLfcif00SlUpEuGfKM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxgoTjnXp84GbL9CKaswF90SaDG1+c1Y4aT1iUarHIl7BDARA+kPKDVjcF5gCoEcM9aIb8RTh90oDtGLc8AjVMzhMxcsrXmf0HRJNbi4eJHioV6pu/7bTrQbpD8DwCnMhkLQlIsFKeiEC0RpYqhAlSbL1/FiaEnHC06Heb2TJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6t5pYzK; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6t5pYzK"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so2678003241.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760343505; x=1760948305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MP6eM6d84V+KwB7a9C/wFTT7hdJY86x0ZJ1uctyqhqg=;
        b=f6t5pYzKAs+oaGA7tnZ63JWIywk3VqQpBb5/EMxFtHY/VJzYPGigY6CStuEXbagOQC
         GwV2mHv3JfBWgreC4A+D7aH9hqAdVux1etPUPRrTcNq+x5uiPlcfnnB2xVTSHp6BrOli
         0pzAITreXSv43Ov6evv3eYaV7C8plBqrvQShM8sM2OayMX2Gp0UrPbvnxpZmACY7ED3t
         paCT0is+dE56D3Txdpf/3DktfX+AwnrTC5QfJau8lcQyuKnrHc5rlS5CfCaC29HpgsEW
         cVXpknGeDQ1/yZfxB7GDZzGtGl1yp7XTxAIhaKgfsa8iOzSjLGZzTLwG/Q6M70ie+Ng3
         gJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343505; x=1760948305;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MP6eM6d84V+KwB7a9C/wFTT7hdJY86x0ZJ1uctyqhqg=;
        b=rbAu/Rg81Cu8faPxhTezh37dWQIpM79tWosN59f2yyUwb1lWuivJOuPT3kIi3MOw0w
         LRbxeavB7eq0rDjB0hpbcROlOExjIL1QlkerAmtcmlcAJwH0G18W/5XgLzrdigDKKd65
         1ZXWFP6x8tEtVACN3XijOBo13I4Xpi1e+SPFQnJsk6IQkaVbRFWeJcFEhGDRdgyJOr/j
         dUo67+m/9mCFRzgeH/kdTfXRNiQjKqjXes9gfEAXk+7GrNyVkTQpHs4qzsYuAgALhWoG
         3OYnyjDspOgwaouSG4SkCLhNDVTajmrpmpEeOeldm/cFCT953A2Z0cU9dwiIW5dnGgJ2
         V/uw==
X-Gm-Message-State: AOJu0YwinyHA5wyi6qsSIu75s72T86djNuHfcWsnv6fwu5oWqXjuMwTF
	d4K4WrWmfV2u/55S1lR6+uKVgJ0XZxp+9TjAocVu4XnlFJ22gM/UdBvu2T3u5rPcrdG8z7fFPcZ
	ye6AKiN+fRQyFwqGvmaELfayK8OnFLQIOn0jf
X-Gm-Gg: ASbGncvFc4n/GbnD24TmTn6j7h4zdsPDGz54ZmvLxJ+MhWynhHLanR1KZ7xVeOA+h00
	0cTna6NvtQKvl3Vz5JFPL+1w73tWJzIbvGHkECfJWIPMXkmJ16NyokUvX7UqUE6SmQugWcJCmnv
	706Vq8sALSxyCfV351h6YiAS7jWSvQyVxZbYkTm4TVECnznPKlIF2u8Sp6JDq0Kjh+RQt3Mnw1M
	+DH4jeJ7j+vL58+flCDKa9l++qjtbYdwPfxd2Q6BEKVSjejoqCAl/QPdIg=
X-Google-Smtp-Source: AGHT+IEpM50QdRSFxje49poMuCYPbVF611WHUYk32kRRRP/Vs/cVBk1yvJTvPfO5pksYKvI2H8E0ZwgGp7uPAWOyA/M=
X-Received: by 2002:a05:6102:4b05:b0:530:f657:c2e with SMTP id
 ada2fe7eead31-5d5e265d911mr9902112137.13.1760343505107; Mon, 13 Oct 2025
 01:18:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:18:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:18:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsYoeMkF6-w7G7@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-1-c7962be584fa@gmail.com>
 <aOjsYoeMkF6-w7G7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 01:18:24 -0700
X-Gm-Features: AS18NWAH17g1PbLdFLe--Rs7tYpoYHKd9yDN_gZGV9OukOpwVxnHHVzsRVG-NYc
Message-ID: <CAOLa=ZRuZebNnPz9punnHxBqSPNp+CbM4FJ6BG1RwC1D_Fjz0w@mail.gmail.com>
Subject: Re: [PATCH 1/9] refs: move to using the '.optimize' functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004e1c75064105e9d5"

--0000000000004e1c75064105e9d5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:05PM +0200, Karthik Nayak wrote:
>> The `struct ref_store` variable, exposes two ways to optimize a reftable
>> backend:
>>
>>   1. pack_refs
>>   2. optimize
>>
>> The former was specific to the 'files' + 'packed' refs backend. The
>> latter is more generic and covers all backends. While the naming is
>> different, both these tend to perform the same functionality.
>
> "tend to perform" is a bit of a curious thing to say, as it raises the
> question when it doesn't.
>

Indeed, will rephrase.

>> In the following commit, we will consolidate this code to only maintain
>> the 'optimize' functions. In preparation, modify the backends to also do
>> the same, by moving to supporting the 'optimize' function.
>
> Maybe: "In preparation, modify the backends so that they exclusively
> implement the `optimize` callback, only."
>

This reads better, thanks!

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index a4cda57981..0b81bd7f74 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1445,8 +1445,8 @@ static int should_pack_refs(struct files_ref_store *refs,
>>  	return 0;
>>  }
>>
>> -static int files_pack_refs(struct ref_store *ref_store,
>> -			   struct pack_refs_opts *opts)
>> +static int files_optimize(struct ref_store *ref_store,
>> +			  struct pack_refs_opts *opts)
>
> `struct pack_refs_opts` really should be renamed to
> `refs_optimize_opts`. Let's read on, maybe you do this in subsequent
> patches.
>

Yup, that's handled in a follow up patch!

> Patrick

--0000000000004e1c75064105e9d5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 934bc0f9cefe96a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3RjNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUZMQy8wZDVPRXAxb0NGSTUyZUNtTUtnZUhyN3NSdgpRZDFDaDVpRi9K
WlZMdTA3UkZhMEU3M2hVZjNIVXlXQzg0TW5XcVNhUWg5b2ZoY2tlVkdVcmV5ejRGUnBzK3hICldq
ZnlEb1E2QkM3R3BCbi9PVHNVODJSOEpkUG4yY2dFQXRpTDFxa3lCS3dwODVVOFE2WXdkSEphN0du
MHNoOTEKNzNhTldqYk01M3J0MHZZTzYzczRMWDFwTmNIYVBteHNJN29teklyd1Z3UDJ4OURPU0lh
ajRoQlg3RDN0RW8vUwpwS3c2dlNML0Z3QU51VjVCVi9vV3JLRlpHYmJ3RjlxNFFBTFlRMWExTVds
cGlyY2lNSkN6ZHRTUE9vSy9naXE0CnozNGRhZExudFVLbEcvYWpaNjBvMVpHclNkV2lEa3huR2Vj
QlYwV1dhTnNqV05NT3RrVHJlVGRLWXN5Zmcxa3EKdUoyQTN6bmExMU16cENnUjdzQUU4d0NsdlhC
QWVIbXFzUUlpOVovYlNQbVFXK3lkTC94aFlJMUJ3akN4aHVUdgpVM1NoZERkQ3FrZVBhTE04YnFx
V0psWHM0VVcyd0lyQXBvcVIwWUVROEpRWDBKUThkU0ROOWU1MFJOdUJVd1owCkg4L3NSenRGVk9a
Q0ZiWEoycjBxNFBEWDRtc0paNGVzTkp3R1JVRT0KPUlUOWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004e1c75064105e9d5--
