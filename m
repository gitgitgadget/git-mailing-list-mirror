Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0722BE056
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928343; cv=none; b=Of5WEgnrk6oT9AfOcaB9FpRYXxPhv5QqWm0GXOhtt17eB06caxZNj73epT+0coO3uBf+RTQoQNw2f25MSICaXDmJ7G9M7TENyhfzuXIK0t9UPltRHyUXBIJcgAuokLshzJegGAa0P24iEEI7QOKq3eJ6nf8pxCuequOhktA4hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928343; c=relaxed/simple;
	bh=NKGzjbT3G2Qs1LobYt8i+F1zwzUwn6KVReYzMTAQ1Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNBDAjwJHxJ4RGMJB58PAEYuuBO2v4LKd/fqOMxmjqdry5zJTZMkFy4zaqf5kmrSeeBsXDabI+Vd2BC0oINV51C0R8qvlXf9Kw6VXgfjpU45aCoIwwz1LL0l6sNVO90pRVqmipW7k9l1qSl/uTh+jj64N//ZfyoLthVmaTEnKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO1yNn5J; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1yNn5J"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d91f82d819so5162122a34.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928341; x=1775533141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=HO1yNn5JKtbTCrQWhBnbtwYlK/hQGZLwgS1IghCnaqKRmMBHi6tirdhJT5ipzlkLAO
         viWBhyZn+lf5EeQHBo0NLAzn7wJn/j7eutVynQ7BWjc6bFjMaCbNxQ3FpbviTliIsIuc
         8LLRQMdGck1XGvjmVNoQO/O5TdODOneYmErQN3zVaRPZEyIQBZo0+ntZLoZzqZQbInWq
         5MOgzw0TaB1f6GFckuHyafu3BlIJ0CFC53ieyP//tmdIehVrr5Ig8PqY46bhrf52PEEn
         0TMXCV7QCVKppev4zCh2+IA5v8lWDVEnwVKrCt2usKZ43dd2rFWpXG1TfqhVwac+1aIO
         v1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928341; x=1775533141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrXACizDL/uExS0X7F+8s3qUkPpuTzVyYDcM38xl0Uk=;
        b=XtHaO/fjlXcrlBAAh86/x1gwwOsWlUopEHQd0zYKSRr55OJ+pROBkNxv/WWDZGQOW5
         /mXACuDHv6k75doScU/W9pRl2UXPum9sHdGtoUzaqUBxF5FLDxqB/ETH4QYTr0zBxBuI
         a89zs9OIX6a3NsC1hkRjci9qUa39vXAjlmeI2yVeYsPaW9GS74W76goMS1I4S/Cewgrc
         xd2ZuyY7JtC+l0GU7wLMUbGfGox5aTETB7A4VeDbUeZ+a0NxVp29sRbjjlRslOZjpy3v
         7BXVpzJrBmKti5KAd/ou/4Y7wH06TM+teKdNI4Zcfr20f0PuawpUvyPt+MugVj+kVnfU
         SBMQ==
X-Gm-Message-State: AOJu0YzWALOVU8cPkObdEvbGwH/Vel+77XtkQilcV96FSZFqkLfPwLj9
	AsQ8nE1FKJgZdLOF+65mDs5HZf7X0IQKm034xJzqmwgi5/CvLqEisdo5ofeDSQ==
X-Gm-Gg: ATEYQzw7OtmfTAiKmeOzrLspX9iWeHtqpo/w9NIBhhl80TnPmHiJ4PzzRir/XRaEFsy
	FvamedKofzvaxmvzUtbdXkeJXXNdhglgUbbjeI9cyISRqzpevANGK0GLtULcw9ajbf6ofcHf72u
	+h4QnOudTOxj4dnPiB0VRA+JWa49GetMG5yB3/QCU3/qOKA1ycq23clDiX7cmE3pMJvq7E4rCN5
	JE7amg1ZCTqltHrGD+w42ngxMm3Ucxwq65RtpcTzO6vHzJjq/80mVhbfH6xTjQvhV1LZahPm+IP
	d10DVcYeeSh3EoGxad7+55SJtrGZ26rcxB+apKPlcU9X0iDdDB03ehVDcYHFRgZWCKZMJzs76bL
	BOW+AuC3YLD2XRnsomfP6aUL270VLl+7aGohyUgZpTcmFoSGLMZqXXxj0ykxdC1A4gBTo8xFlHH
	lzqI98a4rpdErWtfCzTMcr6lMbjojmMoI=
X-Received: by 2002:a05:6830:3508:b0:7d7:bf59:16df with SMTP id 46e09a7af769-7d9faed1bfdmr9365048a34.17.1774928340837;
        Mon, 30 Mar 2026 20:39:00 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:39:00 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/6] odb/transaction: use pluggable `begin_transaction()`
Date: Mon, 30 Mar 2026 22:38:31 -0500
Message-ID: <20260331033835.2863514-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260331033835.2863514-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each ODB source is expected to provide an ODB transaction implementation
that should be used when starting a transaction. With d6fc6fe6f8
(odb/source: make `begin_transaction()` function pluggable, 2026-03-05),
the `struct odb_source` now provides a pluggable callback for beginning
transactions. Use the callback provided by the ODB source accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 odb/transaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/transaction.c b/odb/transaction.c
index 9bf3f347dc..592ac84075 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-file.h"
+#include "odb/source.h"
 #include "odb/transaction.h"
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
@@ -7,7 +7,7 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 	if (odb->transaction)
 		return NULL;
 
-	odb->transaction = odb_transaction_files_begin(odb->sources);
+	odb_source_begin_transaction(odb->sources, &odb->transaction);
 
 	return odb->transaction;
 }
-- 
2.53.0.381.g628a66ccf6

