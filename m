Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7343446CD
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643932; cv=none; b=RLxnUWYXvDfZKcGGMUPhT/BGLkoLrifQtSglLXUcsG5LFBLQi9MAx4o7U3wEEFNewQwK+NUHF/ce8iV7ko23WnhOXkja8aV6XknYCMuIZO1PX1Y9aEKAL7TD6toFVvA3JouIAIbPsWsevi650vPbgesFIDBYpBnS+XxjWipDsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643932; c=relaxed/simple;
	bh=3AccddzkKkYIjiGmtVexWyVQWHbTsc+dYd/AJ5ZruIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gan+8BJKqS9W4SZX1D/tqtXfEGqaqUmxw5Oo2LXWOpGiAmymdKdJNJPIGQ7Wr/Nrs7mX3k0hyANIqfUTgLxmuF1PqWzIH1UE4aQFx2tP9+O1MN92E3zWPkzzr15Y/DQHc0yAQAT1gAO4k1KOYRDFYeQPPg/GrZmvAHU70hUVzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AftF0+cV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AftF0+cV"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d1872504cbso321166a34.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643930; x=1770248730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5/K4+y2QDz1ZCARZjEFnMOWeaoT/dDw2Jll0Rxd3L4=;
        b=AftF0+cV2DdnpvwsW5tg+PjdUVoB0DKbmS2ilPQPXqsYKChjuGEoR4nBZVAilUG8Jl
         CHasp2la0wglCaFQm3ceWXN+CF6eFM99wCntRf+hD1Dmz1X3jyob+ogl5aMA+D6rYJbW
         X7MVrmptH9/5pdxev//DF4qb0WasaRUDQLsRdVb1FG5/aXhZ7bStrXrPmS4ElNrDFbdz
         igHNHRQI7TN3mD5aU7c9xr3rVmlpqjSsQNMPp5AKYcqtBFgCe7RHDFL6zY9LWfOSCROQ
         QCPgJWyEKYai6j7IYGkILWgoiXqLUIfY9kelNeyl2hHLpJ/Jr/oUS4oVdhe2I0O5wTEq
         qX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643930; x=1770248730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5/K4+y2QDz1ZCARZjEFnMOWeaoT/dDw2Jll0Rxd3L4=;
        b=MrNsAjmzcpxdpCsxb94VDohuzqh6AN53nulxzTe2zHDkcdnlaSIdDrOJDm9Uz5Yooh
         wwIX7EqNM4j8g+kUyy3u33JAn6Ubw7N44IcXV9zcxYo8b/ia9GMjzYZTJom9FEI+iosr
         iFX514r9usLPQ6e8qNBfNM/jPppoGS7CDMdXDnNI54dnN7Zg+FRAnkDw43zb8Jdbxwh4
         /lVZ49k8Kbt7lSNkbWMSdzQzsqw1iFAPD8WSnuwo0V6ifwfs/Hc57HhYZtmtrHQ90aY3
         kcb2EnR56OgQ+d5zcBqxV12TIVP1HZ6ROPyWg0OlWBoQS1VShhx1b5gkfbHlaT6ZksDP
         3ZOA==
X-Gm-Message-State: AOJu0Yy4yq48YFWdRLgWzMaaWlGBSVwzpb0Lb5SAUgM0hLaHoDcJYEEE
	WFh0Io/86y2U3Z05rxbBrLjeYp5NALfd5TmIF/9qknP1fMCG/5r8IWU20lgJDQ==
X-Gm-Gg: AZuq6aKr3BHfwlkPEXn8fGug3x59iZ5e8Ugs0f9buHr7jJpqD2U/bKyYOP88mficK5f
	Atv9/1HrUqYcXq5/tok5CLimIeTOH7I5fyyhds6nV3luTS+30Z67qQRq17hU/T53FVnnDayT2Hu
	+lQp7jEDNSbt0kY+yMFSmz5aJbY7C0SlkG5uL8Y8SrGzV83iCKcHPgKXm40KX6oGw1Dh9GYsn4P
	rozasWTLAoLwanGG2oG/oCw+UYJqdKN2sn4JAoqljNtv44ikuOJKZUZZn4OtrQCAaAbBn8skCMh
	Rb7qSitjtNM4xvFleFq9Ei7rU5hbBkpAeMKOKfm3A6JxvMFccZmXFL1EoXCdAZlLkKtVdGUbOUe
	mkYSMIVyJbS5Mf9QNfvkFNk42V6HRbPtkVLuwMOhHzlm6flCzcanIfQ28Qvqm3iXqK9ml/LcmoK
	7UxDTUqIn4GeW+Xpc8ans=
X-Received: by 2002:a05:6830:6581:b0:7cf:d784:5d6 with SMTP id 46e09a7af769-7d19705e555mr696625a34.5.1769643930254;
        Wed, 28 Jan 2026 15:45:30 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm2648676a34.6.2026.01.28.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:45:29 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/4] odb: transparently handle common transaction behavior
Date: Wed, 28 Jan 2026 17:45:19 -0600
Message-ID: <20260128234519.2721179-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260128234519.2721179-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new ODB transaction is created and returned via
`odb_transaction_begin()` and stored in the ODB. Only a single
transaction may be pending at a time. If the ODB already has a
transaction, the function is expected to return NULL. Similarly, when
committing a transaction via `odb_transaction_commit()` the transaction
being committed must match the pending transaction and upon commit reset
the ODB transaction to NULL.

These behaviors apply regardless of the ODB transaction implementation.
Move the corresponding logic into `odb_transaction_{begin,commit}()`
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c |  9 ---------
 odb.c         | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index e4739fc0cc..0def5efa91 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1994,15 +1994,8 @@ static void odb_transaction_loose_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
 
-	/*
-	 * Ensure the transaction ending matches the pending transaction.
-	 */
-	ASSERT(base == base->source->odb->transaction);
-
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
-	base->source->odb->transaction = NULL;
-	free(transaction);
 }
 
 struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
@@ -2017,8 +2010,6 @@ struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_loose_commit;
 
-	odb->transaction = &transaction->base;
-
 	return &transaction->base;
 }
 
diff --git a/odb.c b/odb.c
index 5b112f2464..332860735e 100644
--- a/odb.c
+++ b/odb.c
@@ -1153,7 +1153,15 @@ void odb_reprepare(struct object_database *o)
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 {
-	return odb_transaction_loose_begin(odb->sources);
+	struct odb_transaction *transaction;
+
+	if (odb->transaction)
+		return NULL;
+
+	transaction = odb_transaction_loose_begin(odb->sources);
+	odb->transaction = transaction;
+
+	return transaction;
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
@@ -1161,5 +1169,12 @@ void odb_transaction_commit(struct odb_transaction *transaction)
 	if (!transaction)
 		return;
 
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->source->odb->transaction);
+
 	transaction->commit(transaction);
+	transaction->source->odb->transaction = NULL;
+	free(transaction);
 }
-- 
2.52.0.373.g68cb7f9e92

