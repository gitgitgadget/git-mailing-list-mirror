Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898691171D
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001504; cv=none; b=F0UC0FCK/RuD+BnyUycieAz3cN/gzHT9n1KCQbwNHZdrO5ForqK5BhreMBEkqQY9VYrTcZ9b41Thw6M66EbjFw25l1ZsrtKQth7WPphVH2tiQaaWiTWfjDn3Rg4nnwcyVvaEXMJaSpgqTGivEif8V5uupCYWXsKceH42UCOT3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001504; c=relaxed/simple;
	bh=HwVowV/szzjP30T4h3G63U5t+8ocJCFzrLQE4p/6RZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIw0yhNwhFKNpTQd7IcrISs7kOpnEL/RMkEKliFwtPvNAfp30f6NZfZwAgiKHrOZDXei8OsfgTN0oqIGNcD0o8CJ1Aw2S19aTfxK0F326VwT9jXE2iqfMTLb3So9SPhGiU1W4ZRGKLM8bN78FNJKQSDQFAa9dGkk7q+HDykStvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h3/OF2pg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5JlEKby; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h3/OF2pg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5JlEKby"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 7F0531C00155;
	Mon, 10 Jun 2024 02:38:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 10 Jun 2024 02:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718001501; x=1718087901; bh=WeXjz1Whhp
	I0daUl7VJHCHzt1IH/EM/BFxRwjTCUKUE=; b=h3/OF2pgo7SZYvA/ivHwtBpXEx
	RScAzBAT9bjADEZvkfHnQakHiaDowedqeRin+yRcU2DgSZDac94b4P6JnLLjwCb1
	UE+XNt5r2gr60wG8QesGl2q81qjYqr5lR6ndTL+UgIfSmH+fELsgpz2XK6kqKK4M
	dbzCLkEjKXZWpaL4cpJfcc6PyhBDzPccAJuK24jfvMTdrI1ffp6Nm16n5CwGEqXB
	yIRJhcXo2gYBjkiew0oaQI3WgxIbsZvB6Tr7leIUbulwV99JVQrvjF/rFLuNsK9R
	n3Lhx/3VNTlGt9eWs4duQfB183XW8MifJER7I3UyHxx2DMVAybr4sH3AIBLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718001501; x=1718087901; bh=WeXjz1WhhpI0daUl7VJHCHzt1IH/
	EM/BFxRwjTCUKUE=; b=V5JlEKbyUnnML8eZo/zc7sXuR21xbpZa0GfZhFr4fOsm
	J81M399jZYMtgW71jstz3V7Ptsn86RcyYYsmFCxWApGNmOY+tq4B67CDQeQ1Yvd/
	KtIuOLlTKycIT2gqE6s3wMv4xkIO/i4vcdaE63r4FYAxhF7xkxRnzJD81+GUHWVa
	sXbbKOprT93X7dVuxPblRFOAYUqfYxbi2R7OTsLeUGePRq6ZZDuI9GMioTjriMmp
	BdHYeCK6CmUvJ0nZ8mma3v70XJddWtHvGaU0fNtsn6mn3H2Ld79MzsU8nzZeDPcr
	yjc3NibrRxp80ivT9Iq2PV4/HkTQSOE2uuEuW1l+VQ==
X-ME-Sender: <xms:XJ9mZs3qeTyH_4dGoNe7IGA5vKtVU2EZ0qpDGyWXa6TMRHMxhVQGIQ>
    <xme:XJ9mZnFDz8twZ-7aH-cZ_0Gez0J4MYtb-eVU4Ca54aYw8VI8zqHjUjVzgrLCPO1J0
    g38X8B4wzuPHvSdQA>
X-ME-Received: <xmr:XJ9mZk6VYx_e-OUxpGbBX9fsT_fk0440eRzPY58cbQ33s12cQlWbuahCGH7QizbnSzvJFkYTNEjlXXinslaMla6-rRI-SMES5-rum207NYLZnDir>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XJ9mZl0SVmKbBZP9shAEPRkuXY1c0kyS4raW4yVhk-2SmZ0D8QbbUQ>
    <xmx:XZ9mZvEjJQMKsYp92qc6N1ysGX1anBY5OYF9qDXq0Uh9NMv2CQSgfw>
    <xmx:XZ9mZu9vLVZfNPzuAS7aCL2-L_iURVy6FQH73NClY0v9cSzMbGvLCQ>
    <xmx:XZ9mZkn02miaHF7MeceT3hKzzI7mOz3h70qHA7rIm1WCS-btcBFQ8g>
    <xmx:XZ9mZnBElNhPU_X4RxIkj0qk-gpROLRNynRrgafmSWsvsd0BLLuJXk46>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 02:38:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1c22eb39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 06:38:10 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:38:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2] ci: detect more warnings via `-Og`
Message-ID: <cover.1718001244.git.ps@pks.im>
References: <cover.1717655210.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sKcy8ilVxf8HkdlU"
Content-Disposition: inline
In-Reply-To: <cover.1717655210.git.ps@pks.im>


--sKcy8ilVxf8HkdlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that starts to compile
with `-Og` in one of our CI jobs. This is done to surface more warnings
=66rom the compiler that might not show with other optimization levels.

Changes compared to v3:

  - Remove the first patch as Junio has moved it into a separate
    topic so that it can be fast-tracked.

  - Drop the patch that changes CI jobs to compile with V=3D1.

  - Drop the `override` statement and instead implement CFLAGS_APPEND
    and LDFLAGS_APPEND via ALL_CFLAGS and ALL_LDFLAGS, respectively, as
    suggested by Peff.

The range diff is not all that useful for this version, and the patch
series is tiny, so I dropped it.

Thanks!

Patrick

Patrick Steinhardt (2):
  Makefile: add ability to append to CFLAGS and LDFLAGS
  ci: compile "linux-gcc-default" job with -Og

 Makefile                  | 4 ++--
 ci/run-build-and-tests.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)
--=20
2.45.2.436.gcd77e87115.dirty


--sKcy8ilVxf8HkdlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmn1YACgkQVbJhu7ck
PpSWAQ/+My3sAraK20Rswx1DDlvX5R2A2OR713/QYKQV+YC1APvpLa/ArMOUT2S7
8QpXDZDWTobU0TArQIvuFcFNupjkdYvCghHAVBY+hPUUh3qcpDO4srlBsSwvl9IG
U11NcvYrx5hWn5zahdNCQzxAD6uYfhv1tx/pandyFFgQeGQVhU1ZSyar+xtI2zKE
ZrmYUf7tKGT+YdM73WjmmdBefoCVvRrnnBPkIcr18/Una2jE0o/seGuXBT6ekqLk
JHmr5CIAg7p5iubcWU5jZ8LmC3EVHslf+CFYhIuw2rlOqmqI310IVOhb/Xzf/Z25
XryaJmu8SAeMSkO/NuyxDEJCP4VSYzVa1hIVwz/GWyAYOr78MTvD2kHaF5qZqRTr
JlOCQDhE9DU75/INKbwBXZgsNlbSY/F8McJI8gg06mQ+iTNlcKLDDXyTgnPh/k4R
KI5CvsjKtlrQ/I0JTjhVbfbz+9griw7bXFyxiD9lPkevfa4ERrZd4bOFCIUz3bQH
xZ1uIPU6P664S9D5U6/qmQIY2/cm7AagaiiQ7mHDb/28Oxloj+lWu1bYDuvUS3Fx
oDRGqMGM45vimYDEkgeQOP4XXQmY4hj6fdFly6L3jMgy7I6kI+VRJnTet+R1Slyf
QRJZW1twoBhYsuFmrOYgvick6KOkXheR34sgfYTaIp25kQNijA0=
=coUl
-----END PGP SIGNATURE-----

--sKcy8ilVxf8HkdlU--
