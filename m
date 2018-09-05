Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2482C1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIEVc0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:32:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38615 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEVc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:32:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so8436046wrc.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZNaLfw4JS8yJwkiaSjxHESDbt/3/7VArEAzH/jTeSGM=;
        b=jVTNXLj37JScdNl822DaAmrPzqj5E2lsKHJB/oBi6r81aDyD1ExPEzZMmr9IG5OC8B
         wZ231tamovp9KVbPAuQF+jrs9ryb5bWnLNdMPUh6cOXGG/xKDC326FnbtY4xziuLdBVy
         T4+NhaX60bhztFalzTd4aLymp38e6Ul0Z/8Mlhz5duja9/H5Ajt3a3UH810vS/qmg2zk
         bJTEWsNdi7MKw0JxUPh9+A6SY3z54sPIXR5lloL5T72Jt4Vh2wpIeBD/bkTq9D1gOFIo
         NzCQtPDcG6Qli1DCbzcKPKZzbQpokQCvXJ46i1Nvk5x0CjgCIdkvqnyScUC3YF1DpH5T
         1rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZNaLfw4JS8yJwkiaSjxHESDbt/3/7VArEAzH/jTeSGM=;
        b=snM8b9vFokesvXjRQICTaJc61q40qyVy+5ZN91k9yIaxMe29iifkNckejdvikeUjnQ
         hFUZtXeUZhqbTW7GEPD2OrYlie8EIO7LcChIaY7v5fyDx4gaoxJr5g9Yg4xj5O1dOHPF
         C9+zBszBJbS3KwCo8/BBdXUmwrq5mt6ggS6jLmt81YGhAJOlWnbXYguZoypjEZrxijio
         QXDFgApvk6qh1pGoyRF9QQmKmhKnLxlbnvFUsNKAlcq9lwmwJtWxxAfuaP4dbVilk2NY
         HQ8gLnpzGdcaCvl698xYKic1RxoHIvwiVUpTOdjObA5GrfR4AKWPHqFIz52FDUdgE+W+
         09hA==
X-Gm-Message-State: APzg51C+g7YrRSZ1vwXXMRjwkxWhTWvAJrTrADS99BzcfTpDIyUBSN72
        gQ0xXyomVpSLBpf/KQAyAKA=
X-Google-Smtp-Source: ANB0VdafVK/NeOK0UPtsDK5e+uhyN+9ZTbODY6pv1L/R+LlmC+wpGQeLlh6Uyv1nT4TmGGMLKMWJkA==
X-Received: by 2002:adf:8445:: with SMTP id 63-v6mr27498566wrf.41.1536166881854;
        Wed, 05 Sep 2018 10:01:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n17-v6sm1752400wmc.13.2018.09.05.10.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 10:01:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
References: <20180902072408.GA18787@sigill.intra.peff.net>
        <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
        <20180904163807.GA23572@sigill.intra.peff.net>
        <20180904233643.GA9156@sigill.intra.peff.net>
        <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com>
        <20180905153551.GB24660@sigill.intra.peff.net>
        <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
        <20180905154827.GC24660@sigill.intra.peff.net>
        <xmqqva7j51gt.fsf@gitster-ct.c.googlers.com>
        <20180905165625.GA31930@sigill.intra.peff.net>
Date:   Wed, 05 Sep 2018 10:01:20 -0700
In-Reply-To: <20180905165625.GA31930@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Sep 2018 12:56:26 -0400")
Message-ID: <xmqqr2i7515r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 05, 2018 at 09:54:42AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> > So AFAIK this fsck catches everything and yields a non-zero exit in the
>> >> > error case. And it should work for even a single byte of rubbish.
>> >> 
>> >> Yes you're right. I forgot about the trailing hash.
>> >
>> > Thanks, I was worried that I was missing something. ;)
>> >
>> > Maybe it is worth making that final comment:
>> >
>> >   # and that the trailing hash in the index was not corrupted,
>> >   # which should catch even a single byte of cruft
>> >   git fsck
>> 
>> Perhaps.  I do not mind seeing an additional comment to explain why
>> this requires PERL (it wasn't immediately obvious as I never use
>> 'commit -p' myself), either.
>
> I thought the PERL prereq in the existing "-p" test of the commit header
> would explain it. ;)
>
> Do you prefer an in-code comment, or one in the commit message?

Neither ;-)  

Just like I think 'our index was not corrupted' as an explanation
for 'git fsck' is sufficient, PERL sprinkled all over this script
and all of them tend to be near "commit -i/-p" should be a good
enough clue, I'd think.
