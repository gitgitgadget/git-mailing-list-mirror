Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD61598F6
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078695; cv=none; b=pRCgsIcmalmL89W3JdBNtvxJb7m9A3KsRot4saGiDRVlNjP8ivxpQ9Kno9hLc+Gjw8hqSFvouoN683/Rdir+HsiuV+LHjctwtwA/p9DdYUkaU/lKbdaFM/HSpWb4pmp6W7H6LdTuRwlSwk3Ey1tH1aoibjFycuvZN/qjVx2yvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078695; c=relaxed/simple;
	bh=YaWIU8R9GSM62RdPYRPeYLLYduD3S+yvtJOdEMXvV8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYKbd4zhjEQdKpp7hd74oTdY5zc1m+8F3fsKbGBRUyCg/BBsOPdvKo7A9yvGBZCWG9gXVTATM5AMF4gpAQCu/FAyug9vo2t7R1Hs30TRAzIFoIvybIV04E0kj9kU27Y5xZx2Sgp0zNVwu6FIZNmuZbGo11dmM/5aS8c0UeL3HjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TV0DWGch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUXDEwNg; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TV0DWGch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUXDEwNg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 3ACE032002E2;
	Tue,  2 Apr 2024 13:24:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 13:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078692; x=1712165092; bh=tZ3ebwRrsS
	+Pp6RfAkyUQhsI5oHq7ZUcpP9rqDW8KXc=; b=TV0DWGchAYUO9j+rvLVE0V0vte
	nIUy2MquHYm8QT6yKpNrXhyiFFrd/sSZIji7O7Xui5I6QCh6a/+dE0dIlh4PaFdu
	gwLiU5bJgUH7Ts7x+OIhLuPifmJruK4a5o9bL2QmZuixn2yiRaqjSo05XCwEGB7f
	EgYLewOfEHMH9bAGXuuPWgDyCa0JfihN1DePsKThA9YXGzO3NDVXQLa+PaP0w4gZ
	XIgAtV2SC9QPq8cPTujkk4WVX3ZiX7yvjlTSNZeSXHIm/h87a9TWQXxBqZKQBdBe
	3s7BMn+CwjbOMEWnqm4yvlilGp0cgLxeWLDFXLya9bc7jc/puk2JiYMqL1bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078692; x=1712165092; bh=tZ3ebwRrsS+Pp6RfAkyUQhsI5oHq
	7ZUcpP9rqDW8KXc=; b=IUXDEwNgOaW1ek2McfvLGy+XiLnQMnMAPiE+zXplfS6B
	Z1ZHUUjG44DFLvq8AG48Ktwbi72LoGDo5YScJ1CYRxnHrilC++S8+woDO1G0wdcw
	wKkCui17/fuGeTYca4WpqQfXzjVoSJDIC5pxdwWImOjpQt0dEmS0tuX4Xpcf3M9b
	chKLcoGry63gqZDZbUc6hBj4ey9Q4CtF4ehM0qOvZwUTOJEDWzQktZQoMxf0gA1m
	q8adUUFWZ974zHlj2TGUzzZZKu2GeEnc3UTvty7t3JS02bPFNG741OthDlQBbQAC
	dAcTASFG3wxjX6yUPwXWpBpDyu5eSSmB2w316GXW6Q==
X-ME-Sender: <xms:ZD8MZiYdTs4H3Kc-Y7aYgLPB9C6OZ3tMrPWWAo3Pp8KqLVNQnBeGCw>
    <xme:ZD8MZlapcCAAwyKRFZWvjad3ivoivSo4aidybivFB6rE2ROtD9VFcArGPKZ5zGu6a
    FI2YHmoUU852IXzUg>
X-ME-Received: <xmr:ZD8MZs-1w65v7JFvE8gC4YxHac5j4DAur7m71IbuvT_RpMONIs5NSzC8R_oaR3rWhid1sb0h_kWRrQsLDNJtslkDhtiB3tfC6kkLerqimP760go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ZD8MZkrPY6DhTCtiGuqxqLsyOptzxDVLlDicRVwD17FMFbKKfqlhWg>
    <xmx:ZD8MZtqCN3d8pbFeeHqgw7jQ-jsUDV8PjwZRKcWYar8fSfQ7cKMkUA>
    <xmx:ZD8MZiQvEdA7ZcLibwMqxrXHFYjax8wj2H1Wv7BEeVOVdvLRoYx8DA>
    <xmx:ZD8MZtr7eCclApVVn-n-BvT-DmmeNbbjcwqrpxCUWKYCp14TX2RTfA>
    <xmx:ZD8MZkXVWpCmRpGhHnzW5oua7iqXN_tvOyrtnLREEgnE8z1X8iOeJJW5uXE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7755f1d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:42 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/7] reftable/refname: refactor binary search over refnames
Message-ID: <f5bf65e0dde70e7753e715b1fd207ef0e556669c.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WOh9ZMSSWcy+dYHj"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--WOh9ZMSSWcy+dYHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is comparatively hard to understand how exactly the binary search
over refnames works given that the function and variable names are not
exactly easy to grasp. Rename them to make this more obvious. This
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/refname.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/reftable/refname.c b/reftable/refname.c
index 64eba1b886..bbfde15754 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -12,15 +12,15 @@
 #include "refname.h"
 #include "reftable-iterator.h"
=20
-struct find_arg {
-	char **names;
-	const char *want;
+struct refname_needle_lesseq_args {
+	char **haystack;
+	const char *needle;
 };
=20
-static int find_name(size_t k, void *arg)
+static int refname_needle_lesseq(size_t k, void *_args)
 {
-	struct find_arg *f_arg =3D arg;
-	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
+	struct refname_needle_lesseq_args *args =3D _args;
+	return strcmp(args->needle, args->haystack[k]) <=3D 0;
 }
=20
 static int modification_has_ref(struct modification *mod, const char *name)
@@ -29,21 +29,21 @@ static int modification_has_ref(struct modification *mo=
d, const char *name)
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D name,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->add,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
 		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
 	}
=20
 	if (mod->del_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->del,
-			.want =3D name,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->del,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
 		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
 	}
@@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D prefix,
+		struct refname_needle_lesseq_args args =3D {
+			.haystack =3D mod->add,
+			.needle =3D prefix,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 			goto done;
=20
 		if (mod->del_len > 0) {
-			struct find_arg arg =3D {
-				.names =3D mod->del,
-				.want =3D ref.refname,
+			struct refname_needle_lesseq_args args =3D {
+				.haystack =3D mod->del,
+				.needle =3D ref.refname,
 			};
-			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args);
 			if (idx < mod->del_len &&
 			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
--=20
2.44.GIT


--WOh9ZMSSWcy+dYHj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP2AACgkQVbJhu7ck
PpTX8BAApWL+pj2LDt1E+aCFYX/CheHKw5Kv77T+XUcuSU++Z4t9G7BF44Asg6lj
z8acLFVlwFVA03O3IEf40PPrwoQqAmLapFqPleVInxFz9y21XFOWubDaN1NgB5Ud
A+bh0pK6FbDF+MU3tB44xRZxtUBK/JZDAVUbdbGuQNEH4E9f+gc6y7b3swb+o7Pt
5CYwqLFRUIJ159/i0/NO+rFKE9eNP9vdxI6FhHuOixQeuhthJWe38FoN0OzTVPuc
wl8o3is8pTqQvdkR4HhE2HXZR8zb1vE2j/kneh509Q/6CFwjBKRdpkS+UJhg2hgw
rbVqvJPoQ9PaAwV5gZ0GazyJ3nhHWpJp8KWYT6iTpXbarRfa8aS/c/rJDAObYsS6
CuLhRhOSvpu77Nz5JsjaV9EGDn6wVwzqfjvilNcXN8vbDGlnCptH3aTaoFWbTvH1
XeeqUlr8p9bRy+Uigj/I937pkbaegd7gLGtKofIGsYqdOYXUubJp7xM0UnECVVRf
7hw7gYYzQM3GYU1Ji195X4pJXDei2J2QBqUuWHMIi3GkG/s5AvV5Wju4x0L9gseg
59EbW+kgkQtK1/00zqYMvWjTTDdzpP9hMK1yadLYE/nVhbsqXeZx7rPMBgZx989F
ijGXsDzwv476Z/RHCuZ0RpfONK5ksGrg1TMJYSuiAilj2hvY4LI=
=3L4o
-----END PGP SIGNATURE-----

--WOh9ZMSSWcy+dYHj--
