Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66281BD508
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934798; cv=none; b=XiuuhDczY/HUYF/ER6TNXfa2OrywKo45ANm8HROWQOBZekPHJixOSV91qTiURR5dtsUFeiCRzgBfZg3RpdZacJvRgC1na/rjm7x+2Usqhdab3pPAxB4BrdvdRPY2MdrInEst2QurUFslVTeg41U7TybBj+7d3L5stA4MsgV9Ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934798; c=relaxed/simple;
	bh=PQ6HvMuClx2Wms+Z4AqCrqvyF7OwIPHYeMMP5EDPvMw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6TTiorN4+FqWiZfhlzEGWSk80iGhvI4fVDeifr6vb3CDhQTvgpevuc0dfAiCv/P8+62H0HikZs+frxH8qKRzfzD3uEP+5MX3f5uQojJ6I2BKNiqlT41QpRbRb8B4vQxBIcK+/dBHx2GdPxVv1cW+lvtoFRv+ZCcmPBBIbcVYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bGKd6UWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHOKFmkF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bGKd6UWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHOKFmkF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id CD0DE138FC93
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 04:59:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 06 Aug 2024 04:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934795; x=1723021195; bh=ap73Do47Aa
	9PhER5/lZPg7qzD5Kw8GgpmY26owWVa6Y=; b=bGKd6UWSYw+JhDJ+d4kdhqLFvn
	Cp0+u74bYY7fMPS14HJiTgivBSfkC+vyeYzWu0tlpcC7DnxS38356L4Oia37lxTL
	vBtQ/yw5ln7+ovfapy7/0S4R8y0mRerLHsMmFxDQRuOq/2oUlki6pY5GUgE9kK09
	RY/pmcHchK3331o+sRT1QYGmK4shsJ1cuFyQkZkqlL0MEcvDVrGInf0kBNQRLSaT
	MXWV5RpNVUfHzuNiYsPzldcKEbWS4sGbtq0FqKHzwhFMw5f/n/KF/Zzgofix1gXX
	CQEXApF6ay3CHP6TIes0M5VMf3gFS4uuYtAlqQfe5M6+N9KYb6w/mSYxqLbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934795; x=1723021195; bh=ap73Do47Aa9PhER5/lZPg7qzD5Kw
	8GgpmY26owWVa6Y=; b=nHOKFmkFXOfX1qE8Gn8d04oWaaqyoyaNw60JdOKwDunU
	rKS2nxl2Ef4RDVIQuCX+GJfmv20mbg6Ao96PiDKRJaMI8r6dEsRFXy0QpBZatZb/
	ObHxZXvg4WLo5kOqBZdwC6/cVQ87J7V+2okVlw3otZMIQGDYi1QqPAejJRocjk1S
	Wzo8rkDNM0mmRGqaI39gz/UseP7YylKkFsJjhYqChzeRWF73VdS/60OprkCR+q6r
	69OnopB/6mm19mX8AskInxZmj0IBnuaSlJDmVUXTSruXwDuZsiSayN4h6PxF/twD
	AixF3V5Kskg6JJX4n4VJalBhM5N4ltPc0ePFZ2jg7w==
X-ME-Sender: <xms:C-axZml8e6QKlbLmqXZVDkQf-w2qeI4YSnGk00icKTBsvPDIF4PRZQ>
    <xme:C-axZt1qHAHvo6TL6r4wcrbOOBSkLoswwbfGoRYCiEnk0GcegrEuHwnxdZoku8hq0
    cWnK91EmN65LHISwg>
X-ME-Received: <xmr:C-axZkpmOCJC-_oujvdDyz4l_bbHoN6dBTqqzXDL8d8Kd7yF0wT1NrAByo0dpIIwArpg9DbA0c4YR_crABoumLcHiU49CJ1RdmEeC2t9I4vl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:C-axZql1BfuNTxgxvRRBi43IupjAyoefTgN9KckLMrNIgoU8BSk2ng>
    <xmx:C-axZk2zGAtqBSO3WzZZ296qf4ev0Pu5ik1dkVm_cNU3ymeq3L6sHw>
    <xmx:C-axZhsifnxoeB0wSjwr-IeqmhzHbM0_SXHGXxu6P51v7kTLU8aBlw>
    <xmx:C-axZgVZ2qF68VAxX3JLMIzTQOJ20POttgr-0wl5K08B98D-LcG_ww>
    <xmx:C-axZh8tjNMj_GvHy1UxNUfMT3Yrnc4igzQ_qUyv2ghzGsZyJOuLoVcL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abb9a06c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:52 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/22] object-name: fix leaking symlink paths in object
 context
Message-ID: <a9caaaed55045324bf0cde266c1db1581b73a0e4.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/keMQ5dU6Lpyuchv"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--/keMQ5dU6Lpyuchv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The object context may be populated with symlink contents when reading a
symlink, but the associated strbuf doesn't ever get released when
releasing the object context, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c       | 1 +
 t/t1006-cat-file.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-name.c b/object-name.c
index 240a93e7ce..e39fa50e47 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1765,6 +1765,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const =
char *name)
 void object_context_release(struct object_context *ctx)
 {
 	free(ctx->path);
+	strbuf_release(&ctx->symlink_path);
 }
=20
 /*
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa..d36cd7c086 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git cat-file'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_cmdmode_usage () {
--=20
2.46.0.dirty


--/keMQ5dU6Lpyuchv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5gcACgkQVbJhu7ck
PpROjw//Zg8MZcx05lrMxwvK3v+uSmCJd7b6Vc9DDmViQDGnbbHnkLojBc406xsz
Vn7oJPbMvZ2O/RIbLRBjT3t5PBbOtwKJKKHUCMztAFD7Cl76qgVxc+DnqQwl8JR2
Mi0kEJc8QrN6HyoTKCAcIxA/fKEjGMn9l5frMZtpwGynNA7yTSowwVYqO+MpZK8W
xNFyfzD9OQE396Lk3MgOTXmNBWINuKkgaoM335y2laQQiWrlmIifs/ZrNKqJeOQE
mZTEFzGqZubBKL9V2idmmys5X7c7QFtnX4Qiju/SzWlDauKRkxwdGZrnLUMJODfO
XO1aXsPGYFiy+o0VNWlCdLyfi4JaoWWY59UdCfmPgyGwhJxd2jMUtovOa9ocy3RZ
kprzJVEi0iM2wNrG5gvE8e5x0RUb/KyD43SETenjS4uOOdxzyWKkPbKmTw1K6/nH
I0paUPjqu2LEkqpDkGS4RnqyvDyXl5pDHwbCTCWle4/T3WrhM2SRBqB3XP8KDEhF
SMdB0ExcZqwB/OIkjyY//YvJvCQ7KvzapjFjk7rsdZqgrrbC5+tBTVn+q2rxpOFO
gPevKe4Tqpk1wucmvUtmnhHlmsPTm5vXZZkVUSM/Z5YTdDs0QrIhqMbGdPDV0DQT
gEtOywQdj9df9hL5eIkwP2y/eo4jrtDMgeFFKPrFt2nTSluSS3M=
=xDzH
-----END PGP SIGNATURE-----

--/keMQ5dU6Lpyuchv--
