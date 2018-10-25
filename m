Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8073B1F454
	for <e@80x24.org>; Thu, 25 Oct 2018 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeJZFGb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:06:31 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:44527 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:06:31 -0400
Received: by mail-it1-f201.google.com with SMTP id k69-v6so2215543ite.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DsVphwlz36UnHbXY6sN3S4Cn26w60aLN6xboQCiPjOs=;
        b=Mm2V7QHOobZEEHE2/U+p8AKj+LIxmXGy813ughN2NurCJ95fFx7cmJwvmNt6uCCuIy
         oqWu0evyaHABuGETloW+3cwTuaOmCPBSH7v9BJHMbQpf3mFezcOMYxnK8axPFOxzvJGL
         vUWIsSfC2P5jV09oKXGlRSPQoQQ3JS6/6FG4V6KBrtYXvbhVmQ+25Y/HWdJAMOno+4V0
         YgBnj7FRkIuDo3i1b5BYwoodehNjPpawR/y9pt3GCJGOsEUhzjTqlqNvSkXhQG1i/j9N
         1vN3Gvos2rpPvazvHrSpvH7zieTvsbFO3Qtco7k+4eh2ijkiiK/N216Yt4fq+hqYKWdC
         6GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DsVphwlz36UnHbXY6sN3S4Cn26w60aLN6xboQCiPjOs=;
        b=MAYA9zJVnI9hTLVgRVKh1u5iz6lYl7enwryOVKuH04Pm+yaIDF5Co4yOl5BVjQWAaL
         za8Tj5uxcMrzcrlcNEVP2pkOZRcRkxTXPV4WyrWZ2YwrQT2aEWyP8S4IPlEB/NL9KYAH
         9sKAP1bF469rWPB1FXnlGbdYj2BJyg8v7/bgKRzByJdn9++iWrQse6JEE57Rzl5Vn9+k
         ZH3WxbyvW03MGXc2rewP/3/XMICafVNYJmFYDuhn8lvaUzczEfJbWjjYg4rUXHYo9bfL
         Rbi4nHPXe6QYbEVbA/4UmQC4UE8HNESLPw1NrIF5eQ60nyZVYRDyG8MyePpGXStpHcXO
         zofw==
X-Gm-Message-State: AGRZ1gJo+6cOLVOETaZa/qV/uFYcrEplwGtW7HxHhlRn058o+YuNiU26
        pfDeZS1aAf/YIR53diL5pBVukxwoOI8WAkXYRMnNkeXt4XKA5rZEQnI0Vq9vvEW9cxr1UnUDwtA
        JXmLXtRnGvsAJXwyrrDV4APdhNSXiqZ62e15LH0gPHPsnUPmJ2DReDfiQJDj2KII=
X-Google-Smtp-Source: AJdET5cldH7urgaBuQ/S8fenZa1r3apNtGSaHeLlkmjKTX1yMI9P8b3DpQPlrz29qfZ1gvoq6ymJ15aWQd2U2Q==
X-Received: by 2002:a24:6794:: with SMTP id u142-v6mr577852itc.9.1540499537558;
 Thu, 25 Oct 2018 13:32:17 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:32:14 -0700
In-Reply-To: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
Message-Id: <c85673cee76c1c4a7e2b2a489d6139f5c89ba88c.1540499413.git.steadmon@google.com>
Mime-Version: 1.0
References: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v5] archive: initialize archivers earlier
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialize archivers as soon as possible when running git-archive.
Various non-obvious behavior depends on having the archivers
initialized, such as determining the desired archival format from the
provided filename.

Since 08716b3c11 ("archive: refactor file extension format-guessing",
2011-06-21), archive_format_from_filename() has used the registered
archivers to match filenames (provided via --output) to archival
formats. However, when git-archive is executed with --remote, format
detection happens before the archivers have been registered. This causes
archives from remotes to always be generated as TAR files, regardless of
the actual filename (unless an explicit --format is provided).

This patch fixes that behavior; archival format is determined properly
from the output filename, even when --remote is used.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Helped-by: Jeff King <peff@peff.net>
---
Range-diff against v4:
1:  1d7b070928 ! 1:  c85673cee7 archive: initialize archivers earlier
    @@ -96,7 +96,7 @@
      
     +test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
     +	git archive --output=d5.tgz --remote=. HEAD &&
    -+	gzip -d -c < d5.tgz > d5.tar &&
    ++	gzip -d -c <d5.tgz >d5.tar &&
     +	test_cmp_bin b.tar d5.tar
     +'
     +

 archive.c                | 9 ++++++---
 archive.h                | 1 +
 builtin/archive.c        | 2 ++
 builtin/upload-archive.c | 2 ++
 t/t5000-tar-tree.sh      | 6 ++++++
 t/t5003-archive-zip.sh   | 7 ++++++-
 6 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index c1870105eb..ce0f8a0362 100644
--- a/archive.c
+++ b/archive.c
@@ -29,6 +29,12 @@ void register_archiver(struct archiver *ar)
 	archivers[nr_archivers++] = ar;
 }
 
+void init_archivers(void)
+{
+	init_tar_archiver();
+	init_zip_archiver();
+}
+
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
                          struct strbuf *buf)
@@ -531,9 +537,6 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
 	git_config(git_default_config, NULL);
 
-	init_tar_archiver();
-	init_zip_archiver();
-
 	args.repo = repo;
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
diff --git a/archive.h b/archive.h
index d4f97a00f5..21ac010699 100644
--- a/archive.h
+++ b/archive.h
@@ -43,6 +43,7 @@ extern void register_archiver(struct archiver *);
 
 extern void init_tar_archiver(void);
 extern void init_zip_archiver(void);
+extern void init_archivers(void);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
diff --git a/builtin/archive.c b/builtin/archive.c
index e74f675390..d2455237ce 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -97,6 +97,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
+	init_archivers();
+
 	if (output)
 		create_output_file(output);
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 25d9116356..018879737a 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -28,6 +28,8 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
+	init_archivers();
+
 	/* put received options in sent_argv[] */
 	argv_array_push(&sent_argv, "git-upload-archive");
 	for (;;) {
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2a97b27b0a..602bfd9574 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -206,6 +206,12 @@ test_expect_success 'git archive with --output, override inferred format' '
 	test_cmp_bin b.tar d4.zip
 '
 
+test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
+	git archive --output=d5.tgz --remote=. HEAD &&
+	gzip -d -c <d5.tgz >d5.tar &&
+	test_cmp_bin b.tar d5.tar
+'
+
 test_expect_success 'git archive --list outside of a git repo' '
 	nongit git archive --list
 '
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 55c7870997..106eddbd85 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -158,11 +158,16 @@ test_expect_success 'git archive --format=zip with --output' \
     'git archive --format=zip --output=d2.zip HEAD &&
     test_cmp_bin d.zip d2.zip'
 
-test_expect_success 'git archive with --output, inferring format' '
+test_expect_success 'git archive with --output, inferring format (local)' '
 	git archive --output=d3.zip HEAD &&
 	test_cmp_bin d.zip d3.zip
 '
 
+test_expect_success 'git archive with --output, inferring format (remote)' '
+	git archive --remote=. --output=d4.zip HEAD &&
+	test_cmp_bin d.zip d4.zip
+'
+
 test_expect_success \
     'git archive --format=zip with prefix' \
     'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
-- 
2.19.1.568.g152ad8e336-goog

