Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78618FDC4
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316982; cv=none; b=Qil0HuE6+glfrNt1RuD+oHyTMS4RMtNFpGnJIABY674u0sH7vbUIgmzejxmZQyagBbYeQzky9J/FBU338Xvj3h9xNmvTQquzVxUv8sS+rI8juTQjntbMOl6IPO1N8zvoma5pqo+Bjpl963BqBDxW1PCeTDQWBg8AUwaT6hUJvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316982; c=relaxed/simple;
	bh=ISKkhNJEpWJvz44vAzpWgh5jroYDf/d7pjP+4Rgicn8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIpaReBtqSN7pts1OySHowd4+QYSBiUGVRvGOKJKGctz9OFac0HcgiJC7RjVWhjpW0Gmgu8Mwhejgon2v8ZhV2wHKypnaGe4K3ZM3gwLsDM3gcw+GCLBxjJWhdFVzkN+0/117JU4AjI2EenxiVNQ5dCx0Z0SSpWoNQ3XTelDEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RfA0GK67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWSpt2WE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RfA0GK67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWSpt2WE"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7CDC513807A6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 01:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316979; x=1722403379; bh=rxU7dGD8Nb
	HSi2iUzxHR8zSRnBmmaFz5FL8UpWYPWE8=; b=RfA0GK67bnsoOjf/FPb/245jTj
	emTAIWgDUcrM2kbbnWITLYWEQaq73/f0v5lEoJ+pFalpSG6hu1GMB1kUhC/DqGvX
	VuRaGy499jkWZEE4HJEHZaurnor3I2v1FHKZNljtGy97DskU+5JOZ5tXH4fZwbnd
	M2ONY9DSvtDbi0iXDDtrGgooxx4SQbcA12OjjvSa5XV/g2awIf9CMDWbM625YOO0
	Ws2tsPusTtqxyYR8/D/Zlp6mNUE+w7QluodjGVwzSpWYXjls+kRrT0a9fHjIKf8f
	Hxi2I1EvNojqpzUb3UFiep4BQ0qSHRynZy80EhBPe7rtY1nx4TY0+dnGg/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316979; x=1722403379; bh=rxU7dGD8NbHSi2iUzxHR8zSRnBmm
	aFz5FL8UpWYPWE8=; b=AWSpt2WEB8GhrR8iV1cW8cI90OFLMhuD3npJ8EHg7qrI
	fsJulH8epDRdq19RnLBb5hL9CG/8ecZc9mE7QbQrtSr4Gf/UpTv77vuhmGP1yI5V
	ATXicMlWXniS0jxobjZS2DL0rPxmfqJv3mjuW/76p6sp0i8LCZFEJ0pFxCWtiGF+
	DM116mfaBAuh6AjwwrHXG3O7GbSiwfVVO99dytEEJT5Rf+HfBC8MTx+OvglBMnGe
	J4D/hM1Ue1q1uGDaa8fipqLpq3McJbYrEwPZL/sL5CKn/vriMGoElhk+O5sMb/2p
	8M4Ji5tlaJyD8jqvEvPYe+Hb8aWQev3oxMSESicukg==
X-ME-Sender: <xms:s3ioZp6JBc4HEgUfc2EPC-8rAW-OyHc8huykFBeQT7B3jlGwFUjBFQ>
    <xme:s3ioZm6onduZWKuirtHrd3327l60DC02kB6dacpRdnm0bE-1kvmpcKidtmVgitpFp
    fNK661F4AJhFsaLGw>
X-ME-Received: <xmr:s3ioZgfjO8hgg3kXO_Uk9j58nJWsSWly5WC7SIFTvV4QzjObiMUnF0f3S834maVg5LGFQtqmjJVLx8bMwRUYMK-wzTAHK5wgGej06gpsfAKZ4lk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:s3ioZiJgz7AAWzG2GtU2QnHs7oSJnshrhsTQF9oyoPLXhakp995DWw>
    <xmx:s3ioZtI-RvA1rw0zdwvD6IkABx-u4QPf07N8mIJMEXGs8bNg13NiLg>
    <xmx:s3ioZrwH2PAV__jB9xtCC9uKjjNs8m4pdfNRtMFXPsI8i13CvxXh-w>
    <xmx:s3ioZpLE2z6Ngrjv0MXiqN-91GSM13MhiJo7voJMQvEdQbW1vpGBnQ>
    <xmx:s3ioZriNsbU43OVvox6lC4wsCqHK_fDWDpz7N_ouKO6me1D8H3mWSBHK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:22:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c30e09dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:31 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:22:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/5] refs/files: stop using `the_repository`
Message-ID: <cd51e9694d20e70b4c95a7ab8aee65e43c69cbe1.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PTgphtm6NcirQTak"
Content-Disposition: inline
In-Reply-To: <cover.1722316795.git.ps@pks.im>


--PTgphtm6NcirQTak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert the files ref backend to stop using `the_repository` in favor of
the repo that gets passed in via `struct ref_store`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3437c79699..c73f95ecf2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "../git-compat-util.h"
 #include "../copy.h"
 #include "../environment.h"
@@ -248,7 +246,7 @@ static void loose_fill_ref_dir_regular_file(struct file=
s_ref_store *refs,
=20
 	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
 				     &oid, &flag)) {
-		oidclr(&oid, the_repository->hash_algo);
+		oidclr(&oid, refs->base.repo->hash_algo);
 		flag |=3D REF_ISBROKEN;
 	} else if (is_null_oid(&oid)) {
 		/*
@@ -265,7 +263,7 @@ static void loose_fill_ref_dir_regular_file(struct file=
s_ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(refname))
 			die("loose refname is dangerous: %s", refname);
-		oidclr(&oid, the_repository->hash_algo);
+		oidclr(&oid, refs->base.repo->hash_algo);
 		flag |=3D REF_BAD_NAME | REF_ISBROKEN;
 	}
 	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
@@ -1154,7 +1152,7 @@ static struct ref_lock *lock_ref_oid_basic(struct fil=
es_ref_store *refs,
=20
 	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
 				     &lock->old_oid, NULL))
-		oidclr(&lock->old_oid, the_repository->hash_algo);
+		oidclr(&lock->old_oid, refs->base.repo->hash_algo);
 	goto out;
=20
  error_return:
--=20
2.46.0.rc1.dirty


--PTgphtm6NcirQTak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeK8ACgkQVbJhu7ck
PpQefhAAqOVjbZ0KgmHjt1uFfdGxDxN18ezHVjyi4jFghxeUclXeJVQaMeseVUUO
z3ZD++lk6ig2/XHifcBI4T24tx/ICYg/U04vYR7l8kYazxbzWDeGwiur+5sIAKKW
Fc/ePKZfDZP9oS67x4gkq0TkQJ5xYhgyFIUfSy4/do7ZCrn+ooZNs8NBWgrxt0k4
07PdsrDfA4n3pV/TanZB/OPnR6PtbrqgZ626sYcTzUQTsesMMeRUoNorAoOl7eIv
9OVoGidW9giVhH+uolVNGxcQkO7wEgHmOW8NMpI19u7VN8nU+xmD2WWWnhp2uKz1
sHpuJ5VSlWTSY6Ac7cFCsQrmyHgRuSVHwEvj8vO/YsOWM34mPaFwp4alJ5Ma2xzA
Rm9RXFUy85JbTBywEwkfdWwtJiicHhhXkiuRz3lDBGAYLbCTb0vNXx1c/BD2dKTT
qu/Li+xYwaoay/h7/dQAoqPShLJKV9B7Ol9MBvcrgMCPZjPYXxLtzTuNV1p74dYX
ejOMC1gQR6AP9VnTd13Z0jEUgH3MDPLUVc+tl3lQaiYZajvKv/7r9AE2UqbOiMCI
NqqtQ6slgajlOwimG/mqeqfmH1eeOPPD84+jinlIWXu9tPE7rEpSYR9/pCroY+Il
qDBAfQrpfHr5olCPL2bYhToynZ43d4MEGw3pnVu3/bPd58Vixjo=
=xHdj
-----END PGP SIGNATURE-----

--PTgphtm6NcirQTak--
