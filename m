Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC1BC35
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989560; cv=none; b=fjye+9huQTG0G9WD2mwVVLotC4VScag0JDf6IeI/pRqwGQWTbjEL9N9klVjAeKX8P3Ya4mdIIrwkhRDS90HiHM7BxufVZOMxUyIWWzRBBI0IP0lZEKNdzSSwxK18PQsnuGnUAt9ffa6wY4+iahz8VRRAB8+dk0j6NpCGhP1iPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989560; c=relaxed/simple;
	bh=ffJ7yDUKB0dV7yFYHZzfxx6CfM/G+04GXUSb3CVnoos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7j3X8cvqApOxtX3sKyvvjZU+S1+tJsojC28OyOfLZept4wmPbPbketYOlL8W2746hRR5wiVXOBHFecMT37KWOWfyTGCFqBCoRwwpqXFnLakUwrHnrpGgIuZ6Jj8f469H9jom6FE/046IrwDN/0MDfrHHjifhEa3EuTjc6xpUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nGj4gdng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axLcX8NB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nGj4gdng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axLcX8NB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4277D13800D0;
	Thu, 15 Feb 2024 04:32:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 15 Feb 2024 04:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989558; x=1708075958; bh=t+AGg+EMB2
	1enP+P90B1xYX+IRu+jMMkpSqRwb9V+AA=; b=nGj4gdngmi4yU0CyZt63+QQ47m
	86hBFAVl+8gnt81Pu9e7sJKhX4wI6KWuxZ/2+5hEDWD97D5kqBcnT68td2pDMpxe
	xOpFIT6DdWppeDbNfHQFqG1/vLZ363fb1++HPfV8tfThfQ60fEEkEsaKhHQxSChF
	IQl0VK9c7SrOOA1sO1ei7BE47bO6oa6zK2hvUyutTA/SkcGNFMX9oyJf/i63+EnM
	YK4rvn9BR0QW8fpzkSICSOGZt4V1yQ3lTbTHng1J+z7EuHR1DgmPVTT0ABV6UzWG
	nuowtHEhnWje7A4fhHKbr+hyp1yLciKaXD8N8UW+l7FGIlF2nzc9GQap11gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989558; x=1708075958; bh=t+AGg+EMB21enP+P90B1xYX+IRu+
	jMMkpSqRwb9V+AA=; b=axLcX8NBkCPRWRdrhg+RtbAvH4gVzp9JWMJFiJxl8ZJK
	lAnr7e9iwQz9HyhuBknqHOKZfGsubJo/9o9zvDah3gaRqiFbuDz1SZZajYj0cT4o
	MoOJg/iA9gPe00gXNn11qAVkokjaQb/mynmZru8vZTdKvIwafy9aSE/NZBQDmdOG
	mI5zFk7nv6Noe9mbgx9bgrWgDnQBlTfK0sW4jgflDXMwUIe7/oExTMuZqvWhe6A+
	X0KgyfN4eCkbpTwmVzcqRk2/kMMHnMEFnib0S0u+J8FgYujuixiUA18DSGaf1DnG
	ka4iAtRyqFT+89HmZxbS1hPET4Smrma8cGe1/WX0bg==
X-ME-Sender: <xms:NtrNZb_SmnC3vkrgs6lF8v8clxRybJK3y4gsxf8VHhGZJ_SmP7LkjA>
    <xme:NtrNZXtxTT2onRV_QsXfYz88_I020zizqjLv868mS8quOxYGTYFH6QwTANxnh0iMG
    J0OVmmidxJuen4qfw>
X-ME-Received: <xmr:NtrNZZArsuzZOUBKdFekkrhdyduBXCE5GLxnCXgwF6jggAeWgyAJRnZ70IefqsITqT4iO8g7jQCjLp5M4CFmpitybT7Q7e0bVgitC-6_-eop>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:NtrNZXdYoyiPWluPMGW2YT4KFLtCdmpTsVEyXo9ozR1LrfzCqJuIwQ>
    <xmx:NtrNZQNZ_wpPew1nTYC1A-ALY9DhMprWXKJXIv22TPVZoNrw8vq_7A>
    <xmx:NtrNZZk0XEI5ztyT0GwOLSV5iXKgD6CXQJ1WVC0MKKNn9-Md4oWgMA>
    <xmx:NtrNZVo0U1kQ8hgY1dILP_u0y3flB1jOHGW2jjUS96B_z3y6zBAdDg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d76436de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:45 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 07/12] fsmonitor: refactor untracked-cache invalidation
Message-ID: <Zc3aMzBBZBlK3MfI@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <1df4019931c29824b174defb75e09823d604219e.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lw9LHe0UmhJak/0l"
Content-Disposition: inline
In-Reply-To: <1df4019931c29824b174defb75e09823d604219e.1707857541.git.gitgitgadget@gmail.com>


--lw9LHe0UmhJak/0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:16PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>

Junio already mentioned that this change does more than a mere
refactoring, which leaves the reader puzzled a bit.

> ---
>  fsmonitor.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 754fe20cfd0..14585b6c516 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,11 +183,35 @@ static int query_fsmonitor_hook(struct repository *=
r,
>  	return result;
>  }
> =20
> +/*
> + * Invalidate the untracked cache for the given pathname.  Copy the
> + * buffer to a proper null-terminated string (since the untracked
> + * cache code does not use (buf, len) style argument).  Also strip any
> + * trailing slash.
> + */
> +static void my_invalidate_untracked_cache(
> +	struct index_state *istate, const char *name, int len)
> +{
> +	struct strbuf work_path =3D STRBUF_INIT;
> +
> +	if (!len)
> +		return;
> +
> +	if (name[len-1] =3D=3D '/')
> +		len--;
> +
> +	strbuf_add(&work_path, name, len);
> +	untracked_cache_invalidate_path(istate, work_path.buf, 0);
> +	strbuf_release(&work_path);
> +}
> +
>  static void fsmonitor_refresh_callback_unqualified(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {
>  	int i;
> =20
> +	my_invalidate_untracked_cache(istate, name, len);
> +
>  	if (pos >=3D 0) {
>  		/*
>  		 * We have an exact match for this path and can just
> @@ -253,6 +277,8 @@ static int fsmonitor_refresh_callback_slash(
>  	int i;
>  	int nr_in_cone =3D 0;
> =20
> +	my_invalidate_untracked_cache(istate, name, len);
> +
>  	if (pos < 0)
>  		pos =3D -pos - 1;
> =20
> @@ -278,21 +304,9 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
> =20
>  	if (name[len - 1] =3D=3D '/') {
>  		fsmonitor_refresh_callback_slash(istate, name, len, pos);
> -
> -		/*
> -		 * We need to remove the traling "/" from the path
> -		 * for the untracked cache.
> -		 */
> -		name[len - 1] =3D '\0';
>  	} else {
>  		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
>  	}

We can drop the braces here as both branches are now single-line
statements.

Patrick

> -
> -	/*
> -	 * Mark the untracked cache dirty even if it wasn't found in the index
> -	 * as it could be a new untracked file.
> -	 */
> -	untracked_cache_invalidate_path(istate, name, 0);
>  }
> =20
>  /*
> --=20
> gitgitgadget
>=20
>=20

--lw9LHe0UmhJak/0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2jIACgkQVbJhu7ck
PpS8gw/9FtWmBZA0Nl3BzmAk/f2hpPEa9WmBWDRONq4Jx5am5JYu3Jam21uTpx0S
E3DaJQzIdbXVEGtXFjqbovy4e9dPlJ4dq/eW+Jb0E7njFdA+Tpi6KXu+2znboWUz
qaMlsxEDR+s5cf/15Mb8tx/3MbgbFDuA9fCKm/Ydo1XRNo1UqQNYrcnfGRAslhu+
NGzT461ge6Ws5c7IooMz/3B3Uk/2M8Rga5wqk9uT5JXoJGS5BPyu1zlQ7SwNSihA
7yZwiIipEWCLdgDrm8CQSst79kj3HO2pSEDQdAiijxE+nnQBKxdErZLHs7M9WAJz
UYDR2/ccHb0L2KBL1gLnGcTWPOUYLBDpBUTKzMLU/4X/O+FvqUZG8R+lrOJpGKqE
DSeLYzYdd3ZMTO+11kWpLbP8zsymWe1tt0FRgnXTJbUpJUqCw/WJkdJrRKevN9W8
NjG1R8lEC+Ml7KCgAk7y539SJSHgbwfzQNKp2lTsN/45rBKjivJvHx29biijeW96
5fjLacnKivfv04cF+RLzRO43xkOVb6pgj8CUzY8P6XjFg7dG2wsNHp6Ge5Rthyxn
yUiUxp1pUNh84f7Lr7lZEd2IuK8cGBxt6m4l1YFshvhEdccU3eHlBJNgdCTjvxng
4BDc++26w7nV1iU0Iutv5IRrdMcpWHgR1md152HvEIKji5k4kHU=
=aKxO
-----END PGP SIGNATURE-----

--lw9LHe0UmhJak/0l--
