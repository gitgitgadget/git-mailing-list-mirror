Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1F13B5A6
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941300; cv=none; b=PtbTS5JcxZB1CLvEI0VdT9zk7UG/bES7jjbdvSbXXwJbnuRkjE2iGOvhlTQ/xgO7PDuMbnC1/fJ2qxt905yXR/G25r3rzQa6/hRYDGO0CBF0J228BXXmZ2MId6QUWrzQmOtHzAhkFR0PfX5NNBCrXGCWe4nAxrWZjjOt7woiaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941300; c=relaxed/simple;
	bh=aQDo6KF3Ru8lW5LpNjy8vqxfd/39mKBpOu3YJWfEzyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPQILal4SxpFsAw0PR4XuxUtq2SAOVCSetXEqk81PP7aKxG4mpetU1f9ztnc/2kWhlGEpv9kq3YXcQNwKc1iiCjIzA4feHMByguSZx30tk/Z5DyBEos9j1boIEyix1fEwCMO4xENKTf/pKZObIgPBbcP82Dr58UGf4nQbq3223A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hdRe+jSb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1Mfr1EH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hdRe+jSb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1Mfr1EH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 221B911400E9;
	Wed, 24 Apr 2024 02:48:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Apr 2024 02:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713941297; x=1714027697; bh=rAS1KcFA1J
	AyDVRbOryOotywbFjk7hjvp3h70T5VHt0=; b=hdRe+jSb+yqtSgRxnddDRKdMCy
	fIzysqTX6hDCPFprFrVtT664vzkW3sTVwxFClLxeVBI4LtBhtIlGVdcQIo3ZXOQQ
	Z8+hLGgbWIWUjYcipqPCV+zQnUy915Kv/4oqX3UMT5TDNhNifz6e/F+hsvYcIOvk
	9obF3KPzvr2l6Koy0yR1kdFt49JS5KwnwaKpw/MEM2ARyZBvfulQvNpU0tTVikUe
	A5WLWOUvnZ3cv896434/uuPEHQuZdDSr4UXjvlrHvik6pQ0penB08r4EccdADXIx
	CnRM/PffUC88J094HSMGiD+d/TJ+Dr78ZqvPhxvIrYHid4aT/98/xh2U518w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713941297; x=1714027697; bh=rAS1KcFA1JAyDVRbOryOotywbFjk
	7hjvp3h70T5VHt0=; b=a1Mfr1EH3PLNzFi0AlcFgG8wss4umRFSGqF0MA/B/rCE
	/Qdes4QfVymFuUYIpQ8iapx0JEM9Rezk7ZBZ5QxDEJ0CWiThiFNqGIAxccQv4TFL
	KtvReT9TJ/dcOkpdKU9vRejE/Ldrcq2YCV6xzBWzx3GGss445BKGsn18LWeZwZPE
	iiJdlslw2uKTgVpXWmro7e7QMInEPuVuFq72oJAVIcfSYLf+WSqiDJeuRkPdXRfs
	+iVK6Qk/7QUdMhDjDghvTpgUV6DZ2hF8xomf2UQy7aA1axatg8RPNOzJ8TshfEtV
	QSz5gx63g9u6s+MeL3k27X4PQaM4DOOeFYJcgk+WKA==
X-ME-Sender: <xms:MKsoZo6FZcQnoKE72GyBsnFmMlbnoIl7MwvmKnHZgWsZryQlM_vkOw>
    <xme:MKsoZp6NFWCq64O-hsqknNPu2Ww3PbypcJu5b9jZC1LLu-f9Ynqu7nc7RL10UQUV_
    xbebgECkqyl_G5AFw>
X-ME-Received: <xmr:MKsoZneYcc-hfKp_zDaYpSm7VTwmL3tuMS7HVbD6ZOyCUce_M2raEVxLnPor3k6RiZCKNL0_DzMTTGoBpFsw6BHpdy5ebMbN12ovJSxMLSvzTn0Vcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:MKsoZtJA8GbvORA2vRWNaWXZW3jxuHc4uovG80K80tmOsZmzAQd1Dg>
    <xmx:MKsoZsIJZMjwPTtghyPX9JKkBCQvPt764EiiAWJvuvak02u2sRNdXg>
    <xmx:MKsoZuwPG-_XHNUudVU7fBndSE-bCeT3Dmxe34QKaL2j_2HzkxcylA>
    <xmx:MKsoZgJhAecL6dLF21ZCpnbs-_0_2MBaJqmfKeizMO3kMuYDaw4yGw>
    <xmx:MasoZg0HJWh2zPOQn2udMCP2MBlwlhCraYeRyuE2ZNqCBhwail5Iyo9P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 02:48:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 93e52178 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 06:48:03 +0000 (UTC)
Date: Wed, 24 Apr 2024 08:48:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
Message-ID: <ZiirKgXQPLmtrwLT@tanuki>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ZuHa2Hx8P7pyBfW"
Content-Disposition: inline
In-Reply-To: <xmqqo79z2s24.fsf@gitster.g>


--0ZuHa2Hx8P7pyBfW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:28:03PM -0700, Junio C Hamano wrote:
> James Liu <james@jamesliu.io> writes:
>=20
> > This patch series adds an "all" advice hint type that can be used as a
> > convenience option for disabling all advice hints.
>=20
> Hmph.  I thought this was rejected already and not in so distant
> past, but I am not finding a discussion thread in the archive.
>=20
> The design to support the advice.* variables to let individual ones
> to be squelched, without allowing "all", is very much deliberate.
>=20
> A user may think they are familiar with all the advices already, but
> with "all", they'll never get a chance to learn new ones added after
> they set the configuration.  Looking from the other direction, a new
> advice message is a way for us to tell our users something important
> for them to know.  For example, we may plan to improve a high-level
> Porcelain command so that it will eventually error out when given an
> input that used to be accepted but behaved in a way that newbies
> felt confusing.  In the first step of such a transition, we will
> introduce a new (and hopefully better) way to achieve what the user
> wants to do, and add an advice message to tell the user, when they
> trigger the codepath whose behaviour will change in the future, in
> the old way that will eventually go away.
>=20
> Do not close that communication channel on us.

While I agree that it might not be a good idea to set it for our users,
the usecase mentioned by this patch series is scripting. And here I very
much agree with the sentiment that it makes sense to give an easy knob
to disable all advice (disclosure: James is part of the Gitaly team at
GitLab, and that is where this feature comes from, so I am very much
biased).

It has happened multiple times to us that new advices were introduced
that then subsequently caused regressions in Gitaly because the output
of Git commands now looks different. While addressing such breakage is
easy enough to do, it does add up if we have to run Git with every
single advice that we may hit turned off individually.

Now one could say that we shouldn't execute porcelain tools in our
scripts because it is kind of expected that their output may change at
any point in time, and that is certainly true. But the reality is that
there aren't always good plumbing alternatives available.

Furthermore, we are often forced to parse fragile error messages from
such porcelain tools because Git doesn't provide a better way to dissect
errors. Error codes are mostly meaningless and there is no other data
channel available to us than the error message.

These are problems that run deeper than "We want to disable advices",
and we eventually want to address those over time. But it's a long road
to get there, and meanwhile disabling all advice would be something that
helps us make our scripted uses of Git at least a tiny bit more stable.

Patrick

--0ZuHa2Hx8P7pyBfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYoqykACgkQVbJhu7ck
PpTX2Q/9EuZaM1nOCewKTElV0y9B2m+0j/IXbk5sp3VVNDsM58Sckh2IoiOzzLL3
tQ+gQxeaI5chkFtDmxmegx93X0P9r+wJ8chETenyy/IRZLBvv9ok6NRY4UazJOOD
WoLdlSU5a7LXxxpiFjVaNOpiCE68jUQav8H8lRnH+PI7WIKaLyICjLgRUngmT1i9
W1NeUV3JPQKygXZIBLqp0BQW04vjQKf82APxKvq4l5hnp0GyUNcdVkXJ6OOIuzla
A3eGwAWNfHSOKiETHb6TwMjuYiysjRIvlHrF3bTG5UYT3e3IEf08hhFdmB3/rHAj
EMgyYK/+x6Op5sTgCT8+cCtnHaE/Dj3Ckje31Z5ixqFHwru+TuiPM2oH2VqUE2fD
piTbxdomdv5LVM6Bl1CjKBUG0w5bD6PMWl4mJrqqrMP9cK/cPoPlr0ZxX8tx9j6O
seejgHYYBILW5YHPbW9jpNJ4QidBKF5Wl4Pa4HLDPVcaV5EWMzeDt3gALYn/HJae
ub+ftqJlXoWuyoN9Al+ooBHiJYjJGD/wgugehSMXphU6GL/jTQvTQhCSw58kJIYm
75By+0/gyH6J6u1XeHfa1iMmg1xAtwT9eCU1ofyEQwDKImKWsUj925vxW3KS1Nk5
Nrs9oTUaWWJlLOVXzTnHRXbyeiMCcbga3QlLYsKdkpECOA4js48=
=jTcS
-----END PGP SIGNATURE-----

--0ZuHa2Hx8P7pyBfW--
