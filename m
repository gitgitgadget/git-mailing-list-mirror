Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1718E3F
	for <git@vger.kernel.org>; Mon,  6 May 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974061; cv=none; b=A3hv1dSzMvURKZs1bucbHFwUqlgGdbQIgenAutyZ2YGxxqlxDFeDD/WUATILb+k1DS6cwhBPDnxkqiVw7/haslAQq5QzNYljzmSVqa5RkMQihFNucYNpUJKFED8p5QRUTpT62iyG5kc2bdxnlIx9TUsB5kkV8tZGROHO3Dj6Jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974061; c=relaxed/simple;
	bh=nJtJ4FRpiksfvrZMgFMIeRFCIQvzHaa+LYwb+fiEDwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZGpNE6IRfyCfLJ/rYlGKXas5A5HqJmGO3cofsW2nirH5BxEnzZ2niBuscly5R0RtTs4F2yQn9jiJNSgFXDv/TqPx0o80pmDw0wU2DDApsRGVsQnV7vKk5XyaCJNAQOxPVk6USzlwaFpAaai7QPnG4HQFrVzR3MupDmiBMdwSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JhmJ6zSf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8pyJ63L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JhmJ6zSf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8pyJ63L"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C4C1138027E;
	Mon,  6 May 2024 01:40:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 May 2024 01:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714974058; x=1715060458; bh=nJtJ4FRpik
	sfvrZMgFMIeRFCIQvzHaa+LYwb+fiEDwg=; b=JhmJ6zSfVQ/c6eree4UKY/1zWw
	O3OwjTHnpOckMNj5drg0feHXTaW1PfzODs1HGa07Ax0nlVkfB4rBcyXpiHbdqJv5
	HsWT+eeRp9XxdBBAXo3LcUlJaad9yyJDhu4IDrck1AKN7d/+CbGz1uWpxcJKYg85
	p1xV45zzQJ926PUrOoVnEdycB7rZc9WrOV+DJ/lSCudbJMT4ktGGGkYXGfNKei24
	JLlBzG8HNbkJ21xqsgeF2xhVbiindnKyOMD1meW8dFVvPuRksxHpblXUZbnGlh/+
	ykNJuyl5kCBhBDhLq39iX3NgCywV92negt8uBEr0K+yApRF7vdyrs2w4Nuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714974058; x=1715060458; bh=nJtJ4FRpiksfvrZMgFMIeRFCIQvz
	Haa+LYwb+fiEDwg=; b=H8pyJ63L4Tqa/BK+Hoi87oCLPh3LeBK0YgDbTXbJpiRi
	YH+ch6DeW2+tKyPQhQNR5xaDYCOawKOv+yPUoUw8tiNiiHpk4V3dzV3UYYij6i7I
	5xLCwVrCBs6A1uRpWyz+3Ojdzt707TN5Ym3xUXZmzKzIRY0e2GwG+KEuG5qAdBZC
	YdquyuJ5WpSaZTvPjPDD3guWJX1RpTCeBCJtTre8gdd3gkbAVgCC4wly7ON/alba
	ytKV91l5B5MqDFouWmcR5NmqusNS68AiyqhjqeNv+APxxxtPJfw2c4sMg1HTH+1P
	bQTEFVv48X80bccGv7YtElsRAw/QD4TTNYj9F2WKtw==
X-ME-Sender: <xms:aW04ZtlfBashHXEFEhMAv5NzDSvNlqpfiw-_Lshe5TI7BRup-WaNGA>
    <xme:aW04Zo3haHdY7c71_ixw5kHfLoOFOYnGCUbqyt9H0c3qmDYAY-nTcRauJB9Db0f1L
    h9b4yXJkcgRL9tb4A>
X-ME-Received: <xmr:aW04ZjoPqT3j8zkx47lT3t7wYE8VokND8D2ReC1NobImJv4E3CM_VMzs77VhZK-8VakGEdFRxUYmYXcrrsTYPUUr4PujFrJ5hQfZwGuBVLXNu6rd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleegteehfefhgfeuleduffffjeelteeggfffvdefgedvtdffgfefjeduveevfeel
    necuffhomhgrihhnpehjtghhrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:am04ZtkDBb_yEzCf3QlNAOsYDKKqLzYPa2veAVy86CXgtmEJsqBLrA>
    <xmx:am04Zr1d58zyaJ0bsPg7VCIbbEdUnNU0X2ibh8tc4PdpYVXWtzK6Fg>
    <xmx:am04ZstT3e18iXaW9GGd6bLDpVWKQhYJeY-nhpb0AC0MM_XO4Wtw-Q>
    <xmx:am04ZvWgRtysEX0R0XyttWIf7Msj_W_KDP3A8jPFNnE2kcwsQJD3Yw>
    <xmx:am04ZmR5bQbcna6FlN4V6Teb9X12xsZN5S-My6mAwVdjWP3AbIWTG_su>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 01:40:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f405b357 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 05:40:50 +0000 (UTC)
Date: Mon, 6 May 2024 07:40:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v5 0/3] builtin/tag.c: add --trailer option
Message-ID: <ZjhtZb5nJZ8vlvLw@tanuki>
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
 <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jXx5c0UqPjC6oni3"
Content-Disposition: inline
In-Reply-To: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>


--jXx5c0UqPjC6oni3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 06:49:07PM +0000, John Passaro via GitGitGadget wro=
te:
> 5th follow-up patch taking welcome feedback from Patrick and JCH. Net new
> changes include suggested tweaks in documentation, error messaging, code
> formatting, and patch description.
>=20
> Since git-tag --list --format=3D"%(trailers)" can interpret trailers from
> annotated tag messages, it seems natural to support --trailer when writin=
g a
> new tag message.
>=20
> git-commit accomplishes this by taking --trailer arguments and passing th=
em
> to git-interpret-trailer. This patch series refactors that logic and uses=
 it
> to implement --trailer on git-tag.

This version looks good to me, thanks!

Patrick

--jXx5c0UqPjC6oni3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4bWQACgkQVbJhu7ck
PpQYDw/+KrZt86l+XVBcLwecwPwy9YXE2fQhNpbHS9G684fFV2aK9twZpOOsYQsE
DSlMSbVBvtS2hUGDXT5JCY6AHKCbTcuij8pXHF0BxugNYF8iWbiZM+YWTJbenkd2
l+yNxUTeI4Fxw81fVzXX00+8sFwOxxITq1LgHKTzEnESwkCaqcMB2lcCPW5RDJjK
jQOFGsqCk9nqNnl599LRguETJl134pGEFNBt35+YxySzNPLuIxlo38ODPKiowy9i
bUQ1sbkdRyT6xSEBPG3X71jlR6cL0UG4KgUzx5R79hhyBb9HI4WHmbWoTXpQJ7MD
diMwpVzWO/EUDR8ahaSi1fM2TVhGsHjqkFDXrJ70tfSf13XeT1vlIHwJVgarenAE
Vjp21PsOSorlPeh31HmyNM/Kf0Jd2g81SUfJwpOdBRgr5Kf8hsD/4smMyA2+4AI/
lZArQyuIJrjWD803FP/uN+5NXmN/m36gst6/ljTSAh9aAOSUNimkwpgXetFiIsHq
mBG4nNy2zO7y+PkpTcoxcR75fHI+Tn4WIi/GWvbFyjSvjhnfq752JPR+66BAWC4/
1ER8AvLvpsVEht/UDc+S1PbT8YSrBMKVAgI4AKqu60zHE4dVfpSCqxFoMnU/EijR
Wolb7L1Z9Snmma7Hxl79ZKZ2Ya6bA5Bx0gNzjDCrH+DE8dCtw+I=
=3yFV
-----END PGP SIGNATURE-----

--jXx5c0UqPjC6oni3--
