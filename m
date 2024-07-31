Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F5611E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435297; cv=none; b=XBeOXfJzdpbXZGTNQEIiXw6ecWKU9s6esq209TPP4EGtFiryG0gVI7rMp6Vyjp/LA3yRPxCFf042HqwwV5josYEW7cpmzFkoLyDRWs9bzqKRVgkVCsjA5QFgBkG0SNlPbWxmtH5oBkkwFdRydM3Oa39+N8ezp8bvaCrrmJpjduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435297; c=relaxed/simple;
	bh=L1Vx+dlTPqhDzPAJTc95qIPi7w4KC8aM5oaa4wY1cq8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZocObSoxFWtq/ZWAlgbmxV96o3Ssh429c3jtS/42VdbG2WyY3tYujfwBhrXaVbpQ3ZnJ5ivap6OZtunvc6buoQ6BvXHy6u9IKjx3EfUKmw593SU05PTa++qMh9gAJ+lcg2gIz41WyDEYtALmLAurmz0Ao3TTKqzpOUFfvDjr+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p5UNCRUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSJYTKu+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p5UNCRUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSJYTKu+"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D9061381D30
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:14:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722435293; x=1722521693; bh=4ezKN75OnFUy9+gCaEmA/o0Zo6+gaBiw
	/DsQLl5+lcw=; b=p5UNCRUCFSItnSljaxuEnnRPujiuK4SE5hZlz9cDrqNNm+UX
	ZIyb2o3yXNTfRpJeiqr2YaT6H1NsdnvChiZJElABHbXyNlTkA5ef0YWLoeFvmTgS
	imr34TZYBEi6PxbobZOkxt7A+SqgqEhEEF0BDR5daVpOFheSAYmP/8xm+2L0Wai+
	bk5MuUkp4dkaNOOlZ0qeNZTEtUmi6u9AH6ZXr/tOYHh0jaEI6jKe24DfqIK3crgk
	ovc2G8tFsyiudCxMEs1ec7Df/XQhFqr6T1U9Lbzrp3WFEq0OKVrS4v5uHAqxJ2Sw
	1/tWzs6t12Ax/lreZE9Ps9Twf0zjQhxOjsvzig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722435293; x=1722521693; bh=4ezKN75OnFUy9+gCaEmA/o0Zo6+gaBiw/Ds
	QLl5+lcw=; b=lSJYTKu+CcWci6DwfGt/Hlf6WIOHpY2y55ch9H5iuEiANfT2eWj
	pUZRoq7nnov8iGyDOuuMoHCw7UyuhLXK/fnMVsM+RX0qQOuNbMZH6VLyXhPbXoeR
	WfIOClIkVcLQzLgOm/uRzwy30kYHfz7I/JtNrJf7LFPJ+3vyZqWtcRsvB2N3UtDU
	njRgxEbX9bxAFWZPT6+NyLfFd5RbxXFXO7+BfU+7RDaeMOBn9xj2SfWs+Kkw8Y9f
	5SiRUJbkDowCgaArbZCIlBz1RkiCDzVEU8/Ze7q6gCVexqiMKnu33timoXFdJud0
	5HndVrZpFyEGsa84KGDXQ9RQshmDri+a6ow==
X-ME-Sender: <xms:3UaqZpt2MT8k4BunU_SM-qeokvC63LMn4pYafv_3meE82kfFNiW7BQ>
    <xme:3UaqZifeeGGekHd59jV4Bm2Si8kxfAsOiz1uyiJpCMWqrnFMnv0FTIMFtCcdRVncb
    Zm2kn-TcheStXy1Mw>
X-ME-Received: <xmr:3UaqZsz4Ya36JAfquglpwXAJ1VMU7yiDnCKX6hi2C2G-FEKW3Bh1SZoWrTS-qZaXXXNgkB0JFUy58XndAcFjuo26liMgjbdoyq4GA-KWOfcFKlrN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:3UaqZgOjMWEviArX6cKcCyQGt7IWtlbQwqZ_Fiies12lRlS8g8gkfg>
    <xmx:3UaqZp_enhdOxXjXU26h5Whwq_qGgGtyI5P043xQWpPqgds1M236GQ>
    <xmx:3UaqZgVAImjPLUYAeuNUHCIYCuDyUdtTCOVPTt21cRR2RLWZ_cJneg>
    <xmx:3UaqZqdRU-n-WOpt4t_jjJz4PfrI0T0_wdH62-m1c9FCwDn2WbxPOQ>
    <xmx:3UaqZrnrauMDYIqGMIAPa1NhzWAfuPcrEIBm3HZ1HQL5MnhbaQ7Yrp7q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:14:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5171f91e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:20 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:14:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/8] reftable: improvements and fixes for compaction
Message-ID: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uqdsMD2zfetx6Da"
Content-Disposition: inline


--0uqdsMD2zfetx6Da
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series addresses a couple of issues with compaction of the
reftable stack. The original intent was to make compaction handle the
case gracefully where a subset of the tables it wants to compact has
been locked already. While working on that I found an issue where
compaction may race with a concurrent writer that modified the
"tables.list" file while compacting it.

In theory, this situation should work alright and has been accounted for
in the design: the compacting process locks "tables.list", then locks
all of the tables it wants to compact, unlocks "tables.list", compacts
the data and re-locks "tables.list" to update the stack. No concurrent
process would thus be able to compact the same tables, and thus we know
that the tables we have just compacted must still exist.

What the code didn't do though is to reload the stack before writing the
updated tables to "tables.list". This could either lead to us dropping
new tables appended to the stack while we were compacting, or it could
lead to us writing references to concurrently-compacted tables which
have been removed meanwhile, leading to data loss.

The fix itself is rather straight-forward. What I'm missing though is a
way to test for this given that the logic only triggers when racing with
another thread. I didn't have any idea how to do this, so if anybody
else has an idea: please, share it! Otherwise, I'm not sure I feel
comfortable with untested medium-complexity code. The alternative would
be to just bail out when we see that the stack has been compacted, which
is less ideal when we have just done a bunch of working compacting large
tables.

Thanks!

Patrick

Patrick Steinhardt (8):
  reftable/stack: refactor function to gather table sizes
  reftable/stack: test compaction with already-locked tables
  reftable/stack: update stats on failed full compaction
  reftable/stack: simplify tracking of table locks
  reftable/stack: do not die when fsyncing lock file files
  reftable/stack: use lock_file when adding table to "tables.list"
  reftable/stack: fix corruption on concurrent compaction
  reftable/stack: handle locked tables during auto-compaction

 reftable/stack.c           | 228 +++++++++++++++++++++++++++++--------
 reftable/stack_test.c      | 104 +++++++++++++++++
 t/t0610-reftable-basics.sh |  21 ++--
 3 files changed, 300 insertions(+), 53 deletions(-)


base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
--=20
2.46.0.dirty


--0uqdsMD2zfetx6Da
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRtcACgkQVbJhu7ck
PpTy9Q//YiP80yWS0fEiE5nrSt/jtDd353NDD3e9qYF9UPxLiDDAQAQeudNhD4VC
5tbBMSKOTL3u2WgsiQL6vMA72Q7nVL8PnQPzIgtfdmDMSJFtKmKjoVQZQudSXfcy
IiENpcGERWzbs/iLcr8ufHv3Ktv8jxyen1rbhhBoVaygVQnRl/20AecKE1JLwUNK
bB3oPTF+aS6csnkpQo4cubU5xEp6jn4qH8Fi34AMfhsFSnHuMI2gUxdtQVjPjERo
r+zQ7bqfg97MUgWZehtBx0K02iNMwU02JL6DtkKJvydRafltIfDu/4FET3CVbYHA
xeVni7e3+dxEBDDdnHSpPIT8NT5bFUvgLD4mRDQsMQeXtt57UO6J1oMnIw0oP6Xc
G0Ngzyc/SAN4nPpDQmqtsRa7sxV9yV/IOXnW/j5xrt5aK4hW2AkwxHrkKdkxbx3Q
iQljA8gw0P9876XVu1/XLs9/a4YM4YI046bMCgWqJFWWICqqdpO4ElpJLZ0jsGDN
TRknCIMLftMUm1KU8hAnpYnTjNd+XD7ZMepbl71nw/Qz0HBmYjlkDvCD+tSfSYEt
Px71hHILenc1jDMPc+/Zlj1wOMpuBBUg/MS1iuR7RC+79Lag+gD/AmzOdWQM/hku
B5FgP7XZR33qN6JNVcp7DaQEUlDMjoZ75GN46JZrM9RN6PxKlSs=
=48Oj
-----END PGP SIGNATURE-----

--0uqdsMD2zfetx6Da--
