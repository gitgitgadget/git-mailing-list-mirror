Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B1198A30
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217878; cv=none; b=EvUz2HImAPHI2x52+EYlgaRJyeI/ieApe31IBQ/mmqM2eyrnYvy3D+ej0VR0FuwN/YAw7X93n1BXz2+dD/bSB+fiSNVzgTH7sv+RBo81/g8127iBjxxadrmvVTMhR+FKQZNwA9QHm+UV38IslQ6RXljySeKt8+UMSRD4CVxH7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217878; c=relaxed/simple;
	bh=au1biXVIsRjNNYpNt5mUaIs0KnGccNuF5Bnf/ZYrqoY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ORc7JwZXf+4dMxCNH0xvgTjmZeaLaA4rjqYq9M05VTZ3LrvCS0TC0a4XNGcpUV5/R2Fs6BEEU4xtN3dcU7fMlWS6bveEe8CkuAA91Nu0UCev7B1OEwSwoQOkDa5CvOKNZN1g46BrTA+mh+ObS9GhaX9HYtCjnrhN24EuI8ArKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSP87YuB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSP87YuB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42809d6e719so16287385e9.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723217875; x=1723822675; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUQWSqs03eJiDFdjHCzzmlZg/l4rwbN4ahht1+BR/o0=;
        b=aSP87YuBduIbfki/O7Pmf6IjVySUyWsU7ZIKWjqmdcvmHnqk5KVWMMLQmUmeP9vPZE
         B6mdhXlOGmlQSq7+6Gkgt+Az638upuwIbInyuRNioeZ9ovLfOuSQrzs5cMS2coRZHlhh
         6OihXgfj8enIgZQfT6A5Pv3zXBruhSnANDgTldPnHg4n3z4vyN5NlveEBM8nS5HUAgxW
         vFPepmlIcKbuAz1xHNlMPwBrZTaJzYTM093xCjM6De+Kogp7oQ0R4ZQ9o/ftdWkLIjNT
         oyRwNYoSg6tovVVcPFcBqQPP2xmBRpzjJ1R60GczKhtaWDkEnYh1ne/qucQ50GGrLkUz
         nHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217875; x=1723822675;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUQWSqs03eJiDFdjHCzzmlZg/l4rwbN4ahht1+BR/o0=;
        b=UV2lfhheFj94hhPVDPDjFq4H/lYV2Cw6YMe0wIjp+lzZWI6MDA++AGlQNnzfHRMJ1u
         Ay/b8ybJQOqzy4tUjE6gvVXHYZhhQgBCYz5kbyCCGRC4SKWT16higVWiRQIhr8E8M4eV
         tL97j+SehXsJAli2PRcLZG2E5Du/744N4WE3I+PxrSipEHb3QL86cBzl7E+LlvkBrmv9
         YdIg3hI/0K27ieM9ewyvxeCX8CQB8cur9zs0nTzAffSbRKXll+2ktB2tjzedIgtdjpuh
         m7xpNVaBssqHE+MrufJS3dElsAkQdTI05FKXyuk2+74dVJRhAuD9updjdLxJt6o0aP2G
         njww==
X-Gm-Message-State: AOJu0Yz0GCG0Ag6YnHQREXHA/l9sQVmdTc1lM390B0qzwMV1wISofaKL
	Y66j5DRWuGLKxLSajMkhZFw8m5E+tXRf7Dw+RyXgxETbrKp3uRbS2wlIjg==
X-Google-Smtp-Source: AGHT+IGZVYtLAHoz5HX9owB+/vvF3DmKPtmWC12KP8d3EInCJLplHcTcjulEEjkUucF7VEmgKYoeyA==
X-Received: by 2002:a05:600c:190c:b0:426:61af:e1d3 with SMTP id 5b1f17b1804b1-429c3a5ad1dmr16436225e9.31.1723217874599;
        Fri, 09 Aug 2024 08:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27209a69sm5667371f8f.79.2024.08.09.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:37:54 -0700 (PDT)
Message-Id: <c4f5f5b7dd8dad4f17201611faee14dd1b882bff.1723217871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
References: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
	<pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 15:37:49 +0000
Subject: [PATCH v4 1/3] refs: keep track of unresolved reference value in
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
 refs/files-backend.c    | 15 ++++++++++++---
 refs/iterator.c         |  2 ++
 refs/ref-cache.c        |  5 +++++
 refs/ref-cache.h        |  2 ++
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c | 10 ++++++++--
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c7..210adf644fa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -245,9 +245,12 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 {
 	struct object_id oid;
 	int flag;
+	const char *referent = refs_resolve_ref_unsafe(&refs->base,
+						       refname,
+						       RESOLVE_REF_READING,
+						       &oid, &flag);
 
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
-				     &oid, &flag)) {
+	if (!referent) {
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_ISBROKEN;
 	} else if (is_null_oid(&oid)) {
@@ -268,7 +271,11 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 		oidclr(&oid, the_repository->hash_algo);
 		flag |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+
+	if (!(flag & REF_ISSYMREF))
+		referent = NULL;
+
+	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
 }
 
 /*
@@ -886,6 +893,8 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		iter->base.refname = iter->iter0->refname;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
+		iter->base.referent = iter->iter0->referent;
+
 		return ITER_OK;
 	}
 
diff --git a/refs/iterator.c b/refs/iterator.c
index d355ebf0d59..75fbe5d72ab 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -29,6 +29,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 {
 	iter->vtable = vtable;
 	iter->refname = NULL;
+	iter->referent = NULL;
 	iter->oid = NULL;
 	iter->flags = 0;
 }
@@ -199,6 +200,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		}
 
 		if (selection & ITER_YIELD_CURRENT) {
+			iter->base.referent = (*iter->current)->referent;
 			iter->base.refname = (*iter->current)->refname;
 			iter->base.oid = (*iter->current)->oid;
 			iter->base.flags = (*iter->current)->flags;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4ce519bbc85..35bae7e05de 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -34,6 +34,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
@@ -41,6 +42,8 @@ struct ref_entry *create_ref_entry(const char *refname,
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
 	ref->flag = flag;
+	ref->u.value.referent = xstrdup_or_null(referent);
+
 	return ref;
 }
 
@@ -66,6 +69,7 @@ static void free_ref_entry(struct ref_entry *entry)
 		 */
 		clear_ref_dir(&entry->u.subdir);
 	}
+	free(entry->u.value.referent);
 	free(entry);
 }
 
@@ -431,6 +435,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
index fbe74c239d3..50a072b97b0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -455,6 +455,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	struct reftable_ref_iterator *iter =
 		(struct reftable_ref_iterator *)ref_iterator;
 	struct reftable_ref_store *refs = iter->refs;
+	const char *referent = NULL;
 
 	while (!iter->err) {
 		int flags = 0;
@@ -494,8 +495,12 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				the_repository->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
-						     RESOLVE_REF_READING, &iter->oid, &flags))
+			referent = refs_resolve_ref_unsafe(&iter->refs->base,
+								      iter->ref.refname,
+								      RESOLVE_REF_READING,
+								      &iter->oid,
+								      &flags);
+			if (!referent)
 				oidclr(&iter->oid, the_repository->hash_algo);
 			break;
 		default:
@@ -523,6 +528,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				continue;
 
 		iter->base.refname = iter->ref.refname;
+		iter->base.referent = referent;
 		iter->base.oid = &iter->oid;
 		iter->base.flags = flags;
 
-- 
gitgitgadget

