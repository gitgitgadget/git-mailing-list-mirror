Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A542576F
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521422; cv=none; b=BBJT8YczgqLrWFqlkyL1JbT09q9HfZV9MdqD01pKlUw+c0KbnA7AORTiR3KUqsL9RiO3bAlupoBbCM0wsKIiz8hiXlFkdTAGKbYPRAPxdpJcl0X2ffJkDftRfkwrHDm/ukcYSeZGdc1Qq8OMkssETZl5w3G58Ac+tNtC9U+ey84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521422; c=relaxed/simple;
	bh=2ZUyOz/5BvJin0o+BaNZ95XTafgtZ1IGUFlOMKlHm8M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejtVWkG+ropKAmOL0QVn1M4IEkkouxpNPmusShR75mWxsjuKaa3HCxORchyIH0mHCltUJdC+/YcSQ0rIPaqhjiPEAucxg/H+qGdy+cHc2riuET/HZQJzRNov6goa87RCdGHKKFPHjg3GFtBKYJbKas3IcNGrcmpVSbYAp+/AohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E81ZMglx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wCZ+wwIj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E81ZMglx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wCZ+wwIj"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07DE11380133
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Mar 2024 02:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521420; x=1711607820; bh=akpdQNFj6c
	YoX2KgB+AiDz4yrbOseyYVS1TiJeGw7+s=; b=E81ZMglxnJQhZjtgezDJZDxsno
	Kk67dCphkOw9a4A8QhLa3tXF4QKcev1MYDgJ8eLxyWbULI7lp0kNKQZXLjTP9/Uq
	Vx2MB4LcC8j275rd00vD1aqALzy21RTLtWMa+eOMJAlZ7WlVsKAUxQDi9/EsBeTC
	GQYBSPKJCzlEKDie0cRMNmkyiveB2ohbd/KMbfKR0vgxqyNjWG+BLvuk1mgcZ3Aj
	fhOGd+S3fGc4AYi15ua8VvKqx3BuUpiaHi9JqTWgcsgWULRD7DuK3aXhuJJ80/XW
	MPh3qI9lM2M/LsuyDpt1oOAeYOx/Kd2/ark+3XU1DqV36WzxI8d7aEg8h3og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521420; x=1711607820; bh=akpdQNFj6cYoX2KgB+AiDz4yrbOs
	eyYVS1TiJeGw7+s=; b=wCZ+wwIjlb2TkqxRYW3Ln6M5XDtXGxH5ANrk2J/KySOJ
	yKjVhLyCphcm4LoX2UB+0swiI3J2EHYWWpinfTltSaIWoAALYzTZblK9P4i3CRJt
	rUBBhTCu73w4P1NkiwgEosvMG/GGMjbOAyPaBUigegse1oZtm1iXNjxxC9BedQ2w
	5ne4aQZSLxCiPWClerN0m5dE4lrq4ehjcz+16+Da0abKOEnTGtgsMNWg5vPmTuwE
	7eyKTvmbgvcVzddeaSQ/1SzAvbmBXA/Wk5s88hKMEA2WrnAluacssq1WnH/A3jDe
	Z/pJzfNqx8kB8qYSQBdX/aAMpadfF7LmIex537iAFw==
X-ME-Sender: <xms:i74DZlchb6ZrxQm0k1MRRmVRnxEEBt7GDp513ZVdulYq0_bvNaMpag>
    <xme:i74DZjN4bysPxB8ESqiMN852fj8VRdnTVaPFoybPnO2eSU6sqOrGAEodvBwFuji_j
    YwGRrqQFZDaxzTOaA>
X-ME-Received: <xmr:i74DZuhX2KRDfwd3uHZiM3DqBI9NHJf1LrANAriSgeF9pNSZXEju78Vqg1VldrBvIeStaI1Fzifui88-m8RfQAbLi_oF9FTIwSwF4udrzJOQiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:i74DZu9J2w0eiL5KM2XxkTHYe2UQ32asO39ahVnnWN6On1Uu3Aa0sA>
    <xmx:i74DZhv5YpH1QG1nMRkn2UYgk69GSQIPAmyVQIO4wzYy4J0mtC7lmA>
    <xmx:i74DZtHuvGKTsfzYjWNfKYB6gcet9lSFwfrcaj_gRPt8IOIQGHL45A>
    <xmx:i74DZoMGS6KAienyfu0Q2DGUiIv9duVNJ-6QvQFG5q8qFCrbbLkqAw>
    <xmx:jL4DZq7uK7lPM_N8AQh4iejdOB2UyoY0NRG23ap-_mupoUaxdCCm-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:36:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b9815ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:36:45 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:36:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/9] reftable/block: rename `block_reader_start()`
Message-ID: <24b0dda29e2f48265b35a78a10c9902f2bf4fa77.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54GWcduEHkcsXYFF"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--54GWcduEHkcsXYFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_reader_start()` does not really apply to the block
reader, but to the block iterator. It's name is thus somewhat confusing.
Rename it to `block_iter_seek_start()` to clarify.

We will rename `block_reader_seek()` in similar spirit in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c      | 2 +-
 reftable/block.h      | 2 +-
 reftable/block_test.c | 2 +-
 reftable/iter.c       | 2 +-
 reftable/reader.c     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index e2a2cee58d..d5f32867bb 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -266,7 +266,7 @@ static uint32_t block_reader_restart_offset(struct bloc=
k_reader *br, int i)
 	return get_be24(br->restart_bytes + 3 * i);
 }
=20
-void block_reader_start(struct block_reader *br, struct block_iter *it)
+void block_iter_seek_start(struct block_iter *it, struct block_reader *br)
 {
 	it->br =3D br;
 	strbuf_reset(&it->last_key);
diff --git a/reftable/block.h b/reftable/block.h
index 47acc62c0a..44a9a8de7d 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -98,7 +98,7 @@ int block_reader_init(struct block_reader *br, struct ref=
table_block *bl,
 		      int hash_size);
=20
 /* Position `it` at start of the block */
-void block_reader_start(struct block_reader *br, struct block_iter *it);
+void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
=20
 /* Position `it` to the `want` key in the block */
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
diff --git a/reftable/block_test.c b/reftable/block_test.c
index e162c6e33f..a719be7c50 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -69,7 +69,7 @@ static void test_block_read_write(void)
=20
 	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
=20
-	block_reader_start(&br, &it);
+	block_iter_seek_start(&it, &br);
=20
 	while (1) {
 		int r =3D block_iter_next(&it, &rec);
diff --git a/reftable/iter.c b/reftable/iter.c
index 7aa30c4a51..aa9ac199b1 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -115,7 +115,7 @@ static int indexed_table_ref_iter_next_block(struct ind=
exed_table_ref_iter *it)
 		/* indexed block does not exist. */
 		return REFTABLE_FORMAT_ERROR;
 	}
-	block_reader_start(&it->block_reader, &it->cur);
+	block_iter_seek_start(&it->cur, &it->block_reader);
 	return 0;
 }
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index b113daab77..d7d47e8640 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -345,7 +345,7 @@ static int table_iter_next_block(struct table_iter *des=
t,
 		*brp =3D br;
=20
 		dest->is_finished =3D 0;
-		block_reader_start(brp, &dest->bi);
+		block_iter_seek_start(&dest->bi, brp);
 	}
 	return 0;
 }
@@ -429,7 +429,7 @@ static int reader_table_iter_at(struct reftable_reader =
*r,
 	ti->r =3D r;
 	ti->typ =3D block_reader_type(brp);
 	ti->block_off =3D off;
-	block_reader_start(brp, &ti->bi);
+	block_iter_seek_start(&ti->bi, brp);
 	return 0;
 }
=20
--=20
2.44.GIT


--54GWcduEHkcsXYFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvogACgkQVbJhu7ck
PpRA2A//bJxZbFfewSojK55XmMsv66p3UzLfaX4rk6YWNDdfV+bnAAouomUMXSHk
zfdmCYCgbnzm934/yeV76FDH0MjIsWRkVpxDhq032sBCXp31kvDDUaFyZLl0AiZ5
kI1kkTpQ6HcaNI3SJsfejzRfbCxqXV8gHpy6em/HbOYSH/2lWf7TN38t74XYjK5o
hvjrrYcvaoyqcj8E7VZ6jdhab6QBGCo9bWtyyJyo1kVaSmx8SZ5jXFpaQh3f8Las
N4+FXQv0yUJmGCbZvGB6u/ieaq5245T85pH/8bcbwkKJBWURaKQUTxnrl8HF2Wvq
QWGlp88kDEGVypGF/YYOrMMjjxDi4qvtNaZ+cFlA4AvCxgI9bXbNWC+qqEelMpIH
5V0HD4zrhHo8NwKH2qGECjs6JLFWw8IbZPbeYWkFqXoy5YIZYycIGHWtB2d4RGg3
X0me540Te0+/TJqN1OGTWc2wzjWgztTtzPAkrV/C2xx7BzMam6bTcnmWu9k3LGv1
NbM31kxkE4wMgGtqWKpsPY0BD8g+I0s9hvqVkal4+2U/P1yMrz4l6ZzVtmbvdx+i
kGLZRIAFKQ0Ud/NuAcYi9LX1gBsqzIeF7TOmz276O41iNLel91LgEl97qa4+4kFZ
dwxlewsgwK42I1YAx+XuoMnRWkZScTT39xjV1gOM8LQM040njTs=
=9F+D
-----END PGP SIGNATURE-----

--54GWcduEHkcsXYFF--
