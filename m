Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3537146915
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046400; cv=none; b=RZVVVHU+r055bDnQjGLLvYgTAYuTR6r/mVfUdY/o4Fm4vwxx7jLdXmhoxts2qcn9mWZpCA0MQrLBnueEOoa9hNKoNw6Z4orFhFl6n0rlEBL1Xm4WmGJIabjmyl3pIE2HL9VlHYtZLhvEZ8cliZlQgeYxsMTtIY3PzqbMoxYq+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046400; c=relaxed/simple;
	bh=XKTgLLRynHauvOvCOQt5ofGZEWbh5QOkMUd6sNmJEbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aynsyxmw3uZtqMo8xD+vzXnyDntIRsiBtuD/5bEtngj/H4/aH85ss00QfK99iOHiS65ROQtD8wyzNpeB9J4QOdZnY/kQVrCizrZKMMq/ia2HYBhxtZtanZpeZQIqMpHncW22S7a2Ov3tZnHyE0JnoGSiz+gBOfYChudF/VrrKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gPoyKPPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H7cAdjC7; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gPoyKPPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H7cAdjC7"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0AC0118000B0;
	Tue, 27 Feb 2024 10:06:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046397; x=1709132797; bh=6T1Y6gnsBv
	insKQG4NYwBa0K4fuBqtL3WwO7sIA0WKA=; b=gPoyKPPxGV8/5m2tSS+SqaVCuY
	a9biL0Z8u9Yw4BcHeIVT2ttoXBu8uHFn6XAv3IVbORBzLMgUP8jiWWhPNsECm1Qg
	fUiCO3tVAhd5ZtMHTp2HZR7QTI7MKgN+I4LYDN5Nqa/90OKOila3Aq3ePyovO+De
	V5RmjTB/PTC38rG0ZcHDD27E60nvmERSLH+QnSagDzJ8EdI5O5a9+lr6H8Kkkir2
	0yJDIw4rPQcH87mptX3RehJXYzmKtsrSlgz0+xEou9e0gu/lOsIXHgjROQx68dfF
	DlL/4s3M5oWfLXFq9tfp760iLaaBe1qIpXwQLjwpwKBAjuwTa9KYha07EYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046397; x=1709132797; bh=6T1Y6gnsBvinsKQG4NYwBa0K4fuB
	qtL3WwO7sIA0WKA=; b=H7cAdjC7A8Uof2SUEqM5O6GbUj4CLm2c4GRqQse0WCE0
	ffcrckplHX/JcXfngoS1N0id1QPBMrfhsTU1wDGCc/s8m2R8SdaWYN1C4w0C+qTn
	lHoQ0ITdXgHQmzfbh0bZIsuLjMhOZjbCS+s9vJOOv74Iy35flX2oJOTuxTvsVaEo
	2Jx+gzUDQDjANEAmFoDUGoVu1hcOz3n+24mFG4xAEgt9jyGQ/UAeSsZaVfza/XUc
	BMKUw9zATuTCnAFltBbTzD63WMrqCWl+dY50wXNDrt5ItE/sii76MwnYhfJn863u
	YXLLe6rMZeeSBsmLS96nA21t7/ssg6PbPBXeM7QVqg==
X-ME-Sender: <xms:ffrdZQ6OBZGA13uYjv8gnYMdN0pytjhYdouv7mvmymEgLXD7EcZDSw>
    <xme:ffrdZR4s3B1QsQmpTQQE7mxQJqWBrXqUzzy8Yh_SlhflPTWNa9_aRBcRouo-gx6CN
    1UhAH6_Kr3adv6etg>
X-ME-Received: <xmr:ffrdZfcUai0pudDqLZ3UXv3N5srwXwjAnqS49TsbmmdleSFMz8zJmBLaZnihf2YLm8jm_mZ3-vP98axI_XjMmenOZX16cw_gVmSjsQl_kuiKgH94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ffrdZVJDmG87OIxc9fshHDWIhh1IezoI0a2zUYFqinAolq8dth58sA>
    <xmx:ffrdZUIaLLh-XNeZHEwXZzrZade3AViVP-2OZktwYojzzbpCjvThCw>
    <xmx:ffrdZWwWHfza_gldAf1bz9EMiI3EZYbCD8m9ED4ApPujjs808uwLSw>
    <xmx:ffrdZbVtU6hDeNbInIBnv4CxtKA3vVEvgf1hP1WmPDUlGYbte6gf7IaDfcM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e8f4b0ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:19 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/13] reftable/merged: remove unnecessary null check for
 subiters
Message-ID: <0adf34d08b781c384d878d7d5f651efcefa7d7ab.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1FdcAOBnXGqsW8iQ"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--1FdcAOBnXGqsW8iQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we advance a subiter we first call `iterator_is_null()`. This
is not needed though because we only ever advance subiters which have
entries in the priority queue, and we do not end entries to the priority
queue when the subiter has been exhausted.

Drop the check as well as the now-unused function. This results in a
surprisingly big speedup:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     138.1 ms =C2=B1   4.4 ms    [User: 135=
=2E1 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   133.4 ms =E2=80=A6 167.3 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     134.4 ms =C2=B1   4.2 ms    [User: 131=
=2E5 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):   130.0 ms =E2=80=A6 164.0 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.03 =C2=B1 0.05 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   |  5 -----
 reftable/iter.h   |  4 ----
 reftable/merged.c | 10 +---------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 8b5ebf6183..7aa30c4a51 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -16,11 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reader.h"
 #include "reftable-error.h"
=20
-int iterator_is_null(struct reftable_iterator *it)
-{
-	return !it->ops;
-}
-
 static void filtering_ref_iterator_close(void *iter_arg)
 {
 	struct filtering_ref_iterator *fri =3D iter_arg;
diff --git a/reftable/iter.h b/reftable/iter.h
index 47d67d84df..537431baba 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -16,10 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-iterator.h"
 #include "reftable-generic.h"
=20
-/* Returns true for a zeroed out iterator, such as the one returned from
- * iterator_destroy. */
-int iterator_is_null(struct reftable_iterator *it);
-
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
 	int double_check;
diff --git a/reftable/merged.c b/reftable/merged.c
index ae74234472..29ad09f3d8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -70,8 +70,7 @@ static void merged_iter_close(void *p)
 	reftable_free(mi->subiters);
 }
=20
-static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
-					       size_t idx)
+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 {
 	struct pq_entry e =3D {
 		.index =3D idx,
@@ -92,13 +91,6 @@ static int merged_iter_advance_nonnull_subiter(struct me=
rged_iter *mi,
 	return 0;
 }
=20
-static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
-{
-	if (iterator_is_null(&mi->subiters[idx].iter))
-		return 0;
-	return merged_iter_advance_nonnull_subiter(mi, idx);
-}
-
 static int merged_iter_next_entry(struct merged_iter *mi,
 				  struct reftable_record *rec)
 {
--=20
2.44.0


--1FdcAOBnXGqsW8iQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+nkACgkQVbJhu7ck
PpSR1A/9FfdtIxZTSEh8koP2m/VJcg/xpXfX1DjT87z3wDLa75hgf5eCEE3ryarS
9Sx2b6+5cU7dzFRJDUiKVZygQrf0wbUbVG6WpzNHnCLr0g6ylmyx6BnmEOQoBnr5
mM6VxhkLp8EBHzF1JyzGPeB3B3otYCk4OhZ4P05dwvR6Zj+NJsPEjQqIFS4jYR8B
BSNtBeky/KapnvpJbB/U7EQGtH99+DD/HLZpYbh/iVSCVhDafYdv8O3SibFMclkX
AhYfCAb4XHBCT6riG+111Pi5Suv+6mJurYZ0Yg7FFPsSvuUZhmElMVhLZ+X7bGjm
Y3YFG/U8AlMNs7+ky7AMo0au9RpZWBLyA3qIkOjYVlOR/gWnuOpe0KEvauRZl5Sx
8G+bt4uIR01lw0zHJzt6Iv9cYfhg1bPh0x/gMnp2oR8U4agL/KNpFmiasOKBoJIr
cXzDBsXLEfk8HbAPjBRkT901unSv5v9fLDDYgF5+7JwQt+oJzfJ/a12Y7GyIPy/+
5nsKY5H2pQDRHlh5CeaLlN0H3ZH7iy9CFynXab2/m9Zga1k5M6XzjD3FnHEbhbWx
HlGDvtJ9aenjTIXGwgwsVCgVemGQZ2yAa4LkYp6AkYk1SC3Ht5sLVBXd+ZRoel66
+P3OQOYTvL/9cfQoDvi0GuBnJaeoa4sy6TgnnSt9qVoj5dQDbho=
=f2y4
-----END PGP SIGNATURE-----

--1FdcAOBnXGqsW8iQ--
