Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA0CC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2217360F5C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 23:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhJDX5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJDX5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 19:57:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3AC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 16:55:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f9so8773217edx.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fZss4e3L3tix2DY0ysXI4C7dhMYWNlPfhXxfo1XW28M=;
        b=LBvCUC9rQJRa5EdHNcwzmLA/ug898t2LcA+2lHn8n+6UoAnXwVIoXSYIfdGV+icsup
         7XdDi+pZ3MZoSyqdBDTEfA+GJnSxtxl4TIEXw7tb+VTcV1krI9poIaf/OCK5nw9zz0sd
         3Y8yVSBFOaH+89fHG1QSRQDP0Yot0JfgCNJXfRKLNQ3aCq1fA1Keo4CGnx1EEg1jn+PX
         1IQ45e4zHWoKUayG+dMn+uDB5dQFg9Jnlh/ZVqNXViOIOGL1AqBG7X5Z6L3tI0pwVjoW
         Y8mSrYqNcjECA8xQAERlgmVib0HOEpXp3ToidaWz8ydw8R3BQOdjHfCxyVDGoTmEoK4H
         JRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fZss4e3L3tix2DY0ysXI4C7dhMYWNlPfhXxfo1XW28M=;
        b=WKr9waSLV5ApYoNY0BXSa3z3e5/AHry0HKd5YW15zHojoDkZiRe5AX7zmBCcJ/dktE
         cEkM4GzYidPripnhc6ka66rK9dVbjrk4eP6WZAz01ApbSI9xy5q+NsiuOIVl2ZTexEGd
         6ds5UZES1vfY0tGjju5qGAW1f3lTDmvTThig7bcQksrCLUo9uQobKd5lzSIGONu8un36
         /tL8NcnOEVttYc7GRy/O57ywBdCBi04JXh8u/tbVc7SN9lpsl518HQWNxLdo2zd9fD93
         AycbG26Y7meL7Rq0Zsdjd9vSbnDbh0kPAKKsKR7vFm5GVmmEgtB2ruVE4GDWYl+MMO7z
         pLbw==
X-Gm-Message-State: AOAM530VtIa1SggWXDEeUfSU6lQlg8EWvHlETS1Gb0Byf0G+g1rAlo1N
        9emA/3pvCyzN/nTNk1RtQmh189OMr5J25Q==
X-Google-Smtp-Source: ABdhPJzrLpJtDJ62TX8VQOBbQZr6gM1hWuZu2uEZYVG/GzduFsK422zHdUgP2lmU3XBFSNjw5J9hoA==
X-Received: by 2002:aa7:d802:: with SMTP id v2mr18306765edq.271.1633391720650;
        Mon, 04 Oct 2021 16:55:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p6sm3047739edi.18.2021.10.04.16.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 16:55:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git send-email splits name with comma
Date:   Tue, 05 Oct 2021 01:47:36 +0200
References: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
 <87r1d0svy4.fsf@igel.home>
 <CAMuHMdUk5=sqFvy51nxv5g3UFPhQnZ-6dBOS=xVDWdTxuLKuRQ@mail.gmail.com>
 <xmqqczokwrt9.fsf@gitster.g>
 <CAMuHMdVHuxzKv7z+oVnPXSBi8bLnGMZDcXdgtGR4N15UQttciQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAMuHMdVHuxzKv7z+oVnPXSBi8bLnGMZDcXdgtGR4N15UQttciQ@mail.gmail.com>
Message-ID: <87pmskl508.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Geert Uytterhoeven wrote:

> Hi Junio,
>
> On Mon, Oct 4, 2021 at 8:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > On Mon, Oct 4, 2021 at 4:31 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> >> On Okt 04 2021, Geert Uytterhoeven wrote:
>> >> > If the name of an email address contains a comma, it will be split
>> >> > incorrectly into multiple addresses.
>> >>
>> >> If you want to include a comma in the display-name part of an address,
>> >> you need to use the quoted-string form of the phrase.
>> >
>> > Adding more quoting like:
>> >
>> >     git send-email --to "\"foo bar, geert\" <geert@linux-m68k.org>"
>> >
>> > indeed works.  But I feel git send-email could do better, given it already
>> > receives the full email address in a single argv[] entry.
>>
>> Sorry, but I do not quite follow.
>>
>> If I were to send a message both to the list and to you, wouldn't
>>
>>     git send-email --to "l-k@vger.k.org, geert <g@l-m68k.o>"
>>
>> a valid way to do so?
>
> Oh wait, I never realized --to and --cc take multiple email addresses;
> I also use multiple --to/--cc options instead.
> So the behavior I see is actually the expected behavior.
> Thanks, and sorry for the noise.
>
> Gr{oetje,eeting}s,

FWIW git-send-email just defers to Perl's Mail::Address module here:

perl -MMail::Address -MData::Dumper -wE 'warn qq[For @ARGV got: ] .
     Dumper [map { $_->format } map { Mail::Address->parse($_) } @ARGV]
' 'foo, bar <x@example.com>'
For foo, bar <x@example.com> got: $VAR1 = [
          'foo',
          'bar <x@example.com>'
        ];

As has been noted the quotes are needed, and the same should go for yor
mailer.

Anyway, that's covered already, but if anyone cared to make it
friendlier I don't see why it couldn't be made to be nicer.

I.e. we could loop over the list, use $_->address to see that the "foo"
doesn't even have an "@" in it, and either fix it up to what th user
probably meant, or do so conditionally, warn or whatever.
