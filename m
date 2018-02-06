Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC771F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBFAZE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42948 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeBFAYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:24:47 -0500
Received: by mail-pg0-f65.google.com with SMTP id m28so165279pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VSoFK/wzCPQUGr+v3mwPM+XwSNsvgPhTJIRq8H4rwcE=;
        b=pmvnOaA+hHNBLsLxj1F0LZngONTJV3EcD8qkH/4mJxH6zLC0kI4C2JE/Hwypdm773T
         OjCbf4cnsZbOJ5QIo66Jm5hcu0OoLHuOfUQ88z6H9cRp0e/bLrNag4jedIqkV3RXvQQk
         VnNFOYagORS8u6cVnmT5WzfkRCbMxZwZWi2SKKMOhJIsEyYpKJ7sy0iGwekQBbTtJUUc
         keUunCQYCSi9jTOSaduyC8I+q1B3zzgZyQ9kjA84gmJEUe5Hyubs+JNb9+sE4qjAM5Je
         dB7SBTZe6rY8zGapwFAdLHG40UF4LEXxoI5aUgCAT6doaKcXKhAoExfFDsoJyQui/DJH
         6cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VSoFK/wzCPQUGr+v3mwPM+XwSNsvgPhTJIRq8H4rwcE=;
        b=aB1OGMCon6ofXYoVoLmllDQR2kngqJ3fQFK5eeyuelpePp3MFuD0GDnUh9dq5b6IwD
         FSntUs/0enetd+p8/0QSJASMpojyzIJFgDbVhTh53hgw5CAGPot9qKA97T036z9pOawX
         CpV6G7eNQPEesnSAAeNSJhQs9lr91O+fiBgGHULcYsRcHuiI7YglmTkBS2HKjNap3hhY
         pFXJinnjMeJuZRZ3cVTW5/d0k1tLPDDmLJes7I1fNsYnjYNIHV2pQ/ZvEq/SoNOMAcot
         tLrQWf3wXeDSo2eSDGIIDXniduqq63Gnhjw6tzdni6nh6masjTxG+fzxU6d8ydABm+yt
         06iQ==
X-Gm-Message-State: APf1xPCjMfGEnCFTYByRulYzxK8iltvfrg89+kCku56YOJu8LEQhbb/4
        qsv6tS8oLhg5AU9yDwwH1Z2nfn/uY0g=
X-Google-Smtp-Source: AH8x2269c+Rn3SqrbBXmoaJTUhriPxoe5WQ2npEv032r0yYx7dAkcuwdXaK/whL2ttN6iq0MaLypBQ==
X-Received: by 10.99.102.193 with SMTP id a184mr452436pgc.141.1517876685904;
        Mon, 05 Feb 2018 16:24:45 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j83sm14430074pfe.47.2018.02.05.16.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:24:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 143/194] object: add repository argument to parse_commit_gently
Date:   Mon,  5 Feb 2018 16:16:58 -0800
Message-Id: <20180206001749.218943-45-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of parse_commit_gently to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                              | 2 +-
 commit.h                              | 5 +++--
 contrib/coccinelle/object_store.cocci | 9 +++++++++
 revision.c                            | 4 ++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 3a990b7078..93a4f70fa4 100644
--- a/commit.c
+++ b/commit.c
@@ -384,7 +384,7 @@ int parse_commit_buffer_the_repository(struct commit *item, const void *buffer,
 	return 0;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing)
 {
 	enum object_type type;
 	void *buffer;
diff --git a/commit.h b/commit.h
index 870ad525fd..bb2b1e1e28 100644
--- a/commit.h
+++ b/commit.h
@@ -66,10 +66,11 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 
 #define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
 int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
-int parse_commit_gently(struct commit *item, int quiet_on_missing);
+#define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
+int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
-	return parse_commit_gently(item, 0);
+	return parse_commit_gently(the_repository, item, 0);
 }
 void parse_commit_or_die(struct commit *item);
 
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 3d29868dbf..93b1d03971 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -44,3 +44,12 @@ expression H;
 open_istream(
 + the_repository,
  E, F, G, H)
+
+@@
+expression E;
+expression F;
+@@
+ parse_commit_gently(
++ the_repository,
+  E, F)
+
diff --git a/revision.c b/revision.c
index 5c5375ac54..7501ef3160 100644
--- a/revision.c
+++ b/revision.c
@@ -775,7 +775,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			parent = parent->next;
 			if (p)
 				p->object.flags |= UNINTERESTING;
-			if (parse_commit_gently(p, 1) < 0)
+			if (parse_commit_gently(the_repository, p, 1) < 0)
 				continue;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -802,7 +802,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 
-		if (parse_commit_gently(p, revs->ignore_missing_links) < 0)
+		if (parse_commit_gently(the_repository, p, revs->ignore_missing_links) < 0)
 			return -1;
 		if (revs->show_source && !p->util)
 			p->util = commit->util;
-- 
2.15.1.433.g936d1b9894.dirty

