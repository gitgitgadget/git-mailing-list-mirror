Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8EC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiF3WMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiF3WMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2557221
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f8-20020a17090ac28800b001ed312c6fe1so348263pjt.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Uc1wUpswlB7QI5C9LKGx9uW0ov7hkTrcI9ayvPeZMG8=;
        b=M3BalLDQE+9d8+AzTtW2WU2jmDsmMKo2J8TCjT9nUe/ow8GnUavcB7XKyeOsdrxEam
         /3NkhF62jJMdqwbFwhQ5tfPauUKa/2vWFWE1FvwTERsuyK68bMq+EBMpTtsjBVBAnLrY
         gw2GNOUKQtE6uXorG61y6Bgz2yu8IOnGTHbJonUCwMSS2E8jNxl6PIJzyaSQwYcP4un8
         a1tCC+LQKHGf8rr1vh2vsJOf2hGD+QMWgvtx/AP426ULsLlR9ZocXyYAXMFIJC5p1r4S
         xIo7B5EtFdnXsv9TQMqvvgFbjcZBSvViuDEnWYwuxYN1BJreC5J811qRuzxBvgyCQQgI
         3k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Uc1wUpswlB7QI5C9LKGx9uW0ov7hkTrcI9ayvPeZMG8=;
        b=4NUF5rvEvL8SKKzK1F5JT0Op0XZ2NSI/EzcGxPVedJTM0snEK6l1qJnraPHbVtpe/V
         xNM/um3jSa7LsRV6/D9IZPUUX54mxrEkT+n0TKIIaFGcE9P3ttYsfMN5eHMpppp53Fdk
         S+NZJzEWMm56//mnM7SNd67zGXSsuPsHYUhAIl1XMOKSwzo6abbQshmXT4ZmT6xje6hv
         mJsQ6qyR9N3qALVixEEQPM+SGSkRRGCIux2Ofk16RP8BnKeMFj7kAZM2rkV9WmZfN+7x
         ejJiTfP66G7FY5A8ZY/0sXNZbJmKeWP1HYvoIr2ry7qlvgJphgt+6s0IDLX56ITJoWNI
         Ux4g==
X-Gm-Message-State: AJIora/xY21OjMTYrqkdjb+Sc7LICPbtvp5MOE0aHY/O1MvodJ1Ufjpw
        R2n2pTqTKgvd8qf0wv9cQkmbS4LyL7Nt/1eW8fOt6TWrosxt6mLn3MZrV5oROQvBjJl2/TaVHgT
        nVjDsc8YvmOnZkZm0Miwy6eU6FmYaT7FhQKEIMbFcRoq/yuMzji61rXvfudZyTsM=
X-Google-Smtp-Source: AGRyM1sBCrFa4EjQbMzmL2+VOGx/nSfrm8TiPXW6sO7FOtdq95yVamK6qdrPXXnXs1w/4ydO4im8Dyn5Py/JEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9206:0:b0:525:1068:c026 with SMTP id
 6-20020aa79206000000b005251068c026mr18029809pfo.52.1656627119643; Thu, 30 Jun
 2022 15:11:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:43 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-3-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 2/6] submodule--helper: don't recreate recursive prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

update_submodule() uses duplicated code to compute
update_data->displaypath and next.recursive_prefix. The latter is just
the former with "/" appended to it, and since update_data->displaypath
not changed outside of this statement, we can just reuse the already
computed result.

We can go one step further and remove the reference to
next.recursive_prefix altogether. Since it is only used in
update_data_to_args() (to compute the "--recursive-prefix" flag for the
recursive update child process) we can just use the already computed
.displaypath value of there.

Delete the duplicated code, and remove the unnecessary reference to
next.recursive_prefix. As a bonus, this fixes a memory leak where
prefixed_path was never freed (this leak was first reported in [1]).

[1] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db2d5ab799..c104b1a023 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2418,9 +2418,9 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	if (update_data->recursive_prefix)
-		strvec_pushl(args, "--recursive-prefix",
-			     update_data->recursive_prefix, NULL);
+	if (update_data->displaypath)
+		strvec_pushf(args, "--recursive-prefix=%s/",
+			     update_data->displaypath);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2516,14 +2516,6 @@ static int update_submodule(struct update_data *update_data)
 		struct update_data next = *update_data;
 		int res;
 
-		if (update_data->recursive_prefix)
-			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
-						update_data->sm_path);
-		else
-			prefixed_path = xstrfmt("%s/", update_data->sm_path);
-
-		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
-								  update_data->prefix);
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
 		oidcpy(&next.suboid, null_oid());
-- 
2.37.0.rc0.161.g10f37bed90-goog

