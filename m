Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1615CC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 21:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiCDViU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiCDViT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 16:38:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520C1106
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 13:37:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r65so5762962wma.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=UhKa36M2nSiwdhXg1rRcVpQp4EsbcWpICYmBYs3yax0=;
        b=jrQrbSBR5yiemvjR0ZFeyno/dwAZi0GlhbQn6HbwXk8zyYSxjJV3hyURL6vd+cO+0M
         vn3z1RBlrvttfsnYrdhNHegotjbc2J43AA3Pata6BVYiFHuN4Ko75PmguhNLvx5TIaf+
         kPKcv6rjNGjkUsCL92gqnn/sCnVM6XOkbpKS8c15BH8I9srkqepv9yhEL/LI1BiWDxOU
         sPyfm+Ogua1hB6cVpEecZQMLQKhjrrHh3zEW0tOar6ejNyMTXaajNH1hP6QR+H4YKLey
         G2TfCX6YXL4r+h7vaYkmAToWiPoGFd1Phy6sLW/Zi1H6kQZtRHA5y6CgLKXZVgayBhD2
         gIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UhKa36M2nSiwdhXg1rRcVpQp4EsbcWpICYmBYs3yax0=;
        b=SYwOD6oa++ut4KroZKajqLTrbTbjj12xBpw6ROU3b3cqDeehtPoafvyHB6jIzQxNyD
         C67YclOkgk9jrjwiyUAdnvULDvtEguwB50OBnHadDF4PjdoKOp+PaHq/U+3AmlAQ4S7S
         okzQznsTc5dG6Ti8Fmo5WNMW4ra4BeHP4Fagnk7KJNzNcTcC+emZPf+hsNNt5Y8eIxFs
         w6dmtnnraNMqYEp9WPgOn5MJTwSNJj2i/h/KzAHn03P/E18JMunHUmR0ieqt8NT3d9I4
         jyO9llhQ0EoLoF2Q6OPaUaK1Xvc0rUIfFaxqAT2JV00B5Y1RBVDIduICFhi1NXsv6roR
         QyFw==
X-Gm-Message-State: AOAM531rSfACpar+YRU5xWQ6ECKkkl/L6Pd7L+d2vYtzgZxTD45E/yEM
        3Um7UXK9mXwEidp8jjrxT2vQKUu72is=
X-Google-Smtp-Source: ABdhPJzkClRBhvzGtksc3FlpShNtCnZmuC2ekISU8bAwNOP2swGeJSO3yKiGD1XhHOFVjdDBl+vcMw==
X-Received: by 2002:a1c:e908:0:b0:37c:3d08:e0d3 with SMTP id q8-20020a1ce908000000b0037c3d08e0d3mr261778wmc.97.1646429846345;
        Fri, 04 Mar 2022 13:37:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0038181486018sm6950474wmq.40.2022.03.04.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:37:26 -0800 (PST)
Message-Id: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 21:37:25 +0000
Subject: [PATCH] cat-file: skip expanding default format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

When format is passed into --batch, --batch-check, --batch-command,
the format gets expanded. When nothing is passed in, the default format
is set and the expand_format() gets called.

We can save on these cycles by hardcoding how to print the
information when nothing is passed as the format, or when the default
format is passed. There is no need for the fully expanded format with
the default. Since batch_object_write() happens on every object provided
in batch mode, we get a nice performance improvement.

git rev-list --all > /tmp/all-obj.txt

git cat-file --batch-check </tmp/all-obj.txt

with HEAD^:

Time (mean ± σ): 57.6 ms ± 1.7 ms [User: 51.5 ms, System: 6.2 ms]
Range (min … max): 54.6 ms … 64.7 ms 50 runs

with HEAD:

Time (mean ± σ): 49.8 ms ± 1.7 ms [User: 42.6 ms, System: 7.3 ms]
Range (min … max): 46.9 ms … 55.9 ms 56 runs

If nothing is provided as a format argument, or if the default format is
passed, skip expanding of the format and print the object info with a
default format.

Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>

See https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/
---
    optimize cat file batch info writing
    
    When cat-file --batch or --batch-check is used, we can skip having to
    expand the format if no format is specified or if the default format is
    specified. In this case we know exactly how to print the objects without
    the full expanded format.
    
    This was first discussed in [1].
    
    We get a little performance boost from this optimization because this
    happens for each objects provided to --batch, --batch-check, or
    --batch-command. Because batch_object_write() is called on every oid
    provided in batch mode, this optimization adds up when a large number of
    oid info is printed.
    
    git rev-list --all >/tmp/all-objs.txt
    
    git cat-file --batch-check </tmp/all-obj.txt (with hyperfine)
    
    run on origin/master:
    
    Time (mean ± σ): 57.6 ms ± 1.7 ms [User: 51.5 ms, System: 6.2 ms] Range
    (min … max): 54.6 ms … 64.7 ms 50 runs
    
    run on jc/optimize-cat-file-batch-default-format:
    
    Time (mean ± σ): 49.8 ms ± 1.7 ms [User: 42.6 ms, System: 7.3 ms] Range
    (min … max): 46.9 ms … 55.9 ms 56 runs
    
     1. https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1221%2Fjohn-cai%2Fjc%2Foptimize-cat-file-batch-default-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1221/john-cai/jc/optimize-cat-file-batch-default-format-v1
Pull-Request: https://github.com/git/git/pull/1221

 builtin/cat-file.c       | 39 +++++++++++++++++++++++++++++++++------
 t/perf/p1006-cat-file.sh | 16 ++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..6a337941638 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,6 +17,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+static const char *default_format = "%(objectname) %(objecttype) %(objectsize)";
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
@@ -351,6 +352,14 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+static void print_default_format(char *buf, int len, struct expand_data *data)
+{
+	snprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+		 data->info.type_name->buf,
+		 (uintmax_t)*data->info.sizep);
+
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -363,6 +372,12 @@ static void batch_object_write(const char *obj_name,
 			       struct packed_git *pack,
 			       off_t offset)
 {
+	const char *fmt;
+
+	struct strbuf type_name = STRBUF_INIT;
+	if (!opt->format)
+		data->info.type_name = &type_name;
+
 	if (!data->skip_object_info) {
 		int ret;
 
@@ -377,12 +392,21 @@ static void batch_object_write(const char *obj_name,
 			printf("%s missing\n",
 			       obj_name ? obj_name : oid_to_hex(&data->oid));
 			fflush(stdout);
-			return;
+			goto cleanup;
 		}
 	}
 
+	if (!opt->format && !opt->print_contents) {
+		char buf[1024];
+
+		print_default_format(buf, 1024, data);
+		batch_write(opt, buf, strlen(buf));
+		goto cleanup;
+	}
+
+	fmt = opt->format ? opt->format : default_format;
 	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
+	strbuf_expand(scratch, fmt, expand_format, data);
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
@@ -390,8 +414,12 @@ static void batch_object_write(const char *obj_name,
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
+
+cleanup:
+	strbuf_release(&type_name);
 }
 
+
 static void batch_one_object(const char *obj_name,
 			     struct strbuf *scratch,
 			     struct batch_options *opt,
@@ -515,9 +543,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
-
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
+	const char *fmt;
 
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
@@ -526,7 +552,8 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&output, opt->format, expand_format, &data);
+	fmt = opt->format ? opt->format : default_format;
+	strbuf_expand(&output, fmt, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
 	if (opt->cmdmode)
diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
new file mode 100755
index 00000000000..e463623f5a3
--- /dev/null
+++ b/t/perf/p1006-cat-file.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description='Basic sort performance tests'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	git rev-list --all >rla
+'
+
+test_perf 'cat-file --batch-check' '
+	git cat-file --batch-check <rla
+'
+
+test_done

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
gitgitgadget
