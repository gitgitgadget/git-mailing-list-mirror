Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B13AB285
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555176; cv=none; b=e+fadc9j9JvR2KS8gS2k2h78Txt2Fi1QP3wPXgf7Q2r1OjKaOCBmrUKMMe1ZtdhSBYljebHJ7ZIGoN/I6nvKYCDYvVjxgnBSsDmD6R2oHub/FP2ofpOqtDdSA69yBU6Gl756z5o3rHnht9vMrhQPfSj4TCLJDWRF0gmbWegaDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555176; c=relaxed/simple;
	bh=+H8BcW184X3OfPRE6Ih14ZcmNwhNadpYPordDEEFvho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKbCHb5sbDHpa8u/oCgJQPeOHS/wXfvM+QuvMUiOy2MqKcTFhnKWY8hDq3h7xOEEb7VkGQfeVLguUZycpteHLwGlAadXx+YZrb+vzjrJH40lWJIdtGpqr317qVcePK30D8wy0ok8my44gkP2naRZo1FCoFygwxyFtisOFp+0j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW9EcKcV; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW9EcKcV"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a3776acb16so348604eaf.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555173; x=1784159973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqguGBGo7mmgCqK2YZOtK1mG9UaipWfwtJC62j1vw00=;
        b=lW9EcKcVW/e611CpHxpF8QqEA+VwDdXpR3WPUTPf+XyL1wQiIt5vlbFy6rKMemOUdz
         BjRXPaKHdlNQbMuUjeNafFSEhqSED+UzrQRS0vSJyIR6GNTZ1C260mdtPBWSaAtNx6Y+
         E6iGJuvdyAaqN1l/wepvBmY1TCF8Wwht1hGRKaFKBz0hK4YXoqg8joRGRAP2UiGQ/CQY
         QWTnnkztxVL45lopIw3J0YptjkIHhr9bmq5EQ+P+u0IdzoL4cZrEeQNAoYE6wqtS90w3
         mvlDrQaOplKN70ogfPEZnO1SDHqXL+L8A/FP3PiWUAt+j5iZfgHZEc2XfzzZoTe/NR56
         xS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555173; x=1784159973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqguGBGo7mmgCqK2YZOtK1mG9UaipWfwtJC62j1vw00=;
        b=B84YhCFPwrPE6t1qJYI6YrzHuwJLLVR5Yqv50M297yiUFqRJVSxChtVAOtCzu8kvcL
         HpPsaz3KCv0LceJNdvi+U9O9nabfSry9kuLc1e01M0KAuNT2r9V2ZN59QT54AM00X67A
         7p26wNkPha99bDFbH6ZpqrSY/MkFIwrPT0yOOE3cHcGOaGjkJqRXJhalkO+b85OSx181
         eua7oFfWmFIg1JzTVhAUefrZHMOE+Z3pVPiVCYYbEKIefJZLln2oplwz1rAYakjiLyf2
         ugnh5htpj9GQKJADL7SQzTQ2WWBA/lTxeVhrOKMM3pgl8+Zj7rw0O1ICgQoc11vUUBAE
         1kNA==
X-Gm-Message-State: AOJu0Ywx8Mdc5mlnszGesKLXPl/iIn3To2eRlSAuFE5XwSb7xvNJ1hl/
	PYCygRWhHEskN8gFdo591uszBrWi7gvb4/m1pY7CsaL2IfkGhzB9jx5z3HyBCw==
X-Gm-Gg: AfdE7cnjIHIpGZ3RJeSugYwC4HjZrTNP/DXv4rV7uAUreySixOTqwbiG1Pp2ZWcn6GK
	9ZoQV1Y19rr1K/tGoDwJ7mtoHa+cvVZoBViwbm03PTQTGFcHaMQyGl5oTWjgJlZ5weTSZVPECdR
	CUqh8sKXCMa8dlss1lEOiHymLsl6ZwqnLRP8hla8jAA8FrQHUCbo71HMVSEYV3A8ceefif42VTt
	FgULjlIskIaLsSITqK++UJOWEnC/BsbkF2rfcbsqwTUpmKLOzWpZ6qwp8zgmlp+oc+2lzD13dyT
	piLCe3reCtESjf+1hYNOgamRXRGd9/eOl0LEy1cbvXl8AyEjxrheHlTR9is4VfO71T1eUW6ZViI
	TaII1SSFKUZ3aqULRpOAqhYkv/Vs0Sm2vXdMTF2TPvvx41F1kawvPeJE5BdmJ9t/i7I+TH7tuBo
	pS+f2SC7VqNMUhgkj8llx8
X-Received: by 2002:a05:6820:8c2:b0:6a1:805b:5288 with SMTP id 006d021491bc7-6a36d9a0ce5mr3635696eaf.33.1783555173214;
        Wed, 08 Jul 2026 16:59:33 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 03/11] object-file: embed transaction flush logic in commit function
Date: Wed,  8 Jul 2026 18:59:17 -0500
Message-ID: <20260708235925.3992097-4-jltobler@gmail.com>
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

When a "files" transaction is committed,
`flush_loose_object_transaction()` is invoked to handle performing a
hardware flush along with migrating the temporary object directory into
the primary and configuring the repository ODB source accordingly. The
function name here is a bit misleading because the helper is doing a bit
more than just "flushing" the transaction contents. Also, in a
subsequent commit, the transaction temporary directory is used to stage
packfiles and not just loose objects anymore.

Lift the helper function logic directly into
`odb_transaction_files_commit()` to more accurately signal to readers
the operation being performed.

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

