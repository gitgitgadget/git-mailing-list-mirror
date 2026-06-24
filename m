Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CA380FFD
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274774; cv=none; b=VJeQtYLCrVJd/2sbUTKfLp5IrQ1kWal5q4tQfwcDNNypGyzy03lb7+eBo4f7CIOCrdP03WwqZLa2CLOrlt+E2efExMWrE09bIW0H0ohJSmGR4PFfBpoATredffRsZxwBpbbDmSOsSQdxlBZ/WGtrsab1WYqzOROcmvYimiAXwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274774; c=relaxed/simple;
	bh=gGZEyh9nxg6y20XHelhnFnSJHFoaFbaOWpE0xtgLDxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQqMVOFCvbiW8YcepOWd3/YVI0MWLY46fpwFVYYeCV7VX/KNHuEaPFo4jwBzhNCgtQYQoUk6vmT9j5G130P/iSdzu+Nr3xDIkef16Ik7NnIqsJiPdIslsKFipJKxfOOhfWiMseHK8PJZmVL/lX32Y3bJ0gqM8EwbfNUXsjfwkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gllm2QFM; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gllm2QFM"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-487167d083bso437561b6e.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274772; x=1782879572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6AM1pfNOYM/9ae4jlSoLkUFbz7MPZlQXzTI5b1UIdQ=;
        b=Gllm2QFMr6OpX8OMS/KhK3D9IbLN3Zn2ehCGx3XCsTbz7MAYzEnku7TbvP6llBfa3n
         g8RF744JAN3sACchhiPr8EeSUn6OteocZNxPODz7lsATw7pUdaiLA0oZAbANk+Pu/iod
         gOCulxp61nyCywyaYYVAjZzfgb2MFYNkbSQJKDbu6F6YRtYKoO1H6pF+IHQrKSu6o/kS
         PbyPrIjZ6g/lwISoK/aTJNoDGJgFC7ZEX9jSmQL+o9IagvIhyYArtHsU4KoylipJYJW4
         IIwYBaFl1QcH3VhUD8/HLXPASQ4ilP8lKad/kgVc8/ggjatlob7XpBJDWkTchImL0nzJ
         d8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274772; x=1782879572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6AM1pfNOYM/9ae4jlSoLkUFbz7MPZlQXzTI5b1UIdQ=;
        b=RlC9BK6q4iNghU8rYgwW9a/lLsWp5yAdNPHBIPhrmskN24p3tYj8MKwKPwUrUlvTUw
         JUe5Tj9Yj8EIBmfAzjmo1VvSV2bBJgGKEt8GV1ozc53klz9/72QR+LuX1ZS29V9GKaZD
         7cWEK3+E1ttnd34CTZH1mgHLPykvMDa9vDp3g8Ub4pbKQS/pD8XihzLp2NHK5sDEuDxk
         TrY/QQ1FQR4mDNJLkCczrQaCHsWvOmnW2KBM0L5OK2IdJZf3wCiMbXJkIKP752T5/Yaz
         Z8iKvaaaJFLx/SSJ6Qlo8B9FUKKHLajRsTD0SGIgYHErCyTyoH+sPIz1y7sMtAQf1D0R
         6NWg==
X-Gm-Message-State: AOJu0YxdQAIvJu77fY3zB8/APl8TuIbMsfej+vCVG0iM+uhWIfxWvaMW
	6p3cjRto1uz0/eig4e8hlZp7FWxiRqm/eoR8c2jaAIMJrUas75OPMPt2YzBkaw==
X-Gm-Gg: AfdE7cnc83zhs5uBOC3tHDXgOZYI039UZ/LmhB9Bs9y4r8VeHjN3IkAW6mcNheQiGNw
	sz2mgPvFF3olzcrDc7l/9Msf7t4AlY0xOzdoUwjxVSIE4R78GXmwjiHoknXBebAtuC5K4UmZXa8
	2qmyz7CKubI52yj+L4tv1InlJ8KalpCTEvzI+6kM7/ah9qGKmNUvvnc8mLumkxba9SHT1YSHHdW
	x4+2jZTD2sFejfmvTPH4a0lhfOIhGcDrhgvqk1h+uihytc8dggP4xa0S5mHzTOVL2wBiKNIiaWU
	C7dKOMDF0eFxVTjJ+hoeNmyfwAFVQrUXPUWyeBCm25DRmtizKd2qo/QvqykzFIoJOkVTQ9DkCMP
	/sXEDqy41maWuVydNVrJI3i1zf0Nr4sbGeNg75UT/rjnPyk6TeftTefya+Ym2gPus5IyAbExlg/
	zhpXMo+vZ+GynJbv6+Zu2ld15SZxVsxjU=
X-Received: by 2002:a05:6808:250b:b0:489:6b4d:3128 with SMTP id 5614622812f47-49079b982damr1108032b6e.40.1782274772227;
        Tue, 23 Jun 2026 21:19:32 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/6] odb/transaction: add transaction env interface
Date: Tue, 23 Jun 2026 23:19:19 -0500
Message-ID: <20260624041920.2601961-6-jltobler@gmail.com>
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

The ODB transaction backend is responsible for creating/managing its own
staging area for writing objects. Other child processes spawned by Git
may need to access to uncommitted objects or write new objects in the
staging area though.

Introduce `odb_transaction_env()` which is expected to provide the set
of environment variables needed by a child process to access the
transaction staging area.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     | 11 +++++++++++
 odb/transaction.c |  8 ++++++++
 odb/transaction.h | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/object-file.c b/object-file.c
index 696f05dc2d..14064d188a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1691,6 +1691,16 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static const char **odb_transaction_files_env(struct odb_transaction *base)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+
+	odb_transaction_files_prepare(&transaction->base);
+
+	return tmp_objdir_env(transaction->objdir);
+}
+
 int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out)
 {
@@ -1706,6 +1716,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.env = odb_transaction_files_env;
 	*out = &transaction->base;
 
 	return 0;
diff --git a/odb/transaction.c b/odb/transaction.c
index b20d6a16f8..20d3f43f54 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -46,3 +46,11 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 {
 	return transaction->write_object_stream(transaction, stream, len, oid);
 }
+
+const char **odb_transaction_env(struct odb_transaction *transaction)
+{
+	if (!transaction)
+		return NULL;
+
+	return transaction->env(transaction);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
index 7898770071..536458297b 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -32,6 +32,16 @@ struct odb_transaction {
 	int (*write_object_stream)(struct odb_transaction *transaction,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+
+	/*
+	 * This callback is expected to return a NULL-terminated array of
+	 * environment variables that a child process should inherit so
+	 * that its object writes participate in the transaction. The
+	 * returned array is owned by the backend and remains valid until
+	 * the transaction ends. May return NULL when the backend does not
+	 * need to expose any state to child processes.
+	 */
+	const char **(*env)(struct odb_transaction *transaction);
 };
 
 /*
@@ -65,4 +75,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid);
 
+/*
+ * Returns a NULL-terminated array of environment variables that a child
+ * process should inherit so that its object writes participate in the
+ * transaction, suitable for passing via child_process.env. Returns NULL if
+ * the transaction is NULL or the backend does not expose any state to child
+ * processes.
+ */
+const char **odb_transaction_env(struct odb_transaction *transaction);
+
 #endif
-- 
2.54.0.105.g59ff4886a5

