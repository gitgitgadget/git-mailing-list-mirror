Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BE156F3C
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863286; cv=none; b=kfHeWOGWZVmKEqe521gmOaDA/kCQSGiSQbqPJipwI4sZnwUHMle2JW/dCxXVAL+h+S/APoIC8s9GLsSTF9XbwPhqKi/DLlro20CuT06tB7cwaCoytoL+8ryVLfT0C0Bv5c22tjolmZD3Wl457it7Zqb0WNEPVi9QsaPWzGpcagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863286; c=relaxed/simple;
	bh=YGXAcgYW1ixv2L36cvBAl5m2FgjnqyH9QEmD9DDOrIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9VX1MJgOzFBg61Wa3RFcWbI8KgOWEwH6ClvKCbFScK2/ePTuAwkM3izkviFwBToxoyB2ZtU8YePtgIcrS2xeiXl/35EWBAiXCXl3Eb9G/wRMgOq3FJ5l3vlSUINtSO5/v+bWSH1FQ13fi5geKm7wFDacknRbqdajts9pO5b4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g0LNwkgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OrvaR4cH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g0LNwkgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OrvaR4cH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B8016138FCB2;
	Mon,  5 Aug 2024 09:08:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 09:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863284; x=1722949684; bh=F/rE/KEYJN
	LjiZ9FugfZ1pGBz5Ho78FYTx3z1OlUvBw=; b=g0LNwkgLLUabVZZ+Zgfgr0T1sa
	CcgyKHjRHJKXnrKXcf0soYRtBtCBa6szs2k7vYw12mLoMVBUEkwZ15PTqgD14NRS
	+NRWQOrILtWYopUDohMJJXrVTMQ7XvClGLVbVpu7r02MNMJjrsilbeR+Nzi2EJte
	oj2OlW4DIcDUseHetnqR8t/a4zncqpK1zOu14o14H7j2kVamOu8MBkR5bwrMTdHZ
	2Qyl2xIrTGyfF7JgzOibz8euXXUA2LFqgRQa6u6VrrZ0wiSAL8WhwOOMmRfizSe7
	xBR2v6RsHhPq8VdOjYTh+J+nOsKiqqkgknLg5h+3wKx3k4IeyzYC9EezTYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863284; x=1722949684; bh=F/rE/KEYJNLjiZ9FugfZ1pGBz5Ho
	78FYTx3z1OlUvBw=; b=OrvaR4cH6/HP/n30QSRLOdL+LSslC132kmXYe25CK7tg
	4LTztSjx+Ff0NV+s60tO8mt90oXRbpe7XucAYIJX7FJydGkpKXyoybockgaszodC
	AkHOrLGqJo6iUnS8vRgKLk6kb9UE5kupMjPWCIGLI0NmSSVkk/bi4F5G0omvIGN6
	+ANtxxXKW9hv9dV0SR8UTxFYMckm5hPlzcVULlLoUVDSRTnKOuThEkaY7DKK/v8w
	fQZo7NxhZTXnr5b4uUsmog51VRTuSQePyV0qB/kCzv6MvvKel8twVlY+eEuicznq
	vcVeyISo6uyibhoox3eVuJsa/rGeXktCFjrec6JgSg==
X-ME-Sender: <xms:tM6wZhXz88UJw9kRWXliOGpCLnmTqDKcvl25yp7fhfNe9ZCPRRzl_Q>
    <xme:tM6wZhl6lQosBCt09Io4XyMQwvI2k3CcvqVuVRYX5ipe9FYRGLU05QEHOJNg6MmgK
    eIHt_jvuibekiVt-w>
X-ME-Received: <xmr:tM6wZtbKwwE6NpXmW0VxmCMILghqPV2baHpYSsIkXGaxw1Mb3yz70yxFxSvkUN2OvCLHb753X9bklQ6iSWmiPS3QlH_dk9mW94YjadLot1B_44-aAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:tM6wZkUNxX5_XubmqkUdRpvLyjzn_jTOKgZJ3xFrl5AjVjkivu28lA>
    <xmx:tM6wZrloslE4hqLuqmti_8C_tMaUjTK1MkG2Z9KodrvNHRYdpat6pw>
    <xmx:tM6wZhdpf4ygHpHoyb06FS0tr2lsnnCnba7EP1W7TmlodHdr1BOoZA>
    <xmx:tM6wZlH6e5DACm2NB6AMe0lkY62nyRBH8KJm3VVKJhpUZzPVg4DYhw>
    <xmx:tM6wZpg6rZ1xp02x8h5vwnUVWh4cmr9DUlG19wN-c4EwQD_cSH0RaWK->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f108191 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:02 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] reftable/stack: update stats on failed full compaction
Message-ID: <1989dafcb468c3f6c84f802bee5016a8d22c4556.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y+ddDSEumKeTLESW"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--y+ddDSEumKeTLESW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When auto-compaction fails due to a locking error, we update the
statistics to indicate this failure. We're not doing the same when
performing a full compaction.

Fix this inconsistency by using `stack_compact_range_stats()`, which
handles the stat update for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 14 +++++++-------
 reftable/stack_test.c |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ba8234b486..e5959d2c76 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1205,13 +1205,6 @@ static int stack_compact_range(struct reftable_stack=
 *st,
 	return err;
 }
=20
-int reftable_stack_compact_all(struct reftable_stack *st,
-			       struct reftable_log_expiry_config *config)
-{
-	return stack_compact_range(st, 0, st->merged->stack_len ?
-			st->merged->stack_len - 1 : 0, config);
-}
-
 static int stack_compact_range_stats(struct reftable_stack *st,
 				     size_t first, size_t last,
 				     struct reftable_log_expiry_config *config)
@@ -1222,6 +1215,13 @@ static int stack_compact_range_stats(struct reftable=
_stack *st,
 	return err;
 }
=20
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	size_t last =3D st->merged->stack_len ? st->merged->stack_len - 1 : 0;
+	return stack_compact_range_stats(st, 0, last, config);
+}
+
 static int segment_size(struct segment *s)
 {
 	return s->end - s->start;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 46d376026b..2b1eb83934 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1001,8 +1001,7 @@ static void test_reftable_stack_compaction_with_locke=
d_tables(void)
 	 */
 	err =3D reftable_stack_compact_all(st, NULL);
 	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
-	/* TODO: this is wrong, we should get notified about the failure. */
-	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->stats.failures =3D=3D 1);
 	EXPECT(st->merged->stack_len =3D=3D 3);
=20
 	reftable_stack_destroy(st);
--=20
2.46.0.dirty


--y+ddDSEumKeTLESW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzrAACgkQVbJhu7ck
PpTcvRAAoDBXq0LzaQV7nrrdtb21J2WNCO7ODvjnT8izJPT6Q/nRoJbvFvO0ECAg
Hoqsb+QnLq8ogImCeq/Xo9h8FyCDxFehOFtKFwjsCqNTBMoUmQbnFENAcfwaVxd6
NoLVo20h+3378wM29oRP1jo1d7rvOPvAc2l0iqan4RRxacyTzcCW4lj+8cHK2GjL
VJD5nvRniwMlxZjSg7AluowTTZJdHCml+Ilt10BoEPoAhr7OAF45Z56FxuzpUmAt
oG3CfydEjN4O8oKlLCzPu+Bc+CLny6u3+QBtSCQYfSPlnWX4YRGsz4IuQTQrdmR6
LWkWfb6UICIUJMhmN3cur2twwiq1wC67d2+7GxKztqIWx+IZrEgvbFnTdylBkaVL
aFmpumaE2ow2hNacmDttDCS7jq4ZohI4mH5202ZYtHWCLOHlCSHcujlBElzq7/jk
LZDa2TN+GbI3CG19nyCwg6Vs9W1C/+5QGHqfLPI2ygj+dOu3tKV6LCBzxlsBp/h1
BPMLSooW/53grPMkgIW6GhvtC/evvRvzdpQatmW/q6BlgVrBJyMXjf7V+86+H95j
ncMg5bmLWaSETJiO95QKH3TJQUR6vZ9ZmHtFT3SdEiesvoH5dUEar05lpND7yVEi
7mMJ6PjPhmj7BJqPJyqYQiQE1Z7yndDKHejz7O3TphkkX9/xwto=
=s/gX
-----END PGP SIGNATURE-----

--y+ddDSEumKeTLESW--
