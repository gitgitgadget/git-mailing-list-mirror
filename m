Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C38C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeFFQul (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39771 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933544AbeFFQuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id t134-v6so10162963lff.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKv9fCub1rNsUQeVIXNPO/AcEeLjGWLPRoTNeGIzWiU=;
        b=LnlvE/5JMqn4QtqejQ3tpTpZ/9hzVI5EtJTygohPcCRIzd8cwopH52zeQr/vgrmbKn
         RykeDiWXtZiuT/NydEp3DUBNFDVme6Q5dMtQHwDOZI1vZvuhMUZraju9q7qvVNT7WA9M
         Im9TAEwpSaUuHri2gWxi9/s09eH+X0xi/EM9ha9IHbz+z15ZPZFxdVI+Tf0NaBYq59vf
         /60v4klsYHK74vLhxRFcKIzj04veFj1u32Wi3nbWcMYzLvyGtXNcpLe0qzRIYeP41Uy5
         R0CY3IYxn5LcCSIcFek+x520ODSHaYY2JuyELYOcmY/nW1oxRmXte5qUNvZjH8gHbm1a
         eHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKv9fCub1rNsUQeVIXNPO/AcEeLjGWLPRoTNeGIzWiU=;
        b=mGtcTlSHrX1ycbnamalm6zSVyGrKtHKpaGRWjK6HFHt77uX4a0yoNBzdF9EjczLzBL
         tkkWvyDl+CvvV+5/Q625JH/87Yfer3MiqBKXJJdffrae9vLGf3F0TgqbyVQRxPpZ7ZcC
         bq7u+MIscqkgkIwl9xmLI88qZ98JCt1i1Z+WoTVynIHbjVPkokuR62I44RRygcUv03BV
         aA+WxjFa5shawuC1ngoGKQAGNsNEFN4c7vucMlleUV8wxZvfX0WFJ/XaaSUCNYa6yOT7
         YYIAUQmaKt7zk47Zn+WafNz+MxRORoHhZuCL3qTpG80jFBF2gka6rWViRN/m7ghjyuMw
         6ewA==
X-Gm-Message-State: APt69E3Hp62sLCHFPp39/1DMCEha5eCVyqXV1glrUGpeqhYbycQJ5x/R
        g5Mq2eSZqpLZ8qIAz1iOiAmwMA==
X-Google-Smtp-Source: ADUXVKLTuwsXf0F/vY4GTHM7lToSvfKFQe0MZKAixZVMIc4crmwlsbssFjcdO4ucZbNPZKHCANrtbQ==
X-Received: by 2002:a19:9ec2:: with SMTP id h185-v6mr2468326lfe.37.1528303837401;
        Wed, 06 Jun 2018 09:50:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 04/23] unpack-tress: convert clear_ce_flags* to avoid the_index
Date:   Wed,  6 Jun 2018 18:49:57 +0200
Message-Id: <20180606165016.3285-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
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
index 45fcda3169..5268de7af5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1085,13 +1085,15 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
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
@@ -1100,7 +1102,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el, &the_index);
+					basename, &dtype, el, istate);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1122,7 +1124,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * calling clear_ce_flags_1(). That function will call
 	 * the expensive is_excluded_from_list() on every entry.
 	 */
-	rc = clear_ce_flags_1(cache, cache_end - cache,
+	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 			      prefix,
 			      select_mask, clear_mask,
 			      el, ret);
@@ -1145,7 +1147,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
  *   cache[0]->name[0..(prefix_len-1)]
  * Top level path has prefix_len zero.
  */
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval)
@@ -1179,7 +1182,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			len = slash - name;
 			strbuf_add(prefix, name, len);
 
-			processed = clear_ce_flags_dir(cache, cache_end - cache,
+			processed = clear_ce_flags_dir(istate, cache, cache_end - cache,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
@@ -1193,7 +1196,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(cache, cache_end - cache,
+			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
 						  prefix,
 						  select_mask, clear_mask, el, defval);
 			strbuf_setlen(prefix, prefix->len - len - 1);
@@ -1203,7 +1206,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el, &the_index);
+					    name, &dtype, el, istate);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1213,15 +1216,17 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
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
@@ -1256,7 +1261,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate->cache, istate->cache_nr, select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.rc0.333.g22e6ee6cdf

