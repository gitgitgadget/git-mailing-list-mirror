Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AA6996E
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058470; cv=none; b=FG4UhLM7tVj8GuMxiPKj/gjGlEesvU+Fh7VaFAgO2kRHeqVgBZskZhUxUqjbyUOtUN6wC/3rUWKUskqvXaJqzhXVRc+08JK+P4rBku3Z673YJe+ssjz4Q8U0BEdiansDdbYPL/CfKdIhmfVzp79uPXFwz4OgHMBKuG4vy14zO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058470; c=relaxed/simple;
	bh=rrqgaax6pR1Acek3Ee0rcKK5Vo8v766j60HYo1tWBpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy/RwcOAHXn6YsGdsEWWjGpVCj9HrdqhLxt/BYJnSAMDTiDTFs13PL3mHeEz9QzGHrLwBlZnkGf2XrbObKMtWUqAgJApLFaxHWuFnq5xBcmXuvY1w6kyhfQIc+C1anLHbmOhDv4c3don0W7yYjX3zKnpREj0Y5QUWdJnb2Yh4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TH5EWuhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1n9Akms; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TH5EWuhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1n9Akms"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 6654D1C000DC;
	Tue,  2 Apr 2024 07:47:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 07:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712058466; x=1712144866; bh=sy/wH9TpA5
	OOJfJJ7BdYOdHiloGxL7xGZIKcy9bc+pg=; b=TH5EWuhKm1Doi1CAu8+gHkXRap
	jvxPMQv2y1S9Qda6q5p+VLZiCZQezy6xiwnv6qTwwwFxxOhg1Gda9vg8HdhXxFsB
	PkU2JfuYvnF0rMZE4+I8hhHtfsp1XbVMEoYJuRbFouqKtruo5BK3ulJRFl7RVr65
	PUgE0N5cAx6pTqmfC1gz7L+gurV2FQdQv5Cdrt1AooM+iM9imtKwX5RLa9Lbc46N
	qVX+iHCqxMcqTrRqJUQ5733RAL5YDcvQm5LJIYkhWjeX5cmxYfdfDslKwDWuYA1I
	1NLe2ZoiaO4gwQEvtcEcpQXWeJJJd1fFPtTRBVbIT6I55uaRtvfILchmF54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712058466; x=1712144866; bh=sy/wH9TpA5OOJfJJ7BdYOdHiloGx
	L7xGZIKcy9bc+pg=; b=A1n9AkmsPEQOMwzakJ+eIj8rVp3J4nSnewqIU9NHUpil
	+v1AZs/PBw8ZIXFE386hlrsVs+wN2XSk4ZjRjA3KWhrpkC9d2S/Ji3L1E2XthVU0
	43rfj23jShmaI5K428i/vxbzbRALK1U6dkP49XisnJiXONhQJJr91ABOybvXSKC2
	x23gC4i49MxcBlrYM2q7a6FI54vQGlqiwx3n9PsMCIVIDkmTR9aQir4AeV1tsHxZ
	sCM9xDUWGCsYrR4f3EtLehZrJnNkFNaIbmWh72TqpJJXZsT0gXwXduOVjg/ZA4el
	fmb7mf6b0npWVbE4TbyqO4JYU5Ho2MLtl10SlFGflg==
X-ME-Sender: <xms:YvALZojqFAtzbHCCxbx1epjHhWtkvFgqrDdU6awRVBIPSluM_Qc23w>
    <xme:YvALZhAo9O_OiEeRhlcg72oI3BtD9w7fhHQ74tLo84ZUiuC7QYz2ci_5bwH8rnhSJ
    Zmxx4102NSl7rpILg>
X-ME-Received: <xmr:YvALZgHHE00mVgk-Fay_G-u1Ccy_bAWWeqHsKSMdDGo47O1_zF-Ar1hZNMO-0kSTlVnmgFhUPvC86PyjTBs_bffiTGRvXcuLzyeyWj6gKJUh4zU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:YvALZpQNBi6zzpfrH0dP_IxGMCjMgQdeFaByq3aTTW3RpOO-wlhfRQ>
    <xmx:YvALZlyEeiFxc86aCRT_w3k5Grn8YdNxGShk3b8Pi4AFzgYStpdTZw>
    <xmx:YvALZn6fy6EarURHw6qRhVz76B4u7lvehDD9_HcMnwu3ASwV8MT3tg>
    <xmx:YvALZiyuw5MpCL4JikhTO-oZ4a0hkMN0xSMKd_YB6H3L73se2fg4jQ>
    <xmx:YvALZskBMuvk-naae67zZBbgLVxFS4N4Xvw_Z_nuXviVKTupEQXia-1D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 07:47:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e7cb8ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 11:47:37 +0000 (UTC)
Date: Tue, 2 Apr 2024 13:47:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 4/4] midx-write.c: use `--stdin-packs` when repacking
Message-ID: <ZgvwXyMMUKxfP9ni@tanuki>
References: <cover.1711387439.git.me@ttaylorr.com>
 <cover.1712006190.git.me@ttaylorr.com>
 <b5d6ba5802aef6ddf1542f1b0efffe43c22436ba.1712006190.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aAnk95TjBobe53D7"
Content-Disposition: inline
In-Reply-To: <b5d6ba5802aef6ddf1542f1b0efffe43c22436ba.1712006190.git.me@ttaylorr.com>


--aAnk95TjBobe53D7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 05:16:44PM -0400, Taylor Blau wrote:
[snip]
> @@ -1498,16 +1499,15 @@ int midx_repack(struct repository *r, const char =
*object_dir, size_t batch_size,
>  	}
> =20
>  	cmd_in =3D xfdopen(cmd.in, "w");
> -
> -	for (i =3D 0; i < m->num_objects; i++) {
> -		struct object_id oid;
> -		uint32_t pack_int_id =3D nth_midxed_pack_int_id(m, i);
> -
> -		if (!include_pack[pack_int_id])
> +	for (i =3D 0; i < m->num_packs; i++) {
> +		struct packed_git *p =3D m->packs[i];
> +		if (!p)
>  			continue;
> =20
> -		nth_midxed_object_oid(&oid, m, i);
> -		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
> +		if (include_pack[i])
> +			fprintf(cmd_in, "%s\n", pack_basename(p));
> +		else
> +			fprintf(cmd_in, "^%s\n", pack_basename(p));
>  	}

The patch looks straight-forward to me overall, but this last part
confused me a bit. Why do we explicitly exclude those packs instead of
merely skipping over them? Is this so that we don't repack objects which
are part of both included and not-included packs?

I was mostly wondering whether it can ever happen here that we decide to
not include a pack because all of its objects are already contained in
other packs. In that case, explicitly excluding it would lead to repo
corruption if we deleted such a not-included pack.

Patrick

--aAnk95TjBobe53D7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL8F4ACgkQVbJhu7ck
PpQAvhAAmP4r4Sqtxe/2Q0XDzqIS8kbpoVydqLQcf3EVMWalAJN6GF7lXYWPiNeL
NFfZN0+eUT2z3kjluNOYtC8pMNCEmw7GJ04LoeHj35znh53Z+jNsECyFlPrqet5I
mQ5DR6Ko8QxxAdTmLig2RLjv8Qh5KeKfrkF3f+wkwmgGftRfU2AlXUKEPVXvUmwQ
xs//O9S5k2rn2FFJQeadjkRGFT0z1VZnQmc9yLOAldh96NkWdxr3Bjc0Ukh72GrL
/mzOXuSIFQPz2qdmjL+vZEhBViBzfcrFFwGgNkpUF0SxJNWl7EiML770qQ8hLpTm
E2si5pbBPOwAP2PN2wDMVOR5M/9dSj08QOXAPlV03LBQUUrmD9fe/+n81Uen8HEU
gE8qNySa8WWqJ6sO/7LBQcf7HR/mjDaTjrVqrmdwgVi/oTCNHWfyVdsFGWWjCvQc
L/S6HlVSfaRi2G1+g/O+J5RlBkD+kHE/neSjitXfgrh2LPY0nbA+Fhxm5Gco4biD
votrLibRvwClvfv0ICQe+26pypfQN2qNGVJzS4eMqbXQp0FJLqQM+/MPSnUlEFcA
k8ud2dERbq5KTwF7fa//MLJvd3yRIhLsFrwIHEaEwK1piut+J+Dkwt/Gc2cA0kQl
WLZtgaCDM5aglk/r3KV13G/6qHTLH9vuA5hxMs+7Ol4r+QtwTns=
=YOGv
-----END PGP SIGNATURE-----

--aAnk95TjBobe53D7--
