Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21B71F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeFFRDJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:09 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33999 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933788AbeFFRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:05 -0400
Received: by mail-lf0-f45.google.com with SMTP id o9-v6so10238091lfk.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64vG5n66OAKulBiL3VnDDRTmn/XcmzaoohXmeffJNZk=;
        b=gt5NGwvZl7EgKaC67cRRYu9X1SV4uZWx8wfRvUpMkIOXEQI0ekezqrZRY8M543vCkV
         Vr1hcJ85ez0O7dGfhihIc63ngJFYxip0pD19Bklqr0xCDCidZefjqJIfCK2jZlDbRZbS
         oANSHMIkcbROIt+r97AcTVKKqyp/ATasxacUNQz1ktpHy8Qn9p++eu0+/um7uoeuagTT
         w51mJLNmJ1LHLEBbe4wBHHD8uwFjW85KCIDFXCI/QGWI2Q5/KPYEZfggiork99I692eA
         cDTlQ25c2DQuqmqPSixFuL932yTMiTCrzUZrmYsQCgOEfuI+TK5I8x2CAwsRmJ6W4H5e
         NXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64vG5n66OAKulBiL3VnDDRTmn/XcmzaoohXmeffJNZk=;
        b=RgsxzQPP4FymbS6x20xz72eeggi8kqKNDgEbSgFNzRyxopa3sdOZXLabpRZpiS/HDp
         b5uDQVsIutOc9FDciLf6sRGQOTni1JF/sWOuu03/rHpY3DP0qiticH7fuTjfHeSX4dx6
         PGbzXC7oqjCoxuSYnPC+ZGmcynBTlQUBUOzoRi7PYE8Gnxe8C/AP+gzfJRlli1VUCj+Y
         T8lnR4LNslxxe/bgsSf4LXo7gLtgBaVvc0SGqtrMH70vDI+CxhXG9z/hVwyyvHDk5Uz7
         daLc2xbbmVWKhmamWjloKNqvQbOLBAOwzORFiAnGnSPOKurCy5zPa090wRUcjU3hoUQF
         cYpg==
X-Gm-Message-State: APt69E2YOUbGXH7ZSAbPkPYiwaAr+XmHPV80G3WTw0ZsscfAz7nBrYBs
        uBNd+AAhTBt//pyleHhb2eqbag==
X-Google-Smtp-Source: ADUXVKK/aZCBJptC40KWagy+y/NQ3iCfUa1YBh/QO0Jumh2ITbxFTWdhCFU6s8ZnBrey24UMYaXRtQ==
X-Received: by 2002:a19:5c94:: with SMTP id u20-v6mr2196822lfi.138.1528304583660;
        Wed, 06 Jun 2018 10:03:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 11/23] ls-files: correct index argument to get_convert_attr_ascii()
Date:   Wed,  6 Jun 2018 19:02:31 +0200
Message-Id: <20180606170243.4169-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
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
2.18.0.rc0.333.g22e6ee6cdf

