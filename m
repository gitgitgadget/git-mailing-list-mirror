Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCF61F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfHOVlq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36966 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOVli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so1278518pgp.4
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvDOI/3Eye7eflnivNRY5diCc1h9uwuWsQqALfEhBWE=;
        b=mmV7T7lOGFZbSTHU8dqGbhMp5Uk9BUC4d5NJmGt3IXu2MYpsqFJycWvMZ/Cnd21Afw
         l5GLMIEMVAmpkqbPZM8aNruLYIABC+3X0KGED+TN83mjqcmuXkkvXqTLoGN8ixk3e9iP
         06zbFdir2TfiORgMHobMNyUx+rfPgnQUtzLlrV5sa+GirNsNNE+VZJ4HzbCyccLPQrjz
         Be4kPGKsDz1hVu3vutK78ijU3skhNWlKFZn/bHjtQcbry1GgSZact00tPPoXOcptullT
         pJuomIp6CPh0XQGes5y3tKBEY173uW35pGWbv3y1lGE8zNneKKaoG2QFSBFlbt55mNC9
         cxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvDOI/3Eye7eflnivNRY5diCc1h9uwuWsQqALfEhBWE=;
        b=RlRlGmMCtZ8ZH/KvNj8qkMLhEW8mh+/J1/OSrpI8aJIFINIsw7/nS0qCAkA/2rxOrR
         HsEyWtKY15WIUcFDgwMjIWZCjRbGTkrsgq8YnQXCRLJX7AlhGvthp4n8UioD3+hyfjcC
         q4VIVc2J2IErpv9Uv5zLiE5apy/v2OtfUSu8GFkQRcprZcEoXUZH7oK4i69v1i/AmHRS
         6HzuGd99i9qV+C4hZ0hFTJfOlOgU2IdvVZIDGhPWo8L4rxhjMBq53NHGqY4iTwJ0RKr9
         d8n3tYIhUowZjgV5f8z8PToj4d/6PNmpmabVyPaDFu5k0RHY6wlk4W+3hvgOG2jn4a4s
         I6ew==
X-Gm-Message-State: APjAAAUr83kzckPx4dvCwspdynYTjC2vFfl8MDStjoy38A2O0mMC7uEB
        mHAw6vLp8zhq+sFc8k9LFi4CLi1a
X-Google-Smtp-Source: APXvYqwK9OHEm8SVe4QBLQpv5iDQ3zllVGN9EFgCYk4jv7wu4MiswTEunHFL/UQSaKEimL4IIeMmEA==
X-Received: by 2002:a17:90a:3847:: with SMTP id l7mr3884814pjf.99.1565905297024;
        Thu, 15 Aug 2019 14:41:37 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 22/24] merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
Date:   Thu, 15 Aug 2019 14:40:51 -0700
Message-Id: <20190815214053.16594-23-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to implement the same outward facing API as found within
merge-recursive.h in a different merge strategy.  However, that makes
names like MERGE_RECURSIVE_{NORMAL,OURS,THEIRS} look a little funny;
rename to MERGE_VARIANT_{NORMAL,OURS,THEIRS}.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 14 +++++++-------
 merge-recursive.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 840b09f1dc..647b1f25c3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1045,10 +1045,10 @@ static int merge_3way(struct merge_options *opt,
 		ll_opts.variant = 0;
 	} else {
 		switch (opt->recursive_variant) {
-		case MERGE_RECURSIVE_OURS:
+		case MERGE_VARIANT_OURS:
 			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
 			break;
-		case MERGE_RECURSIVE_THEIRS:
+		case MERGE_VARIANT_THEIRS:
 			ll_opts.variant = XDL_MERGE_FAVOR_THEIRS;
 			break;
 		default:
@@ -1355,15 +1355,15 @@ static int merge_mode_and_contents(struct merge_options *opt,
 							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
-			case MERGE_RECURSIVE_NORMAL:
+			case MERGE_VARIANT_NORMAL:
 				oidcpy(&result->blob.oid, &a->oid);
 				if (!oid_eq(&a->oid, &b->oid))
 					result->clean = 0;
 				break;
-			case MERGE_RECURSIVE_OURS:
+			case MERGE_VARIANT_OURS:
 				oidcpy(&result->blob.oid, &a->oid);
 				break;
-			case MERGE_RECURSIVE_THEIRS:
+			case MERGE_VARIANT_THEIRS:
 				oidcpy(&result->blob.oid, &b->oid);
 				break;
 			}
@@ -3801,9 +3801,9 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
-		opt->recursive_variant = MERGE_RECURSIVE_OURS;
+		opt->recursive_variant = MERGE_VARIANT_OURS;
 	else if (!strcmp(s, "theirs"))
-		opt->recursive_variant = MERGE_RECURSIVE_THEIRS;
+		opt->recursive_variant = MERGE_VARIANT_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		opt->subtree_shift = "";
 	else if (skip_prefix(s, "subtree=", &arg))
diff --git a/merge-recursive.h b/merge-recursive.h
index 58a4c5238a..978847e672 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -32,9 +32,9 @@ struct merge_options {
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
 	enum {
-		MERGE_RECURSIVE_NORMAL = 0,
-		MERGE_RECURSIVE_OURS,
-		MERGE_RECURSIVE_THEIRS
+		MERGE_VARIANT_NORMAL = 0,
+		MERGE_VARIANT_OURS,
+		MERGE_VARIANT_THEIRS
 	} recursive_variant;
 
 	/* console output related options */
-- 
2.23.0.rc2.32.g2123e9e4e4

