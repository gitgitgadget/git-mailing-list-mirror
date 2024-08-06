Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33A1BDAA6
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934803; cv=none; b=V+jx8Yv1ihEM98bm5lybH8QYNi/3n47hp0LK+fagYMJqojUg6tP+KYThP+4yjbHmllhnmi7ktih3Qwr2aZyKAAz6wd9y9QS19paWWAR/EbJnnLwmVK54CIb8hEAVJHjNikkrlfAsCMf77MNzVWWtKNjXsS8EubylqBaI2e2kRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934803; c=relaxed/simple;
	bh=6Nxllw8uVJwfNbh9C1HphZG0xVARTyyuqQcmTBBG32Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=givShShcOls4jj5MXlkUDMXF7rZtc6JBPo5ZBmtxYqioBZTSamtBBg7AkrGlW8+k6MJwR/cxod2LurPANWxt14NFWiWKJxbT29Aa9tXy2JGCWN3WT6cV/lCSAeASlFHwJ4c0MikcOzMA1fzj4IAIiXDREdmt5oh/h/Dp1BMIwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fA0H5AR7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmAPzzIY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fA0H5AR7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmAPzzIY"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A482E1151B49
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 05:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934800; x=1723021200; bh=GP9fctTnqb
	qMwZt4BwhZv9MGju5UdPodsG1Nk5WaDdc=; b=fA0H5AR7yMU/U6wo3gZwfK3fdX
	+0S/9zK2eJqoZnRksCgpDRyLiQubFETxvCNEVSQsUjBgSTFY4sP7qvZT/UZVBfgS
	OKAHaQoXuNPyTfiIZ/bu8ANVMF211i8yXg4OYmYQlWY23awrc43UBAUXtKQhSAzC
	KPlfrCg1yrzF8zV+h0QexB/EU+po7028OgoVYN780HEy8kLI/25lORlzXbc+KaoC
	yLzbtmtmp7stBJyq3GpJye8vg5+t5IYAL13bzKsyCi3+hx8y8rTu81JGIE/NDrf+
	aC+RZfqFACbqmxu5BrP4wBXMUQQvtTN9mSEgMoYDJ2A00hZnRZY5iWmvzWIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934800; x=1723021200; bh=GP9fctTnqbqMwZt4BwhZv9MGju5U
	dPodsG1Nk5WaDdc=; b=QmAPzzIYqCh2AJxQCvKIqstRGzqXJaoJvvVJSWF/SekC
	QjifOfVRyrxHjxp+8XZ4q2+6VHOP7XLkxBag1oqWvwcFcos0bV/ubz9uUrpPLaJ0
	CmRSUTBcptQ5fKf3h5pbvrBUdoTYeuwUoTCVcz04ZFrAvxsjVdcdvATOwomwIJK+
	P87QsRKcY5EjstEDn4U+r2VsUxQVyF2g7+YoebeE8fGvoDz/CjNUNmrWnLVMEuTE
	wwO3PonnMuBBnhbu8Vv3TgAv9HcUiQQruNI+98a+/s2F8rVygjEzyMb7yKHveuDH
	I/xow9/ljnjQtJv1PoqV4wI6uzjmt7MvlwE0e4GbeQ==
X-ME-Sender: <xms:EOaxZga0VQzDcvvsc_-O6ULKBti1EoKVdmN9B_btzdP6KxL2JSeq9w>
    <xme:EOaxZrYmubEhHM8JupN3ij9CZr9fWVEScyk9yJqhwqlivODXZKH8k5yaf3SyqY7UH
    h7qZ-f8Uoq4YuKpZA>
X-ME-Received: <xmr:EOaxZq9XxX-VuDkaNcx8GjlPD05XcgPPjZHpIBGHnGjXoFhADR-xyx7Pr4WgNUcZlX-Ub51qSdTARD9KKMDRhqk4Rj9VROb1msiFuc7n7kGP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EOaxZqr7BJBxbfF6fm2VGqk8zVbbScnSuBf1rPBrPymcZh4NI9p20Q>
    <xmx:EOaxZrqnNXX304LznymQlvuuVjIGnl5zfuJTzw5UwtMvwHLAniXfXA>
    <xmx:EOaxZoQi6IipaDprtkyR6QqnUZ4JQ-U8mkkccKhCYc10iPv03A3JCw>
    <xmx:EOaxZrrbJpb3eh7R6sPH_8Z5kP0aWum0gU_BKY-i38WtAu96Exeh1Q>
    <xmx:EOaxZkAS3LkbyOCdW-fsIS4Mrjs5X6Kk7ZLEmDDdTncdU39roUDhwyrQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc667097 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:57 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/22] bulk-checkin: fix leaking state TODO
Message-ID: <794af6610395add19abb359be5245e95a57681d0.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7e0q6WLPVClgxyqB"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--7e0q6WLPVClgxyqB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When flushing a bulk-checking to disk we also reset the `struct
bulk_checkin_packfile` state. But while we free some of its members,
others aren't being free'd, leading to memory leaks:

  - The temporary packfile name is not getting freed.

  - The `struct hashfile` only gets freed in case we end up calling
    `finalize_hashfile()`. There are code paths though where that is not
    the case, namely when nothing has been written. For this, we need to
    make `free_hashfile()` public.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c   |  2 ++
 csum-file.c      |  2 +-
 csum-file.h      | 10 ++++++++++
 t/t1050-large.sh |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index da8673199b..9089c214fa 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -61,6 +61,7 @@ static void flush_bulk_checkin_packfile(struct bulk_check=
in_packfile *state)
=20
 	if (state->nr_written =3D=3D 0) {
 		close(state->f->fd);
+		free_hashfile(state->f);
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written =3D=3D 1) {
@@ -83,6 +84,7 @@ static void flush_bulk_checkin_packfile(struct bulk_check=
in_packfile *state)
 		free(state->written[i]);
=20
 clear_exit:
+	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
=20
diff --git a/csum-file.c b/csum-file.c
index 8abbf01325..7e0ece1305 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -56,7 +56,7 @@ void hashflush(struct hashfile *f)
 	}
 }
=20
-static void free_hashfile(struct hashfile *f)
+void free_hashfile(struct hashfile *f)
 {
 	free(f->buffer);
 	free(f->check_buffer);
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd2..ca553eba17 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -46,6 +46,16 @@ int hashfile_truncate(struct hashfile *, struct hashfile=
_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progre=
ss *tp);
+
+/*
+ * Free the hashfile without flushing its contents to disk. This only
+ * needs to be called when not calling `finalize_hashfile()`.
+ */
+void free_hashfile(struct hashfile *f);
+
+/*
+ * Finalize the hashfile by flushing data to disk and free'ing it.
+ */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_compo=
nent, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b024..ed638f6644 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,6 +3,7 @@
=20
 test_description=3D'adding and checking out large blobs'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'core.bigFileThreshold must be non-negative' '
--=20
2.46.0.dirty


--7e0q6WLPVClgxyqB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5gwACgkQVbJhu7ck
PpT6Xw/+N2Qt2nNxdLouB9TdtKJA6iK4GjTg3o0ENgOaM6jTrxMxn1OEZEZge6OG
u5RuZ9s9W2YXsdnebAl1D6L+vKj0nm82wmdeo0ZhzMnZAn3fRIuL9bDhuyOjcOtg
ei/JdCdh4+qwhW/B3R3tqfFO26PFHXJ/J3CcDaaTGatvLYBmA9ET2AdJ6GT36pIP
yXFT04GhOuWnu6MQVUXr3EDpwG7mXKFO/ffRwvCir4jpjUcBMSp8B5LzB24JIKeF
eENB/kgqnXT5uiYi2PfMU+OI/6k77yRgDuc/24BwguiK4uTYnUGUVe4IC9lefDnj
fuOXiAufxUFtTnYXaHuMwdW8qBPVgeXRPK7bR0oxjshg/nXSF9adsVxzXMBXZq3Q
WUkS/jBPnVZsRSORjeegWF+Hy+Wd3fn1vNjQq6kbPx+S1fvnO0j3aTVLoWTsdp16
NeiemwKa11hU68H3BXCfNaJ9zTmyB4FeNKQ1gOv/10yDrTaziqMVf4cBELcnU3NT
oQRxLo6N5Hhx1/n4TVjxyQ/81wu/byycsRLDGuWsOdQE09HhEoVfZFZsUd0vJGXA
L0cTySO7CIzg5CLga0msoDa2pHiCVbR+62NJlpQYULTSryeuMYRTcioH5Ua8WFij
hT9VVz7rKQsYmk5MPjrE/maIYYsvOgZ3oYPCT1tK+IdF2fnHAr0=
=7hBu
-----END PGP SIGNATURE-----

--7e0q6WLPVClgxyqB--
