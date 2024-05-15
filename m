Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C700745D9
	for <git@vger.kernel.org>; Wed, 15 May 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775898; cv=none; b=Z01YPvyF4mTypQurVq1bgTTMA2GQGmVjUMvjODgVfc5AC2Zidt4tWkGwahEWNaQhjRSVIpWBUiggP2aTFWjh2H5bSrBG7+wH8t1kZ9gXvhE+UjVVWhivCVLr9+q9tbvo/9AUUo85KuoT3b1z3HrSkJwkkGNWWfxfdsfcFM/r5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775898; c=relaxed/simple;
	bh=oNZeUiP2A2g5S/iHP5ZN/jTuvv5hT2KXre1IbhkY2I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfnMVwvmtPn2EEB/+Oc3Ab1RtkMJcl8WXh/eC9yOg+dtZuevoy32JY6m0d1h9tY+BZZQxWEmn3bYOlK7kmqa42YcutOxJ5i3rJg7sL3regDWD6f87hWBO5m4W4k6lyma5dDSs1AW9ScjaIgtZZH8RoEjeSShENWFuRHvChh8qKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=StMy+vev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CLFAZCHk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="StMy+vev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLFAZCHk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 64A751140098;
	Wed, 15 May 2024 08:24:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 May 2024 08:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715775895; x=1715862295; bh=PTFp9f1xHg
	cxP2knWxbNvvPvqpnhGN484tQdE2tkCLE=; b=StMy+vevEb741BCWH9hTg+aUF9
	j8S1JiDtSpmnAxdno+bn9EbvtiXVapZg4Y4o1c7mNiLbJ0H5gcsHQvL7+WR5pLXe
	Sd7NgzS+IThWaY4PbVBTphKsEu14A6Jw6XsD3Ze4QwTuqFmZPfijMGhSjGpkivb3
	6U0EXGwgICkCR5PUZViEisyHI25onjK/QKRkDVNdU6Gg3e0qX570GPp/ZvQRzkuo
	3PIjmrgfgstquh3y9JuCyzEIPJurWSTWHfUGXT6aP+hjyBxddWMMyU9zbRUxL7XJ
	31oNjzBGCMEJWOPMB1KbdYQVxxBiICLVSkCpxpzL88tElmzawUmPNgja7jxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715775895; x=1715862295; bh=PTFp9f1xHgcxP2knWxbNvvPvqpnh
	GN484tQdE2tkCLE=; b=CLFAZCHkIVHu5rd2NPazBfRJjumKy9VpU141o5F3t6Ey
	xCvtFOeByQNCJQqbwS36jRqVJDvrgqmYovrTg6jFMyJ66BPowIfyavQDBM9lMkM9
	MHccC3mrcPnfpJMpy+N3H7qCwN/R4hBZFEB4lfGga3jLEdAs3EyiZQ3PL5/ejzYd
	ucmKcbM+onDvtlxzcVIgP92GPjUC45j9DMIBpI64f1tlkE6m3hbvZieOzRybxxIB
	qdr4KGQIxlpmM4dhBoC35xd9c63Qo6QkX/Xaq3vWDcW19dwTZ0/Ff0JOyEaZkbj5
	jUUtgsSC43FgkP0uftKZN91Y6tW2uoOw/77ZxrJbiQ==
X-ME-Sender: <xms:l6lEZv1IGmPL2shQUDaSypXpEwUdUC09dmV6-KIYKtyJfBkf6p0uRg>
    <xme:l6lEZuF99sZvwp8WlPysiR-nkQARlvqbAaxKnS7_LTQZxbIzcsa7fAibcyeAWT68D
    jHefbgb2qgHDOlvvQ>
X-ME-Received: <xmr:l6lEZv4W2EyHiUolYD56w0NOqQJlhLI3upMyyIcLeh1eHpqKd278OCzCctf2_PzNzaAiZ1EFC6SaetUxdo_VJTX2s_wdYsVlRZ-Dp6upWZ1AzLAq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:l6lEZk1qtZdPwskrxu2ba9ErWL-WINv5tG3lwRkWDxST_MXsn4MNqQ>
    <xmx:l6lEZiE1_5ZMc0O8suWHZy4S5mRhyJ_IRB2Igxb2g-x5mV5geuOaHw>
    <xmx:l6lEZl_ht62VdKCWn8jUoCmXGPsV8PwGhroNszBsEpm6nawr9daswQ>
    <xmx:l6lEZvng98OFDECvtr8A1ewyhafbgArrxGT64tfpbvV7wGiO0VqWvQ>
    <xmx:l6lEZnRldeK2O0-zl8qGY8L5ICXqr9OjZIr-x4fDpT2h8SO75kQS6Tkn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 08:24:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f5a1ab4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 12:24:31 +0000 (UTC)
Date: Wed, 15 May 2024 14:24:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
Message-ID: <ZkSpk3v2kRsdOcbQ@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
 <20240514011437.3779151-3-gitster@pobox.com>
 <ZkLpTwNgFGFyC4_N@tanuki>
 <xmqqo79877oc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UNO1oZ1ZPDERyLEV"
Content-Disposition: inline
In-Reply-To: <xmqqo79877oc.fsf@gitster.g>


--UNO1oZ1ZPDERyLEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 08:08:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Is there a specific reason why this needs a whole patch suite, as
> > opposed to adding the tests to the respective test suites of the
> > commands?
>=20
> Yes, testing out-of-repository operations needs certain trick and
> people forget to write such tests using the GIT_CEILING_DIRECTORIES
> mechanism.  Having one place where we have an enumeration of
> commands that are designed to be usable outside repository is a
> handy way to make sure that we have enough test coverage.  It would
> make it easy to control how GIT_DEFAULT_HASH environment is set
> during these tests to have them in all one place.

We already have the "nogit" command that neatly encapsulates all of this
logic, so the trickery is contained in a single spot in practice.

Patrick

--UNO1oZ1ZPDERyLEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEqZIACgkQVbJhu7ck
PpTVtQ/7Btu+R5FC/WW5fi2/w/5bJ4T3wZQS2Lcm7TZkvhAlXX44krkmVtI6L8io
Iki8nAefQeLXIA5l0mPPXegKZg3KZczwNXPdfZa0tQNV93l3OGFlZi76eZS+Y7cl
kiLTljgXX+EwGfxTpujg7EN716tYiUpeFlPgCbgGDYDTpD04VVB5i2sgRU1nif/c
6fTvwhMbHmHOeyiDX5olRhaPrK05j0xUHhuG39/XglnFn3Q9HO8HJGqfJCSvY5b1
rgLPgC3shAVuPf6kZ9InJvS2patRFI0oGhMpvGeUBwXcsZ5A0dy0eYpBr5Fc7jix
Ir6x82jUqTXQRl5hH0ZtuSyxgoEbopF+NlZwIly8Qb1xwUKLmHpKOkVvVe6rhddA
a66C6fFCXS8zh6RsGHdok5lsLP5nfnZre4zFTQhnhHkyY6nMJpXtQLLatLgKvn4Q
uX9xmXjDFMp8T5hC5dMTl9HC2qrsCWloaTCxxCfRsK+/2S1S040GOccbvl2KfoYf
3382AwD1bttHsc2l4ux3gJgsB47woCQcbQ0I9WTrKu7Gk2WfG5Kf5BpupKTD7U5y
1Q5gAamiJoTJtGp9PQqExL/WSQd9YGHBtqSMAM3nJpWrJgQhObK8QXwldAtnI3j8
3sZYJIktWL2gTEfi4r85NU49hpx8g73AheC4rdUtJYPwHwbYBcU=
=zu76
-----END PGP SIGNATURE-----

--UNO1oZ1ZPDERyLEV--
