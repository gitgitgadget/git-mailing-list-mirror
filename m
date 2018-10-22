Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9851F453
	for <e@80x24.org>; Mon, 22 Oct 2018 23:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeJWIPe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:15:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49305 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWIPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:15:34 -0400
Received: by mail-pf1-f202.google.com with SMTP id y73-v6so27772490pfi.16
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NMpKMjC7PLmQJKUjpejYSrfmag4imLbgdMR+tbnfU9E=;
        b=XZIM3kUFuHha/Wavc3ZoHcwDvcexlQ2HouikP+BRuKhq2wMfEBUs/68rut++TTWuCc
         OBaRkM0tD0A9veLJsrkTeBN0B+odJ6sTjDhR9UYogLGgarcD1OfsfLHhFAcZPG18ZWSC
         LT/5tmfXvl2KR/XjAMh6Gp2diYypLt97me+O2eKRdeOAvZojW1cOvyn9GKRXxHz28AA2
         uNNp2pGtbcp0kYMBc+6xcrtzPweWU9/CqGkTIKF6GQJvp7QyvBgCvLToCuG8LACammBn
         AuDKJdLBq3XTIjmlDBqTynVMvMflpRBDnPGZnbsN5nnrIDBmdrLtJChxJZrIBBUaa8Oo
         DxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NMpKMjC7PLmQJKUjpejYSrfmag4imLbgdMR+tbnfU9E=;
        b=s/JQjYkSYNGJsbah/jLIah+HU6CxuVDWfgJ1eWOXD8TbS9hp4sr3fRzA5tlVPe1M6z
         jEDV91yd58bbBfK2k/M4f3OPNamm+KULcbvLqxLnrWboyzX4HN/rjoNdAhmzyONBxp1S
         xmsaeaQtEuTWV957rezFqMwdJp0qEDEVS+BGrcgKuiaK1gq/u3w96joo9gAk7sBrwxVL
         IQGrI1TH0arxu3bjpqS7CI9MqSqxyvrlKmTkKG4wYwVOjJOQhi0bWQVb0ZH6MjitJ8i+
         6+dyMT05EFXifDHZzfjpSG2MJCKHgmu/fPWERG0bUaeBgF+apqYBAn/JU1SHoPygRziQ
         66wA==
X-Gm-Message-State: ABuFfog6k+fnHv0M4nUQC9i52SRl8BVzakgmJ3dTb0T1I0LDegkpLNhc
        cPdwHhXHRRdo1W7wVqMA/OboySvnxW7mYn2AwqP/fyCVxiksdbYNyQF6hET0gdLEFQ/RwCDtLOs
        9QRGfT9wawoWa3WiTNcn4oqx+2tSoAYJdO38492qBzouqOjMCsPrZtBLub6QAFBM=
X-Google-Smtp-Source: ACcGV63cvvcZ4F7YaBjElPHfiSRSH6e9rOgZFsV03GIEwKf9bP2PzTHoZyBeS26SObmwlkovigvrD1xjEpIa9g==
X-Received: by 2002:a62:1981:: with SMTP id 123-v6mr16716085pfz.65.1540252489424;
 Mon, 22 Oct 2018 16:54:49 -0700 (PDT)
Date:   Mon, 22 Oct 2018 16:54:47 -0700
In-Reply-To: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
Message-Id: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
Mime-Version: 1.0
References: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v3] archive: initialize archivers earlier
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
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
Range-diff against v2:
1:  bc6f20274d ! 1:  39a4e7bf8f archive: initialize archivers earlier
    @@ -78,26 +78,43 @@
      --- a/builtin/upload-archive.c
      +++ b/builtin/upload-archive.c
     @@
    - 	}
    + 	if (!enter_repo(argv[1], 0))
    + 		die("'%s' does not appear to be a git repository", argv[1]);
      
    - 	/* parse all options sent by the client */
     +	init_archivers();
    - 	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
    - 			     the_repository, NULL, 1);
    - }
    ++
    + 	/* put received options in sent_argv[] */
    + 	argv_array_push(&sent_argv, "git-upload-archive");
    + 	for (;;) {
     
      diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
      --- a/t/t5000-tar-tree.sh
      +++ b/t/t5000-tar-tree.sh
     @@
    + 
    + test_lazy_prereq GZIP 'gzip --version'
    + 
    ++test_lazy_prereq ZIP 'zip --version'
    ++
    + get_pax_header() {
    + 	file=$1
    + 	header=$2=
    +@@
      	test_cmp_bin b.tar d4.zip
      '
      
    -+test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
    ++test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
     +	git archive --output=d5.tgz --remote=. HEAD &&
     +	gzip -d -c < d5.tgz > d5.tar &&
     +	test_cmp_bin b.tar d5.tar
     +'
    ++
    ++test_expect_success ZIP 'git archive with --output and --remote creates .zip' '
    ++	git archive --output=d6.zip --remote=. HEAD &&
    ++	zip -sf d6.zip | sed "/^[^ ]/d" | sed "s/^  //" | sort > zip_manifest &&
    ++	"$TAR" tf b.tar | sort > tar_manifest &&
    ++	test_cmp zip_manifest tar_manifest
    ++'
     +
      test_expect_success 'git archive --list outside of a git repo' '
      	nongit git archive --list

 archive.c                |  9 ++++++---
 archive.h                |  1 +
 builtin/archive.c        |  2 ++
 builtin/upload-archive.c |  2 ++
 t/t5000-tar-tree.sh      | 15 +++++++++++++++
 5 files changed, 26 insertions(+), 3 deletions(-)

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
index 2a97b27b0a..cfd5ca492f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -39,6 +39,8 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
 
 test_lazy_prereq GZIP 'gzip --version'
 
+test_lazy_prereq ZIP 'zip --version'
+
 get_pax_header() {
 	file=$1
 	header=$2=
@@ -206,6 +208,19 @@ test_expect_success 'git archive with --output, override inferred format' '
 	test_cmp_bin b.tar d4.zip
 '
 
+test_expect_success GZIP 'git archive with --output and --remote creates .tgz' '
+	git archive --output=d5.tgz --remote=. HEAD &&
+	gzip -d -c < d5.tgz > d5.tar &&
+	test_cmp_bin b.tar d5.tar
+'
+
+test_expect_success ZIP 'git archive with --output and --remote creates .zip' '
+	git archive --output=d6.zip --remote=. HEAD &&
+	zip -sf d6.zip | sed "/^[^ ]/d" | sed "s/^  //" | sort > zip_manifest &&
+	"$TAR" tf b.tar | sort > tar_manifest &&
+	test_cmp zip_manifest tar_manifest
+'
+
 test_expect_success 'git archive --list outside of a git repo' '
 	nongit git archive --list
 '
-- 
2.19.1.568.g152ad8e336-goog

