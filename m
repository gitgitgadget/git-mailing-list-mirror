Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53EA22092
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838791; cv=none; b=D11qylLGNF9ir48TL6ulUiu1yZK8A2x6RjEuCAtWHCsDMsqXdXeMYFGesmCZgfsKErCyCiCIItJoWYBA5yO3GbizNQiH+AkuYW89gMmXz8TwFQLow08qtXABO4NvOQlpN/FM/3ZrOybSSJCTJ4sRIyO1vARniDCii+M7nwkKsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838791; c=relaxed/simple;
	bh=tc03nrFtENB78jrwmplH0WghzWwpiUozx0fmTrV66ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuUxGrS1CZNRkh2c0tVMgYT5NSK6ZA6gxFgPQaZU2b251kyO+PLA0dglGoVTqWKdbvXhiD1jxyalkv/enkJG4tZZ7H7JEeU6Yh4H9uK4DRMFDVpT8C49/Hf5Jv9ZyTlpRl5qPB+7SPnQGHrEWToA+DRdzbqZ6B03FhxezWnCa20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVowbYx5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVowbYx5"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4734ae95b3so381568566b.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838788; x=1712443588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbOEcYQGUM0QssVKyJxX5uLcLqMLVykNZR5bim81GBM=;
        b=GVowbYx5PPL+wE6zUJ73sAkLiD4HeC6l4p6/wYxE5MruuI3PRBR7Cn6GV1hU37n5vw
         X6KxsFiw2sJgC/bd5UG+98XBViHaUO7zNLJ8XwvaOuCDE5Sa+C6we9BzqyvIzFhJRwXo
         RzsF1G5n+1nKuy6U8m+sigNFXJX+OWVP+Kg0TaQBFeK6D087kkCU3XXuqRXjnuDVhHmQ
         TAM4rEjlTKmiVY6RPKBqHUabXOYqhI0zjjQb2W0ldiBtNlRy0IqqO2lJB2DwQgmolupP
         /m6ysZHAflF0NaWHMvi5/n3NslOt0o/mm3HZWxWqyRmBTe9YvzLkjzjYFR2TNjqmmvEZ
         JK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838788; x=1712443588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbOEcYQGUM0QssVKyJxX5uLcLqMLVykNZR5bim81GBM=;
        b=P3dD1N0V0RPG4pBF2tyTENa4BwRULv/Xjq1kUPRFjvcOWPoXaO1Q/TAAGlU6bsikHY
         XOg5CMLseUNYS9Rw3jTB6tCziOua2ibFZzgdOxBtHYhzsbYu59KgoE0UrJ7YYcrroO2b
         ArGzil5kJxBqY0dRUyitTlaQNTiwWykTvXb1bRMpBRdK999d+OkF/U3KWEWNz/Nu33eI
         dJk1iU2FnJxeFo+J1dpRunL49ftBwngc+tYQoFJISXW2gUKuvsNdtSeYB/Q9TcMI4AiI
         wVKu0QvXMW1Yv4MPd2BojQDPMo9vSGy4j22xVrAnjF/LT3DTYisqQUyxY0eToPgzDIeC
         6cmg==
X-Gm-Message-State: AOJu0Yzr4hi2pDLPJQ+HJp/NQdy9HT1xaN/ednCXCXBIQ8XadZfCaPg3
	FvwGCe29Nm/bNjiQwGESXvpdxYez+qWZWPFQ/FPBS1lkXxYU6mtDYB8KqIbGcY4=
X-Google-Smtp-Source: AGHT+IFkcQ5h3FDHZNzm4wIBvcfAnbRuI+nDRz4qGunUEl7SNRJP2kASGsdVbHX84ugWOwnUdWdI7A==
X-Received: by 2002:a17:907:7da9:b0:a4e:5c8c:8be8 with SMTP id oz41-20020a1709077da900b00a4e5c8c8be8mr343136ejc.29.1711838787617;
        Sat, 30 Mar 2024 15:46:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/8] files-backend: extract out `create_symref_lock`
Date: Sat, 30 Mar 2024 23:46:16 +0100
Message-ID: <20240330224623.579457-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The function `create_symref_locked` creates a symref by creating a
'<symref>.lock' file and then committing the symref lock, which creates
the final symref.

Split this into two individual functions `create_and_commit_symref` and
`create_symref_locked`. This way we can create the symref lock and
commit it at different times. This will be used to provide symref
support in `git-update-ref(1)`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea0..3f0f9521cb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1920,26 +1920,39 @@ static void update_symref_reflog(struct files_ref_store *refs,
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
+	/* no error check; commit_ref will check ferror */
+	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
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
 	return 0;
 }
 
@@ -1960,7 +1973,8 @@ static int files_create_symref(struct ref_store *ref_store,
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

