Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF633FD
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268827; cv=none; b=I/yEyrBVIt4/BGzPehvLqfkQ82S700QlUYO//DZ5nP1EOGTwr7M1/JKArqWqzlVoouVYhHU6rrs6umZ2VhqrVAGMOleuqGwlskj4d/V5PnWwDtA/J/ZbPcQokq1iHr7URaRxZ6vpIBzwm1eHTEG+tLEhu9r5RhIKMRDOI3JZmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268827; c=relaxed/simple;
	bh=StGinMK/1ZhrKThtuAkV9ljbqseUhg/+eks3n3M2q6o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4z5DR0SqEe8vUhDglAw4ZObO+xAcGMgZ2woc8yLirhPYKZjnN3jpuopdBd7h6qgA2qNAb4gFgXZTRq12dEGheXlleWd3oftuBCZZK2oAEEQRYZ7doF9aS7ACcCp+f0zqxbCMkMaH8Etbbp64ThLMXekFa+wtyujtWosy3Dmc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6WrjRoj; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6WrjRoj"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523bf140eccso810937e0c.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741268824; x=1741873624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1QoaDzc2M15SqDP2JrF/Z6PthUjzz5T0K0+bAOAmdo=;
        b=M6WrjRoj+261UqGVRB6ysKm3WMr/W50P1xcDvrUCn8gU5LY6PI9sjcfF+3uT/6Mu+A
         rJdg4VbvypIC/oeC4JKmXfcrjjZ699F6Fa8OvDTNrPTmfcKsb8Wrtqq3iTXGzhZtX0eO
         Nu0KOhKAWXUq5LoNyr+W3Fa5DJxCj+CMmKT5szKzF67LkgC1Nm8UaMj1Bckde+q092T7
         H1cfwS8V7sVEt2+T7qm9jWOzi3Rch/IvAF6Cl0jRPb4u142pT8ptG5DU/W8fK+F15bm0
         JhxZDxaAGxf5wBC7WJZxUobQJz5N/5G0A/WgsQf44LRsZOLXm//QYTAXOWnhZsl1TqrP
         uuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741268824; x=1741873624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1QoaDzc2M15SqDP2JrF/Z6PthUjzz5T0K0+bAOAmdo=;
        b=fTaZ7Sp/2FxkEXTsoiQce8w1KELTAxM9ZJKBMA52P13NQv8M8DLlRaUjnJj67H5YLP
         +bTmxO43yeavSzuqnyyfZjZEfurZibwDXvFhJvXD8nrBAAsTH7B1ww/Upf4ENje2/Om/
         3m/Crt1eaTdp8wJw1wiDTUlQtP40Mih1boNCnI8RH+vp4GlNDUO+7ejCQTypwn4i2lPb
         deBNJFtrm6dMBTrCorqwS3Rro30tguE/6ggvmMvFsdnvXI/srfH4qrwOrnAjtvnC9TLZ
         Sd/DclmYxPy7HNOG+7L0+ad8/NiuKAxpMibYtchFz6HCVGBUfSuVn7B0G+9zHQRqKMsz
         oJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1k7srGb3OIrYimUMnegPWCi86P/r6MUHm8FelPSFxigu+41t7Z4mfgIrL6hVV3JgAoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAg7+yyoms0p/hKOvmWjv/4cHGB0YVsgFEATrKxwCYWUkbUnpa
	eAow5dMWF9EAMspjc+R5ZUUthogJs7TIlaJZ1cW28dIjzv2TNTtFZvSpe5uLMsrn7410RO/Qb4K
	mntK2VEm5OiaPjUbQUx3TcMNTsyrEqkdD
X-Gm-Gg: ASbGncvQN2CpwCK4EPZdNhQp1EAv6hi40tFqFMwqMMilU8DzirZxgXF86ZJkZD3nk+M
	SJDEQMow7BSzIaG2ZSD8DXu98NJaHNse1AaQmatfkD0BcUR1U/dh119C9YGZQtpz6Ow2auArhQC
	bPQ4SXzcVEwi+c8Nr2sPFfMNtP
X-Google-Smtp-Source: AGHT+IHwHtacc+C4XGO/qF/oQcI8NGbIkI9BFGJ9CK5KBgqwiDQJiRLsr2DHO7kbSQwk1yK2XVFWmbDQSxMUiAtYIT4=
X-Received: by 2002:a05:6122:390e:b0:523:a78a:5b3f with SMTP id
 71dfb90a1353d-523d50a3036mr1832877e0c.6.1741268824450; Thu, 06 Mar 2025
 05:47:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 07:47:03 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-4-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im> <20250228-pks-update-ref-optimization-v4-4-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 07:47:03 -0600
X-Gm-Features: AQ5f1JrHWM8OoXiiYrpmDbNtRZd4WiphnP6us6yPLlbdsq3o1KsK8HEJX0aD8VA
Message-ID: <CAOLa=ZTUb28f6Dr=cinGZN3XdwNr5bdeqZ_fruwj3YrY2tsO7A@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] refs: introduce function to batch refname
 availability checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000be993c062facbd7e"

--000000000000be993c062facbd7e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs.h b/refs.h
> index a0cdd99250e..185aed5a461 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -124,6 +124,18 @@ int refs_verify_refname_available(struct ref_store *refs,
>  				  unsigned int initial_transaction,
>  				  struct strbuf *err);
>
> +/*
> + * Same as `refs_verify_refname_available()`, but checking for a list of
> + * refnames instead of only a single item. This is more efficient in the case
> + * where one needs to check multiple refnames.
> + */
> +int refs_verify_refnames_available(struct ref_store *refs,
> +				   const struct string_list *refnames,
> +				   const struct string_list *extras,
> +				   const struct string_list *skip,
> +				   unsigned int initial_transaction,
> +				   struct strbuf *err);
> +
>  int refs_ref_exists(struct ref_store *refs, const char *refname);
>
>  int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,

FYI: In my patch-series to add partial transaction support (based on top
of this series), I move this function to 'refs-internal.h', because I
also pass in the transaction to it.

The patch looks good!

--000000000000be993c062facbd7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2aefc41c20c2baa5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnAxQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMU9QQy80M2VvS0JFais2VVJBdFMwZWpva2IyY0UxbQpYV0F1LzFNWmht
NWJHcHBHM1orQUZiUTVEakQveVl6TnhVaHE4YTVxcDdmcWYzU21DYkN5UFRqZm9uS0ZRS3M2Cnhs
QkVEcUNSRlB5cFRuL2c2YjB5Mm5VZUlQRXYxZFlFa1FOQnQ0T2IxTWdRaTFzQjZ5eWQzYy9JZENp
Y0MwOE4KWmk0YXQ5N3RaK1ZqaXRDUWJDSjdPOG5EWjhkNkY0TjBkWGFJUDRmS2lDanRnYkdmaEVR
dXY0STZZdnlTY29nZApiR05tUGs1cDJncW1wSTFxejZ2NHUrdzVxRVAxbEJpRFg5N2dIOWpTd0lR
RDdZUWpKSklSRThTN1l1VHZNRCtnCjR3dFJzVG5MRStoTHExa2oxRE5yc1lQQWRYM0dwbVFXZHFy
RXVJN29LUGowelNKVy9FcTR2Tk9UdTdWbHpuczkKTmFEcndnMnJIczFQbjF3NVh6KytqN2FVN0dk
eWFWTDcvY0Fwa09XY0h1N3dhci85TVVTYzJTUlErMlFmWVZydwpmUXpiVGFKdXNrVlNNcE9kd3JC
d3Z2dHppZTBGNk9pM25sR1J1eUZYd0hJdXcrMWw0N2tyWEJpc0RCYkExTkR3Cml0Kzh6Wm1CaGpM
bzdTSEZ6RVM4b1RZRUc1V0N2bW0yNHpjRXVFQT0KPTFxdi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000be993c062facbd7e--
