Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4519395AF2
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484064; cv=none; b=KQs550huG6bVa6skmgXSVInUXQhibt5WPCulPLF3q/ZQu5lqKje0bpvGf1FqAalaB5BbGpDI+hCvXtSCGlzXmxyqCY+4TDQZLHt/WlgZqpePenwakuus75D7vv0OXLU6Mc+cO83+91Wn2FSFbcx74yQCQPQ4sp4XNmR9SlvARc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484064; c=relaxed/simple;
	bh=f7xcIqZUEATk7Ut9w5MiY1K8oFtz51JtZ3Pm954HNow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCpB3Elf39eaBbfgU4N0AoFi+J2NALbaoqns9jPNKGJF89pwq5uTeQd3hVmAeyWTPAmtoKLb1YeNuvTqXo5PWFEmex+C+4qRzzRxS63mSOiOSz7VdPtvKHv7SkYkUyT69whzNeCY1wlZm9Y3zdpl24fuZMYYqS/IrwVJbho0z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCGfXArN; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCGfXArN"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-495ee8e807aso107342b6e.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484062; x=1784088862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJEYoNroMv9Z7xdX+q7Oy8VcMLH9O8ETpv9mDcX+mOk=;
        b=lCGfXArN9XOeTPhI1y7J+wG1J4uCtqtIbjVcJYx5BOdwdCgDjn0JxcTwqDsl1AZKCp
         zUMfgAO+jue7sMyo4y62CitfsFRl1KFP1NJMvNmnhLJmZsPuMHqYNqd5PYuDINBfFhE6
         adnyv/Nro71NncV+0z8SDTynqNUsyyh3Fau+RseFkNZ6qPmLMqStPjFROJngoxmGcNwQ
         7KR2h/uppgix9IdzIoHpYuPOoq8Q+FO69OkCsEGjkqXbB8Y7QlSU5oja0lgK1VWUt/YS
         qItSaDmlHJ6ekIbfkZpMlhxhcCNq3LV6uMbdmvN5Slgh6tgQXQMbgbg2/NFY1ZsdYZmh
         vPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484062; x=1784088862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJEYoNroMv9Z7xdX+q7Oy8VcMLH9O8ETpv9mDcX+mOk=;
        b=L8FhwhDi4e03JNku1kq4RYO3L132veugtuTpIZV92oczUFsAIMA5j/+Drpq0+4MYRW
         hySlvEj+cBeqTWsWohksqwYlzWv2BB+0R+ywyU9HZPzUNOOBGKLzTuUylCOlFQimRQdy
         8hAZhEUiQXuNsLJ4heIF/hhu3hsmf7pxFYUqUDwWs0ESXuACZCXZR7ZT/CX3Weggeba7
         WVBz5q0WVweNi9Xg6oKr7jCnk+RksFhg7JUBQJxKEFrN6cq1/X4o9sHUEVcwIo7j56Vb
         JU3FpPJWAefLfqZWoxCkKGnsGHsnGgmvPEBUrflwPC6PUyJE91gg3eZhQHpdStStNrRj
         V+iA==
X-Gm-Message-State: AOJu0YxRS+5xb9mMnFLv5tejCNYvyyODfX19XPmwPwpF10m4Napkx3eY
	LMqe+/XPP1kv6Le/5FsxGiNP1WhWrtemUNBVZa/zydJe0UiiXZBYYIMUvMPa7A==
X-Gm-Gg: AfdE7ckksD3TfCQfG4qmu7GD3kUIAxYsGI4ht3mcyVc/ZOxkUGWP1nbPLqUWtJ/Ym64
	0f1O1tQAyjtuhWshDNzhodmcP1OgstXKYb6wTgyAsX7IHxZehPSD1M+AVQgnkb5Pb4dpg1HFstk
	HaLQVQTrosgWSRCBhQDBlez6mHp6WwR4ZPUmG1GlRL0ltyaG6pHjWQfxfpVVqclVNn4AL1PAlnk
	az8hyhujSWHRB0UfC+NWiy1VL3RNkLUPKPBgz2JDxQAUeiqx7B+bAz/pzCrWx4hDkQjOT5/8wsS
	UfMo1WnpmSVkWaIsN4QLIVmSTao5eGprjECepkArtSbY25Rng9HuHVqSQKcd1A07Zhwa+8blJ05
	kWnQm2It26pXaX27zVhBEu02v6P6Z6vMUIdN151angk++XLnnzy+vugt/Yz1hUR1D77lQYqImxr
	7tsEu+BNmbPR29rOw6+/lnN1u50nuUask=
X-Received: by 2002:a05:6808:6783:b0:495:dfbc:c1c6 with SMTP id 5614622812f47-4a20590c794mr650615b6e.40.1783484061778;
        Tue, 07 Jul 2026 21:14:21 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/11] object-file: embed transaction flush logic in commit function
Date: Tue,  7 Jul 2026 23:14:04 -0500
Message-ID: <20260708041412.1157499-4-jltobler@gmail.com>
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

When a "files" transaction is committed,
`flush_loose_object_transaction()` is invoked to handle performing a
hardware flush along with migrating the temporary object directory into
the primary. In a subsequent commit, the temporary directory is also
used to write packfiles.

Instead of maintaining a separate helper function, embed the logic to
flush and migrate the temporary directory directly into
`odb_transaction_files_commit()`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 64 ++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/object-file.c b/object-file.c
index d68824bb44..33bd6c6810 100644
--- a/object-file.c
+++ b/object-file.c
@@ -543,41 +543,6 @@ static void odb_transaction_files_fsync(struct odb_transaction *base,
 	}
 }
 
-/*
- * Cleanup after batch-mode fsync_object_files.
- */
-static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
-{
-	struct strbuf temp_path = STRBUF_INIT;
-	struct tempfile *temp;
-
-	if (!transaction->objdir)
-		return;
-
-	/*
-	 * Issue a full hardware flush against a temporary file to ensure
-	 * that all objects are durable before any renames occur. The code in
-	 * odb_transaction_files_fsync has already issued a writeout
-	 * request, but it has not flushed any writeback cache in the storage
-	 * hardware or any filesystem logs. This fsync call acts as a barrier
-	 * to ensure that the data in each new object file is durable before
-	 * the final name is visible.
-	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->base.source->odb->repo));
-	temp = xmks_tempfile(temp_path.buf);
-	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
-	delete_tempfile(&temp);
-	strbuf_release(&temp_path);
-
-	/*
-	 * Make the object files visible in the primary ODB after their data is
-	 * fully durable.
-	 */
-	tmp_objdir_migrate(transaction->objdir);
-	transaction->objdir = NULL;
-}
-
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(struct odb_source_loose *loose,
 			       int fd, const char *filename)
@@ -1679,7 +1644,34 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
 
-	flush_loose_object_transaction(transaction);
+	if (transaction->objdir) {
+		struct strbuf temp_path = STRBUF_INIT;
+		struct tempfile *temp;
+
+		/*
+		 * Issue a full hardware flush against a temporary file to ensure
+		 * that all objects are durable before any renames occur. The code in
+		 * odb_transaction_files_fsync has already issued a writeout
+		 * request, but it has not flushed any writeback cache in the storage
+		 * hardware or any filesystem logs. This fsync call acts as a barrier
+		 * to ensure that the data in each new object file is durable before
+		 * the final name is visible.
+		 */
+		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+			    repo_get_object_directory(transaction->base.source->odb->repo));
+		temp = xmks_tempfile(temp_path.buf);
+		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+		delete_tempfile(&temp);
+		strbuf_release(&temp_path);
+
+		/*
+		 * Make the object files visible in the primary ODB after their data is
+		 * fully durable.
+		 */
+		tmp_objdir_migrate(transaction->objdir);
+		transaction->objdir = NULL;
+	}
+
 	flush_packfile_transaction(transaction);
 }
 
-- 
2.55.0.122.gf85a7e6620

