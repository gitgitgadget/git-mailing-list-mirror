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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE1C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8299560EE7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbhIMSN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346974AbhIMSNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522DC061768
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e7-20020a056a0000c700b004391956f161so3806269pfj.18
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uQA0vp52oFr4ibA2LjJ8KV9D7k7RRMdwiHL6mqoRkZg=;
        b=ljvcUBBi4WjLrz6WAgGQIwhTFuXRB8c5aWZGbYZzW09nIlJ8xXrkJPeLGjyiS/835y
         3cZeY1DwNiVy3qZv+uoXOdTqpgioRZC0jRGpJ/k4jn9tBqMSlbCkyzjBpiOXN9iZK80w
         VBfrpejipX7XwnKCYjAk2gJK6kgxUwimpFGotMu+3VYuDvT2UDEImsFTWCwaetQeFOlv
         nULNlzuz9k0OGzEInCCHcoxSDil91FOQz7XEMC2dyIbeFNxUymQVDOwwzUncGbanro6v
         phV1ObfgEuxulfNJpvSMmE4lT242ZoFtHFVvg7GaN94kYs6Wa2COgxfS1VmoZGYoWr/s
         ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uQA0vp52oFr4ibA2LjJ8KV9D7k7RRMdwiHL6mqoRkZg=;
        b=1/nChOJdC2qm24+HENF3or7qMmRHaYFD0yu0pTH5sosUrKUlYAKD9MgVFM5At1JPE+
         YJ2e/aNbv3WJuRLaT8DliZtzTpEA2L3mXjRkDdt79ahM81KTQau0snZxdW9DMIZQgx2R
         4Jy/oWJNuGE1Xvn9SijqWC3GONfoz3oHNZdWGqwPIlFd65eD0KZ1y8ZiQ8WuJ0GRzeCq
         JV3JeO2OO6QR8b3SYfdulENMxXR5WOKsqSolHhmDqdHC9V5dM7yYyhcUWnv/jI6wA4Cp
         LLdeNamsGzCABM5yOku2KOojqmMJeKLYdOTo2+Q3cBlC5QINbAt9G2Z4ijmtJ3YrgrQT
         1xuQ==
X-Gm-Message-State: AOAM531tj0unZ3kbiQ0wn3kCU+Yt4Zt++YWsA+MWH6/7GZZnjb7qh6Ea
        mjLK/siUtQnY0KEoPhoCNduwaW9/OtAeb5LQIOcDlp19qrfXxDvhr7g84Si4MzxghqfDdMUHPS+
        MMvflIaeLxyDLc6McPXdCugQDYTACe+jWn26nwse0lKlW9gxs6FH50o5dIG71dOI=
X-Google-Smtp-Source: ABdhPJysvJlkoqDrjKVEoHQe0hNv4sn7UCzLXvHfqSAUyimo23sMnyYUNJqt26X1+pDorXAztD2Q7iz43nKafw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:b912:: with SMTP id
 z18mr12221470pge.59.1631556756280; Mon, 13 Sep 2021 11:12:36 -0700 (PDT)
Date:   Mon, 13 Sep 2021 11:12:21 -0700
In-Reply-To: <20210913181221.42635-1-chooglen@google.com>
Message-Id: <20210913181221.42635-4-chooglen@google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 3/3] gc: perform incremental repack when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/gc.c has two ways of checking of multi-pack-index is enabled:
- git_config_get_bool() in incremental_repack_auto_condition()
- the_repository->settings.core_multi_pack_index in
  maintenance_task_incremental_repack()

the_repository->settings.core_multi_pack_index should be preferred
because it has default values from prepare_repo_settings().

Standardize on the_repository->settings.core_multi_pack_index to check
if multi-pack-index is enabled.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/gc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1a..070b7dccb1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1051,12 +1051,11 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
 static int incremental_repack_auto_condition(void)
 {
 	struct packed_git *p;
-	int enabled;
 	int incremental_repack_auto_limit = 10;
 	int count = 0;
 
-	if (git_config_get_bool("core.multiPackIndex", &enabled) ||
-	    !enabled)
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_multi_pack_index)
 		return 0;
 
 	git_config_get_int("maintenance.incremental-repack.auto",
-- 
2.33.0.309.g3052b89438-goog

