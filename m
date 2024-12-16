Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E4207E1F
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367483; cv=none; b=Ilh4Ic45qQEB9YTm/Nz0R9E72rN/ZAE+0Ct8Tmge02SRksI9YBeWl5sM5wFW9HsPss4PqnVTOYclp2EIc64A6S3QBIEV/pnksvVL8TMHM4l6FjpIFDvbV+cbMT8zTqboXR783WgK3+C7FwV21p3Lebf/lKdo7MqUkgnjwpIjVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367483; c=relaxed/simple;
	bh=ATy4ssKxG+1kuX/UpGVdpNwF/duWxcYMcv9ZJ2nZT2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1vBbkxLCQiWz92+05TdPmHPMbTniwXTED4+hoSPTh1YyYCTp2YuyEDwXfVGkUqkkO+o+EYj0fW3d2kUi4gxOYGW6eC3Pl/QXNmR9P6ilPHyHnohozWxqenw/+aqZIZCszeAdr0gDIxjwiwdXFKL3fgS36ou12kNIrxiTYFA8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEkb8Tig; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEkb8Tig"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6aee68a57so632296266b.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367480; x=1734972280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1ch3s3JnDSoPZxdCqvaf+8QiC2QUWbiyEX7XSSiSX0=;
        b=MEkb8TigiHePgHoXAvpyVYNM4LkXG5/gKVItIKdUJO1lVuDIl+w93et3xVSCeRAJyb
         2GpYiLoV7tBR5ptivwuGv3iWvyx6Qd9bd43fQycZ1ZQvP8Rw72uIoxjFO/GCSt3I9I8p
         2z5ZR9/y6FxCd81LGLEXAi05BDT1I9NnPBv/7yf1m2MmFNwEULvvrtYDbwp+Q4WmemsJ
         HzJwgiYtqtI+LNfb2CChLIEWQMEzV3LL1Z8uvvO8ZcrmuCFCcpam52OiZLGxdynAMKYB
         ijN3S29OWUbizZI4Vnc7WqAvGPR9GEJ0y5+fA0o67OcQLnAoAh6HmpU1xR9CC87k4zFK
         pfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367480; x=1734972280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1ch3s3JnDSoPZxdCqvaf+8QiC2QUWbiyEX7XSSiSX0=;
        b=jbcuzWt6Jb4hXIlw7ps4W8En7MCi/37X133gnHZJzivSFifawtwYQvOpNRfo4GixXl
         ouviXuabKx/mhW7pnObkIiE4g4EUbCV+xlv7jaZ/Q2HVKNIQRvlQw9Golc+kz4mllbtc
         CE+w+7KhzG5qCJTKURqQEB/gvcFr/9bzbrHMQqpGklALSUnNSy17cU99gMsbgAt+ZcFF
         W3kwrdEXANkgG3N9uB3ipFrdQ+4K5VFsQ8BGu8MHoend0VpfQMExGVGpw1dxxWoknHc3
         5UIwPvI/uGdEfpKgHhQbUtSsuKh0ei36/84AGNoTloSXVVtXBMtnNO65OwPjbytpZdWK
         GWQA==
X-Gm-Message-State: AOJu0Yzm7pTonGMRUSttKZvSlzz2vALuahhYvVe9c5Oll/JgN1OsU4cD
	zaRxFPorSjf8v5ZIvNCR/FjauI+hYzU/0ofiW0JBqyB92qjUXOmZjb8JW806
X-Gm-Gg: ASbGnctSsWWuF4Vw/hQR8AcXS3EFs0qarohgvEygxM0rknQI5kCatIMj2qaVftulwaj
	rJCmfF4S9DMwOSsJ/IxYlKa0DvtuQlts0O0Q0YoxIpW6SV25Q5fHhlmNivWjeezgfmBNFRjgE+r
	AWBkcZvU8t9P/G/pVQMkn2acTPkrBHo0gi5wUOZjREqZeta9qFsnWTebDr9IKsKaK5xRNoV+hfR
	9Nf7lSHqXC8vdRHTKFfKwZKE8BZJmH4ay8W7yjUUuR3rKGi3T5TO62g1Ew=
X-Google-Smtp-Source: AGHT+IEXCHsJLwts4V3/zQ/C1pBd9ND/h09bD10674HqSD0VJuM6BMH0XZ9PXSXzy+NHCuoEBbGSaA==
X-Received: by 2002:a17:907:7fa5:b0:aa6:8a1b:8b78 with SMTP id a640c23a62f3a-aab778c1e9dmr1541444566b.6.1734367479715;
        Mon, 16 Dec 2024 08:44:39 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 16 Dec 2024 17:44:30 +0100
Subject: [PATCH v4 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-5-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5487; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ATy4ssKxG+1kuX/UpGVdpNwF/duWxcYMcv9ZJ2nZT2Y=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjwq/0DsKHogDxkdsf4BUxQvkyxazMigcb7j
 SCS4qW9TSaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY8AAKCRA+1Z8kjkaM
 fyRjC/4wh39x5fku5opaRU2udnKSZlOQBT2exudjhR9H6wMCpOOEEfgpoLQGvWMLoHIsMs6kalQ
 EgjXSRf3ddg7/nMeeFuY4VQ5YmjrZZfVYp/jtzrbMAHNAILUXZNStMgw3rD5Q2RjSb0X0rdJ7y4
 cnKZyALhgX7J9RJXWs0TWTquXQxoL5kzYbar7bgJnNf1aZns4Itr4uk32J/x1FaWKcDjFu85SaG
 SX2MewvIdY78GewfFor+lH7kLiHt/kUrrAXgoQei9/cXzF1MFWdNsucjXWajddacn2EDUDJXzUy
 aBDWe8EXPa+OLgATPTwFOzRTDqs50PtDQcKbl/INZvTGonu9VHeqAZVqO0UZ6G1OkJZ4oVYEUK8
 xvIVM30ZVlEdEQdBwUTaEaCdMfrej53IlPVf67oj/FCkqiSUSyvwwW34MfCZDTo4DdHjTwLpAFP
 c7BGEfuKGhDUuV2QYZCmktP5bvPxUhBH85VdvfCk4+qvbPTkmW/46poWYSYbzD5jCwWks=
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

