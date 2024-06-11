Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF002171640
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086000; cv=none; b=NaCfA0D46ZLvnlFILmFJFyQhZkJzZCQPQHdD9ndAOvazSmRdXvjLS4uYQTg61jciy3niCK84Q5muOmAHsSwT22ojL3FCdPoXBp929xgmYsaj3pAW7ZLrVUyZlVyuFoH9c4jOk3qDNrVzCm62NuL0cVbm07MgnHottpNkFddT5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086000; c=relaxed/simple;
	bh=J65Hv7Jo9DWKXEdUpDwggbqQvMdNOUEnZEml8Em1oro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/aWkpfM6FPF2QfEvuY2FOgjWn7Y+Qa7jm8mpDWsmrtPLoGutv7qFRLoBmTH0D3UqwB0GsuHBrmwLkd1Loq25WeFTGtpzzHF0W33RmSoxqhk+opKNqgrd0ERClsDSCtOVwFUIBTZx7rVTx2jElxT/hJsPk2JVKhkuZU7TUuenzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y9JBMMm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XaEcgMTJ; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y9JBMMm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XaEcgMTJ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 8EF941C00103;
	Tue, 11 Jun 2024 02:06:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 02:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718085996; x=1718172396; bh=0eXoNS9CIv
	6COlTxuel8hZsjCRZ9lbfslHSsJwgfak8=; b=Y9JBMMm4ewsTRE85rEaLs3MNrC
	QmTuau7K4WbuqaAz5/Y6FzxPEwQKyoX/Cx1T6H667j4krCBqRb5gNVtj+vHBZxMv
	yQzQZlfkGKhuc6SsFZ4f4u9hMLESg4tPuP3i0zYKsZHqxD329d42uOPZ81fpHz8p
	2Ck866tZj/e7tPmMoHQ5XSEjaelsXo81BymJkKuZaj0LdKjWrtWx8sGYVpTbG8jL
	uU53VDrBVHVDGU2Zkc++7K7fmBsawFWwlGKdtIO8jhndaX5hYwWaCQoZIP1wo2Jr
	K5s89WqPfqVdqpaDIo0mDbmaVYZ9XHES1/YkbXr8mhko2GNP5zZ5Lw6woBeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718085996; x=1718172396; bh=0eXoNS9CIv6COlTxuel8hZsjCRZ9
	lbfslHSsJwgfak8=; b=XaEcgMTJgjqS1pjy+dKBnug3aKcA5GH0dOZ9OXvQBweZ
	UvxsSu/Tyz91nX6Pex8rh44TXkMfrQoQA5Fy4gDyhiRoOX87GPKxHnpgvGdlucc5
	1ZYLmxZ4UUUOCKuEwW12Sdhe2FqHBnN7hnPaIrPHTus+j0RIvNhBQ8naaIg/i0aZ
	y6Dnotq9EM9DmB1BNmO6PeYzLA/BxRRC9HGuAIVdJKpsDymR5NgXRKdWtNHok2Sv
	wFCIWYnEigyAHFh8WP04NymRX7D5QBSPkbPbpTsN/YclyVqPwqX10MXwFAIwacbN
	Jg7PYvEFayq3dN2oi0bKUqhKJG+8sIW1n/8BBYrIUg==
X-ME-Sender: <xms:bOlnZmVS4LmA2RYFP-VM4A91hmph4IN1F9BicQSkIJAMBe7GYul7rg>
    <xme:bOlnZinvm4FOtw16XQA7baYhATL2QDj3TztSnzFU-yuSx1uQvPzcHspl3x5QIYSc4
    elj-vXEOv3lhUOlSg>
X-ME-Received: <xmr:bOlnZqYCcEeiOHcJIeW8KM2b4juWgc0SHM5tIUU3PucZP_cwyIneKDqByE82bT55owGSJXb42dAAkzSCB3DnzSoAQ0s1b-WS6nSBzkJQPqDX2tVyhwqO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:bOlnZtWw_bZXG0zRR_zjABDckrA_7jh4W8myt-CzcnIebKudu4OBsw>
    <xmx:bOlnZgltg80JdsyfVSRvAA5K1w9yOq2T7ClXFuaXO0SRxYtNGigCIA>
    <xmx:bOlnZicfHmiMGP9RCkVf0443tDWXzRFYWRvwf7PRZE3kts10-gWqKw>
    <xmx:bOlnZiHfYWFJeqqlwPsOPuNXDCUjOK9Dac0308XwqlFB3G9HTKUjdg>
    <xmx:bOlnZlyywTT6_62tvQR90n_CGJoKS8mwoe28VBcXKwSgqeuUt8uWWGAm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 02:06:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f878eadc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 06:06:24 +0000 (UTC)
Date: Tue, 11 Jun 2024 08:06:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kyle Lippincott <spectral@google.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: SEGV (detected by Address Sanitizer) when using `core.abbrev`
 option
Message-ID: <ZmfpZm2vuwx0fl1w@tanuki>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JazGhyRWTVflWVB8"
Content-Disposition: inline
In-Reply-To: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>


--JazGhyRWTVflWVB8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 03:27:11PM -0700, Kyle Lippincott wrote:
> c8aed5e8dadf (repository: stop setting SHA1 as the default object
> hash, 2024-05-07) stopped initializing the_hash_algo, but config.c
> references it when it observes a user setting core.abbrev, in two
> ways:
> - if core.abbrev is detected as a 'no' boolean value, then
> default_abbrev is set to the_hash_algo->hexsz
> - if core.abbrev is set to an integer, it verifies that it's within
> range for the hash algorithm (specifically: it errors out if the value
> is < minimum_abbrev or > the_hash_algo->hexsz).
>=20
> Stack:
> =3D=3D2421488=3D=3DERROR: AddressSanitizer: SEGV on unknown address
> 0x000000000018 (pc 0x56344202585f bp 0x7fff9546fe10 sp 0x7fff9546fcb0
> T0)
> =3D=3D2421488=3D=3DThe signal is caused by a READ memory access.
> =3D=3D2421488=3D=3DHint: address points to the zero page.
>     #0 0x56344202585f in git_default_core_config git/config.c:1466
>     #1 0x56344202585f in git_default_config git/config.c:1815
>     #2 0x56344202064e in configset_iter git/config.c:2185
>     #3 0x563441d531cb in cmd_clone builtin/clone.c:981
>     #4 0x563441cebac2 in run_builtin git/git.c:474
>     #5 0x563441cebac2 in handle_builtin git/git.c:729
>     #6 0x563441ceed0a in run_argv git/git.c:793
>     #7 0x563441cf0aea in cmd_main git/git.c:928
>     #8 0x563441ce9323 in main git/common-main.c:62
>     #9 0x7fa3228456c9 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>     #10 0x7fa322845784 in __libc_start_main_impl ../csu/libc-start.c:360
>     #11 0x563441ceb530 in _start (git/git+0x1e0530) (BuildId:
> c0e4b09d5b212a201769f1eb8e7592cddbe3af1d)
>=20
> AddressSanitizer can not provide additional info.

Good find.

> My first thought for a fix was to just cap it at 40, with the
> assumption that the code would handle it correctly in the unlikely
> event that the hash size ever decreased, but I don't think that does
> the right thing if `core.abbrev=3Dno`. That's documented as a way of
> obtaining the full hashes (with no abbreviation), and if we're using
> sha256, capping that at 40 hex (160bits) is incorrect.

Exactly, this doesn't feel like the right solution.

> My second thought was that we could store the requested value and
> validate it on every usage. This complicates usage locations, and can
> lead to poor behavior (crashes in the middle of operation when we
> finally get around to checking the value).

This feels more complex than needed indeed.

> My third thought was that we could store the requested value and
> validate when we have a repository that initializes the hash for us as
> part of that initialization. If we attempt to abbreviate some hashes
> without that setup, we act as if core.abbrev isn't set at all (so they
> get the default behavior). That seems like the best option overall.
> Exploring that further ...
>=20
> I've looked at a semi-random collection of places where
> `default_abbrev` or `DEFAULT_ABBREV` are used, and they all seem to
> eventually go through `repo_find_unique_abbrev_r`, and they pass in
> the len. This also always has a repository available (otherwise it
> wouldn't be able to disambiguate). Furthermore, it has `if (len < 0)`.
> We could thus carry the "unvalidated" request in default_abbrev by
> having special magic values (auto=3D-1 like today, no=3D-2 (replaced with
> hexsz when we know it), other requests are <=3D -4, for a requested
> length of 4 or higher), or we could have another variable
> (requested_default_abbrev) that gets copied to default_abbrev when we
> have a repo.

This also feels a bit too complex in my opinion.

> The one potential issue I can think of with this is that setting
> `core.abbrev =3D no`, having that resolve to 64 (sha256) when we set up
> the repo, and then if we ever read from a repo that uses 40 hexsz
> (such as sha1), then we have to ensure that we tolerate a requested
> length greater than the current hash algorithm's maximum length. This
> likely wasn't a problem when sha1 was the default, because we're
> unlikely to go to a hash algorithm with <160 bits in the future. But
> if sha256 becomes the default, then this can be problematic.

I think this is the best solution. I don't quite see why we need to
abort in the first place when the caller asks for something longer
than GIT_MAX_HEXSZ. If they do, it's rather clear that the intent is to
show the full object hash, so we can do that.

In other words, the following should be sufficient, shouldn't it?

diff --git a/config.c b/config.c
index abce05b774..0416b0f2b6 100644
--- a/config.c
+++ b/config.c
@@ -1460,10 +1460,10 @@ static int git_default_core_config(const char *var,=
 const char *value,
 		if (!strcasecmp(value, "auto"))
 			default_abbrev =3D -1;
 		else if (!git_parse_maybe_bool_text(value))
-			default_abbrev =3D the_hash_algo->hexsz;
+			default_abbrev =3D GIT_MAX_HEXSZ;
 		else {
 			int abbrev =3D git_config_int(var, value, ctx->kvi);
-			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
+			if (abbrev < minimum_abbrev)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev =3D abbrev;
 		}
diff --git a/object-name.c b/object-name.c
index 523af6f64f..1be2ad1a16 100644
--- a/object-name.c
+++ b/object-name.c
@@ -837,7 +837,7 @@ int repo_find_unique_abbrev_r(struct repository *r, cha=
r *hex,
 	}
=20
 	oid_to_hex_r(hex, oid);
-	if (len =3D=3D hexsz || !len)
+	if (len >=3D hexsz || !len)
 		return hexsz;
=20
 	mad.repo =3D r;

This is also in line with `parse_opt_abbrev_cb()`, which does the
following:

    if (v && v < MINIMUM_ABBREV)
        v =3D MINIMUM_ABBREV;
    else if (startup_info->have_repository && v > the_hash_algo->hexsz)
        v =3D the_hash_algo->hexsz;

In other words, it trims to `the_hash_algo->hexsz` or, if we don't have
a repository, it doesn't bother to trim the value at all.

I'll send a patch that does this.

Patrick

--JazGhyRWTVflWVB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZn6WEACgkQVbJhu7ck
PpSaDQ//cj8jznMfftbZjLUqXTbb62KITUKWQh3QeNFYFg3UIDF2wU439Pmau0/I
/hnCdvAbi8AKu8U29sjiWyDp3o5GsMP5+LQObxe5omeC+IVdBdeBcveYAkSwugmg
uW6UBR1ftu35A3UzZcvAhUjezi9iZaisVmHtHlyxs5V+4R+EkpSvO0GaJ5N2MbX7
Ikp/wjpPbceQfOaFZs0g4XXbiJ9fdoQfNVLC+iRYzJYEjLP7t6hHJQ8pZvHlw3J4
tBd2S1MZBqiNt0UJZ+6OQAGzRrccaqe8GEk/6R3g26X9JwylV9JOP64v6oSLiLOe
ZtxctQfaa6H0Z2JhmvuJNvuF5FsAzfsBaZf2te/kk2Ja9m+l55K8D2mskgpq6BtT
qCZtYOKfdnuNmHDbqp+NRTUBQ1YTAD3ES0YzIu0XZMWbMrfaW3JW4N+BQ2eXODZ+
jNm4fJmYnCvcWek6UtzrwmiOeCEcSjgOXnY5jdbzkL4mSBkq/QGIdkOTD9knx+k4
Y8ss3fEy2Je3a3vVCqUmghLHiX2rPHuPE9Pz68IeP1FiW65/o2dk2MM7A3aC8Fra
cZQtrRCwknTVBqlKRKctyHsBjsAD7ymoBe4/NyNe5e/TVOXDlSzJOBEJkrZbU3dV
OljsOL5UPFa5jyKP5YurwzAYFgY3OT8lNelrcZJqSbUx6vlkXU0=
=7Ann
-----END PGP SIGNATURE-----

--JazGhyRWTVflWVB8--
