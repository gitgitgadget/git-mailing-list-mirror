Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC81BF53
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163294; cv=none; b=r4oqFsE2m21QbUNJ1twdwMmhlZwdbPqgCcPqO/Oo0wA/rhY9q3PHrXBqObELIS+33mnzio6QrjaXezG5eeGwMLjPELRtvhEhmImrVpSieK8Egsa+9R8ftoJr4OgQJM6bFqjCUYYm9QVdh0BQ3atJ3SI4jsRIBv/Yb3G20oc2s20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163294; c=relaxed/simple;
	bh=e3UmuC7CYLgJ0J18F6JQiNzGC9kFZgdrbQeZLQJOtRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKU/CXnpXIyTDqyqlE/xe4+ViyVb2vZ91LaLm7uGFF2cJA+uIK2iVb6z7Jek8fiB56ojIR1Rn2P10CFaetHOk+FfjIPfgY/XevJn3w7d4Pv4kxhtITkHdo+tv3H3u6lUwoUMD2FnuEGLqlDN4bFW37KnTBqGKZgiuR115epdzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PnfSE3c6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZHuaIRu5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PnfSE3c6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHuaIRu5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DE2BF1140085;
	Mon, 15 Apr 2024 02:41:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 02:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713163289; x=1713249689; bh=hFBmElZPMb
	CIWRhXeeqMqhYzw8GvHFE6ieFL9eS6Qhs=; b=PnfSE3c6CfSa2/qpYaZB3G1oIq
	44g9f+8yvId5ui/InpBfkExjA3kncR7QIvGz9pGzTX9Hje+s/HZbc6eq5VFucRQQ
	q7bOFffDREtpzubcCbYybvGPyCGr/P8Z4F8vvZWbSnSjRSiXmzf+dltmNJ5pDVts
	NCoFKT5m9JSm1/4F1bLOfeW2XGucmbebruweT0WMMGucvVe1haPLIv5fZGkU/4RA
	QANOGfoGS+ZLJjmdbTPzzUCgxsEBoJtMk1xS9QUaKHBx75oC47bht0p82UZxEyDM
	4EXr1kEydh5X2OBpZvuQKpjLoU8zV0VlUFp7SB23NMp/Tg0dAYFKYgaV7Ksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713163289; x=1713249689; bh=hFBmElZPMbCIWRhXeeqMqhYzw8Gv
	HFE6ieFL9eS6Qhs=; b=ZHuaIRu5CC2NUGYj8ftfYerMYdFfcXeuXbHWWtZ4aXNK
	awaaZIY9kvczKTaktRqHYDLX59CdjTXdhCCNVDVtBE9pBrp/ruLpXlhYRRurRHVL
	Zmla7qqSKtCLzmiSkzJVylwHPzcVPE0RehgURSxCO0mj7+IjMsxt+sz6GDs9xuMu
	1K2JATBOeVwkYHaqxVZ3EJI31khYdxlvCdzC/E5+fpXUSJ7p327F9yFMzUsCBsSQ
	ih8wGfkq52N3LRCKXD6EcS+XbTeZTm2cBo6ZpT49A15dZWXhXGeqiOFqcGg63mQM
	+Ye81pBFH5hw/gjdlS3BKE3yKuOCmlz6J25NqjPX/Q==
X-ME-Sender: <xms:GcwcZr1vTcgXDfRSQ7R5BP1rED69F8-NMgNwU3rnG0AIggVEdzRmCg>
    <xme:GcwcZqF9jgtRw3JHDpHob_yRA41gBoNmKk6gRi6VsFZtB5TmR-ojIMpSdXGg-cjID
    sB0NUd2yGj7z-j-xg>
X-ME-Received: <xmr:GcwcZr57VlZGaDBPyrmjeyFJ5gfj4bdBY673ZEP7965K1Tz2gH0ovg0danYq_43o4sKdhvoa9oWXk-mC0lhtw5Kwg_49rYAKJHXP0xgL0fw-8gsChQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GcwcZg3QCpKQ3lp_zPahlJRxK2mEzmrLo4Z8KIE3C4ZJX2XpYHG_sw>
    <xmx:GcwcZuEHxjMObpGz50W_ykut4YTLgXSlId6xWtRvC923XFp60aPRrw>
    <xmx:GcwcZh8duNg97y_jNIWWa6M9-m7khWssRaRFJFQmjsqX-CjjlmdDLw>
    <xmx:GcwcZrnRv90TqePkuaOOkOGK9zTmEoRYF_oc1flC0oRHRy7UTn0xtA>
    <xmx:GcwcZjTQu0qxKBifcEyibIGvQwAQu44MNbm0cnoK3b6dHHhP8FO419p5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 02:41:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 626b2d9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 06:41:08 +0000 (UTC)
Date: Mon, 15 Apr 2024 08:41:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ej41Hu/vCOEofkSN"
Content-Disposition: inline
In-Reply-To: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>


--ej41Hu/vCOEofkSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 0fea6b73f1 (Merge branch 'tb/multi-pack-verbatim-reuse', 2024-01-12)
we have introduced multi-pack verbatim reuse of objects. This series has
introduced a new BTMP chunk, which encodes information about bitmapped
objects in the multi-pack index. Starting with dab60934e3 (pack-bitmap:
pass `bitmapped_pack` struct to pack-reuse functions, 2023-12-14) we use
this information to figure out objects which we can reuse from each of
the packfiles.

One thing that we glossed over though is backwards compatibility with
repositories that do not yet have BTMP chunks in their multi-pack index.
In that case, `nth_bitmapped_pack()` would return an error, which causes
us to emit a warning followed by another error message. These warnings
are visible to users that fetch from a repository:

```
$ git fetch
=2E..
remote: error: MIDX does not contain the BTMP chunk
remote: warning: unable to load pack: 'pack-f6bb7bd71d345ea9fe604b60cab9ba9=
ece54ffbe.idx', disabling pack-reuse
remote: Enumerating objects: 40, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 40 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
=2E..
```

While the fetch succeeds the user is left wondering what they did wrong.
Furthermore, as visible both from the warning and from the reuse stats,
pack-reuse is completely disabled in such repositories.

What is quite interesting is that this issue can even be triggered in
case `pack.allowPackReuse=3Dsingle` is set, which is the default value.
One could have expected that in this case we fall back to the old logic,
which is to use the preferred packfile without consulting BTMP chunks at
all. But either we fail with the above error in case they are missing,
or we use the first pack in the multi-pack-index. The former case
disables pack-reuse altogether, whereas the latter case may result in
reusing objects from a suboptimal packfile.

Fix this issue by partially reverting the logic back to what we had
before this patch series landed. Namely, in the case where we have no
BTMP chunks or when `pack.allowPackReuse=3Dsingle` are set, we use the
preferred pack instead of consulting the BTMP chunks.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Range-diff against v1:
1:  5933a302b5 ! 1:  a8251f8278 pack-bitmap: gracefully handle missing BTMP=
 chunks
    @@ Commit message
         BTMP chunks or when `pack.allowPackReuse=3Dsingle` are set, we use=
 the
         preferred pack instead of consulting the BTMP chunks.
    =20
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## midx.c ##
    -@@ midx.c: static int write_midx_internal(const char *object_dir,
    - 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
    - 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
    - 			  write_midx_revindex);
    --		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    --			  bitmapped_packs_concat_len,
    --			  write_midx_bitmapped_packs);
    -+		if (git_env_bool("GIT_TEST_MIDX_WRITE_BTMP", 1))
    -+			add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    -+				  bitmapped_packs_concat_len,
    -+				  write_midx_bitmapped_packs);
    - 	}
    +@@ midx.c: struct multi_pack_index *load_multi_pack_index(const char *=
object_dir, int local
     =20
    - 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
    + 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
    + 		   &m->chunk_large_offsets_len);
    +-	pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    +-		   (const unsigned char **)&m->chunk_bitmapped_packs,
    +-		   &m->chunk_bitmapped_packs_len);
    ++	if (git_env_bool("GIT_TEST_MIDX_READ_BTMP", 1))
    ++		pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
    ++			   (const unsigned char **)&m->chunk_bitmapped_packs,
    ++			   &m->chunk_bitmapped_packs_len);
    +=20
    + 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
    + 		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
    =20
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitma=
p_index *bitmap_git,
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap=
_index *bitm
      	load_reverse_index(r, bitmap_git);
     =20
     -	if (bitmap_is_midx(bitmap_git)) {
    -+	if (bitmap_is_midx(bitmap_git) &&
    -+	    (!multi_pack_reuse || !bitmap_git->midx->chunk_bitmapped_packs))=
 {
    -+		uint32_t preferred_pack_pos;
    -+		struct packed_git *pack;
    -+
    -+		if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0)=
 {
    -+			warning(_("unable to compute preferred pack, disabling pack-reuse"=
));
    -+			return;
    -+		}
    -+
    -+		pack =3D bitmap_git->midx->packs[preferred_pack_pos];
    ++	if (!bitmap_is_midx(bitmap_git) || !bitmap_git->midx->chunk_bitmappe=
d_packs)
    ++		multi_pack_reuse =3D 0;
     +
    -+		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
    -+		packs[packs_nr].p =3D pack;
    -+		packs[packs_nr].bitmap_nr =3D pack->num_objects;
    -+		packs[packs_nr].bitmap_pos =3D 0;
    -+
    -+		objects_nr =3D packs[packs_nr++].bitmap_nr;
    -+	} else if (bitmap_is_midx(bitmap_git)) {
    ++	if (multi_pack_reuse) {
      		for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
      			struct bitmapped_pack pack;
      			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap=
_index *bitm
      		}
     =20
      		QSORT(packs, packs_nr, bitmapped_pack_cmp);
    + 	} else {
    +-		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
    ++		struct packed_git *pack;
    ++
    ++		if (bitmap_is_midx(bitmap_git)) {
    ++			uint32_t preferred_pack_pos;
    ++
    ++			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0=
) {
    ++				warning(_("unable to compute preferred pack, disabling pack-reuse=
"));
    ++				return;
    ++			}
    +=20
    +-		packs[packs_nr].p =3D bitmap_git->pack;
    +-		packs[packs_nr].bitmap_nr =3D bitmap_git->pack->num_objects;
    ++			pack =3D bitmap_git->midx->packs[preferred_pack_pos];
    ++		} else {
    ++			pack =3D bitmap_git->pack;
    ++		}
    ++
    ++		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
    ++		packs[packs_nr].p =3D pack;
    ++		packs[packs_nr].bitmap_nr =3D pack->num_objects;
    + 		packs[packs_nr].bitmap_pos =3D 0;
    +=20
    + 		objects_nr =3D packs[packs_nr++].bitmap_nr;
    =20
      ## t/t5326-multi-pack-bitmaps.sh ##
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'corrupt MIDX wi=
th bitmap causes fallback' '
    @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'corrupt MIDX wit=
h bitmap cau
     =20
     +for allow_pack_reuse in single multi
     +do
    -+	test_expect_success "MIDX without BTMP chunk does not complain with =
$allow_pack_reuse pack reuse" '
    ++	test_expect_success "reading MIDX without BTMP chunk does not compla=
in with $allow_pack_reuse pack reuse" '
     +		test_when_finished "rm -rf midx-without-btmp" &&
     +		git init midx-without-btmp &&
     +		(
     +			cd midx-without-btmp &&
     +			test_commit initial &&
     +
    -+			# Write a multi-pack index that does have a bitmap, but
    -+			# no BTMP chunk. Such MIDX files would not be generated
    -+			# by modern Git anymore, but they were generated by
    -+			# older Git versions.
    -+			GIT_TEST_MIDX_WRITE_BTMP=3Dfalse \
    -+				git repack -Adbl --write-bitmap-index --write-midx &&
    -+			git -c pack.allowPackReuse=3D$allow_pack_reuse \
    ++			git repack -Adbl --write-bitmap-index --write-midx &&
    ++			GIT_TEST_MIDX_READ_BTMP=3Dfalse git -c pack.allowPackReuse=3D$allo=
w_pack_reuse \
     +				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/n=
ull 2>err &&
     +			test_must_be_empty err
     +		)

 midx.c                        |  7 +++---
 pack-bitmap.c                 | 41 ++++++++++++++++++-----------------
 t/t5326-multi-pack-bitmaps.sh | 17 +++++++++++++++
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/midx.c b/midx.c
index ae3b49166c..6f07de3688 100644
--- a/midx.c
+++ b/midx.c
@@ -170,9 +170,10 @@ struct multi_pack_index *load_multi_pack_index(const c=
har *object_dir, int local
=20
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
 		   &m->chunk_large_offsets_len);
-	pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
-		   (const unsigned char **)&m->chunk_bitmapped_packs,
-		   &m->chunk_bitmapped_packs_len);
+	if (git_env_bool("GIT_TEST_MIDX_READ_BTMP", 1))
+		pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
+			   (const unsigned char **)&m->chunk_bitmapped_packs,
+			   &m->chunk_bitmapped_packs_len);
=20
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
 		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2baeabacee..35c5ef9d3c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2049,7 +2049,10 @@ void reuse_partial_packfile_from_bitmap(struct bitma=
p_index *bitmap_git,
=20
 	load_reverse_index(r, bitmap_git);
=20
-	if (bitmap_is_midx(bitmap_git)) {
+	if (!bitmap_is_midx(bitmap_git) || !bitmap_git->midx->chunk_bitmapped_pac=
ks)
+		multi_pack_reuse =3D 0;
+
+	if (multi_pack_reuse) {
 		for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
@@ -2062,34 +2065,32 @@ void reuse_partial_packfile_from_bitmap(struct bitm=
ap_index *bitmap_git,
 			if (!pack.bitmap_nr)
 				continue;
=20
-			if (!multi_pack_reuse && pack.bitmap_pos) {
-				/*
-				 * If we're only reusing a single pack, skip
-				 * over any packs which are not positioned at
-				 * the beginning of the MIDX bitmap.
-				 *
-				 * This is consistent with the existing
-				 * single-pack reuse behavior, which only reuses
-				 * parts of the MIDX's preferred pack.
-				 */
-				continue;
-			}
-
 			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
=20
 			objects_nr +=3D pack.p->num_objects;
-
-			if (!multi_pack_reuse)
-				break;
 		}
=20
 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
 	} else {
+		struct packed_git *pack;
+
+		if (bitmap_is_midx(bitmap_git)) {
+			uint32_t preferred_pack_pos;
+
+			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+				warning(_("unable to compute preferred pack, disabling pack-reuse"));
+				return;
+			}
+
+			pack =3D bitmap_git->midx->packs[preferred_pack_pos];
+		} else {
+			pack =3D bitmap_git->pack;
+		}
+
 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
-
-		packs[packs_nr].p =3D bitmap_git->pack;
-		packs[packs_nr].bitmap_nr =3D bitmap_git->pack->num_objects;
+		packs[packs_nr].p =3D pack;
+		packs[packs_nr].bitmap_nr =3D pack->num_objects;
 		packs[packs_nr].bitmap_pos =3D 0;
=20
 		objects_nr =3D packs[packs_nr++].bitmap_nr;
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 70d1b58709..5d7d321840 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -513,4 +513,21 @@ test_expect_success 'corrupt MIDX with bitmap causes f=
allback' '
 	)
 '
=20
+for allow_pack_reuse in single multi
+do
+	test_expect_success "reading MIDX without BTMP chunk does not complain wi=
th $allow_pack_reuse pack reuse" '
+		test_when_finished "rm -rf midx-without-btmp" &&
+		git init midx-without-btmp &&
+		(
+			cd midx-without-btmp &&
+			test_commit initial &&
+
+			git repack -Adbl --write-bitmap-index --write-midx &&
+			GIT_TEST_MIDX_READ_BTMP=3Dfalse git -c pack.allowPackReuse=3D$allow_pac=
k_reuse \
+				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/null 2=
>err &&
+			test_must_be_empty err
+		)
+	'
+done
+
 test_done

base-commit: 19981daefd7c147444462739375462b49412ce33
--=20
2.44.GIT


--ej41Hu/vCOEofkSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYczBQACgkQVbJhu7ck
PpSTug//VtJ9pzQGPnXDgbQR3xJsM1eXOuoVkRSqrAoNslzvn+pEOl1ry1h6EntT
FjFrjDx6ohkNTJwkcnERUFhgtJcKrusz+C/AfWzV9vJVWKXcyHLlnHdgqWw7yXwI
qxeZTxJ3eEbQzQdokKeCveg7LGsbL2rWq/keMJS/0e1ury1pFnsrQCr2jbbzUvJz
2GgHSpqqX/Q6Pz7LF4F2v1/m1cHoEFnpIvMFs9UWWCYuENs34ZOirTlats1b1erS
cRnl3a7U52iTraEfIj4x5ZBt51ecHq6/+2wZXWJ4t263UbtEd5WHUCllUTkkgg9R
0wCDmuMwEogGYTvdf7l81IsNUYVI7Q4rjp4bE68r7FE1TFtcXP9Sp2R1xYzCGlgK
kN33jEwYh/0eE2UFGNGXLGR8tYZ6V56pwUTXBTkUKkDe8GO657cgru0doElNNJSL
FvV2RrJwuN8mJ1fcpucwRLGLZcQDRaouHPAqp3hkYci1HAQnVldWTy5mzKXp9BNH
z3dNSIpaOfNTxZfQnKqyeQ4EHQPOPzRrDhvSK5rvTV/3wKjYTm3p5uSXXlZwNIEo
jfGcwo/td0zAk4bdzAjF7d/jy/E4L5RYaEi1wOBzV0SQ0wm7g0igJ2ujKA7tt5fe
XYtHK8oJlp5esrNWxZcx28NYnyN8RH62yMid8vorZ/R1I/PNdDk=
=L6Cd
-----END PGP SIGNATURE-----

--ej41Hu/vCOEofkSN--
