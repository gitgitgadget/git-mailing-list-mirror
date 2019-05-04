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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C1D1F461
	for <e@80x24.org>; Sat,  4 May 2019 06:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEDGwG (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 May 2019 02:52:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43374 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfEDGwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 May 2019 02:52:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so6349836edb.10
        for <git@vger.kernel.org>; Fri, 03 May 2019 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+imfoW2kyG7VeYiAOV2nntoI80vzdNZUOtX+0RAL5M4=;
        b=iptyK43X18EQM/bMdrrIqZbtJ3MnuYOQBp8VaoQXCNGuDVJtUvjtRMbEEzzLCnMANd
         9gIyRlEJOzcwTzQUowhELvy0is+8kcQhMWkarD3krVrrjXKVTP8gnD358av5Ie1c3u95
         Fo/KEBlXyFsVFpl6FQyfWo+OjXAL7rUsCOKCrRCMIVb/nzXFOXUwG459C7kzkH68xMQ/
         /w2CXu/s4jAUdTKzj/Kemy5SYIiLG12gpfHDrONFP4CHSDNu8KrHdBK/9IhcMjxY46MD
         sDOFKxr2c7YXNCQ3G/udvkxen+5r25maskweEE/CvOkPHmFBZqGG76Bn7LefcnFDbpHX
         jsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+imfoW2kyG7VeYiAOV2nntoI80vzdNZUOtX+0RAL5M4=;
        b=Y0LnKXqCv9zoNc1lUrx+MG60AidcPOJT8yIV9mFdMc0RFAKnC7AQFYLrHSYPe019Up
         e7rxt5+6TrnJcolB/pvL8DwqfdlxLWS8AF5GZB6bOewsNwvdib+4TV8tz8Rr9YMZJUED
         pyw3uO4WBQm57RPr+IDaXi4xbqsrkdn+sCeF2x7/F+/crpPPRmdihedqBST1tF4F5jzF
         hdcyNqFRNQ6a4WsokIw/aqDRzjkEpKlR+PdoHS1X5AjZnnYb9+XznmgorV/RmY8psAkU
         dD6So6Ew8IqF+hiV6ACndwrBwImCPiF9QufsjOe2pKpAcmEXSJQ+6/4aoqzBOMBH3KP5
         zkLw==
X-Gm-Message-State: APjAAAWoudyKhufUPYFKZL4G9tiA0XyM0jcRc2p0arD6KKBEyiCiSDHl
        noUrVknxZMZDgMR6OIuBMm0=
X-Google-Smtp-Source: APXvYqz9RmGRoVRchp8jerk8H8QYz01GFB/Ag9jYRmmO12JH0QReXkEHnvxYy1eRsQCpkwpBm4lAAw==
X-Received: by 2002:a50:bae4:: with SMTP id x91mr6237447ede.76.1556952723769;
        Fri, 03 May 2019 23:52:03 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d6sm1132574edq.65.2019.05.03.23.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 23:52:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190309024944.zcbwgvn52jsw2a2e@dcvr> <20190310233956.GB3059@sigill.intra.peff.net> <20190312031303.5tutut7zzvxne5dw@dcvr> <20190312104954.GA2023@sigill.intra.peff.net> <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com> <20190504013713.GC17551@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190504013713.GC17551@sigill.intra.peff.net>
Date:   Sat, 04 May 2019 08:52:01 +0200
Message-ID: <87a7g2iuem.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 04 2019, Jeff King wrote:

> On Thu, Apr 25, 2019 at 04:16:46PM +0900, Junio C Hamano wrote:
>
>> I was revisiting the recent "What's cooking" report, and I am not
>> sure what the current status of the topic is.
>>
>> I do not get a feel that the current bitmap implementation has been
>> widely used in repositories that have vastly different access
>> patterns---it probably has been tried only by those who can afford
>> the engineering cost to see if the implementation happens to work
>> well for their workload and some may have chosen to adopt it while
>> others didn't.  So it may be very well tuned for the former people
>> but once we merge this topic down, we'll hear from others with quite
>> different workload, which may lead to us tuning the code to bit
>> better to their workload while not hurting other existing users,
>> hopefully.
>>
>> Or not.
>
> Note that =C3=86var's case was somebody running bitmaps locally and tryin=
g to
> push, which I think is generally not a good match for bitmaps (even when
> they work, they cost more to generate than what you save if you're only
> pushing once).

Right. It was *not* caused by this "enable bitmaps by default on bare
repos" patch (which I wasn't even running with), but *is* indicative of
a pretty big edge case with enabling bitmaps that *will* happen for some
on such bare repos if we ship the patch.

> The goal of Eric's patch was that by kicking in for bare repos, we'd
> mostly be hitting servers that are serving up fetches. So if by
> "workload" you mean that we some people might use bare repos for other
> cases, yeah, there's a potential for confusion or regression there.

As noted I suspect that's a really rare use-case in practice, and in
reply to Junio's <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com> upthread I
think it's fine to just try this. Maybe we'll finally get such use-cases
out of the woodworks by turning it on by default.

As an aside this is the Nth time I notice how crappy that "Enumerating
objects" progress bar is. We do a *lot* of things there, including this
bitmap calculation.

But just splitting it up might result in either no progress (all
individually below 2 seconds), or a lot of noise as you have 20 things
that each take 2 seconds. I wonder if someone's looked at supporting:

    Enumerating Objects (X%) =3D> Calculating bitmaps (Y%)

Where X% is the total progres, and %Y is the sub-progress. I eyeballed
doing this once by "chaining" the progress structs, but there's probably
a less crappy way...


> If you mean that bitmaps might not work for some workloads even when
> we're serving a lot of fetches, I won't say that's _not_ true, but my
> experience is that they are generally a net win. Both for the smaller
> repositories we see on github.com, but also for big, busy ones that our
> on-premises customers use.
>
>   Actually, there is one curiosity with Eric's patch that I haven't
>   tested. As I've mentioned before, we store "forks" as single
>   repositories pointing to a single shared alternates repository. Since
>   the bitmap code only handles one .bitmap per invocation, you really
>   want just one big one in the shared repo. If "git repack" in the forks
>   started generating one, that would be surprising and annoying.
>
>   In practice this is a pretty extreme corner case. And a lot would
>   depend on how you're using "repack" in the fork (e.g., a partial
>   repack would know that it can't generate bitmaps anyway). I'm pretty
>   sure it would not even impact our setup at all, but I can probably
>   come up with a devils advocate one where it would.
>
>> I am somewhat tempted to make things more exciting by merging it to
>> 'next' soonish, but I guess =C3=86var and you are not quite ready for
>> that excitement yet, judging from the following (which looks quite
>> sensible suggestions)?
>
> It's OK with me for this to go to 'next'. Note that the other two
> patches from me could actually graduate separately. One is a
> straight-out test fix, and the other should always be a win (and does
> nothing if you're not already generating bitmaps).
>
> By the way, there were some timing puzzles mentioned in that second
> commit. I re-ran them today and everything was what I'd expect. So I
> wonder if I just screwed up the timings before. I can re-write that
> commit message if it hasn't made it to 'next' yet.
>
> -Peff
