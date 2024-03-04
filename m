Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFB1378
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535499; cv=none; b=VfblXESkOWW/6W428BKAJc3tNiCaHvuLPw2GexLmiX0fQosTbdQqQhxWDSYmcqhErE69MgyMNGx78eTWkV9QHGjd3ShEhqLopkTd6MOUH9MiFCo1HUvMhARf7h0/H+XbQ8J09hzZy71GTBP+/+es9sBW4lI377e1u6pwb3n0Q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535499; c=relaxed/simple;
	bh=Mg2FEWaE39qJomM+Siyqq/zcynpXmIFD+MhxryHgo7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkrIGJyNRY2AMwvkjMIO254YBzep2J+HKSbl4mokYhbEpvxhBZi5DgzuFVc24CceD2zUiDgM6ZnhxgpJ2VgVnbBF2r6Ta7KHZ1hYB8KOfwPGcowL9WdViCBLCh13XC3zTyGdiiMg4iaHLCiof291ZWbSxOic+f5t2NqJoK4RBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nPFyg/ob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzyYcbRn; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nPFyg/ob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzyYcbRn"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6959D18000B0;
	Mon,  4 Mar 2024 01:58:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Mar 2024 01:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709535495; x=1709621895; bh=d58/hTUeWz
	r+elXhWItv2OLgpgZbYyOxlrB1CojOga0=; b=nPFyg/ob4uIu7u1UyTaebXogLS
	CQX4QzoSWzXn/4EHcymxCIukYvdx5j/HvmIaT+e1/xc01AGup45UQqElBIxUSfxW
	RJKsuR9OiLHu2OBoVrvc9RFKxT9dw69HsgJuAWwj1dYS7RVbGaalA6WaE+dP/tIb
	Cn3r8JcnMXRiI6rPdM20M1xAyN/QPs0LoDh9vHElsmeq26qYKRR6bVMIuMa33bjf
	+805VbQo10KQC0/ELlE7rvN3G47l/151jKD7CUOEw2f1knuGDSAmP6buGvCBrabC
	7TdPg92O98cIK8PkoABDq8B/6oAgoYv8E35ZRANvNUlqUKmSSUsszWJX99yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709535495; x=1709621895; bh=d58/hTUeWzr+elXhWItv2OLgpgZb
	YyOxlrB1CojOga0=; b=HzyYcbRnVhD/fNYGoz1ELcCxvZLaqan9sqNV7QPcXKg8
	lfGdrpP4YZFKULNwzlfKnuGqPLVj0jv/YIZ4BW68naxIp1wOKQDiUlLxUwpuFe9T
	CgUeyK/8Fhvc1Ih/mzdMPW+XCIncKFEOdkDR5sZ1UQxAs25FEg/bhjwbV063aNDs
	aabqDWNhmFfTu3Eyvm991ZZKNEsLuCR4S6lKSD2nz0YZEH2SJmb0RKytUDDm43si
	gTUr36LyBuauVriXRzkOE1mC2sDSgxmI/JEvnaUfGlDArXxBsUiTOijHDEcYInMs
	jI7eU+vvkO4MxQ+YMQvOWfeJhV9AswXUJLkNttSYPA==
X-ME-Sender: <xms:B3HlZawhkDDL9qaFz8ODMVm6sm5PuBXvDVPRAXDDBGsLiWLrDuu9Zw>
    <xme:B3HlZWT6JKb59kh43Uj7fBSXc3tQ78fj6wdt-YucXL1d46i7jIf-DRj2h7ivYdaX5
    kE-YE4z-TALsT9ebw>
X-ME-Received: <xmr:B3HlZcXMRHpZCmfBoXh9YoTJw9FBBglinjPD2OzgOm-K-oRI2Jw4pilX4SEdAu-lz2RUU4isRMJDMQVd_FjTNFgPzRDF92otnKz4j0SCDGHa-Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:B3HlZQiaw79AAJC5yr6j0f3RvMOTxreVSCtkFWrprFUt8HYwzplzZA>
    <xmx:B3HlZcCJT46FJ2hE4TnD3HaYTw8tNpdLQoVG4mWbu6-cDKxX01vDKA>
    <xmx:B3HlZRLDhgsRHMTeT-muI2fD25XN4w1lqn8X6DcUaj91Fo4Jp8_PNw>
    <xmx:B3HlZfMOWqQifQSSom9K_arEjTTipmiyvq9E00XlAMV3yD-zK7ipbUN6Krc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 01:58:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6625291a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 06:53:48 +0000 (UTC)
Date: Mon, 4 Mar 2024 07:58:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] unpack: replace xwrite() loop with write_in_full()
Message-ID: <ZeVxA1KvN18Y85J_@tanuki>
References: <20240302190348.3946569-1-gitster@pobox.com>
 <20240302190348.3946569-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrNHH6qkcxmr+CSz"
Content-Disposition: inline
In-Reply-To: <20240302190348.3946569-2-gitster@pobox.com>


--nrNHH6qkcxmr+CSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 11:03:46AM -0800, Junio C Hamano wrote:
> We have two packfile stream consumers, index-pack and
> unpack-objects, that allow excess payload after the packfile stream
> data. Their code to relay excess data hasn't changed significantly
> since their original implementation that appeared in 67e5a5ec
> (git-unpack-objects: re-write to read from stdin, 2005-06-28) and
> 9bee2478 (mimic unpack-objects when --stdin is used with index-pack,
> 2006-10-25).
>=20
> These code blocks contain hand-rolled loops using xwrite(), written
> before our write_in_full() helper existed. This helper now provides
> the same functionality.
>=20
> Replace these loops with write_in_full() for shorter, clearer
> code. Update related variables accordingly.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/index-pack.c     | 17 +++--------------
>  builtin/unpack-objects.c |  8 +-------
>  2 files changed, 4 insertions(+), 21 deletions(-)
>=20
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a3a37bd215..856428fef9 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1524,14 +1524,12 @@ static void final(const char *final_pack_name, co=
nst char *curr_pack_name,
>  	struct strbuf pack_name =3D STRBUF_INIT;
>  	struct strbuf index_name =3D STRBUF_INIT;
>  	struct strbuf rev_index_name =3D STRBUF_INIT;
> -	int err;
> =20
>  	if (!from_stdin) {
>  		close(input_fd);
>  	} else {
>  		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name=
);
> -		err =3D close(output_fd);
> -		if (err)
> +		if (close(output_fd))
>  			die_errno(_("error while closing pack file"));
>  	}
> =20
> @@ -1566,17 +1564,8 @@ static void final(const char *final_pack_name, con=
st char *curr_pack_name,
>  		write_or_die(1, buf.buf, buf.len);
>  		strbuf_release(&buf);
> =20
> -		/*
> -		 * Let's just mimic git-unpack-objects here and write
> -		 * the last part of the input buffer to stdout.
> -		 */
> -		while (input_len) {
> -			err =3D xwrite(1, input_buffer + input_offset, input_len);
> -			if (err <=3D 0)
> -				break;
> -			input_len -=3D err;
> -			input_offset +=3D err;
> -		}
> +		/* Write the last part of the buffer to stdout */
> +		write_in_full(1, input_buffer + input_offset, input_len);

With this change we stop updating `input_len` and `input_offset`, both
of which are global variables. Assuming that tests pass this must be
okay right now given that this is the final part of what we are writing.
But I wonder whether we shouldn't update those regardless just so that
these remain consistent?

>  	}
> =20
>  	strbuf_release(&rev_index_name);
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index e0a701f2b3..f1c85a00ae 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -679,13 +679,7 @@ int cmd_unpack_objects(int argc, const char **argv, =
const char *prefix UNUSED)
>  	use(the_hash_algo->rawsz);
> =20
>  	/* Write the last part of the buffer to stdout */
> -	while (len) {
> -		int ret =3D xwrite(1, buffer + offset, len);
> -		if (ret <=3D 0)
> -			break;
> -		len -=3D ret;
> -		offset +=3D ret;
> -	}
> +	write_in_full(1, buffer + offset, len);

Same here.

Patrick

>  	/* All done */
>  	return has_errors;
> --=20
> 2.44.0-84-gb387623c12
>=20
>=20

--nrNHH6qkcxmr+CSz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlcQIACgkQVbJhu7ck
PpTF8g//c8+fE4/u3fhA3w0AMKNAvA3yKkJuXbIpF+Zo110g4DQOTKZ0FdQvtDzI
CJVLuQ6zFf47bWlwBbfOAIaEIvyw0+PkvfISsnhrPtsrmHW0gD6tA1hPB/xQvf2t
+DMSbFAChvdQkCBluq3Qo0RjIo0EqlXEPOMjHrDsfpbCYacN3aq2AnF02AKXqzet
iNcoFQFPEBbROSLzHZEwmjpDtiMfZfqk9W0/h7yGxQyDNR9k3eV0IkkbxhYuu0fC
UC7HuWrstij9IYjmnrING9ySrQaB0HMaUXt/xU9aV7MukRr6EsVi4EmINATolvIW
w+KT+qYUyWDcI5a8mPK5RYP34DTznKEtUglQu3euf6EA3Qoo9RtmyCMGkIU79KQM
+rscjvfsuiaLh2Rq8lcPs4ErmFkCnezTeTHH5owIdo7b+QqN62j4udQ3b2lJWNl6
CfYIc7FspyC333PzCgu+M9XjppL3Ap8WPJCpq7SB4/juLp0k7fUJRJvfKL/RRBFG
VHIetGKNs8ent8Vtx1c8kEK/sOYBgcz9xgFHZkNUpS9gXRPEKhJ6WRky1iGPg53C
3JuDAQczcGB7obdolqmj+4HAAF6mZYPgjnVUVRPCSQRmC3oTI1A05GgkPpcZfpYA
lL3zlku89NP89MSkjedXe0lzHFOqtTvfJOfg4nw3+9PCevqFIPo=
=8WJy
-----END PGP SIGNATURE-----

--nrNHH6qkcxmr+CSz--
