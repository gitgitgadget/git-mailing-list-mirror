Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3981F462
	for <e@80x24.org>; Wed, 19 Jun 2019 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSTzu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:55:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFSTzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560974126;
        bh=PqCO3VxKnJqhJ/nD1/GXt5pFdHWIeDCw9stZxHjFT+0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D3iZ2fKNZ908jQGQGgS4ayXaUbzDkzT5n6O6QgHjJOj39am7XBzg8AxRWtNbMBIuG
         1CVQn8cpcd8+6S17wLhADpjXZZyqsKvNB8a7KLWoGl8KaXNOcw2AzNskcuqJFgFjx/
         ix7pzEgj9Ajh+OZN7QX2azaKHZC8wo/zK/0i5RRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV30j-1i7l4t0yIn-00YUwm; Wed, 19
 Jun 2019 21:55:26 +0200
Date:   Wed, 19 Jun 2019 21:55:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
In-Reply-To: <20190618170416.GA14636@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906192119380.44@tvgsbejvaqbjf.bet>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net> <20190616185330.549436-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet> <20190618012943.GB8877@genre.crustytoothpaste.net> <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
 <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet> <20190618170416.GA14636@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KoW3DQY9iIDjmgEdy2UOKw1+PYSaoRVAKdoHl7hX5SM3jZwE3Ip
 S+av7o4JzuAC2UpNIvC0OWqguplpivSe+DTnNAwunMa9AulyBC6grwZrZpqG5eG9QhOn62L
 BrwdGTl7MceypZSX1Z4v3/7P2lKK8abzURkbqrgK4192IGwEYTlxsX5ZATv0ntgSCzH5hsv
 48Mm7RSs3XInXqivTjazg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0w2s5tqGfpw=:YwJ+WP1UmkCKg1UxLJQEbr
 HNAhYt7lvw+Bn/FQEXMpkpNAgqmRvZrfFEpFbUK3whitB3A08XixEgHm+hQIQRn2lwAUVET4r
 N6rVTobY3ccxBDM4ZMBhBh9LdURSs6f7vWAkYanfMpmzL6/QL8UCMHBi2rkeW8BiSggFiaojE
 4iPVwKiCKTFXalzXHYUl6ZFrkPA+DgdAhYpjt3QDqX7LCQ2sGYlcT9+3zip+WG3wJndbjx47B
 2ZUOKftI/UsssZGCEoYSZ4o2e19gWb5NW/OAZfgba6C1yFKWOkcFklDJxK76Hm4HXd1YQv/Iz
 MqzN53BudF76kW14NTPtnYTbUz4eAZUq4skDjS/0DdlH6Zvib3uHVY8wd/qgHuEkAsyzAf1vE
 abWqWeVALXyliNdIIqBqIB8UTDcSFzc+SUL5+/WjrasQ1w7LtuBfIZVEngL03LUjk9rWqCAHz
 //VGOWDMWqrupmpl5ApWV79mi7gbBMOIjGBjxLUggyZiDqxinTS7SDEuNt3SWJ0czOLZIFXFV
 Ssj9qBYKmCU5+3b+K4tPWO/lzs/OIFu0IAOfVs8P2+KWfR4zc5dDALmLaEiHa5rcAS94omMK3
 mOMWBOoMmxTFhF15SbztnAI37vYKioaQeASnxhaZ4FN5KqdJWzfGG2QruDcUQsiYMjs3tWVAR
 qRnH16SxIYqz1x225j0+xBTXG4MLO8Rh40HvYXG+rWSSsKQQPT2AMoIYE6RXqlwQ+XeiPlryT
 2PQc1Y4sGwgIdSrsREiSsNwrqzATeV2QnSLJilUfmNMOTIwroq9lG0pWA3jLNLJKMNB8qgh3/
 neIQWZ8kvPSrNWyqycHcar3JRG7yIYCKvjCxVciczDhD67VznWTheYlQc298Feo3X0b7lVTJF
 6/lY/ji1+e0cp/0PkPXkEhtRAAApkqRuBzThpwdSSU5aERboRxvjig6aOV1WlOcCIjqnVi0zZ
 yDhaV5/J1RWELnZBxOCxFy5fhhQdHFyZAnYZVjq2C1+eaVNfb13f3
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 18 Jun 2019, Jeff King wrote:

> On Tue, Jun 18, 2019 at 06:15:46PM +0200, Johannes Schindelin wrote:
>
> > > And looking through this patch series, I see a gazillion of *new*
> > > process substitutions $(test_something...) and $(basename $whatever)=
.
> > > Can't we do something about it?
> >
> > I wish there was. Unix shell scripting has not evolved much in the pas=
t,
> > what, 3 decades? So I don't really see a way to "pass variables by
> > reference" to shell functions, short of calling `eval` (which buys
> > preciously little as it _also_ has to spawn a new process [*1*]).
>
> Really? An eval can impact the caller's state, so it _can't_ happen in a
> sub-process in most cases.
>
> E.g., if I run this:
>
> -- >8 --
> #!/bin/sh
>
> # usage: test_oid_to_path <var> <oid>
> # to set the variable <var> in the caller's environment to the path of <=
oid>
> test_oid_to_path() {
> 	path=3D"${2%${2#??}}/${2#??}"
> 	eval "$1=3D\$path"
> }
>
> test_oid_to_path foo 1234abcd
> echo foo: $foo
> -- >8 --
>
> it all happens in a single process, under both bash and dash.

Oops. I think I may have read too much into the name `eval.c` in Dash's
source code, I assumed that it was all about the `eval` command. But now
that I look at this again, I see:

/*
 * Execute a command inside back quotes.  If it's a builtin command, we
 * want to save its output in a block obtained from malloc.  Otherwise
 * we fork off a subprocess and get the output of the command via a pipe.
 * Should be called with interrupts off.
 */

void
evalbackcmd(union node *n, struct backcmd *result)
{
	[...]

I saw this at
https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/eval.c#n608

So this is actually about `$(...)` (or the old, non-nestable backtick
version of it) and not about `eval`.

And of course I was also making another incorrect connection to the Perl
command `eval` which allows you to catch code that `die()`s (which *must*
run in a subprocess).

So yeah, I guess `eval` would work here to avoid the `$(...)` constructs.

Sorry for the noise,
Dscho
