Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F21F92E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642110; cv=none; b=iJyQC/Zx1xJ2BtgbCLwmVfw461PB105eTk7IKdftns8KbxEuv7lLtdJ6rOE1TMbVq9Ic8ceRQa4eN9lDmj0labI6zZVPzb2AFy4KfYrPxSRheKwt655z9BZ0YQSJhB52I39KRbKvFXKypX2nwLGCJ204j9TIm/SE0JahSzRhZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642110; c=relaxed/simple;
	bh=BHVJtoNMHWQgXJ3kNIT+8UC7aKcEoK4DGgVRn/dE6Y0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=SWsozu7q1XmbSSfo5QPgJebHr0NS5KICzI9T+jv8Gz4NaVxnX/7HAZX8kUzOvoJTjb6ZkPaLfpKLW1fmrNOFDS8kGfJbvmAAu5pivGdJSRfwxDkXwvJHy3zU2/4Plmt1G89yFi6FKYPygaKRTs4XolbiWhE6XdE0WofmB03QnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoD/sOXp; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoD/sOXp"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5570a77eabcso4215091137.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758642108; x=1759246908; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjmSQIb8ePAFF824tATmmgHwov4UJXlEJB5WqSbMcYw=;
        b=FoD/sOXprjGUCLsAIBGhJcA6hKMH8gG4Vg0f4I0cTrMt339NAf0H4suSIYYkaC98MP
         x8924KxwmAOLZMSZvqqE/XGDMbO/hYCAQEyHVJaJJxIQqW27azLjPGqkR5fo2nRkKNX7
         sR7kZRll9prBmM7LbvjTZ2ZH4wa+2md1WR9dNnZ7bVfEggbigIp/z70xwussez5gH1n8
         HwsZJueEwoqpT3PvCUpeBZLYasV35yT855EFj6fyIBYD2Q+dbF54hbJPPCuw0/WVF6Or
         nNVE+DbJJNvujtl4wMqlkkyMdns2h9ZOPWDZZfXdF9nQFF/kIcskDocLqr6fmOWnUfuG
         FOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642108; x=1759246908;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjmSQIb8ePAFF824tATmmgHwov4UJXlEJB5WqSbMcYw=;
        b=XERqDhSA6bfUEczAroYBsLeJY2vWx5ynUq4pWCf/p99XoX5Pr4sh3iMVPvZdRZpXov
         vlqLz/5laAsbXeVc5TutZqGgSYQPxsUUOPLUUGGl+LPWumh9jfUPm/G10YXPHNXZ2MKK
         KThNTBVPVyMyra/mgQBSM1f290YqMd993ttPjQWAx51TklvbrmwzwYkee/sb62VHYpWZ
         7NUdyBU6jiw7iYdToiux5IdwQrODgfg0TPJ7J6So5YYkK7bzjXrrJPioM2e25mVXR6Zb
         heCvwYyVs6y+VCkXYYaX+4jw/Qdpc5nfMZ1QvkL55av8wodcF+ld/+JhYzpC6giAE68M
         0xHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUvBWninMs1n8nRrhVf5Rmwp+Cr9ythHLJ1OUrYxioi0ohbxzDVzT8B9TqypezHa1MhfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAW41a7xM9B6Lysmh+OgntmYGYg09YFAzAvsuViYw3q9cvkPq
	4bTv7kz6FCUtMgoKd1BW8doxGHJ/zAOzRs3pOIR0/u9YE6qaZ21WChvUo25t4Yx/nR9r0fZf64c
	UlCH+xu0JNtR+ao5R7g22NCmpPn4y9ro=
X-Gm-Gg: ASbGncvpcEMPXbNcu1MlFFOeweLqi5qy9vwlFX5W3Qe5Ika2ZcnfzEMh3KHffhikv5+
	khQ+kd3Fuizelpu+lN8SkJLP+qPbeG+4hwn7CudiVU08xkuu97YG91f6vj+ebsra6hPdStp3zWz
	bpNH6lxIjskF6n1fdFRICvi/t00H3vbf7zESph1oaNr9vJr5D3Wp3yq2nhgvv65kNH7/lK6yrZf
	W4tpjY=
X-Google-Smtp-Source: AGHT+IHsut+TE4rqUOD+jHjxDQhnsGB2CP0WzNWCyjgw02mdP0NSH+GUZcMbKJ7XACCVjmEw2KhAnvPHm1d/YI4RN98=
X-Received: by 2002:a05:6102:38cc:b0:59e:2c90:fae2 with SMTP id
 ada2fe7eead31-5a581876534mr1208987137.30.1758642107857; Tue, 23 Sep 2025
 08:41:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:41:44 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:41:44 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250923025700.3046260-5-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com> <20250923025700.3046260-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 11:41:44 -0400
X-Gm-Features: AS18NWCCOeq9a31ir_4L1u-B6JF_NwU8mRXwArnTJh3m2jk5qb2qKnXUIZKNSa4
Message-ID: <CAOLa=ZSyXFAE+=ApxscikcmYjtz2-EzrOdORZn3KfiU5Rg_RgA@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtin/repo: add nul format for stats
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000020582b063f79c6e5"

--00000000000020582b063f79c6e5
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> @@ -291,27 +291,31 @@ static void stats_table_print(struct stats_table *table)
>  	strbuf_release(&buf);
>  }
>
> -static void stats_print(struct stats *stats)
> +static void stats_print(struct stats *stats, int nul_delim)
>  {
>

Nit: we can use 'bool' variable types now.

>  	struct strbuf buf = STRBUF_INIT;
> -
> -	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.branches);
> -	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.tags);
> -	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.remotes);
> -	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.others);
> -
> -	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.commits);
> -	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.trees);
> -	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.blobs);
> -	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.tags);
> +	char delim = '\n';
> +
> +	if (nul_delim)
> +		delim = '\0';
> +
> +	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.branches, delim);
> +	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.tags, delim);
> +	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.remotes, delim);
> +	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.others, delim);
> +
> +	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.commits, delim);
> +	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.trees, delim);
> +	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.blobs, delim);
> +	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.tags, delim);
>
>  	fwrite(buf.buf, sizeof(char), buf.len, stdout);
>  	strbuf_release(&buf);

The rest looks good to me! :)

--00000000000020582b063f79c6e5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6518a94006c3d026_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU3Y3WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNktHQy85cThxVElsRXJENVVVYnZ4eE82RWdubDNqRAoxMWNBbm9QY3VN
OGR6aTFvRE1BOGxYNnRvSDJxTDlLSGcydVd5czlYQnNVSXNaRldFMXNuM3RBQVlUUks0dk5zCkJq
ZnpUVlRZOVRTblRYTGRMcmYrNFlVU1h5QUdWNTZtZGNzbDFjK1lDTS9lRWk4a0lUdyt5VVBBalJY
TlVQT08KRkcxNnI3VTRrRWVCaHJrL3RDZjRhTGpSdjBtamRqUVNac20vRDJ6Yjg4RzI3TWs3VUJX
QkF3MWRCaVJrTFRTYQpBdmJHUisrZjBsWnFNdy9iTUJ3d0pIbmN3TWt5Ni81a2ZUUGwxOEVYaXli
MFg5MXRUS1pzN1ZiNmhLRVRiSVVTCmFDallUSkVjT1ZlNVhDUDl3TnJNRkhxS3Z5Q3c1RlBoY3Jv
TnlPejI2cGFsbVFIeXFqQWhURjhhWmFZemJRU00KK3lHc0NnTGdXb0FCbUFqL25qSVdTa0xuZmZT
RzYvYmlLOStJTERKQ0kxaXIvR0FmSjh0ZnY3c3pmblBnR2hGQwpXZzJ6RlQwYWRIb3VyQjdaTGhv
c2JHTE8vTENwV0pOTFhYendGSmdsRnNoRTJXSHhjdk01YzY2cEY0ZDJyMzl3CkxQbHBZNW8wZSs2
WGk3OTFjN2dCK0d3cXJFMVNKSWFGTy9WTWJGTT0KPWYzekoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000020582b063f79c6e5--
