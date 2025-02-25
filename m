Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AB25A2DB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475772; cv=none; b=qYkPtJus50+laLdzaz+EanmdvpgaIilenA9P0AvK4t4fjxatHisCfgiwgJ69VUaNhRctrQGv4laeFpj9kMT8jWZuSX2j1pWdo5MLFqvwlhjACMWZd4q4q3zMcYeV76I7T3Zy1C6nYPnQdCvl1qyYgmskGoiLx3QA6JMrxzcRcdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475772; c=relaxed/simple;
	bh=zmtseKdgAQyOS7jHubzK3mQey7UR7niByDTIziqT9k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEiYEJWozPmC9iPBRwoVk+AtRJGCeyPbiPtSavR0d03kmr5/Faf7HH7OwYS6mKL/XDxG1W+tfVlMC8IcpjD8uyH7HIYGZNZByslfAcy7ZWXNwsHUZhx+KRUwe913McRa7p01JcrMHrerJpOtVrcRwVf9vici3eBYwibwNrWjun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaxek4BZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaxek4BZ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb8045c3f3so660572766b.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475769; x=1741080569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7qH/u1enQSenIflRJo/e9Lu4z7mOyPHg8s9g1x3r6c=;
        b=iaxek4BZsFBLokcDdqIolC6nnTyH5NUkhAyEk5T5DD1YHYqAD5jfAtM/5sS3eGwPmx
         MS28Fdw3o7BHzpcnrR+MdV/oNYKehqslyQIKSb/doDiKA2hMNyVEJhw15+BQJn/Mia2W
         MUmU8xDvxaNDDxYoV8uB98su26jwVRN8ITCmT4LBQJziJXxZuSGoWm/FrH3HtagWjqeN
         RKosPgkbnopyO0Wr07Z4OwHRTtmXqvPg9ABU/K8zfPQqubMyEyOAkubTv9uw2S2yo0kO
         AhrKxgWwRjJ+aX/L2it+P1uDxazDldXj+VfHcy75cZj/DI0WUHnR4uhq++PJikiusbca
         S+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475769; x=1741080569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7qH/u1enQSenIflRJo/e9Lu4z7mOyPHg8s9g1x3r6c=;
        b=IdYt/Qq2oqZxMKjsEwAQyShYOIZsuwEBuAabgqQVYBjXznI1LZydzBHxYWLk+scTqP
         6jerOSo0RGjTiDFVGDm0dV8c0ZmoweV7ZBVKOjiUjfaHnJk9ro9TxPcfk3lxmmMvgk+N
         NRZoG9Oj0jMg7/65HFH9yLLDyKVR20cj9vdPIbWS8+tBXO8MZm+1ft92gvgTBNxqyJcD
         ZH4ltTOoz8cMh/vXu0aaa7ygJggDwj29kcuj6Lhwm7TTZmNFI0GBrS9+eceRKZliIPFq
         eGjo7CmafLzenS3xgqqMETB7lrAwzpDhgi5fLE1DiHwCN0yLdnfuI+IagID9WHi2F28V
         xXlg==
X-Gm-Message-State: AOJu0YyDyquHbi6xssG++hZn8gNFQhrT7+dbvAC7zH3XLxYog4sY2lJW
	ghgLbTSXrEBiPJJCQS47z3p46D7xW2n3LdLWVCLBAghEVd704SIsK0sdByK5
X-Gm-Gg: ASbGnctROt1CNdJnRkifPbxLKa+8YVEiPE7QRR0ysM8gJWyw1QZEt8JFgRRy/OQeGWU
	5mLLwJUB/lmV//ygL8H7bhDD2GRwylzIkNtl6TUGASv7FWnOI9PbQFgu99A3jEsjTQDnJUZb2DL
	MiaqgW84EUN7JeduU1cxJMWFscGR6F6/3rMFRf+QRvMMgdvkUHyDOtfy/g96/LVXEdEZBb7f7pl
	0JkI4rhLy3p8Yj5NAanZKDYqUsKIYGYR/rrYQZLEKbgOrBgcmsaWQuofCz0fNCDBUEwhETkv2cw
	N0+OtuTSD+AtYHJxJsPz3PZOR1yMk9MQ
X-Google-Smtp-Source: AGHT+IGybvhe1hLMvOUJOvfyPCjGct4eg07RpaEGMghrxZeozK6/sGEyF7xsbUYKARayemV/ZRkcYQ==
X-Received: by 2002:a17:907:da9:b0:ab6:f4e7:52f9 with SMTP id a640c23a62f3a-abc09a8a264mr1510511466b.25.1740475768723;
        Tue, 25 Feb 2025 01:29:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:04 +0100
Subject: [PATCH v2 1/7] refs/files: remove redundant check in
 split_symref_update()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-1-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zmtseKdgAQyOS7jHubzK3mQey7UR7niByDTIziqT9k4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXOe9fLC9sxjm7ORRpb0PWK8spFX90CZE
 dtzbMCE+g/DP4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY1zAAoJED7VnySO
 Rox/3nYL/jARqVVmxZtgtWQERsFKGWnDue4CqWC1KzWuFap0vnyuSFpma25Qpm9FZSQMgJ4q2Cl
 qjq0lNf+YMGUu+oIEyZoN2pHGSMzx1IL3/EnIWhTu5rHX05a1tlVOOHh1rqpqaBnbWUhkIAo5pb
 At+oS7YDPZlz5vHWWu/sejiwSgJ27gxW8c5B3l2y7AVs+iyqVkqspAj3owT616Uy3/2lFwa39Xh
 GzSe/EaCw5OScueUNLiNrVMmAUmfqZGmfQFKcwxfztvDAOfVeWYtlqIw/gt/+672TiPnLl4UuZc
 bVbE08PneI5FPTxezNkhMZVhIMMKeVEZWbv9FWps/iC3MdIwWKKNf4AKgcXo6YgoN5OqM2P9BIv
 081wfB1i1BcN7FXoSuZ52+6qTtzyl9TH3iHQoZ1ZSe6HzC8i6adcuTPV/qHW++y5twl0QLGSQIg
 /XTOm8qh0LDm5KDiR68N7AsnhLJ1FO2HRqd1nT1BjNocL7BjrntAgeevcKvqABzAFvNkJOq3qi6
 Zo=
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
2.47.2

