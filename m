Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DAF2082F
	for <e@80x24.org>; Tue, 27 Jun 2017 12:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbdF0MKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:10:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36615 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdF0MKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:10:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so31680107wrb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+qXb9uSvO5TuYQ0qPBh9U1adeR1dipuhBSY6zY23q7Y=;
        b=PLaxAw6CcLeVGw0CnRYFxqnqhL40p7P77o0MJRWSVyCYFz0H6qupsDwu3Rhb+DCQUy
         8BgYB81ZVPQJv33KgRA+s33V4oNfS4gY47D8J3zqTvA3BEw5u+zBp3ojy/wLZfBiRVtq
         eX4v5/hhAJfgvvraIz9gFYDwz0/M3n0+6JRE+dvx9KqRlrGylS+6BWZSD4gXs2sKG06x
         0UF2enggwnfrLUXQLCO5mG25ys+cv41FhNBKR2polX6i+ee5FMNrgsiW1L2AjlLtmcSe
         ek91HhmJGgptq4TvCexwPMrUZU7TuLJGZPE6xPZ5FKDLfH8tZ3978/2r1nDEG3tK8TsO
         /Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+qXb9uSvO5TuYQ0qPBh9U1adeR1dipuhBSY6zY23q7Y=;
        b=A8lnc/d1d+RFlzlQ6/cn3+RMLobJiyiVEkLO8W1EUar3PgyMXYk+fzzBv5vN7ZpyA+
         F/YKiJQUcfMbiGkBESqUS7fEQ/XYq+a4rmQYmsqQ0i1HobEVmrnExZYjGcNsJZBiOuhb
         vMPE5uOpakymteQe3SiSAphp3bWUeypyUu1g+TXL9zAWirS/IB28NBKr/2svvI1Bl+Iz
         x+uhrwVlMBI94RYXHMn7aKRQMMiCBaN2JxEKZtUh6QmcrCi7xAQbmIuC06HiSba1wN5q
         Y2O7GG55EZ1fqFtTUhmfioP8jPKLa+D3ugRDf/QvTdmZKlWnBFW6k5hGJsqaO4Dwe9K+
         s0DA==
X-Gm-Message-State: AKS2vOx9GfVLwvfeRx9W70p4Io3ad2cN/LIvtsH6qLqcqCUeiW13UeZQ
        VAh9vK3iehSa78fD
X-Received: by 10.223.165.86 with SMTP id j22mr14444387wrb.147.1498565434615;
        Tue, 27 Jun 2017 05:10:34 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:33 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 0/6] convert: add "status=delayed" to filter process protocol
Date:   Tue, 27 Jun 2017 14:10:21 +0200
Message-Id: <20170627121027.99209-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 7th iteration of my "status delayed" topic. Patch 1 to 3 are
minor t0021 test adjustments. Patch 4 is a minor convert.c style adjustment.
Patch 5 is a minor "extract method" refactoring in convert.c with an
additional minor style adjustment. Patch 6 is the new feature.

Changes since v6 (full inter diff below!):
* delayed_checkout->state was used for two purposes:
  (1) Signal the filter if a cache entry can be delayed
  (2) Retrieve info from the filter if a cache entry actually was delayed
  --> That double use is confusing. To make it more clear I removed the
      ce_delay_state "CE_DELAYED" and added the member "is_delayed" to
      delayed_checkout. The filter can use that member to communicate back
      to Git that a cache entry was delayed (Junio/Peff)
* throw an error if the filter sends Git a path in async_query_available_blobs
  that was not delayed before (Junio)
* add test cases for the following "delay related" errors:
  (1) The filter misses to signal the availability of a file
  (2) The filter signals the availability of a blob that was not delayed before
* format comments properly (Junio)
* use STRING_LIST_INIT_NODUP (Junio)
* various commit message improvements (Junio)
* documentation improvements (Junio)
* variable naming improvements (Junio)
* remove unnecessary empty line (Junio)

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


Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/5b124cdf43
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v7 && git checkout 5b124cdf43

Interdiff (v6..v7):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 5489e8b723..4049a0b9a8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -539,13 +539,17 @@ packet:          git< 0000

 If the filter supports the "delay" capability then it must support the
 "list_available_blobs" command. If Git sends this command, then the
-filter is expected to return a list of pathnames of blobs that are
-available. The list must be terminated with a flush packet followed
+filter is expected to return a list of pathnames representing blobs
+that have been delayed earlier and are now available.
+The list must be terminated with a flush packet followed
 by a "success" status that is also terminated with a flush packet. If
 no blobs for the delayed paths are available, yet, then the filter is
 expected to block the response until at least one blob becomes
 available. The filter can tell Git that it has no more delayed blobs
-by sending an empty list.
+by sending an empty list. As soon as the filter responds with an empty
+list, Git stops asking. All blobs that Git has not received at this
+point are considered missing and will result in an error.
+
 ------------------------
 packet:          git> command=list_available_blobs
 packet:          git> 0000
diff --git a/cache.h b/cache.h
index 2ec12c4477..69b03b5dc7 100644
--- a/cache.h
+++ b/cache.h
@@ -1552,7 +1552,6 @@ struct checkout {
 };
 #define CHECKOUT_INIT { NULL, "" }

-
 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern void enable_delayed_checkout(struct checkout *state);
diff --git a/convert.c b/convert.c
index 6452ab546a..f17d822ac8 100644
--- a/convert.c
+++ b/convert.c
@@ -677,7 +677,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;

 	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
-		dco->state = CE_DELAYED;
+		dco->is_delayed = 1;
 		string_list_insert(&dco->filters, cmd);
 		string_list_insert(&dco->paths, path);
 	} else {
@@ -709,7 +709,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 }


-int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths)
+int async_query_available_blobs(const char *cmd, struct string_list *available_paths)
 {
 	int err;
 	char *line;
@@ -739,7 +739,7 @@ int async_query_available_blobs(const char *cmd, struct string_list *delayed_pat
 	while ((line = packet_read_line(process->out, NULL))) {
 		const char *path;
 		if (skip_prefix(line, "pathname=", &path))
-			string_list_insert(delayed_paths, xstrdup(path));
+			string_list_insert(available_paths, xstrdup(path));
 		else
 			; /* ignore unknown keys */
 	}
diff --git a/convert.h b/convert.h
index 51f0fb7fbe..cdb91ab99a 100644
--- a/convert.h
+++ b/convert.h
@@ -37,16 +37,18 @@ enum eol {
 enum ce_delay_state {
 	CE_NO_DELAY = 0,
 	CE_CAN_DELAY = 1,
-	CE_DELAYED = 2,
-	CE_RETRY = 3
+	CE_RETRY = 2
 };

 struct delayed_checkout {
 	/* State of the currently processed cache entry. If the state is
-	CE_CAN_DELAY, then the filter can change this to CE_DELAYED. If
-	the state is CE_RETRY, then this signals the filter that the cache
-	entry was requested before. */
+	 * CE_CAN_DELAY, then the filter can change the 'is_delayed' flag
+	 * to signal that the current cache entry was delayed. If the state is
+	 * CE_RETRY, then this signals the filter that the cache entry was
+	 * requested before.
+	 */
 	enum ce_delay_state state;
+	int is_delayed;
 	/* List of filter drivers that signaled delayed blobs. */
 	struct string_list filters;
 	/* List of delayed blobs identified by their path. */
@@ -66,7 +68,7 @@ extern int convert_to_working_tree(const char *path, const char *src,
 extern int async_convert_to_working_tree(const char *path, const char *src,
 					 size_t len, struct strbuf *dst,
 					 void *dco);
-extern int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths);
+extern int async_query_available_blobs(const char *cmd, struct string_list *available_paths);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
diff --git a/entry.c b/entry.c
index c6d5cc01dc..8406060e33 100644
--- a/entry.c
+++ b/entry.c
@@ -150,7 +150,12 @@ void enable_delayed_checkout(struct checkout *state)
 static int remove_available_paths(struct string_list_item *item, void *cb_data)
 {
 	struct string_list *available_paths = cb_data;
-	return !string_list_has_string(available_paths, item->string);
+	struct string_list_item *available;
+
+	available = string_list_lookup(available_paths, item->string);
+	if (available)
+		available->util = (void *)item->string;
+	return !available;
 }

 int finish_delayed_checkout(struct checkout *state)
@@ -165,8 +170,7 @@ int finish_delayed_checkout(struct checkout *state)
 	dco->state = CE_RETRY;
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
-			struct string_list available_paths;
-			string_list_init(&available_paths, 0);
+			struct string_list available_paths = STRING_LIST_INIT_NODUP;

 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -176,24 +180,38 @@ int finish_delayed_checkout(struct checkout *state)
 			}
 			if (available_paths.nr <= 0) {
 				/* Filter responded with no entries. That means
-				   the filter is done and we can remove the
-				   filter from the list (see
-				   "string_list_remove_empty_items" call below).
+				 * the filter is done and we can remove the
+				 * filter from the list (see
+				 * "string_list_remove_empty_items" call below).
 				 */
 				filter->string = "";
 				continue;
 			}

 			/* In dco->paths we store a list of all delayed paths.
-			   The filter just send us a list of available paths.
-			   Remove them from the list.
+			 * The filter just send us a list of available paths.
+			 * Remove them from the list.
 			 */
 			filter_string_list(&dco->paths, 0,
 				&remove_available_paths, &available_paths);

 			for_each_string_list_item(path, &available_paths) {
-				struct cache_entry* ce = index_file_exists(
-					state->istate, path->string,
+				struct cache_entry* ce;
+
+				if (!path->util) {
+					error("external filter '%s' signaled that '%s' "
+					      "is now available although it has not been "
+					      "delayed earlier",
+					      filter->string, path->string);
+					errs |= 1;
+
+					/* Do not ask the filter for available blobs,
+					 * again, as the filter is likely buggy.
+					 */
+					filter->string = "";
+					continue;
+				}
+				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
 				assert(dco->state == CE_RETRY);
 				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
@@ -206,7 +224,7 @@ int finish_delayed_checkout(struct checkout *state)
 	/* At this point we should not have any delayed paths anymore. */
 	errs |= dco->paths.nr;
 	for_each_string_list_item(path, &dco->paths) {
-		warning(_("%s was not filtered properly."), path->string);
+		error("'%s' was not filtered properly", path->string);
 	}
 	string_list_clear(&dco->paths, 0);

@@ -266,12 +284,11 @@ static int write_entry(struct cache_entry *ce,
 					new = NULL;
 					size = 0;
 				}
+				dco->is_delayed = 0;
 				ret = async_convert_to_working_tree(
 					ce->name, new, size, &buf, dco);
-				if (ret && dco->state == CE_DELAYED) {
+				if (ret && dco->is_delayed) {
 					free(new);
-					/* Reset the state of the next blob */
-					dco->state = CE_CAN_DELAY;
 					goto finish;
 				}
 			} else
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4b5a45fd43..eb3d83744a 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -720,7 +720,7 @@ test_expect_success PERL 'delayed checkout in process filter' '
 		cp "$TEST_ROOT/test.o" test-delay20.a &&
 		cp "$TEST_ROOT/test.o" test-delay10.b &&
 		git add . &&
-		git commit -m "test commit 1"
+		git commit -m "test commit"
 	) &&

 	S=$(file_size "$TEST_ROOT/test.o") &&
@@ -775,4 +775,46 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	)
 '

+test_expect_success PERL 'missing file in delayed checkout' '
+	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+	test_config_global filter.bug.required true &&
+
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		echo "*.a filter=bug" >.gitattributes &&
+		cp "$TEST_ROOT/test.o" missing-delay.a
+		git add . &&
+		git commit -m "test commit"
+	) &&
+
+	rm -rf repo-cloned &&
+	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
+	cat git-stderr.log &&
+	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
+'
+
+test_expect_success PERL 'invalid file in delayed checkout' '
+	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+	test_config_global filter.bug.required true &&
+
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		echo "*.a filter=bug" >.gitattributes &&
+		cp "$TEST_ROOT/test.o" invalid-delay.a &&
+		cp "$TEST_ROOT/test.o" unfiltered
+		git add . &&
+		git commit -m "test commit"
+	) &&
+
+	rm -rf repo-cloned &&
+	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
+	grep "error: external filter .* signaled that .unfiltered. is now available although it has not been delayed earlier" git-stderr.log
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index f0dc0aff4a..ad685d92f8 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -19,10 +19,15 @@
 #     to process the file and any file after that is processed with the
 #     same command.
 # (5) If data with a pathname that is a key in the DELAY hash is
-#     requested (e.g. 'test-delay10.a') then the filter responds with
+#     requested (e.g. "test-delay10.a") then the filter responds with
 #     a "delay" status and sets the "requested" field in the DELAY hash.
 #     The filter will signal the availability of this object after
 #     "count" (field in DELAY hash) "list_available_blobs" commands.
+# (6) If data with the pathname "missing-delay.a" is processed that the
+#     filter will drop the path from the "list_available_blobs" response.
+# (7) If data with the pathname "invalid-delay.a" is processed that the
+#     filter will add the path "unfiltered" which was not delayed before
+#     to the "list_available_blobs" response.
 #

 use strict;
@@ -40,6 +45,8 @@ my %DELAY = (
 	'test-delay11.a' => { "requested" => 0, "count" => 1 },
 	'test-delay20.a' => { "requested" => 0, "count" => 2 },
 	'test-delay10.b' => { "requested" => 0, "count" => 1 },
+	'missing-delay.a' => { "requested" => 0, "count" => 1 },
+	'invalid-delay.a' => { "requested" => 0, "count" => 1 },
 );

 sub rot13 {
@@ -135,7 +142,13 @@ while (1) {
 		foreach my $pathname ( sort keys %DELAY ) {
 			if ( $DELAY{$pathname}{"requested"} >= 1 ) {
 				$DELAY{$pathname}{"count"} = $DELAY{$pathname}{"count"} - 1;
-				if ($DELAY{$pathname}{"count"} == 0 ) {
+				if ( $pathname eq "invalid-delay.a" ) {
+					# Send Git a pathname that was not delayed earlier
+					packet_txt_write("pathname=unfiltered");
+				}
+				if ( $pathname eq "missing-delay.a" ) {
+					# Do not signal Git that this file is available
+				} elsif ( $DELAY{$pathname}{"count"} == 0 ) {
 					print $debug " $pathname";
 					packet_txt_write("pathname=$pathname");
 				}


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
 convert.c                       | 168 +++++++++++++++++++++++--------
 convert.h                       |  27 +++++
 entry.c                         | 131 +++++++++++++++++++++++-
 t/t0021-conversion.sh           | 178 +++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl         | 214 +++++++++++++++++++++++++++-------------
 unpack-trees.c                  |   2 +
 9 files changed, 645 insertions(+), 150 deletions(-)


base-commit: 0339965c70d68fd3831c9a5306443c869de3f6a8
--
2.13.2

