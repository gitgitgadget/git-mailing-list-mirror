Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CFE41F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIOViV (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:21 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42138 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOViV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:21 -0400
Received: by mail-lj1-f179.google.com with SMTP id f1-v6so9837011ljc.9
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ODaTwTcPVL34m2NkcLyv4GSbek6ACY9TAkpZJdo4d0=;
        b=KU52PpgsCu3WW/A54mFNaagCNQAB/rdgm23zbHs3swcZ2jDDMsZubOWUkQVZtsovw9
         GtkjCYJNTxJPrTlc05p11roKJFPWCltFI5PMaeGzjpZ17C9LAcanr8U0jUkpvxeRo0UV
         EGnQN3buR0QwZEnvFeKHjC3vjH55iM3+EtWu/WreNpZUo9VJY2amejtmvn0mwJ4gxJDX
         aBUunyAmbdnSgAfTG0acO5YeYuLvpiekEr5ZbB60czANGecqoOJvsYZUKIYXNnooiwEl
         ltJlyn05QsgPCtAO42LwBSrt5L/ona8IhbMT6DDLmVPLKSuwAGZMJSFRJDfnEazwhHCT
         6vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ODaTwTcPVL34m2NkcLyv4GSbek6ACY9TAkpZJdo4d0=;
        b=tRw36zS59TGRU1XvqarnFc9Nlu9nIN5uGeiGFddBdzaA6UUZbtXwHregFKaa6k73iU
         pLUEM3KstQsBRsuQd9uVozqpBve904EQ2ICEuNPPGSPsGRMaxIOPq51T5uM2dOg7ieI0
         JbIAPwMqsqsTz6tou9fn9fzsbRyTRCU0IkirIj28UryTWYxaCgW0peTXfBei33dhPJ4+
         PvRXALoVwq5/Pvfrz5wixv/o1qxJo3W40ao7iT2ytNkZS7+eScAdmIX/wYAEcI9ITHb/
         6xt6RjtfbBySx8Qh8uYcDBkGNAk7dI+7KtZj8Gl5De8kFyZiXXVcX5yKTTN9hJe2ADjy
         w40Q==
X-Gm-Message-State: APzg51Cprqez4xukjsa+zFFAjm4RGPIL9tR/a9jEYXLG/B5ITls5tRV2
        5fTwA7P61OX04L4Uk7uUlEzjFdmF
X-Google-Smtp-Source: ANB0VdZgQXQRWCSv1FfQ5A1n8BuHc0HFXZoyq7nj7Dwez4cThuhNer3F+3TJfhpRBgFOMoNxtNu/vA==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr10449940ljc.25.1537028329407;
        Sat, 15 Sep 2018 09:18:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 10/23] diff-lib.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:46 +0200
Message-Id: <20180915161759.8272-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff-lib.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 88a98b1c06..c54773fe12 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -70,7 +70,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     struct stat *st, unsigned ce_option,
 				     unsigned *dirty_submodule)
 {
-	int changed = ce_match_stat(ce, st, ce_option);
+	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
 		if (!diffopt->flags.override_submodule_config)
@@ -93,15 +93,16 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
+	struct index_state *istate = revs->diffopt.repo->index;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
-	entries = active_nr;
+	entries = istate->cache_nr;
 	for (i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = istate->cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
 		const struct object_id *old_oid, *new_oid;
@@ -109,7 +110,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(&the_index, ce, &revs->prune_data, NULL))
+		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
 			continue;
 
 		if (ce_stage(ce)) {
@@ -145,7 +146,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->mode = wt_mode;
 
 			while (i < entries) {
-				struct cache_entry *nce = active_cache[i];
+				struct cache_entry *nce = istate->cache[i];
 				int stage;
 
 				if (strcmp(ce->name, nce->name))
@@ -474,7 +475,9 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
-	if (ce_path_match(&the_index, idx ? idx : tree, &revs->prune_data, NULL)) {
+	if (ce_path_match(revs->diffopt.repo->index,
+			  idx ? idx : tree,
+			  &revs->prune_data, NULL)) {
 		do_oneway_diff(o, idx, tree);
 		if (diff_can_quit_early(&revs->diffopt)) {
 			o->exiting_early = 1;
@@ -506,7 +509,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
-	opts.src_index = &the_index;
+	opts.src_index = revs->diffopt.repo->index;
 	opts.dst_index = NULL;
 	opts.pathspec = &revs->diffopt.pathspec;
 	opts.pathspec->recursive = 1;
-- 
2.19.0.rc0.337.ge906d732e7

