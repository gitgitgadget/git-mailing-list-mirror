Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F43C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 02:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiKHCOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 21:14:52 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5E13D68
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 18:14:52 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id l6so6845118ilq.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 18:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WOTXjtxqV+I44RqQSQBtTLYimNl0HOHf94WyB+DzwiA=;
        b=ayFAF5ZM4QuaCxEzTGVcFIQg8UYDpOLuHee7wTFE3b1E0fPxihcZUGtTURgbwItkNx
         9UoTUpYRWU42F1WtD/PXHySNXX6AAeU7ATBp8szjVlx3HKd+DU3XF6NqMjgwvFU1QFdu
         VxqYfOhZMoM5MkHen8dW7ZwEsKxtRcuLW7hODXLE8R841NatHVMsfd7GevHpgBlR9/v9
         ReQHyXJmw07fnSGU1sTtuBcyr3yMobyQdIEkneHV0niZZ+K4+m6RhNQ5GbbZ+3pa0T0s
         TUN7IwkV4dLF/p/TVni/fRLX3DVf3E8tnbY8wsp0oEaaoN4HTT7DeRFHyd885cpZLUBV
         FbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOTXjtxqV+I44RqQSQBtTLYimNl0HOHf94WyB+DzwiA=;
        b=bdYLMNkzx/DSHUKpgZ1fu1Z/05NP2wlT+OawtYThswWHNiR+fWc8JeW32u3UuuJHRk
         pqXZbQpQsP6mhBAANzHu3E0Ukni79fFaKocRLjik8NFFNi7acx8hbbZfdvpXqO+K0tf/
         c/2NU7Dtv4RlnSpp9xLsp0gu/H+yLeq1VV9oVviydRUIKqIgfRj983FIOaldTj8RlswZ
         1yUT5g3K01DeIIFWBUNosPrW/VxsHuvVsHpf3D03wfDrS0CXDT58FOOIh1LRhlsmfvUV
         tm2F+W8gPE7xaGwnATaGHnwLTX7tQ9cg6RYZctEu2Jnq4kv4TrIwz4ttr6mswjVwfWEo
         xS4w==
X-Gm-Message-State: ACrzQf0rwMoHB5uOa2dDJrHr91IntahMeR7KsMV4ODo/cIu+ItB0zSqY
        oz3O4bpWjv6pGBr5dOnXcHs1qg==
X-Google-Smtp-Source: AMsMyM4bwT0DLXV6CG8wlFBu3/gfi0X+pIVjWpQrFkBBTwpoB5d0AdxxcqXA78hfoMGqSs7hddTq7A==
X-Received: by 2002:a05:6e02:13cc:b0:300:2b50:8dbd with SMTP id v12-20020a056e0213cc00b003002b508dbdmr707955ilj.274.1667873691389;
        Mon, 07 Nov 2022 18:14:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z25-20020a027a59000000b003717c1df569sm3281551jad.165.2022.11.07.18.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:14:51 -0800 (PST)
Date:   Mon, 7 Nov 2022 21:14:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 3/3] diff.c: use diff_free_queue()
Message-ID: <Y2m7mmlL1RWkp6m3@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-4-szeder.dev@gmail.com>
 <Y2MKKTz4nK0L8uW5@nand.local>
 <20221107161311.GC1951@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107161311.GC1951@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 05:13:11PM +0100, SZEDER Gábor wrote:
> On Wed, Nov 02, 2022 at 08:24:09PM -0400, Taylor Blau wrote:
> > On Wed, Nov 02, 2022 at 11:01:42PM +0100, SZEDER Gábor wrote:
> > >  int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
> > >  {
> > >  	struct diff_queue_struct *q = &diff_queued_diff;
> > > -	int i;
> > >  	int result = diff_get_patch_id(options, oid, diff_header_only);
> > >
> > > -	for (i = 0; i < q->nr; i++)
> > > -		diff_free_filepair(q->queue[i]);
> > > -
> > > -	free(q->queue);
> > > +	diff_free_queue(q);
> > >  	DIFF_QUEUE_CLEAR(q);
> >
> > So, this all looks fine to me. But I did a quick grep around for
> > DIFF_QUEUE_CLEAR(), and this macro is used in quite a few places.
> > Mostly, as far as I can tell, to "empty" out the diff-queue by setting
> > its 'queue' pointer to NULL, and its 'nr' back to 0.
> >
> > Should we be freeing the memory held by the queue there more
> > aggressively? I.e., should we make sure that there is a
> > diff_free_queue() call above each expansion of the DIFF_QUEUE_CLEAR()
> > macro?
>
> Definitely not.  DIFF_QUEUE_CLEAR is often used to initialize a just
> created 'struct diff_queue_struct' instance; by adding a
> diff_free_queue() above those it would operate on uninitialized
> memory.

Thanks for pointing it out.

Thanks,
Taylor
