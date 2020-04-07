Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE11C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49CE2075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YI6qFEMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgDGOar (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:30:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:37375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgDGOar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586269835;
        bh=2+VTyzHYTIOeC60FxrkIJoKRTnpuacVYMuSuqb0qVDU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YI6qFEMOimlMnmMfukymLQrtlSXKDSvm5m89UFbW5EMbL4+RgMfqg1P6AWBZUKzbC
         KqbIBMGK2LWe9he+zdGR7JWslvZi00KVVPKyuqybjs7JUU+D2Mlwlx+fZHdFaclpAJ
         FXZoMa/Fx/ceSSBywqNbhnQnGECWdF1dnPy9KWJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7i8Y-1jHxMH20Sw-014nfm; Tue, 07 Apr 2020 16:30:35 +0200
Date:   Tue, 7 Apr 2020 16:30:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
In-Reply-To: <20200407141600.GA1963@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2004071623400.46@tvgsbejvaqbjf.bet>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com> <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com> <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com> <xmqqimidybzu.fsf@gitster.c.googlers.com>
 <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com> <20200407005828.GC2568@danh.dev> <806dc7e9-9980-2c05-461f-9f3a62598244@gmail.com> <20200407141600.GA1963@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MZVD9CKrHoWlEGHPFjT7pAbE8RYd4B29cIqa9ZJtdmp/G9750Dn
 bpDq4TLHR3/sEQ/HrtFHjnfreHnhkcN3yBb6ADjQx9ce8B71si3Qg1xpaLC0yCLYrNS6s9w
 J2eLFhYbVXYmPqZIfAl0i7G33Qlw3yJ1UMbrjKUSAtWLWIh2U7rTTmfmxCGvGbk8HPTumTT
 RV4X+9JJP91TseU++5iWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:INuBmlT4YQI=:p26XCYCvECXrw2u86xrgLI
 9g7XHXeXyYE5r79j217GrTs5IQjP15TjKxDyfSGFApGD+ZRlBvAkwmZA7PRUisWTqJlcVbG0h
 yTG4v2sKCwptwzMB6bdKTHWnjar50KAwMMZuAT8rjwdlvUtFKhVGlGbne+7W5Qkmc0XXNTv5J
 KMqHPf3Ms6f92vs3BpmgrZg9PvMDWQBgY0g3IHiv02TXYuu5hXDQabBI7aAcHQTJhdRov3FTR
 9RYZddzqOPjIJ3J8UUF0++v2PANl8qIZILl+xRNi9kYEBIoNRxfUMEzQX3Qbrc7Y6AcP0cRdu
 k1ijrKXxIdXG8tF3Kodnwh9jsDPB/SGiZEbsvgGug2EvUi1FrfE/Mh0oOdBj99WixqpH3a1ml
 TGtxqfsEqvg+2Wq43qh/xJxafxXj4uG135X2bfBbqXioNlTutUAG29UGIKU2Ux7S4LnblY4w9
 586ouEbr8PSEDghMaIq50GCgOcGFfVqLLFlpnqVX1LZ/3qJUfujaSu8iXZX6cDgZXRcRNgCjW
 eQfZ37Uas6TFUcwZZCi1luN3I3EcTluj8K4u4GJLEX54P5aMzdpuQOlpVBtDh7UJDNaxJc6hZ
 DWxybzbu+AVnb39WvMsc3LhebBXcTYDPPrbfj5JQ5yJjYWVHOrcffNWGRLYYqyWiDioA/Wm+Q
 EfZnPnZCYvuBK6DH16BVo7ZnDJpjJPbNi9VFTsxxmB/P83Kndo3Nlx+ciM5YnNpIXVfaDgUhI
 Z+v9mV64klwoH7gSXKHq7FlwAQTOWqWyK0gm/rALp5755kCMaqm4Uyy21geAO6dU/ZWN3hInS
 GsFwiIbbcZZHZGicUZiEYbBXQ+6JjaUb/CYBxLZ4a0S7idrHKvTZNGzW+a4JEC9sEBhT9WjmQ
 +N92ZOD/PvYrtDDx9Pd0Wq8FU+Cwb9iuXdcl/6DyyitkIhr4t1AaiDBZ6H32wI15jsjuEBf8D
 BvkOWAnHthsN9tZqHUfW8k9pkXjdKIxTozNFticUoC0NemqVp8u78mRYnSZwllaEb4Cw7m4FP
 J4PwHhANepUc+EEUvQJs+H0QNw0fXWj007jnvGYslrYQTCzjuU1G2VdcNV6v04/6QChiltUzu
 PMuxbjzJG2/EvPPN18A4orfCvBGh0J5rXOPWMDgfZ+nRML1rT1z4PjJWNFnPRIr/hx6gZ0duq
 KLD5EkHKoHBZNi7YvUSUr8RfOEz/7pM4CmOmbxnh3ZLFHhIkGpbdIxdj8hfJHOHF8h9hLNquq
 n2nfraNl1OSlyJ1zvuyrRUwocQnb/XB151spQwQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 7 Apr 2020, Danh Doan wrote:

> On 2020-04-07 06:54:33-0400, Derrick Stolee <stolee@gmail.com> wrote:
> > On 4/6/2020 8:58 PM, Danh Doan wrote:
> > > On 2020-04-06 10:42:23-0400, Derrick Stolee <stolee@gmail.com> wrote=
:
> > >> Of course, not every platform has "cron" but that just means we nee=
d a
> > >> cross-platform way to launch Git processes on some schedule. That c=
ould
> > >> be a command that creates a cron job on platforms that have it, and=
 on
> > >
> > > There's Unix system that doesn't have cron.
> > > People could use other scheduler mechanism.
> > >
> > > A lot of systemd users uses systemd-timer.
> > > I'm using snooze.
> >
> > Thanks for listing some alternatives. I'll look into these.
>
> I didn't mean to list those alternatives as only possible
> alternatives.

In contrast, I think that they are _really_ alternatives, and they are
only options for people who are dedicated fans of fiddling with the
technical details.

In other words, `cron` is a very viable option for a few people who are
_not_ in the audience of this here patch series.

The audience of this patch series are software engineers who _have_ to use
Git, but do not really want to spend their time learning about the
internal details. For those developers, especially those working on
insanely large repositories, we want to provide some convenient functions
(much like `git gc --auto` tries to help developers who do not want to
bother with Git details, but _better_ because it tries very much to stay
_out_ of the way of the developer, which `git gc --auto` distinctly does
_not_) that were developed using the experience with the world's largest
repository.

> The point is people have their own preference to choose a scheduler
> that suites their need.

And they can!

But again, this here patch series is obviously for those who do not want
to tinker with Git's functionality, yet still want to have decent
performance.

Learning from the experience that led to the invention of `git gc --auto`,
there is _a large_ benefit in doing this: `git gc --auto` was invented
because some prolific Linux contributors were experiencing abysmal
performance because they did not want to spend time learning how to
keep their repositories in a good shape, but rather they wanted to spend
time developing Linux kernel code.

> Someone could use their own supervisor system with things like:
>
> 	#/bin/sh
>
> 	sleep 3600 # 1 hour
> 	exec git cmd
>
> When "git cmd" exit, the supervisor will start the job again (because
> it's down and it needs to be run).

Sure. And that would work for developers who are interested in how the
world works, and have enough time to learn about this.

In my experience the vast majority of enterprise software developers are
not really as excited about Git internals as I am. This patch series is
for them. Because they are good people, too, and deserve our care in
supporting them.

Ciao,
Dscho
