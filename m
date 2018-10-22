Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B946A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeJWGIf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:08:35 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39226 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeJWGIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:08:34 -0400
Received: by mail-qt1-f201.google.com with SMTP id 7-v6so11107253qtx.6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ly6to11fAMrIXvwVvnB06xCSsmYNDDN1Yje4zw1VoBk=;
        b=mC/Oknwm+icTqOmY6P9g6y095G2OmLI7KuFopxz6XYU3uZm0YGn5wfYKr5sENae1Eb
         TI+5QU4G2sa8lhzDMFQD4ROGeC+b+VycR2Ng+H+BfcTC30ZHMjJY97tKHwSyJ0TrOBIu
         md3Wz3mdnepoa3EmOK0IaWlsaPx5U7loy2+N6zesiZhgpYQg/1Q4Feu9CVadn/2Nhzr8
         DGsNqKAECrT2K5ZznO46PiZGL+jNxdxR06OFJhTS9OkluzS3PlZbDC5Vqp3JOkFsdKIz
         NET9IZY3X1qownXUZlpy6IDUAIhaMSEb0q0Rlk/0FuM3SEu9m9Jy4IAhNY3IuLHW8GCA
         hkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ly6to11fAMrIXvwVvnB06xCSsmYNDDN1Yje4zw1VoBk=;
        b=qqjd9FBdI96VSlEqYhkhdUspLPXckVlthcbywtvBqfknZb0jvXEe6diKqcJCBUU7Sw
         zwEaZBR85AZmgB/npHHcJz/bxf5uMQbQq1JIYf+TjbmYt9SACJoqNVjI+AKbBpNVS0+Y
         iCI8a/h53mmGSHbpfeH2jNCJxfZhk1AElOuOWfNGW20Gr3aISNQ19e63z2PZvjV1kLwi
         hzv/2oXf8E1HFjMKGvtAhcs/MGDgXgeWv5kT8MLOn09tlxEA3VRHqAwG5UdLBphoztIx
         6dPUYe9cM9uOdaNd5692v+s1Wlpyphx1/2npF5E30fpTsmHUNPN03wqQiUJ4eyiWaHVM
         iOWQ==
X-Gm-Message-State: ABuFfog/lmyYVdYX3BVTbR2a7mdbeEqShIwkgzi/b+Rjy27b8CYOvQau
        /163WL/TmiSQHj9iBl+D2+zW/1WLl2n+WKTUtN7Bxop8IPhmxcA/F3wVzBhB6kUWr8lONTiwlJt
        QJhMn0X4aM/hWR7HlvMJZRjNOEdGApSXI8VIGqYHqn+NWICg3vPIIJrztdaZJM2E=
X-Google-Smtp-Source: ACcGV60vXkrK0UWOrsMp/P0nrvI7LK9Hogq/oDv3534dBzPvZaAAsGNzMS5Tyok47nmcxx9dNR6dR9GLrD2eQg==
X-Received: by 2002:a0c:b8a0:: with SMTP id y32mr20506191qvf.25.1540244894408;
 Mon, 22 Oct 2018 14:48:14 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:48:11 -0700
In-Reply-To: <cover.1539990488.git.steadmon@google.com>
Message-Id: <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1539990488.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] archive: initialize archivers earlier
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialize archivers as soon as possible when running git-archive and
git-upload-archive. Various non-obvious behavior depends on having the
archivers initialized, such as determining the desired archival format
from the provided filename.

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
 archive.c                | 9 ++++++---
 archive.h                | 1 +
 builtin/archive.c        | 2 ++
 builtin/upload-archive.c | 1 +
 t/t5000-tar-tree.sh      | 6 ++++++
 5 files changed, 16 insertions(+), 3 deletions(-)

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
index 25d9116356..3f35ebcfe8 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -43,6 +43,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
+	init_archivers();
 	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
 			     the_repository, NULL, 1);
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2a97b27b0a..3e95fdf660 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -206,6 +206,12 @@ test_expect_success 'git archive with --output, override inferred format' '
 	test_cmp_bin b.tar d4.zip
 '
 
+test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
+	git archive --output=d5.tgz --remote=. HEAD &&
+	gzip -d -c < d5.tgz > d5.tar &&
+	test_cmp_bin b.tar d5.tar
+'
+
 test_expect_success 'git archive --list outside of a git repo' '
 	nongit git archive --list
 '
-- 
2.19.1.568.g152ad8e336-goog

