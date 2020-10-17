Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA47C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DFE20897
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dq4wUF+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgJRKmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 06:42:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:60717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgJRKlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 06:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603017681;
        bh=Lq3c+DJXtblxQFHNOVmx+VYdqJ5v7lVPga8Mk1zhs4Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dq4wUF+wp+853XDAOsZ1zjWIuepJWR3hoXyZ555AmSfwQUMY+3+42HvPRZurYVy2E
         ajQuLRWIJqOvLA1heou0wrgZdBgQKawOjwAmcn2g2xYyWbt+R6JqU5Cgc+laJJwFYn
         XnLSVgyZeccdPjrdLUsMOTakiLbP/GBlMSYUKo5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.31]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1kiSeT2rAS-00KwU9; Sun, 18
 Oct 2020 12:41:21 +0200
Date:   Sat, 17 Oct 2020 05:31:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
In-Reply-To: <20201013190913.GB2994107@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010170434340.56@tvgsbejvaqbjf.bet>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com> <20201013185515.GA2994107@coredump.intra.peff.net> <20201013190913.GB2994107@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GkIQF5RNmA1Nar/IuYeDSSK4egXsMvQBukmtJ3b7BLtVF0qSubQ
 PQgbufGdqybyElhEzgORdu8vGgAq6G+XTebQiNotPNcNiAtNRMSUnstRwDIn2uvuFJYyrbB
 1HDeWmx03EGdqenQ1pMZz9hPD2bGugzNw8+VO6zG0a/vy97+Zo7/covXjigoHjeK5pYza4i
 +KVTP+sBC338taUmKERbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPCQT6hmcuA=:wvFt6hJkwzHCzhOntV/wFW
 rCL8YRu/b//cuzQfyMpt2ZCzw5SNe11YteLoT3F1jLG2nP9buPEBqILaItTHUq8cQA5HxMZVD
 nqd7w3b09cGcSsw+8KChR7tvTK76lu7jYreOMq6MSgviiqsMVgq77UmBj7zqse6U3ECOYi8+E
 6SvSZmcEJdRgbPpqwfoOhmHC6hMFfA2Mxaj8tk7ehpQUOX3Yj+mRXYtt1JEF9T4Zxvc/xWTok
 ogaSO7B/HNfWl0eGynFlTC1kfrOM/ZMdkzhM/wIJ9BFbJN4y2AbobFpH/rf6Agl2MakAt0cau
 0CKJ+7klcYoc3EFw9KdYuzuAq9cTbnwMauP022BVJNoq8VydAm77vX4v9s4GbXhpsmE4sSey3
 FMU8V6Rn/Oank5TkZWDjUNcUbdqItd8sKClKcEV4m4CT7RFWESWjMKtnzO4IJ7K81xukt/oD4
 rOTx3oi+dwcZfZFvNUK2fVq/ZKN4yNoyUDqeiqbuIEx3eTnmYB/brKSut7h1YY9NRN+HMAMim
 sRf8n+eIPFDp8UvcVMaqS+e54bVx/RUUOu7N4v4Fy7Oa8mwNCs8REjdTKrUkClAiwC285wRJP
 jgJ8bCW5PKTWKd2YoKzfuDLxoMwzr+yeljQ/7Y95HkNcv0nK03pOL8NxX9f66rCGG1SefUukc
 UCAuJLKVvEssIqQDVzpqFNcJyQF2/qXl9tDsmyeY6Afp1OGB1RZ0dPwc/UF5yd6sTRi8uJBRd
 UJM8nShZwNt1M0RijSTZSM9G3h1qSMC9Z26b6sH4wN5cFPC1Xm0CUwKzPbwtIR6O1MmyY7B6L
 X7bO+w4Pbxo6ZfwFaZ0eq/t5JDbA/kJ7tXZ9K5ilAbCwFCMZttux4hVXqkJiOPWvYi7Vl1o/T
 cJ80Tn7gZLWN+tjX0hVryYz1bpNafj4kCnoIOBAjs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 13 Oct 2020, Jeff King wrote:

> On Tue, Oct 13, 2020 at 02:55:15PM -0400, Jeff King wrote:
>
> > But then in fbd76cd450 (sideband: reverse its dependency on pkt-line,
> > 2019-01-16), the function became demultiplex_sideband(). The loop went
> > away, and we pump only a single packet on each call. When we see
> > sideband 2, we do an early return. But on sideband 1, we continue to t=
he
> > cleanup: label, which flushes the scratch buffer.
> >
> > I think we need to return from there without hitting that cleanup labe=
l,
> > like this:
>
> By the way, the reason this works is that the "scratch" buffer persists
> beyond individual calls to demultiplex_sideband(). So we can get away
> with letting it persist between the two.

The thing that threw me was that I somehow expected `recv_sideband()` to
return primary data as it is read, much like `read()` operates. And yes,
I also found the split version of the code (`recv_sideband()` contains the
`while` loop and lives in `pkt-line.c` while `demultiplex_sideband()`
contains the `scratch` handling and the `switch` between packet types and
it lives in `sideband.c`) was much harder to read than the original
version.

> However unlike the original recv_sideband(), which broke out of the loop
> on error and then flushed scratch, our post-fbd76cd450 does not do the
> same. It now looks like:
>
> int recv_sideband(const char *me, int in_stream, int out)
> {
>         char buf[LARGE_PACKET_MAX + 1];
>         int len;
>         struct strbuf scratch =3D STRBUF_INIT;
>         enum sideband_type sideband_type;
>
>         while (1) {
>                 len =3D packet_read(in_stream, NULL, NULL, buf, LARGE_PA=
CKET_MAX,
>                                   0);
>                 if (!demultiplex_sideband(me, buf, len, 0, &scratch,
>                                           &sideband_type))
>                         continue;
>                 switch (sideband_type) {
>                 case SIDEBAND_PRIMARY:
>                         write_or_die(out, buf + 1, len - 1);
>                         break;
>                 default: /* errors: message already written */
>                         return sideband_type;
>                 }
>         }
> }
>
> I wondered if we could ever have a case where we broke out of the loop
> with data left over in "scratch" (or its buffer left allocated). I think
> the answer is no. We only break out of the loop if
> demultiplex_sideband() returned non-zero _and_ its not the primary
> sideband. So both before and after my suggested fix, we'd have hit the
> cleanup label in demultiplex_sideband(), which flushes and frees the
> buffer.

Right.

It took me quite a while to convince myself of that, too.

And since I am really worried that the complexity of the code makes it
easy to introduce a regression, I spent quite a bit of time to figure out
how to implement a good regression test for exactly this issue.

Even so, the regression test will not necessarily catch problems where the
`while` loop is abandoned without processing any unfinished sideband
message. I introduced a `BUG()` for that case, but it is quite a bit
unsatisfying that I could not come up with a better way to ensure that
this does not happen.

> I do have to say that the original loop before that commit was a lot
> easier to follow, though.
>
> Another weirdness I noticed is that it doesn't distinguish a flush
> packet (expected) from a zero-byte packet (an error). But neither did
> the original. I would have guessed the zero-byte packet was meant to
> trigger this second conditional:
>
>         if (len =3D=3D 0) {
>                 *sideband_type =3D SIDEBAND_FLUSH;
>                 goto cleanup;
>         }
>         if (len < 1) {
>                 strbuf_addf(scratch,
>                             "%s%s: protocol error: no band designator",
>                             scratch->len ? "\n" : "", me);
>                 *sideband_type =3D SIDEBAND_PROTOCOL_ERROR;
>                 goto cleanup;
>         }
>
> but we'd hit the first conditional before then. We would still trigger
> the second if we saw EOF while reading the packet (because we set the
> length to -1 then), but then it's arguably the wrong error to be
> showing.
>
> So I think this could be improved a bit by using
> packet_read_with_status() in the recv_sideband() caller.

Possibly. But is it really a bug to send a zero-byte packet? It is
inefficient, sure. But I could see how it could potentially simplify code,
or serve e.g. as some sort of a "keep-alive" mechanism or whatever.

In other words, I am not sure that  we should treat this as an error, but
yes, we should probably not treat it as a flush (even if it is likely that
our current sideband users simply won't ever send empty primary packets).

Ciao,
Dscho
