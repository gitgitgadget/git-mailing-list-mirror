Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158A1B946
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989550; cv=none; b=YLpRhjhDMuBurueC4fMoV4KIbS/2kgOUoTao2GBahIFxGBFEqYjDZhnUXlOTw+jxFe3Oq/OAUQubs1H5jU27HcOkzIWiQLk2xvFbNK9S3smqDraXEk1HQFeoRhSlkF9zEfQcU4PObNH8O+NE9EYEcTPYbgMRwY+9rVsUCwm5xQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989550; c=relaxed/simple;
	bh=zOOuJOwLizupx/T4L+CTEFtQcDvg8WZcy1+IbOaBhTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNf+Gx5eaI1OLbuK4qMnfJ9yFyXMhLE8o7a/qjhp98AR2FBXgVxUe0PRXesoP1FEiiBOkjyzRVwpYMuiG1bAmxS9zuh0yCfqmOgEtJPvRmSaSoqxeOOfo0PcrVZhYydRjZS9rWjBI5g8ABknkv0fiJN4XW6nRAMIZMW+zMAxx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nfju6Abg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fG43RJKi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nfju6Abg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fG43RJKi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 42E0011400AA;
	Thu, 15 Feb 2024 04:32:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 04:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989548; x=1708075948; bh=fxCaoM4u/8
	unHphaW7XvUXlBZ1YT8ZT9zMnNl2qV2oc=; b=nfju6Abg2VCHFEYYcQJ0Fj9Mjd
	hfEFPSLRGaENdmHdQ6krDu7pT/jIGVKkIb01yJ4rm9YMqCVnfEz4uq317N09NZBg
	LWTtavJGkQYmlWNyu97YMGMsbKozEgIPUa5yzuvwztivANHVcrewTqDXmvGaIUEz
	N2VT0dTDbRAqBodz6+maxwetZWBoKVR214qc1sw5HXzKPFhScsg/H5hMr2GJOLsK
	t8PCkMr5MtwXXNyFMDvJJQ/PHkSaPBhxP74ZgFy1OGcZkWcMX5tRN0147Ba4+xpR
	xS9dU3t6aEuJntiOfOto+OMh8G252tknejKqMTImLJXIm6WTakBEnJXF5K1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989548; x=1708075948; bh=fxCaoM4u/8unHphaW7XvUXlBZ1YT
	8ZT9zMnNl2qV2oc=; b=fG43RJKiWgt/JEW7auhQRP8/cDBzS3aFyP+gtHmPYyaT
	o3g5R159iMg5lnBGxBnNyL11yMwZMjAjPQVQ7j0C1Feam2n7mL2lfTSxi3R01BIy
	rT9Uy9GOAJwO8eicn1hRvMmI0Mozula8IdK7sio8JHXz0pte+3zeWnAOaXdDYSW8
	HQuRSduyDb/Y//epUfXmjn+52mE+h1/WXUWktsMD96UA6IdLBfg1hwazzZ8kLUZu
	shlLkyOudu93rIvthP8cG7bf9TokblIMJfxD4/ySMQcFNEvhtS2sfM9iZ2Hsrxp7
	xLABa8yZLOVHRQLGCR5Pz+KmkUhUfsJpN1IVrdtmSQ==
X-ME-Sender: <xms:LNrNZe13S20UKwfhzr4GLoVhDGn5LVvqaNzNvMl-M6X6QSISM24rFw>
    <xme:LNrNZREaU7Nmf0nVYzi1pE90P3DFD_aP1jUx4WhYnZtrSMDncfDV4Z4DlKsYEfjPl
    -LlG2rVW3XQhzaR2g>
X-ME-Received: <xmr:LNrNZW632cBksBay91PLOEkTj5niUxzxa1fqAruMo0AJjjq296rv7gaJK62VnIdFSATkINvpfe03I-U0YaCTf8JKHYjSf7tfHZpy1hi_coK7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:LNrNZf1Zy3nDwwzvY9dCNZ21Mq58nCnO6uw3UTri-qSkTKbl1RWqGQ>
    <xmx:LNrNZRFj7iXKPHz7l4sxkuH23koeq4Buuuc2dRWB9NTtwC6eAM2NZw>
    <xmx:LNrNZY8QFOYedFvbMFLWnDE09TQCdqjDJoQFKdpZRSKlX7pJh-bNvg>
    <xmx:LNrNZRBZMjoP5aG71HRV1Knd8KFVNACVdVYhG-5ndqGo6fg0qIVPhA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68228b53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:35 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 06/12] fsmonitor: clarify handling of directory events in
 callback
Message-ID: <Zc3aKSR53Ew4ImMP@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ya81abOwaVrXBE+N"
Content-Disposition: inline
In-Reply-To: <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>


--ya81abOwaVrXBE+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:15PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 614270fa5e8..754fe20cfd0 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -219,24 +219,40 @@ static void fsmonitor_refresh_callback_unqualified(
>  	}
>  }
> =20
> -static void fsmonitor_refresh_callback_slash(
> +/*
> + * The daemon can decorate directory events, such as a move or rename,
> + * by adding a trailing slash to the observed name.  Use this to
> + * explicitly invalidate the entire cone under that directory.
> + *
> + * The daemon can only reliably do that if the OS FSEvent contains
> + * sufficient information in the event.
> + *
> + * macOS FSEvents have enough information.
> + *
> + * Other platforms may or may not be able to do it (and it might
> + * depend on the type of event (for example, a daemon could lstat() an
> + * observed pathname after a rename, but not after a delete)).
> + *
> + * If we find an exact match in the index for a path with a trailing
> + * slash, it means that we matched a sparse-index directory in a
> + * cone-mode sparse-checkout (since that's the only time we have
> + * directories in the index).  We should never see this in practice
> + * (because sparse directories should not be present and therefore
> + * not generating FS events).  Either way, we can treat them in the
> + * same way and just invalidate the cache-entry and the untracked
> + * cache (and in this case, the forward cache-entry scan won't find
> + * anything and it doesn't hurt to let it run).
> + *
> + * Return the number of cache-entries that we invalidated.  We will
> + * use this later to determine if we need to attempt a second
> + * case-insensitive search.
> + */
> +static int fsmonitor_refresh_callback_slash(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
>  	int i;
> +	int nr_in_cone =3D 0;

Should we return `size_t` instead of `int`?

Patrick

> -	/*
> -	 * The daemon can decorate directory events, such as
> -	 * moves or renames, with a trailing slash if the OS
> -	 * FS Event contains sufficient information, such as
> -	 * MacOS.
> -	 *
> -	 * Use this to invalidate the entire cone under that
> -	 * directory.
> -	 *
> -	 * We do not expect an exact match because the index
> -	 * does not normally contain directory entries, so we
> -	 * start at the insertion point and scan.
> -	 */
>  	if (pos < 0)
>  		pos =3D -pos - 1;
> =20
> @@ -245,7 +261,10 @@ static void fsmonitor_refresh_callback_slash(
>  		if (!starts_with(istate->cache[i]->name, name))
>  			break;
>  		istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +		nr_in_cone++;
>  	}
> +
> +	return nr_in_cone;
>  }
> =20
>  static void fsmonitor_refresh_callback(struct index_state *istate, char =
*name)
> --=20
> gitgitgadget
>=20
>=20

--ya81abOwaVrXBE+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2igACgkQVbJhu7ck
PpTkehAAm7xZiI0JxcQ9wO586oavS/5ytYBZljCuMT6zfsXWRMbIP6ppye2lkGq3
Nnro+4rpqzj4js4KPEpREyIuc8S4zTR4ciVNEMQuOVR2jSYJmlfoUGC2tsyZ6S/v
lRO0k7w+rLsDZtDHs1vy9R3JWRyLrDwKPhBzxoZ8TJAOERZDZUrH1tuY5JUDCtr4
A9+OJGE5d4NbG6Jvy3Eor8OrTq4kEL6n+O698EAX7pYKb+FdAK4BcpUNUba+0+42
m0X830BcGnA1XuKreEvI2VtJhqxey/uPX9h1MmebpGZFAwhPamrTSy8w1OFyuwpg
UkasWT594oxW5yK05XF0KSh6525s7xUXSV0monyPH2mGFOp/9fDk2h3gnBocwJgD
UNiMPzZeUZEx8sxE4xQTbUtPem/2BJ2LDFsXQsvRO3CB0CvCg5msGJnnG8J9HPbt
lw8O9PNgiVoJjYGvnJ2wFwDnGtMuWd+aq/zOlapJJsqL0Wimc73VK4eACWex4xy3
mTYJx1Y8lTIf6zNTSLK/2MVELSyb0JgsMIeUPci6x61flwnoGywE609K4d1tS+8b
/hLfYe3duhJxOp0FYm5KuNPGvEo3sXty5xSND5Zu2hLK9uCNzZX2GdQTcQnzqzuI
sUlNYYF9C0xUNGjAxYL89aPoGGsBSG3Fk17JA9pvsR3eR51j/Zw=
=W6Ty
-----END PGP SIGNATURE-----

--ya81abOwaVrXBE+N--
