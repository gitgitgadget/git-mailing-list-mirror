Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893128314D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092038; cv=none; b=ezqRpUgzsqeLJK4G+IkakwqkIJPymBysmNaSw0sw/vr8frJqKjXtyz8jjHTDdOYEnWAYIRY9giRQlcZXoqJR+yFcyb+FzBTl4Au1D3ywFYBbjofIHum3S328OXu98a2Cp8smPdURX4sxD/szBrc4An81W1zkCY+lKaP1jT9+9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092038; c=relaxed/simple;
	bh=EshALcwkl5b4kt4pGQOFK38xvjVnicdfM6v/+c+wbVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VI/oIJle0EGPmnMqLhF6YiCqwqLPrHaS4/KoJwa16/GoJDxrvBxOP11rR+w9Vq0obUTkQt4MjG+sUqPDdKIqSVDv+64BoslVp8Nk9l63+Ow8HuFyM3z8QU/oJ8CF1Q14vmF1hPnoTT5ry6BDjFdHNWDU3qUhvQbTRpzGAd4cRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1QB8c94; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1QB8c94"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso3725170a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092035; x=1760696835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6WtHooUgokgsmZT42oELxsSOTmHn6BWdmWHFLWfmcI=;
        b=O1QB8c94ov0pTYAkY7DRYwM07Qwh6ViBradCVxwvEqsG/nmOBe7ZWIYiiJ1SwwFuVS
         e1iWSf38oCV4Q7xpsUIv5ze/pqPmUT+ekGUSOwyY9gS9b1m2cbwWx/k1sNWx0M9TOzzj
         aTDHg5eO6JfRAPVbjyThsy1C7l4l9UDumjljr5+TArYWXznZk/K012AGn6rWqVBgLgQv
         bMFDDg4kwN6dyh80HxF6m2VZeV1oEUoWofqnpHq1lzk9aY8eqg6SxcdR13RPjAX9rnj/
         +ebj08yZtKn9dho6NCM9CJ/XiZKwmzscNYjJdSdwWrtBIou717axE0dqlH9bedwmSAKZ
         /WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092035; x=1760696835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6WtHooUgokgsmZT42oELxsSOTmHn6BWdmWHFLWfmcI=;
        b=rfPNZtGZZkFld8EXVw+qvt0WdPUTe50bEbtC3Xewiqf0tkx0dUpHLVaI1wrTSEPnLE
         dsC3T9aPe9WPTF3DiOd4N59sKx9jssPXKFs/frolfjOaHc/P0jAtDs0f/3Ec0La+yLpN
         sU6IkwHBB/viuQ3zwDSKJ+RFw1eafmeSc72SD/weuTQ/kKzIJVbUFdp3fCfz/HGjZjWO
         6ignuZ104owkHMg4gZ4Wo9QX2zdjx2gN6mslzNFPb1QqykDyORqUKs9oBrDy4NEbLX5g
         2i//3nArUujo2eqIgpSS9ceKQz5Usgh7+RQq2fvYIjenXXymKf6+PhVdxh7nzOvQZxpf
         HS4w==
X-Gm-Message-State: AOJu0Yx3WPc7QVw7LcOOqG1cC8vmkSXm7aYVGGTlY58RL4dBY9hsZ83F
	35NTMj66gTmmMncJX/4qY0cZx4bZU2lhzL7Jsmz71l2eqUNoU9S7xHuUEJdjjllc
X-Gm-Gg: ASbGncsi62Stz8HFLhH/adIBhtz350Jxsnhg+ghS5qJV7T+rYLtADXtGfPeiwcvOxu+
	pDSn+YnNozB/kLOcIHLk+abI0jTWivtMbBy/TK8sSXsQq8VPm993Gehsza//SySHJ23Sq97KgpG
	GCQ4h8hINLb7h75zuS9KuCd5VtLtNqLUtyZHsmmg646EBCb0/FJWMwY1rRnd+st052lVB8VJ0oO
	MZXaLH7IRL87y0GzhMnxtbQLLbEw91aFehVmjtKSAJsdkvUrVjUT7c1oDN+ZtClTl47BeuaSUtu
	joNoUoH4FtvNHl7jmYL+tlbPA0pQ25p5HSL9GCeR5kn4Hdh13KawLzqvvfwetYlXunb36n7JonL
	IlcYzab+ylzEZi666PCNwB5wV5PmmEb9ha5iGLid31MddpJvsUsjJ8z2MOrBjptrMnSzr
X-Google-Smtp-Source: AGHT+IGbfU4qm1keYTZUJMJr1x2cUmwxqxGFnRh9c7R5Q6F1uq78iN3deyl6fh59VnkxRz5IsczYig==
X-Received: by 2002:a05:6402:3487:b0:639:f548:6894 with SMTP id 4fb4d7f45d1cf-639f548ba3fmr6542587a12.3.1760092034928;
        Fri, 10 Oct 2025 03:27:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:06 +0200
Subject: [PATCH 2/9] refs: cleanup code around optimization
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-2-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=EshALcwkl5b4kt4pGQOFK38xvjVnicdfM6v/+c+wbVI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo339GwodMFubP2CVMrb4tJ9UgJbntkJgeo
 1kTqyLEXGCyRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/ib4MAJybfunJMdAoEZADq4fPqGgCFIX0s3NNaxXtqzcRxjQx0n9ULryTpia2Gio9PgRd87O
 LqP4Wa5HcCLrOwb+mMj6gy6R1CnlsyGVHpphqG2prEkEXxPu7p3VbsxbtT0qUxKhNTUO65XuCN0
 PDx2v88v1MZRXGgi1L689VzOkl4bAXefNg1+AXMmpv7dVxAy0wVk4FOS9CUuCN1KQQXf70RWh/a
 Hz4/8Xkmzvzkx5xtEPmUpDSs3Tm+5RkiJditOcV4fTNQaQvK3zK5Xv01t+qUkmh5Ccbt4zNj5yC
 1IkxU10Xg2dWVgk38OR/SHr5G3RTfGC8hraIOM/SvJxI87soKlgI4smZ4UuzpN1f2NIL6nlgvCV
 ZRKDfKbyAECRuo0cj72Xlt/5soOtaddtC3ZaJQcMLrTShln9ZLnw3iebqAo6eYpXc4q6jAT65u0
 7A+vnmwDW8spSXPsIRES2FgOvw8CGozLqiQaYfTdQCv1NXENIDjDnDW17AePZqjq66AK1AtmtJ8
 Sk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit, moved all backends to only use/support the
'optimize' function within the `ref_store` structure. With this, cleanup
all references to the 'pack_refs' field of the structure and code around
it.

Modify existing documentation in this regard.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  6 ------
 refs.h               | 10 +++-------
 refs/refs-internal.h |  3 ---
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 40acaa3f42..77dc1ab501 100644
--- a/refs.c
+++ b/refs.c
@@ -2312,12 +2312,6 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 	refs->gitdir = xstrdup(path);
 }
 
-/* backend functions */
-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
-{
-	return refs->be->pack_refs(refs, opts);
-}
-
 int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
 {
 	return refs->be->optimize(refs, opts);
diff --git a/refs.h b/refs.h
index 2dd7ac1a16..c6c955d78d 100644
--- a/refs.h
+++ b/refs.h
@@ -499,7 +499,7 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const struct string_list *refnames);
 
 /*
- * Flags for controlling behaviour of pack_refs()
+ * Flags for controlling behaviour of refs_optimize()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
  *                 result are decided by the ref backend. Backends may ignore
@@ -514,15 +514,11 @@ struct pack_refs_opts {
 	struct string_list *includes;
 };
 
-/*
- * Write a packed-refs file for the current repository.
- * flags: Combination of the above PACK_REFS_* flags.
- */
-int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
-
 /*
  * Optimize the ref store. The exact behavior is up to the backend.
  * For the files backend, this is equivalent to packing refs.
+ *
+ * flags: Combination of the above PACK_REFS_* flags.
  */
 int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4671517dad..fc5149df5b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -422,8 +422,6 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
-typedef int pack_refs_fn(struct ref_store *ref_store,
-			 struct pack_refs_opts *opts);
 typedef int optimize_fn(struct ref_store *ref_store,
 			struct pack_refs_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
@@ -550,7 +548,6 @@ struct ref_storage_be {
 	ref_transaction_finish_fn *transaction_finish;
 	ref_transaction_abort_fn *transaction_abort;
 
-	pack_refs_fn *pack_refs;
 	optimize_fn *optimize;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;

-- 
2.51.0

