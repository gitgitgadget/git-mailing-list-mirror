Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25E61F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeHMS62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35442 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeHMS60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id f18-v6so11668493lfc.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1aeeAMJp9xq2x0d5FVP+5BzqLcMT0Poz9QYDZNbhXs=;
        b=brW6clzmI1ZC5ifcsEcAH6EyZHSTVyjPkJC8AsSDioDHJ9X63gT/LY8EMUTXtDfZRw
         QVMgHGZ1kuRH64KhBLF+MYCgW6nUqCyBnjWuX+Dzc16sxzqNkDVg8yRDpdKwcRwySDvj
         pR8RoXB5gn7Bl/AagrSPpeKYcfrl4pp9763rmc81AOGKQV8Odk7JMADkNHzhdHruAfB6
         CUQynlOihtM2TYcOPBHfgWrjp1BWBmaYOFbSucCFywItL8ARA68UAJ36DTiRXBCzRCux
         Jj2zW0rXe8B/o8WzjxojkOxUoRs3pgIVY42I4z0mCcKuoR5fAwJeStDAbayIQeaxswfB
         bDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1aeeAMJp9xq2x0d5FVP+5BzqLcMT0Poz9QYDZNbhXs=;
        b=tYTjRLyq9EgNVGc8+XkiPLQ3oWnN6BNP2oCZktJRLZT3FtV+ZEBu2pnAkO+i32E2jT
         0wZU0ZfsHwQ52RNw4rw4dIx/CAmUAhL/x07ZVTyK3mdCy6mCJ8kR6Fp/Jo6e6O4ynIqU
         HvjdJPZz6SODG/UnWYYGJzSFKCKJ77PYTf043XxS6zMCM5K2pbSM/vvpR6pF87378Nzb
         p7Q8v/GytxrEvCQNRdvvI/5PGG1460g47KITcSWVJH5+FQhucpfFcZ5GbG8JEliqkcYJ
         wXarz/xNr5Vsyx4RQBTTa+OtapqZTKpahwTwjFy+NuNHcHHElaTczxagqfRykw3fdlaN
         b/yA==
X-Gm-Message-State: AOUpUlHmvU5wkUmDfewQo3S53aDef/w4kIhKYBf5FpjeuOkY/IiZBcJt
        yvKGJreGlIAHyU80m82O20xmUsNl
X-Google-Smtp-Source: AA+uWPwKdCOrG5PkBo5BPeGQZMANEKXWMMValYPOKi5gkAofguiOJezvK8G3lKsAWRjBbkfHVkAyVQ==
X-Received: by 2002:a19:1863:: with SMTP id o96-v6mr11393571lfi.134.1534176931336;
        Mon, 13 Aug 2018 09:15:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/24] unpack-trees: convert clear_ce_flags* to avoid the_index
Date:   Mon, 13 Aug 2018 18:14:28 +0200
Message-Id: <20180813161441.16824-12-pclouds@gmail.com>
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

Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
the_index when running the exclude machinery. fba92be8f7 helps show
this problem clearer because unpack-trees operation is supposed to
work on whatever index the caller specifies... not specifically
the_index.

Update the code to use "istate" argument that's originally from
mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
you can see that this function works on two separate indexes:
o->src_index and o->result. The second mark_new_skip_worktree() so far
has incorecctly applied exclude rules on o->src_index instead of
o->result. It's unclear what is the consequences of this, but it's
definitely wrong.

[1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
    2017-05-05)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f50b463f65..5d11f10e66 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1092,13 +1092,15 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	return mask;
 }
 
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval);
 
 /* Whole directory matching */
-static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
+static int clear_ce_flags_dir(struct index_state *istate,
+			      struct cache_entry **cache, int nr,
 			      struct strbuf *prefix,
 			      char *basename,
 			      int select_mask, int clear_mask,
@@ -1107,7 +1109,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el, &the_index);
+					basename, &dtype, el, istate);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1129,7 +1131,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * calling clear_ce_flags_1(). That function will call
 	 * the expensive is_excluded_from_list() on every entry.
 	 */
-	rc = clear_ce_flags_1(cache, cache_end - cache,
+	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 			      prefix,
 			      select_mask, clear_mask,
 			      el, ret);
@@ -1152,7 +1154,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
  *   cache[0]->name[0..(prefix_len-1)]
  * Top level path has prefix_len zero.
  */
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval)
@@ -1186,7 +1189,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			len = slash - name;
 			strbuf_add(prefix, name, len);
 
-			processed = clear_ce_flags_dir(cache, cache_end - cache,
+			processed = clear_ce_flags_dir(istate, cache, cache_end - cache,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
@@ -1200,7 +1203,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(cache, cache_end - cache,
+			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
 						  prefix,
 						  select_mask, clear_mask, el, defval);
 			strbuf_setlen(prefix, prefix->len - len - 1);
@@ -1210,7 +1213,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el, &the_index);
+					    name, &dtype, el, istate);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1220,15 +1223,17 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 	return nr - (cache_end - cache);
 }
 
-static int clear_ce_flags(struct cache_entry **cache, int nr,
-			    int select_mask, int clear_mask,
-			    struct exclude_list *el)
+static int clear_ce_flags(struct index_state *istate,
+			  int select_mask, int clear_mask,
+			  struct exclude_list *el)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(cache, nr,
+	return clear_ce_flags_1(istate,
+				istate->cache,
+				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				el, 0);
@@ -1263,7 +1268,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate->cache, istate->cache_nr, select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.1004.g6639190530

