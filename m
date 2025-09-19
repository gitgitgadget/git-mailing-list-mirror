Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13C2F7AB2
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270418; cv=none; b=gNC8rwTqJUGIzqiHo5xxRPCj9uxuiaiRdoERY7YMZ41h49T5gOZMzaD8Djq/U3NpNzoGgMOrNjAmqHYZjTvGlg5nKle1ban3WgMhFu/KJPilP+ob2lgdNTRM2DnbwL/3JANwwmOxQ6Aj/uDd0pBxzNd9qmsAdHdWQCzglodoTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270418; c=relaxed/simple;
	bh=idHSlXDHVwYH1X6bfU3fy5vX6PfzR30HfyfN3VnVJ3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3d1Nfi2I9pRlDRR7XdaZYAQ8WRYzBa7ce8SSf2S/KRnNDZC/LIRn5G+aaCGaZd0NP91/6evlF4okwBMIQTj8Nfu0lOUfYUhjUMbF4vs9DqPNw7ib5vzX2F0p0nkxPUCKv6XTzd6RyAp2hfgAO6mx5BbfvEo8nAHoPg0eILkuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRAxOp+D; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRAxOp+D"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1316410a91.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270416; x=1758875216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP84X4fiWBDo6H1MfpOKT1Fg2xbvB4WaN857wiLs/7U=;
        b=SRAxOp+DXBHWLz5gTws/eeSQBMBZyVFiORpHBZ4bXpVlSFM4HEbUUv2hK7N6oqdaPy
         7LC5bhhRyCB+SvM7z1Ivj03lwBHySsUgDYRUSQQzIwIfRBYRDlHoGYeTYJTVDDONxwqy
         3UvEThgXJIVfFkV/SbT8hsLiigHrDGis4cgRY28op0ckQNAkrNacGbIGXR9ZFF4oa6Z1
         UvtKHtoxmZA2VgoQh6q+tUjcv9ojAtJz7Bp5VeN2PcpF4QPcfWJnmsQq5KaIiAOZRLY/
         HVcN1Bup0mgi1btIgeXh7gXIupCvDKkX+p1OeRXU2BnJxisxjktTVUIvCKs1ytEU/cjJ
         g86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270416; x=1758875216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EP84X4fiWBDo6H1MfpOKT1Fg2xbvB4WaN857wiLs/7U=;
        b=v7wB4g4YLDPgrFWjANkOdoCghITVzJ/QcSPz/23DU8ezGgoCDz6j07HbzCoK8HTFEJ
         wCqWr61m9rgNyCHR3B9jguQ9ApDk0784Lm7R696Svx0ASGT9OMEsL6JSyGNRaM2Zg/I6
         8pZyNdVcO5Mx+1Vo+qDpB9orxYDua+flJgACR0B8QTJb4Ck+XGXsn5wanYfrhY4oEuKs
         TVRmxYlvNNAYYuzhkw5mw5rEUlFiPeFbZgeUsvP015qxWI60/EKhsPtbkIw5YK4tuxyE
         RenowfVbRQ+KFGvrzs5VwJFL6FuibuXOwOUGZ8Rasgm+kd1zTAFJYxd9inGT0c4EUgjf
         G+TA==
X-Gm-Message-State: AOJu0Ywse2jeWiPdJkKEX0z+AE1i3lSwOpNoYMzqkXL9326LEdqWyzh7
	aJ/7seIaxETrzUzf+U+fFpqwsvsaKwjd4frtTVJ9ZOfmyZKA/PfYC4bQaM1jaA==
X-Gm-Gg: ASbGncti1Bqp1TXrOX25uTEkxot3drHet8GhYgrVU1LSHNUPn7N+y7Y/AulsZJt0Zjv
	nfv0jvWaNKGRGPEgFVA6wDFcjlFAlSr9/jbkUGNTNVUFcElggN6a7RI4L6qcJaTU33o0aPyqaCn
	SfF7nn8ZrA+ZgG7ImiPKFwTx/BgoQwKJPt9LzdqFS5ScrzXVR2EfzHXiO9uIoeNdwrySmXznItU
	y1HgPaB40WmBqrVAHbIqoXDHmwTNg082ANnlI+slOtNpfGeAZ4OrkbfrDlhE8uVv3KYGqwDuV/r
	thVdRszN9TKcN7Z9JhyPpVrodtsUbo2NXbvzCgTJMioG1mmAdusNeyb+9MyjQRN9ZyzFPedcTfa
	125kv34PwXwRAl9bX0Ow=
X-Google-Smtp-Source: AGHT+IEVSfcfzFqDOQA1U1OCTzSYe/9xzVF3ldV4CpR2NV89/4FV0oKEC/3dJU5ibfR3kYYXzYZAVA==
X-Received: by 2002:a17:90b:3a43:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-3309836315amr3173133a91.25.1758270416008;
        Fri, 19 Sep 2025 01:26:56 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:26:55 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 1/9] refs: add a generic 'optimize' API
Date: Fri, 19 Sep 2025 13:56:39 +0530
Message-Id: <20250919082647.535213-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing `pack-refs` API is conceptually tied to the 'files'
backend, but its behavior is generic (e.g., it triggers compaction for
reftable). This naming is confusing.

Introduce a new generic refs_optimize() API that dispatches to a
backend-specific implementation via a new 'optimize' vtable method.

This lays the architectural groundwork for different reference backends
(like 'files' and 'reftable') to provide their own storage optimization
logic, which will be called from a single, generic entry point.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs.c               | 5 +++++
 refs.h               | 6 ++++++
 refs/refs-internal.h | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/refs.c b/refs.c
index 4ff55cf24f..191b95b4a3 100644
--- a/refs.c
+++ b/refs.c
@@ -2282,6 +2282,11 @@ int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
 	return refs->be->pack_refs(refs, opts);
 }
 
+int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
+{
+	return refs->be->optimize(refs, opts);
+}
+
 int peel_iterated_oid(struct repository *r, const struct object_id *base, struct object_id *peeled)
 {
 	if (current_ref_iter &&
diff --git a/refs.h b/refs.h
index f29e486e33..d28c4ef0af 100644
--- a/refs.h
+++ b/refs.h
@@ -480,6 +480,12 @@ struct pack_refs_opts {
  */
 int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
 
+/*
+ * Optimize the ref store. The exact behavior is up to the backend.
+ * For the files backend, this is equivalent to packing refs.
+ */
+int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54c2079c12..4ef3bd75c6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -447,6 +447,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int pack_refs_fn(struct ref_store *ref_store,
 			 struct pack_refs_opts *opts);
+typedef int optimize_fn(struct ref_store *ref_store,
+			struct pack_refs_opts *opts);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -572,6 +574,7 @@ struct ref_storage_be {
 	ref_transaction_abort_fn *transaction_abort;
 
 	pack_refs_fn *pack_refs;
+	optimize_fn *optimize;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
-- 
2.34.1

