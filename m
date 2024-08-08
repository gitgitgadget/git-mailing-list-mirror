Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129818A6B3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122294; cv=none; b=ESssQZ4KZ8A+PgRoWC8PQlnRvOBEZw0vTgi+hc2baqf40hPRcxBxz7EpGYHEoDYJhkX11Y9hVAOgDhC8whXoLEn4/p2ZG4x7hzWFYEH9YXqiW5cv5CGUc/iylgj5TcTvdMqvtWSHi5BCEGhz57aeYscjyd7J/MXF46HpR90HUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122294; c=relaxed/simple;
	bh=8I5e9Cxunt4osoT31+NxYD9EerZfoq/8ig6SWR4QFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZjEmBGzrIQRo0rQT2cE9fCNuYvdoOE6H/WZQm+RYU8pY87E/dsJj8fU2CTEqwzcxAYOlS3aAcXN6JqImRNiMfw4Xl/XxOkQNQpMpit2YhOH8foSso4TotraeKReSLIZytLCpiifT6r1adq6BY4dIArQ/ftsb9DxGzoOFECeXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLMl1hgJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cS8x4jZC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLMl1hgJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cS8x4jZC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 58EDE1151A9F;
	Thu,  8 Aug 2024 09:04:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 09:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122292; x=1723208692; bh=ah8PAqvoEe
	7xJ4BzJ9iftcfmGMWF5Y90yWAq+6wx1PA=; b=SLMl1hgJiKTW+pkY2ojW8Wp+M8
	kl1kXsVjicxmNFYadM4FoG/7xC+h8QGRkv8MpTqmMQZRlFDAegUT2Tm66h/04PSi
	G10d3vUR7S3hc8TfxHx4XiXxryTKwE7cdvZhJfRZStLPqmhMU2LiaaKQIK64OoHd
	mLFtrAGT7wdESQRmN/xmM89VbBHbgXSThDswPRYgX881d80DmLKDreMGJrop6hkv
	tC8wRm0RD7IrB++EiykwQcexXVv0/+/5U/TukDDqKY22BC6A4WpQBijDQm3lxN+1
	YSg+yGWaWfHlbkGi2kCihDkZFoQ6GXl4AYE4T0k+myIsyYtyZxzjthO1z1yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122292; x=1723208692; bh=ah8PAqvoEe7xJ4BzJ9iftcfmGMWF
	5Y90yWAq+6wx1PA=; b=cS8x4jZCQlfoptOelJ7VwS7zA13Z5B1RqjhG3OpWftEw
	XRpi6v8U5RFq9kM2+9/AAwmBCtM8mA2Wx7dZtI6+WoFPkA8xm0cgM3nI8lglTZw2
	4xKSDYIgTYsTvOqTflhGAGyjXA0U8B0Vc6QwlsADWaiVQK72cx8orqJjyekh+/7j
	WuMrI64qXdlPI5oQt0C31bJcX0iekJLrIPla3AiTysPfvBTrZ10JBRwz7xq4pobY
	5+cQbc1QYGf7lhfgvWsRgMFt2Ut0qOliCn1FNkSK+HPqmk9holKfVeJM1wMVBDFu
	s8VcWzhq4+1JxKDiEHmIHYO4vWmt4cf5v2QnX/ebZw==
X-ME-Sender: <xms:dMK0ZhOm1ZlHQjpaRpSaGzr1B7F9376MFIcZjPs95nB2plszpPvu5g>
    <xme:dMK0Zj_kpk5DvmyxIhurk8k-KTHfKYhukpOG6jVvj5Gz-5Q284H4LClrnofg7E157
    XvMRGJ7J4lQ3QgqAA>
X-ME-Received: <xmr:dMK0ZgQhlHGiBeq-mE4-mKrzIAACTdI6oWovAyVB6qXzWpSvKBxqcybxiON4zKTj6xFRX4L-lH94-Bds7oDPzYp590eC7gHRxXqFjEZJP_A6prMS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:dMK0ZtsST54t75hCTC3nDG2_Il-zW0lcOPztXTp_1n1EEAOPeKyJlg>
    <xmx:dMK0ZpeNw_rLYY8V_n5i_V1_J42x7Gs4mzxBihNE0ayRL3MQ569Elg>
    <xmx:dMK0Zp2Pk3B_NXObRHbc4v3hXMSmBkk4ald9Txge0HF3Yb8jQvgWTw>
    <xmx:dMK0Zl_FNH_psQgxYTnZ16RuArxEx0qyY2Clv8LEnPu7g3vDGgGkXw>
    <xmx:dMK0Zt5rkVMEXucOGQ0g42ogFAGdJcd5o0KwWTiAzNgU10lRpNmYNhSl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ecf1900 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:44 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 04/22] object-name: fix leaking symlink paths in object
 context
Message-ID: <9d3dc145e8a60ae446b890ae5b97f81bfd762f79.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdWcfGUTOWEIkl4S"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--xdWcfGUTOWEIkl4S
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
2.46.0.46.g406f326d27.dirty


--xdWcfGUTOWEIkl4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wnAACgkQVbJhu7ck
PpTGbg//fiS78hAdWO0Ko8IHJxGAk+Q+jOmnakYPEpyIQZQNteKjpbtSH5+X//I9
yZJlt+aif9ldo9bzR5eP1TnMn27jQEb93utlDbp3d+BOXyIrMilfj7M6m8qWl7Xl
tYM+Zgpcll9qqmtTrNRLU1t39n2O7Eo7Znza/THVYmBp91zNQCj9hxD8Tdn0Sp8U
qs9HeOx0PI0frP0/jWMFhh91oOpGBr68NIa70q7yiD4vZW4bhDEqbGgR1Fn6RW6v
LRAoUZ5s/3dv+XI8M8Jbj6ss9eev/AKm+fSXRZWuewUyHG71zb/sqms0462FPgGy
9QJncxtrt49eoUun4ZdyTZGy984lqn3z9OkhgVwVQa2FnSY909gH8Iq1K1DA/Bjd
rnW1HMmVmTmPcOqkw0LtTh145PysBl50HDx0DOIHB7rNHZf11YtLTdB1KAuTp6+D
0gVBjZ1aCe/Yzy4Zz1oWY6lqMy3xOne39OLDLdVZ21WOraYmYQfHPLv3ShbenrKe
E4t9p91UYtwTphVQb2QOeZfieUyE2T9tkoztcg2+su7+JA4INILcpxfC61U7vtPh
Pu8OGZub626XP+UkK2uPHQtBUTse35G2+8wpCZfUtHpFzkrVMtgeS8Kzt0d+Lh13
AIGdOmNo99dNaVDntcc51FYCtCBvsQ5apf2jvj/BR1SmqPVzyQc=
=pHqy
-----END PGP SIGNATURE-----

--xdWcfGUTOWEIkl4S--
