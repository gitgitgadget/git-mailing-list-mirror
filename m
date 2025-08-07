Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC2244675
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556924; cv=none; b=bVs2jS+EcAPHo8/t1PUuuSovq8fBEqWnl7kqWVpqow0SZV3cVAijwTXbtT1n31teXTpiwHZhWDKLNpIkHhx8VbulmMAWMUpy3CuIGMiygb2ZeSbdBYzfEiS+W9yqrPFQBqiXYNrENNL7SrTzLzeFX2Ttvx684ms2w/gfh/lnS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556924; c=relaxed/simple;
	bh=kSZob9RsvggNOP0BX3qRQDKBkxMuXxt/7Zv9ux+HnQU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai819yzC1uM2GDXUro2Az5TJYFizCqbCgI8bT0x2W2fF8xRPr1ldGPe2I/aWEXdkYWkDO7Pvn6AJCkVGDBRvFRIa9MGJDFtYAkjjyon9Dc0Fd8F2VtfcWwNPQ+FufMnydFfmtRxpEPcJbFzbBeM+UhDiGC/HeDV0VMkJA57I9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvsWrWY2; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvsWrWY2"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5393a970209so531592e0c.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754556921; x=1755161721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGievvd+e1LR8hiEJQ6nwEOKUxjCfskF51lxzE3XCMc=;
        b=JvsWrWY2dlC7u3nQjETdCZMla700G7TXTNBPXUCgTspSXJ96oXTs2DqFmHpcZlxyWt
         bAmQiIOAM3EgyFTQ5TKyrS5iTSb9jfqBbCtl4PoVPg9GzP052x3viqumnANecncT2TJ3
         3geAo4/kVddPreebiHgMrMRN7YUW8eQEqeKsOqDjh0+I4jQclYjNqD/IJo0drVmyQn0Z
         etAEyYvBQhFpZMkmZUiTaw6Y8VSMgqOOeRvkocaYJeKgZy5bX+8ZP5/XdmmwHbrgLCdN
         GH4IsScxlXSrZijrUDbP0hK9zPCD4JaFba99gLKZ7/HY0y/Jj/buqWntuuk0TqVgiJmc
         OAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556921; x=1755161721;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGievvd+e1LR8hiEJQ6nwEOKUxjCfskF51lxzE3XCMc=;
        b=IN3xq74TiyTh6zyXPkQRXKCdG2HzlzwJgGWS+k6vJWVS+a7ze08lkw83JNBvAndo28
         elIiovhp5Kpe3noZBAKb3GJa4BfS1XcOPk1Xl4R8+PH9zvi5VohxU+8vP+SZnPIGgJK0
         zorZCm63ushjeKwW8JH4Yvdh/G3YOr3CV+2r5eN1Tdw++/xPCtFJcel/tAesjufVSpiu
         4y8Ehynw+HLfZbB9ULOztKGT16z8jXIfthG0Gpv3yVHM9q0yQxT0oFBaznT+RzEUgcUV
         +oZINp5s2ctNkwE/mLJKBXiwXpanka5g1j+M6xLpy2hQVPr1c+3SwZB5SGPGywGkYt0i
         /8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXrInfQ7iZdJiXigMbu45ZdP6+r7rD1PbFpZbtSJbGJ0S3XeJL+vM6MP5YfkX/gJ0f8zCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oz+jRhO+bUjACtsVHobhyzwNph1v2ijLnMnW3B0P1hkzzyi8
	tBnAyllR84Mb3KskwYKRRga204Pdbi5zJFvx/uI3NfwLOlsLQBYfY+eb4uKxvt09TzsN4VbwifA
	Rj1w7ytVHGvCOhrnxFIwsUfA9aVIuDwI=
X-Gm-Gg: ASbGncuNT422z6PV4pn4dUbE1Dn2ddI0qmQmwpD/QpSQhOP2BwPiRe55GT1JcPVuqOE
	zIrAstfyzz8AW/KfBC6JmoFkLksj68KePwyAzBFdZpZzRPw3sgdmj/slhRmObDBBVM1Xuq4BdB4
	Gb4JvbfW3+9KTjN516bfDBK5FcdGSRLnVJoLvGZ+xGDw267m3Kpg+EcIQ5BPMooAPfcKeaPFPQI
	Y+XQA==
X-Google-Smtp-Source: AGHT+IFPoo0GF5M6ahiZcTM249mADaRP84TNLGQ1N1ndcQQM02t711qI0jmTQsCSHQA7m2Dl9HKeqNWgkWlJapohtK0=
X-Received: by 2002:a05:6122:310b:b0:539:3403:7353 with SMTP id
 71dfb90a1353d-539a04bda57mr2696228e0c.10.1754556921419; Thu, 07 Aug 2025
 01:55:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:55:20 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Aug 2025 04:55:20 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-6-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-6-748db2eda3b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Aug 2025 04:55:20 -0400
X-Gm-Features: Ac12FXw0nbPaT6OWTfSKz9bNMH9uu2rV2ClEKobEGj2o4-W7iKVo2D3e94FAa9k
Message-ID: <CAOLa=ZTdgra4j-9WbU8nnyQ=38W03MRWbYdJgCGpxnSkumJ9Kg@mail.gmail.com>
Subject: Re: [PATCH 6/8] midx: write multi-pack indices via their source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000000a3742063bc29e38"

--0000000000000a3742063bc29e38
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/midx-write.c b/midx-write.c
> index 37a0b1682f..bf7c01d4b1 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -913,15 +913,6 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
>  	return ret;
>  }
>
> -static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
> -							const char *object_dir)
> -{
> -	struct odb_source *source = odb_find_source(r->objects, object_dir);
> -	if (!source)
> -		die(_("could not find object directory matching %s"), object_dir);
> -	return get_multi_pack_index(source);
> -}
> -
>

Since we now directly pass the source, there is no need to find it from
the repository. Makes sense.

[snip]

The rest of the patch, simply replaces the 'repository' object with the
'odb_source' object. This makes things a lot more contained and is
indeed a much nicer flow of information.

--0000000000000a3742063bc29e38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6970c2e104f7a095_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVWFmY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3pnREFDRXhYN1d0R2lLZnpzRXNDZkJHMXJwRkdJdAo1MmtpZU55ZVFq
RHJmL2hzK1FqS3BoMXhzUHNkVTF1b1o0V2pNNy9EUFVKeXBGbEZmM1NCYkdUVFlsVHB6eXhDClpV
L2lPOUlsSHAzVFU1b2UxUWdJbno5ZXB3YUd5QWoyY2JiNDBBaDZBNmViTEFHbGgvNE1OSCt5YzA0
NEZCblkKaHFiZ0hmdUxpdlIwamx0SndPWVpTRitOeHNPZFI2enpNbFRwb25YL1FLeTY0T1V5WWph
K1YxeTgzK0wvaEI5dwoybjQ0SGVtZEt6dG4xOEdGQnRiYThBRmxYZGlzM3hHYWFDL2RQamlxWGNs
V01jQVNOUEN2UnV0czJ6UmpnSWdFCkhUaCttd1ltbVh6K2ptMGxyWi9sdVMrU05KNEl1ampCTUVH
RFlhVGxKMERSOGRhaGszUmc2YXpiMDMwRUFZbE0Kbi8wUWRrVSt1d1V0VTVEb3YyN2ZqL0piUGxi
TjkwbU4vWGZwVVczV2I2cUVlWmQ3bGcwS3oxSXhEbFRCRDZPUQpveXU2VTUySHBUZllweG5nMVFI
NWc2NDQ2dzRTbDVUSENpb3JFQVI1Y2Y3am5PcmhsNmgwVlZjdkpxeDFYUWlsCmhPajRCdHFKS2E0
b3pwY2lhaStHai94VG14b1Q1SVlhWGNFS0tsST0KPVgvZ2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a3742063bc29e38--
