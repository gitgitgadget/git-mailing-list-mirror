Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A6181BA8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095513; cv=none; b=YqVlh9eCqeVMtmy115H1AcolVrAy7swMWnrd8qSy6xgjJVcqa/XL67/afn6MRH1boL5gbqOn3HZKSi26TePSZowjZ62BuoHP5bu5Git3b/xlvkjzYeEDKkfXNbz2vz9mqx0EPH5vdVNwlrFdFCaNsGM+NzI7xUugRy2d2snM4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095513; c=relaxed/simple;
	bh=tkFeRyEn5Yk03Bn0wIZHZL+FHlDtcZEjrnLkMmaYQfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyxJvxFcps1ogyMLjncgN60rUEvhugQGNbYZivslx4Tp0II4pocB19dYACpXqu6QICfn7l8m5dX5JLRf3f/E9COmUkWoSNEWsMbOQSCyhCxK2cG3c3Fk/LALVePfYdaeum/sDR6d1b4+xCq21qFhkXMdvRbS0mzmfyis/3oHfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j2tl71Jm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVSSG4wO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j2tl71Jm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVSSG4wO"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id E7384138FDF5;
	Thu,  8 Aug 2024 01:38:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 08 Aug 2024 01:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095510; x=1723181910; bh=XDfgzyJs1v
	nZMaodvPFKz/UpbIPYPIyen5/O6Omiou8=; b=j2tl71Jm9GIyym1AfIeqeD4PX2
	z/48DE/nYhoNKz70uex1JQLsbsT7z42Ao5BYVrsciEgIYw8xEFAMEF2YceKmAumR
	feoiOC+LMzjQbgy2AYZ6piiqfO3Zn/GmeH0oOhzDfBmEfFAbZV50o3XPgloAktnc
	ybB2rp4LnD1yKTeVvfCZdnIKTpan4Q0nbKzpGX26O2JcM/G3NgBoaVZ6nsfyP5FW
	xtU1JNqRQT4JpqfV+u37YfzdFFYK3JxDUQpZqde+axrzpHRcx9p5/K3xXZjrXvqO
	RVeeHaSqrHGfKdWgwatBRMvehivszXk8U34adKSKVx9TC5KWZvre1rmT6hQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095510; x=1723181910; bh=XDfgzyJs1vnZMaodvPFKz/UpbIPY
	PIyen5/O6Omiou8=; b=VVSSG4wOg3BQjlE4ojPUHAUjjf84N+9QJbAlaolwhkVb
	wzyKuF02+DSP3fvufMzvC6FRENPD0FZc+dtncXp4+pi9tv5a+fVzuEC9UimB42YB
	6a6LDreFX4KJN0dfAaR8AC0aQ+Qjzt2HPJTaetyclVMo42rcMqmrJP2AKLSl6w6t
	VXNyMwcni7cJKbMBdm/wvAAO7qth0y8t2lLu+ILVu4LD/A7YopkQZ1lRC1JcldUz
	5BeWH5vVtdnFbt1gAOxjrw+As5ep1/O/PditVbC6XMtOPtEuxh+Q3RHVtX8pgh0b
	XKiM0xQnay5GW/YlHIBINia2NEGrqfQ2GJaEJDVuKw==
X-ME-Sender: <xms:1lm0ZpQInfTVatz5YrD8qSfUXx_jL9YY6AuP5EVDwD4qlb9nv-GyrA>
    <xme:1lm0Ziy798Qe4qSCF4geo9lwQxZkene7ITaPtZnZpf63T4XM_Z6kbEi1hcxeGFFUf
    5Zuw1xcwaDd45jG8Q>
X-ME-Received: <xmr:1lm0Zu2RlBtqNIoPjZJMl2Sl0Sz495ZnnaKFyGE8SXm_287lAZ9PKbYhnes0baKZjEoQ0eheGl52iDyS74Anj8rX1mjzXogog42PSrJ1LJXQj06A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheeg
    kefhjeehfeekhfevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhk
X-ME-Proxy: <xmx:1lm0ZhB8vIpD2zt5D0K4W-VzRCMT4fOLJZ8EPLqrpRp2AL9f7VtBBw>
    <xmx:1lm0Zij3uuTSHILSOqvk5zsUHVpXjrrQPjzDzXLRgzZfDySLBbNHsw>
    <xmx:1lm0ZlrIb2fKtjXAoQ4UCEEb-L4OEmHsCItvG4qEgFbX0HR-OyuT6g>
    <xmx:1lm0Zti7Lqo1ekeW0qPkxldTn_ocPWJNEKJFI_pSZexXDJx3N66kjA>
    <xmx:1lm0ZrXP72C5e475HI98j23Ni1m7I9EAyxJ-Ti_LVc828McEi_2fddJ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21ae305a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:23 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 4/7] t/clar: fix compatibility with NonStop
Message-ID: <7a76c21bcbe232c834bacc0f217371df4aef49c5.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gQ+iy2QH+Vk/290"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--4gQ+iy2QH+Vk/290
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sand=
box.h
index 7c177f3525..e25057b7c4 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) =3D=3D NULL)
 		return -1;
=20
+	if (mkdir(_clar_path, 0700) !=3D 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) =3D=3D NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) !=3D 0)
 		return -1;
 #elif defined(_WIN32)
--=20
2.46.0.dirty


--4gQ+iy2QH+Vk/290
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0WdIACgkQVbJhu7ck
PpRlZg/6AuDuhNjgMcMx8PqKa1q9sgr33MKGwJkmEPalRGfDZIqiJJbDzd7kFlRO
7nsixrDBP7YAIAy5+tGo+QiC6bfZUe3uxfPstqA+d++OS93RWdgc8pEbqNS/pYTQ
MixB86rv1zw58qVz1asX1DNmMbXYLOpOzT/PCmjxQ923s/T49rVlBQPZKghTXNi8
e9awM2zGsxu7GgiDCvHJ3jaPIFArNWOgV8Ry2NaW6PPv7X/CYG5ZCqNMj7K7nFSM
Rt28cfpS7QLByY3kr5PjYSI9R64TiNMXEPYMWHUrvkUZbnqjUVeplSSSOvDE0Io/
ahROBPDD0USCEurlmR8kdD1vGGjDberSJAVJ6sbSc3eFNVlKCYl1dv4xDyJBZi8o
OOgTtyoLxATLuXhPP7JocTBCAmc8REvjkMIIxz7UsaNEoqCryPZfDsd669WtockG
QxyPOCYhmRdMWH5JROKZ0Vrb8u7MoqiChhv7upMulpUSFzVCAFwpJclLOx0BMU19
Hhu5YkhGw0FCpyUQHtBzsosT+6GROd6M7CheQEjUheFyY9VnULCd8r3R80S9/bWp
rBMCJDvpWp5P3f9ALIGrdGpXaT6kuF5gAF1PzhLVxzCZR8L3dJTJ3geVyJZoHkBk
x1Ho1Jk/GieaahH22fklqiPCsfnuQPB9/OvDG/uBpkAA1fE212w=
=V2gt
-----END PGP SIGNATURE-----

--4gQ+iy2QH+Vk/290--
