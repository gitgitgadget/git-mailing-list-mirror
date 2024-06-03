Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6843ADC
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400230; cv=none; b=OsOmsPSGVpRNdFIA3oYBVNrGjER8dKyzpmKs/56HnCWCef+o+7OzU/8yuD0Ph1Ez+uNKI2CoqYDE5su5Q2yYgEUfUSmonomYZrg2NNy19RSLOJXOXJbY3PRvsniS2biI3E/czBDnd2WrrEjdrXAVrUsqHqLSKi5b6d7Oj9/oSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400230; c=relaxed/simple;
	bh=+OiKrxzJ1GdHQ2DcOyZwZWbg3pIu0KGsTzS19bWpqP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B58Qcv6Vt2nEZGoWzbAS/32a9XcaUUdsTXMjOqhJTvUIbU75glPnwEouiTlFstcFAXvVanM1PxMfNBs+nlB19G6BojpgLVufgxCCZFvV3M2K+F0aJae4QmawYSltaj/49lNXjlJ0Q3a9Z0ZHkQ61GlABmpRsstLthbmxC/ZEivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cti3COVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dL0+YidF; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cti3COVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dL0+YidF"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id E12BB18000AA;
	Mon,  3 Jun 2024 03:37:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 03:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717400227; x=1717486627; bh=Ff2jJmtOCO
	6sLyrhclqtjQVOxlvIGypYNPRE3S+5fXo=; b=Cti3COVwt2nQssih4CcS9BR9Ri
	ydZUN1N4Mb8h3nXnoGiQfWfStFPDGVADrOJ51AWfPM8SuDUCEOI46rFTkypDbWz0
	lhhWaLidAMCdSo2nxJll8hnS3+TvK7m3J186cdFn/5ob+ZHpQa+CIxLue1PQDHSW
	/2encO6iiAnXP9q9Wl22uSn6RT4yE1axM5MDWgncuO/SmxQtN+YO/7ghoY/K2O4t
	TE3IqLj+Qj9SacElkGF40ec0tIdyIHwQP4SoPZP7lOMwq8jUCVWa6zZqU5820ziu
	fRBVbJxir/tgKRrFqrcyFGspoHTI60a0EXJwHKrstDp5NhAlZmQiIpoaEdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717400227; x=1717486627; bh=Ff2jJmtOCO6sLyrhclqtjQVOxlvI
	GypYNPRE3S+5fXo=; b=dL0+YidFMQWW5uF1tpDINyDaLnR+I6pEGS9YT52VL20x
	Qj7Z7d2E4SeHfrS3+QOQjzb8NN7MUYfIC9HA8iakMoL5x1ZJoqUJjwAfArvEaVtw
	3BFgx0G1U9lcUsLDU6M/+Utrvy4XyeTgQqZWA7QUP3X60xfsbq+mTXNSVKc+lCbe
	LUrTEzdCXB/BzS1pWA5gLJ6WeVLVe+K3hOiRy9Aie9M5otdxX20GGxBrFrY1ELdH
	xJIj5ga4zfrhE4/mti8sZxgnr3v2fQwfpAaiIsCPAFWSdkMuRFUTl4nHWm02IobT
	lQsGkCqtry0dZ/3qnslJxsan9QGWIobpYJtCU0xhwg==
X-ME-Sender: <xms:o3JdZl6PwOSzm80n5PsZZm3Zez_Cl2OrFfnORKBIsvwZ6NrO83Rygw>
    <xme:o3JdZi6baV0Os5YwsJ5PUaRNK6RUWOl_FoteEED5QFCnye2d6xnkW4QMbyJtYMj11
    P2pjbBQvC13RkWnxg>
X-ME-Received: <xmr:o3JdZse-KpHGOmqPXNVbOW35r7ZsQpzp3F4_Il3wYtgdmyt-0i6D8c878kaxmjHmClvfD3gZeGfTZZ3RC6ypqliV0lu5LxeV6ZFMk_soHMTsIA0B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeluddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:o3JdZuJw8eyEfafYDkovLVDVcJfDKGN99h8rqJr6IMCBKlqYI-DIGQ>
    <xmx:o3JdZpLg0xbx0xSAHk8ADIoCI0hVpJX4nHHaPqdcRkkwNLdUC4f_cw>
    <xmx:o3JdZnxmeDdpoNHrlMZbC1vyMoaUfr6zmKTd3w_ib8zS4aDdk508Xg>
    <xmx:o3JdZlKcRD_ew9EbEVHMCV8ZFKQLAJJCMAMU1Sf82gdBUBgvrwOsxA>
    <xmx:o3JdZh-ICHgOJKvRsYNB2QVqy-nsZjZ_69c_wRuix8lW1JIYADOlKp8F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 03:37:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4169f923 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 07:36:40 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:37:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>, psteinhardt@gitlab.com
Subject: Re: [PATCH v3 12/12] builtin/refs: new command to migrate ref
 storage formats
Message-ID: <Zl1ynntoW-_VzvY-@framework>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
 <d832414d1f8a7c8d9ec3ade13e11dd509c0ab641.1716877224.git.ps@pks.im>
 <xmqqjzj9czop.fsf@gitster.g>
 <xmqq7cf8b1gg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i6j881SCaRxyISF7"
Content-Disposition: inline
In-Reply-To: <xmqq7cf8b1gg.fsf@gitster.g>


--i6j881SCaRxyISF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2024 at 06:03:27PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > One thing missing is an entry in command-list.
> >
> > If you ran "make check-docs", you would have seen
> >
> >     $ make check-docs
> >     no link: git-refs
> >
> > The Documentation/MyFirstContribution.txt file does mention
> > command-list, but it is rather messy and unorganized.  I think the
> > checklist at the top of <builtin.h> would be the best source of
> > information at this moment.
> >
> > Thanks.
>=20
> You'd need something like this. =20
>=20
> With the command missing from command-list.txt, git.1 (which has the
> list of commands) will fail to mention the command, of course.
>=20
> The fix to the documentation file itself is also crucial, as the
> name section is where we grab the list of command descriptions used
> in "git help -a", and with the extra blank line, git.1 will fail to
> build.

Thanks, I'll squash this in and send a new version.

It would of course be great if CI had noticed this. And we do execute
`make check-docs` via "ci/test-documentation.sh" indeed. But the problem
is that `make check-docs` does not return an error when there is a
missing link.

I'll send a follow-up for this test gap later this week.

Patrick

--i6j881SCaRxyISF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdcp0ACgkQVbJhu7ck
PpTaOg//f5qRrnY0flHPwd4qZ9nqrNnaEwLqOgm5VrMXz7TFGjlsiDUBWFX/w6C3
6hEW8BZS8tLwz43TsiYvA0TwS4h6TRwaSBaM3Zyo+6nkrI25L6+I4CmMAPiKl36v
tsBG+KY4zsQnZT7/duShtjZ17yEnOVD+6V1/dzXfh+bqQU+DMRdHOfTxRdSa8tV0
tv37DRkaqHRgwOHmM/mghr1Dq7sTQQlj3TFpedzRRP459uHwRyFEJRf44Zm4fh+P
NpHY/zT0IHyC4US+v3iXyiJe1lhLJYhRMzNSj4ii4QwYDVE1pMe9Hl5duDXdOm6e
YmpSc+TsIzj4IozQgUA7L3UrZc3DjQ/i23rytU3pPwDkVtsU8IDRSPACABsy0+Eb
yAnMUQyb9V65AkZsbponxC3eMh1x+iyIvGr9x3e6HPqbTQE4ZllvzGGDjqUwHIzq
AYqpVCbIgqRYVZHazYXd4AzsjC/9UQWgxxc3yRDu1FmXO+LboGfpjv0AXMPQsK5f
VsZCxlqquKGso7iKuaf1ooA134PIUVa0/d0KdORpOnR0d6XIr2Vd4dsUkHPZx+un
5/h8Vq5KKL7aGsJj8jdvftJRoBwDuxjgORpf+8JmJPCp9NGblMX8vh/u3C6jP2u6
IputQYOYYUdDC59h6dzaGYcKx08ecKBX4p1JqX9OruGHDrsq/5c=
=TbBA
-----END PGP SIGNATURE-----

--i6j881SCaRxyISF7--
