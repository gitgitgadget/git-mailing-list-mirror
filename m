Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB5C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbiEDP3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352581AbiEDP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F54DEC9
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1048444wmn.1
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v2bVxgiXyAJb5mJiV2jLmDxYyCHvoUPxWAqoNPpKzrk=;
        b=PDjNsLGwEeGiJ4QuVVgYGVssIcLv4sY0Fufo76eqKjEhnAKto9BVuabPY41r0litoj
         bmWkkVYeU+Uzzi62N3PB5ksCBA+i45+VwWlv+cWNjlT8CvGQ/fd3yyfLsB1S5SJQ1/od
         dY9wXzVclR58SEnOFa0fT6V5uw0YLbs1tr5XY4ha9N+Kr5sISSaI75sFH5uwFDX8wuuw
         RE4ylWvKYzFOLQfYhDx50wH3+asJrVyZPYGiLBWU5AjkC9PPjCJkAuDJQNxGepHoHjCk
         GsQ3SX/fSLyUgN2hmxD0gO5kA0DisnDgvNCD3dQbhT459Jecf/CqkSbmz+oPSA/RcNST
         5LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v2bVxgiXyAJb5mJiV2jLmDxYyCHvoUPxWAqoNPpKzrk=;
        b=GupXNOE4AeW0d2KQMo7KaS3PZ8MHCi7qfVK6xFazxfXtQcz31rv5OHtsfWoZB+TZRA
         bp8FSqs+Lkn3JkQNOpyKulxv7vPslvsH7h8JLD/BQQ/OBOpsx2ZyPlmNH6cgs6xyfLkp
         dQPnJB3Nn3JE5IDnhTMSsL/2StB8LBu8kcxUTOMFTZ567trjep9W90fiLl3H+lW6NvXW
         Vg/4xgCIXbkF/yH7OmLbWxVlWI9sJ4fD+r96l73q9pZcvdV4Qwjk6q8X/MZKL5bFkKic
         yGbFEBXVr71eThM6mGWDMJ5OFoHCWX+E2aMJloZHVsRxconoVXaZBYdYIjLBG9gWqi2e
         7arA==
X-Gm-Message-State: AOAM532jtsO7aoyqYBjNpfeEjqacK3IV4fz9WrImZNBdySfLBTQtt2S/
        gkP3YkSLcp5L0xRJriop74N+DyeroEk=
X-Google-Smtp-Source: ABdhPJzksD2VdGzcWxaTI8+MqOoLfngaIeGYK6HRBfXtdABiJXHsJblKTYK6FP9dy+odXfomCQZO+A==
X-Received: by 2002:a7b:c088:0:b0:394:451e:34a0 with SMTP id r8-20020a7bc088000000b00394451e34a0mr16397wmh.10.1651677922347;
        Wed, 04 May 2022 08:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020adfc586000000b0020c5253d908sm12636711wrg.84.2022.05.04.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:21 -0700 (PDT)
Message-Id: <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:13 +0000
Subject: [PATCH v3 1/7] archive: optionally add "virtual" files
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

This will allow us to generate `.zip` files with generated content,
without having to add said content to the object database and without
having to write it out to disk.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-archive.txt | 11 ++++++++
 archive.c                     | 51 +++++++++++++++++++++++++++++------
 t/t5003-archive-zip.sh        | 12 +++++++++
 3 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a7834..a0edc9167b2 100644
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
+a regular file, and the option may be subject to platform-dependent
+command-line limits. For non-trivial cases, write an untracked file
+and use `--add-file` instead.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index a3bbb091256..d798624cd5f 100644
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
+	if (!strcmp(opt->long_name, "add-file")) {
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
+		  N_("path:content"), N_("add untracked file to archive"), 0,
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

