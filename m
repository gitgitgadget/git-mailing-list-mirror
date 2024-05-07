Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D07A715
	for <git@vger.kernel.org>; Tue,  7 May 2024 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065915; cv=none; b=XZTpl2OZFRHIqKkBIsKvWIkTcIERibc8cOgqKiWladiKJF3qlyN8L8s7UPlZUEIHBychG5D0rCcKSBu1TlKlUG1I/mJITbnFt2fq/jpi3P9NhsOHp4xQNcV6p4xrn35/Tm2y7zACELFLI4uaF5p+d2NK9bP5oJi4SVWcE0TYhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065915; c=relaxed/simple;
	bh=PFgUc4FIMLeheBzeScsNgayPo9kH3lAvu3P4dlBa0fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH6oj+eeEVXOeESphZTSXVz5JvKJGpWKbq9nllpqPvr96h2bYbdnMvmoz10OW5mLCt1jNB6loGxXTR/CT9P6+aWL/0KB9MWUT70YQ4s7E91/clvdFiMCgwsgUecG9eFb+wuYj+lrI0lpzTrJ1yf0IkbiQ1Pil3gMSIpFE5ZBXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jlNefpQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBfemgRj; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jlNefpQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBfemgRj"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6A77D18000B4;
	Tue,  7 May 2024 03:11:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 03:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715065912; x=1715152312; bh=GPFQebM2vk
	zggftFeIbRknT4/7plgCoZdWhNUds1ia0=; b=jlNefpQXRtnKPZr+f/FLIRPzV+
	U0eQ6KZyZ4S73R7ohep0XaxnRclMz64rB023Mvfiz5UPcy5eWIG4YMU/A/EKJAGl
	YuWhuCkKEEjqik3znBH1CzvGM082iKP8sqfxFiTXO+o1+y6r2DWlyRQdfUH2FyOO
	UItRZhgMIyeGkr+52dxDA9M11IfIWpEeo3BMHQfm8WUMe2lHa5g3j/A99dRsl0TH
	zvLLEfBjsUeqL50UnkNTYEMc2dz7mibrM27VRkAwSkRd7Qz2cRNaps1TI0s8EY1Q
	vQ02WSfGUR4U6QwWVWkIFiTuHKzLRmiamjyEOovIRthyZMRJTzSlUPSyt6lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715065912; x=1715152312; bh=GPFQebM2vkzggftFeIbRknT4/7pl
	gCoZdWhNUds1ia0=; b=IBfemgRj5RtQyBQQfzMeKEamyJKk7tfcGS4JdiUbV2FT
	ki1T1vIbGmJ/ADg+9tblqh36v6ubOZpWhq77FoJ9nnd+SpsUFPIGDdeU6yLLNHcR
	sz9CcNPEcWpOF6Pz9yoGZ4IFdjNXxGPmIT1jCrtY2d/L97CbvpBbmajM6iqq44Wv
	ohdApQLOG3vPAO471oGbyy/Iv+YE7ddjudtnjuL2Oj8/l8091iO9dxqgGYd1Ojcd
	fcg58IoEdEmf2IYydaI7B3WGhqHLrgEKsHt/n5fxbf8aK2O9Z9bo12Jd9/AGBn+9
	paDf0aPfZQ42ywJ02j9AwMGGP5CqefpR1clTuQsKDg==
X-ME-Sender: <xms:N9Q5Zs8ZObba5WFP2nfZU3OFyuX3DEptH3jBYV_mQRZV6Vv34Mv3CQ>
    <xme:N9Q5ZksTSnhnCQg-l2knEgCeI4aKRfigEZurlqlUM3d3R5YTpxHzaKmowb9QmqhGn
    Y6bXF4ncrn-dmm7xQ>
X-ME-Received: <xmr:N9Q5ZiDxY4_ANtCjf_zkcJWzJaUzzJeoPczmDUz8KZ_ar5akwSLMI73FukqEahnwHvalS3Cv7X3DHP7T3sMs4Uij7uauUm2UQ8UfA3z1bsYbrkcDqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:N9Q5ZsfWkyawVGfs6HC_yEaX2no2GsfUpx7G_TfEs3cvyq6rPnztLQ>
    <xmx:N9Q5ZhMBoQ2M6gWU7jPDUDavH48ifPqVGQjpFMmw8ZbPeRa8OpA2Mg>
    <xmx:N9Q5Zmkj72yFUbSMMIlQFgUOVMtfSXb8oN4BuEAvu2obSTFLVtcCkQ>
    <xmx:N9Q5Zjv7C2E1Uyvm1Sj4LCtxFdFDvsvJ0WrUe0FwaI5s7Dr_MMi_XA>
    <xmx:ONQ5ZmqWDT2ejpS1NWal3RSuR28T0KBwWJqLfq0wHAi9L3h7GFmNRSZo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 03:11:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b9bfa049 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 07:11:43 +0000 (UTC)
Date: Tue, 7 May 2024 09:11:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, James Liu <james@jamesliu.io>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] cocci: introduce rules to transform "refs" to pass
 ref store
Message-ID: <ffe83f7482615c4523237bd18387ff9d3b16554d.1715065736.git.ps@pks.im>
References: <cover.1714717057.git.ps@pks.im>
 <cover.1715065736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEgjtqyCsig6Q6J4"
Content-Disposition: inline
In-Reply-To: <cover.1715065736.git.ps@pks.im>


--lEgjtqyCsig6Q6J4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Most of the functions in "refs.h" have two flavors: one that accepts a
`struct ref_store`, and one that figures it out via `the_repository`.
As part of the libification efforts we want to get rid of the latter
variant and stop relying on `the_repository` altogether.

Introduce a set of Coccinelle rules that transform callers of the "refs"
interfaces to pass a `struct ref_store`. These rules are not yet applied
by this patch so that it can be reviewed standalone more easily. This
will be done in the next patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/coccinelle/refs.cocci | 103 ++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 contrib/coccinelle/refs.cocci

diff --git a/contrib/coccinelle/refs.cocci b/contrib/coccinelle/refs.cocci
new file mode 100644
index 0000000000..31d9cad8f3
--- /dev/null
+++ b/contrib/coccinelle/refs.cocci
@@ -0,0 +1,103 @@
+// Migrate "refs.h" to not rely on `the_repository` implicitly anymore.
+@@
+@@
+(
+- resolve_ref_unsafe
++ refs_resolve_ref_unsafe
+|
+- resolve_refdup
++ refs_resolve_refdup
+|
+- read_ref_full
++ refs_read_ref_full
+|
+- read_ref
++ refs_read_ref
+|
+- ref_exists
++ refs_ref_exists
+|
+- head_ref
++ refs_head_ref
+|
+- for_each_ref
++ refs_for_each_ref
+|
+- for_each_ref_in
++ refs_for_each_ref_in
+|
+- for_each_fullref_in
++ refs_for_each_fullref_in
+|
+- for_each_tag_ref
++ refs_for_each_tag_ref
+|
+- for_each_branch_ref
++ refs_for_each_branch_ref
+|
+- for_each_remote_ref
++ refs_for_each_remote_ref
+|
+- for_each_glob_ref
++ refs_for_each_glob_ref
+|
+- for_each_glob_ref_in
++ refs_for_each_glob_ref_in
+|
+- head_ref_namespaced
++ refs_head_ref_namespaced
+|
+- for_each_namespaced_ref
++ refs_for_each_namespaced_ref
+|
+- for_each_rawref
++ refs_for_each_rawref
+|
+- safe_create_reflog
++ refs_create_reflog
+|
+- reflog_exists
++ refs_reflog_exists
+|
+- delete_ref
++ refs_delete_ref
+|
+- delete_refs
++ refs_delete_refs
+|
+- delete_reflog
++ refs_delete_reflog
+|
+- for_each_reflog_ent
++ refs_for_each_reflog_ent
+|
+- for_each_reflog_ent_reverse
++ refs_for_each_reflog_ent_reverse
+|
+- for_each_reflog
++ refs_for_each_reflog
+|
+- shorten_unambiguous_ref
++ refs_shorten_unambiguous_ref
+|
+- rename_ref
++ refs_rename_ref
+|
+- copy_existing_ref
++ refs_copy_existing_ref
+|
+- create_symref
++ refs_create_symref
+|
+- ref_transaction_begin
++ ref_store_transaction_begin
+|
+- update_ref
++ refs_update_ref
+|
+- reflog_expire
++ refs_reflog_expire
+)
+  (
++ get_main_ref_store(the_repository),
+  ...)
--=20
2.45.0


--lEgjtqyCsig6Q6J4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY51DMACgkQVbJhu7ck
PpQpEA/+JsNbztEUv5hCbhEIOR7q9HSCui5t/m5KHpx2sA894ewwMbw0JtIta5GZ
JDAfz/5nHXLMmcT94MZcumnnEYv+Xj57Qm6tgZV2bKqATdtsLjYPW15duildQ45S
cGmB9w8Hl1u/Lp+LAftO/aH5WsujUpWVSoztK6XHNs06hW+vGotvSGXZj47HJnAB
3qS0RM4Zz/ajjEUyzk+K2oPiYwjDj9w1X0ooo5D5Mer10C63qnUVXqfernwNV0dx
sYJRbxq2NU36m2CeXLYJO57b8iovYJgJN/MHH4Xd8LLyJ8q3BtJPcyRazq5oBt5f
2y0/exeHg7h03Lv6SsIAcPZtd6Znn18cebFlrw6NZsOHadpz3NBUN4ck3vxLx2Pe
4MI3hW/L9rIl3pZXijZriQouGIvCeRbGBEzJaKXXNkkSIBRbei37jnILaHZaLVio
lYhN7pyB3HYQubYT83t6wwLjz/y4eZQHqPMSoEbIsR8lReZNLkAOck2fWJLsPdpK
JKoWm/WpIYKR2vB8P8N4BgW1qNWbOJSKYf2OMcip+3GYIMrLMOHrzMTaaDw6i9R9
c+cFiDub2uYTmgrCDLFYHN3Irmqdh4GRt9Fsc+yjyG7DlTxWybrTKhvakRUMj6Aa
ty3PtI1Ho3UsfUJuoue3KmLmL+mfknVvppV5k7WQdM+tso6wbOw=
=2nzS
-----END PGP SIGNATURE-----

--lEgjtqyCsig6Q6J4--
