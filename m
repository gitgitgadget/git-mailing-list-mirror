Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C61C460E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271856; cv=none; b=Hu1RweUOqEwo9Gfr/DZn7u0gisUleONaln9kIpea1rydMqnSipmCfTGV14bxT1HbHPqmJ03wJ58UvzB+2AJWRbk/bXT8fzExKZu1usA8NtnrvYPajQBgq9VIyytkvNk0Yutsf7El7nTFxYhFrjSV8AqCBxDJCR/MKpQMED29UC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271856; c=relaxed/simple;
	bh=UlXoABOch6nPKAkfn0l3wAwaxirZCFsyFaVLGT1yBKk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGC56n7zEU1di34c1K+OFbbAdzyV0XjnMELT50XBn9t+SbEc7GhY/yMvc5/GIvGf3UMVywGrqHGUE3tKP6X7g5mPZydrIv6bYFoH3lJkWJwegUe8GUqcO8kCo+WCM+1y6IO7xhqNY5+rbAw7I3SSwfz63pvSnxkgZKefidYY1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH+4yWHD; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH+4yWHD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-856a084088bso663397241.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732271853; x=1732876653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ7GwLLQjkA3yWXXW+RYcnfagFuo2rrkFnoQwPjJkzA=;
        b=kH+4yWHDoWAk+HRW8+7Ww9VomjsQ/dBpWO9lXNCPIUAeDqgeIAKqITvRrIkaup941f
         R3lIbhr+TVEffxVzAahvJ6zngObLXXyNLX724QAFfSQ8RT8kSxSmAvliegToxsdDqjtM
         lN3XlUb/2k2btDNXbTrxumAD/LJ/0Fh5LRp7gRzx5k++YgggLO8JC5Wwnx1Y3LT5PcW8
         CMI3VQX5hbX2iQYfRiXtrpLlZYy10MxxOFbCotRM4DwoLyQ6IFFCJVfkE1b55WCTr20Z
         1QEiNx+ayxjmgbQLbnDOCTSVOaRIYheT3SM/Gp+8fFx+tp+BiZpq38V8K4NQTvaJury3
         3VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732271853; x=1732876653;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ7GwLLQjkA3yWXXW+RYcnfagFuo2rrkFnoQwPjJkzA=;
        b=wJTU1pYstdjyC3Br27cUOT/LQUQxpxxyHRQJKUEzGxa8f5JKOMBMnpkiJe0HwiLmfA
         AMJyjN+lcEArBl08LBbMqhbgE8lZk4QDM8ba2gWGGmrsq6rwVR5VxAX8j7MvtVTJSQ+D
         NqALVd2iMobYwiTpb/BEp+J5R5ZVSG7SGNklUO+WQjFRyp7AGp8az6MIKbSaNJH2M8p7
         bVIYaV3lq4OcZYZRH72COH5k0g8r6CYfKX5wnRaWPGjo2UWs06dgol5nbxI1whX+5DkA
         CJdURrC44RSWW+Ii9ED8ht/yCSshgKvFO5vckn/qpWydbiQNIr4rRgjHCxIBeO/Gfebc
         bpcg==
X-Forwarded-Encrypted: i=1; AJvYcCXwitky2Kb4DRdjPIvIHMnDPHvPTfMU3mp3CL+q3Im0kU6HQiqkdsXl68DAT6mrnrFq2zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt2pTNc47yEBRsu1LatEvdQK5DcPMF01qHfvtp3iTY5q6Syeyb
	XoVR9Gs4OgS7IFE80ZGZY0PiLRP1oA+TKoRIVVzm1sRedsI4wmzJ4+L7LhrH4D1+xXWm6e0zSfZ
	oVpArv0RL8+b2c1YpZ9Vm9F6nzrI=
X-Gm-Gg: ASbGnctQkpCAcUZOUkZlUsLYsGHisO5RWC05LyG4o9/rYTPaeDU7ZLWbA6TaIZmmJQ1
	46V87QbRcjKmEX//YhiJymhUHaIl9xw==
X-Google-Smtp-Source: AGHT+IHaP0Vi5vxMgO0eGDrCewAJl9Ujr+Lq/jnOylGbtDh03KvSSaEp7p04fvNBxJSdcDNvbkclYvGzrdXvbm1+38A=
X-Received: by 2002:a05:6102:4429:b0:4ae:f4d9:9a4f with SMTP id
 ada2fe7eead31-4aef4d99b34mr697113137.12.1732271853420; Fri, 22 Nov 2024
 02:37:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Nov 2024 05:37:31 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241121225757.3877852-4-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com> <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 05:37:31 -0500
Message-ID: <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of refs_read_symbolic_ref
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000007a74b106277df80e"

--0000000000007a74b106277df80e
Content-Type: text/plain; charset="UTF-8"

Bence Ferdinandy <bence@ferdinandy.com> writes:

[snip]

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 38eb14d591..1809e3426a 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
>  		return ret;
>
>  	ret = reftable_stack_read_ref(stack, refname, &ref);
> -	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
> +        if (ret)
> +                ret = -1;
> +        else if (ref.value_type == REFTABLE_REF_SYMREF)
>  		strbuf_addstr(referent, ref.value.symref);
> -	else
> -		ret = -1;
> +        else
> +                ret = NOT_A_SYMREF;
>

I was building my series on top of this, and noticed whitespace issues
here. A simple way to check your series is to run:

  $ git log --check --pretty=format:"---% h% s"

>  	reftable_ref_record_release(&ref);
>  	return ret;
> --
> 2.47.0.298.g52a96ec17b

--0000000000007a74b106277df80e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 69851d9cf3915398_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kQVh1b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTBFQy85ZlJXL1Vhay93RDlWTEhTMnRXRW02c0tQQgpXL3VTT1ovbksy
WTB4L3pmMnYzaUZYeDZmdFdCdW1QdHpXc0dqRzBlTnhLa0FTYW5aajBaZGpPWjBSTjJ2bGphCitM
bEI2N2JMZC9pNVpxaVpEb1lUdDlSZTNTY3k4ZXZlR1lxdE1MRWtRNHN2ZmhQaU5pamhxb01uLzZz
VXhlU1AKVEFQZCtDdXdYcnNTMzBaOStmbXM3Nm5vRXpkMERldExpV3J1aHNPZUp5bkZLeng3bEEv
L2FpaFJOcVRBMVFLLwp4SWxQaVNPaXg2OUNJR3NCZmZqdTFVVHY2ZUVqMXNCS0svR2g4cTB0TWxz
QWFrYTZBSEcwdWhOZ2FRMWx2YlhqCklHR1RPWjhWSEJUS25acGxCYTFkZnhNaHlXWGt5ei9KRlY4
bGNWNElUZUxFWkFpYTlWV0xsU3kzRUMyanlVb2oKRk9SZjI0TmlPY1pvT0FrbFVkNzk0YTF3aWZN
VzRzMDZRV2tOdHM5akxuREZXZWQ3eVZIY05WdjRkSHpqSENBSgpvK1RCallrNVV4aEZQdmlyRnBR
blZwRzhsUmo3bSt5VHRmRkNsRkphSDU4eTh6a1JGRlBvSzhobVNHYkIvcjZYCjdQUmcvaVBBNmtT
K3BHU1VFeExlNjNEY2sydjJ4OWhvUVFLQ1lPdz0KPVJwaXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a74b106277df80e--
