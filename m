Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E22202BB
	for <e@80x24.org>; Mon,  4 Mar 2019 08:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCDIyV (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 03:54:21 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36184 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDIyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 03:54:21 -0500
Received: by mail-ed1-f54.google.com with SMTP id g9so3564692eds.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+xeRS4IiLDFkyuIb9Ez9xYy9ByL/MSXatwYo8Fk0og=;
        b=Kjibnw2kun1WC7/oO/5XdASUIs+NpZsgZJDZCIeng+JBa0D4N7o+/g/wcl/01Xkjv8
         E41VIaQ/ZfC5X7m1O8q36lfgVchnZ/FPXYiureHX3G+mFrPE7DoFRCEvp0L9zVI2aALw
         DQltsDGOPNSMdnlLcilHW2rti04fHEL/cgPr0qVkkR/h2hB1+c5/bl9aEXXTF6ANp5u0
         0AF6LbwUxhFab+YCe1LIvoxRFP9V8Zh3+9w2IOHBk41RfEX+jM11qrJr+hvOADxOy2ly
         qx7sVoe4uTRnfS1mLCYe+5QZrIpnUG0zWnj9kjbVAaCoRT5lxShNQN69HJwL2AW2nbHh
         CX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+xeRS4IiLDFkyuIb9Ez9xYy9ByL/MSXatwYo8Fk0og=;
        b=iCRGpTLVsM2AAnZvX98QIgNqxz7iX8X5Rm0Jq7WQg7l3ItEbohulOvm0P4LvNYP+Um
         I+ZgAlZdPXBrhXhKJEMPlp5fKmL4ZZfpPMOqKZNYDUSFWuHKbGy9k7TvHrLFLZiB1Wk7
         Qddjx4ANl4poE9rlcdkyONHwb4tBQzRIW9ZtzPFw0nCQ/CphglzMvj7ZPJsLLmd7MNvz
         bigcHsrByRSa56ePFrnb67OP2TNcKzNq50eZ3Zqkpp2Zm/MWjgqJJh3+uyHHdarA68+9
         xcwJ2gNbTlS2gYIn50oDdkQzIQ61hhlu19WhrV2yG/GV0w/CegYKXzS4St8DyMw1SBRD
         fBFw==
X-Gm-Message-State: APjAAAVNvf0KgstDRyRfhuHY7vriUEecIliaibwymXyg4TVHMNspFWEX
        cyuO1cAYSDAZDmQtezzLgmJc93gEH81Hh9IipR4=
X-Google-Smtp-Source: APXvYqyQ6gbsgAX4Z43Yp06KN8e5x/Tqw6gQPxgCN1JIiQvQuT55SLZwsU9iJk95I952zABK0naAnula7ANEWMhWLs8=
X-Received: by 2002:a50:9156:: with SMTP id f22mr14821095eda.131.1551689658730;
 Mon, 04 Mar 2019 00:54:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD19521P=-R1XEdRK++HPatt3BJaxWPvpPRo8LHr3eisjA@mail.gmail.com>
 <20190225234528.GD16965@google.com> <CAP8UFD1tKNFO9wU8CbgNnSnQyvHYPsZMk1Bit2y1jxH4vk62qQ@mail.gmail.com>
 <20190228232108.GA163714@google.com>
In-Reply-To: <20190228232108.GA163714@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 4 Mar 2019 09:54:07 +0100
Message-ID: <CAP8UFD3SWNu=btPxV2vV=neYrofbgKPzz_WLvsJbv6bKjRoCpQ@mail.gmail.com>
Subject: Re: [WIP 0/7] CDN offloading of fetch response
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 1, 2019 at 12:21 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Sorry for the slow followup.  Thanks for probing into the design ---
> this should be useful for getting the docs to be clear.
>
> Christian Couder wrote:
>
> > So it's likely that users will want a way to host on such sites
> > incomplete repos using CDN offloading to a CDN on another site. And
> > then if the CDN is not accessible for some reason, things will
> > completely break when users will clone.
>
> I think this would be a broken setup --- we can make it clear in the
> protocol and server docs that you should only point to a CDN for which
> you control the contents, to avoid breaking clients.

We can say whatever in the docs, but in real life if it's
simpler/cheaper for repo admins to use a CDN for example on Google and
a repo on GitHub, they are likely to do it anyway.

> That doesn't prevent adding additional features in the future e.g. for
> "server suggested alternates" --- it's just that I consider that a
> separate feature.
>
> Using CDN offloading requires cooperation of the hosting provider.
> It's a way to optimize how fetches work, not a way to have a partial
> repository on the server side.

We can say whatever we want about what it is for. Users are likely to
use it anyway in the way they think it will benefit them the most.

> > On Tue, Feb 26, 2019 at 12:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> This doesn't stop a hosting provider from using e.g. server options to
> >> allow the client more control over how their response is served, just
> >> like can be done for other features of how the transfer works (how
> >> often to send progress updates, whether to prioritize latency or
> >> throughput, etc).
> >
> > Could you give a more concrete example of what could be done?
>
> What I mean is passing server options using "git fetch --server-option".
> For example:
>
>         git fetch -o priority=BATCH origin master
>
> or
>
>         git fetch -o avoid-cdn=badcdn.example.com origin master
>
> The interpretation of server options is up to the server.

If you often have to tell things like "-o
avoid-cdn=badcdn.example.com", then how is it better than just
specifying "-o usecdn=goodcdn.example.com" or even better using the
remote mechanism to configure a remote for goodcdn.example.com and
then configuring this remote to be used along the origin remote (which
is what many promisor remotes is about)?

> >> What the client *can* do is turn off support for packfile URLs in a
> >> request completely.  This is required for backward compatibility and
> >> allows working around a host that has configured the feature
> >> incorrectly.
> >
> > If the full content of a repo is really large, the size of a full pack
> > file sent by an initial clone could be really big and many client
> > machines could not have enough memory to deal with that. And this
> > suppose that repo hosting providers would be ok to host very large
> > repos in the first place.
>
> Do we require the packfile to fit in memory?  If so, we should fix
> that (to use streaming instead).

Even if we stream the packfile to write it, at one point we have to use it.

And I could be wrong but I think that mmap doesn't work on Windows, so
I think we will just try to read the whole thing into memory. Even on
Linux I don't think it's a good idea to mmap a very large file and
then use some big parts of it which I think we will have to do when
checking out the large files from inside the packfile.

Yeah, we can improve that part of Git too. I think though that it
means yet another thing (and not an easy one) that needs to be
improved before CDN offloading can work well in the real world.

I think that the Git "development philosophy" since the beginning has
been more about adding things that work well in the real world first
even if they are small and a bit manual, and then improving on top of
those early things, rather than adding a big thing that doesn't quite
work well in the real world but is automated and then improving on
that.
