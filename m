Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E6F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDCQ2x (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:42753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeDCQ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:52 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MXq3L-1ezKKi1OXX-00Wly5; Tue, 03 Apr 2018 18:28:43 +0200
Date:   Tue, 3 Apr 2018 18:28:42 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 11/15] git_config_set: do not use a state machine
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <4b3eba873df4355d7a77dfbd74963c636b1ba08e.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6FMmcHN5YWOZfGUxY4kHOMbtBvpRUMPXphfzRLen6nrr5Fy1lCR
 /RJsbImQneW/yAhnmgwfTmRCk0Qqkv9gzlTdsxgEYEfokh0Ate0zJzMJpRKCa+Mlf9R1lXY
 ww6I6k+m57HNeraMpo0U49H7VL0puJX+/ihgSoBWq5rAx79rMWUL+mCUou+Ya3K48eBheIt
 VzDCoHaI1ZOaibWfscT7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M036BQ60ZTc=:P6+LkkXYl9SPU8czJ7U6bJ
 ovYy+XAFxwWaoeIeuN5jvKHJcKZco++t7QKXOIVnxoTMBQ4fPgGuU4rZxngdExqplERFFtPH5
 FukSYd5piBfjBFfA4UPQZPwGIB5kkubSt80v97zHQlaMGAGU8CoQyZOjnhhZl6EAExernuznr
 MpaioO3NWSUNM0DmO6TmPpBRALpTH45l9WZl/HhgbcHNS1ApcvyQRD0TLc3CGOKtBIDXrfGdQ
 RR0Nfzmbp8hA/GSuZKX9nN6Zpz1/EYT3rMA4wCLePITI5ewTkauw8KpblHdOmmT1Q6kRz+TDB
 6S1B1OTRB2JiGR2wSi4fLRj/N0pvi5JVaD7AxlzMNKnym/LFg5iQB0c1AXAUJN42uS+J6YLjx
 iO/bkCYTcq7lygQ4qslT/yZEDlqggya9cS/iSEnlycvkLnI/ju0lWfIgXbpfNkxtmwGARSd5N
 lP4NvOsKcQQFMyTNJe+i4pBUyoQH/bR7kEwRK0BmFyfjSktHQ718Elb+sGnvfpDrVn6wNjeQW
 yAFRKHRT7GcvyOXJkiSvQbGH7rizxNlrQByUF2SqUoAzDJOj38iH7uQnpkdgZZw6snFE31k2D
 AEwpAgIRJPsDlH/2jZLjaM110IB0vGrT5ZrsGjIAiRGBZiXdJwcoRHmqhsQ4aE0GHodaSEhE6
 uPS2POgr110BKy00uX16Cuy96arRMKGxuUE3JJGxAiWjhIM46MpYNJU/Vw4vCged/zDqQ2/Lq
 DybpMLkPxirP7oCby2XHE8EllRenSmd25WgS4crVuWgqWd/ENCpjJI6mTXAqEKuIZtfDA/AhT
 dJKA8puXQa512cOKQX0saXwpvfuARDil1PIX8uumXJdBFUk7j0q76l6GrWl/EMcMN3kNv8K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While a neat theoretical construct, state machines are hard to read. In
this instance, it does not even make a whole lot of sense because we are
more interested in flags, anyway: has the section been seen? Has the key
been seen? Does the current section match the key we are looking for?

Besides, the state `SECTION_SEEN` was named in a misleading way: it did
not indicate that we saw the section matching the key we are looking
for, but it instead indicated that we are *currently* in that section.

Let's just replace the state machine logic by clear and obvious flags.

This will also make it easier to review the upcoming patches to use the
newly-introduced `event_fn` callback of the config parser.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/config.c b/config.c
index b73b48b5650..84e8f7ffeb8 100644
--- a/config.c
+++ b/config.c
@@ -2305,7 +2305,7 @@ struct config_set_store {
 	int multi_replace;
 	size_t *seen;
 	unsigned int seen_nr, seen_alloc;
-	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
+	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
 static int matches(const char *key, const char *value,
@@ -2328,8 +2328,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 	size_t section_len;
 	struct config_set_store *store = cb;
 
-	switch (store->state) {
-	case KEY_SEEN:
+	if (store->key_seen) {
 		if (matches(key, value, store)) {
 			if (store->seen_nr == 1 && store->multi_replace == 0) {
 				warning(_("%s has multiple values"), key);
@@ -2341,8 +2340,8 @@ static int store_aux(const char *key, const char *value, void *cb)
 			store->seen[store->seen_nr] = cf->do_ftell(cf);
 			store->seen_nr++;
 		}
-		break;
-	case SECTION_SEEN:
+		return 0;
+	} else if (store->is_keys_section) {
 		/*
 		 * What we are looking for is in store->key (both
 		 * section and var), and its section part is baselen
@@ -2357,10 +2356,9 @@ static int store_aux(const char *key, const char *value, void *cb)
 
 		if ((section_len != store->baselen) ||
 		    memcmp(key, store->key, section_len+1)) {
-			store->state = SECTION_END_SEEN;
-			break;
+			store->is_keys_section = 0;
+			return 0;
 		}
-
 		/*
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
@@ -2368,27 +2366,29 @@ static int store_aux(const char *key, const char *value, void *cb)
 		ALLOC_GROW(store->seen, store->seen_nr + 1,
 			   store->seen_alloc);
 		store->seen[store->seen_nr] = cf->do_ftell(cf);
-		/* fallthru */
-	case SECTION_END_SEEN:
-	case START:
-		if (matches(key, value, store)) {
-			ALLOC_GROW(store->seen, store->seen_nr + 1,
-				   store->seen_alloc);
-			store->seen[store->seen_nr] = cf->do_ftell(cf);
-			store->state = KEY_SEEN;
-			store->seen_nr++;
-		} else {
-			if (strrchr(key, '.') - key == store->baselen &&
-			      !strncmp(key, store->key, store->baselen)) {
-					store->state = SECTION_SEEN;
-					ALLOC_GROW(store->seen,
-						   store->seen_nr + 1,
-						   store->seen_alloc);
-					store->seen[store->seen_nr] =
-						cf->do_ftell(cf);
-			}
+	}
+
+	if (matches(key, value, store)) {
+		ALLOC_GROW(store->seen, store->seen_nr + 1,
+			   store->seen_alloc);
+		store->seen[store->seen_nr] = cf->do_ftell(cf);
+		store->seen_nr++;
+		store->key_seen = 1;
+		store->section_seen = 1;
+		store->is_keys_section = 1;
+	} else {
+		if (strrchr(key, '.') - key == store->baselen &&
+		      !strncmp(key, store->key, store->baselen)) {
+				store->section_seen = 1;
+				store->is_keys_section = 1;
+				ALLOC_GROW(store->seen,
+					   store->seen_nr + 1,
+					   store->seen_alloc);
+				store->seen[store->seen_nr] =
+					cf->do_ftell(cf);
 		}
 	}
+
 	return 0;
 }
 
@@ -2646,7 +2646,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		ALLOC_GROW(store.seen, 1, store.seen_alloc);
 		store.seen[0] = 0;
-		store.state = START;
 		store.seen_nr = 0;
 
 		/*
@@ -2714,7 +2713,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			new_line = 0;
 			if (store.seen[i] == 0) {
 				store.seen[i] = copy_end = contents_sz;
-			} else if (store.state != KEY_SEEN) {
+			} else if (!store.key_seen) {
 				copy_end = store.seen[i];
 			} else
 				copy_end = find_beginning_of_line(
@@ -2738,7 +2737,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
-			if (store.state == START) {
+			if (!store.section_seen) {
 				if (write_section(fd, key, &store) < 0)
 					goto write_err_out;
 			}
-- 
2.16.2.windows.1.26.g2cc3565eb4b


