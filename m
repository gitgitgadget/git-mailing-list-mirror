Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C31598F4
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862694; cv=none; b=hVbvBxnnURuIaGCpV4+OiZE2jg23Kj/c9ZuBhypOGGBAXlLr92f+7R4lYmU7zWEItePTzUB5g5mQCoA5AFGCXSv7WsEAXo1OQBy/UbSsMrUe+E/wC8hOua1KZikGKPvkIz6RHiVcJ1lv2ExxgRqcEjstVoPbvVewg36Y6/uwC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862694; c=relaxed/simple;
	bh=Vo3XyU6ML/sVp4TCBEOCx5WgfBqLkqo/dbP3uEUGkTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNqNRc122QwMbZEsUEm1usVf+oiosyz7P48+Q+atjdG0s6KpNAQHoBb622VPL+CUhcT13TL09swwcqEfUWNoH1XVQVHaGl77wEHmbPNX/OphFa6OHVLDzSx1SupPh6Cu8vl1zEU/v6kf/g9Q5WAaWYlAdMUV2n6WrqxY5K3BLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cV7vBhlM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zbb3btrB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cV7vBhlM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zbb3btrB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A6AEE138FCC7;
	Mon,  5 Aug 2024 08:58:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 08:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862691; x=1722949091; bh=hdFQ7f9ADv
	Q3XthfZgQOslC03+Pf7Ux0RTWw6IhEe3o=; b=cV7vBhlM5JBCvR63fdDJJ+/iP3
	teV650Gv5kcH/qvqyaXVgP3NlCfd+vhaBdVN0gJ3+ekCPWqp+V//4x5niqoSn6DT
	0fH4s5qVewmzyIcwSdiNmx1jnvLjawn/m8Q9kuf54LEWDRcYGde0EIIE4mKVPAT/
	eapRmuSFTtc/vo2a2pdtqd9GwvGS+u0iLfIsKj+Kls1NxrxnkFRRi/O7bCh3RReB
	+JH8VoZaTqdT3E/rViPp3ylG9Z9TOOV6tKDEtZ7degZLvd+PMG0CPoc8znbKHGGj
	Y8p1Ux1wx0PuhDhPQZ17+m1ehXb8uxceTG022ailxZIYQNaYFIVfo4SHqAsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862691; x=1722949091; bh=hdFQ7f9ADvQ3XthfZgQOslC03+Pf
	7Ux0RTWw6IhEe3o=; b=Zbb3btrBZ9F0fV9zH93rrSM2Y1+LTzVSsHP22+rVnH6P
	J28oOAb3tqLqckYXh1StjBbIl0ukz16ESqNGom0fb6QvFDdQua/8W1/fN1SfUoAr
	kDFV7zQ6kaYBN5Ft4QQj25+8WDHQ8venYZzkekvbp9O7iDo3+44DyO0ZPiadCx/j
	ugkHQgHy52VbcuQC5gKgJ6B7bWi9nIemCe9bckw8rnbBWb7V2p+j8ayHAoyFRZWp
	21HKs3VV1spkcaIEPm6ySmLd4PANeGRGGtPChuNz+G6Rm+24qowPTRvsoYvZeAqs
	uQG0E4mRhjbRlC3UCPbrmq/ZlRr6GtkCjE9mM5XALg==
X-ME-Sender: <xms:Y8ywZlagh1MZ5QCkH5DP9FL9NpHD4uY5eSqh1jQ5qF4Rv1XU1eIHKQ>
    <xme:Y8ywZsakChYACyYk8xIOJeJ_8wwQB3GZOa8XgVKKXIQyM1ACaXOPb0zl3t6Qsd7WY
    YyZVXF7bHLeqZInDQ>
X-ME-Received: <xmr:Y8ywZn9keoSAY4r60hzZo6LIpMr5S4OKFe5K_JjvUXcUghtgTwh9gEIxmnHZQlZma8TAFbj4oCCpQWypZ4EqlnKr8BrP2cyCV7K63fTGq_PFYK877g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Y8ywZjpQXmpXTR1GjNe5BDjycyREj5ONGOXuVJH6YNGDYPpmYgtcSQ>
    <xmx:Y8ywZgoJ-IOy1t8rbcs9xjAN0-LY4LuMpSkRETsPklpt7KyDUSMrhA>
    <xmx:Y8ywZpRx2YqPm1mDWCsaEvYEKynyJ1H4jN_QnoLrRBhLhCZEmXvBng>
    <xmx:Y8ywZorlrfku1MZ2c4x-rzagd22lHgyhXB3U0aNhIXz9TUtZ-wWjdg>
    <xmx:Y8ywZhfHFddUJXQ9F1cCEK96g27qk9B-FU1qbT4tcliBhaJkaIJlRFu0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ed425c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:08 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 03/11] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <ZrDMXgEuE8yeSzkw@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumN5cfsQYHlU5X@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J/A+VuQOi1XK0U+b"
Content-Disposition: inline
In-Reply-To: <ZqumN5cfsQYHlU5X@ArchLinux>


--J/A+VuQOi1XK0U+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:13:59PM +0800, shejialuo wrote:
> @@ -254,9 +251,9 @@ static int report(struct fsck_options *options,
>  	prepare_msg_ids();
>  	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
> =20
> -	va_start(ap, fmt);
> -	strbuf_vaddf(&sb, fmt, ap);
> -	result =3D options->error_func(options, &report,
> +	va_copy(ap_copy, ap);

Can't we use `ap` directly instead of copying it? We'd have to get rid
of the call to `va_end` as our caller already does that, but other than
that I don't see any reason to copy the argument list here.

> +	strbuf_vaddf(&sb, fmt, ap_copy);
> +	result =3D options->error_func(options, fsck_report,
>  				     msg_type, msg_id, sb.buf);
>  	strbuf_release(&sb);
>  	va_end(ap);

Patrick

--J/A+VuQOi1XK0U+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzF0ACgkQVbJhu7ck
PpRCJA//TTfPvpcJhG5Qf2YIPlHbtEEqBp19PSauuv+/mugomAJDBrA1PZebxQ9y
f/OENAABw3LtzLhjNeWpaFUFAieQgi9SANIb7xPjxWd+Gs7HHycWOpPFPiRjcCDc
dN1PHMMjfbv/iVWK1mZ4IatYUR7zwx1le/5B9u9oxcT1GShIpdg9Zwd2mNF1xlBs
gV/KqG6iEYdrqOfWg8fByGXN6+rXJ++9qYUqTL0Ga+RyO9YiTz08eWma4qUmsZEE
F76q4yI4x4H5MYWyvX/hHTp1fhm37uK7FZrV9wSQM5J5f3IV4sartnpta2ZUqgSS
+9I3PNTKIqEDuI/a24v6GuIqujtGQwG2XTHm9jeiwaxa3sJAxVwk/WJFCKaUWmR5
Ji3iTanyItMtAtm3+ii4UrmHuwur4KPSAGUzqpm9s3abuxLWil6ix+SCzwBXibiT
yF2iK94VGKbL/lDD5pfi4J+i1kdbH8aqtOycSmQ6aG+S6ROshXiUhLMXFePB/vuT
KkBVq/5zyLX3R9AO2flCV/bfJMGkXmVrskzXKPWKJu0Ab/NmXOkEieD8Gzvk/scc
qqYE+rs8goV6XABV1RGVrx69FODVTY9EXq6sS+Par4+hotXsZkDxlnIjdqwF7zgG
Y5rAHGJSqWLCintO0MdhpAxufUTNGkdE7q6o7CHxtFUnuIVhrfs=
=9EQA
-----END PGP SIGNATURE-----

--J/A+VuQOi1XK0U+b--
