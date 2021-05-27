Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23577C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069F0613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhE0ALB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhE0AKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95E5C06138C
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r25-20020a05620a03d9b02903a58bfe037cso2080661qkm.15
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OlFFOx1J937SauwGyV2zTpiyzLPKZyfZEkDezuJbeHI=;
        b=cTjvaYtf9OTX9Notft4xoUUmP11j05EqqXCKD9Uaj1hyv9erlzCUmddkw+sGPuTSRQ
         rTrE/n+LqSLbx9G9A/N8cQMeQg3fCQK7Zf18+goJaT/F3Ojxi51YGC4iC5t4Z5CAwBN+
         g/DkdzN70yxJj2nIPZdqTDkmqJKf9n7mylTw3DQ4gEP52HnQ7r9GUPYi+I/37iORo9mw
         i4l45iGmn2I3shcVvuwADo68Zw6Iqt5uTeQ9wrSPU+26GcFKWYzrmJcnYg3xSNpaUS7y
         mKzmMbEzgphK/so+lTF0vUR+7EeVmyPXYh390yNnU4T69u47F7U5hXWjtNyBhROahBqN
         ulCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OlFFOx1J937SauwGyV2zTpiyzLPKZyfZEkDezuJbeHI=;
        b=UWFx3H8jv7tyFtF9syk0MxHdclXgpYksB/XyC/F83djODCVlCFkGdAJPNb35AB3QJd
         SpadXPWlqdp6Q2o+0WGBcp/cpvISQY/oDMH1WLAn55eDQnwQXWFp2qB757RpcQTmbd9j
         qdVvktNPfQkB5QXKjvZME6xtwqvOs7II7gqlhFHsWi64D1ynMxI/iKTacMjYNWtpuT5X
         JOddq4GHCCjChm83jw9kl9GM+Tkndt9Dg6YPxQVCsxLqDtke/B/1RcdI0wUvDMaBI4PM
         Z+SOD3NJpQcXEVLiNVoFJhMJzKkPRgvQAcQzt/6k89POeya+34QM+XhSB3tanAVCfc3i
         yxfA==
X-Gm-Message-State: AOAM530P8UarVJ+FmhKf3OR9zVkkBZSxgTWihGrI0I/aTAdcNqMHi+S/
        U7ST/KWa/x5KbigJwal6fDGIO4R1/BpaHMtxhKdNx6M/rSmPNE0cyrAqBJYQYRfPadPrN74wAum
        6C4+6XBhlL7ip3UXnWXs8HPA9fN16GHCoYFm9J1zoS2nWhVQsA/FRwYP4qWPBAWV1NMwx8ap4LQ
        ==
X-Google-Smtp-Source: ABdhPJyJdaVE5kwJ5j6c7qM+2aghQYEoEbwEIYKRh5Y9rKXUJubNNkdG13HXOToAuC+FCokZOF6GgFJa+eGfT6Qc+C0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:5fcb:: with SMTP id
 jq11mr784371qvb.61.1622074152950; Wed, 26 May 2021 17:09:12 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:25 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 06/37] parse-options: parse into strvec
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options already knows how to read into a string_list, and it knows
how to read into an strvec as a passthrough (that is, including the
argument as well as its value). string_list and strvec serve similar
purposes but are somewhat painful to convert between; so, let's teach
parse-options to read values of string arguments directly into an
strvec without preserving the argument name.

This is useful if collecting generic arguments to pass through to
another command, for example, 'git hook run --arg "--quiet" --arg
"--format=pretty" some-hook'. The resulting strvec would contain
{ "--quiet", "--format=pretty" }.

The implementation is based on that of OPT_STRING_LIST.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v7, updated the reference doc to make the intended usage for OPT_STRVEC
    more clear.
    
    Since v4, fixed one or two more places where I missed the argv_array->strvec
    rename.

 Documentation/technical/api-parse-options.txt |  7 +++++
 parse-options-cb.c                            | 16 +++++++++++
 parse-options.h                               |  4 +++
 t/helper/test-parse-options.c                 |  6 +++++
 t/t0040-parse-options.sh                      | 27 +++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a60bbfa7f..f79b17e7fc 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,6 +173,13 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
+	Introduce an option with a string argument, meant to be specified
+	multiple times.
+	The string argument is stored as an element in `strvec`, and later
+	arguments are added to the same `strvec`.
+	Use of `--no-option` will clear the list of preceding values.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a..8227499eb6 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -207,6 +207,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
+{
+	struct strvec *v = opt->value;
+
+	if (unset) {
+		strvec_clear(v);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	strvec_push(v, arg);
+	return 0;
+}
+
 int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
diff --git a/parse-options.h b/parse-options.h
index a845a9d952..fcb0f1f31e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -178,6 +178,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+#define OPT_STRVEC(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_strvec }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -297,6 +300,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 2051ce57db..922af56156 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "trace2.h"
 
 static int boolean = 0;
@@ -15,6 +16,7 @@ static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
 static struct string_list list = STRING_LIST_INIT_NODUP;
+static struct strvec vector = STRVEC_INIT;
 
 static struct {
 	int called;
@@ -133,6 +135,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
+		OPT_STRVEC(0, "vector", &vector, "str", "add str to strvec"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", NULL, "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
@@ -183,6 +186,9 @@ int cmd__parse_options(int argc, const char **argv)
 	for (i = 0; i < list.nr; i++)
 		show(&expect, &ret, "list: %s", list.items[i].string);
 
+	for (i = 0; i < vector.nr; i++)
+		show(&expect, &ret, "vector: %s", vector.v[i]);
+
 	for (i = 0; i < argc; i++)
 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ad4746d899..485e0170bf 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -35,6 +35,7 @@ String options
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
     --list <str>          add str to list
+    --vector <str>        add str to strvec
 
 Magic arguments
     --quux                means --quux
@@ -386,6 +387,32 @@ test_expect_success '--no-list resets list' '
 	test_cmp expect output
 '
 
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: -1
+quiet: 0
+dry run: no
+file: (not set)
+vector: foo
+vector: bar
+vector: baz
+EOF
+test_expect_success '--vector keeps list of strings' '
+	test-tool parse-options --vector foo --vector=bar --vector=baz >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--no-vector resets list' '
+	test-tool parse-options --vector=other --vector=irrelevant --vector=options \
+		--no-vector --vector=foo --vector=bar --vector=baz >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'multiple quiet levels' '
 	test-tool parse-options --expect="quiet: 3" -q -q -q
 '
-- 
2.31.1.818.g46aad6cb9e-goog

