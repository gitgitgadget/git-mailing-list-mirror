Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC32BC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD72613C3
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhGNRfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGNRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:35:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D041C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:32:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k16so3101108ios.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=de7Hvpf4Xz/ArH7lWmx2j4iLu7BiAtfuDxrhh9BwBTI=;
        b=rgDgGOWuie/ukRC15Q3gPLzDMj1Uf+ent9WUYP9e+J70Rc/Y8ozgqmi9Ocs89+tt0I
         Xa6KdJckGC2OLYIiXFOdVg4/7kA2pgShExfZnJJbY7BLKZ5ZJX4F/+EFKAOyuj8DwxbN
         IbvnEX9obyQV9E8gi5npxdKymIxGzgOHVq8J97sLpuCjhePBbGz8knSg70YyCHbXxKtL
         v1GzeDiMmU0A4ah+FIq0NeUBZ6VsLkLiSc+hRDPF8aqiJREt6kvejEdI/NpPRd3kH5q/
         och2iZrvFvhsOcCGwebxLKLoYDKzXS/HSeqymUbzbXtmTcib7CPsCxtlYY9KyNQqZOKu
         mSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=de7Hvpf4Xz/ArH7lWmx2j4iLu7BiAtfuDxrhh9BwBTI=;
        b=fNj0A04eUqQucPgTHRLp4b6DpIvkY2ukEpmRx/QKMk/UwW4W2S6iwAdW6BzKJL+mBB
         bBnYa7mtcHhRJFat8xEFENZsp8x42+c9TC/YRntiQCrFi1xz+d6By61JGhWRHwo0Z3d9
         DPFkLFlnzhmzD5Xk31LK0HqvQ0FdXAbQV8j5y6jw12ok9NZCmlWpJDAw05HY7AG3tGyH
         uNXouU7MCw3q8et1tGAULe3qC6ZBdglR7/uvVYU2DCMrW1mlypB/AjqjB+eTaqLpffEE
         4NrLuEnciPiDLqBO8caAs5OHKtqD54d1m489VcoxTajnRY9CaUt40grkQZopyWeE4TH+
         sI1w==
X-Gm-Message-State: AOAM531qxeZCADYYwyIG7lUg1IJ/ktnWtqPrLTPs0SU96p4RMJ9GKavR
        eMfJNEpNTrw0xc8hadAnjRg81Q==
X-Google-Smtp-Source: ABdhPJxdYSmOSlvR+/z82xCF0sEQlHCnUkcBbBskmW2+FzavSRfuyA5A8Seiiu1xlLfh9ba3JgyX/A==
X-Received: by 2002:a02:9109:: with SMTP id a9mr9944664jag.93.1626283942649;
        Wed, 14 Jul 2021 10:32:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id e17sm1497934ilr.51.2021.07.14.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:32:22 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:32:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YO8fpVZhoCiEiurR@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <87eecqzvld.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eecqzvld.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 01:23:40AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 21 2021, Taylor Blau wrote:
>
> > -static uint32_t find_object_pos(const struct object_id *oid)
> > +static uint32_t find_object_pos(const struct object_id *oid, int *found)
> >  {
> >  	struct object_entry *entry = packlist_find(writer.to_pack, oid);
> >
> >  	if (!entry) {
> > -		die("Failed to write bitmap index. Packfile doesn't have full closure "
> > +		if (found)
> > +			*found = 0;
> > +		warning("Failed to write bitmap index. Packfile doesn't have full closure "
> >  			"(object %s is missing)", oid_to_hex(oid));
> > +		return 0;
> >  	}
> >
> > +	if (found)
> > +		*found = 1;
> >  	return oe_in_pack_pos(writer.to_pack, entry);
> >  }
>
> So, a function that returns an unsigned 32 bit int won't (presumably)
> have enough space for an "is bad", but before it died so it didn't
> matter.
>
> Now it warns, so it needs a "is bad", so we add another "int" to pass
> that information around.

Right. You could imagine using the most-significant bit to indicate
"bad" (which in this case is "I couldn't find this object that I'm
supposed to be able to reach"), but of course it cuts our maximum number
of objects in a bitmap in half.

> So if we're already paying for that extra space (which, on some
> platforms would already be a 64 bit int, and on some so would the
> uint32_t, it's just "at least 32 bits").
>
> Wouldn't it be more idiomatic to just have find_object_pos() return
> int64_t now, if it's -1 it's an error, otherwise the "pos" is cast to
> uint32_t:

I'm not sure. It does save the extra argument, which is arguably more
convenient for callers, but the cost for doing so is a cast from a
signed integer type to an unsigned one (and a narrower destination type,
at that).

That seems easier to get wrong to me than passing a pointer to a pure
"int" and keeping the return type a uint32_t. So, I'm probably more
content to leave it as-is rather than change it.

I don't feel too strongly about it, though, so if you do I'd be happy to
hear more.

Thanks,
Taylor
