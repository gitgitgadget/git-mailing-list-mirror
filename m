Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDE1C3F00
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441213; cv=none; b=ZIpFog7EO+flHPl0Ppa3IFsvm6J5iRfPOeOXYc10CA3Z5HVShaX0lfCmTUgCsdPnnfjzBlNIGDHqdNpPpGOzS/KQQU1eggZohxUkkDc8ipT2iWafP2WjYy177ZtDmts2xGiUnoiidlxOUWgR4qKjPjFoYia/4gtloTneJ+NDnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441213; c=relaxed/simple;
	bh=qXBb5S+au/MqwTyyMLVXC7GzTok2nG96taBsZNZeCDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEWYsIUkefO885R4NyShGMqL48iVTQ3xPn7B20vnZWau6kftJ6gCDgMMkY82/fDjK9BBcMfrzUK+7TnUbTdxHnHif6DMl4NakeZ+q3S7lUupmvj8NAADAOusDwbFAVezJX/BzNcI5wSPJGWJQtDte01/hiyzdqYsEeWonmiQxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POBQ9g84; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POBQ9g84"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ebadbb14dcso1312981b6e.3
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441210; x=1739046010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g75BUhcT48DLcnjFe2zYhcjHhwEwmuhsmGwotE+RA/w=;
        b=POBQ9g84uggq7Z5+vEIQaVhuheP3Gg8/Lajw5yO4HbUi69rLI1TtKmpAhOpQHUgkQQ
         lrcEGAOF6nFDlwh2W9Akri62eqhdfSr6U+y4xKp5m6CJHs6+gKadCv3Gv7tzCEnVi4RK
         Uif+Nde1LpTPsdqIYNQxoTRf/kpPlFqYe0FAwlfYkAhrMNwEcZmqoVlV9rwzE6gw1OyT
         dfh0DQf73IT6wujwZU1RGFN+7HjD7eZMT6xSlebZEe5obtD3JGGKRu0UvJIYXb5HGxwN
         KDcrtH0IT6T2tGDDy0J8lUrlhc5b31INsbEcaly2u987UMel8FMm2Bc7DDV9CqkFOpks
         7zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441210; x=1739046010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g75BUhcT48DLcnjFe2zYhcjHhwEwmuhsmGwotE+RA/w=;
        b=uvOqtctpCXdDKK8ZDk2J+NQS9NcPxEHWV9NMvz6W0164JbWKYzwXxKDt91ipPSiDZz
         I+rxWAFGMdogwHBFK0uj/uUc3PD7w/Eamq78wChwF7fIMHnFGSnCwRqB3n3mWPElGEiw
         BErOyBrdNT5CHH3u65xRDk5RXLtfcQSr5AwvYxHtGUBWWjQ1pztnSplyPmHswH8Ut76f
         N3csXbWRz1Qot+Srl1dpLvnu9ekKsQwHbnvmKf0mAY8RSz5gSKnLqj/W56JAba2KrvcV
         x9HpPfnQF/v7kyqxLNW2rqNI+WpaaiMaEplZ+mQKA9Q3F1vtEDPMl8FgDw5vYpCyg50z
         1Y7w==
X-Gm-Message-State: AOJu0Yzy0TwM2gq/ZWdh87HrIr1wslzZrpxTZs0NbmwGX9HD07rPfnNb
	lK86OroovQrt4g2Wu0lKkVkLK45M2DxS8adRydJqPLprqNremWuxNMBEig==
X-Gm-Gg: ASbGncsUBizMUTR0z06TjxdWusSCGtGI5DwrvmSY+9ZnInLXJ51F7D8mnvWOSO9Ufhu
	HNpc+puGa/7tIO4xzmYdTisyKJiuvEiX2FympQ2rqsfo8dw7DKZCktONFITKATVyoawZm5+jPB9
	lQuHcf4eW/Uv7Oi+hWLGeRkh53EqF5KMT2vR8Dk/f6NlzCyVH8kbu0vblgzI9Hfi7CKPkCxAD4/
	wWrC9SXn15MhUdBoIZQQT3/14C84qCGWU+izLiuaaK4YAByeTeAJ36j72E6v8gNJstIY7HDuAu/
	COiC8q1j4H+zj5mljFh4C+E=
X-Google-Smtp-Source: AGHT+IHkwqGDnD0A3WfD0zI4LkbfAzJ0kmmMps5cTCWPdXkR0m5vTrdmSd0pJXR9FcbV3KyOH5TEPA==
X-Received: by 2002:a05:6808:1a06:b0:3ec:d30f:60e3 with SMTP id 5614622812f47-3f323b7318amr12473491b6e.39.1738441209622;
        Sat, 01 Feb 2025 12:20:09 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm1588336b6e.0.2025.02.01.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 12:20:09 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/4] rev-list: add print-info action to print missing object path
Date: Sat,  1 Feb 2025 14:16:57 -0600
Message-ID: <20250201201658.11562-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
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
 builtin/rev-list.c                 | 102 ++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        |  52 +++++++++++++++
 3 files changed, 153 insertions(+), 17 deletions(-)

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
index 3196da7b2d..4a45a4e555 100644
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
@@ -101,7 +109,46 @@ static off_t get_object_disk_usage(struct object *obj)
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
+		quote_path(entry->path, NULL, &path,
+			   QUOTE_PATH_QUOTE_SP | QUOTE_PATH_IGNORE_CONFIG);
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
@@ -119,7 +166,8 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
+	case MA_PRINT_INFO:
+		add_missing_object_entry(&obj->oid, name);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -152,7 +200,7 @@ static void show_commit(struct commit *commit, void *data)
 
 	if (revs->do_not_die_on_missing_objects &&
 	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
-		finish_object__ma(&commit->object);
+		finish_object__ma(&commit->object, NULL);
 		return;
 	}
 
@@ -268,12 +316,11 @@ static void show_commit(struct commit *commit, void *data)
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
@@ -414,6 +461,12 @@ static inline int parse_missing_action_value(const char *value)
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
@@ -781,10 +834,18 @@ int cmd_rev_list(int argc,
 
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
 
@@ -800,13 +861,20 @@ int cmd_rev_list(int argc,
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

