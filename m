Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA015FA60
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442475; cv=none; b=kBaE+5w+v6oPKGb8qC6agVveO2BF/YTPovH/lxio/LhtKHLMyQosG1Mz9dEHgzjvy0V7rEkiIWJD9GQQZQouFF1OFEK1hL6zvvONiRK7YUR2Evk3JYRTDxCRLB7EeP60ZkuXz1RTqEJdPPHwLqze1mF0va8Qaj8GxoOiQR7EXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442475; c=relaxed/simple;
	bh=xxeIpD0rlpVzV/vjz+gS4TdwoYjxwMcAqAU5Bbw2LFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiZY877l64DUgkW9r3pB1uJyMub3T7xGHOdrD+JXfFJ7OEIXe7rBK1+SEbdoWDua2yIcmYZLySHQz0uo/23GZZoYC4HZ7TRMIxJuN7rXVBZvGZe+eNsWuKma2b5LRO4vx4ZTo3D+1rKpkKfe6tPHFdx/AxT7rXamHIcUfSQk0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRsvu0TV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0XsogJs; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRsvu0TV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0XsogJs"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9EEF113800A6;
	Thu, 18 Apr 2024 08:14:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 08:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442472; x=1713528872; bh=grIKjSUlZO
	dlUiP5ZnP4y/vTO/ZLszftgvHhwmP3sxA=; b=YRsvu0TVaXNzHh4s2bdfJi7vCe
	J0/H+JdlhbWlawQorp7e+FLSNAObARBRM+ppj8QUYdZ6ifXJZ/Sy1Z6omLKEw79r
	X31EspJwjTaEXVYLT7rVVB82DqAPu0E9ILqgSju+HH1korywsU4Mqccs/199sYfc
	WkJfu1KV5MLPAAi5KCy7xo54DCCVg2/spQffh8yN3oLCzlY5+j7RLlNykRHEfrnw
	7bKKI+HZNTH9HTLf7NNJyj2tMi08WUYU/JxSQ/c3IfwH4s0hcEnPeoP2bRwooYpC
	IJwvONiEFLSgeuAekWRHdqA/0z/OvFArBG6+oj/ieSpDhh4ELA/8gRv+Z2aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442472; x=1713528872; bh=grIKjSUlZOdlUiP5ZnP4y/vTO/ZL
	szftgvHhwmP3sxA=; b=K0XsogJseQaLStj56GPYs/buOHG3GlZhrwkHOOlwkjx0
	fz4R0ORQku2Bo+rcc9JTuVWvts3J8j184Wu6AbYZNQ6oSjigSHNPuNmzWF0MvvjQ
	IseN3xXI5HUWanZOkv9jRAasEUNArIqrnC7cDIRWMZe7Gm3DNiv8WPw/tLbJtbwd
	qIpO1eI6b+sOf5i7Bgh/RX+mC8Ha23OjKir5yP6rs30/TE14/pwE5u3bDC5vmD8v
	gqWEhrZoLHOENeHWZDAIuPOUAUHix9B0rcXKVrM0u3TBmwyJOLQy5f3ETny+d152
	mrAv/8cwsQAmlC1135BOLrAA9hjrO5fPo9dd2Y62mQ==
X-ME-Sender: <xms:qA4hZr-60iu4oVEIlF-yzgbYFGl20H4jqsXiRNgIEU3d9-B5utFw-w>
    <xme:qA4hZns5iw4mhov8picYFv5vVG_xpqdKLnHAR2-v1ldm9eTj_rrz8AAnEa-_oXuuR
    EkcfLIXMTTE4Yo1EQ>
X-ME-Received: <xmr:qA4hZpBTsOVhVfxmmad_vdm82ZgBXSMMR9pblSzsb8jdxDDe5jH41mmGuc4aGHPuzWkCHzitW-etzWwj5ylZOX7gpIOd5IiOq6Z6Xj5jDJIpvOpdyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qA4hZndgymRLu-OQMVpZjHExzawP57Dc4J_sIvJDoePxSMgWOfzitw>
    <xmx:qA4hZgPBzRhO4guV9Z0_1_A_m28zLTdR5C3M4wZkgDSFNqv2xN_4Uw>
    <xmx:qA4hZpl8rnTARoUgF_kcMqaQdP2HKM7F5vX-GS1SbersTFdpEXkQXw>
    <xmx:qA4hZqsU5m819n0JD1H9vh4UZPd-TnwhOH8dYxSLo-QRxjCfH02s5A>
    <xmx:qA4hZtptJ9qJvcjMikJnEQTge1Gx2_gO-LNn0owVrF7TTWXqSVPjli1e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 10461d08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:14:06 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] repository: drop `the_index` variable
Message-ID: <549f8c048fb13a4b0b004c5dc72a39fb24a70c7f.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+VR+1LQ/FXg6RRO0"
Content-Disposition: inline
In-Reply-To: <cover.1713442061.git.ps@pks.im>


--+VR+1LQ/FXg6RRO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All users of `the_index` have been converted to use either a custom
`struct index_state *` or the index provided by `the_repository`. We can
thus drop the globally-accessible declaration of this variable. In fact,
we can go further than that and drop `the_index` completely now and have
it be allocated dynamically in `initialize_repository()` as all the
other data structures in it are.

This concludes the quest to make Git `the_index` free, which has started
with 4aab5b46f4 (Make read-cache.c "the_index" free., 2007-04-01).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 25 ++++++-------------------
 repository.h |  3 ---
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/repository.c b/repository.c
index d64d15d952..089edbffa2 100644
--- a/repository.c
+++ b/repository.c
@@ -1,8 +1,3 @@
-/*
- * not really _using_ the compat macros, just make sure the_index
- * declaration matches the definition in this file.
- */
-#define USE_THE_INDEX_VARIABLE
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
@@ -23,22 +18,20 @@
 /* The main repository */
 static struct repository the_repo;
 struct repository *the_repository;
-struct index_state the_index;
=20
-static void initialize_repository(struct repository *repo,
-				  struct index_state *index)
+static void initialize_repository(struct repository *repo)
 {
-	repo->index =3D index;
 	repo->objects =3D raw_object_store_new();
 	repo->remote_state =3D remote_state_new();
 	repo->parsed_objects =3D parsed_object_pool_new();
-	index_state_init(index, repo);
+	ALLOC_ARRAY(repo->index, 1);
+	index_state_init(repo->index, repo);
 }
=20
 void initialize_the_repository(void)
 {
 	the_repository =3D &the_repo;
-	initialize_repository(the_repository, &the_index);
+	initialize_repository(the_repository);
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
=20
@@ -191,12 +184,7 @@ int repo_init(struct repository *repo,
 	struct repository_format format =3D REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
=20
-	if (repo =3D=3D the_repository) {
-		initialize_repository(the_repository, &the_index);
-	} else {
-		ALLOC_ARRAY(repo->index, 1);
-		initialize_repository(repo, repo->index);
-	}
+	initialize_repository(repo);
=20
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -313,8 +301,7 @@ void repo_clear(struct repository *repo)
=20
 	if (repo->index) {
 		discard_index(repo->index);
-		if (repo->index !=3D &the_index)
-			FREE_AND_NULL(repo->index);
+		FREE_AND_NULL(repo->index);
 	}
=20
 	if (repo->promisor_remote_config) {
diff --git a/repository.h b/repository.h
index 268436779c..6f4af15417 100644
--- a/repository.h
+++ b/repository.h
@@ -187,9 +187,6 @@ struct repository {
 };
=20
 extern struct repository *the_repository;
-#ifdef USE_THE_INDEX_VARIABLE
-extern struct index_state the_index;
-#endif
=20
 /*
  * Define a custom repository layout. Any field can be NULL, which
--=20
2.44.GIT


--+VR+1LQ/FXg6RRO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDqQACgkQVbJhu7ck
PpSJ+w//RFBdZQNWMWtkpge6GpBP5vmu7ICyDQyifozMZMAMnb4ygjydinB6W2fF
QLrzrKgPEp1yzxBzRHoPL3N24SsTwVxTzJCgWkrPua2M1wFZ5j2VZUtb/UvcGR5O
BpSfAwt5+0TBICe38YpidtOunkaSv83AryuERMg0Rv5uVmOKQZNFO/F3lNzX9+N/
MgNc+gwIRGmrGVOZS01Rj4vWc1p8KMY2UV/aUka64ScUuajFqm/spBPGe8u7cDQS
sKKYthFWOrHgPmC3oEitjHiQSs3kuJvlgMZiBYZLjPd90mPEK6N+0sfGdZE0uQjD
vxtkG8KUU6lycHyhRdZ+oOt0tcAfEIheZ4i1ypOfORQm5qF2tiupL16YkW66zNxh
Lc8MDb6dilUXN904Bkm7mqYW1hDKWvQCpCX9T68f2WoVw9toHmDCaw81fOey/+FA
GPwubUtME6Fwia7ruATrfZeIj5tmcH6BVb8PRpgYg1uEG4VLjjzAmXEgpPossUS6
hfWf+r63bedoBHRs6D/ICPGcpkgUpus23u3hUmKTKuqJY7rzDAYLO9n0x1Sr//nq
11A+0NHq/2iRSGMBJY6QezZ9XdhDQvPrBuvAx7GGwFk/tH9EPMNb+Mm0SBOa//py
vrFI6rbJJQDFTqfLUSgxzjDiSMhghUOBs0Rug6/9Dqh8OgAHmfU=
=lQs2
-----END PGP SIGNATURE-----

--+VR+1LQ/FXg6RRO0--
