Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21894282F22
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484063; cv=none; b=iJrF+SO9+hMYfPm722AnjmQkvbYQaNRLu3seEkDipwDAFMeSAudX5kiNojkf7XikFV10WtaYQdCF82wR8bbpoSmgVkjq3k35xJumekHPD+vU67Ge4kN7kkNWKA7REihqA/fkr04MxHKAGlmyoCpbP6CNNnFcENY63+soDT4ZABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484063; c=relaxed/simple;
	bh=Jk2E5Uw+4WBzW+eHpo+IMnp7D7ua4kPTRtZGBO4aoBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iclR5PJcL6FObKi0DU9gyXjm9q356Ap9OXsgNJfpZRJOA4MnA2vzIpPrw5SOEdZVmAdyrwdSNO/eoco/Juwv/+E7DJwNmcCkldpVhst5u91dV2FMOV0EfASFqhHeAPB3y9PiLsf4AEsohKg6lPL92gypGlWthxJf98r4uv6jjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tH66B+6f; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH66B+6f"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-497e6956acfso220663b6e.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484061; x=1784088861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=tH66B+6fd6ms3qUPGR/zDAB+GPbV3rBqjKweA4m4RxlxmVKPCBaUbZs2gUEJldxBni
         bpu9q5nH8yx2hSQr4GR1tcaI8d+PpfesqIuXSa7OO/6inAj7jbyexQqoHHEUeTNGoJ7C
         wNE4H4yN0nLlf9lPuuNNaeQ8YRs0cRYeoeO3UadsNb0g7Fc2UNj5uEvTpOgaVTXdJ0BW
         50DMYmVCME1MXO+idtCxqUpS/V+nZd5XDKqSkm225ULTDdAp8pWAAcHvxsH+tbKUN2YL
         TAxSMBG+JeVCVeBqqmtjvAWy0ivijFATRhFA+dwuGpeXquFHHRNxAZhAyZQWe+CaUvGQ
         oiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484061; x=1784088861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=M9yXa/JjBCh29KwSGpEAETQvkuuXp8FDe+5rpmesHhmVEzy2LyK/Y47+r6CElovmP8
         YZvCikIt9UVN8tC2t3KXImv7fJkAu2u8P7yuySywm0rUQn48dlP0BDbHDIwxiPVrFxao
         sNb+fqBm5y7wprruNBzhcfdFWWGT0ECyr81dF+73Sk34pNsdJZsOBphVNwQIHElfiMB+
         lA/AKx0xo3ISEzidxiLzp0hV56IoZEHqgO0EYjQI0mYzGTYXvpexbSiog8CGGD7aVsDX
         76JQ/PZ7c5uhCBnxKlBfSUYWyA9OATkI4e+FlSVg7/5foHf53Es/43h0a85JFk9yr61I
         XZ+g==
X-Gm-Message-State: AOJu0YyZaUmIc67obFkldR7f+njO5i1jsnybX/qS3/+lpNOqLMhK6RPl
	dno0n4mceFkhQ1MZ2ND2KKW/o08dGXgra+VyswMF+X4nz1Xhf+rWNm5y2+Behg==
X-Gm-Gg: AfdE7cluQy0OvY4PM2/FfzTIL5LGJ94rsqRWwhXUqrHPtwEQDsWK0VYDcrFl2sID6dp
	pqUtTCSvdbxqGJAhxIoXQoV5XFnXLyO9PQNAYwEuLcOpSeTljuR+wL5VOsxMtHf0fWt8324QNnk
	sC95zUaE8zTi2rAzHv/BEaDmDIUSRYlPbgNiIwiok6ljFn3joLR1Kk+bfBxylCvp2mhxX6BBTi5
	AX9hDCuvqxuHZGN92gIC6Jix7R9YaYtebJe4Bmq7ReUEY1NNrnvIwXQ4Jzw9P5U/CAhRSEnYiHJ
	L/nJluUlBfYmWnRO7k9x/74d/A78jly+UrFMAobpBtQYr9qipXEDIsRpWlK+a3VE8BvxRtMtiIT
	FBImplixWtVo333GwragJF95reZAdpai+Lh4OYSKcN1EC/N0cVQ2DZ7C3n4CnY91vsVBWMrL+eH
	Y6GvQ8lXmmi9QNhRyHMkkUiOap/zQkj/Q=
X-Received: by 2002:a05:6808:6804:b0:497:db25:8a2a with SMTP id 5614622812f47-4a1f0a08766mr776666b6e.13.1783484061006;
        Tue, 07 Jul 2026 21:14:21 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/11] object-file: rename files transaction fsync function
Date: Tue,  7 Jul 2026 23:14:03 -0500
Message-ID: <20260708041412.1157499-3-jltobler@gmail.com>
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

When writing an object to a "files" ODB transaction, a full hardware
flush is not initially performed during the fsync in
`fsync_loose_object_transaction()` and instead delayed until the
transaction is later committed.

To be more consistent with other "files" ODB transaction helpers, rename
the function to `odb_transaction_files_fsync()` accordingly. The
conditional in the helper is also slightly restructured to improve
clarity to readers.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index a3eb8d71dd..d68824bb44 100644
--- a/object-file.c
+++ b/object-file.c
@@ -518,12 +518,17 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_transaction(struct odb_transaction *base,
-					   int fd, const char *filename)
+static void odb_transaction_files_fsync(struct odb_transaction *base,
+					int fd, const char *filename)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
 
+	if (!transaction || !transaction->objdir) {
+		fsync_or_die(fd, filename);
+		return;
+	}
+
 	/*
 	 * If we have an active ODB transaction, we issue a call that
 	 * cleans the filesystem page cache but avoids a hardware flush
@@ -531,8 +536,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
 	 * before renaming the objects to their final names as part of
 	 * flush_batch_fsync.
 	 */
-	if (!transaction || !transaction->objdir ||
-	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
+	if (git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
 		if (errno == ENOSYS)
 			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
 		fsync_or_die(fd, filename);
@@ -553,7 +557,7 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
 	/*
 	 * Issue a full hardware flush against a temporary file to ensure
 	 * that all objects are durable before any renames occur. The code in
-	 * fsync_loose_object_transaction has already issued a writeout
+	 * odb_transaction_files_fsync has already issued a writeout
 	 * request, but it has not flushed any writeback cache in the storage
 	 * hardware or any filesystem logs. This fsync call acts as a barrier
 	 * to ensure that the data in each new object file is durable before
@@ -582,7 +586,7 @@ static void close_loose_object(struct odb_source_loose *loose,
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_transaction(loose->base.odb->transaction, fd, filename);
+		odb_transaction_files_fsync(loose->base.odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
-- 
2.55.0.122.gf85a7e6620

