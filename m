Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA80203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcGYV2y (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 17:28:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33206 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbcGYV2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:28:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so18548390wme.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 14:28:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HvQx3dgnP+oOptGYkLotN5ljnmE6RyiOt2sw/LSR4HQ=;
        b=BfoQtWI1aCZJ9AGA+FyI5fdCxDeK+RgQfa15NlRj35uCK2cA0x8lIMqOs9sKreWRU+
         Ufir/ebjwLAllULW2loOqbnWa0ojLSANcWqA1Y3EYkY132w+C6wDhPRWVz+5MADy+/ZP
         KIxjoaz8chZen2yMHMXrRxpTk51DtFrDNPhceGUbKVpEDcrRTTba9NE7t1A1YCu4M4GA
         RXoVRj5MaMH0QQVz1NsPSZeyQnXrUvb5+Ica4Ataardw7ZFyjF083UEVxMgyl9lT3k9v
         +zaPb3CWiYuPELnZZhRfGRbnXWxoQ7juBUlROKHDUR7DwOWaofyJV9JM4OfCG6+ZL520
         5kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HvQx3dgnP+oOptGYkLotN5ljnmE6RyiOt2sw/LSR4HQ=;
        b=l+OhVUY8CP8CrZok8fDv6l8Ote/K4uDTNYULguBNqTUO8G67WSa2xGIks1SlU2gP5F
         BymL44D3oYjbixSIleMg7oAQy675PIp92Jqt+/r+btl/9hlm4iIrcqhW0c7NQGhGHlCW
         AhEz3+qdbrYIpGsFLtfiGsFeMieWAOluh+SlydbbWts2Jsgyr/g5wmyhoy9bNCi60yOF
         F72319WarrfuajDc/1yGMm/gCfKJSThjrKZn/bg9igvS4/uVjvTZNledGzhEE7qmaFW1
         d549j8/nxzKbFF+Y1WS1pbqR9flm1ryUX15e0JaoSY0XndxzT6VCxD6Wi+s84LHsSyMr
         bR0Q==
X-Gm-Message-State: AEkooutL0x7hwBwi8x5yvobDB5EENeH1YUmRrpAhJSU85o0tGeOEVYAHZLUUoFhnLU1Z5gta/LBCxlze7oR0bg==
X-Received: by 10.28.103.6 with SMTP id b6mr23085828wmc.89.1469482128255; Mon,
 25 Jul 2016 14:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Mon, 25 Jul 2016 14:28:47 -0700 (PDT)
In-Reply-To: <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
 <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
 <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de> <CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
 <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Mon, 25 Jul 2016 23:28:47 +0200
Message-ID: <CAP8UFD2m07QxnEQr+-P0EJoyeORAUjrow8irQK_1U48h0BQD8A@mail.gmail.com>
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Pranit Bauva <pranit.bauva@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>> And why are the defines 1,2,4,8 ?
>>> It looks as if a #define bitmap may be a better choice here ?
>>> How do we do these kind of bit-wise opions otherwise ?
>
> We might want to ask if these should even be bitwise option.  A word
> with individually controllable bits (i.e. "flag word") makes sense
> only when the bits within it are largely independent.  But the code
> does this pretty much upfront:
>
>>>> +       if (term_defined != 0 && term_defined != TERM_BAD &&
>>>> +           term_defined != TERM_GOOD && term_defined != TERM_NEW &&
>>>> +           term_defined != TERM_OLD)
>>>> +               die(_("only one option among --term-bad, --term-good, "
>>>> +                     "--term-new and --term-old can be used."));
>
> which is a very strong indication that these bits are not.
>
> I suspect that OPTION_CMDMODE would be a better choice to group
> these four options and mark them mutually incompatible automatically
> than OPT_BIT?

I must say that Pranit used that at one point, but it felt weird to me
to use that for things that is not really a command.
