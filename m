Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0643AB7
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209695; cv=none; b=MPhupEG5nIVgJ3pGSxaw6XyCsu/v7/Lo0yk+CWfLMSmpxdGuU7G0CvYA/1pw0Foe1w+qDFijtkzqC2b3/K0rb4Rom82+QBGYW8kzzsXB2wFhlsDPyvepOIgEL2GlcsPsLmHmn4vXSg+4AUF7WZrpboYJP6f00fDiTXvCg+CrhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209695; c=relaxed/simple;
	bh=k7e5i0JT6/KWWUDfybaszt4H9xKevUfBEgnJVAeJ6rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTUHEt9/cABUAnV+w7srHzqCMhbXdnIL1lcVDguPUGMJNlUmdMt+RHnRBP3QB2lhgQlgG4Ddus0/2BsCJx8nUShfai5aw4O+3WzFbRuSUCffvy19ZPuMdUFFWgeHujVUr8lFktkn1w25JQ0XGRcDMYo92U6MKUgquYP/oBaxSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S95o2l9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rb+Ps2a1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S95o2l9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rb+Ps2a1"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B2321380128;
	Thu,  4 Apr 2024 01:48:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 04 Apr 2024 01:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209692; x=1712296092; bh=UbKzqy01O0
	4ASpFyt4CpmGkXBb+qA6qOZuH9X806jc0=; b=S95o2l9l6kRjcwjmDsxK0vk6MZ
	Yy/a4XIZMNErTtpSXFCEWQNQM4z8vQ+qdOnAh6Xv4Tj3m/tSX/r1KOOXadQCFTQp
	iy5Vqlasg9XJPYYsaPLoV4EjaSDJ7KMtcN191ezQWFguu02j2MPEmUT4j4KrVS8t
	ZRfPRbH7ESig08K7PvIi929wAgioUa4mBKiNoPoyZwvEHV8z6bw1ClSiql5RU0uz
	okHXGJBfxc/vp89zP/TLec1ForopNKzdNMlLNhYgqX0ORO4xgTdXwbXhUfEqmb3t
	IHY0ed8nSF2ZLc4WTcOsqM2an4h4fh7rpPSKDJx/ogSDY3hBezbKyquTB6WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209692; x=1712296092; bh=UbKzqy01O04ASpFyt4CpmGkXBb+q
	A6qOZuH9X806jc0=; b=rb+Ps2a1szGp6CJiVbkG83c3/zV4DKAorXiHj+kQGnqG
	0yZ+cg2TLSHNzLuflRDFFdHo63Ouui8LuOtxy35K2Opuip5BuEDqAxYGJmYqegWy
	vf65FNiw8d865o4Cm7E5iikj4TrreiMiwWUvGHIgVbzWSZVqSPSyyfl8OxOtuuse
	YyOSKWW55gShySPHZSkNXwZAGNdZ1p2OgDvEMNX25b6W1oaynQEGajREV2dlnx3e
	4fRwdYVGbg1HpDxr6I4oyunFOY7GrgD8ytAK8wsv1k5vdpL9XySjnJTIo1qqsxRY
	wM0jlgp0jU7LQeSuaz/MDYVE2cgJUaPT0g5XAGumYA==
X-ME-Sender: <xms:HD8OZokNpHbhIyezXeg9ro2WtNvj9KM9CcznM9DFncfSKbk_0bdRgQ>
    <xme:HD8OZn31RHhRMqWQXOPmrYtwKto1sl_YlIsK2D878JTkWMFsZeZXYdGnqYy-KX-8p
    CKJ3fCnH5FHtTcJ5A>
X-ME-Received: <xmr:HD8OZmosh9ZnvpepTwS-fT1VsxOb1_u4WxHjWnkQijDuQRoQuLxvqbS0GK3MHqNKgOCjxh_pehiTKsrG3u_W94CkY8k-42Uvb44S0yjQOZUDgbM2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HD8OZkmREOyKHEFNwOQmu7Fdvr6UpEgwJJ-8WYpPC0Nnh6d3Iidfog>
    <xmx:HD8OZm02Jd-UZAvZZhSKnHtvB4W3PIfUZLApuViw8hEXXTzjHh-1Fg>
    <xmx:HD8OZru2IKVRX0aDl2qbPouarYx_8xYI3_Lp8A864Mh8M5oq0Rd4aQ>
    <xmx:HD8OZiVhG8QtB2FBnelwADH2t8zqpwvoSKrK3foQZwJcY0AmpgP6WQ>
    <xmx:HD8OZpQPKKN-EZ8fSc-AaM94PJyvfv-SIqUtyvWwbGvkoMPZLVkFhS92>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b2bbcf38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:08 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 01/11] refs/reftable: fix D/F conflict error message on
 ref copy
Message-ID: <926e80239580b601cff752fa5f2086b2ff9298f6.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQWQCmy73Eiauqth"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--GQWQCmy73Eiauqth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `write_copy_table()` function is shared between the reftable
implementations for renaming and copying refs. The only difference
between those two cases is that the rename will also delete the old
reference, whereas copying won't.

This has resulted in a bug though where we don't properly verify refname
availability. When calling `refs_verify_refname_available()`, we always
add the old ref name to the list of refs to be skipped when computing
availability, which indicates that the name would be available even if
it already exists at the current point in time. This is only the right
thing to do for renames though, not for copies.

The consequence of this bug is quite harmless because the reftable
backend has its own checks for D/F conflicts further down in the call
stack, and thus we refuse the update regardless of the bug. But all the
user gets in this case is an uninformative message that copying the ref
has failed, without any further details.

Fix the bug and only add the old name to the skip-list in case we rename
the ref. Consequently, this error case will now be handled by
`refs_verify_refname_available()`, which knows to provide a proper error
message.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  3 ++-
 t/t0610-reftable-basics.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073..0358da14db 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1351,7 +1351,8 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	/*
 	 * Verify that the new refname is available.
 	 */
-	string_list_insert(&skip, arg->oldname);
+	if (arg->delete_old)
+		string_list_insert(&skip, arg->oldname);
 	ret =3D refs_verify_refname_available(&arg->refs->base, arg->newname,
 					    NULL, &skip, &errbuf);
 	if (ret < 0) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..055231a707 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -730,6 +730,39 @@ test_expect_success 'reflog: updates via HEAD update H=
EAD reflog' '
 	)
 '
=20
+test_expect_success 'branch: copying branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/branch${SQ} exists; cannot create ${SQ}refs/heads=
/branch/moved${SQ}
+		fatal: branch copy failed
+		EOF
+		test_must_fail git branch -c branch branch/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'branch: moving branch with D/F conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git branch branch &&
+		git branch conflict &&
+		cat >expect <<-EOF &&
+		error: ${SQ}refs/heads/conflict${SQ} exists; cannot create ${SQ}refs/hea=
ds/conflict/moved${SQ}
+		fatal: branch rename failed
+		EOF
+		test_must_fail git branch -m branch conflict/moved 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'worktree: adding worktree creates separate stack' '
 	test_when_finished "rm -rf repo worktree" &&
 	git init repo &&
--=20
2.44.GIT


--GQWQCmy73Eiauqth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPxgACgkQVbJhu7ck
PpTVYhAAjK3s3kzKvGmS3ShKCGxxaas/5fG+GYhDR/okSQ0I+/DmSlk3A8wcJ3MD
h/Tny6OexCEAePiXgVLZ6c28CTJpClmdZa04shZQMiVb4mPvk8zA6gEX5a5xeAM9
qjpIcTGfR/aLA+aSzwKrTslQxA7wl7jBEgZAmWT5nAxFNCVFjQ536f0Nu2J5kvwy
k3AVj3MX238bAODn6WMbsRo4LXJwWSf8q3aY2Px4Me7JxIn3kHxt8H0FcG4XDAQO
I8WDb+ZrGB2g4dSfLOEtrbziXrkszqMOMKPwgXGlD/NdNIrJTtq4aoF9j/U0P9Yy
yGSOuuxAZr3jzgeHkoV9YRV2F6Fa8r0uGZQVB6fU7ZDUaaPBkRvR6FlWeeiUcFbd
maFN2KHQm9Ontv0f1m9yUGOdLTEbi3UW474AAHOvvt6ToGB6HNjPNSRnXTuloF+d
KX/XOjZnT1L+im5KTIHWv4lDDJY8fQ0fOuMueYb17srtJRs4UjsbOHro05bGwj7e
QYeq3/8JmZxhhav1epJFq0EXkFPy1a5bjI254ahm7NBGN26bPeYlijxNOoF62z5Q
G0UYyZcv1r764ktNRxxKFW+S93WPUzx0x5l2srrSs9jXCh3tMOlJpoN6ZMg2EAv2
jJb0U/IxCu0xRepXa6KJizMY8efDxFafHOVVD9QW889PfcRpmEE=
=pN7v
-----END PGP SIGNATURE-----

--GQWQCmy73Eiauqth--
