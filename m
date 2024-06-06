Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB7198E87
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694808; cv=none; b=OIFonos32VCdX467zLuxLMIv38czfZub1iXOR/o0XQWXtoiMZiiCc8wqY55GH+z1L8nU36ezRPydnOGPh7mSU6bzSe7fTxADHRjzcmA7H7RqanwgjIgvWAHlDmDXWS/aN/jSwhtZAytB2ingEf1nQRAO3AdPy/4bznBWpCwJANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694808; c=relaxed/simple;
	bh=AOoGtFAeUiz7d3NyHI62uCutnIWQjWcOaN9tF+FjFF0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i/4TFvLjf2SdNZfkOzIw9FdisLYDwdeZqdvWAjghrYUafumPuTF+mi3DSK+lw+j+EurjTa3AtgiTkM+sgCu7egKdfhtiCUiUIDjlievEYqCW9Ysm/1vK/AI6joA/VuV+x4P3HVz05c0byJPecxK0yn4a3FFprUWPdCJqM2xHU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msvm1BsU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msvm1BsU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4215b0c4b7dso12931595e9.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694805; x=1718299605; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi3ZC775ldC9fn9/+wwWTLI/lCYWwfYs7bCATeo1f6c=;
        b=msvm1BsUQWx3hk3jAmrOyRbxPNcdnqW6vsHbvbKeIvN0OIRqpVxCp0DxfjEcVMLgaY
         dQznsPF2GVdofP/i1eYN9t4rHr/+wIwnKI+MxGpAIY0h9yZIuIvOaDnw6GfEJ+BXzlJr
         +Bl6p3SWj83foTZ/Hjzf4F+hTc6MAkyU2PSSBaragF4vOo9HPMuD6KcicZ/ejCRXUYIb
         QIZz0TOQ8yxsisEM94dP3UETXJGcZXWmNAP4LFAy/fSVP6poGgp7czkYHUh3jMaYWKJn
         +ETlGdtC8sr3Ogg2D7lKJ2ab1wPwmGJPsdHY3ShDAW0bTaTYD9E+hK+fUnXsWWc03Ci3
         amAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694805; x=1718299605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi3ZC775ldC9fn9/+wwWTLI/lCYWwfYs7bCATeo1f6c=;
        b=Ssqv0KSYHY4HFKqKt8By5Xa+JsyMjSkfGIg4bjy+grZx162ay+SSyhBesec1WQqHSb
         hGj02kQSY35G/OjcZHmQgcaBBfSruKZw1VE10CSQOzAH/5QM6SMEc8yossRk3UftTUDI
         P9uBETAc8jLJMhR7W+t1mKPhWokfOQ3h2RLuhR38J5qe7DhzHBiNA5IR24cA8ALEnGb/
         AYsWZC3L0APAk0nC9/jaoULfyaJD1kBltO9y2XZYmhIdWvXTlYxuSucLpPeG67N/76MU
         2i1TVLhMK3Vy9ZdvQrLMuLmTkogdADnPaK95O+JGr/mvxFOT8Q44ZDKIlEReIqlAafw9
         XuIg==
X-Gm-Message-State: AOJu0YwYHFBq9KoLWjtVtyZBHVuLXhlIZeZ7ZT4XgLGkgP6+xO3raEaN
	xP+MPwWg7B0hNlESSSNUt8vwiTz+mkblexyXpKrAZR//lHg9WnqP7gRYbA==
X-Google-Smtp-Source: AGHT+IEvHWyWz0FCkXyHKszFiO5oHMXO0uSZOx2vLChv5Xn5p1/yxvAwkPEkyUslBvDgElbJP4KWVA==
X-Received: by 2002:a05:600c:3aca:b0:41b:f788:8ca6 with SMTP id 5b1f17b1804b1-421649ea031mr2994755e9.8.1717694805074;
        Thu, 06 Jun 2024 10:26:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2a7799sm28716805e9.27.2024.06.06.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:26:44 -0700 (PDT)
Message-Id: <7202ada0542b6f014647785945094a13c9d885c7.1717694802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Jun 2024 17:26:38 +0000
Subject: [PATCH 2/4] refs: keep track of unresolved reference value in
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
Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    "Jeff King [ ]" <peff@peff.net>,
    "Patrick Steinhardt [ ]" <ps@pks.im>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= Avila [ ]" <avila.jn@gmail.com>,
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
 refs/files-backend.c    | 8 ++++++--
 refs/iterator.c         | 3 +++
 refs/ref-cache.c        | 6 ++++++
 refs/ref-cache.h        | 2 ++
 refs/refs-internal.h    | 1 +
 refs/reftable-backend.c | 2 +-
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf2ffe062ea..a963d796a29 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -243,8 +243,9 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 {
 	struct object_id oid;
 	int flag;
+	const char* referent = NULL;
 
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, NULL, RESOLVE_REF_READING,
+	if (!refs_resolve_ref_unsafe(&refs->base, refname, referent, RESOLVE_REF_READING,
 				     &oid, &flag)) {
 		oidclr(&oid);
 		flag |= REF_ISBROKEN;
@@ -266,7 +267,7 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 		oidclr(&oid);
 		flag |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
 }
 
 /*
@@ -854,6 +855,9 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
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
index b6c53fc8ed2..e8ce5822cc1 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -5,6 +5,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "../iterator.h"
+#include "../strbuf.h"
 
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
@@ -34,12 +35,16 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
 
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
+	if (referent)
+		ref->u.value.referent = xstrdup(referent);
+
 	ref->flag = flag;
 	return ref;
 }
@@ -429,6 +434,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->index = -1;
 		} else {
 			iter->base.refname = entry->name;
+			iter->base.referent = entry->u.value.referent;
 			iter->base.oid = &entry->u.value.oid;
 			iter->base.flags = entry->flag;
 			return ITER_OK;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 95c76e27c83..12ddee4fddc 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -42,6 +42,7 @@ struct ref_value {
 	 * referred to by the last reference in the symlink chain.
 	 */
 	struct object_id oid;
+	const char *referent;
 };
 
 /*
@@ -173,6 +174,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len);
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag);
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 33749fbd839..07754514355 100644
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
index 9e03582e7da..6328c0f77dc 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -438,7 +438,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			oidread(&iter->oid, iter->ref.value.val2.value);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, NULL,
+			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, iter->base.referent,
 						     RESOLVE_REF_READING, &iter->oid, &flags))
 				oidclr(&iter->oid);
 			break;
-- 
gitgitgadget

