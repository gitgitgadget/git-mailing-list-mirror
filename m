Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4073E1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeDVSNL (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 14:13:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42610 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeDVSNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 14:13:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18-v6so35198817wrg.9
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsuty4FPJsdfrtjFt1TtCamulXaUL0SGRmlhnj86sEA=;
        b=kuCNZ22XGl0L1DOFFRsMwyKvnsHvuYTSWHCJo6XK+LGp5+NR8geeeShoVLrW6DiJzs
         gng51aDtgYGnO7q3I/dc5WTbsnlF96GoudAJKo9Coh1deGGRBoL/VOk3NGFTpB/N8eEU
         Itq0szPhKHy4eu4UXb8inMe+HIVxVTdB/O/alzvp9VdbPd8ndR9b7HF7uWVZonNVfnI3
         CtTwntLMb592SZeKpmj0aUDyqYtxPB26+XqmcIXa+Z3mF90iPzf/s0KmFGMXpKCyqL1f
         4tFP14xvQS2R1SHxk2aGl59FEWLq58fINzAtqeI4cgdESfOSkdCew0I997bxgFoJRV2p
         zLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsuty4FPJsdfrtjFt1TtCamulXaUL0SGRmlhnj86sEA=;
        b=ZiCqCbNOD8E1TkzemsITlpJ6Q2bJM8Rx9ecCHX1JVrGlIveprr7ObJQdEX5B9ptoyh
         uNJWC/woMyWMaEFwJCX5U8qTO2LqO7KhXRJTrbEQJEypwpSAwedjgvWGcOLWj+dssWk7
         NBGe3oi/M5cMU1hPbo2wdWmoSwd0bgAtIIzgTwwHiICh8D7C71+oiqGXZXZnPIUy63qj
         9yDTEsjXyndf2Zmspj/QxEwc5DYr5xlZi9mBFYFt26QTiK9lHnz/oaF+eyxJAdMQLlPB
         cKqs9mMSq4YQ7hoHoGFoTI5xsJrLoQqilsJ9ldVUArBda3wG7TpkR8PUSjUsiBLLRi6v
         w1gA==
X-Gm-Message-State: ALQs6tB2KzRjsMrdyay4EH3Goq0BdrN7H2rGT7UsLDBUN3pFSfd+hGmU
        RF4TO9UfvUgkhuOgSJbqQaw+5Vqr
X-Google-Smtp-Source: AIpwx4/tEB40zE4yZf0N3M99yaKaN5BnwuQ7lxGhEtA+b7FXXYZCqowvZrrQqK3pzGC4coQjUAOCQg==
X-Received: by 10.28.125.66 with SMTP id y63mr5476257wmc.121.1524420788870;
        Sun, 22 Apr 2018 11:13:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id f2-v6sm8354450wre.76.2018.04.22.11.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Apr 2018 11:13:07 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Walton <bwalton@artsci.utoronto.ca>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] walker: drop fields of `struct walker` which are always 1
Date:   Sun, 22 Apr 2018 20:12:50 +0200
Message-Id: <44e0ee4a6617244e5d45806e100565f8f46a86c5.1524420451.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <367243f0c8215f702fd38152952f47121ab337b1.1524420451.git.martin.agren@gmail.com>
References: <367243f0c8215f702fd38152952f47121ab337b1.1524420451.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous commit, both users of `struct walker` set `get_tree`,
`get_history` and `get_all` to 1. Drop those fields and simplify the
walker implementation accordingly.

Let's hope that any out-of-tree users will not mind this change. They
should notice that the compilation fails as they try to set these
fields. (If they do not set them, note that `get_http_walker()` leaves
them undefined, so the behavior will have been undefined all the time.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 walker.h      |  3 ---
 http-fetch.c  |  3 ---
 remote-curl.c |  3 ---
 walker.c      | 19 ++++++++-----------
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/walker.h b/walker.h
index a869013e85..6d8ae00e5b 100644
--- a/walker.h
+++ b/walker.h
@@ -9,9 +9,6 @@ struct walker {
 	void (*prefetch)(struct walker *, unsigned char *sha1);
 	int (*fetch)(struct walker *, unsigned char *sha1);
 	void (*cleanup)(struct walker *);
-	int get_tree;
-	int get_history;
-	int get_all;
 	int get_verbosely;
 	int get_recover;
 
diff --git a/http-fetch.c b/http-fetch.c
index a1564f5a41..7b855d3349 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -56,9 +56,6 @@ int cmd_main(int argc, const char **argv)
 
 	http_init(NULL, url, 0);
 	walker = get_http_walker(url);
-	walker->get_tree = 1;
-	walker->get_history = 1;
-	walker->get_all = 1;
 	walker->get_verbosely = get_verbosely;
 	walker->get_recover = get_recover;
 
diff --git a/remote-curl.c b/remote-curl.c
index a7c4c9b5ff..dd86a6c4fa 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -797,9 +797,6 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 		targets[i] = xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
 
 	walker = get_http_walker(url.buf);
-	walker->get_all = 1;
-	walker->get_tree = 1;
-	walker->get_history = 1;
 	walker->get_verbosely = options.verbosity >= 3;
 	walker->get_recover = 0;
 	ret = walker_fetch(walker, nr_heads, targets, NULL, NULL);
diff --git a/walker.c b/walker.c
index dffb9c8e37..8eb7db7a52 100644
--- a/walker.c
+++ b/walker.c
@@ -72,6 +72,8 @@ static struct commit_list *complete = NULL;
 
 static int process_commit(struct walker *walker, struct commit *commit)
 {
+	struct commit_list *parents;
+
 	if (parse_commit(commit))
 		return -1;
 
@@ -86,19 +88,14 @@ static int process_commit(struct walker *walker, struct commit *commit)
 
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
 
-	if (walker->get_tree) {
-		if (process(walker, &commit->tree->object))
+	if (process(walker, &commit->tree->object))
+		return -1;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		if (process(walker, &parents->item->object))
 			return -1;
-		if (!walker->get_all)
-			walker->get_tree = 0;
-	}
-	if (walker->get_history) {
-		struct commit_list *parents = commit->parents;
-		for (; parents; parents = parents->next) {
-			if (process(walker, &parents->item->object))
-				return -1;
-		}
 	}
+
 	return 0;
 }
 
-- 
2.17.0

