Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8815B99C
	for <git@vger.kernel.org>; Wed, 29 May 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962428; cv=none; b=r+JhEhFoX/hKY2sFlRfhYjmWzWITwtA0dd5x+vwbjV4AQm4KaedJiiYKrftHOkUDdERD5pczhDC6v+JW1se4S80UxMYw5Z6zS8Lu1xrCouuRLznKsFUwej6ut3zIFdpJEyhCTiqR42QsOhOSm6tA9p5intUDCbPJnRln905KpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962428; c=relaxed/simple;
	bh=3IzTmYG7IW8HshtS8LoBHrT3AbH/gYiO4MWB5ZOVJGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlhdbO/St7qExWVqR5mKv9dSN/DxzCzKKSeJ5b5dk8WW7uvrJZ8QkAipzgC50ziQOtzoRorVe0ScF4AVt6zriixqBvAExYv9f3tI+qnUnyDYDlZ4S6D9aypD32nBpgfJNjEP87avFj4qSUeFdjv8Rv1ILkZ4cZY4Vyca9OZN8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OZyuMSor; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBMl+24A; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OZyuMSor";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBMl+24A"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id BDA9B1800124;
	Wed, 29 May 2024 02:00:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 May 2024 02:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716962425; x=1717048825; bh=3IzTmYG7IW
	8HshtS8LoBHrT3AbH/gYiO4MWB5ZOVJGI=; b=OZyuMSorDAHsN9e3TN92bHrRfc
	IdEXLEe4EhdDX5ot+LNxmS3odgphYol8D2R1jkvM99YmSNB3R5olvHvjf9nKyOya
	Nbn7OSjtQ1W9p79EV2KegLMXGnNhvLdN0YnYLD1GktkAK5apu2dKmGc7WmFZd3fx
	vV7OH5V0BPgQgGo4tFPt5jheLrw0zWTz3pupgcHxt1Lh5oLNlQpnhcp/oXRBE12w
	9fFLJFz8txQXTAYGZMV8Ob49/+ThwzKRKEdugpigKGQYasVQHM+B2JidwmUOqkdl
	/JvHuRszswlNGy9BLcD/ULbuLTS4epqEJZQG/QKRuv7qxYm4V00mH7iswkow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716962425; x=1717048825; bh=3IzTmYG7IW8HshtS8LoBHrT3AbH/
	gYiO4MWB5ZOVJGI=; b=HBMl+24AyIABZhe4XU70SJ1e9BhtVq6xCCNFXJ6a0xEv
	5USxrJjlMP8nXJdUNESTIeWtI5dWHHy1ZexeLtu6MIG4tS40B0OpQbBovHCJ1mgw
	ovdtnAMi8zLE2hWynMPhdhXgN1X9PtqxY/q4amuGUeDJpZS6jAUKZHZpBPbYV23V
	tUje5/ljjd8oixP26KoGFMi+56DaqZ6MY5IeSwxJe2LoCYYX09OQQ4/PHqnBe/wj
	DoTTJCjFJNEpTzCfrIwGP7aucqI0/fkqbriE5m66kReoMpcG8/zHFbm92A6UVCnQ
	YxFx9yAVJat03n9ZZKmVP5kRP2hJvaRPEnRUtqEtvQ==
X-ME-Sender: <xms:ecRWZmP8M5japPrhtvgkVu7GlR4_DToS9rmfnEDbms0MmRUFta889w>
    <xme:ecRWZk-EHVAWONx0oiWmq23Z2OZ4PbhMR4o1ykNvXKTO662Z2nnGVsepwBdh-F28W
    tXWJhDBLWHFtsFFTQ>
X-ME-Received: <xmr:ecRWZtSnpBP49PATRbXM-U0ae55EoA7aZmbxBTrxlLF5VVGnfYgywSPtAkgH_IBjeUN89_U-UEu7bZw3A1bHfQdUmEvl6I4zCaJi12dPevJ_ooOP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeejteeiteelieefhfetleeijeelkeekvedvfedtkeduleehheeffeelhfeuuddu
    ieenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ecRWZmtZNyBjFaDOhpkgP7kk54SQma94DF-KqBlCFFBQRfc6iNGHvQ>
    <xmx:ecRWZuf4zuYAmM6ruBTzu9FcqL8rDQa8U7cj5lZ_nxQo5CIeE3iMbg>
    <xmx:ecRWZq0gmoFLTlwAfk0dsj-1WyZUOnCXuJbLqSMpwjxB2STNytIF3g>
    <xmx:ecRWZi_pFEDgtCc6XEyPUjZj7HuH1ZehB7B9eX3bARF_-7fYTJ9Qtw>
    <xmx:ecRWZt7OQnlrSXgIPWK0zU23bvbIgtcbY3hG-hEypbOtpg5Krqk3tf_F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 02:00:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9d1fd6c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 06:00:10 +0000 (UTC)
Date: Wed, 29 May 2024 08:00:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] t: move reftable/basics_test.c to the unit testing
 framework
Message-ID: <ZlbEdZNbrVNEHFLw@tanuki>
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240528113856.8348-2-chandrapratap3519@gmail.com>
 <CAP8UFD2ObwdQVE9Ta+th6O-FC9cTR8sNxsrSQWBXosjP4ccqSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jVIdoDuNv6g4V5c"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2ObwdQVE9Ta+th6O-FC9cTR8sNxsrSQWBXosjP4ccqSQ@mail.gmail.com>


--/jVIdoDuNv6g4V5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 02:34:05PM +0200, Christian Couder wrote:
> On Tue, May 28, 2024 at 1:45=E2=80=AFPM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
>=20
> > diff --git a/reftable/basics_test.c b/t/unit-tests/t-reftable-basics.c
> > similarity index 60%
> > rename from reftable/basics_test.c
> > rename to t/unit-tests/t-reftable-basics.c
> > index 997c4d9e01..b6088e1ddd 100644
> > --- a/reftable/basics_test.c
> > +++ b/t/unit-tests/t-reftable-basics.c
> > @@ -1,16 +1,6 @@
> > -/*
> > -Copyright 2020 Google LLC
> > -
> > -Use of this source code is governed by a BSD-style
> > -license that can be found in the LICENSE file or at
> > -https://developers.google.com/open-source/licenses/bsd
> > -*/
>=20
> Are we sure it's Ok to remove the above Copyright? Or is it safer to
> just move it over (and perhaps add our own)?

Good question indeed. We should retain the copyright header given that
these source files have a different license compared to the rest of the
codebase.

Patrick

--/jVIdoDuNv6g4V5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWxHQACgkQVbJhu7ck
PpRfNw//U6Bh3AwNqu7bBkg6G7lLe1yFKTYQnP+HICCxMpvTroepmJLY1+hfSVLY
c+1anIZGvJwcRWQBkJ1QwfARoFhwU1IohIGiDGQjpVCDEwg0rowpin4KVmMH2QxU
g34f8hfy0Z8dY+xoINMm6yVkv9nVQjaO/pDWr9xEFyd8Sk8PKCTQJ6hCfaLzYfGJ
bZvkSwmfV3m1GQXmOlxvs64D0HIx1Qdp8aq/lwFM0/dT5JWGRCe6ZyEQzCAv5Clj
HU8IAXA4BbitPfhAnVT5cHQRjYKJJvn7Wvh9qvUytzEssU3NNkOa7lInIRfPnS2w
zwXmJlmaN9r+8jATKHa+Y8XXixWExOxL/PqRkVPxMw7VmzCVJkhZXtPv4WuPOBFD
S3l999hCi6ELBWqCkBgL6iwIvWf2+hhctVJs2GGboUdIr4v8zswXXk2XxWb6W8ZD
CAieullZjI+fKbC6vhsJ5o+UTsR24f/sN7JnFfvqV1CzLbBvunpDTtkvmNhDiXp0
rDb1mi7dd34YCHoDdpqYM7Q9K/+Nh9HwzJ4MRtbkd2TYc30DAMVwcdke2uIuHL8a
U/hYJkvDAo9TL3LgQQLW5FAXTRnDViw/so4KlDeizxwYs7dE4Q8wifWJCbTkaD75
juG9YknHd/IYHerV0Rnk3ZO3xadEyC5TiI5/MXCpQmRyumFCGco=
=9OIl
-----END PGP SIGNATURE-----

--/jVIdoDuNv6g4V5c--
