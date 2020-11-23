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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23377C388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A5220721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwJ+01Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgKWUpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgKWUpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:45:25 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E179C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:45:25 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d9so3081479qtr.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ha7fUR57JK2a7s4g54+hWhFMrAlKIgOOceK+jRn2cv8=;
        b=lwJ+01NcEMWCigtva1/6m73T8uCs8V92q4Oj/Ku5hkpzfmykcUK/k7EEZp0nsYtb0x
         xqlD5uSC7awYfUjTCaXCz8t3Py9XpDA5I+YXdfiWqhJMz/Zyxe35YkCM4c06GgsAfHNk
         jd5D+eQoZAvIjKYhlYQzT7eETv0hIOcJqfrC9UeaEjak0pVFpN35aBmJtLOe5Ak20lHX
         T0qdaZAUoHkHxu3i1tR7DQkc1aC+sdgVJfrqHqhsc2kEBGZXU1IBvpyeFpNkCWUu3gsj
         +f2G6DZaQx/o1U6EWv4HIwb9arJyYMJTMuL/shYkrgULcsdPF9Bp2wS4gSSZpzN5W68S
         EQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ha7fUR57JK2a7s4g54+hWhFMrAlKIgOOceK+jRn2cv8=;
        b=lkOBPS8aJ2RY65iF1wiM/0kY5Mi68wd+VNS6NkSZvDERBxHIMv5bu3AwVpcDGJWCH8
         30Ml3O/sG/9XLdn4odSQCNy6CeTMZJtT5q7IQ4PisWcdghaNhbTw0mJDd8eSpj4NWdck
         Jvf9gwnekZPhsvrxTbvhJZJ/SDJSzDF6EgYJRZYOaOCG1WDRHPGmQXC3tlsd8veeTafc
         V0SQqVacSCs0Ek+Rdqgw+7LdD6FTomvpijEuHQtq3rT7Hqur/t1H61RTEw2qYRaDQQYH
         Rc9MOMLKqFId52p2CyhFuhe7Fp1RZKHWUPQfJmP2IOuCZIRx02mXvTKJAWQZk7o+5qyB
         SnHA==
X-Gm-Message-State: AOAM531OMT15IDJL7R8aeVRjB61Vw41fgQpHMPlirUfJnOD3U3nmUiUB
        5qwsJfQxtMZni6rmsWgYBIGrqwRN5h+sG57PsYCseqdRXF0yl+wj4YQAbgSooQZiHV/DGUtDGfW
        drj8e2RdQpmCFpI4iZlGHPIo3DNkDjTaJQ6C1zpAyfFyc9VlrKeZMdQXzjDgbuadqE32SdxOK79
        Gy
X-Google-Smtp-Source: ABdhPJxYpGOFYpd8Fmy4AG1uDjqyQlMYlZxXKF1QjAxaNXdNPyntjvT5VYzC4jGz8DCqtzcDv3sEhqhzu84fvsqIVqXJ
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:17c1:: with SMTP id
 cu1mr1476142qvb.32.1606164324314; Mon, 23 Nov 2020 12:45:24 -0800 (PST)
Date:   Mon, 23 Nov 2020 12:45:22 -0800
In-Reply-To: <20201123190412.101265-1-jonathantanmy@google.com>
Message-Id: <20201123204522.675836-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201123190412.101265-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [RFC PATCH v2] usage: add trace2 entry upon warning()
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
Whoops...I ran a compile for the first version but I sent the email out
before looking at the results. The first version had a compile error,
but this one should be fine.
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

