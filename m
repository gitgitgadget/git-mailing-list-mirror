Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF821A23AC
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982487; cv=none; b=pBcUkuEgH9g77QNSsuZSPZ0t/5A+MRFL62x3YTSfkTUISn6wjjzY6TV/1KT8aPFqD8vO8uH4VvJPbyE3KKLkV6vkYh0CbxJfjTozoFLwdnJxmdqtalYUlrSALpakgGtT4tiMo3XHL1EUzQbam/PqkRxkM8OiEPtAc5/U+cV8RDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982487; c=relaxed/simple;
	bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3nR3cNYTVePsVa3OUO29FAeunwM6aX0AwRH0wxvT//ZvsC0KljxX99PT4paqgrjcRnuc1YuEs+nSjTDRNDfPiZKi9am0Hf/gZ+APPPg14qiCQ8l/1Tqsnd43wqOKF326Iap7Xf0h5YajgkYAiqemwcZkhLJHIPyFpSwVNuwJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRLmGBuI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRLmGBuI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so766160166b.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982484; x=1752587284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=aRLmGBuIcH/ol/0p4uYLx75DdHCHGeY/AZwvpreQyjh0bT+dXKdx1ow1U2m3M4vK9u
         UmmMs9POElC60V4owSYwIuKVxhpNzcCAKh8ZEvz/friQTbE5Yn8ZqKvz6VbuZSKWJAVY
         ghUlWT95B3AAgIOs4Aodmw22gapOFW3E0khNOQ9btiWjZbVVtmBsYsi4CbZZ43fJ8XNz
         Io7geKZdTo+u2TrYCLgOLxHlA8ElScDtipsojQmMNh8VlQVvRW6fRpN/t1RXfB7CKzkG
         hoejt5ELDwyTU33nrc0Rx+19SGHNEiFza5Ed/1werNVoVn9iNVB/790CmXVeDHgfxR+l
         WaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982484; x=1752587284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=VRapTRzt9FMeG8KrO9bb98FQYTeQGGesaF6BvsFKvwNzUn25htud7PnNbNZhzoiqfF
         bKaEdXZ0jZWuhDLviABIct6GNq19mKAN+gDzycMjQ/Fph4rL7q34cB2Ux2/6NwL470j1
         EvpFees00nR02c5VEAiN73r1/S1vMJKEOd0FCH2uqP9wFPHEYe6A/g9Lg6YxkBQY3utZ
         t5yxRNte6WObgmVWsjLlEEAMft2eY1VUi+R9lrMZdrg2AuPFgSQOfWaYZo/MydFEeZ9T
         HN1oXIz9WsBN32VDhkW8zdJhYrKWhYBWTuf01q+Rx3T7l/rJhRgdFVHiiPNQKaEl/fek
         5MWw==
X-Gm-Message-State: AOJu0YxUZG8KzM9rhKOr28pDOZAyZu8ErecH1vetby9ah0ghtLNnEnV7
	dvT8xvKAlcMg2oLffcKgz0YJtjacC7Ijs5UcVXwla92fvj1vHwFIrigM
X-Gm-Gg: ASbGncvPC7trdJq3Iv3rI7gBktk1GDsily8k5W1Yoy0PgU42mPXVPQQJk7HNbHWJDKt
	4LriOxJ2VanEcfWzXZxz88i0yoH0kW2pKMz1TaX6VmbrZsjhuENSnEMwIEVgS/kcCDh/HD4X3Jj
	+s7+4imJIk3bnQU91DExhDNZK61Ela8ijRB3dOmqnlQYfCWTp78IkzbvgqHhUFBXN2iL2Uceqwf
	yGPoc6OnQU4US3CRa9i6RIkkfdPlZlfV+2sTW0d/D+QXFA9yLGWHoFAV5RWhQAn4NoyoPYAHBTf
	zGpAWjYfKiVqzyXURO0FiM5DIUPZJfxaH1u2Beht
X-Google-Smtp-Source: AGHT+IEEZ2KVPHJ9K6p5Vcx3lz5NEKzhpWFzv4vCyPymim3rqtJ4YZPFYAWLAcadyGd4och8+dtCeg==
X-Received: by 2002:a17:906:6a0f:b0:adb:9e8:8f17 with SMTP id a640c23a62f3a-ae3fe82b351mr1613312566b.52.1751982483542;
        Tue, 08 Jul 2025 06:48:03 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03032sm886575466b.124.2025.07.08.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:48:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Jul 2025 15:47:47 +0200
Subject: [PATCH v3 2/4] ref-cache: remove unused function
 'find_ref_entry()'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-306-git-for-each-ref-pagination-v3-2-8cfba1080be4@gmail.com>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhtIY/t/1lg62GKkvIXp9gTjiCJNCKPLJjvJ
 11hqXRkOUQ4bokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJobSGPAAoJED7VnySO
 Rox/fzAL/12DloBMNHH3XNf/WZgRMfOxr5/LNzRF+igqgR3tyX0M2xL5V0grX9KMUWvhQK/BGGV
 eUvfTrG8FtWXkWACI4VUqPN4+/hAYcbhKlqd0/zT8FbrURT54peoiJyI0NY2Bf/eQHCvyC2BWUN
 /oQ9WN+QnHT6S4t/JyyrNq1dvQgWpKy+xE2lQgN4Yw+h7/UD7MfpNg85u8rDfjE0AsOzVRp4Oex
 RRsQ2V86h9zpZ1JUpSz5DuV4qqXvMklBiO3lgQ475Wd6puYmTxj62XN75cDLorX0f/cnNllL5ZM
 Gnb/YbJzg8W1oXldgmu3u6ZyC+X/s8p66VLlbn70FR5qUppqhg76MVx5pAOjVib2fkNHJybl3Ed
 0AIqaaiJueFDTRYiuiEUzrrZ629JqfXtZxZN01GM7qZ5i5KKYStQFK++i2OkHiaxvqJIj0vizvt
 kZZFJpizq8/nHHXkazoWjraoa/6rAMP+yUv6PdNoRsqUqbZlnbOSzCKsHZwyt0FYk13giS160s7
 dA=
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

