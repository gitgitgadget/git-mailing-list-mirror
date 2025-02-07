Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53336233D98
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913831; cv=none; b=oq5hfOtfJhDxJqU9ZX/0xbAdr3/baX8jJ1PpbzD/U4tvBzfigLH++5UaN12CLtXbkjLIxCbOIkrF53UNX1cGtOn8DII8DyDHLMUdB3bAvmuu1Dc4I9fYQd0pz/JJvBnArr0UbtHk9FdEmVMVyhBW+km6K33cO/C9FNFnRyly3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913831; c=relaxed/simple;
	bh=/93ilwoAPUAPhaigNwnzxuvu5ZqOVZO0gIj2Cz+Tvyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiC3/5UlZDM2bfghTqvmAmTM4MlkKvxjRWP/qwny6iGICKhj4FhRJ3e/SdR0+hJxI9UqhGHJYJaSUs3blSL6Yt7U1pi9jEwWBDcknUGgWzJHvd6uzDpr4gPbciYrJz3TOsGaEw1Xxqu1iQxde0Z31BtRE090JhNngevdFVjbzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx8H3Pa2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx8H3Pa2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21c2f1b610dso43496015ad.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913829; x=1739518629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8mVxehKNFPgAh/+uKFSdFCJxS5RQi97Hzg+MSLee/s=;
        b=Dx8H3Pa2P2XOG++M9NKdBAS9tivAdGu3Vz21jaLODabrciKs9ZbTahGnfBsW/nAbvJ
         mSnv9jaX9d8YSd5L1p5Ochen8DuRWFuhHk5zoq4fRc2y3uo6ZJcuvYBhFY/WRGe/2roA
         CfjRafd/V/EjV3Ra9kbBHYUrJwIDpgZXHy9U9Xh3mLaq7gYi8M9l+eVdfyEWGUu0OEi7
         AdiTQwks7BJtxf+FSblRxbAazfDwM/ZR3t+WP8haUTGTFkjjg6jLbjSPQdrXHGMc2bdU
         fI16q+47vRwLzuphdeNdSZ3j69dgist5h6HWMt1F4v8tKlEAiQhzHtMamRtTo609V2ZY
         Q6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913829; x=1739518629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8mVxehKNFPgAh/+uKFSdFCJxS5RQi97Hzg+MSLee/s=;
        b=G3EJaic3gXaV5ldK7Bg6HAzhVzWx5cNCwZKAjIIkITEdRJb9NNCqlrImyDL4JBM5b6
         +nCkClpsxGyVADfe36wWbjmiPQlsNTXCHcF1Rhm28DVOzN1lGCyeKAESWWbb0t9YdUF3
         5U76bwhdu/7Bm8yo84nYpobLsqs3Uft2WdVivaaIdNtsreMsXjgARbNUiRhPmyMlMy46
         4P/IYpZrg1oVPScDk2aAtDIdvNSMvvygw8FNa6oqXKW+9ZJQ3aA+GHKQVXHOfxxSLA5w
         Hy1ydRHNJyBFAb/1YGjjzQScHu/xc4kbmiOyoDkZOg45u5E7xAD/tQKMqjd/9R2YUmKS
         FcYA==
X-Gm-Message-State: AOJu0Yzox0+QL9aeHRvICBnyIsLoSdzwFUdO4DNeTTfaHgFp64ErH3SO
	gkj8twxmBho6CVcPaoF6OdDRvCOz61EbCUCpQ5QDzTXCzcMYMGd67IFYCfje
X-Gm-Gg: ASbGncuCvPPkjGhjLXMN7J/jC2ybhSUftnK67lZ8y7rUpBk2delGjGrSxZLfqQOicud
	2PspnfzPvgMMsep+yvlOpMQ6XTf6Nqi0X/irqgg4nVs9xJsbsS3hm9gcc3jheOb6brVOM0sVPkn
	QgJZqFB9iTISA/JRIgTl4C5iPIppkwEgqsKHvR1DvLT9coSv4QPb7iMIQt008S3+Igjz7FkW8LT
	bX/EyZS5ZRIgr2t7i/av4MXb1xVonixjJ+JulMCnS64bYFZG/iXxWGO07+ZmxB3/8WRfux5hF/F
	Yk7JGOPIXG4pZYSeBKkDLw==
X-Google-Smtp-Source: AGHT+IEafYOdRCNVHdjzte0WL03dGO6Nvfb6yJtjZCtvlJBkRyejsfU95Z086we5rK9AAQqmbIeamg==
X-Received: by 2002:a05:6a21:100c:b0:1db:eead:c588 with SMTP id adf61e73a8af0-1ee03b20a2bmr4510835637.29.1738913829297;
        Thu, 06 Feb 2025 23:37:09 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:38 +0100
Subject: [PATCH 3/6] refs/files: remove duplicate duplicates check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-3-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3178; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=/93ilwoAPUAPhaigNwnzxuvu5ZqOVZO0gIj2Cz+Tvyw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBqZxXX/tH5tGKdpnGwNgJNy1psoip+av
 hl7q9UDpnVkpokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgaAAoJED7VnySO
 Rox/TXsL/iAr3ru0YXw0KF3QgslNjPm6o8quulcvAg2XugzKYJrbI9vDuj1CnAjHvsHMvAhQhJK
 8CcjmLtSRPr9zewxg3MZr3i5ijBWm3P7OPQCixROAJy9TdGemmBZgqayXrM1FdX78KiMI60xXlH
 UYBmVlD6lWHJrLDBRocj+0j4kXKogPe1/EihF8OAFGxgMDPmRHpERMC4TzD0/QPUkzlWJArjY91
 NOaWoOLIp9EIq+2Bn6Eoi3glGipXcEPrJFC5JnSDPzcAVWzl4jNetgE1VIGGW3chNK6SaaOP3r3
 TJIHJo3zUN9agDJiX2Uc6gNCX5Yw3aNIk8rHXDFTLSXCuiuy3qHYnoQtfgmgOERTSEpIhhOt/En
 u3eXuyHNwAICGsFQZvU9OUvNGhEZ9qbDVQfICHuJDFOU0kF235c9+Zc7i9c3Bx2o7JkSLY8C3VJ
 YLpFrNcq9Qj6YUq9v4PLbeog056el3PXhgY0ngP1M8I40qkbylVIdsnsUwJ3pTIzua+9iHu55U4
 cc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Within the files reference backend's transaction's 'finish' phase, a
verification step is currently performed wherein the refnames list is
sorted and examined for multiple updates targeting the same refname.

It has been observed that this verification is redundant, as an
identical check is already executed during the transaction's 'prepare'
stage. Since the refnames list remains unmodified following the
'prepare' stage, this secondary verification can be safely eliminated.

The duplicate check has been removed accordingly, and the
`ref_update_reject_duplicates()` function has been marked as static, as
its usage is now confined to 'refs.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               | 9 +++++++--
 refs/files-backend.c | 6 ------
 refs/refs-internal.h | 8 --------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 4c9b706461977995be1d55e7667f7fb708fbbb76..b420a120102b3793168598b885bba68e4f5f5f03 100644
--- a/refs.c
+++ b/refs.c
@@ -2295,8 +2295,13 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 	return ret;
 }
 
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err)
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+static int ref_update_reject_duplicates(struct string_list *refnames,
+					struct strbuf *err)
 {
 	size_t i, n = refnames->nr;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 18da30c3f37dc5c09f7d81a9083d6b41d0463bd5..9fc5454678340dd7c72539bfa0f15ee7eb24b1ff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2995,12 +2995,6 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (transaction->state != REF_TRANSACTION_PREPARED)
 		BUG("commit called for transaction that is not prepared");
 
-	string_list_sort(&transaction->refnames);
-	if (ref_update_reject_duplicates(&transaction->refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
 	/*
 	 * It's really undefined to call this function in an active
 	 * repository or when there are existing references: we are
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f43766e1f00443eb689685cf4df0fa0b80018a03..434362b6099a35f92906a04ddd65365140147572 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -142,14 +142,6 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
-/*
- * Write an error to `err` and return a nonzero value iff the same
- * refname appears multiple times in `refnames`. `refnames` must be
- * sorted on entry to this function.
- */
-int ref_update_reject_duplicates(struct string_list *refnames,
-				 struct strbuf *err);
-
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify

-- 
2.47.0

