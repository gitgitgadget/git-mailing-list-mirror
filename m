Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1A4EB23
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399354; cv=none; b=q1DZQu0ZAHKXvMZH0rWYXCDTdgKkZkBxaxLftag9i8mIJlKV2WBrjE0QXwVWE5uv/uLlwh3HS191UgS+VqC6LSmQ830XFb3kTzvD3ICNmS8ro8XVgMQUdgzehSAWwUOM6ANjQWdfpwnjXzBzCSJKzxWju8f4mZkIdEUArvF3Xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399354; c=relaxed/simple;
	bh=6tfkI6SKu86UwuXeLhJc4VPCKDqXfZQ1DsE6XtpHesw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2AHsNOyhgZczL9pVHBMRw8javk7QQFX1G6os1DIcojB2QlO1jFgSUUSHPvIANsYr+cu/PgiQZ7Jdgq8D27LCHiq0soSarU6l+ckzR58UI8mNziUw1IpCOMQvquDbJonOZQ/HOakKu3OqGIlEBxlGeTepAOApT1+ZbWB0nY9pVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nAhASkz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cv+P0VPg; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nAhASkz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cv+P0VPg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6BF7318000BA;
	Mon,  3 Jun 2024 03:22:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 03:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717399351; x=1717485751; bh=iRa2cddmJ9
	2v5HRJJlAQjLf8yS4MlDMncwNUPFrka2Q=; b=nAhASkz0K4gtHvfM16Q69madNT
	BigvMKIc4G3+yGSpi1M3/S2B7K+NeWpvK7ZWK8zdS0lwEMavakD5vO0sjuQ8cF1D
	aNCoaOhD1JkeHGS0UEL1GAEWqAkMZOLrN9DuIISSBIpruNaMl0EKx/1Edj5/iDvp
	vCoT8r+xfBPr2/g/nnp9f5Xetnnc3cQ/x+2XFDpMtFnLaGI9O83Jk1Ckvf2wGeA/
	MIAsV6kgG/aNMXduRHc4oksEUtosJ8BngNzLDYSfyokpHi/RnXtfTBUe5BbLv8Dg
	jYyTnNsy8gaUGicn5E4zCimGzWkfqxgSt2VTVwPy3VQkTUBeNf8xzo8pKXYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717399351; x=1717485751; bh=iRa2cddmJ92v5HRJJlAQjLf8yS4M
	lDMncwNUPFrka2Q=; b=Cv+P0VPgQWnr+vdyaIQ/Gwl3Jc16aB3McClsmPmsFzZF
	8XrogT1jZ1D41yXJO8cr2aMLFzJfshAHyOs9hyvp9ztSBNEavyW9G1B2uh4I2syx
	LrIMSPSNcOptxV+jsmAj1z6PPNxcDos6w77+NEkuaocjd868ASR42uzR+7EtiYK+
	9QE2KyUQEQ9b0l5GTbJm1Ne23Vx5qW369IJwwHiDXqo8SxC9jRxfEzTB9cWZXWub
	Y2fVvodkdy+/5GQjfN9dxRItxE/4S2lD+M6bvN/pABCrYMIHuCvYeZw1iaZyELzn
	xoGMl38kiN4WGChPaopK+jXd3wiohtwdMiu8a9fZnQ==
X-ME-Sender: <xms:Nm9dZiQPQMI1pz_2gvmYkQKcjbHtCw4-tpDnOs_5t7ziA9K7_dWM2Q>
    <xme:Nm9dZnzmBriiMad-8NN4w3EFN5vf8W_yFaic4-2YrqbiJbi_ZeMYuv38Z4FZnD4R6
    4YcHF_Ni2iMcA7PNQ>
X-ME-Received: <xmr:Nm9dZv3is4d9PzXZQkYxQuFgI5AgHhAVW_tCZ68YQK2_PmnueJy9l2cR4NniZV7k6NOA2Lc_s6wiH2T4ZsJMyP5SFf9DtYV3ZmRIjjZRx1RfRcZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeluddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Nm9dZuBfplH9VEw4Btp2xrg3NoWCYVjT9oa2Vk0-6ODncyEPNvtKZg>
    <xmx:Nm9dZrjWvRz9VfYiytGGzCUhW8thujHxp9juQYqRX6rAvJACARPU8Q>
    <xmx:Nm9dZqpYRM7VyNaV36gojVYJyU1CBknIv0Z9q9BgKQ5hME8cI3iOCA>
    <xmx:Nm9dZugNGNbaoTeVe7Zy0q8FNuKCfBCo7WHA6ot70yZHPdJsmOM3jQ>
    <xmx:N29dZotpG1YPLS5zdzjg9CzlWDSevj8yrTtiVu_fampwMx_6DL02pGLJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 03:22:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3ad79d5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 07:22:03 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:22:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 2/2] refs: add name and content check for file
 backend
Message-ID: <Zl1vJNxOFh-Abj5Q@framework>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240530122753.1114818-3-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1gA3oqrm7GHLyD+0"
Content-Disposition: inline
In-Reply-To: <20240530122753.1114818-3-shejialuo@gmail.com>


--1gA3oqrm7GHLyD+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 08:27:53PM +0800, shejialuo wrote:
> The existing git-fsck does not fully check bad format ref name such as
> standalone '@' or name ending with ".lock". And also `git-fsck` does not
> fully check ref content, the following contents will not be reported by
> the original git-fsck command.
>=20
> 1. "c71dba5654404b9b0d378a6cbff1b743b9d31a34 garbage": with trailing
>    characters.
> 2. "c71dba5654404b9b0d378a6cbff1b743b9d31a34    ": with trailing empty
>    characters.
> 3. "C71DBA5654404b9b0d378a6cbff1b743b9d31A34": with uppercase hex.
> 4. "z71dba5654404b9b0d378a6cbff1b743b9d31a34": with not hex character.
>=20
> Provide functionality to support such consistency checks for branch and
> tag refs and add a new unit test to verify this functionality.

I would recommend to only introduce one check per commit. This commit
introduces multiple different checks to the files backend, which makes
it harder to review.

[snip]
> +static int files_fsck_refs_content(const char *refs_check_dir,
> +				struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content =3D STRBUF_INIT;
> +
> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
> +		error(_("%s/%s: unable to read the ref"), refs_check_dir, iter->basena=
me);
> +		goto clean;
> +	}
> +
> +	/*
> +	 * Case 1: check if the ref content length is valid and the last
> +	 * character is a newline.
> +	 */
> +	if (ref_content.len !=3D the_hash_algo->hexsz + 1 ||
> +			ref_content.buf[ref_content.len - 1] !=3D '\n') {
> +		goto failure;
> +	}
> +
> +	/*
> +	 * Case 2: the content should be range of [0-9a-f].
> +	 */
> +	for (size_t i =3D 0; i < the_hash_algo->hexsz; i++) {
> +		if (!isdigit(ref_content.buf[i]) &&
> +				(ref_content.buf[i] < 'a' || ref_content.buf[i] > 'f')) {
> +			goto failure;
> +		}
> +	}
> +
> +	strbuf_release(&ref_content);
> +	return 0;
> +
> +failure:
> +	error(_("%s/%s: invalid ref content"), refs_check_dir, iter->basename);
> +
> +clean:
> +	strbuf_release(&ref_content);
> +	return -1;

Can we reuse `parse_loose_ref_contents()` to get rid of much of the
duplication here? That function would need to learn to indicate to the
caller that there is trailing data, but other than that it's already as
strict as we want it to be.

Other than that, Junio has already added quite a bunch of comments, so
I'll refrain from repeating them here.

Thanks!

Patrick

--1gA3oqrm7GHLyD+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdbzAACgkQVbJhu7ck
PpTELBAAj+kgpxSDbHTS+1b9viFESQPhhbcGQeoUhO7CXT57SkliLgsIykfW5eR0
u6XEq3gnFnYRcJMPfTIpAFCNmked4+NXpV5kimg1IhihNjgq/M7YOd/Eyt3lWJI/
QEDoYb+bzlYb96WyeuVe/n1KNlWS2CvRrpJBvEZo2O6N6XlghzrxfhQfTYPfQvzZ
Mzv1uf4Kon/jsX/lygPG55/AcPAoGnCU6wCOBvLSXpKifwHJEvLhrKFu0RGjsII7
co9K0u9oMFBvVC8KuHHssPU4gQIcUb444PlO9yeN63m1qMh4dk/ceaikq9t6g8LD
SviJeSNmCTO8hPkH3Kxkq8iCrbk7CqLQe2YM+wVtI33B3jeCLMIYlRepOsoI9WIb
+jQreOFmHmsvsjbrGKZJlkkERX9fU6ozQrfo7rjCxlMGe+8bQY8O7p4S0+dsP6AF
hhSjDouugS0jv3NYFyhrVmPLys1ZkEQAYKfBOhZB7LN+5nLznywo+A7oTX47VfbC
oJe/SddIA6bQwRj5C1M/BhVPqonlqi/t+G2S21II155VTN2LgUw+uS697CKvDoNg
Nf19jFD8+dNlHoQy1ZlkvfG97Nub1viHKUkjqmqNKYdEvJtyyLi7p6CzUOlO8BJi
/u+EO3VwZTjt1n8tbN0M4vzHby1wHQ/V9avbBfL180ZoXuOfwH0=
=VoUX
-----END PGP SIGNATURE-----

--1gA3oqrm7GHLyD+0--
