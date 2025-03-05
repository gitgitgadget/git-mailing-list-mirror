Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66617B401
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196359; cv=none; b=XWNT09XFD3jjYZPLL0E70YTQt+qwKx1D9CnTzUOpm4D9NfWaarV5yOcVtNP2HoBjAGV9jjsJC4/9MlB9BUKiWzjQ2g7u/adu/HchMWlZnDuEHrPJgUemwq/KXQ8Hzcdj3T6KMrHANSpONUYXonj44qbEFsNy8txx2BDY8aeje+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196359; c=relaxed/simple;
	bh=ijcews+R3T9WRiFIz5DXUchs6rSe6Or9l3vjvHuB7SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDKZ1i/oKXrfFus1S1/AUGRiLfjdkxBwSk3SynM8Dx/ghBFkvDkw5RFIMrEw2MQFqGRAS8pvc4NdIrYF003T2c14GZNgx15pT3o8QA+f6vQyrrq+VOIiRDKAPiPUet/NSqJ4wFOYCZjlB15na7Uq+yvipuJ+gI8iZSEsIbB+ASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA/xvE64; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA/xvE64"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac1f5157c90so372805166b.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196355; x=1741801155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwFj8lgbcCEReiZ0VMtFUt5egxOBI7jMsqXr/ycBxS4=;
        b=SA/xvE64EvKT4V+NPF95r4QRgbwHhVteHW61PaTyDJHeTewfaQ5RZeCfqgb5aSdVJt
         GTVrQM9fX5S5+bRI3VvsmKvmxaJQKnlqNtoq4CncaZLfTSL8FbIFfy4lnYJ8de1vUMlG
         KRNYh2UYowDZia6Xwjvvk1MEAizpi0iM0wpFOyvRlVorPSStrtmrRDA0SrKawVRJmP+M
         0D6UTgY9hQ146Ua6HYVV6D8rvjlkupYTtgfc68mvsgGxkBUqZA2cQokKprmDMInZJ8B5
         ysShdVbhWCgMqfkEaeskY5m7nGAQTbFoaRkQWvtK0hqSztX9T3YWxvseB4aOqXeVATyY
         PAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196355; x=1741801155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwFj8lgbcCEReiZ0VMtFUt5egxOBI7jMsqXr/ycBxS4=;
        b=GRG3fRY1rv1rU+4oxHwGokLj1eKF+73lEu1jPtbs8h8+Ca8de+fmPXd18fNmuWIclr
         may/UThIHllmVnLvPUwR2MB5FlJ2y6d62mZiVAOeCLiCpyMljd856ngLRo68YPVtw+A8
         Zh1FmY10aWZnj22Uy3mZVLidKcrcSKXukv/m/D76qE9uQ6cMOKcHTcF8Ol1rx+IDnaD0
         KktqsqyAC9apQcs0KSWf9S4vp6N/hzVi2V2gSSmVHUYqMCVBgxYD5Qr+naXp9Q3kweXv
         D0cW/+F9COjT6QdE6AWml8zHm7LRLapuMQBs92cGceMc7/FIL3UCPYx9agdAh8KYtc6s
         nr9w==
X-Gm-Message-State: AOJu0Yz5X+z+hIH8ijCV4VZcRoYP1N9xdw7yDQUrJFbEAuCu+Ginu8Us
	LaO/VEQJ4VdltI9S8R3yo/2Z4ff5PorM1n2QS4sSwKrtPYRmAOUJHWxzP3EG
X-Gm-Gg: ASbGncuRrEQGYok5Pu8UFmyJGo02iEoOp0fGtWYRj/HeYAb5o/8dvKBPUIRC4qrTDnF
	690csAq1DTeK48B/V1NcdHIPUtr6DZUFb8cDw1+8cxwjfEISNQ12jYQTebF9dNCp4vkgIPHgl2g
	j1iXPWCOHYiR8yTwz9PNS3Ojx2ehWkXe6i2r0/uFqfrUbZdMXZ9rJ0C04JtVJ03vt0wf0F1+FXm
	XHT+8MM+oCpD2c7X8NV6Y8k4AYAzDgwrRy3dAsyBv5RP1clwZt/05UfNdgcpogKaCf9PD0Jn6zK
	RIqBvG438oLzz6eWJDpGldDmufe+MbUl6qf1sjtClOGmYva9KQ==
X-Google-Smtp-Source: AGHT+IG1yI+itF01Rstu97McQMUdpHIgmV1oToWMdrAs723M1RcG+xN7arvVBwVsZ6RxcppNOtFglA==
X-Received: by 2002:a17:907:6e92:b0:ac1:f759:f9e7 with SMTP id a640c23a62f3a-ac20da187b5mr353594866b.23.1741196354965;
        Wed, 05 Mar 2025 09:39:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:38:56 +0100
Subject: [PATCH v3 1/8] refs/files: remove redundant check in
 split_symref_update()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-1-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ijcews+R3T9WRiFIz5DXUchs6rSe6Or9l3vjvHuB7SA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEB8VYlcX/44MtlLJQXQFWuhyioSttenz
 1QZu7c765c6dYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/RzUL/RlWbRQ4Cd0LDUJy+I6Jl2GzxPoVfkvLPWhXnS9ISRKGoLpw+aPk33yRUPomCqaMfzk
 Qtj+aj537OGfW+9MGTZajM3WtYDJNW2symJ8cMi3NjKUsq0boiFSKYHHjInVIzXa/yNtzVA7Yqx
 JAPfZkyF014ZpGLxN+ntnWCcOlJ1UeptOHxSvOzzw7KpK2EpnsUYjJqSWnOoRYpyvASPd7BSNIR
 Dau325PlGWOLsjneJP5OaOYgVH3hHzGY14rpmDiTvpITwaOoqpLOVSQ19idGTYf64Ew1PDgcMsW
 MZkEkmfuKDePhl59mjpvvznlk3qQmGfrh1SlnTd4lsvyfc7iF7LFKVvTCKITs7/rx+7UT3Gt9LF
 lvC0oNObu21rByqj6sckTrGdpzq+NjWwS39d36hQaF9fCqRpAq6hiq5guHrl+0y8Y8RerAm8SnU
 CjP0Fh6DZtgwSRjOwtOP76dH8xM+Fzv1Dx0k9/NLP3trBrUkqRFJwGUlIxtqjtEPgPCTdKqMz75
 qU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In `split_symref_update()`, there were two checks for duplicate
refnames:

  - At the start, `string_list_has_string()` ensures the refname is not
    already in `affected_refnames`, preventing duplicates from being
    added.

  - After adding the refname, another check verifies whether the newly
    inserted item has a `util` value.

The second check is unnecessary because the first one guarantees that
`string_list_insert()` will never encounter a preexisting entry.

Since `item->util` is only used in this context, remove the assignment and
simplify the surrounding code.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4e1c50fead..6c7df30738 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2382,7 +2382,6 @@ static int split_head_update(struct ref_update *update,
 			     struct string_list *affected_refnames,
 			     struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
@@ -2421,8 +2420,7 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	item = string_list_insert(affected_refnames, new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2441,7 +2439,6 @@ static int split_symref_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
@@ -2496,11 +2493,7 @@ static int split_symref_update(struct ref_update *update,
 	 * be valid as long as affected_refnames is in use, and NOT
 	 * referent, which might soon be freed by our caller.
 	 */
-	item = string_list_insert(affected_refnames, new_update->refname);
-	if (item->util)
-		BUG("%s unexpectedly found in affected_refnames",
-		    new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2834,7 +2827,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
@@ -2843,13 +2835,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (update->flags & REF_LOG_ONLY)
 			continue;
 
-		item = string_list_append(&affected_refnames, update->refname);
-		/*
-		 * We store a pointer to update in item->util, but at
-		 * the moment we never use the value of this field
-		 * except to check whether it is non-NULL.
-		 */
-		item->util = update;
+		string_list_append(&affected_refnames, update->refname);
 	}
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {

-- 
2.48.1

