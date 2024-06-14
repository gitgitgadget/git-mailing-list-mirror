Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661E1487D6
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347840; cv=none; b=Kb1UwhtIInHZ6zpWETQNr84hHTYFy84egNIDO8VmcAJUln9T2tMbzF12/x6ShBX8HI2Zb0HhaWQ1X6v/JU3/XjMuCIWnzy2h954Iq7Cr7FyMVGETWn+qEOMUHDkEq61iMxJgBIeao1D8Rs5NkuwD4095MVH66lEV4exeq/4hn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347840; c=relaxed/simple;
	bh=kL43dpDY6WpRsafk1r84+N09I2w4rwlbpz/a2p2oC9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXuzt+268HfRu8bcuX4NwPFc9GTW/7oyDTd5Hq7f0B6OjCVgf2neCUdBLBtc0d9zmQR6bfrNh5orPBYccSK2vRUSHvN3SEuGNvakWTlZU8p3JNSo6hNB8krC53d99fXu8FgtdDrAr9Dc0tm4HPXb/oHs9C/UkZ0o31FjE66i/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kmNBse/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GoGMX+MN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kmNBse/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoGMX+MN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id F376613803EE;
	Fri, 14 Jun 2024 02:50:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347836; x=1718434236; bh=iN9QLau8lD
	W/3Iow1OJD4XF10comS7Q6pxutXIsMgs4=; b=kmNBse/unzH21lw2p5YkbKAbue
	EBHXTQATO77qnrT6Irz6I87CWUX/GCvW0vEadtD5Ap+nIFUsSwY50FEC7IxTrtGM
	HRxeym2bmP6yrL8eJAlBSJT/drePb5lSlqnZ8yzrpzaS29uPwzLg2ncdT5t+lASJ
	XU0aCs8Ty/yLyezHZ0wY9C0kEkYPmQbSnAytWBGTv7nyeWIap16nwVttX7H7na3c
	G14Sbn+mcgqSqHwsqopEdAHmG9m8ODF1ZVL2w5ceU8nVo8y6q9tpblqp4R5eDvix
	mwgmC1H31ksX5y3IMARNsxdywTgLgOIHNkgGQeAMtGtDCnBOAeHyjqU4UIjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347836; x=1718434236; bh=iN9QLau8lDW/3Iow1OJD4XF10com
	S7Q6pxutXIsMgs4=; b=GoGMX+MNevcTKMzDba53+Wi+T6LRldYTAP4hQ4/ikQOe
	eRZD12t619MgtuAAsTF5huUKInYJMHQVdEnsCx3X2BalmPIEtHneX0LF8mijltbY
	zJuxZTarPY4yuFb3Cl9RYsc18Fqh32FoGrwXN2zTo+67x0yao9XIPJIyIO135qdk
	t79xBN37QfvSBd64jLQtBACNcw0Uhcsj5EGjoCc6yi5+hF4RkfhF4zs6QDJUxjUI
	NC3jU5fQyEyo4eP5L8kqcrMjyJbz0FPHzB9Llv639w9nNjTmvaoV7xpUAZ1vOG4q
	QfyQuOwgLtxdTtNfhq5V2ssr1XQHr5oR8/4KIBxdrA==
X-ME-Sender: <xms:POhrZoLu8oFk_AaCRVBHcoPz6qaaQ5-2btUGLs4xriww5aOfUzmFVA>
    <xme:POhrZoJ1hnpRJCQuMcurQ10fAwnnrWbUUnu0AsE4w2w8EZqpj8TtxPpv3vYbqSLsC
    QMXMMQ570QFwxKzAQ>
X-ME-Received: <xmr:POhrZossCwDMm0Zmq1aHJ1syoFzmFkk-9PQRg9jBGA91oJyEKoYczOV_Wcxb46r9SNrQ1hkPX6x4vRLRO0-N_VKjFmL0MfvwYNZypKYu19bwmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:POhrZlZFzu1ps91m5GJugr7mr3exZvLfn5ybxVGvdV7nU7EIGMA8Fg>
    <xmx:POhrZvaNqk7iRdmcMF0q9t_sV6yggb-byX7CMaksOHlVPaE1TPmr0g>
    <xmx:POhrZhAS2G04NBOc5jxgI5B-ywbTBndn5vSRzy7OyE_SPA37Npu4IA>
    <xmx:POhrZlail97bIqrKsHdMD6o1g7R2QMsmEvRjpavzSQB6y2jJ0F1zfQ>
    <xmx:POhrZqyWOBH0A21uX6JoU4cZQCpRtTgv1n1dhukWL-q2DfXXS-YRtxC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0b8d1dec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:20 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/20] hash-ll: merge with "hash.h"
Message-ID: <fe4550ba0cc90f1be3863312089078912a26d588.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A4APWpkhj1S15o4T"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--A4APWpkhj1S15o4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "hash-ll.h" header was introduced via d1cbe1e6d8 (hash-ll.h: split
out of hash.h to remove dependency on repository.h, 2023-04-22) to make
explicit the split between hash-related functions that rely on the
global `the_repository`, and those that don't. This split is no longer
necessary now that we we have removed the reliance on `the_repository`.

Merge "hash-ll.h" back into "hash.h". This causes some code units to not
include "repository.h" anymore, which requires us to add some forward
declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.h                    |   2 +-
 bloom.c                    |   1 +
 checkout.h                 |   2 +-
 chunk-format.h             |   2 +-
 commit-graph.h             |   2 +
 compat/sha1-chunked.c      |   2 +-
 convert.h                  |   2 +-
 csum-file.h                |   2 +-
 diff.h                     |   2 +-
 diffcore.h                 |   2 +-
 dir.h                      |   2 +-
 hash-ll.h                  | 364 -------------------------------------
 hash.h                     | 362 +++++++++++++++++++++++++++++++++++-
 hex.h                      |   2 +-
 loose.h                    |   2 +
 merge-ort.h                |   2 +-
 object-file-convert.c      |   2 +-
 object.h                   |   2 +-
 oidmap.h                   |   2 +-
 oidtree.h                  |   2 +-
 packfile.h                 |   2 +
 protocol-caps.c            |   2 +-
 read-cache-ll.h            |   2 +-
 refs/ref-cache.h           |   2 +-
 reftable/dump.c            |   2 +-
 reftable/reftable-record.h |   2 +-
 reftable/system.h          |   2 +-
 remote.h                   |   2 +-
 reset.h                    |   2 +-
 resolve-undo.h             |   2 +-
 serve.c                    |   2 +-
 split-index.h              |   2 +-
 t/helper/test-hash-speed.c |   2 +-
 t/helper/test-sha1.c       |   2 +-
 t/helper/test-sha256.c     |   2 +-
 t/unit-tests/lib-oid.h     |   2 +-
 tree-diff.c                |   1 +
 tree-walk.h                |   2 +-
 xdiff-interface.h          |   2 +-
 39 files changed, 400 insertions(+), 398 deletions(-)
 delete mode 100644 hash-ll.h

diff --git a/apply.h b/apply.h
index 7cd38b1443..b9f18ce87d 100644
--- a/apply.h
+++ b/apply.h
@@ -1,7 +1,7 @@
 #ifndef APPLY_H
 #define APPLY_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "lockfile.h"
 #include "string-list.h"
 #include "strmap.h"
diff --git a/bloom.c b/bloom.c
index e529f7605c..bbf146fc30 100644
--- a/bloom.c
+++ b/bloom.c
@@ -6,6 +6,7 @@
 #include "commit-graph.h"
 #include "commit.h"
 #include "commit-slab.h"
+#include "repository.h"
=20
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
=20
diff --git a/checkout.h b/checkout.h
index ba15a13fb3..55920e7aeb 100644
--- a/checkout.h
+++ b/checkout.h
@@ -1,7 +1,7 @@
 #ifndef CHECKOUT_H
 #define CHECKOUT_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 /*
  * Check if the branch name uniquely matches a branch name on a remote
diff --git a/chunk-format.h b/chunk-format.h
index 14b76180ef..212a0a6af1 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -1,7 +1,7 @@
 #ifndef CHUNK_FORMAT_H
 #define CHUNK_FORMAT_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct hashfile;
 struct chunkfile;
diff --git a/commit-graph.h b/commit-graph.h
index e519cb81cb..6781940195 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -122,6 +122,8 @@ struct commit_graph *load_commit_graph_chain_fd_st(stru=
ct repository *r,
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb);
=20
+struct repo_settings;
+
 /*
  * Callers should initialize the repo_settings with prepare_repo_settings()
  * prior to calling parse_commit_graph().
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
index a4a6f930d7..0446f9983f 100644
--- a/compat/sha1-chunked.c
+++ b/compat/sha1-chunked.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t =
len)
 {
diff --git a/convert.h b/convert.h
index d925589444..0a6e4086b8 100644
--- a/convert.h
+++ b/convert.h
@@ -4,7 +4,7 @@
 #ifndef CONVERT_H
 #define CONVERT_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "string-list.h"
=20
 struct index_state;
diff --git a/csum-file.h b/csum-file.h
index bc5bec27ac..566e05cbd2 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,7 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "write-or-die.h"
=20
 struct progress;
diff --git a/diff.h b/diff.h
index 66bd8aeb29..9901c8ca8c 100644
--- a/diff.h
+++ b/diff.h
@@ -4,7 +4,7 @@
 #ifndef DIFF_H
 #define DIFF_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "pathspec.h"
 #include "strbuf.h"
=20
diff --git a/diffcore.h b/diffcore.h
index 5ffe4ec788..1701ed50b9 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,7 +4,7 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct diff_options;
 struct mem_pool;
diff --git a/dir.h b/dir.h
index 1398a53fb4..69a76d8bdd 100644
--- a/dir.h
+++ b/dir.h
@@ -1,7 +1,7 @@
 #ifndef DIR_H
 #define DIR_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "hashmap.h"
 #include "pathspec.h"
 #include "statinfo.h"
diff --git a/hash-ll.h b/hash-ll.h
deleted file mode 100644
index 3161c778b9..0000000000
--- a/hash-ll.h
+++ /dev/null
@@ -1,364 +0,0 @@
-#ifndef HASH_LL_H
-#define HASH_LL_H
-
-#if defined(SHA1_APPLE)
-#include <CommonCrypto/CommonDigest.h>
-#elif defined(SHA1_OPENSSL)
-#  include <openssl/sha.h>
-#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >=3D 3
-#    define SHA1_NEEDS_CLONE_HELPER
-#    include "sha1/openssl.h"
-#  endif
-#elif defined(SHA1_DC)
-#include "sha1dc_git.h"
-#else /* SHA1_BLK */
-#include "block-sha1/sha1.h"
-#endif
-
-#if defined(SHA256_NETTLE)
-#include "sha256/nettle.h"
-#elif defined(SHA256_GCRYPT)
-#define SHA256_NEEDS_CLONE_HELPER
-#include "sha256/gcrypt.h"
-#elif defined(SHA256_OPENSSL)
-#  include <openssl/sha.h>
-#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >=3D 3
-#    define SHA256_NEEDS_CLONE_HELPER
-#    include "sha256/openssl.h"
-#  endif
-#else
-#include "sha256/block/sha256.h"
-#endif
-
-#ifndef platform_SHA_CTX
-/*
- * platform's underlying implementation of SHA-1; could be OpenSSL,
- * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
- * SHA-1 header may have already defined platform_SHA_CTX for our
- * own implementations like block-sha1, so we list
- * the default for OpenSSL compatible SHA-1 implementations here.
- */
-#define platform_SHA_CTX	SHA_CTX
-#define platform_SHA1_Init	SHA1_Init
-#define platform_SHA1_Update	SHA1_Update
-#define platform_SHA1_Final    	SHA1_Final
-#endif
-
-#define git_SHA_CTX		platform_SHA_CTX
-#define git_SHA1_Init		platform_SHA1_Init
-#define git_SHA1_Update		platform_SHA1_Update
-#define git_SHA1_Final		platform_SHA1_Final
-
-#ifdef platform_SHA1_Clone
-#define git_SHA1_Clone	platform_SHA1_Clone
-#endif
-
-#ifndef platform_SHA256_CTX
-#define platform_SHA256_CTX	SHA256_CTX
-#define platform_SHA256_Init	SHA256_Init
-#define platform_SHA256_Update	SHA256_Update
-#define platform_SHA256_Final	SHA256_Final
-#endif
-
-#define git_SHA256_CTX		platform_SHA256_CTX
-#define git_SHA256_Init		platform_SHA256_Init
-#define git_SHA256_Update	platform_SHA256_Update
-#define git_SHA256_Final	platform_SHA256_Final
-
-#ifdef platform_SHA256_Clone
-#define git_SHA256_Clone	platform_SHA256_Clone
-#endif
-
-#ifdef SHA1_MAX_BLOCK_SIZE
-#include "compat/sha1-chunked.h"
-#undef git_SHA1_Update
-#define git_SHA1_Update		git_SHA1_Update_Chunked
-#endif
-
-#ifndef SHA1_NEEDS_CLONE_HELPER
-static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-#endif
-
-#ifndef SHA256_NEEDS_CLONE_HELPER
-static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_=
CTX *src)
-{
-	memcpy(dst, src, sizeof(*dst));
-}
-#endif
-
-/*
- * Note that these constants are suitable for indexing the hash_algos arra=
y and
- * comparing against each other, but are otherwise arbitrary, so they shou=
ld not
- * be exposed to the user or serialized to disk.  To know whether a
- * git_hash_algo struct points to some usable hash function, test the form=
at_id
- * field for being non-zero.  Use the name field for user-visible situatio=
ns and
- * the format_id field for fixed-length fields on disk.
- */
-/* An unknown hash function. */
-#define GIT_HASH_UNKNOWN 0
-/* SHA-1 */
-#define GIT_HASH_SHA1 1
-/* SHA-256  */
-#define GIT_HASH_SHA256 2
-/* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
-
-/* "sha1", big-endian */
-#define GIT_SHA1_FORMAT_ID 0x73686131
-
-/* The length in bytes and in hex digits of an object name (SHA-1 value). =
*/
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-/* The block size of SHA-1. */
-#define GIT_SHA1_BLKSZ 64
-
-/* "s256", big-endian */
-#define GIT_SHA256_FORMAT_ID 0x73323536
-
-/* The length in bytes and in hex digits of an object name (SHA-256 value)=
=2E */
-#define GIT_SHA256_RAWSZ 32
-#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
-/* The block size of SHA-256. */
-#define GIT_SHA256_BLKSZ 64
-
-/* The length in byte and in hex digits of the largest possible hash value=
=2E */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
-/* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;	/* XXX requires 4-byte alignment */
-};
-
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-#define GET_OID_HASH_ANY      020000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND =3D 0,
-	MISSING_OBJECT =3D -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS =3D -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK =3D -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP =3D -5,
-	NOT_DIR =3D -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
-/* A suitably aligned type for stack allocations of hash contexts. */
-union git_hash_ctx {
-	git_SHA_CTX sha1;
-	git_SHA256_CTX sha256;
-};
-typedef union git_hash_ctx git_hash_ctx;
-
-typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
-typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *s=
rc);
-typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size=
_t len);
-typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
-typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx =
*ctx);
-
-struct git_hash_algo {
-	/*
-	 * The name of the algorithm, as appears in the config file and in
-	 * messages.
-	 */
-	const char *name;
-
-	/* A four-byte version identifier, used in pack indices. */
-	uint32_t format_id;
-
-	/* The length of the hash in binary. */
-	size_t rawsz;
-
-	/* The length of the hash in hex characters. */
-	size_t hexsz;
-
-	/* The block size of the hash. */
-	size_t blksz;
-
-	/* The hash initialization function. */
-	git_hash_init_fn init_fn;
-
-	/* The hash context cloning function. */
-	git_hash_clone_fn clone_fn;
-
-	/* The hash update function. */
-	git_hash_update_fn update_fn;
-
-	/* The hash finalization function. */
-	git_hash_final_fn final_fn;
-
-	/* The hash finalization function for object IDs. */
-	git_hash_final_oid_fn final_oid_fn;
-
-	/* The OID of the empty tree. */
-	const struct object_id *empty_tree;
-
-	/* The OID of the empty blob. */
-	const struct object_id *empty_blob;
-
-	/* The all-zeros OID. */
-	const struct object_id *null_oid;
-};
-extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
-
-/*
- * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNO=
WN if
- * the name doesn't match a known algorithm.
- */
-int hash_algo_by_name(const char *name);
-/* Identical, except based on the format ID. */
-int hash_algo_by_id(uint32_t format_id);
-/* Identical, except based on the length. */
-int hash_algo_by_length(int len);
-/* Identical, except for a pointer to struct git_hash_algo. */
-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
-{
-	return p - hash_algos;
-}
-
-const struct object_id *null_oid(void);
-
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2, const struct git_hash_algo *algop)
-{
-	/*
-	 * Teach the compiler that there are only two possibilities of hash size
-	 * here, so that it can optimize for this case as much as possible.
-	 */
-	if (algop->rawsz =3D=3D GIT_MAX_RAWSZ)
-		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
-static inline int hasheq(const unsigned char *sha1, const unsigned char *s=
ha2, const struct git_hash_algo *algop)
-{
-	/*
-	 * We write this here instead of deferring to hashcmp so that the
-	 * compiler can properly inline it and avoid calling memcmp.
-	 */
-	if (algop->rawsz =3D=3D GIT_MAX_RAWSZ)
-		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
-	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
-}
-
-static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sh=
a_src,
-			   const struct git_hash_algo *algop)
-{
-	memcpy(sha_dst, sha_src, algop->rawsz);
-}
-
-static inline void hashclr(unsigned char *hash, const struct git_hash_algo=
 *algop)
-{
-	memset(hash, 0, algop->rawsz);
-}
-
-static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
-{
-	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
-}
-
-static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
-{
-	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
-}
-
-static inline void oidcpy(struct object_id *dst, const struct object_id *s=
rc)
-{
-	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
-	dst->algo =3D src->algo;
-}
-
-static inline void oidread(struct object_id *oid, const unsigned char *has=
h,
-			   const struct git_hash_algo *algop)
-{
-	memcpy(oid->hash, hash, algop->rawsz);
-	if (algop->rawsz < GIT_MAX_RAWSZ)
-		memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
-	oid->algo =3D hash_algo_by_ptr(algop);
-}
-
-static inline void oidclr(struct object_id *oid,
-			  const struct git_hash_algo *algop)
-{
-	memset(oid->hash, 0, GIT_MAX_RAWSZ);
-	oid->algo =3D hash_algo_by_ptr(algop);
-}
-
-static inline struct object_id *oiddup(const struct object_id *src)
-{
-	struct object_id *dst =3D xmalloc(sizeof(struct object_id));
-	oidcpy(dst, src);
-	return dst;
-}
-
-static inline void oid_set_algo(struct object_id *oid, const struct git_ha=
sh_algo *algop)
-{
-	oid->algo =3D hash_algo_by_ptr(algop);
-}
-
-/*
- * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
- * for use in hash tables. Cryptographic hashes are supposed to have
- * uniform distribution, so in contrast to `memhash()`, this just copies
- * the first `sizeof(int)` bytes without shuffling any bits. Note that
- * the results will be different on big-endian and little-endian
- * platforms, so they should not be stored or transferred over the net.
- */
-static inline unsigned int oidhash(const struct object_id *oid)
-{
-	/*
-	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
-	 * platforms that don't support unaligned reads.
-	 */
-	unsigned int hash;
-	memcpy(&hash, oid->hash, sizeof(hash));
-	return hash;
-}
-
-static inline int is_null_oid(const struct object_id *oid)
-{
-	static const unsigned char null_hash[GIT_MAX_RAWSZ];
-	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
-}
-
-const char *empty_tree_oid_hex(const struct git_hash_algo *algop);
-
-static inline int is_empty_blob_oid(const struct object_id *oid,
-				    const struct git_hash_algo *algop)
-{
-	return oideq(oid, algop->empty_blob);
-}
-
-static inline int is_empty_tree_oid(const struct object_id *oid,
-				    const struct git_hash_algo *algop)
-{
-	return oideq(oid, algop->empty_tree);
-}
-
-#endif
diff --git a/hash.h b/hash.h
index cb85d26a2f..72ffbc862e 100644
--- a/hash.h
+++ b/hash.h
@@ -1,11 +1,369 @@
 #ifndef HASH_H
 #define HASH_H
=20
-#include "hash-ll.h"
-#include "repository.h"
+#if defined(SHA1_APPLE)
+#include <CommonCrypto/CommonDigest.h>
+#elif defined(SHA1_OPENSSL)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >=3D 3
+#    define SHA1_NEEDS_CLONE_HELPER
+#    include "sha1/openssl.h"
+#  endif
+#elif defined(SHA1_DC)
+#include "sha1dc_git.h"
+#else /* SHA1_BLK */
+#include "block-sha1/sha1.h"
+#endif
+
+#if defined(SHA256_NETTLE)
+#include "sha256/nettle.h"
+#elif defined(SHA256_GCRYPT)
+#define SHA256_NEEDS_CLONE_HELPER
+#include "sha256/gcrypt.h"
+#elif defined(SHA256_OPENSSL)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >=3D 3
+#    define SHA256_NEEDS_CLONE_HELPER
+#    include "sha256/openssl.h"
+#  endif
+#else
+#include "sha256/block/sha256.h"
+#endif
+
+#ifndef platform_SHA_CTX
+/*
+ * platform's underlying implementation of SHA-1; could be OpenSSL,
+ * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
+ * SHA-1 header may have already defined platform_SHA_CTX for our
+ * own implementations like block-sha1, so we list
+ * the default for OpenSSL compatible SHA-1 implementations here.
+ */
+#define platform_SHA_CTX	SHA_CTX
+#define platform_SHA1_Init	SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define platform_SHA1_Final    	SHA1_Final
+#endif
+
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		platform_SHA1_Update
+#define git_SHA1_Final		platform_SHA1_Final
+
+#ifdef platform_SHA1_Clone
+#define git_SHA1_Clone	platform_SHA1_Clone
+#endif
+
+#ifndef platform_SHA256_CTX
+#define platform_SHA256_CTX	SHA256_CTX
+#define platform_SHA256_Init	SHA256_Init
+#define platform_SHA256_Update	SHA256_Update
+#define platform_SHA256_Final	SHA256_Final
+#endif
+
+#define git_SHA256_CTX		platform_SHA256_CTX
+#define git_SHA256_Init		platform_SHA256_Init
+#define git_SHA256_Update	platform_SHA256_Update
+#define git_SHA256_Final	platform_SHA256_Final
+
+#ifdef platform_SHA256_Clone
+#define git_SHA256_Clone	platform_SHA256_Clone
+#endif
+
+#ifdef SHA1_MAX_BLOCK_SIZE
+#include "compat/sha1-chunked.h"
+#undef git_SHA1_Update
+#define git_SHA1_Update		git_SHA1_Update_Chunked
+#endif
+
+#ifndef SHA1_NEEDS_CLONE_HELPER
+static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
+
+#ifndef SHA256_NEEDS_CLONE_HELPER
+static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_=
CTX *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
+
+/*
+ * Note that these constants are suitable for indexing the hash_algos arra=
y and
+ * comparing against each other, but are otherwise arbitrary, so they shou=
ld not
+ * be exposed to the user or serialized to disk.  To know whether a
+ * git_hash_algo struct points to some usable hash function, test the form=
at_id
+ * field for being non-zero.  Use the name field for user-visible situatio=
ns and
+ * the format_id field for fixed-length fields on disk.
+ */
+/* An unknown hash function. */
+#define GIT_HASH_UNKNOWN 0
+/* SHA-1 */
+#define GIT_HASH_SHA1 1
+/* SHA-256  */
+#define GIT_HASH_SHA256 2
+/* Number of algorithms supported (including unknown). */
+#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+
+/* "sha1", big-endian */
+#define GIT_SHA1_FORMAT_ID 0x73686131
+
+/* The length in bytes and in hex digits of an object name (SHA-1 value). =
*/
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
+
+/* "s256", big-endian */
+#define GIT_SHA256_FORMAT_ID 0x73323536
+
+/* The length in bytes and in hex digits of an object name (SHA-256 value)=
=2E */
+#define GIT_SHA256_RAWSZ 32
+#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
+/* The block size of SHA-256. */
+#define GIT_SHA256_BLKSZ 64
+
+/* The length in byte and in hex digits of the largest possible hash value=
=2E */
+#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
+
+struct object_id {
+	unsigned char hash[GIT_MAX_RAWSZ];
+	int algo;	/* XXX requires 4-byte alignment */
+};
+
+#define GET_OID_QUIETLY           01
+#define GET_OID_COMMIT            02
+#define GET_OID_COMMITTISH        04
+#define GET_OID_TREE             010
+#define GET_OID_TREEISH          020
+#define GET_OID_BLOB             040
+#define GET_OID_FOLLOW_SYMLINKS 0100
+#define GET_OID_RECORD_PATH     0200
+#define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
+#define GET_OID_HASH_ANY      020000
+
+#define GET_OID_DISAMBIGUATORS \
+	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
+	GET_OID_TREE | GET_OID_TREEISH | \
+	GET_OID_BLOB)
+
+enum get_oid_result {
+	FOUND =3D 0,
+	MISSING_OBJECT =3D -1, /* The requested object is missing */
+	SHORT_NAME_AMBIGUOUS =3D -2,
+	/* The following only apply when symlinks are followed */
+	DANGLING_SYMLINK =3D -4, /*
+				* The initial symlink is there, but
+				* (transitively) points to a missing
+				* in-tree file
+				*/
+	SYMLINK_LOOP =3D -5,
+	NOT_DIR =3D -6, /*
+		       * Somewhere along the symlink chain, a path is
+		       * requested which contains a file as a
+		       * non-final element.
+		       */
+};
=20
 #ifdef USE_THE_REPOSITORY_VARIABLE
+# include "repository.h"
 # define the_hash_algo the_repository->hash_algo
 #endif
=20
+/* A suitably aligned type for stack allocations of hash contexts. */
+union git_hash_ctx {
+	git_SHA_CTX sha1;
+	git_SHA256_CTX sha256;
+};
+typedef union git_hash_ctx git_hash_ctx;
+
+typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
+typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *s=
rc);
+typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size=
_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
+typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx =
*ctx);
+
+struct git_hash_algo {
+	/*
+	 * The name of the algorithm, as appears in the config file and in
+	 * messages.
+	 */
+	const char *name;
+
+	/* A four-byte version identifier, used in pack indices. */
+	uint32_t format_id;
+
+	/* The length of the hash in binary. */
+	size_t rawsz;
+
+	/* The length of the hash in hex characters. */
+	size_t hexsz;
+
+	/* The block size of the hash. */
+	size_t blksz;
+
+	/* The hash initialization function. */
+	git_hash_init_fn init_fn;
+
+	/* The hash context cloning function. */
+	git_hash_clone_fn clone_fn;
+
+	/* The hash update function. */
+	git_hash_update_fn update_fn;
+
+	/* The hash finalization function. */
+	git_hash_final_fn final_fn;
+
+	/* The hash finalization function for object IDs. */
+	git_hash_final_oid_fn final_oid_fn;
+
+	/* The OID of the empty tree. */
+	const struct object_id *empty_tree;
+
+	/* The OID of the empty blob. */
+	const struct object_id *empty_blob;
+
+	/* The all-zeros OID. */
+	const struct object_id *null_oid;
+};
+extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
+
+/*
+ * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNO=
WN if
+ * the name doesn't match a known algorithm.
+ */
+int hash_algo_by_name(const char *name);
+/* Identical, except based on the format ID. */
+int hash_algo_by_id(uint32_t format_id);
+/* Identical, except based on the length. */
+int hash_algo_by_length(int len);
+/* Identical, except for a pointer to struct git_hash_algo. */
+static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+{
+	return p - hash_algos;
+}
+
+const struct object_id *null_oid(void);
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *=
sha2, const struct git_hash_algo *algop)
+{
+	/*
+	 * Teach the compiler that there are only two possibilities of hash size
+	 * here, so that it can optimize for this case as much as possible.
+	 */
+	if (algop->rawsz =3D=3D GIT_MAX_RAWSZ)
+		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline int hasheq(const unsigned char *sha1, const unsigned char *s=
ha2, const struct git_hash_algo *algop)
+{
+	/*
+	 * We write this here instead of deferring to hashcmp so that the
+	 * compiler can properly inline it and avoid calling memcmp.
+	 */
+	if (algop->rawsz =3D=3D GIT_MAX_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
+}
+
+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sh=
a_src,
+			   const struct git_hash_algo *algop)
+{
+	memcpy(sha_dst, sha_src, algop->rawsz);
+}
+
+static inline void hashclr(unsigned char *hash, const struct git_hash_algo=
 *algop)
+{
+	memset(hash, 0, algop->rawsz);
+}
+
+static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
+{
+	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
+}
+
+static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
+{
+	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
+}
+
+static inline void oidcpy(struct object_id *dst, const struct object_id *s=
rc)
+{
+	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
+	dst->algo =3D src->algo;
+}
+
+static inline void oidread(struct object_id *oid, const unsigned char *has=
h,
+			   const struct git_hash_algo *algop)
+{
+	memcpy(oid->hash, hash, algop->rawsz);
+	if (algop->rawsz < GIT_MAX_RAWSZ)
+		memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
+	oid->algo =3D hash_algo_by_ptr(algop);
+}
+
+static inline void oidclr(struct object_id *oid,
+			  const struct git_hash_algo *algop)
+{
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+	oid->algo =3D hash_algo_by_ptr(algop);
+}
+
+static inline struct object_id *oiddup(const struct object_id *src)
+{
+	struct object_id *dst =3D xmalloc(sizeof(struct object_id));
+	oidcpy(dst, src);
+	return dst;
+}
+
+static inline void oid_set_algo(struct object_id *oid, const struct git_ha=
sh_algo *algop)
+{
+	oid->algo =3D hash_algo_by_ptr(algop);
+}
+
+/*
+ * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
+ * for use in hash tables. Cryptographic hashes are supposed to have
+ * uniform distribution, so in contrast to `memhash()`, this just copies
+ * the first `sizeof(int)` bytes without shuffling any bits. Note that
+ * the results will be different on big-endian and little-endian
+ * platforms, so they should not be stored or transferred over the net.
+ */
+static inline unsigned int oidhash(const struct object_id *oid)
+{
+	/*
+	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
+	 * platforms that don't support unaligned reads.
+	 */
+	unsigned int hash;
+	memcpy(&hash, oid->hash, sizeof(hash));
+	return hash;
+}
+
+static inline int is_null_oid(const struct object_id *oid)
+{
+	static const unsigned char null_hash[GIT_MAX_RAWSZ];
+	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
+}
+
+const char *empty_tree_oid_hex(const struct git_hash_algo *algop);
+
+static inline int is_empty_blob_oid(const struct object_id *oid,
+				    const struct git_hash_algo *algop)
+{
+	return oideq(oid, algop->empty_blob);
+}
+
+static inline int is_empty_tree_oid(const struct object_id *oid,
+				    const struct git_hash_algo *algop)
+{
+	return oideq(oid, algop->empty_tree);
+}
+
 #endif
diff --git a/hex.h b/hex.h
index e0b83f776f..9809667f33 100644
--- a/hex.h
+++ b/hex.h
@@ -1,7 +1,7 @@
 #ifndef HEX_H
 #define HEX_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "hex-ll.h"
=20
 /*
diff --git a/loose.h b/loose.h
index 2c2957072c..28512306e5 100644
--- a/loose.h
+++ b/loose.h
@@ -3,6 +3,8 @@
=20
 #include "khash.h"
=20
+struct repository;
+
 struct loose_object_map {
 	kh_oid_map_t *to_compat;
 	kh_oid_map_t *to_storage;
diff --git a/merge-ort.h b/merge-ort.h
index ce56ec1a78..a994c9a5fc 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,7 +2,7 @@
 #define MERGE_ORT_H
=20
 #include "merge-recursive.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct commit;
 struct tree;
diff --git a/object-file-convert.c b/object-file-convert.c
index 958f61f094..3887d6d57b 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -5,7 +5,7 @@
 #include "strbuf.h"
 #include "hex.h"
 #include "repository.h"
-#include "hash-ll.h"
+#include "hash.h"
 #include "hash.h"
 #include "object.h"
 #include "loose.h"
diff --git a/object.h b/object.h
index 73b4ec3904..9fa42d51d9 100644
--- a/object.h
+++ b/object.h
@@ -1,7 +1,7 @@
 #ifndef OBJECT_H
 #define OBJECT_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct buffer_slab;
 struct repository;
diff --git a/oidmap.h b/oidmap.h
index 05c673eb7c..fad412827a 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -1,7 +1,7 @@
 #ifndef OIDMAP_H
 #define OIDMAP_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "hashmap.h"
=20
 /*
diff --git a/oidtree.h b/oidtree.h
index 55c83513fd..77898f510a 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -2,7 +2,7 @@
 #define OIDTREE_H
=20
 #include "cbtree.h"
-#include "hash-ll.h"
+#include "hash.h"
 #include "mem-pool.h"
=20
 struct oidtree {
diff --git a/packfile.h b/packfile.h
index 28c8fd3e39..eb18ec15db 100644
--- a/packfile.h
+++ b/packfile.h
@@ -101,6 +101,8 @@ int close_pack_fd(struct packed_git *p);
=20
 uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
=20
+struct raw_object_store;
+
 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t,=
 unsigned long *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
diff --git a/protocol-caps.c b/protocol-caps.c
index 75f4cbb0a7..fe8d1d5c63 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -3,7 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
-#include "hash-ll.h"
+#include "hash.h"
 #include "hex.h"
 #include "object.h"
 #include "object-store-ll.h"
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 09414afd04..e0e39607ef 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -1,7 +1,7 @@
 #ifndef READ_CACHE_LL_H
 #define READ_CACHE_LL_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "hashmap.h"
 #include "statinfo.h"
=20
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 95c76e27c8..31ebe24f6c 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct ref_dir;
 struct ref_store;
diff --git a/reftable/dump.c b/reftable/dump.c
index 41abbb8ecf..dd65d9e8bb 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -7,7 +7,7 @@ license that can be found in the LICENSE file or at
 */
=20
 #include "git-compat-util.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 2a2943cd13..ff486eb1f7 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -9,7 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include <stdint.h>
=20
 /*
diff --git a/reftable/system.h b/reftable/system.h
index 5d8b6dede5..d0cabd5d17 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,7 +15,7 @@ license that can be found in the LICENSE file or at
 #include "lockfile.h"
 #include "strbuf.h"
 #include "tempfile.h"
-#include "hash-ll.h" /* hash ID, sizes.*/
+#include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
=20
 int hash_size(uint32_t id);
diff --git a/remote.h b/remote.h
index e8c6655e42..7d04e1be1b 100644
--- a/remote.h
+++ b/remote.h
@@ -1,7 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "hashmap.h"
 #include "refspec.h"
=20
diff --git a/reset.h b/reset.h
index 10708d8ddc..a28f81829d 100644
--- a/reset.h
+++ b/reset.h
@@ -1,7 +1,7 @@
 #ifndef RESET_H
 #define RESET_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "repository.h"
=20
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
diff --git a/resolve-undo.h b/resolve-undo.h
index f3f8462751..89a3227262 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -6,7 +6,7 @@ struct index_state;
 struct pathspec;
 struct string_list;
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/serve.c b/serve.c
index 33608ea4d5..884cd84ca8 100644
--- a/serve.c
+++ b/serve.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
-#include "hash-ll.h"
+#include "hash.h"
 #include "pkt-line.h"
 #include "version.h"
 #include "ls-refs.h"
diff --git a/split-index.h b/split-index.h
index 15a29cd08c..1a153f47ba 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct index_state;
 struct strbuf;
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index b235da594f..7de822af51 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 #define NUM_SECONDS 3
=20
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index dcb7f6c003..e60d000c03 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 int cmd__sha1(int ac, const char **av)
 {
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 08cf149001..2fb20438f3 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "hash-ll.h"
+#include "hash.h"
=20
 int cmd__sha256(int ac, const char **av)
 {
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
index bfde639190..8d2acca768 100644
--- a/t/unit-tests/lib-oid.h
+++ b/t/unit-tests/lib-oid.h
@@ -1,7 +1,7 @@
 #ifndef LIB_OID_H
 #define LIB_OID_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 /*
  * Convert arbitrary hex string to object_id.
diff --git a/tree-diff.c b/tree-diff.c
index 46107772d1..9252481df3 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "environment.h"
+#include "repository.h"
=20
 /*
  * Some mode bits are also used internally for computations.
diff --git a/tree-walk.h b/tree-walk.h
index 0b1067fbc5..aaea689f9a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,7 +1,7 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
=20
-#include "hash-ll.h"
+#include "hash.h"
=20
 struct index_state;
 struct repository;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 38537169b7..1ed430b622 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -1,7 +1,7 @@
 #ifndef XDIFF_INTERFACE_H
 #define XDIFF_INTERFACE_H
=20
-#include "hash-ll.h"
+#include "hash.h"
 #include "xdiff/xdiff.h"
=20
 /*
--=20
2.45.2.457.g8d94cfb545.dirty


--A4APWpkhj1S15o4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6DcACgkQVbJhu7ck
PpSN1A/8DPB9w6KkiKnUAK57iaZxYURMhWngpfnZN1DG1FFrNzxNYw7Ox33Pr12l
6RNfUYouO7pfRsvvSKHl4NiteMrdVqm9wOWhf8cIj614Jxxm0yLWha3jvMbr1TLo
z0LzfbOuRDxOIh3wAab79VJUApKirqpOvJFScNdxCw/ntGApVMGww02tvPW9+llH
y460UMnAzHYJWCFFxJ66KCSA0kqvwCXMMm7mBEyqmV/Q0ZiTavmOCM698PlDWRhY
o8NldjiZxCeJ6DkfohNmdOG98OttHE46AiECeIlWJXc9zk9Cr2dkd0fV4LRb6Iwa
8FSA44HbqDmrAvoyMFQvgkHjuOleC0lGyD9KcomB4Q9YtUKTT8Tz1rkfRm1gPRPO
6qYNGP48Dq2LovxborgQsWNmlgOx6DAJJdz0Sfz9KKXI5wGQCOezoEPW6rdlfYQW
YQZ1YfVuXfiXr3/LfIbnXwMVOtMq01FDfAsEcVxHduF6501KrBLJ0HBbb/VXcpes
1ORGZNjLUeG8XvTcs3rHkTHbSs6+F5nO1/iPbPAwhHVq7BsAMt4sELnnTYroJjgx
Gxn4cE5SgMn8yA8BH5sghBUZi+JdoSZBWOwO29lFuPBwkPAoaW4l1nfdXXuEM3/j
s/IypqsXxpxNVRgJLx4PUq8pWoxpCJP1uAKGipUXJkcQJbvPCeE=
=tzPR
-----END PGP SIGNATURE-----

--A4APWpkhj1S15o4T--
