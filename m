Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9251F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeHMS6d (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46408 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so12990839ljj.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnpvxT5LWKcsISgCwcvqei8WNNdsEKcdocY6rT1+uzI=;
        b=foNExzE2BFti3BF/FPcbSPTGxNfaD7RLg7aSGWHHltvaFtF0RYangToazn1uEAJID8
         qA/UCvXbUv7AZdZGJIBN3Fx+jKcSUibeRh9SFrTCXg89f3VTSeiknXSTWyu5hWPhXw7/
         PKBsZLUHHn0iSUh5XzUXch3Jd9Z0kSh1fNyyvZl3ptWArRZ8qPBmOAMpUalXnUp585Lu
         mgYimdUa2H5jxQwZAc74VO4fA8Qu3YAX3xuSCJ5/fyfNWEVdtNmrlN2JETIgQna2OKJw
         /H09SLGnxbE9QyK/rbjhTbiZgvUM8hEqdx6bFp2+EO/r7xPqINb3dMH0YXZwnXlH1luj
         JtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnpvxT5LWKcsISgCwcvqei8WNNdsEKcdocY6rT1+uzI=;
        b=m8A9ZpVp99I/dHb21dIrRYmxtAwO3y828OtlUoU5BcNKLs/ZDPPiZg2rgFr0jDJ5Bp
         bbX0GGOzWPL6uCoLvtW9cnkq9WNSq588mjeCH2yfP9ylAAgKKWRmN4VQSqwVQ5nHEiyX
         iNFkAAvZ0lw1c89xOweY6ThZwKSbYowlIHR2V2gnWEICoDs0ijq6GrgwkDbiqMXGKF30
         sf7mRhX61vmHxVMaDO9+wCcBvXEnSN20YB9Cl43bXqFn8HGpLlOUG7W5BmSpCNzMVY+6
         vxokpoR86mUujOIQ1344aPQV3q++DTbSHStHvU8QXCQILIabqdL3Ny4926RfdU3eqZwJ
         75ZQ==
X-Gm-Message-State: AOUpUlFwF6MX0tKdRul5ujCaCHX2Hg9Y7E3DDpL3bGEPtOsugwQBqp+Z
        55adnQ2XZS+P+E78rER1WeocWhUx
X-Google-Smtp-Source: AA+uWPz6BBL+dI/QRwHhtXza9+xKEIrfJSwoS8FlQX7YXT/A7rIc8W00sbGiptlGQLoaC7R7cOtr3Q==
X-Received: by 2002:a2e:557:: with SMTP id 84-v6mr13398412ljf.152.1534176937636;
        Mon, 13 Aug 2018 09:15:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/24] attr: remove index from git_attr_set_direction()
Date:   Mon, 13 Aug 2018 18:14:33 +0200
Message-Id: <20180813161441.16824-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since attr checking API now take the index, there's no need to set an
index in advance with this call. Most call sites are straightforward
because they either pass the_index or NULL (which defaults back to
the_index previously). There's only one suspicious call site in
unpack-trees.c where it sets a different index.

This code in unpack-trees is about to check out entries from the
new/temporary index after merging is done in it. The attributes will
be used by entry.c code to do crlf conversion if needed. entry.c now
respects struct checkout's istate field, and this field is correctly
set in unpack-trees.c, there should be no regression from this change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c            |  2 +-
 attr.c               | 15 +++------------
 attr.h               |  3 +--
 builtin/check-attr.c |  2 +-
 unpack-trees.c       |  4 ++--
 5 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/archive.c b/archive.c
index c81e35bf23..aca9179d03 100644
--- a/archive.c
+++ b/archive.c
@@ -274,7 +274,7 @@ int write_archive_entries(struct archiver_args *args,
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
 			return -1;
-		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
 	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
diff --git a/attr.c b/attr.c
index 863fad3bd1..98e4953f6e 100644
--- a/attr.c
+++ b/attr.c
@@ -708,10 +708,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
  * another thread could potentially be calling into the attribute system.
  */
 static enum git_attr_direction direction;
-static const struct index_state *use_index;
 
-void git_attr_set_direction(enum git_attr_direction new_direction,
-			    const struct index_state *istate)
+void git_attr_set_direction(enum git_attr_direction new_direction)
 {
 	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
@@ -720,7 +718,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 		drop_all_attr_stacks();
 
 	direction = new_direction;
-	use_index = istate;
 }
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
@@ -750,17 +747,11 @@ static struct attr_stack *read_attr_from_index(const struct index_state *istate,
 	struct attr_stack *res;
 	char *buf, *sp;
 	int lineno = 0;
-	const struct index_state *to_read_from;
 
-	/*
-	 * Temporary workaround for c24f3abace (apply: file commited
-	 * with CRLF should roundtrip diff and apply - 2017-08-19)
-	 */
-	to_read_from = use_index ? use_index : istate;
-	if (!to_read_from)
+	if (!istate)
 		return NULL;
 
-	buf = read_blob_data_from_index(to_read_from, path, NULL);
+	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
 
diff --git a/attr.h b/attr.h
index 3daca3c0cb..01dab4a126 100644
--- a/attr.h
+++ b/attr.h
@@ -77,8 +77,7 @@ enum git_attr_direction {
 	GIT_ATTR_CHECKOUT,
 	GIT_ATTR_INDEX
 };
-void git_attr_set_direction(enum git_attr_direction new_direction,
-			    const struct index_state *istate);
+void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index f7b59993d3..c05573ff9c 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -120,7 +120,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cached_attrs)
-		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
+		git_attr_set_direction(GIT_ATTR_INDEX);
 
 	doubledash = -1;
 	for (i = 0; doubledash < 0 && i < argc; i++) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 14e9043f9d..f25089b878 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -353,7 +353,7 @@ static int check_updates(struct unpack_trees_options *o)
 	progress = get_progress(o);
 
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
+		git_attr_set_direction(GIT_ATTR_CHECKOUT);
 
 	if (should_update_submodules() && o->update && !o->dry_run)
 		load_gitmodules_file(index, NULL);
@@ -413,7 +413,7 @@ static int check_updates(struct unpack_trees_options *o)
 	stop_progress(&progress);
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	return errs != 0;
 }
 
-- 
2.18.0.1004.g6639190530

