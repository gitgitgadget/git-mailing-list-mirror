Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158A2178F0
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803291; cv=none; b=l1d4/MHuCovIMHiswG5TbJAHbInLTqe3eT9MJ172/nkSgUdyRILkp/QsMKpK8zSP1Usg7fAs6XE5AmIdx2bQiAUzFQckPURhu40PrdNaMstQqmJF3Va10wG2b5VcJA1kAIIBFRwrSxwd+JB9ww3VFJEyC+CJMZJpsZVDoFpDalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803291; c=relaxed/simple;
	bh=9xJmjiN3sOiTK9/L7hUDTq5Tz1Bbqyfr32dmYd70us4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrKPMA59Vo8GEA9SFIeUMfjpm1TRQiE7y/jrvNViFmeXvu0PwUWY0/AsIqVrxjwszqDVwRKPs6VRt6a+EFOC9AoSVqRXc8IsCkf6b7zocVHXPhHsBejuhPHGtU0qnMnkz5A9h6IFsinwa/kaN6ZvK1P/yoH3pVn5JEHgyOU2RwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HELxecap; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HELxecap"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbce9e4598so8455576d6.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803285; x=1730408085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqpv6pnPqWIy+76SH/vJj0AEX3OBK7+5mk9nDG/9Rus=;
        b=HELxecapaQkbpIg3vHwLSUkPfBRuYIsR+1+jx8Z1hJgx4kdgIDr70dBXxYbukNCcQK
         I1AbDqX6d7xkuG6quwGEXfx25IqdM24WwaYBXdnZHD/gTGAJ3iGb+v4OzYhzp3sueeSJ
         Sj42HdrCyeOvQ2RDEG8e5moLww4bi77NGxnOOjX12ldm0zCsltxnqU0vIXA84h1rO94s
         motw/IzYrhmEDj4WK3vPYrh9/31t2Z4UtyZE7XPUcy+r1B4oWE1AoZ0BBqykQm+HsHc6
         vN9AlvnVHYf98O0BhcD4uRTjn7Rw3NCSfDTWk9KtNTtjyoA7CM44slpXYNSNKuK5oTjS
         nc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803285; x=1730408085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqpv6pnPqWIy+76SH/vJj0AEX3OBK7+5mk9nDG/9Rus=;
        b=kCUFFRFWQJboWpeMcwd8UT64QWndIHS2fPujdERa+h3p3azIgel4slOH4HCX9o7LmR
         yNO+Gyg4NKDsQ1wG0F2TxcwtkqxMo78Ctfz+0yU/E2OEsx4rA/XY2ynDfyWV/ks1OPfJ
         klCQxtT5XzLJhCllLxDgsxOl4heh9oYUR+Dyl10WvE04RnkOCTq3+IpiDz390SiktcYn
         Ay2dWAkp8gioxD+fiiNNIVPR9gsPcOec61CQwv9GplknwW4KvlQ9noSAxEO4aMxVItUu
         mW3A3BGTDtwtSwNThzXsORx753L2jjPgE15wn30FNtw2/OlMN8uYh2JTngQ8VZ9auLXd
         JpGA==
X-Gm-Message-State: AOJu0YwZjGrysYta/4mzm4ttbB2BWKmQtMFvEauK/WZX5c41lTq0l3ps
	lA5wdAoCnTj+zqltEJebuStJ1nZ62WM62Kn7JTaX3QOh9uOcWkg/dAcTyha6
X-Google-Smtp-Source: AGHT+IHXUucikwbtPcu52ay3+KDF78Hz+I4C8Y06ovjRMD0STmhJYqcrvxOzqmxY74Ma/E9N1tIMmw==
X-Received: by 2002:a0c:f9c6:0:b0:6d1:7629:2ecc with SMTP id 6a1803df08f44-6d176292f4dmr3634066d6.24.1729803284744;
        Thu, 24 Oct 2024 13:54:44 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:44 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 6/6] cat-file: add remote-object-info to batch-command
Date: Thu, 24 Oct 2024 16:53:59 -0400
Message-ID: <20241024205359.16376-7-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
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
then loop through the object info passed in, printing the info.

In order for remote-object-info to avoid remote communication overhead
in the non-buffer mode, the objects are passed in as such:

remote-object-info <remote> <oid> <oid> ... <oid>

rather than

remote-object-info <remote> <oid>
remote-object-info <remote> <oid>
...
remote-object-info <remote> <oid>

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 Documentation/git-cat-file.txt         |  24 +-
 builtin/cat-file.c                     | 108 +++-
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 739 +++++++++++++++++++++++++
 7 files changed, 897 insertions(+), 17 deletions(-)
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index d5890ae368..f2be00b599 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -149,6 +149,13 @@ info <object>::
 	Print object info for object reference `<object>`. This corresponds to the
 	output of `--batch-check`.
 
+remote-object-info <remote> <object>...::
+	Print object info for object references `<object>` at specified <remote> without
+	downloading objects from remote. If the object-info capability is not
+	supported by the server, the objects will be downloaded instead.
+	Error when no object references are provided.
+	This command may be combined with `--buffer`.
+
 flush::
 	Used with `--buffer` to execute all preceding commands that were issued
 	since the beginning or since the last flush was issued. When `--buffer`
@@ -290,7 +297,8 @@ newline. The available atoms are:
 	The full hex representation of the object name.
 
 `objecttype`::
-	The type of the object (the same as `cat-file -t` reports).
+	The type of the object (the same as `cat-file -t` reports). See
+	`CAVEATS` below. Not supported by `remote-object-info`.
 
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
@@ -298,13 +306,14 @@ newline. The available atoms are:
 
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
@@ -314,7 +323,10 @@ newline. The available atoms are:
 	line) are output in place of the `%(rest)` atom.
 
 If no format is specified, the default format is `%(objectname)
-%(objecttype) %(objectsize)`.
+%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
+`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.
+WARNING: When "%(objecttype)" is supported, the default format WILL be unified, so
+DO NOT RELY on the current the default format to stay the same!!!
 
 If `--batch` is specified, or if `--batch-command` is used with the `contents`
 command, the object information is followed by the object contents (consisting
@@ -396,6 +408,10 @@ scripting purposes.
 CAVEATS
 -------
 
+Note that since %(objecttype), %(objectsize:disk) and %(deltabase) are
+currently not supported by the `remote-object-info` command, we will error
+and exit when they are in the format string.
+
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
 responsible for disk usage. The size of a packed non-delta object may be
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5db55fabc4..714c182f39 100644
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
@@ -42,9 +45,12 @@ struct batch_options {
 	char input_delim;
 	char output_delim;
 	const char *format;
+	int use_remote_info;
 };
 
 static const char *force_path;
+static struct object_info *remote_object_info;
+static struct oid_array object_info_oids = OID_ARRAY_INIT;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 static int use_mailmap;
@@ -528,7 +534,7 @@ static void batch_one_object(const char *obj_name,
 	enum get_oid_result result;
 
 	result = get_oid_with_context(the_repository, obj_name,
-				      flags, &data->oid, &ctx);
+								  flags, &data->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
@@ -576,6 +582,59 @@ static void batch_one_object(const char *obj_name,
 	object_context_release(&ctx);
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
+	if (!opt->format)
+		opt->format = "%(objectname) %(objectsize)";
+
+	remote = remote_get(argv[0]);
+	if (!remote)
+		die(_("must supply valid remote when using remote-object-info"));
+
+	oid_array_clear(&object_info_oids);
+	for (size_t i = 1; i < argc; i++) {
+		if (get_oid_hex(argv[i], &oid))
+			die(_("Not a valid object name %s"), argv[i]);
+		oid_array_append(&object_info_oids, &oid);
+	}
+
+	gtransport = transport_get(remote, NULL);
+	if (gtransport->smart_options) {
+		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
+		gtransport->smart_options->object_info = 1;
+		gtransport->smart_options->object_info_oids = &object_info_oids;
+
+		/* 'objectsize' is the only option currently supported */
+		if (!strstr(opt->format, "%(objectsize)"))
+			die(_("%s is currently not supported with remote-object-info"), opt->format);
+
+		string_list_append(&object_info_options, "size");
+
+		if (object_info_options.nr > 0) {
+			gtransport->smart_options->object_info_options = &object_info_options;
+			gtransport->smart_options->object_info_data = remote_object_info;
+			retval = transport_fetch_refs(gtransport, NULL);
+		}
+	} else {
+		retval = -1;
+	}
+
+	string_list_clear(&object_info_options, 0);
+	transport_disconnect(gtransport);
+	return retval;
+}
+
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
@@ -667,6 +726,52 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static void parse_cmd_remote_object_info(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data)
+{
+	int count;
+	const char **argv;
+
+	char *line_to_split = xstrdup_or_null(line);
+	count = split_cmdline(line_to_split, &argv);
+	if (get_remote_info(opt, count, argv))
+		goto cleanup;
+
+	opt->use_remote_info = 1;
+	data->skip_object_info = 1;
+	for (size_t i = 0; i < object_info_oids.nr; i++) {
+
+		data->oid = object_info_oids.oid[i];
+
+		if (remote_object_info[i].sizep) {
+			data->size = *remote_object_info[i].sizep;
+		} else {
+			/*
+			 * When reaching here, it means remote-object-info can't retrieve
+			 * information from server without downloading them, and the objects
+			 * have been fetched to client already.
+			 * Print the information using the logic for local objects.
+			 */
+			data->skip_object_info = 0;
+		}
+
+		opt->batch_mode = BATCH_MODE_INFO;
+		batch_object_write(argv[i+1], output, opt, data, NULL, 0);
+
+	}
+	opt->use_remote_info = 0;
+	data->skip_object_info = 0;
+
+cleanup:
+	for (size_t i = 0; i < object_info_oids.nr; i++)
+		free_object_info_contents(&remote_object_info[i]);
+	free(line_to_split);
+	free(argv);
+	free(remote_object_info);
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -698,6 +803,7 @@ static const struct parse_cmd {
 } commands[] = {
 	{ "contents", parse_cmd_contents, 1},
 	{ "info", parse_cmd_info, 1},
+	{ "remote-object-info", parse_cmd_remote_object_info, 1},
 	{ "flush", NULL, 0},
 };
 
diff --git a/object-file.c b/object-file.c
index b1a3463852..181cde98e1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -3132,3 +3132,14 @@ int read_loose_object(const char *path,
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
index 53b8e693b1..611e2ca708 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -548,4 +548,7 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+/* Free pointers inside of object_info, but not object_info itself */
+void free_object_info_contents(struct object_info *object_info);
+
 #endif /* OBJECT_STORE_LL_H */
diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..929d32da76
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related functions.
+
+# Print a string without a trailing newline
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replaces them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string removing any leading spaces.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d36cd7c086..d8a851c427 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     oid=$2
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
new file mode 100755
index 0000000000..f4bff07311
--- /dev/null
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -0,0 +1,739 @@
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
+# Test --batch-command remote-object-info with 'git://' and
+# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
+
+test_expect_success 'remote-object-info fallback git://: fetch objects to client' '
+	(
+		git -C "$daemon_parent" config transfer.advertiseobjectinfo false &&
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		# Prove object is not on the client
+		echo "$hello_oid missing" >expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		# These results prove remote-object-info can retrieve object info
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results are for the info command
+		# They prove objects are downloaded
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		remote-object-info $GIT_DAEMON_URL/parent $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+
+		# revert server state back
+		git -C "$daemon_parent" config transfer.advertiseobjectinfo true &&
+
+		test_cmp expect actual
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
+
+test_expect_success 'remote-object-info fallback file://: fetch objects to client' '
+	(
+		set_transport_variables "server" &&
+		server_path="$(pwd)/server" &&
+		git -C "${server_path}" config transfer.advertiseobjectinfo false &&
+		cd file_client_empty &&
+
+		# Prove object is not on the client
+		echo "$hello_oid missing" >expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		# These results prove remote-object-info can retrieve object info
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results are for the info command
+		# They prove objects are downloaded
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command="%(objectname) %(objectsize)" >actual <<-EOF &&
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		remote-object-info "file://${server_path}" $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+
+		# revert server state back
+		git -C "${server_path}" config transfer.advertiseobjectinfo true &&
+		test_cmp expect actual
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
+test_expect_success 'remote-object-info fails on unspported filter option (objectsize:disk)' '
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
+test_expect_success 'remote-object-info fails on unspported filter option (deltabase)' '
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
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid
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
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		git clone "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" missing_oid_repo &&
+		test_commit -C missing_oid_repo message1 c.txt &&
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
+# Test --batch-command remote-object-info with 'http://' transport and
+# transfer.advertiseobjectinfo set to false, i.e. server does not have object-info capability
+
+test_expect_success 'remote-object-info fallback http://: fetch objects to client' '
+	(
+		set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo false &&
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty" &&
+
+		# Prove object is not on the client
+		echo "$hello_oid missing" >expect &&
+		echo "$tree_oid missing" >>expect &&
+		echo "$commit_oid missing" >>expect &&
+		echo "$tag_oid missing" >>expect &&
+
+		# These results prove remote-object-info can retrieve object info
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		# These results are for the info command
+		# They prove objects are downloaded
+		echo "$hello_oid $hello_size" >>expect &&
+		echo "$tree_oid $tree_size" >>expect &&
+		echo "$commit_oid $commit_size" >>expect &&
+		echo "$tag_oid $tag_size" >>expect &&
+
+		git cat-file --batch-command >actual <<-EOF &&
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_oid $tree_oid $commit_oid $tag_oid
+		info $hello_oid
+		info $tree_oid
+		info $commit_oid
+		info $tag_oid
+		EOF
+
+		# revert server state back
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
+
+		test_cmp expect actual
+	)
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
+test_done
-- 
2.47.0

