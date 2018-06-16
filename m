Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B921F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeFPFmP (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:15 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33484 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756326AbeFPFmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:13 -0400
Received: by mail-lf0-f51.google.com with SMTP id y20-v6so17545258lfy.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOzKAKw77XJwZHA8m+Y7ZHmChI/Nx0gV/TTWL6XwH6Y=;
        b=GKuOgFXsL7EkHDHjTa4XrTx+/mRDmEYy8uNlJU48wSz167cKSlTCfMyvr0c4BqkHB4
         R02U8WTZ7Nm3R3nC9SU+mRKNqR9YCKsospbncT7THdVGvQuWOcg+WwWJfRsPJIGcEuRn
         ciVkDjbjhJKpo07+cksQKAvhTPeIXZ+C7YdxuBl/C4JqIEiBbP0D0rIBFnDjpTp6R5/Y
         3xIfdViHH3OdPEM/9jdah5FlIkqFKBGm+cA1bqVi2enTbReRVg7jtw+IqzEaD3E+o6UR
         TSu16DMwIysoMbo2+v+QH0xlE/0QvhcPN2vrVqHUA8k1m6m/rCF9fV33ljDUmMGUL6/G
         mjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOzKAKw77XJwZHA8m+Y7ZHmChI/Nx0gV/TTWL6XwH6Y=;
        b=gCjXSmbl3JKc9YofVMXNeAhAE7pGJ0K3hIRWk5nfNqq3jJd9S8OxTkEGQrb5nuSoOC
         NISS1VAw8dk/5ShXzzabO0Wwqn2oCyLqfZBZeVv+o7xt5ckYN2EybL16NEIteDUqgrDh
         ZU8Cr2Rm7vE1tZ2vldh9AwEGADYozL0hQLRO+5AAXrgeHeEeePJvXI2UZRK7EJzTM+Nt
         PEGyNkSuRKXUIF4uDxb9IPZYEnWV2cf/kvos9T9pEOAGgXzUctqKMydoSua/tKJZ8xUG
         JTYichw78q7qVm2RaB/v6IuoT2ifmmRcFR9FOa66afQv8WGTePsX4HuS8FmMveKsYW+t
         jriA==
X-Gm-Message-State: APt69E1ezUnhRt9NgtYYTEMc6wppkiB3+sXzzGX3CN5BqfJMb3UC/lem
        VFSMpMoW2eohdZ+0PlFOnDpItA==
X-Google-Smtp-Source: ADUXVKKy6aiRvcG7rGYAp9qN8akXMXVQ/9dv/1lz2YFvzjrYrMBMupbk/JHSd/a+nqJ5JIERFgAMWg==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr3145239lje.140.1529127732297;
        Fri, 15 Jun 2018 22:42:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/15] revision.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:53 +0200
Message-Id: <20180616054157.32433-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 40fd91ff2b..d56ca57717 100644
--- a/revision.c
+++ b/revision.c
@@ -1354,7 +1354,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
 	struct worktree **worktrees, **p;
 
-	read_cache();
+	read_index(&the_index);
 	do_add_index_objects_to_pending(revs, &the_index);
 
 	if (revs->single_worktree)
@@ -1495,10 +1495,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
-	if (!active_nr)
-		read_cache();
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	if (!the_index.cache_nr)
+		read_index(&the_index);
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 		if (ce_path_match(ce, &revs->prune_data, NULL)) {
@@ -1507,8 +1507,8 @@ static void prepare_show_merge(struct rev_info *revs)
 			prune[prune_num-2] = ce->name;
 			prune[prune_num-1] = NULL;
 		}
-		while ((i+1 < active_nr) &&
-		       ce_same_name(ce, active_cache[i+1]))
+		while ((i+1 < the_index.cache_nr) &&
+		       ce_same_name(ce, the_index.cache[i+1]))
 			i++;
 	}
 	clear_pathspec(&revs->prune_data);
-- 
2.18.0.rc0.333.g22e6ee6cdf

