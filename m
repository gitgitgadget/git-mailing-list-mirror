Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5EB64FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCKCLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCKCLE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:04 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115C2C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:04 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c7so14308593qka.6
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OWYnZbPFGX9FT/eauTj5CPL93ENtK/W91SmNK7BDIjE=;
        b=XruIqkMn9VxPDPfo0yoa08dH93oOnT3HZcmZSteGbjKXD1sc4w0fdO7cJiClL6T7XD
         6UYoBld4AYFMBpvOJcTrMoz2wODmkdblVCMON0NPm4x7uEACQ05O/11EoBJQqg1nBzs5
         UBXstGei4fZ6Y8VcsGg2zHkiSU/vI4x/3k19kPSNAu7E4RIBXgRQUslatluC92X5nPEq
         eR6zeGprAA4wsh4AIFoA2MwpRuohu6ftHMavy5bipSuVUiJfpvV27Lw4rtrycLSdmVCz
         ue1dzGGTRJ3fZ6+y2/NYRarN9N5TU42AyqGuW0EkNLEFQCQFeTXDyD7A2f1PyKevIl2G
         9ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OWYnZbPFGX9FT/eauTj5CPL93ENtK/W91SmNK7BDIjE=;
        b=jfwLRlEPQFrRe76VIK9TLawD0sPJLLMbPc/+GWqD+bGtftTh55acKdhqPWb9woB0Zi
         MrGhe/GI3n6V/fpQiYPU9T3up9UV7z7qG33i84ZDn92f5F/MxS1D9UDBe0QzuLwVRD/P
         X/+3UnZ3hTIZhUBoma1GaI9orcx80k+m1dryT1Ocn5ve07TbEIwSOmaS50HPjbxuFIMZ
         JMR3Gta4KNZXy9oLZrRYCM/axZJ4AROuOtMStRcQt3ExznCs0r+5IOluc66QKuThHWea
         zymYahk/q6Q9x6Q6c5gp5be+m3KX89NNhU/xTdEKEFu6bWuWciyW6paYo+vtR21iXuVI
         kdzA==
X-Gm-Message-State: AOAM531sWiJbbbxyCiWwf9MQQi+O2NVy3RjidxC2rbp1xkRfdhBicK8C
        BltM0vRkr+KXyn+YQGGd4EjjsNU9EqzKlWzaR1M8hEVnkkULHz3SZYMif8K8yAGSz2nnh0VyPgS
        Xhzz/KJ0lNZ6BdIu2khEcBJCDv4NvAP1xwhw4x4VQGTBmRJB+odq3fiRmgUcqdndeE5vy3+Nuyg
        ==
X-Google-Smtp-Source: ABdhPJx3DcyR2ePx6Okm3+SspuA9rNEc/EccJXRZBT0/r/1YVYVpExLvEpNfsVuSLG55hWvvSzxB4UxFPp0H/n0ESfI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:50c7:: with SMTP id
 e7mr5677172qvq.58.1615428663227; Wed, 10 Mar 2021 18:11:03 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:07 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 07/37] parse-options: parse into strvec
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

 Documentation/technical/api-parse-options.txt |  7 +++++++
 parse-options-cb.c                            | 16 ++++++++++++++++
 parse-options.h                               |  4 ++++
 3 files changed, 27 insertions(+)

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
index 4542d4d3f9..c2451dfb1b 100644
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
index ff6506a504..44c4ac08e9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -177,6 +177,9 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+#define OPT_STRVEC(s, l, v, a, h) \
+				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				      (h), 0, &parse_opt_strvec }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
@@ -296,6 +299,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
-- 
2.31.0.rc2.261.g7f71774620-goog

