Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D1134C7
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983987; cv=none; b=ePFGWE1O8TQGaZvK6GmCjcJUE6IAFuhNiATSkl4BAec6wUZ0SkbmX07uxMh5vb19UcLYAX7uFCbPxWJAWYL3z3tQdNg0NCEbPLvQWV2nCMneFkb7q+vYjeuugav9xpSQytQBj9FQkhqdy1ZrCG+ISy8O5+qPESfhXL7CmVg/LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983987; c=relaxed/simple;
	bh=/nslBpJaDu6IypgL/agD9r7+ZuqYMx3PniiSa/WlTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5QWMhbmjp+rTqpZXeZG9KFyjD64qH0LfovlRWM6Eb+cGbyeGYSIzDTR0JTTGZ4S3po663nDvWm8NMrZb8+abvXSsxVDzWAtvn1eqFHfFRvXASfEDE+gO//e5w0rIgIKy/CVYIGDVGOh7jdv7VW6tmM1AbXxVqIjcNJS4twgSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ade++boM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyWSrnWw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ade++boM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyWSrnWw"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 920B913800DF;
	Thu, 15 Feb 2024 02:59:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 02:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707983984; x=1708070384; bh=i4T4BT5C1a
	2TlYMBG0IzYYwAx7TLZHxULtD6yCbjIFI=; b=ade++boMewmE2yR5BBy0q8rS5U
	j8ShwW46fLNfsi195AwnAaFl+Q1XvjwNvbHh/N9dsqI9kxJs7FE7LO2CMKHKX7Sa
	Y5yGE7H4tMJONIeoYKTJtvUsH6WA8mRBEuuRF1FOossiL4Ltx1iu80v6okMsgpAU
	UJRytjJmqtiTMrKSNDe0g8WuAESDORnjIYY+N8SVwq32o7kpkPOTFmsr94HJMeJA
	v1ov5H+/2JNYTUocuc92FiFKamn22SPp4R4SeIRCUvqSqJ1bLIXMNVC1x/RTHObp
	JocxCsydnSCnaiwJcsgLXNg4SgAXqa5Hvtui4Sr2Pi+7uIYpcsRNdNm3ro7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707983984; x=1708070384; bh=i4T4BT5C1a2TlYMBG0IzYYwAx7TL
	ZHxULtD6yCbjIFI=; b=EyWSrnWwihgfXSsOOM6VWB3UY0KqaSwkGNuRKqHdiA6G
	yHTl3K79LXDvB1C5gIOq3os9ajdyBZQDm4s0dH9/PWkq3v0QZyv+jBfg6hFfbUlb
	cP8nD63E/9XZ8JgIB02dqFu/hD7z3V5uAMjcwxe/4ULqVIytAabZRFQ2i9WWQgRo
	WEsOvck9sH9xPjIDiymQrt6k0OrYJkABT5A0cAM8WGwcI7Uuh0vZ40BAKJgpNm0/
	2ul/Rt/I+RecEACqSq9M5irEQqL2sD320U8eEmBDDh48cFY77l6cFJaj8Nu1CVXg
	JCljuNBCVH8Qz0trpB+UwzQpd9vv8pJdFbg1tkWAQg==
X-ME-Sender: <xms:cMTNZfklZhqcPJNs0xRW-n-YY4jAIYfVESk523vz1_xJS8WKHAdn9Q>
    <xme:cMTNZS39HTvfSpbbZQGRKJKbObieWbQFok8QmS2rj4EkMV7tZsCdzK2Am_rDEdElM
    GTBDLqwXxuGjenX1Q>
X-ME-Received: <xmr:cMTNZVqSF4ClHV9cBRf8YUTXYjZWQj9qqcFeFdZHoTLmRVNO8yrdBeOphHn6VIMXuDNYeUX0w5jWlBuqyzI5fr630922Ka9x6UcmM93swVcC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cMTNZXmYYfO9nSnoVtq1ZammcoLtROWcsvM6fewrv35H6r1PoUXYtg>
    <xmx:cMTNZd1lWglKNeCiqqSfGp5ao3P6gZqdJ5Yynt1NhycnFaasxJyHMQ>
    <xmx:cMTNZWuJpEGnsWoJXBjlI9MLESXJvcjGrB1H2i8br2IhcBOEox2DnA>
    <xmx:cMTNZWyRrt7i6_rNfL7wXknsgYRo1ac6GLY0elul7Pk6RZxP7JmnzA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 02:59:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aff74b54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 07:55:50 +0000 (UTC)
Date: Thu, 15 Feb 2024 08:59:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/7] t0410: enable tests with extensions with non-default
 repo format
Message-ID: <Zc3EbCXFdG8E7_v2@tanuki>
References: <cover.1707463221.git.ps@pks.im>
 <feef6a3e6cd0d9096816d0a8a5789837fb784517.1707463221.git.ps@pks.im>
 <xmqqle7mu00c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmsdSyO6BABfu25u"
Content-Disposition: inline
In-Reply-To: <xmqqle7mu00c.fsf@gitster.g>


--qmsdSyO6BABfu25u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:57:55PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In t0410 we have two tests which exercise how partial clones behave in
> > the context of a repository with extensions. These tests are marked to
> > require a default repository using SHA1 and the "files" backend because
> > we explicitly set the repository format version to 0.
> >
> > Changing the repository format version to 0 is not needed though. The
> > "noop" extension is ignored as expected regardless of what the version
> > is set to, same as the "nonsense" extension leads to failure regardless
> > of the version.
>=20
> Isn't the reason why 11664196 kept the forcing of the format version
> because it wanted to see noop ignored and nonsense failed even if
> the format version is 0 to ensure the regression it fixed will stay
> fixed?  IOW, we force version 0 not because we do not want to test
> with anything but SHA1 and REFFILES; we pretty much assume that with
> the default version, noop and nonsense will be handled sensibly, and
> we want to make sure they will be with version 0 as well.
>=20
> And once we force to version 0, we have trouble running with
> anything other than SHA1 and REFFILES, hence these prerequisites.
>=20
> So, I dunno.

Hum, I guess that's fair. Let me adapt the test case to instead use the
DEFAULT_REPO_FORMAT prerequisite then.

Patrick

--qmsdSyO6BABfu25u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNxGsACgkQVbJhu7ck
PpQZqw//bSQ/05ga+Vq2+aOeHsLOFK2bliz3iU2Y3uYqiV6dPfdCZPCRU0Qi6HT7
c368xVjyb8LiesSAn7+OSmCDceQ3qWIR7/N/smVK3NMW8kC62wRpbcYz88pup7FR
30InABucXzOxOH6XyU3AzhG1tMZpmHi9eOnJq98tvaecdawsne/nyRKVx7DkeBCm
LiwENqIEtgHwsbjPHIQUvwvmPTjRV5S/67ow1gb2f1UXM9rgSAIZK8o4Xyj+Mq4R
rbG1G+uHIV8pLcuxxkpWBXMhqcmnoXKc9Mlac9B9jFbfkcxcylZBXYqAJWO4z7Ie
jiDGxTtibVlQO+GYkNsfuzOr5/kqJBGzlou/FQKO5+Ta3Ap8DeMcCx/aIHdxPRn2
44gF+QotsR/PXeZqVUrHhxjaySkojbmQ8RtvVBIzAMlL64qlPjguRaH9Qb0g2B6o
7BA85pALVNdU4xO/iXJSz5PBUMgICaL/IXQHhagL/UO0yV+il501HWgzc7jH+DYG
OKcm2S2twrcJETUVWzpDA9K0jkwOBU2Vm+nQyoA3AmBJY9q+9W0cUz0FCYs4Nwk4
4Tzg464B+F3xhj4YZyjTYRwjdSma8/UYgl1XYiaU3+Ir7Zl4RQozSQBUDmyTkyCq
8o17UAUsVcH9Z+Vr+aaDZirP2KEW8Br2kvII4NJhZjPqeaG9U7o=
=ezW2
-----END PGP SIGNATURE-----

--qmsdSyO6BABfu25u--
