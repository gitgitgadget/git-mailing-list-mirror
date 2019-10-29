Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF4C1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 19:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJ2T6C (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 15:58:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:38647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfJ2T6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 15:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572379070;
        bh=uMTP2lbzQ46F0Q75+69ftMqPiA6WUgVzNI9ky3UXLlw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DQJNlij8dZNPgMStr5TqdVov0xv1DOLcfXSpnbRpc5WK8ngWmet1i/Ze7GHSIXzG0
         4SKr9TleJRokFEijRpSDzYTQ1t2jUdJkFP4OUyZ9huVq6x6q4CYgXhuQVqzmGEGnRv
         XE7HKqKaRi/nRR/fQ2UkIkvnR4oeAByBBisvflEg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1ibxhI3nJN-00Panm; Tue, 29
 Oct 2019 20:57:50 +0100
Date:   Tue, 29 Oct 2019 20:57:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
In-Reply-To: <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <pull.428.v2.git.1572356272.gitgitgadget@gmail.com> <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com> <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F2O3y2lmXY4hZKQHrMRy3yAdOj2JMd/11mmu0IrvCAu+OQdq61F
 2A4Rb+rgFvRkzEsqkQB0zGtCTS7airMWVdCgPtfCGVG/LAhCTB5LimHkTmEeSgJaIvS/Of4
 Pbb9OksQptldfvdW8LiTDgzwdlr4qXUUzcmMOZybbla2ewFOnwnir/rSmSgcNlRGDnRBStR
 anhLDiHse0jyA4g3MGZ2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HzzCacWs5z8=:evjtjFWELZhkNrWprfqOI7
 n9FhoFUgZQ5aFDdo4UyprXgJSCNjXS4QrqZKd8QSsLUy9vGawQpDMrZQ5qm6psMBbcXNly0Wt
 9/LzHZdZw98STm+DH260Zbz5YAnutjgXH6EngdgyP2fBY2PNPfZoZfrasTTuIpHQsu3tyytHs
 m23t3A1pQsuVZkEavtf7jLd8GV9ozn1muWKGB1ivWzj/aXSE1nFMYxggUteY003ZWEdOoPBiy
 jg6XIe/YRbPZ8PASbnRAYZHJWWZOxfTqwmeHcr+zBYNHLtnhglLNSfE8ky4HbrLPCtwVlrGsZ
 5wwm/9ey+fBzENGVHnbFMisK3EkK3cvH1yBBbarR4nzM0D/48PSCd6Hi1zLGZa0BhivVwsw8W
 ilFcXm+VlOqgJ8ZLP103o3NOV8/vKJzTKMN19V4ZSvGzDrrtBA8uywk0L8e3qCZ8cj31v/kSa
 90HLnspuzfqGJiABtcQIWRKPuDMawTNf0ybPHccBDno5I/d8ZC3x00EUvhEsuLZliZIn5tUhG
 osi1HBGNCRmobtCl3QUF+nbNZfC7yGpP213C9N32FDPbhWytc7ulO6yGGrOovZI1JMnjxmyts
 o+plPX/vKdWRYdS8/qocVLe18hrdsLukHIKug3LV16m+gs+MHNUJScethENlXy2ne7/eSjv6f
 VLjnFfxhgIJIewKFHMnq5LY+tkI4ZbJwgekQuEekFXSI5LfRcE7VWo4nKw1OWLThONgDQH+AJ
 /KQ6t6HrAQXFQVIG4PZ/PACxQHJMU1i9xqmsezGHyKKaK2eGY+O2pVCnDm7WRWQ16lLzyzBvZ
 7L/EVGEpgPKrF1tbWVIJwBkyqMcxTxfAzKS0mmqVoje4NvLfk04pKacwz7RHLP3/N27Al9FPY
 rxqLeQftHWYOLBq5ADlaoIBvHm3x7bCjzbxjDMREwwUKg47QOiKjOR5487buNRpZoepBgXrgv
 brsDsVGSgz8WuuU5SEA0rpzeRoQHsRpRmlHrvlMVg4sBZCY31tSS5cS5buR3cI/bnFLY/bkKB
 /HN9KtMC3oZKP+EPqvuu3VNRdm7euY0ppzIZxQYe4U2Noe8drtfLGDT+bzyiNZ8HmVQVUWRoF
 HCOcZHX+L5mh22Pp7joLhCfSjKbXfyczA14qwYP00yEDEVPDSwD2ab4nODKp3SLw8k1VjLrFl
 /DBcwh/NBrh3WrNV+YI9MwhvTaMAhW5ZhtEOokvMcEidOrXzBClquhR7hQvXvKpTrOLltMsO6
 lvwiYPdETjeolwHNidF2HuBrDnHGH4StXtgzAqMFcbW5eP5F+0VX+MTVxfzk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, 29 Oct 2019, Alexandr Miloslavskiy wrote:

> On 29.10.2019 14:37, Johannes Schindelin via GitGitGadget wrote:
>
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > -	for (p =3D msg; *p; p++) {
> > +	p =3D msg + off < pend ? msg + off : pend - 1;
>
> According to my understanding, this is undefined behavior:

It is not entirely obvious to me what exactly you mean by "this",
assuming that you refer to comparing two pointers via `<`, I agree that
this is not the best idea, I changed it to `off < pend - msg`. If my
assumption is correct, however, we are still talking about C, so I
wonder how this C++ document you linked could bear any relevance:

> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3242.pdf
> ... Unless both pointers point to elements of the same array object, or =
one
> past the last element of the array object, the behavior is undefined.
>
> > The MSVC runtime behavior differs from glibc's with respect to
> > `fprintf(stderr, ...)` in that the former writes out the message
> > character by character.
>
> Can you please preserve the research text about fprintf() behavior on
> different platforms that I provided before? Change formatting to what yo=
u
> think fits best.

Quite honestly, I purposefully refrained from copying that information.
While even the following paragraphs are incomplete by necessity (there
are many more standard C libraries we try to work against, e.g. musl and
newlibc, and it would be insanity to try to cover them all in an
analysis of stdio buffering), the only finding that is relevant to the
patch under discussion is that MSVC's runtime outputs to `stderr` byte
by byte (or more correctly, character by character, I guess), and I did
mention this in the commit message (in the part you quoted).

Thanks,
Dscho

>
> fprintf() has problems with any buffering settings
> --------------------------------------------------
> 1) If `stderr` is fully buffered:
>    the ordering of `stdout` and `stderr` messages could be wrong,
>    because `stderr` output waits for the buffer to become full.
> 2) If `stderr` has any type of buffering:
>    buffer has fixed size, which could lead to interleaved buffer blocks
>    when two threads/processes write at the same time.
> 3) If `stderr` is not buffered:
>    Some implementations, such as VC++ and MinGW, literally disable
>    buffering and `fprintf()` will output char-by-char, which leads to
>    unreadable char-interleaved writes if two processes write to
>    `stderr` at the same time (threads are OK because `fprintf()`
>    usually locks `FILE*` in current process).
> 4) If stderr is line buffered: MinGW/VC++ will enable full buffering
>    instead. See MSDN for `setvbuf()`.
>
> fprintf() behavior in git, per platform
> ---------------------------------------
> 1) libc - large outputs can be block-interleaved
>    fprintf() enables temporary stream buffering.
>    Code references:
>        buffered_vfprintf()
> 2) VC++ - char-interleaved
>    fprintf() enables temporary stream buffering, but only if stream was
>    not set to no buffering. This has no effect, because stderr is not
>    buffered by default, and git takes an extra step to ensure that in
>    `swap_osfhnd()`.
>    Code references:
>        _iob[_IOB_ENTRIES]
>        __acrt_stdio_temporary_buffering_guard
>        has_any_buffer()
> 3) MinGW - char-interleaved (console), full buffering (file)
>    `fprintf()` obeys `stderr` buffering. But it uses old MSVCRT.DLL,
>    which eventually calls `_flsbuf()`, which enables buffering unless
>    `isatty(stderr)` or buffering is disabled. Buffering is not disabled
>    by default for `stderr`. Therefore, buffering is enabled only for
>    file-redirected `stderr`.
>    Code references:
>        __mingw_vfprintf()
>        __pformat_wcputs()
>        _fputc_nolock()
>        _flsbuf()
>        _iob[_IOB_ENTRIES]
>
>
