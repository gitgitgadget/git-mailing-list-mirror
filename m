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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C6C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4689120708
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbHSavcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgKXUFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgKXUFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:05:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6CC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:05:30 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 143so12412020pfv.16
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c9J9ZbvBSlHe9bISBGM21/gzvPVhQUdTS7I6Vvj6poU=;
        b=kbHSavcnHq7yeJDJC71NhYLLQUrFn4/hI/2r2BMztW4IkAu7YvqUcUs+8FHd1mIeTU
         K0VTNyPis/I6EDEQYo8jEOPxonLLIqoLb4+vDjncTRNtIfb7s52loysM8wzIu7KocKQ3
         rGpr8BxDV1Eyv3MHV7EGicMz58oIjvLyb1vi6opTbw5MmWJwvE+/vQfFL8le7NkNOzsK
         PUAR72LlmWj5VTUYaSoeotrisS0sHDiAfE9SmSiKsSAdjYsm07JVPWkox+H2JOSWWoO3
         FqlE0tG0MIXWEK7njHBQDJIw3D5oat/eQludrU/yZh1nyOTvCq1ceG3M6Yn3fHY1/kYk
         diTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9J9ZbvBSlHe9bISBGM21/gzvPVhQUdTS7I6Vvj6poU=;
        b=IsHXNIEYs8i2jMhkJOv9eTzNkJHTy4Co823YnNU0Fimr42RQQWwJDQg51/VXcLFxGk
         Ek05CV/jqcrAOcWVzNw4EPqRUm5XT8hJLwsbLmOANpJ0XQWc+jAWwxeROqL8luXjz8Ce
         6JsP87kvfbT9g/G5fFjCgqlWmUYNw88L2xVKrk5nK8BZAiqfAHgYmLeN2JJW9tuCR1bI
         cQduFGlMehWaqH7a039+BvExmUEQnyTk/STedQkOlKoNYts9eTfTZyWhQQYgu/I0w27J
         el1oHuqibY6jezvFzxR8CiwEoWTox5ibuqs/uvOs1D5P+HVd+swqYGH7nRyL7ZvbI0vw
         9Low==
X-Gm-Message-State: AOAM532a4EeYY+/AIS9p/rvsLc4eyLeStddv36yvBn/XoXPauK4xL1DD
        HayenB50kGOj8SheDNWjB38Z+0tdp5BiPPDXcd0K4hoJpgZ5RRxesObvFUwxvvsxeuG25BAMqpG
        8JYoelGqE5MVW0l7umbSOuZSwtIiKpZ2sxIAXp7Oz/QVGQSTN+afLphAMABi/EbaXxdZ/0MZjtd
        lP
X-Google-Smtp-Source: ABdhPJzsqKPH09w7Pn7m3uHfp1dIGzKoCG0x9S1lLOlG7M93wqBjdoDBF4z994o5FO3Uf6eJ6gy0yc1vN4enYvXGyRqr
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f406:: with SMTP id
 ch6mr288677pjb.134.1606248329938; Tue, 24 Nov 2020 12:05:29 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:05:27 -0800
In-Reply-To: <20201123190412.101265-1-jonathantanmy@google.com>
Message-Id: <20201124200527.890563-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201123190412.101265-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3] usage: add trace2 entry upon warning()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emit a trace2 error event whenever warning() is called, just like when
die(), error(), or usage() is called.

This helps debugging issues that would trigger warnings but not errors.
In particular, this might have helped debugging an issue I encountered
with commit graphs at $DAYJOB [1].

There is a tradeoff between including potentially relevant messages and
cluttering up the trace output produced. I think that warning() messages
should be included in traces, because by its nature, Git is used over
multiple invocations of the Git tool, and a failure (currently traced)
in a Git invocation might be caused by an unexpected interaction in a
previous Git invocation that only has a warning (currently untraced) as
a symptom - as is the case in [1].

[1] https://lore.kernel.org/git/20200629220744.1054093-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Junio. That comment looks good. Here is the version with Junio's
suggested comment included, for everyone's reference.
---
 Documentation/technical/api-trace2.txt | 2 +-
 trace2.h                               | 5 +++++
 usage.c                                | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 6b6085585d..c65ffafc48 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -466,7 +466,7 @@ completed.)
 
 `"error"`::
 	This event is emitted when one of the `error()`, `die()`,
-	or `usage()` functions are called.
+	`warning()`, or `usage()` functions are called.
 +
 ------------
 {
diff --git a/trace2.h b/trace2.h
index b18bc5529c..2b5c5c4ba0 100644
--- a/trace2.h
+++ b/trace2.h
@@ -116,6 +116,11 @@ int trace2_cmd_exit_fl(const char *file, int line, int code);
  * Emit an 'error' event.
  *
  * Write an error message to the TRACE2 targets.
+ * 
+ * Note that the "va_list ap" the caller has is not touched, because
+ * it is fed to each of the TRACE2 targets, which must use va_copy()
+ * and use va_end() on the copy.  The caller can still use ap it uses
+ * to call this function and and call va_end() on it when it is done.
  */
 void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
 			    va_list ap);
diff --git a/usage.c b/usage.c
index 06665823a2..1868a24f7a 100644
--- a/usage.c
+++ b/usage.c
@@ -81,6 +81,12 @@ static void error_builtin(const char *err, va_list params)
 
 static void warn_builtin(const char *warn, va_list params)
 {
+	/*
+	 * We call this trace2 function first and expect it to va_copy 'params'
+	 * before using it (because an 'ap' can only be walked once).
+	 */
+	trace2_cmd_error_va(warn, params);
+
 	vreportf("warning: ", warn, params);
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

