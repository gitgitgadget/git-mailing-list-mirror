Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F3193071
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279960; cv=none; b=exj7DXn3D8x+ZSnkH8hTvzc6AY9Ju0B3mRd54aqbLtrwOumR9X5h+VxkWuC7HswBVhNrgW/qawcibxV9nLKCL0nO3k7lu6mt+ok0x8a/TwgTXHG986PzB8go9qpyVBA74lMwA9NB8jrAuxRqK/zdofnOc3ljj1szA54r8WyoMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279960; c=relaxed/simple;
	bh=ATy4ssKxG+1kuX/UpGVdpNwF/duWxcYMcv9ZJ2nZT2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zkzq9lTtxJzOpmzRTaQ/+YHlDQdFI5z9VmhoTO9rAnBIvip/qHtHKIdg5fUiNw+JCXO/OLUGtW6lBxHTDSBDu/iPSPoDW1UFUWca8A9OoS5VjUMzywm4kJktX5PCv9Q8y8gLsfNQmVUtdupZ+TLOyW8dlBECYQQjIz0EqYcVsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuUdj1aL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuUdj1aL"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa670ffe302so632976366b.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279957; x=1734884757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1ch3s3JnDSoPZxdCqvaf+8QiC2QUWbiyEX7XSSiSX0=;
        b=OuUdj1aL1nz1LKZQQGlBw71viY/AcmmF6HUXPzU6w2TRU8zQAER1cbMUGVPA+gUC0u
         8UqxXduPJLaO9xEEPV0o3LlUbwdqb4yDZBSBM6dB0DGpHlN9HjmZx0eBrETmJYftc4jy
         JgxTmrTO2+ooQrUoWgvhkRGoMsZpC4O6OK3HQ2U1ttXT/GRpFtfCy1lE1DzssQ0Ukn4R
         Mh+AQEbj3SMI5+6PYyghZmMlJOvoxWTMkglVg2yU79Ma4QY7ytdzpSd/u3FkTRMQ08Hv
         P5Iomx2NS07C5IK0gJPJ/2iez8TNJjEdrTrc/24c0FYpY25uZiJntH4g/AN1Hzx+Vokv
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279957; x=1734884757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1ch3s3JnDSoPZxdCqvaf+8QiC2QUWbiyEX7XSSiSX0=;
        b=QWc1CVHHAPYjbDfdiCcSIfStsHwL54qH/5hnj7OnxmXlrmiOJH7L8+mAAD4zFJMQHk
         vNNEOprXcc4u2xZPC3PqS/NDmdbKQgQ8sUSdnahf21gPsCQjLHhNrg8CG9B0qZ/pDQtm
         jw/Ex5TDTh/Av9ro/+n7bW48Hw5wu4b/y4/GGBfKkid6P5rX4skcCQ1MXavfyzVVBTGe
         siX1QPsbgLh1lNSvheXdxwSvpfyojiGGbUtfaXLEES0hhevP20UttQt2h9Sz4n9Mx4It
         9rW8zvCad6R6PzHlWk3//Qec2l5vEIYzJd5vu0pcGS/tOKdHnXIByUBjJLQp3mUpyBia
         kGiA==
X-Gm-Message-State: AOJu0YxMyHGCFK/SKeWLEF8BpQpLnKBcEutoVFEF2zvzGbPWwe10Rf1T
	6wORnjZNBI+gMKvr0ybRLzeFGnPxZdEWVLHqDFJyOLBTLOvMhnpf
X-Gm-Gg: ASbGncs2Jz4+f3omtH6AOUGntSdjSS0M8PWfsHO91pKpKiMYxGjT0jI9QnGgVGH+wAq
	ITiTFNm4bNLAYOynpS89Lc70Xtjvj28RjLzjptGVcrBgZXlU/bE5OwT3ujIjGfjK4/sPbN7ZK1x
	yuEa9zurNMOrwxTSTkzntVh1bF6lAITwbbA2AsBgaGIxulcDo9slSeYCWVlgc1D1NaB5Mmca6Sp
	jjizblD2bLS0C6V3pej3T835URvhfCMXJmM5/6J9vQHePX9EgouL6tkBIIAPrsKR+tpRA==
X-Google-Smtp-Source: AGHT+IHvjA7ERkDCg9C5D2u7P8k2GkxwBJJ56JYN4aX9cnZoy1TAmegisBA25W5xOau36oWK+vy9IQ==
X-Received: by 2002:a17:907:780a:b0:aa6:8520:7187 with SMTP id a640c23a62f3a-aab779c1398mr960499866b.36.1734279956571;
        Sun, 15 Dec 2024 08:25:56 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:56 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 15 Dec 2024 17:25:42 +0100
Subject: [PATCH v3 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-5-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5487; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ATy4ssKxG+1kuX/UpGVdpNwF/duWxcYMcv9ZJ2nZT2Y=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMOmyYBfliGGIhJ2n/3fF+4NkZFkl5FNf797
 K9yRLi3rXSJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DDgAKCRA+1Z8kjkaM
 f1c9DACKtASTy9GGPJo6D6RZjFuc22IPvDbdhw56gN2IgcuLZpvITKB0Ws+OlqAPD1aNb1JakB3
 HyWrIC0SdtL6S/oqxVgGzXbXF9390ASRzjAXE2F0S7J7kdiA8j3nkyyoGDWyo9MQQopYQ5ckcHQ
 eIOVsMPiudt75TqSNxIrt2uc3/RaSVNqk4TmSNsWfuLK/2Lbhs+bhequl0E42Uwh4mgFhd9eF7L
 AeobmACTrjhXNr21L3WPTiTtm1Q2/0f8yuF3hEBQ6WpA5+RZmga6EhcVUw4/fVa03aYTzith8j5
 Kk4zutokN7jGuyAOCq9QOUfKIQPE6O2LAH+VSWGGE+jfq4nPWqIvioOET08ISNyoV1NVzCZO/Q/
 z2bIxXuhL6sE+264BNAt/iAqQ9+oo4Q8/IKqZPlKwnXCSmKVmvTQEuBahsrLMIx0XS2vGHkRBkz
 SyFra/C6etm0yrbJFLzr8jvDWm5eh9WbQMHfADFa7W8Ly96b1AZ4EnL2zfTudwpk2jgvM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_add_update()` creates the `ref_update` struct. To
facilitate addition of reflogs in the next commit, the function needs to
accommodate setting the `committer_info` field in the struct. So modify
the function to also take `committer_info` as an argument and set it
accordingly.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  7 +++++--
 refs/files-backend.c    | 14 ++++++++------
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c |  6 ++++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801..782bf1090af65196263a3c35ed18d878bb4f2967 100644
--- a/refs.c
+++ b/refs.c
@@ -1166,6 +1166,7 @@ struct ref_update *ref_transaction_add_update(
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
 		const char *new_target, const char *old_target,
+		const char *committer_info,
 		const char *msg)
 {
 	struct ref_update *update;
@@ -1190,8 +1191,10 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
-	if (!(flags & REF_SKIP_CREATE_REFLOG))
+	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
+		update->committer_info = xstrdup_or_null(committer_info);
 		update->msg = normalize_reflog_message(msg);
+	}
 
 	return update;
 }
@@ -1253,7 +1256,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
-				   old_target, msg);
+				   old_target, NULL, msg);
 	return 0;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 02cb4907d8659e87a227fed4f60a5f6606be8764..255fed8354cae982f785b1b85340e2a1eeecf2a6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1270,7 +1270,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL, NULL, NULL);
+			null_oid(), &r->oid, NULL, NULL, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -2417,7 +2417,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			NULL, NULL, update->committer_info, update->msg);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2481,7 +2481,8 @@ static int split_symref_update(struct ref_update *update,
 			transaction, referent, new_flags,
 			update->new_target ? NULL : &update->new_oid,
 			update->old_target ? NULL : &update->old_oid,
-			update->new_target, update->old_target, update->msg);
+			update->new_target, update->old_target, NULL,
+			update->msg);
 
 	new_update->parent_update = update;
 
@@ -2914,7 +2915,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL,
-					NULL, NULL, NULL);
+					NULL, NULL, NULL, NULL);
 		}
 	}
 
@@ -3094,12 +3095,13 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			ref_transaction_add_update(loose_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,
 						   update->new_target ? NULL : &update->new_oid, NULL,
-						   update->new_target, NULL, NULL);
+						   update->new_target, NULL, update->committer_info,
+						   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,
 						   &update->new_oid, &update->old_oid,
-						   NULL, NULL, NULL);
+						   NULL, NULL, update->committer_info, NULL);
 		}
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f5c733d099f0c6f1076a25f4f77d9d5eb345ec87..79b287c5ec5c7d8f759869cf93cda405640186dc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -162,6 +162,7 @@ struct ref_update *ref_transaction_add_update(
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
 		const char *new_target, const char *old_target,
+		const char *committer_info,
 		const char *msg);
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c008f20be719fec3af6a8f81c821cb9c263764d7..b2e3ba877de9e59fea5a4d066eb13e60ef22a32b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1078,7 +1078,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+					&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+					u->msg);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -1161,7 +1162,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					transaction, referent.buf, new_flags,
 					u->new_target ? NULL : &u->new_oid,
 					u->old_target ? NULL : &u->old_oid,
-					u->new_target, u->old_target, u->msg);
+					u->new_target, u->old_target,
+					u->committer_info, u->msg);
 
 				new_update->parent_update = u;
 

-- 
2.47.1

