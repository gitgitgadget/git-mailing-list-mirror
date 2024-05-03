Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FF21A06
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740083; cv=none; b=TVPHnoIsBt6YAB5FEFZnkzwn3YKPv8meU19tCfQxKQKNIfZk03DH12Rkr2zdJrFaLLt86ONFzUpoUqtZMuJkuxLJoBgJXgItHzIk02Xj2eIKekJwMyeGTsyJYKTGLZHHdc+y4MatVaSTkX+ddpt9LWoaJSf2/XjnhZCDWWx4Vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740083; c=relaxed/simple;
	bh=/z+GjUanz0VJg8cfRSx5x7luD4TqFaFjagpMOYcgiek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpDTb1kfq4+iYgeixaTWSf5wK5FLGVe6/TMYZqq8Tusc2vXbgwl1VMf4Bg32ZlK6uL6p5qaFCTpGk2kyafT9sTGdW3fssrkHTDkE4xCz4ybc7OSMV5Jt1fFTJABfASgu/Gg2NHSnlUGoVh6e5whwzipVNZ18+YRrTmHkG2M5TIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G95+QaXY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G95+QaXY"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso871351666b.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740080; x=1715344880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FERSfw3Ff4dZG+nIeAH/tJSTfDrXGZVZI6a+PJbbfNA=;
        b=G95+QaXYpql3CbtGLal3jjsQ2GWJ7kRQO2sj+e4fRH+0yMou+76j2Z+JVqnLpnVfCq
         bkmT+XGr4vrJW87wjF/dqoLRmiH7vZ7UuU7dL2i7tSDISiMDNJrEELjGeVvxBv1ymhxs
         4AEhWsDhR1OB4iTcKNb4aEJ061HwhBqGdGonVREiw8mJP2+TMy4ZRy/enWVcRtVY54iU
         0uXcge+1f8feixLHIYANRdPHv7uYxfB5pbcmpeKy5W1HMkxKAe1zk35qrv72yAZm3fkt
         EZVKi3La6kpXuBXE2MnR3fZNaIiAdxkN+yDf3L4X1Jd7EGznPtKVKT/AoSbU2vEJGv9+
         vsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740080; x=1715344880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FERSfw3Ff4dZG+nIeAH/tJSTfDrXGZVZI6a+PJbbfNA=;
        b=SrmgYYOzADqjQcfouX8K5KCqse/tidwQkmWSFQV4Dw7/bsYf0g2vX5pLL/7yGxtbbP
         NQAGCNAUMxFq5jVHnbC+vbicTIigPifLyFh2qLsXshiwJttukkpwnar9ZYoYCRao1DFW
         WCRmVvfrZNwmPL4F7zkn1ZQ5F9yvDxHdHYGAcS6NwgWLGw4f1C8gH26QZ4U84gVgoEf3
         YI6ngg6uYcXzu+oRqhlYTznLtWIe0Wn4I552EsRmZxyDYFnmKhQxCUp7o7ObIyG/u6pd
         sX1pJGxHbQWLBUgSjhZoURCXuMAscjzlXpot0PDZNkNXq+IF/GzN/m5Zyb809/J9AWH2
         zXGg==
X-Forwarded-Encrypted: i=1; AJvYcCUScgG3s7hqUlWCkKMEI9ydsLl9LR1/eC/po7ZChzv9wudDj2OonX52OJoq3G7IrFtUEIwS506ht8fCoFRXGH2J1f0U
X-Gm-Message-State: AOJu0YzPyMvRSCHJQHdxcUejekuiqIYdGlTnfIwUjDG0OSyx+3icToao
	Ja7MJNfxl/RujjMdrUQrdOuIY6hCxydAiawSedfXlPesiogoy1OnXZd+cQ==
X-Google-Smtp-Source: AGHT+IHhJWuKJDyU4Btcd385WtV3tLRaYEjUGflIr9hZyrfuDnf3t56DI/dPLaV/y2SNMFh8/8PJvA==
X-Received: by 2002:a17:906:8a49:b0:a59:9bf1:4088 with SMTP id gx9-20020a1709068a4900b00a599bf14088mr504614ejc.27.1714740079502;
        Fri, 03 May 2024 05:41:19 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 2/7] files-backend: extract out `create_symref_lock()`
Date: Fri,  3 May 2024 14:41:10 +0200
Message-ID: <20240503124115.252413-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The function `create_symref_locked()` creates a symref by creating a
'<symref>.lock' file and then committing the symref lock, which creates
the final symref.

Extract the early half of `create_symref_locked()` into a new helper
function `create_symref_lock()`. Because the name of the new function is
too similar to the original, rename the original to
`create_and_commit_symref()` to avoid confusion.

The new function `create_symref_locked()` can be used to create the
symref lock in a separate step from that of committing it. This allows
to add transactional support for symrefs, where the lock would be
created in the preparation step and the lock would be committed in the
finish step.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 51 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d0aa3d41..74a713090c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1920,27 +1920,49 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	}
 }
 
-static int create_symref_locked(struct files_ref_store *refs,
-				struct ref_lock *lock, const char *refname,
-				const char *target, const char *logmsg)
+static int create_symref_lock(struct files_ref_store *refs,
+			      struct ref_lock *lock, const char *refname,
+			      const char *target, struct strbuf *err)
 {
+	if (!fdopen_lock_file(&lock->lk, "w")) {
+		strbuf_addf(err, "unable to fdopen %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+		return -1;
+	}
+
+	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0) {
+		strbuf_addf(err, "unable to write to %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int create_and_commit_symref(struct files_ref_store *refs,
+				    struct ref_lock *lock, const char *refname,
+				    const char *target, const char *logmsg)
+{
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
 		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
-	if (!fdopen_lock_file(&lock->lk, "w"))
-		return error("unable to fdopen %s: %s",
-			     get_lock_file_path(&lock->lk), strerror(errno));
+	ret = create_symref_lock(refs, lock, refname, target, &err);
+	if (!ret) {
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 
-	update_symref_reflog(refs, lock, refname, target, logmsg);
+		if (commit_ref(lock) < 0)
+			return error("unable to write symref for %s: %s", refname,
+				     strerror(errno));
+	} else {
+		return error("%s", err.buf);
+	}
 
-	/* no error check; commit_ref will check ferror */
-	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
-	if (commit_ref(lock) < 0)
-		return error("unable to write symref for %s: %s", refname,
-			     strerror(errno));
-	return 0;
+	return ret;
 }
 
 static int files_create_symref(struct ref_store *ref_store,
@@ -1960,7 +1982,8 @@ static int files_create_symref(struct ref_store *ref_store,
 		return -1;
 	}
 
-	ret = create_symref_locked(refs, lock, refname, target, logmsg);
+	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
+
 	unlock_ref(lock);
 	return ret;
 }
-- 
2.43.GIT

