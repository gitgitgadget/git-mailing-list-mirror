Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E603A1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeDCQ26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:47675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeDCQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:56 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MIu7d-1f5JXb49Gb-002X3m; Tue, 03 Apr 2018 18:28:47 +0200
Date:   Tue, 3 Apr 2018 18:28:46 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 12/15] git_config_set: make use of the config parser's
 event stream
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <f65d03849854bb7e46041225e9f7bb4ba8f043f7.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eJFFVSV7RLg2VzA+lgnO/gDpeRoBgLomSopZAIgwbykeU9lN7Cf
 RZYjVft3lWY7i9RkZA6pNdcSmWKBUhdmkvYoGYFatm7gotEGoll6hkgqf5xe5QwNE/Kh++E
 yMXny82jrhJ2CxOo5ffmmt7X5YU7S1UpwN32Kw2cL2t3woCdcC4wfvXdGHRfFLY+20XtKRT
 uK/gzjMFWVikC9LKKk+hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bRI9GogplxU=:Oa//ljH1DHw+VdwK+2CCyc
 ZKRneTYG12Xbb78lmpHED/O+QXKIaEURCOpyaaoX7xU42t1yXYefV7P7ltkm6DC870p1z9IR4
 MKVK5TRuMd8VF+VrPGq2aq2euZopZHKMitSmO3Dmu6cKapLDwumOzquZfjGbWtIeq2KoctyoH
 7Hjz4C4NnD6X4IrmQs/kYHRQtB9aRo1EKWRjM8z5GI6v+WPnXGoMftpRq7cW2zsbKWC9bSKiS
 5tdyTaAsLTKiXZ2/PQ5FxrDvFWtKuXSP/iZlbd2HHORloqDklt3O2zLPL0rP2XLRZv7t4rK8G
 PhNpRfDLCfes8qCUUEDxF5r4DNSkJa4D+8lIrYT1dw9pkT099unKvi4b4+/B4rCJPgRsxzj8q
 24Z9+zqSd/6Ex3mV80Oz9ehlrAYjGvN56+2G3/2Y4dc29LrZsKvyxssJQ1wkavfpFkzWrn5pK
 s97pLs7nZ+KdQ5GIO3wvGgNZzEm6HP+vwUG0mwwhGiMcyP0SyRUgW7TXUZ/jN0XaGI6qmqjdy
 FRIsFWIPbmM5+5JtrowfcLuUxWoXC5hFxklF7SkyT17MoST8wr51c53rmh99iZ1/b5fi0wXYQ
 p5TN8H78n9cYzC0y+V3IcJHj9LKAwbX6E/Ii1zgDPAFaScFy+giiqPvcUS1l37TgowZ6iq8RQ
 jhcETvRGwT3OeevpSFJ0uhGa9XayGAT9GLTGL1zqIVQTuV6dPd402HGwVf8Hph+WRc8TPLbJ5
 14jc0W51AE2zmE7iT0zr7/dkDXauyZb8xGXTC0BE/nmwtar83sNxBS8pTf5jW3vIXbU4ytq+V
 SB5AnSOi8UkJzKx3ZTlRhGD7Zs8Q2NAyh5lk/AUaPYqt3cN85R4afoJ7fOHvLNlT3HsBQvr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the recent commit with the title "config: introduce an optional event
stream while parsing", we introduced an optional callback to keep track
of the config parser's events "comment", "white-space", "section header"
and "entry".

One motivation for this feature was to make use of it in the code that
edits the config. And this commit makes it so.

Note: this patch changes the meaning of the `seen` array that records
whether we saw the config entry that is to be edited: previously, it
contained the end offset of the found entry. Now, we introduce a new
array `parsed` that keeps a record of *all* config parser events (with
begin/end offsets), and the items in the `seen` array now point into the
`parsed` array.

There are two reasons why we do it this way:

1. To keep the implementation simple, the config parser's event stream
   reports the event only after the config callback was called, so we
   would not receive the begin offset otherwise.

2. In the following patches, we will re-use the `parsed` array to fix two
   long-standing bugs related to empty sections.

Note that this also makes the code more robust with respect to finding the
begin offset of the part(s) of the config file to be edited, as we no
longer back-track to find the beginning of the line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 170 ++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 81 insertions(+), 89 deletions(-)

diff --git a/config.c b/config.c
index 84e8f7ffeb8..345b1d2f140 100644
--- a/config.c
+++ b/config.c
@@ -2303,8 +2303,11 @@ struct config_set_store {
 	int do_not_match;
 	regex_t *value_regex;
 	int multi_replace;
-	size_t *seen;
-	unsigned int seen_nr, seen_alloc;
+	struct {
+		size_t begin, end;
+		enum config_event_t type;
+	} *parsed;
+	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
@@ -2322,10 +2325,31 @@ static int matches(const char *key, const char *value,
 		(value && !regexec(store->value_regex, value, 0, NULL, 0));
 }
 
+static int store_aux_event(enum config_event_t type,
+			   size_t begin, size_t end, void *data)
+{
+	struct config_set_store *store = data;
+
+	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
+	store->parsed[store->parsed_nr].begin = begin;
+	store->parsed[store->parsed_nr].end = end;
+	store->parsed[store->parsed_nr].type = type;
+	store->parsed_nr++;
+
+	if (type == CONFIG_EVENT_SECTION) {
+		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
+			BUG("Invalid section name '%s'", cf->var.buf);
+
+		/* Is this the section we were looking for? */
+		store->is_keys_section = cf->var.len - 1 == store->baselen &&
+			!strncasecmp(cf->var.buf, store->key, store->baselen);
+	}
+
+	return 0;
+}
+
 static int store_aux(const char *key, const char *value, void *cb)
 {
-	const char *ep;
-	size_t section_len;
 	struct config_set_store *store = cb;
 
 	if (store->key_seen) {
@@ -2337,55 +2361,21 @@ static int store_aux(const char *key, const char *value, void *cb)
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
 				   store->seen_alloc);
 
-			store->seen[store->seen_nr] = cf->do_ftell(cf);
+			store->seen[store->seen_nr] = store->parsed_nr;
 			store->seen_nr++;
 		}
-		return 0;
 	} else if (store->is_keys_section) {
 		/*
-		 * What we are looking for is in store->key (both
-		 * section and var), and its section part is baselen
-		 * long.  We found key (again, both section and var).
-		 * We would want to know if this key is in the same
-		 * section as what we are looking for.  We already
-		 * know we are in the same section as what should
-		 * hold store->key.
+		 * Do not increment matches yet: this may not be a match, but we
+		 * are in the desired section.
 		 */
-		ep = strrchr(key, '.');
-		section_len = ep - key;
-
-		if ((section_len != store->baselen) ||
-		    memcmp(key, store->key, section_len+1)) {
-			store->is_keys_section = 0;
-			return 0;
-		}
-		/*
-		 * Do not increment matches: this is no match, but we
-		 * just made sure we are in the desired section.
-		 */
-		ALLOC_GROW(store->seen, store->seen_nr + 1,
-			   store->seen_alloc);
-		store->seen[store->seen_nr] = cf->do_ftell(cf);
-	}
-
-	if (matches(key, value, store)) {
-		ALLOC_GROW(store->seen, store->seen_nr + 1,
-			   store->seen_alloc);
-		store->seen[store->seen_nr] = cf->do_ftell(cf);
-		store->seen_nr++;
-		store->key_seen = 1;
+		ALLOC_GROW(store->seen, store->seen_nr + 1, store->seen_alloc);
+		store->seen[store->seen_nr] = store->parsed_nr;
 		store->section_seen = 1;
-		store->is_keys_section = 1;
-	} else {
-		if (strrchr(key, '.') - key == store->baselen &&
-		      !strncmp(key, store->key, store->baselen)) {
-				store->section_seen = 1;
-				store->is_keys_section = 1;
-				ALLOC_GROW(store->seen,
-					   store->seen_nr + 1,
-					   store->seen_alloc);
-				store->seen[store->seen_nr] =
-					cf->do_ftell(cf);
+
+		if (matches(key, value, store)) {
+			store->seen_nr++;
+			store->key_seen = 1;
 		}
 	}
 
@@ -2486,32 +2476,6 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 	return ret;
 }
 
-static ssize_t find_beginning_of_line(const char *contents, size_t size,
-	size_t offset_, int *found_bracket)
-{
-	size_t equal_offset = size, bracket_offset = size;
-	ssize_t offset;
-
-contline:
-	for (offset = offset_-2; offset > 0
-			&& contents[offset] != '\n'; offset--)
-		switch (contents[offset]) {
-			case '=': equal_offset = offset; break;
-			case ']': bracket_offset = offset; break;
-		}
-	if (offset > 0 && contents[offset-1] == '\\') {
-		offset_ = offset;
-		goto contline;
-	}
-	if (bracket_offset < equal_offset) {
-		*found_bracket = 1;
-		offset = bracket_offset+1;
-	} else
-		offset++;
-
-	return offset;
-}
-
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *value)
 {
@@ -2622,6 +2586,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
+		struct config_options opts;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
@@ -2644,17 +2609,24 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			}
 		}
 
-		ALLOC_GROW(store.seen, 1, store.seen_alloc);
-		store.seen[0] = 0;
-		store.seen_nr = 0;
+		ALLOC_GROW(store.parsed, 1, store.parsed_alloc);
+		store.parsed[0].end = 0;
+
+		memset(&opts, 0, sizeof(opts));
+		opts.event_fn = store_aux_event;
+		opts.event_fn_data = &store;
 
 		/*
-		 * After this, store.offset will contain the *end* offset
-		 * of the last match, or remain at 0 if no match was found.
+		 * After this, store.parsed will contain offsets of all the
+		 * parsed elements, and store.seen will contain a list of
+		 * matches, as indices into store.parsed.
+		 *
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, &store)) {
+		if (git_config_from_file_with_options(store_aux,
+						      config_filename,
+						      &store, &opts)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL &&
@@ -2706,19 +2678,39 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		if (store.seen_nr == 0)
+		if (store.seen_nr == 0) {
+			if (!store.seen_alloc) {
+				/* Did not see key nor section */
+				ALLOC_GROW(store.seen, 1, store.seen_alloc);
+				store.seen[0] = store.parsed_nr
+					- !!store.parsed_nr;
+			}
 			store.seen_nr = 1;
+		}
 
 		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
+			size_t replace_end;
+			int j = store.seen[i];
+
 			new_line = 0;
-			if (store.seen[i] == 0) {
-				store.seen[i] = copy_end = contents_sz;
-			} else if (!store.key_seen) {
-				copy_end = store.seen[i];
-			} else
-				copy_end = find_beginning_of_line(
-					contents, contents_sz,
-					store.seen[i], &new_line);
+			if (!store.key_seen) {
+				replace_end = copy_end = store.parsed[j].end;
+			} else {
+				replace_end = store.parsed[j].end;
+				copy_end = store.parsed[j].begin;
+				/*
+				 * Swallow preceding white-space on the same
+				 * line.
+				 */
+				while (copy_end > 0 ) {
+					char c = contents[copy_end - 1];
+
+					if (isspace(c) && c != '\n')
+						copy_end--;
+					else
+						break;
+				}
+			}
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
@@ -2732,7 +2724,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				    write_str_in_full(fd, "\n") < 0)
 					goto write_err_out;
 			}
-			copy_begin = store.seen[i];
+			copy_begin = replace_end;
 		}
 
 		/* write the pair (value == NULL means unset) */
-- 
2.16.2.windows.1.26.g2cc3565eb4b


