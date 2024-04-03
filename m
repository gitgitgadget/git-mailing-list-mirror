Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13079147C76
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150198; cv=none; b=XSnJwczzAvaBUsYXP1Nbmn1ohR2toxcVsvfZhnd1By8ISRBaNhbOcaWLZajpzbUiGpIxfcgEZrzyqvs3SV0yVKubGSglqgaHV2W4+hRYBOL7QqAy4taKtUqdBbKrcApYCwpoWx9Z4WgG4cZL1CFLCXKdch+t8RghmKp+LW2prVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150198; c=relaxed/simple;
	bh=CLcBciirMDVBogkNUguY1Po7aSRmc/UqPyTJ6CM/cHs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=o5ih82b5+sPTHZkwVZurJALth1x5oR6xFLhRCbjVZ/Om4ItjFu/1hbFdHri4uAhdQYJbqmPbLyrrOvd0r7scFGkJxHleGyoj7wBfu0O7nqX6trVhbGfbL6OChqjw6Z6HltmjAkYBXvJOfaJ0FZb4DxG6JPQgbZBbqRRNZpEgxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkNqzbiH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkNqzbiH"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso4590651a34.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150196; x=1712754996; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8purMISx4R3NeTCqRruVu65FL22ZVs16tzsD1fnLGQ=;
        b=JkNqzbiH5t2JHO8VULnQ3uJKyBi0cl2FabS722fyTJQUugejdwV5anh880z3ZHmLM/
         hVGpiv+aCInSDuYOs9IRLi/vYS0jGDtwkA9BggWAEaP55mN/yr61GKUliakvkp4qaBDN
         XHwjS4NGl94fGC3W+qEE9lyCr78DeS+aiHip+CBJuOO+4YTlvaWJ44IFLBFtWyJGMyCd
         5DSd9E4N7WGE8mUO9047akOvfxxzh04Bewm13zewgpvoL89rj1NfxfTa4e+6xBtmoW8+
         okd6n1vZmdMYcSDtxPOrNyy7CBlOfiSjcia6S8Qy5ZKbcaaPhKtC8kdJ3yGCVzoR76En
         o4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150196; x=1712754996;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8purMISx4R3NeTCqRruVu65FL22ZVs16tzsD1fnLGQ=;
        b=VJtADrEL4LDxG5hzTZ1KvcDepK02mY4BW7YYE77Bv0phnsubxf4RS6Gj4w/5A2hzhS
         eg3oTxZvVZwfGLyBF+uSP2ndlMthzafWjzPnWusWkeiPtwrh1QLh/aBFRSe3wi1uPGwG
         uSGxqVpmLd4z+qC3PHuuVkzBkwhVtIj6eO2jgwECoiArgjeqaMS2z87Yjx91Am2+vhUx
         ET2dlIYH8N32YjLzmdmbVnS5i8C+YCMANoABsNWShwKN0XHZcPIQxU7+iWGCipTEgZuK
         Ob4NQ1P5DoPk4WLx0PHIAqnPIRo7/XfHsXx8hMXbUDGqYIDutuyq0ZI+BHfkpersYQ94
         Pygw==
X-Forwarded-Encrypted: i=1; AJvYcCVY0+8Dh9J2OCschxLVe20B82D6Pc75Z0+Fro/vfRKkBdySUAHm9/XUls+3SNjqJgttmXOkNEhpBVficakBXs3y9B6j
X-Gm-Message-State: AOJu0Yw9SHQA/m82g001BUONcGt3yS029RGP8oH67+pVC942VVe24e8e
	W/Dy1QtYRNYppNel/0k3m07yGdKzMsWQYOi3FuWwt6y17DYXlXnn4Na4fq2xqQwWbc5hI4mq8bL
	NMGXbEOcGdpFoQcDRLkwWNYHe9n9ENCBY
X-Google-Smtp-Source: AGHT+IEFjF/CVgLu31OwiPOGrIhWXZr8S/Ye0rqcnFH4Vej8zDKHOCkhgJG11cNzi2tftAL9SIQCxwNssU8jKnK2hmI=
X-Received: by 2002:a05:6870:51d6:b0:229:fe6a:8516 with SMTP id
 b22-20020a05687051d600b00229fe6a8516mr11328968oaj.22.1712150195902; Wed, 03
 Apr 2024 06:16:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 06:16:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9a1253649a4dc993da7caced2f15839d988905d9.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im> <9a1253649a4dc993da7caced2f15839d988905d9.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Apr 2024 06:16:35 -0700
Message-ID: <CAOLa=ZQ4Vq7YfUsh4mky8HsEurp3RyUEXsZS7tDU0XMc+6Gv0w@mail.gmail.com>
Subject: Re: [PATCH 4/9] reftable/block: introduce `block_reader_release()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003ab3f80615310801"

--0000000000003ab3f80615310801
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index f70efa2b7c..f925570bf3 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -253,7 +253,7 @@ static void table_iter_block_done(struct table_iter *ti)
>  	if (!ti->bi.br) {
>  		return;
>  	}
> -	reftable_block_done(&ti->bi.br->block);
> +	block_reader_release(ti->bi.br);
>  	FREE_AND_NULL(ti->bi.br);
>
>  	ti->bi.last_key.len = 0;

I would expect `FREE_AND_NULL(ti->bi.br)` to also be within
`block_reader_release`, but then you'd have to pass `table_iter` or
`**`. So I guess this is okay.

--0000000000003ab3f80615310801
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 317b89fcc4db4bfc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTlZyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGNQREFDWVIwNWxYeVd4U1pZL0xjVGlPZlprT2k1MQo2N0dMNy9vanNx
VS9ZZGNpTXJpS2E5dzNoZXdIOHYyUzk3NC9PL0tCV2F0aHlndGxYOHdYR0p5TmQ2TjR3VUI3CjNG
RXB0aCtrc2FJU29ZK3VDR1k5ckE4dkwxajZhYTNkbjRZSFZJZll4bDRNb2I4NTF3Sml4ZmVtVERV
WU9YNGYKMENnRGVhdUozalR1a3hlT2tabHlrQjJmMm54MHJkTzFZbzYyQVJ6OGVLMmI5Mm1yYnJj
Zi91b0p0NHk2ZUJIUQpNYmNha3FiSDgyVjhEVk11ZEhCeTd2cW15Njd4WjhjNjBaVUM4NWtrVU1h
RS9QL1NSdTBrVnZ2VXB1TG90cG9UCjZ2UHBIeUdjNFZMWkpuYjZUTzlxK0ZxNVlOem9zRmtPRTN3
NENLOUNLYUh0NFZtK0NlOTR6UkREU0hQL3N2SmIKZVhvNXQ2aFJMcVJQRlVjN3RpckR1T0tMT2xn
cDc5RVYrYlBIWHg1UVZ5eXFaOC96dk1JaW5MdnlEZkVWSU9YVwpCRi9pRlRERzBwWXhVdHVxMXpQ
WWxmNERzdWVFazRwMExza3NEYk80aU5EaldqNWR1UnNIaHRhYnRsbStvMXpmClJGdnNFMExIeG96
SWw5bUFjS1BqbGpBS3dxdlZ3ZEN0STY4VEkvdz0KPVZCYi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ab3f80615310801--
