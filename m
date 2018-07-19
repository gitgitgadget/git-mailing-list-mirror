Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3381F597
	for <e@80x24.org>; Thu, 19 Jul 2018 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeGSQ11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 12:27:27 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:39480 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbeGSQ11 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 12:27:27 -0400
Received: by mail-it0-f53.google.com with SMTP id g141-v6so8170278ita.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VyC8N7FLCERIyauBPjHNRAZDtAgvcNFxCW/k5WcIwU=;
        b=SQx0Kq0k/ovWsPpd9rXSXQkmI/hEeTFJ6iGn1Y5i6boXo8yi27ns+Tnm/mRcL/D5Vz
         Ki8U17rQ7jnYiJ0+aNrA0Tb0cC8fs/K4qVVtoayES21I6v3XCLdBzJMdN3sfLeXN7fOh
         A5mFx3xl18i5sEdlGt+FimFWeP6z/ZVupnz8EJkkT5/fdDG2R/pU6Ta09qA20VBugapy
         nOh8Jax8ak1sBfE+NWnwuul1hROQTj/yBUvtrp7L55oE5dGudB50K/9YcrQfeB9VEAR2
         HqNORiUZaHfy+ZAzh99UZEDYl2eS1SJcbRDXPSSZlXn8219YlkRa9nMhS34YTagetLsK
         UIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VyC8N7FLCERIyauBPjHNRAZDtAgvcNFxCW/k5WcIwU=;
        b=V5VY3jzAhYMxCaCrXrR18L9aBmVPtnFjHEu0AURuV6OfTcHgWjQkQrXeKKSWVaOmJU
         koK8NvLV6LtptBgUT+628zyByCtz8lCijiVs02yT1asd7nRuDK7S2mEreiMX9FCi2BTM
         f6DbtoSvrVu2hxvNWsyBMPDFI2Lzlk3xcTFV0L6K2NQTZw75RhEruRBgg/Xhh02O3+Ym
         cckn22qiICAGWSuYATBJ8PQvlkWgjNHysWwwkCuUMQemiRmjtj9MVf041SXY8NmIEM30
         a896i6nEB8s6Hz2ybZQkkDcV5iuq3PlLzyLMrDg8crzz7LOHjTNSFdndTbFlbJ1RVM9l
         P6tA==
X-Gm-Message-State: AOUpUlFirHEJ6z68JvxTifHiSZcNaA04XKZKhCcDLlg9/JvWt+j9FlCP
        y4b3IukgJ561kVyHVNzLew97bZeowl7KbX9x8i2XPg==
X-Google-Smtp-Source: AAOMgpd7mxDbyWZFCoEfoXp4++LDFQyozQu79MSFcoUVFGfUIdi0e+hwx8wfmZ7d3ZtZtD10OeBfqXWuMyeesmgU950=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr5822945itf.121.1532015021458;
 Thu, 19 Jul 2018 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <CACsJy8Cc=h3ptDaW=oUGXqRZAvNU8-pUCe1cVFpRd0t8O1a0Gw@mail.gmail.com>
 <CABPp-BGbFSv3uyHusgKqaFAW4acXdf2Cj-s4FyZLiDU_brpK1Q@mail.gmail.com>
In-Reply-To: <CABPp-BGbFSv3uyHusgKqaFAW4acXdf2Cj-s4FyZLiDU_brpK1Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 17:43:15 +0200
Message-ID: <CACsJy8B9Aq9WEgC6TX72wdGshZEG5RAiGd+=hapRV7MPDC8vUw@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 5:27 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jul 18, 2018 at 10:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Jul 19, 2018 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
> >>
> >> I had a user report some poor behavior of 'git gc --aggressive' on a
> >> certain repo (which I sadly cannot share).  Turns out that on this
> >> repo, this operation takes about 60% longer and produces a pack
> >> roughly twice the expected size.
> >
> > The intention was to make life better for weaker machines but
> > definitely should not slow down beefier ones, so yes this is
> > definitely a regression.
>
> Not sure if it matters, but the original discovery was on a laptop.
> Probably 4 cores and 16 GB RAM.  I duplicated on my workstation (8
> cores, 24 GB RAM).  However, since the original patch was memory
> related and I noticed the repacking using all available memory, I
> repeated the testcases while measuring memory but did it on a machine
> that wouldn't be memory limited.

That should be plentiful for a 5GB pack with default cache settings, I think.

> > Is it possible to share "verify-pack -v <pack file>" output of the
> > pack produced by 2.17.0 and 2.18.0? The only sensitive info there is
> > sha-1, which you can replace with just "SHA-1" if you want. I'm more
> > interested in delta sizes and distribution.
>
> For the deltas, assuming the size-in-pack field (4th column) is the relevant one
>
> Number of objects in repo (lines of verify-pack output): 4460755
> Number of deltas: 2831384
> Number of deltas greater than 1MB: 72
> Min: 14
> Median: 47
> Mean: 586
> 99.999 percentile: 11366280.6 (10.8 MB)
> Max: 141664210 (135.1 MB)
>
> If the size field (3rd column) is the relevant one, then the numbers
> change slightly to:
>
> Number of deltas greater than 1MB: 101
> Min: 4
> Median: 33
> Mean: 660
> 99.999 percentile: 12245551.7 (11.7 MB)

I think size is the right one because even deltas are compressed
before stored in the pack file (I probably should check the code...)
but anyway this number is bigger and that sounds to me like 16MB as
delta size limit should cover common case nicely. 32MB to be on the
safe side, but given default cache size of 256MB, a single delta 1/8
the size of the cache sounds too much.

> Max: 144658342 (138.0 MB)

This one would trigger the patch I just sent, which should also handle
it nicely (I hope).

> I checked out the blob which had the biggest delta, as well as the
> blob it was a delta against.  One was a 280 MB file, the other a 278
> MB file.
-- 
Duy
