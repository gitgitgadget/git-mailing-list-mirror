Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CEAC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 02:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiCOClw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 22:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiCOClv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 22:41:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED047AD7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 19:40:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j26so26893624wrb.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fiekj8AX4h0JHeSikRVPMR9duQuE0xajAXBaxe8z8nw=;
        b=pizfClMOelDguT/s/UcxI0c89h/Wski3+ZAfZP2sysOBwxhc3tGu9yeVM6mkXQudAB
         IEqGDsqP6rvFvuZtIaFqR1eaMSQ7MunO+GKN1bNsGZQ+OcBoyldCqVt+GJsdGPEsUkO7
         9ZorwNjuy+2WBOAH++BJ4IDJdesz4I8Ukl4h3Uj/hbl2XJKaq60t+Np+AR3o4MSVZikU
         0/gCs0qEtTD/YvabjXbRjUKvLPB7mM5zUHoTA7+izB3iRdyAmw5fQc0tMkklpIatMBWc
         x1TINoWl0oDRy5Y0wkdXzG6pckOjc78oiEFwVLX5fXQRz0lOEztyCf3jTy5N0I7DF/sR
         p1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fiekj8AX4h0JHeSikRVPMR9duQuE0xajAXBaxe8z8nw=;
        b=0fVQ/fxdKxiyxN84LSEMSEPOdhspTUuPCwTjbN1m491KJ2rXzUmVlsUlWzvKdkwwP5
         BOLzxGRep0DbSR2qj9o6IeEuA+DkIpRgrsuMBcHysUnTKzdTxBeTJdJSj9bmV6YomenM
         97BxfIJPHkbkM/gnR+dRrNWS7QALmS4UUmO3mt/7H4eBZbk30eEnr/m1GgKBhbn12er8
         g6eIMCGPgHD1BxmsgcAtJHJ3G5A7K+syrZtJTwlyDGD2sQdWJviQTH1pZyMa/OnNGA0Q
         B1ccftXe1rfTs5rj54tA2NsUsK+GnLuryLWTwpRQAWmqx9jExjNCCfKHXtp8ZEI8mP00
         u3WA==
X-Gm-Message-State: AOAM533gft5/Sfv3DtmSF38c+enpIMTNbQhgGOP9wXcgfMEpiKn+9TDv
        rnilP0BAWxaqI6HQKXL774QQyRoGIiQ=
X-Google-Smtp-Source: ABdhPJx3iQHoi+iy0VSPjDWWL1DN7eoOfAvkkpgsUEvZ7H69JyVCR5R0bn1PSjm+n7XQt/Qhre22fQ==
X-Received: by 2002:a5d:6dad:0:b0:203:84b4:da13 with SMTP id u13-20020a5d6dad000000b0020384b4da13mr17951638wrs.162.1647312037964;
        Mon, 14 Mar 2022 19:40:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d49ce000000b001f036a29f42sm14205601wrs.116.2022.03.14.19.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:40:37 -0700 (PDT)
Message-Id: <pull.1221.v4.git.git.1647312036664.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
References: <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 02:40:36 +0000
Subject: [PATCH v4] cat-file: skip expanding default format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
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
    
    Changes since v3:
    
     * reuse scratch string buffer
     * use --batch-all-objects in test
    
    Changes since v2:
    
     * get rid of type_name string buffer, and call type_name() for each
       object in print_default_format()
    
    Changes since v1:
    
     * set opt->format in batch_objects so that the loop that prints objects
       only has to check if the format is null to know to print the object
       info in the default format
     * fixed up commit trailer to include Ævar as Signed-off-by
    
     1. https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1221%2Fjohn-cai%2Fjc%2Foptimize-cat-file-batch-default-format-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1221/john-cai/jc/optimize-cat-file-batch-default-format-v4
Pull-Request: https://github.com/git/git/pull/1221

Range-diff vs v3:

 1:  56d13da5141 ! 1:  b0c6a18b7ad cat-file: skip expanding default format
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
       	}
       }
       
     -+static int print_default_format(char *buf, int len, struct expand_data *data)
     ++static void print_default_format(struct strbuf *scratch, struct expand_data *data)
      +{
     -+	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
     -+			 type_name(data->type),
     -+			 (uintmax_t)*data->info.sizep);
     ++	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
     ++		    type_name(data->type),
     ++		    (uintmax_t)data->size);
      +}
      +
       /*
        * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
        * which the object may be accessed (though note that we may also rely on
      @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     - 		}
       	}
       
     --	strbuf_reset(scratch);
     + 	strbuf_reset(scratch);
      -	strbuf_expand(scratch, opt->format, expand_format, data);
      -	strbuf_addch(scratch, '\n');
     --	batch_write(opt, scratch->buf, scratch->len);
     ++
      +	if (!opt->format) {
     -+		char buf[1024];
     -+		int len = print_default_format(buf, 1024, data);
     -+		batch_write(opt, buf, len);
     ++		print_default_format(scratch, data);
      +	} else {
     -+		strbuf_reset(scratch);
      +		strbuf_expand(scratch, opt->format, expand_format, data);
      +		strbuf_addch(scratch, '\n');
     -+		batch_write(opt, scratch->buf, scratch->len);
      +	}
     ++
     + 	batch_write(opt, scratch->buf, scratch->len);
       
     - 	if (opt->print_contents) {
     - 		print_object_or_die(opt, data);
     -@@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
     - 				      data);
     + 	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
     +@@ builtin/cat-file.c: static void batch_objects_command(struct batch_options *opt,
     + 	strbuf_release(&input);
       }
       
     -+
      +#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
      +
       static int batch_objects(struct batch_options *opt)
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
      +		      &data);
       	data.mark_query = 0;
       	strbuf_release(&output);
     - 	if (opt->cmdmode)
     + 	if (opt->transform_mode)
       		data.split_on_whitespace = 1;
       
      +	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
     @@ t/perf/p1006-cat-file.sh (new)
      @@
      +#!/bin/sh
      +
     -+test_description='Basic sort performance tests'
     ++test_description='Tests listing object info performance'
      +. ./perf-lib.sh
      +
      +test_perf_large_repo
      +
     -+test_expect_success 'setup' '
     -+	git rev-list --all >rla
     -+'
     -+
      +test_perf 'cat-file --batch-check' '
     -+	git cat-file --batch-check <rla
     ++	git cat-file --batch-all-objects --batch-check
      +'
      +
      +test_done


 builtin/cat-file.c       | 29 +++++++++++++++++++++++------
 t/perf/p1006-cat-file.sh | 12 ++++++++++++
 2 files changed, 35 insertions(+), 6 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e75e110302e..94d5901e9a7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -357,6 +357,13 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+static void print_default_format(struct strbuf *scratch, struct expand_data *data)
+{
+	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+		    type_name(data->type),
+		    (uintmax_t)data->size);
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -388,8 +395,14 @@ static void batch_object_write(const char *obj_name,
 	}
 
 	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
-	strbuf_addch(scratch, '\n');
+
+	if (!opt->format) {
+		print_default_format(scratch, data);
+	} else {
+		strbuf_expand(scratch, opt->format, expand_format, data);
+		strbuf_addch(scratch, '\n');
+	}
+
 	batch_write(opt, scratch->buf, scratch->len);
 
 	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
@@ -643,6 +656,8 @@ static void batch_objects_command(struct batch_options *opt,
 	strbuf_release(&input);
 }
 
+#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -651,9 +666,6 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
-
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
 	 * object_info to be handed to oid_object_info_extended for each
@@ -661,12 +673,17 @@ static int batch_objects(struct batch_options *opt)
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
 	if (opt->transform_mode)
 		data.split_on_whitespace = 1;
 
+	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
+		opt->format = NULL;
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
new file mode 100755
index 00000000000..dcd80153796
--- /dev/null
+++ b/t/perf/p1006-cat-file.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+test_description='Tests listing object info performance'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_perf 'cat-file --batch-check' '
+	git cat-file --batch-all-objects --batch-check
+'
+
+test_done

base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
-- 
gitgitgadget
