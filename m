Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C451F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeJEXrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:47:22 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36096 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeJEXrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:47:22 -0400
Received: by mail-wm1-f41.google.com with SMTP id a8-v6so2520924wmf.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=GdsTF7XyjMlCimO7TKPlBA5XStyIIsCImaClqk8Eymc=;
        b=pBc3UMnUZ7avrAZeREQ2LsHuc9+3415MZzchFkB/ech5E/XuEpK/N8ER24efS/63xf
         thj2vnsxOgvKxGrCWCEbcp6YxknJHZAGy1nZrKFRCZ+YoAqFvsuBnKJXB7LMbIbuU4Qv
         tFFbR8tGilgYZDpi7T9QVUlvovLgQG0NHWF6DQtHFUg9xz2S4s9BFPDDRtfX3XEc8/3Q
         Sv/8xkeqOM84pHrud0mz5c7UszRAcZQR0hNvmIlQ9Pz5+DJN7QH/DvlS982ZviuwBxTm
         OFHjs9G4FvTUgjt9CTcPfLpCEVOJWxE1FEhiCQvyDG8w/zvcHlrvlLBev5OrNwYlITT6
         cfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GdsTF7XyjMlCimO7TKPlBA5XStyIIsCImaClqk8Eymc=;
        b=YsbDF/LyUYuEDWPaI5fUYHSO53cN8pQ0mO1WQE1knwR1ZGbJzHyDaLXmJZ39uPPCRV
         TauUKziyO7p/JwbemTcG49cFPmzSn8CtpJXngDkI5ZM05MJHxDtm7jFzR1JeRVkl+DC8
         k+ThCFquBq0s/bPFAqO5UTd6n0pUnfAFRdDr7S1SpHlCzT0xnWnh6pP1ImocRzugy0HH
         pC3ufvGH3p1UBnrcQ+qaNhtUOOaNqaOaZ9nZrxUcBzK5FTi+JBSIhnDbEubaoSOLjCDZ
         PdPLAiZ5HymPgsvEIviMgXbE6pPSOj8yiuppe6PSj/QFxnZ6AWAAS+ixTq40+qXJ7EeE
         c6LQ==
X-Gm-Message-State: ABuFfohzrrXOa1T0/VuIBcc9SWVXjq6LKsxcfzO7S67SLNSz7ugZ5BbW
        TUrF2efvcksLLvnBXQJFrks=
X-Google-Smtp-Source: ACcGV62YGEC3YRmR2wIP/i4YSkbkzcEtSWPOk2S28BBhkiEbcHTXO3AB/nOpnnSf4XBhmQLrqCkhTA==
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr8123249wmd.17.1538758069350;
        Fri, 05 Oct 2018 09:47:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w72-v6sm14620615wrc.52.2018.10.05.09.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:47:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is there some script to find un-delta-able objects?
References: <87d0soh3v8.fsf@evledraar.gmail.com>
        <20181005161943.GA8816@sigill.intra.peff.net>
Date:   Fri, 05 Oct 2018 09:47:47 -0700
Message-ID: <xmqqk1mwwdak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 05, 2018 at 04:20:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> I.e. something to generate the .gitattributes file using this format:
>> 
>> https://git-scm.com/docs/gitattributes#_packing_objects
>> 
>> Some stuff is obvious, like "*.gpg binary -delta", but I'm wondering if
>> there's some repo scanner utility to spew this out for a given repo.
>
> I'm not sure what you mean by "un-delta-able" objects. Do you mean ones
> where we're not likely to find a delta? Or ones where Git will not try
> to look for a delta?
>
> If the latter, I think the only rules are the "-delta" attribute and the
> object size. You should be able to use git-check-attr and "git-cat-file"
> to get that info.
>
> If the former, I don't know how you would know. We can only report on
> what isn't a delta _yet_.

I am reasonably sure that the question is about solving the former
so that "-delta" attribute is set appropriately.

Iniitially, I thought that it is likely an undeltifiable object has
higher randomness than deltifiable ones and that can be exploited,
but if you have such a highly random blob A (and no other object
like it) in the repository and then later acquire another blob B
that happens to share most of the data with A, then A and B by
themselves will pass the "highly random" test but still yet each can
be expressed as a delta derived from the other.  So your "what isn't
a delta yet" is a reasonable assessment of what mechanically can be
known.  

Knowledge/heuristic like "No two '*.gpg' files are expected to be
alike" needs something more than the randomness of individual files,
I guess.

