Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DD2E3367
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910504; cv=none; b=c1Kwpk9+hDkkJaR6eEGqlodLZE2AadJFOIJKxJWlpuFmiX0G+DqX42KiGYws8xfXvvWQTviMsDEqDJKNdroAF3aJm1sbpSwAkD991mA3GJnPPC/3l/e/3q11FrlLwKY3g2vR0KfIuRdw+ZN5etfEVlctxXPn639atWTZXRXj/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910504; c=relaxed/simple;
	bh=9Oixtf8VtLt11mtugwndN5WDyIGQO6bIWKsWs5kuz2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoiG7mnAZPVGnFjr+KPYq8j5jsNbELlkWooBEzThJSsNXUGoYf0c2OfsqDJ3NQLt9pa7uIqrRA9BH7c//e5KwcxcjUxTwhP1wsZY5g4h56xQ6xDF9gY1lLjKZU6vFLDYeMZxnefxrxbKb9Gnlj+ezf0zw52td6a05ZajTdfyk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQHeG5Kd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQHeG5Kd"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72726025fa5so407135a34.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910502; x=1742515302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=jQHeG5KdM9PGK20UyqjWciHe+vCRPz4XYzCABsR12M5fyz+UkOPfxQH0BhRHd5RlzT
         NVry6DqxzZ1FxsKRgPosdraHeczTtqgEFiNXbDMAAPwNo2SUCf7UWNGv6NnWmBVEUlZZ
         ysERX+5QoAdjWNfQPaePGz3/GsgnwxWkWV7P4x5gPgt/TTjwzUQGGkWh2Ht1C4j0AKrU
         0CMhgbyaqV2ZO8tbBNu9yR3xg5cerhpfQivDOam4+GzGa0YpJ4CM3A+O3rsuFjn+MPWe
         MCy4vYS1LuwvHy0fYj3DUqNWnwUa7j2HJ0YRL+8Ibk5nqW+Aet1Jd5hdFRLe3xgkRvge
         BhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910502; x=1742515302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNuZlJ4W5k6Ov8daMR9JpIecLLiQjZVFryYurms4G8k=;
        b=OyFF+HCU7zgRcZsZGNka3rtOSS5TqAn5pE4Z+zxXShPMYWABAoKzlpISjaWfdLsybt
         tfmKc5qdvWCiZRN1pX9QeuNh+p5RUJ81vcTHq+lOuZr/C8dGnCa3M0p4GGKcyj8jZOUt
         hJu6/WtvO/Bq40fGokMGnQgIhwvB9WHpshufwA9VII+fxdMAc68smOjfWyd9aUhK/338
         zDWWfjF/8vxWm3FDdKF/O9jiRD9Dg/ZmYLqPnu9PiMqhHW5JfLQwyWOATiS6+Gv8hfWL
         tz29ayDGV7ZiZzN2yc23eJRQwAaOJGAZFUjvLTdE58YNBaavMRoWAC2swIgissTItWi7
         5Epg==
X-Gm-Message-State: AOJu0Yw6iagZ0k62FMXKRPyA85xFUraDaLvwolQj8mIu+zeLHbvcP6RX
	W+CvB1KqXrHfRneoOduN1CW4CQJbn3Jt9f188orp4kJ+ZCU4KvXqS1SIPg==
X-Gm-Gg: ASbGncvhUetRr/eYcKfguUzHRAApHUWdXKO9fQJjTL89OasGApcyCNL39mpyW47N5VK
	nk99TB4pMa10aosBjrCKagF53LQMfLZPHTWBxjGhklFSRkrNc3nLikNmrYhchLeM0r5XuNWJbZ4
	tBhGBawsSRr2IdUZiQaWFUbRj9hSnCbcifbA1WQp3JLj9Xc71QNW1Qj4/dmD1f6/w2bku8cH71C
	hxW9xDhSeBqO7pS4oQhFF2rPBHEUUIKhtOZ+ilj5oqlnhvsF+emX6HSOYqwSS/qSatHZtaFrhHF
	hQonNo/rZIzv+a4luKmLiPbtVlzwhx8sDSUE29PxVvF7ZIgDVxe7
X-Google-Smtp-Source: AGHT+IFdS2hMVBk9twn6yKuGYc83t+KBif3xvlOw12Xj4u38ePSp9nRkPzmRA35XyRosXf+YHQsvvg==
X-Received: by 2002:a05:6830:43a2:b0:72b:a3f3:deb6 with SMTP id 46e09a7af769-72bbc200fe6mr212088a34.4.1741910501747;
        Thu, 13 Mar 2025 17:01:41 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:39 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/6] rev-list: inline `show_object_with_name()` in `show_object()`
Date: Thu, 13 Mar 2025 18:57:42 -0500
Message-ID: <20250313235747.9583-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
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

