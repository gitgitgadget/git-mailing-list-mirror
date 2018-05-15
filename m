Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86751F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeEOXnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:08 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:39668 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeEOXnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:43:04 -0400
Received: by mail-pg0-f42.google.com with SMTP id e1-v6so726482pga.6
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zEjQUSO0KCe/ZZrVdOjp2dd0J72fGe0UsoYi5h2U5p0=;
        b=EoUPz4w2LEadin5BzV5x4kaAxZl51p7phuGhoN0x5uU+x/k9eKpupM+Q75r0+h7Icc
         Jv+vs/yVI4YIQVakyJd+gxdlynmxkQ3hmI9KJBtWL9hF8f6RzPVOvksfXey/e34L+VD+
         w+k80s0Tn+Ralq+TUZwEPmSzh/Wmo7Xp4ZbWpBZCLsf7TCFC1bo9OA97WOfZk7TodJ7w
         w/4xwFaq9pTwtS/vHld+UqUlOg5Dc0E23FJCGRrhdqGZKrJVUS6Khcget/ikY6+HvWxO
         EG/HLz1VEXuUil6Uih/bvQEp1bE/spjL9b8EBxP2SIgAnMM67VcosVwz2EvEEE0RdwVP
         nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zEjQUSO0KCe/ZZrVdOjp2dd0J72fGe0UsoYi5h2U5p0=;
        b=hndfGxCz521msGgi6S827d7ghlT4oLMbuS5RqU8YrLSaHZbtwyTMu1aAhVLGRnE9hA
         oMrR/rsq3Nn6AQ5Xqy2rza8NFPWEoARuDdcQxfZkz9R8zDCWykqViWqlIftEJm1ZFvep
         QZI6rx3KWAuUqAVrUmTrlCGvZA2f/tl9tO7r8MhFCBDMSm8dNdIHoFFhuj8Xmlw+A/Eg
         JKrSSIut3YEsAYUkG9R4r8U+FXDRTSfbjlXTBtygXEZXrwlvPwDRknrTsfLyRw61/3Wj
         sJUzJOxuQuAcA1vmZoeDp9buPqqgEzWR1KyIlKp+FjlGPTHzdpwb//QUnLSw2jnHYGtJ
         HtIQ==
X-Gm-Message-State: ALKqPweYFSDJ4CM3Jh5TrUQ5Plk4eVPcPvNhlXdr1ETJt8J9StVl9Dpc
        N1WHAs9dV8fuRZJNywiQSIwdJ80d3SM=
X-Google-Smtp-Source: AB8JxZrA48eg1Ba6ajdCO6XDWLsGb0f8GakrZzrGdkpOi8Wpqg7pXH6c8NyGjzHAU1wR6KgiSjdHXw==
X-Received: by 2002:a62:9d89:: with SMTP id a9-v6mr17103134pfk.206.1526427783549;
        Tue, 15 May 2018 16:43:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w19-v6sm975059pgv.59.2018.05.15.16.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:43:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/19] commit: allow lookup_commit_graft to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:33 -0700
Message-Id: <20180515234233.143708-20-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 commit.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index eef1675d692..b01cc0c3e0c 100644
--- a/commit.c
+++ b/commit.c
@@ -209,14 +209,14 @@ static void prepare_commit_graft(struct repository *r)
 	r->parsed_objects->commit_graft_prepared = 1;
 }
 
-struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid)
+struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid)
 {
 	int pos;
-	prepare_commit_graft(the_repository);
-	pos = commit_graft_pos(the_repository, oid->hash);
+	prepare_commit_graft(r);
+	pos = commit_graft_pos(r, oid->hash);
 	if (pos < 0)
 		return NULL;
-	return the_repository->parsed_objects->grafts[pos];
+	return r->parsed_objects->grafts[pos];
 }
 
 int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
diff --git a/commit.h b/commit.h
index 45114a95b25..6de6f10cd04 100644
--- a/commit.h
+++ b/commit.h
@@ -175,8 +175,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
-#define lookup_commit_graft(r, o) lookup_commit_graft_##r(o)
-struct commit_graft *lookup_commit_graft_the_repository(const struct object_id *oid);
+struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
-- 
2.17.0.582.gccdcbd54c44.dirty

