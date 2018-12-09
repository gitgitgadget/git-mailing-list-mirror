Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4FD20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLIKpX (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40163 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeLIKpS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so5957412lfe.7
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPPEL3E01UJjkqxy8tiRUQglXLfNt4BsYCm/Lo5/7vY=;
        b=vXKsBY8zuGxv6Ctbm2xg2h9VAyy/cyHvm8NxYsyaEMQiHwyCGxBChK5NgIWZVn/3T+
         yl9ovrHbxowG3Jo6btLMGtj6If4UjtOYEjw9We4XxSYfV9ze1sex5uSlsJ2MXB8i13Zx
         0EfVzLlmKJ8CZOcjGKWEKOPKjnGwOHl8E+psm7UrijEAOs8h5GU6qy18vBp9SG/U+IOt
         Y5N6xl9vYDk735OqRXfN7y2SDrB0iO9iPzbRICXSk1aQmKRGb5GbTAgZQw5tiBBnyFrW
         hL8a/7pIii2og7iPGN7e4otlFVNAUYxaEasfm7z0BCdMtIPdPGGNqiIADBCcv3Va1+0F
         sT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPPEL3E01UJjkqxy8tiRUQglXLfNt4BsYCm/Lo5/7vY=;
        b=j9ATVe/CZy5hwMO7cbnt3frJxi9nAVOUIuOpe7cfQmxM1PmeUI9yfsjPlZCToGUlOD
         LPCruf2gKFOKTSj+Tnk7UzsMUBVfsf5LkY+W3ux/cWpMz/76mrqQj8NK8ybTRTES6EgB
         ROqhwQOleCT7+vnMx5HyRp6XoZT1wX7szsgyY4tX3TNe9DhoP2bbUhCxl1TPxBtIscIV
         idhewLVAPc3xRD58bSl1yFpaMCcvdkz6DdKcS9c6gQ8Lg/iNX5zBI1if40vpScpR5+kM
         jQ1YK/3XJuYafn5kBegofNEA/gPMtVdkRavQJVgwzgw/TEnL9Rp94hP7LKTzg1H2453t
         EY+Q==
X-Gm-Message-State: AA+aEWY6pCyz7hf0Ui+9jSpBpyI3oVHsVB/iafC+872HGBfAuqyITeIg
        qU9SwRcisQpEEyPSLAt3eSx+UBKe
X-Google-Smtp-Source: AFSGD/WYbe880s+lV4++PYE3bplgkgDwSM2ww0wy3gCgtwnEqqeXLoGyjAokCAkLnoCBAYephk1/EA==
X-Received: by 2002:a19:6514:: with SMTP id z20mr4539411lfb.31.1544352315048;
        Sun, 09 Dec 2018 02:45:15 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:14 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/24] backup-log: add prune command
Date:   Sun,  9 Dec 2018 11:44:08 +0100
Message-Id: <20181209104419.12639-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 backup-log.c         | 71 ++++++++++++++++++++++++++++++++++++++++++++
 backup-log.h         |  3 ++
 builtin/backup-log.c | 17 +++++++++++
 3 files changed, 91 insertions(+)

diff --git a/backup-log.c b/backup-log.c
index 49f2ce68fe..5e38725981 100644
--- a/backup-log.c
+++ b/backup-log.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "backup-log.h"
+#include "blob.h"
 #include "lockfile.h"
+#include "object-store.h"
 #include "strbuf.h"
 
 void bkl_append(struct strbuf *output, const char *path,
@@ -217,3 +219,72 @@ int bkl_parse_file(const char *path,
 	strbuf_release(&sb);
 	return ret;
 }
+
+struct prune_options {
+	struct repository *repo;
+	FILE *fp;
+	timestamp_t expire;
+	struct strbuf copy;
+};
+
+static int good_oid(struct repository *r, const struct object_id *oid)
+{
+	if (is_null_oid(oid))
+		return 1;
+
+	return oid_object_info(r, oid, NULL) == OBJ_BLOB;
+}
+
+static int prune_parse(struct strbuf *line, void *data)
+{
+	struct prune_options *opts = data;
+	struct bkl_entry entry;
+
+	strbuf_reset(&opts->copy);
+	strbuf_addbuf(&opts->copy, line);
+
+	if (bkl_parse_entry(line, &entry))
+		return -1;
+
+	if (entry.timestamp < opts->expire)
+		return 0;
+
+	if (oideq(&entry.old_oid, &entry.new_oid))
+		return 0;
+
+	if (!good_oid(opts->repo, &entry.old_oid) ||
+	    !good_oid(opts->repo, &entry.new_oid))
+		return 0;
+
+	if (!opts->fp)
+		return -1;
+
+	fputs(opts->copy.buf, opts->fp);
+	return 0;
+}
+
+int bkl_prune(struct repository *r, const char *path, timestamp_t expire)
+{
+	struct lock_file lk;
+	struct prune_options opts;
+	int ret;
+
+	ret = hold_lock_file_for_update(&lk, path, 0);
+	if (ret == -1) {
+		if (errno == ENOTDIR || errno == ENOENT)
+			return 0;
+		return error(_("failed to lock '%s'"), path);
+	}
+	opts.repo = r;
+	opts.expire = expire;
+	opts.fp = fdopen_lock_file(&lk, "w");
+	strbuf_init(&opts.copy, 0);
+
+	ret = bkl_parse_file(path, prune_parse, &opts);
+	if (ret < 0)
+		rollback_lock_file(&lk);
+	else
+		ret = commit_lock_file(&lk);
+	strbuf_release(&opts.copy);
+	return ret;
+}
diff --git a/backup-log.h b/backup-log.h
index c9de9c687c..06fe706f81 100644
--- a/backup-log.h
+++ b/backup-log.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 
+struct repository;
 struct strbuf;
 
 struct bkl_entry
@@ -29,4 +30,6 @@ int bkl_parse_file(const char *path,
 		   int (*parse)(struct strbuf *line, void *data),
 		   void *data);
 
+int bkl_prune(struct repository *r, const char *id, timestamp_t expire);
+
 #endif
diff --git a/builtin/backup-log.c b/builtin/backup-log.c
index 2496d73ba5..2291124c38 100644
--- a/builtin/backup-log.c
+++ b/builtin/backup-log.c
@@ -301,6 +301,21 @@ static int log_(int argc, const char **argv,
 	return ret;
 }
 
+static int prune(int argc, const char **argv,
+		 const char *prefix, const char *log_path)
+{
+	timestamp_t expire = time(NULL) - 90 * 24 * 3600;
+	struct option options[] = {
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("expire objects older than <time>")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, backup_log_usage, 0);
+
+	return bkl_prune(the_repository, log_path, expire);
+}
+
 static char *log_id_to_path(const char *id)
 {
 	if (!strcmp(id, "index"))
@@ -346,6 +361,8 @@ int cmd_backup_log(int argc, const char **argv, const char *prefix)
 		return diff(argc, argv, prefix, log_path);
 	else if (!strcmp(argv[0], "log"))
 		return log_(argc, argv, prefix, log_path);
+	else if (!strcmp(argv[0], "prune"))
+		return prune(argc, argv, prefix, log_path);
 	else
 		die(_("unknown subcommand: %s"), argv[0]);
 
-- 
2.20.0.rc2.486.g9832c05c3d

