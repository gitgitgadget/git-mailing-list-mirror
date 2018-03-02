Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED3C1F576
	for <e@80x24.org>; Fri,  2 Mar 2018 10:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426770AbeCBK4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 05:56:10 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42592 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426680AbeCBK4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 05:56:03 -0500
Received: by mail-oi0-f44.google.com with SMTP id c18so6740402oiy.9
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 02:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aaf3qipjA5HgvjG+9KX3IvcJWEHCgmP4So8UY1jCeAg=;
        b=OGEaQSl9W2bFUnIaG5xIn7dJ2ODz0+GVXqjgDHmLIL60VFx8vXjMuvOsW85rO9JaNf
         iOKxo6RWg7QG6L1bP055IM5FcJglp90YbTdKuqLsnRw755henZVJV43yCcsamMt9lmfT
         dC5ywVGRZ9THfVwtD/E0dqfJYYBninaAmFF+afI+4sTZB8bIc4xjWxm1P3nZRpYgUbjj
         0/TkgUEwG17IxbkMHR1ejtmiY/PEJ0I7qMsLWuJZP9bacxSP7f592/L6LB7IN10uXB95
         AorqfmVZfLU3rm8DI+XxRSwJBntRQBYfEEncyLLE0sPtK8/o2WzFMrKEbItx1KmxstMl
         CG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aaf3qipjA5HgvjG+9KX3IvcJWEHCgmP4So8UY1jCeAg=;
        b=X7ewoxRi9t/EESzhU+uUpah36BsT9K7EsCu0MAzAozpZ/WM5DoiuMwaxKvD+M/9kPl
         LHiYJ1D4FH+51xVUqOrx6TQJWj4X7a/M1wA3ZZw509h95Lzg5tAY0RsGQIJ/3Erud1rt
         PxgoYiP8hunFiNrwtyDOkO+tAZBYNqxvRjaTMQ9NutGrRV/Fc9KxPmw0UOEP3TdIJ7ET
         jaVrdLkgN67ThXAsmjjEYtY9SHETCtOCrdjGL002yseZZ7ex4dmCmrB5YGji1YEs5AAz
         gl1/UTgODFHTB0U/VNRonpBPtM5Bo4M/vnJJCceGO/I9Wp89J+puz+qdgeWAEjGApgz+
         H+0w==
X-Gm-Message-State: APf1xPB6EOsQizXbBhJI98gm4uaYutGzUhMuO6zgMdzFFbGZkKf5h8Cs
        /2Si9WDdU9etS22elO8wl01NtUxErU8C56nZ1AQ=
X-Google-Smtp-Source: AG47ELtBTZgFNgho2v9ZE8NxaL75jW/ZhE7IzCStathS8dhv55D/lhUb9hJ1sI8m4Z7x/uMI6lSs//83Nq8HOO7hZ1M=
X-Received: by 10.202.64.85 with SMTP id n82mr3358272oia.30.1519988162529;
 Fri, 02 Mar 2018 02:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 02:55:32 -0800 (PST)
In-Reply-To: <20180302105405.GD11074@sigill.intra.peff.net>
References: <20180228092722.GA25627@ash> <CACsJy8AzP9HLc02LbSxBvNM6Dg4FsgRt57SgaNFyT5TBPRq-Zw@mail.gmail.com>
 <20180302105405.GD11074@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 17:55:32 +0700
Message-ID: <CACsJy8DgNfVyp9v7NgO=1V54eBBHCToTTmxr3Xw=yrt9di8z5w@mail.gmail.com>
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
> separate arrays?

Yep.

> I think that would work, but it sounds kind of nasty

Yeah :(

> (arcane code, and extra CPU work for systems that don't care about the
> 26MB).
-- 
Duy
