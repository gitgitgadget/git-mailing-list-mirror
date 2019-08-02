Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4197B1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 12:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfHBMjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 08:39:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:57721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfHBMjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564749572;
        bh=cEp6oL4nMPmyG8WehgkptPS6muVS/LXuzGeCPBfn87I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jOiChkLUf0882cUlvsmpvNYoakrOGCZ87h0cFy+T+bMzWNcaHPI3PoYPZfm3Xync5
         9tgM6qrMMtuSGyXJy0OrTUvRBOVRHSQeFqFW0TvYANSNV3cewqRsboIEin8qK1NfRl
         cBQiAyYG9ACd5Ze7pkRHTngJUTPQU41oJLZ8rgI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1iWj100mJy-00fQeD; Fri, 02
 Aug 2019 14:39:32 +0200
Date:   Fri, 2 Aug 2019 14:39:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
In-Reply-To: <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
References: <20190728151726.9188-1-me@yadavpratyush.com> <20190728213634.GB162590@genre.crustytoothpaste.net> <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com> <20190728224943.GC162590@genre.crustytoothpaste.net> <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com> <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet> <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jtfGCY5ftHc+xps08Oioat3uIkbWwjhZe9oP8Q5JDIELpfujV+4
 4BjTQoA2DMdvjO/5r5ZsiiRdpivzmZEcsQJgqKr9o/bpDmwHnsHJ+W83+XW+DT5TGX0q1j7
 HFz6xuO2wf4Og5VK5i957lWjPEHtTgbF1goq67aNJjHo12zZSc0jMw8cLwyBN7A9m1F9VTd
 RfCUxZJ7Fl+aAxM6ah5zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNVr2aKDvcs=:aIYKezVWPaDkMf/qeyV1pN
 +zL3ZTkF1Q6mi2SZwQsfw9n7OhIeyYQ02sgkhhOlxwRWo8/G0A5gtu3ZwRcNla2mRIB9HacGY
 3fKs+BJ3+6WDHBMSJFa7atWeBRKn95itGR2bM4vnRjEG0YIEa9lVUQxb0uUJEQzUWSwjhiDnj
 ULxoJ+eQz6Xx1NmcIsWZJzoXvrZvfZu7hDJknTpzM1sgsPg2FDvhI+4nkNYQFR3jMEpcmJ9se
 46feZ4DiU3AhDaBHuQvUYMBPQLSgnM9kM3E0xHG0AWZ4ZBy3wDyVUJYfogPNY+tOFRXtlC5Nx
 xz1BMhaplqa35PtfbCiZufthuEePpLo+1kFts1ro3PX2CZchx7fdBj87zJZqQWj0gO1xD0iY/
 Idh7ICAp+Uiw+lSZcQEJw7e45jH/GI8IF9Rd4fYcgEivD19oiuuJpmBCzdnFefdOaKEyGuYhE
 j9YLNzQjtdENiSOXg7ylU1oo9Y+dNdkZG7z2TW9k81F6t++gw2JNGCzefPzFbuSct57ktFstx
 WcGyhVTlxHqCVVWwbX7oEZxgICQRMa6xZQQ+P0t22O8mwe+WSXZEpSYpQkjOC4LW5xAq+ajdt
 3BqYnnXxH3jvK/TnsKBVU0PrEv2DwAGlolM9hMU4NyEeH64W7mOmC3wDP/wDUt1tKZac4jZhH
 gKWflARDnLgvTB8L2S3rPrc0VA0+73SMXZbIRDSQKqKyX7VH+t782OhibEJU5uJD9oytrJ6Hk
 h/jRqucdDO3U2a2gc5WKjdERNirKHxG9HAX2Nn1OfWVTCQ//38Hc+PBhqmq0yGsS7GZvc2ABb
 QLpJ12sV0OQCphB8APBN3gpbKt7u98JZm4XN63LjvrL0vop9nxtl0E5YmUBWggB4iuFBjIXak
 Gg4GODlArrODpSSD4gCwbfWlSGj+5XVRJ5P+iPexTRdRZZKqhuOGNByHAR3lQ2gzWr/Q3sxuM
 9RVTJcCq2z3UBgaW1tdewA17BfB97jXVoBeMR3iSdfuEfh5eSOL5c5pJYX0LZpfdYTlV2pyO+
 /QiU/k30OtjmODSCA2wES4zthka5EX/6khxfNVYrHrZ2YsGe5YwJYvTiSEFp6P9bkvarB5shF
 vupE5xR1NgXbDEXTpPayA+DY9Ft5omvKL43JPG5dzFiVTKPovzABjy6RabVO4x9mDkOtt5rE6
 27Pvo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2 Aug 2019, Pratyush Yadav wrote:

> On 8/1/19 1:12 AM, Johannes Schindelin wrote:
> >
> > I would be _extremely_ cautious to base an argument on one
> > particular setup, using on particular hardware with one particular
> > OS and one particular repository.
> >
>
> Agreed. That's why I asked for benchmarks from other people.
> Unfortunately, no one replied.

What stops _you_ from performing more tests yourself? There are tons of
real-world repositories out there, we even talk about options for large
repositories to test with in Git for Windows' Contributing Guidelines:
https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#perform=
ance-tests

> I am worried about exactly this problem that other users will have
> performance problems. I usually reserve judgment till I see some
> actual benchmarks, but since in this case we aren't getting any, it is
> probably better to err on the side of caution.

Well, you proposed it without testing it first e.g. on Kotlin or even
Linux.  Personally, I would have chosen Chromium, as it is a pretty big
one.

Maybe you want to do that now.

> > When it comes to repositories that are worked on actively, git.git is
> > not actually a representative example, it is way smaller than what use=
rs
> > deal with.
>
> Out of curiosity, what would you consider large enough? The Linux kernel
> (855,753 commits as of writing this)?

As your patch is about refreshing the Git GUI, the number of Git commits
is irrelevant. The number of worktree files is relevant.

Unfortunately, you cannot search for this dimension on GitHub, but you
can search for "repository size", which is at least loosely correlated:

https://github.com/search?utf8=3D%E2%9C%93&q=3Dsize%3A%3E5000000&type=3DRe=
positories&ref=3Dadvsearch&l=3D&l=3D

Personally, I would probably have chosen either of these, for testing:

* https://github.com/chromium/chromium
* https://github.com/WebKit/webkit
* https://github.com/raspberrypi/firmware
* https://github.com/MicrosoftDocs/azure-docs
* https://github.com/facebookresearch/FAIR-Play

> > At this point, I am gently inclined against the presented approach, in
> > particular given that even context menus reportedly trigger the re-sca=
n
> > (which I suspect might actually be a Linux-only issue, as context menu=
s
> > are top-level windows on X11, at least if I remember correctly, and I
> > also seem to remember that they are dependent windows on Aqua and Win3=
2,
> > just to add yet another argument against overfitting considerations on=
to
> > a single, specific setup).
>
> All right, the patch in its current state can't fly. So what is the corr=
ect
> way to do this? I see the following options:
>
> 1. Add this as an option that is disabled by default, but people who don=
't
> mind it can enable it. This is the easiest to implement. But I leave it =
to you
> and Junio (and anyone else who wants to pitch in :)) to decide if it is =
a good
> idea.

That would probably be much easier to get accepted.

> 2. Watch all files for changes. Atom does this for their git gui [0]. We=
 can
> probably use watchman [1] for this, but this adds another external depen=
dency.

I am currently looking at watchman, and it seems that it has its own
performance issues in big repositories (for which it is actually most
relevant). Besides, Windows support is kinda flaky, so I would rule this
out (Git is supported on many more platforms than watchman supports).

Besides, what your patch wants to do is not to know when things have
changed. Your patch wants to refresh the UI at opportune moments, and it
is unclear how watchman could help decide when to refresh.

> 3. Leave this feature out. I of course don't like this option very much,=
 and
> will probably have to run a fork, but if it is better for the project, i=
t is
> better for the project.

That would indeed be the safest.

I wonder, however, whether you can think of a better method to figure
out when to auto-refresh. Focus seems to be a low-hanging fruit, but as
you noticed it is not very accurate. Maybe if you combine it with a
timeout? Or maybe you can detect idle time in Tcl/Tk?

Ciao,
Johannes
