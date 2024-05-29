Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3115B13E
	for <git@vger.kernel.org>; Wed, 29 May 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960800; cv=none; b=gsu6S/m2LFG2eLmo3PEOOa2hzm1aVK+SRCpTPhIloIVlLfmvsutKb0MyU7FslPjmFLKzqXC4CCH1VNvJvKTMAknY9Mj0VwbsLCQtUJc7qZotfbg+446gbiB9FbkZ+anQ9Zc0P+hzEsDpC4SA+zZ/VUCciPSGiY0VoVtjJSEtR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960800; c=relaxed/simple;
	bh=NxVM+j53dSt36bUH3VA9h0Z+3xMS+ajsmM7MttyobW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoV9ikTHxxUQYPKXUqFnShx+RaEgNSi9Fm7YHrs49qqpwD1YP74bYMZOSIwTB3OeBOiZsDXBy5ozIOWJOZntBz1KCHu5aks3qIRK+rLGS522vszbaf0gsYfVTFZdVuln4Shns17xh9NDRNuJFDw28EQZ6ZKA9mDvzeO+vt6MuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNfrxW8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oNHDk62m; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNfrxW8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oNHDk62m"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 31159138018A;
	Wed, 29 May 2024 01:33:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 29 May 2024 01:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716960797; x=1717047197; bh=lyL/WYoWaY
	VdIinY1FYTJMtZd4hGZCCbR6BlYj3RR+A=; b=UNfrxW8EUq6OTuYhv9ZYGpAwYK
	DGhX+duDHPJITueR0+f6zxD5Z7dwKwUaKl1d9rnBhpVnMW5iLTMIQjvaScT7QTZX
	YVFUrsP9qD8Wp7LcAoIzfhMtTFFZKxNesir/QEfDcPhLObPuRvz8jxBu4GsJ6F91
	gjbxs7NFVsHbadkvSeD1bDN/yZ5oYbtFzjdzWzKaB/JLICTmtDxxU5bdg0BUnlTs
	Mv89cKaY+Gj7T9dpM+52qVBhjxLhFi+PdGetBbrBkeK2bKqlBo1+ZaKoemZHEIXf
	0RUCtpU56faifYeY8C6JysrAatd6ON+a0OBij7+M9JefAFEnJQLJ2aqTKgAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716960797; x=1717047197; bh=lyL/WYoWaYVdIinY1FYTJMtZd4hG
	ZCCbR6BlYj3RR+A=; b=oNHDk62mXOHUNyDgRUSqCvXV5wttkj3EExwYDfH6EM7W
	JFjkO7ZUu9TcNYN8vgevkXr/DBUqWDisOjt7fM2K5ikgZYqaS3rI36NevN7vD7fY
	oFjiMODrQE20W7qsYjhS2lxFilNsY85RIgbZTgq08QdGuFKUKmu5TTjsR7fXGwjF
	7/UUb1pdtfpCtOrbJqszOF5idvULvY72pEnFSrUPPsuYV4lmMlKMKxv4mUtmD6p3
	ic7QLyUKMNhKBBcZ7tpG54ILbrMKhQm4Rmy3CaZqFEkrtV0k+yvPTXLSuAhwR9Ir
	I6GMNPcQRTHfcrlY4Onsa5z+hNDUr92Zf8gM3Dzf1g==
X-ME-Sender: <xms:Hb5WZmydX2qxZDWFyjGbOMGiJhoIFTEKr_U16LKfXzOq4poGraAO-g>
    <xme:Hb5WZiQrq0HMNpP78Id5plDJSSvRf8RWCxZZ60CibXxC5v662ZICEp0ihoSJk9X0J
    rKNC0du8GdIw9DQzg>
X-ME-Received: <xmr:Hb5WZoUONLPJc1OusyvAVOMGOVG9715ePajpmEDGMlmFYRI3Qsm2qHMAVY3L8N2r4ahwAhJWpRrfGE5r-Yxv_0C3seo6Qx8HlEYUAFn8xkciAPII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Hb5WZsgYtQ-CfFJVVbKrD5ffZ7PSMrD-KndAtRgwP4ARdPriI3Ceew>
    <xmx:Hb5WZoABA-kw15rncIxx8gkiYGQvmI4XvCIRsR3zeXraaz5dTHVXjg>
    <xmx:Hb5WZtI_h8yJHmbwpZ2LqEkFo-7MzjikToJ8GzAOnlxU-TPLrwSrDg>
    <xmx:Hb5WZvBpIv2JI7hgEnEr_PHeWqlYV8uDCmzWnO2d9kjFGkrJG-TuWQ>
    <xmx:Hb5WZrO-nFtaiSAf2uWGxlJ0ldWZlBo5UxBrqORJcaFVSmYXo3t50loT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 01:33:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f614ec04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:33:00 +0000 (UTC)
Date: Wed, 29 May 2024 07:33:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
Message-ID: <Zla-GJ6NpSNNVDXq@tanuki>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com>
 <ZlB2g5bTuBFz5m5_@tanuki>
 <xmqqo78ukhmk.fsf@gitster.g>
 <ZlQX0FmIsz2eFgsC@tanuki>
 <xmqqsey39mmt.fsf@gitster.g>
 <ZlXbxzFOJ8gVv7r5@tanuki>
 <xmqqv82x6fto.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5h/LQwXHk3xPVyVv"
Content-Disposition: inline
In-Reply-To: <xmqqv82x6fto.fsf@gitster.g>


--5h/LQwXHk3xPVyVv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 09:50:43AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Yeah, that's definitely better. Whether it's preferable over having it
> > after the signature separator I don't know. I personally liked that
> > version better, but can totally see why others may not like it.
>=20
> I do not think anybody posted a version that writes inter/range diff
> ater the signature mark.

No, I'm talking about the version that you hand crafted initially and
that kicked off this topic.

> > Hm. By now I've gotten a bit indifferent, to be honest. I'm not a 100%
> > sure whether it's an improvement or not, but I don't have a strong
> > opinion either way.
>=20
> I am not sure what two you are comparing.  The current version with
> inter/range diff that is before the diffstat and the proposed one
> that places inter/range diff after the main patch?  Between them, I
> do have a strong preference.

Yeah, that's the one I'm talking about.

> Or placing the inter/range diff after the main patch, before or
> after the signature mark?  As a reader of such a patch, I do not
> have strong preference myself, either, but the signature mark is a
> convention, established and honored for more than a few decades, to
> say "no interesting contents come after this line".  I do not think
> of a strong reason to go against that convention.

Well, agreed. I liked it because it rendered nicely for me, but as I
said, I can very much understand why others are not so thrilled.

> We certainly could use the "---" after the main patch before we add
> the inter/range diff.  I had such a version but its output looked
> rather ugly.  Because the inter/range diff output are designed to be
> very distinct from the usual patch, I'd say something as innocuous
> as an extra blank line would be a good choice.

Fair enough. In any case, I think the result looks fine with the extra
blank line. I just don't have a strong preference between the old and
new formats by now. If you or others feel strongly I don't mind at all
if this patch lands.

Patrick

--5h/LQwXHk3xPVyVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWvhcACgkQVbJhu7ck
PpRf3xAAq38VBwk//zb4uQlQzKaaRWDhHktC0K3u/2kredQUB2GH6Y6FPWDKsRSS
HdHdsuW6A3W41u2G0vAqPXayjs/W7L/IqTqRG21zxNaJPxcFwp6FKQjeEDv7R9ly
4Dsp9yeR9vowhOonMg+RBrnB0C7qBSReGBuHl8uejrzHsVdr0HvYB4WUXPKZG11i
mLqfFwmObJ4oe+BONEKZPvEkutXJPwmBvOuPyjuscmUKEuaD9+du5odQLHBp6yMM
19qsi67J3RkSwLCiZCk4/0f52t5W9OPjKHTiYqFunG4jj8KW8ut4bnZR1rGcPbUq
X44jYipEIJ3D5NYlKvUF+nh/B5wAppPwJZzd8owBqh45CTWuhN65QWyNWOyzv94o
vJkwdGqsV1P593LJEpXo9ax6y7FqVXRJu3cHDEUpLC5pCRKEJubCk3jZyM7qiFv+
wRxQUtGzCovtT8DZlDL1qIGqi8JQaqYSeZ8rxd+mdZdKqDgLfYb96wwUks3VJ07V
ifMA6ggOaenS5Rk/Ivgnp4CNojCgfXM2JopIqjMRdPoNCu1C/3fxDNIRv0HMcfgQ
i7J60zwWHUIINyIz+wKZJbpc6rP3hNgm2akVUaMYMt/8guljdRR8hVpTehakb+Yz
HV30v1SYVWchpNQm5zeTyV5hGAWA3oeo1i9PYY/z1Q/e231lXE0=
=Zn1b
-----END PGP SIGNATURE-----

--5h/LQwXHk3xPVyVv--
