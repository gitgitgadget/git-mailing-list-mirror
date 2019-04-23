Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1591F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 07:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfDWHHK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 03:07:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38852 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 03:07:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id f14so18108266wrj.5
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PXeuCOM6FySw9d5mapjxjvYIQYS0olPALOqUjElMUVg=;
        b=ZP+w2zB0iEUIot06ZjVbytjwcyl8ej2diFr1OlTxqd3ADR+6VXQkltiK7QMymgUYkc
         HXIgecTIBhFhY8HqbOERNoRuIzLZZv5IEeuUmKxGk7imTtuvdJNMHmp6w+sXU7UIyrrb
         SqbFaUA3Xh6r+eKtTUUnCsQGZe8klg5mQupI23nYUwu7/BStRTvHF/AvmTK5ErS+JWIB
         e16nQJdPUChO8un+2p6uyP4aw63eoLEatORFxAXWTOLJZrEhmuxt3C0Mvh83pv+Tv8dK
         rsNiO7jFUQEn9pW3bECLbq9rcsxMEKF+4YlpJKPNnTF/uRkbZiBMZwXnsduqPX1qdWgt
         pZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PXeuCOM6FySw9d5mapjxjvYIQYS0olPALOqUjElMUVg=;
        b=HfHzPIvGnt/0MlR65gpKU2IdN9XoGKnfm5UqNoLQ/GNxuA3F32J02Wj/4lGQ0GAPUd
         K8d0GrUkZl5JWT+TlSePwIhZFfihzp17lGxMn0aZhiBhbSbawB6iE0YQFjGbsqMZXWId
         LTnPHOmjqhyil6wY8/sFrdtTtUg+gvZLClePAqSxwuBk91R/mgi2jIopb5kOJeAi0t/v
         vboMeRX1Tc27T6Y1aHWiNsoE50HgiWDIL5Yd5esdUIY3auQ2JkyZdpsgKJcttqsnQ3Uh
         oDWDjSdthTD6OA05zA4k/JdZcQ3SeYBPLOUyeP2LL4SLKDalNNp0aK11QCxoNwPVBlHT
         yDag==
X-Gm-Message-State: APjAAAUCMxzXmR1jLLSdanmLoUIyFNHfnELmTY72K9jjZq94pA2hqVlS
        w60Oz5+nBHmcDtdaQ+znBYw=
X-Google-Smtp-Source: APXvYqzu583/lLfm94yGq23UnwwQS27aHAAKz8djdtYWWHrTYg2P8pYgvCBzsbhBWNCywvGOifEd3g==
X-Received: by 2002:a5d:53cc:: with SMTP id a12mr7345266wrw.262.1556003228347;
        Tue, 23 Apr 2019 00:07:08 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q4sm16856606wrx.25.2019.04.23.00.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 00:07:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Resolving deltas dominates clone time
References: <259296914.jpyqiltySj@mfick-lnx> <20190420035825.GB3559@sigill.intra.peff.net> <874l6tayzz.fsf@evledraar.gmail.com> <20190422155716.GA9680@sigill.intra.peff.net> <874l6pudg4.fsf@evledraar.gmail.com> <20190422184329.GA20304@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190422184329.GA20304@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 09:07:06 +0200
Message-ID: <8736m9td2d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 22 2019, Jeff King wrote:

> On Mon, Apr 22, 2019 at 08:01:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Your patch is optionally removing the "woah, we got an object with a
>> > duplicate sha1, let's check that the bytes are the same in both copies"
>> > check. But Martin's problem is a clone, so we wouldn't have any existi=
ng
>> > objects to duplicate in the first place.
>>
>> Right, but we do anyway, as reported by Geert at @amazon.com preceding
>> that patch of mine. But it is 99.99% irrelevant to *performance* in this
>> case after the loose object cache you added (but before that could make
>> all the difference depending on the FS).
>
> I scratched my head at this a bit. If we don't have any other objects,
> then what are we comparing against? But I think you mean that we have
> the overhead of doing the object lookups to find that out. Yes, that can
> add up if your filesystem has high latency, but I think in this case it
> is a drop in the bucket compared to dealing with the actual object data.

There was no "we have no objects" clause, so this bit is what dominated
clone time before the loose object cache...

>> I just mentioned it to plant a flag on another bit of the code where
>> index-pack in general has certain paranoias/validation the user might be
>> willing to optionally drop just at "clone" time.
>
> Yeah, I agree it may be worth pursuing independently. I just don't think
> it will help Martin's case in any noticeable way.

...indeed, as noted just mentioning this in the context of things in
index-pack that *in general* might benefit from some "we had no objects
before" special-case.

>> > Right, that would work. I will note one thing, though: the total time =
to
>> > do a 1-depth clone followed by an unshallow is probably much higher th=
an
>> > doing the whole clone as one unit, for two reasons:
>>
>> Indeed. The hypothesis is that the user doesn't really care about the
>> clone-time, but the clone-to-repo-mostly-usable time.
>
> There was a little bit of self-interest in there for me, too, as a
> server operator. While it does add to the end-to-end time, most of the
> resource use for the shallow fetch gets put on the server. IOW, I don't
> think we'd be happy to see clients doing this depth-1-and-then-unshallow
> strategy for every clone.

Just change from per-seat pricing to charging a premium for CPU &
I/O. Now your problem is a solution :)

More seriously, yeah I think we definitely need to be careful about
changes to git that'll eat someone "free" server time to save the client
time/work.

At the same time we have dedicated internal operators who wouldn't mind
spending that CPU. So hopefully we can in general find some reasonable
middle-ground.

>> > So in general, I think you'd need some cooperation from the server side
>> > to ask it to generate and send the .idx that matches the .pack it is
>> > sending you. Or even if not the .idx format itself, some stable list of
>> > sha1s that you could use to reproduce it without hashing each
>> > uncompressed byte yourself.
>>
>> Yeah, depending on how jt/fetch-cdn-offload is designed (see my
>> https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/) it
>> could be (ab)used to do this. I.e. you'd keep a "base" *.{pack,idx}
>> around for such a purpose.
>>
>> So in such a case you'd serve up that recent-enough *.{pack,idx} for the
>> client to "wget", and the client would then trust it (or not) and do the
>> equivalent of a "fetch" from that point to be 100% up-to-date.
>
> I think it's sort of orthogonal. Either way you have to teach the client
> how to get a .pack/.idx combo. Whether it learns to receive it inline
> from the first fetch, or whether it is taught to expect it from the
> out-of-band fetch, most of the challenge is the same.

I think it is, but maybe we're talking about different things.

I suspect a few of us have experimented with similar rsync-and-pull
hacks as a replacement for "clone". It's much faster (often 50-90%
faster).

I.e. just an rsync of a recent-enough .git dir (or .git/objects),
followed by a 'reset --hard' to get the worktree and then a 'git pull'.

>> > This could even be stuffed into the pack format and stripped out by
>> > the receiving index-pack (i.e., each entry is prefixed with "and by
>> > the way, here is my sha1...").
>>
>> That would be really interesting. I.e. just having room for that (or
>> anything else) in the pack format.
>>
>> I wonder if it could be added to the delta-chain in the current format
>> as a nasty hack :)
>
> There's definitely not "room" in any sense of the word in the pack
> format. :) However, as long as all parties agreed, we can stick whatever
> we want into the on-the-wire format. So I was imagining something more
> like:
>
>   1. pack-objects learns a --report-object-id option that sticks some
>      additional bytes before each object (in its simplest form,
>      $obj_hash bytes of id)
>
>   2. likewise, index-pack learns a --parse-object-id option to receive
>      it and skip hashing the object bytes
>
>   3. we get a new protocol capability, "send-object-ids". If the server
>      advertises and the client requests it, then both sides turn on the
>      appropriate option
>
> You could even imagine generalizing it to "--report-object-metadata",
> and including 0 or more metadata packets before each object. With object
> id being one, but possibly other computable bits like "generation
> number" after that. I'm not convinced other metadata is worth the
> space/time tradeoff, though. After all, this is stuff that the client
> _could_ generate and cache themselves, so you're trading off bandwidth
> to save the client from doing the computation.
>
> Anyway, food for thought. :)
