Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363F285067
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818579; cv=none; b=bZDGXDtyc5uptYOYaC62uR1fTRbPAX+u4bzAlZxZo6tbCezjCVVWdWuri5n7XMAwS0Sn4DAE1bxsnaC1s5AGevdLwlVJjCkgznMAui8pNCzFj6MhAqV7vUaCQksUsmWo/xx8uy+kjE8xtoN0BDlc1tTDtc+gMp3Oyn3OLdhI9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818579; c=relaxed/simple;
	bh=scWm5Lt/icvZ4mB4HupXp4Yk/Nxv7UVseCuAye8jZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxB3W4eg9OchxPtbcJEPQhdBmmtxUTFGZzIRyG92ZQQ2Tb8XeNFvk2cvAxEPi7KIEF0B2Nc6Wu0IO22bg4vc+cRijNk20UAMhSRpkkrkk4LN+K3fLajF2RXKHIAbWczhpQV2D7uOgue7DrPRrmgjgTT3Qr4cg+TCU5CTOy4+7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meosDt1c; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meosDt1c"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce52ba30so1099093fac.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818577; x=1756423377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFeI9QVV86ZBlnQguR+y7AN2VvXE07EgOASWBT7FAvE=;
        b=meosDt1cJnoxX/joIG5e5r7cBMAeulZ2q3Mpo2xgw2cwswsiXCDcQWbyt8u0SY5ABF
         5/Or1JDwXD2P7lGrdh6u4KfkRO6SGcEOGPnTLJl0r27qMMOfnFMqkqEsDYaN+UXWQvZo
         tOgkns8aRKjBNgWTu9A4I0Lb6bX6SWIPBfZuTTLZ/Sm8+SrXyvqpA/JWZjmQ6U2K9rNC
         wJERfjvsPjdk1FUJkTg38COoyhTkaCJ8XzXMgVlgut6C6ESJ4eNsCCDIKuJ81MRs+n/v
         4ZRLth4UzJ8163sdDsp5iY3HvHYHYqEVxFQ3GeBDgPXyp71xMhKgiawhpSYj8Uiu079e
         1GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818577; x=1756423377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFeI9QVV86ZBlnQguR+y7AN2VvXE07EgOASWBT7FAvE=;
        b=aSiLmiRgNaJ8Yry8MC6pMe8Y4uVkMdtoQrB3XW35DfAt6h1H7Za5/WGlJs7J2dhI5P
         x1YYrFCljFA+d8E7cu6RaVsPbWn3E312KWA8mf/3XgYHoWwKJfAKJZR1AJoR8OjMYf/q
         1ASnRAGFFDhSLB4DGOk+IpkxJQgIOfCNPVvk+AmyrdJDeEwErwAlXml6xhLNE5IrHb6v
         QXFvoOYmg/eQOd7hYlDIKzlbjWdgMlybeQruT5JMfXmcVIuXZrOAD6ZvTvYkIU7B2u5X
         Dupu/3+zuKtT/ytrDKLr+25+DtCuz/XLvAVe4oNbnM1lDtFG5qtnLZkBDNuVyAa0vShR
         MjGg==
X-Gm-Message-State: AOJu0YzC15OSvrjU4l+FrEcTBCzbXxF93sOuDRdDs+VkICvvetgVq4+T
	BcA6Mix24uBDBcRYhECPHzSjNgrPt1EZXDyd/Kak1fMmDFao/Ri+PtTKwWYfClL4
X-Gm-Gg: ASbGncvy+LLQB8ObUeExdVWbxpXliHmt4cf5CdS4rU1KhIB8ItSYGs6w6XARQ4J0FHs
	Q82vMEUGclsFCJBdExwUBLyq3AbfaDt6hKYY8Ui2QZrRARE+yYSw33o8e3uMvm/hZMQZ5NIhFN9
	hwMI1M8ncMsBmrkedAQQrgsHYO/2Wcy7pPkTzMyzLcc0Cunzf62D2ysLCCoRS46/XD9RxzAt0HU
	7HHBuQpcXErwKlxyJbMnbuyPoijeI1SwOsuPNUU03mtWD/NJLnu2pC4Hm7Py20eb9H3QK3PKA+Y
	J6tetK7ApIY3uyHsPNcKdtNz2muVTczuF5iQ+18LDZj7PZ51SXoP86O2hYduOpV9x2R0QTX5Q0E
	zK/VXDFvJ25HyJM5X0XL8XdUSRyBKJT0=
X-Google-Smtp-Source: AGHT+IGrD0ZsvmFUbFvWy2zujap0G+7BOVtByJfpnAQBZSaQcd7yX0znZKrS6XlKNpN+sIDh7BfTYA==
X-Received: by 2002:a05:6871:5826:b0:314:b6a6:6899 with SMTP id 586e51a60fabf-314dce40c2amr620106fac.45.1755818576869;
        Thu, 21 Aug 2025 16:22:56 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d621sm3759747a34.40.2025.08.21.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:56 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/4] bulk-checkin: require transaction for index_blob_bulk_checkin()
Date: Thu, 21 Aug 2025 18:22:48 -0500
Message-ID: <20250821232249.319427-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821232249.319427-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk-checkin subsystem provides a mechanism to write blobs directly
to a packfile via `index_blob_bulk_checkin()`. If there is an ongoing
transaction when invoked, objects written via this function are stored
in the same packfile. The packfile is not flushed until the transaction
itself is flushed. If there is no transaction, the single object is
written to a packfile and immediately flushed. This complicates
`index_blob_bulk_checkin()` as it cannot reliably use the provided
transaction to get the associated repository.

Update `index_blob_bulk_checkin()` to assume that a valid transaction is
always provided. Callers are now expected to ensure a transaction is set
up beforehand. The single call site in `object-file.c:index_fd()` is
updated accordingly. Due to how `{begin,end}_odb_transaction()` handles
nested transactions, a new transaction is only created and committed if
there is not already an ongoing transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 15 ++-------------
 bulk-checkin.h |  7 +++++--
 object-file.c  | 21 ++++++++++++++-------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 53a20a2d92f..0e3747640b9 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -365,19 +365,8 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 			    struct object_id *oid, int fd, size_t size,
 			    const char *path, unsigned flags)
 {
-	int status;
-
-	if (transaction) {
-		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
-					      size, path, flags);
-	} else {
-		struct bulk_checkin_packfile state = { 0 };
-
-		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
-		flush_bulk_checkin_packfile(&state);
-	}
-
-	return status;
+	return deflate_blob_to_pack(&transaction->packfile, oid, fd, size, path,
+				    flags);
 }
 
 struct odb_transaction *begin_odb_transaction(struct object_database *odb)
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 16254ce6a70..ac8887f476b 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -14,8 +14,11 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 				     int fd, const char *filename);
 
 /*
- * This creates one packfile per large blob unless bulk-checkin
- * machinery is "plugged".
+ * This writes the specified object to a packfile. Objects written here
+ * during the same transaction are written to the same packfile. The
+ * packfile is not flushed until the transaction is flushed. The caller
+ * is expected to ensure a valid transaction is setup for objects to be
+ * recorded to.
  *
  * This also bypasses the usual "convert-to-git" dance, and that is on
  * purpose. We could write a streaming version of the converting
diff --git a/object-file.c b/object-file.c
index 1740aa2b2e3..bc15af42450 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1253,19 +1253,26 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
 	 * die() for large files.
 	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path)) {
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
-	else if (!S_ISREG(st->st_mode))
+	} else if (!S_ISREG(st->st_mode)) {
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
-		 type != OBJ_BLOB ||
-		 (path && would_convert_to_git(istate, path)))
+	} else if ((st->st_size >= 0 &&
+		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
+		   type != OBJ_BLOB ||
+		   (path && would_convert_to_git(istate, path))) {
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
-	else
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
+	} else {
+		struct odb_transaction *transaction;
+
+		transaction = begin_odb_transaction(the_repository->objects);
+		ret = index_blob_bulk_checkin(transaction,
 					      oid, fd, xsize_t(st->st_size),
 					      path, flags);
+		end_odb_transaction(transaction);
+	}
+
 	close(fd);
 	return ret;
 }
-- 
2.51.0

