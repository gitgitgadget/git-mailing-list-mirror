Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CD539021C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555181; cv=none; b=YY6q51EaV2U4H+jttu9P95t7NXbUpIKjbmOJyKMwDwYK3IBTVzSFTS1mPhY7M0Yl86EGHWz+AX7IhqfQ7gKITlxkCHLNwJ3CXwqpLgYehQ+KKUplYGFjePFlQXyQ5rKX00hF5+zUnisuBsWmV1ZUMaLzKEruGlTq4qmlBVvX7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555181; c=relaxed/simple;
	bh=Rn1CSaYLntVUNYXnGSyKJ96AmcZNStC20HfoO4ZNYi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Marh1HJKy6QKiM0/65QTo0L9xYOpmhhcbzTyErSwX3LKqsthAEHjyh4uXjFPbQji+XHz2Xz78b5EgXZr9C2ADJKxcTDEyMracl7JzNRpu8Gs1SqAaS5IDUx6p3eIoDi3pcrluowMdYrJsFHgEGern7bqVCenShXrPRABAigf65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuUcZcqu; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuUcZcqu"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4518ad44e83so228169fac.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555177; x=1784159977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbmVoIELUrNoVIip/YUUSJYvliktIuqQc7uzBx/VwS8=;
        b=PuUcZcqugpclq2rt9+9PRPqPLG8nhq83AOXP/SLmFzThPz24e3/CxfNOoOtdgER58X
         TYtkAX8qBqimhRluV6nUw5t86hPxIO4RDu5fenfnMLSv3fqm0C88wEuaG5pZuXA18iAu
         wQmLQRXeGXH6MY9c+OxBziDDF58dgilfIC3AUVAfzevblnKy3CRs79ezLSqzZR5GFbL5
         dH3ogbGHynmPsBENYXkCpYZ+97MFaTIT0KA/R5RX9t7dNjinrtaTbvfhu7VyiwXgJyMu
         uYAj4jqXtUnpSthifUIgxrx71qxjjWtNm0FWu/Xdgvm8SevNqOZhpzmXLcsqboxHbWKy
         4+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555177; x=1784159977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbmVoIELUrNoVIip/YUUSJYvliktIuqQc7uzBx/VwS8=;
        b=PSUY6I9qafFUzVNs8pZVxCXSrO/3GL56LpIgOLFUMnJhdQAR4aSE2iT/4a4OZJA1K6
         YdB47/IMUL7qzzjUrZaKyMtRZLOapcXDUaFffDSWlkwCU0S9VmlaHp+cJQ1+7Xzj3//o
         vyQwKQPrFtDGY9jefEoTHs1fq1N/UI/vAplkTSxUZIlVIvjDoGknPbvUbogKel7BUBFX
         L6oEm5JtL3mK4qt0GFBMuUOKJrWbHaVoPAK6jzgX6KWYh+HeHHZ2RpzUbwIeP8lwyVY7
         jbeiJhDBHFaYHlFQIYKAsae0GPPM2XZo8sqvUJ1dNSUlN74/Aj439495um9Gz4D9+Bm0
         49XQ==
X-Gm-Message-State: AOJu0Yzvphh3tPkJaNv7C9Q1QmipLP6mY2niWTAN7Jeq0b4vKmhXa870
	TkfESq49M8ImKjLQgk6YCDyZmvqNZQr/fgdTc2u0mV9g5dIKQ/APSg8Blzisrg==
X-Gm-Gg: AfdE7ckVhtlcQeuamdsA2DOmc9SL5QHsD9sgNiVb23dVJrGz0xxNjwVraMTiGRwzMLn
	Nn4XoxPnCgJCxmN9Ra6/CFCCH9BHGwuw0eouyZoNtjuxcmNXoC8v19ZrRvk/KmNQhBvXs0Du+fz
	aPkqJPZ8YK7Y0kK8iHtr5fTLwlkfhi5vU9CJVvJUOmkPQtB4RYETInsfH7m/RSTn/V0RcBshP7e
	uPvpGvY6w7O65nuwsNKzaz1q8rer7RaOl3kz0BfUxbl6WQ45aWRqptup7a1weUTAIj/iNkAJ5Ck
	iZnbR36b2T57WRXiA59VMhpXnPMfVKF4e70/fe3iCA4MImjGJJXAcfDLDiIyR9yV2LfAqKt3UC/
	boOsdbi2sPg9E7k+WikiurlQOizwlecq0A6XuQDDeMfX/n2kGl7e+PcjX1bE3m37S96u5BBJ8GE
	iRyheb0PX7uUnPHUzvutt+OEAeqLFDmwE=
X-Received: by 2002:a05:6870:4403:b0:442:175:cea9 with SMTP id 586e51a60fabf-451637bb9e9mr3183290fac.7.1783555177483;
        Wed, 08 Jul 2026 16:59:37 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/11] odb/transaction: propagate commit errors
Date: Wed,  8 Jul 2026 18:59:21 -0500
Message-ID: <20260708235925.3992097-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `odb_transaction_commit()` is invoked, the return value of the
backend commit callback is silently discarded. A backend has no way
to signal that committing failed, such as when the "files" backend
cannot migrate its temporary object directory into the permanent
ODB.

In a subsequent commit, git-receive-pack(1) starts using ODB transaction
to stage objects and consequently cares about such failures so it can
handle the error appropriately. Change the commit callback signature to
return an int error code and have `odb_transaction_commit()` forward it
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.c | 10 +++++++---
 odb/transaction.h |  7 ++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index a5fba7f908..0a924e73f7 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -17,19 +17,23 @@ int odb_transaction_begin(struct object_database *odb,
 	return ret;
 }
 
-void odb_transaction_commit(struct odb_transaction *transaction)
+int odb_transaction_commit(struct odb_transaction *transaction)
 {
+	int ret;
+
 	if (!transaction)
-		return;
+		return 0;
 
 	/*
 	 * Ensure the transaction ending matches the pending transaction.
 	 */
 	ASSERT(transaction == transaction->source->odb->transaction);
 
-	transaction->commit(transaction);
+	ret = transaction->commit(transaction);
 	transaction->source->odb->transaction = NULL;
 	free(transaction);
+
+	return ret;
 }
 
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
diff --git a/odb/transaction.h b/odb/transaction.h
index f5c43187c9..3b0a5a78e5 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -54,10 +54,11 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
 }
 
 /*
- * Commits an ODB transaction making the written objects visible. If the
- * specified transaction is NULL, the function is a no-op.
+ * Commits an ODB transaction making the written objects visible. Returns 0 on
+ * success, a negative error code otherwise. Note that, if the specified
+ * transaction is NULL, the function is a no-op and no error is returned.
  */
-void odb_transaction_commit(struct odb_transaction *transaction);
+int odb_transaction_commit(struct odb_transaction *transaction);
 
 /*
  * Writes the object in the provided stream into the transaction. The resulting
-- 
2.55.0.122.gf85a7e6620

