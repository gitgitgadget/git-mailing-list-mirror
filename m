Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8C1428E8
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593265; cv=none; b=nDCbUjcpifNUYR17TJVGRQ9zNomN5AUW/kgBK/HXITyAIyNyZMFTZLqlE5awWSX+MCgDU7Hlgduq1Ixp97b0Wi5tGMUu48yPsv1ygAdm6msMnOGo6MywTaw3sKXXEaEg96+f7vI86wu2DjTVRc7EluiVxMB8yPZfvCbmS50NRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593265; c=relaxed/simple;
	bh=qPNX1ZvXfvD8lc7K2v9haliQ3lLym4/nE1LzoDnQB8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpap7QksBWNMEhPzbA/BVoTSE6O3iMb5orKMFekqrr7KWb+kuh4Pug6yyfGpDRwiBVawBtCncG350xMO9KxhgmENN7jUWHleWDNQpxejkDkCoSwTWyg0J0t4XwWk5z9qtxMPgvN7vecqsI3P7IgdbtJB0SOx1YSu6zQ7npbSxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=auRQgeVX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0C9y29T; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="auRQgeVX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0C9y29T"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D4F2F1140153;
	Mon,  8 Apr 2024 12:21:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 12:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712593261; x=1712679661; bh=xuHU4V+wwy
	r7u1zk9tcxViCi/YA+9h6OVbASYHH4P2g=; b=auRQgeVXk/o8xmDAc6VDiHd2u8
	s4Uh+G4ixaBHhneH3uWC45KiigFJUmuQBmoJbRwETmkMNfwWTX0B6gEcT+kbvOL+
	LZR45j96iBc6xUOZbggDFiVjNGCwV4aaF8ts58vJOGT9xpqb3OOIYxkrKRss0t/W
	5LzeWUtYD+ABM3a3LhTwDLa1AGuQaT2LE/nBuUN6dDVOUu5Thj4BPacTCZ/5rOap
	BCLejBFBmoVEz7v/HQdCHYHEWb1infV1fGjX5wlK0QITCEV5JHPdtFwrRvDHqs4w
	mxJEV8mFWW8+XZEk7Gz1DgYIcuOXowUsMafMaCMZfGS4ppL5l9xXVmqRDj4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712593261; x=1712679661; bh=xuHU4V+wwyr7u1zk9tcxViCi/YA+
	9h6OVbASYHH4P2g=; b=D0C9y29TZRtjfLeu8F8m60qoMB8dTQ22Km340ttftFFP
	E/iN0Nf+rWZ+LDQT1i1oTTwlhqrapNOOv/peUcyfECr/zw3doqCEG5C2Wmx5E7NB
	uYYyc7w1cosV454MOY5rI03kkbhMmtC+EiSBg2BrRZAdd7z+rWn07/NdLV2uYnbn
	AbJpSvrPjYk/K59czs0wF+ZYrbzyOf/M3j3kCyCEznpuDMQSQAMCd0/HyCeV/Lwz
	Hqd2cM9YpFqZ/e8yURh4Gab9Uh8YIgHf3iSUeerDapFXXLgI/moiFHXs5ZpV5BQ3
	psWy2D8JxUAD4fiTX6CuPDL4DiPCO6KKdQRlMY0VGw==
X-ME-Sender: <xms:bRkUZt03SSVS6V8kf3YlwIXnSDLKdc4kkGEiycG1_Q8L8e0J7Bzmkg>
    <xme:bRkUZkFzDxaNdaUJoBrVeYeyK_4SNQY-APZbn-lTDV4uRIkIhVIFD0gq1UfCq6Jve
    hopjSFToY4va0J9iA>
X-ME-Received: <xmr:bRkUZt7QbNsB4JKgtBLK_CNqu6dXoGHiMlm5Lo9nMhmFlqKN-plOjUkEd-jwGouSk-MRZylMspw7Sz39vTBVFUnlcYesv9kD7tqTN5KVXKPhyvAnJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bRkUZq3Oh4ZbTXzPfb8Em0rJiGqsJcUmRlXVd6msfmDnH34ZZY3w6Q>
    <xmx:bRkUZgEyQhULMByxZL243tRsHIqjgmeJ5oGdyhuP2mYuZ29ha4v8Og>
    <xmx:bRkUZr_M7v3bdjq2yyDuoFvyT4JsmziZwLJh5IgLhs_9D-ckYCmyqg>
    <xmx:bRkUZtlYUn-hvoOwto_w2xQe-YUUZPE9djnJrU6QPYA2Nrm09LdHXw>
    <xmx:bRkUZlOQWh_oWPz-kWjul-xNJSXoYVd3JIjMfr203_UQKS-NxQabdGUl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 12:21:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ec40e898 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 16:20:52 +0000 (UTC)
Date: Mon, 8 Apr 2024 18:20:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 0/3] reftable/stack: use geometric table compaction
Message-ID: <ZhQZaI3JcShhYwXn@tanuki>
References: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
 <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6aiX8pVJek98P9ax"
Content-Disposition: inline
In-Reply-To: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>


--6aiX8pVJek98P9ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:16:52PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> Hello again,
>=20
> This is the sixth version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compa=
red
> to v5:
>=20
>  * Reworded commit message to more clearly explain that the already exist=
ing
>    configuration to disable auto-compaction is being exposed to callers of
>    the library.
>  * Simplified expression to set the disable_auto_compact configuration.
>=20
> Thanks for taking a look!

Thanks, this version looks good to me!

Patrick

> -Justin
>=20
> Justin Tobler (3):
>   reftable/stack: expose option to disable auto-compaction
>   reftable/stack: add env to disable autocompaction
>   reftable/stack: use geometric table compaction
>=20
>  refs/reftable-backend.c    |   3 +
>  reftable/reftable-writer.h |   3 +
>  reftable/stack.c           | 125 +++++++++++++++++++------------------
>  reftable/stack.h           |   4 --
>  reftable/stack_test.c      |  77 ++++++-----------------
>  t/t0610-reftable-basics.sh |  71 ++++++++++++++++-----
>  6 files changed, 145 insertions(+), 138 deletions(-)
>=20
>=20
> base-commit: 4b32163adf4863c6df3bb6b43540fa2ca3494e28
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2F=
jltobler%2Fjt%2Freftable-geometric-compaction-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltob=
ler/jt/reftable-geometric-compaction-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/1683
>=20
> Range-diff vs v5:
>=20
>  1:  a7011dbc6aa ! 1:  9c8f6b336ec reftable/stack: allow disabling of aut=
o-compaction
>      @@ Metadata
>       Author: Justin Tobler <jltobler@gmail.com>
>      =20
>        ## Commit message ##
>      -    reftable/stack: allow disabling of auto-compaction
>      +    reftable/stack: expose option to disable auto-compaction
>      +
>      +    The reftable stack already has a variable to configure whether =
or not to
>      +    run auto-compaction, but it is inaccessible to users of the lib=
rary.
>      +    There exist use cases where a caller may want to have more cont=
rol over
>      +    auto-compaction.
>      =20
>           Move the `disable_auto_compact` option into `reftable_write_opt=
ions` to
>      -    allow a stack to be configured with auto-compaction disabled. I=
n a
>      -    subsequent commit, this is used to disable auto-compaction when=
 a
>      -    specific environment variable is set.
>      +    allow external callers to disable auto-compaction. This will be=
 used in
>      +    a subsequent commit.
>      =20
>           Signed-off-by: Justin Tobler <jltobler@gmail.com>
>      =20
>  2:  7c4fe0e9ec5 ! 2:  c7bc7346540 reftable/stack: add env to disable aut=
ocompaction
>      @@ refs/reftable-backend.c
>       =20
>        /*
>       @@ refs/reftable-backend.c: static struct ref_store *reftable_be_in=
it(struct repository *repo,
>      + 	refs->write_options.block_size =3D 4096;
>        	refs->write_options.hash_id =3D repo->hash_algo->format_id;
>        	refs->write_options.default_permissions =3D calc_shared_perm(0666=
 & ~mask);
>      ++	refs->write_options.disable_auto_compact =3D
>      ++		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
>       =20
>      -+	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
>      -+		refs->write_options.disable_auto_compact =3D 1;
>      -+
>        	/*
>        	 * Set up the main reftable stack that is hosted in GIT_COMMON_DI=
R.
>      - 	 * This stack contains both the shared and the main worktree refs.
>      =20
>        ## t/t0610-reftable-basics.sh ##
>       @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction=
: writes cause auto-compaction' '
>  3:  8f124acf0f8 =3D 3:  d75494a88b0 reftable/stack: use geometric table =
compaction
>=20
> --=20
> gitgitgadget

--6aiX8pVJek98P9ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUGWcACgkQVbJhu7ck
PpT0uRAAi2BA2HNrMugpkfE+xuMiFq4s8i4rXephrtzrGzWbm73onY/hqnGx2a99
EZQqnaLklrzyFpflO84Kabovips6zcRh22q3U2yJzUTiq0qHKR/5uxncyDr2KWKf
NYybaVFCbjmAkGD/l6+HNXETXiabHiespzqR9MIw4Ixorb1JWuBR1uLaqs/zr1Wh
ZVCt6W1avpOKMDebJ2oKyhbBnJUDsQILl7VzWY8kp27ffwpZ37eJ06pZXmj0aV0E
Oh0A7iZY7grtfZvEWf3TP7rKag9VoYVVnMSk6EJVzIP0Uy2itrutL+aZzTDP5zPq
Sx4P4S9t2dyG8QvM/Xy7csm3M1xWZ137mf9NrdkfPtdOUgUiCK783GVmTDBHuYDN
OxW8PiP/pmw/EnxcR0wSjOmFVM574+IyURS7GnsQILEcrDY1ndu1SIDE5gIIIr1M
alne9LLNdJf0OwcmOfzfxprye1sJi8SoFA96wc3Q6U/lHKsXluYp9jeid5IUNwlv
6ZEroRbqI47uPAZiR04ztcfqcznMi6kxyE90LKO/okxEeE4cCzeiYY1W9TJGst/r
nxftolGUHB3K2iLjHQdew0IIb97UVmpp/kW89MbzRYuBGBJCI4IuuU2JQdTLEvHf
xZZvFQPLkBsJMHuNRKsJ+H30LGRirZgLkEvssY93Shl+ASh718w=
=sNNN
-----END PGP SIGNATURE-----

--6aiX8pVJek98P9ax--
