Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8695C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiKHODH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiKHODF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:03:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489F68689
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:03:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id y14so38843566ejd.9
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXoOXZvcuu3Va/PwxQH3BksTnvrduIvBJbFKJ2zZZqA=;
        b=NxcT0LyN9K4CqqplXznR/EIPedBW5VMDe4czdoX/S3qWEa6uSok+kPkXqt5oRzkINI
         gawL/PQB7inibSTZ90P90pxjJpCszyTWJVJhwQlfgDxNrwFvonP/8smEGUv87Q1DjIpH
         /+yDZuaaA1M7X5Tspb94k1jFAyENMcE41HBI0l7gErqv1/NsDhHcDy0rjiJ+4HgRw5Dn
         2Oa0xNRcNh6SOpTdCIo7I3Cybm+69x9KjrLZohbwT17PZM71rbJSftvRUAuubPm09onb
         vK286NAsfZ7Pz6nQ0Z977l8/v/Fl06vgY8N93qHI/Hq0g0hbRP3unTeeoCSwiaBHuKgM
         K/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXoOXZvcuu3Va/PwxQH3BksTnvrduIvBJbFKJ2zZZqA=;
        b=l7uKvvc0A8VqGciXjWvXtM5Gf0EtzfjbWABseUl1r9aDqwryvXdYixkH8hLf1jRL+C
         C8F4TLnmkZPgK19rVEOcxR+Z+BlT9n8D1HdSrHFedgpoE6dbUPJKp6xS7zTbDWc78wll
         lxdl3qj5i6/vtrDtqer/YKHUTpPZ6suGNoGnInKXGyNXFgaiu5z2gwiRounEEcm10jG0
         WqWGj4Ryxq1IGmGkoL1O39wB8JlVDyCYTsjC7+yApI8678VHXf2yM1wPCDqsWAEqvnN6
         iw+6FGic9fjcr0gxSXbEgZ+x0gXo7MXnhqiEfds5CzUNPB7tzux9IhIRc4eptieF7Cpy
         b20w==
X-Gm-Message-State: ACrzQf12MFiRMmgK98WY/PyGFJkHoQoab/5yyM3Nui6AtiKPQJQ+joiv
        UcxR0u1ulhsSfbVdME65oibpHCdMcw71ag==
X-Google-Smtp-Source: AMsMyM7TdmyyvIf3bjQAVtXsm+kOe+KmdyWSUQQ8q4lrKisWau0zalQfHXHI9JHRj1oWFUfVNbYQCQ==
X-Received: by 2002:a17:907:7626:b0:7aa:987f:4e8f with SMTP id jy6-20020a170907762600b007aa987f4e8fmr53686952ejc.204.1667916182390;
        Tue, 08 Nov 2022 06:03:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7df0e000000b00461e4498666sm5576935edy.11.2022.11.08.06.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:03:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] revisions API: extend the nascent REV_INFO_INIT macro
Date:   Tue,  8 Nov 2022 15:02:57 +0100
Message-Id: <patch-1.1-c3afcd69ddb-20221108T140134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the REV_INFO_INIT macro added in [1] declare more members of
"struct rev_info" that we can initialize statically, and have
repo_init_revisions() do so with the memcpy(..., &blank) idiom
introduced in [2].

As the comment for the "REV_INFO_INIT" macro notes this still isn't
sufficient to initialize a "struct rev_info" for use yet. But we are
getting closer to that eventual goal.

Even though we can't fully initialize a "struct rev_info" with
REV_INFO_INIT it's useful for readability to clearly separate those
things that we can statically initialize, and those that we can't.

This change could replace the:

	list_objects_filter_init(&revs->filter);

In the repo_init_revisions() with this line, at the end of the
REV_INFO_INIT deceleration in revisions.h:

	.filter = LIST_OBJECTS_FILTER_INIT, \

But doing so would produce a minor conflict with an outstanding
topic[3]. Let's skip that for now. I have follow-ups to initialize
more of this statically, e.g. changes to get rid of grep_init(). We
can initialize more members with the macro in a future series.

1. f196c1e908d (revisions API users: use release_revisions() needing
   REV_INFO_INIT, 2022-04-13)
2. 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
   macro, 2021-07-01)
3. https://lore.kernel.org/git/265b292ed5c2de19b7118dfe046d3d9d932e2e89.1667901510.git.ps@pks.im/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A small follow-up to what I mentioned in[1]. As noted above there's a
very small part of Patrick's series that *could* use this[2] (getting
rid of the trivial "init_ref_exclusions"), but let's not hold that up
for this minor cleanup, and have these proceed concurrently without
conflicts.

1. https://lore.kernel.org/git/221107.86tu3ax5b6.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/265b292ed5c2de19b7118dfe046d3d9d932e2e89.1667901510.git.ps@pks.im/

 revision.c | 19 ++-----------------
 revision.h | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/revision.c b/revision.c
index 0760e78936e..c6b39965834 100644
--- a/revision.c
+++ b/revision.c
@@ -1865,30 +1865,15 @@ void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
 {
-	memset(revs, 0, sizeof(*revs));
+	struct rev_info blank = REV_INFO_INIT;
+	memcpy(revs, &blank, sizeof(*revs));
 
 	revs->repo = r;
-	revs->abbrev = DEFAULT_ABBREV;
-	revs->simplify_history = 1;
 	revs->pruning.repo = r;
-	revs->pruning.flags.recursive = 1;
-	revs->pruning.flags.quick = 1;
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->pruning.change_fn_data = revs;
-	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
-	revs->dense = 1;
 	revs->prefix = prefix;
-	revs->max_age = -1;
-	revs->max_age_as_filter = -1;
-	revs->min_age = -1;
-	revs->skip_count = -1;
-	revs->max_count = -1;
-	revs->max_parents = -1;
-	revs->expand_tabs_in_log = -1;
-
-	revs->commit_format = CMIT_FMT_DEFAULT;
-	revs->expand_tabs_in_log_default = 8;
 
 	grep_init(&revs->grep_filter, revs->repo);
 	revs->grep_filter.status_only = 1;
diff --git a/revision.h b/revision.h
index afe1b77985f..8493a3f3b93 100644
--- a/revision.h
+++ b/revision.h
@@ -357,7 +357,23 @@ struct rev_info {
  * called before release_revisions() the "struct rev_info" can be left
  * uninitialized.
  */
-#define REV_INFO_INIT { 0 }
+#define REV_INFO_INIT { \
+	.abbrev = DEFAULT_ABBREV, \
+	.simplify_history = 1, \
+	.pruning.flags.recursive = 1, \
+	.pruning.flags.quick = 1, \
+	.sort_order = REV_SORT_IN_GRAPH_ORDER, \
+	.dense = 1, \
+	.max_age = -1, \
+	.max_age_as_filter = -1, \
+	.min_age = -1, \
+	.skip_count = -1, \
+	.max_count = -1, \
+	.max_parents = -1, \
+	.expand_tabs_in_log = -1, \
+	.commit_format = CMIT_FMT_DEFAULT, \
+	.expand_tabs_in_log_default = 8, \
+}
 
 /**
  * Initialize a rev_info structure with default values. The third parameter may
-- 
2.38.0.1464.gea6794aacbc

