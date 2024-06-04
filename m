Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77888140399
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486973; cv=none; b=cYrP7YNwp6Apyp5toC3Fr6oNoqmKLUbAI621YE+aoYVCgP28YuLeu5xorAx1cQgmkoEQTRpBntyo2uLkm7bLK72PTdjWUi+egFG1bJNBLuv/WkWRlubqlqHB8lYjrAH+w6oxoHCfo0KNP283pjXLzXXYD/lcuuvxkZMO5XlVlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486973; c=relaxed/simple;
	bh=gsPIF6zYj8wzTPRk4N2+u8m0KbTgmxr+KUA+xgpKIIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUT9sLshbxO0iR5FJO18ZI8gRtoh6CA/UNcHYGE4wxgAZKybnvpaYfveL0n2LRwf+6zmmST+VAlxkBHzPeBJYJ8OJwRnAeiI3+XCPg3I9NfR2Q6Gtm/7TFGSzh8zc5rOEvlGcEZyq2SkZQihgNDLaJtD2P+utSiRntwpOqn3X+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YKJ+sTFP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AixClCUd; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YKJ+sTFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AixClCUd"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6066B18000DF;
	Tue,  4 Jun 2024 03:42:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 03:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717486970; x=1717573370; bh=KeCUpXad8A
	lxUDgP3FtZgCV2ikZdC6ToDZjw4nVC0hU=; b=YKJ+sTFPiBq3SSSg9MbF2beDP6
	Imk/vE46Q1YD8r5lMK6hhBH9csMjc81fj8YxdYf/x/MaxJFQv+H1+fE2U2MAQSpK
	30qLSwM+MpW4699OaOSmOW8JN+uoHWn6IH2cVJbNznX8jYm8LjUfZjc6VV/s002x
	PjFYcvOar7eW67m2uQEdt03nBAih6gvnx4eb9H3t5vjwxI8ALz8bKNxKkvYQkx83
	FtWjRuwSL2Ig+ApnqAJVfuz8q7cvJIvkGDmumjHwz8M12Sgrd/6BfmsPwTuI2VE/
	m4D11/axVQWw9066sbfDusAgCewxT3rsZVaCXEtXjK2tB13a1P2wVPqBGNCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717486970; x=1717573370; bh=KeCUpXad8AlxUDgP3FtZgCV2ikZd
	C6ToDZjw4nVC0hU=; b=AixClCUd5KSMh/X1e2JmtcGrve3Bi62IDSDt+Pbal9av
	jGaPo5UqwBeXLzRXvVo/sNSgjfgtDweiLarzOri3yrD528Ffx+pPecWPLyq1BQ48
	2+q1cReS82zNYVsT1tYZ2DFmMMrCOJQ0qwk/oIUWfVPM2GVF+jCT67zqnuwOzBIT
	snpZUqosQF2J84fzCCKoVyrsStpOBwnNSjqQUmPceziw+UhS4xHPUSMQfxPLVeCh
	EJd4TXFrBRpwkiOsO8kp+6Ks1BqmdxYQ5ZauXJC3MXVrtBFRC77J5hfY9Z5PnQyu
	XFDdHMX4FB9iNlalXSxovGUO6tX5VWQb59/RpkLGyQ==
X-ME-Sender: <xms:ecVeZg22P-IXFCBnP7T_SB8RTz-QQUDwVVIEVhzYgE3FC9uL0CkISA>
    <xme:ecVeZrFNovQ9ExGL4kxTuFSvnBesuDl4Jo-sxqa2fLcidwMWoJdphES3q0qE4QjGW
    UlAL9OPFO9gC752tA>
X-ME-Received: <xmr:ecVeZo5ydA-4NfZ2qwUoxrk1T_PebZp-8gBteg0X6WNUUTW9I0i5nhzLm6nPTQwCXLyecr2OlKaFCUhH-IRe2mOXdt3w5oMkn4X62xfC0OfcTQg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguth
    cuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeuledvudejgeelgfdthfeu
    vdehfeelleekveekkeffgfeiheduheekteekvedvteenucffohhmrghinhepghhithhhuh
    gsrdhiohdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ecVeZp3GSzcQngQozZKNt_DkImVg2rflWjRJf_SuqjrqJUp1NwZuRw>
    <xmx:ecVeZjFjtBq4jhiidyzaFmJaBsu31uqRapuzdRXJXUuEAKrOiMBmUQ>
    <xmx:ecVeZi_e_t8joJqLu87foK-0622Lf08VkM3DF_gNzuKCzLrrYuSg1w>
    <xmx:ecVeZollFGOU0Vcmeb02deGBiCTSZQWV9bW-XzP_eutfyTOAw5ky_A>
    <xmx:esVeZi2mbui6VlS_YlMPZPB02E3-9y28khm8hTMQZBb1VdI5Qvm3NadW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:42:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aaa93e1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:42:20 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/4] docs: introduce document to announce breaking
 changes
Message-ID: <Zl7FdB2juCFkHuba@framework>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
 <993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
 <xmqqr0dhgc1e.fsf@gitster.g>
 <Zl2Np9qNcA6Z1q5U@framework>
 <xmqq34pu6lwm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5AVpz2OXx3uscq/"
Content-Disposition: inline
In-Reply-To: <xmqq34pu6lwm.fsf@gitster.g>


--D5AVpz2OXx3uscq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 09:17:29AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I would definitely call Git 2.0 a breaking release as the changes to
> > git-push(1)'s defaults were quite significant.
>=20
> Git 1.6.0 was certainly a lot more controversial than the change in
> Git 2.0, as the end-users never expected Git will change even with
> ample pre-warning.  We originally had all the "git-foo" in $PATH
> since 2005 when Git started, and we announced that we'll stop doing
> so in the release notes to Git 1.5.4 with instructions on how to
> adjust the scripts that use "git-foo" form.  Even then end-users
> (back then they were a lot smaller population---we are talking about
> Aug 2008) complained quite loudly.
>=20
> [Readings]
>=20
> * https://git.github.io/htmldocs/RelNotes/1.5.4.txt
> * https://git.github.io/htmldocs/RelNotes/1.6.0.txt
> * https://lore.kernel.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/

I had it in my mind that Git 1.6 was controversial, but I didn't quite
know why exactly as I haven't been around at that point in time yet. I
did read through its release notes to double check, but it seems like I
missed the important part even though it was up front.

Thanks for the history lesson, will add!

Patrick

--D5AVpz2OXx3uscq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZexXMACgkQVbJhu7ck
PpTV5w/9GPoPDsvsvcTWEfv8dA6C7g1LRnO2nQDp84rDPk8vDvK2ZZ59yUoDTt45
cbvivE4zU35XotIpwQda0U0Zn5UgW1N/XXF7u7f77DgeHwAIzZN1wwcqB24SIO6y
fbbUfDGzK51WxH8swiSz2NklQlB5UmBelCNjzhb9lFjGAo4gcWgE9N9kF9+b4i3k
svMPE72MFCiDxldFyK4VClTW01GJdxzNXkZk4KSUsj+SnNGBv6Xic1BE3r6CIH9S
B7Xyh3ayIFG2iDw1gQyCKJVQGcyQzPf8/9nKzVKBqL8LiniHzMRiOYVxA+VoiTlF
xZH7HECc58b6iB/Usj6beR7FGT46GnYpROtODE1P04bwprL4yH7GqqBcJlFFGzZ3
QqlomQbT/NvlzCoN10s938f0NvwwbgZP0ya/iK5y3dt6BgKh/BGURmacYNSHO8ho
2wGSqR3wQYUgHy6dRe7URX6RLpaJkIkoNkahSyDMrmcvMNrUdJ4g2GlUzE8D4Bc/
aYWN6jK2Ku9vH/H53E30SkCJRIvS9osx4uPe75xv33xWKjiCo37A7UTNyTpfIkac
1Ui+ZbXQ6YM+p9eQXHbNtUINv440d4f0rqDkpQmJnyDZpuJCH2xYuvovjHpSpyqX
qN4ZoxJXg5a08taOvi4eC5yV5kc+sZv4tEkLndiEiH0cUyvdV9M=
=E/7Z
-----END PGP SIGNATURE-----

--D5AVpz2OXx3uscq/--
