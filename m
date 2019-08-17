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
	by dcvr.yhbt.net (Postfix) with ESMTP id B97421F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHQSm0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37411 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfHQSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so4815274pfa.4
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvRWqFVyOHoucwg5J9Nf3LMAwNCSQ281wrX5Pg1DAhM=;
        b=d9CNBfeI+gYiShdSmJqKbJgEJvfFvNOtEQ+2pUxYkdyHWrmzZ9lVJM1Lz2zIN9n2QE
         DCZYKyf8Zy9+RUtpLwWkVVKFiTMrvEqFKws9FgGcUCK7FdrM5jsGnG8f6OTxSoBae/l1
         JDY38I6pQdq9/thoUwzs1ZJhje6kM0lZlnzeDnk0lvmRN2LQRpgZSwAxl7NkyUqQO8Cs
         Hyij4mtnnkh8UzZ644LLI5vGMd+yc/UjT8INixywzH/AJ2u+pQYEAGEa5gOC3GcPoS5E
         ykr8vCx7bbqNeqmrfyDknLxX3K8SyUaVoEUMJfC/jTYjVZuev7jI8jfpdNn0PXwTtrQR
         1PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvRWqFVyOHoucwg5J9Nf3LMAwNCSQ281wrX5Pg1DAhM=;
        b=U0Sq1Kd0K99KZYxIAQmO0jJvkuRVPWQBvPWKmwo4zho3lWkexEoB2sCT3E6ULFfrHz
         9aB+35TtMVnOZJBYK8t0iPOhDNdFEXJVtjSLbWLFG+LZ54FWtZlCOAmwppg9ag8RbX/7
         e1cPMK1QzwXMqXSnFqyTXJSAOWt/aecBowV6DwMTw7dUosThF/vzTtk15OopD7ac6Iv7
         qAZatOD/XnlqMK9VOLw/0EztzyCmUKmW9I8S7XRyQ2DN23ENSj0i8KUpH0MLEJbz0kys
         G4yk8/os4HfLsnum4QVymChqMvgpNQ90bILNefxOipOjGvZvuNJnn2yCXNL1aoVOkjP/
         d59w==
X-Gm-Message-State: APjAAAUE7toW96KQPp90ECEW8/qujX2wT/RJks2aZeDJ/68I0Pd5M16Q
        J5t++4UWFflEQpSZKz80zf+GeD4u
X-Google-Smtp-Source: APXvYqxx0RD8oPnoELnOjHzmhCABv7BI67My4SiTsfWxfJWnMwhRMkLxqSj0/taZxUJ6MEvdSpWLLw==
X-Received: by 2002:a63:2887:: with SMTP id o129mr12731982pgo.179.1566067342790;
        Sat, 17 Aug 2019 11:42:22 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 22/24] merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
Date:   Sat, 17 Aug 2019 11:41:42 -0700
Message-Id: <20190817184144.32179-23-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
index c92993e8f0..fa3f8eb0b2 100644
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
@@ -3795,9 +3795,9 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
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
2.23.0.rc2.28.g5f89f15d7b.dirty

