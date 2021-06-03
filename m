Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686CC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AE261003
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFCRC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:02:28 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:45676 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFCRC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 13:02:27 -0400
Received: by mail-ej1-f51.google.com with SMTP id k7so10226581ejv.12
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0l/iOFngc0S4im2tTOZcQRVy2yMvbpiqkxMDMHl6UU4=;
        b=nCpdqTF6HbInuR0A/lTWw1sIlpwtByHUepilmxzBloL8zzC+yKIEDTW9qEABBjcv0D
         0Rm4Up0llkGjMScrZVJc5s8rong3hQCXVKHVj4Xk+QcoV6xHc+Cm4iD5jxMC/zS5ahA3
         uHjapiiAfbbD7HYqZfWZIbIEj0xbpstgCC7+L6l046By9aXPjYQxmdePLxIHfmdLJnu0
         xdD6rhDCd959lUFbcYtyJinfwfozF8BaSb81mRvVf2A28fde1uAA88xkIC6QPs30QZy2
         sRvovk263ld8LgLFvZemfnx7hVx4RdugD+Odiank+pyDJf8/50mvkzRXcmqunzZpmXw6
         nMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0l/iOFngc0S4im2tTOZcQRVy2yMvbpiqkxMDMHl6UU4=;
        b=AR4mg6lc2V2ivPae2rn3jbeCaADUYFQPYSRTUpSOEvb3BMjIJOY2Csq/c2knoIgxxZ
         iXo6JdfmSx6M1hStyJ+tBN8pvBWYl6YFdA5ygCctUFVThd8vGT6TzsgQfr58KUEYaL2/
         eN+U+9ei/MHxyJiRjW4AsUNuAbAKSAixVT0zfd3OCjv/VCLlJph8WHUx6i5y0zAQy7N1
         H0KkqZDcIUsBkwxEbmNoivgEsUKoA0PmpS+zmAfH+OOHTUhy4cMq9D25W3sFTL20twUq
         rWH3gTiKZ2xxQVie3zVQChr+cOFrfoQnpSPWNwltCWw+B5V9nltOtsg8neQ+Wt7L9dUm
         fvKg==
X-Gm-Message-State: AOAM532uW0MlZq/jAqv6m2q1RpjIwmlC5CIIfo9QYCc3TKWFKH/YjLAH
        stHJ0n9Xce4yTSUzytmKibU=
X-Google-Smtp-Source: ABdhPJwt1j6e6HxWUZUhvMgGE8MAS3Y5xWWS1P97qZpYg6Hd5+Ema+BaxqI/5GbX5hw+jLeCPTZsQg==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr301506ejc.209.1622739568439;
        Thu, 03 Jun 2021 09:59:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x9sm1811781eje.64.2021.06.03.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 09:59:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Thu, 03 Jun 2021 18:44:52 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
 <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
 <87wnrb5cvl.fsf@evledraar.gmail.com>
 <dbbb5a73-12b5-27a1-63d4-eece1e60f57b@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <dbbb5a73-12b5-27a1-63d4-eece1e60f57b@gmail.com>
Message-ID: <87tume6g0g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 03/06/2021 13:31, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jun 03 2021, Felipe Contreras wrote:
>>=20
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> So I skipped the "disable most config", but for what it's worth I think
>>>> I'd miss these the most, I couldn't pick just N favorites, sorry:
>>>>
>>>>   * diff.colorMoved=3Dtrue: super useful, but I'd be vary of turning i=
t on
>>>>     by default in its current form. E.g. on gcc.git's changelog files =
it
>>>>     has really pathological performance characteristics.
>
> Would you be able say a bit more about this so I can try and reproduce
> it please. I'm working on some patches [1] to improve the performance
> of `diff --color-moved` and `diff --color-moved-ws` and it would be
> good to test them on a problematic repo. At the moment I diffing two
> releases of git to test performance on a large diff. I just cloned the
> last 18 months of gcc.git and Changelog seems to just be appended to.

I misremembered the gcc.git ChangeLog issue, sorry. That's about
something else entirely.

The issue with the color moved code can just be reproduced on most large
diffs, e.g. on git.git:
=20=20=20=20
    $ time git diff --color-moved=3Dtrue v2.25.0..v2.30.0 >/dev/null
    real    0m10.112s
    $ time git diff --color-moved=3Dfalse v2.25.0..v2.30.0 >/dev/null
    real    0m0.939s

So 10x slower, and e.g. diffing from v2.22.0 makes it 25s and 1.1s,
respectively.

In some sense that slowness is expected, it simly takes time to compute
this. I think for turning it on by default we should have something like
the diff.renameLimit, and change the default to some "auto" that would
punt out if it was taking too long to compute.

I run with it by default so this doesn't bother me, but I think it's
probably a semi-common use-case of some people to e.g. diff the last N
releases of Linux, and then use their pager to search around in the
diff.

We don't want commands like that to take 25s instead of 1s, but I think
it would be fine (and we should) warn that we aborted on the color move
if it's otherwise the default.

Otherwise it'll take 1s, and if you normally depend on it you'll
conclude that some code you're looking at wasn't moved, which would also
suck, better to punt on it and warn, just like the diff.renameLimit.


>>> Very nice! I didn't know about it. I'll pick it for my third day.
>> It makes patch review a lot easier, and also integrates nicely with
>> -w.
>
> I find --color-moved-ws=3Dallow-indentation-change helpful as well (it
> is quite a bit slower at the moment but I have some patches to bring
> it up to the speed of the other --color-moved modes.
>
> [1] https://github.com/phillipwood/git/tree/wip/diff-color-moved-tweaks

Nice, I didn't know about that option. Will try it.
