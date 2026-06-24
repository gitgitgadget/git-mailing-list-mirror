Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F5366562
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274777; cv=none; b=dxBo9s4sxYU34eptxfnxACQdPhFusMUksXDIryFVBO0yAxuiPgwhkIK1BpeRME4C9aoBGvyQQP680zqmE4iMTsnPqYl8WK67UOUVADypu5m3T0XYg6do2cIqXCTYiXiQOsds5+YdtekFRFwifXq9Zt9uVcCEWXsG6DWiwDdxc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274777; c=relaxed/simple;
	bh=X5y9dmRXnPWnN0seL0479CsL6O/dRLmoPTOF9qsf+XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUsTB+iNOAPs5Iu69TMObP2YP1ILaJhC7yev1NHIVmgbgo19tU3TGhULVH4psoasN0wt6Km1o7JNkkheRVvX0OqH3JEM2ZeKskd0wB9sLedE3V0vGjdSqFiFyI1JatMVXn77HgpjWuJCbpFv6C7PfP1trxVeNhlzGeQBJdE8a1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSHQg0xP; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSHQg0xP"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9797ec365so486313a34.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274775; x=1782879575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNXJKVX7a0IPKtll7nTbcU+VTiQgSyLLm+/Al0IECzg=;
        b=iSHQg0xPeFceJLT7pnhNGTWVnWG7U9Va6IsDSnw5DtKOgOA3wxAFJl/TB5WUPFJom2
         CC0cQ80HcvI0lP61rNUG6VWPnQH8Dk1dTTG5byeKe7tV2770sDom+LzF5xvxBSQVP9PV
         47vvihe1hs8biaR1uJM8kR22CMr0n2bF25HUiBqrWXhih2QSD+yO7mNBEn8+AwVlngxj
         yJhwTnG5Uc4uj2aR578v5MwLzesmezNkMrQoDTudHlkaHzG/sE/14PUFpXpQF4XfHkS6
         A+/6ryP5ShpKSoayr3Ib9Ih5ShoKD+NZ3QGu7RVJbhpSavYAuq7di7ca7CMZIfPqiyNC
         SNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274775; x=1782879575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNXJKVX7a0IPKtll7nTbcU+VTiQgSyLLm+/Al0IECzg=;
        b=lgZzqyI1jFOoKhG+aBvgxoNanZf5Edf183NFDuapGdJROl9p3mBSSsL8n36wT+FSML
         ORWa6i4CCJmkCARpR2RZkOF6GioAQYYqPpKNiGpBegixK7XTjhTjcliVyWuKMIZHrXaB
         7Ojpzqvf4JxHSfYOWljSB+eTmEpLumeuJijXxtL2/4B85RJ2rqUlKlSHbN4Se+1PAwhX
         0eE2niDu8+xJkHdsEXziVcBFzjCybaIL6pe4rOSmWsjRZHwAZ8hfSyr5PAM4oDCPD7FM
         jwjq8TDVYSzoeIQfDkKcOdFWPI9fNSvyXFDEDtPbRv4xAeZFgT1033xckGDsGLCyhq6I
         nkVw==
X-Gm-Message-State: AOJu0YwrcdBDr+KxPmmfdwC9XmqvhfDAsHXQISEF9NsEKl96P43V52lG
	hEVHAYT69QEKcMhY9Ds+fIaXyP74Ti0Na1bje/mitZ/dGe75zpXb7q6UHxShfg==
X-Gm-Gg: AfdE7cnN0yONg/sm4DKJwN2MLI1Ue7vmuentztjB894slZGrnboUn4dI4KJZ9X+/WBm
	BwM0WfGTTcCfINu36EiXYKmTI6O8BQGOtyXGU5q69tpmcZ1+p+qJXCdLpnl59z87BKINwY2Kftn
	Q2tHCyCB0lA5I9ueYwhm3c1KgpbY0HeLqwXcapNRATSeJptIQaDkuB560KZ2VFtOdGXPr09oJ5I
	Rgolt2yNHUUCMfhoI94YfoG3B60nfOi6+vbKiioS1kX9HdZ4KPwXVwm919Tv23+j9Z9DH97dBwQ
	XjtOXWw0MvF8Vii2yPFAboUvxzfOTRHOh+UhKCn0sKevxK4X8XrrBYDgysOlfBFeS6YoAXu3x3s
	xbU29aSaPP6Oe6j5+TXbQKNHU9565/ZgRcpa2AIW5/YtY6zBuEMZStFXTSZY899TqwwoHXlIJiS
	pT2cUYRTtvAjM1gZEDRNUZ
X-Received: by 2002:a05:6808:67c7:b0:48a:67e8:69c4 with SMTP id 5614622812f47-490796859a5mr1401470b6e.22.1782274770712;
        Tue, 23 Jun 2026 21:19:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/6] odb/transaction: propagate commit errors
Date: Tue, 23 Jun 2026 23:19:18 -0500
Message-ID: <20260624041920.2601961-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
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
 odb/transaction.c | 13 ++++++++++---
 odb/transaction.h |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index d3de01db50..b20d6a16f8 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -18,19 +18,26 @@ int odb_transaction_begin(struct object_database *odb,
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
+	if (ret)
+		return ret;
+
 	transaction->source->odb->transaction = NULL;
 	free(transaction);
+
+	return 0;
 }
 
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
diff --git a/odb/transaction.h b/odb/transaction.h
index cd6d50f2e5..7898770071 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -54,7 +54,7 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
  * Commits an ODB transaction making the written objects visible. If the
  * specified transaction is NULL, the function is a no-op.
  */
-void odb_transaction_commit(struct odb_transaction *transaction);
+int odb_transaction_commit(struct odb_transaction *transaction);
 
 /*
  * Writes the object in the provided stream into the transaction. The resulting
-- 
2.54.0.105.g59ff4886a5

