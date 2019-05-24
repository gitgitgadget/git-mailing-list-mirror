Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85B61F609
	for <e@80x24.org>; Fri, 24 May 2019 07:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfEXHzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 03:55:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfEXHzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 03:55:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so8921880wrb.9
        for <git@vger.kernel.org>; Fri, 24 May 2019 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l/b7RBnMj09xEsudonwbnkUy0XDTNtKU797h/yU1VV0=;
        b=Sv6bqy/EZv/477YN3boqinVkpuj21G7WbjXpGZ3J9H8Qc37vUvJT+Sl1K5cBBEurQW
         SmxkLUzQg0iH+kiBWqSuDZGAAXBWpx50o85Lx/T3oqXIjPIB036T4tV2z4mSy6REPS9m
         RvD3CFKqwSly0xbDc+JYg9N/OtlLF+3CNnNSCQC7oY+7IJmAEiFiKK7xar/vsy90jW6W
         0IvADg7ERbBalO0otGTaNn86H+QWhd34HRxVNPYGVarjlg4ZcKNRe3sU8kkDj9ysmzM6
         Q9q8/QIdodxP7hTPgPC9jVTdRrK3+EuT2fUO3xW6g7OSZmHlsGGJPNch+QnFeTPu/BnM
         EBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=l/b7RBnMj09xEsudonwbnkUy0XDTNtKU797h/yU1VV0=;
        b=H9u7qp5l9iSxSdP7+w1u7Sar4oWbb8J1T0wr+tFJUSH82d+bsW/5Kz5lbJRyk6rbfN
         Oa6CWHryzgA9QbWGZfMaKb8yCBFzc1LMtFfRKBPzX3de2W8dKiOlwZ+XjXNLDsh9yu09
         bWghVtYR1a3LLzwYWtO5Dy+Ebtg/Zb2RcWQaGarnPzGxsh7VDetnI02/7r0w7Kg1NbIV
         uKw7Gu4Vw7MbHjq6HySXdbfEl04lljR/CHSprSYy6rI0GuPVGoXxXr74LyNxUkgLTfnM
         AU0Nhjo44KB/y9GTSEXpnjCVXzlzbGKKwqEBTbtb55+BRIgu9NCQGvJyenWTJY7KZqr9
         YTIg==
X-Gm-Message-State: APjAAAXlGqzH1FodlNO70pD6rM9ogCnhnUfcrFiZBiJfZGRybtU8b3b8
        M+Yoo0esNnMNCKvHOgepDzFv0ZEIE+M=
X-Google-Smtp-Source: APXvYqzNk4d19qea1ux9DuUdWPsg4HXeHRav0YsTo//qE/p/q5dNAELchAnPqdIgvp+kZOqd2fJSwg==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr46915859wrj.246.1558684506982;
        Fri, 24 May 2019 00:55:06 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c131sm1556109wma.31.2019.05.24.00.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 00:55:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190310233956.GB3059@sigill.intra.peff.net> <20190312031303.5tutut7zzvxne5dw@dcvr> <20190312104954.GA2023@sigill.intra.peff.net> <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <20190523113031.GA17448@sigill.intra.peff.net> <87tvdlt1jp.fsf@evledraar.gmail.com> <20190524072724.GH25694@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524072724.GH25694@sigill.intra.peff.net>
Date:   Fri, 24 May 2019 09:55:05 +0200
Message-ID: <87r28offs6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Jeff King wrote:

> On Thu, May 23, 2019 at 09:26:34PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I spent a while thinking and experimenting with this tonight. The resu=
lt
>> > is the patch below. =C3=86var, do you still have a copy of the repo th=
at
>> > misbehaved? I'd be curious to see how it fares.
>>
>> No, sorry. I think we could make an artificial test to emulate it, which
>> would be something like:
>>
>>  * ~1 million commits
>>  * local clone setup to fetch all branches/tags (default 'git clone')
>>  * local a bit ahead/behind
>>  * Have old "main" pack with *.bitmap, bunch of other packs/loose object=
s without that
>>  * push try to push the local change upstream (or to a topic branch)
>>
>> I tried briefly to emulate this with git.git with:
>> [...]
>> But didn't get anywhere, probably because here my topics are all stuff I
>> have already, and I just have 2x packs.
>
> Yeah, I haven't been able to find a reproduction for this problem at
> will. The bitmaps are _supposed_ to be sprinkled around through the
> commit graph so that we don't have to walk far. But presumably in your
> case that was not so.
>
> I'm not sure what tickles the bitmap-writer to fail so hard. Is it
> having too many refs? Weird patterns in the graph? Just a ton of
> commits?

Ah, why did only this ancient (big) pack have a bitmap?

The bitmap writer had never failed, this was just a repository where
some automation (on a dev/staging box) cloned a repo, and someone had
once run a manual "repack" to make make a pack with a bitmap.

Then as time passed that pack stayed around, and re-looking at this that
could have only happened because I had gc.bigPackThreshold turned on.

I.e. without that we'd have eventually done a full repack, so the bitmap
would have gone away.

So getting the repo into that state was a series of unlikely events.

I think to the extent that this is an issue we can reproduce in the
future the proper fix for it in lieu of some easy fix in the bitmap code
would be to just teach "gc" to unlink old *.bitmap files if we detect
they're too stale.

I.e. we don't need to deal gracefully with some case where the bitmaps
just cover some tiny part of the graph, we can just teach "gc" to either
update them, or (if we're not currently writing them) unlink them.

That seems to me to be a good idea in general, not just with bitmaps but
also the commit graph. If we're doing a GC and our current settings
aren't such that we'd update those files, shouldn't we just unlink them?
