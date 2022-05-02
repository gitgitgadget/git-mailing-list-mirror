Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A8DC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386625AbiEBRNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386576AbiEBRNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1AB1F6
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id bj12-20020a056a02018c00b003a9eebaad34so7249326pgb.10
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KIcdDExwiOWtYbZVdamkiwlgjINW/QWj55/Di02BHm0=;
        b=aQbTnGzeZDsznn/QOzGgYr5NAkhqwt3KNSUttzrfH38UqUwSfeXot+dJLC0oQb25Kf
         HZY9c2JfiWS8jGiynCxB0MGKqcRlt5XYkYJ9VQbq8qQ+fp1y8wfmQ4IbMfD7aBGknfl4
         UL587XrhnP/GVJrQf0kmni8H9u2rTtAXxpSymfDnVEbsFi+w4dkZGk9PcQoWfJZpIOpE
         /qpz7J+JzRTjD3SAfXcoXpxwz+ckYpzjauRFJiVpA1Nhwpb40uBMfYaCoiFlUod5l5vm
         GGSOTFJz+EIKogBwiU7RRFJEDL/HVlTTJ4EIRyvSxji/QCpuGi1KSN9BdWcBpLOI6P8w
         2SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KIcdDExwiOWtYbZVdamkiwlgjINW/QWj55/Di02BHm0=;
        b=tmisa3yQWprwG/0430aP7cztObcOH96jK/ozQm8M1drREGy4AXztbk3VC2BwIJ0obF
         xkS5InRgLJMkgEITNrtH4O0kWIkWR7WInGzGJH2n8Mmqwt3aUutniQ/3ep8UmO3OLMEq
         wFYzk1ALGu1oHpA/ahwBTrPy6q0+P5nCyzPnAjglaOy7yWd+NkLPOl1yuWN0k+V/ld0N
         FjRa+ZfwIewN0xqOWjltATY1ZaRQEi998DVS2VQNNMl2HbvBJ3q013ySu2dTN4yvQf4f
         jk57uLxS64X2y1xkU7eYtDkBt3xAxXojq+Ww7NmM6145x3qnWDUmDPWVIOZlzl0p/g1k
         yc6w==
X-Gm-Message-State: AOAM530mQFgo2D6sDeCXduh4fQHXTRVZThwMBDibA66+isSiy0rfYfT6
        ueyv9v5h4eY0bglRpyOXXJlBs4YGW6VJdpnIFHFPqBot5NS+aL/mm0GJmB+/Gmu2UjkLz8/uhXU
        sQUOWN7LCxfNVHuUZY5pkCdMgNf+bCexT4kSfFmgIPxjKrUhqwYdHojmaSVPEGMZO3Q==
X-Google-Smtp-Source: ABdhPJwIN8EF6c3qMfxiQNwyo1XcYI195ognyBhAEBhEaB5ZS2HeiiR7FRpgeET10o9XLXHspqzkSAsoXJUld0M=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:1105:b0:156:3e9d:bb7b with SMTP
 id n5-20020a170903110500b001563e9dbb7bmr12313348plh.136.1651511410280; Mon,
 02 May 2022 10:10:10 -0700 (PDT)
Date:   Mon,  2 May 2022 17:09:04 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-9-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 8/8] cat-file: add --batch-command remote-object-info command
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
then generates multiples `info` commands with the object info passed in.
It cannot be implemented similarly to `info` and `content` because of
the overhead with remote commenication.

---
 Documentation/git-cat-file.txt |  16 +-
 builtin/cat-file.c             | 200 +++++++++++++++----
 t/t1006-cat-file.sh            | 347 +++++++++++++++++++++++++++++++++
 3 files changed, 522 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 24a811f0ef..0d9e8e6214 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -115,6 +115,10 @@ info <object>::
 	Print object info for object reference `<object>`. This corresponds to the
 	output of `--batch-check`.
 
+remote-object-info <remote> [<object>]::
+	Print object info for object references `<object>` at specified <remote>.
+	This command may only be combined with `--buffer`.
+
 flush::
 	Used with `--buffer` to execute all preceding commands that were issued
 	since the beginning or since the last flush was issued. When `--buffer`
@@ -245,7 +249,8 @@ newline. The available atoms are:
 	The full hex representation of the object name.
 
 `objecttype`::
-	The type of the object (the same as `cat-file -t` reports).
+	The type of the object (the same as `cat-file -t` reports). See
+	`CAVEATS` below.
 
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
@@ -253,13 +258,14 @@ newline. The available atoms are:
 
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
@@ -346,6 +352,10 @@ directory name.
 CAVEATS
 -------
 
+Note that since object type is currently not supported by the
+object-info command request, git fetches the entire object instead to
+get the object info.
+
 Note that the sizes of objects on disk are reported accurately, but care
 should be taken in drawing conclusions about which refs or objects are
 responsible for disk usage. The size of a packed non-delta object may be
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cfe74c36eb..7baa9bed61 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,9 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "alias.h"
+#include "remote.h"
+#include "transport.h"
 
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
@@ -32,11 +35,14 @@ struct batch_options {
 	int unordered;
 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
+	int use_remote_info;
 };
 
 #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
 
 static const char *force_path;
+static struct object_info *remote_object_info;
+static struct oid_array object_info_oids = OID_ARRAY_INIT;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
@@ -425,48 +431,115 @@ static void batch_one_object(const char *obj_name,
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum get_oid_result result;
 
-	result = get_oid_with_context(the_repository, obj_name,
-				      flags, &data->oid, &ctx);
-	if (result != FOUND) {
-		switch (result) {
-		case MISSING_OBJECT:
-			printf("%s missing\n", obj_name);
-			break;
-		case SHORT_NAME_AMBIGUOUS:
-			printf("%s ambiguous\n", obj_name);
-			break;
-		case DANGLING_SYMLINK:
-			printf("dangling %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
-			break;
-		case SYMLINK_LOOP:
-			printf("loop %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
-			break;
-		case NOT_DIR:
-			printf("notdir %"PRIuMAX"\n%s\n",
-			       (uintmax_t)strlen(obj_name), obj_name);
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
+				printf("%s missing\n", obj_name);
+				break;
+			case SHORT_NAME_AMBIGUOUS:
+				printf("%s ambiguous\n", obj_name);
+				break;
+			case DANGLING_SYMLINK:
+				printf("dangling %"PRIuMAX"\n%s\n",
+					(uintmax_t)strlen(obj_name), obj_name);
+				break;
+			case SYMLINK_LOOP:
+				printf("loop %"PRIuMAX"\n%s\n",
+					(uintmax_t)strlen(obj_name), obj_name);
+				break;
+			case NOT_DIR:
+				printf("notdir %"PRIuMAX"\n%s\n",
+					(uintmax_t)strlen(obj_name), obj_name);
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
-		printf("symlink %"PRIuMAX"\n%s\n",
-		       (uintmax_t)ctx.symlink_path.len,
-		       ctx.symlink_path.buf);
-		fflush(stdout);
-		return;
+		if (ctx.mode == 0) {
+			printf("symlink %"PRIuMAX"\n%s\n",
+				(uintmax_t)ctx.symlink_path.len,
+				ctx.symlink_path.buf);
+			fflush(stdout);
+			return;
+		}
 	}
 
 	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
 }
 
+static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
+{
+	int retval = 0;
+	size_t i;
+	struct remote *remote = NULL;
+	struct object_id oid;
+	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
+	static struct transport *gtransport;
+	char *format = DEFAULT_FORMAT;
+
+	if (opt->format)
+		format = xstrdup(opt->format);
+
+	remote = remote_get(argv[0]);
+	if (!remote)
+		die(_("must supply valid remote when using --object-info"));
+	oid_array_clear(&object_info_oids);
+	for (i = 1; i < argc; i++) {
+		if (get_oid(argv[i], &oid))
+			die(_("malformed object id '%s'"), argv[i]);
+		oid_array_append(&object_info_oids, &oid);
+	}
+
+	gtransport = transport_get(remote, NULL);
+	if (gtransport->smart_options) {
+		size_t j;
+		int include_size = 0, include_type = 0;
+
+		remote_object_info = xcalloc(object_info_oids.nr, sizeof(struct object_info));
+		gtransport->smart_options->object_info = 1;
+		gtransport->smart_options->object_info_oids = &object_info_oids;
+		/**
+		 * 'size' is the only option currently supported.
+		 * Other options that are passed in the format will default to a
+		 * standard fetch request rather than object-info.
+		 */
+		if (strstr(format, "%(objectsize)")) {
+			string_list_append(&object_info_options, "size");
+			include_size = 1;
+		}
+		if (strstr(format, "%(objecttype)")) {
+			string_list_append(&object_info_options, "type");
+			include_type = 1;
+		}
+		if (strstr(format, "%(objectsize:disk)"))
+			die(_("objectsize:disk is currently not supported with remote-object-info"));
+		if (strstr(format, "%(deltabase)"))
+			die(_("deltabase is currently not supported with remote-object-info"));
+		if (object_info_options.nr > 0) {
+			gtransport->smart_options->object_info_options = &object_info_options;
+			for (j = 0; j < object_info_oids.nr; j++) {
+				if (include_size)
+					remote_object_info[j].sizep = xcalloc(1, sizeof(long));
+				if (include_type)
+					remote_object_info[j].typep = xcalloc(1, sizeof(enum object_type));
+			}
+			gtransport->smart_options->object_info_data = &remote_object_info;
+			retval = transport_fetch_refs(gtransport, NULL);
+		}
+	} else {
+		retval = -1;
+	}
+	return retval;
+}
+
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
@@ -538,6 +611,7 @@ typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
 struct queued_cmd {
 	parse_cmd_fn_t fn;
 	char *line;
+	const char *name;
 };
 
 static void parse_cmd_contents(struct batch_options *opt,
@@ -565,9 +639,49 @@ static const struct parse_cmd {
 } commands[] = {
 	{ "contents", parse_cmd_contents, 1},
 	{ "info", parse_cmd_info, 1},
+	{ "remote-object-info", parse_cmd_info, 1},
 	{ "flush", NULL, 0},
 };
 
+static void parse_remote_info(struct batch_options *opt,
+			   char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   const struct parse_cmd *p_cmd,
+			   struct queued_cmd *q_cmd)
+{
+	int count;
+	size_t i;
+	const char **argv;
+
+	count = split_cmdline(line, &argv);
+	if (get_remote_info(opt, count, argv))
+		goto cleanup;
+	opt->use_remote_info = 1;
+	data->skip_object_info = 1;
+	data->mark_query = 0;
+	for (i = 0; i < object_info_oids.nr; i++) {
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
+	for (i = 0; i < object_info_oids.nr; i++)
+		free_object_info_contents(&remote_object_info[i]);
+	free(remote_object_info);
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -579,8 +693,12 @@ static void dispatch_calls(struct batch_options *opt,
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
-		cmd[i].fn(opt, cmd[i].line, output, data);
+	for (i = 0; i < nr; i++) {
+		if (!strcmp(cmd[i].name, "remote-object-info"))
+			parse_remote_info(opt, cmd[i].line, output, data, NULL, &cmd[i]);
+		else
+			cmd[i].fn(opt, cmd[i].line, output, data);
+	}
 
 	fflush(stdout);
 }
@@ -640,11 +758,17 @@ static void batch_objects_command(struct batch_options *opt,
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
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1b85207694..69ee3f8330 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -2,6 +2,9 @@
 
 test_description='git cat-file'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_cmdmode_usage () {
@@ -1087,4 +1090,348 @@ test_expect_success 'batch-command flush without --buffer' '
 	grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
+# This section tests --batch-command with remote-object-info command
+# If a filter is not set, the filter defaults to "%(objectname) %(objectsize) %(objecttype)"
+# Since "%(objecttype)" is currently not supported by the command request, object-info,
+# the filters are set to "%(objectname) %(objectsize)".
+
+set_transport_variables () {
+    tree_sha1=$(git -C "$1" write-tree)
+	commit_sha1=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_sha1)
+	tag_sha1=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)
+	tag_size=$(strlen "$tag_content")
+}
+
+# Test --batch-command remote-object-info with 'git://' transport
+
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon --export-all --enable=receive-pack
+daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
+
+test_expect_success 'create repo to be served by git-daemon' '
+	git init "$daemon_parent" &&
+	echo_without_newline "$hello_content" > $daemon_parent/hello &&
+	git -C "$daemon_parent" update-index --add hello
+'
+
+set_transport_variables "$daemon_parent"
+
+test_expect_success 'batch-command remote-object-info git://' '
+	(
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
+		cd "$daemon_parent" &&
+
+		echo "$hello_sha1 blob $hello_size" >expect &&
+		echo "$tree_sha1 tree $tree_size" >>expect &&
+		echo "$commit_sha1 commit $commit_size" >>expect &&
+		echo "$tag_sha1 tag $tag_size" >>expect &&
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
+		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'batch-command --buffer remote-object-info git://' '
+	(
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
+	echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add hello
+'
+set_transport_variables "$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
+
+test_expect_success 'batch-command remote-object-info http://' '
+	(
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
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		echo "$hello_sha1 blob $hello_size" >expect &&
+		echo "$tree_sha1 tree $tree_size" >>expect &&
+		echo "$commit_sha1 commit $commit_size" >>expect &&
+		echo "$tag_sha1 tag $tag_size" >>expect &&
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
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(objectsize:disk)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_i18ngrep "objectsize:disk is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on unspported filter option (deltabase)' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git cat-file --batch-command="%(deltabase)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_i18ngrep "deltabase is currently not supported with remote-object-info" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_i18ngrep "object-info requires protocol v2" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on server with legacy protocol fallback' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+
+		test_must_fail git -c protocol.version=0 cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $hello_sha1
+		EOF
+		test_i18ngrep "object-info requires protocol v2" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on malformed OID' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		malformed_object_id="this_id_is_not_valid" &&
+
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $malformed_object_id
+		EOF
+		test_i18ngrep "malformed object id '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on malformed OID fallback' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+		malformed_object_id="this_id_is_not_valid" &&
+
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $malformed_object_id
+		EOF
+		test_i18ngrep "malformed object id '$malformed_object_id'" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on missing OID' '
+	git clone "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" missing_oid_repo &&
+	test_commit -C missing_oid_repo message1 c.txt &&
+	(
+		cd missing_oid_repo &&
+		object_id=$(git rev-parse message1:c.txt) &&
+		test_must_fail git cat-file --batch-command="%(objectname) %(objectsize)" 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $object_id
+		EOF
+		test_i18ngrep "object-info: not our ref $object_id" err
+	)
+'
+
+test_expect_success 'remote-object-info fails on missing OID fallback' '
+	(
+		cd missing_oid_repo &&
+		object_id=$(git rev-parse message1:c.txt) &&
+		test_must_fail git cat-file --batch-command 2>err <<-EOF &&
+		remote-object-info "$HTTPD_URL/smart/http_parent" $object_id
+		EOF
+		test_i18ngrep "fatal: remote error: upload-pack: not our ref $object_id" err
+	)
+'
+
+# Test --batch-command remote-object-info with 'file://' transport
+
+test_expect_success 'create repo to be served by file:// transport' '
+	git init server &&
+	git -C server config protocol.version 2 &&
+	echo_without_newline "$hello_content" > server/hello &&
+	git -C server update-index --add hello
+'
+
+set_transport_variables "server"
+
+test_expect_success 'batch-command remote-object-info file://' '
+	(
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
+		cd server &&
+
+		echo "$hello_sha1 blob $hello_size" >expect &&
+		echo "$tree_sha1 tree $tree_size" >>expect &&
+		echo "$commit_sha1 commit $commit_size" >>expect &&
+		echo "$tag_sha1 tag $tag_size" >>expect &&
+		git cat-file --batch-command >actual <<-EOF &&
+		remote-object-info "file://$(pwd)" $hello_sha1 $tree_sha1
+		remote-object-info "file://$(pwd)" $commit_sha1 $tag_sha1
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.36.0.rc2.10170.gb555eefa6f

