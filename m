Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCFC1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeICWbo (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:44 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42377 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:43 -0400
Received: by mail-lf1-f53.google.com with SMTP id z11-v6so1012310lff.9
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ODaTwTcPVL34m2NkcLyv4GSbek6ACY9TAkpZJdo4d0=;
        b=oOlfLayRYqKE0AZ5Iq0+jYiyyag6t3rYt99m+b7VYo1GUIaPaRivohMDulouiQjV9e
         vTwAIceDOyUqSpMPXvcCaLdTEXMrw/DEz7kBzDAo/J/1Euhx17E12vlkUVJr0WwkMAap
         OqVvx/ZJL3XGIy478xxh4Ch1+5OcrlKmQfbVoz//WeHgx1kJTRBin3LV8IgRpVXBOiKV
         YvDPZFDT8uI5bWrgJq+0dtAbrIDWUo7Y8mslyVuRVSX3RCVZKLpHsOeuVImKs1itAq+H
         HrsMVTdmueXRFkt/Gfyc1QoB3iemXrka5BaiGATH5bSzsTO+EGbMfJSkhjyNnoDYgZgj
         SxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ODaTwTcPVL34m2NkcLyv4GSbek6ACY9TAkpZJdo4d0=;
        b=UemAHHxvE0ZTn0qIwZ8gGTCkqry83WbuxFxhA9j1mJ65u4m0URuqbakiNZS0bhuxYT
         KaLCv3eeVdMXXAAsUvSfLcRNbk+r6HlWZdyax1XVES5SFiNglg2FQ2pCOieZ9ju8lBmu
         D0JAWFxNH3iNE/b78UI/8UBjEoe2BBBKhafsU8rorax4/kxL0SITDJCYUxGzNDIsfBOa
         gWCP8Nt9TchykN4Sk0DRePOtzzWE16qFIr6ndekTCVKQV32toemIEC4sSPH8EJvvhekw
         URhkKj8OOtpd99W3MckVeae93UwFo3xZSRNd3l1BwdyGtGDzHjMKHq1jv7Nwof+A5Z10
         gRYQ==
X-Gm-Message-State: APzg51Bb8ZbYFTVIDWKZJ3j46I9IA0yQZbrHNxW9rYmWe3dZ7THabgdg
        OZDw/CuQ32x8/m67f/2BaVc=
X-Google-Smtp-Source: ANB0Vdbd/Zg0hZlcwogntoNSPmRG1m0itqMYdlFdSy8+wKa5wmJbuNbedLfmQ9bVeXiVo0PgW2Ac1g==
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr11921452lfe.89.1535998222295;
        Mon, 03 Sep 2018 11:10:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 10/24] diff-lib.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:18 +0200
Message-Id: <20180903180932.32260-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
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

