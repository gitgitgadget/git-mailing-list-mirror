Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B398C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbiBFWjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbiBFWjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F253C061348
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so21691402wra.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aBKUUrI4uvsCfdz7CTI77NcsvhLomTqrbD8OMq5shmg=;
        b=KPYIIIQJQvQy9PelkbGuZXZxwashhVnrrDgQ8ZN72SF3vfOVPcA8uYyuBdYUvKOAQd
         +rQG67c4hx1pUWncefGk6/MX0HWi4e6ZK061qewBFozBr1qllMqMGKQkj5hg8oU8/D/1
         JgDvmJlwj+voCtnxnmsJQ8svRASjoZl5eL4+DVyuBc4wjkWHr1SUA4fkS5D+3rqVA4KS
         a7yQ4t6FgKW0uSf8b+vYSsvfXVlYXupltcuSOzO2qaGSRYry7kaZHu0K8KCV/JoAIeqM
         MlYFMX3LZg2IrDeX045kYrq3qNv4YL1bsI03u+WK7F2aehxVv3AE8AwvC3JoEfS8TvOc
         Cr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aBKUUrI4uvsCfdz7CTI77NcsvhLomTqrbD8OMq5shmg=;
        b=lBuGZAVYOWfbg+LFxtqlfNq//5kphkIRDhf5Y1iWLktyZNL5Mf0V8+/ZmqYatuvANq
         p18aCxq/FyBtes7RmAMj+3yszN3eRSjMGMPjV+3C8gLnifzlRD4kCmOqbqLL7dhCd35H
         axWgtW/vUjsE3+YGV4dPUS1yq+NVtKQStgA998DqpBNKfV3cYAhIEnekQaBE4RQq2nWu
         7HCJAFp666QqunTXWaGeVcR5Ib68ulOkspvUVGaqIwgG/UsZx3auda/AkphcHctLy8o8
         Y8eQvk130kMOecQ66zSd5tjp2J+HJiy/nsFV1UDwwI9DhI0cVMY9IqmozxM2yNrcDmxX
         5u+Q==
X-Gm-Message-State: AOAM5312W8iwPvzXVE2yxvY37i7OfntQ6AFXJC1jYe1u0XvX+ud3hUJM
        Uc8P5OCG719GliQSdHH+cebwu5KcUXg=
X-Google-Smtp-Source: ABdhPJzb4dwlgvSrLc9o1228esc89OBp8RMI49Vjd2P8OJDCofFGkE1dh9pAJUlpKEstvAihKrbveQ==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr7805387wrz.16.1644187148242;
        Sun, 06 Feb 2022 14:39:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm17696867wmq.17.2022.02.06.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:07 -0800 (PST)
Message-Id: <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:01 +0000
Subject: [PATCH v2 1/6] archive: optionally add "virtual" files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the `--add-file-with-content=<path>:<content>` option, `git
archive` now supports use cases where relatively trivial files need to
be added that do not exist on disk.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-archive.txt | 11 ++++++++
 archive.c                     | 51 +++++++++++++++++++++++++++++------
 t/t5003-archive-zip.sh        | 12 +++++++++
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a7834..1b52a0a65a1 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -61,6 +61,17 @@ OPTIONS
 	by concatenating the value for `--prefix` (if any) and the
 	basename of <file>.
 
+--add-file-with-content=<path>:<content>::
+	Add the specified contents to the archive.  Can be repeated to add
+	multiple files.  The path of the file in the archive is built
+	by concatenating the value for `--prefix` (if any) and the
+	basename of <file>.
++
+The `<path>` cannot contain any colon, the file mode is limited to
+a regular file, and the option may be subject platform-dependent
+command-line limits. For non-trivial cases, write an untracked file
+and use `--add-file` instead.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index a3bbb091256..172efd690c3 100644
--- a/archive.c
+++ b/archive.c
@@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 struct extra_file_info {
 	char *base;
 	struct stat stat;
+	void *content;
 };
 
 int write_archive_entries(struct archiver_args *args,
@@ -337,7 +338,13 @@ int write_archive_entries(struct archiver_args *args,
 		strbuf_addstr(&path_in_archive, basename(path));
 
 		strbuf_reset(&content);
-		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
+		if (info->content)
+			err = write_entry(args, &fake_oid, path_in_archive.buf,
+					  path_in_archive.len,
+					  info->stat.st_mode,
+					  info->content, info->stat.st_size);
+		else if (strbuf_read_file(&content, path,
+					  info->stat.st_size) < 0)
 			err = error_errno(_("could not read '%s'"), path);
 		else
 			err = write_entry(args, &fake_oid, path_in_archive.buf,
@@ -493,6 +500,7 @@ static void extra_file_info_clear(void *util, const char *str)
 {
 	struct extra_file_info *info = util;
 	free(info->base);
+	free(info->content);
 	free(info);
 }
 
@@ -514,14 +522,38 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg)
 		return -1;
 
-	path = prefix_filename(args->prefix, arg);
-	item = string_list_append_nodup(&args->extra_files, path);
-	item->util = info = xmalloc(sizeof(*info));
+	info = xmalloc(sizeof(*info));
 	info->base = xstrdup_or_null(base);
-	if (stat(path, &info->stat))
-		die(_("File not found: %s"), path);
-	if (!S_ISREG(info->stat.st_mode))
-		die(_("Not a regular file: %s"), path);
+
+	if (strcmp(opt->long_name, "add-file-with-content")) {
+		path = prefix_filename(args->prefix, arg);
+		if (stat(path, &info->stat))
+			die(_("File not found: %s"), path);
+		if (!S_ISREG(info->stat.st_mode))
+			die(_("Not a regular file: %s"), path);
+		info->content = NULL; /* read the file later */
+	} else {
+		const char *colon = strchr(arg, ':');
+		char *p;
+
+		if (!colon)
+			die(_("missing colon: '%s'"), arg);
+
+		p = xstrndup(arg, colon - arg);
+		if (!args->prefix)
+			path = p;
+		else {
+			path = prefix_filename(args->prefix, p);
+			free(p);
+		}
+		memset(&info->stat, 0, sizeof(info->stat));
+		info->stat.st_mode = S_IFREG | 0644;
+		info->content = xstrdup(colon + 1);
+		info->stat.st_size = strlen(info->content);
+	}
+	item = string_list_append_nodup(&args->extra_files, path);
+	item->util = info;
+
 	return 0;
 }
 
@@ -554,6 +586,9 @@ static int parse_archive_args(int argc, const char **argv,
 		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
 		  N_("add untracked file to archive"), 0, add_file_cb,
 		  (intptr_t)&base },
+		{ OPTION_CALLBACK, 0, "add-file-with-content", args,
+		  N_("file"), N_("add untracked file to archive"), 0,
+		  add_file_cb, (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 1e6d18b140e..8ff1257f1a0 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -206,6 +206,18 @@ test_expect_success 'git archive --format=zip --add-file' '
 check_zip with_untracked
 check_added with_untracked untracked untracked
 
+test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
+	git archive --format=zip >with_file_with_content.zip \
+		--add-file-with-content=hello:world $EMPTY_TREE &&
+	test_when_finished "rm -rf tmp-unpack" &&
+	mkdir tmp-unpack && (
+		cd tmp-unpack &&
+		"$GIT_UNZIP" ../with_file_with_content.zip &&
+		test_path_is_file hello &&
+		test world = $(cat hello)
+	)
+'
+
 test_expect_success 'git archive --format=zip --add-file twice' '
 	echo untracked >untracked &&
 	git archive --format=zip --prefix=one/ --add-file=untracked \
-- 
gitgitgadget

