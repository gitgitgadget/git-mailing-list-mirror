Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408751A3A94
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677368; cv=none; b=JJLP7J5oOr7m/1fIzXtgbdjVWVzd19aeNo/lzvtSVdcLjcVYBKglJNR6Odu8Oh4baKqjv18rTyLPvOlAP2t6yP8rqMJqZaqKz32e1prcDg2AG4+bpq1NuPPPfGiSdsVM+Ile0kPkcp5/0DPI6qOx98tXcY4BFXCxy+JwZVXx8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677368; c=relaxed/simple;
	bh=stVz+jRdBrdbsBYkMKBL1G1FxBMtIAngFQ8TO4u/frw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpSb2R7EGkb/My8KoUOKTm9moOfChLTn81SWADKd7KN72SsySpOqtePPJLTRbDrPb0bLb+LDpig+u+kKNnsTjS4xcNlsayQOU8rmt8EsLTHisdkavwSNV6Rt5aUqa8cxqAqYUECReRA3dFONkOrjpbOVT8HmVJNxhKHI2ON3K84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pE+PxJl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJ4eos4O; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pE+PxJl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJ4eos4O"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 461F711400AF;
	Wed, 23 Oct 2024 05:56:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Oct 2024 05:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677364; x=1729763764; bh=8oysbDlBs7
	GyvhMzG2x7HruS+B8kReUQIVCXvllK3ek=; b=pE+PxJl5zV5RpE7OOwPP8e17DX
	H4NP/+N97PbEX9RjD1u7Vjyzepi75cSFgC/L1eYB8UD7XXkHBT/8qj5Kop3dmWai
	kt9BbRnkAcQnAQqN+D+WiFJCXZ5SB/9i6a4HiePq6UKts+J5tDX2Pi00QskmGBPt
	ytGeQkEORw6WP4kn6inqXXNg4xS5fsOhJ/LsWL1Xd37HgHddh7dkCQFLAQ3pZklK
	vXKKRry7leum9amM7TwV0EemxOcr17NOnoWLaD0d3LdpgermItk+d59UUSZ5jdgZ
	b9yie+CoISXhgQTSfXCqWH+CqlDvd3f1ZH4pf0yUrRJBGqT9HQm/5zVmIiHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677364; x=1729763764; bh=8oysbDlBs7GyvhMzG2x7HruS+B8k
	ReUQIVCXvllK3ek=; b=HJ4eos4OQ2g6kxHo0Z3d+FnhUV+gIJ31GYcS/eRQzOzY
	wg/bC5phXYl7mN7roaMShcEjmc4JUmbkElOQrxSrmUiNuNpLgrhpbVUccdqNi0s6
	nldfZC4qF2rJgpWTFLfX8bwxgcDSbF1TO3InagmZQBdvHRcvOf4PdMieGHv7tr5C
	Z55Ui8Q/TmH9dLZ6C4J1eAMDv5ysbkOzavKxpip/bQKXhLaoABMR2TcceUgYQT7d
	iL/cLTIL3XfhFVZBzv18ZI5Io7q8xShQDDC3xMF73EYCfRWOON3wp4gcHAHMu2Zz
	CX9Sd1NuBspc5UZ9+9oZIjNbLjGQ3xz2I8i0DgA+HQ==
X-ME-Sender: <xms:NMgYZ8dUFqqE7_mHG7dQkyJ3kXle85n5KzFQA30z1obFc3zD63fNkQ>
    <xme:NMgYZ-P-Fn0iZ_aPutuhvgnnMQOdWC5HrCKZPnmIMGICDEzs8cLOd0VGAN4z6OLSS
    5kNxO7v2C5zPsP2KQ>
X-ME-Received: <xmr:NMgYZ9jQbrb7uSj798qSlLWbanNwnAD6DHYPdfegljCQClgLkrkIY1vWK0JUJCka54YlWQlewJ3e0_FEzb5v9MLl8kZeyz57fbz_2kho_EKe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgedtgfefhfdtffettdevjeeiteektdffkeefheeukeet
    feeltefhffdvieejgfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpvhgrlhdvrd
    htrghrghgvthdpuhhpuggrthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomh
X-ME-Proxy: <xmx:NMgYZx9o1FgAUd48YwLa2tBrPw1uhgwxfPqXoVoHB9wHuvcMb10hQA>
    <xmx:NMgYZ4vz08JkZvstY5H5hm4_bXtA65PwHtYgB0uTjw6UICtXW6Y9wg>
    <xmx:NMgYZ4EwGPDa1OzWhV9zW6QbbHZl4B-tFgTFCDPkdWT6lfzgcf8VWg>
    <xmx:NMgYZ3Meav24_vqr017xzXcrFpkV0WL_48hU2aICbCIrcV8YK8gg7w>
    <xmx:NMgYZx7Hdwbax3P3ULth_dLvEtJu-R0N44sCd-RNo9y8P47wxzaH-nzy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 222e1eee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:32 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:56:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 3/7] reftable/system: stop depending on "hash.h"
Message-ID: <b595668a5cdae0dff4a7271a3547c5821aa6e912.1729677003.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

We include "hash.h" in "reftable/system.h" such that we can use hash
format IDs as well as the raw size of SHA1 and SHA256. As we are in the
process of converting the reftable library to become standalone we of
course cannot rely on those constants anymore.

Introduce a new `enum reftable_hash` to replace internal uses of the
hash format IDs and new constants that replace internal uses of the hash
size. Adapt the reftable backend to set up the correct hash function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c             | 12 +++++-
 reftable/basics.c                   | 13 ++++---
 reftable/basics.h                   |  2 +-
 reftable/merged.c                   |  4 +-
 reftable/merged.h                   |  3 +-
 reftable/reader.c                   |  8 ++--
 reftable/reader.h                   |  4 +-
 reftable/reftable-basics.h          | 13 +++++++
 reftable/reftable-merged.h          |  4 +-
 reftable/reftable-reader.h          |  2 +-
 reftable/reftable-record.h          | 12 +++---
 reftable/reftable-writer.h          |  2 +-
 reftable/stack.c                    |  4 +-
 reftable/system.h                   |  3 --
 reftable/writer.c                   |  8 ++--
 t/helper/test-reftable.c            |  4 +-
 t/unit-tests/lib-reftable.c         |  4 +-
 t/unit-tests/lib-reftable.h         |  2 +-
 t/unit-tests/t-reftable-block.c     | 40 +++++++++----------
 t/unit-tests/t-reftable-merged.c    | 26 ++++++-------
 t/unit-tests/t-reftable-pq.c        |  2 +-
 t/unit-tests/t-reftable-reader.c    |  4 +-
 t/unit-tests/t-reftable-readwrite.c | 40 +++++++++----------
 t/unit-tests/t-reftable-record.c    | 59 +++++++++++++++--------------
 t/unit-tests/t-reftable-stack.c     | 34 ++++++++---------
 25 files changed, 166 insertions(+), 143 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3c6107c7ce5..7d86d920970 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -15,6 +15,7 @@
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"
+#include "../reftable/reftable-basics.h"
 #include "../reftable/reftable-stack.h"
 #include "../reftable/reftable-record.h"
 #include "../reftable/reftable-error.h"
@@ -289,7 +290,16 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
-	refs->write_options.hash_id = repo->hash_algo->format_id;
+	switch (repo->hash_algo->format_id) {
+	case GIT_SHA1_FORMAT_ID:
+		refs->write_options.hash_id = REFTABLE_HASH_SHA1;
+		break;
+	case GIT_SHA256_FORMAT_ID:
+		refs->write_options.hash_id = REFTABLE_HASH_SHA256;
+		break;
+	default:
+		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
+	}
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
diff --git a/reftable/basics.c b/reftable/basics.c
index bc4fcc91446..7d84a5d62de 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -271,14 +271,15 @@ int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
 	return p;
 }
 
-int hash_size(uint32_t id)
+int hash_size(enum reftable_hash id)
 {
+	if (!id)
+		return REFTABLE_HASH_SIZE_SHA1;
 	switch (id) {
-	case 0:
-	case GIT_SHA1_FORMAT_ID:
-		return GIT_SHA1_RAWSZ;
-	case GIT_SHA256_FORMAT_ID:
-		return GIT_SHA256_RAWSZ;
+	case REFTABLE_HASH_SHA1:
+		return REFTABLE_HASH_SIZE_SHA1;
+	case REFTABLE_HASH_SHA256:
+		return REFTABLE_HASH_SIZE_SHA256;
 	}
 	abort();
 }
diff --git a/reftable/basics.h b/reftable/basics.h
index 86141602e74..0b77d047ada 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -148,7 +148,7 @@ char *reftable_strdup(const char *str);
 /* Find the longest shared prefix size of `a` and `b` */
 int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
-int hash_size(uint32_t id);
+int hash_size(enum reftable_hash id);
 
 /*
  * Format IDs that identify the hash function used by a reftable. Note that
diff --git a/reftable/merged.c b/reftable/merged.c
index 514d6facf45..5b93e20f429 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -181,7 +181,7 @@ static void iterator_from_merged_iter(struct reftable_iterator *it,
 
 int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_reader **readers, size_t n,
-			      uint32_t hash_id)
+			      enum reftable_hash hash_id)
 {
 	struct reftable_merged_table *m = NULL;
 	uint64_t last_max = 0;
@@ -293,7 +293,7 @@ int reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
 	return merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
 }
 
-uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
+enum reftable_hash reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
 }
diff --git a/reftable/merged.h b/reftable/merged.h
index 89bd0c4b35b..13a5fe4154e 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -10,11 +10,12 @@ license that can be found in the LICENSE file or at
 #define MERGED_H
 
 #include "system.h"
+#include "basics.h"
 
 struct reftable_merged_table {
 	struct reftable_reader **readers;
 	size_t readers_len;
-	uint32_t hash_id;
+	enum reftable_hash hash_id;
 
 	/* If unset, produce deletions. This is useful for compaction. For the
 	 * full stack, deletions should be produced. */
diff --git a/reftable/reader.c b/reftable/reader.c
index 64eb6938efe..ea82955c9bc 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -67,7 +67,7 @@ static int reader_get_block(struct reftable_reader *r,
 	return block_source_read_block(&r->source, dest, off, sz);
 }
 
-uint32_t reftable_reader_hash_id(struct reftable_reader *r)
+enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r)
 {
 	return r->hash_id;
 }
@@ -107,14 +107,14 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	f += 8;
 
 	if (r->version == 1) {
-		r->hash_id = GIT_SHA1_FORMAT_ID;
+		r->hash_id = REFTABLE_HASH_SHA1;
 	} else {
 		switch (get_be32(f)) {
 		case REFTABLE_FORMAT_ID_SHA1:
-			r->hash_id = GIT_SHA1_FORMAT_ID;
+			r->hash_id = REFTABLE_HASH_SHA1;
 			break;
 		case REFTABLE_FORMAT_ID_SHA256:
-			r->hash_id = GIT_SHA256_FORMAT_ID;
+			r->hash_id = REFTABLE_HASH_SHA256;
 			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
diff --git a/reftable/reader.h b/reftable/reader.h
index 010fbfe8511..d2b48a48499 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -37,8 +37,8 @@ struct reftable_reader {
 	/* Size of the file, excluding the footer. */
 	uint64_t size;
 
-	/* 'sha1' for SHA1, 's256' for SHA-256 */
-	uint32_t hash_id;
+	/* The hash function used for ref records. */
+	enum reftable_hash hash_id;
 
 	uint32_t block_size;
 	uint64_t min_update_index;
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
index 6e8e636b716..e0397ed5836 100644
--- a/reftable/reftable-basics.h
+++ b/reftable/reftable-basics.h
@@ -11,6 +11,19 @@
 
 #include <stddef.h>
 
+/*
+ * Hash functions understood by the reftable library. Note that the values are
+ * arbitrary and somewhat random such that we can easily detect cases where the
+ * hash hasn't been properly set up.
+ */
+enum reftable_hash {
+	REFTABLE_HASH_SHA1   = 89,
+	REFTABLE_HASH_SHA256 = 247,
+};
+#define REFTABLE_HASH_SIZE_SHA1   20
+#define REFTABLE_HASH_SIZE_SHA256 32
+#define REFTABLE_HASH_SIZE_MAX    REFTABLE_HASH_SIZE_SHA256
+
 /* Overrides the functions to use for memory management. */
 void reftable_set_alloc(void *(*malloc)(size_t),
 			void *(*realloc)(void *, size_t), void (*free)(void *));
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index a970d5dd89a..f2d01c3ef82 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -34,7 +34,7 @@ struct reftable_reader;
  */
 int reftable_merged_table_new(struct reftable_merged_table **dest,
 			      struct reftable_reader **readers, size_t n,
-			      uint32_t hash_id);
+			      enum reftable_hash hash_id);
 
 /* Initialize a merged table iterator for reading refs. */
 int reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
@@ -56,6 +56,6 @@ reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
 void reftable_merged_table_free(struct reftable_merged_table *m);
 
 /* return the hash ID of the merged table. */
-uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
+enum reftable_hash reftable_merged_table_hash_id(struct reftable_merged_table *m);
 
 #endif
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 6a2d0b693f5..0085fbb9032 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -54,7 +54,7 @@ int reftable_reader_init_log_iterator(struct reftable_reader *r,
 				      struct reftable_iterator *it);
 
 /* returns the hash ID used in this table. */
-uint32_t reftable_reader_hash_id(struct reftable_reader *r);
+enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r);
 
 /* return an iterator for the refs pointing to `oid`. */
 int reftable_reader_refs_for(struct reftable_reader *r,
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 2d42463c581..ddd48eb5798 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -9,7 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
 
-#include "hash.h"
+#include "reftable-basics.h"
 #include <stdint.h>
 
 /*
@@ -40,10 +40,10 @@ struct reftable_ref_record {
 #define REFTABLE_NR_REF_VALUETYPES 4
 	} value_type;
 	union {
-		unsigned char val1[GIT_MAX_RAWSZ];
+		unsigned char val1[REFTABLE_HASH_SIZE_MAX];
 		struct {
-			unsigned char value[GIT_MAX_RAWSZ]; /* first hash  */
-			unsigned char target_value[GIT_MAX_RAWSZ]; /* second hash */
+			unsigned char value[REFTABLE_HASH_SIZE_MAX]; /* first hash  */
+			unsigned char target_value[REFTABLE_HASH_SIZE_MAX]; /* second hash */
 		} val2;
 		char *symref; /* referent, malloced 0-terminated string */
 	} value;
@@ -85,8 +85,8 @@ struct reftable_log_record {
 
 	union {
 		struct {
-			unsigned char new_hash[GIT_MAX_RAWSZ];
-			unsigned char old_hash[GIT_MAX_RAWSZ];
+			unsigned char new_hash[REFTABLE_HASH_SIZE_MAX];
+			unsigned char old_hash[REFTABLE_HASH_SIZE_MAX];
 			char *name;
 			char *email;
 			uint64_t time;
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index e4fc9537883..211860d08a4 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -33,7 +33,7 @@ struct reftable_write_options {
 	/* 4-byte identifier ("sha1", "s256") of the hash.
 	 * Defaults to SHA1 if unset
 	 */
-	uint32_t hash_id;
+	enum reftable_hash hash_id;
 
 	/* Default mode for creating files. If unset, use 0666 (+umask) */
 	unsigned int default_permissions;
diff --git a/reftable/stack.c b/reftable/stack.c
index c33979536ef..9ae716ff375 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -73,7 +73,7 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 	if (_opts)
 		opts = *_opts;
 	if (opts.hash_id == 0)
-		opts.hash_id = GIT_SHA1_FORMAT_ID;
+		opts.hash_id = REFTABLE_HASH_SHA1;
 
 	*dest = NULL;
 
@@ -1603,7 +1603,7 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 
 static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 {
-	int version = (st->opts.hash_id == GIT_SHA1_FORMAT_ID) ? 1 : 2;
+	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
 	int overhead = header_size(version) - 1;
 	uint64_t *sizes;
 
diff --git a/reftable/system.h b/reftable/system.h
index 8564213475e..38d3534620e 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -14,8 +14,5 @@ license that can be found in the LICENSE file or at
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "tempfile.h"
-#include "hash.h" /* hash ID, sizes.*/
-
-int hash_size(uint32_t id);
 
 #endif
diff --git a/reftable/writer.c b/reftable/writer.c
index 9aa45de6340..ea2f831fc58 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -79,7 +79,7 @@ static void options_set_defaults(struct reftable_write_options *opts)
 	}
 
 	if (opts->hash_id == 0) {
-		opts->hash_id = GIT_SHA1_FORMAT_ID;
+		opts->hash_id = REFTABLE_HASH_SHA1;
 	}
 	if (opts->block_size == 0) {
 		opts->block_size = DEFAULT_BLOCK_SIZE;
@@ -88,7 +88,7 @@ static void options_set_defaults(struct reftable_write_options *opts)
 
 static int writer_version(struct reftable_writer *w)
 {
-	return (w->opts.hash_id == 0 || w->opts.hash_id == GIT_SHA1_FORMAT_ID) ?
+	return (w->opts.hash_id == 0 || w->opts.hash_id == REFTABLE_HASH_SHA1) ?
 			     1 :
 			     2;
 }
@@ -106,10 +106,10 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 		uint32_t hash_id;
 
 		switch (w->opts.hash_id) {
-		case GIT_SHA1_FORMAT_ID:
+		case REFTABLE_HASH_SHA1:
 			hash_id = REFTABLE_FORMAT_ID_SHA1;
 			break;
-		case GIT_SHA256_FORMAT_ID:
+		case REFTABLE_HASH_SHA256:
 			hash_id = REFTABLE_FORMAT_ID_SHA256;
 			break;
 		default:
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 5c8849d115b..3c72ed985b3 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -156,7 +156,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	int opt_dump_blocks = 0;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
-	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
+	uint32_t opt_hash_id = REFTABLE_HASH_SHA1;
 	const char *arg = NULL, *argv0 = argv[0];
 
 	for (; argc > 1; argv++, argc--)
@@ -167,7 +167,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 		else if (!strcmp("-t", argv[1]))
 			opt_dump_table = 1;
 		else if (!strcmp("-6", argv[1]))
-			opt_hash_id = GIT_SHA256_FORMAT_ID;
+			opt_hash_id = REFTABLE_HASH_SHA256;
 		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index 2ddf480588d..c1631f45275 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -3,7 +3,7 @@
 #include "reftable/constants.h"
 #include "reftable/writer.h"
 
-void t_reftable_set_hash(uint8_t *p, int i, uint32_t id)
+void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
 {
 	memset(p, (uint8_t)i, hash_size(id));
 }
@@ -82,7 +82,7 @@ void t_reftable_write_to_buf(struct reftable_buf *buf,
 		size_t off = i * (opts.block_size ? opts.block_size
 						  : DEFAULT_BLOCK_SIZE);
 		if (!off)
-			off = header_size(opts.hash_id == GIT_SHA256_FORMAT_ID ? 2 : 1);
+			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
 		check_char(buf->buf[off], ==, 'r');
 	}
 
diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
index d4950fed3da..e4c360fa7ee 100644
--- a/t/unit-tests/lib-reftable.h
+++ b/t/unit-tests/lib-reftable.h
@@ -6,7 +6,7 @@
 
 struct reftable_buf;
 
-void t_reftable_set_hash(uint8_t *p, int i, uint32_t id);
+void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
 
 struct reftable_writer *t_reftable_strbuf_writer(struct reftable_buf *buf,
 						 struct reftable_write_options *opts);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index f9af907117b..13e10807dae 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -36,7 +36,7 @@ static void t_ref_block_read_write(void)
 	block.len = block_size;
 	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
-				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
 	rec.u.ref.refname = (char *) "";
@@ -47,7 +47,7 @@ static void t_ref_block_read_write(void)
 	for (i = 0; i < N; i++) {
 		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
-		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
+		memset(rec.u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
 
 		recs[i] = rec;
 		ret = block_writer_add(&bw, &rec);
@@ -61,7 +61,7 @@ static void t_ref_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -72,7 +72,7 @@ static void t_ref_block_read_write(void)
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	for (i = 0; i < N; i++) {
@@ -85,7 +85,7 @@ static void t_ref_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -93,7 +93,7 @@ static void t_ref_block_read_write(void)
 
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	block_reader_release(&br);
@@ -130,7 +130,7 @@ static void t_log_block_read_write(void)
 	block.len = block_size;
 	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
-				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
 	for (i = 0; i < N; i++) {
@@ -150,7 +150,7 @@ static void t_log_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -161,7 +161,7 @@ static void t_log_block_read_write(void)
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	for (i = 0; i < N; i++) {
@@ -175,7 +175,7 @@ static void t_log_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -183,7 +183,7 @@ static void t_log_block_read_write(void)
 
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	block_reader_release(&br);
@@ -220,7 +220,7 @@ static void t_obj_block_read_write(void)
 	block.len = block_size;
 	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
-				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
 	for (i = 0; i < N; i++) {
@@ -242,7 +242,7 @@ static void t_obj_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -253,7 +253,7 @@ static void t_obj_block_read_write(void)
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	for (i = 0; i < N; i++) {
@@ -266,7 +266,7 @@ static void t_obj_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	block_reader_release(&br);
@@ -304,7 +304,7 @@ static void t_index_block_read_write(void)
 	block.len = block_size;
 	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
-				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+				header_off, hash_size(REFTABLE_HASH_SHA1));
 	check(!ret);
 
 	for (i = 0; i < N; i++) {
@@ -326,7 +326,7 @@ static void t_index_block_read_write(void)
 
 	block_writer_release(&bw);
 
-	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
+	block_reader_init(&br, &block, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
 	block_iter_seek_start(&it, &br);
 
@@ -337,7 +337,7 @@ static void t_index_block_read_write(void)
 			check_int(i, ==, N);
 			break;
 		}
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	for (i = 0; i < N; i++) {
@@ -350,7 +350,7 @@ static void t_index_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 
-		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -358,7 +358,7 @@ static void t_index_block_read_write(void)
 
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
-		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	block_reader_release(&br);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 484c18251f3..0573d9470a6 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -42,7 +42,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 		check(!err);
 	}
 
-	err = reftable_merged_table_new(&mt, *readers, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
 	check(!err);
 	return mt;
 }
@@ -91,7 +91,7 @@ static void t_merged_single_record(void)
 
 	err = reftable_iterator_next_ref(&it, &ref);
 	check(!err);
-	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 3);
@@ -168,7 +168,7 @@ static void t_merged_refs(void)
 	check(!err);
 	err = reftable_iterator_seek_ref(&it, "a");
 	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
+	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
@@ -186,7 +186,7 @@ static void t_merged_refs(void)
 	check_int(ARRAY_SIZE(want), ==, len);
 	for (i = 0; i < len; i++)
 		check(reftable_ref_record_equal(want[i], &out[i],
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 	for (i = 0; i < len; i++)
 		reftable_ref_record_release(&out[i]);
 	reftable_free(out);
@@ -252,12 +252,12 @@ static void t_merged_seek_multiple_times(void)
 
 		err = reftable_iterator_next_ref(&it, &rec);
 		check(!err);
-		err = reftable_ref_record_equal(&rec, &r1[1], GIT_SHA1_RAWSZ);
+		err = reftable_ref_record_equal(&rec, &r1[1], REFTABLE_HASH_SIZE_SHA1);
 		check(err == 1);
 
 		err = reftable_iterator_next_ref(&it, &rec);
 		check(!err);
-		err = reftable_ref_record_equal(&rec, &r2[1], GIT_SHA1_RAWSZ);
+		err = reftable_ref_record_equal(&rec, &r2[1], REFTABLE_HASH_SIZE_SHA1);
 		check(err == 1);
 
 		err = reftable_iterator_next_ref(&it, &rec);
@@ -300,7 +300,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 		check(!err);
 	}
 
-	err = reftable_merged_table_new(&mt, *readers, n, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
 	check(!err);
 	return mt;
 }
@@ -377,7 +377,7 @@ static void t_merged_logs(void)
 	check(!err);
 	err = reftable_iterator_seek_log(&it, "a");
 	check(!err);
-	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
+	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
@@ -395,7 +395,7 @@ static void t_merged_logs(void)
 	check_int(ARRAY_SIZE(want), ==, len);
 	for (i = 0; i < len; i++)
 		check(reftable_log_record_equal(want[i], &out[i],
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 
 	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	check(!err);
@@ -404,7 +404,7 @@ static void t_merged_logs(void)
 	reftable_log_record_release(&out[0]);
 	err = reftable_iterator_next_log(&it, &out[0]);
 	check(!err);
-	check(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
+	check(reftable_log_record_equal(&out[0], &r3[0], REFTABLE_HASH_SIZE_SHA1));
 	reftable_iterator_destroy(&it);
 
 	for (i = 0; i < len; i++)
@@ -448,11 +448,11 @@ static void t_default_write_opts(void)
 	check(!err);
 
 	hash_id = reftable_reader_hash_id(rd);
-	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
+	check_int(hash_id, ==, REFTABLE_HASH_SHA1);
 
-	err = reftable_merged_table_new(&merged, &rd, 1, GIT_SHA256_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA256);
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
-	err = reftable_merged_table_new(&merged, &rd, 1, GIT_SHA1_FORMAT_ID);
+	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1);
 	check(!err);
 
 	reftable_reader_decref(rd);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index ada4c19f18a..272da05bea6 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -132,7 +132,7 @@ static void t_merged_iter_pqueue_top(void)
 
 		merged_iter_pqueue_check(&pq);
 		check(pq_entry_equal(&top, &e));
-		check(reftable_record_equal(top.rec, &recs[i], GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(top.rec, &recs[i], REFTABLE_HASH_SIZE_SHA1));
 		for (size_t j = 0; i < pq.len; j++) {
 			check(pq_less(&top, &pq.heap[j]));
 			check_int(top.index, >, j);
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
index 19cb53b6415..546df6005e4 100644
--- a/t/unit-tests/t-reftable-reader.c
+++ b/t/unit-tests/t-reftable-reader.c
@@ -31,7 +31,7 @@ static int t_reader_seek_once(void)
 	ret = reftable_iterator_next_ref(&it, &ref);
 	check(!ret);
 
-	ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
+	ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
 	check_int(ret, ==, 1);
 
 	ret = reftable_iterator_next_ref(&it, &ref);
@@ -74,7 +74,7 @@ static int t_reader_reseek(void)
 		ret = reftable_iterator_next_ref(&it, &ref);
 		check(!ret);
 
-		ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
+		ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
 		check_int(ret, ==, 1);
 
 		ret = reftable_iterator_next_ref(&it, &ref);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index d279b86df0a..57896922eb1 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -41,7 +41,7 @@ static void t_buffer(void)
 }
 
 static void write_table(char ***names, struct reftable_buf *buf, int N,
-			int block_size, uint32_t hash_id)
+			int block_size, enum reftable_hash hash_id)
 {
 	struct reftable_write_options opts = {
 		.block_size = block_size,
@@ -62,7 +62,7 @@ static void write_table(char ***names, struct reftable_buf *buf, int N,
 		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
 		refs[i].update_index = update_index;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -70,7 +70,7 @@ static void write_table(char ***names, struct reftable_buf *buf, int N,
 		logs[i].update_index = update_index;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		t_reftable_set_hash(logs[i].value.update.new_hash, i,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 		logs[i].value.update.message = (char *) "message";
 	}
 
@@ -104,7 +104,7 @@ static void t_log_buffer_size(void)
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
 	*/
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < REFTABLE_HASH_SIZE_SHA1; i++) {
 		log.value.update.old_hash[i] = (uint8_t)(git_rand() % 256);
 		log.value.update.new_hash[i] = (uint8_t)(git_rand() % 256);
 	}
@@ -191,9 +191,9 @@ static void t_log_write_read(void)
 		log.update_index = i;
 		log.value_type = REFTABLE_LOG_UPDATE;
 		t_reftable_set_hash(log.value.update.old_hash, i,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 		t_reftable_set_hash(log.value.update.new_hash, i + 1,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 
 		err = reftable_writer_add_log(w, &log);
 		check(!err);
@@ -326,7 +326,7 @@ static void t_table_read_write_sequential(void)
 	int err = 0;
 	int j = 0;
 
-	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
+	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
 
 	block_source_from_buf(&source, &buf);
 
@@ -361,7 +361,7 @@ static void t_table_write_small_table(void)
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int N = 1;
-	write_table(&names, &buf, N, 4096, GIT_SHA1_FORMAT_ID);
+	write_table(&names, &buf, N, 4096, REFTABLE_HASH_SHA1);
 	check_int(buf.len, <, 200);
 	reftable_buf_release(&buf);
 	free_names(names);
@@ -378,7 +378,7 @@ static void t_table_read_api(void)
 	struct reftable_log_record log = { 0 };
 	struct reftable_iterator it = { 0 };
 
-	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
+	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
 
 	block_source_from_buf(&source, &buf);
 
@@ -400,7 +400,7 @@ static void t_table_read_api(void)
 	reftable_buf_release(&buf);
 }
 
-static void t_table_read_write_seek(int index, int hash_id)
+static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
 {
 	char **names;
 	struct reftable_buf buf = REFTABLE_BUF_INIT;
@@ -467,24 +467,24 @@ static void t_table_read_write_seek(int index, int hash_id)
 
 static void t_table_read_write_seek_linear(void)
 {
-	t_table_read_write_seek(0, GIT_SHA1_FORMAT_ID);
+	t_table_read_write_seek(0, REFTABLE_HASH_SHA1);
 }
 
 static void t_table_read_write_seek_linear_sha256(void)
 {
-	t_table_read_write_seek(0, GIT_SHA256_FORMAT_ID);
+	t_table_read_write_seek(0, REFTABLE_HASH_SHA256);
 }
 
 static void t_table_read_write_seek_index(void)
 {
-	t_table_read_write_seek(1, GIT_SHA1_FORMAT_ID);
+	t_table_read_write_seek(1, REFTABLE_HASH_SHA1);
 }
 
 static void t_table_refs_for(int indexed)
 {
 	char **want_names;
 	int want_names_len = 0;
-	uint8_t want_hash[GIT_SHA1_RAWSZ];
+	uint8_t want_hash[REFTABLE_HASH_SIZE_SHA1];
 
 	struct reftable_write_options opts = {
 		.block_size = 256,
@@ -500,10 +500,10 @@ static void t_table_refs_for(int indexed)
 	want_names = reftable_calloc(N + 1, sizeof(*want_names));
 	check(want_names != NULL);
 
-	t_reftable_set_hash(want_hash, 4, GIT_SHA1_FORMAT_ID);
+	t_reftable_set_hash(want_hash, 4, REFTABLE_HASH_SHA1);
 
 	for (i = 0; i < N; i++) {
-		uint8_t hash[GIT_SHA1_RAWSZ];
+		uint8_t hash[REFTABLE_HASH_SIZE_SHA1];
 		char fill[51] = { 0 };
 		char name[100];
 		struct reftable_ref_record ref = { 0 };
@@ -517,9 +517,9 @@ static void t_table_refs_for(int indexed)
 
 		ref.value_type = REFTABLE_REF_VAL2;
 		t_reftable_set_hash(ref.value.val2.value, i / 4,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 		t_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 
 		/* 80 bytes / entry, so 3 entries per block. Yields 17
 		 */
@@ -527,8 +527,8 @@ static void t_table_refs_for(int indexed)
 		n = reftable_writer_add_ref(w, &ref);
 		check_int(n, ==, 0);
 
-		if (!memcmp(ref.value.val2.value, want_hash, GIT_SHA1_RAWSZ) ||
-		    !memcmp(ref.value.val2.target_value, want_hash, GIT_SHA1_RAWSZ))
+		if (!memcmp(ref.value.val2.value, want_hash, REFTABLE_HASH_SIZE_SHA1) ||
+		    !memcmp(ref.value.val2.target_value, want_hash, REFTABLE_HASH_SIZE_SHA1))
 			want_names[want_names_len++] = xstrdup(name);
 	}
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index eb98bf2da91..42bc64cec87 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -7,6 +7,7 @@
 */
 
 #include "test-lib.h"
+#include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
 
@@ -17,10 +18,10 @@ static void t_copy(struct reftable_record *rec)
 
 	typ = reftable_record_type(rec);
 	reftable_record_init(&copy, typ);
-	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
+	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
 	/* do it twice to catch memory leaks */
-	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
-	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
+	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
+	check(reftable_record_equal(rec, &copy, REFTABLE_HASH_SIZE_SHA1));
 
 	reftable_record_release(&copy);
 }
@@ -59,7 +60,7 @@ static void t_varint_roundtrip(void)
 
 static void set_hash(uint8_t *h, int j)
 {
-	for (int i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++)
+	for (int i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
 		h[i] = (j >> i) & 0xff;
 }
 
@@ -84,14 +85,14 @@ static void t_reftable_ref_record_comparison(void)
 		},
 	};
 
-	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 
-	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
 	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
-	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
@@ -155,15 +156,15 @@ static void t_reftable_ref_record_roundtrip(void)
 		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
 
 		reftable_record_key(&in, &key);
-		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
+		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
 		check_int(n, >, 0);
 
 		/* decode into a non-zero reftable_record to test for leaks. */
-		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ, &scratch);
+		m = reftable_record_decode(&out, key, i, dest, REFTABLE_HASH_SIZE_SHA1, &scratch);
 		check_int(n, ==, m);
 
 		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 		reftable_record_release(&in);
 
 		reftable_buf_release(&key);
@@ -193,15 +194,15 @@ static void t_reftable_log_record_comparison(void)
 		},
 	};
 
-	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
-	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
+	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
 	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
 	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
-	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
@@ -303,15 +304,15 @@ static void t_reftable_log_record_roundtrip(void)
 
 		reftable_record_key(&rec, &key);
 
-		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
+		n = reftable_record_encode(&rec, dest, REFTABLE_HASH_SIZE_SHA1);
 		check_int(n, >=, 0);
 		valtype = reftable_record_val_type(&rec);
 		m = reftable_record_decode(&out, key, valtype, dest,
-					   GIT_SHA1_RAWSZ, &scratch);
+					   REFTABLE_HASH_SIZE_SHA1, &scratch);
 		check_int(n, ==, m);
 
 		check(reftable_log_record_equal(&in[i], &out.u.log,
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 		reftable_log_record_release(&in[i]);
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
@@ -380,20 +381,20 @@ static void t_reftable_obj_record_comparison(void)
 		},
 	};
 
-	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 
-	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
 	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
-	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 }
 
 static void t_reftable_obj_record_roundtrip(void)
 {
-	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
+	uint8_t testHash1[REFTABLE_HASH_SIZE_SHA1] = { 1, 2, 3, 4, 0 };
 	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
 	struct reftable_obj_record recs[3] = {
 		{
@@ -435,14 +436,14 @@ static void t_reftable_obj_record_roundtrip(void)
 		check(!reftable_record_is_deletion(&in));
 		t_copy(&in);
 		reftable_record_key(&in, &key);
-		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
+		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
 		check_int(n, >, 0);
 		extra = reftable_record_val_type(&in);
 		m = reftable_record_decode(&out, key, extra, dest,
-					   GIT_SHA1_RAWSZ, &scratch);
+					   REFTABLE_HASH_SIZE_SHA1, &scratch);
 		check_int(n, ==, m);
 
-		check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
+		check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
 		reftable_buf_release(&key);
 		reftable_record_release(&out);
 	}
@@ -473,14 +474,14 @@ static void t_reftable_index_record_comparison(void)
 	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
 	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
 
-	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 
-	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
+	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
 	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
-	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_cmp(&in[0], &in[1]));
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
@@ -516,15 +517,15 @@ static void t_reftable_index_record_roundtrip(void)
 
 	check(!reftable_record_is_deletion(&in));
 	check(!reftable_buf_cmp(&key, &in.u.idx.last_key));
-	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
+	n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
 	check_int(n, >, 0);
 
 	extra = reftable_record_val_type(&in);
-	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ,
+	m = reftable_record_decode(&out, key, extra, dest, REFTABLE_HASH_SIZE_SHA1,
 				   &scratch);
 	check_int(m, ==, n);
 
-	check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
+	check(reftable_record_equal(&in, &out, REFTABLE_HASH_SIZE_SHA1));
 
 	reftable_record_release(&out);
 	reftable_buf_release(&key);
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 1b4363a58fc..13fd8d8f941 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -121,7 +121,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 
 		snprintf(buf, sizeof(buf), "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
-		t_reftable_set_hash(ref.value.val1, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
 		check(!err);
@@ -169,7 +169,7 @@ static void t_reftable_stack_add_one(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
 	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
@@ -280,7 +280,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
 	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
@@ -340,7 +340,7 @@ static void t_reftable_stack_transaction_with_reload(void)
 	for (size_t i = 0; i < ARRAY_SIZE(refs); i++) {
 		err = reftable_stack_read_ref(st2, refs[i].refname, &ref);
 		check(!err);
-		check(reftable_ref_record_equal(&refs[i], &ref, GIT_SHA1_RAWSZ));
+		check(reftable_ref_record_equal(&refs[i], &ref, REFTABLE_HASH_SIZE_SHA1));
 	}
 
 	reftable_ref_record_release(&ref);
@@ -530,13 +530,13 @@ static void t_reftable_stack_add(void)
 		refs[i].refname = xstrdup(buf);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
 
 		logs[i].refname = xstrdup(buf);
 		logs[i].update_index = N + i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-		t_reftable_set_hash(logs[i].value.update.new_hash, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -562,7 +562,7 @@ static void t_reftable_stack_add(void)
 		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
 		check(!err);
 		check(reftable_ref_record_equal(&dest, refs + i,
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 		reftable_ref_record_release(&dest);
 	}
 
@@ -571,7 +571,7 @@ static void t_reftable_stack_add(void)
 		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
 		check(!err);
 		check(reftable_log_record_equal(&dest, logs + i,
-						 GIT_SHA1_RAWSZ));
+						 REFTABLE_HASH_SIZE_SHA1));
 		reftable_log_record_release(&dest);
 	}
 
@@ -622,14 +622,14 @@ static void t_reftable_stack_iterator(void)
 		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(refs[i].value.val1, i, REFTABLE_HASH_SHA1);
 
 		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		logs[i].update_index = i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("johndoe@invalid");
 		logs[i].value.update.message = xstrdup("commit\n");
-		t_reftable_set_hash(logs[i].value.update.new_hash, i, GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(logs[i].value.update.new_hash, i, REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -656,7 +656,7 @@ static void t_reftable_stack_iterator(void)
 		if (err > 0)
 			break;
 		check(!err);
-		check(reftable_ref_record_equal(&ref, &refs[i], GIT_SHA1_RAWSZ));
+		check(reftable_ref_record_equal(&ref, &refs[i], REFTABLE_HASH_SIZE_SHA1));
 		reftable_ref_record_release(&ref);
 	}
 	check_int(i, ==, N);
@@ -674,7 +674,7 @@ static void t_reftable_stack_iterator(void)
 		if (err > 0)
 			break;
 		check(!err);
-		check(reftable_log_record_equal(&log, &logs[i], GIT_SHA1_RAWSZ));
+		check(reftable_log_record_equal(&log, &logs[i], REFTABLE_HASH_SIZE_SHA1));
 		reftable_log_record_release(&log);
 	}
 	check_int(i, ==, N);
@@ -767,7 +767,7 @@ static void t_reftable_stack_tombstone(void)
 		if (i % 2 == 0) {
 			refs[i].value_type = REFTABLE_REF_VAL1;
 			t_reftable_set_hash(refs[i].value.val1, i,
-					    GIT_SHA1_FORMAT_ID);
+					    REFTABLE_HASH_SHA1);
 		}
 
 		logs[i].refname = xstrdup(buf);
@@ -776,7 +776,7 @@ static void t_reftable_stack_tombstone(void)
 		if (i % 2 == 0) {
 			logs[i].value_type = REFTABLE_LOG_UPDATE;
 			t_reftable_set_hash(logs[i].value.update.new_hash, i,
-					    GIT_SHA1_FORMAT_ID);
+					    REFTABLE_HASH_SHA1);
 			logs[i].value.update.email =
 				xstrdup("identity@invalid");
 		}
@@ -836,7 +836,7 @@ static void t_reftable_stack_hash_id(void)
 		.value.symref = (char *) "target",
 		.update_index = 1,
 	};
-	struct reftable_write_options opts32 = { .hash_id = GIT_SHA256_FORMAT_ID };
+	struct reftable_write_options opts32 = { .hash_id = REFTABLE_HASH_SHA256 };
 	struct reftable_stack *st32 = NULL;
 	struct reftable_write_options opts_default = { 0 };
 	struct reftable_stack *st_default = NULL;
@@ -859,7 +859,7 @@ static void t_reftable_stack_hash_id(void)
 	err = reftable_stack_read_ref(st_default, "master", &dest);
 	check(!err);
 
-	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
+	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
 	reftable_stack_destroy(st_default);
@@ -909,7 +909,7 @@ static void t_reflog_expire(void)
 		logs[i].value.update.time = i;
 		logs[i].value.update.email = xstrdup("identity@invalid");
 		t_reftable_set_hash(logs[i].value.update.new_hash, i,
-				    GIT_SHA1_FORMAT_ID);
+				    REFTABLE_HASH_SHA1);
 	}
 
 	for (i = 1; i <= N; i++) {
-- 
2.47.0.118.gfd3785337b.dirty

