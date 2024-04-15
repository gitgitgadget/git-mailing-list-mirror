Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED8634E5
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181392; cv=none; b=hl5qxIuGjY7TM7cZVIAIaZEyIrmoDMsGj+RLTIx+YHpzo6aFCYrbTwDdiDsy/FK2noAPNU36sDTGOZaHpAQB7gNUg2aPu9bo96RYf5hFBfuez/PYN3r0Mo+XV47jTe/6oF/WqSxM4rvn6ODfw9aXgOPyVaXZbI9q+Gf9GY0tg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181392; c=relaxed/simple;
	bh=4s4E4YtT3cUUxNHCnbaTWi1XxqalGDtP7wQUi42tCag=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDCDND6FE6uPhlRBsuhpO6FI1DJGr8Zg0wPkh3zIbHTsx69F0+LvUzwHMQXQmKwVzW31JL1MhmqDwvlCC8G7y7XnMk2q4cFMaqsklLLrje0VQkQ4q93+zhOWqG9BnQD+HRCEyh7c23JnOWvpJIsieE/bF3Io1StAVbcwiTc299E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gYy8HQj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEbbTWpo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gYy8HQj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEbbTWpo"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8DA5E1380057
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:43:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Apr 2024 07:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713181390; x=1713267790; bh=x919HQzyRK
	Vr53cGu5j/qlKlFeMLMX7K8rbjLfAffd0=; b=gYy8HQj8AEUeWerFQcaSB9cxu+
	GDq0xJ+OoQVLy7atsaKuXYIyCMsUKWkNipCqeTn2mey8WO7tRMmbFbC1crx1jQHv
	oxAZBYshSGFWRuA/gza/ImzvOCbd0YJs+AGFLOEIvnNiq/fb9guhSLoNfTIW6eAD
	CtYuslxjAXv0eCMF9WC5CP7d98JT7xUT4Ui/ANhxVXUzzszevYG8x0P2rTvss3Du
	o8rWpAPw9ly8+jfeZvIaPOoVy+jNS7YGxC2y47fSnU5F5X1Hy0m9QVnY36wYUQMN
	Gi1yCx0zJwluizwYohc4ntJ6lTpnfnz+6A9fiePXW7lo903TRYUqfwm2FqWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713181390; x=1713267790; bh=x919HQzyRKVr53cGu5j/qlKlFeML
	MX7K8rbjLfAffd0=; b=UEbbTWpoc1wLb9hiV99g6S4f+RzoBec4i71+RvcRHZDZ
	U6uCYQoVr/XHvUMAczhCADSX4xr4liNkzM8EQxLCdM8bKAfReB/poNrpcgQ4iCS/
	4MDjtRwqyNZF2PkWKY7dfDmSyuSdLB0ITFPgkmra8Y4sHITw1/kflyfPweRzrKlV
	pJxRxztKVSXNt+d1HNgqIthr+ktjKHYkafRqnyiPBuAfsWx7HJcTDPaoq94KqKpw
	5/M7SPT28NYCs8JaLRjPOYQoPs6DGBecqc31h0KrmF8c9A2VSWQKe+fy195Zowzm
	75xyLZQohkY+FleFMl7B25KbucdTamUgJEwruVA1ug==
X-ME-Sender: <xms:zhIdZsIw7ywlVKaozwojzJOiYE_r3E16ZFp6dhYezKTCuQwl0RaQlg>
    <xme:zhIdZsIqdH4Ou8m0nIxgaBnLLgzN7kqkE6LZcRnOJtHgTtuq2i1UTDDpCvHd4eeJI
    gtbvsnJ9UpM2Zey4w>
X-ME-Received: <xmr:zhIdZsvYGNQzP1-bgVSXq7cT07Us0To9PEBWzxOtW38R_LmuDAMCpK4Nr3gU51GM5h28MnwAenTFeqPklmVb-p-1V7Or94BakdNeygnFETkN-PxbsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zhIdZpYcYsuRzt-RveQXDV6K-giM8QWeWlp-H7JT9Hx3rwUM6yphFA>
    <xmx:zhIdZja0AGnU6h37fi79fSIGj7teIKKPeaIcOXmA7mbhPN2-OGsjFw>
    <xmx:zhIdZlDb482a9bkQgVLfUOdaTdP8y6S_T2C_iVxrAT-A8zc7GmyyuQ>
    <xmx:zhIdZpbSa2HuAoGeiOUE-DmIsscgJ2KLbs7aY1GUrWRx2UHpVFxtWA>
    <xmx:zhIdZqzka45X7N0sL9JF8Bld90Yh3Cx1eNjB45d-vbQsYCn1Ogn9cHiH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Apr 2024 07:43:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cbfbd5e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Apr 2024 11:42:49 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:43:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/5] repository: drop global `the_index` variable
Message-ID: <80c36225bc9ae9a79710213e1fb30cdb2a924e8d.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wZrhqK2Hu7l2n2+"
Content-Disposition: inline
In-Reply-To: <cover.1713180749.git.ps@pks.im>


--5wZrhqK2Hu7l2n2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All users of `the_index` have been converted to use either a custom
`struct index_state *` or the index provided by `the_repository`. We can
thus drop the globally-accessible declaration of this variable.

This concludes the quest to make Git `the_index` free, which has started
with 4aab5b46f4 (Make read-cache.c "the_index" free., 2007-04-01).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 4 ++--
 repository.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/repository.c b/repository.c
index d64d15d952..cbaa6ef7ee 100644
--- a/repository.c
+++ b/repository.c
@@ -2,7 +2,7 @@
  * not really _using_ the compat macros, just make sure the_index
  * declaration matches the definition in this file.
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
@@ -23,7 +23,7 @@
 /* The main repository */
 static struct repository the_repo;
 struct repository *the_repository;
-struct index_state the_index;
+static struct index_state the_index;
=20
 static void initialize_repository(struct repository *repo,
 				  struct index_state *index)
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


--5wZrhqK2Hu7l2n2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdEsoACgkQVbJhu7ck
PpTuYA/+OYj2qgBy13QDigTvYb+4SelX0j/tjU5Yw3hKqVo2jomwiBUzKj3W0Dej
DpRWAudNv+GLcWiW+MqCzBMFf/SwdVMRBnHnFwhtUy30pBSNDK3tg28UUcnHuU6g
5Xo4Az05wL6GrWPRYL/c3Adan2E99+YfeVgieghCqNo31gwOG+NduoDjR9U0+6ha
w/KJU9B0kEWY6wSjf904/Q/UsL+oMfYzoZe7jrBza1sV2NfEXuZ+I0kQYBFOg28t
npQH1aCd8YGDe4cTuRQpNI1wnM8NdgyAfGPQt1iE1XFRAm7tD1NKEj2sAA08xAbF
Dqh/aHgIL2s7W/fO/60qUopgbJPNvSzzbMP/IEPaxwTOlDyCYTYMjlb1cNxZ6vXE
U/CDR3jW9Nt81udaEUrp5YA6J7D5RuWzNMJRvQzJEI3xl3XPGkmX4ASASRI97F/3
DSZVgRvme9aZfbw28ezX41LIlztui7PuB+UPJxwKxIQlD7Z0Ggg1QMAh9GUyf+LC
7xi45dmKqRkETGG/fgBFdhO0pGjCwN1cku1ZwRmvEbJBt9Fbnn9vG9cuuN8wKGtQ
97uc6uaIGM0uQ9Pf1jekXHUDPgMsbJ6bkHhilwsndIXcz3b7K6gHrj/LIGJLc7Ho
u7lsK8IElA7Ozps5HjFy6070vONLHSs0DBELLZMer//HGSrOtGU=
=IejR
-----END PGP SIGNATURE-----

--5wZrhqK2Hu7l2n2+--
