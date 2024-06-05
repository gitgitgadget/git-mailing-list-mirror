Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600E191466
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583405; cv=none; b=MhYoNJ23CGWFgqZtxxgcOskWjz5A4+ZVJLQizJ9w8PhxCUGA6HLYcpVQs+tApG6fw4kwtV5DuvmRupfSIdjG6KJ15ClPIJNDV1CGqATmTM6pliyYekcR5eXaZGCEKzX65r6tW9wZuw7IZHGfQmaKwpbJPGHE81ccHLgq9686aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583405; c=relaxed/simple;
	bh=t2Sh2uOYymZ8PY1NxFZ+tdvRzLosECEg/jwYIX9U8wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIpEbjShTfkL7+gEcfoDWGN23q1ljzB5nZzGIKSAR2wWx1kOFDiT5rKCabve0cu2EIpgqHXxjWRbRCadc+ewxoI7ZiCgwtv1kdcia2/PF8xuaqzObkWLJ1NZ8WRr/+EpOwEHhkVppdZeBgoUfOfth5bNSdDMiamgbEdf9TXiLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbi6XIJy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbi6XIJy"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a626919d19dso143350166b.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717583403; x=1718188203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=kbi6XIJyHPC4eF3IdwwzsFyh+MTpGiTlkecqKZAyrfsBtBNENSQJba3E32zMyf/lPs
         PcAilvxxA5jN7yKIMHyux8p/AjKlGPU6kgXAlALd+FAC138PBVED8o76Hch6chc/nmb9
         c5tjJpsMnHX6/1uptl6Hs5uVZivXSjtsloXDPY7oPHNyLWI0Rp/YomYkpacKrr7QVUlg
         BXcu6++qxYQCekDhvJOVMZ7pZFQk1aV+iR8grzk+Df+F0RiRLu4FRpi08lrnl3xEjsEh
         mHE15OTsf4Ji058j18HuPrYL/awElmkpmjz79BAiu5pSdCXIBjhnnO8yJRlCLt0nvddA
         E79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583403; x=1718188203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=j+sFxW+KB5uVjz0XA6ZqsL8hiu7zti8ALo6M39iRmdU4b+bf5lj8yDjg7mCDXbltiX
         gSntiTwo5PWamYfUkDR/iI1IcCxIAxZyIVdD3Se42h3HGJMBKoFT2sx56UrlrdkOhlHp
         rabAOG4sHp23RXjYgwg9woFB9sSvUoMCamvYoflvnUgq2rgHay2o1/MNhrfxLCo2U3i6
         VKLlsyAG+ozywKMlgQ0lrXdXL8UgsScK+fyIZq6T7Rd2iO5YoLv0PFoy7IHRNplT8snG
         hzyOfD9wLJPzptDNHJGXdcncmzVICSeHxEZ3+DqPSvKkWsETglHP6uZm504GJdhWWcWr
         tjZw==
X-Gm-Message-State: AOJu0Yz1rtfiF5mm4nyl80YR9Ijm685BpQEqW7u0LqndqikSODkyajVW
	yUUYI47PJ7rKFc5kE/Z4LTf7qYCkGc8U8QyVAwEksWqdN1dVNOeImG3S8EPA
X-Google-Smtp-Source: AGHT+IF0LQvEupp42GhTvcSJ7PuC7/DrzsSnSiX+EBUgZhzQuLG+eU6nWtk9FArMItqHdtJMKCLcBA==
X-Received: by 2002:a17:906:b09:b0:a5a:89a8:49c5 with SMTP id a640c23a62f3a-a699d862f04mr178017466b.33.1717583402539;
        Wed, 05 Jun 2024 03:30:02 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f0e03cfdsm510453166b.195.2024.06.05.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:30:02 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 1/7] refs: create and use `ref_update_expects_existing_old_ref()`
Date: Wed,  5 Jun 2024 12:29:52 +0200
Message-ID: <20240605102958.716432-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The files and reftable backend, need to check if a ref must exist, so
that the required validation can be done. A ref must exist only when the
`old_oid` value of the update has been explicitly set and it is not the
`null_oid` value.

Since we also support symrefs now, we need to ensure that even when
`old_target` is set a ref must exist. While this was missed when we
added symref support in transactions, there are no active users of this
path. As we introduce the 'symref-verify' command in the upcoming
commits, it is important to fix this.

So let's export this to a function called
`ref_update_expects_existing_old_ref()` and expose it internally via
'refs-internal.h'.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 6 ++++++
 refs/files-backend.c    | 3 +--
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8260c27cde..50d8d7d777 100644
--- a/refs.c
+++ b/refs.c
@@ -2679,3 +2679,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+int ref_update_expects_existing_old_ref(struct ref_update *update)
+{
+	return (update->flags & REF_HAVE_OLD) &&
+		(!is_null_oid(&update->old_oid) || update->old_target);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f3089d947..194e74eb4d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2412,8 +2412,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
-	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_oid(&update->old_oid);
+	int mustexist = ref_update_expects_existing_old_ref(update);
 	int ret = 0;
 	struct ref_lock *lock;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 53a6c5d842..ee298ec0d5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update *update);
 int ref_update_check_old_target(const char *referent, struct ref_update *update,
 				struct strbuf *err);
 
+/*
+ * Check if the ref must exist, this means that the old_oid or
+ * old_target is non NULL.
+ */
+int ref_update_expects_existing_old_ref(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..b838cf8f00 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -824,7 +824,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
-		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid))) {
+		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 			/*
 			 * The reference does not exist, and we either have no
 			 * old object ID or expect the reference to not exist.
-- 
2.43.GIT

