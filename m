Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8274ED8
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661135; cv=none; b=IpcdpvvAjgNhhXlDHrBz766tH4YBl1G7Q8mub0ZhClzNXoZZIK61z78+m/ZzP9CvbJATSfLd1LEOmHMnM3eSbR+dOnhcRsiH29brAL6bs+6KMuz3LUtQL5VIl4KDrPoZmpkpv7jSASfyc0lVlYhoIk0plsoH9bbBNzJQ//lyNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661135; c=relaxed/simple;
	bh=Xv8zcFfm9WHVd1tbrDvOXhVUmPP4ivaCcvnPg/Vyo7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEaPuqk98O3hidsMPM2vLWAmVo8DmWbe9X2zBh2qj3+iQz9YOYoHEiH+On7Q0seQssaQmZR3k05zgC+lVu6Z4Pj7AiCF3ArpsBzXhScklqNJTDzwCRpIYCpbgfgW1OpHcXgFB1bYVaWTsogLNCPrYCSVjKxvTYZjSwPDa1i46nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rGzUiuGz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKDycQd1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rGzUiuGz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKDycQd1"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0798B1800180;
	Tue, 14 May 2024 00:32:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 14 May 2024 00:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715661132; x=1715747532; bh=mOdicuqNDo
	qLNr8hhsVJlT9cxknOf4hPgLctQFAiJ+o=; b=rGzUiuGzNDAitxMZ+7LTZ+t15c
	TYU6O354mD59pc4B+HCvpaBpPWOenmkd3ZXEchTOdXvwlnLZcTSYBKQRiodOXtbl
	mC8oPHNJ1cGtsaVopCX3zmh4/f4TaogwQyyMi9ah14QFnjPkdTEozyk4tdUoLe9B
	7ND3muJeE/oSBpziOFz4r0v8uNr0tU5X4s8FL/YkjimTlL2NJ5zDtsybeId1Wh4h
	NRipcA5tapr3B21t5yLCVg+VV9rT9zlBLEo4bfj19uczyXCeRacUfE+VQeKIFoUa
	w8AaB5RIeTDmHw3rNWelAzO/8dZ9bKNId63OTdwVXeCF0Bjxy2W+z9nwH01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715661132; x=1715747532; bh=mOdicuqNDoqLNr8hhsVJlT9cxknO
	f4hPgLctQFAiJ+o=; b=LKDycQd1FvjQxIHnRnY9G1X4GHZSzLtjQQPpFJlLk3rc
	kt/2D6HecW5oC0mEswqUpryTkfQ2j3J6d8OuLMiZ2LoGY4YwrUYhH78CAUsxuM06
	VGBpFAf93KsP5pB93f2yw8P7WxOVg5HEX8W1tVWROQIB/bwwcJjqsVFOv0O6uX0T
	UAas7e127IJ2V87oLtswbdWhoMEl8hKvoSSdY4CT8PKl69JZfbUSAmVl61e3WklL
	sOVRO5pmuUERE1xPGdTscccQlt0u5FwOI2CXgGGksW4Q6TYX1dqZFqiSo2m3RUD5
	o5tdPeBhsF1tbsclOO0GiP/+vMPhtpZHydc42h7pcw==
X-ME-Sender: <xms:TOlCZrNdHlGHXWAitzEZl90n7mMpQAIZzlE7vvXydkm99qVplRzfRw>
    <xme:TOlCZl_TFrXO-M75QPFFZ6LMeVjSjKWRdByQGaC754IpQ9v1rxBkxkiL8Lm0p9mbo
    l7NazZs5Rd9O3CzSQ>
X-ME-Received: <xmr:TOlCZqSxk9HZm5XF5JBhEvCSjUf1qmNv4Wq11Xdbj1ai9drpkLWfZTrKajQAC7RnECV456x4me9LOFHtTKouPkT_eT6JcHQCRplXNsvXIEPMiNWFrFNN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:TOlCZvtmjy3dqk5xVwOz3VAIUQw7NqTExe1iQSmCmfvyFh7V8t-NSw>
    <xmx:TOlCZjcfPBJjCFRwpyH0_pdQP2eZ1pbwsKyDuDz8k3PxUC_CD9BLkg>
    <xmx:TOlCZr1QP8GqM5ZYNZHXaJ2g4sq81x-lNFVn4joF_-C7N-r391ez2Q>
    <xmx:TOlCZv-_WPEw0bwGYvUrk52oWSVxFjB3fWkdsLGfyK4WpPvaiITszg>
    <xmx:TOlCZko84RkY-24gKEhc3jw8whs33jZwetlY8fBCXRdUSVfUqx0CAxhQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:32:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eeaf4967 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:31:51 +0000 (UTC)
Date: Tue, 14 May 2024 06:32:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
Message-ID: <ZkLpSW6TNcpKpg-V@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
 <20240514011437.3779151-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIR2+QZ79EqMWQP8"
Content-Disposition: inline
In-Reply-To: <20240514011437.3779151-2-gitster@pobox.com>


--EIR2+QZ79EqMWQP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 06:14:33PM -0700, Junio C Hamano wrote:
[snip]
> diff --git a/repository.c b/repository.c
> index 15c10015b0..f912ee9a7c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -1,5 +1,6 @@
>  #include "git-compat-util.h"
>  #include "abspath.h"
> +#include "environment.h"
>  #include "repository.h"
>  #include "object-store-ll.h"
>  #include "config.h"
> @@ -19,6 +20,27 @@
>  static struct repository the_repo;
>  struct repository *the_repository =3D &the_repo;
> =20
> +static void set_default_hash_algo(struct repository *repo)
> +{
> +	const char *hash_name;
> +	int algo;
> +
> +	hash_name =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
> +	if (!hash_name)
> +		return;
> +	algo =3D hash_algo_by_name(hash_name);
> +
> +	/*
> +	 * NEEDSWORK: after all, falling back to SHA-1 by assigning
> +	 * GIT_HASH_SHA1 to algo here, instead of returning, may give
> +	 * us better behaviour.
> +	 */
> +	if (algo =3D=3D GIT_HASH_UNKNOWN)
> +		return;
> +
> +	repo_set_hash_algo(repo, algo);
> +}

The problem with reusing "GIT_DEFAULT_HASH" is that we unconditionally
set it in our test suite in "test-lib.sh". This will have the effect
that we will never hit segfaults in our tests because we always end up
setting up the default hash, whereas our users now will.

I would propose to revert this back to the first iteration you had,
where the workaround only enables the SHA1 fallback. No users have yet
complained about the inability to pick the hash algo outside of a repo,
indicating that it's not widely used. And when they complain, there is
more motivation to fix this properly by adding a `--object-hash=3D` switch
to the respective commands so that a user can pick the desired object
hash.

Patrick

--EIR2+QZ79EqMWQP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC6UgACgkQVbJhu7ck
PpRSTw//XQlwhz7Oc6FFKuW0PlzLjp3gmAJiVtxJeP3RTzv5mXYz5HLGjNTXwKx1
NUzgpA7bVGLZZdtYMi/QEY7fyExacT8lrdHhf5tGYWadN3HOTzYOy4MjhBRjWPYq
2ApGHiZzbMtK8l0YVtgr/rUfFzgwOZCb8pOXPEuG0iB4yFf4go26p/FxgazpV1he
gKK8BnC6Di0nmzRrwOVS2z0a2H8M15RTjdw0On+H4hOQgw+Bj7I9Zwis2faCHVFH
QVvmi3JGgZ/q5mGLW2uIqhOVhBKko+Td5caW68/uZj2yG3HvAvp3zO8ImBs7+CJk
2PKZjUAD7Fusj57jxbfyhLNRk15GLJQLa1f0mi02FEGcpycLFwM0kitvsfCCiLSb
DSB8dkD3hR0pgGeJpHuzvLKy5zwcJG1zd7RChqZ17BEG0T3cocojNn44btQX8op8
EVg9QuWPSlIuf4U0EQrXNy8GEp0NL2YVSTPOPrmH9D8RvIagTO5QNuzrNdBO+Ccm
/Ga3VklIByAemhSyJs9wa9Z6edGSzEorkQtqWYsTZf0Kep4o2XhS4z8Fc4rxNtRF
O3TLcpD8oghdbFv4JIUOd6EMxVbkpIKPxxgdWlfs5OlkJsGt1mWTGpT4Nuf7MOTt
bqQH5lT5MbeFKN2aD0vAh50SlkkoeV86pJWeHd4HgI0QYK0CbZ8=
=17EM
-----END PGP SIGNATURE-----

--EIR2+QZ79EqMWQP8--
