Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640373672BF
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701451; cv=none; b=mAagrgP8rN/gtEOzZsoNCcULKdKk/TKrGZXNMHesq2WErEDRscd/DjESRhN2bdhWLEWeyqk3ae4gsKNUZrS8+zn/zyM9Avvkbt5y/f3oPIFh7YGN1dy2ZWWfSs8GiB36HSr7DuhmtyQr/JmoUxxAtHsJDT1YlP4C6t1JHtPrkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701451; c=relaxed/simple;
	bh=Jk2E5Uw+4WBzW+eHpo+IMnp7D7ua4kPTRtZGBO4aoBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQemyzH0X2JIkqsw1fMpp3sEQY5tTSIICy5KlvEm3dDOM5BBCQKGZwr5FjJM+sFHZEpM8/zOI1S8CuVw8SjLPl3vw2937KrStYrAvSS8K2BNJVbctWuhzpE3IIDus2IUPvPfBq1Q1UnIuIAxqJbnyZi3/ftgNBwRF9EAoA6rrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddi4kKep; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddi4kKep"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb4d8a21a8so863993a34.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701449; x=1784306249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=Ddi4kKepcwFVwh3YGtZUA3GdZHMi11xlWAKR//BXpTl1vGUj9kO1wa64BzhXSB41AU
         K/UcNjoAj5a4BBTPYs3U2VvNuE0Q31RP6yiEC3KjH1bZiSzUK/oLxdqxzErIsYaRqC96
         MKY8xvJaARw7tjlChauvXONIh/36weeqLP3tLgWpvodq5WJP8e0KijxR+vP1qw+KbmI6
         HDiV0cq4/hjm40pwVDllnl80l118wdQfHDl0Gj0llkRMQCN/2gHw1JToE8u851BJFWZ8
         xQjriCHjz18zf6wGGX+eyMwAPEwAvEgwUJ9gggO0lJj9lJ7k5LyO4mZmP+eMeS7V/IHj
         aHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701449; x=1784306249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KdMH69oD6LL6hPVV6AFUFTU0CgYi7kzlxSOOUfI/80w=;
        b=lj5XLc0n6EorJbeKg9HJbBgbMospwCoTCmb5R7GIStOVwfsCB14jCmmxis8+xsfTgg
         yPsBB/oGpBqc8Kxw4DDyFBEOb0P2sbfB275HP7PvVumyLXRDu/Ryp9lRE3+4H2C692/P
         ptugX+oUsp9ZF0kjS///2R0EbY0boySiZhpBBvKku5ZY1IemjY9CyKoPP5dIppjKoLI9
         I5PKDYhDfwzyg+pDh753/iJtm0HqhQ4o5RDjcd8NlPMTOLKtPBGh7vSmoI8+nA7Qn6mT
         YD+Rn66qk1vnFUHLWq3WVir5M/zbejU8zPBRrkuGOHFb+HTMOlBvF3BBVPBl7dv0grVo
         eY6w==
X-Gm-Message-State: AOJu0YzXWlA2vuKVXffHBbFSKysat/rP+1VnEKKPlWxxXcZbLT+3CwZD
	AGUie9GkzcGWroN2FttRBgrNK9dmEJQpyUj77SlJj7rI/n2ZEytspz6GrB0e1g==
X-Gm-Gg: AfdE7cnfz952GD/Pm38t4w4gwdUGENMLhcFRqGiYLTcCo9OcPmWSORlKKTNYvIuXTxy
	Dl0kjqufnmi9/wr6sNvF3xuKe772QnttPhoVW6eBwHkNsM/8sEaqxPwXFddQkY2tb75uG/yVwaL
	BVd5fRwU6KQwnH1YneY4st/o5VeF7w4ORvT7p1Q0cWPBXeN2agQoha5U3urVkUORPmJb3edna3W
	Exj1vBN3w0pDT4+pnXM3V3IOER/nY+TLSz6E04XiDZIdt9F1Dc8bxx3BWSqGTpmBtv3LP6DKy1I
	SD8487Qu/cm+9/VcxpGwdPP0s1uQqnvmn46RUGJSUnS+arH8tEQ9hyGEMrPa8Tkt1PbtqUg85CD
	fzVPmP1p1FW3e6gyjmVx7j0daGoM7LdeyNE6IsEKS9FSHLDi6qjimWST09a0agU7mIg7HuYVaU8
	nOIifBvdDfqkWmkKAYz6mt
X-Received: by 2002:a05:6830:81ed:b0:7e6:f2ef:e231 with SMTP id 46e09a7af769-7ebcfe542c8mr10596015a34.2.1783701449314;
        Fri, 10 Jul 2026 09:37:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 02/11] object-file: rename files transaction fsync function
Date: Fri, 10 Jul 2026 11:37:13 -0500
Message-ID: <20260710163722.2962278-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
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

