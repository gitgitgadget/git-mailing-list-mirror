Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3D81F464
	for <e@80x24.org>; Wed, 25 Sep 2019 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406300AbfIYNPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:15:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33284 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfIYNPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:15:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so6482034qtd.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5vxC4t4kU0NMbOs2k28rc9f3JagSLUFuXbn4XpU0evI=;
        b=PiGauGsNIfbTcv3YO+t0n9AoQuS3dZaAPXqxAYy5Sx4ooa+97cyE6mCpqxNX1V/v3f
         qICRaTZgHAr68CPgjbu5COYOSMf1jH0gQ3wQ0SxQYxiIk1kvA6KwtUxdvVnbPhplnCqO
         YAGBWaIto0TotkRwyOrBheng/KUiagCz0g8koQvSVpsnzUJQq5NhUU58WQ26jsgsroju
         zxeP1bUIkcsQT3z+jtB3O+74/8iawRj7vKsp6sFlWhAObAxDh9iggGuGAs8vsnsToVSN
         TNcdfsYaHTh3nSQh9epje6onpHLIfzS0O0CpFm88I+kN6wx5LmSIuNNR8O0VOwKR5+JV
         ra1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5vxC4t4kU0NMbOs2k28rc9f3JagSLUFuXbn4XpU0evI=;
        b=O0INfidLkaAacrTPA6NkH+RvFrOaDB7NCIYNRD0rgcJ5IPB3hGw9WR5H/zaZhF1K1U
         3w22i5Qih3GZfKZoDkqjsoy9Q0TDhErVrrDk1+nPnL3SLXPU2RUe8c15D93nRb9hxyQ0
         K+XeCvHlXjXtt1n9MnpEI6f1RRnr65RQRPDWNFLuKtsQDclSkCxzCu5L8HTrpweqPTlu
         vFtIa7sYsoZMzymbich22M838+ot2Ii08/ILSVt5/fLppNWp0rfh8jvus86PeF5p38pV
         e6nDhgYmuYPSt/qyHBCbezgfcK16Xs4Jc8CNn29Gtf7q7GeMSafb5kMOoIXA9YKqkZXR
         7Lpg==
X-Gm-Message-State: APjAAAUkNAfy8+EyvRzcgMX/0OIbwmCLP5wO1wvW9ZnoO9z+/2pMTcuf
        OPOdQVtOP+9IYPF1b5d6dXJaMTC9KsY=
X-Google-Smtp-Source: APXvYqz1ROeBqJv4t4CKj0UeYu3Xmsw1Ee1P1Tg1zn2215BQ446KcVVxHi4VEdEH6Rfj4yfb2CrWmw==
X-Received: by 2002:ac8:7019:: with SMTP id x25mr8952921qtm.133.1569417330180;
        Wed, 25 Sep 2019 06:15:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id k2sm3134962qti.24.2019.09.25.06.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:15:29 -0700 (PDT)
Subject: Re: [PATCH v2 12/19] hashmap: use *_entry APIs to wrap container_of
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-13-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <610f3f40-ebff-c2e5-a210-ef3628193e81@gmail.com>
Date:   Wed, 25 Sep 2019 09:15:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-13-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> Using `container_of' can be verbose and choosing names for
> intermediate "struct hashmap_entry" pointers is a hard problem.
> So introduce "*_entry" APIs inspired by similar linked-list
> APIs in the Linux kernel.
> 
> Unfortunately, `__typeof__' is not portable C, so we need an
> extra parameter to specify the type.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  diff.c                  | 21 +++++++++------------
>  diffcore-rename.c       | 14 +++++---------
>  git-compat-util.h       | 16 ++++++++++++++++
>  hashmap.h               | 40 ++++++++++++++++++++++++++++++++++------
>  name-hash.c             | 11 +++++------
>  t/helper/test-hashmap.c | 12 +++++-------
>  6 files changed, 74 insertions(+), 40 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 663b5d01f8..66cdf4e9ca 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1035,10 +1035,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>  {
>  	int i;
>  	char *got_match = xcalloc(1, pmb_nr);
> -	struct hashmap_entry *ent = &match->ent;
>  
> -	for (; ent; ent = hashmap_get_next(hm, ent)) {
> -		match = container_of(ent, struct moved_entry, ent);
> +	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {

Of course, my recommendation for using the initializer in the for(;;)
is undone here, anyway.

However, how does this work? Let's investigate the macro.

> +/*
> + * iterate @map starting from @var, where @var is a pointer of @type
> + * and @member is the name of the "struct hashmap_entry" field in @type
> + */
> +#define hashmap_for_each_entry_from(map, var, type, member) \
> +	for (; \
> +		var; \
> +		var = hashmap_get_next_entry(map, var, type, member))
> +

When reading this patch immediately after the previous change to use "ent"
as the iteration variable, I was confused as to which entry was used for "var".
The expansion of this macro more closely resembles the code without the
previous patch.

In fact, after pulling your code, I think the diff for PATCHes 10 & 11
together is cleaner than looking at the two together. I include that
diff below.

Thanks,
-Stolee

---
diff --git a/diff.c b/diff.c
index 72d3c6aa19..66cdf4e9ca 100644
--- a/diff.c
+++ b/diff.c
@@ -1036,7 +1036,7 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
 
-	for (; match; match = hashmap_get_next(hm, &match->ent)) {
+	hashmap_for_each_entry_from(hm, match, struct moved_entry, ent) {
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1144,13 +1144,15 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, &key->ent, NULL);
+			match = hashmap_get_entry(hm, key, NULL,
+						struct moved_entry, ent);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, &key->ent, NULL);
+			match = hashmap_get_entry(hm, key, NULL,
+						struct moved_entry, ent);
 			free(key);
 			break;
 		default:
@@ -1189,8 +1191,8 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			for (; match; match = hashmap_get_next(hm,
-								&match->ent)) {
+			hashmap_for_each_entry_from(hm, match,
+						struct moved_entry, ent) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 4670a40179..611b08f463 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -274,18 +274,17 @@ static int find_identical_files(struct hashmap *srcs,
 				struct diff_options *options)
 {
 	int renames = 0;
-
 	struct diff_filespec *target = rename_dst[dst_index].two;
 	struct file_similarity *p, *best = NULL;
 	int i = 100, best_score = -1;
+	unsigned int hash = hash_filespec(options->repo, target);
 
 	/*
 	 * Find the best source match for specified destination.
 	 */
-	p = hashmap_get_from_hash(srcs,
-				  hash_filespec(options->repo, target),
-				  NULL);
-	for (; p; p = hashmap_get_next(srcs, &p->entry)) {
+	p = hashmap_get_entry_from_hash(srcs, hash, NULL,
+					struct file_similarity, entry);
+	hashmap_for_each_entry_from(srcs, p, struct file_similarity, entry) {
 		int score;
 		struct diff_filespec *source = p->filespec;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 4cc2c8283a..e24510452a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1322,4 +1322,20 @@ void unleak_memory(const void *ptr, size_t len);
 #define container_of(ptr, type, member) \
 	((type *) ((char *)(ptr) - offsetof(type, member)))
 
+
+/*
+ * helper function for `container_of_or_null' to avoid multiple
+ * evaluation of @ptr
+ */
+static inline void *container_of_or_null_offset(void *ptr, size_t offset)
+{
+	return ptr ? (char *)ptr - offset : NULL;
+}
+
+/*
+ * like `container_of', but allows returned value to be NULL
+ */
+#define container_of_or_null(ptr, type, member) \
+	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
+
 #endif
diff --git a/hashmap.c b/hashmap.c
index 9b83e73d03..22bc7c5b3b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -192,7 +192,7 @@ void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
 	return *find_entry_ptr(map, key, keydata);
 }
 
-void *hashmap_get_next(const struct hashmap *map,
+struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
 			const struct hashmap_entry *entry)
 {
 	struct hashmap_entry *e = entry->next;
diff --git a/hashmap.h b/hashmap.h
index cb630447bb..6d5f8685a8 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -59,11 +59,13 @@
  *             k.key = key;
  *
  *             flags &= ~COMPARE_VALUE;
- *             e = hashmap_get(&map, &k, NULL);
+ *             e = hashmap_get_entry(&map, &k, NULL, struct long2string, ent);
  *             if (e) {
  *                 printf("first: %ld %s\n", e->key, e->value);
- *                 while ((e = hashmap_get_next(&map, e)))
+ *                 while ((e = hashmap_get_next_entry(&map, e,
+ *                                              struct long2string, ent))) {
  *                     printf("found more: %ld %s\n", e->key, e->value);
+ *                 }
  *             }
  *         }
  *
@@ -320,7 +322,7 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
  * `entry` is the hashmap_entry to start the search from, obtained via a previous
  * call to `hashmap_get` or `hashmap_get_next`.
  */
-void *hashmap_get_next(const struct hashmap *map,
+struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
 			const struct hashmap_entry *entry);
 
 /*
@@ -383,6 +385,36 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
+/*
+ * returns a @pointer of @type matching @keyvar, or NULL if nothing found.
+ * @keyvar is a pointer of @type
+ * @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_get_entry(map, keyvar, keydata, type, member) \
+	container_of_or_null(hashmap_get(map, &(keyvar)->member, keydata), \
+				type, member)
+
+#define hashmap_get_entry_from_hash(map, hash, keydata, type, member) \
+	container_of_or_null(hashmap_get_from_hash(map, hash, keydata), \
+				type, member)
+/*
+ * returns the next equal @type pointer to @var, or NULL if not found.
+ * @var is a pointer of @type
+ * @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_get_next_entry(map, var, type, member) \
+	container_of_or_null(hashmap_get_next(map, &(var)->member), \
+				type, member)
+
+/*
+ * iterate @map starting from @var, where @var is a pointer of @type
+ * and @member is the name of the "struct hashmap_entry" field in @type
+ */
+#define hashmap_for_each_entry_from(map, var, type, member) \
+	for (; \
+		var; \
+		var = hashmap_get_next_entry(map, var, type, member))
+
 /*
  * Disable item counting and automatic rehashing when adding/removing items.
  *
diff --git a/name-hash.c b/name-hash.c
index 44d788f1ce..73b83adf3d 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -702,15 +702,16 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int icase)
 {
 	struct cache_entry *ce;
+	unsigned int hash = memihash(name, namelen);
 
 	lazy_init_name_hash(istate);
 
-	ce = hashmap_get_from_hash(&istate->name_hash,
-				   memihash(name, namelen), NULL);
-	while (ce) {
+	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
+					 struct cache_entry, ent);
+	hashmap_for_each_entry_from(&istate->name_hash, ce,
+					struct cache_entry, ent) {
 		if (same_name(ce, name, namelen, icase))
 			return ce;
-		ce = hashmap_get_next(&istate->name_hash, &ce->ent);
 	}
 	return NULL;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index de2bd083b9..e82cbfdee2 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -194,16 +194,16 @@ int cmd__hashmap(int argc, const char **argv)
 			free(entry);
 
 		} else if (!strcmp("get", cmd) && p1) {
-
 			/* lookup entry in hashmap */
-			entry = hashmap_get_from_hash(&map, hash, p1);
+			entry = hashmap_get_entry_from_hash(&map, hash, p1,
+							struct test_entry, ent);
 
 			/* print result */
 			if (!entry)
 				puts("NULL");
-			while (entry) {
+			hashmap_for_each_entry_from(&map, entry,
+						struct test_entry, ent) {
 				puts(get_value(entry));
-				entry = hashmap_get_next(&map, &entry->ent);
 			}
 
 		} else if (!strcmp("remove", cmd) && p1) {

