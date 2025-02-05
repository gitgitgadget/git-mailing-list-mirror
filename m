Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EB5FDA7
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716324; cv=none; b=lmyDkHNueyUbFTNlO3AL/LbqmdDWTOYt1bMCa6OGj3lCRLDJfGlfX5v8EzggqQCtAtsUetBu1fOF0/40d30uLCBF+SemnWWXxNgGU1Hn/V8HqRtYQuPsUTz8ule+GrAKVIs2YgyTjzwPxBaS5UOKp7Sx2dnieLs3QhWSjDQ8Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716324; c=relaxed/simple;
	bh=q1cm5HmYpyHiJo6PtyiamP96ChgIVkX9huZeevB5uDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqbmKT8AftABeuCY7sfMSuUvkp9F4+LmPUKKR4jHM5+Jq0+nGbQzV1Cz07bsDwPQBZ+Lzo6TMSzZYRQK4PCGzdAvkNNSdQ47+XShw0IZ6KFevf+3pTXWSG97fsW/IiU1uhyLckzGYNA2Hkr4NUZRrhaDVuedO0XjZ6eTlFwZYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzjXDZ6L; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzjXDZ6L"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b7f09611a9so363777fac.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 16:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738716321; x=1739321121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsOoYhLEqLAkcDi8FxM91GOCblEsW3U4ZfgEx1mm484=;
        b=gzjXDZ6LWatSA04xNCv9v2A3AK8DNeqkooqhz5vLkiaIbrxy0Pt5K7AROLNJYYvThL
         nXhEocQzy6rSZEPVQYzt+98VTU2DCb6HvvYuLbRtfWaNlJ+Wa+ceblgkn1jFKahnoZ15
         Oo63OsaUWnsCg2RFAZQG5eMWDYsUtItYO+JuM7AiCqNmWwj81DHVbOsk3vzX9cZHx/MV
         ZfFU/5YH5h9eHZKDtyT9CvAZbvmEkoPDisV0TGRjblt94JQ98+h/vdxviRZD2PK9WK5r
         +/+RChV94h1UL15X35AHAdMtBC69xVKKNRcdqtpXP6fnrr8mVtM0XywT7TLQUky7RnxT
         WBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716321; x=1739321121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsOoYhLEqLAkcDi8FxM91GOCblEsW3U4ZfgEx1mm484=;
        b=HXJii6qPva9TEEGpIteX7x+vda67sFrrQUoDZgwnpG4roLwj2m7NznF+EEIoqTtyiD
         RxRRE4p5U6x1VFnQCPmK8QFvrTpICUCNuX1KpzWAPyJiArrj2fhc+9KvAhaMIrMO8dqH
         8UQ5V+zSnrZLSkN0gNSN+aNA5e0sa4YLhUl7caoJ0EU8OuWSFhAmmHsTqxca7Rqw85lM
         pLKd/OknZfoJWEZVLQDwKjWDQknmWpGTXA1ccctYlNM5ti6k1XIsCjIfr9gnEFlUmpnK
         xlk3wKwNu5YQqOrbuGWkMX4Qda4FVMTg/w2TgGzsakji6jjKYzlT+tUtzrLaS8jIwfak
         pSbw==
X-Gm-Message-State: AOJu0YxIfDjqWzxIZzEwxJcoITfAbw8vp9aMz7yul5ZTeFrtGhMe98iF
	9169MlRm0vnufQiYdvd0mDcrG2USvoD85Jh6bs3iGNycw5FFR7oi6iv5sw==
X-Gm-Gg: ASbGncuhiLF4XORU1KysGzrExq7mcgLLKCP7qnEshJdd4myPZ0zkYJU7SvJ7FXdcwoY
	ENgvAxcXSAN30MZ8Jb7ALfd4CxMGbPN2sSSOcnamt+Dglj0GL+2l9Qz2S68XkVJri7IYnPLviMo
	ZFVA2v9LiOiKf3STT8he/X/OqlWY/1NUCm59/yLeuzb+S9apCKwQJHEqDwXrLIpfftHaXigbm5W
	k5HEBdiTpjMIPj25Nb93we+qNcUvBxEXifktKxP6Y4vgS+RLfac6WFEP9J8BT4iyEivHA9m5Fbe
	Xl+2X6WjqXUeuMSKF3AoiYQ=
X-Google-Smtp-Source: AGHT+IFFuCyIMM5Th7UxaurphhG/Su+SbdPgLb98yB/gKm9y5Y4rDfGIngDRCXdW9nV21d8PS7D/Iw==
X-Received: by 2002:a05:6870:8292:b0:29e:6547:bffa with SMTP id 586e51a60fabf-2b804fa48e1mr631541fac.21.1738716321157;
        Tue, 04 Feb 2025 16:45:21 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356643beesm4429451fac.41.2025.02.04.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:45:20 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/2] rev-list: add print-info action to print missing object path
Date: Tue,  4 Feb 2025 18:41:46 -0600
Message-ID: <20250205004147.887106-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250205004147.887106-1-jltobler@gmail.com>
References: <20250201201658.11562-1-jltobler@gmail.com>
 <20250205004147.887106-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing objects identified through git-rev-list(1) can be printed by
setting the `--missing=print` option. Additional information about the
missing object, such as its path and type, may be present in its
containing object.

Add the `print-info` missing action for the `--missing` option that,
when set, prints additional insight about the missing object inferred
from its containing object. Each line of output for a missing object is
in the form: `?<oid> [<token>=<value>]...`. The `<token>=<value>` pairs
containing additional information are separated from each other by a SP.
The value is encoded in a token specific fashion, but SP or LF contained
in value are always expected to be represented in such a way that the
resulting encoded value does not have either of these two problematic
bytes. This format is kept generic so it can be extended in the future
to support additional information.

For now, only a missing object path info is implemented. It follows the
form `path=<path>` and specifies the full path to the object from the
top-level tree. A path containing SP or special characters is enclosed
in double-quotes in the C style as needed. In a subsequent commit,
missing object type info will also be added.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.txt |  16 +++++
 builtin/rev-list.c                 | 101 ++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        |  52 +++++++++++++++
 3 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 459e5a02f5..0bea9d4ad3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1024,6 +1024,22 @@ Unexpected missing objects will raise an error.
 The form '--missing=print' is like 'allow-any', but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 +
+The form '--missing=print-info' is like 'print', but will also print additional
+information about the missing object inferred from its containing object. The
+information is all printed on the same line with the missing object ID in the
+form: `?<oid> [<token>=<value>]...`. The `<token>=<value>` pairs containing
+additional information are separated from each other by a SP. The value is
+encoded in a token specific fashion, but SP or LF contained in value are always
+expected to be represented in such a way that the resulting encoded value does
+not have either of these two problematic bytes. Each `<token>=<value>` may be
+one of the following:
++
+--
+* The `path=<path>` shows the path of the missing object inferred from a
+  containing object. A path containing SP or special characters is enclosed in
+  double-quotes in the C style as needed.
+--
++
 If some tips passed to the traversal are missing, they will be
 considered as missing too, and the traversal will ignore them. In case
 we cannot get their Object ID though, an error will be raised.
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d..00f157eb68 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -22,7 +22,10 @@
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
+#include "oidmap.h"
 #include "packfile.h"
+#include "quote.h"
+#include "strbuf.h"
 
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit>... [--] [<path>...]\n"
@@ -73,11 +76,16 @@ static unsigned progress_counter;
 static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
-static struct oidset missing_objects;
+struct missing_objects_map_entry {
+	struct oidmap_entry entry;
+	const char *path;
+};
+static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
 	MA_PRINT,        /* print ALL missing objects in special section */
+	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
 	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
@@ -101,7 +109,45 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static inline void finish_object__ma(struct object *obj)
+static void add_missing_object_entry(struct object_id *oid, const char *path)
+{
+	struct missing_objects_map_entry *entry;
+
+	if (oidmap_get(&missing_objects, oid))
+		return;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->entry.oid = *oid;
+	if (path)
+		entry->path = xstrdup(path);
+	oidmap_put(&missing_objects, entry);
+}
+
+static void print_missing_object(struct missing_objects_map_entry *entry,
+				 int print_missing_info)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!print_missing_info) {
+		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		return;
+	}
+
+	if (entry->path && *entry->path) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addstr(&sb, " path=");
+		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
+		strbuf_addbuf(&sb, &path);
+
+		strbuf_release(&path);
+	}
+
+	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
+	strbuf_release(&sb);
+}
+
+static inline void finish_object__ma(struct object *obj, const char *name)
 {
 	/*
 	 * Whether or not we try to dynamically fetch missing objects
@@ -119,7 +165,8 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
+	case MA_PRINT_INFO:
+		add_missing_object_entry(&obj->oid, name);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -152,7 +199,7 @@ static void show_commit(struct commit *commit, void *data)
 
 	if (revs->do_not_die_on_missing_objects &&
 	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
-		finish_object__ma(&commit->object);
+		finish_object__ma(&commit->object, NULL);
 		return;
 	}
 
@@ -268,12 +315,11 @@ static void show_commit(struct commit *commit, void *data)
 	finish_commit(commit);
 }
 
-static int finish_object(struct object *obj, const char *name UNUSED,
-			 void *cb_data)
+static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
-		finish_object__ma(obj);
+		finish_object__ma(obj, name);
 		return 1;
 	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
@@ -414,6 +460,12 @@ static inline int parse_missing_action_value(const char *value)
 		return 1;
 	}
 
+	if (!strcmp(value, "print-info")) {
+		arg_missing_action = MA_PRINT_INFO;
+		fetch_if_missing = 0;
+		return 1;
+	}
+
 	if (!strcmp(value, "allow-promisor")) {
 		arg_missing_action = MA_ALLOW_PROMISOR;
 		fetch_if_missing = 0;
@@ -781,10 +833,18 @@ int cmd_rev_list(int argc,
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT) {
-		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+	if (arg_missing_action == MA_PRINT ||
+	    arg_missing_action == MA_PRINT_INFO) {
+		struct oidset_iter iter;
+		struct object_id *oid;
+
+		oidmap_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		oidset_iter_init(&revs.missing_commits, &iter);
+
 		/* Add missing tips */
-		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
+		while ((oid = oidset_iter_next(&iter)))
+			add_missing_object_entry(oid, NULL);
+
 		oidset_clear(&revs.missing_commits);
 	}
 
@@ -800,13 +860,20 @@ int cmd_rev_list(int argc,
 			printf("~%s\n", oid_to_hex(oid));
 		oidset_clear(&omitted_objects);
 	}
-	if (arg_missing_action == MA_PRINT) {
-		struct oidset_iter iter;
-		struct object_id *oid;
-		oidset_iter_init(&missing_objects, &iter);
-		while ((oid = oidset_iter_next(&iter)))
-			printf("?%s\n", oid_to_hex(oid));
-		oidset_clear(&missing_objects);
+	if (arg_missing_action == MA_PRINT ||
+	    arg_missing_action == MA_PRINT_INFO) {
+		struct missing_objects_map_entry *entry;
+		struct oidmap_iter iter;
+
+		oidmap_iter_init(&missing_objects, &iter);
+
+		while ((entry = oidmap_iter_next(&iter))) {
+			print_missing_object(entry, arg_missing_action ==
+							    MA_PRINT_INFO);
+			free((void *)entry->path);
+		}
+
+		oidmap_free(&missing_objects, true);
 	}
 
 	stop_progress(&progress);
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 7553a9cca2..38afca6f09 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -145,4 +145,56 @@ do
 	done
 done
 
+for obj in "HEAD~1" "HEAD^{tree}" "HEAD:foo" "HEAD:foo/bar" "HEAD:baz baz"
+do
+	test_expect_success "--missing=print-info with missing '$obj'" '
+		test_when_finished rm -rf missing-info &&
+
+		git init missing-info &&
+		(
+			cd missing-info &&
+			git commit --allow-empty -m first &&
+
+			mkdir foo &&
+			echo bar >foo/bar &&
+			echo baz >"baz baz" &&
+			echo bat >bat\" &&
+			git add -A &&
+			git commit -m second &&
+
+			oid="$(git rev-parse "$obj")" &&
+			path=".git/objects/$(test_oid_to_path $oid)" &&
+
+			case $obj in
+			HEAD:foo)
+				path_info=" path=foo"
+				;;
+			HEAD:foo/bar)
+				path_info=" path=foo/bar"
+				;;
+			"HEAD:baz baz")
+				path_info=" path=\"baz baz\""
+				;;
+			"HEAD:bat\"")
+				path_info=" path=\"bat\\\"\""
+				;;
+			esac &&
+
+			# Before the object is made missing, we use rev-list to
+			# get the expected oids.
+			git rev-list --objects --no-object-names \
+				HEAD ^"$obj" >expect.raw &&
+			echo "?$oid$path_info" >>expect.raw &&
+
+			mv "$path" "$path.hidden" &&
+			git rev-list --objects --no-object-names \
+				--missing=print-info HEAD >actual.raw &&
+
+			sort actual.raw >actual &&
+			sort expect.raw >expect &&
+			test_cmp expect actual
+		)
+	'
+done
+
 test_done
-- 
2.48.1.157.g3b0d05c4a7

