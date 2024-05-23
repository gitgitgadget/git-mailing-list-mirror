Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15E1482E9
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467150; cv=none; b=HOejxZvFm2KnoY4vKiMBicAFoN34M+uMzv8YoAo0sf/RrhpTrSEkczVgpfAqUNisLYJXQ2z/2h03/h+CfKgO2NxfK/wT00LNsZiOI0/xDOIkyeEI/68pU7Cin9rkAP8gJQXEmSZCM8Fch6UBCwfWHxdIDQiLmoTk0QgPrT/jvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467150; c=relaxed/simple;
	bh=vKiUXDid/xIKjRRK3PJkLOjYhAR20sHB5YJntC2h39A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+sjSjlyouUFYo9RdFRIflhcpyxASFpleeZPM/qj3OZGtsbNfwwlfWl8/aLamF71eXc9MIpFdqO/mkU7BcrfbEGqTHN3tG14Ft5Rn4NmySdFx2H9JvI9FjjpRMQRO2rS0LBnVjjv5iDnuxgKOWT36qbCnIntMAduVfoFN5HSB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPyzTdm2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gfw0Wfox; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPyzTdm2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gfw0Wfox"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7C502180010F
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 May 2024 08:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467148; x=1716553548; bh=rmoSPuL3oe
	y/Jt9uOU2RtbvC9EPwonGwHfk/GRx52TM=; b=MPyzTdm29bBkeNl2tj7OZ5rFya
	nUW6YAh0CKepFS/aaS50DYSYLh5ckCANsuDK3JXNwXPGhKKEWa4cYtX93GbqoZ26
	B1cpV734TR0nF2+2GrLWzxzhopKNBKYUc9qgILyHdsDwtZsxDVgzp7Z4qjm/fgHh
	T7APFq62gs1NqYx0UBdl3nVyVTct5fTH1nBph2EHQ0J0IhVduNV8n2XAEg1BwXLE
	DTBnZaRYV/08Z+WaPO6sbUzIH+SQ8n4lwdF4XahWo8oWXEKzVBQOYRZBMCaIWtW3
	imPdmmgQRpi+bAAm5WuhkHyDpZDbqLczdfJXZ12iHfGEhcI3xyrgZYi6YlyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467148; x=1716553548; bh=rmoSPuL3oey/Jt9uOU2RtbvC9EPw
	onGwHfk/GRx52TM=; b=Gfw0Wfoxo2333sdK9fLQPY8Ao8lATZQHVLBVpkeRX5eh
	UlaDis4Ncy9j0SRM/Fd49L3GL4PCUo8DzwJOpPZjkxpJbT6bwx/oTLohaQmfcE6W
	ziBj2MydpBBDZfCnWpN9WVXltP5FhBmD9/XwRscTXHdzdVdG+R1+jS4wS0yfvqv3
	rVYakXL9fHYtn0pzaXXYadUWgOs+BU1PMJOLx1sim83KUY8xQfeDYmW6swJqm359
	K59x6q/Sw4VIcfnf0OjyRxLSqxxb6tKZ9h6qg+awa5ViTkgDCzvmg5efUfCta2kP
	RFc0YXcf2rRcpy2j+F6X+EjUJphuJLfHlsxN3gm7dA==
X-ME-Sender: <xms:yzVPZu7YIlzDqjbgMK6L_bfKkk9X1djOE5B2eUG2NndDDI9SJYuLuw>
    <xme:yzVPZn5NGjFqALp__Mt4_7n2QPhDcEpW2eBjErHp9Orudun0v73MHQX9IXmAd4WuY
    xraxe4wEFjWrYuUew>
X-ME-Received: <xmr:yzVPZteKWjX3UlRruyxDio3rDKIqfNBAfFo2Oj0wEofXKja1y7xBlLOusDRwfMf1QSHSiEQdweBgjFvpqGB8JQJwIeell2qZGcxp2axsfe9aukq-zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yzVPZrKzYcVzBX05LDqxaxfJijLS_ZP73ZSguyeJwGllvBhrLRoRQg>
    <xmx:yzVPZiIzZxKwDUrBH44HbSX_ucKHOhH4D3oNYxW3UkU9ZCOraOwe_A>
    <xmx:yzVPZsztH67phZfLRPeuZnJ_CFKLbUNnNu9Isaz4VWp8RBkhvsnAqQ>
    <xmx:yzVPZmIZ62XpynFVfPugTKqriG7p_mld44XXuTWIHXFl7Q9Cb6F0Ag>
    <xmx:zDVPZkjDRMIkr8gN0eZyTC43dx6BpklXD8MlGI8IoYKDG0RcVkrzPZfE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0371b3e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:41 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/20] diff: refactor code to clarify memory ownership of
 prefixes
Message-ID: <18dce492df7d4337dd639be767f2fe280083e9f6.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbUnG+Jm5dofJlQK"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--rbUnG+Jm5dofJlQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The source end destination prefixes are tracked in a `const char *`
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


--rbUnG+Jm5dofJlQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNcgACgkQVbJhu7ck
PpRprQ/9GAWIhbgvzjiR5I/FEzUS4zARku7D+/RLoYh2omorikV1tHOuQ2V6XAU0
Z9+ll0rSuXmIB8cJyRF2NOljeG286BmjdL83ITY7U+yb3bcLIa1EA3Yq/pPUrfBE
xkVDaMZJXYL9htZB1JyF+mZUGuEuu0rPLehhyVMmLY+cPOsAZi+RSz8oZ1jKQ8Lx
NDsztw+RCIBUZ/GziSRaGMcAQzRSDtx68RJFBn0AuDbRez9SDZhoZ5ZELUqKZGUg
q3DbIL0Dn+sBs6ahwhjbd3Rnnd8LQ8AEAzFKG7eUU1Fr6WPGzJtijIfW4zVpNRoN
XoaasewrBNfq9mLh6gZwcykfmQRLBdyUc1uve2gSxxu/w+amtsLB1n5s4+4qZifR
6e+sueRZj/J0dpLwmJCbzuBcerVIO8eSEY+ghUt6/OlFK9ugR/8mVP3UJ1OmA51X
VZ4zRBrts0h75XoBpOcPnLYuRF3JOHy+yuF/ZYiVCyeGO+jXUzFTPt9gG4+/4XVl
nrAHX1hkPYasYbx6/QAgYHR1CmqAAV93rJ9ZnNvMYx82h3bmH7Fgfy/46lVbRjJz
o+rOMJ2lY8Lcs6mf0adtsmNo2tYe8dem4zXcLDgcemk2YxvW9FE9tGZAG5st196u
q5xhMwKOrj7DAKEuRgnXnAKq/yCdCG+937lakOc4zUEhCPa+fQ8=
=4R3s
-----END PGP SIGNATURE-----

--rbUnG+Jm5dofJlQK--
