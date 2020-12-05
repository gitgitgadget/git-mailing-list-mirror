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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573CC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035D922DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbgLEBrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBrp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:45 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F0C061A56
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:28 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v18so6236886qta.22
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=IrR711oKxyB5r8jYdcnsLyLHtTjfJvr79t/+lDexFhPTx1uvAxg3g9350+ZmW2yWa6
         wjaclTIaibOZ8gQZgM3rhPPaAq3YTw3mcI+DkDDH2CiIkeq9GZHVM4D6hpIYagFBqdQZ
         4mfDUGDXvUoGSBDptapDY/beRz/YltCkP73JgXofPlu9ie+h/HQ6CdtyANKBYHjLHAFf
         ulr5HUWiOhQ6H44yUo9mt7WdEZXPIvxPSKNz+95W6Jh5c0mi+G6ktgIBtSb6rhxK0o6n
         2xgwGkBKfDbq0XSHGgUp9ABkRmujn5Kq4c2O8Nhwt5OOoKkVsWbwCM/e6zDBi9rgcohx
         UKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tYBIp72At1pPq2NwvWzTuSgSJkDuk44JQzLmJTw7OgE=;
        b=VDkChuXBy5buVVKBqTbXiiyrHsPjjJPKYTW6bZ0NliPYQvMdph2loPO0y5nh3xqiz9
         8I8kRA0fr4aJUADbmZ7wyZIwL4hyJZilE329/umm3HNQ6tROXNk+/fjbVd7f+DWU8NiI
         4CBSZHO72joCel91NgudQxe8M5MlOPg6P0Y1HfZorh1eFytCCKHXe6io6iabzXvOhFIb
         9LKd/fdmxIyfN4thLMTQ4MSQZWB+mRNbu0q5VLk/E+1d9kzPD1LZ75xnsuzCdOkkduUZ
         7YPfT7NrVAxmhlXuxzsMHXS6OhsZkZI0vB/vpftjXy6uKBQg0qT5wlGZpzFmpnZJBJbD
         ZoWQ==
X-Gm-Message-State: AOAM530uDWv3vCdWe69LqTAqeC7itnILQbfQpZB6WDTyDimO9tZMKh7e
        gxsh/sx1s3slH3IXGj0u3CrnFgymH+A6LsNUzdAzxkdNM6yrEtCkoAisuIwSn1aQ/2Guljeyt6g
        XveZWaDexPXf7rkCzlHeGf/VBjYCbsnRNDuUTWsv8KoPfbSF588SfhFnbj/ydzidHRCGqpsX5uw
        ==
X-Google-Smtp-Source: ABdhPJwrygg3ICRFKoPGO5pzvtUkcLwHntw8LTnha+Wo6ama9Xo1U5q6MvvzichSo9ctPIxeJHKzOK5twok7wYL1ixo=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b59a:: with SMTP id
 g26mr9152078qve.26.1607132787887; Fri, 04 Dec 2020 17:46:27 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:57 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 07/17] parse-options: parse into strvec
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
    Since v4, fixed one or two more places where I missed the argv_array->strvec
    rename.

 Documentation/technical/api-parse-options.txt |  5 +++++
 parse-options-cb.c                            | 16 ++++++++++++++++
 parse-options.h                               |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a60bbfa7f..679bd98629 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -173,6 +173,11 @@ There are some macros to easily define options:
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
+	Introduce an option with a string argument.
+	The string argument is stored as an element in `strvec`.
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
index 7030d8f3da..75cc8c7c96 100644
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
2.28.0.rc0.142.g3c755180ce-goog

