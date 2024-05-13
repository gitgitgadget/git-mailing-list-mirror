Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BA148FE3
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594586; cv=none; b=izzKBpnS51mcU5mMVuxSvvqca9QhhZmmb40Zp+6gS1mRZvis7YnWWYKJi4j63pySi6lgvb3htYZ23jCKb1XH3umJWsHWzbphycbs6x4TGP4ksq45A8UDnMFgyu+lFQbWweoJXpYF4PxD18qR1FV6Tafwec5ZIjZ9q1+hUz3xl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594586; c=relaxed/simple;
	bh=NaQ9gwTF+LNb3UH7U77xNxwPKhnbjmkup8u3iSzK4Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McON5/ECXpzYLvM9pGyS/nxp2x0tOz14tmQNMv0eeEiDM991NaawSQPWP7JeXDcIqOROe0tlMyPfUKnPMbopuFG5GLw8kYYLZ1LwKHeL/YbZFpWd5PzkbF5M2nH1TdAuJbd4fCWa9QD2ZKZaSCtBa3Buu7o0Fbu+WZATBJFxEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m2U8+Nfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEC9xTOv; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m2U8+Nfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEC9xTOv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 38AB31C000F2;
	Mon, 13 May 2024 06:03:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 13 May 2024 06:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715594582; x=1715680982; bh=NaQ9gwTF+L
	Nb3UH7U77xNxwPKhnbjmkup8u3iSzK4Nk=; b=m2U8+Nfr32NRKc8aZp/atZ37IW
	J/4Y58amzSdD3OHh3K6UCAu5b2nUo9ICSxHfmLOV+ScBkr0jn4G+fyKFlQ/4f2uv
	WBGnxWR73LQ6g6WGgyH29q+mKlqrQmSNpbG5a+4ZoJANbRpjdC/PZe9HAPN+lyYD
	s/hpIDqGjVPCo6N0YbEaLjz8HynDxLfTMrJ8TuRjP03py3vIDMMuPY7g3EkssdFl
	DgQICV0xF5YxezRUKdj+s+g9kelNGVFIoMnF9m8cOUcGShaEr9hEQy03AFIEnzwO
	b78IERymLSetuU6KT1nCXFv/eO88kPvpNpSfW/KKuHpL3r2cxT0hi4+m5r/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715594582; x=1715680982; bh=NaQ9gwTF+LNb3UH7U77xNxwPKhnb
	jmkup8u3iSzK4Nk=; b=KEC9xTOvAAN7DlMnBnLq6+l0pmPrG4uIstoSbp3P5Imx
	tTzr26rHECLfKIXgrw+m3Vp1Ug7QpYdADbcImRCYOmHLIiuyhJQrkNPvyi8uKUtm
	8Z5M83zkUd5lSfXCC+My7CQyXAac0/xD5N+qJdcgh2SFsvZh9JmDIACSGmlVeSv4
	lLvb0UnfcphH8DSDXk4Z48bq+o36B3rujsQfTawpA2tU6SNeb/sXm849sMUfq7yc
	nTotybwZfUQm0ODbF3Y95n06qAjkkAqztzm5GaL4Ym3AIOsvRy6fC9MjqEDXjn9u
	KO6yj1jUE1PxtepidWjpsn1gfZU4Prc8ZfpiUg4ocw==
X-ME-Sender: <xms:VuVBZrUfIlpymc0cPDXgSksvlYjJZ0NJlKGNNjrr6XHNWnqu3F7G1A>
    <xme:VuVBZjk61oFWYhJ9ly18SaVK3e0DWbs23US1bPPhTl171EUapci44WkXU79ZOgIpG
    kiioE7ZqHyZ4LSb0w>
X-ME-Received: <xmr:VuVBZnZYctJom0KXFf1wOePGEKKHp1aT5QDu_gpWpEF6XxqncK1do0Ka9cXqM0Duuk-9cGMRbERSMs33w5yEH8oToqQ1pqhdnBlwsEbjWerbBis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VuVBZmUa1Xt5pvnnV-lZ2a1Xm-PME3zeBM9MtKTTRaHvH2rvRuwQ9w>
    <xmx:VuVBZlm_0lZr3JW-TF8KaWyllkKOOcbwUmSePuvhdziDvsTyw6cXWA>
    <xmx:VuVBZjcLmGTxB7gK0mZay45icj2rO9s9qi8sMjh8d9QIZ0dmuLIMgA>
    <xmx:VuVBZvHBIeq8tg5vauQrJ2narCxyGZJDhXx0bmuRQ3ZYtVU2AXURrQ>
    <xmx:VuVBZuA9lTHbZ6x-7Bbpkoq6MMGzjoeg5h10YLBiEO5eqpAuvUwGOXE2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:03:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 149e7854 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:02:41 +0000 (UTC)
Date: Mon, 13 May 2024 12:02:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH] fetch-pack: Remove unused struct 'loose_object_iter'
Message-ID: <ZkHlUkKtqbXSvVNS@tanuki>
References: <20240512005913.342287-1-dave@treblig.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgc5pNW5rgmuunvd"
Content-Disposition: inline
In-Reply-To: <20240512005913.342287-1-dave@treblig.org>


--pgc5pNW5rgmuunvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 12, 2024 at 01:59:13AM +0100, Dr. David Alan Gilbert wrote:

Tiny nit: we don't capitalize the first letter after the colon in the
subject. I don't think this warrants a reroll of this patch though.

> 'loose_object_iter' in fetch-pack.c is unused since
> commit 97b2fa08b6b9ee3e ("fetch-pack: drop custom loose object cache")
> Remove it.

Good catch, and thanks for providing historical context. The patch looks
obviously good to me.

Patrick

--pgc5pNW5rgmuunvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB5VEACgkQVbJhu7ck
PpQG2xAAgji0ZHRxg/n6FkmpoTitgEW6vXo0QfgXM35eKIQlvGdHS3gxynFUNDod
HQtSonyoO2dF3XXUerq48hwM1pX5HnW5G251jEwbYA5Rc6gr/ooGfRO5DCNDM77J
pJ2uROxBmYHsVv8T8WyyMG6EedVvQMN2vqeBgI/EfzKYPNDpS4t0Hzw9iQ5VPK30
LIkJ025sI16OUaTB9shGyX2gehGuc7+xvVK7mPQSNbYKyaewmp9njRA3PbBV7lGl
nB7auX7PrzRHR56osWRQJHDcjJa8XIq3TmNqkFKJttpS6fIr/RohyY1mkE0+pFq8
Rp1OBKX0p4DMGEqI+35WLFAjaUjltjIZKnfYEgLE/mgV4/gaj1D7z9Zkh1CGEaLY
wGJnIMWLncC5wmtrSszj32n3RyaaUxa+b0Sng+4HQrX6Lmt80+Ocu4h9kXucp6Sp
2+Cd6gU3k0vN2MYnuJXpRmwAqokwFzAo8x/OVGYEiDZ5BaFFjmMraj+wjygIB6y3
f8J9U2ewH4H93vjlCfnLJKxXQhT2faVEUjWrO4WY0l16TAqnWqGag+/7A23732rh
x0XXFqR648b1jnQypotLjVYKIzXN6/V9mnICPyUkc3POzOHVvyX7WxEjplFaVfRw
LhzG/emfiCTDcSofRhwF1XGGlAcj0Tl9zFHk82foBxATbP9v5M4=
=ElAM
-----END PGP SIGNATURE-----

--pgc5pNW5rgmuunvd--
