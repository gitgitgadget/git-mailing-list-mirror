Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF8125A1
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896751; cv=none; b=d/a4FVWq+PPr4GVe0z8FFZkhysRGlpomKlXayCP/sCoNYgN5o87VuSTh7rEFuuZRIg6/FwdLbC9lV16GC+6bts0Euds1JMEN2VgXSYByLxVwXiRKm9m66nrFbTCUZux23+qcxCZ+GZ+4vupHx6cXdyt2TsKzXnbO9t3/49TvfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896751; c=relaxed/simple;
	bh=Ohb9lbSQnxDqK54O0+tczJBYlwBPpKv2cMqGpDePDmM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4leR2/EwayDIg3SDbv8fop8Wp4TnFJlqqW64Iw88PQoJBSAr0T1qgYGwl7yt2mNXcs0dx8/TpfcPMo+9ZlNXy/LFLNww0plSAQcigq2q3lmMEeaIftKT/OAwnp4VyGy2ZCO2QeShsQIJoIlJzcZab76uuh3G9do2Ev781RaWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X/XJ4JJ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzUWeL6z; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X/XJ4JJ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzUWeL6z"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1C7B232002D8
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 02:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896748; x=1707983148; bh=TBy9wXlLQc
	MBXmYfYPhKBB5IdG2xQSK9OT9MXeTw59M=; b=X/XJ4JJ1DX2OVdgQTVwoLK9s/J
	jtJ30vJEeoIuVqY0dJ8hUtLnot32cs5U6x/t22Q+4O78TTyQ164vK4hm/+v0nk5E
	8qtST2IHDNvAoNBEgmvOtOC1zF4b27XhqctQcTqkh5D/yaabdBv4bPOK4VU65xxg
	UDh3Bwt2Itr6tqV+JC1vm0KpSvh3w5EmlZStokyJlJWoHKzoQlYLs7kyuptOiR6b
	3GwKSqvfKUjv3VqCyy3G8hPSzhe3KgjT8DiMgRnmooSfKRuRwEEHmHz3qNaLs22e
	Q9d8dQUjXmzv3+c0YlF4k8j64SA78GLJNBPF7rMobdnZcUt7Dbd7MxZRn00A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896748; x=1707983148; bh=TBy9wXlLQcMBXmYfYPhKBB5IdG2x
	QSK9OT9MXeTw59M=; b=XzUWeL6zl9SQ6YGYkXGRlcBeC2waFkW4Br3eFw7iw16m
	Tm1PIIo+jHnB2B7Rkq+yrWiakaFnTcfLtuBlKX5qZkPn5+vQpznrJo9eCLWVqPbk
	v+r7Fov26h5TY44tjOz6UlUc0AWJZiKHPkKOGh4JcMjgkhz2mvUgcElEweX+ouOh
	M3QAJjOGxnqcbGAEy1ZQmt3T+ckG2z4H7GzKM4saqI5bQwhr+7NINZnWjA34iwMR
	VdPByCWG+W2Q6pCYB5x+GLu+Kok0jy6g9HmVbv09hABvo94kx+ss2hScLyv6LBF2
	FrrPxe+STk/p5ljzT1CGODnp3Luv1BX3Jm7rCCxuAg==
X-ME-Sender: <xms:rG_MZU9NkzQkP9nYaUM0JbCMAGgkwZCv-AjL7XEs3WuhRVMMgQzSxw>
    <xme:rG_MZcsA98j-phIcwe12jE1QKb2o4N9S50FglhxwIXEV9Dv5N5Kg1VYF3YsmHAFUb
    P-uyx1bE1kLk7mVQQ>
X-ME-Received: <xmr:rG_MZaAQZjheCPSDqoo4EQ3Mgop_DxCA70vx6EtMxQdbLcGkwwCwIZU8vx4z2cnSWrT-vfQ2uyBBMtEZF5JHcJ5ik1J8B3xxO-DPfyQK-eODEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rG_MZUdAyA5YdrzKj9Kw3Vb6PbNWuHAMSzj1h4436-BolCBcycC3pA>
    <xmx:rG_MZZPsukQaiuSf64v3EWbTfQj3W5ny0KXYcDTfAXGxvkedqb3D0g>
    <xmx:rG_MZelojUYsNfdC1awVAxzurpq2pK8e_vOfxkBS5ZPwL1Flu0oupA>
    <xmx:rG_MZbWh6JhWr-YWm-6y2IFwhqmCy_-SmfjzI2gpKjpgkrFyNpjk9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf0a18e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:41:57 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/12] reftable/merged: make `merged_iter` structure private
Message-ID: <be807e7650e2b11e5d6f7dd84ca1c549408f678a.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CVVub9XW6bQ2THTj"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--CVVub9XW6bQ2THTj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `merged_iter` structure is not used anywhere outside of "merged.c",
but is declared in its header. Move it into the code file so that it is
clear that its implementation details are never exposed to anything.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 9 +++++++++
 reftable/merged.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 1aa6cd31b7..12ebd732e8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -17,6 +17,15 @@ license that can be found in the LICENSE file or at
 #include "reftable-error.h"
 #include "system.h"
=20
+struct merged_iter {
+	struct reftable_iterator *stack;
+	uint32_t hash_id;
+	size_t stack_len;
+	uint8_t typ;
+	int suppress_deletions;
+	struct merged_iter_pqueue pq;
+};
+
 static int merged_iter_init(struct merged_iter *mi)
 {
 	for (size_t i =3D 0; i < mi->stack_len; i++) {
diff --git a/reftable/merged.h b/reftable/merged.h
index 7d9f95d27e..288ad66656 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -24,15 +24,6 @@ struct reftable_merged_table {
 	uint64_t max;
 };
=20
-struct merged_iter {
-	struct reftable_iterator *stack;
-	uint32_t hash_id;
-	size_t stack_len;
-	uint8_t typ;
-	int suppress_deletions;
-	struct merged_iter_pqueue pq;
-};
-
 void merged_table_release(struct reftable_merged_table *mt);
=20
 #endif
--=20
2.43.GIT


--CVVub9XW6bQ2THTj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb6kACgkQVbJhu7ck
PpThuRAAkNrGqKp+3I4h6L/UFtzgZ5J4vS1B8wtNNGRDtLl84V9Jtd5O+T4w11Tw
W1+eliTx0TI/5blMaqRhBf0Mf/98zan8h/y5wCfXzjzdGN1CafBAa//JoqjzQnoV
yUDUaXPZHILT43QQm22WKYkNPsDyRzHAFlI/iMR3obLtBOXxQ+lrNww2CVPBk0Qx
G2jA8lRf3aLGMZVkjGAbbLDPctpuAgR5RdOl9H7KhI7Bhsv9+TDFeCNDaZ4Nq3tq
j6/wZq/3O7JvqWxAenya+O/J6iyQO/ti0k4DdEJSpQCB35LIqYb1AFBCGj1wN9I2
gPU4BAtFpxve6IyNjfo/CrVvLfkGd5qml0iVumz5ocrE7EfgtRbThlGsRW4TUKk2
M16OBGlEh6RsxC1/5ivj8XAnPDyFUUKk4wA0/TmQwFUZ64vRxgKtEQT3bwcaM/45
5/X/DFcUwvHogn9+KDvNBJX/48nNr/WZ6RrCunLsCUMDgTJDF02YW1Z5EZM1A1MR
l0iKlQbqk+b66eDupUoqLhSK+Iclk21XYwTSyMO/fG71jeJoUfs/40x8NAbNrYOj
uQ52mmu22a/8oqv30V96iwW+aIN34lPhuuI10On/MVOu7BQxrzr1o3nNlL/ackfC
ADHorY68pWdCxGLMAAL/l1iqFwWHSW/EhW73ESowNUoweeukQ+o=
=Upse
-----END PGP SIGNATURE-----

--CVVub9XW6bQ2THTj--
