Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386201F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDIIcU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:43059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbeDIIcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lu7ty-1eOB4h0oCs-011TNR; Mon, 09
 Apr 2018 10:32:09 +0200
Date:   Mon, 9 Apr 2018 10:32:09 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 10/15] config: avoid using the global variable `store`
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <8ba9842d8eee51b6dac772292eefef2c4c36952e.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GmjcpYP1Gj++XRJYpdMS9foiohCMdV6KS0jvjQTnDkn6PffELLA
 KxeDJ/u0mGyabvtb1sYIrb7OE+7G+nIUVNH5XR08guD5OC/Yegv6//yg+1ctStERMwXPwXZ
 bCXgsYl8b0NjyGR2FRs68vQMK+GLT8OIcXUuNBfxqFYaVtuwDjJmq028XFpWzMlk9Yp80UI
 5PwWLHx/24uryE+8upMOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U332gzenMc4=:w63rW4RCOfYtMxrRiEES3Q
 xr9VxZtzh22b3lNlEYiqkRInFnO4y+XQIDS+zsQBtjGcKhi9bSqWgODRHcnIOb35rp9yqSYC5
 sg4zHD5zfm3QaDrOgAZmwNfWGmYjKBLoLc3l5XtZ+dkyADCiJvHaWhfBHaxnc4pL9G/WbB5ah
 wgmrRyznTzxujlt7BV9lYtLCYD7PYWFJyaN3Jq7gAOBejCzglijwNqHBVxrMjvntIXt3sSZPF
 ySGZavxfwa4xz08vpZpmM4pygmxYY1mMq6VfimQtAIwd2EI60kCTryQZHDwqAVn7/E/U3E77j
 9zcCwEONvCKc4u8VloKXjYcAeh7EKk43LiVm6H+XrZ84jT8j+/xouHid9GtjhsLamumejCfK1
 qyvH9bDpt9ru45SSeIS5F4vSvrcIGXiBWntgMCBwCMkO83R4zXx7CvzSH1G8v8bhcg5nqhSf2
 kN9R9HRMYcnDBcPQrnInYrwDjNE6zXp4QqFo5ZaIstP4aP7BFFNhS7tsx9OU3ThXJKDUv/BTv
 Sejm/Z9iBxCVXixbEpbYWHJCaN+N/d7CVIq6UPu3fSM5OP/EP4KG+GhbjdupmnvrjyTOdlx53
 7lA3VHnRTS9kSXBfK9FL7H3gpVztCFf4C22Jioqowpwgbrg97W1IwWk3OwCER+nkFRb+qIWsp
 lCJYvobrcba1hF6FD30yNdXbmrxQyVHKNM7AyDXUp7vdIXILTOFOZ0g62lqAY4bbxeOlCpSUZ
 G0+3Q5MjV19COq2+QMQP6PRyW7MeXp6licv3hCYh/hGIP/IYH6q1ql5g9VVojOmiHSvX73KKU
 1KiFEuHVMNVRLUcwDObU5b6wACAGqlF8MSPlvsVDfFQjghIzgU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is much easier to reason about, when the config code to set/unset
variables or to remove/rename sections does not rely on a global (or
file-local) variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 119 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/config.c b/config.c
index 03d8e7709fe..0c0a965267d 100644
--- a/config.c
+++ b/config.c
@@ -2296,7 +2296,7 @@ void git_die_config(const char *key, const char *err, ...)
  * Find all the stuff for git_config_set() below.
  */
 
-static struct {
+struct config_store_data {
 	int baselen;
 	char *key;
 	int do_not_match;
@@ -2306,56 +2306,58 @@ static struct {
 	unsigned int offset_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	unsigned int seen;
-} store;
+};
 
-static int matches(const char *key, const char *value)
+static int matches(const char *key, const char *value,
+		   const struct config_store_data *store)
 {
-	if (strcmp(key, store.key))
+	if (strcmp(key, store->key))
 		return 0; /* not ours */
-	if (!store.value_regex)
+	if (!store->value_regex)
 		return 1; /* always matches */
-	if (store.value_regex == CONFIG_REGEX_NONE)
+	if (store->value_regex == CONFIG_REGEX_NONE)
 		return 0; /* never matches */
 
-	return store.do_not_match ^
-		(value && !regexec(store.value_regex, value, 0, NULL, 0));
+	return store->do_not_match ^
+		(value && !regexec(store->value_regex, value, 0, NULL, 0));
 }
 
 static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
+	struct config_store_data *store = cb;
 
-	switch (store.state) {
+	switch (store->state) {
 	case KEY_SEEN:
-		if (matches(key, value)) {
-			if (store.seen == 1 && store.multi_replace == 0) {
+		if (matches(key, value, store)) {
+			if (store->seen == 1 && store->multi_replace == 0) {
 				warning(_("%s has multiple values"), key);
 			}
 
-			ALLOC_GROW(store.offset, store.seen + 1,
-				   store.offset_alloc);
+			ALLOC_GROW(store->offset, store->seen + 1,
+				   store->offset_alloc);
 
-			store.offset[store.seen] = cf->do_ftell(cf);
-			store.seen++;
+			store->offset[store->seen] = cf->do_ftell(cf);
+			store->seen++;
 		}
 		break;
 	case SECTION_SEEN:
 		/*
-		 * What we are looking for is in store.key (both
+		 * What we are looking for is in store->key (both
 		 * section and var), and its section part is baselen
 		 * long.  We found key (again, both section and var).
 		 * We would want to know if this key is in the same
 		 * section as what we are looking for.  We already
 		 * know we are in the same section as what should
-		 * hold store.key.
+		 * hold store->key.
 		 */
 		ep = strrchr(key, '.');
 		section_len = ep - key;
 
-		if ((section_len != store.baselen) ||
-		    memcmp(key, store.key, section_len+1)) {
-			store.state = SECTION_END_SEEN;
+		if ((section_len != store->baselen) ||
+		    memcmp(key, store->key, section_len+1)) {
+			store->state = SECTION_END_SEEN;
 			break;
 		}
 
@@ -2363,26 +2365,27 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
-		ALLOC_GROW(store.offset, store.seen + 1,
-			   store.offset_alloc);
-		store.offset[store.seen] = cf->do_ftell(cf);
+		ALLOC_GROW(store->offset, store->seen + 1,
+			   store->offset_alloc);
+		store->offset[store->seen] = cf->do_ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
-		if (matches(key, value)) {
-			ALLOC_GROW(store.offset, store.seen + 1,
-				   store.offset_alloc);
-			store.offset[store.seen] = cf->do_ftell(cf);
-			store.state = KEY_SEEN;
-			store.seen++;
+		if (matches(key, value, store)) {
+			ALLOC_GROW(store->offset, store->seen + 1,
+				   store->offset_alloc);
+			store->offset[store->seen] = cf->do_ftell(cf);
+			store->state = KEY_SEEN;
+			store->seen++;
 		} else {
-			if (strrchr(key, '.') - key == store.baselen &&
-			      !strncmp(key, store.key, store.baselen)) {
-					store.state = SECTION_SEEN;
-					ALLOC_GROW(store.offset,
-						   store.seen + 1,
-						   store.offset_alloc);
-					store.offset[store.seen] = cf->do_ftell(cf);
+			if (strrchr(key, '.') - key == store->baselen &&
+			      !strncmp(key, store->key, store->baselen)) {
+					store->state = SECTION_SEEN;
+					ALLOC_GROW(store->offset,
+						   store->seen + 1,
+						   store->offset_alloc);
+					store->offset[store->seen] =
+						cf->do_ftell(cf);
 			}
 		}
 	}
@@ -2397,31 +2400,33 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static struct strbuf store_create_section(const char *key)
+static struct strbuf store_create_section(const char *key,
+					  const struct config_store_data *store)
 {
 	const char *dot;
 	int i;
 	struct strbuf sb = STRBUF_INIT;
 
-	dot = memchr(key, '.', store.baselen);
+	dot = memchr(key, '.', store->baselen);
 	if (dot) {
 		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
-		for (i = dot - key + 1; i < store.baselen; i++) {
+		for (i = dot - key + 1; i < store->baselen; i++) {
 			if (key[i] == '"' || key[i] == '\\')
 				strbuf_addch(&sb, '\\');
 			strbuf_addch(&sb, key[i]);
 		}
 		strbuf_addstr(&sb, "\"]\n");
 	} else {
-		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
+		strbuf_addf(&sb, "[%.*s]\n", store->baselen, key);
 	}
 
 	return sb;
 }
 
-static ssize_t write_section(int fd, const char *key)
+static ssize_t write_section(int fd, const char *key,
+			     const struct config_store_data *store)
 {
-	struct strbuf sb = store_create_section(key);
+	struct strbuf sb = store_create_section(key, store);
 	ssize_t ret;
 
 	ret = write_in_full(fd, sb.buf, sb.len);
@@ -2430,11 +2435,12 @@ static ssize_t write_section(int fd, const char *key)
 	return ret;
 }
 
-static ssize_t write_pair(int fd, const char *key, const char *value)
+static ssize_t write_pair(int fd, const char *key, const char *value,
+			  const struct config_store_data *store)
 {
 	int i;
 	ssize_t ret;
-	int length = strlen(key + store.baselen + 1);
+	int length = strlen(key + store->baselen + 1);
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2454,7 +2460,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
 		quote = "\"";
 
 	strbuf_addf(&sb, "\t%.*s = %s",
-		    length, key + store.baselen + 1, quote);
+		    length, key + store->baselen + 1, quote);
 
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
@@ -2564,6 +2570,9 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	char *filename_buf = NULL;
 	char *contents = NULL;
 	size_t contents_sz;
+	struct config_store_data store;
+
+	memset(&store, 0, sizeof(store));
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
@@ -2606,8 +2615,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		store.key = (char *)key;
-		if (write_section(fd, key) < 0 ||
-		    write_pair(fd, key, value) < 0)
+		if (write_section(fd, key, &store) < 0 ||
+		    write_pair(fd, key, value, &store) < 0)
 			goto write_err_out;
 	} else {
 		struct stat st;
@@ -2646,7 +2655,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, NULL)) {
+		if (git_config_from_file(store_aux, config_filename, &store)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL &&
@@ -2730,10 +2739,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		/* write the pair (value == NULL means unset) */
 		if (value != NULL) {
 			if (store.state == START) {
-				if (write_section(fd, key) < 0)
+				if (write_section(fd, key, &store) < 0)
 					goto write_err_out;
 			}
-			if (write_pair(fd, key, value) < 0)
+			if (write_pair(fd, key, value, &store) < 0)
 				goto write_err_out;
 		}
 
@@ -2857,7 +2866,8 @@ static int section_name_is_ok(const char *name)
 
 /* if new_name == NULL, the section is removed instead */
 static int git_config_copy_or_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name, int copy)
+				      const char *old_name,
+				      const char *new_name, int copy)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
@@ -2867,6 +2877,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	FILE *config_file = NULL;
 	struct stat st;
 	struct strbuf copystr = STRBUF_INIT;
+	struct config_store_data store;
+
+	memset(&store, 0, sizeof(store));
 
 	if (new_name && !section_name_is_ok(new_name)) {
 		ret = error("invalid section name: %s", new_name);
@@ -2936,7 +2949,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 				}
 				store.baselen = strlen(new_name);
 				if (!copy) {
-					if (write_section(out_fd, new_name) < 0) {
+					if (write_section(out_fd, new_name, &store) < 0) {
 						ret = write_error(get_lock_file_path(&lock));
 						goto out;
 					}
@@ -2957,7 +2970,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 						output[0] = '\t';
 					}
 				} else {
-					copystr = store_create_section(new_name);
+					copystr = store_create_section(new_name, &store);
 				}
 			}
 			remove = 0;
-- 
2.17.0.windows.1.4.g7e4058d72e3


