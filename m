Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679C1D8A0B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590818; cv=none; b=hn9wgCDGkoX+ljmHkPrNpUMFD+vbFCqAdIYyVF/kxjr+3QuhBS96W2tWRjfu7ZJ8mlRsxJ4xbDMvabji2wDJY8HEbmMQb8UXKEkKVFGZ7t/y69cf56MI3rZSn1r9YCRpwrm+xGsyYtkOV0BPe3KGrITKe6fXrGfjSBp351onk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590818; c=relaxed/simple;
	bh=Nvyn7DlNFnqaTMirC3Qa47WRk5b9+r5bVU0i8X/+0mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZhm5kmBXkxIWdJzoZqAhy6ueoM7EflW36ef0Rs9/g64QJqUa3BVcfXoYbiF68yaW2Ry7SuWq0Z30N29jJytBcnmsv8/iwN7TB2J0OK3Sv85QGn6Lfp4cnEhG/BhYh8a5FhTQkF6F28tRwzazaOSnSccXt4EBgj6l62ChkCCLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iYEzRNaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsiR5brL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYEzRNaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsiR5brL"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE6FB2540133;
	Mon, 10 Mar 2025 03:13:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 10 Mar 2025 03:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590815;
	 x=1741677215; bh=Y4HJmM+JiR7nztyQnLAkouWPQJpIaN73FcU24TrRUvI=; b=
	iYEzRNaRFh4JSRLHQaAMJo2CtGfu+2rIG5o4bLrzRyfV4ujOQX3z4w2uCQ1Q71lW
	bVw2K5e/Hy5BFbOATb79BBiLh4WNn7irhlWEx8ML9wRm/Y7ErDsMe9eaYio1YkAj
	DGUFe9e6R2QEGrhW3MtIB7k+FNsOc+CvBxnaSbCyfqKYE+Yv9RQ3sMl4MUnB0plc
	OLug0HyTIQOaH85n2XAn5j5pAYK2SKQ99xC/Z1iZOHfjFoWo70IfkkIDCUmApsiv
	ZWnXWfXXn4BcOQsd9c46f466yJthokVf5G55/6BRxhOvpPlMEc8UCbcZ0+1tZERJ
	IcHd2s3cJikGRjdvzqfLhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590815; x=
	1741677215; bh=Y4HJmM+JiR7nztyQnLAkouWPQJpIaN73FcU24TrRUvI=; b=n
	siR5brLxhUPKeZJG7L/N6k8xWIgCi5QUdl+k6dcCJOuny5c0osaN5A4czkHUrz0J
	4C3jRXWXRigVmwCUXbdMoVjS2vraYDNDlqe0xI68wYctLMXj6IV17zC3Hnd2rczp
	bbWWTUZRN8/uMN526kD2nygimMLLpfpdu3+ACkL8JZAeI8IIj/UZAS1/lSLo8o/r
	JxsS3qUFPM0jF1zci9aF/kpGQAMb11RQhw4QLeC0PbGkaZO13kA/J0q9a3k1FO/u
	1ayYu95CgAuO7S7vIq2inHI6h3rHAJWP/5HFsjxCO1RlJ78gMpVTFis6JXpJq0i1
	pY48HAaRQg0S8+SCoc5qw==
X-ME-Sender: <xms:H5HOZx9gF3RD1dgoxPqT8UTZ0nkv01uhz1-WiKzn6aY0EvEfirD9Iw>
    <xme:H5HOZ1vj2TRSPJyIek2Sc4laPs8kyTo2lifMcibA_83DlKdRhYKJq8qvAiLg6Ci40
    1-vO-CRQNCq_F1NXg>
X-ME-Received: <xmr:H5HOZ_DnTbzutXqJpxphRGwPLbfIr9fYeqOVHNqvvQ5TuUpmEmimwvrhLbK5lx4y8Oiuk5O6pCu3DhRZFGSTh7R-z9XYFaQpsNYIG0184-Qbfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:H5HOZ1fNsGGrjzUAvpIs3-gJAlmNDCM7iQIyTFRSCCMMBZHlBfvsqg>
    <xmx:H5HOZ2NcO2tWthk-j91gZsgPcMB7HuNkqJWMUgnxH-YTX8kNlxjFXw>
    <xmx:H5HOZ3nkcYOwVAbY0ZvK2SqSccLssyqXc9xPnqgI97HgI4cnLgWDBA>
    <xmx:H5HOZwuP7EqBgrPNti28FnVtOb6vc5AMa8qVzGAzacHa4WVn66Kegw>
    <xmx:H5HOZzrU3mt8TQpg7YRuBMtNjmzWvlWby8Ie50LH2csjpdXjOeyuyx9o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 771a3ab0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:25 +0100
Subject: [PATCH v4 06/12] pack-revindex: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-6-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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

