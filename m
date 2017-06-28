Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9783A20287
	for <e@80x24.org>; Wed, 28 Jun 2017 21:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdF1V37 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:29:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34967 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdF1V35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:29:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id 131so13755933wmq.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zqqhAtgZ2DS/yh0XL7kNBogM9h6pSMRiZVmuZUdq0lA=;
        b=nEiZ+pggsUlI9m8iQuc9dFeyL2+oQ8ikI7FYr+YP9iKkPqOVLXeWi/JlXOzwCv2E0S
         29c5UFBrc3O83M6bEBjFNn90s9sj7OAeocyRKSPMNe4l7tJkU0KhsFzSfIRUX/8WSTW5
         o1Uh+vDRBZ/lJ+4H9nYDyn/ubG6kIW12v0zxKKYp9HSm4wtFOQNIZ7U00oMGg0KDGpnE
         M3VEsKowoJYBd3i72M2U4VakUdCwATgzMQzQpT2lp5aOzn6dwUUJSMPrwGnxuBza0H7P
         gfGuu1RtdLfShFwl5+EUV5c7zI4VcX35p0DYfZxA5+G38jhIaOb0Ou77p4LtwSga7S7F
         tghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zqqhAtgZ2DS/yh0XL7kNBogM9h6pSMRiZVmuZUdq0lA=;
        b=BUn5nVkWRzIClrk3j4LOgclo1toISRpDhxhIzjgmEbGkVAxBhWfZyGLq2MHG6zVeHt
         HbgRsN7dcTX4xgz/7D3HHcpaQV/CsBbeHiVCJiVHb1oxNekL3JkhXxn7FkpISOobfiZe
         rcvbU89O8g5v2te5uJkQvtNHQbzWwVr5927+U1f2vIvC7ukBR9G+jT3dQMoxcxnpkdr6
         /uR6oLCe0UOa637+p3bMRCuvA/BfmYlhLXyEh/KRM43cpV4J5z9VdC9Xa8g4TjNeLlz5
         JwArr1GgfJkVuE6z6SPCjSRZU5QXq9VwwH+4lam4PD1TKOy/XuqIIISUgsDuU8gTTfMm
         46PQ==
X-Gm-Message-State: AKS2vOx2S8C97hW798BdJVtVEV9M6JljEEw7HCzEx0QT0TgJozzzczzh
        W4z2508284Ab0Ucm
X-Received: by 10.28.111.5 with SMTP id k5mr2918660wmc.19.1498685394810;
        Wed, 28 Jun 2017 14:29:54 -0700 (PDT)
Received: from ccsh0hfn32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l20sm2581036wre.25.2017.06.28.14.29.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:29:54 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v8 0/6] convert: add "status=delayed" to filter process protocol
Date:   Wed, 28 Jun 2017 23:29:46 +0200
Message-Id: <20170628212952.60781-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 8th iteration of my "status delayed" topic. Patch 1 to 3 are
minor t0021 test adjustments. Patch 4 is a minor convert.c style adjustment.
Patch 5 is a minor "extract method" refactoring in convert.c with an
additional minor style adjustment. Patch 6 is the new feature.

### Changes since v7 (full inter diff below!):
* remove 'is_delayed' member from delayed_checkout struct as the
  information can be derived from the 'paths' member (Junio)
* use table-driven approach for capability negotiation (Junio)
* remove unnecessary assert (Junio)
* fix comment style (Junio)

If you review this series then please read the "Delay" section in
"Documentation/gitattributes.txt" first for an overview of the delay mechanism.
The changes in "t/t0021/rot13-filter.pl" are easier to review if you ignore
whitespace changes.

Thanks,
Lars


RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/
v3: http://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/
v4: http://public-inbox.org/git/20170522135001.54506-1-larsxschneider@gmail.com/
v5: http://public-inbox.org/git/20170601082203.50397-1-larsxschneider@gmail.com/
v6: http://public-inbox.org/git/20170625182125.6741-1-larsxschneider@gmail.com/
v7: http://public-inbox.org/git/20170627121027.99209-1-larsxschneider@gmail.com/

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/9877046063
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v8 && git checkout 9877046063


### Interdiff (v7..v8):

diff --git a/convert.c b/convert.c
index f17d822ac8..12a0b3eafb 100644
--- a/convert.c
+++ b/convert.c
@@ -508,7 +508,7 @@ static struct hashmap subprocess_map;

 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	int err;
+	int err, i;
 	struct cmd2process *entry = (struct cmd2process *)subprocess;
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
@@ -516,6 +516,15 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	struct child_process *process = &subprocess->process;
 	const char *cmd = subprocess->cmd;

+	static const struct {
+		const char *name;
+		unsigned int cap;
+	} known_caps[] = {
+		{ "clean",  CAP_CLEAN  },
+		{ "smudge", CAP_SMUDGE },
+		{ "delay",  CAP_DELAY  },
+	};
+
 	sigchain_push(SIGPIPE, SIG_IGN);

 	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
@@ -534,8 +543,15 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	if (err)
 		goto done;

-	err = packet_writel(process->in,
-		"capability=clean", "capability=smudge", "capability=delay", NULL);
+	for (i = 0; i < ARRAY_SIZE(known_caps); ++i) {
+		err = packet_write_fmt_gently(
+			process->in, "capability=%s\n", known_caps[i].name);
+		if (err)
+			goto done;
+	}
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;

 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -547,18 +563,15 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 			continue;

 		cap_name = cap_list.items[1].string;
-		if (!strcmp(cap_name, "clean")) {
-			entry->supported_capabilities |= CAP_CLEAN;
-		} else if (!strcmp(cap_name, "smudge")) {
-			entry->supported_capabilities |= CAP_SMUDGE;
-		} else if (!strcmp(cap_name, "delay")) {
-			entry->supported_capabilities |= CAP_DELAY;
-		} else {
-			warning(
-				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
-			);
-		}
+		i = ARRAY_SIZE(known_caps) - 1;
+		while (i >= 0 && strcmp(cap_name, known_caps[i].name))
+			i--;
+
+		if (i >= 0)
+			entry->supported_capabilities |= known_caps[i].cap;
+		else
+			warning("external filter '%s' requested unsupported filter capability '%s'",
+			cmd, cap_name);

 		string_list_clear(&cap_list, 0);
 	}
@@ -677,7 +690,6 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;

 	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
-		dco->is_delayed = 1;
 		string_list_insert(&dco->filters, cmd);
 		string_list_insert(&dco->paths, path);
 	} else {
diff --git a/convert.h b/convert.h
index cdb91ab99a..643a5be6cc 100644
--- a/convert.h
+++ b/convert.h
@@ -41,14 +41,13 @@ enum ce_delay_state {
 };

 struct delayed_checkout {
-	/* State of the currently processed cache entry. If the state is
-	 * CE_CAN_DELAY, then the filter can change the 'is_delayed' flag
-	 * to signal that the current cache entry was delayed. If the state is
-	 * CE_RETRY, then this signals the filter that the cache entry was
-	 * requested before.
+	/*
+	 * State of the currently processed cache entry. If the state is
+	 * CE_CAN_DELAY, then the filter can delay the current cache entry.
+	 * If the state is CE_RETRY, then this signals the filter that the
+	 * cache entry was requested before.
 	 */
 	enum ce_delay_state state;
-	int is_delayed;
 	/* List of filter drivers that signaled delayed blobs. */
 	struct string_list filters;
 	/* List of delayed blobs identified by their path. */
diff --git a/entry.c b/entry.c
index 8406060e33..65458f07a4 100644
--- a/entry.c
+++ b/entry.c
@@ -179,7 +179,8 @@ int finish_delayed_checkout(struct checkout *state)
 				continue;
 			}
 			if (available_paths.nr <= 0) {
-				/* Filter responded with no entries. That means
+				/*
+				 * Filter responded with no entries. That means
 				 * the filter is done and we can remove the
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
@@ -188,7 +189,8 @@ int finish_delayed_checkout(struct checkout *state)
 				continue;
 			}

-			/* In dco->paths we store a list of all delayed paths.
+			/*
+			 * In dco->paths we store a list of all delayed paths.
 			 * The filter just send us a list of available paths.
 			 * Remove them from the list.
 			 */
@@ -205,7 +207,8 @@ int finish_delayed_checkout(struct checkout *state)
 					      filter->string, path->string);
 					errs |= 1;

-					/* Do not ask the filter for available blobs,
+					/*
+					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
 					filter->string = "";
@@ -213,7 +216,6 @@ int finish_delayed_checkout(struct checkout *state)
 				}
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
-				assert(dco->state == CE_RETRY);
 				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
 			}
 		}
@@ -284,10 +286,9 @@ static int write_entry(struct cache_entry *ce,
 					new = NULL;
 					size = 0;
 				}
-				dco->is_delayed = 0;
 				ret = async_convert_to_working_tree(
 					ce->name, new, size, &buf, dco);
-				if (ret && dco->is_delayed) {
+				if (ret && string_list_has_string(&dco->paths, ce->name)) {
 					free(new);
 					goto finish;
 				}


### Patches

Lars Schneider (6):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT <size>" only on success
  convert: put the flags field before the flag itself for consistent
    style
  convert: move multiple file filter error handling to separate function
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  69 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   3 +
 convert.c                       | 202 +++++++++++++++++++++++++++----------
 convert.h                       |  26 +++++
 entry.c                         | 132 ++++++++++++++++++++++++-
 t/t0021-conversion.sh           | 178 +++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl         | 214 +++++++++++++++++++++++++++-------------
 unpack-trees.c                  |   2 +
 9 files changed, 668 insertions(+), 161 deletions(-)


base-commit: 0339965c70d68fd3831c9a5306443c869de3f6a8
--
2.13.2

