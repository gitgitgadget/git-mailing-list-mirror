Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086D1A8C11
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524344; cv=none; b=qDkau0I4zhoxSlecfV05T6AFk11ylcjZu0I5yUiZXyfJZLCMYvkWiDg0nQXJnsuqNxzHiM3UC+7yL83EpRhQFM3etxvVC8862sGZERM/uZCBXSTgWCOgForqWj3ba4Z6pYkyzNys3Yg78l1ByKK4grACVX3UKCs0BmrQ5kXkyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524344; c=relaxed/simple;
	bh=WaoFYyXEd03KhgZkVD4XD+oEKGEOrlgRVz3JMWo9hrU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TtQStN36RY1WgS+A8/q7rILH1U9myRexXi7k8AT4DfdFSJxqQ3T/UMOTzTsGhtwQIbb8YY4LD6hnp8f4K69xVXOlKfMKJZlnhGqZN0xbCQ13a4JbEPUq8zhpudvF0sV6ZpaEGPTR9MsDnFg8oT9LDtp7L/aPGbL45Gd0NE30e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJz+pdRG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJz+pdRG"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368663d7f80so3562633f8f.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524338; x=1723129138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAf4NMwbV4VnwRnGs2bvlnFu49oV2R40q/gaRNKaksg=;
        b=lJz+pdRG5bEm/cBMEYyBiVGNrcgz2vJacOTZ/6/sdVoayZosbR1ZWr8yCbMaFAGKTL
         POWcJ1aS0ztV1ZVFtM/2H6ibNgOSAgak0YuNbnJGPuVmW/MzOR1bUGJxDvWL398egvWZ
         3VBS+f6MxH2REmuvbcaKOfb2upMluSYMtK8S+TNx9q4xpws7zfoa5U50pbU2QV7a0aU2
         hf10rBLrieOvPKcNCfkiLOpuAzieqWgomkYPakrmviqnyiDTp1GZ4rogAjxDkETjxlBa
         k9vPtqyRpbgWNuR/xvGGpxqKuOsxVs5ARB84C+TlHK0xvZePYVcg52JIG11EcN0w4ki5
         /geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524338; x=1723129138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAf4NMwbV4VnwRnGs2bvlnFu49oV2R40q/gaRNKaksg=;
        b=WHxvW3t4RlNv35QFIgR1DfkZ5JK6zcgEVgbIzbX+IMYCtSVcXbz2NF+1HaNLJmAM4Q
         s4Ybb49vJYMhLWBZryniMJ/Hw+2jnzA+f/tSIZQyTHNjHO6ucKOPSqhxd0SQrjJOxBd/
         S75hTgsvhGraZ+SYcwOEpl1aHakfhRB/q3rHNDnGYCGt2OZ6BBWJIWichn6tcem9bWRW
         gWk1v6ABS+H1e2eCx52+SiOPAr73VLwlh0NQtyXxlA2Q7Y7/w874rqnQlzQxldP3ZWsA
         bdpORa2Mw1u4zNX/cug4UTA2Lj7upiguUpREQp8IrkX1VhASW1kvDErQ/xIpqFuaSFV8
         Ui6w==
X-Gm-Message-State: AOJu0YzYZjLWoYl774morgvdSer5Eg8PAeN6d7kuFCu2yTODi4QprTU0
	nRKMOdZPsC25hIpeHrA+N6EK+erAbIwdtQ88XRsyn9en9wK0nf3f6DDwIA==
X-Google-Smtp-Source: AGHT+IHrHfK0gvNSGVSB7ChHkRtR5pIFy+oe0y8EJmeW0Cw/tQCyz6lgE6xBw4XhZy+kSSPHXVNM6A==
X-Received: by 2002:adf:ebc6:0:b0:368:6b28:5911 with SMTP id ffacd0b85a97d-36bbc0a72e1mr86688f8f.2.1722524337654;
        Thu, 01 Aug 2024 07:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b368638fbsm19490795f8f.103.2024.08.01.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:58:57 -0700 (PDT)
Message-Id: <ac0957c9e6abdc2597900573703461833e9c9d69.1722524334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 14:58:52 +0000
Subject: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterators
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Since ref iterators do not hold onto the direct value of a reference
without resolving it, the only way to get ahold of a direct value of a
symbolic ref is to make a separate call to refs_read_symbolic_ref.

To make accessing the direct value of a symbolic ref more efficient,
let's save the direct value of the ref in the iterators for both the
files backend and the reftable backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 refs/files-backend.c    | 14 ++++++++++----
 refs/iterator.c         |  3 +++
 refs/ref-cache.c        |  8 ++++++++
 refs/ref-cache.h        |  2 ++
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c |  8 ++++++--
 6 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c7..7640318cba8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -245,9 +245,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 {
 	struct object_id oid;
 	int flag;
-
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
-				     &oid, &flag)) {
+	const char* referent = refs_resolve_ref_unsafe(&refs->base,
+						       refname,
+						       RESOLVE_REF_READING,
+						       &oid, &flag);
+	if (!referent) {
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_ISBROKEN;
 	} else if (is_null_oid(&oid)) {
@@ -268,7 +270,8 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+
+	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
 }
 
 /*
@@ -886,6 +889,9 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		iter->base.refname = iter->iter0->refname;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
+		if (iter->iter0->flags & REF_ISSYMREF)
+			iter->base.referent = iter->iter0->referent;
+
 		return ITER_OK;
 	}
 
diff --git a/refs/iterator.c b/refs/iterator.c
index d355ebf0d59..26acb6bd640 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "iterator.h"
+#include "strbuf.h"
 
 int ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
@@ -29,6 +30,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 {
 	iter->vtable = vtable;
 	iter->refname = NULL;
+	iter->referent = NULL;
 	iter->oid = NULL;
 	iter->flags = 0;
 }
@@ -199,6 +201,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		}
 
 		if (selection & ITER_YIELD_CURRENT) {
+			iter->base.referent = (*iter->current)->referent;
 			iter->base.refname = (*iter->current)->refname;
 			iter->base.oid = (*iter->current)->oid;
 			iter->base.flags = (*iter->current)->flags;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4ce519bbc85..da946d476cc 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -5,6 +5,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
+#include "../strbuf.h"
 
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
@@ -34,6 +35,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
@@ -41,6 +43,10 @@ struct ref_entry *create_ref_entry(const char *refname,
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
 	ref->flag = flag;
+
+	if (flag & REF_ISSYMREF)
+		ref->u.value.referent = xstrdup_or_null(referent);
+
 	return ref;
 }
 
@@ -66,6 +72,7 @@ static void free_ref_entry(struct ref_entry *entry)
 		 */
 		clear_ref_dir(&entry->u.subdir);
 	}
+	free(entry->u.value.referent);
 	free(entry);
 }
 
@@ -431,6 +438,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->index = -1;
 		} else {
 			iter->base.refname = entry->name;
+			iter->base.referent = entry->u.value.referent;
 			iter->base.oid = &entry->u.value.oid;
 			iter->base.flags = entry->flag;
 			return ITER_OK;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 31ebe24f6cf..5f04e518c37 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -42,6 +42,7 @@ struct ref_value {
 	 * referred to by the last reference in the symlink chain.
 	 */
 	struct object_id oid;
+	char *referent;
 };
 
 /*
@@ -173,6 +174,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len);
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag);
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa975d69aaa..117ec233848 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -299,6 +299,7 @@ enum do_for_each_ref_flags {
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
 	const char *refname;
+	const char *referent;
 	const struct object_id *oid;
 	unsigned int flags;
 };
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fbe74c239d3..9f724c3d632 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -494,8 +494,12 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				the_repository->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
-						     RESOLVE_REF_READING, &iter->oid, &flags))
+			iter->base.referent = refs_resolve_ref_unsafe(&iter->refs->base,
+								      iter->ref.refname,
+								      RESOLVE_REF_READING,
+								      &iter->oid,
+								      &flags);
+			if (!iter->base.referent)
 				oidclr(&iter->oid, the_repository->hash_algo);
 			break;
 		default:
-- 
gitgitgadget

