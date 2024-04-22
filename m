Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7C47A7A
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767707; cv=none; b=ZKKQafVjMiN1Nq0Y5v5CVuc0u+Ee6FhvKPvZIo0yRVyi7f3YtuyYnUAlZtONl64N0wSpIAjxTl0qOOuMKn/hdCAnAFGgCg34NlqEle2MdVfa0Wc+M03wf4wSG1fEIlKvwzhjWqLnt+IDJT6kNououMYzPelnrQzKG9pXeY9MBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767707; c=relaxed/simple;
	bh=G6bQ8tgf8FrIoDuzaUunM8NnSBku04oMJ9pntHlEndA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mDtMk074qil2PACt1bVSV+QFV5uMGE9WjDcN4tI+33XeorFYVIoJ4MxGDdfAX2KgypWB5kZybRtITLOyRV33pwQW8+1XmeFNeecuh5Jil3/u1w1QEa9S6xQD4fig0AQHcjCqjsUlgMPHlKy9LbgWlqVUFn2ITxNEQXwJQ9Ctrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evN6Kx9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=It4xr2H1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evN6Kx9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="It4xr2H1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5211C18000F5;
	Mon, 22 Apr 2024 02:35:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Apr 2024 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1713767703; x=1713854103; bh=IKWKNw9NsPOE4E92KFvijRk6U0kqtdn8
	SC7SCmO7IuU=; b=evN6Kx9u4Zc6l7jKUVb82X/h5fQ1ETeudQfTDia2aqdUWWnt
	3bwZupGxD1Jqd7gImfPTLwlMv8TiHEv4fMhuM4BMN71p8KX+xmnySc81UtqP0fAQ
	/hShiYR2SCDfekB1qsSnAFWlMTQLO5V/Wj92FAxo5CjccsbO2EK2mhm5HVkf1Xen
	oF1/9uKy6I5dttmAFa5tCbYFHxj6foa+seej92E0dRaaa8p5IXhjKxwNCq7XKSnA
	zYs+tuOdigmdxfgBKoad0B8jZpz4F2gw72wh7Rkh0CH2evz8J0tQ5g+WOSdyYqXf
	KdAYDSZP7CzkZlsCMziROlCaEMBY3FOpOMBzeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1713767703; x=1713854103; bh=IKWKNw9NsPOE4E92KFvijRk6U0kqtdn8SC7
	SCmO7IuU=; b=It4xr2H1rQQ3YxpqprVEyweTsOOEyFH1TR9RL0AK5eFqAHo9uNC
	pf6DmNuAscimARpgceH6wsPq8XZYn+pxld+9S9mTp0pbKKoulFzrR6qHtokIlbY5
	PhqmZ+hMbmlcwwBYEXXbvfjXoliGUzOal82t6hHgUF4RGndEeStXmQ/nndtlI00R
	og70i0nvilDJGru1+Q6/idIvoi04KCbei7HKoi8DZd00HMlsmUIhIjz3CccR7K59
	YATzGs/MOujSn75otQhJrS/yBLNexJoY4JBbiGGq2Y8kULiyz0HOaSnCb6Fm66a1
	2/mQVdCD8kLI7h3AjtwWdeL+NmG3qVZPt9Q==
X-ME-Sender: <xms:FwUmZh_qHrRxctPByUmM1DlMipWA2inDRUPIsTmmkUo3ih44yobafA>
    <xme:FwUmZlulC3Y4VqT0Cisr7ZD1UTHmuq4TLP43BEYjZcKcvzrf5CO9xI0AzfuzW0-_F
    arziZee9_6ns8U2Qg>
X-ME-Received: <xmr:FwUmZvCByQpoy3qANc3AEQnNUdYADNcWMrtNaPhAMC1kA9HXT5jeBSbN3J9IoOJ-dZROPhuDUrwlZ-s93hebXrUtYfiFqntijzp1nlVYdr8yhKLz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepuefguedtueeiheetleevgedujeekjeehle
    ejjefhhffghfevgfekueekjedtieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FwUmZldfrdBHOpMmUZquqASh1WoTLPivWg8HUFTXw-j1vKWqS4tcig>
    <xmx:FwUmZmOG8S9ZQRaIljn-gTmf0vpLPKf8A-sFpMMgKAO3-9gHizEKxg>
    <xmx:FwUmZnnGvaaxWBr_2z7sOyOFsndQCdVyMTZ7Dfm_V4fUvJvlDa5X3w>
    <xmx:FwUmZgvJR9d74Y8onmR3MHbWVghSDNI66R30_hnV93S22QkLIKuXFw>
    <xmx:FwUmZvbcs9Y6WjXuDxezcOLBngFf4hg8D1hEPOm81f2dOdXhYSfV7QAW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 02:35:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8b49a09e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 06:34:56 +0000 (UTC)
Date: Mon, 22 Apr 2024 08:34:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] docs: improvements for Git v2.45 changelog
Message-ID: <cover.1713767605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KpqCbBFTuQDwvazz"
Content-Disposition: inline


--KpqCbBFTuQDwvazz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this short series contains some small improvements for the Git v2.45
changelog.

Patrick

Patrick Steinhardt (2):
  docs: improve changelog entry for `git pack-refs --auto`
  docs: address typos in Git v2.45 changelog

 Documentation/RelNotes/2.45.0.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--=20
2.45.0-rc0


--KpqCbBFTuQDwvazz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYmBRIACgkQVbJhu7ck
PpTp4w//crzRQI+FC0HV/3FaAk03axoocBh6n7s22qWSfrjLriD9EvUVeQEs6+qd
Ma4kc97KGJ7xqUqofRMy6afyrMiv2MMNLci/NIwYJil4on6IVBXHnhGtBhnpCKR5
Zr3r3Up9fHRtQfKLp+R2h3j0WKAauXSjFPzdyF0XumnvPqRU3r4OLmVfP7ddiq45
XMRhU+iqr6jlbf87dJQL8CervkZDI28EDwqWOithZOEEvgZmbHXwj1Jm2m/p7g4M
DaMHSEKyjM3tGPOq7/dSdUynQFV77owYWNbbq6QiH7/8VfhxCPrd1XIAoMJrFLX9
e8ATKmoNk1uNuKXthYSvHAkAC+VOeUVIXSO0jvweAB4BmAdLXTc/Sj+LzCRO0gT8
5rifHEyg60G6miMx54ZF0nmBM6zSaj/XXEPrv0JY7q84Hswh6I+co5IOkAE/7FKv
9acsGPb29CvfgQH8bIYhtyw1WcpekKMKF4akirkmKPY5RRjLD4eyUVWAJ/XXTfQy
Xj9MFz6VVVOtpHTvC5EaCPS5HLAAEA/Bedh1PAGMhSCRcVK4zECSARkgqh6qCcsi
3WL4PfXKpjENFTMKe4E0UeDwiJhtoqsxRhLA9U3iWybTvLpMtWl4EiDK9mfftXzV
PZZ2wMWDV56bNT9yAdkh7/qS9Anv7/z7x8+Wcpn0YkXzPa9Sr44=
=Y77h
-----END PGP SIGNATURE-----

--KpqCbBFTuQDwvazz--
