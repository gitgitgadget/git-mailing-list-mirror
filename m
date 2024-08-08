Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA618CBF3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122326; cv=none; b=CCCgPFQKakkcxDeFb84cJHPWYiGvt7C+xbETeqm+wXQtC6+65/vBVwPP5XO9feZI47Y/zkeJG6EikCFWZHhXtlaz3aMnYLeMD42jdIk15z+DQSu1/YFxoKISOe/yC4AJFn7ZJr+XaLaE98zuarc1/TD18SwFOEWh2C1rdi242ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122326; c=relaxed/simple;
	bh=xcIZBYzHtkb5xO9oiQTWKci5z+vcwhMIzGuQxjjcjCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYQU944U9HMzrDHYVfkSDtj8Mrs//MHxrLMcv/9+4TA1Ym6KRMZi7JInnOt/2qiyUYkeDiiH1Tj1LJZkDDpGvoLWF5wRxaVBoTXEov/9gHw3TDx+Jz4vJkyi6juEMdPqq89oYYX09f1eYO7zB/sMMJjQ03eU0rm+zJD+vMzc/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q2+xOGIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuO5RP9q; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q2+xOGIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuO5RP9q"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71D7F1151ABE;
	Thu,  8 Aug 2024 09:05:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122324; x=1723208724; bh=xV2qufCYHt
	qM0Ny/e0o9FDvYdFCfpMhCbMGttLDJk48=; b=Q2+xOGInX/RmoXwjXQ6MFG55ro
	fRAkYL2K7aHOAlWr2haM6GoR2cAe7GO5QGLh6kteewXfBoWrsivVr7XPE60niiiw
	x2f1R9AWwQPQfjGHgiGyOow5DcZIMU6vgz7voCR7ridltkyBqnTkSaJVegYFojEn
	N8H54claWx37QBRhX6gzFvuqmXuOLmPj/xw5nAqFvTQg3acr4egU+86KQCgyL2VK
	KOq1BvvwKpKkBEExZbYHpM2SJ/9Gd1fjXEXb9/tjrY1JZYqlP2HoZWFAVukMsJ6+
	vMRP7Ck7AXeifb2LEe5ek57sKrdUPZMF+2y9UdGi75Kw7UMB7bscHGJaTt+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122324; x=1723208724; bh=xV2qufCYHtqM0Ny/e0o9FDvYdFCf
	pMhCbMGttLDJk48=; b=CuO5RP9qQBQnbfxTTR3MTJRgJedqi8y5TavJ/WwjwtsL
	GndH8JDaG/WM+InJi57dYSrC0HxsltsZAifpAB7d3M/x1/R34WA/4MWwNLV/f8u5
	Y2qTeslYdGTpqqwOBz7Gd0EkZibtqxYeN9B8IPQ007OSfoSU9cflZxm/gLv6XPiG
	Zh3P/RmCZc95GmlA82ivbLFvOO+lq0SyY0FbczBCvkpLq6zG6RA1oypxL4eWouxa
	cBuQRNO8K1rNBZIlkK3X7wC8OkVckgF2XsNNHomspuGFshQFOf575K54uq+WnUhw
	5vu/RrfnSfWSnXiC7tGvg2zI+f+OOmEwIv82N3nTxw==
X-ME-Sender: <xms:lMK0ZkxIJmnxZ3c2hi_EhfRuD_OBDYYcK8Lx2eG0nAW506J1R7XtWQ>
    <xme:lMK0ZoQsRwA10OqQ5oOqEUQbgD2mTpB52fC0MdjKndDU8RrWyjqXKY8UkiahB_BV6
    8UzwI_BPW21G-oyvw>
X-ME-Received: <xmr:lMK0ZmXkXIlOX1mmRtR_DlN8JEZYJ2QFyehj_anal57NmhmLg7N7t8LP3bb5ym_T1QjGHnfSeSAmLmSX_wAZ5vGwNDkwjHGXui5h1yYg5I5c8yox>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:lMK0Zihpv1mCS6u9ufPGfOhFrJ3mC-UypUJsOvrO7YnZuN32zGkjeg>
    <xmx:lMK0ZmB6HQyCsi2i9GOluMms-r422p0kWCdt90GZ-MXgGZCWhs0znw>
    <xmx:lMK0ZjL35TUm8kZ1PjM9_CPMyT1GiPMVmLHJbWqzuDTOZsx2ucX7tQ>
    <xmx:lMK0ZtC9tj_Fy1mQBBtFlafW0a9D0BphnfyRWeOPuZlvA3-8JSy2AA>
    <xmx:lMK0ZhNRD3UrzgqfAA1zswjz0WtKw3aeCGMsHPc4B240uqnwhySc_RTC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c5e9b5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:16 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 11/22] builtin/fast-import: plug trivial memory leaks
Message-ID: <d1c757157bae695ccbab5d41523c341d0aa8b9e5.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hX/0Sk6L0l7Zj+iB"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--hX/0Sk6L0l7Zj+iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Plug some trivial memory leaks in git-fast-import(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c        | 8 ++++++--
 t/t9300-fast-import.sh       | 1 +
 t/t9304-fast-import-marks.sh | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d21c4053a7..6dfeb01665 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -206,8 +206,8 @@ static unsigned int object_entry_alloc =3D 5000;
 static struct object_entry_pool *blocks;
 static struct hashmap object_table;
 static struct mark_set *marks;
-static const char *export_marks_file;
-static const char *import_marks_file;
+static char *export_marks_file;
+static char *import_marks_file;
 static int import_marks_file_from_stream;
 static int import_marks_file_ignore_missing;
 static int import_marks_file_done;
@@ -3274,6 +3274,7 @@ static void option_import_marks(const char *marks,
 			read_marks();
 	}
=20
+	free(import_marks_file);
 	import_marks_file =3D make_fast_import_path(marks);
 	import_marks_file_from_stream =3D from_stream;
 	import_marks_file_ignore_missing =3D ignore_missing;
@@ -3316,6 +3317,7 @@ static void option_active_branches(const char *branch=
es)
=20
 static void option_export_marks(const char *marks)
 {
+	free(export_marks_file);
 	export_marks_file =3D make_fast_import_path(marks);
 }
=20
@@ -3357,6 +3359,8 @@ static void option_rewrite_submodules(const char *arg=
, struct string_list *list)
 	free(f);
=20
 	string_list_insert(list, s)->util =3D ms;
+
+	free(s);
 }
=20
 static int parse_one_option(const char *option)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1e68426852..3b3c371740 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,7 @@ test_description=3D'test git fast-import utility'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
=20
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 410a871c52..1f776a80f3 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test exotic situations with marks'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup dump of basic history' '
--=20
2.46.0.46.g406f326d27.dirty


--hX/0Sk6L0l7Zj+iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wpAACgkQVbJhu7ck
PpSs6Q//YuHiVnHYsIw0stHXgv26mLHs07SQ/4wBcArmeIt49Y5trgtQLSSGjOmj
sWDbPKJkW9tBdYjyoMRN6v3jBqEbKAGYye9/qICeeqHLenjdNdiGj3a1LZGmB4rz
7ssKsBItbEdaTTqYFDEv/LgLntxAb2OgnV472/N5A0GdvQcsUjy+b8y7JaZmyVjn
L4AXoAMsaBGsG8smHm7IEEFA/Xsb5/cwGsQRxwPaEve07QIXnaXrwsHnIPnh9j7Q
i5lrM3SpHC9D8PkBYjfDii9bB1OiPTQyLd9u2WLcRhhWYeY7HnwojnLJvP4v5M3p
cfauN8wC0F04w1h9grXd+KjtdIJxWt1K7OErL57+xc7xwSpPb8A9cfw8shA4srVm
qs9Gyck8j1e1N/9fCje1+SVa1fGkU1Vy4qo9s68HzL6IIOzdh/zRhZ/AxnPekLPp
pHWKuO/GRjNgwZYT0aeBUz11Fumoyt47C1jCs4J5bqlRYhj0eBhBagTlZWTCmSJL
XbpG312m7Ab+Gp6QSVEEnBeJ0VVek7lf0N/V+tj16Ouu4DBuQDfWTmp+be/fGPUh
AwiXnS1DzYwHgxFScHerLbexXp4xk7qcLKOusW9b8gwJ0TFQdyLmbSST1tP8CfYG
MoV2wKEZSmo4yvMsLSSlVYbxv/PBkJuRTVu/W2yeDojFby2N08k=
=v5jE
-----END PGP SIGNATURE-----

--hX/0Sk6L0l7Zj+iB--
