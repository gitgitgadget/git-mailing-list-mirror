Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C261F8691
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762637699; cv=none; b=GU/tdDRxWjtw3XVe+eRqqyXRtzCTyNRYMTHiRRH3G1Hn9m/TESIffhfs9U0oRSunZddVq441f2vFjbDDoFQf6afn7xmqsWH06OeInh5YxuVAZvjRmBh+D0VQ1PGaxd73XFF7UzOJqe/urV9voz5YIAPBKV/3Q1O5PhksBLSy45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762637699; c=relaxed/simple;
	bh=tt/KzWowmiZeavsLnwY/dr4yUOJaSMzLPmuux9V0vFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLCPoSZb+M/oQuxUQaC3Ww3V1HkiGpy+mgIrVhNpTIlMUozuQbSxuNNmMhI59HybYUhQSkGUHHax0Nh2nYkGPeBbzqmZVu6I1zQ0oNVSy3qCxRUwHqMajgy9JALiGFbRQFTjpLA3XJjQfNrgUZuwauPOfhdNr2c5fKNFVLa/C3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K48B3Gpb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K48B3Gpb"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so801120a12.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762637696; x=1763242496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCltSNvqBOUTbYTy+R2EnTEblQfo25+BWUDLmh1f0LY=;
        b=K48B3GpbO+ooCyfQMp58/Erg+IFNNXmTSURrMQNoWMFLDOC+/wbPXMU5AD/JoeG0Bz
         6nw0zlM6a9pJspLienbT+4oZXRgdq5Y/9q3bOdqWq0b7X3LjkzzJ/O5OUHDkRYTrVWRE
         9kv5kXc1a0opsmzRaeeLBl+YVavaqvPa59dt5Ibk+TH0O0ewHOvboMPyTLAnNCb5F47X
         o9BKKSvaFqyzFCcxK3CWMCC4DBqV0DBJRLmnrOrsqJxFPzYJHoM43tgEUvUqfSYm/F7o
         nO1/rdAg2vEbE3s2XwoxS2VR7FbdKJx/dKI1jFdcBzeS0rh0ndC4XDc0NHFDpAQNWNwQ
         1Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762637696; x=1763242496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCltSNvqBOUTbYTy+R2EnTEblQfo25+BWUDLmh1f0LY=;
        b=dqwNcikzne10t1RJkcKk8dlR2EcBYGMImUe/7qqf6MKgrsneZI3Yn7fhsdO0vfdVTZ
         nhP7cRrsOjjqNlKx8FDQH3AumvMJN9TYfvUZUiMpedMwX/CxON5MSfrDfF1UJPMlzQ6h
         CS6Ckzxc2Z0Xzp/1VndSd62QrVoHZ82yWEerbHgiuj/BSqWmSDjbZHgWdx+scmLPGX/n
         T2lgwyFRhS2g/8Z7mrEGm+KqmjWWcOt/zkOD3rM/gvqvYUccqwX1lvyKaLZeHaQ6T+bD
         c+RhBEaEGeyMAkoae0bCb99p3QuOXtHpJClx+Yh3DFU8qRjZIMmQ9nYXMVHq1GiUX1yQ
         R5jQ==
X-Gm-Message-State: AOJu0Yyf/d+06tbYcRnoFoCyKZ+74sP5bn1nwRfRIH07KwjjkYNKI10U
	kcExdaQfbC5A0ayjYu9fXkBCDvygYIwB9T7Q5TD+oU34m5aBShwGUva1gvF6obqk
X-Gm-Gg: ASbGnctdQVJHGQMUTiykZTI4wt4sWiWxO8P4iunMKaTDaq7GkB/lV68A0B68s19N8cH
	DORvvbe9yJng4x44bi5LK99MKzcmZTpNz+hNuDZjQ2py0m6AUOtmPWwajw6d/2uJgw8akGNOVBa
	CLjdZSaP+HGvCNoinXzTpYHUz5L2EyTxrsxPP3gszb2mkLTSAMtCCiK6DNx7a4yEgihFTryj9Hf
	2mgB4prb77MYvE73QlhHiLlyt68KJQvRd0MC5/nz1+tigHwW+5mvDagsW7BTiqoMXW9B1cB7Mol
	fQC6lqCJD8PGsOl8VjLECdyrUngp/zrpLTtvfmB5nhb6e4AE7b2LRa9t5/v8dJbMBqlCseFGkY+
	Lv6C31/bRv3oZhszVSme/+vXtVEMCdjdas5SKu2pNYOvQ7M/m1kMr2QNA1tvptrpYtPWkgynISA
	v6gP0T
X-Google-Smtp-Source: AGHT+IEtPwCMqyPUfAEB0M9OJ9BQ1W23njkbJjbivuM1rDKC2yXwefZFvHCguDXw0+fTP6eUZMJBUQ==
X-Received: by 2002:a05:6402:13c8:b0:640:abd5:863d with SMTP id 4fb4d7f45d1cf-6415e6fe635mr2708475a12.20.1762637696267;
        Sat, 08 Nov 2025 13:34:56 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f7139bdsm7403661a12.4.2025.11.08.13.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:34:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:34:43 +0100
Subject: [PATCH v3 1/2] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-fix-tags-not-fetching-v3-1-a12ab6c4daef@gmail.com>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
In-Reply-To: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 sunshine@sunshineco.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=tt/KzWowmiZeavsLnwY/dr4yUOJaSMzLPmuux9V0vFg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPt3qXcGQZSFe/JXPk+VHYUl6tIwvs+unln
 DVJyEeqZbI0E4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7d6AAoJED7VnySO
 Rox/K/0MAIUPV9/fMuhEAh2DhKn1gUX1Nr3mxpG14slFa3FG+WdIiBC02luFQw+gBHLnS/ydAt5
 5U+NZjWYktKbMNvWNc2u2P8eh6jz2rr7NpOiTm6j2NwkOXGR6y6zRaMSv8sgMkBE+4Euj5cy8GP
 XfeQQWD5AfEtHfxw7Rx813MIFx2NNU+ARPxSgzREuNAiFEmckGLOQsIuJAOFaD3Dk61gA+TOm/q
 VgJLwB3ABGyHbNCRTUyhXXln4mg/KViBepvaNM6a7uVLhGM5xBFic64KYfSmQWhMh7EdO0Wbcgg
 aqvFbVa2AltmuaT5TUhlHtmnKnaTyshe3clHJ8nfpLXCD2Nw+SO1jbIqPf8eBaD0R2DLbD0xWLQ
 XGPIhsGCOarDE0EFVFlhqJSYZblRRZlahmEinD6Nhqd5MpIRrU2hP92XjKU/IlknGd4kgq55Zbr
 BdYT84rzeHEHXTPnAS89VFILAY2p3+UbrQqMV445dfvpFketmPPyXrvK6Mzx7oAqANKUVgHjE84
 84=
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 65 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..49e195199e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
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
+	if (retcode) {
+		/*
+		 * Explicitly handle transaction cleanup to avoid
+		 * aborting an already closed transaction.
+		 */
+		ref_transaction_free(*transaction);
+		*transaction = NULL;
+	}
+
+	if (*transaction && !is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+
+		ref_transaction_free(*transaction);
+		*transaction = NULL;
+	}
+
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1858,33 +1894,10 @@ static int do_fetch(struct transport *transport,
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

