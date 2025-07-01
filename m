Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D102749ED
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382256; cv=none; b=pUOVeE4tlPOhv547wBZlI2gTUx+niAD8MNV7h5nuZ7yCPvAdlkVammaRGG4+PWEZ4ZHKmC7hnvyT2WuR7CnP3lu2KiMjzpfczPXsy7xZyNIFbqLgxakp6k7eW8p/82cTpBOvS0d1kWAv3qExYusWQmXw8J8AZNVm6meXE61o8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382256; c=relaxed/simple;
	bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhRyVOydtP4ytRxXBPCQ/IhmlD/15uYYuJcgH8pB2A9uA9wevse0m5QvbgI7hbGJH73TkjOX0XsA+cVimrIG9y8Qo1iojM/ukQ7DmZPzRkzk/h3wQNYxU5IGVBVx1HqSpIWCbtSbQNEu2SBrf/N/UScaaffuQ8lrWg3wjpguMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlU0wYro; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlU0wYro"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so5568198a12.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382253; x=1751987053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=PlU0wYrojMz57zEmSqmoYXs+/r25zR+LYyEsICUtN6wGjOcl8GC30RAXowhiGSnnm4
         pzlFh5MiYr4KJusunCH0P0//IKrY7O/UN9od158UWNj9MPeRI7MG9JqpVvJCpvHYqQYo
         D0AlBzTxJSxvATNA8p1DEUGilw0VWNtHDv7+6wpmb41Dqf1FajLrraCcs5Ub5bjs510P
         EbXiqlMqoWeUnQ0tLi1sH7INRlCwBfpBZz8/grwqW/yygfB9OHs68Rf0D1liVaLQ5D5z
         5ZoNkwsAt54KWSp/WgmiXEDV3zIxruuktHYchEeLOnIzJQ6BQnZGhRgUhnGbOcEX29fp
         ic+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382253; x=1751987053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=wxrqlxwg7V9q6RuuE11Uh8yOOK1DWYe/lcEZv31qQSf4DslroCdhV2oNZPdu3viIPw
         68BVKX1tWt8qrP2mi3bgz+ANHtppi1Pal4dNibQ0hsOF+TqVnZQsIjduBbLn+tB79otr
         vWZmlkjcT0n+E8OjBC4Hlch2zbDs7+6LEVA/QItVBVy20QuRDct2cWrFELx8GNQJs8hj
         cdyFVH1J7JraR1eHJwrkHZKunRny4atfWj9Ik7rjri4nY7yqW/E7qmR9l0j3nXLTxeVS
         JussD2vFv//GB4l/4n/yQ2r6V4VS/Q/2z/IoxuZz5s8Cxb9nv17wcEypWxHOvwYirKoD
         /jYw==
X-Gm-Message-State: AOJu0Yzcy+QxC3Hrj+WKo0tL4gxNLzfdmI8ZCgEAhTb5c/BY+LIASWod
	0BNlElZJdpQ3lEEDKq0mqj4RhZkobIdMfO0MI07nMHrVY34adOQpawHIh60QRHmJ
X-Gm-Gg: ASbGncuh5o7+sdl91pgZtPs7GwZetfhga/pTiR8eqy7rwqSCOmIz9nO62+iTn4sdm1o
	CqurLBgzQ0HoCwG+R/aqYsZTOrLefbyvy+SHHJ5qqhOCqxdY/A/TbeSYQOLiKo9xsSZ1oU7Wh7G
	760Ld4BoF47y+BiFUk5y9Bv058CoaTZBxY0V8TnsLfCDH9LVsdUxz/l/rjnX12hPSuRMBihipP7
	mEMWFIyqL3Pal43y49OK1NfJv7id2lamjSLrB5m4ce9LwoOGF8trBDIgBBv5U6JV4y8psZUbTaz
	WQcnPF+EhALRqz/lmpJ2rXxfV9Nfd6o8UuXzz3Qt8RRh1w==
X-Google-Smtp-Source: AGHT+IGccQXelQPSp+wDJf5MEMiuOb5QMBOQf9cPiz12ti5btU8wUjzVX6TrxJbVbCU4V28KHv50Xw==
X-Received: by 2002:a17:907:9716:b0:ae3:b532:6fe8 with SMTP id a640c23a62f3a-ae3b532730bmr227875066b.57.1751382251238;
        Tue, 01 Jul 2025 08:04:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6747:3d30:531b:25db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm895472266b.102.2025.07.01.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:04:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Jul 2025 17:03:28 +0200
Subject: [PATCH 2/4] ref-cache: remove unused function 'find_ref_entry()'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-306-git-for-each-ref-pagination-v1-2-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhj+Ofj4vyVtvc1FMPlSgWvVsXVzawB1z5pI
 e8GXxlRBqp68YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoY/jnAAoJED7VnySO
 Rox/ohUL/jArYFNRZTIARL2hofNbOqJL5B2NjRf9R2+w72vSe4iW+DjhLYlGbFGmvgjgdaLpn5m
 OTZxtYA1xlhzNZ3pXEuSUNSt98iV/fvk0fJxAlkhvIGDxukuu3yrQqUJmjz8kzJek0HfCVWqIk2
 A7cj/nEViiKj57Vt4M2bMengJjN1QQQFGajsUHQ3PeRy+GARh9C3hLsLujN4k2bkPxiwobByAkk
 KX7zHbeMoiJbu/vdW3FP2VneJJbdd6f1M6atED051Vsn1h3eN8p54dIQp7PFqvL4NC4622qlpbv
 rHRmMO9b7i1VZ+D2R8w6W/pFnKyb0b/z5WWBZom+nqz5BWmcxgZ+XXSRTNlFW4KIEZPozH0pkcu
 sj9s4wJqeB+eb3vpIlnS+93EE5y4WC57Bi1PZ9hLE0o4Q6e+UXX5GUoPXdJXKFyIvuI2EJDzHJm
 0xELv5IH2Z0haPyQp9VIqzbaoEvtfQ88tldup+p9evPLBUSxrX4S4/3XJ+a1TrR1viN9QcbLpS7
 fk=
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

