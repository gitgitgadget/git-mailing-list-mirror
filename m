Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A6187655
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360997; cv=none; b=LEyLB7WA2AXMyYfze3a3Jlj/7mk/OPGOXAIrGAHOBRVHIUtVyw/fN5WqDcglLCrws1IxkFFjuCotAS8LqDPnw1t68EyaGJrRRenKro3Ruq/Zr32v/h0pyOj2bEVJAwBD6bvHWE2MfMKhNqZggF4v/0j5ptQMHRRynEDRWmltXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360997; c=relaxed/simple;
	bh=EyB1g/RyLPvRfz3pJrLyb/TQiChG/MvdswabBjBjk9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfM86O6zBsv3HgNaKAkCg14lWEmB5y9F6+FlmBaNtdbUZRjjt49Y/wAfEafsH8n4oB0bG1T/SI1hjLtAKAPCdIxcKy35orV2FS6MdBvUsq052tHuNHwvm6J7bMh+TZX6rXvvVbXaxDCZ7pItFEMokJpQl9Ed3iA9XmrAvHTzdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aS7HZGta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qUgBIqST; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aS7HZGta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qUgBIqST"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9F4501380083;
	Mon, 25 Mar 2024 06:03:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360994; x=1711447394; bh=WSxWqR9iW/
	y2ufdK6Jjuh5lyTEAWhg4uBQT6I4Ex9Ts=; b=aS7HZGtaFVwOwSLp+mQk3A6rjm
	g+8GUbGZ6kdXRMr/99kPZIZYc81aUAYIe+TFZqr01t3D/fa8bk1igkSWHg5ecsaZ
	c11GGEVpQFZpl5JFoT6a6wwhR9V9Qdj54iKrjQRR1bsqt52Vje7lesgUteSHQORV
	Fmo9jXVKgdUDtnXpAO0/V4mt0BBQfYeLIT9mPNmZJzXf/4GuAzqktOEip+66cyZ3
	t5HBMDD1u9vsNdNJI43B8bv2qvwSXvziewFPv9LDZ4wM7fsbr7v50zBBJvXUUKSm
	K1g4e5RGg++nbdqOnJXauaxEU50UObiFEvCNPjaYs3hUI6uCVDZvd+JEKyjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360994; x=1711447394; bh=WSxWqR9iW/y2ufdK6Jjuh5lyTEAW
	hg4uBQT6I4Ex9Ts=; b=qUgBIqSTbThleFpmeWLHL0xjf/3iJbnfjYGEpeoHHXV+
	zSBJihyRb/bmAETm9n/jWohh78rQ57KFlGHdqx+kHPCilpLuJfHIQrkmsx9GRHBG
	KwQjtAFBdrcBsI3ihLKEIDMqW5dckxgN0CBBCsNdsAwHZyNhmMZBWOaX4zV/ob6h
	SEvtjcoIl588egIeXp1Tp4+a+BxumnqeHrkTzw4xKwig3KqmwxX+uKfbC5aMwrF+
	jIfmFGj2gwEPBX+9cy4kgXl8MXCNS2AeGYSbC/0g12yCHW/QARN3Efj5Bv3dSzTB
	CDePeiPi5isOeXz3FpqXF+yoa2TTsATpA3Mpy6g4mg==
X-ME-Sender: <xms:4ksBZiWn2c2Mr3TyeuvqgDyd4bYJbkVDy6gFvCxWieSiPDuj6aDdUg>
    <xme:4ksBZumE6aUjYxzvOTVVMN9rWHWr1IkrtS5KdBbTDS3p_aBe3YEPANTTTF3cLvBYB
    d5Tjvynen0BAv4DJw>
X-ME-Received: <xmr:4ksBZmZFA_4FvhXJSuyJ7WgacUBRKrQiDkLab73OXdv7ud44UU6ACqPdeCNs0lsMg1SSrlHA1Glej1ix9-840q5f5aOC7E-9Jf9u4-aIgfwx9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4ksBZpWcqcoGY4ZF-eHxb47l2r2LMfETe9bq_OZphDSNMvvqvsHKyw>
    <xmx:4ksBZslNhXhnd7MCV-U1ehDiW5Obht88WS6BXf76ZJHav0oZSzFSCg>
    <xmx:4ksBZudQ15iyUZ7KjO1_sykt8aBIvKK9HeqF203aKWEv55rlMirI8g>
    <xmx:4ksBZuGN7t8pveNLfdEX-wXxttqnLPoM4tjTNAnoJS4a9snDEs0a0A>
    <xmx:4ksBZtCXVZ0OjhP_IRvCDlUoQLkZ2t6aZSUD_r2HyLo28CvKB1YBIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cdce92e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:03 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/15] refs/reftable: expose auto compaction via new flag
Message-ID: <5d7af236d4a7fd9d133f400a3b814b03d772aacc.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8i6R/ERhgUIXW/Pv"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--8i6R/ERhgUIXW/Pv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Under normal circumstances, the "reftable" backend will automatically
perform compaction after appending to the stack. It is thus not
necessary and may even be considered wasteful to run git-pack-refs(1) in
"reftable"-backed repositories as it will cause the backend to compact
all tables into a single one. We do exactly that though when running
`git maintenance run --auto` or `git gc --auto`, which gets spawned by
Git after running some specific commands.

The `--auto` mode is typically only executing optimizations as needed.
To do so, we already use several heuristics for the various different
data structures in Git to determine whether to optimize them or not.
We do not use any heuristics for refs though and instead always optimize
them.

Introduce a new `PACK_REFS_AUTO` flag that can be passed to the backend.
When not handled by the backend we will continue to behave the exact
same as we do right now, that is we optimize refs unconditionally. This
is done for the "files" backend for now to retain current behaviour,
even though we may eventually also want to introduce heuristics here.
For the "reftable" backend though we already do have auto-compaction, so
we can easily reuse that logic to implement the new auto-packing flag.

Note that under normal circumstances, this should always end up being a
no-op. After all, we already invoke the code for every single addition
to the stack. But there are special cases where it can still be helpful
to execute the auto-compaction code explicitly:

  - Concurrent writers may cause compaction to not run due to locks.

  - Callers may decide to disable compaction altogether and then pack
    refs at a later point due to various reasons.

  - Other implementations of the reftable format may do compaction
    differently or even not at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h                  | 6 +++++-
 refs/reftable-backend.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 8c8994cb29..d278775e08 100644
--- a/refs.h
+++ b/refs.h
@@ -422,8 +422,12 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 /*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
+ * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
+ *                 result are decided by the ref backend. Backends may ign=
ore
+ *                 this flag and fall back to a normal repack.
  */
-#define PACK_REFS_PRUNE 0x0001
+#define PACK_REFS_PRUNE (1 << 0)
+#define PACK_REFS_AUTO  (1 << 1)
=20
 struct pack_refs_opts {
 	unsigned int flags;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 694dc4845f..0bed6d2ab4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1203,7 +1203,10 @@ static int reftable_be_pack_refs(struct ref_store *r=
ef_store,
 	if (!stack)
 		stack =3D refs->main_stack;
=20
-	ret =3D reftable_stack_compact_all(stack, NULL);
+	if (opts->flags & PACK_REFS_AUTO)
+		ret =3D reftable_stack_auto_compact(stack);
+	else
+		ret =3D reftable_stack_compact_all(stack, NULL);
 	if (ret < 0) {
 		ret =3D error(_("unable to compact stack: %s"),
 			    reftable_error_str(ret));
--=20
2.44.GIT


--8i6R/ERhgUIXW/Pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS94ACgkQVbJhu7ck
PpQGThAAgEEUS3RpRja6DGImJKzzIf9BUuyuUjBC+m2BVqnFVr3RWWRiWT/PdmcB
1M7nsDKsUVbDgVaBDk1LA8Vt6GfacmbKBVT7aEVhkTUXKxCEkzV0cHDIwBD3ZbCL
vBuToL3A/rqyEMMog/+9GlAj36pZUKNIt++v+5hBAjkUY4s5hO6/UrkMQY0lPJmS
K3FaxdEd4xlUX98JAl5BG2Fb24eEY06fAXAdtRAjGJ8eCN1/IjWeEBBzWl8i/7tA
AVxTZMTJTS5eCVeXhdveSxuI2hikSZ2GTpmsh7/6vvDcI7K8kW8uzfLVVlnkuYKH
Gf+pUmaTaZgE98fUHjghHYVyr9Yba8FMFrwkY2HJoZ7b7lDmZjpdNMxnhpKrnNax
FY9tj0KH18evscaRX9U3npYKbdvy0xRWcI0hGx8YRoRjCWoicM5s8R7CGiBp9nqY
uq8fQi3j8ol6iMD6IFShj6iUF45zid11rBiOC9p4mV/2k/P9RrwRvfYZFXd2w4Km
xdms/ws3MSR0LRosq1JTZXwlUipWTM1Uggc+1AOCXKzGwZvH781nq1SXZdgc6OOF
PnU7WP7JhQgGuuD8da+1dcOIRshJWRxSl+I6VgoVFtVLPbTLl2/dBjdW2NACyAMc
GGw4/qemn1wv5kPH6M1Uz1CtnSnzOxNP2QisiRYdgP0WAoS87+A=
=rfHS
-----END PGP SIGNATURE-----

--8i6R/ERhgUIXW/Pv--
