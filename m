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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A256FC63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFE120738
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zuz4qCg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgKWTES (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgKWTES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:04:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A26C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:04:16 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g14so13568166pfb.8
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PQhieNhO9GwYmlSfd+bk0Et080XfZXXNXb5djw3+9rU=;
        b=Zuz4qCg+E7p3JFCgL5ZoAw1F8XY8Nt+ZMpXm3vVMAyyUndUsuYcY2lesIaGSZcGrrF
         JLBB5tcOMRV3RQeIoY42HihyLLMDBJHy+4YVtAhnIX58In+wb9iAghNIgnCDTAdedf+z
         jt25QMj92Q8P6RIRqrzlLgXBqG0rCDX41S8t7CwRDx+tKDcpU+spXqLYAPOaD5wGlqLp
         02jk0kuGKPz0MyQlj0GcYtoo6LlRAak8okCL/FiYm64DFq0FDCIS7SJhc+EZfGrJSqYy
         7fc+71unrZDfgg5FhvmLTj0KQi39uK4kDWqCvj5em8HORs4Dgi6GypCpYaYy6AQXKztK
         ulcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PQhieNhO9GwYmlSfd+bk0Et080XfZXXNXb5djw3+9rU=;
        b=b3RkhkM+TUsLnVLFaMq/olkleYDk9Y1Hnv39dmdpuoNO1zCP4eXGUJ0i6xkEoMeXP2
         4+hEMrsgVDvO70/J7mIN1Qbnr7UGei8iVBOG58qB2vwSw1gOkJbg1YotcEyG1oXICAVe
         teC0io8FDxN7I5SgzRVpuE4DvjI+orvWLGNaHgMBZkwWwNoW0ZxqQJtPmR332Dl/vSPE
         w15V4ucbu8ioMpiwGj5dP962ZM+EpecK1vi83x+09tGgA5LGxXTAZh5Z7eCa04IFJGWl
         6LQ3Pwa4Orbz3s+HjlscQPgx8ZwNxbQaQhXllxlf5Ovd2/Nj7/e91pPowsmDHhCwOa21
         u2mw==
X-Gm-Message-State: AOAM533Cg8Q5WxW7gVAPJQR8pHo7JtyB6qp/nAJjG1WDmqFi+nE4H7fX
        f5FsGdE8rWGZuOnUj5ekRyEniUCWG3CE75YsSttGiW90BXyaZSdKpl9qM/9fm1+P3k/SDayw2YD
        iRMRaeqcPAomxvYbTY6TygyPS+Jf6LlQ8Kha5x37Zhmke+OE+KItVMsH2zR7d1/PS2WmU4BzxRy
        Xe
X-Google-Smtp-Source: ABdhPJzXM9b0WoKMzWWFl25LdXcZva2REGiAAO7rtFudQ3CRTtJ0PCggWIdGNULwtIRkOaX61Vt8dyMqvfqlGoE78JJo
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c14b:b029:d6:ab18:108d with
 SMTP id 11-20020a170902c14bb02900d6ab18108dmr783983plj.20.1606158255964; Mon,
 23 Nov 2020 11:04:15 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:04:12 -0800
Message-Id: <20201123190412.101265-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [RFC PATCH] usage: add trace2 entry upon warning()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
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
The documentation (see the patch below) says that it is emitted when
usage() is called, but I don't see it in the code (nor in practice). If
not emitting traces upon usage() is intended (which is reasonable to
me), I'll edit the documentation (and the commit message above).

I marked this as RFC mostly because this is a perhaps subjective
tradeoff that needs to be made. I think the tradeoff should be in favor
of tracing warning() messages, and I have explained that in the commit
message.
---
 Documentation/technical/api-trace2.txt | 2 +-
 usage.c                                | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
diff --git a/usage.c b/usage.c
index 06665823a2..673edf5afd 100644
--- a/usage.c
+++ b/usage.c
@@ -81,6 +81,12 @@ static void error_builtin(const char *err, va_list params)
 
 static void warn_builtin(const char *warn, va_list params)
 {
+	/*
+	 * We call this trace2 function first and expect it to va_copy 'params'
+	 * before using it (because an 'ap' can only be walked once).
+	 */
+	trace2_cmd_error_va(err, params);
+
 	vreportf("warning: ", warn, params);
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

