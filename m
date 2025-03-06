Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F920E715
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273842; cv=none; b=Du6CJg6rZ/O6bH1dJc1PJMBsBIw/CBel+P1DeQ3snpJp4sAHc67olr7jChoxpzkh64zI0VgqDx37Cko2VIWX2j88XVr5ODGKv1FyjlPomy37hiTqhTg3qqgDn9n2nxv0a87Ip5d8Kcy7VM/3F/YDKhUTCIcxlYQdK5SyhCxLER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273842; c=relaxed/simple;
	bh=lnxEVR2IA13z9KTC8xpHJqhxn8O/jIqjqe9yP/yBGjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWGltjeLwLSAhPbySlKaXRl4PDauWcgoSCttuk5iYHs06ncVQb2K7KUKuUSsgX1uDHxwezO5VnYWjqy9SZdVFU5OGC/ALM7R84eaUM7Al6yFRzlKmUD6KMhe5eKvN4pefv7t15+RfUqKjQBEB3xez/6TIL5KHKCPttcNERjuO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zj5PaEji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QajlhdxK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zj5PaEji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QajlhdxK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 135C925401F4;
	Thu,  6 Mar 2025 10:10:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 10:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273839;
	 x=1741360239; bh=oL05rzC34cehRs5YCKlbAbEvZ2+A35yKljHgebRFehk=; b=
	Zj5PaEjiggyxuEyfN1pajheAmS8bMdGnv1T5Ecue2ONNrXRHPYxqC4WNjjBhqT4a
	ddl8RwYuLZEDY98abrIeAOM7NllVSpsJGNs+1KklHc5vaNCWWJGk/HBSLFBevC4i
	2lFVhnOHKEOfVgue9sY11Y0Ck6vmKIwsCuyl77FJjh81UVxTiBcU9mvZ548UER6/
	dVej4t/FjubK8R7LgzJWHu6eeGEjiPLtWLUBa154wwhRxaN+PX3xRPI6RBLvcE9X
	NflgAOicTMBLcgNrRHH9cKqGmpT1hwhHWgxJEb1uD1f5kgGlhNsWLy1Q9J42uea9
	fz4r3OyACBjmfWz1Ku2Z3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273839; x=
	1741360239; bh=oL05rzC34cehRs5YCKlbAbEvZ2+A35yKljHgebRFehk=; b=Q
	ajlhdxKtzB265sGyIAk6FR/b3sP0gzD6/vc3NhsRGlSvxJcm0jjQfkE9YzywUOTJ
	uNx+nULm4x9ctyODnGiQRw3Qe+dXFzKdEvyqedABX+9XYA9tY/gWqVw9B3aypJj0
	jrPtItBj27dCYHBWXZ2xKA7rjnMw3D/lcxbhGtaU7+q3JuODHJJj3VdhzRHBa00m
	7tV3crBVJnA2KM46EQPvoycbuJGH8wuZeaBxJ1wyh2sH8ry13TNqV1eYMarul23Y
	A9LWxy8DuqRuXNikJmP6e0WGyJHNS6PcRZTZpNj8qYMaxE5xNzQftRRgMp9PMi5f
	9JWHPvwpcBcp0gO4mvlmQ==
X-ME-Sender: <xms:77rJZz6g20EPudY9m-8EZyJ0pmnM9SGZkRJEctfNltK8QPEWYesmwA>
    <xme:77rJZ44KmSFF_5xsgqttwGTVFm4BMxTF2a2dZM5YgCKWA6EuB2nlqcFZ48r4T6opR
    RyMx1tnwf7wVHxUOg>
X-ME-Received: <xmr:77rJZ6dq7aMeNWwhdoRJOJcmrLvmQAxy5v0XO9C-W96NwvlK-UGf62r6OxfmT-PYR_gRY2SkM0_QgT9I-dB08aDQLRmNeSzXxZF2u4IkK0ktEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:77rJZ0Lfv4IK_D4SYplIs14E94g0xNGJbRrxPfwavb95wQd8Dkz41w>
    <xmx:77rJZ3IfY1fqaLWUlDU6Zgo2dIZQ9SglzCba3iRJoUfDmAba8H-Plg>
    <xmx:77rJZ9xrc50GAw2mUIVzAAzJKH5tXoPssDO1IVMLn_01YdHUXoRv_w>
    <xmx:77rJZzImemYiZETWO5os1pFA4f1T0PIO-xICSUh48ux9Srs8M2haDw>
    <xmx:77rJZ_3wUhydVlyqOLmf9Lj0MZLeeKbmgGRLqWC9zuFtn3vYlYtx1I6R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb42bb1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:30 +0100
Subject: [PATCH v2 06/12] pack-revindex: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-6-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are multiple sites in "pack-revindex.c" where we use the global
`the_repository` variable, either explicitly or implicitly by using
`the_hash_algo`. In all of those cases we already have a repository
available in the calling context though.

Refactor the code to instead use the caller-provided repository and
remove the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-revindex.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 78139e3d7f5..038e0c96b1c 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
@@ -9,6 +7,7 @@
 #include "strbuf.h"
 #include "trace2.h"
 #include "parse.h"
+#include "repository.h"
 #include "midx.h"
 #include "csum-file.h"
 
@@ -137,7 +136,7 @@ static void create_pack_revindex(struct packed_git *p)
 	const unsigned num_ent = p->num_objects;
 	unsigned i;
 	const char *index = p->index_data;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
 	ALLOC_ARRAY(p->revindex, num_ent + 1);
 	index += 4 * 256;
@@ -193,7 +192,11 @@ static char *pack_revindex_filename(struct packed_git *p)
 }
 
 #define RIDX_HEADER_SIZE (12)
-#define RIDX_MIN_SIZE (RIDX_HEADER_SIZE + (2 * the_hash_algo->rawsz))
+
+static size_t ridx_min_size(const struct git_hash_algo *algo)
+{
+	return RIDX_HEADER_SIZE + (2 * algo->rawsz);
+}
 
 struct revindex_header {
 	uint32_t signature;
@@ -201,7 +204,8 @@ struct revindex_header {
 	uint32_t hash_id;
 };
 
-static int load_revindex_from_disk(char *revindex_name,
+static int load_revindex_from_disk(const struct git_hash_algo *algo,
+				   char *revindex_name,
 				   uint32_t num_objects,
 				   const uint32_t **data_p, size_t *len_p)
 {
@@ -228,12 +232,12 @@ static int load_revindex_from_disk(char *revindex_name,
 
 	revindex_size = xsize_t(st.st_size);
 
-	if (revindex_size < RIDX_MIN_SIZE) {
+	if (revindex_size < ridx_min_size(algo)) {
 		ret = error(_("reverse-index file %s is too small"), revindex_name);
 		goto cleanup;
 	}
 
-	if (revindex_size - RIDX_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
+	if (revindex_size - ridx_min_size(algo) != st_mult(sizeof(uint32_t), num_objects)) {
 		ret = error(_("reverse-index file %s is corrupt"), revindex_name);
 		goto cleanup;
 	}
@@ -279,7 +283,8 @@ int load_pack_revindex_from_disk(struct packed_git *p)
 
 	revindex_name = pack_revindex_filename(p);
 
-	ret = load_revindex_from_disk(revindex_name,
+	ret = load_revindex_from_disk(p->repo->hash_algo,
+				      revindex_name,
 				      p->num_objects,
 				      &p->revindex_map,
 				      &p->revindex_size);
@@ -322,7 +327,7 @@ int verify_pack_revindex(struct packed_git *p)
 	if (!p->revindex_map || !p->revindex_data)
 		return res;
 
-	if (!hashfile_checksum_valid(the_repository->hash_algo,
+	if (!hashfile_checksum_valid(p->repo->hash_algo,
 				     (const unsigned char *)p->revindex_map, p->revindex_size)) {
 		error(_("invalid checksum"));
 		res = -1;
@@ -375,19 +380,20 @@ int load_midx_revindex(struct multi_pack_index *m)
 		 * not want to accidentally call munmap() in the middle of the
 		 * MIDX.
 		 */
-		trace2_data_string("load_midx_revindex", the_repository,
+		trace2_data_string("load_midx_revindex", m->repo,
 				   "source", "midx");
 		m->revindex_data = (const uint32_t *)m->chunk_revindex;
 		return 0;
 	}
 
-	trace2_data_string("load_midx_revindex", the_repository,
+	trace2_data_string("load_midx_revindex", m->repo,
 			   "source", "rev");
 
 	get_midx_filename_ext(m->repo->hash_algo, &revindex_name, m->object_dir,
 			      get_midx_checksum(m), MIDX_EXT_REV);
 
-	ret = load_revindex_from_disk(revindex_name.buf,
+	ret = load_revindex_from_disk(m->repo->hash_algo,
+				      revindex_name.buf,
 				      m->num_objects,
 				      &m->revindex_map,
 				      &m->revindex_len);
@@ -419,7 +425,7 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
 
-	if (load_pack_revindex(the_repository, p) < 0)
+	if (load_pack_revindex(p->repo, p) < 0)
 		return -1;
 
 	lo = 0;
@@ -465,7 +471,7 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 	if (p->revindex)
 		return p->revindex[pos].offset;
 	else if (pos == p->num_objects)
-		return p->pack_size - the_hash_algo->rawsz;
+		return p->pack_size - p->repo->hash_algo->rawsz;
 	else
 		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
 }

-- 
2.49.0.rc0.416.g627208d89d.dirty

