Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCF21A0A
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816938; cv=none; b=i3N+cubRxKUTIJ24Poe2HJ2sUPMa6kHRuKwV5lJaalIVN9DDxsgl7LVFP/EE4Ohr3g0q9dWvgJKQDh14ekKRXH9eaZEVfYd1pAmrpQJVmIoeqJMrzVXd3XK/TaEYZL2cuk5ozD0TMi6QuveZfbqZNvas1TNtBLbPuO3kuiiDRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816938; c=relaxed/simple;
	bh=KRY6W9rINURWOL+VHH14biDj8+kQ/XQ5EDMOGAfDcSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhjBXCBUH7VSwcuhR3+FfoUgOXRzMDNpf9MUiHbmw6kflKBfT41bEV5sg44P2BcxfQZVGLrPCNsaNfq2ZFcYHDwO/Xf3uhAsIh1Jiofr6jxVxw98gsmV6lI/XNxK53GbB6c94yOvS6G8+3iuh7EqU3NyDLt3b620gbaiqAVdQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amJlBN1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ay/Jy9kS; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amJlBN1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ay/Jy9kS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4FDBE18000AB;
	Tue, 13 Feb 2024 04:35:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Feb 2024 04:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707816933; x=1707903333; bh=UyEg1CoeNw
	/9uaX9dTF9N1n2u4UjgbqyhBwPox7aCBc=; b=amJlBN1AihaVUnax2e1A4J5YQ9
	v0Hs1rdLVlVPh7Zx/rO/FJE6Bir19mk3V5NWxDr0YcgokTW+RTmSH6yOEmYmtHLn
	g0vUwoPemUvBHUwYI2M1Jdz9MXdLtFoBf1MApzC1fWniDqVtl/ZIBYS10zENxmBI
	BW/gpsWLTZCYeS7W34c9IoL06Z3LFWrsYzWwzPJe1F9Ens/R2k+ZovQuHNE+1bmG
	anJfMJlfsr9c7Brm874NreCXg/xtHMpKxvu0cuknUmRPkj7XGXzJGW6EXBwiYqHi
	5kkfBMr+BOC+BCvHusKXiwkBdRRFsO8O30pNx3m/HLux73U7LzkuA/1asM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707816933; x=1707903333; bh=UyEg1CoeNw/9uaX9dTF9N1n2u4Uj
	gbqyhBwPox7aCBc=; b=ay/Jy9kS5X4c/gcoLwfA+Qx6MbbFi9E3N1CnDDc24prd
	xKzigvbw6+78PWF0r9hTVCTvMLQBKo+j7rYC0z3sIN/5C5hli8lFb35sH6DTEHOR
	SEPYuJC/caQsE6ABtQ2ickv5Y2Zrjs0qpPk273GtJLgjw5NGWd3c2jb9d5JP4Mi7
	RaL/tGG28a7ns9J1KInaA7XrYGZd6SOiC6tlabXKDRC3BQSbVmWeeHnhc80MRYE4
	xVciwgKe+m2U6cgEUWrshXEbrfzlmyjEV6cMkeqWRmKTlieCTx4K1pkuNPfn4XHW
	zwMxVV4rsg7/4fZMHsKBOBDqW56kwsyZPCKbPVs50A==
X-ME-Sender: <xms:5TfLZV1XXErv_K9NyhganppACgq1yjPRDprQsp7bKa29fLDFeki2AQ>
    <xme:5TfLZcHcgBfrOv4pgUXEO7WDge8r0nuGx-bcENzWvKUF2eNvHfaCsBkVtHsjguOj_
    MKBSt1dx-FyfQlMng>
X-ME-Received: <xmr:5TfLZV68f58l9Dd7LssxwPpwbYQMRgoXlhZj5Cm7zwGJ44Waj5KGrkapIfHx73gzLQ3Oe1vi4kt6vK447_T2vEncXfwVotgL0Mi407Rc7QhJ9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:5TfLZS0UKxzdmTgqrzHM7TqHVRmsATcEitWj9WECikYPNmgd6u_rWQ>
    <xmx:5TfLZYHJN44rk61qLsTNX1NRk6apKRgkewvng0w3ktPV3YMYVlNO9Q>
    <xmx:5TfLZT9Onc52AJt3MjKiQgqjA9ADnG4koOB8duBgE8Nf6HEevaqRgw>
    <xmx:5TfLZcCco6uWbAmsNff-YlYmBNbyzVA-cE4Y2cCch_8oAdnIfkEY7XcrUWw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 04:35:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2069a23d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Feb 2024 09:31:43 +0000 (UTC)
Date: Tue, 13 Feb 2024 10:35:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 0/4] completion: remove hardcoded config variable names
Message-ID: <Zcs34kGTqTbIana6@tanuki>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/af/kQS0Aim22S3c"
Content-Disposition: inline
In-Reply-To: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>


--/af/kQS0Aim22S3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 06:32:19PM +0000, Philippe Blain via GitGitGadget w=
rote:
> Changes since v2:
>=20
>  * Moved the addition of the tests to 2/4, and tweaked 3/4 and 4/4 so they
>    simply adjust the test names
>  * Added a test for user-defined submodule names, as suggested by Patrick
>  * Added more details in the commit message of 3/4 around the use of glob=
al
>    variables as caches
>  * Slightly improved commit message wording and fixed typos
>  * Added 'local' where suggested
>  * Dropped 4/5 which modified 'git help', since it's not needed (thanks
>    Patrick!)
>=20
> Changes since v1:
>=20
>  * Corrected my email in PATCH 2/5 (sorry for the noise)
>=20
> v1: This series removes hardcoded config variable names in the
> __git_complete_config_variable_name function, partly by adding a new mode=
 to
> 'git help'. It also adds completion for 'submodule.*' config variables,
> which were previously missing.
>=20
> I think it makes sense to do that in the same series since it's closely
> related, and splitting it would result in textual conflicts between both
> series if one does not build on top of the other, but I'm open to other
> suggestions.
>=20
> Thanks,
>=20
> Philippe.

I ain't got anything else to add to this patch series. Thanks!

Patrick

--/af/kQS0Aim22S3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXLN+EACgkQVbJhu7ck
PpQOAA//dUAKQdKJmN3fBAwOhQ2wUQqzVCiKGzWjig7jxt4FAkt62G7wcDAWQeMn
v/SLdDMy3xAC5BFrb7m80MC9AB8p8FaXIUMx9NXrxboSRCyj5jVQ8OWIBD+SLnSP
qL2UEuzcIkGUI2agXwYyQTVd5SsmJWvPBInZc2QlEO9dqhj7tByw2uggCs2S64FS
CA10g8jRexxo33s8HCBdlxyyc/caF280BNl1X81eP4ljCOVSYbeq/LQfoWcAHOTh
x/Gqiu3kfddpbtzHcI+wjbXnbhZ3DlrtYsNe3Z6JtBTIcDqFKZMZQGfi/lh3PX3q
GC7wCn6YEVaSc4hsg0m8fuLtynkQhNGZMXMvOYIT60HhxW2rCQcUIS2L22ydJHrE
7k/1+lJ2pHQHyqRPK+jDZxSVJyssNdk650cNHtF1IdPPwoJl2b0L1+cc0V4q23uR
1FLXTTN5/3VrPY/x3LCSgd+HYlHDKJzv3xGLGCLR+2WXnfBjEobwWW9hOjaQ+W2/
Xu6PKa7N9P/jfH7BQVVo/POcnQDoDv4I1tUhsgG6P0IYpIUkNSlALmiGPiv/7lE7
4WIUeDoSCPpDyD4zpMrqTsN9i0hG+hYgtGKAXFScuqUGQfbBE7janUBRSjFOSJMG
MB+CO1M17cne6HsSaSBlPsMB33gzaBHbE7BPRGa7Vif/nkkKeKI=
=6Axs
-----END PGP SIGNATURE-----

--/af/kQS0Aim22S3c--
