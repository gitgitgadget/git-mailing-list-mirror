Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E71C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBXAKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBXAJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729921E2B5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az36so733177wmb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4X8dIcN+pCagJlgAf6jZFO+KisEH6zY6nlgFheTPYw=;
        b=aOetjYVTgxj2h+uPlcZBDYI/t2iORD8zZa/JYmEx1sY/tmCb93gYJ5PMC4mkUtSJkS
         oY1Vq8Wf83MCfAhtZDCq3AhBSboTOFjzlz0BwxQNBfnObMmx+F2iiGQE0hPowRAFH9Ra
         c6jT3f/mMr32wp7OojoG2IdGN3VhxpgrxoyAlsmIa2vgZgVMbMSOsQbW+fNx18qtXQWk
         +eJukHJDGnMku6isFDZdRKASQY8pXYUPKzMDOE5QuaY9U8RdITkHTHn0WIJsLv0OuPdN
         s+3z8q91sBPPRCh9Dz1rnjloAZMPhzs9AAdeMGkiCR7jgfBDQ8QY44j+652yuLNagmB6
         jQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4X8dIcN+pCagJlgAf6jZFO+KisEH6zY6nlgFheTPYw=;
        b=dyd3vIK4dSWmHD7CBGKUa9YvCQdYw7HPVeLkZBF7gwz9gnFWWqntCoAqGB9pHSMjSI
         oD4l+t9amFO2jnV+z62q9JhgHlIE9WVnZMeasf0wNjCBZUKOD+fO2mwOGrRMD3hndJNA
         YLRqpjBMaAz3Ua67QRPCEHlLHrMyHlD97aWln1qvi/E6exApYpm7n8Bjvvd+SEl09xmo
         ZS49VUdn+vJa8ZZJ252QtAs3MY1eu4Mj7q1xj/A/c1ivFc4+7PhURO9MwhOWe1SfXdG5
         /kEBzDZLY2C/oRsZ89BjTmxPmON8i4CO5CibPsKoVbKuRfju6jjYsKM2aRgK1W5AcptJ
         ncSg==
X-Gm-Message-State: AO0yUKUb2FDJ4EyknBcnIQH7aAe8Dq+5n9Qm6mmEEY3S81jwa03XXohW
        oVMHKWxvMGEgN7Sh+zYiainwrGZerhM=
X-Google-Smtp-Source: AK7set/l0hu+GbZl8rN3u1uZ2NN/IEPGtLjFUHqDIbfnnJPF7uO4nfLkyyIAXtrkOyPsrtP1kHxsTA==
X-Received: by 2002:a05:600c:1609:b0:3e2:1592:ccf5 with SMTP id m9-20020a05600c160900b003e21592ccf5mr8218087wmn.8.1677197387907;
        Thu, 23 Feb 2023 16:09:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd12-20020a05600c1f0c00b003e0015c8618sm905561wmb.6.2023.02.23.16.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:47 -0800 (PST)
Message-Id: <f1e9b32423411b5e20ceb404dd022a5e2c67299b.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:28 +0000
Subject: [PATCH v2 09/17] pretty.h: move has_non_ascii() declaration from
 commit.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The function is defined in pretty.c, so this moves the declaration to
a more logical place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 commit.h           | 1 -
 diffcore-pickaxe.c | 4 ++--
 pretty.h           | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index cc2c5da7bdb..06657b4c6e7 100644
--- a/commit.h
+++ b/commit.h
@@ -205,7 +205,6 @@ void free_commit_list(struct commit_list *list);
 
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
-int has_non_ascii(const char *text);
 const char *logmsg_reencode(const struct commit *commit,
 			    char **commit_encoding,
 			    const char *output_encoding);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 03fcbcb40ba..13c98a7b5e7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -2,12 +2,12 @@
  * Copyright (C) 2005 Junio C Hamano
  * Copyright (C) 2010 Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
-#include "commit.h"
+#include "pretty.h"
 #include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
diff --git a/pretty.h b/pretty.h
index 9508c22f030..921dd6e0cae 100644
--- a/pretty.h
+++ b/pretty.h
@@ -153,6 +153,8 @@ int commit_format_is_empty(enum cmit_fmt);
 /* Make subject of commit message suitable for filename */
 void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
 
+int has_non_ascii(const char *text);
+
 /*
  * Set values of fields in "struct process_trailer_options"
  * according to trailers arguments.
-- 
gitgitgadget

