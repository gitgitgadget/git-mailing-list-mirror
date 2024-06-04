Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486494A0F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484372; cv=none; b=eP6agmI42i56shui/YqqfLh5WgymFjJkVLtqBPUeUpheUQr40Lasc9C6bVRF0cGU1ybAO+ayZtDhE+TLIpKQMeCMEzheqdXcaOArvYuRLZLTZSxJDARrVhOFXXrl71vab5Z2xH7jUGZ2xxv1Gsyt0LP7fpuBLNM8znVjtLUSeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484372; c=relaxed/simple;
	bh=260bez3Q6RElwmYCQVAbDf+Oz/dOWwqIZeyA6iE9SRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ//VZHrdCdKpmvkXUtmR64t5VBksWVgg7Ltps5dmnt+kJZ/OejjXIsFNY/QBD5htxp+WX4I31v8uYXpZBCXRCA86274d5cGiwQ50U6tyP5J9jFoGhFhZPZ4AYOnP2vW/0/g0f8ZDg5qe+YBhNE3v1Rws25f0mjAn1utkRgWESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oFXu9sCs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8ZsKxzI; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oFXu9sCs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8ZsKxzI"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id DBB8F1C001AD;
	Tue,  4 Jun 2024 02:59:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 02:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717484368; x=1717570768; bh=260bez3Q6R
	ElwmYCQVAbDf+Oz/dOWwqIZeyA6iE9SRk=; b=oFXu9sCsTUSbOxhZrs/MNaQKGB
	INDMd4jLK+5PWiUAztuhOKw3rDQrdF5O1WXag0oAyqKT2UzhB20cP8ErtU2XRV5G
	xaLmuBGfvoJJSrxAHVp+LHRkmySmtvSTMpxynpwZBqtaNaztt63RIEfHmqRBbb6J
	ewakVwZl/ChQhCeBsjKqZrEWBL/g0A8WBDqtf5y2UxZsDBbiyB/OEpox/NU2HZd+
	/74Rvklg07W9/Ohi6DCYqyDWUE5TMzr3Nq3Y4d0CHhHOCzbhx1DpI6tEqhiZye5Z
	gk4dpE857E4xOe+NziQk1mznzSU7fxIT6estdpVRDagUtsVSmBhfUggefDCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717484368; x=1717570768; bh=260bez3Q6RElwmYCQVAbDf+Oz/dO
	WwqIZeyA6iE9SRk=; b=o8ZsKxzI1Lqm/EY0oywOC/8Z+IrxTOQ9Mb4ue5j9nuU9
	9AG4OZazniZYwmNGgMYxtTb+iOT2fDqJpMCzJ9avBB6ZHMU2hDKDepv5IS1HAv6L
	a+/fmBBCl35paEkDo/kdVWwipEgP2PYdX2/XAtZeAVlQS7iAf/46/vGbNsHns54S
	nSZRd0wgtjWf7AgDtNSSR6HqfJhrTX16scfREu1SUt/rxg0uDn009nKXvAGaSoZ8
	9g6lCFuL+jn3nrYHAFh3REmztVWzh3Rk2/1mpuWsI5WeYhLkKi3crTFQvtu3tYfg
	eNa9Gic0HykXZhfjbxrEpVyftqRW4pTm4WCFDf9wkQ==
X-ME-Sender: <xms:ULteZqJnVnzF-Jx3Y1s9IPkTGexIa9P2ooKfCyyyLesGtyO1tggF8A>
    <xme:ULteZiLIM9_kBDSIlB09ZIFjM4dQY0Fdba6T77kpVRi_DPrw-WmlZO2cqNap55xi3
    c_u8sDnSedv6Br5zQ>
X-ME-Received: <xmr:ULteZqsak4GfBGvh1llVNgW8rWKXJV3LK80V4SL0nNE4H3WTs9LEMwtB6Iq1mQhjPRsHbWlJdomrPzWfgHb9x4HXjHTkcMvjgp4zM92IWwGaL_B1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ULteZvZoH3rbD5fc6hcVht1H7ORV3Kn7gE3GP-BFw1Yh_QFu5PQ6pA>
    <xmx:ULteZhZ5uIoqYso1PfbkceB1oEw7x-U0LXxebsGXaB6ygMFbC8ujvg>
    <xmx:ULteZrDugwJw2ayNQwxeB0uSkFTzFh4BbLZceqCaKSBOQpdUUg333Q>
    <xmx:ULteZnZSfLft661CNqCruiwAKzZaXVZwltnzGgBJqmOMCZq9brS8Zw>
    <xmx:ULteZvMDunlhwrq8saXM2FBLnUxaZ6_E_03dzrsIlFCasKKr71vB4JCN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 02:59:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 740e9626 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 06:58:58 +0000 (UTC)
Date: Tue, 4 Jun 2024 08:59:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 1/4] docs: introduce document to announce breaking
 changes
Message-ID: <Zl67SnAQbtnxzAxS@framework>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
 <67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
 <xmqqv82q56zz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/yGb+SXUr3omfALM"
Content-Disposition: inline
In-Reply-To: <xmqqv82q56zz.fsf@gitster.g>


--/yGb+SXUr3omfALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 09:24:48AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +This is a living document as the environment surrounding the project c=
hanges
> > +over time. An earlier decision to deprecate or change something may ne=
ed to be
> > +revisited from time to time. So do not take items on this list to mean=
 "it is
> > +settled, do not waste our time bringing it up again".
>=20
> But you are expected to be aware of past discussion, and if you are
> not bringing anything new to the table, you are wasting our time.
> Note that pointing out an old rationale no longer applies to today's
> world still counts as a new datapoint in a renewed discussion.

Yeah. I like Phillip's proposal here, which adds "If circumstances
change" to the second sentence to clarify that we do not want to rehash
the same arguments.

Patrick

--/yGb+SXUr3omfALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZeu0kACgkQVbJhu7ck
PpSrBQ//f+NNsrcIO8gBPco3LezCfxQlcq0JUYuYXPuEtGEcXNMhaEXgfkVXdSYZ
r5PaGitfE71jeV5Qb1z9/NgWpwB9BJKENilnk/K5thfwR6SK3gqy3W8kWTIsb2mp
9kLG7MaOnH7Ho8Mz3lxq/9ulSia9NRlvcrAbiUUTIYpQxQiF1xUN/G+wiK2K4PkZ
7llaYXxc/E6DOEKPm8tcBu72/clBmO8w9G4+fMNz6hCJhVaUg6wnCP3n6aPuQJXh
YbFTKB0PscoP3VMp/EJGULDsUa0wd6Dos/ep6RYRDObEI6Jq/6EvtgbKuRI2osXk
YljpjMR0juYSuLQRTFSn9LcnS/+n0SHKrr6Al3C3CVHQ8CgU0cN7CL9+6dlbxLS+
VnFOXmUpfSTqde59KQBd3FyNyGRBS8ps73n+zwp8SESzX6vTITn959U55SWx/s7S
wxrAPiRUdzgUsq+QHIZbM5zMDwks/WmdaAtBipjnwd7bzCf28nrk6NKZiTtXJuF5
ADWLqK/SudCJiivbE5NKhwjIID9d9/blzUKLHM2garPYnyOncV8bYK43/WIFDG6r
sd599cWIhrzB/gCPhfFmr9MEGFXeU91D3rAv1KmoEbk3aY+uTZIzVxFbUYsoLgvz
+SDe+PviNCXDLWBZcCuPYK+ahjlS1Kw02OWS/2KZLx9MOuMPisg=
=19Gr
-----END PGP SIGNATURE-----

--/yGb+SXUr3omfALM--
