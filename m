Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64342B9B9
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307784; cv=none; b=lkbj2//YGyCQwh/6r9nYA6VDH5cu9zX7WO4iw+LSs3XfoZg0MBYgJsz7auIXmVbOvM7Vv/km0ro7w8qzleh/FDIx7o3e8RpdfFC0twka2do5DIjRsLE6DHaAdJ+Wh7ttOULMi4OS3fQSNzajvDX+Lt4psww6ma6u7UlCSul/PMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307784; c=relaxed/simple;
	bh=oW/oclTEv1TLHiIzo8692fCq38pxcCSwte65dn6IZkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5CwxPOuG8FwfeMn/Nhjy99un8mg3JgaJ12qAw+UwZDL17OH30fCotFqImI4XjFeBImZQrVrmm4M+0MpXS/pPJi00gVUZKXj3fqw5yFXCn+wDxMTQu9+yGfI4TydE9GFtF4iMcz4t7v//HUMnKpd4YMQLR9say6OWGLDztGJ31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzSPfXgH; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzSPfXgH"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb9101419cso8191076b6e.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 19:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736307781; x=1736912581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fb73DqGgqhi84cdCBAjvTjQNuTV177dtWMO0yJnXsDg=;
        b=DzSPfXgHdBcnnE25dn3vxH/CgFJBXnfeDRaAjNbHzBUZFGM07CwKO9krkRqjfT+mJR
         ZHQdyVBmqwvKWZ4JWjgcBH2OZNEnG/WZws38eeWltJ8POaECkaZkpRSgICv2XsiQ2I+r
         PyHR9QMGIewzbJahl+kXnTPuQuYEkuy8XFF5hxtzqGHrL/KF4CsC0hhqepnieekTPTsQ
         l60IC5juaSBKbzJZap7PZ6eplWRS/uKezlOEBrAPaQ/jjnIJ8Qt6kwSUrzzYGWcdYOfY
         x6LZ5nyhMPCyAgeO3K0Ax/p/o2mf4s+UEsjEIsTkQugdlxJj9XEhF4NgT1lhRfRQEQBu
         Rv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736307781; x=1736912581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fb73DqGgqhi84cdCBAjvTjQNuTV177dtWMO0yJnXsDg=;
        b=Ig6iwbHb48xx8uCf7LCFvfvV4ogj4x20WjYIIESOhFJKznCo34VN/DJeS0JLeqSqWo
         umrKln++nvXra991WeuBPFJCyMgchEAJVgwFiFWtA1jOvRQkcRNWgIg8UTAjHbvQyAro
         DNRtQ/w4eLI/u/4w/+Br2iy3bOP8ueTrPqsWFLqiixEi/yLY5s5fWmWehRiRNmLLUxUa
         SVhOMz7mYUvnVDX8r44eXkh0oZzfffu70U3Gb5U17+rytipUtuYSWuP17a22aBHCm03O
         1nzqfXrzpaX0fUEUUNR/K/gUU23ojuW1JyzDTagaLDQVLS5RHwdtgAvG7aur5RAhUlmm
         XiHQ==
X-Gm-Message-State: AOJu0Ywszl7sTK3oIScGF8Q8vjcDUh4f6QvnLtqKR0yPHFyfBr2bUDqQ
	dbb6G08SkSEfFhGXmyf2SB0C3/nulqJwtLmUjZu2iUwWNoHgzJe5L3f4uQ==
X-Gm-Gg: ASbGnct9x7Y2DatxKN1duz3s/lBsZlOg4TTXQzSTB5Wsmy/l+RqRlBR5S3BOQUNEwOC
	+S8OM6u7TioiAJtPn31hAkLwaxjF1jDJDqK3WTm8qiJ/IcHqgf4ldP9WUbqdaXWZCiZcEtP8Iz+
	g2zys8wTsh005KIfj/goo8+Px1Pj5mefnt4Y+NKl3HZxEnn1vCQSg5mAn8fF2ueSPMLy4PsIPGQ
	E0DCyjD2Y4ad1a0wm1do77L4Ej7gv749f1PmV376tTLmB71Qi4s+5RaUi1W3JkT
X-Google-Smtp-Source: AGHT+IEeq3KzMqfUDLB+/TLeb7aje/CVyMAVBwiuL1YRFwBveBfMPu3bk0hBOGWGoDExXtVPh5qLnw==
X-Received: by 2002:a05:6808:1993:b0:3eb:4876:cabb with SMTP id 5614622812f47-3ef2ecb034bmr879939b6e.24.1736307781329;
        Tue, 07 Jan 2025 19:43:01 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece24828b2sm11136382b6e.20.2025.01.07.19.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:43:00 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] rev-list: print missing object type with --missing=print-type
Date: Tue,  7 Jan 2025 21:40:12 -0600
Message-ID: <20250108034012.211043-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling of missing objects encounted by git-rev-list(1) can be
configured with the `--missing=<action>` option and specifying the
desired action. Of the available missing actions, none provide a way to
print additional information about the missing object such as its type.

Add a new missing action called `print-type`. Similar to `print`, this
action prints a list of missing objects but also includes the object
type if available in the form: `?<oid> [type]`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
Instead of adding an additional missing action type for the explicit
purpose of printing type info, I also considered a separate option
(something like `--object-types`, or maybe a `--missing-format`) that
could be used in combination with the `--missing=print` option to
achieve the same result. The main intent is for the missing object type
and I wasn't sure if type info would be useful in the general case so I
opted to choose the former approach.

Thanks,
-Justin
---
 Documentation/rev-list-options.txt |  3 ++
 builtin/rev-list.c                 | 74 +++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        | 13 +++++-
 3 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 459e5a02f5..277a0b645e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1024,6 +1024,9 @@ Unexpected missing objects will raise an error.
 The form '--missing=print' is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 +
+The form '--missing=print-type' is like 'print', but will also print the
+missing object type information if available in the form `?<oid> [type]`.
++
 If some tips passed to the traversal are missing, they will be
 considered as missing too, and the traversal will ignore them. In case
 we cannot get their Object ID though, an error will be raised.
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d..ee473da52c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -22,6 +22,7 @@
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
+#include "oidmap.h"
 #include "packfile.h"
 
 static const char rev_list_usage[] =
@@ -73,11 +74,16 @@ static unsigned progress_counter;
 static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
-static struct oidset missing_objects;
+struct missing_objects_map_entry {
+	struct oidmap_entry entry;
+	unsigned type : TYPE_BITS;
+};
+static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
 	MA_PRINT,        /* print ALL missing objects in special section */
+	MA_PRINT_TYPE,   /* same as MA_PRINT but includes available type info */
 	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
@@ -103,6 +109,8 @@ static off_t get_object_disk_usage(struct object *obj)
 
 static inline void finish_object__ma(struct object *obj)
 {
+	struct missing_objects_map_entry *entry, *old;
+
 	/*
 	 * Whether or not we try to dynamically fetch missing objects
 	 * from the server, we currently DO NOT have the object.  We
@@ -119,7 +127,12 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
+	case MA_PRINT_TYPE:
+		CALLOC_ARRAY(entry, 1);
+		entry->entry.oid = obj->oid;
+		entry->type = obj->type;
+		old = oidmap_put(&missing_objects, entry);
+		free(old);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -414,6 +427,12 @@ static inline int parse_missing_action_value(const char *value)
 		return 1;
 	}
 
+	if (!strcmp(value, "print-type")) {
+		arg_missing_action = MA_PRINT_TYPE;
+		fetch_if_missing = 0;
+		return 1;
+	}
+
 	if (!strcmp(value, "allow-promisor")) {
 		arg_missing_action = MA_ALLOW_PROMISOR;
 		fetch_if_missing = 0;
@@ -781,10 +800,26 @@ int cmd_rev_list(int argc,
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT) {
-		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
-		/* Add missing tips */
-		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
+	if (arg_missing_action == MA_PRINT ||
+	    arg_missing_action == MA_PRINT_TYPE) {
+		struct oidset_iter iter;
+		struct object_id *oid;
+
+		oidmap_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		oidset_iter_init(&revs.missing_commits, &iter);
+
+		/*
+		 * Revisions pointing to missing objects lack the context
+		 * required to determine object type.
+		 */
+		while ((oid = oidset_iter_next(&iter))) {
+			struct missing_objects_map_entry *entry;
+
+			CALLOC_ARRAY(entry, 1);
+			oidcpy(&entry->entry.oid, oid);
+			oidmap_put(&missing_objects, entry);
+		}
+
 		oidset_clear(&revs.missing_commits);
 	}
 
@@ -801,12 +836,27 @@ int cmd_rev_list(int argc,
 		oidset_clear(&omitted_objects);
 	}
 	if (arg_missing_action == MA_PRINT) {
-		struct oidset_iter iter;
-		struct object_id *oid;
-		oidset_iter_init(&missing_objects, &iter);
-		while ((oid = oidset_iter_next(&iter)))
-			printf("?%s\n", oid_to_hex(oid));
-		oidset_clear(&missing_objects);
+		struct missing_objects_map_entry *entry;
+		struct oidmap_iter iter;
+
+		oidmap_iter_init(&missing_objects, &iter);
+
+		while ((entry = oidmap_iter_next(&iter)))
+			printf("?%s\n", oid_to_hex(&entry->entry.oid));
+
+		oidmap_free(&missing_objects, true);
+	}
+	if (arg_missing_action == MA_PRINT_TYPE) {
+		struct missing_objects_map_entry *entry;
+		struct oidmap_iter iter;
+
+		oidmap_iter_init(&missing_objects, &iter);
+
+		while ((entry = oidmap_iter_next(&iter)))
+			printf("?%s %s\n", oid_to_hex(&entry->entry.oid),
+			       entry->type ? type_name(entry->type) : "");
+
+		oidmap_free(&missing_objects, true);
 	}
 
 	stop_progress(&progress);
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 7553a9cca2..1606082d4b 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -37,7 +37,7 @@ done
 
 for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
 do
-	for action in "allow-any" "print"
+	for action in "allow-any" "print" "print-type"
 	do
 		test_expect_success "rev-list --missing=$action with missing $obj" '
 			oid="$(git rev-parse $obj)" &&
@@ -48,6 +48,13 @@ do
 			git rev-list --objects --no-object-names \
 				HEAD ^$obj >expect.raw &&
 
+			# When the action is to print the type, we should also
+			# record the expected type of the missing object.
+			if test "$action" = "print-type"
+			then
+				type="$(git cat-file -t $obj)"
+			fi &&
+
 			# Blobs are shared by all commits, so even though a commit/tree
 			# might be skipped, its blob must be accounted for.
 			if test $obj != "HEAD:1.t"
@@ -71,6 +78,10 @@ do
 				grep ?$oid actual.raw &&
 				echo ?$oid >>expect.raw
 				;;
+			print-type)
+				grep "?$oid $type" actual.raw &&
+				echo "?$oid $type" >>expect.raw
+				;;
 			esac &&
 
 			sort actual.raw >actual &&

base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.47.1

