Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3619FC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0CD6101E
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2TzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJ2TzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 15:55:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771BC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so18148509wrv.9
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1XFWB784wKgkRwHFHCBuAZN7J4iTJJG9v9cyMoZpL4=;
        b=L2Gvy+rgqQe+Fm2ihm237XshWq5n8jB5artBH2KQDxzVgS8LHdK62es70pZEhvgD9Q
         Erxu9+k7XUQ//nU/3IGqgQvOvNJyOboWk7M4TAOqa7u8bDBbP1/FdIi0135WceNxJj6c
         VOHrwIa5dEhnDnvPS2ArPoRj31zccwpAGqGWpLk+TCK37sDeSgfWZ2iGWhIRsXyuGMEi
         KLz+lgfIPExzNTxJOUivnXQj+CyJk4YGKkNHD32vMqCgXrJOR72Ig0+by5aEKROxvLiX
         Xj+1ECRiSHV+GIjXQLf9OiiKw4mSEYusitmUenI4Sek5HfImjFwAmLNyEw8fO2Vt7I7O
         hTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c1XFWB784wKgkRwHFHCBuAZN7J4iTJJG9v9cyMoZpL4=;
        b=AchhgsNhnmTH3HCEtc0KHJhMwxfa62/gnU2fG3d8Nerfb/RwRx8A0kRwNHgotpI5yQ
         zkKQh/ZLt9ZHErWSQbMN3jLrKRqs+9wnAseo5a2ocrn71srz6B/JrQ2+KE9EsETa5WlB
         /S+7pl8ptUac/ZFCKLsmTVzNPTixpimsAzd3CxA4002XfStELkNQoJ42GEdoJerqHkU1
         XGyjA11JCS+XxcBis2SSOLGa2IMz5BdUNWtoMB2Cx3GaGAB8jLxl4CEnr/T3KdM0rvbj
         dFTRpCbMsDLmTI2v4emS7rzAYpUdXdaNL8JDP9L1JiyWXHSZj57AZD2Haa6ueclNoSbg
         Ngcg==
X-Gm-Message-State: AOAM530Szcfr+WvC9gMrO0lHsLsByJBmSXgW7V8iV58qFyoje+ULiYpf
        Yjqr8wy1iFe7wyL/GhpJFcpb/PIaHjo=
X-Google-Smtp-Source: ABdhPJzjLk9OhwfznLqTI9McRP1wdXFD/VWOdM8WMkGjAusnG49aXptpLFPj9klGOx+HFlljIAXlAw==
X-Received: by 2002:adf:e387:: with SMTP id e7mr5821104wrm.412.1635537165743;
        Fri, 29 Oct 2021 12:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm6657150wmq.13.2021.10.29.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:52:45 -0700 (PDT)
Message-Id: <1535671dd6af917246ba642b00fc51f7a8f29edf.1635537163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
References: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
        <pull.1063.v3.git.1635537163.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 19:52:43 +0000
Subject: [PATCH v3 2/2] docs: add headers in MyFirstObjectWalk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In several places, headers need to be included or else the code won't
compile. Since this is the first object walk, it would be nice to
include them in the tutorial to make it easier to follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index bf0a7c1f766..ca267941f3e 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -58,8 +58,13 @@ running, enable trace output by setting the environment variable `GIT_TRACE`.
 
 Add usage text and `-h` handling, like all subcommands should consistently do
 (our test suite will notice and complain if you fail to do so).
+We'll need to include the `parse-options.h` header.
 
 ----
+#include "parse-options.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	const char * const walken_usage[] = {
@@ -195,9 +200,14 @@ Similarly to the default values, we don't have anything to do here yet
 ourselves; however, we should call `git_default_config()` if we aren't calling
 any other existing config callbacks.
 
-Add a new function to `builtin/walken.c`:
+Add a new function to `builtin/walken.c`.
+We'll also need to include the `config.h` header:
 
 ----
+#include "config.h"
+
+...
+
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
 	/*
@@ -229,8 +239,14 @@ typically done by calling `repo_init_revisions()` with the repository you intend
 to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
 struct.
 
-Add the `struct rev_info` and the `repo_init_revisions()` call:
+Add the `struct rev_info` and the `repo_init_revisions()` call.
+We'll also need to include the `revision.h` header:
+
 ----
+#include "revision.h"
+
+...
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	/* This can go wherever you like in your declarations.*/
@@ -624,9 +640,14 @@ static void walken_object_walk(struct rev_info *rev)
 ----
 
 Let's start by calling just the unfiltered walk and reporting our counts.
-Complete your implementation of `walken_object_walk()`:
+Complete your implementation of `walken_object_walk()`.
+We'll also need to include the `list-objects.h` header.
 
 ----
+#include "list-objects.h"
+
+...
+
 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
 
 	printf("commits %d\nblobs %d\ntags %d\ntrees %d\n", commit_count,
-- 
gitgitgadget
