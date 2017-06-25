Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E94E2082F
	for <e@80x24.org>; Sun, 25 Jun 2017 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdFYSV2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 14:21:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35290 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdFYSV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 14:21:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so25778160wrb.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tp6MyPzD7ni6iYVYp1o+CVdFxF5pgMW/zIQzEQD4f6E=;
        b=ODQxvGnfM0AaVTfs8IEg9rwiS5U3kXSzi2SN1m8odPsFNmdwWH36uzr6CtISbTlWXe
         WoE8bYjH7ZjtNRh+VIFHJ0ygMxnGs4l81Vi35FCk7Euy8S08DQoYEw8wfKkF08lMd41R
         R7SXmqmHAbkp9gXo9+62tRwMhhTOyntAk3cPxhoMRqYm9QDYow+V335EJpXqr3CZbm73
         IdBtp90qvqVozsBM986PhxbFGIi2uycyywlX9NLVZ791c+ixW6jXoQ38TodRXGjm4hYI
         j5pqX/iskjUPVgnAkB3dkDAB+xi6GUbY/P0ZJcbAtto6A2F16X6eqhAnJTpru0ncH/Q/
         MNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tp6MyPzD7ni6iYVYp1o+CVdFxF5pgMW/zIQzEQD4f6E=;
        b=sNPP2imZPgux5my9HiuPjbbgkWFY7VgGMcEb7QAIrlgtiY+uiTDrdb6Bbf+DCs4rwx
         rMH8BD7DdfcJBU6GUiGjShFAw+Lm3vu3A4OZnKGEGpuXG+vy/USKFFecVj+i/NOvFw89
         99edX/WjvX3JTUib3tYfhSwxJdj2olx14bD+ceEdU+qfK2/07aE3p4jgfqnq1kKwze+j
         KEsA28tAEX1wxpw4qk8smGMfKP7xrjXN2AzNU4Gy/qSua7LtnxS/kem8UBfO5QNospvl
         zzk8oDUAZ5mf84SlGpzFqrv829G3ykJS0L23fZCDOlqkpWIhZphXOUKZXNINYOjnFsYe
         L1VA==
X-Gm-Message-State: AKS2vOwA6bRnB+r/BisT2Qutxkn+p5ugQwlhlw7krm6MjpLXjJ8PCRKI
        Bi61ShLkJl65E19c
X-Received: by 10.223.131.162 with SMTP id 31mr8180244wre.161.1498414884668;
        Sun, 25 Jun 2017 11:21:24 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB71F6.dip0.t-ipconnect.de. [93.219.113.246])
        by smtp.gmail.com with ESMTPSA id u13sm13313926wmd.22.2017.06.25.11.21.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 11:21:23 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v6 0/6] convert: add "status=delayed" to filter process protocol
Date:   Sun, 25 Jun 2017 20:21:19 +0200
Message-Id: <20170625182125.6741-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 6th iteration of my "status delayed" topic. Patch 1 to 3 are
minor t0021 test adjustments and haven't been changed since v3. Patch 4
is new and a minor style adjustment. Patch 5 is a minor "extract method"
refactoring in convert.c with an additional minor style adjustment in
this round. Patch 6 is the new feature.

Changes since v5 (full inter diff below!):
* commit message improvements (Torsten/Peff)
* reorder checkout struct to keep base_dir* member together (Peff)
* remove unnecessary initialization in CHECKOUT_INIT (Peff)
* adhere to Git style (";" instead "{}") for empty if blocks (Torsten)
* flag fields before flags (Peff)
* make operator precedence explicit with parenthesis (Peff)
* use skip_prefix() to simplify parsing and silently parse unknown keys (Peff)
* add ce_delay_state explanation (Peff)
* print files that the filter delayed but not delivered; clean up data structure (Peff)

If you review this series then please read the "Delay" section in
"Documentation/gitattributes.txt" first for an overview of the delay mechanism.
The changes in "t/t0021/rot13-filter.pl" are easier to review if you ignore
whitespace changes.

I also noticed that the diff around the "static int apply_multi_file_filter"
looks really weird as my new function "int async_query_available_blobs" is
right behind it with similar lines.

Thanks,
Lars


RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/
v3: http://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/
v4: http://public-inbox.org/git/20170522135001.54506-1-larsxschneider@gmail.com/
v5: http://public-inbox.org/git/20170601082203.50397-1-larsxschneider@gmail.com/


Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/ab3535aa60
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v6 && git checkout ab3535aa60
Interdiff (v5..v6):

diff --git a/cache.h b/cache.h
index 523ead1d95..2ec12c4477 100644
--- a/cache.h
+++ b/cache.h
@@ -1543,14 +1543,14 @@ extern int ident_cmp(const struct ident_split *, const struct ident_split *);
 struct checkout {
 	struct index_state *istate;
 	const char *base_dir;
-	struct delayed_checkout *delayed_checkout;
 	int base_dir_len;
+	struct delayed_checkout *delayed_checkout;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
 		 refresh_cache:1;
 };
-#define CHECKOUT_INIT { NULL, "", NULL }
+#define CHECKOUT_INIT { NULL, "" }


 #define TEMPORARY_FILENAME_LENGTH 25
diff --git a/convert.c b/convert.c
index c4df174378..6452ab546a 100644
--- a/convert.c
+++ b/convert.c
@@ -572,9 +572,9 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 static void handle_filter_error(const struct strbuf *filter_status,
 				struct cmd2process *entry,
 				const unsigned int wanted_capability) {
-	if (!strcmp(filter_status->buf, "error")) {
-		/* The filter signaled a problem with the file. */
-	} else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
+	if (!strcmp(filter_status->buf, "error"))
+		; /* The filter signaled a problem with the file. */
+	else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
 		/*
 		 * The filter signaled a permanent problem. Don't try to filter
 		 * files with the same command for the lifetime of the current
@@ -626,12 +626,12 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	}
 	process = &entry->subprocess.process;

-	if (!(wanted_capability & entry->supported_capabilities))
+	if (!(entry->supported_capabilities & wanted_capability))
 		return 0;

-	if (CAP_CLEAN & wanted_capability)
+	if (wanted_capability & CAP_CLEAN)
 		filter_type = "clean";
-	else if (CAP_SMUDGE & wanted_capability)
+	else if (wanted_capability & CAP_SMUDGE)
 		filter_type = "smudge";
 	else
 		die("unexpected filter type");
@@ -653,7 +653,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;

-	if (CAP_DELAY & entry->supported_capabilities &&
+	if ((entry->supported_capabilities & CAP_DELAY) &&
 	    dco && dco->state == CE_CAN_DELAY) {
 		can_delay = 1;
 		err = packet_write_fmt_gently(process->in, "can-delay=1\n");
@@ -736,16 +736,12 @@ int async_query_available_blobs(const char *cmd, struct string_list *delayed_pat
 	if (err)
 		goto done;

-	for (;;) {
-		const char* pre = "pathname=";
-		const int pre_len = strlen(pre);
-		line = packet_read_line(process->out, NULL);
-		if (!line)
-			break;
-		err = strlen(line) <= pre_len || strncmp(line, pre, pre_len);
-		if (err)
-			goto done;
-		string_list_insert(delayed_paths, xstrdup(line+pre_len));
+	while ((line = packet_read_line(process->out, NULL))) {
+		const char *path;
+		if (skip_prefix(line, "pathname=", &path))
+			string_list_insert(delayed_paths, xstrdup(path));
+		else
+			; /* ignore unknown keys */
 	}

 	err = subprocess_read_status(process->out, &filter_status);
@@ -784,9 +780,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!dst)
 		return 1;

-	if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
+	if ((wanted_capability & CAP_CLEAN) && !drv->process && drv->clean)
 		cmd = drv->clean;
-	else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
+	else if ((wanted_capability & CAP_SMUDGE) && !drv->process && drv->smudge)
 		cmd = drv->smudge;

 	if (cmd && *cmd)
diff --git a/convert.h b/convert.h
index c4beaa5101..51f0fb7fbe 100644
--- a/convert.h
+++ b/convert.h
@@ -42,6 +42,10 @@ enum ce_delay_state {
 };

 struct delayed_checkout {
+	/* State of the currently processed cache entry. If the state is
+	CE_CAN_DELAY, then the filter can change this to CE_DELAYED. If
+	the state is CE_RETRY, then this signals the filter that the cache
+	entry was requested before. */
 	enum ce_delay_state state;
 	/* List of filter drivers that signaled delayed blobs. */
 	struct string_list filters;
diff --git a/entry.c b/entry.c
index c9cb557559..c6d5cc01dc 100644
--- a/entry.c
+++ b/entry.c
@@ -159,10 +159,10 @@ int finish_delayed_checkout(struct checkout *state)
 	struct string_list_item *filter, *path;
 	struct delayed_checkout *dco = state->delayed_checkout;

-	if (!state->delayed_checkout) {
+	if (!state->delayed_checkout)
 		return errs;
-	}

+	dco->state = CE_RETRY;
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths;
@@ -195,7 +195,7 @@ int finish_delayed_checkout(struct checkout *state)
 				struct cache_entry* ce = index_file_exists(
 					state->istate, path->string,
 					strlen(path->string), 0);
-				dco->state = CE_RETRY;
+				assert(dco->state == CE_RETRY);
 				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
 			}
 		}
@@ -205,6 +205,10 @@ int finish_delayed_checkout(struct checkout *state)

 	/* At this point we should not have any delayed paths anymore. */
 	errs |= dco->paths.nr;
+	for_each_string_list_item(path, &dco->paths) {
+		warning(_("%s was not filtered properly."), path->string);
+	}
+	string_list_clear(&dco->paths, 0);

 	free(dco);
 	state->delayed_checkout = NULL;


Lars Schneider (6):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT" only on success
  convert: put the flags field before the flag itself for consistent
    style
  convert: move multiple file filter error handling to separate function
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  65 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   4 +
 convert.c                       | 168 ++++++++++++++++++++++++---------
 convert.h                       |  25 +++++
 entry.c                         | 114 ++++++++++++++++++++++-
 t/t0021-conversion.sh           | 136 ++++++++++++++++++++-------
 t/t0021/rot13-filter.pl         | 199 ++++++++++++++++++++++++++--------------
 unpack-trees.c                  |   2 +
 9 files changed, 567 insertions(+), 149 deletions(-)


base-commit: 0339965c70d68fd3831c9a5306443c869de3f6a8
--
2.13.1

