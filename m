Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1C18CBF3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122341; cv=none; b=m8cPWlByQ/8o8ZN331nNg65wBFmfl5kxpWp3/VYpqvJUzDkmLx0pDcbHiluZ0/GKq8BLmsEelpli7r+dXXb2GEkm5uBBXiE3F6/5+bPRE+UUX2ZEhTL7rzOiHwdwmtDjv1FG/vVddKpibMR4iPQE0NFXY5skGL2eHyf2RxeBqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122341; c=relaxed/simple;
	bh=1upg5b7TYizz4CP82niP3afnP84tLsj+sGwONfes0OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPCszrn69owhB1BH6kSV+AhWWM6g0SxjLAYSyLGWN1JUtp/bG0+SsDRQUKiIRNJwlKYFVNHR8m+4sImO1BWu3d32bi3OgS5LC31efbNrrTUFlIbhzeLTe3uSiH9FnWlAWndQAfrPqHpx2jydgsy5MT1qznsHnyPTuizzubPrjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kzyyvYGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oagQ9Ajj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kzyyvYGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oagQ9Ajj"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EEDEC1151AB8;
	Thu,  8 Aug 2024 09:05:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122338; x=1723208738; bh=v5Pcsxqp0R
	aj1P1JX80A+jFJ2jULQksSHp0lT0ll+vQ=; b=kzyyvYGQ/Qc7f4roIrST4RbAWL
	ZrHf+YOFVwRXWAvDsCwah8kLbBd1JHN2vyBlTSZGINlcWtzMT5qqaa+tdKCUOD4C
	JUT36NE4ZOcq8mYIo4b9ewxMrGlPy1milQLpD8eMwVvP1tOpyj4QipnI3flBf8GE
	Dh5Lsfcq8GrVk4h2MWoiGUN6lBuvob+eMFtlrdI04HyHFv5mIW5exMMynfqAxUK0
	ERCG+ZorCc1piBfTvSFcXJAiqcEfjVoBKdW73CVEwCaKzRcrAfk4tzRIeXm+1GQh
	rrdNMYCPd1CTk6YlYUbWo4/2QhYjdqgziOjkoq8aBRFYFBwOQhlprMAaW8vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122338; x=1723208738; bh=v5Pcsxqp0Raj1P1JX80A+jFJ2jUL
	QksSHp0lT0ll+vQ=; b=oagQ9Ajj3JvbwFB72kbawXYzz5bt4SG+6jOjSQEUvMNa
	F5gJgvjoA23grFSm7rtaClpDlgWW7dOgS/xXRU+IC9Wy8uxzOFeFJA/gcwW3R5bk
	ojeV6u3XrmoHMnbSx8jHSC/jKXDEV7su+Lkw9KLn3bw51Y/Fa6icEz9nlbcQbq5w
	x/3N3KR59PllUI+78KRTGEMzsj6BUB69EsJ7cBwwJh/shLTiO0UsVouqFvnIBR2H
	4q4J7wuziFgxm5m/Rd4/AaR+GD/JCoIxsoqtHltrDUhsdUiEmk/akPb2dWRRovWL
	o44ZxTLG9mBK86Rkk7rapm6mcgJmpSbocpdWo7RI+A==
X-ME-Sender: <xms:osK0ZlJguvTAVrqsBacJvuWBw6VGECcybpjadIgEnDY_p5n8y5hL_g>
    <xme:osK0ZhLLctUR_e8B_C1kAlxoJcV9O3LqiAReAWyDUNm0UhEs_6gRSgY-xVU9vM0hd
    jodYX8rGt4HYYvVvg>
X-ME-Received: <xmr:osK0Ztv6SszDDiaM1IplkuHGx0uyruDAnHLDsp71LMZjIU283epp98_y3O6rihtCn6-554gIauNmBV-fUYdlgcs3wwjp0Jr8O9c6HRnuCIUh4o-b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:osK0Zmb9FMrHsg6J41kIHIFXyrUE4dxL2hOPGt_t7aHHW0iMEDgKRQ>
    <xmx:osK0ZsZM5TA10pijB6Z3XI7v2zjFOBcAlrZOjjSBnLVXrubvUVtKuQ>
    <xmx:osK0ZqAwCtBmntrTfo6Fk-SquSjKmBNdducfFJO9Trt9hNeCAKG_fg>
    <xmx:osK0ZqYFJMLt9c9VKaVzer_YOFeDEBpU01T_4x7TYKILBoTc6ub8Cg>
    <xmx:osK0ZkEKTHJrarudiAnOli2rfz78Xfzx9yO7bJD-Yxg8PSKO2SjlhRTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d1bf9db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:30 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 14/22] merge-ort: unconditionally release attributes index
Message-ID: <8f6860485e8f806477964575928d31dba8373f66.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdjdWeMygQ4XX1Vk"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--rdjdWeMygQ4XX1Vk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We conditionally release the index used for reading gitattributes in
merge-ort based on whether or the index has been populated. This check
uses `cache_nr` as a condition. This isn't sufficient though, as the
variable may be zero even when some other parts of the index have been
populated. This leads to memory leaks when sparse checkouts are in use,
as we may not end up releasing the sparse checkout patterns.

Fix this issue by unconditionally releasing the index.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-ort.c                       | 3 +--
 t/t3507-cherry-pick-conflict.sh   | 1 +
 t/t6421-merge-partial-clone.sh    | 1 +
 t/t6428-merge-conflicts-sparse.sh | 1 +
 t/t7817-grep-sparse-checkout.sh   | 1 +
 5 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e9d01ac7f7..3752c7e595 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -689,8 +689,7 @@ static void clear_or_reinit_internal_opts(struct merge_=
options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
=20
-	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
-		discard_index(&opti->attr_index);
+	discard_index(&opti->attr_index);
=20
 	/* Free memory used by various renames maps */
 	for (i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; ++i) {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict=
=2Esh
index f3947b400a..10e9c91dbb 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
 TEST_CREATE_REPO_NO_TEMPLATE=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 pristine_detach () {
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e75..020375c805 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -26,6 +26,7 @@ test_description=3D"limiting blob downloads when merging =
with partial clones"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sp=
arse.sh
index 9919c3fa7c..8a79bc2e92 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -22,6 +22,7 @@ test_description=3D"merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout=
=2Esh
index eb59564565..0ba7817fb7 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -33,6 +33,7 @@ should leave the following structure in the working tree:
 But note that sub2 should have the SKIP_WORKTREE bit set.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.46.g406f326d27.dirty


--rdjdWeMygQ4XX1Vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wp4ACgkQVbJhu7ck
PpSpZRAAg4KS9geMm12tCQ9ivgwqOnz+xbNmW9awUn3b7SizBXluFIBN5XmjdViQ
l9rw35jtiSxy8h2rwuLC3fYHk9kFPmJE3HL8oLjo8ieRW3U8rEnSzPsRu+WCWxCs
A7JMGSI8pWjmF0w6ZKw3m44MvVD5nCV/yKsd4jb3rJgfzqT21dBOjin6XsEiP0i7
s4jQQcxdSy/cqD4pIRYVNZu4VznPhDIS1h9sYlcgE3DAN9V4n9HR81LWpfYEM0ZQ
m9ohICeX45h0QwPEWzR/f8u6d6d0decomg1f8J0F3pDb2YBTQPeon16ftlzCl8eK
gSUDRDBgAIm4diNwH+aDrc5diUlZ3VJHMovLAWKL11YM9DX+O93MF2CBMajC9fTb
awkIsDCVTQQJOWiVSZjJEf9UXKdHk0Xvr3ksG3mrYkY5RAmvpePORqnDPxBgZJoL
mdfK4aVTOh2v2Bf6ivP2s568Djt6iZbKqFAye/AaoC9dVW0v4+pjWZNdJF/RMi0A
zsam/XalCXYFOwmH0AXYk3qqOqyMqNtKcwgv6zNY5ou85+ME1/W5CZoiu4j/SrOb
gfF1iMOIEq9iaCWwzuUlRlDbmakAOJzKdO8psXCtfngd4dGAs5e6qUFA5j8ZkMzt
SEBj5m7mLpMVnJUVU+mzLvHTpb31FwZ4jhRTyZD0sLLVN3dBex8=
=UX/H
-----END PGP SIGNATURE-----

--rdjdWeMygQ4XX1Vk--
