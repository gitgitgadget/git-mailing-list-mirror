Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068ED22257F
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196360; cv=none; b=Gmxx7FJUvNwknoFBzI7+bZIVyxrbRjajO7E959122K8V0PGGzqLIDX7L4mc9tYFKyqsfBHM+kFRTgQBQghBuPV1c+6rAOcR5OqiroR9hbRbsAWFJvoJ38MCQwESSKHslxsA/5PKFtwETENhzuQss2VNmpUr5cUPVRf54k52uGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196360; c=relaxed/simple;
	bh=9YmifEGyq1ueljobaFVEbkIC66lNtY7vX4XH43M3rLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cto+rgxw1SoSIN13l7m8S5x8CsVaqNlx6Jh8PxlcNAbdl4s1FlvGVilTIFp/E+Nc0Uf9O8VPmfpltB4zOTM0RwFxfYWr9w2pSXEQWVZnG98VZgs+GV1qlcCPZK474qxkI918rTkT/JQH1vPTPlHjxEyn+HLdB7ZJSNJBNv6skyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2zthJFY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2zthJFY"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso5225808a12.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196357; x=1741801157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDPXCiVB5QBIs7R6/jJuJGsxfpKTePe6+C/xKixPjNk=;
        b=Y2zthJFYRRJwbjuiGoNfMZM9gT2jzhI0VLmtS3REO/RzpgY5mgj32zboOdP29VLlsr
         LCZbbkfj4STa1mVypJHLq2gC2GtKLbFIQV7q9wAhz2PULpnFkFxJDp7OUGXBC4u56pTZ
         o6cDNiVIn35c5EFniPddzC2iEep2H//yk7uxLpcu2NY5EnWSQe/cStBj9ntriONBpODn
         mS/putZ/3BumUmkobBc3aO8jmtE6bC2sfhJnR2bEh/xvyOdcE8srfOmuUCu+6qScCcrX
         6Z1NiJLdbDcn+OOMVen/XUtOPD1+BCWGDZ5N3/7BXs3+xeLRAdPtCu/cQk3kpZpmMfSf
         em6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196357; x=1741801157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDPXCiVB5QBIs7R6/jJuJGsxfpKTePe6+C/xKixPjNk=;
        b=Xcq5I6ZHN4xn6hEbkWL+72A2yx0CBcFgJ25A7KIv+YhLYC7DovmJJcP5+XwkgkDL7w
         00HaFbaGKbJyKLvc38HNeVllKRdG5U93DQj4PHk5KinScRZusO5YUb17oa90JvwW00bO
         ZUL1CkYk0OGTKmZ+g/DG8EkPcpvwc0+oc/hUgHG37f5mDDc0zsGVeMqOP2/Wq8UOz32/
         qviJwZJ9AwbjoD6TSH4j08DZOVpOcKNhRIvIoTphqd7yk9aVsg/Zs6rfoPP7ZGO09XcP
         I9nTp0x9NGrEr8rhNxnAocpoMN3Jg/Wvj5rWUVxyUJ7r3wc7jWNQZZvxiFGeKp+kcX/A
         A7FA==
X-Gm-Message-State: AOJu0YwLdm8NKb/HlgoI1k9BtHqgIVzWbRk41sP0DZ9Ac/9Nxc6ddw5F
	LpT5cpYXpQjq3sRlOMq5zM4ECsNsGJyi0HPBUrAHdgLj7II7zz2ebHgpKFnZ
X-Gm-Gg: ASbGncvmdXTxZXTSbsrgCiNwrYoCyT5JRqybObYXYF4YSUZmyKMCJb/l5fnoyKcosF5
	tj7gsNqR+/GlDoxX2k3hAAGDpbkBtFuA1Z19wVJYh3BcMVXHBjjeQKMWLsz/HBxdtf3uhJQ/240
	9X4dcnrDubweGKJFdbXztrb732H0WSb7elci3VLFUh97KeB3Mt25DE6lH5HkIx8bP/flvb8xZQ8
	xGBo8tE92j4cfihs4ctD/qemGfSVk2QAHL8r85Syk69kRsBz0uTMnnT/deWxMNB8fvQLA4WpYVd
	a7209sPbEpAWamxzQOH4/cs2t7hnLz9Ca+oM5CTOd20mSvfpVw==
X-Google-Smtp-Source: AGHT+IH9nTC3uCEOC4lOHVLPvO8lyxqyk/0cVrU0kIO8WR356kxKtUiSOb06lcRml7Mj8vOTuenNoA==
X-Received: by 2002:a05:6402:34cd:b0:5e5:2d5c:4f32 with SMTP id 4fb4d7f45d1cf-5e59f4b69f9mr8869259a12.28.1741196356666;
        Wed, 05 Mar 2025 09:39:16 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:16 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:38:58 +0100
Subject: [PATCH v3 3/8] refs/files: remove duplicate duplicates check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-3-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9YmifEGyq1ueljobaFVEbkIC66lNtY7vX4XH43M3rLI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEDFSxV5U+shYinBLFSJWDxOZpkwZ7B1M
 cQ6aBqeVQgFoYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/tOMMAJF1y0MpONJ9tDdFr8UB4KnXunWLeE7LjymXogL6TjaQk7ZmcclKKp75eugA24cbdh5
 f2FerDr8Q0OJJEs8klUS5t4UzjQi66RVUdMCoF38z9zALlgpF9XVcdYUKw5NSO8Ggnsa3pbljEG
 glNIsNGcCR+d1UomK6yt1o2f4NRPJlMf2AsluuhofQ+oNF6lVDKwUjVKS6yw0XFW1lLSve24WUF
 rorlxy5sFNa1/y1bItyO3lHIyzhYpnXK1+aFahY1F9OcvFyXo13Zf3uiK1CJ9yLq8sjPKCeInoV
 F9PhHMlHQl6MUtS6Sl3DhvPA+8t/L5CGL6iB4npsQ/tPJDDsNM4r9s4+S0P6uu0mMCfPUcBrnte
 k1yr/DlWAEQPLVJuTKGnaH2BUP9ORanrAjFa5Z79Irv7sK/6agPDIBVVphFeJ07xpOXQzACH9XF
 IuM+Ks6k2E0Y61fswQfQVGG2Vn0FV85NuHrguIu1BBO5K6wZKGY2Xt9TDyofbpepD9HAPvErlp5
 hM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Within the files reference backend's transaction's 'finish' phase, a
verification step is currently performed wherein the refnames list is
sorted and examined for multiple updates targeting the same refname.

It has been observed that this verification is redundant, as an
identical check is already executed during the transaction's 'prepare'
stage. Since the refnames list remains unmodified following the
'prepare' stage, this secondary verification can be safely eliminated.

The duplicate check has been removed accordingly, and the
`ref_update_reject_duplicates()` function has been marked as static, as
its usage is now confined to 'refs.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 9 +++++++--
 refs/files-backend.c | 6 ------
 refs/refs-internal.h | 8 --------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index ab69746947..69f385f344 100644
--- a/refs.c
+++ b/refs.c
@@ -2303,8 +2303,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 	return ret;
 }
 
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err)
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+static int ref_update_reject_duplicates(struct string_list *refnames,
+					struct strbuf *err)
 {
 	size_t i, n = refnames->nr;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 85ed85ad87..7c6a0b3478 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3016,12 +3016,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	string_list_sort(&transaction->refnames);
-	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92db793026..6d3770d0cc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -142,14 +142,6 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
-/*
- * Write an error to `err` and return a nonzero value iff the same
- * refname appears multiple times in `refnames`. `refnames` must be
- * sorted on entry to this function.
- */
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err);
-
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify

-- 
2.48.1

