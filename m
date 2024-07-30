Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63E195B3B
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328289; cv=none; b=I9STWswfKDLPyLxj9ULd6Nd9FZbqdWkBX0kEISm5glMpEHBP3Q/19B3U0Ln9sFgY8+A+mPBNDe/c9zxIwBA9aua0gb/sLJ5BUhRjuJqYehnwztAPEY7LX+mzMDlWNHlm0T7DSgzZL1gWPMGyQX9or9H0GAVCnyag2cYjrCOTQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328289; c=relaxed/simple;
	bh=NHZUvvR6UJMWFwePBTQLnfFTGOLueCmV1fU6NeGk98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSlXe7OfV1rdJf4ZmPpujuUBZwyXXxkSsEmYLBWtrnqKTk+CLSiEW2MnhYtLY9XQZ0djqkOXVs1KmfedldRA5CNTelfcSRIPKyPiFw+u6n3nD4yMVuu+mAjyQEV2bJHN/y20Igi/5fKZUFbX88ge8pK12heBVFLCdETcjE6SM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VKIrGdUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9A7tq7G; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VKIrGdUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9A7tq7G"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9FFDF138076C;
	Tue, 30 Jul 2024 04:31:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 04:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328284; x=1722414684; bh=HVtq4JHy1J
	XB8KXz1sCiSnAWtRtNUCwpzuS3viT8FVM=; b=VKIrGdUMbfi5o/ecabpOHuiMUa
	aQ2p6NGk6z07E1Bzlcb/n/BaSpcKxYduiilylF/q8RCRKINNB2PR3OlFFZ1MtMdg
	Mx++q+atCW1yVpA9iHsiTB+1uTsDJnQ+v6HF8G6ht7fLzJWLHGBLnws23vNYrL7T
	PAVzs+q5xKOtNWTsQS5VGJT/rZnx3rTV/X6kdZpeGZSKASKN1N6CWJ+dh/XySYYx
	CdOa10b6cKzJnb5qwLDOQA1WRKC51pkl/bvfiVnKEzUshFqrNfljNSZDmr33JekJ
	WfzXpgN7+5WuvZqcVCix3CYiXY7KNqDZ+GA7+579VjsjkrLimj52BsxOYChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328284; x=1722414684; bh=HVtq4JHy1JXB8KXz1sCiSnAWtRtN
	UCwpzuS3viT8FVM=; b=M9A7tq7GQw1cOZuiWMNmvIpI6yNyBMpgYH5Tc6LsFYgl
	LS9YNMhanTN9crnut+Xx2ngo5yvXilW5kHnnfBvKr/w2VcGgFVG3Gaux6xp9+nBk
	iOfIJubIkFu+4xWDN7G+YuVTAoUSjIqSdneiFFQTQmcn0NWnvVzRvRaMKWY82kGV
	1jQ9/03zORnrXwEegu0vBuygebmx0rq9VuKcYoJh9Pma7YrJbfxpbKcsEBGrnOcR
	30ENVl7LavLQ3ncCd1f43MgAF4JuzdGRXP4sh/ayByIXLm3k1ETZRlA8gOhxydLz
	J7EPeMI22AfvHl4PZqKE5dyk01CBfulCIvNLDmMWIw==
X-ME-Sender: <xms:3KSoZuZT3VJjacTWF461MTcGi-tqJyuO47mpVtZ3dzzkJrY-F3UQKw>
    <xme:3KSoZhZ5mzVOqGBdukIJmV-gDmbLAJ-atLyCAPnvOtKWSAeKz-rsDBZncj5UkL6P_
    pQX3XfdTJOkC_bxZw>
X-ME-Received: <xmr:3KSoZo-qpC0TaufWFVf3FqVeI3Rm0WFlLOOK-v-sbH2uKa2gUkw0-ig_fq5zbsC25gnC9fluMw_aqqvwB4nRBBqMemTp5MKu4UgJ86Mgqyn6pas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:3KSoZgqFEOPCqeFM1DeNJUcBhBYM5Dzb0lD2v0e9SwSJGUH21zDDGQ>
    <xmx:3KSoZpplCxPQ8mujaeGQvdDH8toBjY72e__tNn6DHnd9phBkef7FCA>
    <xmx:3KSoZuQ6ARCNExO7vIM28Y54BWkaZ4PawO-g8_sdK5nFz3GTZQFLag>
    <xmx:3KSoZpp8PGCcJzinRgsbxUYhQcqoz5dZqfTU3NpcvqReyct4KIr0EA>
    <xmx:3KSoZqd-f7TnXkB1GIg8-A8ozrtg_mEwyiWY4dkiO8aPe26Szyxx3sRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fa041f50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:29:51 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 02/10] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <Zqik1JFs-RYCwNnz@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYhkaArVmMdrnK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTv1En+HUoefivR2"
Content-Disposition: inline
In-Reply-To: <ZqeYhkaArVmMdrnK@ArchLinux>


--hTv1En+HUoefivR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:26:30PM +0800, shejialuo wrote:
> The static function "report" provided by "fsck.c" aims at checking fsck
> error type and calling the callback "error_func" to report the message.
> However, "report" function is only related to object database which
> cannot be reused for refs.

Nit: it would be nice to mention _why_ it cannot be reused for refs.

> diff --git a/fsck.c b/fsck.c
> index 3f32441492..1185e9a8ad 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -226,12 +226,18 @@ static int object_on_skiplist(struct fsck_options *=
opts,
>  	return opts && oid && oidset_contains(&opts->skip_oids, oid);
>  }
> =20
> -__attribute__((format (printf, 5, 6)))
> -static int report(struct fsck_options *options,
> -		  const struct object_id *oid, enum object_type object_type,
> -		  enum fsck_msg_id msg_id, const char *fmt, ...)
> +/*
> + * Provide a unified interface for either fscking refs or objects.
> + * It will get the current msg error type and call the error_func callba=
ck
> + * which is registered in the "fsck_options" struct.
> + */
> +static int fsck_vreport(struct fsck_options *options,
> +			const struct object_id *oid,
> +			enum object_type object_type,
> +			const struct fsck_refs_info *refs_info,
> +			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
>  {
> -	va_list ap;
> +	va_list ap_copy;
>  	struct strbuf sb =3D STRBUF_INIT;
>  	enum fsck_msg_type msg_type =3D fsck_msg_type(msg_id, options);
>  	int result;

It is a bit weird that this new generic function receives non-generic
inputs which are specific to the respective subsystems (objects or refs)
that we are checking.

A better design would likely be to make `error_func()` receive a void
pointer such that `error_func()` and then have the respective subsystems
provide a function that knows to format the message while receiving
either a `struct fsck_object_report *` or a `struct fsck_ref_report *`.

I don't think this is particularly worriesome though as it is still
manageable right now. So I'm fine if we want to leave this as-is, and
then we can iterate on this in a future patch series as required.

> @@ -250,9 +256,9 @@ static int report(struct fsck_options *options,
>  	prepare_msg_ids();
>  	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
> =20
> -	va_start(ap, fmt);
> -	strbuf_vaddf(&sb, fmt, ap);
> -	result =3D options->error_func(options, oid, object_type,
> +	va_copy(ap_copy, ap);
> +	strbuf_vaddf(&sb, fmt, ap_copy);
> +	result =3D options->error_func(options, oid, object_type, refs_info,
>  				     msg_type, msg_id, sb.buf);
>  	strbuf_release(&sb);
>  	va_end(ap);
> @@ -260,6 +266,35 @@ static int report(struct fsck_options *options,
>  	return result;
>  }
> =20
> +__attribute__((format (printf, 5, 6)))
> +static int report(struct fsck_options *options,
> +		  const struct object_id *oid, enum object_type object_type,
> +		  enum fsck_msg_id msg_id, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int result;
> +
> +	va_start(ap, fmt);
> +	result =3D fsck_vreport(options, oid, object_type, NULL, msg_id, fmt, a=
p);
> +	va_end(ap);
> +
> +	return result;
> +}

As far as I can see, `report()` is now specific to reporting errors with
objects while `fsck_vreport()` is the generic part. Do we want to rename
the function to `fsck_report_object()` to clarify, or would that cause
too much churn?

Hm. Seeing that we have 62 callsites of that function it may be too much
churn indeed.

> +int fsck_refs_report(struct fsck_options *options,
> +		     const struct object_id *oid,
> +		     const struct fsck_refs_info *refs_info,
> +		     enum fsck_msg_id msg_id, const char *fmt, ...)

Would `fsck_report_ref()` be a better name?

What is the intent of the `oid` field? Would it be set to the object ID
that a reference points to? What if the reference is a non-resolving
symbolic reference? I wonder whether we can just remove it.

Patrick

--hTv1En+HUoefivR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopNMACgkQVbJhu7ck
PpQISA//bgfIMkr3iWdNpAz3vi804S9Ypt4xzJCUMjOxM06rMzq4cIhTWAY0dCsR
FUvlhmRCROL7A4QagdI61scTRI6FortpIbhzoZE1CL1FNxfY6304udvnFzRuDuhD
j+uv4idkkSXYA69qxDTGF/YtK4CXxGuxYYZaxz8AfklgzjaxpuSPy9lEDWh2RvbQ
LoSeyDFOQgoE7TqmhDzbG2spMoEgdYTOoVwDN3pE49FD96wXbNUTmfhIMzUWQ21K
DiyYDRvwyWZ0jMfzEp5YM1E03TqAnuMdRF3nZ2xI5vh3eZ7O1tirYSaid3YZoptH
H5mkboWk/iuzftdzH1hoHkzWh2mcwVxWM/u+bpLJkV5IVYDqwkMJY6V7QkQfF0pw
3UPGaP5wyxNaCVpiLyE+rXAQwU+JUaABMH+UKCfw0KBJUu0LMmAynrxLSNfFhUCc
/tAYiAmDJ9WwuonNW9HdqLKNsS9fImrtKztaSj9nTZ1qRKULIyb7TgLopiamTrDW
oPjYPSaXIj1MJa4ZiUJMdklg2G6DrAMbNlDVSRYoLFF2Fvpi4+gKrTZKljMcR/m/
hoa55CXDDpPxrVvo3hnnrGGRxUnRaqTZGiCGeFJ1hlHr5wueY4jHadG/NdQgSYvZ
/2sH79yxLBpiVP2GSu6o+BMt5yx4jtgX2aQx6JPmiZa71KVZ/x0=
=9Z7I
-----END PGP SIGNATURE-----

--hTv1En+HUoefivR2--
