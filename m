Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97874C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81ADF613F7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhGOQu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhGOQuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:50:54 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED3C061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:48:01 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z11so7292015iow.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACo5x/ngCjrSdv+10VO/HntGa6tp8zIFtZUg+3Wt6FA=;
        b=Nsazi+8XpRjt+OqlJyr+If3mNyPjsfwQveQezaUTrGd4zswz/1N95HqGjs4GcF1oVL
         sFR6fQvhEY3J2DOWqe9yvsrCtL1D7p7OR6CVKhvP8qjgryPAGPo8i6lAdHklecunmeXB
         rJZplReN9nabL3DwchY2Ht2W4tdXSZqwNXLZRscDEv8gqwq45kF+O8+vpzggek/oKbzr
         U2PfW1XMkc6mpMHqtXo9ILytG5mvqSCLS8uRWtobTKkIrH43fj7Sva+wewABhLZBMJOB
         5TvmltmHzJb3B2w2xUpW/RmQpWCFOeBBmGQ5T4vlWH/crZNjXDR8GNPGrG/vPGrVD3a/
         0RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACo5x/ngCjrSdv+10VO/HntGa6tp8zIFtZUg+3Wt6FA=;
        b=HblEq4un4IF4umfFuDBJmE4bTyBYQLJdFdJWdV5QcoKbvAdYDIivMR96M0RG+Gccjr
         Kpj6MHlrIH+5DpwyALjFWmeOS6SAcNRn7sUiN+FbfZYctzMeTtH4bKAKarsEJ+4KeFKH
         ms+uduUM81Vot6DqEQbJ77HfxcTnOYvazbYNVGvZRtktaXe8IMpVbkChDh2L9uwQRk9J
         nYypsTg37AWKcnm6JirJ/TzvMCB1Umo2NvwOIWB5C16sqljTGMUI6u4nNK/WfHXdS1YL
         ANL/JLwTOnwgnMXIIALfDSwoYM/xhFZZ0i1Q3/1X5bGzka3DKMkkHuoOhrurpoJb30FJ
         tJkA==
X-Gm-Message-State: AOAM532PuKM4fgj1MYBjIXzIswNlDXa5LluFD64g5asAw8cVz7eqpWE+
        apHZ1DWqiUlUxhn1UoIGaZysQA==
X-Google-Smtp-Source: ABdhPJz4Uu0pNVkq8u9Dtul9jZST5mLMmgTNa+QjUQl0T6IWtFFGVkhR8tgyDDqPiTq5p0q4zOECUA==
X-Received: by 2002:a02:620a:: with SMTP id d10mr4988073jac.22.1626367680775;
        Thu, 15 Jul 2021 09:48:00 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:d40c:332:312b:8a8c])
        by smtp.gmail.com with ESMTPSA id e9sm3183400ils.61.2021.07.15.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:48:00 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:47:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: recommend gender-neutral description
Message-ID: <YPBmv7x3zUbuQ2uy@nand.local>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
 <87czrl0wob.fsf@evledraar.gmail.com>
 <xmqqk0lrtuh4.fsf_-_@gitster.g>
 <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT24=jy65C1cQ4WarakJHKm4F8_78nDm=jWOnHxfhtcRw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 12:35:30PM -0400, Eric Sunshine wrote:
> On Thu, Jul 15, 2021 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Technical writing seeks to convey information with minimal
> > friction. One way that a reader can experience friction is if they
> > encounter a description of "a user" that is later simplified using a
> > gendered pronoun. If the reader does not consider that pronoun to
> > apply to them, then they can experience cognitive dissonance that
> > removes focus from the information.
> >
> > Give some basic tips to guide us avoid unnecessary of gendered
> > description.
>
> Some words seem to be missing from this sentence.

I assume that it's supposed to read "guide us [to] avoid unnecessary
[uses] of gendered description".

>
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > @@ -541,6 +541,49 @@ Writing Documentation:
> > +      A contributor asks their upstream to pull from them.
> > +
> > +    Note that this sounds ungrammatical and unnatural to those who
> > +    learned English as a second language in some parts of the world.
>
> It also sounds ungrammatical and unnatural to this native English speaker.

Apologies if this suggestion has been made earlier in the thread, but
this article

    https://apastyle.apa.org/style-grammar-guidelines/grammar/singular-they

document from the APA's style guide helps convince me that this is
grammatical.

Thanks,
Taylor
