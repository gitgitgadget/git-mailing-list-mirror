Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4576048
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601549; cv=none; b=Q9wY4IFAzEEjGdoSdNEgOjD2wlfy0VMpfjtq8YWN0NcZhJ9RdhZeKHLf8cmopXxT/zNr/VWqXyc02A/ywWbGkR12SRKr+6HAuqFlMnZvdmXq4EIzjCCV0SOrtxzKWnkRDnlomdCgJaMUaynn2oBJGEJ4cTSHNf+A5oQhPtvZITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601549; c=relaxed/simple;
	bh=dcPGPMcnYSJGQ6TXU68AXVBaFDgn3eolIyjRV+vAB1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIRxCFX4TZ9iGsF6PwuTFAc/D148ehYMZ+jkUXBkek68ADeEEwPb9KE/u+V5E5FBIiLwu67iqMRdGIwjaUaAjHTgV2BPZXA+wXbI6Z9PqTBTBFemcIpIw5oo3QUUYSALHdmMyTf+SA/sFMB9yKkPt19T5HRJoqBl4zPx5o/c55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPwgOoUl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPwgOoUl"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b4ff803ef2so4985496d6.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719601545; x=1720206345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhWo9w4Qz/L7e8C+MlRA+cl5G20WOx2Ihy5N2AQ42fc=;
        b=JPwgOoUlQbErynIfmaPQRzt1JMJTWErv4/MqZsf3wVv9/PL9YnUCML8YK7k88TlALC
         arInqHASFFApG/NZL4EIh4bxA/f5nuH9Twxupp2eq/uK6xOBymulSNXTI2XStzk+cNr/
         17fXA0zEjHRavu1q/Pv98gutX1QnMwqjPwVgvj4JunOMl5y0PVwhS18ex2NB0ATO95Fu
         wORAVBa7o6f+RwZHLBkXnHh5oAq91hEv9C2LzImREiptbBcFmbGs0f5lBUFq9ImGztg0
         4kEkXElek0aeZ8UqMM7ubKxI3cWnIbDl1o/ZIJmNamdYDp1N2p8AaWJmoTHZQGUkpvk/
         shRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601545; x=1720206345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhWo9w4Qz/L7e8C+MlRA+cl5G20WOx2Ihy5N2AQ42fc=;
        b=ABOCd8puJrgAY/kE59vIZt+ywUd6kFQNCCEU9dv26DWCnZuU9aAL2/bgl5RILNM+CT
         X7U/K1l2sQC3kDfcBrQ0aTWr1BpXJ1HUKeyPFuVxuY75edi9xlrDyNob2Rv61jaiQYer
         6RfCADVg8Yhxmavrm2thmiA3b6D9OhC6XhZyRPnGbkfcOQXmKt5zLFo+dEsIp/w138xt
         zEyIV0IncFo2e+cTY4lio1AUzQlaEKeFgvabRYDNTyXDwLxGLgr2kzNS/nHUiS3OEbxJ
         wwIIB3S596NgMRGTHRt4tRsG3XG+kVi9asbrLo2qIczCR2ZMbP/Rd9igqzYBbgFnU6xf
         moEA==
X-Gm-Message-State: AOJu0YyguEb/L8CEAj0UqfS1tpdRLsiFj88hL8uZCHvUcwV24X1rfycu
	PK3meODvZ8WzbWQGBWsau5t9OPJoUM3F1liiyfwyqpYq+jHeritAppOSaEGm
X-Google-Smtp-Source: AGHT+IEOJ9BEdIAewVz3wvenQ26B8H+z6ZqV3UkOAsn84LuNj9r+fvDwFvYJnv1xJSYfdLNDk3ANTw==
X-Received: by 2002:a05:6214:20af:b0:6b5:a000:81ad with SMTP id 6a1803df08f44-6b5a00082bcmr42230366d6.63.1719601544991;
        Fri, 28 Jun 2024 12:05:44 -0700 (PDT)
Received: from localhost.localdomain ([76.71.94.205])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e574cc4sm10262346d6.53.2024.06.28.12.05.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jun 2024 12:05:44 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	John Cai <johncai86@gmail.com>,
	Eric Ju <eric.peijian@gmail.com>
Subject: [PATCH 6/6] cat-file: add remote-object-info to batch-command
Date: Fri, 28 Jun 2024 15:05:03 -0400
Message-ID: <20240628190503.67389-7-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Since the `info` command in cat-file --batch-command prints object info
for a given object, it is natural to add another command in cat-file
--batch-command to print object info for a given object from a remote.
Add `remote-object-info` to cat-file --batch-command.

While `info` takes object ids one at a time, this creates overhead when
making requests to a server so `remote-object-info` instead can take
multiple object ids at once.

cat-file --batch-command is generally implemented in the following
manner:

 - Receive and parse input from user
 - Call respective function attached to command
 - Set batch mode state, get object info, print object info

In --buffer mode, this changes to:

 - Receive and parse input from user
 - Store respective function attached to command in a queue
 - After flush, loop through commands in queue
    - Call respective function attached to command
    - Set batch mode state, get object info, print object info

Notice how the getting and printing of object info is accomplished one
at a time. As described above, this creates a problem for making
requests to a server. Therefore, `remote-object-info` is implemented in
the following manner:

 - Receive and parse input from user
 If command is `remote-object-info`:
    - Get object info from remote
    - Loop through object info
        - Call respective function attached to `info`
        - Set batch mode state, use passed in object info, print object
          info
 Else:
    - Call respective function attached to command
    - Parse input, get object info, print object info

And finally for --buffer mode `remote-object-info`:
 - Receive and parse input from user
 - Store respective function attached to command in a queue
 - After flush, loop through commands in queue:
    If command is `remote-object-info`:
        - Get object info from remote
        - Loop through object info
            - Call respective function attached to `info`
            - Set batch mode state, use passed in object info, print
              object info
    Else:
        - Call respective function attached to command
        - Set batch mode state, get object info, print object info

To summarize, `remote-object-info` gets object info from the remote and
then generates multiple `info` commands with the object info passed in.

In order for remote-object-info to avoid remote communication overhead
in the non-buffer mode, the objects are passed in as such:

remote-object-info <remote> <oid> <oid> ... <oid>

rather than

remote-object-info <remote> <oid>
remote-object-info <remote> <oid>
...
remote-object-info <remote> <oid>

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cat-file.txt         |  22 +-
 builtin/cat-file.c                     | 231 ++++++++++----
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 t/t1017-cat-file-remote-object-info.sh | 412 +++++++++++++++++++++++++
 5 files changed, 620 insertions(+), 59 deletions(-)
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a..ab0647bb39 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -149,6 +149,12 @@ info <object>::
 	Print object info for object reference `<object>`. This corresponds to the
 	output of `--batch-check`.
 
+remote-object-info <remote> <object>...::
+	Print object info for object references `<object>` at specified <remote> without
+	downloading object from remote.
+	Error when no object references is provided.
+	This command may be combined with `--buffer`.
+
 flush::
 	Used with `--buffer` to execute all preceding commands that were issued
 	since the beginning or since the last flush was issued. When `--buffer`
@@ -290,7 +296,8 @@ newline. The available atoms are:
 	The full hex representation of the object name.
 
 `objecttype`::
-	The type of the object (the same as `cat-file -t` reports).
+	The type of the object (the same as `cat-file -t` reports). See
+	`CAVEATS` below. Not supported by `remote-object-info`.
 
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
@@ -298,13 +305,14 @@ newline. The available atoms are:
 
 `objectsize:disk`::
 	The size, in bytes, that the object takes up on disk. See the
-	note about on-disk sizes in the `CAVEATS` section below.
+	note about on-disk sizes in the `CAVEATS` section below. Not
+	supported by `remote-object-info`.
 
 `deltabase`::
 	If the object is stored as a delta on-disk, this expands to the
 	full hex representation of the delta base object name.
 	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
-	below.
+	below. Not supported by `remote-object-info`.
 
 `rest`::
 	If this atom is used in the output string, input lines are split
@@ -314,7 +322,9 @@ newline. The available atoms are:
 	line) are output in place of the `%(rest)` atom.
 
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`.
+%(objecttype) %(objectsize)`, except remote-object-info command who uses
+`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
+When "%(objecttype)" is supported, default format should be unified.
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -396,6 +406,10 @@ scripting purposes.
 CAVEATS
 -------
 
+Note that since objecttype, objectsize:disk and deltabase are currently not supported by the
+remote-object-info, git will error and exit when they are in the format string.
+
+
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
 responsible for disk usage. The size of a packed non-delta object may be
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 72a78cdc8c..34958a1747 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,6 +24,9 @@
 #include "promisor-remote.h"
 #include "mailmap.h"
 #include "write-or-die.h"
+#include "alias.h"
+#include "remote.h"
+#include "transport.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -42,9 +45,14 @@ struct batch_options {
 	char input_delim;
 	char output_delim;
 	const char *format;
+	int use_remote_info;
 };
 
+#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
+
 static const char *force_path;
+static struct object_info *remote_object_info;
+static struct oid_array object_info_oids = OID_ARRAY_INIT;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 static int use_mailmap;
@@ -508,7 +516,6 @@ static void batch_object_write(const char *obj_name,
 	}
 
 	batch_write(opt, scratch->buf, scratch->len);
-
 	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, &opt->output_delim, 1);
@@ -526,51 +533,118 @@ static void batch_one_object(const char *obj_name,
 		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
 	enum get_oid_result result;
 
-	result = get_oid_with_context(the_repository, obj_name,
-				      flags, &data->oid, &ctx);
-	if (result != FOUND) {
-		switch (result) {
-		case MISSING_OBJECT:
-			printf("%s missing%c", obj_name, opt->output_delim);
-			break;
-		case SHORT_NAME_AMBIGUOUS:
-			printf("%s ambiguous%c", obj_name, opt->output_delim);
-			break;
-		case DANGLING_SYMLINK:
-			printf("dangling %"PRIuMAX"%c%s%c",
-			       (uintmax_t)strlen(obj_name),
-			       opt->output_delim, obj_name, opt->output_delim);
-			break;
-		case SYMLINK_LOOP:
-			printf("loop %"PRIuMAX"%c%s%c",
-			       (uintmax_t)strlen(obj_name),
-			       opt->output_delim, obj_name, opt->output_delim);
-			break;
-		case NOT_DIR:
-			printf("notdir %"PRIuMAX"%c%s%c",
-			       (uintmax_t)strlen(obj_name),
-			       opt->output_delim, obj_name, opt->output_delim);
-			break;
-		default:
-			BUG("unknown get_sha1_with_context result %d\n",
-			       result);
-			break;
+	if (!opt->use_remote_info) {
+		result = get_oid_with_context(the_repository, obj_name,
+						flags, &data->oid, &ctx);
+		if (result != FOUND) {
+			switch (result) {
+			case MISSING_OBJECT:
+				printf("%s missing%c", obj_name, opt->output_delim);
+				break;
+			case SHORT_NAME_AMBIGUOUS:
+				printf("%s ambiguous%c", obj_name, opt->output_delim);
+				break;
+			case DANGLING_SYMLINK:
+				printf("dangling %"PRIuMAX"%c%s%c",
+					(uintmax_t)strlen(obj_name),
+					opt->output_delim, obj_name, opt->output_delim);
+				break;
+			case SYMLINK_LOOP:
+				printf("loop %"PRIuMAX"%c%s%c",
+					(uintmax_t)strlen(obj_name),
+					opt->output_delim, obj_name, opt->output_delim);
+				break;
+			case NOT_DIR:
+				printf("notdir %"PRIuMAX"%c%s%c",
+					(uintmax_t)strlen(obj_name),
+					opt->output_delim, obj_name, opt->output_delim);
+				break;
+			default:
+				BUG("unknown get_sha1_with_context result %d\n",
+					result);
+				break;
+			}
+			fflush(stdout);
+			return;
 		}
-		fflush(stdout);
-		return;
-	}
 
-	if (ctx.mode == 0) {
-		printf("symlink %"PRIuMAX"%c%s%c",
-		       (uintmax_t)ctx.symlink_path.len,
-		       opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
-		fflush(stdout);
-		return;
+		if (ctx.mode == 0) {
+			printf("symlink %"PRIuMAX"%c%s%c",
+				(uintmax_t)ctx.symlink_path.len,
+				opt->output_delim, ctx.symlink_path.buf, opt->output_delim);
+			fflush(stdout);
+			return;
+		}
 	}
 
 	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
 }
 
+static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
+{
+	int retval = 0;
+	struct remote *remote = NULL;
+	struct object_id oid;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
+	static struct transport *gtransport;
+
+	/*
+	 * Change the format to "%(objectname) %(objectsize)" when
+	 * remote-object-info command is used. Once we start supporting objecttype
+	 * the default format should change to DEFAULT_FORMAT
+	*/
+	if (!opt->format) {
+		opt->format = "%(objectname) %(objectsize)";
+	}
+
+	remote = remote_get(argv[0]);
+	if (!remote)
+		die(_("must supply valid remote when using remote-object-info"));
+	oid_array_clear(&object_info_oids);
+	for (size_t i = 1; i < argc; i++) {
+		if (get_oid_hex(argv[i], &oid))
+			die(_("Not a valid object name %s"), argv[i]);
+		oid_array_append(&object_info_oids, &oid);
+	}
+
+	gtransport = transport_get(remote, NULL);
+	if (gtransport->smart_options) {
+		int include_size = 0;
+
+		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
+		gtransport->smart_options->object_info = 1;
+		gtransport->smart_options->object_info_oids = &object_info_oids;
+		/*
+		 * 'size' is the only option currently supported.
+		 * Other options that are passed in the format will exit with error.
+		 */
+		if (strstr(opt->format, "%(objectsize)")) {
+			string_list_append(&object_info_options, "size");
+			include_size = 1;
+		}
+		if (strstr(opt->format, "%(objecttype)")) {
+			die(_("objecttype is currently not supported with remote-object-info"));
+		}
+		if (strstr(opt->format, "%(objectsize:disk)"))
+			die(_("objectsize:disk is currently not supported with remote-object-info"));
+		if (strstr(opt->format, "%(deltabase)"))
+			die(_("deltabase is currently not supported with remote-object-info"));
+		if (object_info_options.nr > 0) {
+			gtransport->smart_options->object_info_options = &object_info_options;
+			for (size_t i = 0; i < object_info_oids.nr; i++) {
+				if (include_size)
+					remote_object_info[i].sizep = xcalloc(1, sizeof(long));
+			}
+			gtransport->smart_options->object_info_data = &remote_object_info;
+			retval = transport_fetch_refs(gtransport, NULL);
+		}
+	} else {
+		retval = -1;
+	}
+
+	return retval;
+}
+
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
@@ -642,6 +716,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
 struct queued_cmd {
 	parse_cmd_fn_t fn;
 	char *line;
+	const char *name;
 };
 
 static void parse_cmd_contents(struct batch_options *opt,
@@ -662,6 +737,55 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static const struct parse_cmd {
+	const char *name;
+	parse_cmd_fn_t fn;
+	unsigned takes_args;
+} commands[] = {
+	{ "contents", parse_cmd_contents, 1 },
+	{ "info", parse_cmd_info, 1 },
+	{ "remote-object-info", parse_cmd_info, 1 },
+	{ "flush", NULL, 0 },
+};
+
+static void parse_remote_info(struct batch_options *opt,
+			   char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   const struct parse_cmd *p_cmd,
+			   struct queued_cmd *q_cmd)
+{
+	int count;
+	const char **argv;
+
+	count = split_cmdline(line, &argv);
+	if (get_remote_info(opt, count, argv))
+		goto cleanup;
+	opt->use_remote_info = 1;
+	data->skip_object_info = 1;
+	data->mark_query = 0;
+	for (size_t i = 0; i < object_info_oids.nr; i++) {
+		if (remote_object_info[i].sizep)
+			data->size = *remote_object_info[i].sizep;
+		if (remote_object_info[i].typep)
+			data->type = *remote_object_info[i].typep;
+
+		data->oid = object_info_oids.oid[i];
+		if (p_cmd)
+			p_cmd->fn(opt, argv[i+1], output, data);
+		else
+			q_cmd->fn(opt, argv[i+1], output, data);
+	}
+	opt->use_remote_info = 0;
+	data->skip_object_info = 0;
+	data->mark_query = 1;
+
+cleanup:
+	for (size_t i = 0; i < object_info_oids.nr; i++)
+		free_object_info_contents(&remote_object_info[i]);
+	free(remote_object_info);
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -671,8 +795,12 @@ static void dispatch_calls(struct batch_options *opt,
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (int i = 0; i < nr; i++)
-		cmd[i].fn(opt, cmd[i].line, output, data);
+	for (int i = 0; i < nr; i++) {
+		if (!strcmp(cmd[i].name, "remote-object-info"))
+			parse_remote_info(opt, cmd[i].line, output, data, NULL, &cmd[i]);
+		else
+			cmd[i].fn(opt, cmd[i].line, output, data);
+	}
 
 	fflush(stdout);
 }
@@ -685,17 +813,6 @@ static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 	*nr = 0;
 }
 
-
-static const struct parse_cmd {
-	const char *name;
-	parse_cmd_fn_t fn;
-	unsigned takes_args;
-} commands[] = {
-	{ "contents", parse_cmd_contents, 1},
-	{ "info", parse_cmd_info, 1},
-	{ "flush", NULL, 0},
-};
-
 static void batch_objects_command(struct batch_options *opt,
 				    struct strbuf *output,
 				    struct expand_data *data)
@@ -740,11 +857,17 @@ static void batch_objects_command(struct batch_options *opt,
 			dispatch_calls(opt, output, data, queued_cmd, nr);
 			free_cmds(queued_cmd, &nr);
 		} else if (!opt->buffer_output) {
-			cmd->fn(opt, p, output, data);
+			if (!strcmp(cmd->name, "remote-object-info")) {
+				char *line = xstrdup_or_null(p);
+				parse_remote_info(opt, line, output, data, cmd, NULL);
+			} else {
+				cmd->fn(opt, p, output, data);
+			}
 		} else {
 			ALLOC_GROW(queued_cmd, nr + 1, alloc);
 			call.fn = cmd->fn;
 			call.line = xstrdup_or_null(p);
+			call.name = cmd->name;
 			queued_cmd[nr++] = call;
 		}
 	}
@@ -761,8 +884,6 @@ static void batch_objects_command(struct batch_options *opt,
 	strbuf_release(&input);
 }
 
-#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
-
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
diff --git a/object-file.c b/object-file.c
index d3cf4b8b2e..6aaa167942 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2988,3 +2988,14 @@ int read_loose_object(const char *path,
 		munmap(map, mapsize);
 	return ret;
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
+	free(object_info->type_name);
+}
diff --git a/object-store-ll.h b/object-store-ll.h
index c5f2bb2fc2..333e19cd1e 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -533,4 +533,7 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+/* Free pointers inside of object_info, but not object_info itself */
+void free_object_info_contents(struct object_info *object_info);
+
 #endif /* OBJECT_STORE_LL_H */
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
new file mode 100755
index 0000000000..7a7bdfeb91
--- /dev/null
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -0,0 +1,412 @@
+#!/bin/sh
+
+test_description='git cat-file --batch-command with remote-object-info command'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+echo_without_newline () {
+    printf '%s' "$*"
+}
+
+strlen () {
+    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
+
+hello_content="Hello World"
+hello_size=$(strlen "$hello_content")
+hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+
+tree_size=$(($(test_oid rawsz) + 13))
+
+commit_message="Initial commit"
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
+# This section tests --batch-command with remote-object-info command
+# Since "%(objecttype)" is currently not supported by the command remote-object-info ,
+# the filters are set to "%(objectname) %(objectsize)".
+# Tests with the default filter are used to test the fallback to 'fetch' command
+
+
+# Test --batch-command remote-object-info with 'git://' transport
+
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=receive-pack
+daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+
+	echo_without_newline "$hello_content" > $daemon_parent/hello &&
+	git -C "$daemon_parent" update-index --add hello &&
+	git -C "$daemon_parent" config transfer.advertiseobjectinfo true
+'
+
+set_transport_variables () {
+	hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+	tree_sha1=$(git -C "$1" write-tree)
+	commit_sha1=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_sha1)
+	tag_sha1=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)
+	tag_size=$(strlen "$tag_content")
+}
+
+
+test_expect_success 'batch-command remote-object-info git://' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $tree_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info git:// multiple sha1 per line' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info http:// default filter' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		GIT_TRACE_PACKET=1 git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info git://' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+stop_git_daemon
+
+# Test --batch-command remote-object-info with 'http://' transport
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
+	echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add hello
+'
+
+
+test_expect_success 'batch-command remote-object-info http://' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		remote-object-info "$HTTPD_URL/smart/http_parent" $tree_sha1
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1
+		remote-object-info "$HTTPD_URL/smart/http_parent" $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info http:// one line' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info http://' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1 $tag_sha1
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info http:// default filter' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1 $tree_sha1
+		remote-object-info "$HTTPD_URL/smart/http_parent" $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote-object-info fails on unspported filter option (objectsize:disk)' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_grep "objectsize:disk is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on unspported filter option (deltabase)' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_grep "deltabase is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_grep "remote-object-info requires protocol v2" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol fallback' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_grep "remote-object-info requires protocol v2" err
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
+		test_grep "Not a valid object name '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on malformed OID fallback' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		malformed_object_id="this_id_is_not_valid" &&
+
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $malformed_object_id
+		EOF
+		test_grep "Not a valid object name '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on missing OID' '
+	set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git clone "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" missing_oid_repo &&
+	test_commit -C missing_oid_repo message1 c.txt &&
+	(
+		cd missing_oid_repo &&
+
+		object_id=$(git rev-parse message1:c.txt) &&
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $object_id
+		EOF
+		test_grep "object-info: not our ref $object_id" err
+	)
+'
+
+# shellcheck disable=SC2016
+test_expect_success 'remote-object-info fails on missing OID fallback' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		cd missing_oid_repo &&
+		object_id=$(git rev-parse message1:c.txt) &&
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $object_id
+		EOF
+		test_grep "fatal: object-info: not our ref $object_id" err
+	)
+'
+
+# Test --batch-command remote-object-info with 'file://' transport
+
+# shellcheck disable=SC2016
+test_expect_success 'create repo to be served by file:// transport' '
+	git init server &&
+	git -C server config protocol.version 2 &&
+	git -C server config transfer.advertiseobjectinfo true &&
+	echo_without_newline "$hello_content" > server/hello &&
+	git -C server update-index --add hello
+'
+
+
+test_expect_success 'batch-command remote-object-info file://' '
+	(
+		set_transport_variables "server" &&
+		cd server &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "file://$(pwd)" $hello_sha1
+		remote-object-info "file://$(pwd)" $tree_sha1
+		remote-object-info "file://$(pwd)" $commit_sha1
+		remote-object-info "file://$(pwd)" $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info file:// multiple sha1 per line' '
+	(
+		set_transport_variables "server" &&
+		cd server &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1 $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info file://' '
+	(
+		set_transport_variables "server" &&
+		cd server &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+		git cat-file --batch-command="%(objectname) %(objectsize)" --buffer >actual <<-EOF &&
+		remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1
+		remote-object-info "file://$(pwd)" $commit_sha1 $tag_sha1
+		flush
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command remote-object-info file:// default filter' '
+	(
+		set_transport_variables "server" &&
+		cd server &&
+
+		echo "$hello_sha1 $hello_size" >expect &&
+		echo "$tree_sha1 $tree_size" >>expect &&
+		echo "$commit_sha1 $commit_size" >>expect &&
+		echo "$tag_sha1 $tag_size" >>expect &&
+
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1
+		remote-object-info "file://$(pwd)" $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.45.2

