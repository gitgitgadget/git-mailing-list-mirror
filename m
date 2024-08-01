Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78A1A57F0
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523446; cv=none; b=P//U4NGrMYfFSL35p9yLiIb/CLsrz0tABQ0Yert2QHo7Ifh8GkBIuOgrpg6xDSDjqHRmtcPMxeV4QThaJeWDp46scIdSibFxUJjomOIEJloLpSV4I6cQt2WUVgNETaCSAAH4qlQGdf3XIvWrK/hZUqsIOkxwAl+hurkZH6w2GFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523446; c=relaxed/simple;
	bh=3lMjeRk4wVBNxjOF8rj20d39slyJT8beyPa7LsU8ux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyceaRVb1LRzf4XheUGAk4Onz5JhiMfZ5KpYPuI6m7HpiHrIFoU8VbldAxnt+6kM/tFmuZe8hSEUxCqofFRgk0kczfZRcy3sax5m5PoE3JbeYmzaiD43oulxrJV0ZWOHgZO8MIheURc1EMmmvJClSS77UdIPtANJi7PbAgcZ7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cBoBqiEG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZrh81uj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cBoBqiEG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZrh81uj"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B89CA1383A38;
	Thu,  1 Aug 2024 10:44:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 10:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722523443; x=1722609843; bh=3lMjeRk4wV
	BNxjOF8rj20d39slyJT8beyPa7LsU8ux4=; b=cBoBqiEGhJBdYY6RZ1a3XVaJpu
	bkFmVBx281UfHqI3rmA07xN92Dh1dP8qiQ3uXAHOT5XdnX8fRN95XjDHBAxFCard
	kC6WYXoYqxyR3HhAntw/JCkNmhydw+6TlihD3qfOuL+vJmgFAoacusCfTioTxzRc
	YPrbxeBh6IqoUPL4maDA/98dD0sGUorVm9ukIzoqaSgL/mtIt16YLYdrsp7gDuVc
	uE7ln/Qpx8V9DuT2oMRKaObMSd5vAJtnZKo6kOBJgNiWLywb1sxxEILNCKI+CMy/
	FPBkahWVjoiRdAxrXAeWe7661xt2ZUrew8XhMqI4THglz6KVIafpbwrgLVYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722523443; x=1722609843; bh=3lMjeRk4wVBNxjOF8rj20d39slyJ
	T8beyPa7LsU8ux4=; b=LZrh81ujePa96xiOrn2Nu7Djk38zjh9fHhkXfA1Ritfe
	mTgUXIe9M7W8xMYlGfIzEkkhRQBm7WDTRP/0n3dKML6/dlIvSxiZwwbinLnvL8us
	6g8JAtZNIsJ1+K+Br+GUi8Utc+1dwP4/SR732HQdsBq59kO1Lyp2Z8ACsDZY0B5q
	G3gp8f1LCvuOt7KiMgDW58pTjPunb8OokiAG91BSdlVes6uAAPjYRK/u9vKfEl+P
	jfoWP1tFWz3ylaxv0B7tA7i9ITMyQs8nGUJSS0RuFoVKDfcZIP9wsTZgJDxrLxNx
	9zpolM5uEzV0G5BP57xPxj/3phdqhHnqqKyfE6/DlA==
X-ME-Sender: <xms:M5-rZu4ZJUddIAIF04CerDWYdwM1vp0-DdAkisiotHfNJf7K15y3Eg>
    <xme:M5-rZn76dTMJtXyf_vBP_gkAU8vfEMmLrsmpty36Zexnhy6dy3rUoVg6CZhDl6Ru1
    VHy1IXgzrEkn3MWyA>
X-ME-Received: <xmr:M5-rZtcz0Q-KW77DxSWc9cO2FGzHFP3xX1EmKItWpxJdEbGQeeioldcf6tg6jl91QTIed9NV9dnCi6Y41GRN4NBLkJnJisA2rlFXBhelp_pk3po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeegieen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:M5-rZrKovTGNhdHOifsHZMPEBEt4ANIS4uDZhS74f9gG7hlqhXALbQ>
    <xmx:M5-rZiKErK8NbZuGIFXl8c1IySR5OWMY0S_FcknFFO0SJdRxgF7ttw>
    <xmx:M5-rZsxqaZekecObIzvpekO1xYvlbFa9YjwywlI3xqhOuLl-RwonNA>
    <xmx:M5-rZmJSg_xo9aEGCT7N7-Qsb9K7F3GD2Hw7gzcd7Ejk6Aze3xrcEQ>
    <xmx:M5-rZjoga7BExpNJEffvsCX1SCSlc3ADUUd7UBKdXLQa7ZLGXr0i5AfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 10:44:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5c79d145 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 14:42:27 +0000 (UTC)
Date: Thu, 1 Aug 2024 16:43:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZqufLYWnj75VeDXB@ncase>
References: <00a801dae384$de2780d0$9a768270$@nexbridge.com>
 <ZqtWDtqkXzjz2A8u@tanuki>
 <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
 <024601dae411$faab2cb0$f0018610$@nexbridge.com>
 <ZquPfiAWgYjIPGRB@tanuki>
 <025f01dae419$636bb790$2a4326b0$@nexbridge.com>
 <ZquSkkR_aw2IUdX2@ncase>
 <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com>
 <ZquT0B-UXy73x6QI@ncase>
 <028501dae41b$c277ec20$4767c460$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TRqTWy4dMb8cRbXV"
Content-Disposition: inline
In-Reply-To: <028501dae41b$c277ec20$4767c460$@nexbridge.com>


--TRqTWy4dMb8cRbXV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 10:04:37AM -0400, rsbecker@nexbridge.com wrote:
> On Thursday, August 1, 2024 9:55 AM, Patrick Steinhardt wrote:
> >On Thu, Aug 01, 2024 at 09:53:52AM -0400, rsbecker@nexbridge.com wrote:
> >> On Thursday, August 1, 2024 9:50 AM, Patrick Steinhardt wrote:
> >> >On Thu, Aug 01, 2024 at 09:47:38AM -0400, rsbecker@nexbridge.com wrot=
e:
> >> >> On Thursday, August 1, 2024 9:37 AM, Patrick Steinhardt wrote:
> >> >> >As mentioned in another mail, we do not use its Makefile at all.
> >> >> >Did you
> >> >> check
> >> >> >whether the version I have proposed here works when running `make
> test`?
> >> >>
> >> >> That is the commit I have been trying to use. make test in clar or
> git?
> >> >
> >> >In Git itself. `make test` builds and runs our unit tests, and that
> >> >now
> >> also includes
> >> >unit tests based on clar with this patch series. The clar Makefile
> >> >exists
> >> only because I
> >> >did a 1:1 import of the upstream dependency. We could just as well
> >> >remove
> >> it
> >> >altogether, including other bits that we don't end up using.
> >>
> >> I see. Well, the 2.46.0 test passes. I ran 'seen' 5 days ago and
> >> 'next' is going now. Would that catch it?
> >
> >No, as the patches in this thread are only up for discussion right now a=
nd
> have not
> >been merged to any of the branches. You'd have to apply them on top of
> v2.46.0
> >first :)
>=20
> Do you happen to have a public fork?

You can pull the branch pks-clar-unit-tests from
https://gitlab.com/gitlab-org/git.

Patrick

--TRqTWy4dMb8cRbXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarnywACgkQVbJhu7ck
PpSzZA//f3AFq9PNrsS0pRuc+S+vaEfrCTQ4rnWfSlYZSZpKffOwlN2gUqZ9ZLr1
2M+zZGlJ7d0uVIpKN0AERNinq+ccU9p/823tn4p/L9a/dpDLmX8VO0xBCb8UlIG3
k5pc0pHNu0PUEX0A4v73WH/gGlJk92U3GuDRXub3zDq8OnDtXuo1PWBEtwr6bzng
mM/vLsSJam5S+rK5RHFz6z/HYJP7zokm6HfWTKON6BLB4qfFfi3MGtdh4Jhjce/P
hnG81+bIIPTfgysgstf1VNHA0T4meqMYIkhKomXVjiQbNvd8NuR6l4oOobxjAfvj
V0z4sHd5S0rR0LFCw6MIyTD1ZAX8kK91Art9sNqbrA4MS8fbYnHzaRTBgyDL98mK
r9eE9JKZVOJbebg2pYtZITzS5CW6P35CGXdvV6x5r8eh45CFNxXmiLyzKmCob/m6
XuqzWvNL7ga2qDl9u4fwMfHOPXgja8xBU/zlgZaCW8lOcSAum5tawCKAzK6meFp/
0+u+jDMujCb/IVaODuA2ERRlTkC4Ubfd6FI4dOkrcR8Nus8sJOuxk6hm+wseNCba
FLJvfGyX8g+R4TFphKRZycVjF5OX1g0sjLvXliX6UMCZy/cdAKbYP2eFeb1/KQcC
ove85SRc8aOO+5H/kPGOX2KAIjHJYzTUU5gjNeLxMqg+JI4lOr4=
=YSnC
-----END PGP SIGNATURE-----

--TRqTWy4dMb8cRbXV--
