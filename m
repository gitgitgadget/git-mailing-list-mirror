Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5D2F9D82
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563523; cv=none; b=RPf5WrzL2VYv02+pmSAiviWTYBax+TPfO+hdF9RUgC/hRtkgwWiTnAhtp2w+9cClSfOb3Si2GUtQJOot018U1Mvk7b8tw5X2L3Mgt/LU8NUBdPl4f1804cuybANmdeLJbMMXy9WhcuMDD46/o6JQSTkVBXq6ivvNjhN3lab9LUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563523; c=relaxed/simple;
	bh=QCJMl5j4Nw2u/6nb4d0bOPjd/qXM2QqYWXgOQdr5gFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUpf7odj/816W7mD+l1OZdm+0qK9dyO88DJfkWDwR1qNCbBcA4q5Ozi7b57RHL99B1MsKYd3ihmsLtiilnsAXVOT3m0zHMwF/fSz8VSwYcIzs8F+EpK2qakouvDNvlMbRQ6340e4W/GDCvE+JLwab3hO92HHcCpKAHnXWI6PPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnpOSNru; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnpOSNru"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3c2db014easo9980766b.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563519; x=1761168319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K3L06ulsc8St62pssAj/fINOfac28el4YCCwRiHZR4=;
        b=NnpOSNruy6qLjGRyrAr4LVzvlO61f+Fnhsr9LxoY/L4ZJInpeuVK7Os0LJL2kjefn3
         UcYCbIeQWuzbnHnb5hI82U+ROZAUyTv02+ttRePE1orPhjIZ3CO3BdLdFhSvih6z+t4Q
         1Q3EWsqDrS6kOoLslTEEBhAPVBwKj9tnbglyCiHVxuIUprLDRjuNJCqsKQpCemLhFCUF
         COnXBv2q3CYOuzLPAN/frDDhIbro6HIpW8Rg/bsTKVAZ8LU3xYeiH3OHC11EA5MGNnYe
         DPZH83r9ZnTUI5evQ2z9H04cBlOX/Mda29OGzsdc+gtP40K99S7WSMDIEoUc4FmqGTha
         7dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563519; x=1761168319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K3L06ulsc8St62pssAj/fINOfac28el4YCCwRiHZR4=;
        b=kZhZNd+eWVIEJO10sRnKq/9TAKLT6c7MrEZFARB32daLP8/WOZNfd60dqWGUoQuA5t
         TxVJfOste191a0KWBo/7Wu3ENw+y3QLlZnqQTLqQzMMtdIhylS3JjLKwfoR/f0CKevyD
         he7zDY+tY8roA5Z5nYZR2oKj0KCFTEYGSNQcYDy8zDDjtsOGvEV6s+QuXpH+nMB/guIV
         NO+w/K0ebf8X5vJHbZCYOryn9XWSrPnmxZaYe3QdG9jKnVT5US9nCDaG539DjAzdsENJ
         dOpKf0lUj4OE1WTSRc/Qb4JsULGnUFgQqvzVodhqL1Jr7bs2s+ja6ElUlhbWVXiewL5X
         aGew==
X-Gm-Message-State: AOJu0YzBfcu1pK6WDaU2gHaFRs/jBl9F3Z0kq6gdlUqAEnikJYbzi2JF
	P/9hWIeRNiaElmRGqPi36HGUkEtpHoIo2rUmgYQ8ensGGHbi8whDN9KSxwgV9S1q
X-Gm-Gg: ASbGncu/t07e7PmZtatInXjJkB/GOMIY5Yctkensx+hJeAHG1t/Lj2mJwi5zL4jlpVk
	3Ba4RVBpfF81Sq6LqI1e/k3gN7+pQJvX2dREt5Jtq0HfW9zdiaqJ5JrMynWRLU/7VZxVhF95s7C
	ELTRUSapUHslgNFyvQjbZMGBceLgMCTGbYHcvpnHcUUufZTCbDW1zj9tRw5swjLnCOwqMyVo4/x
	d/jRe+MlepTm41daNIGnHj2PqAv6HmsmkpzLkYefRuzJPl36Tlihx1WP8K8g4QidMhXL6qBqIXb
	yN23UV0JhwvdyyCE6S4FL3bWlHYOYI7aaGfGkc4BxoUAG3XPFoBDCbPxUktCaeadQ8pli2+0EDC
	43i4ixvwOv8qk8q+qxvIGPfSJxYmvxBP7mVuIXvlaVwdU39pJ7Dq+JauHm6jhPLp9HmNePaU=
X-Google-Smtp-Source: AGHT+IFaOOXR8zRr6349Z9vgIsU9hkRWa0TLr8XwNFseD1jQOd+T5yvmfn9w7SquTPGtJ+8wF+4u+g==
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b50a9c5b352mr3149097766b.4.1760563519107;
        Wed, 15 Oct 2025 14:25:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:980b:e8aa:7473:ef22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm315854766b.50.2025.10.15.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 15 Oct 2025 23:25:07 +0200
Subject: [PATCH 2/4] refs: cleanup code around optimization
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-refs-code-cleanup-v1-2-550fdd8a3b41@gmail.com>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
In-Reply-To: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QCJMl5j4Nw2u/6nb4d0bOPjd/qXM2QqYWXgOQdr5gFc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjwETuWf93cwi4Pn7pLgYDAtWzBcZovOz0If
 bz9ZPKk1NjHnokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo8BE7AAoJED7VnySO
 Rox/eq4MAJc5FTUzFyMAqT0RT4KGQb2bmxWd5+d6UBl8mB7ZD0oRCi270UQ6+tZeQCSMZqXjpnG
 k2U7zONvyqWS9n1LoK62Z41ki0nNu3B2+9t7rjHNvOlh1Tb/HTg7snsB4Rntz2gvG9/o5CQuh+M
 QUkTwVmdN5205tk4dvbCw2ZGQSZtEloPzRYmQN4ys9DPiwIhdjzCmeImIc9cCftyX/fIZe0tsV0
 NogMdFVbZfBRPjaiDgFP7Qs/JMnGZZlvCNuQKF9qX/HyDbhavAqmNTsby5mL+xIpAfRBPRWWvfx
 Gww86SV7pfIoH94ksWDw7NFQWXOtR5cF2oUoSQaxAo3uGh0r8IFp3NfPXUJXkgWFBiPyGgY5OPD
 Hv18abW95inntQCvrhO6ZLg5Dn8PuVnu9ce4iJUiVvDdiuK5TFTk7X2gWOBT96IsSZeBPv23B2/
 F54tp8AXIURrZzGsqYOCzIiFkR59YXCiNH/SffCjaC3BLkPxnLU0Z+xNbTkXBTNtV61Zfkras55
 GQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit, moved all backends to only use/support the
'optimize' function within the `ref_store` structure. With this, cleanup
all references to the 'pack_refs' field of the structure and code around
it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 6 ------
 refs.h               | 8 +-------
 refs/refs-internal.h | 3 ---
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index a41a94ae55..b9a4a60646 100644
--- a/refs.c
+++ b/refs.c
@@ -2313,12 +2313,6 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
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
index 23437d1220..04e917fec0 100644
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
@@ -514,12 +514,6 @@ struct pack_refs_opts {
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

