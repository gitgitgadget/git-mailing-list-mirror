Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3441C1F03
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086218; cv=none; b=o7JoL5gM2KQElb4NFAaAp+GkUy3hzX0jOdaJTmbdxs3jj8kCLdVdqnPS9TcQuGWNx40H40cL/kZ0rGSHR3q1p3r72D/g6vQ56mzstqkT1HtlpZySeuGFEMQneClPs5/UBTsZVrbYN9wtXKULxOesvBKXnXIEtdIZY6Jby3wEVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086218; c=relaxed/simple;
	bh=OqbDd3jsfWs8s5oNdnPUTcLB6APdMSxltVwJQdqRtRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jquQQo7rHyy1nJxKy1aIm5qiy1VPdhLjMa6caosso7GKXKvyBWl3jtLHxVNcCffZ21TWmcVOesefuksjk6j5Bg5QAx18wgjItOUdfJMBMpI9rrSXSHJ2BEere7+0aOpEzotYWDGqyigQFudW6tt5AbsT0myoJL5H+Ojul2oksm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAxjsp9T; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAxjsp9T"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa692211331so311031666b.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086215; x=1734691015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvQRFT0vg1nsS3aygyDwNZGzsFcPMBGk2RfdqS0CpN0=;
        b=CAxjsp9TrOm3FeIe1L5wQy64mC3WyQCU5/3Kiw8/xHLkdT1F1RclcSsoe0mI7Rloh4
         94sJfxHVZSgo+1fiqhK7DzCDLHTkBhrV1feDfmOKF5Cxc7CzbeB87kPGICr+un0nijYU
         RC8mQ7Ms1Iu6sJEd5/C4eWEhODRQxQqlNQ1bvqXzQiAlHv5MM6381Wo/ArvkDo1tTaUu
         ykDfQ10MrVDtweGZbTZXj0/7fyob3DDmZN7+FneysqTLtUBQGkYXd0yNpk6a/GlLRZsI
         VFmsmBiZw8FfXvZOJZfCrIxYkC/j+CQUz2U3biicLW67mUyisvWn638Ytfb2wIphtRLO
         6Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086215; x=1734691015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvQRFT0vg1nsS3aygyDwNZGzsFcPMBGk2RfdqS0CpN0=;
        b=qJtcIkFTwvuUEItucSxlgiZ36wLpSp+YV5SDqerIgje7JfUaisKZ+est668leorufw
         ok13vNt17keAjXmL4j1PgQbTX2GnAtbpGAORjiej3GpfF+H0SZOnz5iFWIh1rEF32fhM
         P12cUwu2nvXCMABCimkIDwI2w5mUjYbTh+NYe9fD6dW5Cfr0S9XCYsQ6bIzM6JJ5EVus
         5Br1PS2bl6eYDN1PB/PEtHRQ5jccxeqG3ZBUymwIRj8tKP7dmQR2xq86ncJV74UWT7j2
         ft7jbCO48krwD+AMKJ1hkk5sYF0cAapYfv7ksG24eTsXM5PKDDci5pNyA/fBpggeheKg
         9frQ==
X-Gm-Message-State: AOJu0YzHRk6V3bce8UZaJTWE5GuMGBex8ohW2JGzLYximDcVyKjbJADf
	GH6Set30fMhKLoKkR+MozWJ0wOmwaxZneG2Oqxs77AHn84Pqo5Yj
X-Gm-Gg: ASbGncvuM2RSmSjexnkSzgyxTEBQW2VAneHxd2w5FTfoRb/ApfiDIRQF6YUE+SA75Hz
	YNcYB43bKaMtU7HacplljSK7b+q2kJHjbR4QNWkPkfUsXc2XsxbEf/8h88UU2L9oxAB6md3PPw9
	e6YqLQlgZwQV5A6H+g1dmXDcbh9DSgL9UjFqYvK3i5bGxEVnT2vmHGBikCa2t6GKMV3IP26qh+t
	q8Hp2CRLeIe0aCzgy1OQ7kBlzz8QgQcATYvYbj9VTfycqQKjdNYE35yzmsMvXd3hDTCqw==
X-Google-Smtp-Source: AGHT+IGo8KjwbWZK08sx8dLQUpPpCbCwl4+FehMYeIR43yPAEyhAyeH4otJ0wUXOp09sWhYJQl6AXA==
X-Received: by 2002:a17:907:1c1a:b0:aa6:9540:5714 with SMTP id a640c23a62f3a-aa6c427589emr509985966b.25.1734086214739;
        Fri, 13 Dec 2024 02:36:54 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:54 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:50 +0100
Subject: [PATCH v2 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-5-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=OqbDd3jsfWs8s5oNdnPUTcLB6APdMSxltVwJQdqRtRM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5AqjrAOASHoZn99LJYQSLKci2tz2Anp4Mst
 J5o2LYXEbGJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQAAKCRA+1Z8kjkaM
 f9kXC/9Z6hhcAqe3xrFbQwjIGe3zUI9VgYvcuNT5xNXACR+UBwNYdlYDG+KaVT9/j8vv9FadUZn
 lRAYSgel5Q/+HfOq/e3ga6YMnVoCvHZCWgt1OA1HI4gfCCn9z1fGsbwzs1YtwkzfixnYR0e0NlV
 VtrF1kCVOj7Ih+xEABw23RZm8JDdySOtsClciFJ7/vT4PO+GYuO7H6BCz70YJfdhn1bnzZEotTE
 t5kO5fngvrSKPYA1pDojjy0xmfpWOKo1jh2C0bVyKe084y2ZShsOI5W7foqz1moYFlNfsa60EKo
 li8yqYeMO2MbC3+emLoNjvajzWbEXXQW7Ebm39demxjAPCFA4+/9+ixTMlKek1eG1FSLESdjtH4
 w+RzJZRzu7CasITIGud2OZTYWKo4xS8H4S54Ikz5xCOoQbu+q+ZyWHfH6XonfheLV1nW+LIMgzv
 oBLQQhzF8g7nZ+/fU/utrnQG4NLFENefzvYLQHA6DOoiGCHsvri+nKoAwuslLPGIretbQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_add_update()` creates the `ref_update` struct. To
facilitate addition of reflogs in the next commit, the function needs to
accommodate setting the `committer_info` field in the struct. So modify
the function to also take `committer_info` as an argument and set it
accordingly.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  9 +++++++--
 refs/files-backend.c    | 14 ++++++++------
 refs/refs-internal.h    |  1 +
 refs/reftable-backend.c |  6 ++++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801..428ca256f3e5860554e9a7fa42a8368bb2689b31 100644
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
@@ -1190,8 +1191,12 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
-	if (!(flags & REF_SKIP_CREATE_REFLOG))
+	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
+		if (committer_info)
+			update->committer_info = xstrdup(committer_info);
+
 		update->msg = normalize_reflog_message(msg);
+	}
 
 	return update;
 }
@@ -1253,7 +1258,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
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

