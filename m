Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47116203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbdGXRNF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:13:05 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38228 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbdGXRNA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:13:00 -0400
Received: by mail-pg0-f41.google.com with SMTP id s4so59614403pgr.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SGFgvKoAaZI/TzQEW1fAZRdS2expiMdD+QqbXBcDqKE=;
        b=hsY4Not6ttbmxrTVnacsLKnkPYc7eE8yS2TON9F+8mA71qSZTVtmv69OWVcfuM7RfF
         riOJRZvYIzEBSlegaHB/C5DMkbHEYarZwJOzaVfuLGMUP2QWJ2LDzSDb6q3nveNHMRGf
         kliur4/nHzGgFqKg3f/3+1Rn0tn3muwhtdMo82Mq7tpEXndDakSM3DFoV6p4tlLEoBVZ
         dvsurM8bzepHBRgYcMdF36iAW9fVDj5mzqyPG5LsUEYlYeQIfIJlld9hE7x105TWuH+9
         vuViK/6UpUbAkARzanq7tyYVvZJuocrxGbBV9Sy7eFKZVDKcsrZ3Q6W2krKZHeOdgEZB
         3wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SGFgvKoAaZI/TzQEW1fAZRdS2expiMdD+QqbXBcDqKE=;
        b=Hr/DtACt2MbemkFccxkMprsJB/bhIhPISd5TpB1kswBL2Z5tY4UDILPGXZSE6blqPO
         EPMfLZZo3uDF9fatuhKfKNGSUTbROD86bO/D3n9SBbWuaD1OoZ8Z2p47eXNYu8M9d9ss
         jjZwqAcc7YnbtBTS6WAlnx4t6m/WPBETmcemSGc2yOZ5FDPeCUDqCNkyZ3h61sailm/v
         SfAWyd3t8eEs+jgdBc+GpNu2/QNVpa6Y2NkW3F7v4mbnpzd/FmC6u7WwaQNaIfIafm/b
         qso4sfGbIW1HqCzNi2qUPLJHZTyS9LNrFZ7DwE5YWMR5HyR2BrUDSpNKH6szkiJib2P1
         LMCw==
X-Gm-Message-State: AIVw1102RX13E+YsmRX+8JRJcYZvyVba/l4L/2e50Gm1V8HXTu5Ofclk
        dQf5T6bORtjtjF3ARo+ZDYQFAeMNqxFd
X-Received: by 10.98.12.145 with SMTP id 17mr16574711pfm.153.1500916380101;
 Mon, 24 Jul 2017 10:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Mon, 24 Jul 2017 10:12:59 -0700 (PDT)
In-Reply-To: <20170724170813.scceigybl5d3fvdd@sigill.intra.peff.net>
References: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com> <20170719181956.15845-1-sbeller@google.com>
 <20170719182342.GA158344@google.com> <20170724170813.scceigybl5d3fvdd@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Jul 2017 10:12:59 -0700
Message-ID: <CAGZ79kZafHBJOVwZzw_ii3T6_X24Uci4vUudp45r8-GTn0a4Sg@mail.gmail.com>
Subject: Re: [PATCH] objects: scope count variable to loop
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 10:08 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 19, 2017 at 11:23:42AM -0700, Brandon Williams wrote:
>
>> > object.c: In function =E2=80=98object_array_remove_duplicates=E2=80=99=
:
>> > object.c:404:2: error: =E2=80=98for=E2=80=99 loop initial declarations=
 are only allowed in C99 mode
>> >   for (unsigned src =3D 0; src < nr; src++) {
>> >   ^
>> > object.c:404:2: note: use option -std=3Dc99 or -std=3Dgnu99 to compile=
 your code
>> >
>> > Using -std=3Dc99 works for me.
>>
>> This would need a change to the makefile then wouldn't it?
>
> Actually, it complicates things even more, I'd think. We probably can't
> just blindly add "-std=3Dc99" to CFLAGS, as not all compilers would
> support it (even if they _do_ support this construct).
>
> Interestingly I have no problems compiling it here. I wonder if Stefan's
> config.mak is supplying -std=3Dc89 or some other restrictive flag. Or if
> his compiler is a different version (though I tried with gcc-6, gcc-4.9,
> and clang-3.8).

Before this patch, I only had
  CFLAGS +=3D -g -O0
in config.mak (as I switched working directories recently), I'll throw in
  DEVELOPER=3D1

My compiler version is ancient (gcc 4.8.4-2ubuntu1~14.04.3)
apparently (why did I never check in this environment?)
