Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704433CC4
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592178; cv=none; b=AHdhFmcEqB0zxk4g5JA1skFjIkYLCTvYqDGGb8cg5apH3fH9iGLtOLHCb2j09UHw189GsF/WRhTGbR2R1qsoPJ1Y2W4e2dtX/25LaCXR0KGJcmBP2O/mlrJFaWG5/s5e2gD/9ydFD4/IN4K7a6yhU+iOrrL0xGuyzaouMXfEPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592178; c=relaxed/simple;
	bh=yTr8rQrI/3h0Dkp3q7CtCOkv69X6Mik0CQm16NuBvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ur4YdbsJ8IrnvddriOiH7QQpArJfCHMx1tcvpjy23zAwq4d1rKeTmRal5tqDGldlNB2+b44qkSg/QrLHSX0cVwelXzEfD+cHpXTBYnT9WffefbeSMn9SLuCAhe9zQKkhsUy19aFX9RSbHTCl55aywOhJOJ1RbKpK0retGTHTR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l19lbcfM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdIn+2rL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l19lbcfM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdIn+2rL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id CEFB5138006B;
	Tue, 30 Jan 2024 00:22:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jan 2024 00:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1706592173; x=1706678573; bh=N/Kw/pD12WJL/524H7kz02EQuFy44Vz+
	USFZxHMgUJA=; b=l19lbcfM6lurDqmFPXWEnTA00Kk4XEQ8DlPsHLX1KEC+iHXf
	FU064v3515RE3Y/ZTjuo6dAMt5MKjEoR7T/XMLzgTprwUf48qqNDgl+Xhe5p0icz
	jfoBKGoOfX2tkAxoDzOH1QvOlPxxePNmbjdAT1JXwFCXf2Mn1Nb7f0JS11/tWj4g
	2LrKP71h8GLZzSzeRqMvtG9np9yzycfsLS42ZCYAbRmNLcv+P6TjIJIHqIl4Wh6z
	ad48U63U3b+BNbXHkWWaoTtVcZPpYg480E8CWuitS8c9M4/hwsOuHbTGkDCaMFqn
	0HuIS2jaLSLNWTknnhw3fIwtRX1O7wxwRbxnqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706592173; x=1706678573; bh=N/Kw/pD12WJL/524H7kz02EQuFy44Vz+USF
	ZxHMgUJA=; b=jdIn+2rLeipaFAE8Zam3k3l3QPtpSKlFyUwv34EC2zos/E0tC1N
	8PlEbEDj3JDzL3/pIJD9Sn4eKXkTC1LxHx/4btvg+vDDZOfal+IyUggdg0gRPQjh
	P9YhcGZXUDP9VaMkA7pV91k2x9TxTToNYqCMpfmIbIzUrSDaEegLfI31hXubvSNg
	5Sryki+rjCZUhJh4F+bS2R3KxR4P0hEE7yJb1xwIi8iU/gNyXIPV5C7hulCxSL39
	AHlDIelAJMWpBtKqtq67vvqqMWod8vYsgnyDLw9Bvf9gjOHvnZSg+XmUKNcpEFA7
	7zfJYhfwnuKHbInAk8b56udbOgrs9Z3/WtQ==
X-ME-Sender: <xms:rYe4ZZkvajZ_7o1qAttx83WRYCKtGO1PkGB2iOMF7ApFJ2vQ5VnyQQ>
    <xme:rYe4ZU3W-2iq0VXHXMPIxOrNYbe_ur0ZsH4o5WKJ28MxXtCtTalz5N_rXc_gA_yFA
    e-Xk--GD1ZBi7Y0BQ>
X-ME-Received: <xmr:rYe4ZfrEH0JQqAR34NJP0fpaWg0YhImDdOlMAMcXC6i8OZt20dt-MRE9l8FbHaoRUnQ1ihXjOTajkA3cgIjFiaOeSycx0I9XMmlMDZOFSp0p_z4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:rYe4ZZnm2lnNYieq2NRbZnuaGdmoWnzJzkihOu0cljVqF9jvvVUIeQ>
    <xmx:rYe4ZX1psWxgHhh7E0u8o0PN_MgOva3JsZO0xE9MABShEYk4Xd_Rlg>
    <xmx:rYe4ZYvUctKOYyyCUPplKv-ZX5iyaanelDU2kf7tCY2ha5WwijOYnw>
    <xmx:rYe4ZVBJP9ImHDBQl50f9rjyaqlyp4B9MrJuNjBGcKYN8wH1MCksww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 00:22:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b96766f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 05:19:32 +0000 (UTC)
Date: Tue, 30 Jan 2024 06:22:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>
Subject: [PATCH] reftable/stack: fsync "tables.list" during compaction
Message-ID: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0aTklQm5cubt8a9s"
Content-Disposition: inline


--0aTklQm5cubt8a9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 1df18a1c9a (reftable: honor core.fsync, 2024-01-23), we have added
code to fsync both newly written reftables as well as "tables.list" to
disk. But there are two code paths where "tables.list" is being written:

  - When appending a new table due to a normal ref update.

  - When compacting a range of tables during compaction.

We have only addressed the former code path, but do not yet sync the new
"tables.list" file in the latter. Fix this ommission.

Note that we are not yet adding any tests. These tests will be added
once the "reftable" backend has been upstreamed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index ab295341cc..01d05933f6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1018,6 +1018,14 @@ static int stack_compact_range(struct reftable_stack=
 *st, int first, int last,
 		unlink(new_table_path.buf);
 		goto done;
 	}
+
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	if (err < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		unlink(new_table_path.buf);
+		goto done;
+	}
+
 	err =3D close(lock_file_fd);
 	lock_file_fd =3D -1;
 	if (err < 0) {
--=20
2.43.GIT


--0aTklQm5cubt8a9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW4h6IACgkQVbJhu7ck
PpSSZg//Spro88O9/L6X8ISicItaqfCkqwiIkRZKdpTwR1H3Q8XAlZXxbzSoiqBE
fD+oJdBFn3978jtgAJ2jMqgnVvrH+lbQdVqblBzLHXzTuhQ7cR15kudtQSenygNw
EeWpVj7nfN5FGicSH2dpsDuXPVXkDO5Qa/K2/BzkqqcJga9h1bA8RgC/Yb+ZCtuZ
spfKCpy95i9fiOEX6iUgatEslZVrSXOo2UrM6BNuJOhDMJQIC/TMmT63VmqPj5iV
uhuEqn8825HQdtQE+7aUaOowo6DJni/6MDxXwMAYPm2JyBZ06hhAkFzAnQ3D8S/J
o5VlFnpNV7d7UAO8aSDkZSdOJ/N53zyXQT6Ip8BjGMOPVJI48t22ZckAov/2CtA2
ik7uTx0AyfdOHQJQnGU+dkuF/vTNaaVvgR1gHv8ylZnU1821G/OGyaMX8RCO5bLm
yjL5/wTbuI0dYcGB23GrnnKYSGnHV1Q9/OlPthUbpR7NvqAwTZ3DPWkHi3/ql0Po
FleTVCECDx3H3p69RYtjYY/CiYRVWNzX88TUWdN64JJxDCd/OqmV7P7eX76JTdmG
HZNRw88J6J6ut0ZJwRC6P7pmglKcKcl+8/AYSv/yV83N53f/2do33VEuSq8AdgTJ
FPsjG4zxyQtuk6lZqD8ajcG/OlmFQxr5qN8lJBxi548xd1nOX3o=
=XBmT
-----END PGP SIGNATURE-----

--0aTklQm5cubt8a9s--
