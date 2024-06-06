Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2617BD5
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651776; cv=none; b=KRjFPnhn/Qx9569+ASQo+I6hXr6YHbj2MKi7OiFBMZITC1MbkQV1slQjjAxzoo3GaWaVW/vfaAvq1JRFCSTdcsXMTJSeHB4WH0ssvnOiJFUF1J+NVaTTWF8XIBoazHCH6Nisw3K9Wd4+uoB6NEU+dBzgdz3C9EXIs8rgyz4tdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651776; c=relaxed/simple;
	bh=oV2/weQzu0bIrxiLBXZBdtTc6NO85mAyG01a0zRnO/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4zZIaYmKVPUJ3ZbVq95KS0jVUA7lNWPv6RAD9U8rpkcUElTok/FPTIZlLnukunYFg35s8nFgUJqkMjQBd2vEwsRaO9is6D5f7f2MY9+MA/4A3/0a87239xkthCWEBob8OvkQHWbXzZ1r+3iM17JY/TKvJYm1ykKLvK67SKgR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eNGt+PYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKoCI5dB; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eNGt+PYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKoCI5dB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 184991800199;
	Thu,  6 Jun 2024 01:29:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 01:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651773; x=1717738173; bh=NmXC40nQw3
	ibAZH4sTdQfldyCVWUHiXgzFDFfceOW4I=; b=eNGt+PYFDdhcQEsYcA0k1+UxHH
	siX5zColR0JNg+hTGXC3nmDgMJYGjww8ohR82ePw1UNleKvcsJdahXfHiH1oc7nC
	ROxBhIExyXp1CHWdyo15gePgqm9TbpdacBRR0pyKEtXDbeH86jtQs0PMFtnSNIYh
	P7Gg9yEOw14w3hp0D7QDVqwHvxkM52QKYgfE2H19dfzDHwv+QNhRThxoOiWaXhxH
	LK4Y5pi/V2f56WpFfY3UGUojAaQM8w/thFJk99jy6g0FJPK+mdUQDPQQxyh613zR
	FASixRbYkNPrE6Ww80Qwi1bXQbX3BleFpDls6zsIIifUYQrfv+Rhq06OfKJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651773; x=1717738173; bh=NmXC40nQw3ibAZH4sTdQfldyCVWU
	HiXgzFDFfceOW4I=; b=EKoCI5dB1EbZ0poJQIOZBYtMXn+kY6mVvpsMf+WtQ0FN
	Ssn2Zg8MgsRluUf4DSW8VAwDSHNlsiWDwvkZXfSN/joGrVeuaGLLVuFbv5cy/03q
	zAQ+b7t6tOfSfkQAalkMOfwILJ/YlckbcKSkPXjxhNBwzKMorJ/zFSV3CLe0Yb1E
	rXvXKibk8eo8+5gKLVkPlAuG9mXaVsRm8xP4YbQ+Zp3+xEkwUL2AGJumEfsf2J7B
	lPxKRNOUt8VOOdb/nhlue1ZatVJSk4sRgDWyHltNSM3N/lCdeiw/W76sG9jqufMB
	19xC0BQUYMkPPFlyaueRO6qLWa96i9wgF6oETaIE+w==
X-ME-Sender: <xms:PUlhZif8STmUptLcELO6q7h7vsyyXIiXkEGcoSKj8b13_5ueyc3XgQ>
    <xme:PUlhZsOC9WoEQRbAA8cxzTWwyg_Oh0eiAvKjg3Z2tCCWva4fnL1k402KOHqsQOiGI
    z8AXi8xA0tluwaEIQ>
X-ME-Received: <xmr:PUlhZjg3KLv04LuiUyVUVvHOjoNk22O2EBpbuXPZ83ng-AzFT8-JUTqgjWwO__yXWB71InUkGklFFxFAEFotKIwpRTA-Jyh1tduIv44INYPjWHby>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PUlhZv8-P47iQty-8UVCAWRggANaW4SRMLc5fB47Sbx5avwOxed-Rw>
    <xmx:PUlhZuuw3tRBYa7xAKeJDgeOt4Hs1IoANDGn0v2S8zwMiXupIrIrZQ>
    <xmx:PUlhZmESTxnXIQGYTRinNgzMRn371YiKp7QCo-0Pc_tqRYoXB1dHtw>
    <xmx:PUlhZtOKN1NcCg3T-QsuMUHOw2Fs7dUMyoSvw1H_Z4drZ605mONQJw>
    <xmx:PUlhZr9DIWa8ipGOQHVBIdg9lE948ppC292UfYUT-xcbQA-AlGo13kRd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 94414816 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:29:02 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 08/12] reftable: inline `merged_table_release()`
Message-ID: <0690d5eae983f53b1d4223e7a0c722b6b22e8bee.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SaZgWWxPnINl1lZM"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--SaZgWWxPnINl1lZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `merged_table_release()` releases a merged table, whereas
`reftable_merged_table_free()` releases a merged table and then also
free's its pointer. But all callsites of `merged_table_release()` are in
fact followed by `reftable_merged_table_free()`, which is redundant.

Inline `merged_table_release()` into `reftable_merged_table_free()` to
get rid of this redundance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 reftable/merged.h |  2 --
 reftable/stack.c  |  8 ++------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index f85a24c678..804fdc0de0 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -207,19 +207,11 @@ int reftable_new_merged_table(struct reftable_merged_=
table **dest,
 	return 0;
 }
=20
-/* clears the list of subtable, without affecting the readers themselves. =
*/
-void merged_table_release(struct reftable_merged_table *mt)
-{
-	FREE_AND_NULL(mt->stack);
-	mt->stack_len =3D 0;
-}
-
 void reftable_merged_table_free(struct reftable_merged_table *mt)
 {
-	if (!mt) {
+	if (!mt)
 		return;
-	}
-	merged_table_release(mt);
+	FREE_AND_NULL(mt->stack);
 	reftable_free(mt);
 }
=20
diff --git a/reftable/merged.h b/reftable/merged.h
index a2571dbc99..9db45c3196 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -24,6 +24,4 @@ struct reftable_merged_table {
 	uint64_t max;
 };
=20
-void merged_table_release(struct reftable_merged_table *mt);
-
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index a59ebe038d..984fd866d0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -261,10 +261,8 @@ static int reftable_stack_reload_once(struct reftable_=
stack *st, char **names,
=20
 	new_tables =3D NULL;
 	st->readers_len =3D new_readers_len;
-	if (st->merged) {
-		merged_table_release(st->merged);
+	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	}
 	if (st->readers) {
 		reftable_free(st->readers);
 	}
@@ -968,10 +966,8 @@ static int stack_write_compact(struct reftable_stack *=
st,
=20
 done:
 	reftable_iterator_destroy(&it);
-	if (mt) {
-		merged_table_release(mt);
+	if (mt)
 		reftable_merged_table_free(mt);
-	}
 	reftable_ref_record_release(&ref);
 	reftable_log_record_release(&log);
 	st->stats.entries_written +=3D entries;
--=20
2.45.2.409.g7b0defb391.dirty


--SaZgWWxPnINl1lZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSTkACgkQVbJhu7ck
PpSg/w/+KEfM4OHYNni8vZbinZAHLZVQLxf+eDlO3e1deQP1mLCWFGzylt0G1OOT
m2ZePbFRCpodCvhcNIxXovKhdvyKyJule177q/KyQs3J5vydRbpLOTrtL6rPbQ0X
CGy/IEAfLreBweKi2hrbvG7RNuZHBX+ra8UAb+No0zJy+exJh0FGZe+H99GIq66p
xqolGvGTjrmH+tkPNgY6JyeeK1sJUz+3axHL6QyevHz4b2YxqMchG6pDrAsnfCly
8mG0dmZ3v8vPWPjbdPQUO3PG/vcrn5QB6Qiq7dvZKQrppEx5iJw26DcPvedF9VXH
RBwGXqv5B2j9EpoP6AXNsTasW3O9kZjp+K0SCdJbCvp30k8h1lpLcdvoGe8KDL5F
/TWAkzX5BIgVD4dcIAkRbWN6DikoJIBcX5Baw990+4oxgG24PJSHoKRGuO3c4tlR
ZdxRI/cvUPjSk/Gn6GTqkOce6JTAY/paEkecAfdrAAgkr7Qu0KWG/Gq1NnViU2s9
X40eX1k3zxGI+x2EgbgATgwvmWy9RNspIlfQiPiznbVra18yaQahNEbleNx/nHsD
uHiZMWlUINa7eHDOlKQz1mBuP3c+KcFhAbIcRDqlNmFRINzk9lsjIg8p+/Vd/Kaa
Dx04XXXJSUGgOr8Pd/BWNUnt6t3mG7b25FmBu7V9hMXw487kyro=
=3dUH
-----END PGP SIGNATURE-----

--SaZgWWxPnINl1lZM--
