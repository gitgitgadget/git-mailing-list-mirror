Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16C178372
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643931; cv=none; b=D0CWYpSsYzew/AzeWtpjo9u8GcdLq1pByzyXOs/IAjGzW9vIwGuoHiqihDGBrGJbnI4nvzUwSWDR0nyYMwZx7k2FSC7Ob1+RnzCX9eRIQDWwV2Rjc8pycZh2PAlaH1T7SIegnwlG/89JDcB3wTTHGU7dwrmWEeciR38fdI9rYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643931; c=relaxed/simple;
	bh=puD8iiVY9/yA3oXCA+sfgVoLiFH/JNIQr74Zmp8+gcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVyZVyanPPnAPF/81SRXbSEffi3mVGSl/lv7iFj6mqEHndFvStSmKteI5wlypCDHt/Z0AlTMVr13uBSTwJzkMmVdaiEAgUEIlxVT00glmg/CmETt3m4yCZGI78KjMck6cBWkF5Ph6w/sCdLuBd7BA+HnOafxhJcdXbQjcVGxr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPIW5xP9; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPIW5xP9"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d193b01c10so133321a34.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643929; x=1770248729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrtGl/2DvkmaIfIGX+T3j8u0RD9LNJx7iSEN1cNnpUY=;
        b=PPIW5xP9I0AT2gNYum2K9zMgw4asmVycH+NyokbnoXpbt8q9pBcK/Bdfc+9kPpXUwG
         joyY+eW8ZNPrYGIu9Sz3x1R3SZzmhCsyQnQMRBmknK5P786dOGpP/CwcCimP07B7Iv8t
         PXOwWsgi/CMEHR9voF6VWkL/LKXLnir1bHIYCPI7x+Eg2Fl5kqKTtl/XNbB2c0mZIJ4v
         pRoongjg4tsK7vgAD2lA2qZxmA/aYebeXcdaC3S0AIETspaEgxDNN6Ry7EGdKDBIevZA
         z5R0gAdBLGGnTjxhvkYJsgrr03PbVg+a+RIsCjvB0LyGcxmdFlp3B+wobPVaOpUq3Tnc
         OkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643929; x=1770248729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrtGl/2DvkmaIfIGX+T3j8u0RD9LNJx7iSEN1cNnpUY=;
        b=VdjuqSQ7tHDBf5kubHz3yBd3ZErbI26ToH0l27U6WjGPMjdnJeD9LNgwR6GuNWlQ7a
         ZbxS+M3Ld1D0ke9zQDy4VQ5gWZP18f9oHQfNO2iJ43R1t6ZlAUGAluRlzviqhWN65RVB
         oDKzfuC6D36Jl13QjGR97peqiO0Ux/jxLO0G1+xQMyMZ+YpcNyy3mbpPhh7WwXmRS9K6
         BzznAOoIf5lC20bm5vvblMojOAL86M5/pKhS2kKXfK3sQ00jd6QLFCmH1OLO/rEhX2Ow
         k9LohuAfjo+XDGXvsf9HbFX/Ra8UR38TcmaCXo+8jCfyEwGLjpmyig920Q0nIaYyxf7E
         wpNA==
X-Gm-Message-State: AOJu0YwW9qrb/fXaQcSqeVv6Jg6wncZpWHl3gX1DBqeo6px3uc29snUX
	8SbI+cIvRkBquENKjE4AjdIRDAsQhLfpwrCUaD8TGTTpjxTza8X/w5a0EXTRog==
X-Gm-Gg: AZuq6aLYv/O+tO/quReMT5Hw2jm9qprx53YIGwB/F+uMkXfS8HPkwe5xRcY+87BjWfU
	4OqW9oPCCY80IIjLYVRwtgnn+ccugIiUTG9AhqWD+HeBIPJzs+SN+G6vYMpfI1zfMDoFmJTbsIF
	yuk90/Bn/xLDM5kPLbjdAHiWISMYEkhP0LRoAs25gS2oduJ2vLBjOJeog/FltLWdowZ5osNDZh1
	gNY62VVKgyah4OvAF8wtYqFghb8zDZxK0UaL4YLc883/bSSkpY3XWan9gEiYgwt0wxoGWpVkEVg
	lpKVd6tVIK9E/ExbrMIL/Ii/HMpjqOxg8N/sN5100b+cxusxifrj8Sao1Lkgx9JwGyz1jzZnwqm
	+bh0PXva36zozVbOhXMF2aU0hddwbiJdafBBlTJGp073pzT092Q0g+zTUczKI9uKRVuypu8pJFg
	UmD3F8fruBcqWjynJZsZo=
X-Received: by 2002:a05:6830:4194:b0:7cf:cf19:cc62 with SMTP id 46e09a7af769-7d1851251e1mr4470442a34.38.1769643929144;
        Wed, 28 Jan 2026 15:45:29 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm2648676a34.6.2026.01.28.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:45:28 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/4] object-file: rename transaction functions
Date: Wed, 28 Jan 2026 17:45:17 -0600
Message-ID: <20260128234519.2721179-3-jltobler@gmail.com>
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

In a subsequent commit, ODB transactions are made more generic to
facilitate each ODB source providing its own transaction handling.
Rename `object_file_transaction_{begin,commit}()` to
`odb_transaction_loose_{begin,commit}()` to better match the future
source specific transaction implementation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 object-file.h | 6 +++---
 odb.c         | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index 196509b252..790be25f08 100644
--- a/object-file.c
+++ b/object-file.c
@@ -723,7 +723,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	 * We lazily create the temporary object directory
 	 * the first time an object might be added, since
 	 * callers may not know whether any objects will be
-	 * added at the time they call object_file_transaction_begin.
+	 * added at the time they call odb_transaction_loose_begin.
 	 */
 	if (!transaction || transaction->objdir)
 		return;
@@ -1985,7 +1985,7 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
 {
 	struct object_database *odb = source->odb;
 
@@ -1998,7 +1998,7 @@ struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
 	return odb->transaction;
 }
 
-void object_file_transaction_commit(struct odb_transaction *transaction)
+void odb_transaction_loose_commit(struct odb_transaction *transaction)
 {
 	if (!transaction)
 		return;
diff --git a/object-file.h b/object-file.h
index 1229d5f675..03f0474656 100644
--- a/object-file.h
+++ b/object-file.h
@@ -202,16 +202,16 @@ struct odb_transaction;
 
 /*
  * Tell the object database to optimize for adding
- * multiple objects. object_file_transaction_commit must be called
+ * multiple objects. odb_transaction_loose_commit must be called
  * to make new objects visible. If a transaction is already
  * pending, NULL is returned.
  */
-struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source);
 
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
  */
-void object_file_transaction_commit(struct odb_transaction *transaction);
+void odb_transaction_loose_commit(struct odb_transaction *transaction);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index ac70b6a099..90dcbca821 100644
--- a/odb.c
+++ b/odb.c
@@ -1153,10 +1153,10 @@ void odb_reprepare(struct object_database *o)
 
 struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 {
-	return object_file_transaction_begin(odb->sources);
+	return odb_transaction_loose_begin(odb->sources);
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
 {
-	object_file_transaction_commit(transaction);
+	odb_transaction_loose_commit(transaction);
 }
-- 
2.52.0.373.g68cb7f9e92

