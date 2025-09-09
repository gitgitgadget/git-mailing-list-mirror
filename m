Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD9352FFD
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445112; cv=none; b=eLf/e6Tx6RQYWbg+e7TIO/bw11PVUoycN5rJqsNttcFhkvJaszJzDlSCkJPjKvAjVz/gx13k3Wb/R23dnoDnTyqH5gcgL6ty67rSDuMyqla/YDWL9p7uTK0F5uRhjttCmucC9uPMz2yn9JGUWZ1f1FtIVuBEyOyoeyjObsbag2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445112; c=relaxed/simple;
	bh=dVe0eTGoQjCpDMyknSWbVle+0TKMA8+4k3dWbrKLal0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0ZJzK3Q3YjGvArkTLuKMHMirmG6GVRRfWcivZEJv/RyvdTi638IrOgPqqkqkHrHUcGlG4h7Nq1moWAT07H/aOm30hQbMkCWvJKbF2wj1Pb1OnVXkyBL/JyCxAGscGF6wumW9c1x95iXSbKoIThh3ovT3U464ln93g0PNAuG4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPjKD5mV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPjKD5mV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7493d03f426so1627368a34.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445109; x=1758049909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhC57fJCQky+ZV7LD4+1V467QRKewU+XRnfxzg+or0c=;
        b=GPjKD5mVG7ZuiTfWjuffWFOUIhoVTvOTxO2IqnW/K3/LUawFdFcEBmAfeQ2l21I93b
         enkmWNyp/Voq/d5oftIT8lzpY2/2pFKQUmug6jpwXc89mI0j31YYX59m250SwZEE0tmA
         XIAXfwuWHR8cVajxjf7FGmlCEnJqdQDveFvlzeHNFn0p6+AUiSrOkfML2cxC178Zd4Zn
         vpECTjutenplc28EUw9lS0rlIrPTXk+qZYuxCRfEtk1NrRSaEWXpfWHGswRoiQiVURZV
         XgG0nqgBJJmPRJ6mFCtQKp4g+RpjGJ1SPFz46Ocf6hfUaTD8ag+sJ0OyRYY/o7ifJ9oO
         iz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445109; x=1758049909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhC57fJCQky+ZV7LD4+1V467QRKewU+XRnfxzg+or0c=;
        b=lFBeIm8X08mn+6YC5i5/ISSpL8OEblHByspHN5Z/jQz9Hd4V8qie17nz89pKk3AyoR
         LCQy6G3cPvOr3mQ77sj7RjdxLpbqgUunNxZFNhtRSyJd3a64bx1gjnyl/YOW0tGJEJsC
         a4xK9zkWs8FdPFIkZ8ukpas6dnpr4fRyjkc9467wOwQ4AcrwlC/NdNiYVM6IWBp3weIg
         qEKfEziv8u7/WzG7LnfaNqUq4lUTK3jC9E5dSasB/3gWGogSKkj+WAtrfpe0KAeivyJL
         1dcvHduhbT1IHki8Ya/eyYev39Qc4gfID3fAqDR7I1yYY4Rzzc1iBbp8fVk1a7c6XMH2
         X52w==
X-Gm-Message-State: AOJu0YyPLkYO+glNwTqEQMnjvT+9gKEJQLFheYDJ9KIKcQe9qII7+4nt
	oSM09UKAgBu16Y+8+kiam7OM3qe4nqLY0NxQ7S6dR1jGpq+cwogxR0nvePJbYQ==
X-Gm-Gg: ASbGnctbdE9tfJab9/Ac5HpHjJafGxLNuQxQ5k5FYm+X7mD1MMdAMjPlxsA872Tf3ZY
	T2lyzhltuxruFElj2xWX1PvA2UjvjTSzRHv6cNT/d4JVCzEBjuFpNboTs4iBWVnf7Ei1Ixym4z+
	HMLTaIzDucF+A0tvOcBgok/ouermfjJyWcruONbkAs9W0lNPE+Q3kgYObCB8AlX0Nx0Vde8JiHO
	FR0FqZbzyg1DZNRlBcBGuygrUJJ16bKHPXIXojdxjAYd4B5LyrFcvHQCLvCEiYZnPm7nx5Dz5oE
	TSHNEz7rhwpu7SeYLqahkM2PzMN+12Ro9G+zWbxkHptFZXU28rm6wsz8RGtq0UYsI0SI9OVvD1t
	+LNluNxvqaBP+5k8YJe9od/gGOSYArHA=
X-Google-Smtp-Source: AGHT+IHCiJMKQFURneVibCw3DyvEWMRGm8X+TPFod5d4CPDFUUzuBxfuqXJQ18j0UrK6qluWozc3rQ==
X-Received: by 2002:a05:6830:6c18:b0:745:6166:bb5b with SMTP id 46e09a7af769-74c7851d1dbmr6246831a34.29.1757445108987;
        Tue, 09 Sep 2025 12:11:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/6] bulk-checkin: drop flush_odb_transaction()
Date: Tue,  9 Sep 2025 14:11:31 -0500
Message-ID: <20250909191134.555689-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250909191134.555689-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object database transactions can be explicitly flushed via
flush_odb_transaction() without actually completing the transaction.
This makes the provided transactional interface a bit awkward. Now that
there are no longer any flush_odb_transaction() call sites, drop the
function to simplify the interface and further ensure that a transaction
is only finalized when end_odb_transaction() is invoked.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 10 +---------
 bulk-checkin.h |  7 -------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0da5783090d..6f0343feda3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -376,18 +376,10 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void flush_odb_transaction(struct odb_transaction *transaction)
+void end_odb_transaction(struct odb_transaction *transaction)
 {
-	if (!transaction)
-		return;
-
 	flush_batch_fsync(transaction);
 	flush_bulk_checkin_packfile(transaction);
-}
-
-void end_odb_transaction(struct odb_transaction *transaction)
-{
-	flush_odb_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b4536d81fc2..35e05640828 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -44,13 +44,6 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
  */
 struct odb_transaction *begin_odb_transaction(struct object_database *odb);
 
-/*
- * Make any objects that are currently part of a pending object
- * database transaction visible. It is valid to call this function
- * even if no transaction is active.
- */
-void flush_odb_transaction(struct odb_transaction *transaction);
-
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
-- 
2.51.0.193.g4975ec3473b

