Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD72D877B
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634170; cv=none; b=cx+0GYCCTe55Un6YWMlZBPzWV+OdcHWw5LyuBhx7A/tKC5NgaMEyo2x5R1BiHbB9hQ75ejhoYcnlWY66n5YAKo6jurVobQrPeOOSBnfPtCMqv5AyUodwIKNoUUHazLv8a7P/FDWdqnawAGWn2CzUZHlWuCnFrxrJ3tapKOoAwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634170; c=relaxed/simple;
	bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUGnl3i1DyfivNLUV3BDFESMDU4hoT87Ej+/xFY0eVkLjfGFs8hctLmy88vADkTzdNjpY19GqXzTtkQAvP8uyYqVw6VQqh3JnfS8uYCPBx7+d9LveLYFPBe6ParHet4xf9hal5o0HAmija8XSjW4nfWUAYUv/7X7bNCUcIH2Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dey4HGVp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dey4HGVp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453749aef9eso3253845e9.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634167; x=1752238967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=Dey4HGVpHeofpd4eaC8nXBEwOOIMXSHdTTTxeyy3Y9qbz+MUQwDCDDFyri5BSYoKnr
         OsgK9OB13dFJZU4pGqpKSBRT2c1cj+iJs/fWXZrcDqgXw6Ne1UdU/cv1LE9Pn2yMxFG3
         acX7m8o/jGwtd/KkWly0zwPkWPitXZE2jYjkNIWpb80YOaw0X7QuSvErBrApvcT2OZec
         ZEiM5oxb2/frVYLld3h63pIC/6QZ1fYor4vzdWBo2KOlUD45LhuauTihnSt28tARoUuh
         2qsQfLPvxaJ3kdIKnJJQbco+EFU1gCJexDaX/JVnv8MG3yaAe86KSd/PTdioCbgaFDyV
         IcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634167; x=1752238967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=SWsByzNT+9GXIqwKP7s1kco+5gNKgOVo8rcTnulfKSS68KKSAtBJDvgHnlA4K25/48
         iKqDNLLFvkyS+1IkBLPEzqKKUlxyAoyTblKKoG+vAs6VrcwOmKQp6BJagawccUTD2gfV
         Jo3Q/PXT6KJsfemusXEiwaki1EcAIbTwb5KAiwwip2YAdAHgNfALSwVIZu86NWhxgd/P
         hciw8j1ZDf6Yv8Z2S4lPibGIhN4zqJ3bAx6yQUip8elJOO8ucEba7aeGBnWby00cNClG
         B+i6mSMKCS5cxbA8oawKdXt9kkSxYp9DbAeHyRTGjjSr1DUsGYxw/Hv2DzXFveB9SPlo
         kMMQ==
X-Gm-Message-State: AOJu0YyicG4Qa6bsvmZGPJTeh2pJLTUa9Rc/JZ6ovOvzGwlyg7ZeoFw/
	RB2kPPEc9kjhchWcRmRCZXQ4COherISLEQRkTh1IhFCiySFa+dxnoL9fX4zNtbKa
X-Gm-Gg: ASbGncvnklgFu4OQJTJEm8bDzAPI0s884hkXOfrrJ5OPAGDpr2xRU5mE5VG7aNhjy7R
	pcgZvBKsn0tcN09RS2fCrbWIeKPKe+Ybx6uhFVcmCkJtWS//MsYHFyTJSQ3H/7nI9habh/T3Y7W
	6fF5uRh9THkR1pnbqk2q0BlC4oVs9Cal6jrfVBt55P/uvYSQhhyJP+/TyjUitvzVxju0WCoSVM5
	ohvAhrahrRBZvIv2zCVwnZrFEKdY4cQLRBGThItR8ZnalUgl+eXa69wC4J3Hpjx9Id/ttyEcK6w
	FEertWg/6ejqHQ6A4MqE601YDOEHEfWGVs51uVQ=
X-Google-Smtp-Source: AGHT+IEvOpR4CynJZrPzF5FV/u54uGDsA4GYwUI5Wdg2KepOmS0A4lNuCtQh9Mz4QtuU+JitOVtJSQ==
X-Received: by 2002:a05:600c:8b6c:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-454b3183873mr22666895e9.27.1751634166250;
        Fri, 04 Jul 2025 06:02:46 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba69sm2477687f8f.16.2025.07.04.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:02:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Jul 2025 15:02:30 +0200
Subject: [PATCH v2 2/4] ref-cache: remove unused function
 'find_ref_entry()'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-306-git-for-each-ref-pagination-v2-2-bcde14acdd81@gmail.com>
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhn0PJkqiQ5GFxSvLR2S5n+7BSYu85/5gHyE
 9SI+mFrer3mBYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZ9DyAAoJED7VnySO
 Rox/74wL/RcsusMwPjnK4FYcAmiEKuUJjjl1IhaXrfV4MOS6LeNAEjeA6wiA7UJh9kh39eRqB4w
 L/jT15zgf0WaZ4lKZIYbkTkaCTzDUUUNKdPH22qo4Enpcgh95b9KHsJjWBgNeijcnaj/h/quX12
 BPSLhRu+WmOMnCRvisnSPyNbYCaHA/2ByqrVItoBayD7aZrYs6U2bF9HF5Q/VOFoh8A+Kz4Oo0r
 aSL561WyREfFhSSjHOsqVuZ5RA5mOWq0KGtWsSKvQxybiEBrxSMskkGh1hv7zHMfROJ6Rh0bS4/
 GMbir2DUy4seacVz7WMONbn8Mzdnwx3grLfKV9zVcCsjdkexAD7IYeS3NgApymyu7qGc54NuFXC
 EFzoheEf7OwmKGfaquEXgVZCvhT6xwzH3RseUdJ9gFEat+r0AwbxNdJKzhs8YDyBhE7y0YTLfdI
 iz7C5mWAd+o2f8+NfFGG37bFqoE2pOE0lVW+8tQ08w/swBKRhF65kxRsbEFBAEIb65X+R1Me/F5
 T0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'find_ref_entry' function is no longer used, so remove it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/ref-cache.c | 14 --------------
 refs/ref-cache.h |  7 -------
 2 files changed, 21 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index c1f1bab1d5..8aaffa8c6b 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -194,20 +194,6 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 	return dir;
 }
 
-struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
-{
-	int entry_index;
-	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname);
-	if (!dir)
-		return NULL;
-	entry_index = search_ref_dir(dir, refname, strlen(refname));
-	if (entry_index == -1)
-		return NULL;
-	entry = dir->entries[entry_index];
-	return (entry->flag & REF_DIR) ? NULL : entry;
-}
-
 /*
  * Emit a warning and return true iff ref1 and ref2 have the same name
  * and the same oid. Die if they have the same name but different
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 5f04e518c3..f635d2d824 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -201,13 +201,6 @@ void free_ref_cache(struct ref_cache *cache);
  */
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
-/*
- * Find the value entry with the given name in dir, sorting ref_dirs
- * and recursing into subdirectories as necessary.  If the name is not
- * found or it corresponds to a directory entry, return NULL.
- */
-struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname);
-
 /*
  * Start iterating over references in `cache`. If `prefix` is
  * specified, only include references whose names start with that

-- 
2.49.0

