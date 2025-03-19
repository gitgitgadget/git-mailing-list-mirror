Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F71DFD98
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409476; cv=none; b=QsqvPGQQSbqugEND+/z+f89ZfBzqXgClyVc8YWclPxtJZApNgh1720EUXV0jFMGOe11YQFDd2A516jhszQZjimyvJ8aOLrfoM4N1jbCtbxYxqLvl+bwsYaF9TuifDLjJz4mVrFZIv4KoO3QmnVAP2s97L8PmnipIojjimliM/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409476; c=relaxed/simple;
	bh=9Oixtf8VtLt11mtugwndN5WDyIGQO6bIWKsWs5kuz2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIjSmEiQTChXF1XZUPJJxTuep2Pigp6LQF4AjY2b+yWIeiChPSPfxGz1EqX+T7DkFOzoq2u87Zat7Jeq16QwuNyX4lo16cnfStD6l+j18ydKsyXySnfMqfg9TIs4+AdLVxZJfdVR4JVjKlDZdUv3iPv4nOENzl51suKHdYtNNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0NyborF; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0NyborF"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bc3987a05so571630a34.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409474; x=1743014274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=Q0NyborFbQJHblecZv3oqnQYhVeu6aNuYsiHU64Flg52w2pcmpk9hfoq6+JDOKSMqk
         NtV0PosNUav8qp+pCyKRw1aAR/0vdQVC8OzX/Wnc+WOiDE74HHRwx4bAzIyxDtefr3tg
         tWZZW8arZswbs+itKbrVACSSqcInhwiFlt90nhs3+Fp4DU/FoB2Hkd+GCj5EMttsDhsb
         zZ+YpgpaJjcRihj9ZU1Lb9+pBopbyESuRF6hr/L2xHAEk6TaNOX1XRQC16Dsa4qkMurm
         NbZhe39cEEPaGKkHEllIdzUwP3z6GstdEWMRxz7wCqnlhpgNtB5nBSgaUKwGSGs0vzCx
         5E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409474; x=1743014274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=uSV/JWazkvUtCRqo4A9Z/wTG82gyGRmHBinoQ8E/fE0NaEHBh/Ju3fv2kPsFmbHOOW
         fuQpSfAlQwaanNhu7GT8iFIyI4FstI7qaWBaaJWIwOVkAiZjCGnx88Gl4P3fTL8/Im14
         1EsXuZ4f6o0a/cpy2Tph3ahKMiadh3XPHBWc2S6O7JFdYPjNTX85wd94uJ7gFJ4tYX8L
         MnwDPCVbF3CGh5JEyYZNE17ktqSK6hPAwPJlzevaGxPVrXIjIxNZulgtG43f/CoZMlK5
         39NwwpZB4o3tLFMtNczzRw0BWwP5OwQiB1uZ0uo/mq+jyCKA/MjX90Jy3qPLzwRMeVAq
         L8gQ==
X-Gm-Message-State: AOJu0YxhJZRTeDjqsEFhfPRJKxS3FWEtdljGfgDNzwuiZAcWdGfcjAeq
	qP/7XZ9u2bBvNUCskeNjLsWnpxtqWLfqfn/TiV7kEMdpaYJddJ6g0Mv+XQ==
X-Gm-Gg: ASbGncsLhH6kxs9e6ZetDm0GZEdU/JZAqHd/LGCN3Fss+gbIbve61JznLmQGoi5Wwzl
	Dt1dv4U/Ljdf55X0ZK/xbaIruf+JLa0EcgoXn5hArzM/83GIlMUjgvRoXrSq5ST7yXldWOOBA+B
	HRye8EP68z5TK37Bvo/I/gPfzzqM6IToUYWkl/OkmO3CRRfbwxpwpmBd8cAcq+YDC2Te9mW5dSn
	UtTU4zy4uB5wiU6gYIev3JeakgykcX9dz2dwmwXBnZ8baKcPahJrAKn/3ieTq1pyyRdcJMiTDVF
	DEtwVzvxhDQBuy8HK6/nRNbuJCzK8/bJC3Jc5QBXmQynK4FvDxWe/JO1l1DFGSg=
X-Google-Smtp-Source: AGHT+IF+5TO0pEvfG4Yld5OEiq3wpS0pBfs+3rWkAoPY+pHRN0C7KUSUqi6KmzKCH3h89rEjf17V+A==
X-Received: by 2002:a9d:5606:0:b0:72a:b2a:476 with SMTP id 46e09a7af769-72c02d8fa22mr351450a34.3.1742409473860;
        Wed, 19 Mar 2025 11:37:53 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/5] rev-list: inline `show_object_with_name()` in `show_object()`
Date: Wed, 19 Mar 2025 13:34:06 -0500
Message-ID: <20250319183410.1225428-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250319183410.1225428-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
 <20250319183410.1225428-1-jltobler@gmail.com>
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

