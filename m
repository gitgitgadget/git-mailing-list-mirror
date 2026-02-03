Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFA7E792
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077418; cv=none; b=FJ/JMT/oz/1vzR8ZlgSqFWR94Mcu9d014EgqIkdE4FNur7CszSZLGXZcEjlF2SerEblDdtD4oGRHZkYdqrDbRqlUW5j8H1pSKgeeLf5+5WpjCTLM3f7T1aVGQYaqX05tdECT2aL8OqiDqsbEoUl1H/AfzsB7TfsM4pEzqhfMj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077418; c=relaxed/simple;
	bh=xBsJx2oOgqlHuKFJvBttmGp/x5i3bvcArM8VwJtvKSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4I/m9vVKOlubgVxQ14aL/TpatpdLEa66yOEXxWidGR6vWBLTqtMfaxwn/HrSLe8TQ6rBAu2rC4FyE+8K7e1VuFuj4DXzJCmIZGupHIqVveV6hltqf9iOqCJs29CEKyH7PuBPjzg9Peq8VamYS5k5X5JAxqrtoj/DsXjNdzqtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR39xnIg; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR39xnIg"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c93313721so3326872b6e.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077415; x=1770682215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvU7s5KSO/02wmThFqe8LzHqDXt9CikHenAHPQxa2Qw=;
        b=kR39xnIgilNduPsM7ZrdC3I68au/6Q18CHs40Y7EfRwB76O4h4sr45LLxcRYnxyFft
         f4SASN+xPfxi7yZnZTFf7l/Vppa3AyhEZCI32hMh6CRy0C4A8F5wKajUnyHOGmfrCB85
         enUggblOEPJI/ZS3K6HKYHBQ35TARMIkDM0sPSb7Zb2zV2A3uCLxQ6RT/3QAGkSnGFOl
         y8VPq9ua+ruisZBtIrqOjwH0LHAwdpUYuyZlEcwA0GbVzSxUbmuPBAvRdn63zM/uelVQ
         3W4T6K9yz+zaavOfPQeuLpbXsLhG0wayiOPsHSTN7mL068TNZPvWYp3MWFmM58yRvWvS
         JWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077415; x=1770682215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvU7s5KSO/02wmThFqe8LzHqDXt9CikHenAHPQxa2Qw=;
        b=MJhdn4VNwIbodIx+jmch3ByEGfIIPYVGHLyMjl0lqjhYUSdxyt24EPsVbipWlFuxIH
         qv7Cr68bqoNAnxvh4wp8Rgf896lrVaXuas3umPrsQpQQooUX7Nx8X7HtYs87VatBKX/G
         //iLDjq0U+H6GaljlKKLRu3nrdE9k1zWuSXe80qOdPLEdnciZNkt08AIlEU1g4unDHcP
         9C4FPjUQ/wT8LzlDYTBC43EblDZXTcovU7I6n6WaptCJsXdcpu6fCuvvBUzoHqUWWPwY
         uMjBH7LXuwnyijizKF62iP13oAjb2q42NRlEj4DuWcJLsV/TPB9NC/k714ynTG17Wb2b
         M+LQ==
X-Gm-Message-State: AOJu0YxTNJsf3zmpnTSrUO03l3o5cLsu7L4kUVfToHxOslQkneq+8Yp5
	yWsBKccEOdZBBQHMnBTYdKKKp/LmKqUUc6LxzYKYrvlkLXlFYxtMCODKNaQRGg==
X-Gm-Gg: AZuq6aL3zgJQGEqjaPP9jMt8FYKX4BJTef0084ZegGwRpt+bIpoxRHNcOfoVy+IZums
	9xId8h43NfmDDou88cdFvIgZyrGRHEN2wnrWpIz8pQ5fFQR1E4SRME1dVDFasg7slJXeR5KN/j+
	xuq6jU6ncN29WbWZbO3JG3oBjQ4XUshCvdyFcChDobcTLTVv2dtu3U1Td2fBWACydHn0+kZ+kx+
	Xl2kBIXo6LQd51YzCLOfwoEQNaDN2IUfaIc7xVbuKyfpF2zOPIzKbuUUexYOe5WE4SrlI+igyfL
	k2Con4A5eLftJQJ3k5Tx9PvlUHLeuqxpMjIceGw/EEGHMjHm5PDNShpn1imCNqSAtQSDS38CwxA
	miZ0/4TM9nEXxfEGDSNSYT4V+TYH9GAp+eTQBEL7WKFINBRqikLZTDXedO9+pm1tWoDU9vs3k6s
	HtqsFu3844lkIV3VX+dNE=
X-Received: by 2002:a05:6808:190e:b0:45f:21c:42a8 with SMTP id 5614622812f47-45f34b4e1damr8026381b6e.7.1770077415349;
        Mon, 02 Feb 2026 16:10:15 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f6010esm9851179b6e.15.2026.02.02.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:10:14 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/4] odb: transparently handle common transaction behavior
Date: Mon,  2 Feb 2026 18:10:02 -0600
Message-ID: <20260203001002.2500198-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260203001002.2500198-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new ODB transaction is created and returned via
`odb_transaction_begin()` and stored in the ODB. Only a single
transaction may be pending at a time. If the ODB already has a
transaction, the function is expected to return NULL. Similarly, when
committing a transaction via `odb_transaction_commit()` the transaction
being committed must match the pending transaction and upon commit reset
the ODB transaction to NULL.

These behaviors apply regardless of the ODB transaction implementation.
Move the corresponding logic into `odb_transaction_{begin,commit}()`
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c |  9 ---------
 odb.c         | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index d7e153c1b9..1b62996ef0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1994,15 +1994,8 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
 
-	/*
-	 * Ensure the transaction ending matches the pending transaction.
-	 */
-	ASSERT(base == base->source->odb->transaction);
-
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
-	base->source->odb->transaction = NULL;
-	free(transaction);
 }
 
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
@@ -2017,8 +2010,6 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 
-	odb->transaction = &transaction->base;
-
 	return &transaction->base;
 }
 
diff --git a/odb.c b/odb.c
index 349b4218a5..1679cc0465 100644
--- a/odb.c
+++ b/odb.c
@@ -1153,7 +1153,12 @@ void odb_reprepare(struct object_database *o)
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 {
-	return odb_transaction_files_begin(odb->sources);
+	if (odb->transaction)
+		return NULL;
+
+	odb->transaction = odb_transaction_files_begin(odb->sources);
+
+	return odb->transaction;
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
@@ -1161,5 +1166,12 @@ void odb_transaction_commit(struct odb_transaction *transaction)
 	if (!transaction)
 		return;
 
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->source->odb->transaction);
+
 	transaction->commit(transaction);
+	transaction->source->odb->transaction = NULL;
+	free(transaction);
 }
-- 
2.52.0.373.g68cb7f9e92

