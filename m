Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8ABD1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 14:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426070AbeCBOjK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 09:39:10 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45495 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424068AbeCBOjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 09:39:05 -0500
Received: by mail-oi0-f45.google.com with SMTP id j79so7152498oib.12
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K2oinuMuGHneoG6/Vq1ZWqMw+JcSgAQenx6171CWrcg=;
        b=Z7OVwgYjGJkU3hTax53RJ4qYpXn+pUeR5ieQpJEe1dMvYhhGGojq4jPXoCUQHfHkwE
         F0uXYVq4nQFvrlmB9THnIInCgYExA57YGoZztSwu/GFst3E95uszxTVqz3LWiFoGgMgN
         Hfrql0VC3nl23NPt6KvChwru3g+DFSIIcrPKKgT3Oy7nAUYMU0ZzUU1vLEbTw2uTwzof
         sFns2KlMrY/SdHMvDGXpzXkaFR3l/eNXuFiujRnfQGUvYzwg4IzLFq86OhfR+RRxNri3
         H3ClG5XXJaUoU+UouskJUZ2k0L5BLH63GD7aIjERMkd9KcGJ5xSav5C/6l4lq4uCvpJp
         1uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K2oinuMuGHneoG6/Vq1ZWqMw+JcSgAQenx6171CWrcg=;
        b=JARkZ3ExViuDk9xN/rNwJ5MbZwLEdbwGEG6e5Gf+/eftHsg4ks5/lwF1a8LEaBIW+k
         uYOzpSwWP6vKnb8CSTqt15951ZAA2m9SiXdhQMJL5LtYFRP6JYkp+7YtmovN7AL7es2E
         4rvMF7clnw9lwH0QE6xZ6TS7/x4RXfT9Po88g7tz8wwZkbo+xgeNDFvpGwidWFcKEJg1
         VplHg1ZMkBKkrXHIsa2g99sYL4UcMFdM6QL9lE8l1wlW/4ii89Rpj3tTcaa11Y1mN08I
         tKiCVvC2yVSuFejiPZ6JMiJbTkeMSsCI1eXkSVan8cGOxLeZ1g1/qyHHQnMH33+xa/+9
         UvbQ==
X-Gm-Message-State: AElRT7GYAgJN8hXmKSewTkIj2gMzrR2hcLfpTGOor5zSNpKFLgfZuxAa
        cjpUHWZzXaqQJi0aa6nWKUtDBEavy2XjfIBg4UA=
X-Google-Smtp-Source: AG47ELvioGOesA1Uvt49Cp4F2Fv8D6GOAPJ94lCr7Wgm9Tvj+J1i+BTDPW3Lv7J/nV/vPbz2OFJbd7ZehrwlGByUT3s=
X-Received: by 10.202.83.129 with SMTP id h123mr3847033oib.228.1520001544593;
 Fri, 02 Mar 2018 06:39:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 06:38:34 -0800 (PST)
In-Reply-To: <20180302105405.GD11074@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash> <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
 <20180302105405.GD11074@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 21:38:34 +0700
Message-ID: <CACsJy8BEgC3YnFXR4EsS=cZ=q0ud9cp1NBgOvua0LmUagnKTsg@mail.gmail.com>
Subject: Re: Reduce pack-objects memory footprint?
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 5:54 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 02, 2018 at 05:18:45PM +0700, Duy Nguyen wrote:
>
>> On Wed, Feb 28, 2018 at 4:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
>> > consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
>> > all apps nearly unusuable (granted the problem is partly Linux I/O
>> > scheduler too). So I wonder if we can reduce pack-objects memory
>> > footprint a bit.
>>
>> Next low hanging fruit item:
>>
>> struct revindex_entry {
>>         off_t offset;
>>         unsigned int nr;
>> };
>>
>> We need on entry per object, so 6.5M objects * 16 bytes = 104 MB. If
>> we break this struct apart and store two arrays of offset and nr in
>> struct packed_git, we save 4 bytes per struct, 26 MB total.
>>
>> It's getting low but every megabyte counts for me, and it does not
>> look like breaking this struct will make horrible code (we recreate
>> the struct at find_pack_revindex()) so I'm going to do this too unless
>> someone objects. There will be slight performance regression due to
>> cache effects, but hopefully it's ok.
>
> Maybe you will prove me wrong, but I don't think splitting them is going
> to work. The point of the revindex_entry is that we sort the (offset,nr)
> tuple as a unit.
>
> Or are you planning to sort it, and then copy the result into two
> separate arrays? I think that would work, but it sounds kind of nasty
> (arcane code, and extra CPU work for systems that don't care about the
> 26MB).


How about two level lookups? We have

struct revindex_entry_l2 {
        uint32_t offset; /* the lowest 32 bits */
        uint32_t nr;
};

struct revindex {
        struct revindex_entry *level1[256]; /* 8 high bits */
};

This limits us to 1024GB pack files, which should give us some time
before we have to worry about it again and most of the time we'll need
just one or two items in level1[] so cache effects are not that bad.
Preparing/Sorting this could be a problem though.
-- 
Duy
