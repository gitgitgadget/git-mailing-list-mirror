Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384041BE25A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934830; cv=none; b=YO0uPPN1nqlHSzQhkmy4u7XJv7fkCpx0uFpcIg2jp3fVxdnsXCL9zDwq2svgoswBD7+8Z+DkEC8JFEbMMKhr4497yMACkGMgYa+EjdK78JZS+dzaqPDPSZ1m+EPACQlAV45KJzPSkfcqawjop6+KQHbY+FMnxG1BqIcV/gFajzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934830; c=relaxed/simple;
	bh=SFw2Lg+tF31XpzMyYmsibU+95n9RSrl9WfPeKUj/yXo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhVVSSH21y7CDxW72b83SwYpDuwEPaSQqBW2Kpf7X/b0nyrK5WdIL7E/9zDh8t/hmtzNObguWLwlZPOHKn8pp1cspIYGApq0a799bJojhrTcgSZ0bZIIi/oSt16wQvYOr+Uzw9ca7fav/xCXy058AgKDEWurBnrhSYDBR/j+eEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N+M9n8A/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOrk/ika; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N+M9n8A/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOrk/ika"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F9CA138FCEC
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 05:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934828; x=1723021228; bh=/IZQyuUT8t
	wv1esv5tr0ZkVdZGUo4d6U/9KU/lUaEAU=; b=N+M9n8A/TiYrGA2S18JwBP7LvX
	DG9sVm4WasQnf0ZmqD1Fp+/O9dk0JltpVtAkMZz81feIRNii+OA2IDaieE5bLYiT
	BZXr11q+ZkghbaHg3ElV8yq+qwo/oypZ5LmBGsq4iOuadTKOgLirPj9NDfSKBBjO
	C2YM4YLsWzggVFlW0UKFMTmYo8NgUrKch9agVCZqG9AhyCydpFpxZb3+zUlkpAu3
	CgDodwOG3Vom7n41w6fka+cwjj4UavG/3yYj6dACwunndZc9sbNgZVezjvGRfR92
	8lChoz01nVai6e5TM6WgthgeVDeB4yj1K9VvbCXiJm2u4739+/3/2yyLaspA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934828; x=1723021228; bh=/IZQyuUT8twv1esv5tr0ZkVdZGUo
	4d6U/9KU/lUaEAU=; b=SOrk/ikajdR/v8J736rYcnHhAb8yp089VlWJ9yX2aHVw
	0GWqwNMReBUsXQPxprA+3u8Ym/xjgbz5Xl4s39OuXdwrmcUMx/nRdmHH9fOlWNeI
	LpLgdZ+SqKMQyJ1etR/MFME5eZ7LIXu7xByVeyvYlMcSRO7cEIgEJap3lYm78qze
	fxPy/mMyUly5eiF8nWLDOWu9cn55K7Q+NvPouarlghiQwMGnjK88xvYhEkc7qAF8
	wJeexEivXkH6b7Mtp+kcDCStM6rlcuJ6XTPq5E0KlK4wvqdgj82bf6hI4o4pbILx
	HiRvS7Sk5VE1MlUnHZiVje9Gh8qNUe/w3nshRy1bGQ==
X-ME-Sender: <xms:LOaxZmL0pSsM4l88mTQEOFYn0RBqhZ-v5H30OpU00SHWbR1POUtTag>
    <xme:LOaxZuI1hz1TCltffiHeLEgbb_gYgt1vXQzDWTcqNC3x2nfOqnuo09RlkyAlW5bTO
    P5duBvZKV8GVwggdA>
X-ME-Received: <xmr:LOaxZmtVs0whbGOYK6CWYnhvFr1eJdPQLmwKjtOdvBWAAzPz2xQHetEXbAmSV9B1XwAjGK2st1vkPDcZA_jUsxoSYcZHu_ph2IrFCVkk6iuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:LOaxZrbsoJSCwR5J-pt0uUDGqHEIPY9O9EsFmR4I92OMEdulnkpDKg>
    <xmx:LOaxZtYRPCVMlXL3lBIL-NKD0bbWF3cm6Cv6-20AQr2EG6_TLdXZUQ>
    <xmx:LOaxZnB4yFiXsjEgFjHXZB7uQWPLB39xMXTARdqN-BjhWY3skrP0BQ>
    <xmx:LOaxZjZ5bYOuVTJjTtmIMZWk3huiwzWDDdt_TVM88dsJDpwqptrkbg>
    <xmx:LOaxZsyYaHdQY4b9ACYu_QD461vCddsf-Q7cgH7GMpH28f8P1EGrNHWA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f97f2203 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:25 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/22] builtin/fast-import: plug trivial memory leaks
Message-ID: <798b911f775a8d565f5c05605e257071d9f8a00a.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9xtAzirbVR9kRm+q"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--9xtAzirbVR9kRm+q
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
2.46.0.dirty


--9xtAzirbVR9kRm+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5igACgkQVbJhu7ck
PpRwpA//XfcS7rxdp65dS5snRheC9UhDKUayRoFUybtpExE01l95ukgH3h79OslL
MplrmJ+EjunWlHvWzXP0x1H4CjFxrd02GkUqNwVx2M+kgujVRaPZ+EKB4bZo8teX
7SlhZz9Vm5nmBsCPTsG+hZus9PqUE80r3UtxBukWr9H2ltciFwt6sFEcyIlKSgHL
6umTG4ecmMDTjjCEat1cHwT+pVhjayNZqmTgRCCt6LjA+OxOm6RdWDGqrnF9t/bc
pyN8t/ra+ftidTpkVsEid+vK0hTFJRz18DqcVVseRlYk5Ef2lywKRxeHcHY1veZ6
ainxKsl6PX9MKJAeRe8KDzSMaiwsVKcTPfiL2MBd1oufJtqR/X+vbXOPfvRGI2cz
EDA1oBFKDIZp3NCP3nCu6uflHv5ajKLjGM29aSkZmZPvWL+vf3LZw3K+4SAfIgCq
sVTMggmBxgnJ82FEUNn+7MWlaGsz4e95oO5npWihhaGIJE0BtUWZYs38PC2OMS3z
uxdH/AALDQ73PwvYaEphFK0IBn3bpz7D4uN261kv3wVxufPWQ4FS8buNwfqTogI8
QX9GkBFeGuMUU/33C9QnETL4blwbfhrQGicttt3obFBt0A3KtngfzwH92N88qGju
BxIVH75Gg/6ogOAZZzmZO+v9dIl/LRM/WAP50Q1SGDSi+P/zrqo=
=Np7/
-----END PGP SIGNATURE-----

--9xtAzirbVR9kRm+q--
