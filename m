Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828442D5C61
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047389; cv=none; b=eJEsDbvtU5kMyRjvixQQ/6IcgwNziCCQ3IcMpkO0BVN3MRbOp67G1hHbQsyngika0ifFURJYyPejwrdzWHyFn9Eb7zKSghYH9QYi+ZrjRTgKc4cMFIhb21L3TRhBr3BsV8nStVMchXaOsKmrx7Ot0R4ja8BWnS7/zciFXqLvgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047389; c=relaxed/simple;
	bh=ptB1qg1jJuR4STk5rO0N7df1Kea5Z13jWKOU4xRH+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbVG/DPzsTJSGgW4G5G4ulxrjCIthibyA5NLrf9LrGRYy564gnGq1yVjZ2JrtYyqnT8Z2Ug3ptH7++tt0eaoq2YTmD7sm36Wr/Mtbj3BRHydMm5dkwqlHOpW4Ztr8JjbQCvQ9FPwRdkBsmJhaLiewQWY0oOHD8xmY/Uo61Rw4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/qq4/f0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/qq4/f0"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccea8f43cso116471fac.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047386; x=1758652186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3hfmHqvfCr3AGzO9v/xGtXuC7416CP1DAgTxqcQ854=;
        b=f/qq4/f0S9rJvRyKGajx+CezRBZuIGC78zAneTvj/P9PJAW9yrWoFP2qQLgiwfqzx3
         eY8DpyxodVvr27YE7oBMoeIcGgfG5Wbzm7E43Hnh0A80h+wfwYZ/1P3pEnFKaWzVJbFW
         diWykvXnKYlymPV+GfHA9ILOmGFf/2Pze59J1Qisb0q9n61elZ5YOA6a7Z910BvwIvZl
         OuI9N7bPutVOYV8bddKhl+QsSamjW1u24FWalkArNJQRFepZv/tOdQnB4EuCyvEBOQwC
         IJ49Aymzav1hDSw24we721Bo8Woe4QHXnlI2e2mV6jIDyiCtdJkO8WxtsOZqIuyVrhkf
         8hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047386; x=1758652186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3hfmHqvfCr3AGzO9v/xGtXuC7416CP1DAgTxqcQ854=;
        b=V/62i9b3rTKpjbPpnYITP4u0ZigQtDZhmraZqKz+sJwWp7eH0BBVsNow4dkrNdcOY8
         UnhgmGDFEr7ZV+80R+LwGZm2VXNUBJPySKY4mFwOoX7/izjJ8/cEkbPm7m9a1o84Ew0N
         vM+nUwHdfyUC0UO+RmvxrVlu2ovjKkIUzpt4dldmAFtO083FnxnaxX+NE2btJ9OFjfRL
         H5jTNI9p4xmMJ/zL//zMOS707+bAn7vZNBjNZgSLH+MqZm7pQr/VMgzj51tIPhoWyBwO
         OQOexzqwo/KRo8aLUWiOO+QbRuK5Qd5LdoB5FfaaOcrc9bDkiD3DuMuKOROf7hRm05zf
         cC7A==
X-Gm-Message-State: AOJu0Ywbr2W0dsSsOoVwb1i+PBiHm8Ax2RTsn6deA7v4X13Tk5G1iHUB
	z8kNvGpdKlGZ/bXviUz8vI/K4AdhC/tPjK9tOWJXTh1eYkRcGYAhu347b0T8Ww==
X-Gm-Gg: ASbGnctD8owt5C7EKWaWrOYkb2TWrlMTmrquCQ+v+7R5Yc+ORY0jvnC14TMYnYzcDCc
	/FJp/w/Rs9aNKwdeeAMuZQAdgAOoCOyRzNYAL3hzc6T2fzdCuQbPVFFKRFvc8BAj6IgTfOGzkFV
	hnguZ2CAmx8KhJJyHdfwahiruTEXm0hRmccveM6ZMFai0Q2Jgv7syt5XH821t194mSgJ725Z2lH
	AsAjzD90Fd7oKQwlMyFllKr0WYbaR5p8vxEUqe/AW2tB7j7W8jkmBoYz/iVm7PrS4IimpG4p+vS
	/ft1PkhPAVhQxdeUO8Q0cBkgXxLM3PdrXEItbq0NQPGz6TEFcKTC/qjus3hFY9xZLeXuOL9Bf2s
	OFR5gtOkQDo58JmwezxyN3hNbTQkm7HY=
X-Google-Smtp-Source: AGHT+IH/M3jVMr+PNAfN2TsF+GJHLsAYg0bxYTqYt3clIsaIAd6LAaxdkbiu0njEYIKKuxiaoWM+1A==
X-Received: by 2002:a05:6870:b17:b0:2eb:ace9:197a with SMTP id 586e51a60fabf-33451b16baemr1778046fac.5.1758047386331;
        Tue, 16 Sep 2025 11:29:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/6] bulk-checkin: drop flush_odb_transaction()
Date: Tue, 16 Sep 2025 13:29:35 -0500
Message-ID: <20250916182938.2193476-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250916182938.2193476-1-jltobler@gmail.com>
References: <20250915202956.3784935-1-jltobler@gmail.com>
 <20250916182938.2193476-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object database transactions can be explicitly flushed via
flush_odb_transaction() without actually completing the transaction.
This makes the provided transactional interface a bit awkward. Now that
there are no longer any flush_odb_transaction() call sites, drop the
function to simplify the interface and further ensure that a transaction
is only finalized when end_odb_transaction() is invoked.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 12 ++----------
 bulk-checkin.h |  7 -------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index eb6ef704c3..5de848deff 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -376,15 +376,6 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void flush_odb_transaction(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
-
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
-}
-
 void end_odb_transaction(struct odb_transaction *transaction)
 {
 	if (!transaction)
@@ -395,7 +386,8 @@ void end_odb_transaction(struct odb_transaction *transaction)
 	 */
 	ASSERT(transaction == transaction->odb->transaction);
 
-	flush_odb_transaction(transaction);
+	flush_batch_fsync(transaction);
+	flush_bulk_checkin_packfile(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 51d0ac6134..eea728f0d4 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -43,13 +43,6 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
  */
 struct odb_transaction *begin_odb_transaction(struct object_database *odb);
 
-/*
- * Make any objects that are currently part of a pending object
- * database transaction visible. It is valid to call this function
- * even if no transaction is active.
- */
-void flush_odb_transaction(struct odb_transaction *transaction);
-
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
-- 
2.51.0.193.g4975ec3473b

