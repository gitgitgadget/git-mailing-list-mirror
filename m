Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604DE18C333
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122365; cv=none; b=DBM6oDO9/gaNrSdvCWJPp4z3fcOiwdslbF+BHPs2AhzmHh5naEtO14lWGxIzzXu2Tg/pU+riB5Yd+bPTQuV+JDIE/gjWSfoeOLvto7qUYo2aRNcPagwXsqFQYYPznyV8CQ99YppIA1xx8JoIb2nFf+xYqBsLq+xn0Y4Q8aDvcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122365; c=relaxed/simple;
	bh=GO9yTjtwcrgkCGyc+0gix6+c3rFc0bEUWH9wMwPE3q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiInXAedXM6iVzj6zVaEyCebx/90glmSVa8zqzrxCj6Hp0rcksPNZ5Fsx7m6hNxUgkvo4h4VGTnjt57aARDYA3b3gTpOU2c+Y6CDiMIQZaxGkViLWdfn767m4+hLqD6QRQMquwjNFUO2WsS7FnHoPAxyv3eOfX0GwH6YpBOroJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5D3M1Wt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CG5trl+0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5D3M1Wt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CG5trl+0"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B1EB3138FC80;
	Thu,  8 Aug 2024 09:06:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122362; x=1723208762; bh=Jfc+x53P5+
	QhSACYg7gBpdGLgiyobdi/f5x1BSdY63I=; b=N5D3M1WtYaGkMUm874unNnOmdj
	OP2UwNl/2y93hXa8iYzsGp7jincnoJk3hEFLRfvplwUfdXzW31izIHhJOb0wSo/H
	4Dl+cYdrLtrYKBkeb7h4SlIsKoLWh7eHLvjOZ36uZuXaZ6uiQ2K/7q9gRpPQMYYz
	pTVHxGEaDoY4yi3Ay0rBZUpgPWCIiK1jEzYE7p0AxXVD3wc4Ve8lhz5PMIwDh4g/
	ZZzYO5n4Rlv1d9PmgWHx2/Gqo0jwgKK/vqRaSyRgaLGeExAZDzIcYP2ruiICQ4Ns
	DnsYZVPjknuJRuixBuo47+eh4X1YIfA40lUVFhFyj0ng3iniCAiNJa970yUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122362; x=1723208762; bh=Jfc+x53P5+QhSACYg7gBpdGLgiyo
	bdi/f5x1BSdY63I=; b=CG5trl+0LE8uZiy+8hdpalljzozFPWVLsuwq/XL7pm13
	NUQfAQuHlsEkw8gMctvzSVSlzeymD8UkSOVpvqXnXaNnphL5850kDK23ybmvksqy
	QsUQnXoj1X49F+6NQ74i86qWNwpuXUBsNpzuPHO/Y0bO5PBNdoASxSgCE2hmq/IP
	nMzrq3gsvJ5OXHEkKmEc20bWZDNA0s7PXyDszxKYA6HV+c1JNxJr4uF7HV+uA8Xs
	xfMK1K4Evjrhg+17nqKFAliUk1yEhqvbiEHXfwzqoduk4TzCoqSBO3SvhrVyeWqR
	6utZ/kSrFcgroC2V/iZKJ38WfkQMOxOIoIlVTbwQQQ==
X-ME-Sender: <xms:usK0ZnmES5LKkn9xCBDfzEvbEMQAcvztjMvSihxQdNm0ULOl3RwmBg>
    <xme:usK0Zq05rngltEn1xRTWdr5j3M2fgwPHwU0AXXDsSUkaWtvjs2xf0Im0Uhu4_ejtr
    DUBwBOypYthJI5_8g>
X-ME-Received: <xmr:usK0ZtpU3BL-2bSAa0uLVf79wtULXJVIV6QTrcpO3jdLlQ6Iy-5ekvLtmvngIPOwU-Ct-WQ0jY5OPng4qUHa6doCApbNwWUJ0taaFtBG289B25G6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedutdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:usK0Zvlo54VYD0qgWsINf_x3O-tPLqiUbnb2GCWKLl6N5oBQnZZqVw>
    <xmx:usK0Zl0sp9vXg3IYUs3bgXR8tUn28SISoTgGes_g9aq4jKzNb4FeBg>
    <xmx:usK0ZusNrMSsqxaPwWqMTvjhqr7Z7KdvmsUGtI6gOOC8FP4WxGYqqA>
    <xmx:usK0ZpWgBGPQLT_3o-xZbh2eZeQdGSy74arfQjmjDZ7iLAK9ftWAaw>
    <xmx:usK0ZuwlchTmK152FZQ_JX_-Vl2DYnSZq-lxbiQ4T6z8Od2JepcWlQjZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:06:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8775d4c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:54 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 19/22] userdiff: fix leaking memory for configured diff
 drivers
Message-ID: <be2c5b0bcaa8c327c11f49b0dbfcb441bfa1fe66.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iEVNn0LNj9VRH8/p"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--iEVNn0LNj9VRH8/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The userdiff structures may be initialized either statically on the
stack or dynamically via configuration keys. In the latter case we end
up leaking memory because we didn't have any infrastructure to discern
those strings which have been allocated statically and those which have
been allocated dynamically.

Refactor the code such that we have two pointers for each of these
strings: one that holds the value as accessed by other subsystems, and
one that points to the same string in case it has been allocated. Like
this, we can safely free the second pointer and thus plug those memory
leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 range-diff.c                     |  6 +++--
 t/t4018-diff-funcname.sh         |  1 +
 t/t4042-diff-textconv-caching.sh |  2 ++
 t/t4048-diff-combined-binary.sh  |  1 +
 t/t4209-log-pickaxe.sh           |  2 ++
 userdiff.c                       | 38 ++++++++++++++++++++++++--------
 userdiff.h                       |  4 ++++
 7 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 5f01605550..bbb0952264 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -450,8 +450,10 @@ static void output_pair_header(struct diff_options *di=
ffopt,
 }
=20
 static struct userdiff_driver section_headers =3D {
-	.funcname =3D { "^ ## (.*) ##$\n"
-		      "^.?@@ (.*)$", REG_EXTENDED }
+	.funcname =3D {
+		.pattern =3D "^ ## (.*) ##$\n^.?@@ (.*)$",
+		.cflags =3D REG_EXTENDED,
+	},
 };
=20
 static struct diff_filespec *get_filespec(const char *name, const char *p)
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..8128c30e7f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test custom diff function name patterns'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-cachi=
ng.sh
index 8ebfa3c1be..a179205394 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test textconv caching'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 cat >helper <<'EOF'
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary=
=2Esh
index 0260cf64f5..f399484bce 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -4,6 +4,7 @@ test_description=3D'combined and merge diff handle binary f=
iles and textconv'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup binary merge conflict' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 64e1623733..b42fdc54fc 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'log --grep/--author/--regexp-ignore-case/-S/-G'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_log () {
diff --git a/userdiff.c b/userdiff.c
index c4ebb9ff73..989629149f 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -399,8 +399,11 @@ static struct userdiff_driver *userdiff_find_by_namele=
n(const char *name, size_t
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
-	if (git_config_string((char **) &f->pattern, k, v) < 0)
+	f->pattern =3D NULL;
+	FREE_AND_NULL(f->pattern_owned);
+	if (git_config_string(&f->pattern_owned, k, v) < 0)
 		return -1;
+	f->pattern =3D f->pattern_owned;
 	f->cflags =3D cflags;
 	return 0;
 }
@@ -444,20 +447,37 @@ int userdiff_config(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
-	if (!strcmp(type, "command"))
-		return git_config_string((char **) &drv->external.cmd, k, v);
+	if (!strcmp(type, "command")) {
+		FREE_AND_NULL(drv->external.cmd);
+		return git_config_string(&drv->external.cmd, k, v);
+	}
 	if (!strcmp(type, "trustexitcode")) {
 		drv->external.trust_exit_code =3D git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(type, "textconv"))
-		return git_config_string((char **) &drv->textconv, k, v);
+	if (!strcmp(type, "textconv")) {
+		int ret;
+		FREE_AND_NULL(drv->textconv_owned);
+		ret =3D git_config_string(&drv->textconv_owned, k, v);
+		drv->textconv =3D drv->textconv_owned;
+		return ret;
+	}
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
-	if (!strcmp(type, "wordregex"))
-		return git_config_string((char **) &drv->word_regex, k, v);
-	if (!strcmp(type, "algorithm"))
-		return git_config_string((char **) &drv->algorithm, k, v);
+	if (!strcmp(type, "wordregex")) {
+		int ret;
+		FREE_AND_NULL(drv->word_regex_owned);
+		ret =3D git_config_string(&drv->word_regex_owned, k, v);
+		drv->word_regex =3D drv->word_regex_owned;
+		return ret;
+	}
+	if (!strcmp(type, "algorithm")) {
+		int ret;
+		FREE_AND_NULL(drv->algorithm_owned);
+		ret =3D git_config_string(&drv->algorithm_owned, k, v);
+		drv->algorithm =3D drv->algorithm_owned;
+		return ret;
+	}
=20
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 7565930337..827361b0bc 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -8,6 +8,7 @@ struct repository;
=20
 struct userdiff_funcname {
 	const char *pattern;
+	char *pattern_owned;
 	int cflags;
 };
=20
@@ -20,11 +21,14 @@ struct userdiff_driver {
 	const char *name;
 	struct external_diff external;
 	const char *algorithm;
+	char *algorithm_owned;
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
+	char *word_regex_owned;
 	const char *word_regex_multi_byte;
 	const char *textconv;
+	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
--=20
2.46.0.46.g406f326d27.dirty


--iEVNn0LNj9VRH8/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wrYACgkQVbJhu7ck
PpR1shAAn3N9AjxEN/FcODELpdrDXU6YQUrZM5ZvonBui+UyV23Gld6EN0jfdQJv
eerBaww/NYYe0nxILxCh9cCB0geH2psifS/l/uYDHjKH0PWbBnylIWNnij3R8+wL
VsJ9o9DCkIonFAlE4gd0TgMCdedOSl2/DnO03vVTGfFScYrevNEXvOmQOUgbtjhK
KX+h2q2YIRPsSsnnLunbvegMaRkA0E/ufxCrkT653TQvyRXNPguT6pxoERSCjANH
uk4DvnWchxij3h4C4EbXmaYdxceq2SuzqkL/JNiy1H9agKWaYv2DR7zgCSndKS54
Ei2gHEt4lHUQplko2b7EdqqCVChRjxnuB6dOGJdm1ibJ3M06PsIvMOY2hUnk5rkQ
Li6dmlqZS2T/1DvNNxKjfzLxGdWvw3Ty0Yo4rt4xQEVOk8jtgExLxnAajtb3X1Ei
FiUW+3CUsehmF6ateHAzikHCg6mv8xKBSRhOJyBbzTftG2ZQR1e5z3a+1AvDQ7zX
WJ3YbxXnSNGszyil3v19rG+8Or5cCLd6nTUOlpvrnSgKnb3XnHvhtNd9Uo0yYjyJ
krMxb2G8whfvXerk0eRTgX4MrYnGoo53pPrDJ0xeW+Iq4nPfADA/VD/OYJnfjdhU
d3MD0IcDpNnwoMOyG8yJw/lJNqRw13fG812z9O8IVSbTV4Tnr90=
=p15P
-----END PGP SIGNATURE-----

--iEVNn0LNj9VRH8/p--
