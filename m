Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA32EF9A0
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250728; cv=none; b=XZrFvuQh28E7m3hdejkDMsAt+eA0nZfyONyt2oE4FDwIcs5DKROx+i3bTTzw+KmuTpInqOIzj55yF7LyzJHM3EcsbPvYEDew5XjQU8CpIywhaSJ4Qr3ga5eUOkBl3WRkRIZ+bbYtYwI9UxVo6RBWL9fxg7QexrEMxjo9Ih65jaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250728; c=relaxed/simple;
	bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGW1E201RQKpD7DcRdvIQn4FzPdKARDApWxr38RBViMULTADedVRl12cQHVCUSvTct3l9yMkwb1SD+Yih7QsKKs4cQKoH0gfaR7wQweWD34e46oOEpLdcqX1FUWsJDnrhrA3dWVT76SRt0VNC/07wuxjRFF8Irqu+bSh5ipm87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwKTrLLJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwKTrLLJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso24063455e9.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250725; x=1752855525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=EwKTrLLJBYKKG/Q/bL812d6cm8eoBXOLSZiqtt3MM2+6QHbDaRrY+q/D9c74wEdSKo
         m4026Wy9tjkqlofIIqZa+/tFh0EplJ/z+emBiX7UQRV5nHnI5LfLrWCFhKyN3+3h6h5/
         am6G3CQOFoNBvkfChZCe0TgWUxX+E1QblNsObTsoDeCRMHbhq1TcJnLrgQ/WudxrjyYv
         QWjHTmH/JHrXyfEIBiBi5XUIGZn5TyvUA2vHzHjtOJrFdInd5FCJT9yJiTITAckyJ7J5
         BumK2SILU4jhpVFmlODzXQbpaHzVx9lq7wAR/yx3EWc2VXj9KhtMDEA2PqAcNDOdAzFK
         82YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250725; x=1752855525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLri1x1RWM2iQxYf7CUsMZb+hvhExwc4qHmV6RAYOgI=;
        b=sLZ6mM9/q9lVYp8V/l8Xxj+Z3cXrL9EQYy2DjMmk3CxQuJ7j6PR4DanIRUmOYYPTZs
         yVjwyvZUAjbUtIAKG3TBIjseAgUvcpqZE2FBT03XH5G12kfeL0/AOZD8cNR88x4Hv5za
         WSOon87Fv98RO1SLkTi5KslBUrN4Kxf67cZ6Ir5/pzijSwaIefx7JtiZTsWk6DyB+x+0
         bDqi0ny0SO0OdDp1IA60pIWX9KR08nBYqji5L+K4Os5/f41bKWnXcgl5zAnoQMa/z21i
         hd1YkEWB+yxQcFArtigFe8PnWK4AtL4KtXjZ3Hjzmz0ENjWPpEGyj+GF8E84mQk0upUy
         +iAQ==
X-Gm-Message-State: AOJu0YwipdthduN5LvejzqJfINLw0JVb2JxugMappx/W4GOAYPa3Ek5Y
	uSOV7d+XcJqYF0PcQVBW8qvWYQ5mnAZT4CaxLwG1uFRhltNplueLh6og
X-Gm-Gg: ASbGncsQbtLYAsjQeH6SCxhj/dc8KHdjqsHDUJga84LUTBFdomcuyCIjEDhxqUeAPVK
	jttLXWMTDaAKuj9U1gpC8hLELEfBdL+oU7wx//sdEQFWRxWBUCOQUSLPaALvcxIyCCbMBbNlpsn
	oGjgxB29pat9rGAfK+MJoKHxt+s5puCt2py+XmUa4GBTd5CdNhSh61oiMap3V7DlWOi6Za0d80p
	pOPOZWu90qI6Jn1DBByCv+Ma28rGr6Ir9TG3ako++iKTR8zFfxNViXvnQmqBsuNjLPnzwekBxGI
	Ws3CeGWMvWlKnAkiS5tbXaM9c8aTwQvQSxh50hp4GbYGNuzVOJxwcnVHGiRuu4PdGXgRG31vYzN
	rBDPEhQ==
X-Google-Smtp-Source: AGHT+IGxwlc3vAqUvk4CMVy39EoEyuV9SikFK+5OGHM4mTjn7grXFGvsFie0D/8Urwnpxzez+yZD+Q==
X-Received: by 2002:a05:6000:4407:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b5e7f3c298mr5574211f8f.26.1752250725023;
        Fri, 11 Jul 2025 09:18:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5049:80b7:8726:cf1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm51293955e9.39.2025.07.11.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 11 Jul 2025 18:18:38 +0200
Subject: [PATCH v4 2/4] ref-cache: remove unused function
 'find_ref_entry()'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-306-git-for-each-ref-pagination-v4-2-ed3303ad5b89@gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e/I1oMnIlm83XWqCbtVMRQyOaIndMjZ7XnA3zp1c9rg=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGhxOWGiXQkK0hIs595gebteF5Ysd8PeyR6/GN9kq0qu28/7q
 IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJocTlhAAoJED7VnySORox/5/IMAI9J
 BPy06brpXPf6MhP+PXodL766URAkAWVC7OHjK2N+U94hmLN5Kdy2Lb/6f80eP6T5F+J7q0Vn2fx
 MUzFcl3OLsRGnbd+Tb9nn8WpsFySA7WSHEcgbgtnGFZ0V7Y+f0NFaGvBqvGn4F0KNnICv9A7UGB
 IOuhJGf6/nIwqYCuj/iddiutSrMkuscKutMlbSAtyhVmWV2K4N7W35YwjNLOv4tjTJCCDKcFgnJ
 OUwOeJjfoJIW41BAVAsv4N4h1gVWPHxZXyrOSsLfxYpVftWMM0jfDAw95MPi+qv530UFx8n9rb7
 wSDI2Wb7qU5/Ux2BCwry3CKuGLG/ruBwZcamTVNRv0xN/G+/+bec32bNfCqqPNZlAU7L4wpymaI
 eH+sAMwl/lKUho7KZSGEXZZGDRFcUsjCXG9s60gSBHhUPM7uvoFv4jbwvFkNrw3DOvd6f9/sNIb
 CqChOrnpDbGu7IEzgBo77xrEeDLJgoGKyMfuCg7HwQ3sINqWu5YcU/SPr13w==
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

