Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54FB1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeDCQ2q (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:40405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeDCQ2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:45 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LjZhg-1eWFq70cSe-00bazz; Tue, 03 Apr 2018 18:28:35 +0200
Date:   Tue, 3 Apr 2018 18:28:34 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 09/15] config: avoid using the global variable `store`
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <a9689c880f9226c236aec58f8036740ff39efbb8.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GHB1veH9kQ5euRkDs6RN1bxD/1scQ1AoWqt6B87iRIuj1dMGzA5
 BIkcx/KslmXNx/6iEnE2TCgKydDeUseLKNZTw61qPIlzOUp7rbBrUJptsz3SkSmUTwBcP60
 NJ7Sgflfq1VLqKKYvmkAX1SKZY9VFJtWfV86XJR7pGE27B96/p2rLag969U5W0VVCAASqrd
 1J3W7kUdWcPZJtUwVG0oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EyzWKgLors8=:07fe0suWP/Kl7UKAd0GfIG
 S8UC1WXq6iTyjWjIbnPlWK6hC2krLPkDJCfT7kCJpu0oIGH44rK0YlZNeRRoNmkd3T9Envm18
 a0Q95Jaxrwa/EyN7o58SJwtruQDT3NksyTTZgNLyaiYi6osgtW13MdQj/MtNrfVu/8b4QX02F
 h9dSRVvw/yDpfaQhEMoj4v0fqOXrPbgN7RfVeV21XP617KD1qeQWS70aAQBamq+xlZWEsx/X8
 f29R+ygZBdtnibubZihXCQ5c5xJl5DAS4BZR4rQRsiHs0hTPbJtig8bSd5YEtvoB/XxqRL0df
 WnA/SrcgfM7mJSFKogAvmRS3ueFb42evIQ966U6qhrmtRFDocAz0DrfSJnNXZS4oVk4Z7iLmU
 ObprmAKUqACQAX1oUJTKTMR/BMLQWR5SRHs8eDHpnuBnCHMYU37PuaU90HSb+USlb/hw8mVJ/
 9y418//UebvyCYxrjLy+x73ctVjAfgWGSHAM39fAH8NE77OSOnkAvAxic3nmlm4Uuw3xVcOng
 VzrqHHQZxY7uxxRmk1+xd2pKnOCaOzeP0lU+x/xSxbvE0nJrltQBh3tS3O9j6M7bk7Q7P4j2B
 5xKUfXNwxatxNRlgHHh1vARlFHWrE29vBr9JpisBaE0BeNpB1HJaMyVTJU4v60ao9RLbs3MVd
 afmZoUDlc1Uc7tQXF/J5t2xcAWas+o5fNV2zyGgfN9Eo+IIRn57xau0uzxhw1yfu/BdqvOFoX
 s0m7UJsQ7X6Zf/in05XS62LNLcSUhj1wmT0Lt2ufbPl4wW04OL575xm1++PrLq0082RRdQEPs
 rXPPwxiFD1IUexWhI0EKXsux1KrDal3N98cwYPFq9EYwU+z5Ma2NcToSKX9WX7fsmYLwKtZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is much easier to reason about, when the config code to set/unset
variables or to remove/rename sections does not rely on a global (or
file-local) variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 119 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/config.c b/config.c
index 4cd745f6628..90ae71cb905 100644
--- a/config.c
+++ b/config.c
@@ -2297,7 +2297,7 @@ void git_die_config(const char *key, const char *err, ...)
  * Find all the stuff for git_config_set() below.
  */
 
-static struct {
+struct config_set_store {
 	int baselen;
 	char *key;
 	int do_not_match;
@@ -2307,56 +2307,58 @@ static struct {
 	unsigned int offset_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	unsigned int seen;
-} store;
+};
 
-static int matches(const char *key, const char *value)
+static int matches(const char *key, const char *value,
+		   const struct config_set_store *store)
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
+	struct config_set_store *store = cb;
 
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
 
@@ -2364,26 +2366,27 @@ static int store_aux(const char *key, const char *value, void *cb)
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
@@ -2398,31 +2401,33 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static struct strbuf store_create_section(const char *key)
+static struct strbuf store_create_section(const char *key,
+					  const struct config_set_store *store)
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
+			     const struct config_set_store *store)
 {
-	struct strbuf sb = store_create_section(key);
+	struct strbuf sb = store_create_section(key, store);
 	ssize_t ret;
 
 	ret = write_in_full(fd, sb.buf, sb.len);
@@ -2431,11 +2436,12 @@ static ssize_t write_section(int fd, const char *key)
 	return ret;
 }
 
-static ssize_t write_pair(int fd, const char *key, const char *value)
+static ssize_t write_pair(int fd, const char *key, const char *value,
+			  const struct config_set_store *store)
 {
 	int i;
 	ssize_t ret;
-	int length = strlen(key + store.baselen + 1);
+	int length = strlen(key + store->baselen + 1);
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2455,7 +2461,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
 		quote = "\"";
 
 	strbuf_addf(&sb, "\t%.*s = %s",
-		    length, key + store.baselen + 1, quote);
+		    length, key + store->baselen + 1, quote);
 
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
@@ -2565,6 +2571,9 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	char *filename_buf = NULL;
 	char *contents = NULL;
 	size_t contents_sz;
+	struct config_set_store store;
+
+	memset(&store, 0, sizeof(store));
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
@@ -2607,8 +2616,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 
 		store.key = (char *)key;
-		if (write_section(fd, key) < 0 ||
-		    write_pair(fd, key, value) < 0)
+		if (write_section(fd, key, &store) < 0 ||
+		    write_pair(fd, key, value, &store) < 0)
 			goto write_err_out;
 	} else {
 		struct stat st;
@@ -2647,7 +2656,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, NULL)) {
+		if (git_config_from_file(store_aux, config_filename, &store)) {
 			error("invalid config file %s", config_filename);
 			free(store.key);
 			if (store.value_regex != NULL &&
@@ -2731,10 +2740,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
 
@@ -2858,7 +2867,8 @@ static int section_name_is_ok(const char *name)
 
 /* if new_name == NULL, the section is removed instead */
 static int git_config_copy_or_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name, int copy)
+				      const char *old_name,
+				      const char *new_name, int copy)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
@@ -2868,6 +2878,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	FILE *config_file = NULL;
 	struct stat st;
 	struct strbuf copystr = STRBUF_INIT;
+	struct config_set_store store;
+
+	memset(&store, 0, sizeof(store));
 
 	if (new_name && !section_name_is_ok(new_name)) {
 		ret = error("invalid section name: %s", new_name);
@@ -2937,7 +2950,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 				}
 				store.baselen = strlen(new_name);
 				if (!copy) {
-					if (write_section(out_fd, new_name) < 0) {
+					if (write_section(out_fd, new_name, &store) < 0) {
 						ret = write_error(get_lock_file_path(&lock));
 						goto out;
 					}
@@ -2958,7 +2971,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 						output[0] = '\t';
 					}
 				} else {
-					copystr = store_create_section(new_name);
+					copystr = store_create_section(new_name, &store);
 				}
 			}
 			remove = 0;
-- 
2.16.2.windows.1.26.g2cc3565eb4b


