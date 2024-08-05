Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8615AD9E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862728; cv=none; b=SHZG9NDZV2Qgca+QqK5obioe08SCiZL8pYNOlXjG2IlReogBNw8y+1yBivYKdRI4uAAk9lO7YAmA3fFeHyweSXA6obAzZIPoLyHk6AWoPy6M7uXDTwGjuHW5Avci6puS/ELDYGx3R+ZrPrhqMu0OhcoAtTglGhjW4arRWxtICog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862728; c=relaxed/simple;
	bh=vByBFeRPhTTtGOfx4I7BUg2qnemXdbdBz7Ln5U8Re9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrsOe4xttUZNz9dix5EnDSi7vlG/B5S1UdmHZ0bp/QVcJwq1lLsXxHp1Ty90/eda82O8K+rAwHyJ07gDRT1wwqn0yyTl6YkrKB4iBfJeUV1rclDvGTgkK43SIFseZRF7bm/Q8DURzCgp0TljEkCFg5Qq2ybsuKcDAaq5WtwxR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=erA1NYhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XH2g2v/g; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="erA1NYhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XH2g2v/g"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 003FA138FC86;
	Mon,  5 Aug 2024 08:58:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862725; x=1722949125; bh=iD3I/qzogt
	sS0oNda8r9k5cfIw//kvheR8ryPy2Dknc=; b=erA1NYhxkdOQWghjBWwxCBMTpf
	O1H8GKOV8n7b1BKK6698/lVAwQ4s6pjm0FP+gqeCIYdcjJHxAyFgd1Alh2b5xP8i
	3D7cJ7+Vb5e9AFURf8jd29UY9PKWn4Be2XXmM9Ilr4wFbesV3fGmzBD3Ei1BbxG7
	v5X2WlebzBZ4k0325aO7X2tg0VpxIUINuFYA10CCtbgJeUoYPvGbFxjzeaVIsVCl
	v1IN3r5kLuTydu0lftcWUlHYMYL7/NhsllPTKEjI1I5yk4/NFSanLGfaG/EW272p
	oWqUsEW8cERgxM63hECnBWFETNaqzWtDPealsTHmia5t30n5l94PYPYrkwxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862725; x=1722949125; bh=iD3I/qzogtsS0oNda8r9k5cfIw//
	kvheR8ryPy2Dknc=; b=XH2g2v/g80kgEeVfInVM0o+XVpU1hVZpr8BRmHNihIy8
	/2rNyCUpsREQRgy9/5GTTgRHkmHWIty53CxQAeVM28l58Ij63H64UfFEZ2E7SOIZ
	7RVzBPIBXoK7sKFNGhI/gETSHvkLTOxgTfGXZJVVUXaMR/YluzyMXfN/E4043Eqa
	TQmhlqB1+WefCEUrsuEUMDlfz4NqXmX/OZyMsTQlOi/lEJy1067HVXgA73jImrqo
	tv3HEtkrSPa4jufCGVqZPdoWY01cTJIgkcG1aqCd8PHCXxxFbohJDGc1p8JqjZ9/
	ExcBKBGmYFfUK7FTUqhZrDHwzdqfNFUsV7IdIQVMdg==
X-ME-Sender: <xms:hcywZj6ustpqUoRMDs_eyn3iFq21f-m6TxVe7Iv0EtGdmt6KDUkyyg>
    <xme:hcywZo4AvlNKV6v_3IjsyXgryeiINz7oAQJL7SrxX3DOflMgllJSJVOQweRxV2QW-
    URP0h-w2iFU_wQWjQ>
X-ME-Received: <xmr:hcywZqcorvoqpRTpvXadtqE4OKf0_k2Y-p9Z_D6Jl8LuU0s-_mEuU1FtTO_w28U6pRNM7d5m7bLs-HsM8Bu8rwMMT4FQsWfKSWBjjS3opzdzBBZySw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:hcywZkLFhMXWkMt8gsXkZt0bUt7cqzOj5cXC36JdZvFpHjY9y-NIVQ>
    <xmx:hcywZnIN3bOI74U64SwWkA7GDoIiqY_6qRdbJJSCJ0AuoJ-x0J9dDA>
    <xmx:hcywZtzBMfHk_WQNcf2KhKTPRl2HVRsC0PXuiFMRKO4V5yPlJ5pOkg>
    <xmx:hcywZjLEyFdnufGYRY7E58DO_xXafU6amui-aeXOjgjvTe3SM0P9SA>
    <xmx:hcywZv8eQMwJSfT98MBM7wg6boacuRd-nWXwO2JJOnoEwx_nUTtDbt1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6474bb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:43 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 11/11] fsck: add ref name check for files
 backend
Message-ID: <ZrDMghZ3Vsuor-rO@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumjDzfeaLZQgr5@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A1Wwc+mMQ7AkF+ZP"
Content-Disposition: inline
In-Reply-To: <ZqumjDzfeaLZQgr5@ArchLinux>


--A1Wwc+mMQ7AkF+ZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:15:24PM +0800, shejialuo wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5574e78656..1186b6cbb1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3419,6 +3419,37 @@ typedef int (*files_fsck_refs_fn)(struct fsck_opti=
ons *o,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
> =20
> +static int files_fsck_refs_name(struct fsck_options *o,
> +				const char *gitdir UNUSED,
> +				const char *refs_check_dir,
> +				struct dir_iterator *iter)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	size_t len =3D 0;
> +	int ret =3D 0;
> +
> +	/*
> +	 * Ignore the files ending with ".lock" as they may be lock files
> +	 * However, do not allow bare ".lock" files.
> +	 */
> +	if (strip_suffix(iter->basename, ".lock", &len) && (len !=3D 0))
> +		goto clean;

Better:

    if (ends_with(iter->basename, ".lock))
            goto cleanup;

Patrick

--A1Wwc+mMQ7AkF+ZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzIEACgkQVbJhu7ck
PpQv+xAAlwFMJj2tT4UqCHPGRhIoDrtzE+HL66XJ6PjXA5BAuBv2PljWUrk9I27J
r5S4tcMD8OwFqjkgeT0tcfI+xJCj4bAaeZM1uYi/sg4U/cLLMHW8/oYeNU3iHXgA
FMyYIsXAtJc2I+T1tQ5ii/+W9GVyl5omjK6+005AXs0JA6F+SAs7RI3ubVVMzglb
RpqOKPAptbhSTvV4zvoPGIkB8jYptyVjAqvcELk8IVa/q79N4nHRGWCeV0JSEPtJ
KRQXwt4oH6yj+3+3+yrIH8JHEyK7ddg08oqQDrCQYL2nmBUfWRteXpVEqFzV40Bq
Sqb20VZwAgsRmz58aA42mBmEy/iBPX4uKUgAEusRU16DJUIbqVC06S3pkOabkg/s
rBUUysfbktQ4sp0Hnaix9EMsnxZwdV+JITNywdltcIOq7tC5gasbl/boRW3FJtEY
kVhwGHlMdmlUfFSgKQZipCWSLTxxGbN2+i5LixABSer11nx2cTom9rYAE8VoC6eP
Q7MJshxRFYb5vJnVAnHuh5FtTGaNREJbc7FrPMdmwBsuFWsMhr6U1geqG50LUqyk
EY1ENysRA9s/yxlWpEfCvxDhgBFAB9F5nEWt9FwyUirgOxdqtmbduB+Do1vftVg9
ubXHwqZFAkesd9y+2RTXEXuzsn7vjnpTHxkL1yjZmXWuz5OTd4M=
=v2mP
-----END PGP SIGNATURE-----

--A1Wwc+mMQ7AkF+ZP--
