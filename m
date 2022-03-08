Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8A5C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 02:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiCHCzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 21:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCHCzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 21:55:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A311165
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 18:54:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i66so10308279wma.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 18:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=weFG7gHipTQ0X9DpHAV5S6k1cxcLQzkU55tlnEN24ZA=;
        b=HVKZiFkXkQ1u4ZMZkcBJlWnSxOHsULNWvHlRqlydv4rJELXRkSwsNbYkrN1uSpYGqz
         HoqDbxJraZgK+PmnxGWyQIpGWvGirJ07tOGjeVHcrHPwj4rmWzqXeqhMmhAzpDvCMmBq
         BRU2/7PzaZt6TzonP3zPLJrtfkk8CN0YeXsGP1lVBvHO7JvNlSc+nGbgE5Tsg2uKMI9d
         lqFqOf1ILhpxNn4UCRrjN1sfr74xIPIP7STyzQ3Cj81cVsjdkDRxcMIE7Wddxe8Mt7y/
         eAvylhnq1qqaB7rEP+E5xCamrwHBENhn5ShNzB/PodptMb30VQT5wGZMk1G4+xnMBYcd
         F41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=weFG7gHipTQ0X9DpHAV5S6k1cxcLQzkU55tlnEN24ZA=;
        b=Tdag1+385TME3ZclUkSjRrEI7ASSQeIkLTpJugaFIlxXqEtxptHZtoukLwM6HH3s9a
         C5AHgd4uF7zbw7L/gYbeAyuGtvMvKdgX/qtsfItDI+FvhuElEPk47BsSpkOEdLviSxa9
         W9TPwGZ5dS4CER0HqZfYBD0nOeLFTD/HDWGtC97Sd/BjFUFqcOc6yoAGHMN9gA+8zZso
         C4KhZgX7ba1b0OSmRsq5FySo4dLflg9K71OBV4KG+6u5l1rXxDzOV0xJU6Azam3veztw
         WL1DstPPDHaAN6Ht76/j9v/A58A0XnH47hA24ve56P5EwtCNx64DMT1+evMdusC93R4O
         Gxiw==
X-Gm-Message-State: AOAM531L6vLooe6DWOC8CsyuAIRMW1wYXiBisX0h/iUeh4oMsreR06+q
        GG5OeHQgobw2DAY58hKWU01B3n30clQ=
X-Google-Smtp-Source: ABdhPJwCVesWqiFWWrS8tZQvOQfYntYZDxmvsyn5cD6g+i7Ks5/vLdsb5k1QzzG3+XHl+K112XjmFA==
X-Received: by 2002:a05:600c:19c9:b0:389:77f1:86ba with SMTP id u9-20020a05600c19c900b0038977f186bamr1550460wmq.137.1646708064678;
        Mon, 07 Mar 2022 18:54:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b001f07772457csm9396664wrp.101.2022.03.07.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:54:24 -0800 (PST)
Message-Id: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 02:54:23 +0000
Subject: [PATCH v2] cat-file: skip expanding default format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
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

See https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
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
    
    Changes since v1:
    
     * set opt->format in batch_objects so that the loop that prints objects
       only has to check if the format is null to know to print the object
       info in the default format
     * fixed up commit trailer to include Ævar as Signed-off-by
    
     1. https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1221%2Fjohn-cai%2Fjc%2Foptimize-cat-file-batch-default-format-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1221/john-cai/jc/optimize-cat-file-batch-default-format-v2
Pull-Request: https://github.com/git/git/pull/1221

Range-diff vs v1:

 1:  9f659b36c8f ! 1:  f5d578d14a9 cat-file: skip expanding default format
     @@ Commit message
          passed, skip expanding of the format and print the object info with a
          default format.
      
     -    Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     -    Signed-off-by: John Cai <johncai86@gmail.com>
     -
          See https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/
      
     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Signed-off-by: John Cai <johncai86@gmail.com>
     +
       ## builtin/cat-file.c ##
     -@@
     - #include "object-store.h"
     - #include "promisor-remote.h"
     - 
     -+static const char *default_format = "%(objectname) %(objecttype) %(objectsize)";
     - struct batch_options {
     - 	int enabled;
     - 	int follow_symlinks;
      @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
       	}
       }
       
     -+static void print_default_format(char *buf, int len, struct expand_data *data)
     ++static int print_default_format(char *buf, int len, struct expand_data *data)
      +{
     -+	snprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
     ++	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
      +		 data->info.type_name->buf,
      +		 (uintmax_t)*data->info.sizep);
      +
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
       			       struct packed_git *pack,
       			       off_t offset)
       {
     -+	const char *fmt;
     -+
      +	struct strbuf type_name = STRBUF_INIT;
     ++
      +	if (!opt->format)
      +		data->info.type_name = &type_name;
      +
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
       		}
       	}
       
     -+	if (!opt->format && !opt->print_contents) {
     +-	strbuf_reset(scratch);
     +-	strbuf_expand(scratch, opt->format, expand_format, data);
     +-	strbuf_addch(scratch, '\n');
     +-	batch_write(opt, scratch->buf, scratch->len);
     ++	if (!opt->format) {
      +		char buf[1024];
     -+
     -+		print_default_format(buf, 1024, data);
     -+		batch_write(opt, buf, strlen(buf));
     -+		goto cleanup;
     ++		int len = print_default_format(buf, 1024, data);
     ++		batch_write(opt, buf, len);
     ++	} else {
     ++		strbuf_reset(scratch);
     ++		strbuf_expand(scratch, opt->format, expand_format, data);
     ++		strbuf_addch(scratch, '\n');
     ++		batch_write(opt, scratch->buf, scratch->len);
      +	}
     -+
     -+	fmt = opt->format ? opt->format : default_format;
     - 	strbuf_reset(scratch);
     --	strbuf_expand(scratch, opt->format, expand_format, data);
     -+	strbuf_expand(scratch, fmt, expand_format, data);
     - 	strbuf_addch(scratch, '\n');
     - 	batch_write(opt, scratch->buf, scratch->len);
       
     -@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     + 	if (opt->print_contents) {
       		print_object_or_die(opt, data);
       		batch_write(opt, "\n", 1);
       	}
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
       static void batch_one_object(const char *obj_name,
       			     struct strbuf *scratch,
       			     struct batch_options *opt,
     +@@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
     + 				      data);
     + }
     + 
     ++
     ++#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
     ++
     + static int batch_objects(struct batch_options *opt)
     + {
     + 	struct strbuf input = STRBUF_INIT;
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     - 	struct expand_data data;
       	int save_warning;
       	int retval = 0;
     --
     + 
      -	if (!opt->format)
      -		opt->format = "%(objectname) %(objecttype) %(objectsize)";
     -+	const char *fmt;
     - 
     +-
       	/*
       	 * Expand once with our special mark_query flag, which will prime the
     + 	 * object_info to be handed to oid_object_info_extended for each
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	 */
       	memset(&data, 0, sizeof(data));
       	data.mark_query = 1;
      -	strbuf_expand(&output, opt->format, expand_format, &data);
     -+	fmt = opt->format ? opt->format : default_format;
     -+	strbuf_expand(&output, fmt, expand_format, &data);
     ++	strbuf_expand(&output,
     ++		      opt->format ? opt->format : DEFAULT_FORMAT,
     ++		      expand_format,
     ++		      &data);
       	data.mark_query = 0;
       	strbuf_release(&output);
       	if (opt->cmdmode)
     + 		data.split_on_whitespace = 1;
     + 
     ++	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
     ++		opt->format = NULL;
     + 	/*
     + 	 * If we are printing out the object, then always fill in the type,
     + 	 * since we will want to decide whether or not to stream.
      
       ## t/perf/p1006-cat-file.sh (new) ##
      @@


 builtin/cat-file.c       | 46 ++++++++++++++++++++++++++++++++--------
 t/perf/p1006-cat-file.sh | 16 ++++++++++++++
 2 files changed, 53 insertions(+), 9 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..ab9a49e13a4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -351,6 +351,14 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+static int print_default_format(char *buf, int len, struct expand_data *data)
+{
+	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+		 data->info.type_name->buf,
+		 (uintmax_t)*data->info.sizep);
+
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -363,6 +371,11 @@ static void batch_object_write(const char *obj_name,
 			       struct packed_git *pack,
 			       off_t offset)
 {
+	struct strbuf type_name = STRBUF_INIT;
+
+	if (!opt->format)
+		data->info.type_name = &type_name;
+
 	if (!data->skip_object_info) {
 		int ret;
 
@@ -377,21 +390,31 @@ static void batch_object_write(const char *obj_name,
 			printf("%s missing\n",
 			       obj_name ? obj_name : oid_to_hex(&data->oid));
 			fflush(stdout);
-			return;
+			goto cleanup;
 		}
 	}
 
-	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
-	strbuf_addch(scratch, '\n');
-	batch_write(opt, scratch->buf, scratch->len);
+	if (!opt->format) {
+		char buf[1024];
+		int len = print_default_format(buf, 1024, data);
+		batch_write(opt, buf, len);
+	} else {
+		strbuf_reset(scratch);
+		strbuf_expand(scratch, opt->format, expand_format, data);
+		strbuf_addch(scratch, '\n');
+		batch_write(opt, scratch->buf, scratch->len);
+	}
 
 	if (opt->print_contents) {
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
@@ -508,6 +531,9 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+
+#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -516,9 +542,6 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
-
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
 	 * object_info to be handed to oid_object_info_extended for each
@@ -526,12 +549,17 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&output, opt->format, expand_format, &data);
+	strbuf_expand(&output,
+		      opt->format ? opt->format : DEFAULT_FORMAT,
+		      expand_format,
+		      &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
+	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
+		opt->format = NULL;
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
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
