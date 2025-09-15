Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F582877C2
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968212; cv=none; b=Onk4n3bPCzG42msho6i/STOne9K/jSshWGGvNDRl0MkHNi0roLsW6RYf6/g3a73/sRReGo2jNXz4LCMELecJB2Sz4HYQ3uCcPBkrHoJTsYGfdvrV/C0R+1B3VFOajWRI6EYWpo7vhVVeBBP4EaRE9aPEEx3bZLwmTs4Rx71yxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968212; c=relaxed/simple;
	bh=e1oi95+AO/h5N/DCNb4cJ/8u8qTahEOzeUXlgngM5JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDQfa/ZBcLBbzWRiqEiY6qyV7hh576u/nxnWslb5z84KWto6wHQVc4HvpqCehjUyMr+MelEfMEbHiZvy4ywhwa3tI5n47OCPihLVxfYWmh3nAKvXoZ0P2qQmbqU9IC2NdfMqgSSqEkzcs6D1ts2KiUgwrIcQtjGc9BablPm/Wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFYwVWi8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFYwVWi8"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74c1251df00so2415649a34.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968210; x=1758573010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OC8208b5GXoeYGX7TYfFOu9O6CmQ1pQy/kNorZNf38=;
        b=UFYwVWi8FbOz71hRA0IMv2McYzg5zeUcIlqehYbj1IG2s8t9AGZtt+r2/IQML7nptI
         ZeLP99w7cEERlyDGCdJ2ZAv1h9HAdi4kSF8EbRI7JCh+IPNghWKmFXsRsNtczat3tMT3
         4C5cMH6x2nGkxKBuGI/EABIpzi3RRE5D5bxxUzRt/kZF1Y2lMn2iH5vA9DVpGJ2Xzp+C
         vfiH7s7nc9W7HmP5gzZnfdGUg213bT4Lx31E6y8Cah+K2StzGlK77TE9mFG1d4HzSTxm
         +C5wGQXRFPMhv7SussriqRNbCqqzT6ztuG9Ku28zSe7dzly5Go0+OuGfTreRWMn7BvXL
         0dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968210; x=1758573010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OC8208b5GXoeYGX7TYfFOu9O6CmQ1pQy/kNorZNf38=;
        b=Zh4eP9XJ7jrDIrs0/IRD+OSnUjExWKc6oGZumt/30jNRb1JsWALa7dO+A+CQuPm63P
         tEbKUZnGFzvoJggyhlHWG7JrAZPOGMKcVIU1WDNRx+uCBoPnIiRchSUvN48OYbFBpbz0
         zRO+kck5qrT63TXzyHFosWIgpFeqGvNdigdjfM9XW/7dxKxNwuKT7yoZHTzZC1XQ/lxe
         OFGm9Rlw0ilejiyEq89Z3m5NPu8Mk4CcjSSClls+e44lG1f0muw7fNBo4kW/n7F7lzlM
         J26uua5FMUOhL6OuKmR59JLUSjTtnHVw4kVab/ygIJXDnSS0b65vjRreHohWWvkm3CnW
         IYPg==
X-Gm-Message-State: AOJu0YyQmvQq7Rhk3VxKhh5W6wwS5x2b7m+s2VQSkHZhknAlmqgViEu/
	lb8nu9Z0KA5WiekcZKeEkq0jdgoF8opUkbSfPoCGiUWUQhYkd6v7VTYw4/tEnA==
X-Gm-Gg: ASbGncvHeEtl5rmTvTgq3FopYFpyO2BrYMODKwLi78P/I8vNvNBQK9aXOn3yQqeK0R3
	FTbiuIRpiHGnmU6k36Zj0wBASciiwjnakYUKQgfr791TngKVWgLRhv7ivjgGX683OY8XFJ2nYQO
	ooEaU7DRlTXuxFAGJh6YGZVVY9ZXRWVTMYc/I4uvRpvl8csZ+nHqQ/Msc6svMYR532nY1dy/kCh
	ZfcHpvRa2Ebg2PleTrZbtCb1DW5+ECTLKtEyfHKgy0zVdXbg1sS/RsPHviDMpExzfqJtWyyMrQ/
	5in85x3YqLDMdRGWj1pBg6cXlS83p1yfdIuLylc2ZBWpYYb/nHoByNFWzCWp4zyZM4OB5ONryiQ
	RMAW68zmzkImswHCCveDfLVldTxezjWo=
X-Google-Smtp-Source: AGHT+IGKCllkzkp8RPa4fgHML7CeegRu9mwOlbNvGGuahTrehPUGjtuNEfl7gzLxBkqstpDV1+Do2A==
X-Received: by 2002:a05:6830:490a:b0:748:8b42:779e with SMTP id 46e09a7af769-75355ac0c4bmr8126675a34.27.1757968210125;
        Mon, 15 Sep 2025 13:30:10 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:09 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/6] bulk-checkin: drop flush_odb_transaction()
Date: Mon, 15 Sep 2025 15:29:53 -0500
Message-ID: <20250915202956.3784935-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
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
 bulk-checkin.c | 12 ++----------
 bulk-checkin.h |  7 -------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6299d1c9b3..e1d8367967 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -376,15 +376,6 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void flush_odb_transaction(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
-
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
-}
-
 void end_odb_transaction(struct odb_transaction *transaction)
 {
 	if (!transaction)
@@ -395,7 +386,8 @@ void end_odb_transaction(struct odb_transaction *transaction)
 	 */
 	ASSERT(transaction == transaction->odb->transaction);
 
-	flush_odb_transaction(transaction);
+	flush_batch_fsync(transaction);
+	flush_bulk_checkin_packfile(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b4536d81fc..35e0564082 100644
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

