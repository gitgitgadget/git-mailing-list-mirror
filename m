Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72679C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9BC20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/s3jJkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgE2IvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgE2IvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86936C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so2413139wmh.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9feaE5i968rtyL1eHI9KIXlmeHS1tXADrHmqrjGlOZg=;
        b=D/s3jJkUSEcxc8O1HyXsTWSrutJrYjENw9C+ljo1ju+SL5mVHURTnNWR7JyFNKIMB3
         kfftHn7LnPdQ7e+vFwBf2K/408YtfmWiT1U1k/OTHxK+/KIuMT1nqVQQDvKNH68LTOU0
         rEzzHSC+2n+klQyUMYuAPrzg7zUNpyLe6cSIlIIsM40GeMFdcrFJkgCUQ3/Mk7dbPayg
         LHL2CqkdMNBupOq+hFuB7gB53WItcMCtve+l9jhHuVeKnAdOIq8T5PefPR3DwvArs1hp
         dZyzg6qkiGzjmUrZ2zllA/h+G9DrHhPibeV0xoN9FRFgvt3lIpJ06DwomLHWTTUFbLpp
         3R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9feaE5i968rtyL1eHI9KIXlmeHS1tXADrHmqrjGlOZg=;
        b=tDlF1LwlCEuXGgV45zGRKOtTouJxvtb8oliGjC6Af90zAX+sok/zswT51BECFbu68c
         j0OKdxDqe3qccMuoDbzAjc1LTLCE0UJ+xJaKNmdIy7lyygjqpxijybOQAMllb+gOM558
         m6rQc0Q09sVDy8u5HhoawSiKlTtBGHvotD5XHESfSL4OwM7li3peDnGotzs+lrcgdefk
         KnhH+nCLM6aYlhu5AEpy5gWwNMecTTSg9jWAwAjcSKd+8uLQ1rAQpd1BSjYsEXkyvpEa
         LZwInNZD3Oyzc1VBW/scGo5EtFBG5N5yr7KU1EhpVgdSrvJXYGCW4MdwVh4JWy6Q7sGJ
         zInQ==
X-Gm-Message-State: AOAM533yA9RUo5UOkKKl7w5zVlHal2AWvUX1BfSk0XM0w4Qh5sqBz/ZE
        RWo/WoSaMGAXxPNsxY9p7Sqveiyd
X-Google-Smtp-Source: ABdhPJzMwBW9RdJ4Q8fGNviLRNDgPbhlz+rGiWlQfIwSO+KWQBDABZBx6e1bZY2jjETBgpklpNGImw==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr2270196wma.83.1590742263858;
        Fri, 29 May 2020 01:51:03 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/34] diff.h: drop diff_tree_oid() & friends' return value
Date:   Fri, 29 May 2020 10:50:09 +0200
Message-Id: <20200529085038.26008-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ll_diff_tree_oid() has only ever returned 0 [1], so it's return value
is basically useless.  It's only caller diff_tree_oid() has only ever
returned the return value of ll_diff_tree_oid() as-is [2], so its
return value is just as useless.  Most of diff_tree_oid()'s callers
simply ignore its return value, except:

  - diff_root_tree_oid() is a thin wrapper around diff_tree_oid() and
    returns with its return value, but all of diff_root_tree_oid()'s
    callers ignore its return value.

  - rev_compare_tree() and rev_same_tree_as_empty() do look at the
    return value in a condition, but, since the return value is always
    0, the former's < 0 condition is never fulfilled, while the
    latter's >= 0 condition is always fulfilled.

So let's drop the return value of ll_diff_tree_oid(), diff_tree_oid()
and diff_root_tree_oid(), and drop those conditions from
rev_compare_tree() and rev_same_tree_as_empty() as well.

[1] ll_diff_tree_oid() and its ancestors have been returning only 0
    ever since it was introduced as diff_tree() in 9174026cfe (Add
    "diff-tree" program to show which files have changed between two
    trees., 2005-04-09).
[2] diff_tree_oid() traces back to diff-tree.c:main() in 9174026cfe as
    well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 diff.h      | 10 +++++-----
 revision.c  |  9 +++------
 tree-diff.c | 21 +++++++++------------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/diff.h b/diff.h
index 6febe7e365..a1459de824 100644
--- a/diff.h
+++ b/diff.h
@@ -426,11 +426,11 @@ struct combine_diff_path *diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-int diff_tree_oid(const struct object_id *old_oid,
-		  const struct object_id *new_oid,
-		  const char *base, struct diff_options *opt);
-int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
-		       struct diff_options *opt);
+void diff_tree_oid(const struct object_id *old_oid,
+		   const struct object_id *new_oid,
+		   const char *base, struct diff_options *opt);
+void diff_root_tree_oid(const struct object_id *new_oid, const char *base,
+			struct diff_options *opt);
 
 struct combine_diff_path {
 	struct combine_diff_path *next;
diff --git a/revision.c b/revision.c
index 8136929e23..9dac1262ef 100644
--- a/revision.c
+++ b/revision.c
@@ -655,15 +655,12 @@ static int rev_compare_tree(struct rev_info *revs,
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
-	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
-			   &revs->pruning) < 0)
-		return REV_TREE_DIFFERENT;
+	diff_tree_oid(&t1->object.oid, &t2->object.oid, "", &revs->pruning);
 	return tree_difference;
 }
 
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
-	int retval;
 	struct tree *t1 = get_commit_tree(commit);
 
 	if (!t1)
@@ -671,9 +668,9 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
-	retval = diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
+	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
-	return retval >= 0 && (tree_difference == REV_TREE_SAME);
+	return tree_difference == REV_TREE_SAME;
 }
 
 struct treesame_state {
diff --git a/tree-diff.c b/tree-diff.c
index 33ded7f8b3..9775e4bcaa 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -29,7 +29,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const struct object_id *oid,
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-static int ll_diff_tree_oid(const struct object_id *old_oid,
+static void ll_diff_tree_oid(const struct object_id *old_oid,
 			    const struct object_id *new_oid,
 			    struct strbuf *base, struct diff_options *opt);
 
@@ -673,7 +673,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	q->nr = 1;
 }
 
-static int ll_diff_tree_oid(const struct object_id *old_oid,
+static void ll_diff_tree_oid(const struct object_id *old_oid,
 			    const struct object_id *new_oid,
 			    struct strbuf *base, struct diff_options *opt)
 {
@@ -691,29 +691,26 @@ static int ll_diff_tree_oid(const struct object_id *old_oid,
 	}
 
 	opt->pathchange = pathchange_old;
-	return 0;
 }
 
-int diff_tree_oid(const struct object_id *old_oid,
-		  const struct object_id *new_oid,
-		  const char *base_str, struct diff_options *opt)
+void diff_tree_oid(const struct object_id *old_oid,
+		   const struct object_id *new_oid,
+		   const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
-	int retval;
 
 	strbuf_init(&base, PATH_MAX);
 	strbuf_addstr(&base, base_str);
 
-	retval = ll_diff_tree_oid(old_oid, new_oid, &base, opt);
+	ll_diff_tree_oid(old_oid, new_oid, &base, opt);
 	if (!*base_str && opt->flags.follow_renames && diff_might_be_rename())
 		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
 	strbuf_release(&base);
-
-	return retval;
 }
 
-int diff_root_tree_oid(const struct object_id *new_oid, const char *base, struct diff_options *opt)
+void diff_root_tree_oid(const struct object_id *new_oid, const char *base,
+			struct diff_options *opt)
 {
-	return diff_tree_oid(NULL, new_oid, base, opt);
+	diff_tree_oid(NULL, new_oid, base, opt);
 }
-- 
2.27.0.rc1.431.g5c813f95dc

