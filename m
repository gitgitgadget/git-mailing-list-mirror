Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185218D625
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006924; cv=none; b=eZGUSgvOrd4sKqYqN7pw1YRQ7te0KokwOUjrq0f986tMk12gV3OmkutuwlZ2IVwsO1A1VTB9xNQ0lx5mMODtegqxQoj4I3EhEeO7ITvi+FBL5Xjhq7yy75ghRdVWpq9IRDLr2GegXENba2/kYAc3Mn+2WezvJjH8x59E+uwe0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006924; c=relaxed/simple;
	bh=h7YclKVS1BseILP3Qn1SxDqpSloDjvEYHzBpIqHcvrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co7qL/mHU177LwPS899//WC1bDX010aK62rgVii/Qa7a5vH3iAhpSlC8rM4c9/hjy8xlPW/HN3k1SB3kFHUbYKi9ZXd48mbYWiomWGxV0NVD3YQdPTPECKNHFuru1Fd/fnBFutkzfiMtMFUGzer80r7chcub3VSq4F8ci3kYnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aJpU5l05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BaXMVIx1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aJpU5l05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BaXMVIx1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE82B1146DA8;
	Wed,  7 Aug 2024 01:02:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 01:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723006920; x=1723093320; bh=geA+U5azak
	VvYSf6bVq/fKG/jUdA3oxhi6AF06gqCw8=; b=aJpU5l05tI0evhIaa7QkPf5sA+
	8Hn5f3bj8xvMyOhiUW3AolPXdkkezBXlUwOz/zDFdZAz2jL9FGr4AKZrf0EROtCi
	oMSmqd5rEKzigzDH8TRVWTD70ddtMXBUHl5mlTz01wboFf2zafsVG7TP9UE4lweq
	YezAUmxLwcJGcblccDVgkB8sdjIF9z+UZb2zwJChy3uwQjUKIPQF9nr7Prjf8mGT
	PbLGcBBem53GN9gzew6I6LF/hQwo18f5gjvhcfFEokWExYUECqCQ549qEq9WO29X
	1UR0t00mhd7zmcpmIspPwRMRd+eQVj+v20U0Fab11eYyeQ67eiu1YHatkVdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723006920; x=1723093320; bh=geA+U5azakVvYSf6bVq/fKG/jUdA
	3oxhi6AF06gqCw8=; b=BaXMVIx1LDJ/neqrk3nsh0PD1BhT+5kbNx4FUsGjQiPb
	OnhOxAFMP3+cglEJ2eQNTAvJmuwXEsRT6DDArcmHb7KHhl6FOTZ38EqGqCp+PWun
	akzGL9TaSWF/BPdD7qN2qFdEaHLEgVizU5jaj5EuHnPvmV233iSaIz5zi2hfPGPs
	SdS3jmtX8VRseOpNHYDnVjBm7UWAQqA4Amkzd2+AlhDo5klPhVYyl+gH/U/VDAw6
	UZDAqc4bWq+MMPjg2z5wVmBeFy9j3rlehybtJAooCpm23pE05kWiemexJnOF1dBq
	z3eGD2B06q7IOob5EMK64GoYrQn90HNK05LytvgrFw==
X-ME-Sender: <xms:yP-yZh8LlABbaOIoo2Y-AzfPS7o1Zsn20Q0EeZ0KPXyHjTM5I_YpmA>
    <xme:yP-yZluykKuY3A2ygM8b-x_W_FMwDkHWSAB6KcZnlU4xcB-dTBXq167km_LJXkxzK
    pFiHaiUBc90ihvG6w>
X-ME-Received: <xmr:yP-yZvAKHlqhV4fcar3ASgn8gH2UsJ0eGMOuFcu-a9qdoVFPuK-aChxW4ot72deR8uSfsxHdxPedqOndAyxnT-Vo1PyykBGPLUKKsx-Mwb8_I3pI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:yP-yZle0wdYX9Iis1FvKiNki_v27ECl9sDztNO4lO3RMiF-S3haevQ>
    <xmx:yP-yZmO392a_FhilXs3YS2RsGsiY_XkXMqGdS0DlCMBc1WsGlk3Lew>
    <xmx:yP-yZnmjZtDGXIMB-gmUHGxu5zfXZpA-avh1-_ozZdwXMw9-8nZLpQ>
    <xmx:yP-yZgviuwZnAGr_mJQ-NW7wjBJ5nK2Dr4ZYK0kePxP2k71UmkkVyA>
    <xmx:yP-yZjqf6Elcm8Cyect1ULv7MRoqfpQ2af6XFDmWf2D_qMtKoyqG6YSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:01:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63c48ba1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:01:54 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:01:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [RFC] usage_msg_opt() and _optf() must die
Message-ID: <ZrL_xI0bNga-RqCv@tanuki>
References: <20240806003539.3292562-1-gitster@pobox.com>
 <20240806003539.3292562-2-gitster@pobox.com>
 <ZrG_A3UQk56aYJ_m@tanuki>
 <xmqqed71vbps.fsf@gitster.g>
 <xmqqmslptw3u.fsf_-_@gitster.g>
 <CAPig+cSobEaKf3G4OQ7wHYMXTB23mHdwk2sJi5t9+X3ZX_xcLA@mail.gmail.com>
 <xmqqikwds8pz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvNxh1tBGF2d7gx2"
Content-Disposition: inline
In-Reply-To: <xmqqikwds8pz.fsf@gitster.g>


--kvNxh1tBGF2d7gx2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 01:21:44PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> >> I am very much tempted to suggest us do this.
> >>
> >>  void NORETURN usage_msg_opt(const char *msg,
> >> -                  const char * const *usagestr,
> >> -                  const struct option *options)
> >> +                  const char * const *usagestr UNUSED,
> >> +                  const struct option *options UNUSED)
> >>  {
> >> -       die_message("%s\n", msg); /* The extra \n is intentional */
> >> -       usage_with_options(usagestr, options);
> >> +       die("%s", msg);
> >>  }
> >
> > As a minimal "fix" to eliminate the user-hostile behavior, I would be
> > very much in favor of this change.
> >
> > (Retiring `usage_msg_opt` altogether would be even better, but is much
> > more invasive.)
>=20
> The above is following the usual "we make changes but be nice to in
> flight topics by keeping the API function still available, but the
> function now behaves better" pattern.  In other words, elimination
> of the API function is a breaking change and can go slower.  What
> needs more urgent to get to that goal would be to adjust the tests
> and documentation pages to the fallout from the above single liner.

I think it is fine to do the above as an intermediate step towards
dropping `usage_msg_opt()` altogether during this cycle. But what I'd
like to see is that we already convert all existing callers to stop
calling the function such that we can rest assured that we really can
drop the function once the Git v2.48 release cycle starts. Somewhat like
we have handled the deprecation of `struct ref_store`-less functions in
"refs.h".

Otherwise I fear that it's going to stay around indefinitely in a
misleading way.

I'm less sold on swapping the "usage:" prefix out for "error:". I think
that the "usage:" prefix actually gives a helpful signal to the user,
namely that it was the user that passed unexpected arguments. This is in
contrast to "error:", where the command went with what they gave it but
ultimately ended up running into an error condition.

Patrick

--kvNxh1tBGF2d7gx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmay/8MACgkQVbJhu7ck
PpToQg//Yjjhusa4VbaFouqYMCBLhAN+4Ztkp6ZkmbsJmYPFX2MI8Db1vTzGK3WW
oY55ig85IyUD7b0seShuGltGg/m9SVJt9oelzGpE9jN5ew/tT1ejz1l23a6AMk+l
L5DeDWwpin7jXoN7TkgYEtZjbxIChO9YYz3gIm+Hi/SLWKCyNLLT8CNtFGs9cqkO
MdSsUl67D7ZTQbmVf/ttkvNYDpUDz05ShQsUKy4A5MdGcYGq9vFDSa0teW0U6Brd
AB1bDxjH3taXAjLQKivN4V/TgvtOqZthX4TEA1c2Qmu2m9XaktO+NO89yKQc57aY
NPQcU3w76Oy3SGKeZkBVvZqtmryrNQrPF1hO/3VHDXu0cHIrZq3t9erYRcbqzPSX
lGdShpnh9Mq2RDQuNQtSAXlKXtK6PBMHUcLy9mWDARUg2/0vI9lW4NTWuY9M7qJG
OH9i3z2e622hVcDg20m+lWkmKoZYp7IlgcQ02bQ8SMW8khnsRoMATXGiiHC+rLgw
mFNUpNs2VKYGJ8t+1ljneCmqEL45bHZ5UBpqHnz+dR4EM4WbDoiHf48P4V9G9UMk
fF8cDzpOtGTYApr9eMXFKZvplwkSZg1AG/t8q2NM8YcVR/j2OlRv929Pte6uhfA8
E2vERbq+7yv3eTe5h1MQCxvBsHNHvLmo0JG5DXH73F7R6YpMbWU=
=KH7Y
-----END PGP SIGNATURE-----

--kvNxh1tBGF2d7gx2--
