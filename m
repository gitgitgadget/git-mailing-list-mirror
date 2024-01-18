Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A554208BB
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577905; cv=none; b=PJwqxmtDHQObwyrvOHFgKw/stPj7wQBGomD2vggXQxBZbQyfRvy/xD4NOP+QzwT+T8ZNfipztBP42awzKDdu4J6VXbi1k/TXWw4fn7ZYppeTowcWK7XGK4q7TYI2Dq+RojxOUnGg3cYvSPqHWHT4dijG1qYX4EDejG3FuMX+UWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577905; c=relaxed/simple;
	bh=xay0rklrOIMTdlmHWg3NC7cvcSUWnrbwonTX3cI9EhE=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=RQRJAWb9noaaqRSlvZIbAQ5l7GaS0IgcxZkjDiO0R6i2qTq49fZ3Z8MrWTu6VN1TDGwWDZsf+qSXRekq94SveCJwXChhYTeirkr+3qBV1Avkec5QPSkaWmsX/Yq+GG86q2YOseXDEym21S6POOwhdT5HDjJP3boHuTArPaRFUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ObnCcyf3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UI8RyMGd; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ObnCcyf3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UI8RyMGd"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 1B1B33200BFC;
	Thu, 18 Jan 2024 06:38:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Jan 2024 06:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705577902; x=1705664302; bh=ZfPEcw+S4z
	F2VyNmTXlLTKW59+YPAMPlu2u4TyxG76g=; b=ObnCcyf3w2xDeUUB2tSmQCA4qR
	gYLtWznibX3s8gI+IfEOiDlo7zu3sfM+lfouSS3lXCdr0/rft8fvzrgPJq+Z3F8z
	JyUDfcu57KBUiD8TnHeHqXSqYUoBOJz5ao2TJToNl8Villn/jvXYz/Z8AXZQedyV
	Hozxbn00NIW93yvnIX6NApSV8Q0YGStEpPx64xbaS4KQ4MtU+fv0El0irioRCUgF
	j8YliCKlan5qr0h+7I9KW7wyyT93qkW28MeNNDpaYzQffFsPbJK6x0vNCKXd9vsK
	Kt1uWc7CfTwvqZEQ1+CdKVTW56O7cdXgMS7HEyQ9ZXmXPdg12n6Ih5MsD4MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705577902; x=1705664302; bh=ZfPEcw+S4zF2VyNmTXlLTKW59+YP
	AMPlu2u4TyxG76g=; b=UI8RyMGd7QVezrCn7jWr5zf67t5fYLoIGOtqZmtE9WYZ
	q3VbQ3vOzWnnuwlSqXRms50F+SY5547kWTaOtmhqmeji7oNPzVHnm8xA5G6XudAj
	/biNouf4SL8kUC7yf8O+abc5qtTfL2QofTnEk2dtqmx0Dg+VbqzSZHjYxaPC8kiD
	9DmSQyXfNad3+x8lxC0yjkBMlnSHgOIESM5Sbkhvd/ADM5e/V7l+XOX4yNPJ47B5
	c+CaSix1clAaFAU+h80Oka541E3S8Dhtb9C2jtU+8F+ajsDgtEe8uyDVlETXVtZD
	rqtt6oWyJDV5e/Q0lWtUnM07Vk10j6Cv1QQmmLNykw==
X-ME-Sender: <xms:rg2pZQXMnXtoE4ezZJjNljea8rF2l9teqnQRfvpVbJQfZrKGwybtVw>
    <xme:rg2pZUl4DhoKX-Si1HK6XzckJw7-sBHLW9jBnFMXuHbwaA1Y8GYoKkyJH3RTytkOr
    _P917l0kOUfXGV7vA>
X-ME-Received: <xmr:rg2pZUYl50CMS5D5KlXjW6caW9kXaPTvdnPHBS5ogFgQnMrKSLKU0QwywJjOLAil_KIQBuuVSErJxq5uaWQglbGOdC-Wqg6h0se5p7G03zOdqU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rg2pZfUuU6NhxlAQCnV6iKF6zizEsYHk016CnTSakRKK_Tz6s8yf_A>
    <xmx:rg2pZangukJFAo7tIUxefL2uWV4DrI6AE5HICQFoCRUnQ1y0VC6zBQ>
    <xmx:rg2pZUcaHHrhKxCWCj8JD0vZAiLDl9yCT2yfwcxtWB65MGVAUWlElg>
    <xmx:rg2pZfz519f7fM-WDnlF2JgAWBe6K_Vy_kWUBogNCsym0LIOxxeZwQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 06:38:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6dd4efbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 11:35:25 +0000 (UTC)
Date: Thu, 18 Jan 2024 12:38:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/12] Group reffiles tests
Message-ID: <ZakNqm0zyw8IiIhB@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <xmqqv87rsan6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j97HEkR1nx5Jfq5h"
Content-Disposition: inline
In-Reply-To: <xmqqv87rsan6.fsf@gitster.g>


--j97HEkR1nx5Jfq5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 05:17:17PM -0800, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > This series groups REFFILES specific tests together. These tests are
> > currently grouped together across the test suite based on functionality.
> > However, since they exercise low-level behavior specific to the refs ba=
ckend
> > being used (in these cases, the ref-files backend), group them together
> > based on which refs backend they test. This way, in the near future whe=
n the
> > reftables backend gets upstreamed we can add tests that exercise the
> > reftables backend close by in the t06xx area.
> >
> > These patches also remove the REFFILES prerequisite, since all the test=
s in
> > t06xx are reffiles specific.
>=20
> As we already have REFFILES lazy prereq, even _before_ we enable the
> reftable backend, I think that we should start t0600 and t0602 with
>=20
> 	. ./test-lib.sh
> 	if ! test_have_prereq REFFILES
> 	then
> 		skip_all=3D'skipping reffiles specific tests'
> 		test_done
> 	fi
>=20
> which is more in line with the existing convention.  It is more
> efficient than "forcing t0600 and t0602 to run always with reffiles"
> when you have a CI job that uses reftable for all tests and another
> CI job that uses reffiles for all tests.

I think it depends. If we use the REFFILES prereq for the files-specific
tests, then we should likely also use the REFTABLE prereq for the
reftable-specific tests.

But that raises the question of whether we want to add a CI job that
exercises code with the reftable backend for every major platform
(Linux, macOS, Windows). If so then your proposal would be fine with me
as we make sure that things work alright on all of them. But if we think
that this would be too expensive then I'd like to at least have very
basic test coverage on all platforms by always running these
backend-specific tests.

Patrick

--j97HEkR1nx5Jfq5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpDakACgkQVbJhu7ck
PpR+6g//b+IdAeLxRXj0QOTOMuLGZGwDakXjvVKH4VKmJZ9kiXNUCwPMImIbpKwL
TcRZhUd9eeorNux8e7br37o4ZTbk2WVl3Igaa0COv5IKNU9jHxsgsGw6vV5lYBPS
ePEjnPVkXZQ5bp/yezS8iDpQlWm4L/kQ2qb/+6IpOIeEXJiPTfjtzHnk/PduOyPU
D1/pYlF2kY4lHTxXaNLvZqw/dJP5GQhU0jEYp6zn8DfSn2hkE1dMnpNoJoHf2Zuf
nUr7FqUQFaIwYxTkmD09Axb1jbwKKy/UoHyZG7DdJ6qSL3nacBA8EIIzGDyjA9kz
DMuxX3vGhn5FoxpxQDyOGhpIGUmuBXG79IaOWcqf9NSMksLM3cXLCHietiHmrEgG
hP/7y43Mo47qha4NzbSGUmpisPOkN39ZSeUjQ5KblI14wIX9vue+DggvvUxNxSdr
5a0WbhQr6RrK4+hxYQYz4gC4zYsK80mzVTAGT3Xr6tn0oBt/8zDUHIBHr0OAaoYL
yC7fPEZ85xs8bj0BBkEkBaPsDNXfanyUMDcDyZs11Y/XmClZF/XJBPwPp+diRG39
5ykSzJ7XkSO5gxGCMVg3y2gNDvHSstkD0Q1ECcFfax04nCR++Xzr9c+KFIya28FU
rGW8tg1sFjkLxW8V/2Yi7rzV6+ikppdOq+TScul28tbSzsBfySY=
=khZB
-----END PGP SIGNATURE-----

--j97HEkR1nx5Jfq5h--
