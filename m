Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE6C1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeFPFm0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39322 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756832AbeFPFmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so11123280lfd.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03JsaTBqaASd3is+xghQEFe/OjAWyzvuNqCoR4cXbdU=;
        b=kJSgnnMQoQDeDkM7HBH9Slij6pWHLWdwtljUuAArbb21VBvUlYbNiGj29D39e9Kyp7
         wU4KXrik1jgWWsAPbbXvLSLxRVWv5DmcecLMZ0g5WsvDo9YnYGoO3EtRQRxLsVwuZoIy
         bSaQA5XDNYMFnOh6F+INaQL5dTZinaPVN1p2nHcvfRFuUAzkI+QtiuOfvpD51bvJqKJF
         fVyhNcXbnKbfma70yAmUvjLKt6W5FCgmk1mHRTjX5NJf/8DcMatI+6QMnK0FC9w8yyZ9
         2zDSyJ8KKTiw/wkHHmbUjUjAA5LBsGkkWlP4isHCLAmwkOE4JwSVVhyH8XOiBizu0z79
         TivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03JsaTBqaASd3is+xghQEFe/OjAWyzvuNqCoR4cXbdU=;
        b=JQ9POkHtQTvD2ESZl5MEmtD3tX7IUbDJZ3rQuX/viPoYM24buiwyi3aTwOWq2rrPYk
         2ntBQdzwuKq2WA1h3cK5elqKBTESfsNoFR9HjSm2CtZrL1OALQ59Vfdxc8YRPJN9y7Gs
         bGTSo9zmbt9gr7hKlpiNkh/J/llctFvev7ckKTf6KceZAzubyUtmrSwE7E+mFLjyRTI0
         ZQ9QbuLFxjavRDx1gX5Nw9UGzrPDKHvwTtgGJ6Y1Ttn/rXkIPVAIn8c4B6hC2EZaQrJ4
         2zO0dGgvabogXyiHw3VqBpWqpRchFFvnit0cJWqT8OXnv85IIwKVEPfAv5RidgFyjK7t
         3dBA==
X-Gm-Message-State: APt69E0H3RnzXktyUpZALysXPwZ5vZXYR3NvtAtf9H7Wr8onx07Sphhf
        /XETbIgtFT2c5aBL3AJQ8fn/+w==
X-Google-Smtp-Source: ADUXVKJL0x9HjnGFx5MuTPgnGAO28GAXoZHfQt7RZFZg3XHFyqej60bVgQLFEppmif5y2ESlaliyxQ==
X-Received: by 2002:a2e:9516:: with SMTP id f22-v6mr2956656ljh.9.1529127731179;
        Fri, 15 Jun 2018 22:42:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/15] rerere.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:52 +0200
Message-Id: <20180616054157.32433-11-pclouds@gmail.com>
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
 rerere.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/rerere.c b/rerere.c
index e0862e2778..810e86d246 100644
--- a/rerere.c
+++ b/rerere.c
@@ -524,7 +524,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
  */
 static int check_one_conflict(int i, int *type)
 {
-	const struct cache_entry *e = active_cache[i];
+	const struct cache_entry *e = the_index.cache[i];
 
 	if (!ce_stage(e)) {
 		*type = RESOLVED;
@@ -532,13 +532,13 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	*type = PUNTED;
-	while (ce_stage(active_cache[i]) == 1)
+	while (ce_stage(the_index.cache[i]) == 1)
 		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */
-	if (i + 1 < active_nr) {
-		const struct cache_entry *e2 = active_cache[i];
-		const struct cache_entry *e3 = active_cache[i + 1];
+	if (i + 1 < the_index.cache_nr) {
+		const struct cache_entry *e2 = the_index.cache[i];
+		const struct cache_entry *e3 = the_index.cache[i + 1];
 		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
 		    ce_same_name(e, e3) &&
@@ -548,7 +548,7 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	/* Skip the entries with the same name */
-	while (i < active_nr && ce_same_name(e, active_cache[i]))
+	while (i < the_index.cache_nr && ce_same_name(e, the_index.cache[i]))
 		i++;
 	return i;
 }
@@ -567,12 +567,12 @@ static int check_one_conflict(int i, int *type)
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < the_index.cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
+		const struct cache_entry *e = the_index.cache[i];
 		i = check_one_conflict(i, &conflict_type);
 		if (conflict_type == THREE_STAGED)
 			string_list_insert(conflict, (const char *)e->name);
@@ -600,12 +600,12 @@ int rerere_remaining(struct string_list *merge_rr)
 	int i;
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < the_index.cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
+		const struct cache_entry *e = the_index.cache[i];
 		i = check_one_conflict(i, &conflict_type);
 		if (conflict_type == PUNTED)
 			string_list_insert(merge_rr, (const char *)e->name);
@@ -712,7 +712,7 @@ static void update_paths(struct string_list *update)
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->string, 0))
+		if (add_file_to_index(&the_index, item->string, 0))
 			exit(128);
 		fprintf(stderr, "Staged '%s' using previous resolution.\n",
 			item->string);
@@ -964,16 +964,16 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 * Reproduce the conflicted merge in-core
 	 */
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (0 <= pos)
 		return -1;
 	pos = -pos - 1;
 
-	while (pos < active_nr) {
+	while (pos < the_index.cache_nr) {
 		enum object_type type;
 		unsigned long size;
 
-		ce = active_cache[pos++];
+		ce = the_index.cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
 			break;
 		i = ce_stage(ce) - 1;
@@ -1102,7 +1102,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
@@ -1114,7 +1114,7 @@ int rerere_forget(struct pathspec *pathspec)
 	 * recover the original conflicted state and then
 	 * find the conflicted paths.
 	 */
-	unmerge_cache(pathspec);
+	unmerge_index(&the_index, pathspec);
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-- 
2.18.0.rc0.333.g22e6ee6cdf

