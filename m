Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928A221F1E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471053; cv=none; b=CbQWT9f8aGNNqfq7wB2LQFC+t/vl8ryyJQGPqK/Bap+LQ3vsF0csbe6y0aaYh6Fe9ps+tWp9VG9y5i9LPTYtbxJuzcxkMXiEbK+QaMxMPNiNgzs22tk8LrDUi9eoJpZkwEn7hF3GjAACWGwJ+NYhq58cgjjFgefjm7E9fCk+W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471053; c=relaxed/simple;
	bh=kZ70MrCGUroWDhuT1VddEBHL0jAvn9zT8Ss5CAhni+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0tSB4CS4UCIPqctBhgvKx0o+MarZXYhbJNHX8ndoCs4LutI+zB6SPugRZiIRB2MnHDMlXTyFY6+5tE2WmjlrgijV7KBlW5f+GoL8jmCqnw4j47OQS90Uabp2Y50q90EcW4rS5nCna69ny6C/9BTxMC3RNNOHsqr8b3/wBhuUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXfQWkWv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXfQWkWv"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3b12e8518so159410966b.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471050; x=1743075850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJGJOGebafCyIR03LL6CzEWPuA/w+J7tebiTp9njyX8=;
        b=NXfQWkWvmzB2ybzX6kYVzvv71/og5wpqGqlIzVj+57u88rmY0oQfmJyDf/7BizjRmP
         iS4BESgfQEAjtMWAD2j22k0j9UBEc1A6xIaDx13yXlSnK8OL/2wglPh0FkWAlueZcbIz
         UfBADl+EPB0+2RV2x8e7Uyb/F38PrvYRf7GUgZD7PTBrxj2VlkruhGUq3TJLnkTUM1PR
         6y16p0H0FJkUO0dIOGi28EK9tO1ilv315/88lKa+kPCRDTIMA4YCpBSCV1sB2Arm+oQV
         upSaof7lxD75QPx4dXYqg+m1hdG/ngOJaojLfazTjsWVRPAXq04C7Zjr1OX+gzd1d8YV
         83Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471050; x=1743075850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJGJOGebafCyIR03LL6CzEWPuA/w+J7tebiTp9njyX8=;
        b=fPc/SLDHGwGRGy5a92SHiBRqoIjRMm2n1Wiwr5gPr9IWePPRKlrlcUdlrunprAiSX4
         aclNp48FA2LuoYfVAf17eEP6ZwZgmd0TAAf20Rg1gjRrokg2lhSvuymGiIuptPzIrOFQ
         rfa2rn7oGPJwZvL3rL6qiEMyFO9nPndcCWalFOAbkPpUQm/jI/Lh2WtbjKUkXzAN2NnC
         4j3a+i5oSmFRU9JTpYYEyhJQ1nAT/zWK5AyDwvFAlG554kRfd9RLbHOXej/I1UFx8Fof
         39JJpGbZkIbAY3LhNj8IVaAa2Fz3qx5VgyoRUyk6TgVjDdQ2w3M+NZUF1wzlSM5GjaqO
         naZQ==
X-Gm-Message-State: AOJu0Yxc4SGVjaD7yD0gNGtn5DdB4E7tGFKdeEGiTQtvXDb5nUZ2pjYH
	NKFZGYs54MdPyc+5paKz4yRIvYazWTbvjaUltpekNa4SUg7e1CIm
X-Gm-Gg: ASbGncvBByom7h/apiq0/pCNV0nOiqRtAebx8yJWAmOo6nq9ov+4aLzbo++SNqsyzF3
	80R8wu+YtXhfFRBotwxrW5HEC8pcsjzdOOlehyWUJEWetZiJIZEv1Lae9ToGXEI2X+bhDTr1UEp
	qSYoE6Zxh+fC80LstbJ0DXXilK7APSZv9kHNfA6xk6jzUBSJfIRgEzVRpU30ZLJ/53q9NAQyW0f
	BhcBsqIAObfoLwJKK4oKC7wnjhh0vgSzggGz1PQdNh/jQSSOSgq3S/uMl+mxiVwKnjFPPqozOEu
	XjOIgaVlTDsgHwxfczlZVIq5Io0s+PjDibkMDOCnT8lpTyaO8jPTeNYx/a+Hzw==
X-Google-Smtp-Source: AGHT+IFPkS3DQacAqKovVTBA4CyJThEVEfTGbRlWfFxkDqU5xj1Yx6RNg87BBv5MESBXIjdEwvflMw==
X-Received: by 2002:a17:907:970a:b0:ac3:3e41:d804 with SMTP id a640c23a62f3a-ac3b7f6b7bcmr690648066b.41.1742471049881;
        Thu, 20 Mar 2025 04:44:09 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 20 Mar 2025 12:43:56 +0100
Subject: [PATCH v4 1/8] refs/files: remove redundant check in
 split_symref_update()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-1-3dcc1b311dc9@gmail.com>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=kZ70MrCGUroWDhuT1VddEBHL0jAvn9zT8Ss5CAhni+A=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4fPEkwsnzRvf9l9VcCzC28gJNlnIv02H
 hzuxF147V9S2YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+HAAoJED7VnySO
 Rox/nCAMAI5z4Ym/8HiFDykP63t7OI8zS6xbLQaBLmzHCN6LHJyWmnGgIKmcfpSXxZV6yrB7WKy
 l7u2WA2da8kMtMIYDZKOp7L5PpYs72OAr81Sh4b8jYpb1Zr6f2alqQNfR3VPXJl2Srrja8brSSx
 masjJ1b44oVh2tY4f6MzDP3PJuOZLJTk+RDOx9svgZRpULougB6P+NnuPapjCGWMFzvD9WV+h13
 slCfZu55T+wAG0K2Oea/8art0n4BQfBZ0PTaoo6jtZnPVt+MSSvlJVOnvn4P7aNI13YawmkoWpJ
 4XWOgIWsQakD55BSxAmQXqnOL3xiSCMhskZP0c43WqqzMnplYmvlRpJzs5OIbKCVUpyj0gk1qvC
 KVGd1cDR7orJifOyf7ltZ8PTOF+m5cQrYc+QajiSgjz/We2TajEr9cn+PkZ3yDPDm1vXnKRt8O1
 jMEPmdMqgvTIf6tGroFjG3uhrTvbBADpyeA7weFFhS2v6QrK4GNIMntrJuL3MMb4gjEt8Q9Heo7
 3c=
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

The `item->util` field is assigned to validate that a rename doesn't
already exist in the list. The validation is done after the first check.
As this check is removed, clean up the validation and the assignment of
this field in `split_head_update()` and `files_transaction_prepare()`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ff54a4bb7e..15559a09c5 100644
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

