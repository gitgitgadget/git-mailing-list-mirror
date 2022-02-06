Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC448C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiBFWjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiBFWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692FFC0612A4
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u15so21724867wrt.3
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VWd48JVPenDDsYO1Af79wypuAyYJsrjtXWbFsDP1ERc=;
        b=Oz1KpgTycartwLez0EcQIl9PXQh/Y59GUHSdSciRy9/TuTJJiiuHiIiL3gG+VtArLV
         K20mKT5lJRMrfeaXczUkRfd1UXHSfGGqRa7P1M8RncJkwjWJuykPn0UWFjfSC+FN23NK
         541uG1wwCNhjItdeYqyH4/4iMi76+F564OZ89W0zXcDqO5BFXi6M/6uYAY7WryOxgen+
         Vs1WzWVTRmjpEWfl+ZY9MmI24adPJx0Y5yPGesyEOqzC0ahH584O23UaBVngCfzG/lra
         teeOSnFvlKs/5vlD+8QQ5oZGtBu5GsLxD5lOatF1MDjk1FXTtBIAm0AUjdeFylwjFxKK
         MbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VWd48JVPenDDsYO1Af79wypuAyYJsrjtXWbFsDP1ERc=;
        b=DfU9alUGI17MraxGZKrBXV72FFRG9xyuwb10oAHvQ7Ubaay3kx5C7Y/OoGVagXA0Z/
         qxxjrqGFDFAcmMxrtlKmQ6L/mfFjWKI/UlKJqXh/x3nzMKpl9EiNGoQHB+I/xYQPFUjd
         wBy+oZ/yRd+6O/s5Cz9YqpAtE6MDKrVAga/Lj0pSWYdOhuF4aut4rPJ0rW8LNOTFfRec
         3K1FJBl2RLT/t/5XLNfs1EsDpBXftyiKjozv+lHJUCQ1I3cjHUd/1LYMMzHOjEthwFVM
         VZPDI6H1lzGnCHSJHF+ST+s8DCzIGjR6dWsqFNzWBIRgrueAqU7NujX1OabIOdC74xaM
         CVkg==
X-Gm-Message-State: AOAM531mVNsGwTsge3wgsXiNwadfZbVir3PKnXX5erwyHfFUw5dkqH3q
        jlgfaP4bu2NskkC0WaSXW5EiS8NVwfo=
X-Google-Smtp-Source: ABdhPJzdDvOruixNzWikoSfftWqieEJ/Q9R+9H1YPbkhoVeXlcjdg9J7rp9vILSw3/oL16PrmrdjFA==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr2561588wrq.368.1644187149827;
        Sun, 06 Feb 2022 14:39:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm8442122wmq.24.2022.02.06.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:09 -0800 (PST)
Message-Id: <0d570137bb6aef675f4f5d74d140ace1dfba5eb7.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:03 +0000
Subject: [PATCH v2 3/6] Implement `scalar diagnose`
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

Over the course of Scalar's development, it became obvious that there is
a need for a command that can gather all kinds of useful information
that can help identify the most typical problems with large
worktrees/repositories.

The `diagnose` command is the culmination of this hard-won knowledge: it
gathers the installed hooks, the config, a couple statistics describing
the data shape, among other pieces of information, and then wraps
everything up in a tidy, neat `.zip` archive.

Note: originally, Scalar was implemented in C# using the .NET API, where
we had the luxury of a comprehensive standard library that includes
basic functionality such as writing a `.zip` file. In the C version, we
lack such a commodity. Rather than introducing a dependency on, say,
libzip, we slightly abuse Git's `archive` command: Instead of writing
the `.zip` file directly, we stage the file contents in a Git index of a
temporary, bare repository, only to let `git archive` have at it, and
finally removing the temporary repository.

Also note: Due to the frequently-spawned `git hash-object` processes,
this command is quite a bit slow on Windows. Should it turn out to be a
big problem, the lack of a batch mode of the `hash-object` command could
potentially be worked around via using `git fast-import` with a crafted
`stdin`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 143 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  12 +++
 contrib/scalar/t/t9099-scalar.sh |  14 +++
 3 files changed, 169 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 00dcd4b50ef..30ce0799c7a 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
+#include "archive.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -261,6 +262,44 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int add_directory_to_archiver(struct strvec *archiver_args,
+					  const char *path, int recurse)
+{
+	int at_root = !*path;
+	DIR *dir = opendir(at_root ? "." : path);
+	struct dirent *e;
+	struct strbuf buf = STRBUF_INIT;
+	size_t len;
+	int res = 0;
+
+	if (!dir)
+		return error(_("could not open directory '%s'"), path);
+
+	if (!at_root)
+		strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+	strvec_pushf(archiver_args, "--prefix=%s", buf.buf);
+
+	while (!res && (e = readdir(dir))) {
+		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
+			continue;
+
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, e->d_name);
+
+		if (e->d_type == DT_REG)
+			strvec_pushf(archiver_args, "--add-file=%s", buf.buf);
+		else if (e->d_type != DT_DIR)
+			res = -1;
+		else if (recurse)
+		     add_directory_to_archiver(archiver_args, buf.buf, recurse);
+	}
+
+	closedir(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
 /* printf-style interface, expects `<key>=<value>` argument */
 static int set_config(const char *fmt, ...)
 {
@@ -501,6 +540,109 @@ cleanup:
 	return res;
 }
 
+static int cmd_diagnose(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar diagnose [<enlistment>]"),
+		NULL
+	};
+	struct strbuf zip_path = STRBUF_INIT;
+	struct strvec archiver_args = STRVEC_INIT;
+	char **argv_copy = NULL;
+	int stdout_fd = -1, archiver_fd = -1;
+	time_t now = time(NULL);
+	struct tm tm;
+	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+	size_t off;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
+
+	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
+	strbuf_addftime(&zip_path,
+			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&zip_path, ".zip");
+	switch (safe_create_leading_directories(zip_path.buf)) {
+	case SCLD_EXISTS:
+	case SCLD_OK:
+		break;
+	default:
+		error_errno(_("could not create directory for '%s'"),
+			    zip_path.buf);
+		goto diagnose_cleanup;
+	}
+	stdout_fd = dup(1);
+	if (stdout_fd < 0) {
+		res = error_errno(_("could not duplicate stdout"));
+		goto diagnose_cleanup;
+	}
+
+	archiver_fd = xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
+		res = error_errno(_("could not redirect output"));
+		goto diagnose_cleanup;
+	}
+
+	init_zip_archiver();
+	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
+
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf,
+		      "--add-file-with-content=diagnostics.log:"
+		      "Collecting diagnostic info\n\n");
+	get_version_info(&buf, 1);
+
+	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
+	off = strchr(buf.buf, ':') + 1 - buf.buf;
+	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
+	strvec_push(&archiver_args, buf.buf);
+
+	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+		goto diagnose_cleanup;
+
+	strvec_pushl(&archiver_args, "--prefix=",
+		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
+
+	/* `write_archive()` modifies the `argv` passed to it. Let it. */
+	argv_copy = xmemdupz(archiver_args.v,
+			     sizeof(char *) * archiver_args.nr);
+	res = write_archive(archiver_args.nr, (const char **)argv_copy, NULL,
+			    the_repository, NULL, 0);
+	if (res) {
+		error(_("failed to write archive"));
+		goto diagnose_cleanup;
+	}
+
+	if (!res)
+		printf("\n"
+		       "Diagnostics complete.\n"
+		       "All of the gathered info is captured in '%s'\n",
+		       zip_path.buf);
+
+diagnose_cleanup:
+	if (archiver_fd >= 0) {
+		close(1);
+		dup2(stdout_fd, 1);
+	}
+	free(argv_copy);
+	strvec_clear(&archiver_args);
+	strbuf_release(&zip_path);
+	strbuf_release(&path);
+	strbuf_release(&buf);
+
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
@@ -802,6 +944,7 @@ static struct {
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
 	{ "version", cmd_version },
+	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..22583fe046e 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar diagnose [<enlistment>]
 scalar delete <enlistment>
 
 DESCRIPTION
@@ -129,6 +130,17 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Diagnose
+~~~~~~~~
+
+diagnose [<enlistment>]::
+    When reporting issues with Scalar, it is often helpful to provide the
+    information gathered by this command, including logs and certain
+    statistics describing the data shape of the current enlistment.
++
+The output of this command is a `.zip` file that is written into
+a directory adjacent to the worktree in the `src` directory.
+
 Delete
 ~~~~~~
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 9d83fdf25e8..bbd07a44426 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -90,4 +90,18 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 	grep "cloned. does not exist" err
 '
 
+SQ="'"
+test_expect_success UNZIP 'scalar diagnose' '
+	scalar clone "file://$(pwd)" cloned --single-branch &&
+	scalar diagnose cloned >out &&
+	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
+	zip_path=$(cat zip_path) &&
+	test -n "$zip_path" &&
+	unzip -v "$zip_path" &&
+	folder=${zip_path%.zip} &&
+	test_path_is_missing "$folder" &&
+	unzip -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
gitgitgadget

