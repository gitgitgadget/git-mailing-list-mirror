Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC2143747
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857784; cv=none; b=hElHCanWG8LG/iQXOoP3h10GmCajBZ6PelBK5xlr4mjlfwOLkL1OwUp9BDAaJSH7xziBI94dxN7Y4t5Ec3+cjDzoHr4NVyqxJjrJNvXTvqE/FJaHoy6lEMC0CWN87AX3h5lBCrz6DTXi4Kf+qKys7lk8lNZEX+p55M+/e5B/Gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857784; c=relaxed/simple;
	bh=DG6tDDXvhKrirwFJ1N1gRFHm00/5XpJglAzE4Mh274w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSDm5iTbcygETQNt8ss+SkU1GyposwmQNZ8HU4TW/r/XnP5iBF16epYjKpsHO0exsqiegBl0sto7kd4PRfF+nAK6DXm73wZnF8KDBH/I+6JgH0UlL1QkVFiAW+elqbGVIn+aGwAsKILz2DbL18HgiKh1f7k8n4Yj8svQiI1Zmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g25k36ot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwJ+ST0h; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g25k36ot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwJ+ST0h"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C2C0A13814B7;
	Thu, 16 May 2024 07:09:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 16 May 2024 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715857781; x=1715944181; bh=7xI32US6ow
	lfHSALz+Hn24uFsH98ahmhYN1zsHlBZyo=; b=g25k36otc0A2Hnl/l/Bu824lkU
	8knB6KHeBHBf2+PDcIL7pL2N/M/kRhLPkcavnQhaibNy3aoBrv91VCKSf3EvUPRw
	DqfnaDrQkqwyXt/Fv0CJdZBaG4hDOKHPEseyVSppY5dTa3NbQZwSdkEJcTaeErAq
	rvW0yepQA8sWmkmisnfTiEjxbyHk21yZsiW4OE/hj2HRWCoBKb6R6UmDDfwxcW1q
	ldD3L/eKYBrY2FPEy36rn0aPi5k4MDbFeuZzdhQxap3d3GBR5mUnLVoTb0g7Kpao
	Pfdjku8bGKDkLqU81JM7n8E8XxEhq1c5zxXvjM2SSSfYwtBlcbb/lcdbzX8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715857781; x=1715944181; bh=7xI32US6owlfHSALz+Hn24uFsH98
	ahmhYN1zsHlBZyo=; b=UwJ+ST0h85LvuBXBjXVef0v2/qDu0rEC2+CKkX3S5iT9
	5AnLLHynEhSs9TratlHrcpOFv+rIdqL7TknMHRvHcNrXeTi382sWP4unXrtAQPA7
	1DPvnwsYsktF+voV/yn++qiiEDC0D6pAmgJMfiNP0MC7Q0+OdQek6HoVaNuNdUj6
	XzMxZkhtClfn6xv10LS6o4Au4znYHEwK4gc4Yp+nlgOdePkQcXytMMWXA0nHF7u4
	Fm/RezoQDkIjaLBAwM4pVOXZ4gzon4fDvK6UxYWbNUHAp2fRc+1xadBe+yHemhm6
	oBcSMa34ZM6QX5zYcbj++1QlY2YxNRqWZNFee0DtCA==
X-ME-Sender: <xms:delFZhDK1j2YYCzJI9e6P1iHHrU8-CBsXPAjUC9gNUBJtfoL3O3YjA>
    <xme:delFZviEtLyh-6wES4NvswRVlx5cc0Iu6pYUCUWXyNSpsLzJ0DErhbFYrqJ0WWN9P
    o1gDyOuD2u-egbXjg>
X-ME-Received: <xmr:delFZsnFUyRahOQ26KiN4HOrQhtX7H2YaVBkv9j7x-tJVzPwFNEssRWxZ2_dSQb9fz4LQVrDpGdRqCw4N5HIXZWUFW_ud7s3BgXMQTH3R81sHv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:delFZrw4jaPxzCV-Of39p1aRle9eC2YQmjSpeUQWLq0WRMwYLU3MbA>
    <xmx:delFZmTUrRVjMq0OM1faGa9zl6rnQMYwNgvPanRXoE4ChqwYExqrKQ>
    <xmx:delFZubi62yVJ7AGLJvMkx_AF__43tCSkOehsTs_p0tYD2jXyMe34w>
    <xmx:delFZnTR72Du0pAENuD3wpicPoOeINii8FVOta0VGyk-NFF1CzshmQ>
    <xmx:delFZkd_OxcCwYMo7czROXlRZIw2ci_krBjb7eN5KSpyprt-aIts5eg7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:09:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8b7f9cd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 11:09:15 +0000 (UTC)
Date: Thu, 16 May 2024 13:09:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 6/6] update-ref: add support for 'symref-update' command
Message-ID: <ZkXpcvF6dxGr6qmj@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-7-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/rsNlsWGyZRFSNhb"
Content-Disposition: inline
In-Reply-To: <20240514124411.1037019-7-knayak@gitlab.com>


--/rsNlsWGyZRFSNhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:44:11PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
> allow updates of symbolic refs. The 'symref-update' command takes in a
> <new-target>, which the <ref> will be updated to. If the <ref> doesn't
> exist it will be created.
>=20
> It also optionally takes either an `ref <old-target>` or `oid
> <old-oid>`. If the <old-target> is provided, it checks to see if the
> <ref> targets the <old-target> before the update. If <old-oid> is provided
> it checks <ref> to ensure that it is a regular ref and <old-oid> is the
> OID before the update. This by extension also means that this when a
> zero <old-oid> is provided, it ensures that the ref didn't exist before.

It's somewhat unfortunate that the syntax diverges from the "update"
command. "update" also has essentially the same issue now, that we
cannot verify that its old value is a symref, right? Can we fix that in
a backwards compatible way?

It would also be great to explain why exactly the syntax needs to
diverge.

> The command allows users to perform symbolic ref updates within a
> transaction. This provides atomicity and allows users to perform a set
> of operations together.
>=20
> This command will also support deref mode, to ensure that we can update
> dereferenced regular refs to symrefs.

Will it support deref mode or does it support it with this patch?

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 16d184603b..389136dc2f 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -98,6 +98,41 @@ static char *parse_next_refname(const char **next)
>  	return parse_refname(next);
>  }
> =20
> +/*
> + * Wrapper around parse_arg which skips the next delimiter.
> + */
> +static char *parse_next_arg(const char **next)
> +{
> +	struct strbuf arg =3D STRBUF_INIT;
> +
> +	if (line_termination) {
> +		/* Without -z, consume SP and use next argument */
> +		if (!**next || **next =3D=3D line_termination)
> +			return NULL;
> +		if (**next !=3D ' ')
> +			die("expected SP but got: %s", *next);
> +	} else {
> +		/* With -z, read the next NUL-terminated line */
> +		if (**next)
> +			return NULL;
> +	}
> +	/* Skip the delimiter */
> +	(*next)++;
> +
> +	if (line_termination) {
> +		/* Without -z, use the next argument */
> +		*next =3D parse_arg(*next, &arg);
> +	} else {
> +		/* With -z, use everything up to the next NUL */
> +		strbuf_addstr(&arg, *next);
> +		*next +=3D arg.len;
> +	}
> +
> +	if (arg.len)
> +		return strbuf_detach(&arg, NULL);
> +	return NULL;
> +}
> +
> =20

There's an extra newline here.

>  /*
>   * The value being parsed is <old-oid> (as opposed to <new-oid>; the
> @@ -237,6 +272,55 @@ static void parse_cmd_update(struct ref_transaction =
*transaction,
>  	strbuf_release(&err);
>  }
> =20
> +static void parse_cmd_symref_update(struct ref_transaction *transaction,
> +				    const char *next, const char *end)
> +{
> +	char *refname, *new_target, *old_arg;
> +	char *old_target =3D NULL;
> +	struct strbuf err =3D STRBUF_INIT;
> +	struct object_id old_oid;
> +	int have_old =3D 0;
> +
> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-update: missing <ref>");
> +
> +	new_target =3D parse_next_refname(&next);
> +	if (!new_target)
> +		die("symref-update %s: missing <new-target>", refname);
> +
> +	old_arg =3D parse_next_arg(&next);
> +	if (old_arg) {
> +		old_target =3D parse_next_refname(&next);
> +		if (!old_target)
> +			die("symref-update %s: expected old value", refname);
> +
> +		if (!strcmp(old_arg, "oid") &&
> +		    !repo_get_oid(the_repository, old_target, &old_oid)) {
> +			old_target =3D NULL;
> +			have_old =3D 1;

This one feels weird to me. Shouldn't we return an error in case we are
unable to parse the old OID?

> +		} else if (strcmp(old_arg, "ref"))
> +			die("symref-update %s: invalid arg '%s' for old value", refname, old_=
arg);

When one of the branches has curly braces, then all branches should.

> +	}
> +
> +	if (*next !=3D line_termination)
> +		die("symref-update %s: extra input: %s", refname, next);
> +
> +	if (ref_transaction_update(transaction, refname, NULL,
> +				   have_old ? &old_oid : NULL,
> +				   new_target, old_target,
> +				   update_flags |=3D create_reflog_flag,

This should be `update_flags | create_reflog_flag`, shouldn't it?

Patrick

--/rsNlsWGyZRFSNhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF6XEACgkQVbJhu7ck
PpR75g/6A98OH8RRBrWfnh571KybssdymNWlULbZBYRXKHyazNciiAjwGQB8fXzv
F6t+D6VgtE71fDragPK2t/eqX95SI00aGl8BffiDMGo4ZYEo7q2y48Hy/YyGvUE8
eWtTq4wdzmgN/XRAaD4p3e5KxVAQzK9rLEvxM02CIPX721/JkEBvL+TiU1hKXV/w
VQYE3e0BTtcBePdaiQpBiKws/Z+qc29ryUsHzIKKSiYQfzzJOEBZlq6SZrklwn2V
LLQI1EXEAuDSI16687Z4QM8rZb/1qxUjxs8z1GuRTBsdZXypYD6Rmwf/GeI0+fqR
RRYzVfwGcEqrNQ2JCMGOxjqshxMYn3cvJc3Htj4suYIRrjNkH/6KIOzNaiOdTdCg
4m3ohtvLX/aoVUTnIbiLY+/TeJLviZTiEbopWhOnPeqQ0tLUo0tCHTMgaVjFt7Xr
HMVATzj3aZzu3IfSZBpfwCU9ne6hs8lGH2RzqGDXvLUDivxgX824sp17erK06fa8
iGTjNkqG5im164k2PULxJEiyckcvYmOu5k2EGYGHT+tLECKu5mWIagPrtOOm22fL
LVTuGTCwEC+ljSJ7FlJXIvi2NUEjoP+pjStejNAaGeI0yidykHvJxlwxJA7POF8Q
NDEnHsjkrgfsoH4jDU7WfggfIrPgbnvjxxAhhLZhoOnl6MlLfhU=
=6PQ6
-----END PGP SIGNATURE-----

--/rsNlsWGyZRFSNhb--
