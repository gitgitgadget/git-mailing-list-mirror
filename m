Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EC6C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BE961040
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 17:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhJ2SAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhJ2SAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:00:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CAC061714
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m22so17657046wrb.0
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aqujqb7afWxxPP6fwjodc3ddRBWMK+FdxNnVOd8GEjQ=;
        b=kvOPHMNHQCrsEPQLu/AwJJGUQg4VxbWLIQ0ggXSH+lOUiXCm30I0quNDbL2N1Ng0yI
         8rQKyPeW7F/Dfy++O2zMoDDCJA2eKgBIzr4YoZHm5LNmSEltWOO60miJP7MW1vE7Ry9S
         Fok7Bj68yGQO3+T5z2vZd1uGsL0tWAW6gStcRh0ETZVwNfx3R4JF2KMTgjpbAGncl5HP
         ge23f7YQ3XX3Yk2jXB4uHfEvnpYJ8+hqG+eMEFHtHnrdTWCFPP6o1JECwyu+fd/ReQnI
         Zo0yIC4qiHH6pLqqCipAnBN5u84VTdoa7XvGmWJxQdMfrQYxuV0Jm5H2abBpKRatBU/1
         RD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aqujqb7afWxxPP6fwjodc3ddRBWMK+FdxNnVOd8GEjQ=;
        b=LDYJvYAlGrBIOasLMnCDUku0OAEQZu/a0y6cR3VVPGBajdYPmBAJNYISj3Y5/JFoti
         O/B429CFzJ43T1GjwPRqjPL4CqFswDnhGkdTuDyOXTCHYGmqSU+9mlCB/fqpj2XSukYT
         +5Lc3Nj+sNH3yd+oZoy4vuUpSS96HS1AyNSn/VjBddpS0GTAsrns5p1x8L4p0cHs1t9L
         JFciGVAoaX+/fDaTmvBP/Nv087E+VdjevpseEuWp3qx1tPGSoVuMDNiLTkdEf1EQb0vY
         k6W5eXgbWeyYj71KOGz8O8HsGxsTxCq+IMIBqwbBiUc6IH/NMCtDM6fIN0Ec1PX27bgx
         0eLg==
X-Gm-Message-State: AOAM5312Zb3ourNDsIgxXwq86pstBCTOnUVSnpKra8SpqqW2wxZiIT9s
        rLZNA0iBPOshVK9O4nrTW7mh/KrQuf4=
X-Google-Smtp-Source: ABdhPJxbY7botM88WHKm8KgZ1DCdKkHHg4hZZMulXLjqzbzTx+ngvyFgwmG0zeA+rQUxCIwV/ilcAg==
X-Received: by 2002:adf:eb4b:: with SMTP id u11mr1668829wrn.49.1635530298287;
        Fri, 29 Oct 2021 10:58:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm5661488wmq.0.2021.10.29.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:58:18 -0700 (PDT)
Message-Id: <5c9deaf0bccfe158c7f410f084529850a33b7fd0.1635530296.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
        <pull.1063.v2.git.1635530296.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 17:58:15 +0000
Subject: [PATCH v2 1/2] docs: fix places that break compilation in
 MyFirstObjectWalk
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

Two errors in the example code caused compilation failures due to
a missing semicolon as well as initialization with an empty struct.
This commit fixes that to make the MyFirstObjectWalk tutorial easier to
follow.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 45eb84d8b48..e22615105c0 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -58,6 +58,7 @@ running, enable trace output by setting the environment variable `GIT_TRACE`.
 
 Add usage text and `-h` handling, like all subcommands should consistently do
 (our test suite will notice and complain if you fail to do so).
+We'll need to include the `parse-options.h` header.
 
 ----
 int cmd_walken(int argc, const char **argv, const char *prefix)
@@ -65,7 +66,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	const char * const walken_usage[] = {
 		N_("git walken"),
 		NULL,
-	}
+	};
 	struct option options[] = {
 		OPT_END()
 	};
@@ -195,7 +196,8 @@ Similarly to the default values, we don't have anything to do here yet
 ourselves; however, we should call `git_default_config()` if we aren't calling
 any other existing config callbacks.
 
-Add a new function to `builtin/walken.c`:
+Add a new function to `builtin/walken.c`.
+We'll also need to include the `config.h` header:
 
 ----
 static int git_walken_config(const char *var, const char *value, void *cb)
@@ -229,7 +231,9 @@ typically done by calling `repo_init_revisions()` with the repository you intend
 to target, as well as the `prefix` argument of `cmd_walken` and your `rev_info`
 struct.
 
-Add the `struct rev_info` and the `repo_init_revisions()` call:
+Add the `struct rev_info` and the `repo_init_revisions()` call.
+We'll also need to include the `revision.h` header:
+
 ----
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
@@ -624,7 +628,8 @@ static void walken_object_walk(struct rev_info *rev)
 ----
 
 Let's start by calling just the unfiltered walk and reporting our counts.
-Complete your implementation of `walken_object_walk()`:
+Complete your implementation of `walken_object_walk()`.
+We'll also need to include the `list-objects.h` header.
 
 ----
 	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
@@ -697,7 +702,7 @@ First, we'll need to `#include "list-objects-filter-options.h"` and set up the
 ----
 static void walken_object_walk(struct rev_info *rev)
 {
-	struct list_objects_filter_options filter_options = {};
+	struct list_objects_filter_options filter_options = { 0 };
 
 	...
 ----
-- 
gitgitgadget

