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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF2C1F609
	for <e@80x24.org>; Fri, 24 May 2019 09:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbfEXJBn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:01:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34895 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389425AbfEXJBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:01:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2272626wmi.0
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8EZD5EN3o4+oL1wgC7pKPM1qdyD/Mkkiu9JYjeV02wY=;
        b=Uf7TquJuWSPxZTG4mU/ydFFiYH72dOmnF879NYx8VLBHCap9X+RGUVI/6hSuIBVAsh
         HQJbod4QQi/eh/ZKrPwCtSc/rri1BCG1VPpVEA+wKWAwmEr6UeM7UO58k/v62vsmtEtI
         DGDgV5BFZ6B2KsEM+MXJcdx/2pVxuuolKReRxj04sX8DRqyXvgIat+HVf5gC4xbUjU2+
         l71HXgsZEje3yDqD+kTv2LqvTCvnQTdXCJfz6mrxaVlPedSJsLb7cytD++By23PEgEAF
         mOpa6+ZytWmgigI3yGUyDvC3wEnthmmM29kw9qAdV76Hz62rTfsYlLN4da48LOZOrXeC
         Ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8EZD5EN3o4+oL1wgC7pKPM1qdyD/Mkkiu9JYjeV02wY=;
        b=SMHFAQeIbatMkJjA1MN3kRk2NOfA5ysWw86BbeCJayyHdFTpzY5yZbCZLGs2/gZAXE
         RCrBUAAjEgJiX1MTE6jmPSs7HTrwwIbn0Kef23jqjUo7JFgxSWFGtSvf0LM0fMnE20Yd
         kXS0tkVP8X24KIKRTsVyHJjz1hpH16YiCZiQM++ISGpaiaw//+eZHWT+1a/qzgrdLldw
         ru2KfUOAqjXOfN0Kl7iGCnJ82YFiGRbA5fylfLdc5Id0YrUP6boJqlHkqZmasOyV6NKC
         GeVioTWsEApORgnQeX7tu5fGQW2KC3ilSMRI1Nc14kDOu+Ih76uCRiRUYe5rNQHeOWdc
         D4nw==
X-Gm-Message-State: APjAAAXG2D9scBACZCQbRaWU3KAj7chDZvU+L0v+11iWGUQa83PkESxj
        MfW/bigN3pcX4CiAA5Sh1DE=
X-Google-Smtp-Source: APXvYqzPl5KI0uoDd4x50qR44bOGmjhmFRrNr1/gWiblvCFK2ubVvW3rb7yEcpBf5Y8mN9S7opV6Hw==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr14016212wmc.40.1558688500774;
        Fri, 24 May 2019 02:01:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q11sm1766261wmc.15.2019.05.24.02.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 02:01:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190312104954.GA2023@sigill.intra.peff.net> <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <20190523113031.GA17448@sigill.intra.peff.net> <87tvdlt1jp.fsf@evledraar.gmail.com> <20190524072724.GH25694@sigill.intra.peff.net> <87r28offs6.fsf@evledraar.gmail.com> <20190524082605.GB9082@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524082605.GB9082@sigill.intra.peff.net>
Date:   Fri, 24 May 2019 11:01:39 +0200
Message-ID: <87pno8fcp8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Jeff King wrote:

> On Fri, May 24, 2019 at 09:55:05AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I'm not sure what tickles the bitmap-writer to fail so hard. Is it
>> > having too many refs? Weird patterns in the graph? Just a ton of
>> > commits?
>>
>> Ah, why did only this ancient (big) pack have a bitmap?
>>
>> The bitmap writer had never failed, this was just a repository where
>> some automation (on a dev/staging box) cloned a repo, and someone had
>> once run a manual "repack" to make make a pack with a bitmap.
>
> Just to be clear, by "fail" I didn't mean that the writer failed to
> produce. I just meant it had poor commit selection for its bitmap
> coverage. But...
>
>> Then as time passed that pack stayed around, and re-looking at this that
>> could have only happened because I had gc.bigPackThreshold turned on.
>>
>> I.e. without that we'd have eventually done a full repack, so the bitmap
>> would have gone away.
>>
>> So getting the repo into that state was a series of unlikely events.
>
> Ah, now that's interesting. The issue may have just been that we had a
> ton of un-bitmapped commits because they weren't in the bitmapped pack
> at all. The logic that Stolee pointed out earlier:
>
>           /*
>            * if we have a HAVES list, but none of those haves is contained
>            * in the packfile that has a bitmap, we don't have anything to
>            * optimize here
>            */
>           if (haves && !in_bitmapped_pack(bitmap_git, haves))
>                   goto cleanup;
>
> is pretty feeble. If you have even _one_ UNINTERESTING tip that's in the
> pack, we'll try to use bitmaps. And in your case, you almost certainly
> had old tags on both the client and the server there were in the old
> bitmapped pack, but then a huge swath of history that had happened since
> then. And it was that newer part of the graph that we had to walk to
> fill in the bitmap.
>
> So all of this makes pretty good sense to me now. Bitmaps work
> incrementally as you add new, un-bitmapped history. But the cost gets
> higher and higher the longer you go before repacking and generating new
> bitmaps. So your case was very similar to a repo that uses bitmaps but
> just hadn't packed in a really long time.
>
>> I think to the extent that this is an issue we can reproduce in the
>> future the proper fix for it in lieu of some easy fix in the bitmap code
>> would be to just teach "gc" to unlink old *.bitmap files if we detect
>> they're too stale.
>
> Yeah. This could happen if you simply accumulated history without ever
> running "gc". But in general we can probably assume that "gc" will run
> periodically (though there is a real blind spot if you push up a very
> huge chunk of history in one pack, since gc counts packs, not objects).
>
> I agree that if gc is deciding to leave a big pack, it should probably
> ditch the bitmaps for it.
>
>> I.e. we don't need to deal gracefully with some case where the bitmaps
>> just cover some tiny part of the graph, we can just teach "gc" to either
>> update them, or (if we're not currently writing them) unlink them.
>
> Unfortunately I don't think we can update them, because all of the
> reachable objects need to be in the same pack. So any scheme that isn't
> doing a periodic all-into-one repack probably shouldn't be using
> bitmaps. I wonder if we need to tweak Eric's bitmaps-by-default logic to
> better account for this.

I mean either we'd update them via repacking, or have some heuristic to
do away with them.

>> That seems to me to be a good idea in general, not just with bitmaps but
>> also the commit graph. If we're doing a GC and our current settings
>> aren't such that we'd update those files, shouldn't we just unlink them?
>
> I don't think the commit graph would suffer from this. It's not tied to
> a specific pack, so it can be freely updated on any gc. You still have
> the problem when gc does not run. It's possible that auto-gc should have
> separate thresholds for different activities (e.g., number of packs
> should tell us when to repack objects, number of loose refs should tell
> us when to pack refs, number of un-annotated commits should tell us when
> to update the commit graph). The trouble is that some of those checks
> are non-trivial.
>
> In the long run, I think the plan is for the commit graph to allow cheap
> incremental updating, which may make it reasonable to just update it
> preemptively after every fetch/push.

I don't think it's a performance problem to have an old commit-graph
lying around. But if you turn on the commit-graph, run gc a bunch, then
turn it off in config we'll have it lying around forever, even if you do
subsequent gc's.

So I think we should delete such things on the general principle that
the end-state of a gc's shouldn't be the accumulation of the values of
past configuration options if we can help it.

Maybe that screws over other users who did a "commit-graph write"
without setting gc.writeCommitGraph, but I think the only sane thing to
do is to make "gc" fully 'own' such things if its turned on at all. We
don't worry e.g. that we can't repack some recent pack because a user
might have just manually produced it with handcrafted love seconds
earlier.

Some of what you bring up is "let's do incremental GC". I agree, but
think that can be considered separately from what GC should do *when* it
runs, whether that's a "full" or "partial" run.
