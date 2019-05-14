Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDC61F4B6
	for <e@80x24.org>; Tue, 14 May 2019 11:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfENL5n (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:57:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43546 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENL5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:57:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so22478542edb.10
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xTEiSDu9/agNPiji40Ln0Lw/rPOAZKTmJe6Q3N3WBn0=;
        b=mV9sT4aKea8w0jhSvGgq/z7gQXEZfFPy+PfQQPyJUKnzsTODgJdxre2TQYxhRMWEtb
         bMtVWzhgqZ2DR5UpG+kMeyGAps/UkjD5bJUDPNlHd0JIEqPgYYtRgZFP+im2IJCKCsD/
         blHGBqPO3X7L7z1nY9Gn+O0z5Sx2wZwEEhiBDNuEVkqD4WFU7LJQvwDO1XKEw+qEswLI
         4AgRbtu6FRbyKvP7bRKtQ4Fze6zZSt4xOjKMxXAgJYkVh1aFeLoo9nv2A+knM1n69k3I
         iglinv5TynT+m6wXjpUTLonuR72S85EVkQGhdCTDMTIZJe215Ai7i6EwoB1Cp59RrNK4
         M8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xTEiSDu9/agNPiji40Ln0Lw/rPOAZKTmJe6Q3N3WBn0=;
        b=UVNvIx/OJ8RwJ7pSIgLTJn3fzKhs5akCcIay8eQ886pe2y2NdpiinXuTTN01IKpGx0
         B90YOVAE9LJ1hepmJHyYTzrRo29TMsn5HtL8PZUSLYQSingn4ddNO7/q4BV7kosXRv8f
         cIBQ1jh7heqK1qEJvnKSsf10jbQyJs0hhNTE9pusC3zYB5ZKlbVdsKnFRLkyThuwpwFN
         cn4SI078ULZ/MwLLbKa/3UVMvVYvwHkRx9/vFCHdK/uyqmpRke6TzYGouLlFlnFTd1xG
         hBCHyZg8ZRijkseC1QYTMyOtFXyoqF9OsBl1IlVnZ/BOjHvHl4/10+X4AdLFOgc3KKYC
         2SRQ==
X-Gm-Message-State: APjAAAVUCCweC0R3QhwjhJypacCI2afzLr4352/q6lEEH2vnwMgI/4SH
        By2E6lpSDnMKLepP64AC8/U=
X-Google-Smtp-Source: APXvYqxSkKjsP2WrkKZjjCG0AqwYeDyheoCm3XAt991J76YFYzoFma0Upej9pfh6YHZuQa59Gkhctg==
X-Received: by 2002:a17:906:2ac5:: with SMTP id m5mr27523904eje.71.1557835061807;
        Tue, 14 May 2019 04:57:41 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id j13sm4484454eda.91.2019.05.14.04.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:57:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
References: <20190511013455.5886-1-e@80x24.org>
        <87v9ygwoj0.fsf@evledraar.gmail.com>
        <20190512040825.GA25370@sigill.intra.peff.net>
        <87tve0w3ao.fsf@evledraar.gmail.com>
        <20190514094729.GA12256@sigill.intra.peff.net>
        <87imudwck8.fsf@evledraar.gmail.com>
        <20190514112451.GB26957@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190514112451.GB26957@sigill.intra.peff.net>
Date:   Tue, 14 May 2019 13:57:35 +0200
Message-ID: <87h89xw8nk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Jeff King wrote:

> On Tue, May 14, 2019 at 12:33:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I think it would work because any update-server-info, whether from A or
>> > B, will take into account the full current repo state (and we don't lo=
ok
>> > at that state until we take the lock). So you might get an interleaved
>> > "A-push, B-push, B-maint, A-maint", but that's OK. A-maint will
>> > represent B's state when it runs.
>>
>> Maybe we're talking about different things. I mean the following
>> sequence:
>>
>>  1. Refs "X" and "Y" are at X=3DA Y=3DA
>>  2. Concurrent push #1 happens, updating X from A..F
>>  3. Concurrent push #2 happens, updating Y from A..F
>>  4. Concurrent push #1 succeeds
>>  5. Concurrent push #1 starts update-server-info. Reads X=3DF Y=3DA
>>  5. Concurrent push #2 succeeds
>>  6. Concurrent push #2 starts update-server-info. Reads X=3DF Y=3DF
>>  7. Concurrent push #2's update-server-info finishes, X=3DF Y=3DF writte=
n to "info"
>>  8. Concurrent push #1's update-server-info finishes, X=3DA Y=3DF writte=
n to "info"
>>
>> I.e. because we have per-ref locks and no lock at all on
>> update-server-info (but that would need to be a global ref lock, not
>> just on the "info" files) we can have a push that's already read "X"'s
>> value as "A" while updating "Y" win the race against an
>> update-server-info that updated "X"'s value to "F".
>>
>> It will get fixed on the next push (at least as far as "X"'s value
>> goes), but until that time dumb clients will falsely see that "X" hasn't
>> been updated.
>
> That's the same situation. But I thought we were talking about having an
> update-server-info lock. In which case the #2 update-server-info or the
> #1 update-server-info runs in its entirety, and cannot have their read
> and write steps interleaved (that's what I meant by "don't look at the
> state until we take the lock"). Then that gives us a strict ordering: we
> know that _some_ update-server-info (be it #1 or #2's) will run after
> any given update.

Yeah you're right. I *thought* in my last E-mail we were talking about
the current state, but re-reading upthread I see that was a fail on my
part.

An update-server-info lock would solve this indeed. We could still end
up with a situation where whatever a na=C3=AFve version of the lockfile API
would fail for the "new" update since the old one was underway, so we'd
need something similar to core.*Ref*Timeout, but if we ran into a *.lock
or the timeout we could exit non-zero, as opposed to silently failing
like it does now when it races.
