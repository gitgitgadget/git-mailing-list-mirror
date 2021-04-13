Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB6C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A37613C7
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhDMT2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhDMT2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:28:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB5C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:27:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d21so628541edv.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wxAgDSO4PHtnyT9YqEInrFwVFPJ40qAdrw7NJDg+OnQ=;
        b=g1CJNwa7m6TvN1AL5fntom/RGkd3ZaXUyi0DcYO2msQdmBPNwcIyihbh47WMdR8ruA
         P2Hf6N90Uxjna5EakCvX0uvdjVKbevFvh1P64Un2PUp1DZ9grXsZqkz7pFET0PeY9O3p
         rFoPxpgpQp82jKySnWSNsq3dPoNyVkVgOjnG0BoGB2CGz/yMkEn7Xg7djnZ/MzBP8M9d
         y4K02fh59kLcdAx3gcLAYA/2k/f4CxBttLf35/qcEz8Rj7INW/nIP+vyIxfTUO2pzfhb
         ChsSuHtFfIe7B6hGQKhCeGul/O2gcQ29IWLnBttrdof4vrB21LZUdoP1GnCTHajZ6mA0
         3ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wxAgDSO4PHtnyT9YqEInrFwVFPJ40qAdrw7NJDg+OnQ=;
        b=lj1Bapq7DFxVWQK0cpYvsm67HeaK0pzcy2dDu4KpTG4C0IVsvukjSPPe4wTgzChIgE
         dy6bFMc/VoP6cZnwXMyM5lxi62PLsvzxmzICQbmpYTi/HPDb6bdHaM8Gzku3x+c7UU11
         EzCiU0rh22iIDv1zFl1kV/TCTn7t4Xl7S0YDCjEuTMER5FYpsy6Cd2dfO9+VcLltDJfX
         oi3No/ALw0/EgOLF5y+xaTLk2YI/NwTAJhg/RK2U9ZMFFZsjITnX8D5AgGZFYy59P6xg
         sQ3MgVaN9TcNIkqq0UNRyhuLqJSVqwClMpexiBe34tnG6nbYRfs/MVcvcw/FlsyyMQ0Z
         QfBw==
X-Gm-Message-State: AOAM532qinJn4zuI6L0YlC4+uOGDgXGEJDrURxmS5K6cZDAJ+wgHeS4m
        +UZaxtVTF+T2lve3Ceaa8w8=
X-Google-Smtp-Source: ABdhPJywdHU/i3cYU1gqgd8/BF6Dnf2vR1G64pOniTnydX3FWoQrxGwpNFqqALtyLKHD0QronDbvMQ==
X-Received: by 2002:aa7:c349:: with SMTP id j9mr34667589edr.41.1618342059235;
        Tue, 13 Apr 2021 12:27:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u13sm8724114ejn.59.2021.04.13.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:27:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t0091-bugreport.sh: actually verify some content of report
References: <20210409212724.GE2947267@szeder.dev>
 <20210411143354.25134-1-martin.agren@gmail.com>
 <xmqqwnt7e82i.fsf@gitster.g>
 <CAN0heSr3MQnqMiWiSYpmpx3ZRkyXK6z1VfW_T-EQi31ifs0drA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAN0heSr3MQnqMiWiSYpmpx3ZRkyXK6z1VfW_T-EQi31ifs0drA@mail.gmail.com>
Date:   Tue, 13 Apr 2021 21:27:33 +0200
Message-ID: <87a6q22dei.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Martin =C3=85gren wrote:

> On Mon, 12 Apr 2021 at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>> > In the first test in this script, 'creates a report with content in the
>> > right places', we generate a report and pipe it into our helper
>> > `check_all_headers_populated()`. The idea of the helper is to find all
>> > lines that look like headers ("[Some Header Here]") and to check that
>> > the next line is non-empty. This is supposed to catch erroneous outputs
>> > such as the following:
> ...
>> > Let's instead grep for some contents that we expect to find in a bug
>> > report. We won't verify that they appear in the right order, but at
>> > least we end up verifying the contents more than before this commit.
>>
>> Nicely described.  I agree that the original intent (let alone the
>> implementation) is misguided and we should allow an empty section as
>> a perfectly normal thing.
>
>> > +test_expect_success 'creates a report with content' '
>> >       test_when_finished rm git-bugreport-check-headers.txt &&
>> >       git bugreport -s check-headers &&
>> > -     check_all_headers_populated <git-bugreport-check-headers.txt
>> > +     grep "^Please answer " git-bugreport-check-headers.txt &&
>> > +     grep "^\[System Info\]$" git-bugreport-check-headers.txt &&
>> > +     grep "^git version:$" git-bugreport-check-headers.txt &&
>> > +     grep "^\[Enabled Hooks\]$" git-bugreport-check-headers.txt
>> >  '
>>
>> It is a different matter if it is sufficient to ensure only certain
>> selected lines appear in the report, though.  As all the lines lost
>> by this fix comes from 238b439d (bugreport: add tool to generate
>> debugging info, 2020-04-16), it would be nice to hear from Emily.
>
> Maybe something like
>
>        awk '\''BEGIN { sect=3D"" }
>                /^\[.*]$/ { sect=3D$0 }
>                /./ { print sect, $0 }'\'' \
>            git-bugreport-check-headers.txt >prefixed &&
>        grep "^ Thank you for filling out a Git bug report" prefixed &&
>        grep "^ Please review the rest of the bug report below" prefixed &&
>        grep "^ You can delete any lines you don.t wish to share" prefixed=
 &&
>        grep "\[System Info\] git version ..." prefixed
>
> Something like that could be used to verify that a line goes into the
> right section, as opposed to just seeing that it appears *somewhere*. Or
> maybe
>
>   grep -e Thank.you -e Please.review -e You.can.delete -e "^\[" \
>        -e git.version git-bugreport-check-headers.txt >actual
>
> then setting up an "expect" and comparing. That would help us verify the
> order, including which section things appear in. Slightly less friendly
> for comparing loosely, compared to the awk-then-grep above.
>
> Let's see what Emily thinks about the various alternatives. Maybe she can
> think of something else.

I think a straight-up test_cmp is preferrable, both for correctness and
also as self-documentation, you can see from the test what the full
expected output is like.

Obviously in this case we can't do a test_cmp on the raw output, as it
contains various things from uname.

But it looks like we could do that if we do some light awk/perl/sed
munging of the "[System Info]" and "[Enabled Hooks]" section(s).

Or, since we also control the generator we could pass a --no-system-info
and/or --no-hooks-info, which may be something some people want for
privacy/reporting reasons anyway (e.g. I've often used perlbug and
deleted that whole info, because info there has no relevance to the
specific issue I'm reporting).
