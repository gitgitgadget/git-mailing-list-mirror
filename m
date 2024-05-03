Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40B139586
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717691; cv=none; b=SzmPnCyg6cE6LCqZNxRhawGncPeMCURmnpdqBor6jm/4KysSqMf6EpsZ2J7K46/OtmvdtkI9WpPX8Ztik+2JMmbkBgoBEwjDIsxfTVbjeB2ywYDE7ov1xAL4wF224YZKcqkYYaPy/hpmIe2pb1g8yXw/1kN/kLFwHMfTh76pl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717691; c=relaxed/simple;
	bh=hUpsIlWHz5AJK/YAia11fj+q4inn2G5I/Vx6ZuVAnec=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1q88FJwNSrrZjFlQ6CRUIN4QueCKNsl+QokxxbPXDCt3Tj5TV8lWFYi/M0j39J6YSYZkP1mxvACtTmt3QIPRNvZ85R6Rz3IlgOtXj159hRbguRh41KoaSMW4ejhm28t6LqdT7vJ/GlJelPq9o8FOCZDgEfpNGQg/Mx1CuzaIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tG+vPR3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjqBHYyB; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tG+vPR3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjqBHYyB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3308618000F1
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:28:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 May 2024 02:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714717687; x=1714804087; bh=hIqnO+k3sg
	D8NxYpz037ITC09zXAH9YdmWf4rtK1dcg=; b=tG+vPR3zefK1J752h5y+8ou7qY
	gVr+Mzf2kzzYX/TpVkOAO2/tO/Z8xYvVSZfXBP5UrPqiKqIR9qHBPa00F+sx8EmJ
	MesZAZVIKsSh+ScVCthfooDUql2E0Vox9YWKBBgQMksUPq+QEQBEo6bi8Spc/9hk
	9c3tWCSfE9UWijss1TFDWWtvp31B7XyNFrOJSJuG7LD1bpMA/3T7/TcPwCVERPkD
	sGx3BFpB1IYt+OSvmyu/1NnvXms1OCy0F8dFz/52w0B91Y9/0RQs5AaTswzPp9CL
	zZfTnic6tfWYbG+4PK4dFDTcPo16dPaXDg0zWqT5fMd9Ri6SVkzvlJ4HlpwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714717687; x=1714804087; bh=hIqnO+k3sgD8NxYpz037ITC09zXA
	H9YdmWf4rtK1dcg=; b=HjqBHYyBk1ONvUk4jUu7N0FbeflJwTlI7KcDWGgbhbZy
	F/5TDaY7oSKz55YZRRGPLM1KQ5JL3Saxn8zXsVCtZUsTQa6L8QAreYriQ7KrM4Yp
	0tezSzm/p5L6bf+jcEM9/SHnfki0OLrJ1Xl0eFMbL3lbCqOXDBuTKYIfFP5LQVS3
	Z774Y3k6tqZ7AARYiYdAZZIHJnnGK025m6+HzBXucy/CSPv10QzfRwr6l32jgUu+
	D4SG1oPu33v2txA4ezb94HVo4KhSONb2u+TFpcDTvrQb7+6NJSiR4pIRVQhMqTsp
	RRGcmIU1XBU5czlwoJ1wvZvuNQNdiqScPYvicZWQiA==
X-ME-Sender: <xms:94M0ZuZiBuFUQ7xd5DmZyqftojhFUHidw3gdcyunrBq_r_hq7w2EiA>
    <xme:94M0ZhbckHR9Zp-8m6OZy3waEcMRJloI5atzj5LDbevcvsk-qBqIHPk9yHfp9FDyg
    Au_BCaSridNyeVwPw>
X-ME-Received: <xmr:94M0Zo_REbezBbcsBYuEJcFYsNGRcgAuUdB-R4zWbpjMMlDbmVTbopwJ_3Rp0x9gR-ZwIthQ9yOuNKbvKIYyvMjC4VFOb7H8w8aL355EfYBv9pgz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:94M0ZgoglGsZE3B87cfEnSKrCbe-RZJIcAxLlF7Ms5WOC9Q8pA1sSg>
    <xmx:94M0ZppkVlTqlq10i98LO1zxTjG-UeT1BNXF77Fk2GOWOc7MmMbmsw>
    <xmx:94M0ZuTNCVJ3JkJS4kHSRNIvIjC_Jai4ozPeS00W8VMoSdarBp_dMg>
    <xmx:94M0ZpoT9bUSYweB-6Rx1K-JwP45ptjT9g9WOynepc9nyjZPwKBuzA>
    <xmx:94M0ZqBix9A1f7jdGmudfBJF4QM7bE2TuLDFhTKOiGJ23QUK2dwWU4vg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 May 2024 02:28:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5332c38d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 May 2024 06:27:39 +0000 (UTC)
Date: Fri, 3 May 2024 08:28:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/5] refs: add `exclude_patterns` parameter to
 `for_each_fullref_in()`
Message-ID: <4f34bb2e03479b4987ef30330f096650de354b06.1714717057.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZ4L2kei/teKdtO7"
Content-Disposition: inline
In-Reply-To: <cover.1714717057.git.ps@pks.im>


--YZ4L2kei/teKdtO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `for_each_fullref_in()` function is supposedly the ref-store-less
equivalent of `refs_for_each_fullref_in()`, but the latter has gained a
new parameter `exclude_patterns` over time. Bring these two functions
back in sync again by adding the parameter to the former function, as
well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c |  4 ++--
 builtin/show-ref.c  |  4 ++--
 ref-filter.c        | 10 +++++-----
 refs.c              |  8 +++++---
 refs.h              |  3 ++-
 5 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 624182e507..2b28d43939 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -908,8 +908,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_fullref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_fullref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_fullref_in("refs/bisect/bad", NULL, show_reference, NULL);
+				for_each_fullref_in("refs/bisect/good", NULL, anti_reference, NULL);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1c15421e60..3c521dbfd4 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -208,9 +208,9 @@ static int cmd_show_ref__patterns(const struct patterns=
_options *opts,
 		head_ref(show_ref, &show_ref_data);
 	if (opts->heads_only || opts->tags_only) {
 		if (opts->heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+			for_each_fullref_in("refs/heads/", NULL, show_ref, &show_ref_data);
 		if (opts->tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+			for_each_fullref_in("refs/tags/", NULL, show_ref, &show_ref_data);
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 59ad6f54dd..eab4beba16 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2640,7 +2640,7 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return for_each_fullref_in("", cb, cb_data);
+		return for_each_fullref_in("", NULL, cb, cb_data);
 	}
=20
 	if (filter->ignore_case) {
@@ -2649,7 +2649,7 @@ static int for_each_fullref_in_pattern(struct ref_fil=
ter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return for_each_fullref_in("", cb, cb_data);
+		return for_each_fullref_in("", NULL, cb, cb_data);
 	}
=20
 	if (!filter->name_patterns[0]) {
@@ -3060,11 +3060,11 @@ static int do_filter_refs(struct ref_filter *filter=
, unsigned int type, each_ref
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind =3D=3D FILTER_REFS_BRANCHES)
-			ret =3D for_each_fullref_in("refs/heads/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/heads/", NULL, fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_REMOTES)
-			ret =3D for_each_fullref_in("refs/remotes/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/remotes/", NULL, fn, cb_data);
 		else if (filter->kind =3D=3D FILTER_REFS_TAGS)
-			ret =3D for_each_fullref_in("refs/tags/", fn, cb_data);
+			ret =3D for_each_fullref_in("refs/tags/", NULL, fn, cb_data);
 		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret =3D for_each_fullref_in_pattern(filter, fn, cb_data);
=20
diff --git a/refs.c b/refs.c
index 7cafda1c25..00bcc72719 100644
--- a/refs.c
+++ b/refs.c
@@ -1742,10 +1742,12 @@ int for_each_ref_in(const char *prefix, each_ref_fn=
 fn, void *cb_data)
 	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, f=
n, cb_data);
 }
=20
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+int for_each_fullref_in(const char *prefix,
+			const char **exclude_patterns,
+			each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, NULL, fn, 0, 0, cb_data);
+	return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+					prefix, exclude_patterns, fn, cb_data);
 }
=20
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
diff --git a/refs.h b/refs.h
index 10982dcf03..a28de62fb5 100644
--- a/refs.h
+++ b/refs.h
@@ -353,7 +353,8 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn,=
 void *cb_data);
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data);
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+int for_each_fullref_in(const char *prefix, const char **exclude_patterns,
+			each_ref_fn fn, void *cb_data);
=20
 /**
  * iterate all refs in "patterns" by partitioning patterns into disjoint s=
ets
--=20
2.45.0


--YZ4L2kei/teKdtO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0g/MACgkQVbJhu7ck
PpTIDRAAh9KZax8tAL+uvaWOSLxs8u/ampi8eRdzh+AlYUJjpFEGsFDXWwf8GKjO
5rIwSMI5uMXR9E2/pcKlOEwXAf3zYsvz33yVUFqkAM1frKz7LlBwKy6ypW7jhkBD
KiCw4P4liTkUnho7kNvCS+z5iU+Sw9KCNKEhJ6c19BJyxTX3VHcqgRN91gdg5y9y
Q9iDq1QGZ8tfH1AifderajYit3HD37T4fSh1MPK2HwgRsS6ptXwiLv3efoaYLoiu
ZzEOkYRTiITN5r6Hrg1bYSI4PPvR/PXbCrUQ8Visc/HSyi1muZL0L2syCaKKuOJz
wnLZLAW3Guzxc31bHFtIM2aHjPNMXjZ6d9RytUmyDpbjdsj5bLtFAjH/Fj7TyfIG
v1Zrycj4zemueiJk/IcIgb9zGpZ7o99iIo4p3F2dNhE7UREyVAwLCIZspYuPVhYC
acxPcDISOTqaOpxUZBreAfcp5xM3KZFtQoBiKRoS8eQCvFaZ8pqu05KDTSGR3Pmm
BYA2lBX7lOJMsZ7C6B9I/DlBppsup/UKr2eAIFdrXpta6e/OjDMSTyvZmBHfq+8I
sP/z7WZ+deVPKEjS0dK87JbCPcIayEFA3WCMIVA5aLuSG58HU1nQetP2SZSazUBL
dJ+P9CCrqphXwD6+1s3YpqRYZKEtXx//VhF3EITWlhPC9igAjvY=
=xVCc
-----END PGP SIGNATURE-----

--YZ4L2kei/teKdtO7--
