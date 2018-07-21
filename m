Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7592C1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 04:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeGUFie (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 01:38:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43204 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeGUFie (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 01:38:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so12699416ljg.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCfYnoy/hPxqyI1eRDQLPaNHEgBY2UNqh6s9IqiTGd8=;
        b=gC4ZCVCRQH3keLDeJpx7IyXNVDb4stbmMXgbxCbi1XAOB+Xm3LYvosS+Isr/3qpsFl
         /D4DBkPD6O3etuKVhETKCDNp5wKrbfiyWJ1lZM8zj/oUwEUFHvU/FvUAbGDQmThDgczA
         +D/EBvfdDDKfELWH3QDBDxPrcpwJCGU4MPUSjaBBK/7E+VKZeTRtIkQf7P1ZatWKWZqW
         0GnlGEPFpAD1OKUocS3K3qgjf7WNX0NvHsg53BbZfJDyD99Jn8o72urJEtRzcSaLL/JK
         RrYh0F8sYcmlnKmORIU7Wy9WbLcjeDz8jcFFAwJCGqLSu3TZty2XIhZ7Mvol6ITxuvlQ
         DDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCfYnoy/hPxqyI1eRDQLPaNHEgBY2UNqh6s9IqiTGd8=;
        b=l2R+gAav7K0MaB3ZjNdjzP3BFp0YkA7dC/VLvmFyC5GFXFPKidfd2oyzryBCvhnNvG
         WvICpcs1sLdDdTs8FnlOR9E74p6KZxxS9tJdi4uMDwX75FQs0w3bVxNZ/dgzqEuhkQ8O
         TNWGLOFikHIPQNvFt3Wng6oNQd040crBK1jGJqXButBADVFl3RJHx/Jvjqkiqe0FSzZg
         Ca4XE7kO1Zk2KmTVT86M3QLYvba2SO59FdTm9f3r1dO/fQHfnp1q5gMRfSdq1ojMkQ7O
         kjq9rFQW/1RlHyiS5J0+q7Rr4VDZbBC2YyWX24v0Wvaub4NCT2htCus9QjL9LSmI0TFV
         vIVg==
X-Gm-Message-State: AOUpUlGGOKgvTwbveLOMRSzEY/y1HU+1F3/b5HcnXm6iJv/kCx52hX7Q
        pl8D6a+n24s9/1/+4UY/Pmc=
X-Google-Smtp-Source: AAOMgpebb5aVktVUxKuQNmR0KKku1zZdfLVDB7iy0vE8hWSYc5B7/dgH8xqicA/qT9isMOMFqs1jHA==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr3030736ljc.29.1532148434375;
        Fri, 20 Jul 2018 21:47:14 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i125-v6sm550793lfg.25.2018.07.20.21.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 21:47:13 -0700 (PDT)
Date:   Sat, 21 Jul 2018 06:47:11 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large
 deltas
Message-ID: <20180721044711.GA31376@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 10:43:25AM -0700, Elijah Newren wrote:
> > This patch provides a better fallback that is
> >
> > - cheaper in terms of cpu and io because we won't have to read
> >   existing pack files as much
> >
> > - better in terms of pack size because the pack heuristics is back to
> >   2.17.0 time, we do not drop large deltas at all
> >
> > If we encounter any delta (on-disk or created during try_delta phase)
> > that is larger than the 2MB limit, we stop using delta_size_ field for
> > this because it can't contain such size anyway. A new array of delta
> > size is dynamically allocated and can hold all the deltas that 2.17.0
> > can [1]. All current delta sizes are migrated over.
> >
> > With this, we do not have to drop deltas in try_delta() anymore. Of
> > course the downside is we use slightly more memory, even compared to
> > 2.17.0. But since this is considered an uncommon case, a bit more
> > memory consumption should not be a problem.
> 
> Out of curiosity, would it be possible to use the delta_size_ field
> for deltas that are small enough, and only use an external data
> structure (perhaps a hash rather than an array) for the few deltas
> that are large?

We could. And because repack time is still a bit higher in your
linux.git case. Let's try this. No locking in common case and very
small locked region when we hit large deltas

-- 8< --
diff --git a/pack-objects.c b/pack-objects.c
index eef344b7c1..e3c32bbfc2 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -88,23 +88,6 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	return &pdata->objects[pdata->index[i] - 1];
 }
 
-uint32_t *new_delta_size_array(struct packing_data *pack)
-{
-	uint32_t *delta_size;
-	uint32_t i;
-
-	/*
-	 * nr_alloc, not nr_objects to align with realloc() strategy in
-	 * packlist_alloc()
-	 */
-	ALLOC_ARRAY(delta_size, pack->nr_alloc);
-
-	for (i = 0; i < pack->nr_objects; i++)
-		delta_size[i] = pack->objects[i].delta_size_;
-
-	return delta_size;
-}
-
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
 	struct packed_git **mapping, *p;
diff --git a/pack-objects.h b/pack-objects.h
index 9f977ae800..11890e7217 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -15,7 +15,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	24
+#define OE_DELTA_SIZE_BITS	23
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -94,6 +94,7 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
+	unsigned delta_size_valid:1;
 	unsigned char in_pack_header_size;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
@@ -353,37 +354,26 @@ static inline void oe_set_size(struct packing_data *pack,
 static inline unsigned long oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)
 {
-	unsigned long size;
-
-	packing_data_lock(pack);
-	if (pack->delta_size)
-		size = pack->delta_size[e - pack->objects];
+	if (e->delta_size_valid)
+		return e->delta_size_;
 	else
-		size = e->delta_size_;
-	packing_data_unlock(pack);
-	return size;
+		return pack->delta_size[e - pack->objects];
 }
 
-uint32_t *new_delta_size_array(struct packing_data *pdata);
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
 				     unsigned long size)
 {
-	packing_data_lock(pack);
-	if (!pack->delta_size && size < pack->oe_delta_size_limit) {
-		packing_data_unlock(pack);
+	if (size < pack->oe_delta_size_limit) {
 		e->delta_size_ = size;
-		return;
+		e->delta_size_valid = 1;
+	} else {
+		packing_data_lock(pack);
+		if (!pack->delta_size)
+			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+		packing_data_unlock(pack);
+		pack->delta_size[e - pack->objects] = size;
 	}
-	/*
-	 * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
-	 * limit. delta_size_ will not be used anymore. All delta sizes are
-	 * now from the delta_size[] array.
-	 */
-	if (!pack->delta_size)
-		pack->delta_size = new_delta_size_array(pack);
-	pack->delta_size[e - pack->objects] = size;
-	packing_data_unlock(pack);
 }
 
 #endif
-- 8< --

> > --
> > 2.18.0.rc2.476.g39500d3211
> 
> Missing the 2.18.0 tag?  ;-)

Hehe I was a bit busy lately and have not rebased my branch on the
latest and greatest version.
--
Duy
