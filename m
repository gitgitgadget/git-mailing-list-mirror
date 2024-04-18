Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184715FA60
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442469; cv=none; b=R3Om9UxFnoIrqNYpwubr5+lG401jXfufJrMY/0g+7PdV1YLEo7moZNLYYBx5YrUxCT0h1UuMPo4dEEa62mP/WPQH6JaQtKgKV6/JA6rrAMzbMssiWyAJR3k1mLT1UpF5S/IYvEqFOerLlAdAbMUQRYcZKemYquIVfwmDr2y2lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442469; c=relaxed/simple;
	bh=5fQgINU2wUuwdZdQJ+3lejQaNFF61gqKU46BCP546p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmMnwGavu5JnixDV20tb3Mcf2h2GlwqRkeAnPkWmxyTQojpxS1n+YMrl9UitbXkS1mk46J6xp+aI4g4DmhSFHYGU803GsbEm+PliwfK1AiQJ5UmEcautECGEKTfBZw3bNqo2BXPsppCxJ/2dvHyA2m0lg+Nx8R5Mb4zsoFaBIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DtBPexT2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEw8TuaX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DtBPexT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEw8TuaX"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A81911400A6;
	Thu, 18 Apr 2024 08:14:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 08:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442467; x=1713528867; bh=I48mp/s12U
	RiKFS+bttBHuCS4BdlqJSjySvDqAIY0aA=; b=DtBPexT2Gde+XaPZFNURZuLaUY
	REpJj60N10HpNAPW/Gzmb7spOtPRNcTTDYSfdTKx5h609EG2klDng/y5ANmQAaIS
	avyjCPm6r4oMBoNwuamugfxh7VPPWBaGrsAIfUg51Ui8KzyzlEJtGE30Qh8oYDTq
	svqpjYY2tMwbHiBXdRuEPVwdREOqnf+7LRXJq2dRNbtsnscr5zHaPL3qGyh69IB7
	lge4IeXr9AGuM7pR9u/Gu0P7XXAAQdAhvmD4xnvG6X/XiV9RlKQGQYt9KQhIjOa3
	N+ExNLj0WL7P/p6rfawof2+N5wOftlTR2ro8ZzN8vjkMa0m9p6tHgR+n3GAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442467; x=1713528867; bh=I48mp/s12URiKFS+bttBHuCS4Bdl
	qJSjySvDqAIY0aA=; b=kEw8TuaX5Q9E7o+kgnw4wnb8bI5o/VpUqm2AoyD//Ltg
	IrHCCKW3vF5AQULyxLLpaq+o2jYYTYAca+GF0j82Mq5B8GCbz12qdtQNzpLw1CsE
	DJ1qD58OuBC+zfUEBqkNP7bHps6JNoyn/Z9a8HtA0aPv1AdCP+acwUTLji/SP1uW
	G5bc/wXJaHZ7kCDsMyZH/E/EUDGIitAv74KT5ZFmpsxNN4slRszbxUYvv3O3D3eo
	h2i/cBCKiyMlHpRnljGTCtG9XWTN/eEDiSba39R4KOjIHtDc/aksUPe+aO7C5/pX
	P1Rtk+ytUPGpEbSyphaLgUkcztJ30noiqnG0C1on/w==
X-ME-Sender: <xms:ow4hZu9nMUTPS4AyW74lihWKvKxUCenRRMXAQgkSHp59a00siYjGSA>
    <xme:ow4hZusWtMbg1DpF3TwKzku9NC58GaIiYFWdEv_ZExpzOi8KZHZsQO96OHxBrewe-
    Rca5OmNdw-06Hc71A>
X-ME-Received: <xmr:ow4hZkA8SUlx21M5sALMwUdTchODDBYcM_1CEMR8LoAaeNRf4bzg993CzSS1NUnVZqUE8RVs_NGfMoCe2KInB5VIr8tkssfWld5W_A-DqJaJ5u0X3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ow4hZmeTM1DEjWK7S2Jmi5VqjrL6RA8HBlmp2uXgTF4V_B3wpbgUAQ>
    <xmx:ow4hZjMRnO3-Dd5lBrguVXeYtJCqE2AAfdxGMPQ7S5qnrGhp_mLY-A>
    <xmx:ow4hZgnB0fjn66IekKOn-_Q_J3CE-IK6LyBKPweAEmKQN42Ff0kDoA>
    <xmx:ow4hZlvYppkaPvG3JoLawj75D_zutxzARLEj7euQmZ3c7mJLV5CogQ>
    <xmx:ow4hZor3-o3_BEXVOzTKV10qba-6gnccu0O3NWSAXaWNKTzT7xK0cqsY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6d64ea88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:14:01 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] builtin/clone: stop using `the_index`
Message-ID: <6fb14920181d9d53fe6db09378cb10f7377880f1.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hc+ZOP+YzD7lUV/Y"
Content-Disposition: inline
In-Reply-To: <cover.1713442061.git.ps@pks.im>


--hc+ZOP+YzD7lUV/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert git-clone(1) to use `the_repository->index` instead of
`the_index`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 74ec14542e..93fdfc945a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,6 @@
  * Clone a repository into a different directory that does not yet exist.
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -731,8 +730,8 @@ static int checkout(int submodule_progress, int filter_=
submodules)
 	opts.preserve_ignored =3D 0;
 	opts.fn =3D oneway_merge;
 	opts.verbose_update =3D (option_verbosity >=3D 0);
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	init_checkout_metadata(&opts.meta, head, &oid, NULL);
=20
 	tree =3D parse_tree_indirect(&oid);
@@ -746,7 +745,7 @@ static int checkout(int submodule_progress, int filter_=
submodules)
=20
 	free(head);
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	err |=3D run_hooks_l("post-checkout", oid_to_hex(null_oid()),
--=20
2.44.GIT


--hc+ZOP+YzD7lUV/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDp8ACgkQVbJhu7ck
PpR5Nw//SHcebR6T+/7Nfz1IlQzVE5PIECGSb+UI7e/SlSx7mCCY5QerXPDyGjBS
H6Lh4G74UR0dGIN1N5SygZSwyOYbsGnD5vSeNjbd4v37sbEj5o4TYvfvzyF7Akee
RgiMBWONmD7lzS43FPqrE6VjobZ8yJdvsHT9CFpTaawKNDzy1BI27aS02tekTZg6
0cGmPkktQWD9sMbuKCKbBIw5uvxKWNrCYRxZf2R3qZavp9hipt/EpbAU5127bM4v
qRes14ahU/jFCVbcbo4er1ggMi4fN9zHh/TGItd0LCd7sJ03pz8TCz73UN0v/Pc6
fqgQrhQEP5Kzmgdi7PkqK9YZvE/i5TutYMZCL+iI9VCW2Fcpx6hpF9GgiEsZ60mY
hu+z5Hxquek0dK3jKzHwha7xMl9f8RrxacqDm3ifhk6OAvrN/7NcIrjOo98m0Xj+
kICLgbjeiFUzvxZmXYT1npxEsyC5HftuiUzxnz28S8Va3PG6hIBvXgeNb/ZYC9Tw
61yjC/wHGGgz/7nGzO674sN1UCugOMpvHGKzSMuvfid84SFXnf+4bbDJcRbVUBRp
5HUkE+RZ4GgbWCkxn+aOGr/RqFVlCw4HF/vsrvaFBZAjA9nAgvxHdFEQHKs4fNgq
qqn8ewoVWunlYvnnI5HgLcbd6Y+pSRvO5g7CPjom1AHPfY/bcgU=
=b9Pq
-----END PGP SIGNATURE-----

--hc+ZOP+YzD7lUV/Y--
