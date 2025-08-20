Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496961A9F81
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697918; cv=none; b=p8MdnAA/YH2mXpNoaLWI97jUx6GKEzNKlPcsNfz67pnSYuEfztX3QRTobyOBti/3LBEWjl/mhU0tWM6fUYIBMNDqRZHyMjlOZPsmPPEKuCE2vv/S26u+bLGuFstH3iJF6LW0EhD4+Cs4Cam0FNMvx2JyyomSSzEtAQ3OZpjyTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697918; c=relaxed/simple;
	bh=HCI6b8EGaB32+rFXM3EjQ+fihx8ao26wPD47SoUDji8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Vz2GI1TwyMHrBo3y/iMDnW+ZXUdmaZ9gQ7kgYP48NBZFbcjqcwOH4Os+4aZxYqZgPwno7HfA9E5ouq9MGSRFeun1VvytoWWlOMP/Nvgg7C50JYfnLUUF5Y8fcjV0+dvC7hqk+FVHPilce3mtqsNOWXkqo35hQ8uponV+6nFY9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG52sJ0K; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG52sJ0K"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018eb083eso3795506241.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755697916; x=1756302716; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FhfcRE+PFCFoK8n9IN4JjIatLphsV8dtDEp1fBblLM=;
        b=RG52sJ0KbVh1EByHNpGjjnO5bwkqJwuI7oHeb6yuZ5nHTRSy/cvrYoyHs6Tm1NiHn6
         vzjgBwmL3+m6okaZnz1HYa/bAZO4tHF43aKOYYBtScZanceQoNd/RnHclPz7pEWRM53z
         F+32dX5E9Vb0ekDcIzPKhoDC3hq9tD6V3fiG+zEx9rqWZ8hhTsD04sKnMJSB3luRQTnz
         zZb8FtRQHnacXzlcfEHTm3RX7AK10yCxBUbGBsc/h96G+GiqtqrKkcWy+udyTulS8nq8
         nBs5/ppe08tpShMGc9O9ospomoCsYHv+7Lufr9/BqmDVBgl17hMbVtfDsOK0pXgzEHiw
         Znaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755697916; x=1756302716;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FhfcRE+PFCFoK8n9IN4JjIatLphsV8dtDEp1fBblLM=;
        b=e/uzT1H3IhVNX7taVRt2uyGMSWGKdGaglE5VM8rGzfqviEdsIG5kCiGHST6Q4LEpxF
         QdXf3sEeXVh77quSY8ijV7eGwgHTgh0zfJHPGOY1G4KsxGxETRq3Gr+WfXuMzsGgyfgb
         ZN/nC3h75OqtKJVXPfKPeIoiUCf+SQQtIdq3YIHkDkZuKgGarE/k8B3pBBVvf5IJjaMj
         gIXNrfJiSDQ0iwccMXjupLsV/qNdfcMQGwd5mi3tXr7sKLLF6IbSORPPsB/PxTcgik+E
         sFT2GGYQ6Zbz+AKhHMoUExjUqScCxvk5TQux3ONJOSOGPa9G0dyp/A3JbI3GCd2WecPN
         hPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xt/ZE5/nuS7H7DUFKFUCIJ0/+Z9DoR+YgdYZ9wCVmBHWzcTRC63HrTw87+H+EQpzy18=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4ZVU/DPXiCm7iutbfDHAjnNUouUTfMNbCqnIgyGEggj5mBFD
	etzO3mjzja6wFCjEzbJfdO7WM3tMOxcqVZaim+V4CPviK4+Gb90nqT5x96SQyJ8BgLur6s0R9V7
	e2aF32/8SRxM5QbQL+iokShICikcn41c=
X-Gm-Gg: ASbGncsgU7qcSw0NNJuTdIVEe3FX4Zl7RHvu0x0Q4FPwjzYtXzbw7y1SjqB1ZT1jM2z
	43kUaCrOfm3wjLIukhV4GFIWnY7Sgjr4u2MC9avEeQ2OWZO8z7gqIMPyDE/GBgMsk8ur6UnSNVb
	buyPeVzXIbVcUjJcotMpx5uwNqlsqjgOtrd560H6EuMeGeIngbD+U39cF85JMFjurXdO2HSKZVC
	rUGLLbk4RxUuVLd
X-Google-Smtp-Source: AGHT+IG4vnfMWir8BQ2gn2/MuCXBzQJX8TVt5C6rFVL1nYhjbFD819Jy1Vf/4pIoSimyIxXBxjHmKQRTLtUix3l1pBE=
X-Received: by 2002:a05:6102:32c5:b0:4f7:c5ed:209c with SMTP id
 ada2fe7eead31-51a4ee33078mr929460137.7.1755697916061; Wed, 20 Aug 2025
 06:51:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:51:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:51:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-14-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:51:54 -0700
X-Gm-Features: Ac12FXwrBaxfTZ0G5na9h7GQAE1UTpS_jHJTdfY3cv-GiQ_W6cECGP-xX_mJ3TI
Message-ID: <CAOLa=ZSzgZdqB2OuS=Vi7M-ZCHDzjBCpCdW99co+xdPAB0HMHw@mail.gmail.com>
Subject: Re: [PATCH 14/16] packfile: remove `get_packed_git()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009edb66063ccc46fe"

--0000000000009edb66063ccc46fe
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 1d30d1af2c..565afda51f 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1422,7 +1422,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
>  	if (incremental_repack_auto_limit < 0)
>  		return 1;
>
> -	for (p = get_packed_git(the_repository);
> +	for (p = get_all_packs(the_repository);
>  	     count < incremental_repack_auto_limit && p;
>  	     p = p->next) {
>  		if (!p->multi_pack_index)

Nit: We can get rid of the curly braces here

[snip]

--0000000000009edb66063ccc46fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fa2289b32cc18e9e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbDB2a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkptQy85TnZ3emZLcHBodmRKSm1tY24yenhtZ0lhbwoyS3FVcEZJOVAz
RVhuQXR6V1BCYm5XZTZVdThrRllZZE93RzMxNzQyTlhMK1p0WTlnRklobWtLUVNnaFlWMWI5CnNq
TWhsYUZjYzlWeUdtYWUwemt2K0pQTlBhT0FRck9TdTFqMzBTZFRkdHQ2WXpTa29KbmkxNW5vY0pJ
Y3pyOEkKdkVwWHVwbThoK3NkbWdMSTBLOExjcDBTS1lQcW1MNzIxcDZEaWxLQm1hR29OR1ZwRGEy
dkt2bFZrY2hCSk9HRQpKa1lyS2ZrL1BFNGpQMDc5aVVXVlhxcTVPbGFDV2NCVkF4TXREd3ZaL0dr
ekZ0b216UFI0RkZvQmNDTDljam5sCjB4ODJWdk9tdlY1enVFa3o4U3lLZEVlcnp4YkxvS0RoL1pm
Nzgxc2p3WkN3NUpIbTQvczg1U0NCdDEvYzRvcFEKSldmTnlMMHhxOEhpb1ZjNUlZSUx3Uk0xaUVk
c2RRY3dtV2FFcFg0MlBUYXRsMStVVFpseG4yckRwWXc3MEJIbwpTWldWeVRHdFk0YXg5OEtKSG1L
RXIwOExIeTZSbFlPMDdUOXJia1JSRDJqQml0MWt5bXhwdlZuT1p3ZFdBaHJxCkREWjRXZ0U1VjBy
akxwZXdNQ1AwekdvNXBWUEpFRDBoNHE3Slh1MD0KPXFoMzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009edb66063ccc46fe--
