Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDA29CE1
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041123; cv=none; b=ufEt1nojFirFx6EcYnjYJCk1Gih7LmD1P8m0Knrmv+UMe0ow5KOuEWPDKDh8GwJqN0TKmn8hSGbZ8WqXDgJ6HrBbldahX/+gcGC5f07QNi87+Lk1brZ6v/Ig8frf15hcgqHu/7V+g4x2sF8DGRGJ7hETiKtVko5gilX9/AMfOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041123; c=relaxed/simple;
	bh=mQG9UrHc5aJea5xzZtrJlR6Xayk81hLTdYaacfHp7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTPh2bpt87nBebuw1p3pEWCh0svBYlKmXv2ECjnyAW7gLG9hvbYSAezPig2Z820ZJUOEj1A9uNL3QsZUXVV2D01SmNNxGC+jG/1E+rD4Ciepp665+MEERBnzY8O23b4mGPfmxu+sU+8zp7D+9CGKWb0pcIwq1WEiEX9yvMrfaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLdUGM5p; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLdUGM5p"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so518718f8f.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041120; x=1763645920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPOD1NGfCW6PjFIAl+Im485kIbYUroUUZHJgxxjmtas=;
        b=LLdUGM5pmJIByTXd9sFcPzkPoDDz+zS4tf10/SQtikb+GhKocvrYoTPMMvUMxRkNVP
         957mautCpiZQvU/6C+30Co497V33qBj/dbmKqzQvEyejNUDhJLdbEzB+WTOy3hufKlhZ
         NydflEYvw6LTBJUSiiSqK3YVda+UJsUDiPTxIRyjtt7IDF4H8F8RiwWtYNCHbOepfpSl
         UGYaeGuKSfiibCj1ZBGRoP3/wEN7rghrbr3Mj4o0WrrfXqwsj5gSG8mwenZ8HNxjCK6C
         tL1DxCiOKzYMSprh/HpRqNRrkTSlX1MiHcxNe6Hbmb+04ynxir/yHyub6QZUDEEFrCwS
         f/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041120; x=1763645920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iPOD1NGfCW6PjFIAl+Im485kIbYUroUUZHJgxxjmtas=;
        b=p1S575dvsBz5DCZ9N4/xQuoTRzVQkTSqPT1FCDJmxi8vA3qledUxZQBEyu6f0gZ7nz
         /1pyf6oxYh2SSvoJBm2jPN2gh8n1VOLYiW2+kA1OZsdCeLyZe2sIrmCIT2W6959DagSC
         JprEcn44S/xBIJTp5puvNEx41/ueyeIxExp7/RU7L/uujIjhH00JLc5DaEGxsUpCEOVE
         R4dyG5kubLWokvVYgXDsOe8hxuU5t0m7Uyl1BmrPdXxHRLElprJ4vzQW5qoxJPDBAGC/
         HN+ZuPLRtsa2RUGeDNhRYNxN2iIq6lVeYLm4vBYKyspg+c2Adz8oGc3+zDUU+53dgqMF
         PXNg==
X-Gm-Message-State: AOJu0Yw3aNHoL5nMtL7c+phDfKU74+JC9zAKe7WFy46cveBgHE0zcXNC
	pG9tBnitbLSVmdqcZXsDxPliItthQeRnWdLwc48QU2J3mXugtBzHH0H2
X-Gm-Gg: ASbGncs/SnxHFPLomBvSoINkXpCZy7Yj9LgmG75LP3mdQcQfS3rXy3tbCNPvsXReHUq
	0LOpRJlpK4EJT8m6JjkrzoCDWo8ilF7LCV1IBxYdc5Q4ryCulH35CcwnEgUOIcms2F+wBGZzxIS
	P8Uub+iDVjokvakdpCPTvSdBIyhiKZ8cdeRUThc6OWgENEokc2b6eEA/XGKwpaWRIRoCCqkmsgU
	5CavTkgVpiA1X7oK9ONJKZ1WlSSM1T0BBayKnafALGRAV9KotTReHmTZ59Vq4STc0MoBVzirDb/
	SUjJtvpiydjHZDMPiXB6A7VLJTw2Ulf4toRClNRlQuspeluYT6DAQCr7bMW7AOxjuHnyXMekgsG
	MFwGMmRY8R5qECXuuYKaSaiV33BHDRGNXrMFPbWQAG/iejIlI35+yGG7ltSJlF+bXQ318OWjGv2
	oE
X-Google-Smtp-Source: AGHT+IH2svo3hnUj++TuyPUFvVy7ouTznWaiOOa1FbcszZxkE3RYkiOl9ARb/rYETDY+wwB6RkQNRg==
X-Received: by 2002:a05:6000:40db:b0:426:d54d:224d with SMTP id ffacd0b85a97d-42b4bba5662mr6737700f8f.27.1763041120030;
        Thu, 13 Nov 2025 05:38:40 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm3861166f8f.37.2025.11.13.05.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:38:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 13 Nov 2025 14:38:36 +0100
Subject: [PATCH v5 1/2] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-fix-tags-not-fetching-v5-1-371ea7ec638d@gmail.com>
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
In-Reply-To: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mQG9UrHc5aJea5xzZtrJlR6Xayk81hLTdYaacfHp7VI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkV311I35K8uqedN+Az2Tx23pxOws/VLYpRQ
 Eb6DyfLa1JKhIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpFd9dAAoJED7VnySO
 Rox/uJEL/1nA5EeT11MwvPkLaEej/KBDhW23HnhXN06DK5HZVgsCYnWWeC/QsXNZGDksJcuwyDi
 VW0E++T3pA1XZJHWMvPnAJqKOwBcVJgBVqT9xGiMRH1mGZin3D4oPqSVF9TPOLmqQaxBPVNqEKG
 HoJcrmyyUCn21plkaZPlkn958q+Jmx44mRTzE60q/kw9ZMnR2FDA3aPFl7fKVqCsNRMZ+ChfZWm
 T2RUsAZfRdt8ovLrjjcj8qRLcxU0oxy8XJgQPLXbehWe/YLyuuUTsj+H3HstsPHulwithkML60u
 nA+4TkQ5YcBQTPBVjE1BN94bGhvnpgSrbApvN9mmZK+qbccWS0ydP/J/B5RqZYDrtvqSIzDxR/Y
 3inBOv2K5IvvvSe5VF8Qb1PQV1mpVXDYDkhUaEBKrLNA625UZ6UUp2JF/JcI2+0EqO3ZfIdTmil
 3FIcnWSnpDrFKpGbg1Bo9K6JWElFBD6xoCgxQLfsyRmEpkC6BiuKMehmxxvzKhkniX/5dc9l1F3
 vI=
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
2.51.0

