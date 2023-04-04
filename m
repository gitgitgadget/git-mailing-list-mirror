Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5290CC761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjDDPcB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 4 Apr 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDPcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:32:00 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3A10CF
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:31:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x17so42889137lfu.5
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 08:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnAS7PnZ+qI47ad2cTwmspqJ/bYge73O/i5SR9X3vUw=;
        b=Tag6+mi1/QrKRxoj4WS11g2KbqmXVd8sHNw0ssIn9MY4fyCU0qFGFzc7u4ATDilhQF
         zVg50G5glASowYjt7mJvHsYrzcTsRipbt01jhUQXb8xfm0/OvTbpWHjNP+G7FH0Fv83d
         LrpFSKlJoAPvEMyzfMpqczisTs2ZtIuYzVdO0zEXcL1dL7NeAhKBUB64AbbIe78IVdJl
         xHZU87UW3YoUfptdit53SJwO/GWw1zP+TdL5hUiaIwrtzAppLRx5vnY5VZFPhtBglVQo
         vJijJTQ8a/SXcbte5+OqmaP1hIZPSrgLrJnUaL9GIyD5ms7rgrSxT0BPFe9Jj5VvZFOD
         0JVw==
X-Gm-Message-State: AAQBX9cn51ATNUHp6vTad1j3yaAyT4j1AAszBK+SEYusG6h5xrvxGSwz
        TL+ISnheLnwy3DUXHy2wXjcoxAp1IJ/J1zPPdV8x+ADdh44=
X-Google-Smtp-Source: AKy350aQK+9RCaSofpCjRENW8HmYTkll3IqdCd7d/eG1RmpuOsmcEPOT7NDhkJJdYa25UePBK2pfpReUFNKhcodRJdE=
X-Received: by 2002:a19:ad09:0:b0:4d5:ca32:6aea with SMTP id
 t9-20020a19ad09000000b004d5ca326aeamr879865lfc.10.1680622317044; Tue, 04 Apr
 2023 08:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <230109.86v8lf297g.gmgdl@evledraar.gmail.com> <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CA+8g5KHuE-kQqmi9cVjeJbpyt54v9m9omh9A9we1zmR0+aTDHg@mail.gmail.com> <920dcc8d-9e45-a03e-af06-6b420c6e0f81@cs.ucla.edu>
In-Reply-To: <920dcc8d-9e45-a03e-af06-6b420c6e0f81@cs.ucla.edu>
From:   Jim Meyering <jim@meyering.net>
Date:   Tue, 4 Apr 2023 08:31:44 -0700
Message-ID: <CA+8g5KGGnsf0xMCXO28R1m8-z76=kG_AiYRh6=OgRL+x5C1yqQ@mail.gmail.com>
Subject: Re: bug#60690: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     60690@debbugs.gnu.org, demerphq@gmail.com,
        mega lith01 <megalith01@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023 at 11:47 PM Paul Eggert <eggert@cs.ucla.edu> wrote:
> On 2023-04-03 20:30, Jim Meyering wrote:
> > have you seen justification
> > (other than for compatibility with some other tool or language) for
> > allowing \d to match non-ASCII by default, in spite of the risks?
>
> In the example Ævar supplied in <https://bugs.gnu.org/60690>, my
> impression was that it was better when \d matched non-ASCII digits. That
> is, in a UTF-8 locale it's better when \d finds matches in these lines:
>
> >>      > git-gui/po/ja.po:"- 第１行: 何をしたか、を１行で要約。\n"
> >>      > git-gui/po/ja.po:"- 第２行: 空白\n"
>
> because they contain the Japanese digits "１" and "２". This was the only
> example I recall being given.

Before it was unintentionally enabled in grep-3.9, lines like that have
never been matched by grep -P's '\d'. By relaxing \d, we'd weaken
any application that uses say grep -P '^\d+$' to perform input
validation intending to ensure that some input is all ASCII digits.
It's not a big stretch to imagine that some downstream processor
of that "verified" data is not prepared to deal with multi-byte digits.

> Also, I find it odd that grep -P '^[\w\d]*$' matches lines containing
> any sort of Arabic word characters, but it rejects lines containing
> Arabic digits like "٣" that are perfectly reasonable in Arabic-language
> text. I also find it odd that [\d] and [[:digit:]] mean different things.
>
> There are arguments on the other side, otherwise we wouldn't be having
> this discussion. And it's true that grep -P '\d' formerly rejected
> Arabic digits (though it's also true that grep -P '\w' formerly rejected
> Arabic letters...). Still, the cure's oddness and incompatibility with
> Git, Perl, etc. appears to me to be worse than the disease of dealing
> with grep -P invocations that need to use [0-9] or LC_ALL="C" anyway if
> they want to be portable to any program other than GNU grep.

I'm primarily concerned about not introducing a persistent regression in
how GNU grep's -P '\d' works in multibyte locales. The corner cases you
mention do matter, of course, but are far less likely to matter in practice.
