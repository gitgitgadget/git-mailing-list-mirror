Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E28060C
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656653; cv=none; b=f+YTwylLTXzXzXPJxvAvQ31dR4BR4UrR5LBsumLOasoKoqLGlRVfJbH/pK8DHCwiJxISgym1bH+xPK+j8wY7DVUqeqXgOTRhcI5UQzPOjMEOgsVgyxirOArl8PvxAp3zVI2hNgLfdZlxOhMGDhaA5EnEK7ZLfNEZsNvW7T0JMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656653; c=relaxed/simple;
	bh=PWarfxANwsJzXlVZlShvsfVghK+vKYMcc91LgFZ9rcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyFyrnZ3AwrM9P1BTCYf8LQzIP2F1FYvJsnE7TT36zasyn0ZtmoRnQ5DU6vO78tgs7ANPIVW6k0YhB6iIBLVr1uXr5T2HjI3NBtW19j0OxNob0pMFz485Ki8EDCHZHrgW2Ax8/5xheD7dkkuIRo83pkVK6fkL85Pt/p5KXYHXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gwtSOiXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iy1PvIun; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gwtSOiXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iy1PvIun"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 9577A1C000EE;
	Tue,  9 Apr 2024 05:57:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 09 Apr 2024 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712656649; x=1712743049; bh=GJkNXnE8NA
	xaKyeeAg64n7aZ/NzvaM12wYxeqEK+TX4=; b=gwtSOiXZHIKH2ZUSmvQXFROd1O
	5JtWJQz+30vfP/ENW5yhgFhoCq7PJDaNAuvY5uZegtIt5Wai3w0TLjlkwXITVcIp
	Bz7yFwxrJAXHnqQiUTnQCEzRb95aFqZRW6lZd4LUvL2Wf1sJHN0YNrngzpKUZZA5
	AYYVLkUsOuLfFfaR6viFn4k4YtCHmTijLJDVokkh6Xdabqkdp2OaFNm3fJJGbYgS
	YB7iv8tcOuFMuqDKox9jAxjgz4gvF9AAmP3mO+o8wSt6M1TPkWctFKb/skzl7pCC
	ocb7wMfC0Th+gLuvckaQFHoIE6ERVq2+K6LB3yAW9SdpwuBQw7/Ge/3HDpeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712656649; x=1712743049; bh=GJkNXnE8NAxaKyeeAg64n7aZ/Nzv
	aM12wYxeqEK+TX4=; b=iy1PvIunpq1k3WyOCP7RKBc66iLcSoDeKIqI/wsQvXYJ
	1a5Y6cwRN4chvX+PPS3/zYJYqHockJ65Sqf2S27GSJaCH0MSb0EaWsapbV5V58uy
	YgmG04TygpL6DaVBB6uop1XYVCv7RAPND3x8nsHKyGk4yqqkr7jjpY9N1CXXNSh3
	Lmbm/vf84CUwmg+UA7MeRP1vSF8gCC27v9U+gPF2bYR6SusfilQAhGpSI+C+r9FC
	eLTT+FR140L6QY2TldOhmavnvx66Wa5lXpTsEXRzKaIiGd+Sd2ttcuytYa6W1JwK
	h7DeeBkXfoqWIXi+y03Bp5e7PEODBy4i3sb80Am0MQ==
X-ME-Sender: <xms:CBEVZqS4rHMo8NQaSCPEjTnt1OFJuL9pZhNqcBzijoDAah-VKVtCHQ>
    <xme:CBEVZvwRlCVq1wb2LZ_3TcQoNTAdyDrMV3gHrcF-ri37ZCoqm92SwVbu2cItJRq0b
    eKcZ-0oV1mebRGwfw>
X-ME-Received: <xmr:CBEVZn1o5Bst7rETujitWU88CTkvyt5M6EwzsT9ZQI-8I1CgjYFM5p-VkwXQZ2FMU5nF5H73z2VLSf5PRY6rHH3cjgqPdebV68CqZRZw1CiDGrHFKnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CBEVZmA3QBSNLHHe7kGeGRJKMnm98gFoPlJrsw1vsAkHp00nuSeV6Q>
    <xmx:CBEVZjiY29nzyH91_tdWbL11mm3VAzlTePj2wNl2u5M6YXZpVbCdJQ>
    <xmx:CBEVZiq8yHEkE1YIAdS9sE21CkDZPGOs-AH4crjzsYEWUfuT6go6aw>
    <xmx:CBEVZmhr2yBF2p2biLpqiOuvcIasUBpLu89LLDNywmY2hLJJ9-Q09w>
    <xmx:CREVZuWOCY4J02FzBgFQBbMGfnT4uedFg81T1S0Z4Xo743UW-wiWleqE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 05:57:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c721fdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 09:57:16 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:57:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] t0610: fix umask tests
Message-ID: <cover.1712656576.git.ps@pks.im>
References: <xmqqle5n2sbf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1BGHQ47Hg78bYtC"
Content-Disposition: inline
In-Reply-To: <xmqqle5n2sbf.fsf@gitster.g>


--H1BGHQ47Hg78bYtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

these patches address the issue reported by Junio where running t0610
with an umask of 0027 breaks some tests. The root cause of this is quite
simple: we executed git-pack-refs(1) outside of the shell that had the
modified umask, and thus we ran tests with the umask of the host shell
by accident.

The series fixes this issue and extends the tests to exercise more
umasks than just 002 and 022, which would have caught the issue earlier.

Patrick

Patrick Steinhardt (2):
  t0610: make `--shared=3D` tests reusable
  t0610: execute git-pack-refs(1) with specified umask

 t/t0610-reftable-basics.sh | 67 ++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 28 deletions(-)

--=20
2.44.GIT


--H1BGHQ47Hg78bYtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYVEQEACgkQVbJhu7ck
PpS7XQ/+LMdrrzcZpMXdPdHiLkVqZTchnkFWiKVSKpPped71qlGhqAh3Nq4xZ918
XtJ5W429BKZNi1LgyESqsRHsE4qFLPVX9PYuea2UbkQvgmiXIbni0DN6LJBIz/Dq
zoMCByhkU/8OXV39a0YEh4/UVHAShENQU/WRcOYfly1FoPhq3dDDOeyZLe3S/oJu
3KR5N7IE5AI3hMT9yR1UCQ670VL0gX3F5U36YHWaVTbfGKfXULeuWuSpeaVl7WIn
/Xr0dJHQ8+GBaTi4QpYwGH+2cWJbGKsYTserzO18dw5if99HPYxxjXHiIYeGR2oL
84Zt0hwZAR6oiW0EtF4olWUj5RtMGOYWvdAd0O1vXJsuUEbgQu5WDqBD3D3wt9CG
K65X0hBO9NEx9+xA6m795NlxPFhQvpwc8srJgaW6I1GxBtcYfdgvXSzL+1XFpPxc
+IWDSnM3BEPbfiEvCs3WT6FMAtdrlnHsl5g83h1iEp9O1Svjf1rPnJPWS7xVkluz
exQ9LMIkjpfu4/nBzijuDjzSCm8mjWHx0ZsRphk44dmzbRArucAi5DeOu3kiBkYe
RQV3YLglIzjGJO3UvqOy2VzYjr009XS4hbE3tb5Fw7lIuM8YMg4HNeieLJy1Zgop
xSZh2tXD+Y3e4z1MPPtqKUIda/kY3D09yNPPT+eP+pgNzJ9g8xA=
=z2UP
-----END PGP SIGNATURE-----

--H1BGHQ47Hg78bYtC--
