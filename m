Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA4B1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeHMS6W (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:22 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35402 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMS6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:21 -0400
Received: by mail-lj1-f175.google.com with SMTP id p10-v6so13059075ljg.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZJyr4Z6vy9S0tVJKtqReNEWjHqvEk1yYk7lyneWGAk=;
        b=uOXmoeAv3IwAvJlFOqwgeSlMNrgbR/zOytjp5NBfk2y3MM3qW8REpsVSQhlewMiLwK
         GFEvSqp7nOs1GZSoHgY9KBmlZXj5cmDUVvwUwV087bgNTes9eEdCdFiW7j7R7tSjmtqo
         EWlvEfGUKd3mG4OFrb1WLMDCsj3nf9mgSCX5CYgV2Avt9LbzHDMnO5veaTMnuMgo4eRb
         wr+CuHwN0+a2HSlyiep7YOMynGXVjqXtncSCCr+VKuAE7Iyp2uYXzdRoJGtGr6K7EAZE
         ItBe/COcaeD/aFzOh+F4nOu/mWAAO0zMhptVFZoTemAH3Ds9/MbkIkooXMK5dfeovB+n
         u0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZJyr4Z6vy9S0tVJKtqReNEWjHqvEk1yYk7lyneWGAk=;
        b=AZWTRXSOk+OJQMHtcQLGuselk2LcAcZHZPcy2GAvGw03UyphKPImV4rmco4mcte6Xu
         NweGXu+B2T7GIPbnTBIE/rX8fFdlutNTOSmxSKyXCkZ4rXz/9rbwhpK6trcJ/cTulBdD
         6AqDfzDauDZIQS3sO2WUaDsWDBQLJZ1IDxB/4mrU0V1pjLMQt+Ul+Bf/gtSxBJubazmT
         Km1S8xWPB83azAhLTini8/j8fLGqPw77KzKaCR2w3cSEiNrPXAzHLmPHxaAiWKSoeXKT
         A9robFkEBDpdFAWilxr/CvcQ+65J+7+vWwjseIhCAsn8EtTPIUHl1x/bae1DEtb1ge/I
         XZSQ==
X-Gm-Message-State: AOUpUlHYQuqtIP/+u+10gq+qxurYhdegz5AqbULp6ohvLqYDYnQ5DemL
        F7wBBr4VNjy54jBrsKLi4WIv80KC
X-Google-Smtp-Source: AA+uWPyy0Sq0hxFZwcG4nr3D7iCLKKNjDxxuO4pWMxNTngJk3qfRDcRXkqEavn5Wh2AJ3mYNyOcYFQ==
X-Received: by 2002:a2e:40ca:: with SMTP id r71-v6mr12160131lje.41.1534176927146;
        Mon, 13 Aug 2018 09:15:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/24] ls-files: correct index argument to get_convert_attr_ascii()
Date:   Mon, 13 Aug 2018 18:14:24 +0200
Message-Id: <20180813161441.16824-8-pclouds@gmail.com>
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

write_eolinfo() does take an istate as function argument and it should
be used instead of the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/ls-files.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7233b92794..7f9919a362 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -63,7 +63,7 @@ static void write_eolinfo(const struct index_state *istate,
 		struct stat st;
 		const char *i_txt = "";
 		const char *w_txt = "";
-		const char *a_txt = get_convert_attr_ascii(&the_index, path);
+		const char *a_txt = get_convert_attr_ascii(istate, path);
 		if (ce && S_ISREG(ce->ce_mode))
 			i_txt = get_cached_convert_stats_ascii(istate,
 							       ce->name);
@@ -121,18 +121,19 @@ static void print_debug(const struct cache_entry *ce)
 	}
 }
 
-static void show_dir_entry(const char *tag, struct dir_entry *ent)
+static void show_dir_entry(const struct index_state *istate,
+			   const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
 
 	if (len > ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
-	if (!dir_path_match(&the_index, ent, &pathspec, len, ps_matched))
+	if (!dir_path_match(istate, ent, &pathspec, len, ps_matched))
 		return;
 
 	fputs(tag, stdout);
-	write_eolinfo(NULL, NULL, ent->name);
+	write_eolinfo(istate, NULL, ent->name);
 	write_name(ent->name);
 }
 
@@ -145,7 +146,7 @@ static void show_other_files(const struct index_state *istate,
 		struct dir_entry *ent = dir->entries[i];
 		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
-		show_dir_entry(tag_other, ent);
+		show_dir_entry(istate, tag_other, ent);
 	}
 }
 
@@ -196,7 +197,7 @@ static void show_killed_files(const struct index_state *istate,
 			}
 		}
 		if (killed)
-			show_dir_entry(tag_killed, dir->entries[i]);
+			show_dir_entry(istate, tag_killed, dir->entries[i]);
 	}
 }
 
@@ -228,7 +229,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 	    is_submodule_active(repo, ce->name)) {
 		show_submodule(repo, dir, ce->name);
-	} else if (match_pathspec(&the_index, &pathspec, fullname, strlen(fullname),
+	} else if (match_pathspec(repo->index, &pathspec, fullname, strlen(fullname),
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
@@ -264,7 +265,7 @@ static void show_ru_info(const struct index_state *istate)
 		len = strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec(&the_index, &pathspec, path, len,
+		if (!match_pathspec(istate, &pathspec, path, len,
 				    max_prefix_len, ps_matched, 0))
 			continue; /* uninterested */
 		for (i = 0; i < 3; i++) {
-- 
2.18.0.1004.g6639190530

