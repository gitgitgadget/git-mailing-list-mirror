Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F131635C4
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594958; cv=none; b=IueMj4LphGzHiS3xgf/4ZORSEsoejESISxHn9q515Oh6uyPg6P4z3sAqEesg4ZYuKh3/7uUBMKuZZpDL8WZw/2AMAv3GQjbHEe5pmCqX8xlu55zmljRx1GPP5j7wIPSAZhJoHNdWk+bYSYas9iTOWjHyJEhWK1yQvWxHFwxH4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594958; c=relaxed/simple;
	bh=m5xKXzXalsT5AMV27p4nfiFoeBEQNjh8YFDA3l0Q6po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjFFhS13/Bsbk9NAEo2XSaBiEVlC7h7SUasjQXILrRG5jWhPsCXUuY86rZ/ciEpmIDcszZFeN3JnGXUhmTTLXXbRk59tKYPvU2l50G/Pm1bzf4L1/I5e71VXcVjG9zVbvpP/y3Oi7Oy0CL8wl5iM8qg/zd8WPtRqOpZtqkLpIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uja6AgYV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uja6AgYV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a52223e004dso779248466b.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594955; x=1715199755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6LpZvA3n0HTH5fw5nsszK4Rpa7NXOBj3NMLwPJoQzw=;
        b=Uja6AgYVZ5yMQ1PNSl3db4H+CsgoVuyimy15Q7k4chWSScAffPFsoC7FGPr8UkE6w+
         pB8hSU2Ssq/rMGWDQlmAEHvIE7dHWmxNnMJtIZoD5t2czukr5f+FhlIXZp5NVLkFZflb
         RUe5PfJtU1zX5nkRiqdbTLPSZ4r/W4xMO2sLzT7/dRBCYFhWOP2qIjxiEqvnY57fmWi+
         bEW8UuVafNvpJBlHiL3FqX0O1ubX0xLUse3j8jUSdDeZxC3wNK0pkG87yfv4bLJL7msQ
         6+LOZstQEs8CEzo6VFjhINWM7YYOtKWuDwujaQ1EQSyp2tajijlBQvN4I0E2CLAq0xhY
         9eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594955; x=1715199755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6LpZvA3n0HTH5fw5nsszK4Rpa7NXOBj3NMLwPJoQzw=;
        b=f7nWgK92+nLMv0qptK8i+Ymq4D28IVZAzP0ey5VJ1/eqgIdDZ44KfDdmvW4k/NjohQ
         nseVsIb6cM1L2WnrffLQduOgbE3/N3rv5jcxMeDYRmjYUUyj4aX0PBrKHiEtazpIR0Et
         omukjxyUIEH3/dsDqBD0sJ1y6vy+nuYvyCPHE3ZzU/BTfzOxum9W8hBFtJ/Y55UTjhxy
         lMPIpU/ARQ8orG8z2QFkOxu/w6fgn5DiM2ZLRxYo3Y9ywt+nLxSrQUbcf+qKh21BTmvC
         8NQ0UxZ8IyPHlow81bXQjnBw9w9Dqw2jqheCv0hpLhwp+YZNzxR620b3tme+jNeN34uQ
         huUA==
X-Forwarded-Encrypted: i=1; AJvYcCU59nnVvDE5iaAyUrUbJtqioVDXvRgdosu3dUrz6HnNRGrjn1U3QAZCFcwNfMgf+RxBW5pC0Ws4rLIt7pWlLgrKM/Wn
X-Gm-Message-State: AOJu0Yzc2eqGjPua2T9pVrZnP3mQkbThKn8V9WHhvBgFF8s8o8i7av2F
	+llTwDBPKxNO8nRVTytlMdp/zvl+ndLvv1vBH9oShbVGmen99SOK
X-Google-Smtp-Source: AGHT+IE5X3TkelI7g8kVumnHFjXu4v50j4hRuK6G13SSa6xg7DR7ZoH+5X9vQyNRbfmPX5PGyzbSgA==
X-Received: by 2002:a17:906:258e:b0:a58:db18:3cc6 with SMTP id m14-20020a170906258e00b00a58db183cc6mr45609ejb.3.1714594955192;
        Wed, 01 May 2024 13:22:35 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 2/7] files-backend: extract out `create_symref_lock()`
Date: Wed,  1 May 2024 22:22:24 +0200
Message-ID: <20240501202229.2695774-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
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
 refs/files-backend.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4d0aa3d41..878601ced0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1920,27 +1920,41 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	}
 }
 
-static int create_symref_locked(struct files_ref_store *refs,
-				struct ref_lock *lock, const char *refname,
-				const char *target, const char *logmsg)
+static int create_symref_lock(struct files_ref_store *refs,
+			      struct ref_lock *lock, const char *refname,
+			      const char *target)
 {
+	if (!fdopen_lock_file(&lock->lk, "w"))
+		return error("unable to fdopen %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+
+	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
+		return error("unable to fprintf %s: %s",
+			     get_lock_file_path(&lock->lk), strerror(errno));
+	return 0;
+}
+
+static int create_and_commit_symref(struct files_ref_store *refs,
+				    struct ref_lock *lock, const char *refname,
+				    const char *target, const char *logmsg)
+{
+	int ret;
+
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
 		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
-	if (!fdopen_lock_file(&lock->lk, "w"))
-		return error("unable to fdopen %s: %s",
-			     get_lock_file_path(&lock->lk), strerror(errno));
+	ret = create_symref_lock(refs, lock, refname, target);
+	if (!ret) {
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 
-	update_symref_reflog(refs, lock, refname, target, logmsg);
+		if (commit_ref(lock) < 0)
+			return error("unable to write symref for %s: %s", refname,
+				     strerror(errno));
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
@@ -1960,7 +1974,8 @@ static int files_create_symref(struct ref_store *ref_store,
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

