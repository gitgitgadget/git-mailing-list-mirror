Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91269F513
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077416; cv=none; b=jSwisxA9fGOZA9sBJJOZw96HUV/jfZxIQd2hdGTE024IocY0U6CSJOTxEE4WA8QcD5x9i+V/95Dur71jz63yBgtSI/Pp90v9kVVcN3aIWygzIvvnhvmZz1XlBnRz/jAiY1gsevvZULEazh20Qxb9aHu51CBPqP3Cx4/y5qM3QxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077416; c=relaxed/simple;
	bh=vagWM3QPyU7DL4NLj134Jgf+0YHCDRG3ZK93wozNGsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtQDSVFaYCx4ZLvi2Q+rew9Ib7L/6FA9cLAOwCPBjIcMcy5mK8Dut+zNGQedq6eme3ccRCDwMig/AnXpPLHABauMOWHGYtXIURwQx56bDt61qN6CZAUXzUFvrIxy8EMfPN0CngMVloiXHvMXbxYLSaAX2D23I2WBiAC7S2WYrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRCzs4gF; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRCzs4gF"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c715116dbso3566473b6e.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077413; x=1770682213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsAp/gppxoNCOXUNAqfnIiQk93ag9gMzYouevkuyOQU=;
        b=KRCzs4gFJRMWZ9qLCeT+JdyJZxnr2tKKsmzhcPNA/JuYPSqQq++VZO/1AaOkYaAghe
         a6mlyQMLo0FV1Da1gufERLJWyqIiG+rrYHvWwAMuWMXWcnSf4+nC3OquS028MtiuUE2Z
         27KbxkGx0IaTzLjvkPjHTsv7Fp/LsfHuPrFb1coJL5Ra4Noby2U/X9ewxgLaDm5fc/z7
         p75Fvs0vdSGzhJ3WA5IdSQVWxCq/SugzJobQvYbbt/liNWRGlsT7msG7MRMeLapeDVk8
         5wn1YJGQWuOWt0THbmifUBYhG0GP4qk5L576EeS4r3DGcnAHr0zoXJBjNVz5XwWkYAzZ
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077413; x=1770682213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsAp/gppxoNCOXUNAqfnIiQk93ag9gMzYouevkuyOQU=;
        b=QuvjiZgmxWqcnXFKa/4xDjrb58LfgUWZK9z/QwTMOXHT4gp53hgEfLU5BzKKhyIjvW
         hnuor9WG8YWKulX9Bf2AnuO/HYW2idRsYRedre1z887XYqHZAv1mrjkUXtBNv2/SQe6L
         VZO0Oeja3Paiv16/kaAaAPP++c3AykbotPkq2W4YOxvf0abNmk216HWfqWYYNa5/F2KX
         cpFg8Vwofr3ZC5Vh+mtRn+jNtLT4P7eS/AR3up3G4L3LSHAUx0KpV2zzPhxD74p3idms
         2r+LpvPRrPI9/kArEYdpMfyCnbbYMuUGcvg6rq5rrCsq5f4J4pIPU1KxYzpidnDsrcW7
         0DWA==
X-Gm-Message-State: AOJu0YzSVlKxN+xqq4OtWFQx5oaBxQiNDEppajJgymjiSPpyOKwbCgCF
	2NI7BiVLWvezw6OkOqmtryCdlB9Z8bGqsP3AG1K2IWD0Ol3Gkp8YKSsYW6pysA==
X-Gm-Gg: AZuq6aKexRnlwCwRF4HAMblIthiQgZP9T2bQIq06FVLyh9x3KAitu/vUfbwr6JGlEDy
	cJHlJ/u8ip56eCCsPc0qG5vAbkhR7pipOP/sKGAk/C+iEPiGe26gB1gJSbedDeO6nX7Fzk1olog
	o8DqEdUeEP7A3szHJ/vwJgqEQdqFqgPyYeiFUFrqx8NYPqW1owKFK7npX7dQD6aJAx6HnmpkY8C
	PxxcPIhJA3ycj1913a48gOSWlwUXzR1nZvA87bOcquHztdE6rPGTjW0GfHbc+82y4wkPS7jiqPn
	Rul1kDGOA/Pz4/re/8GZSIMi1ayvsBN3XndUjxjZAo+bJYa4YPGinLyXWyQJKSMwbM3YT2OeAxO
	6n9xCrqn7XaWpH2YhBZFmZmX6sBJ33KE+s0ZK8SjjziJi+tD/2ajVKQmtQkJphKUlfhHIJX2ckt
	dz0tIHT0h1OWbgDIbx9f4=
X-Received: by 2002:a05:6808:6f90:b0:451:4da2:47d1 with SMTP id 5614622812f47-45f34cfc03cmr6712414b6e.45.1770077413042;
        Mon, 02 Feb 2026 16:10:13 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f6010esm9851179b6e.15.2026.02.02.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:10:12 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/4] object-file: rename transaction functions
Date: Mon,  2 Feb 2026 18:10:00 -0600
Message-ID: <20260203001002.2500198-3-jltobler@gmail.com>
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

In a subsequent commit, ODB transactions are made more generic to
facilitate each ODB source providing its own transaction handling.
Rename `object_file_transaction_{begin,commit}()` to
`odb_transaction_files_{begin,commit}()` to better match the future
source specific transaction implementation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 object-file.h | 6 +++---
 odb.c         | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index 196509b252..7b34a2b274 100644
--- a/object-file.c
+++ b/object-file.c
@@ -723,7 +723,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	 * We lazily create the temporary object directory
 	 * the first time an object might be added, since
 	 * callers may not know whether any objects will be
-	 * added at the time they call object_file_transaction_begin.
+	 * added at the time they call odb_transaction_files_begin.
 	 */
 	if (!transaction || transaction->objdir)
 		return;
@@ -1985,7 +1985,7 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
+struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 {
 	struct object_database *odb = source->odb;
 
@@ -1998,7 +1998,7 @@ struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
 	return odb->transaction;
 }
 
-void object_file_transaction_commit(struct odb_transaction *transaction)
+void odb_transaction_files_commit(struct odb_transaction *transaction)
 {
 	if (!transaction)
 		return;
diff --git a/object-file.h b/object-file.h
index 1229d5f675..b4a3341a89 100644
--- a/object-file.h
+++ b/object-file.h
@@ -202,16 +202,16 @@ struct odb_transaction;
 
 /*
  * Tell the object database to optimize for adding
- * multiple objects. object_file_transaction_commit must be called
+ * multiple objects. odb_transaction_files_commit must be called
  * to make new objects visible. If a transaction is already
  * pending, NULL is returned.
  */
-struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
+struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
 
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
  */
-void object_file_transaction_commit(struct odb_transaction *transaction);
+void odb_transaction_files_commit(struct odb_transaction *transaction);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index ac70b6a099..a5e6fd01a9 100644
--- a/odb.c
+++ b/odb.c
@@ -1153,10 +1153,10 @@ void odb_reprepare(struct object_database *o)
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 {
-	return object_file_transaction_begin(odb->sources);
+	return odb_transaction_files_begin(odb->sources);
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
 {
-	object_file_transaction_commit(transaction);
+	odb_transaction_files_commit(transaction);
 }
-- 
2.52.0.373.g68cb7f9e92

