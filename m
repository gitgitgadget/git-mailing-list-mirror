Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D8C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbiCHWJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiCHWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:09:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750931911
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:08:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e24so205315wrc.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=i2Lwu3SjMXl/FURC4/1hYS7279qTRki/Cu35Bth/on8=;
        b=kq/nxk8rv03qvoqx/4MSifF5W1SsuZ52AJPJPqQmw2MnCcp4MzbQ63xKowAno2sCM2
         q98wLrxrgdfYRu2xOmsUXZU93ley4SeHbujSuldiFAJ/9zamV3XIozIReUifZ6V1b+Jn
         G5GYiMSxYFoJPrKjoL+6m/YGqqmG6Thk5+h+g3BHxsv6mxPtkHq5Zj7K5H4ZjK0v0HBe
         Ryjm1z8vusOS0zB4aCvjrtps4Qduk7/1Nnjhlfar52Ld+83t9S1nOXgiNi3IbBHgsU8T
         6IbzP8TpDQsQ5+8q1AP2Sp4b6BlNqOZ0u+F6nbiQUke4hLeMw50vDXkcKivRxTp8t9bx
         vrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=i2Lwu3SjMXl/FURC4/1hYS7279qTRki/Cu35Bth/on8=;
        b=YqWR9+WUCFvFk7CifnLtwiBtQoIfuityBiOP1JBo0Cpdt7H0SOUaoYk2VZq/SkVCvD
         pspNGJTzb0wYX2RjNtYNjgf7im6Lpl5IvGMdUABfqRePl6xxpRuhxPViQBOyjgj4qJTz
         PUusx0Szk9saJ2YN15SmqWj3GTpF/GnhIkehkh6/0xmEFpWIi1jQKTgmQMbpDRMqIXpK
         Bc00R0ZQgmtkXdMHON0D//lONK6b1f3vDVMblotIz+BLWyp0L0kN4g2bWiM2l2ZeLtip
         ONoRsC7QQ0QGcOQADhJoE/adswtpX1G69wqX8KRTs8UvBpviUEBrtHfJZinKRIYcIqMI
         nYCw==
X-Gm-Message-State: AOAM533pUoBqFmRwiwr7cyLSTGQHTDyg51tIAufEKFMZ03auSwPTTpuL
        x+fvSExeGy8uz7E+H3PEcEQ3uyYPsXE=
X-Google-Smtp-Source: ABdhPJxiB00nGX3CPwCFderk1/YpIfqzUwLb/cBNRvpQOqHTYcLQJ9B5V6yj48m39rDIxt4jZ3VJOQ==
X-Received: by 2002:adf:f9c6:0:b0:1ef:832d:58fa with SMTP id w6-20020adff9c6000000b001ef832d58famr13875891wrr.378.1646777328363;
        Tue, 08 Mar 2022 14:08:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0020294da2b42sm88836wrn.117.2022.03.08.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:08:47 -0800 (PST)
Message-Id: <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
References: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:08:46 +0000
Subject: [PATCH v3] cat-file: skip expanding default format
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
    
    Changes since v1:
    
     * set opt->format in batch_objects so that the loop that prints objects
       only has to check if the format is null to know to print the object
       info in the default format
     * fixed up commit trailer to include Ævar as Signed-off-by
    
     1. https://lore.kernel.org/git/87eecf8ork.fsf@evledraar.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1221%2Fjohn-cai%2Fjc%2Foptimize-cat-file-batch-default-format-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1221/john-cai/jc/optimize-cat-file-batch-default-format-v3
Pull-Request: https://github.com/git/git/pull/1221

Range-diff vs v2:

 1:  f5d578d14a9 ! 1:  56d13da5141 cat-file: skip expanding default format
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
      +static int print_default_format(char *buf, int len, struct expand_data *data)
      +{
      +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
     -+		 data->info.type_name->buf,
     -+		 (uintmax_t)*data->info.sizep);
     -+
     ++			 type_name(data->type),
     ++			 (uintmax_t)*data->info.sizep);
      +}
      +
       /*
        * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
        * which the object may be accessed (though note that we may also rely on
      @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     - 			       struct packed_git *pack,
     - 			       off_t offset)
     - {
     -+	struct strbuf type_name = STRBUF_INIT;
     -+
     -+	if (!opt->format)
     -+		data->info.type_name = &type_name;
     -+
     - 	if (!data->skip_object_info) {
     - 		int ret;
     - 
     -@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     - 			printf("%s missing\n",
     - 			       obj_name ? obj_name : oid_to_hex(&data->oid));
     - 			fflush(stdout);
     --			return;
     -+			goto cleanup;
       		}
       	}
       
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
       
       	if (opt->print_contents) {
       		print_object_or_die(opt, data);
     - 		batch_write(opt, "\n", 1);
     - 	}
     -+
     -+cleanup:
     -+	strbuf_release(&type_name);
     - }
     - 
     -+
     - static void batch_one_object(const char *obj_name,
     - 			     struct strbuf *scratch,
     - 			     struct batch_options *opt,
      @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
       				      data);
       }


 builtin/cat-file.c       | 34 ++++++++++++++++++++++++++--------
 t/perf/p1006-cat-file.sh | 16 ++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..e2edba70b41 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -351,6 +351,13 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+static int print_default_format(char *buf, int len, struct expand_data *data)
+{
+	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+			 type_name(data->type),
+			 (uintmax_t)*data->info.sizep);
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -381,10 +388,16 @@ static void batch_object_write(const char *obj_name,
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
@@ -508,6 +521,9 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+
+#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -516,9 +532,6 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
-
 	/*
 	 * Expand once with our special mark_query flag, which will prime the
 	 * object_info to be handed to oid_object_info_extended for each
@@ -526,12 +539,17 @@ static int batch_objects(struct batch_options *opt)
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
