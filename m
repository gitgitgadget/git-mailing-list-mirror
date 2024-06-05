Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94C372
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583407; cv=none; b=B83fbzcKH9TDMcjCnD+j/8xiXVe0aLHSXxn/MyC3Fv1U584bDE/ynF9SG+mdAgbpfD5KHmbVvaGs/CMl9e8/lBPdQWDnwd8umybi8Af39Gk5FmeLsvp66adx7xgqiqxOFIUiCQixoiIBUxvKO93ugygM1QpJqzOj9m7nTO1iQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583407; c=relaxed/simple;
	bh=LNR/syMRT4IlPZI5JIJYxOYMSSo/M7SqH3sJ3YrMGyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzx2na1vkcQrMBLMs8MaFAyeaMpYfw9F2/HS5lpZsBHcAERbAoPlPT8UBrtCnaXR93Gv+eVdwn0k50jWLA2v52HKYTpZbCiNKgPsf+UF1R/RBiYV5zjN5qlKWfK+VOLncr4Pssy1pqfVMb8y1RovEKWF0oZ5GlfKhWjLMTIb6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuebQnHl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuebQnHl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b98fb5c32so4940131e87.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717583404; x=1718188204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeOoVzhDuim50hVgDRPDpRgzjggdoPyYqybx4g7Pa7A=;
        b=TuebQnHlUqPSSNKuWsyUA680DhqljudOhWwCvRWC9guCkm8XuEprTvpCfdnbMP4Kkx
         PyhCWLcQYR9ypDsqtAOAleCfcgOfjIEZ/jO0BEo7565hwWnhRar1kE0Ei0F+R9Wgek7u
         4RHgJdIExOv5rtqIsgTu/JX637ouzGqvdx0l1lo1Kx0uIzgyMXwslxP5QyHAz1zYOFJF
         UFpoJ6SxYrHt5Llin5XYLv+pH1MQXnQR1tIV2i4jEGhy1MOIuyXUsdm+RzZtE7HXNAmN
         uerSrcH5yF5D3rFMfxF1WNLv+WsNDOn+bOGt0vLlpU8aWzt2SBAHRteb9d7qF4YY+Uj4
         /T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583404; x=1718188204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeOoVzhDuim50hVgDRPDpRgzjggdoPyYqybx4g7Pa7A=;
        b=MIO6dns+2ZaySYZy5+cEk3VvmiIjFvvD6xr1INMbIfOkDjCoMeNQ2ujddigzqIH6Th
         2DKKyiOQVNH5f82iez1455Nu5fQ4NONHqPe4mUT4ou9TTKTvtRKOmOF+Q1tSN/MxIQzq
         3pstDrQ0RHEM7GpdcxOLH8NqWm+qEJztvqeh1+21tlHe+qp6b27ib9qkziZwSvCrSGcM
         H9z4TxVtraR9E+PvcNJ8mapFH6AB0k54G/SlLZifz5HsOFrKwER2JGPxKmDzwpZNGuD1
         4fcjCfKrqnT+myYOtlHIFIuN+uLwiyCRhSPCjaJUFquHQd7naAe3pjOu/+5dv/lTSuGR
         l+fg==
X-Gm-Message-State: AOJu0Yw8S2kdltiRFGTqQm2OinSKOeHZCjxhSDAQfcAeIO1+6uoivgdD
	HywDfD/fl1ZYSgjEGnFDoEGlsuuZDswf30KJxIt2jRqDuaICreeU
X-Google-Smtp-Source: AGHT+IEGsUqxlVDiKBKG5MZbmY061mo/vpDTo0klpfT95PsAsXGglTh32cdj4NpRX5hy22R3igvZzA==
X-Received: by 2002:a19:2d4a:0:b0:522:2ada:c02e with SMTP id 2adb3069b0e04-52bab4fcaa1mr1639303e87.53.1717583403792;
        Wed, 05 Jun 2024 03:30:03 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f0e03cfdsm510453166b.195.2024.06.05.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:30:02 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 2/7] refs: specify error for regular refs with `old_target`
Date: Wed,  5 Jun 2024 12:29:53 +0200
Message-ID: <20240605102958.716432-3-knayak@gitlab.com>
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

When a regular reference update contains `old_target` set, we call the
`ref_update_check_old_target` function to check the referent value. But
for regular refs we know that the referent value is not set and this
simply raises a generic error which says nothing about this being a
regular ref. Instead let's raise a more specific error when a regular
ref update contains `old_target`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c    | 13 +++++++------
 refs/reftable-backend.c |  9 +++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 194e74eb4d..f516d4d82f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2491,14 +2491,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 		/*
 		 * Even if the ref is a regular ref, if `old_target` is set, we
-		 * check the referent value. Ideally `old_target` should only
-		 * be set for symrefs, but we're strict about its usage.
+		 * fail with an error.
 		 */
 		if (update->old_target) {
-			if (ref_update_check_old_target(referent.buf, update, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto out;
-			}
+			strbuf_addf(err, _("cannot update regular ref: '%s': "
+					   "symref target '%s' set"),
+				    ref_update_original_update_refname(update),
+				    update->old_target);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else if  (check_old_oid(update, &lock->old_oid, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b838cf8f00..bd89ce8d76 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -928,6 +928,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * backend returns, which keeps our tests happy.
 		 */
 		if (u->old_target) {
+			if (!(u->type & REF_ISSYMREF)) {
+				strbuf_addf(err, _("cannot update regular ref: '%s': "
+					    "symref target '%s' set"),
+					    ref_update_original_update_refname(u),
+					    u->old_target);
+				ret = -1;
+				goto done;
+			}
+
 			if (ref_update_check_old_target(referent.buf, u, err)) {
 				ret = -1;
 				goto done;
-- 
2.43.GIT

