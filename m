Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679821B9F7
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357148; cv=none; b=eVCqGar7euper8NbWC/CJnJMmH4CVIBFISv7tt4UKOH/GtCc10lv5xexU2p4zJvzVr5mBvshN+7kT7athcNEehR2so0HWv0bJ8ggGcrBZvRKnyq8sZ0HDBrxRAtXmw5xGOZriBt8/trkvi0qyle2jQG5s9L5/grXoHNDzKmC6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357148; c=relaxed/simple;
	bh=Nvyn7DlNFnqaTMirC3Qa47WRk5b9+r5bVU0i8X/+0mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIVRIOi4qI1CHBzYH44FvmCvvHWmuFHpTweS7ODyPPQPjv5PmOCC0Il+1pldaVUWXAcNMnD+THPiHxy43PRresJ93TZCFxYsm5RtKwMWqLwHQxNzHitFOYacPgQWhRkkeSPqpPwqJf7JdLCmBjOcFnxqJ4d20IUgWcMPydYwZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SDaf+Tcu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqV/i/mP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SDaf+Tcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqV/i/mP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C53DD1140186;
	Fri,  7 Mar 2025 09:19:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Mar 2025 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357145;
	 x=1741443545; bh=Y4HJmM+JiR7nztyQnLAkouWPQJpIaN73FcU24TrRUvI=; b=
	SDaf+Tcun7aML6DSB6MfIU9xHK4fxtP+arsGpXtJTFSihVMociiT6XxSQtJ/zNA4
	Ewkhk23aL5okA5QgMS8ZepIBc7cbTzZWkoPP49nqyf8PzhhIcWrkOrrk4p26lPU5
	KtIcRxomykgrHSe56rXV+ybxNL01YB8QJsOWQTnwnvDDl9p4VcjaM+LbMKRUEdkN
	EQMqPV7U5Qpr/IiXvZzsmtW5xt3nqwtwUzr7mGmFXkNJcLZxMqlmESZO9zzcc6i+
	kkKNNyQj3n6KYVlUmskrQh5GTUl2e8KU/UsiRsDBu1yEVR9/8K+DP6p5GOtEpx4K
	h+0dOcAUn62C6H3W0DfgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357145; x=
	1741443545; bh=Y4HJmM+JiR7nztyQnLAkouWPQJpIaN73FcU24TrRUvI=; b=V
	qV/i/mPve73v57YuYNmAsxrkn01fL2BL5y5onpsM0v+yTyxesS/1Gptyrnr7G6rF
	2+sjlMGZTvJbbCp9tD8ChkyTwKROiuaz0xWkrXslTpQ0xumQAF5I6GZ/BqghqyVb
	luIZ0icej4KpY4hmX6OjcnyDL4eG7+iuhPyGu+wRRUGX7eSpfYiObVdJsT1d6kUU
	ogytSKJXPrgCiHM1bWOQoHAFR/p05LnJNyWdsqL1fUP+GAEknmtnLGmIZzPjveet
	/OQI2xQ0CKHeu9lmEIj48oOR/kJcIo5N2gfgiRkJsX5F5NbE01AfUXLfyIKHCCn/
	gDQ4pUPIZFskQevdRAJ3A==
X-ME-Sender: <xms:WQDLZzXII0KA1IAJDQN6852KOUKJYBn0sxVLLvLnv-DnoW_-e5ZGXg>
    <xme:WQDLZ7n47R1m1S4DcKoZq5e_CRzd102DJVwpbMXvWsnWBuw9rQUIU2H0il0ZBWpLy
    TLY5X9onHBucpghDg>
X-ME-Received: <xmr:WQDLZ_Z0tTtZGGMv-FiTruPpXijj90SYvlQMQlubWzGULGwnfEvpx1_eq7IEjINPP381fiiqRqy2Jby63V93pNno2W5Cvb53MBMY_90th_BR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WQDLZ-U8A9-Q4u68Q-US-hAa9S3pATKqNqZBAVgqQpU_pv_mj0_l-w>
    <xmx:WQDLZ9lvdtLkWKNXlFvY8_A3HznnItXZVeeWhxCfVk8S7G1pZXldRA>
    <xmx:WQDLZ7cx3c_OSIElzNBzlTBT2oawz4O3I7BiI0dBrRW2ZPO6caP0zQ>
    <xmx:WQDLZ3EmKjX0NiFM5F8KuyVx8JPF4MfHIKhAjzUmBBKPI3TelCgZjQ>
    <xmx:WQDLZzh3f-sWRJ56MLcMgkKYPRRYXeSh9JOzUEbzvxzRQ4gN4da5ut_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b97c8c8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:18:59 +0100
Subject: [PATCH v3 06/12] pack-revindex: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-6-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
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
2.49.0.rc1.455.g4cd33545ba.dirty

