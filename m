Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7583CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545033; cv=none; b=NdoWkPyk9ibJHkOEYvdyKMi1e4VP4NGX55PL2tYWE0jhVkqlqSML2eJ2/4341lRMYugDdG10rVtp52uCg2nJzOMoIbbKcgTsFIN6/tSQveR53qbcfvenU56fxNe9wtujJwYfP419k7jDi/4ceUXROLPEf1KZGdJvIXBm+U3CPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545033; c=relaxed/simple;
	bh=8tLZkJDudCljQJVhwme5ixZcwqXiZuCg9ZbeLz2hx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prj3zx5Lnt8g2NaA29XsiFDP/waWEblgqKyVdEAHsOGN7/RMw6hHSJ4NiGFfhNHWVSWR94a7Kfts+RRsXHazPACyap+W45O14yaiHgbqwPHINNsKVLnsmLmMyMi7wZVTU/ZFK+NyPtLfoEcIl9DA1eTh4WT7T815Hs1JOSw8080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L+tzJ9wr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vs7TGSEm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L+tzJ9wr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vs7TGSEm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 59E4711400C2;
	Fri, 24 May 2024 06:03:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545031; x=1716631431; bh=+xatpJPETN
	vmonEK9zl9VQW/uwzRSdrrRd57nKF/zuM=; b=L+tzJ9wrVp6UcayWBM3h+1ksrQ
	qp8s0ai94emR71vJneDiC8YMsHzzuWJ//RI3RgvPm9Bh3Th11rsvqoizFbM1EiL+
	wq3deJ0r0oBXcumd7uVNvSBq2mW0oNJ4JEbJZnClb175saw1rYKWYY7RjdFy59bU
	bpOtSnNU6c6VRYbCmkLtS6nXZ0efuGw1EYWN7BXZG+WFby+c9rW7Hsi+SEjeiqA8
	v/dODYriyq7LBhMeyjW8NKqDfG1Y5rGcVyr+mVdKNxm3GgQpTkoskBeTiRuEJi0p
	H5ZgH6q+N9v9D4PrTRi0L4dCiKJXoKlKiLjcUFERTwkPCgQMrwon1hRX9K9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545031; x=1716631431; bh=+xatpJPETNvmonEK9zl9VQW/uwzR
	SdrrRd57nKF/zuM=; b=Vs7TGSEm2o8rBCkGDFb1G7+BpKsOJI3DiuDzRLMIFfMQ
	NiElJjAXnLsQB605EaGQtd1nEBlcEpUNbAd1GtNwlTVM8HSVI+MnyHVNj0oC6osn
	wR4HyASTGQYInmyTO0b2glihtBwD6oz9Ws0CAaOEN/qOitaTCkLm9uziOT+yRrll
	TcvvWDiWwwjqNcJytlo5in0ou9QF6B3nt38ipLLVlivAUwak0uR+JMosfcTCkjBx
	TSyr6hqKDPrVGmmb4b8C1/svcNKqc9SGVoIADfGpUAJ4uHDMhIvfpSIS3PiiBjDO
	usOScayJPqIWRfoiTqzktclPxCw1n4lpIbhZYY4Kvg==
X-ME-Sender: <xms:B2ZQZgOFoxNcyFhb4Aa5GnM2Md4n3OSqnefp1GH0HUiuRVaIyWSPaA>
    <xme:B2ZQZm9w2sb_bq8d26cUFi0w-3iQV2_rPLVSKgXiMA1cWXrY8OSBaYCHyeBsdjdxv
    B4UjN9-H8fNR2RDqQ>
X-ME-Received: <xmr:B2ZQZnTxucsoEq-ooBuiyM7mdWsC0Sr0baFIxg-MF2m5FPG5LB-3Cnh3KCipaPYd8V0YYpmOWox2G-wBilePUAQca7_YeG0Ns3HNgn2OgYI2sqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:B2ZQZoty7UC6hCAF7GSaZTfiA6LXJcK5DPXyq24SOi2E6MF9gJ-4Dg>
    <xmx:B2ZQZodralgVfIFqXGFmlD8JYPY51N_NM0Vx-h_m8BF73lc8Z3q5ng>
    <xmx:B2ZQZs2uRfVeS4d3ZpFeI6OnoiWSkN1LXGclLNnRrWHxAqzXF5Y-6g>
    <xmx:B2ZQZs8sUWd0GOfKC2I4VQOE3XPvUGdnF1ntfu8CKZZOiL97c5UY0A>
    <xmx:B2ZQZg5B1mGK97ZEXGWMMSWD_jTV0gD6oBz4-os9Iw6DZW5eienr0hGb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d356ff31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:47 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/21] diff: refactor code to clarify memory ownership of
 prefixes
Message-ID: <afe69c7303c2cc4894e0f075642bfdffedb99839.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wo64HRZG9eNy2u6i"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--wo64HRZG9eNy2u6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The source and destination prefixes are tracked in a `const char *`
array, but may at times contain allocated strings. The result is that
those strings may be leaking because we never free them.

Refactor the code to always store allocated strings in those variables,
freeing them as required. This requires us to handle the default values
a bit different compared to before. But given that there is only a
single callsite where we use the variables to `struct diff_options` it's
easy to handle the defaults there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 902df9286a..679ef472f4 100644
--- a/diff.c
+++ b/diff.c
@@ -62,8 +62,8 @@ static char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
-static const char *diff_src_prefix =3D "a/";
-static const char *diff_dst_prefix =3D "b/";
+static char *diff_src_prefix;
+static char *diff_dst_prefix;
 static int diff_relative;
 static int diff_stat_name_width;
 static int diff_stat_graph_width;
@@ -411,10 +411,12 @@ int git_diff_ui_config(const char *var, const char *v=
alue,
 		return 0;
 	}
 	if (!strcmp(var, "diff.srcprefix")) {
-		return git_config_string(&diff_src_prefix, var, value);
+		FREE_AND_NULL(diff_src_prefix);
+		return git_config_string((const char **) &diff_src_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.dstprefix")) {
-		return git_config_string(&diff_dst_prefix, var, value);
+		FREE_AND_NULL(diff_dst_prefix);
+		return git_config_string((const char **) &diff_dst_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative =3D git_config_bool(var, value);
@@ -3433,8 +3435,8 @@ void diff_set_noprefix(struct diff_options *options)
=20
 void diff_set_default_prefix(struct diff_options *options)
 {
-	options->a_prefix =3D diff_src_prefix;
-	options->b_prefix =3D diff_dst_prefix;
+	options->a_prefix =3D diff_src_prefix ? diff_src_prefix : "a/";
+	options->b_prefix =3D diff_dst_prefix ? diff_dst_prefix : "b/";
 }
=20
 struct userdiff_driver *get_textconv(struct repository *r,
@@ -5371,8 +5373,8 @@ static int diff_opt_default_prefix(const struct optio=
n *opt,
=20
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(optarg);
-	diff_src_prefix =3D "a/";
-	diff_dst_prefix =3D "b/";
+	FREE_AND_NULL(diff_src_prefix);
+	FREE_AND_NULL(diff_dst_prefix);
 	diff_set_default_prefix(options);
 	return 0;
 }
--=20
2.45.1.216.g4365c6fcf9.dirty


--wo64HRZG9eNy2u6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZgMACgkQVbJhu7ck
PpQjZBAAj+7cddZ5r6IdJI686Be6oNr93LzIvOhNOdI+M7ccre8KhYHjMtTaDfq5
tqGUpf7c6YG5JLWF1hK9GV+ExUJz8CeaRVRGhpFxQrStAsvsx/TXYp1pbqMV62xu
sKsZPlJ/fuBojqNbyO9yr2v/VT+/D29ydN8rnIKWvFAuDBDEgQef2a82FKB2SfdW
jF24vmFWryQGGCZaUMonVe4eYz/qA36gYGxWBXMHWFQ0AL/pfsV59+cX6uNjwYmT
oMWULllYhzmVBkRFdFltnMGWy5bKRdAdQoch1b0YkAP/00nYLy82kjUqYanxYcOH
EwNxt6tHA7s1lE0mpDpFwfykg35qtUO4WjgXBJLZ6FA81E8suOrYFT3nb7DfrIsi
4XCLN5RYrE3ooA0jLRUqxFxOGCR255qr3RoXTnm8WLYaW8jVdoRXOJ0IXVxQ2vhZ
Q7mng6OkkMvW7uoWVFyCPT7J7RyCSJz7WqMnCLAJioW4BuEoYaOyzhZpa3nDrtea
u9dO5LJsp2yN+uJVpkLyUBf/H+V3LvN3X62DFZcHDO8ElbaH5hUh1wAueWwpYv+u
V7tpqUh35GWJ8TKc2khaW+PQYZATRtQGt+IFuBiF7EycAGeU7XmTE09gFqHJofr0
yxA0VqaaBsI4iMkOIoMA2hyHHLDseLvj/JH8Q+hRNAPc/lWEDd0=
=ksVf
-----END PGP SIGNATURE-----

--wo64HRZG9eNy2u6i--
