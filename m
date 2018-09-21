Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28DC1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbeIUVrb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:31 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46912 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUVrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:31 -0400
Received: by mail-lf1-f48.google.com with SMTP id q2-v6so1925655lfc.13
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0aBxSs2sqyRecz4UrS464gG8JPUefT2L3oFUincgrYY=;
        b=eRnzcj4v7wLzQ3G0CIbDHatJIKtyoIwyj+fOA/5yUYIGvjfdBZsYCGlrPxFVwKsDec
         OkwUo7UlgM3uHcxZ8K341Zs/FLdhqzCVSfEKjcZ4gaKTo2jp76IRrgXow9XzedC/jJgC
         3PI2DjdcXOqZhw5SUbXlzdScQCP+31WUj5WxEwWm9OaW6cg7mPHtILUJYJ5Tn4PrR3Be
         O3UZFcy5Bc77rzTfuHcjx2fgyS1VlmefDz8/CBx3QqRII4JQPhiJ0icHiMptHXX4UIIc
         wF+J668dl54m/KB9eEx99jZx+MspYCofMnz8qEZyRsP8jKL996HyeoxmWbyVWTuEihec
         /Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aBxSs2sqyRecz4UrS464gG8JPUefT2L3oFUincgrYY=;
        b=p3IivoLYxtd/+m3vrzxLkPrEHtjMAQXiFw2Ay+bEES7xjAnah1WF8cLDbd8oAnxkZL
         FtejhwTlvdRiVPHftQWDn9wjX0V5A1UygJyBuxKO/fVuWFbMWkOm88ej7Mmp3cIZejcS
         iAo9sxfqnPxKNZFlYRX48OaIJKlYJYT2PqLwIzI3YeKbQstyGwn7kArz6DtM9+YoXt3b
         bhII2KRn/uztZcEf0x7MSfw4x0E9ePmhVHqgzZ1QW3cIgUocuqrSccdARYTNcs14HhlO
         kehnDF6PzOvXU1S+mAghP9ktFbrBMb14snrUKhenlu7dErtonoWzQHu3aKE9Vsbhz7t9
         xqXg==
X-Gm-Message-State: APzg51Bzd0ySHSfGCtXyj6jUn1PzBr/l0aFvd0bQklbnxelsxawgXw4h
        1gAiOs1ZhQOKaR2HA/r/TqA=
X-Google-Smtp-Source: ANB0VdYUTnRy05Iq3x+Z+I+0YkW83AciytqDjg5LBr3DMoq0xzdUsJk1khQ/Su6e3Z65fdGlODCo/g==
X-Received: by 2002:a19:dd8a:: with SMTP id w10-v6mr16739679lfi.97.1537545479371;
        Fri, 21 Sep 2018 08:57:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 10/23] diff-lib.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:26 +0200
Message-Id: <20180921155739.14407-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.19.0.640.gcd3aa10a8a

