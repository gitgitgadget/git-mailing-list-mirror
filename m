Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44E3B960F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484069; cv=none; b=LnI+tjvrxHY8fP36aPdMSHJLbrWPMMXwGcsqu2AUI122x7L1mW6HLVsbCNLVeotfh5epgXQXEdKsysa6kv7bKlir14JpAzYOxbey8GoNPab4/hHwfoAa+nffOjWJdFgD5MXMRe9SsDwH1KRUW9WgUgu+L1lEXHrkH2wG/z/jTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484069; c=relaxed/simple;
	bh=TVi2MaE9IXtgfxdFtTQ6Whx6bs4gr55Udf0JQMGKB6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1W8NbR+hYaRnxl5CmNJbUsLNOn1UJ4JXaWm2ID4uaXtEg3tPIZAR/8hEZfEcG0t/CKvZmZKFTmWzo/NOvkWjfNp8jzhLwHm4eHUGxy61aipleH8qBhryzH9AcGhnmcgJ6wgrEI2lp/Y5fkkNo+HB5JGz/IX/3eZTWE+ZEVuZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiGMkyF6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiGMkyF6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4896ae35be9so115402b6e.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484067; x=1784088867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cunu1W4s4QR5bqRFHQel9TIAgqBeaiEu1kWxDmqzvPU=;
        b=QiGMkyF6xGxVakP2l1MTPWpRFtxioQGXO/8Ddoa/syg8ucB+nilvA2Ixw8NKizOIhK
         cZB8w/qsYIO+1JLWoLhXE/fa97Kc29W47GX/yDe8o13UYJs+Z33OmI3TkdQ64CqZ2Ba4
         Kl+CgeoLKK5oyzAmjGAx7ZO6Y3Hj8eFO4SRj1xMiVt7DOsHoFFxFkGCjZgAbeVB26aEu
         JdmqoxnGS6283QegEGW04Ix6ejx0KkPBPaGH+h6yf/Q5eiVIlTk8KVR9ZpijjHHd8qy/
         AffHJwhQ5yoh5PjNmAfvwAtFnZqbUYD/iEbEN/lFolqMNQyhf13oTLWacgiypgqFwy6m
         5raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484067; x=1784088867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cunu1W4s4QR5bqRFHQel9TIAgqBeaiEu1kWxDmqzvPU=;
        b=TOGI2e0qO9HqS++Q/q5YKZ7auawjY8ScoEEdLq3iydXd8OZMhGXH7XsWYutfRSAKIT
         uyrz/O4BsRpNhd2oTFLhU00jnhdEDF3HQ1QXy5UZyf8S/yyTH66qxPjh06XFPLnjoWna
         4RdiGYh+/RkBRuM2J8Q9zJQSfMpy20tuzLhwytl4clsSVYDuKfyAGuGIfN4YiRKbLYIi
         ochql2V2K8DjrKhRxQqBqPpaOwCxRtS3Gc4LYAXG847WkuvNZdAlac5E/gsVeQ6AQU8n
         KoaepY3kbO8UygHfqG4Rb4ezINecX/dPdqIerjoD2YIE9LTF+11kQXbRCxN9nDQOOF62
         HzGQ==
X-Gm-Message-State: AOJu0Yw42SldBEx0kFLWW4PqKy1zyBu35PIBt1pV01WjrQWi1eHteuv3
	k7bc3eGpfxb7/USm8YKpPy8LzISckl4Ngh2ys3R3iAvCzfQI+iadmwKZuSXPlA==
X-Gm-Gg: AfdE7cnHCzgcYIopdwhrOA3oONmwPiy6rFsYw/DoEbFcQC8CWf0suSTQqFNGTh3twKM
	jsajsKackur4OQClU/MHF64mH7cGoRPTpsZX0DYhktbjxGt2eEcNH4tQQ6eEh9ErldTA3WcFpdZ
	wgyqta6Q+QdWkCNtjiGvRHN4jHjD+ckIBhKBmuZ6kIPkBs2V/mGM2owAZAM6auFWSyZ6N/veQUa
	j5c5LccqOy416We4zsVx1MS+uOhg3RoSNPNrlUUl9feoQpzC8CAjcZirVe8eYy5UpjuNydABMKM
	6cEBU5oW36RjQKB8vZLnN+FLpUw1Wh7X5nHhT7e7gggj9rStWnaDp/NowOUw0wnCR/kIM2MwFp9
	44ASrpy1SqcnIdzxuR+vzzIxmjqctYjwzaQhVTvu1uvPf02anKg1JKKb3khVF+I/2evXbdIH3OJ
	TPBiL1jeB+2Y/mylvmDAUM
X-Received: by 2002:a05:6808:13ca:b0:48f:ba75:4d86 with SMTP id 5614622812f47-4a2049ec9c4mr562639b6e.32.1783484066680;
        Tue, 07 Jul 2026 21:14:26 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/11] odb/transaction: propagate commit errors
Date: Tue,  7 Jul 2026 23:14:08 -0500
Message-ID: <20260708041412.1157499-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
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
 odb/transaction.h |  7 ++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index df4275151b..51af2c9a61 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -16,19 +16,26 @@ int odb_transaction_begin(struct object_database *odb,
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
index 36032a5365..9557ee0fd2 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -55,10 +55,11 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
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

