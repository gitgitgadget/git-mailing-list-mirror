Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBB244660
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588802; cv=none; b=JpT2Y3X63OPzguIxmOsWtYFv91We/oCLmXoPKtCmzbVswndgOZDZnvBSI3i9LY7XLvFKadqQLXUIMzq7Ksay5bjhEqY4zKfb/8Mrmw0QpUBNyBszmoILAWfj9ptNQH+TChIDqPHBy7ghsa8JHfyekMx9HcnULBcG63+2vCeYQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588802; c=relaxed/simple;
	bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GN/E+kb43qmCznpErm4nSWN99emi3Sc3NX6cJWNBA7vKRXNbDwJEc+x3BafmLL8cmtE0j/AKgoxkDZv4XFtOO0/0U7I3EskbtJcmkdP9+TjCV6B22d+RfLAD6+4NKZHNn+ewFRR5Gy86Rz7bqQlsM3QNyJ5O6HwrNV4J7qIGlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJP7bSKh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJP7bSKh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so318375a12.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588799; x=1764193599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=XJP7bSKhWtK9pORHCbeVhCCYNczMoZfjb48waBG4jl7FENhwHNmk1/1EmxN4Y3ASbu
         yY7ph4LvSIoIpYfcSquUSNjbeGB3ljwrwVlhtTwo2tW2bkOaXLTJpvO20xNxRxCFaDDY
         kgf0OchqwHnCyBCuee7zb78eMFBtAQLDM7TGZ5tKwtfY2UPB2J1EuIAZ3aTL5zHmeKt4
         emvwBJHVXGL+69jMyltQ1JB6ZD+unzCp0p3Aq799caIi//VIzxRvI+4j4aXloyKOAIB/
         x4w6wwdO0EBUKUnF3IYB0Ko1enncADPVHEze2mDlr/sceyB8QX5GronGDgzWpJd3pRAu
         F/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588799; x=1764193599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1MvPK8lBRV2R11IKy26P5zITc66GZs3/BkgS01Dva8=;
        b=O/lKZUNNLTb2C0vmppJDRdyoK0TVtYaI/FAdgggIc1oi92zX+Bk2S3Y0sIqoqzTcRE
         ADkha5d6cJBWD3Sh53UBSyB3UTKI+Lv82xfNFYZT9scrUpztcZ1tj6OwMY1bWltJeeu1
         6JxPqYRdoFVIjSW2igdGNcAdq/lk/rBv/SLRtUKFsN7BO8kopIRc47E1oGie9oS7wk9U
         mBu03d8/u9D+43/aUj2J+aFigw9dFOMujo3t85xUFAKBu8aX80o+RxAjVjsMu23lTPla
         4sYcMEtZvRIIGY032+xXSjA5NyBTDiwuk7ljvQD8sbaduP4kx855dWDHUtS7lotKTjQN
         ClhQ==
X-Gm-Message-State: AOJu0YxvG+E/1EaXMv8JWay8lJHtIQN8AZ7+cb2mxgJL0AE0VPwM0ecL
	M67kntHUJkAJ7h6DJXQ4fBQl8zwDIV6cfkJj7SMd0twE1JbdQyJJAP3+HmMtQg==
X-Gm-Gg: ASbGncs1GzuiIo/iYP2XDWskRc2kxNES7Iii0Jp9ujvgqw4Odc7SdxMH8acZhiaFcSL
	5ggJyoDsbWyQnEubOywwCa0DOBzqKc5uDXMXcTiWzH50T7k7VcBe+mfd1xFnKEjon/LZYgv77i8
	lRJzB9t8khTfYbUdCHuNb/0Fmo8438/krYEbCaZW4c9T8gZVE8hwo8UemSxTlupkSuyyizo9mHZ
	04izDDJ83LdhKVez3gyvCoy2JbJ6stnvfc3hvxqhhT1xxiqHojbCIXYpywxTEXPpZ2IbvUfQwS4
	y46skt5jfROBavcBKCgWn+BZyLVyBU1UD6fOa2m9uDcLsQ6OMH7mhdTkfmwLae8LJgl6d3xR5Re
	RF1kF3Ud0etOzxsKl0z5uVlocfkI+IsoQxPSHpp/r4BeFPFX18B5JQTVxoJwpd25Fsk8Oj8a0Bc
	S5fVyfyk2PG7VnqtYShHnh1yoMTw==
X-Google-Smtp-Source: AGHT+IGoh4nCGiwpAVjYj5q9m3Kh61kfK9zRectWy5HNGBDpW1FOI4K12hk/OcC5GK+Acv3Y3hrADw==
X-Received: by 2002:a17:906:dc91:b0:b73:8758:b44b with SMTP id a640c23a62f3a-b765560d306mr55761566b.48.1763588799228;
        Wed, 19 Nov 2025 13:46:39 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm40760866b.24.2025.11.19.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:46:38 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Nov 2025 22:46:32 +0100
Subject: [PATCH v7 1/3] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-fix-tags-not-fetching-v7-1-0c8f9fb1f287@gmail.com>
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
In-Reply-To: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Be7uem3/wLq9XQtY6b5prSrinVeC5ZbQos2T4aVnzLc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeOrveb1SBBITRWxDCDHOOuXuYPJZlr5UCX
 kQmzNMzzCyr3okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjq7AAoJED7VnySO
 Rox/ruIMAJR7EuhFxvnKXyvBAphHxOIcohkuw6DQBUtPmgm0AmUNbaVmtRIjFa75nQQ4SuukrFM
 +pNnC0uMa5mM4641GE2+Oz+zyi/+RYc13L4vTyxMqXCvwLDxGynAC/wUmlMtF9TokKSSXDD+my3
 1s25Dhb3QbXpnKYUmkTblCbxICwqY591yAIVOa0AgrfNerKv8dn4996zi1Z03+iDAYVWW5EakI0
 I/l+tK5Rr9d8yj+xcyE1UPTJ3Dw9Ao4l7IgDwsKuFnm9OehW1WEnJwWYtyonOtKpseSyt0P/KWv
 CDmZLq6hU2XiaZ6KqVgrd+7UWq1nqKBX1NBEV/JRnZ8pswudIghJSUEM3LZL2CkCjsBYcBjTVcV
 9iF3dxmAH44KOu2ARKrMhE9fnj6YJxfkjBLXEEJsY9rpEExZqg7X0w1FRsq5OO2hGdrQ0/9UFuJ
 LmJy8I+TupRQ9DCtaG015fH2YhHsCkM2EW5lVh7HKgOH9NnWEIAhnF98YCKiN5C0Sx5sQKGbdL4
 H8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `do_fetch()` function contains the core of the `git-fetch(1)` logic.
Part of this is to fetch and store references. This is done by

  1. Creating a reference transaction (non-atomic mode uses batched
     updates).
  2. Adding individual reference updates to the transaction.
  3. Committing the transaction.
  4. When using batched updates, handling the rejected updates.

The following commit, will fix a bug wherein fetching tags with
conflicts was causing other reference updates to fail. Fixing this
requires utilizing this logic in different regions of the function.

In preparation of the follow up commit, extract the committing and
rejection handling logic into a separate function called
`commit_ref_transaction()`.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 59 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..f90179040b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,36 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+/*
+ * Commit the reference transaction. If it isn't an atomic transaction, handle
+ * rejected updates as part of using batched updates.
+ */
+static int commit_ref_transaction(struct ref_transaction **transaction,
+				  bool is_atomic, const char *remote_name,
+				  struct strbuf *err)
+{
+	int retcode = ref_transaction_commit(*transaction, err);
+	if (retcode)
+		goto out;
+
+	if (!is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+	}
+
+out:
+	ref_transaction_free(*transaction);
+	*transaction = NULL;
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1858,33 +1888,10 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = ref_transaction_commit(transaction, &err);
-	if (retcode) {
-		/*
-		 * Explicitly handle transaction cleanup to avoid
-		 * aborting an already closed transaction.
-		 */
-		ref_transaction_free(transaction);
-		transaction = NULL;
+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
+					 transport->remote->name, &err);
+	if (retcode)
 		goto cleanup;
-	}
-
-	if (!atomic_fetch) {
-		struct ref_rejection_data data = {
-			.retcode = &retcode,
-			.conflict_msg_shown = 0,
-			.remote_name = transport->remote->name,
-		};
-
-		ref_transaction_for_each_rejected_update(transaction,
-							 ref_transaction_rejection_handler,
-							 &data);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
-			goto cleanup;
-		}
-	}
 
 	commit_fetch_head(&fetch_head);
 

-- 
2.51.2

