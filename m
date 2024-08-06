Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA331BD50E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934869; cv=none; b=P+wJbW5FGXPg7YqOvc5pEIA4X5fRFsMP40bPj4K6PSwIXxEHoC4lCYg/Dwl0OLnTCTgEVI9Lw8CcZu7h1dfyO7VWAg5pq76HWyutrUKqnDJWZJUUERefUop6Y2LaQX9fDN6zD1VaUvAUph2C3QTDh71EVz4TlAo/iVMdK1Qw1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934869; c=relaxed/simple;
	bh=2HM5uoZE+hYzHA2LYT563SlfBbfBlo9NtasIElQmNTw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNdF3zDwWHUey7lLAkrqKqrLaJay4+585Jdscdp9zEyIaoDhFVWSxlPuXWfEV0FQxhphL8KLhNY8lG9Pl/HEUt7gU6QWtH+Ge2cUjm73JGVSBw2M7o3IH5W4ucGs0s2zPQ688Tmtt0vfKz9GMYaIn1QrEPXyk87X8U+AAohJUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GjcVXf60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhulsTNu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GjcVXf60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhulsTNu"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 75B0B138FCE2
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:01:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934866; x=1723021266; bh=0U4X7CCiWf
	+2XtXjj9VrO0P3GYgUMFVDtHoPPOoMviw=; b=GjcVXf607JrpKX5NvHlRaVzNj2
	sjDz9QWLS/deXunvjbwQKp6JGb0xmm7MfMbf5mO5Mumi2JuCMnjJC8WI3/wg/d2C
	HAje+Y6Si8RkaylsAfYHU068+VlZ9G2HPWyM4IepedJb1WBODpaIUinGsyWHrjRV
	tY8k5NCaiGf8ijlfF96MQVMYqfAXn+lTHQISG4iLv47go8oVZN2obcKGDPfi+xtU
	CA/sNI+fOLsRZUxGjAw1tPZaBYyQPskVHoYm2ih55ZKQV8PBfBFQ/wQQNVE5J0ZC
	759YMSu85CRd2rvrsUhVxtp2IyleUpnTwf4S1/mMPtFiqiMtJKSdf/HEfDFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934866; x=1723021266; bh=0U4X7CCiWf+2XtXjj9VrO0P3GYgU
	MFVDtHoPPOoMviw=; b=VhulsTNuQ4yWBVThhvS/3OFsfbyuRsnwFzbYFyBh46zk
	+vmMfgTlRyuObkBxaeyyRwFRPvGblU+TgL4lCZlgrqXQipl0DFKcQVMptkC45daI
	7qvvCOPcJiEjoZuD5Wwjm9MLqrSZCpy0it/yRFpum777/YA4lra1OMX+Vy3PgKkJ
	NExV/qBzMjhUM22KiEYQW4sBE4KIEB0KiWV8IAOln2w5w8h/h45RKglLmDj297os
	DWBsWBAD/pcpLXQmLIRcTGCYbkqYQDDQG/eqfoeiA3AOLLf/vsMq1xCWFEjDS6O1
	/g7e2N4Linieri9zzXZ9uX2eN4cqm9SsEjzMomuQwA==
X-ME-Sender: <xms:UuaxZkE5H1OB1M7J5FHkmtK_Q9_Rd6TNRnHbe886Qk0WkkN1neT2PA>
    <xme:UuaxZtXind98ZeMW3KqY5ZICmWCv44ujnPPgLpl8NLVjcb_7ZkE7ItvBBSfFvFJVr
    ApZV7ucqtV47fLvUQ>
X-ME-Received: <xmr:UuaxZuJKwdlonYJFy6bI-D5jfWgo0K0qcrIbyklXtJNz3_mPlIs4opq5ImrHP80O9bGw-b1fiMLq8H_uI2FoRtW0f9F6XxL67_5-tyMP0FjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:UuaxZmFaz6lnhLHnG4Xob_QxbaYRgKnmFltCI-3DxyBPDug26VvV6w>
    <xmx:UuaxZqVlLESuZpw_akimx8LNiynbHdKgBvYXVXPAiCKAGcw5aBQxVA>
    <xmx:UuaxZpMhPDUHUkZpm90-vTtIISbMSZ6WDx2T12dKywzCYxJT3tLYtg>
    <xmx:UuaxZh3v5ZB9LrHU6BVZ9v_rK_fXtMQs4h027xC0a3krcsqlSlhUwA>
    <xmx:UuaxZtfwOBcEkiGRu9LWg6Os3UfY5pcfidujn37f49XMsy4QquLTbho3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:01:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b85175f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:01:03 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:01:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/22] userdiff: fix leaking memory for configured diff
 drivers
Message-ID: <ef780aa36039560fd069ec97ce87665eb0775200.1722933643.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ckioDxoFjiVxPLD+"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--ckioDxoFjiVxPLD+
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
2.46.0.dirty


--ckioDxoFjiVxPLD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5k4ACgkQVbJhu7ck
PpQpSxAAlscTVgDqFhLQ1D5mkchBeBHr8tadx/qaPUhGFZUYuxW9OXyDy3xY4a/n
dWjNc/wyEu5XC8S8Adaw8UX4zD5ooLnKGmvRjGD/omQ5cyz/DyX7YF6r0TSwRV4A
jbniTTiJlUtHOtG1+aJigWfBBCpjD0TR78OLMJotJ8vkNlU31TGpTqhZuhC4Jd45
IZ0uQYShQFTdllGv4JBH2AFpcbxXcOK6txdhPcrgEZ/Fp8AvRPa6h0pr8q+xRWnR
TlUg0Rss4kB5IHMFb6UWRkd7DcVBYxznUk5VPXDgjz7fVYeixdnAeY/32aeOVHLL
ZM03NTsoDNMmZmlSLFhXCwjwut+sO4IMGXbz7mVcagofWmNMHBxZ7kFAjKhjMKmj
mG/b2mfAAzb9XOUlo/8/6VFPXd6dJ61L8U+yruBwJmKLvzZ9EcR/NCvTNkjHLNbc
JPNtAOE9G622vyaHP1+W6/DJtquTIpwxwSgbLNBq21rJ307T7mg8O7aA+gZf1o40
RV0Bxq2hPuWSYiOj9ZzTmyhObs4HLOKh9aWDf4AxsqXdlNI6y5BkjtvFjBhxTyit
lQWqDMkeuCRoZskeZOGv4MpwzTooiu3dW1lPCOQaOGzflETVUiB73nXsrhcg6ruX
49N1Yg+jViZXqxIMX6QOhbn2IjgFeqt15xAQTarBaBFaVIjNgJM=
=xcgi
-----END PGP SIGNATURE-----

--ckioDxoFjiVxPLD+--
