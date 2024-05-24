Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1463749C
	for <git@vger.kernel.org>; Fri, 24 May 2024 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533806; cv=none; b=szdtZqDvnK62YuVKwnb0BpNanb7SN/REQKUNpYq4kIRBy6FI+8yAweRwvL7/dk3zqW9lOuK3YctfDkF9OJcQY59EuOGceBZVMHnrVM8TvWDOgRCd653YjyOentxQRyzBFtV+GITDRYDqkmWqulVMh9bKTj1a4shjlm+rVXbsruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533806; c=relaxed/simple;
	bh=K1j8r3RcYdskPJ60mRYL2KsASw3h3yoN09V96ZruJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi25y9KQJqhwsAw12OUSxUTeM/mBvIN/tj/vmydNYShKayBlTPv1qbpEy2ReyucYKg3GW/1X813asPPruo1146I+XiIlIs2P0pAzv8uAtqnTWQnGU+GaBT3t1GCKvAY8q8ajKFK7hOkGP7hce7C+3vHFRTZBqLVYSRYch+RKKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GlGqTDt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmVOynYE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GlGqTDt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmVOynYE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C93CA13800E4;
	Fri, 24 May 2024 02:56:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 May 2024 02:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716533803; x=1716620203; bh=QIqPSF9k9m
	2nVe3xc5bkpWVGLmAJGKUuOpYX4vg2abA=; b=GlGqTDt1HonVIWTQTP1oGFgjuB
	kGXYJSlkNcLgmDL5nPalSq9A0WgSpPwCJI5YFswmhqRiXALE+RhEqvClGkxFRmUg
	CJnIVorqwd5IYleKjDGhX106cOsGhKzsCUDrIdCmElYU6C1Zy/8IFSv/qBcYKKX/
	/nsq0py3aIVF4X2acVlQyJkA8PWmDxFv8+BrXT3181zv1v/U1i6QAFxbfhS/PtCM
	ReVIPnaEbi3zIAtS3TdgDWzHT3Bun15rihkoJpXndD0C2Oow4M68St9M5sQAQhDJ
	zaximycuGG2gXr+yBGvgrPA1rVXEczwrSgOgjkaWxWKYHuIRnEt2SIX0y36g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716533803; x=1716620203; bh=QIqPSF9k9m2nVe3xc5bkpWVGLmAJ
	GKUuOpYX4vg2abA=; b=nmVOynYE6oZhscHgAmq/tGEICB1bt8VzhUk8jZhXe09V
	I9AbNiK1zNNBjmSoGj3iKjFxw656ESQgQiV+KJM9/xQWzxHQrDJrgj228JmiPjuV
	wkehPj4wV1PM1VpLwlYLKPmIJIvzPxuSQLvsL+8D2wfs7DUnJv0XKDHUE7yGRLVw
	trR1hu59jygZAWQ9iapT13CxSeUuH0eqkbVqZbnDPRE7D0wIdLJMHQI4GU145aH1
	clqYGjN9vV+9byedPXIQ4Ubw1QDKacmTmxTUbcwqU5K1V3hU1L2byIPaSnfxKpfq
	OviAzkX3Qpk5fCLRAMEFiKdDaKkZICabQyQ+dHcLrg==
X-ME-Sender: <xms:KzpQZsNCUV10fd2cnMrr5sczfgh3v38nZbdLTHJug8h_CYlti5wxAw>
    <xme:KzpQZi-7TqvHCJgj1ncs1BMgvY-VOAttFqtPQIl9Vbs9WOyelKwwBtVo7YUMzrJvh
    Hb9ZX6qIyBo0WMq0Q>
X-ME-Received: <xmr:KzpQZjRFZvVTeID36jW3UqFWTxMZ8KCqU4dVKSzBNV2QXTYiiBjgN3wO4yfkke5gICT0j4b5ORbcEJaZCJsWiKbvNModq504sD_m7etXt4F0hlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KzpQZkubi4fFyAKQf_K5K0Le08s4SwwHl5JOTFaaXLBYm780CsjPvw>
    <xmx:KzpQZkdFXpOygFfbY-QHw_MKyqH61xclKgoAdlGU6uriLB9gqm7xlA>
    <xmx:KzpQZo3lu2EmCXE04pSWmIlx-FxGkccbNmXVPuS5VhIBICDCzKKBLg>
    <xmx:KzpQZo_81sNZRcGFcliFUiOsf5KMSdjyfGGIqR9FScZ3Vg-LdwZzmw>
    <xmx:KzpQZloUPGVM1TbEshjDnnrKLLpK5xJRf60IG_mbCnekoz1aXJ3yqSXa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 02:56:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 325528aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 06:56:40 +0000 (UTC)
Date: Fri, 24 May 2024 08:56:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] t: mark a bunch of tests as leak-free
Message-ID: <ZlA6KHZtn4lvyFcI@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
 <xmqqwmnktocp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8fRZQKTWDfy4o4Wl"
Content-Disposition: inline
In-Reply-To: <xmqqwmnktocp.fsf@gitster.g>


--8fRZQKTWDfy4o4Wl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:44:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >   - t4153: Passes since 71c7916053 (apply: plug a leak in apply_data,
> >     2024-04-23).
> >
> >   - t7006: Passes since at least Git v2.40. I did not care to go back
> >     any further than that.
>=20
> Since the base commit you chose to apply this step to (which is
> unknown to me) and the tip of 'master' today 4365c6fc (The sixth
> batch, 2024-05-20), we must have reintroduced more leaks.
>=20
> $ SANITIZE=3Dleak GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue \
>   Meta/Make -j16 --test=3D4153,7006 test
>=20
> dies with
>=20
>     Test Summary Report
>     -------------------
>     t4153-am-resume-override-opts.sh (Wstat: 256 (exited 1) Tests: 5 Fail=
ed: 1)
>       Failed test:  2
>       Non-zero exit status: 1
>     t7006-pager.sh                  (Wstat: 256 (exited 1) Tests: 109 Fai=
led: 6)
>       Failed tests:  14, 70-74
>       Non-zero exit status: 1
>=20
> Here, Meta/Make is a thin wrapper around "make", I primarily use it
> for its --test=3Donly,these,tests feature, which is an opposite of
> GIT_SKIP_TESTS. (Meta/ is a separate checkout of the 'todo' branch
> of this project, that keeps things like whats-cooking.txt and
> miscellaneous tools I use to manage the project).

Hum. Both of these skip a bunch of tests due to a missing TTY prereq on
my system. So I guess it's not a regression, just me missing test
coverage. And seemingly, the same applies to our CI systems because the
pipeline is green there.

And indeed, the TTY prerequisite fails due a totally unrelated error:

    Can't locate IO/Pty.pm in @INC

I'll fix this locally and in our CI setup. Ideally, we'd also make this
thing more robust going forward, but I'll leave that for a future
iteraiton.

Patrick

--8fRZQKTWDfy4o4Wl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQOicACgkQVbJhu7ck
PpTDuQ/+KRoQbrGZbPNhHkv0urBHyrBkUmAOCv6k7q8csW7rspZ/80s9iTiLFY7U
/shLFoZpiwVDj6AovYnq41Y0ym7WHwED3UGUuU1RlTe5by2c/q8S4tFW2ycukIjd
dB4zJWIl48MW8hJbZAU9+7C8ShHvFmQu0p/52I8vfrW6qBuIhVnHU01/XfvxWqU5
Q9+sda/6dIGbhaHQCFzb75OPb75NaMvsTUWDKJRHm0rnnDg+O7VGRLMOo9DjONFG
c6QOy+JxI03/8y+WiYOJm9dcO/4vuSg9lsH3JR9axsjl40KfklE4kL246ILEb+wd
hQwfEb594Ijh3HTQBBtbg8YJyLRd1AtJxyRKHk2RGIP+zZ4mdt52FVLVKdUuRxk1
kHq2asYb+hm4bURoESGnq0WlAo5OUheSIBdwMrRzYnuonfnkPA8k0BnrL/DKfur8
UHz4jjhcWrLmKdWTRb3gHpVj/CBTC+QEaO6Y4d6o7cdjvPUzyH0XaN3cm+nguBkE
/Xb/StlruPHd3OTx8rLEKmawU5E4xvgXETFg+7KM/ML4FtxALnSaMpfYfgdl4Mcn
rCfghQJ6O/HImhIlZ3z5brRvacV9uoFAlhJ0YJ0M6FMartvfPTat0aJvaWLUYCfJ
HaKQFU5LXNFvszq9rtOmgnM3C6jeRTGXpy3bYVbidADkXplF9lY=
=dLnq
-----END PGP SIGNATURE-----

--8fRZQKTWDfy4o4Wl--
