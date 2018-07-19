Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6D51F597
	for <e@80x24.org>; Thu, 19 Jul 2018 15:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbeGSQA0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 12:00:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41762 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbeGSQA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 12:00:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so8066859ljy.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxzNlmbcg7Wq+OgbkjkOty/w8egepFuwvVH5ahwBNf8=;
        b=gGBcueAYn1991yanUsZWcbmVsHywcd3QvYOoqpb0F5iZNWHDdUf9GSiXLpv++tMV4D
         o5c3LpnCTvkXQE2T39KfKqXOhq2yXM+dBdfmPYivin19KdT0daq6AXVpqoaCAhg0W2S+
         6q1legD/ZJXpk1/PHyYQsxMLlHKchfxOH+eTPJnuAmQplLDJBRxAvnSjUhXYz7okSsMf
         H8/te7AeceAso1B5TqGnNmuQ/XDiPAgyLdYrjRQajBrh1TYQQuWPbHIOiyzftwN6IJLs
         jw2dahPehpNYJNHskLgSeAfG59r3MurMLgdWp/fWxNCaYbxY6ai4Pw+8Lyr7ky/k+O57
         B7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxzNlmbcg7Wq+OgbkjkOty/w8egepFuwvVH5ahwBNf8=;
        b=d2gIvpjms0I+Rs0ziiBAu66o0FQ2hzbwqv9nUKOo5sH2FVvDBn8b6eQzevp2kHPL69
         gYOSg6esHRh2lkhvgiAJVqonDMWBVh9ObRJaoe7q9g2aRiKrr9i0aQd+0khHH4j/G34F
         xlIcgMABJO1vBWQJRM0AigzaRtWzomguJKRWcuhJW/X1RfP3lhX1fhrHUqSC8/Oq68vB
         RTDXjKoA3j5Q3fc4NaJ4O/UVImzdJoh1tP8jxiwmmFGbS8iQ4A6ijnltz2YhtkqI4BQd
         GxRFHb6dw1eCiwMH2WlGIJIBn5LR/WPrAxmUq95FbRuDVQRKz4fKCBd0/WEqswr30LIc
         7jQg==
X-Gm-Message-State: AOUpUlHKRV6HURPL859U2pLxS5ksl4NBcEBZmSHCBRXCA3xkvWSPvMPJ
        UDsYAyn73fVikTB4Gw8q/Bg=
X-Google-Smtp-Source: AAOMgpeFoju35YLVSmhOVa7J9YG6S6KRtWnSN3601GlBR/hmUR+/4eROrR6OnzV+xQmQ2M/KOoGZnQ==
X-Received: by 2002:a2e:4055:: with SMTP id n82-v6mr7238992lja.99.1532013406003;
        Thu, 19 Jul 2018 08:16:46 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f3-v6sm991060lfa.21.2018.07.19.08.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:16:45 -0700 (PDT)
Date:   Thu, 19 Jul 2018 17:16:42 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719151640.GA24997@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 07:57:37AM +0200, Duy Nguyen wrote:
> I thought 2M was generous but I was obviously wrong. I'd like to see
> the biggest delta size in this pack and whether it's still reasonable
> to increase OE_DELTA_SIZE_BITS. But if it's very close to 4GB limit
> then we could just store 64-bit delta size in a separate array.

I realize now that these two options don't have to be mutually
exclusive and I should provide a good fallback in terms of performance
anyway.

So Elijah, could you try this patch and see if performance and pack
size go back to 1.7.0? I can write proper commit message and test
support later if it proves a good improvement.

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..7f3546057d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2023,10 +2023,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
-		free(delta_buf);
-		return 0;
-	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..191ed45faf 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -160,6 +160,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+		if (pdata->delta_size)
+			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
@@ -177,3 +179,17 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 	return new_entry;
 }
+
+void oe_prepare_delta_size_array(struct packing_data *pack)
+{
+	int i;
+
+	/*
+	 * nr_alloc, not nr_objects to align with realloc() strategy in
+	 * packlist_alloc()
+	 */
+	ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+
+	for (i = 0; i < pack->nr_objects; i++)
+		pack->delta_size[i] = pack->objects[i].delta_size_;
+}
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..978500e474 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,7 +14,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
+#define OE_DELTA_SIZE_BITS	21
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -93,7 +93,6 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
-	unsigned delta_size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
@@ -130,6 +129,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	unsigned long *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
@@ -330,20 +330,27 @@ static inline void oe_set_size(struct packing_data *pack,
 static inline unsigned long oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)
 {
-	if (e->delta_size_valid)
+	if (!pack->delta_size)
 		return e->delta_size_;
-	return oe_size(pack, e);
+	return pack->delta_size[e - pack->objects];
 }
 
+void oe_prepare_delta_size_array(struct packing_data *pack);
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
 				     unsigned long size)
 {
 	e->delta_size_ = size;
-	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(pack, e))
-		BUG("this can only happen in check_object() "
-		    "where delta size is the same as entry size");
+	if (!pack->delta_size && e->delta_size_ == size)
+		return;
+	/*
+	 * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
+	 * limit. delta_size_ will not be used anymore. All delta sizes are now
+	 * from the delta_size[] array.
+	 */
+	if (!pack->delta_size)
+		oe_prepare_delta_size_array(pack);
+	pack->delta_size[e - pack->objects] = size;
 }
 
 #endif
-- 8< --


--
Duy
