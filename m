Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BA18637
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989546; cv=none; b=ZySljyJWZB56d3KuE4taRy75j1wYIakgOPlUmNspLTe09Nan43rf5V7G7YOuT8MvNvAXyE+BAgnwFC04aJJGpJdENUMNqfK0Tr8z5yEM+/AX+HGRdgcTC2EIZRRLcb4nHIn+FN8+dlzjcp2Ss8Yq3T43wazYr5RvU112zpi9EW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989546; c=relaxed/simple;
	bh=HRQAsFIJssp1oz94KZiIz4MH8B1mXgOuW68z3rAr+uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaq04C2btb6PCRcoykgacWCWh6TsQpu1KY2V6ZHw2Ee/namIv53pNipKm2QtnxWVPqnWA4it0wv4u1/fsRQqtFuDxsI1AVPnLENDR1Wua2bLuvb0/pMcDjyoAj3aXj+hhKDgJmbAaCwtwf+E6RYnXqEby2n8Qe5D2r5lssjJ5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RuOg4Bhn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7rs4XzA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RuOg4Bhn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7rs4XzA"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 541ED11400EC;
	Thu, 15 Feb 2024 04:32:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 15 Feb 2024 04:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989542; x=1708075942; bh=Ql5vKKoT2s
	PsgpRSIov2I9n493j7MPAUI7iPcY8hPJQ=; b=RuOg4BhnWRolmThGfZaZbk5kF+
	0kPBJ1qvHydq9+a3mx0Bwmxy41UIiJH7qWFgwPXHg/CNHyp9g8ETqwKs2KIosJIz
	fF60wluWLEePccINU7WhXFgDbXP4kdt6QkEBjGPui1kykabuKTkSZv0/LNJiS5st
	dcxUfy9bGTAbMnlDqqWrXcI+b1xaXdufPsOeQQDV12gQO48F8/yqq5JJdv9qLAIF
	pxJgNk7tDP947+DrM3isojsDF6av/SYMIb//KwVXfEVleB9NfNBO0x4oktMB3vDa
	pKcgnRSsCbKFb4KjcXoHtRZu4vyq0RdYK+voJNWr3qU+k7dsU6erOndNZaqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989542; x=1708075942; bh=Ql5vKKoT2sPsgpRSIov2I9n493j7
	MPAUI7iPcY8hPJQ=; b=o7rs4XzAmwVJGGz1qVL7ypyawz1IuOVo648RT3xYyK9S
	vs8qa+0SkdXbBfli1ZcQCKUMw23qgONVbUsSpRU8vgxrvZVCCJW7JSTscmoR67xb
	x5FC0De4iF+4bp3C89nv3s2gZPP8LKch4XgsTZZVlQI16PaY1hFbHOYOti+kUsiS
	MxfrnyYxxSri53Vq5N5oiYMtrMRdpqoyelIMpRH8+ChGGQ3zF8Vvsb8WIDj8maf4
	6eI5gBp3F6iik1FyHfA+3ud0QdSGKzudczie20PjUYG6KrNyFJqDxXr6pUXbBaez
	XV0rctK8fGYxkvZRRaXfEspNTyfz3BhNO51bGH/dkQ==
X-ME-Sender: <xms:JtrNZU-b7bizITeveGgu2CD-xF0gpK2p02prqqBio62BL7ZIrqsfPw>
    <xme:JtrNZcs2fi381GENxFRmSRYJFjvO6ulx2OYErouBIi6Ib6PY6r9ei3xlirjW1rerf
    d2zUdyVxe67sOtIGQ>
X-ME-Received: <xmr:JtrNZaAOfEiRK8Nh8gw0_Sa8MfkxIyHXXWeTSU8iuaG8EOZtSsK8fZ1Y0i9-J415b8EwmqJgqu7SreB9e0C3ry5Z0ruyocm8i9dbqHWQnt2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:JtrNZUdmWdLPiP9D6lISueI5YfoMuK12Ul8FqkFzAFPJktgeEZPuXg>
    <xmx:JtrNZZMarPkMuZhF79fNRd9XPdbo_bxjPfppg8VmE6lr8FfT1E17GA>
    <xmx:JtrNZen-kWiNCAFEAdSgu0R0JiwGDhcJkzsCknopmTiJoD83qcFguQ>
    <xmx:JtrNZar4eZzA64n21S2iKUOc-0qfpLTrPWPap99avUQcWTdQj8-fFw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa6177fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:29 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 05/12] fsmonitor: refactor refresh callback for
 non-directory events
Message-ID: <Zc3aI5FGZdWIUDdi@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <0896d4af907d71df29b0c4f5a27d24ea80b3c0e1.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pKdONQZUKG04dgBz"
Content-Disposition: inline
In-Reply-To: <0896d4af907d71df29b0c4f5a27d24ea80b3c0e1.1707857541.git.gitgitgadget@gmail.com>


--pKdONQZUKG04dgBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:14PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 66 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index b1ef01bf3cd..614270fa5e8 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,6 +183,42 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
> =20
> +static void fsmonitor_refresh_callback_unqualified(
> +	struct index_state *istate, const char *name, int len, int pos)
> +{
> +	int i;

Same remarks here regarding the integer types. But again, not a fault of
your patch.

Patrick

> +
> +	if (pos >=3D 0) {
> +		/*
> +		 * We have an exact match for this path and can just
> +		 * invalidate it.
> +		 */
> +		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	} else {
> +		/*
> +		 * The path is not a tracked file -or- it is a
> +		 * directory event on a platform that cannot
> +		 * distinguish between file and directory events in
> +		 * the event handler, such as Windows.
> +		 *
> +		 * Scan as if it is a directory and invalidate the
> +		 * cone under it.  (But remember to ignore items
> +		 * between "name" and "name/", such as "name-" and
> +		 * "name.".
> +		 */
> +		pos =3D -pos - 1;
> +
> +		for (i =3D pos; i < istate->cache_nr; i++) {
> +			if (!starts_with(istate->cache[i]->name, name))
> +				break;
> +			if ((unsigned char)istate->cache[i]->name[len] > '/')
> +				break;
> +			if (istate->cache[i]->name[len] =3D=3D '/')
> +				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		}
> +	}
> +}
> +
>  static void fsmonitor_refresh_callback_slash(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
> @@ -214,7 +250,7 @@ static void fsmonitor_refresh_callback_slash(
> =20
>  static void fsmonitor_refresh_callback(struct index_state *istate, char =
*name)
>  {
> -	int i, len =3D strlen(name);
> +	int len =3D strlen(name);
>  	int pos =3D index_name_pos(istate, name, len);
> =20
>  	trace_printf_key(&trace_fsmonitor,
> @@ -229,34 +265,8 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
>  		 * for the untracked cache.
>  		 */
>  		name[len - 1] =3D '\0';
> -	} else if (pos >=3D 0) {
> -		/*
> -		 * We have an exact match for this path and can just
> -		 * invalidate it.
> -		 */
> -		istate->cache[pos]->ce_flags &=3D ~CE_FSMONITOR_VALID;
>  	} else {
> -		/*
> -		 * The path is not a tracked file -or- it is a
> -		 * directory event on a platform that cannot
> -		 * distinguish between file and directory events in
> -		 * the event handler, such as Windows.
> -		 *
> -		 * Scan as if it is a directory and invalidate the
> -		 * cone under it.  (But remember to ignore items
> -		 * between "name" and "name/", such as "name-" and
> -		 * "name.".
> -		 */
> -		pos =3D -pos - 1;
> -
> -		for (i =3D pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			if ((unsigned char)istate->cache[i]->name[len] > '/')
> -				break;
> -			if (istate->cache[i]->name[len] =3D=3D '/')
> -				istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> -		}
> +		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
>  	}
> =20
>  	/*
> --=20
> gitgitgadget
>=20
>=20

--pKdONQZUKG04dgBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2iMACgkQVbJhu7ck
PpQw8hAAgfv9un+yfBp+3GI58ZN+cy9lK92DKIoQZ47SP+gPfSjGyTiu1M6pJFsr
wi7OBIx17XDRspUpVc38ieavDRgwsrbHFzex6j4Zg9UjziaIDVNZvo2XxuakMezu
CafOs1Cdh3NGr16zFIcxY54P0Bjn3N0QvUJMFXe4j6N7YWicag1WKQQwunRm8aQX
HBLKR867BgZl3LivUDLOp+jmF8gCk7HIOhpkYMd629uRkcNqSS5yZozUAgW2Afry
sj+aQ0KrcjHp2JNqzzaSMLRVRlAYRMSGc1TNwzhoxpV/JtUkDRFToZ2QMVMbISCT
tLccXkht3vGpgUcJtBF22+/U1pA5/aEt1SjJDOaqurVDa1ZLzV6RqxqJb6klmNaq
mqBrwpKZ7puKEfAwrkqvu0ijvd2hg+KP7zWKzhBptCQ+knprmjvdtRbSzPr8nDog
wyfz0DQSRS6LTbWHZURSEIMeSF2a2zFApg3zD3qmbteHaSwWijcEwPBdnESzy7vj
yOlt0Ge7UTmUHeUFAHc56SFRVccs8zL68z0vU5bM947clUSZPYWIptEaOplEdlnd
fnORV959WUpWkxg19DlzgqE5A9+mZx3r9Cp+t8VTnJ1EiLUxK9th/ra33zwm2gav
hZ2+rhbUW/Bzw6gZSOOWyed+5YEIzARTBvT5Yfrvfx4NCUVBDl8=
=CbWu
-----END PGP SIGNATURE-----

--pKdONQZUKG04dgBz--
