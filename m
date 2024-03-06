Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECD5DF1D
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729929; cv=none; b=b7I0gOa7WEg6vxuTslo+jsxRZw1wwG4+FCdS5Ox5flyk4zhyhP0L/gBA1syP825Sgm7zW3S0+KC7mNphSsbMbLw4KhJZicKVJdEHOFcvYGoRYuFPQw87BLt/fyvZ9K+3xCOEst70zzxIt8CBNbrYaGoOtCgLa2HdOT0bh7Q4VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729929; c=relaxed/simple;
	bh=gFcmG1taFPlYHRSwGsIP8obAM7QQ4Zx2csuMI9LJsCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVDRgql1373ZVrGO3ZUCJLBIltwwaCHnxd9PiThO3MiipVbqMfFLCZYJSx6yRzN9QXzrdPjVG9N52A4cNb4TQ3d2kNdX5ZTykBJ38r7EuSpzj/f84Go4aXoRX0Uq5ec8ucwgkLFezVIQsRXrUvno2TjrHYjfKpRYi60oztR2A00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B5zq5hJG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOixEepS; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B5zq5hJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOixEepS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C19281C0007A;
	Wed,  6 Mar 2024 07:58:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 07:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709729926; x=1709816326; bh=tyHHLYGW76
	4MoXhkengWE3iAPiy4bX+38IfJtIz4w5s=; b=B5zq5hJGiTbD8rmPTSpXukr+la
	RXMWLgUSBPjBuoWRRBi7D5FU9bNiz0gFxlw1uzeBBu2BYGzaM5qseg0sB2l9AwE4
	OTT0YCaDhWI9JnPL4GHXEuATqyq0idAP7zPXRpOHrYmp0S15wTTCTR75zwOiIrp5
	gZgrxXdCYiuMnI5OqyIPzSpXFSL1gQiKfshcIt3SJbWc24vSJpgPq739HCsS8WRT
	WioUmt9QAosrtYZyz0av+QTR6VyBdJKLW1VJpEGBx0rK9epN651yDG1DvwKTLwDL
	xGdNhUBLS+lWVI7vogBN86S1QCamcyJWeNw2dWYLh+KEibFUIcJ6/IoP3ung==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709729926; x=1709816326; bh=tyHHLYGW764MoXhkengWE3iAPiy4
	bX+38IfJtIz4w5s=; b=AOixEepSdZnEEhTVz0Wxd2XIztkg59yGWvEx7ue8L0a7
	H+k5AvnR31/CuFogfTrURSaWu7h3x13i3Me0G5tCqIoims7gsT1/I+uJkYQx1g9N
	JN9ZBMnnekRgD4GmgyWHYzVmSDmvXnAJNoJHvJj5KJ+fHFBsli+lYZXHhiu12ORo
	yZ250SsXk4VcwgSQnAD5KTf9TnMt7wGQdkaIxKbETU6G6hsBu6ySqWqgJdIfr+9m
	t2dGZNVzXK1DiWYMsI1CRlgnWQOfPtRhympcrkhkuSItmGXaW7O+hpcTFEad2+Jv
	h9FxSsTlyoWKKF7nl4IvmUgEeLn4xC9s3ki7Pl75Sw==
X-ME-Sender: <xms:hmjoZXB4eEekY0CAJJ7S-OFRew3ExZRYSY3nGCVmNBeY3r2L8JIO4Q>
    <xme:hmjoZdgDthmbdM-j-Fr84PBgYOO_NI0OZ9wPEmcO37WMhLT_lQUJWca5EBp2uIrsT
    nXQp0wp8fMm7harDA>
X-ME-Received: <xmr:hmjoZSkLdEym_BGa89oSoCXq67PPIIEM2QUM11MgL-8aHNYn7ITpnWhjk_FgIwft9KsOnYgdvq92SVr1pSiEtvWkUgoiKlT_WYwYs6h5NECXc-VGEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hmjoZZwCH-yfqx6stzCzOqlP_j9Er3w0wcMHkLYwwj72uGYqAOhFnA>
    <xmx:hmjoZcQIoFHXs-0-d1K0D68Vdou9W_8RzepqYzXbES6eKE9SwKFNpA>
    <xmx:hmjoZcZvmhaUFq7H4Sw8Vd78Irj4CGn8J0dIihAt4fMfhsLf87ay4g>
    <xmx:hmjoZRKxxQ8doIFq41EFBZhIqbzMF0iAVGbNUUfTkQIEvuewUvO-p4z-YJk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 07:58:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1334ee73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 12:54:15 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:58:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v3 11/14] fsmonitor: return invalided cache-entry count
 on non-directory event
Message-ID: <ZehogvB9hhh4ENdR@tanuki>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
 <53f73c1515d0f64bf13f0b30e9039dedbf441f2c.1708983566.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QlLrJdeOGa1YUA/F"
Content-Disposition: inline
In-Reply-To: <53f73c1515d0f64bf13f0b30e9039dedbf441f2c.1708983566.git.gitgitgadget@gmail.com>


--QlLrJdeOGa1YUA/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nit, not worth a reroll: the subject says "invalided" instead of
"invalidated".

Patrick

On Mon, Feb 26, 2024 at 09:39:22PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Teach the refresh callback helper function for unqualified FSEvents
> (pathnames without a trailing slash) to return the number of
> cache-entries that were invalided in response to the event.
>=20
> This will be used in a later commit to help determine if the observed
> pathname was (possibly) case-incorrect when (on a case-insensitive
> file system).
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index a51c17cda70..c16ed5d8758 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -196,8 +196,10 @@ static size_t handle_path_with_trailing_slash(
>   * do not know it is case-correct or -incorrect.
>   *
>   * Assume it is case-correct and try an exact match.
> + *
> + * Return the number of cache-entries that we invalidated.
>   */
> -static void handle_path_without_trailing_slash(
> +static size_t handle_path_without_trailing_slash(
>  	struct index_state *istate, const char *name, int pos)
>  {
>  	/*
> @@ -218,7 +220,9 @@ static void handle_path_without_trailing_slash(
>  		 * at that directory. (That is, assume no D/F conflicts.)
>  		 */
>  		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		return 1;
>  	} else {
> +		size_t nr_in_cone;
>  		struct strbuf work_path =3D STRBUF_INIT;
> =20
>  		/*
> @@ -232,8 +236,10 @@ static void handle_path_without_trailing_slash(
>  		strbuf_add(&work_path, name, strlen(name));
>  		strbuf_addch(&work_path, '/');
>  		pos =3D index_name_pos(istate, work_path.buf, work_path.len);
> -		handle_path_with_trailing_slash(istate, work_path.buf, pos);
> +		nr_in_cone =3D handle_path_with_trailing_slash(
> +			istate, work_path.buf, pos);
>  		strbuf_release(&work_path);
> +		return nr_in_cone;
>  	}
>  }
> =20
> --=20
> gitgitgadget
>=20

--QlLrJdeOGa1YUA/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoaIIACgkQVbJhu7ck
PpR8tw/9EkLYjSuVdEIXUv+xjQ4udcg2zx9UbYGP/vboaaVu29j0HNdjs3WmPw3B
9Om62BSkKsOH3dzboks0OcQwYwI3PIynMurkcTjV4bSp+ZxosWvTiZktg3pcxGk4
XZc4wppk7bIsEN2JIoVOYP0JLN0rzEFgdhApnseqm0h94IdPulHdjb4SQp7StXnO
U/Qi9PQea2AaLSdz6e8innb/iNI6DYbg/irkQJM9d7Cd9rdLnY/mf1eHNr0ljhbT
nB2HcjNIcGyIsbB8Y2YUYI/AWzgZ1Un63m22wYnlA/q12vNFGNgKrT/6DKwqUE8e
UTj+dAo7FqGXVf7PjUma7PeLKxojAOcCZkzSKPeLSHDOEhDpYjLiNs2UeoF23myK
U3DtWyRxy7ZynFqP1AIs/eINR5NlIAF5UMqPcww1qw0EkeEbeIOKutURzgusxMCX
qaMhfTI0khhT7q2LO4TlGposbswmFWDhnOayGhsK8+EUx+TBmbPqmM2pm9EPj81L
Ns26HVmv501ViPGGzA1aUPnrvkiXtCb475g2nNvqSoOv4It7R0bpcHUidQf/GtYw
FD4KOLzSCDCEAU46KIiSW9K8YUnYhd0LTNaKWcLVyT/hloI71fA1yEJuG7C0MiFm
7+EpSV8sZpgtF7vfXV+56XfTho6NVr4Cbw+BEnwt3nUn9qWwRkY=
=QMgS
-----END PGP SIGNATURE-----

--QlLrJdeOGa1YUA/F--
