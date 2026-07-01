Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDF481241
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908349; cv=none; b=pIrhNG9z0QHBwYcZpOqBpVcXBEBC1PW1sWgfphcpaeOVaib41KBidmsdHiEj0zhOltimms54qx27iB8RitQjwvur0ZVZOpbnMOAf96wj+B/DfWZ1FKFLj1pC3V1EqgX0+Udox1rBR4hiw6iwy1rQWLkFTLEJiTwFlxulydRBggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908349; c=relaxed/simple;
	bh=Jg5CXoLl1SYqj3qtfORD+XsJLIN/X/JONzCsV9Ye2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIhxle3Vd5SK7HYlmKVB9IqKaTLiSqjOcUtT0uiTuqB255nbPsVyGlxfEJgg8bIeWDAl3maz6XW7vyb5z4QXC8SP9c2XS+KsONR4hjLass4769j7dbbO2ed5pDENPB15E218CIOLUKcAwX9KhvUtu7CISwB8QGOjKptSl3s8df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt1Qj2fb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt1Qj2fb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so3978505e9.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908344; x=1783513144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QOr2hoO6EzfDrTvwuIKVG4alBwQW5CO4Pr9HlsJQTmk=;
        b=Tt1Qj2fbgW0guGemb81SasWiEYO3trbETBEiZ5KDo+aAAnBYLD1ZGuIHuvbDcJpeH5
         hgi3imBMq1yhX6OEm7+pgDMcp5FI0TMbugoFjS6U92QExUJfqJGv9RiecVOIjW87Hz6P
         icRE/fIFkCHmYdEcasWgX6k/tbpogCq92tKWg6WhKboGKx0osPlsdBzWsit7cO5f/d+p
         nEMpMMke87h+rGCLa2iMLg3xlAN6SjMtPF0oPXZizkC5Ou+xlXRG85eSu12Dpo9nn+jD
         MPs4oBnMUEsu1cB5PAtp38eeObQgd425iazILPxIe5CAjFqlPpQORT9MSfQJ5zQnVnXA
         WC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908344; x=1783513144;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOr2hoO6EzfDrTvwuIKVG4alBwQW5CO4Pr9HlsJQTmk=;
        b=BmIutb/Jj5xVi8P98zHjdKkvUGVhjzJpddyX0NCvy+SJDzurm408zeACcY+i9NjMoz
         584Ic7lc99xkoQzXSTKizXVypR/X3/PdSRR5aw4nlMukSrOit1mE8kPtyqfvX7biJE9G
         4Y0Rp8YXT8GnNoNoAD9CPfFk4Pee4toqDTwnwUvVYQkIekPrqLkbkNcr/Flrw7rgNac7
         ahU9iNCa3zUsUi2c0k6OOcyYNFhVwwhoN+y7w6auK8SuqvD4AuiV4Oq+c73k6/eaUvYG
         4qSROw0nNQOykx3lrpvctKeC7EAtypLVwUdR5mSAliWzJ/cFYWNRm18JnttbMjotTKIR
         JVkg==
X-Gm-Message-State: AOJu0Yz+biXzW2H6Pyz2Ws18G6+P1T7PiJYGvrymQ3tzpDlizVN2Yi0/
	iMqkipEd3Ybi2IigbjgP9NsrZdKQvB8owZzRtEJBQMMsfzF8iRzAz0BAoPrdeP7O
X-Gm-Gg: AfdE7cmZoL/mh06dFdP4hbpjKPhXrP2FO6E3kRL3H8CwU1vxa6ydVeXeHH24nvm31l7
	2GPyah/IGTLw12WgGSrzG0gyJ9JttGYCM1TuHnlzJxsCUCMt0hOE7nfM384HvdIyDglosIY9+pq
	KZzgOKQLJW4VQPo7sjZB5UPgUoww1+vEa84vYuWIxYoviHvmusWWo2fyEoa9EWbL4FRu6Jr8jQw
	koGegYUN1IAO/fn3ZG1RFm6kVvVTuJjX37otinYrlnmX4RbzwZfN+n13+tA1C6C+dM81wddZiTg
	O0G5AR9C++UaDutDnJs4j7JOCxdTbz7+0BzYoBmj1BwLNd6QA7io3UfNef4uj+FZhITHU3yDUsu
	1+LnyvJnHEFSdBPHb/626sw6NbVsvffecrbn/kxQtiTtu8oZdsQbRczkhW/DYduEfe4kXGQ/T5h
	w0J0IX5bVj+DY4pkgvyu0PiQQ6sUpdkw03d0bT1dmNfJ8UBcEMFNTSvQmTqlmyaEopmhSIsnRq6
	FW/O1+JQJA0BC2fe4ydD0zrot9OP9/g9ucJJ3pxpwzKHxcEkCHb0q9OOCzIjWnKANgmyYQq9PEc
	GPRK63r0iGSaXcNbrUDnPonRZ+EZxFPxCCFMOvWLOr/9THY7BWGGZ3qMMb9MpP8d6tWIyxetdVt
	4rdaJP0Xmew==
X-Received: by 2002:a05:600c:c8d:b0:492:37a5:422d with SMTP id 5b1f17b1804b1-493c3cd0ebemr5552945e9.7.1782908344137;
        Wed, 01 Jul 2026 05:19:04 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.19.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:19:02 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v15 11/13] cat-file: add remote-object-info to batch-command
Date: Wed,  1 Jul 2026 14:18:45 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-11-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Since the `info` command in `cat-file --batch-command` prints object
info for a given object, it is natural to add another command in
`cat-file --batch-command` to print object info for a given object
from a remote.

Add `remote-object-info` to `cat-file --batch-command`.

While `info` takes object ids one at a time, this creates
overhead when making requests to a server. So `remote-object-info`
instead can take multiple object ids at once.

The `cat-file --batch-command` command is generally implemented in
the following manner:

 - Receive and parse input from user
 - Call respective function attached to command
 - Get object info, print object info

In --buffer mode, this changes to:

 - Receive and parse input from user
 - Store respective function attached to command in a queue
 - After flush, loop through commands in queue
    - Call respective function attached to command
    - Get object info, print object info

Notice how the getting and printing of object info is accomplished one
at a time. As described above, this creates a problem for making
requests to a server. Therefore, `remote-object-info` is implemented in
the following manner:

 - Receive and parse input from user
 If command is `remote-object-info`:
    - Get object info from remote
    - Loop through and print each object info
 Else:
    - Call respective function attached to command
    - Parse input, get object info, print object info

And finally for --buffer mode `remote-object-info`:
 - Receive and parse input from user
 - Store respective function attached to command in a queue
 - After flush, loop through commands in queue:
    If command is `remote-object-info`:
        - Get object info from remote
        - Loop through and print each object info
    Else:
        - Call respective function attached to command
        - Get object info, print object info

To summarize, `remote-object-info` gets object info from the remote and
then loops through the object info passed in, printing the info.

In order for `remote-object-info` to avoid remote communication
overhead in the non-buffer mode, the objects are passed in as such:

remote-object-info <remote> <oid> <oid> ... <oid>

rather than

remote-object-info <remote> <oid>
remote-object-info <remote> <oid>
...
remote-object-info <remote> <oid>

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-cat-file.adoc        |  29 +-
 builtin/cat-file.c                     | 144 ++++++-
 object-file.c                          |  10 +
 odb.h                                  |   3 +
 t/meson.build                          |   1 +
 t/t1017-cat-file-remote-object-info.sh | 680 +++++++++++++++++++++++++++++++++
 6 files changed, 859 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 86b9181599..a7fa6674c3 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -169,6 +169,13 @@ info <object>::
 	Print object info for object reference `<object>`. This corresponds to the
 	output of `--batch-check`.
 
+remote-object-info <remote> <object>...::
+	Print object info for object references `<object>` at specified
+	`<remote>` without downloading objects from the remote.
+	Raise an error when the `object-info` capability is not supported by the remote.
+	Raise an error when no object references are provided.
+	This command may be combined with `--buffer`.
+
 flush::
 	Used with `--buffer` to execute all preceding commands that were issued
 	since the beginning or since the last flush was issued. When `--buffer`
@@ -301,7 +308,8 @@ one per line, and print information based on the command given. With
 `--batch-command`, the `info` command followed by an object will print
 information about the object the same way `--batch-check` would, and the
 `contents` command followed by an object prints contents in the same way
-`--batch` would.
+`--batch` would. The `remote-object-info` command followed by a remote and
+objects IDs prints object info from the remote without downloading the objects.
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -324,15 +332,12 @@ newline. The available atoms are:
 	reports).
 
 `objectsize:disk`::
-	The size, in bytes, that the object takes up on disk. See the
-	note about on-disk sizes in the `CAVEATS` section below.
+	The size, in bytes, that the object takes up on disk.
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
 	full hex representation of the delta base object name.
-	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
-	below.
-
+	Otherwise, expands to the null OID (all zeroes).
 `rest`::
 	If this atom is used in the output string, input lines are split
 	at the first whitespace boundary. All characters before that
@@ -340,8 +345,14 @@ newline. The available atoms are:
 	after that first run of whitespace (i.e., the "rest" of the
 	line) are output in place of the `%(rest)` atom.
 
+The command `remote-object-info` only supports the `%(objectname)` and
+`%(objectsize)` placeholders. See `CAVEATS` below for more information.
+
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`.
+%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
+use `%(objectname) %(objectsize)` because "%(objecttype)" is not supported yet.
+WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
+so DO NOT RELY on the current default format to stay the same!!!
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -438,6 +449,10 @@ scripting purposes.
 CAVEATS
 -------
 
+Note that since only `%(objectname)` and `%(objectsize)` are currently
+supported by the `remote-object-info` command. Using any other placeholder in
+the format string will raise an error.
+
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
 responsible for disk usage. The size of a packed non-delta object may be
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1e5473ab70..eb133113c0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -29,6 +29,22 @@
 #include "promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
+#include "alias.h"
+#include "remote.h"
+#include "transport.h"
+
+/*
+ * Maximum length for a remote URL. While no universal standard exists,
+ * 8K is assumed to be a reasonable limit.
+ */
+#define MAX_REMOTE_URL_LEN (8 * 1024)
+
+/* Maximum number of objects allowed in a single remote-object-info request. */
+#define MAX_ALLOWED_OBJ_LIMIT 10000
+
+/* Maximum input size permitted for the remote-object-info command. */
+#define MAX_REMOTE_OBJ_INFO_LINE \
+	(MAX_REMOTE_URL_LEN + MAX_ALLOWED_OBJ_LIMIT * (GIT_MAX_HEXSZ + 1))
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -633,6 +649,80 @@ static void batch_one_object(const char *obj_name,
 	object_context_release(&ctx);
 }
 
+static int get_remote_info(struct batch_options *opt,
+			   int argc,
+			   const char **argv,
+			   struct object_info **remote_object_info,
+			   struct oid_array *object_info_oids)
+{
+	int retval = 0;
+	struct remote *remote = NULL;
+	struct object_id oid;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
+	struct transport *gtransport;
+
+	/*
+	 * TODO: Change the format to "%(objectname) %(objectsize)" when
+	 * remote-object-info command is used. Once we start supporting objecttype
+	 * the default format should change to DEFAULT_FORMAT.
+	 */
+	if (!opt->format)
+		opt->format = "%(objectname) %(objectsize)";
+
+	remote = remote_get(argv[0]);
+	if (!remote)
+		die(_("must supply valid remote when using remote-object-info"));
+
+	oid_array_clear(object_info_oids);
+	for (size_t i = 1; i < argc; i++) {
+		if (get_oid_hex(argv[i], &oid)) {
+			size_t len = strlen(argv[i]);
+
+			if (len < the_hash_algo->hexsz && len >= 4) {
+				size_t j;
+				for (j = 0; j < len; j++)
+					if (!isxdigit(argv[i][j]))
+						break;
+				if (j == len)
+					die(_("remote-object-info does not support "
+					      "short oids, %d characters required"),
+					    (int)the_hash_algo->hexsz);
+			}
+			die(_("not a valid object name '%s'"), argv[i]);
+		}
+		oid_array_append(object_info_oids, &oid);
+	}
+
+	if (!object_info_oids->nr)
+		die(_("remote-object-info requires objects"));
+
+	gtransport = transport_get(remote, NULL);
+
+	if (!gtransport->smart_options) {
+		retval = -1;
+		goto cleanup;
+	}
+
+	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
+	gtransport->smart_options->object_info_oids = object_info_oids;
+
+	/* 'objectsize' is the only option currently supported */
+	if (!strstr(opt->format, "%(objectsize)"))
+		die(_("%s is currently not supported with remote-object-info"), opt->format);
+
+	string_list_append(&object_info_options, "size");
+
+	if (object_info_options.nr > 0) {
+		gtransport->smart_options->object_info_options = &object_info_options;
+		gtransport->smart_options->object_info_data = *remote_object_info;
+		retval = transport_fetch_object_info(gtransport);
+	}
+cleanup:
+	string_list_clear(&object_info_options, 0);
+	transport_disconnect(gtransport);
+	return retval;
+}
+
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
@@ -714,6 +804,57 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
 		load_mailmap();
 }
 
+static void parse_cmd_remote_object_info(struct batch_options *opt,
+					 const char *line, struct strbuf *output,
+					 struct expand_data *data)
+{
+	int count;
+	const char **argv;
+	char *line_to_split;
+	struct object_info *remote_object_info = NULL;
+	struct oid_array object_info_oids = OID_ARRAY_INIT;
+
+	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
+		die(_("remote-object-info command too long"));
+
+	line_to_split = xstrdup(line);
+	count = split_cmdline(line_to_split, &argv);
+	if (count < 0)
+		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
+	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
+		die(_("remote-object-info supports at most %d objects"),
+		    MAX_ALLOWED_OBJ_LIMIT);
+
+	if (get_remote_info(opt, count, argv, &remote_object_info,
+			    &object_info_oids))
+		goto cleanup;
+
+	data->skip_object_info = 1;
+	for (size_t i = 0; i < object_info_oids.nr; i++) {
+		data->oid = object_info_oids.oid[i];
+		if (remote_object_info[i].sizep) {
+			/*
+			 * When reaching here, it means remote-object-info can retrieve
+			 * information from server without downloading them.
+			 */
+			data->size = *remote_object_info[i].sizep;
+			opt->batch_mode = BATCH_MODE_INFO;
+			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
+		} else {
+			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
+		}
+	}
+	data->skip_object_info = 0;
+
+cleanup:
+	for (size_t i = 0; i < object_info_oids.nr; i++)
+		free_object_info_contents(&remote_object_info[i]);
+	free(line_to_split);
+	free(argv);
+	free(remote_object_info);
+	oid_array_clear(&object_info_oids);
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -745,8 +886,9 @@ static const struct parse_cmd {
 } commands[] = {
 	{ "contents", parse_cmd_contents, 1 },
 	{ "info", parse_cmd_info, 1 },
-	{ "flush", NULL, 0 },
 	{ "mailmap", parse_cmd_mailmap, 1 },
+	{ "remote-object-info", parse_cmd_remote_object_info, 1 },
+	{ "flush", NULL, 0 },
 };
 
 static void batch_objects_command(struct batch_options *opt,
diff --git a/object-file.c b/object-file.c
index e3d92bbda2..9928e82e0b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1694,3 +1694,13 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 
 	return &transaction->base;
 }
+
+void free_object_info_contents(struct object_info *object_info)
+{
+	if (!object_info)
+		return;
+	free(object_info->typep);
+	free(object_info->sizep);
+	free(object_info->disk_sizep);
+	free(object_info->delta_base_oid);
+}
diff --git a/odb.h b/odb.h
index 3834a0dcbf..42e3934035 100644
--- a/odb.h
+++ b/odb.h
@@ -573,4 +573,7 @@ void parse_alternates(const char *string,
 		      const char *relative_base,
 		      struct strvec *out);
 
+/* Free pointers inside of object_info, but not object_info itself */
+void free_object_info_contents(struct object_info *object_info);
+
 #endif /* ODB_H */
diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..54d21111a3 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -170,6 +170,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1022-read-tree-partial-clone.sh',
   't1050-large.sh',
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
new file mode 100755
index 0000000000..49b6660934
--- /dev/null
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -0,0 +1,680 @@
+#!/bin/sh
+
+test_description='git cat-file --batch-command with remote-object-info command'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
+
+hello_content="Hello World"
+hello_size=$(strlen "$hello_content")
+hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+hello_short_oid=$(git rev-parse --short "$hello_oid")
+
+unstored_content="Hello Git"
+unstored_oid=$(echo_without_newline "$unstored_content" | git hash-object --stdin)
+
+# This is how we get 13:
+# 13 = <file mode> + <a_space> + <file name> + <a_null>, where
+# file mode is 100644, which is 6 characters;
+# file name is hello, which is 5 characters
+# a space is 1 character and a null is 1 character
+tree_size=$(($(test_oid rawsz) + 13))
+
+commit_message="Initial commit"
+
+# This is how we get 137:
+# 137 = <tree header> + <a_space> + <a newline> +
+# <Author line> + <a newline> +
+# <Committer line> + <a newline> +
+# <a newline> +
+# <commit message length>
+# An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
+# to get 177, 2. then deduct 40 hex characters to get 137
+commit_size=$(($(test_oid hexsz) + 137))
+
+tag_header_without_oid="type blob
+tag hellotag
+tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+tag_header_without_timestamp="object $hello_oid
+$tag_header_without_oid"
+tag_description="This is a tag"
+tag_content="$tag_header_without_timestamp 0 +0000
+
+$tag_description"
+
+tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
+tag_size=$(strlen "$tag_content")
+
+set_transport_variables () {
+	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+	tree_oid=$(git -C "$1" write-tree)
+	commit_oid=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_oid)
+	tag_oid=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)
+	tag_size=$(strlen "$tag_content")
+}
+
+# This section tests --batch-command with remote-object-info command
+# Since "%(objecttype)" is currently not supported by the command remote-object-info ,
+# the filters are set to "%(objectname) %(objectsize)" in some test cases.
+
+# Test --batch-command remote-object-info with 'git://' transport with
+# transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=receive-pack
+daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+	echo_without_newline "$hello_content" > $daemon_parent/hello &&
+	git -C "$daemon_parent" update-index --add hello &&
+	git -C "$daemon_parent" config transfer.advertiseobjectinfo true &&
+	git clone "$GIT_DAEMON_URL/parent" -n "$daemon_parent/daemon_client_empty"
+'
+
+test_expect_success 'batch-command remote-object-info git://' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		remote-object-info "$GIT_DAEMON_URL/parent" $tree_oid
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid
+		remote-object-info "$GIT_DAEMON_URL/parent" $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info git:// multiple sha1 per line' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info git:// default filter' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+		GIT_TRACE_PACKET=1 git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info git://' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid $tree_oid
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command -Z remote-object-info git:// default filter' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		printf "%s\0" "$hello_oid $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+
+		printf "%s\0" "$hello_oid missing" >>expect &&
+		printf "%s\0" "$tree_oid missing" >>expect &&
+		printf "%s\0" "$commit_oid missing" >>expect &&
+		printf "%s\0" "$tag_oid missing" >>expect &&
+
+		batch_input="remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid
+remote-object-info $GIT_DAEMON_URL/parent $commit_oid $tag_oid
+info $hello_oid
+info $tree_oid
+info $commit_oid
+info $tag_oid
+" &&
+		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
+
+		git cat-file --batch-command -Z < commands_null_delimited >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote-object-info does not support short oids' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info $GIT_DAEMON_URL/parent $hello_short_oid
+		EOF
+		test_grep "does not support short oids" err
+	)
+'
+
+test_expect_success 'remote-object-info does not die on missing oid like info' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		git cat-file --batch-command >local <<-EOF &&
+		info $unstored_oid
+		EOF
+		git cat-file --batch-command >remote <<-EOF &&
+		remote-object-info $GIT_DAEMON_URL/parent $unstored_oid
+		EOF
+		test_cmp local remote
+	)
+'
+
+# Test --batch-command remote-object-info with 'git://' and
+# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
+test_expect_success 'batch-command remote-object-info git:// fails when transfer.advertiseobjectinfo=false' '
+	(
+		git -C "$daemon_parent" config transfer.advertiseobjectinfo false &&
+		set_transport_variables "$daemon_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid $commit_oid $tag_oid
+		EOF
+		test_grep "object-info capability is not enabled on the server" err &&
+
+		# revert server state back
+		git -C "$daemon_parent" config transfer.advertiseobjectinfo true
+
+	)
+'
+
+stop_git_daemon
+
+# Test --batch-command remote-object-info with 'file://' transport with
+# transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
+# shellcheck disable=SC2016
+test_expect_success 'create repo to be served by file:// transport' '
+	git init server &&
+	git -C server config protocol.version 2 &&
+	git -C server config transfer.advertiseobjectinfo true &&
+	echo_without_newline "$hello_content" > server/hello &&
+	git -C server update-index --add hello &&
+	git clone -n "file://$(pwd)/server" file_client_empty
+'
+
+test_expect_success 'batch-command remote-object-info file://' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid
+		remote-object-info "file://${server_path}" $tree_oid
+		remote-object-info "file://${server_path}" $commit_oid
+		remote-object-info "file://${server_path}" $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info file:// multiple sha1 per line' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info file://' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid
+		remote-object-info "file://${server_path}" $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info file:// default filter' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid
+		remote-object-info "file://${server_path}" $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command -Z remote-object-info file:// default filter' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		cd file_client_empty &&
+
+		printf "%s\0" "$hello_oid $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+
+		printf "%s\0" "$hello_oid missing" >>expect &&
+		printf "%s\0" "$tree_oid missing" >>expect &&
+		printf "%s\0" "$commit_oid missing" >>expect &&
+		printf "%s\0" "$tag_oid missing" >>expect &&
+
+		batch_input="remote-object-info \"file://${server_path}\" $hello_oid $tree_oid
+remote-object-info \"file://${server_path}\" $commit_oid $tag_oid
+info $hello_oid
+info $tree_oid
+info $commit_oid
+info $tag_oid
+" &&
+		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
+
+		git cat-file --batch-command -Z < commands_null_delimited >actual &&
+		test_cmp expect actual
+	)
+'
+
+# Test --batch-command remote-object-info with 'file://' and
+# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
+test_expect_success 'batch-command remote-object-info file:// fails when transfer.advertiseobjectinfo=false' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		git -C "${server_path}" config transfer.advertiseobjectinfo false &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
+		EOF
+		test_grep "object-info capability is not enabled on the server" err &&
+
+		# revert server state back
+		git -C "${server_path}" config transfer.advertiseobjectinfo true
+	)
+'
+
+# Test --batch-command remote-object-info with 'http://' transport with
+# transfer.advertiseobjectinfo set to true, i.e. server has object-info capability
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
+	echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add hello &&
+	git clone "$HTTPD_URL/smart/http_parent" -n "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty"
+'
+
+test_expect_success 'batch-command remote-object-info http://' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $tree_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info http:// one line' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info http://' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		# These results prove remote-object-info can get object info from the remote
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results prove remote-object-info did not download objects from the remote
+		echo "$hello_oid missing" >>expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info http:// default filter' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		echo "$hello_oid $hello_size" >expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_oid $tag_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command -Z remote-object-info http:// default filter' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		printf "%s\0" "$hello_oid $hello_size" >expect &&
+		printf "%s\0" "$tree_oid $tree_size" >>expect &&
+		printf "%s\0" "$commit_oid $commit_size" >>expect &&
+		printf "%s\0" "$tag_oid $tag_size" >>expect &&
+
+		batch_input="remote-object-info $HTTPD_URL/smart/http_parent $hello_oid $tree_oid
+remote-object-info $HTTPD_URL/smart/http_parent $commit_oid $tag_oid
+" &&
+		echo_without_newline_nul "$batch_input" >commands_null_delimited &&
+
+		git cat-file --batch-command -Z < commands_null_delimited >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote-object-info fails on unsupported filter option (objectsize:disk)' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
+		EOF
+		test_grep "%(objectsize:disk) is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on unsupported filter option (deltabase)' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
+		EOF
+		test_grep "%(deltabase) is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
+		EOF
+		test_grep "object-info requires protocol v2" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol with default filter' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
+		EOF
+		test_grep "object-info requires protocol v2" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on malformed OID' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		malformed_object_id="this_id_is_not_valid" &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $malformed_object_id
+		EOF
+		test_grep "not a valid object name '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on malformed OID with default filter' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		malformed_object_id="this_id_is_not_valid" &&
+
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $malformed_object_id
+		EOF
+		test_grep "not a valid object name '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on not providing OID' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent"
+		EOF
+		test_grep "remote-object-info requires objects" err
+	)
+'
+
+
+# Test --batch-command remote-object-info with 'http://' transport and
+# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
+test_expect_success 'batch-command remote-object-info http:// fails when transfer.advertiseobjectinfo=false ' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo false &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
+		EOF
+		test_grep "object-info capability is not enabled on the server" err &&
+
+		# revert server state back
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true
+	)
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
+test_done

-- 
2.54.0
