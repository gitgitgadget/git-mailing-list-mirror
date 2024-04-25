Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCD41757
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027341; cv=none; b=Xsku9d4+/TUIDl0KT4r5Jsp1Fg1G6746BVNaSbrRcyQS9rUXE4QpgGrF2MbNYz2oS062G3qCqPqCBl5/Yo8YGhmbjfvn9C1yfGMXdYC8CKFwLa3a3uuRusd04En+H6jvzKx+RVJJNYre70mS1YbxBMVFbD6TgHRZQ87WriyLGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027341; c=relaxed/simple;
	bh=R8xvwUoknZLL6IJ5tgYX72oXpzR48bmq5jq2psTbIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H76H8U0N9+QqEM0Nn5AOHMTEk5S7s9CsXLaXlFjpSY+EhW/9s1so5cLBDsbywE+Ab+H2xV2DkLgfIDKh0H63jFbt+1VpfCHkLkLs0AHAnr8E/Cp/tisVmxP8sulupM5V4IYuPkDCFkAdmU/kSFiuZYCAYMjQiTGTaqtA/X8u134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EdXB6RI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dn10eCjp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EdXB6RI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dn10eCjp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9B2291380142;
	Thu, 25 Apr 2024 02:42:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Apr 2024 02:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714027336; x=1714113736; bh=B11CAtq0vJ
	7gXCUvaTrZdPCVDD3zdlkNjO5snYfhORg=; b=EdXB6RI8IKSH9dA+h4DQCvBOzw
	w+WXRXE/Fk1f22nFwc88uFv2nm/guoWx1+Q8eU5h8JxJQZ5wGeS7KCIVmnhpnDy7
	ICiqiZxiTGNjHl4w0aJaffPplE/yEylhbmeYmrg5B/TXS9jA8T/PDwjJe9kMykH0
	89evek9JAtwjlQqoH7PxO/8j2a6h5qyeSuGW7v6dIzLwdn38DKF7laj1KMujaGcw
	TIJWtY5xNA1kvu+Lv/gl9iX4u8dGgFukCd8aTVsAatRHE3IzTPoO38zT8YwZRJq9
	yNUplWV2q2/48+y1k77aUcISGcEAE8uxEzH8sz/8cBfWDHImx5E6KiwF6big==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714027336; x=1714113736; bh=B11CAtq0vJ7gXCUvaTrZdPCVDD3z
	dlkNjO5snYfhORg=; b=Dn10eCjpP4fgREHVEe6WJl2KNmphKOiCtfeXL0bdATms
	HejavqwPHZ0e8xMbizjFNprOi6+eJ3iYBviEnRv6oM2hzWeo9OchFyFA/pOTTWft
	GESxcVfI4YaRdnBINpQF9CGynwb5PojOlE6yjUWr6zaRAWxWCA7YnigD0Bb0PhKj
	9b9cYwELYwFF6IbZIhU/uw128fq0pCON8sdTfKw1fBiB0cdDuWHSEEoNj82dz7Gg
	oMpBPoCisVKob4mgsK9ZUwmIb5L9ect83v2OIXxdcQIAeYtinMjsJE+GEuwZPfez
	p7wB3fQH3FwrNw7Bx7/TlbQShwxsiz0eBtiTVoDfNA==
X-ME-Sender: <xms:SPspZlv7hQBdLnYV4OT0kUlC2c0gIJZexYGxblNHydlrxG2x_61nPw>
    <xme:SPspZufjuYKU0PqQLCwOIrw_ui8ZucQFZWIYqaPpwdeYdLrp3dbgfAcpZCn5SKyD6
    UDh0Vz9ugU2zibg_g>
X-ME-Received: <xmr:SPspZozrOw57aYf1w0hGcY2Y1aiDhRE62DmHvBuqy6S8ZB1sjwQuQ7URKhstspOSEZuFWlpnR5Kocat_pLpZtulZFa__EktxBspmgbM-YYg6kjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SPspZsN-FrepRmDf_HIAZWZsUa5_yAz6xGZfnpf0M0pib77lx3G2pA>
    <xmx:SPspZl_vflw3BTQxmwIS5nTXwQVx7ByGMHaPCrfHslHYkanfDNus5A>
    <xmx:SPspZsXhlfuSNg004VHoQf__qbNrAYaJfGl2_iLfc0p_AlmdSlh7JQ>
    <xmx:SPspZmew4TGUitbv8calD02oX-KLMmye5igRDc2yb5SjZHqpp9JPkw>
    <xmx:SPspZgbbrGeOSVCyDQAWNLaIpi3Dv0yDucJBJNfn4Kla5BTy7e--rK2u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 02:42:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a62cbfba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Apr 2024 06:42:02 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:42:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
Message-ID: <Zin7Q6Xdg7WOBNaY@tanuki>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g>
 <ZiirKgXQPLmtrwLT@tanuki>
 <xmqqfrva3k9j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nc0HvJK71iVX5QCQ"
Content-Disposition: inline
In-Reply-To: <xmqqfrva3k9j.fsf@gitster.g>


--Nc0HvJK71iVX5QCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 07:31:04AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Do not close that communication channel on us.
> >
> > While I agree that it might not be a good idea to set it for our users,
> > the usecase mentioned by this patch series is scripting. And here I very
> > much agree with the sentiment that it makes sense to give an easy knob
> > to disable all advice (disclosure: James is part of the Gitaly team at
> > GitLab, and that is where this feature comes from, so I am very much
> > biased).
>=20
> Of course, as you mention, the kosher way is to use the plumbing
> where there is no advice messages.  If certain functionalitly is
> lacking in the set of plumbing commands, adding them would benefit
> everybody, not just Gitaly.
>=20
> If this is for scripting, make it easy for scripts to use while
> making it very very hard for users to trigger in their interactive
> environments.  A configuration variable, by design, is a very bad
> choice to do so, as it is "set it once and forget about it", which
> defeats the whole purpose of advice messages.  An environment
> variable is very much in the same category in that you can set it in
> ~/.login or ~/.profile and forget about it.
>=20
> A "git" wide command line option, similar to "--no-pager" or
> "--literal-pathspecs", is probably an acceptable avenue.

Fair enough. So adding a global config like `--no-advice` it is.

Patrick

--Nc0HvJK71iVX5QCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYp+0IACgkQVbJhu7ck
PpQogw//Rw3iyICvE7kTn85wPUUEB/O5/ByPFD/H/HqVZ586a/tJIK9QnpK+gQKP
OyfiKfLFO5cn4mVuQAoOyzaS0usTQFjg6aNjx1JpCFWgTMl+rzbgNhdi+I/q6nYQ
Z3RIhB03ZQLayQTvmYBSi3sEYd3BKpkZteNZTXMqk6Rx6y2YBYMHY4kwUjUsOBYt
xNHx02Wne3FsTVcywGwZEhHvNUBfhM6lnju6UOfcltxcmyebHPbkE1F36CZgPTTR
rEDpIH7vwzM6L+HQW1SQ5BEv85eeV60i4FFBBokL1fSJaiytaBTn8qorUEPToVLd
0XrAypABLzUz7UI2IQRcvU8YqQrk8fYyXb3YQ/sStilLqFeQNTXf+7tE5YFaAA7L
i9E2gFBGQU432+fYHg9m9PQmOhEkqk/OQPkcvU8PCe51qPMSlTgY2gZbPppdBgKZ
Uk9/qHDAZcr4mj77jMLq53ieida6250XZ2DhGSlWLc4Np2aicwmDHu+/+y8VUJYI
6se25+KV3wv3r7SFN3yuqYrwLRtpJJtbGs3ja7PpTkgQU8N1JAVu6bvuzPtcJJ1g
Eu3If1SfoC+sT92yBsgXvDaV+rXZCC+saEk88ghnDmbVZAbc+i7tTGd7MtlbzG0P
eC277L1F7n6DF/8T6orSkqlorKb6Ifa3ZZ76fEH8P93AVEKPcwU=
=Cbvl
-----END PGP SIGNATURE-----

--Nc0HvJK71iVX5QCQ--
