Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3316D30B
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805623; cv=none; b=ss4UyvuowB8UCqqzQLxqEup65ZxgtCl2gxpI2Kycpp+d6Ou+KoJ4mcwMV7XFz+0OXWXIeS5xI9tl6Fitje+g+e7JWz64a27ULjb5CssTiCO5GzYOBo8p11e80Cpg27pxxQm63suE3/CsBD7IPfpm3pWR+8HZ3+nrLVYdDwz/9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805623; c=relaxed/simple;
	bh=i1oqhB/jhA7YAZzAAl29q8BwDxQZDarSCEB3lpreSVc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=W2+A7OEcZBr9m+AH71OQrEOE8kO7N2vxetcARTnXR6T7f31vWzZezJQqCPuMQFR4oCRPyaCm60nuAT3D2O9s+DPzsBSvFfW6SCc9JC9f6zPofM4Rx9+DgCxQEs6n3hKFVF/oRiNF0UQjw0CE5omutV+pvEJTAxilppHBAIgbrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbLqcrR9; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbLqcrR9"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad2so2289135e0c.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805621; x=1731410421; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1oqhB/jhA7YAZzAAl29q8BwDxQZDarSCEB3lpreSVc=;
        b=GbLqcrR9VQyilNLEp0F3tCdPjz6Wa7Kivu9aMn3MkPqfy2EKwDaRhW0X3z7vrxRgIj
         WM8vsF9v67BbZF2lhGenjMzhp9h3mT+YiclwW8P6FlkBhqGaYBHEqzj4bBQRmsHYMFG1
         KE6LYXCzLQPxCJJsXmtD4p+abkuQdcNvEg0AC48djrkllXk+OUWlKv9xcfi0zpmhEXl/
         qkZJYKvgaeDjJ9TBoEV+7FDp0D/ug4am7NaxH4WYngXZZ8CcDY6mSrSLSkZG+L+kCA2f
         YcUzhJW0Mz8hyxUK4+Jlus4AZp+m+IZsY2HcU7Qrz+d183ZwDVy/Oz2irrdzty9ho523
         K9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805621; x=1731410421;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1oqhB/jhA7YAZzAAl29q8BwDxQZDarSCEB3lpreSVc=;
        b=Jq11wgRTdb3qqOCSTlfMmJfgQw2orAxnHlmw7q6Si0lv5nI92/jJtw+tcQgovaVTgE
         u0tW0G5K4/czTAQ5NMYbFJz4cKrZRaUYAoL2zM6OBkGTZeGnpK8FfEc/3YyfsWVTX+BZ
         s+4ahp3z9IiX7Ov7oADQFJVC3yB12FfTSrES6ffcyZG1eYIyhWTx+uAF61KrYHq5rfQT
         Cv0WxMBtsABIZFI6qWsNWYZYu4RC2USeOAmDk3yDWtjZVfbuP/mxhhEz8ljhY8w+iJ1C
         Tv8/I0HPAMh4Yu5tB29xtftwh99i4ALhtD5WF55DO/SOHXFD8JI6udBrPAbHxboQ8yIs
         ZL0A==
X-Forwarded-Encrypted: i=1; AJvYcCVp47LNRo2Amv9kTB2ykjam1XqRDcJx7TCc54kd18madlHI2a+XEgZvWWWZAR8G/vZDsOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmhiwhJXDhQd7KbwqLCf7/tIcCEWSknvQVyZk64DYsEzOVfmB
	KNNVgPn1IHGyr5MehUSd5R/iOcTlr6bm4uFO9jzEZmvvGNpPOWcCLC3DW3sEaK7l0rDSglztYIY
	IWl+T282DJhkGpcCqXPf9jdFw1JXtN8Xo
X-Google-Smtp-Source: AGHT+IENSF6mt+ptGnIZpjErx1jf/ikMRvmqSdLmnZs8FdYTloo1CUQnfC6y6+JevVqGtlffgi9fFyuSs5axUUSj32I=
X-Received: by 2002:a05:6122:3d09:b0:50d:2534:d8ce with SMTP id
 71dfb90a1353d-512275960e0mr13562548e0c.13.1730805621116; Tue, 05 Nov 2024
 03:20:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 11:20:19 +0000
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <00fdf392a64f2b0f2e9bb7b398565a87c2e187b5.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im> <00fdf392a64f2b0f2e9bb7b398565a87c2e187b5.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Nov 2024 11:20:19 +0000
Message-ID: <CAOLa=ZRO_F93DDZefForD4Jx-ReXDKBnHeL8yOkHwPNtJ6S_bQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs/reftable: read references via `struct reftable_backend`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000390348062628969e"

--000000000000390348062628969e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`

Do you mean `struct reftable_backend` here?

> as input instead of accepting a `struct reftable_stack`. This allows us
> to implement an additional caching layer when reading refs where we can
> reuse reftable iterators.
>

Nit: This commit also refactors the function to use the newly defined
'REFTABLE_HASH_*'. Maybe worth mentioning in the commit.

The patch itself looks good!

[snip]

--000000000000390348062628969e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5b071c9e7d7aa498_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jcC8zSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkl5Qy85Q1J4REhPZURiUHFSS3BjLzJGN1JHQi9jQQpBdzN0a2hyc0tj
RExqdHFtdDN5eW5OWWlVc2lDVFpIc2tSb2lmYmd2MmJvWldNSHlGOWZrR2dLQmY1TkM2TlYxCmRP
MCtDWFFiWWRUbUV3MEpicytsR2hSMERvbnJoTFFQazNra2dLRFhtNTUwdVQwdjI1aGxoOStDd3Ey
bHV3NEIKTmMzTVA3a25ReFlkNlhyYURyRGJWNXpCYzVOYS9mbnhQSUVFSFlRM2o5dzdINndUT2pR
dytxTGVxT0hOUUdZUAphek82SVFzalN5Q1B2R095b3RQaDlvTlZLTDNHcDlYckZaQTk4N214UHk3
dGs1TFJjN1Fla3ozNGI0SXhyZm1yClF4cDVleGlQcVZDa2pCMHRhL3NVeE53WXR3ZUlTTXpwN3Vt
UmNZdFp4S240eXQrOHdiRzRSdkw1a2hyeUxxRDkKbmpmV0xsZzNZT2F5ZDd1NnRNZURhUkJNRER4
S2lTNTI4cmZyUWhFS0RYR2ZHOE1UV21QUXM1NDhncDZQOGI3VwpMWFhCd2QrK2daM0lXU1ExbGZl
NWoxTXdSbmQ5dktqTU9la1VFM2JadUYrY2owN0toSWUvbGluU2hkOHlSYzU2CjgwWno2ditaa2Jh
ZWVaOThDUENJOUpwa2h2OSs0bHVUaGNaK3FjMD0KPXlnL2oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000390348062628969e--
