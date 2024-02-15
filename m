Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746F182DB
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989522; cv=none; b=SAwMhVF/M8+jw81AtR7gQTw4x4+HEmvyhmLfEhv8lUmo1z2nJ1x6rrO+M3Obq7HQ2Sc6074XPfDLHrD5nOaik9We6bKz3IEWvR8JdclxjezhOR2ruEPCpFzl1rEfzIeYAr2IZgAvGdRq9SyNcbba5ceWMfaMw9TMMN2BLB2cvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989522; c=relaxed/simple;
	bh=rBsf94PGrvLeI2PImIsD6v0Qus0a5P0aykn6Y+ZqRkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWxWPBsOYXqqElL/okiB6DaHebGMPJfRRDqcHB1XTnVxgVXkRW536ev4COjOlv7HnMOqBe40JcXiWJrnOzAKyV3DIZaTrFbRK25AVR0A8JJfSbuK9dPq03Omz9RCHcDshlwljyinv55sTd19SR+hmzVdD1/sgelVsA3QkrxgDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oPT2lCNe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3xe3OaR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oPT2lCNe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3xe3OaR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0636E13800D0;
	Thu, 15 Feb 2024 04:31:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 04:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989519; x=1708075919; bh=Bx8vxUeLYq
	Lylem8wa2EaStz/r9O4yFBM5u01anybA0=; b=oPT2lCNeDhyAWkwtvJ5CkbgJBD
	KFosK9mg5J1jI/VIT9wxdTHoJxcacmiYjYy4yAzoY2pp7N8TZpjqPBWgAsc/VPU3
	THxqVjwKdMbCOtIhF6uuXBu3QT7bCNiyKFq2AHxS86R2wiORKCCprNHiBgqNWpFd
	fhQErwxW3RkFbiVu3zvDMt5NBzm9/0h4z11iioCUCexOSGG7Du3ggtVmOF02uAv9
	T30dr+MYzLslcsHGegS1uARjE1XrA4gjAwE8RrOGx+LJIsDbXaPr0cluhx7I3Ne0
	5M0r4m/RPe9U5yTVCmGG6rgPO98VbhoFD7u0OSVYQeeobleFYkQs8dQ26mvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989519; x=1708075919; bh=Bx8vxUeLYqLylem8wa2EaStz/r9O
	4yFBM5u01anybA0=; b=i3xe3OaRMwCqICQFAcpxOt/IiHq0hCZ97wlwqucevNje
	nsvXWMHaU61MKDYqCmnruyL2GpiLJuliZF78tgY0Wn/5bvUK9R7V3Ir/JUUAwk1p
	TgbWBdIe8r0S7hD10MudybiaPoewxkQcBTxzXt+KoJbKDHwBGYN6eI7xkbASW5Df
	9yR70LOiT45vq8H+GZQSz951KCFlJemXprpgBL0LpjbxwTy2sbX2Sc/MIYBGfyjJ
	27zNelN3hKbBzVa6ghYlWeXJOx8+5g1A44lKurnKrD4oNbB0GnGSYStqd9+Qis0o
	8IasqnwaisSfGsJYfD1D8ipx8KRIMnaOaqY+ykVKXA==
X-ME-Sender: <xms:DtrNZQH6OXk52HltbGVMbQAid_eXr1GUTO71dEkpXfdtReVaGff0rw>
    <xme:DtrNZZV0LlN_lTSdjFa7ED8UzP-CHtFHPx4P-tl8WnB_VB8ZVrCJtRf8e86CUC7cm
    HAddHCpJtiSPvLGlA>
X-ME-Received: <xmr:DtrNZaLZQc5A-yLZRM5U9WIUQhwU2ImgoTvpYKGuTb-aAYTCrZp5zvau8NItM6gRDc41BgLD5SdL35R1tLUwhvXnTxLKd33Ahk3ZzJvsyP6t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:DtrNZSGizF23RINhKh5i_i3SlMShrw6SrrRZNL-ahFHOEpmtULgSeg>
    <xmx:DtrNZWVyehqnlJSmIgjd11sQLeKjnwGtJctQeg5YgJJ3y2cWy2HWxA>
    <xmx:DtrNZVMP7NQFMrZ0ctUaQbKe8AWO5r4d26t6xeTy0at9Skwt9w60qg>
    <xmx:D9rNZVTsmbnbjy1_2Ub6UfJWDRkLilgAYj4OBHDSmD9NBuIgXMtjpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:31:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65d7f494 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:03 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:31:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 02/12] name-hash: add index_dir_exists2()
Message-ID: <Zc3aCWwJzawKYE7p@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ovC+64ZulFuSG0dO"
Content-Disposition: inline
In-Reply-To: <3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>


--ovC+64ZulFuSG0dO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:11PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Create a new version of index_dir_exists() to return the canonical
> spelling of the matched directory prefix.
>=20
> The existing index_dir_exists() returns a boolean to indicate if
> there is a case-insensitive match in the directory name-hash, but
> it doesn't tell the caller the exact spelling of that match.
>=20
> The new version also copies the matched spelling to a provided strbuf.
> This lets the caller, for example, then call index_name_pos() with the
> correct case to search the cache-entry array for the real insertion
> position.
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  name-hash.c | 16 ++++++++++++++++
>  name-hash.h |  2 ++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/name-hash.c b/name-hash.c
> index 251f036eef6..d735c81acb3 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -694,6 +694,22 @@ int index_dir_exists(struct index_state *istate, con=
st char *name, int namelen)
>  	dir =3D find_dir_entry(istate, name, namelen);
>  	return dir && dir->nr;
>  }
> +int index_dir_exists2(struct index_state *istate, const char *name, int =
namelen,
> +		      struct strbuf *canonical_path)
> +{
> +	struct dir_entry *dir;
> +
> +	strbuf_init(canonical_path, namelen+1);

Missing spaces: `namelen + 1`.

> +	lazy_init_name_hash(istate);
> +	expand_to_path(istate, name, namelen, 0);
> +	dir =3D find_dir_entry(istate, name, namelen);
> +
> +	if (dir && dir->nr)
> +		strbuf_add(canonical_path, dir->name, dir->namelen);
> +
> +	return dir && dir->nr;
> +}

Can we maybe give this function a more descriptive name?
`index_dir_exists2()` doesn't give the reader any indicator what is
different about it compared to `index_dir_exists()`. How about
`index_dir_exists_with_canonical()`?

>  void adjust_dirname_case(struct index_state *istate, char *name)
>  {
> diff --git a/name-hash.h b/name-hash.h
> index b1b4b0fb337..2fcac5c4870 100644
> --- a/name-hash.h
> +++ b/name-hash.h
> @@ -5,6 +5,8 @@ struct cache_entry;
>  struct index_state;
> =20
>  int index_dir_exists(struct index_state *istate, const char *name, int n=
amelen);
> +int index_dir_exists2(struct index_state *istate, const char *name, int =
namelen,
> +		      struct strbuf *canonical_path);

It would also be great to add comments here that explain what those
functions do and what the difference between them is.

Patrick

>  void adjust_dirname_case(struct index_state *istate, char *name);
>  struct cache_entry *index_file_exists(struct index_state *istate, const =
char *name, int namelen, int igncase);
> =20
> --=20
> gitgitgadget
>=20
>=20

--ovC+64ZulFuSG0dO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2ggACgkQVbJhu7ck
PpRPcA/8CJptkr6wLhzblPN9pwrQZkPirDyHvq1d/Os3i1ZmdF0GDAMDJFqlZNHq
qnWGvr9mFhPrNi2+zXU8js9+0ZdpNeqn0MTYViifrsyD9sIrD7b9hhu+laKo4TSw
AhIxmbuNZcy+2UZhBrmiTiantQ9YrxYKUoo1lFSwM4SMNN4bcBARZ8/DNNrCabMM
VQvUEy0ys0l9gkyU1KwwWid0fdBQVJqy1SsIM0Pl9hj4YeLgwBDTpbeMpfJzgt5a
+H78JBeyqv9oVOcoM2Hksr3Yz9k3eqoWMvIDDjLWUtxeiwMrz+tbLCggC0m3Kn71
+HP2SxVMf6Nh6qgG530jWPx/Q1SlPm5veCEUKNZWYHv3zk0+qptayTXNkMshsHyU
T35UNnTZ5PXc6y4cN/Iwss8I0HqVzfUtMh8oje5kOSa2cVpea/VwqxMjaaL9WwwH
nS8vwSQl2YNaPHDWs9Wr1uq+gyayRN+unrD3DAV6GxsWrMCTbh6cCteY16R+pb1w
rUmIS2zApxxdvKe1X1Qrv40Cn6xZarmnpQXiXBCAiWXul4QeltfNhirAqQuWFG78
4oSQSOgEO+rcdpWeHkEk/imHTxait74SJCNlqCMmYp3c9ELwYz017/NXizJ+PoBW
Z3jrZso6q2x4Ex4oH4ZQCy8TZcNScYZIWbLe+UIRMQdkxokru8o=
=yCHS
-----END PGP SIGNATURE-----

--ovC+64ZulFuSG0dO--
