Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BB1F2C45
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991664; cv=none; b=RV43rWBYv8wszdzWeYs28WndUols0abGA5Pp1Qc5qqDXD/QKZKU6bWiqoVhVtem59p0m8sdIUK8OVIhNJ7YRa5All65qqVuuh3yV+eMBb8t48DPgQXdIOeci7OKFfizPRuiid14K9Lv5oNQ+A+14D8dQVfK6goz8lftWWE45vXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991664; c=relaxed/simple;
	bh=B01UCRA/xRQ1ruyTbE/oVzcTPXxd1Z9FwUdDMPbR/OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNpdRNhYP1rfJ1bWMPdhMIhF2k9qSrkugzhJFJ/cBqMlRz/ryQWeAAdyjv7lFIEDKnl0p1sM38SYat/ik88bU7kKBR584JC94apKA3O1ZW5YilzPOW5dt7FJZbdlFjYd/IicWPv234qvMeclR2Mcu81KheJCu+HCqivr3xFtlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kw2j7xh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDqxNaK9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kw2j7xh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDqxNaK9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0882B25401A4
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 03:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991660;
	 x=1741078060; bh=U89aAvnsKwajowiePgJkSoEcjuU+fbhPxH+LOlOqAb4=; b=
	kw2j7xh6JV97xj4Elke0t+9boleXJn06fot3VKp35AR3QXHEbhPCctGylE2WBMNW
	PhXl0oa9oK1jZTcJyrAkUOCslw4C4hJaYHzCHlz0PnJVMPjyqBiitA4Sdq1iC3TK
	WfnS6iMy1jDCAgYNyRSGkL5kpv1smwLIBx6W/8OnG+Xi8LmWXdU1AOmcsABEx/gR
	M7c3IQWLfgLgtbMmuLFzpK+9gKyTgo4dIfvykqCo1AT2Tf12qUECqiYGgX36Gfuz
	DVnIVo0s7vj6WhFBzrxhDVAzobOZQXOy6fj/InBtwTLuf5zgGo8gJ5LlOEYIOc9G
	5XD096AXqV9nVx+ep5/R9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991660; x=
	1741078060; bh=U89aAvnsKwajowiePgJkSoEcjuU+fbhPxH+LOlOqAb4=; b=Z
	DqxNaK9pkinfrHMNlFxNc33pVtwPo+qxspH/IgywsNMwwVKSK0DZ2Yi026xeh3Ao
	UXjX0wQ9ILmW9eaIbpdZp/uZSt+h7LtawRaRit+KHh6z4ME6sygaOlO/o4NC9/HC
	VuKtA+LnxdIJIKUF8sTLoAOFyx5V0UEp5oPfxLgCMfiHEqjST2cIXO5FXVQFZAB4
	1TcNjGQd66h0q2pSD2EkJbSTPIt4nZBxqLHrocEEAqZ8YhlIxckAAJPEmCb6wjNY
	kjvZlhQf1+xfsrKD9o/KdJlnoHLRtjOBie8IKLvAY2K2zXgWO2Co2ADNQqmBEH87
	U6cAh5t06auPjl4v4Re/g==
X-ME-Sender: <xms:rGzFZ8R8OJl3QWY6emj6iCPNWynBOK5jAMXpiUjFO71g45kmg9IVLQ>
    <xme:rGzFZ5xTy0GGELcPCsK6MPXj9cxZG8vxT_2fCj_44g2cgsr5SsLfAIyIyCeqHEknP
    _O3r3qXFnc4YuYxGw>
X-ME-Received: <xmr:rGzFZ50Z4QO8YysYmp4hIiY9hHbOmb6gO__DyRIRN0aYmlyLo5ExrMJrTwHede0Xmt-1ddnfpOq-TWtBkJlh1a_gadPmuHqCty2w11yAjXKnyfpX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rGzFZwBieusI-tQBRgevkDgj8GgiKwXa_Sg9-2wyiPonBk0xQOHnSQ>
    <xmx:rGzFZ1h-a8t56j_YWxcWHWIX1oK_WgbGTm4yQhsOlTQx7pcGxI0bLQ>
    <xmx:rGzFZ8p3TnpeuFQNlxPejIrm_OGp02aHvAqqwfJdpUaEXQ2m1B22sw>
    <xmx:rGzFZ4gO3p9X-HMrMECuXbIz6nVLsZdNHJP_HwHlvuxwxRVDvD2OeQ>
    <xmx:rGzFZ1at-6L-yYNbj1cPgoIWeE0VFYzDjsdXob_WOngudwhFySmqxdGL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e356cf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:35 +0100
Subject: [PATCH 06/12] pack-revindex: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-6-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.rc0.375.gae4b89d849.dirty

