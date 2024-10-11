Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04B212634
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640321; cv=none; b=mBZH4MY+UQCzm2KqMNzWPkAoSUNSlPG24qnQSUgxb6uSyuz53WIc34hI6K/9SGHgrr12xIlgzM00/6iXWiD/GSEgDRFwC2XqxqdzLoMdSZTGNIqEkt0g1cY5yoYKijUFRcaS5aQHpT4E/xoOHA1X70Quem5VA6Z+d68HGfzhiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640321; c=relaxed/simple;
	bh=RtTzBk+8UVZ/pumJD1G9XVLWz6gZ/L31og53ly534R0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGkSCZUTF0eAhLTJnWZa6dSLTN1d0Fpt/EN6vVXs6vDdTUzMaG/BlRLHYiBzmVA+EtgMBz7rR6MbQcmSNLE8QUSxDVrbbPUD38vR1m0U68ba+zsjLEH+Qw6/WwxknS+lveDUtCmhHWY4zi/JR4KuGeOefjTSV1G+IbV2C16tBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAr7090W; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAr7090W"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50a87472832so527181e0c.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728640319; x=1729245119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2KXBYG3H+ODKM+8ucgZXeqSuyK52cgo3ic1kIFeAIbo=;
        b=lAr7090WU9R7pJJLF7bCJzF9ITA7kbiuLu06+BibmSio4NDuODOUBkpR/jMxtMB5YS
         HGoU5KHLVG8hlC8VVzQRTQzzs8IY9z9xQ1jbeEVFpjFGyIFRoTyB9b5KCDH4vaO0OvRU
         7ZIck3nS6uQ383jwgX05r54Beg2bNQWMwCwnjRbZ8ifiGISmVh06iWVCMxoocSsabO3G
         2h4SiL/Z7vhpNONpyg7Z5GX+VESEQmEnBr6jctV+yxPLIrdkcFuUzKGflm1LAyYXWPQS
         UhcGUw8RyAjduTfSQcb4N8fGoVYVeLC0gV/dw1xTTRC5+trJork0ouMYuFNgT5pJmLEs
         oJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640319; x=1729245119;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KXBYG3H+ODKM+8ucgZXeqSuyK52cgo3ic1kIFeAIbo=;
        b=Fv1D6IHF5I3bjeaG05h3gl8avaIrEfHrjhd46UGHng2/bGpA4FIUwQWou/D8mMkFOM
         9jFX8BB8gl1uGX7JRQkHXdJp88GJyTzQhfq1AXwhm3JmOCvkVHAplr41yN9vSg0Nczkl
         QxziIMrAdsN8l/ekoNSvhS0+dvdjZb8IFe9VFxRc6ciRE6ItFMc6Fy5TcGs9Jgyyv92G
         H8SMQxLXABKxL38pHbKGgeQ1lzig0nGLJqXvndSyx0vOspUv24R6OvoZ/klROLbyGxlv
         fyRSbGlZem9KdyYivLT9xlogpWkHEW8F/UBggnvwknWOZHcc50sfsHbKbeZma/1vL6MO
         JaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV6LfubkMNflZstv3N87OFR5iwlC7kJ8T70KIauw/CAk70gcJMkXxs8yzUe/SaDrfDBKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTShfnfkY3J2x0tZrxswsjz62TP0TvEcPV/oFpMyMm42bLdHjK
	4ZZTiVkICuQ/NovqHE+jYz3oozcQg2Les7giHMbQwaWgFX2/FRqgi0Jg+efmkGR84/X02F7wegx
	53F8XXGKO4Ke+XWpSOvNhefvW9nj6bwDp
X-Google-Smtp-Source: AGHT+IH7wNxsuXB+bE/6KL4JtxSshE+PxHMW07M9BV8zkrdPNEDUtjEH2JhfgTcPHDLun+X0nshwlc68oircbiVU91U=
X-Received: by 2002:a05:6122:458e:b0:502:8cca:1313 with SMTP id
 71dfb90a1353d-50d1f5f71bbmr867429e0c.12.1728640318757; Fri, 11 Oct 2024
 02:51:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Oct 2024 02:51:57 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <abc28d7664f151e00568a6a3d18bf8a2de46470d.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im> <abc28d7664f151e00568a6a3d18bf8a2de46470d.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 02:51:57 -0700
Message-ID: <CAOLa=ZTHuWstTD56ZVTecW7ThHhpEqmrL28Emt5DtPL6pYhcpw@mail.gmail.com>
Subject: Re: [PATCH 02/10] reftable: stop using `strbuf_addf()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Content-Type: multipart/mixed; boundary="00000000000025014c062430700b"

--00000000000025014c062430700b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
> index 27ce84445e8..5f59b0ad6ad 100644
> --- a/t/unit-tests/t-reftable-readwrite.c
> +++ b/t/unit-tests/t-reftable-readwrite.c
> @@ -753,12 +753,13 @@ static void t_write_multiple_indices(void)
>  	struct reftable_write_options opts = {
>  		.block_size = 100,
>  	};
> -	struct strbuf writer_buf = STRBUF_INIT, buf = STRBUF_INIT;
> +	struct strbuf writer_buf = STRBUF_INIT;
>  	struct reftable_block_source source = { 0 };
>  	struct reftable_iterator it = { 0 };
>  	const struct reftable_stats *stats;
>  	struct reftable_writer *writer;
>  	struct reftable_reader *reader;
> +	char buf[128];
>  	int err, i;
>
>  	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
> @@ -770,9 +771,8 @@ static void t_write_multiple_indices(void)
>  			.value.val1 = {i},
>  		};
>
> -		strbuf_reset(&buf);

Here, it is okay to remove this, since we define our own buf array.

> -		strbuf_addf(&buf, "refs/heads/%04d", i);
> -		ref.refname = buf.buf,
> +		snprintf(buf, sizeof(buf), "refs/heads/%04d", i);
> +		ref.refname = buf;
>
>  		err = reftable_writer_add_ref(writer, &ref);
>  		check(!err);
> @@ -788,9 +788,8 @@ static void t_write_multiple_indices(void)

[snip]

> @@ -1077,8 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
>  	 * size, we expect that auto-compaction will want to compact all of the
>  	 * tables. Locking any of the tables will keep it from doing so.
>  	 */
> -	strbuf_reset(&buf);

However here it is different, since we still use the strbuf. I guess it
should be okay, since 'buf' is initialized using 'STRBUF_INIT' and that
still keeps the buf.len to 0.

> -	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
> +	strbuf_addstr(&buf, dir);
> +	strbuf_addstr(&buf, "/");
> +	strbuf_addstr(&buf, st->readers[2]->name);
> +	strbuf_addstr(&buf, ".lock");
>  	write_file_buf(buf.buf, "", 0);
>

So when we do 'strbuf_addstr(&buf, ...)' it should allocate the required
memory. But the reset removal did catch my eye.

[snip]

--00000000000025014c062430700b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4f2cfc604978c806_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSTlUd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVJ4Qy85MG5ENXF2N2RtMmJJSVlnSC94TGN6ZTJMbwpDZ3dQZlY5NGFh
angrZUNRZXZqUUMxR0swbUFrZmRJbmpWVThZd0JjSGxMU1JzMm1mUmJJSngxekFoeDA5cXZNCjNj
V1J1bUxVQVpxMmpLZE1rSGF3eW5zb2dPRE5PV3h0ZmxrWW5BaDVYOUZYUU9XZU5aRkJRM3ZSMkdo
bGhKWDgKUXUrWGJJQ3pBNGdHeWZnOEI4amlCZlVzaUlQQk9OK2hueGFXb1oyeE43UHJxMzMrMUxN
U216RVhBWUVYZDVoaQoxckRhZGw3emx0ZndMZmpNUHRkd05uK1NJMjF6Z1l6Si85SXRvYkNXRGhl
SjJpNDlQWnd0dGc3VEhLRGkzMFpVCkJwOHNUeW9ybjAzU1JNY3V5NEo0WnZoN0ZyOUp3bjNiZjlH
M0dJQnVDczl0SnM0Z1JSRmpTN1NYdVlUWlJwTDgKNkRwdGxnSGExL0hyWWpxMDlyQVhoRnVQUWsr
RWNxQWRZTWhkd0NiMkhZT3ZpdzkvdzFzWWtHYkhTVVlNZ0R2NQo0YW1VRldyRmlYSzloTEZTYThH
V01mWVpKTjQwRHJwVHFYV1cvamRkNC9ScERVYTBXVjdTY1F1TU95eUdDY1B0CkpuNlE1RDE3RDFt
OWdJOWRiSWpCOVB3MW52Y3MzTEQzWTlRdCsvVT0KPXR2YVIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000025014c062430700b--
