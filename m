Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480CA1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbeGSTJJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:09:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42262 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSTJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:09:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so7207044ljc.9
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fj0lZGMVopv2H78u9isM3GUri0CGi9ij//V2rJeaHkM=;
        b=KzYqwTjb7Ff2pdbdSUVfSefW51U7JByu5whDJ/ICsCjso3K45HAtE2Bwci7T6orKpk
         2clt1+WDOdxcr3bwV2gKedtOkLQGCbbdkO4o6JymLPh6Yp/4Gc0CpGTWvlnEIANl3WhB
         0In2L79WpjiIhLQXSpPonb+oRl7GX+yqAqLYIV/5R5NYECuoTlmSiw8DjSsysuAKo3ow
         dr8sEvP8lbo5cYWGBVnyvLZMJKqDIyimZF1JLtdGKeNgs8l6vHq7ITI1+b5pFTr/BkHc
         0FJnhF+coYEATj50bp3F+bbhewPG4cGINne29HXqBp1P9tKdGqp+XH8X9gymocVILBzA
         WoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fj0lZGMVopv2H78u9isM3GUri0CGi9ij//V2rJeaHkM=;
        b=Ms59qULYrSCRFnrlWRQWxMfeCYhxM6e75OqBK6zA4xSKqvCYkAF8GFffij3DaDv+qo
         5DAlz/PSDSP7MisgcAkS1avnChptB5K/IkiR6wwePvwvkHSKep8Fs+rZTQMra/byZEkw
         sAR7MDQnnv7m4JFoaiI1X8TfuUBpQf4/vmo5mB6yMS7iP6IkGWHPMtaBWq446RbunfsE
         H4zl3JGdNN3q8lr4iDiqjy/+F380vGi4be9pYoIkvKgEHRNn4OxDdHmrQznKvISyVn9s
         bUc0Ulk5BVoFXCF1cRyRtb+EgtIq3aGUNY0p9hcu/pWtR9W6QA7hKFaDSwVNI4ctpkyI
         NxaQ==
X-Gm-Message-State: AOUpUlFiijc3x0uWSEkoJxtwVzyACdkoq3JDfCT3YWAyfq9wsbdWzfD2
        zZ+ZdmrPGM573Hw+mHgcNLqSFZjc
X-Google-Smtp-Source: AAOMgpfI0OUN5nynekS9q2NDuydTIiZLSVdeauelrcmA9a875zlQD2rWBExEFXTvlOGxOrVKv2CoZA==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr9112802ljk.116.1532024684940;
        Thu, 19 Jul 2018 11:24:44 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 102-v6sm1052193lfu.70.2018.07.19.11.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 11:24:44 -0700 (PDT)
Date:   Thu, 19 Jul 2018 20:24:42 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719182442.GA5796@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net>
 <20180719173135.GA24563@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719173135.GA24563@duynguyen.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 07:31:35PM +0200, Duy Nguyen wrote:
> On Thu, Jul 19, 2018 at 01:23:58PM -0400, Jeff King wrote:
> > On Thu, Jul 19, 2018 at 09:42:00AM -0700, Elijah Newren wrote:
> > 
> > > Thanks for the quick turnaround.  Unfortunately, I have some bad news.
> > > With this patch, I get the following:
> > > 
> > > $ /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
> > > Enumerating objects: 4460703, done.
> > > Counting objects: 100% (4460703/4460703), done.
> > > Delta compression using up to 40 threads.
> > > Compressing objects: 100% (3807140/3807140), done.
> > > Writing objects: 100% (4460703/4460703), done.
> > > Total 4460703 (delta 2831383), reused 1587071 (delta 0)
> > > error: failed to unpack compressed delta at offset 183854150 from
> > > .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack
> > > fatal: packed object 20ce811e53dabbb8ef9368c108cbbdfa65639c03 (stored
> > > in .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack)
> > > is corrupt
> > > error: failed to run prune
> > > MaxRSS:40025196 Time:2531.52
> > 
> > Looking at that output, my _guess_ is that we somehow end up with a
> > bogus delta_size value and write out a truncated entry. But I couldn't
> > reproduce the issue with smaller test cases.
> 
> Could it be a race condition?

I'm convinced my code is racy (between two writes). I created a broken
pack once with 32 threads. Elijah please try again with this new
patch. It should fix this (I only tried repack a few times so far but
will continue)

The race is this

1. Thread one sees a large delta size and NULL delta_size[] array,
   allocates the new array and in the middle of copying old delta
   sizes over.

2. Thread two wants to write a new (large) delta size. It sees that
   delta_size[] is already allocated, it writes the correct size there
   (and truncated one in object_entry->delta_size_)

3. Back to thread one, it now copies the truncated value in
   delta_size_ from step 2 to delta_size[] array, overwriting the good
   value that thread two wrote.

There is also a potential read/write race where a read from
pack_size[] happens when the array is not ready. But I don't think it
can happen with current try_delta() code. I protect it anyway to be
safe.

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..d67997f11c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,6 +32,12 @@
 #include "object-store.h"
 #include "dir.h"
 
+static unsigned long oe_delta_size(struct packing_data *pack,
+				   const struct object_entry *e);
+static void oe_set_delta_size(struct packing_data *pack,
+			      struct object_entry *e,
+			      unsigned long size);
+
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
@@ -1915,6 +1921,51 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	return size;
 }
 
+static unsigned long oe_delta_size(struct packing_data *pack,
+				   const struct object_entry *e)
+{
+	unsigned long size;
+
+	read_lock();	 /* to protect access to pack->delta_size[] */
+	if (pack->delta_size)
+		size = pack->delta_size[e - pack->objects];
+	else
+		size = e->delta_size_;
+	read_unlock();
+	return size;
+}
+
+static void oe_set_delta_size(struct packing_data *pack,
+			      struct object_entry *e,
+			      unsigned long size)
+{
+	read_lock();	 /* to protect access to pack->delta_size[] */
+	if (!pack->delta_size && size < pack->oe_delta_size_limit) {
+		e->delta_size_ = size;
+		read_unlock();
+		return;
+	}
+	/*
+	 * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
+	 * limit. delta_size_ will not be used anymore. All delta sizes are now
+	 * from the delta_size[] array.
+	 */
+	if (!pack->delta_size) {
+		uint32_t i;
+
+		/*
+		 * nr_alloc, not nr_objects to align with realloc() strategy in
+		 * packlist_alloc()
+		 */
+		ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+
+		for (i = 0; i < pack->nr_objects; i++)
+			pack->delta_size[i] = pack->objects[i].delta_size_;
+	}
+	pack->delta_size[e - pack->objects] = size;
+	read_unlock();
+}
+
 static int try_delta(struct unpacked *trg, struct unpacked *src,
 		     unsigned max_depth, unsigned long *mem_usage)
 {
@@ -2023,10 +2074,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
-		free(delta_buf);
-		return 0;
-	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 4b04c75b7f..2a5bff4a1c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -14,6 +14,7 @@ then
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
+	export GIT_TEST_OE_DELTA_SIZE=5
 	make --quiet test
 fi
 
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..e3c32bbfc2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -146,6 +146,8 @@ void prepare_packing_data(struct packing_data *pdata)
 
 	pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE",
 					     1U << OE_SIZE_BITS);
+	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
+						   1U << OE_DELTA_SIZE_BITS);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -160,6 +162,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+		if (pdata->delta_size)
+			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..7477c7b919 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
+#define OE_DELTA_SIZE_BITS	20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -93,12 +93,12 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
-	unsigned delta_size_valid:1;
+	unsigned char in_pack_header_size;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
-	unsigned type_:TYPE_BITS;
 	unsigned no_try_delta:1;
+	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
@@ -108,17 +108,16 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
-	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
 
 	/*
 	 * pahole results on 64-bit linux (gcc and clang)
 	 *
-	 *   size: 80, bit_padding: 20 bits, holes: 8 bits
+	 *   size: 80, bit_padding: 9 bits
 	 *
 	 * and on 32-bit (gcc)
 	 *
-	 *   size: 76, bit_padding: 20 bits, holes: 8 bits
+	 *   size: 76, bit_padding: 9 bits
 	 */
 };
 
@@ -130,6 +129,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	uint32_t *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
@@ -141,6 +141,7 @@ struct packing_data {
 	struct packed_git **in_pack;
 
 	uintmax_t oe_size_limit;
+	uintmax_t oe_delta_size_limit;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
@@ -327,23 +328,4 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
-{
-	if (e->delta_size_valid)
-		return e->delta_size_;
-	return oe_size(pack, e);
-}
-
-static inline void oe_set_delta_size(struct packing_data *pack,
-				     struct object_entry *e,
-				     unsigned long size)
-{
-	e->delta_size_ = size;
-	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(pack, e))
-		BUG("this can only happen in check_object() "
-		    "where delta size is the same as entry size");
-}
-
 #endif
diff --git a/t/README b/t/README
index 8373a27fea..9028b47d92 100644
--- a/t/README
+++ b/t/README
@@ -315,6 +315,10 @@ packs on demand. This normally only happens when the object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
 
+GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
+path where deltas larger than this limit require extra memory
+allocation for bookkeeping.
+
 Naming Tests
 ------------
 
-- 8< --

--
Duy
