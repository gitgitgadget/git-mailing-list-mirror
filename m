Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0561F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeGSSPt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:15:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46209 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732053AbeGSSPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:15:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so8627081ljj.13
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7itVddE3jzG689AUWb4ArwZ/giCZwk8oapfijkU9i0=;
        b=kR9A0SJaNVLCZSTpaZyk7i1jYivEJC1CeQqVJKQjTMb7uKPOW85SeGh9e6JqyReSt3
         +QLn2YnYJlxoi7wKoIDJewjAVTQlI9w/ZVtTnFmEtqRr5UJRvoHj1CODFZhAMZCy3EA1
         snHpdUqVOWaRh2257aDI5peIabqaYfLjDV4+QUWnUyURRezl53v4xwc90zCUn9SbpQru
         EFTleAsOOFu8eJb8FjXt3Iv7XOR6iS0sK77GJlQc7sI7c92gb8NCqz9wjMH227bhWyKU
         AfQ6nBZnOKnwshmHnFyVoNDFd71jSh5ALN5GjrISC5d3RwzZKhpLqGfi5HbR6LYzmbRU
         owPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7itVddE3jzG689AUWb4ArwZ/giCZwk8oapfijkU9i0=;
        b=P0Y22faNfx+9JtiguqSP4+TqA1Mifzvm7t6F0/arvGfJi2H/ZgHnEZ8Ac+cZ5HglSy
         uSSXVvJJ9q/gXFOPElONAGFdiZBw57JwyVvioEq92zHn5VtPUZvxgJ+YK3oFJnoJZE2Q
         FN3NSJuBV49FZqr6bT5JKaaB9RKTCmqUW9mEMhKHujhV98EFUsBomGZzB1Ykk7KTdJNO
         GBELeWhts3kLWZD8b32C9Ieemt4fpH7M1joLJETdLmyzbGql2Fniez2/KMfm1p88/7V4
         oFmmg/GLxB65imJ9d02TR/twWx+lfrV0vGpbLDLKEVO6Ax0LhvCYrQnnXki9ybF9k70X
         mdcg==
X-Gm-Message-State: AOUpUlEhfRlUp6vNN2WNMwN14+lkUw++GvOColVyL+aeP0JhgBMARv2/
        71uzXRkqPpUxELzRqNYlom8=
X-Google-Smtp-Source: AAOMgpfSH4mFZpnnJ8E4xPMSg/LSUd9G2VyibG7u+It77uF/Q+LKPh8dtg6CNU8p41ZhV19y2B5KHg==
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr6849011lff.11.1532021498332;
        Thu, 19 Jul 2018 10:31:38 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t15-v6sm392154ljh.21.2018.07.19.10.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:31:37 -0700 (PDT)
Date:   Thu, 19 Jul 2018 19:31:35 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
Message-ID: <20180719173135.GA24563@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com>
 <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home>
 <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719172358.GD4868@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 01:23:58PM -0400, Jeff King wrote:
> On Thu, Jul 19, 2018 at 09:42:00AM -0700, Elijah Newren wrote:
> 
> > Thanks for the quick turnaround.  Unfortunately, I have some bad news.
> > With this patch, I get the following:
> > 
> > $ /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
> > Enumerating objects: 4460703, done.
> > Counting objects: 100% (4460703/4460703), done.
> > Delta compression using up to 40 threads.
> > Compressing objects: 100% (3807140/3807140), done.
> > Writing objects: 100% (4460703/4460703), done.
> > Total 4460703 (delta 2831383), reused 1587071 (delta 0)
> > error: failed to unpack compressed delta at offset 183854150 from
> > .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack
> > fatal: packed object 20ce811e53dabbb8ef9368c108cbbdfa65639c03 (stored
> > in .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack)
> > is corrupt
> > error: failed to run prune
> > MaxRSS:40025196 Time:2531.52
> 
> Looking at that output, my _guess_ is that we somehow end up with a
> bogus delta_size value and write out a truncated entry. But I couldn't
> reproduce the issue with smaller test cases.

Could it be a race condition? I ran the whole test suite with this
fallback code activated (by forcing the delta size limit down to two
bytes) and nothing failed. Perhaps something like this on top? I'll
need to see if helgrind could spot anything...

-- 8< --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7f3546057d..1eccbc91d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2054,7 +2054,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 
 	SET_DELTA(trg_entry, src_entry);
+
+	/*
+	 * Locking is needed because SET_DELTA_SIZE() internally call
+	 * oe_prepare_delta_size_array() which may touch other entries,
+	 * which are updated in parallel.
+	 */
+	cache_lock();
 	SET_DELTA_SIZE(trg_entry, delta_size);
+	cache_unlock();
+
 	trg->depth = src->depth + 1;
 
 	return 1;
diff --git a/pack-objects.c b/pack-objects.c
index 89699cf15c..9e52af32c3 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -185,13 +185,16 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 void oe_prepare_delta_size_array(struct packing_data *pack)
 {
 	uint32_t i;
+	uint32_t *delta_size;
 
 	/*
 	 * nr_alloc, not nr_objects to align with realloc() strategy in
 	 * packlist_alloc()
 	 */
-	ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+	ALLOC_ARRAY(delta_size, pack->nr_alloc);
 
 	for (i = 0; i < pack->nr_objects; i++)
-		pack->delta_size[i] = pack->objects[i].delta_size_;
+		delta_size[i] = pack->objects[i].delta_size_;
+
+	pack->delta_size = delta_size;
 }
-- 8< --

Elijah, another thing you could try (if you have plenty of time to
spare) is run this repack with a single thread. It's going to take
forever though...

--
Duy
