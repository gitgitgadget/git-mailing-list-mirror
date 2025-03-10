Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5C15B971
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635135; cv=none; b=orOir1K17oYk9L5ItYyudY/XDEDyJV7onXvoNp/VVXQE1VStBn1rOPqi9gOJQv/a49EGzAakGZ87oVtTZV9qhdFUyX2773aK3IfLqd/sPVUjoRL3vgyZbNFtgbi2V1MOCADQ5EJZZe5sB0PVNaH570ERIHG4DNEZDsvx3xu/Yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635135; c=relaxed/simple;
	bh=9Oixtf8VtLt11mtugwndN5WDyIGQO6bIWKsWs5kuz2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETSYCloXaCV3Kmt11K+X/8N10Jt5HpjygCh2wVXaXuR9y6r4rrKL6X8it32hsrEM2u0BXIX0BWaXAT2q4+Chx0ydAzLyrE662LtcTxPF57u1fL23flv8hoMY2lKf1/xUYpNS7O1dO6rnOyx4FD2pVkvRyDcb8589YBuNotiztRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk7O8b7M; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk7O8b7M"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3d1280f3dso1276954b6e.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635132; x=1742239932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=Dk7O8b7MgwQNbCcliVoQSCUHgd9CFBLDcWy5miDLPEJ2B7olbAEReUouli1yabceTW
         mHKy2x4PRlIAD6dJThqGCINrAYOhntBrw9gdKubxKOnRg38ILosFa9GVDYjCBuUeQ6j4
         I7uE73LBTO56mzh5pJeF9qjaytWUzqjGUv0OV8fi00Etc/vHEY/voTGcs6E9EUnCntg+
         WZgC4/X/65VbFwA7Rcm1sJSdTqvAlkRsbQTYZPG559IzfdXcLL1SNdafm7RQcrsZ6DoW
         lK2oMxFbq1+D1H4mRswR6k7VYmuxdBsFGj3riHoFJo6PgZTawhUonKSP1L6/zWZvod/W
         9pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635132; x=1742239932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=MKe9PK5Scy4Z2hxh85fkP04j0+T6a6QM9yrZaW8tKsbLlofHgAlGOsCcFiXwBFZufh
         ZEEZs95YeZNGWGqFRmiVfTIUWWvumGFCYE8uyIou1EtBxOkcAxFheNTgQGc2+vuW9fZg
         oQqkl5VsPShHq5N+6rowL2qQu3DgwPoxEOTOfnt2cmAkf0IVUOi53Rq4EVDvN6BcTD8S
         EHji0FstAB8cb1cw5nUlrR1OO6n1VCi53J+Q6j4n2aybB0U2HvgaJ1V5fxKAXgOe5kI4
         CnUhApy14t8DHD2AGLozo4AMj+dzD915GHem8qe8e6ntty3x6qfZdzEuBVmZMC7Z7d/U
         /Q1Q==
X-Gm-Message-State: AOJu0YxO/CRgtUibyZ5WpPet0wvDdLOwWDD1EiGaA8+KFMRv64XJDjaB
	kiG/rsnswi0VljeabwaVcga9Z0G8CkyogMhgXdEjnjM2sxmyP6xAzZKNMA==
X-Gm-Gg: ASbGncv7XKIie2Jj/yC4sBjC1RJ/KJqeHyf5I5BLlvXy7RxiDmqpiIsE1NcBNMKN/XH
	vRABQeLC4ZRCLByixqvz2Pf4EmauSQHPJGssWQ9A6rw5Bd26zSq4Uppd277S85laW+1GUSOM+zS
	Tv4siKUBHOcsY6tjf7LbDhpH0kEcrYoibX1gY/8WKZESYV6GErPlxlsoWinH2mtwAJdT9gG550R
	/vo80y2tMpclNPkyuR6g0iiSRv6hxl8n3L5XqLMw6IUHZlcNZgTEheyKIrAgte4NX1leIAgMvhm
	inBVDkj09zLOBLxFL69l1XQDksdmkVEqLjgoQNj5n2t2Oga2Q9g+Ff1UucDsKww=
X-Google-Smtp-Source: AGHT+IH8JyXc1dCfDVbBvN3kmsnUt4IRkDiKIOD0mkidD1GAUIsy895n0NxGow5c4hgzgmtReyqVOQ==
X-Received: by 2002:a05:6808:2013:b0:3f9:c668:2cb8 with SMTP id 5614622812f47-3f9c668319amr1253080b6e.13.1741635132516;
        Mon, 10 Mar 2025 12:32:12 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f861f30de5sm697819b6e.46.2025.03.10.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:32:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/4] rev-list: inline `show_object_with_name()` in `show_object()`
Date: Mon, 10 Mar 2025 14:28:26 -0500
Message-ID: <20250310192829.661692-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `show_object_with_name()` function only has a single call site.
Inline call to `show_object_with_name()` in `show_object()` so the
explicit function can be cleaned up and live closer to where it is used.
While at it, factor out the code that prints the OID and newline for
both objects with and without a name. In a subsequent commit,
`show_object()` is modified to support printing object information in a
NUL-delimited format.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/rev-list.c | 13 +++++++++----
 revision.c         |  8 --------
 revision.h         |  2 --
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bb26bee0d4..dcd079c16c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -357,10 +357,15 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 		return;
 	}
 
-	if (arg_show_object_names)
-		show_object_with_name(stdout, obj, name);
-	else
-		printf("%s\n", oid_to_hex(&obj->oid));
+	printf("%s", oid_to_hex(&obj->oid));
+
+	if (arg_show_object_names) {
+		putchar(' ');
+		for (const char *p = name; *p && *p != '\n'; p++)
+			putchar(*p);
+	}
+
+	putchar('\n');
 }
 
 static void show_edge(struct commit *commit)
diff --git a/revision.c b/revision.c
index c4390f0938..0eaebe4478 100644
--- a/revision.c
+++ b/revision.c
@@ -59,14 +59,6 @@ implement_shared_commit_slab(revision_sources, char *);
 
 static inline int want_ancestry(const struct rev_info *revs);
 
-void show_object_with_name(FILE *out, struct object *obj, const char *name)
-{
-	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	for (const char *p = name; *p && *p != '\n'; p++)
-		fputc(*p, out);
-	fputc('\n', out);
-}
-
 static void mark_blob_uninteresting(struct blob *blob)
 {
 	if (!blob)
diff --git a/revision.h b/revision.h
index 71e984c452..21c6a69899 100644
--- a/revision.h
+++ b/revision.h
@@ -489,8 +489,6 @@ void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
 void mark_tree_uninteresting(struct repository *r, struct tree *tree);
 void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
 
-void show_object_with_name(FILE *, struct object *, const char *);
-
 /**
  * Helpers to check if a reference should be excluded.
  */
-- 
2.49.0.rc2

