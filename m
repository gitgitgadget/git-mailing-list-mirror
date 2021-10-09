Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4787C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBB960E0B
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbhJIAeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhJIAeU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 20:34:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D48C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 17:32:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so42371107edt.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QKjyzYYEnxf9Uaj25qJy4/J2tbxwjNKCLfXYs8Kf0Cs=;
        b=ARP05mgdvylB8YvIsuZfb2fnazganYom0req+/5Y9pXZ0RS6Uhc0a9PpqbQ1z3SI40
         s0TG/0Fp9s8LJWFC8Zz7xZ/NSYG9ORrdjMh73XOu4V6znt8rbhsk9gnU/KP4hbriXsLv
         vDG5DmsfeVxdfiSAaxhJiZt/B8Du5wXB9M1O6F6WwPmuqO3TvWWKPpSJtZtLyAo/QTx2
         XRlkFS3WalPzcmn3gwxZtkDa7ILGsaK4LlTQ1fs1GsckVIY/Aog5gwh4q+QO5WTpBM4O
         3QlFnCQl0YIUJ8g5t9hBdSnjXENv+V6Hj2enZMZshjC7ZjleXpTKbQJ4IwVqceH8CPCS
         K2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QKjyzYYEnxf9Uaj25qJy4/J2tbxwjNKCLfXYs8Kf0Cs=;
        b=R3V5d7QLuYQM6BUnhB7RsAlW4MhlXYkKEWU6HcTSiay/bpD9S1X36LbriRQhYIz8tE
         yMcaXfn4LdqqLvizmSVjcK+LyVuZNDqIqnxaLww2GEu8t7U23H25Dz7OB6rt7fRpwYBW
         odsr5iM/zE8Jt+XLmpLlQJSGFuWdTValC8aWd0FF9/6E5YGKtg9/NZn33ku4ycwamchk
         mhYDrXAYiKUzmUz4ifi2hXRPzllxNvXWMSqVN7lyTC994Ihi2MAkNy6LNiQV3CnXJFFW
         X3CyPu+ofA4asnbeQI4WL5LycE6qFzTf0m2PJQM7Rw1Wh1m2VdZgaVPNROEc8xjE1egp
         dtOQ==
X-Gm-Message-State: AOAM53086soTt761HBE73qSuH/pPdGlLVKTPGGgsujObBloK9lXko5qc
        71ZbAiSDLTAwibQ/zMjv5Eo=
X-Google-Smtp-Source: ABdhPJwWLqWdg8Yay/qXE3olGc/RaFXAgHlgfKiaVa0AUbdOE9EqCcGwV/Ku9bjOOIFk/vZeASraIw==
X-Received: by 2002:a50:d9c9:: with SMTP id x9mr19742801edj.179.1633739542784;
        Fri, 08 Oct 2021 17:32:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x14sm367202edd.25.2021.10.08.17.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 17:32:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/5] Fun with cpp word regex
Date:   Sat, 09 Oct 2021 02:00:12 +0200
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
 <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
 <87r1cvmg0c.fsf@evledraar.gmail.com>
 <25363715-dc39-1f18-a937-f715b106f529@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <25363715-dc39-1f18-a937-f715b106f529@kdbg.org>
Message-ID: <87mtnjm416.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 09 2021, Johannes Sixt wrote:

> Am 08.10.21 um 22:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

[re-arranged a bit]

> [...]As far as tokenization is concerned, C
> is a subset of C++. I don't think we need to separate the drivers.
>
>>  * I found myself back-porting some of your tests (manually mostly),
>>    maybe you disagree, but in cases like 123'123, <=3D> etc. I'd find it
>>    easier to follow if we first added the test data, and then the
>>    changed behavior.
>>=20
>>    Because after all, we're going to change how we highlight existing
>>    data, so testing for that would be informative.
>
> Good point. I'll work a bit more on that.

Great!

>>  * I wonder if it isn't time to split up "cpp" into a "c" driver,
>>    e.g. git.git's .gitattributes has "cpp" for *.[ch] files, but as C++
>>    adds more syntax sugar.
>>=20
>>    So e.g. if you use "<=3D>" after this series we'll tokenize it
>>    differently in *.c files, but it's a C++-only operator, on the other
>>    hand probably nobody cares that much...
>
> Yes, it is that: <=3D> won't appear in a correct C file (outside of
> comments), so no-one will care. [...]

..mmm..

>>  * This pre-dates your much improved tests, but these test files could
>>    really use some test comments, as in:
>>=20
>>    /* Now that we're going to understand the "'" character somehow, will=
 any of this change? */
>>    /* We haven't written code like this since the 1960's ... */
>>    /* Run & free */
>>=20
>>    I.e. we don't just highlight code the compiler likes to eat, but also
>>    comments. So particularly for smaller tokens that also occur in
>>    natural language like "'" and "&" are we getting expected results?
>
> Comments are free text. Anything can happen. There is no such thing as
> "correct tokenization" in comments. Not interested.

Sure there is, just because the problem is fuzzy doesn't mean there
aren't more and less correct things to do.

But most importantly the output of "git diff" is made for human
consumption, people who use --word-diff are going to be looking at code
that contains comments, embedded natural language in C-strings etc.

I've got no reason to think that your changes here make it worse, but
just as a general matter we absolutely should consider that one of the
top priorities when it comes to these language drivers.

E.g. in some languages (like CJK) it's common for characters or words
not to have any unicode whitespace between them, so even a word-diff
mode for C can benefit from recognizing those character ranges and
splitting them appropriately, or at least trying.

So to take a comment of yours where you changed a comment at random:
=20=20=20=20
    $ git log -U0 --oneline -1 --word-diff -p af920e36977 --word-diff-regex=
=3D'[ a-zA-Z]*'
    [...]
    [- Note that this seemingly redundant second declaration is required-]{=
+ Note that this redundant forward declaration is required+}

Don't you think that would suck v.s. the now-behavior of:

    [...]
    Note that this[-seemingly-] redundant [-second-]{+forward+} declaration=
 is required

The former is exactly the sort of thing you'd get in CJK languages with
a word-diff driver thought the line we should stop at was the same as a
comiler tokenizer.

Anyway, the cpp driver seems to do just fine on CJK.

I'm just saying that as a general thing it's definitely a priority for
these drivers to not only handle the narrow cases of tokens a compiler
would know about. Text that people commonly use should be presented in
some way that isn't line noise.

For an example of something we do a bit badly with the cpp driver is
parts of my 66f5f6dca95 (C style: use standard style for "TRANSLATORS"
comments, 2017-05-11).

I.e. there I was changing a comment format, and added a full stop to a
sentence, the word-diff is:

        /*
         {+*+} TRANSLATORS: here is a comment that explains the string to
         {+*+} be translated, that follows immediately after [-it-]{+it.+}
         */

Even though it has nothing to do with C syntax per-se that would be much mo=
re useful as:

        /*
         {+*+} TRANSLATORS: here is a comment that explains the string to
         {+*+} be translated, that follows immediately after it{+.+}
         */

I.e. treating a "." at the end of a word specially isn't C or C++
syntax, but it's absolutely input that the cpp driver *is* getting and
should be if possible be handling well.

I just did that by experimenting with
--word-diff-regex=3D'([A-Za-z:]*|\*|\.)', that example is unchanged with
your series, but maybe low-hanging fruit....

Thanks for working on this, just an unsolicited braindump :)
