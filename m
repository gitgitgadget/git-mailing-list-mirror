Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093BC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BBB611CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 11:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhFXLIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhFXLIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 07:08:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07472C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 04:06:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so8811829ejc.13
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=31dOO79ZUsPBmz9ktkF+FhK3V11tt1L6GDv4YpA8Wj8=;
        b=vgqX7VoNEok3LOKN/1rM/7pKrOhlShk/TLaROob78SiAQNL0bliFneIUHy4oGBSr9A
         LkNoiVGcqlc75rtvUq2a8yWn0AbRJWsrXui+02QJNNLl16x2+a6Gz9K3f0F0/SX0II2Y
         3gTlpS8Xi0ryRhz64IhiA/rU7PYJRG9FpfjZUJ9q4Ws+eiaaAUbn58bUFW2V5UsLEfhU
         /JbIkMayNIVODLzzNfCQFmSLyOfnKXBHlQxnq9uGyGwo/u29ba0Q1BqiAG51oElzFdch
         IhdUgdYsErIUftgZ0dFcngS18HuluQiy0t1i8HkU1pLx2wa55g1ADqoZrSo8lK7ojPUb
         jZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=31dOO79ZUsPBmz9ktkF+FhK3V11tt1L6GDv4YpA8Wj8=;
        b=Br214vJIVyY3HEaWyMuDaGUNQ0TlZz/7rqsJz5NKu3BAW1gzKDMRNuwculfgvimA3p
         y3mDlAP3l/N4kR2ez4OxbpjcOGfeOqFij6HE2WjZoNlA1EE7XVEyeTXHsCxoeqw38+Cs
         cN/J6Q3LboAO/t08IleKjySOr/ifDKIdG6li1nGJngcugAnLe6lelghqQdtZDbDemAKf
         G+JUc4pd17ZjYwZ9Ae2Nrnwu8xFIoB2bOTG/OQ8uatoOd/1Z5je1UBPZur/mZRSTb6hT
         nFiw4JLW6Io40Wbkfbr7IJSps/R4ZDmL6GajChoTMSi14Y726D+njFgELrhDg3Cc+RSu
         Rx8w==
X-Gm-Message-State: AOAM530zMd0EtLaDXkpUlzX2B4mmU8gOyjiQwdjPSv8WZqEQiVWyDbRo
        y3yvB4c5imSoUpS+BCPwkZE=
X-Google-Smtp-Source: ABdhPJw80xJHB2qTFKb9vCHoFeSMh5AB9pcNU+E8U47xGPqNpEbeO3dwGTlDzZsacXBL8OgGUbntFQ==
X-Received: by 2002:a17:906:b215:: with SMTP id p21mr4905575ejz.237.1624532773430;
        Thu, 24 Jun 2021 04:06:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l22sm1642128edr.15.2021.06.24.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 04:06:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/4] WIP/POC check isatty(2)-protected progress lines
Date:   Thu, 24 Jun 2021 12:45:25 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210623215736.8279-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210623215736.8279-1-szeder.dev@gmail.com>
Message-ID: <877dij1pzv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, SZEDER G=C3=A1bor wrote:

> On Sun, Jun 20, 2021 at 10:02:56PM +0200, SZEDER G=C3=A1bor wrote:
>> It turned out that progress
>> counters can be checked easily and transparently in case of progress
>> lines that are shown in the tests, i.e. that are shown even when
>> stderr is not a terminal or are forced with '--progress'.  (In other
>> cases it's still fairly easy but not quite transparent, as I think we
>> need changes to the progress API; more on that later in a separate
>> series.)
>
> So, the first patch in this WIP/POC series is my attempt at checking
> even those progress counters that are not shown in our test suite,
> either because stderr is not a terminal or because of an explicit
> '--no-progress' option.  There are no usable commit messages yet, I
> just wanted to see whether it's possible to check all progress lines
> and whether it uncovers any more bugs; and the answer is yes to both.
>
> Anyway, the basic idea is that instead of checking isatty(2) in the
> caller, let's perform that check in start_progress() and let callers
> override it through an extra function parameter (e.g. when
> '--(no-)progress', '-v' or '--quiet' was given).  This way
> start_progress() will always be called and it would then return NULL
> if the progress line should not be shown.  Or, if
> GIT_TEST_CHECK_PROGRESS=3D1, then it would return a valid non-NULL
> progress instance even when the progress line should not be shown, but
> with the new 'progress->hidden' flag set, so subsequent
> display_progress() and stop_progress() calls won't print anything but
> will be able to perform all the checks and trigger BUG() if one is
> violated.
>
> However, after =C3=86var pointed out upthread that progress also generates
> trace2 regions, I think that it would be better if start_progress()
> always returned a valid progress instance, even without
> GIT_TEST_CHECK_PROGRESS but with 'progress->hidden' set as necessary,
> because that way we would always get that trace2 output, even with
> '--no-progress' or 'git cmd 2>log'.
>
> The first patch also converts a good couple of progress lines to this
> new approach, and the subsequent patches fix most of the uncovered
> buggy progress lines.

Thanks, I skimmed over it and this sort of approach is definitely what
we'll need to address my "But we'll still have various untested for
BUG()[...]" in
https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab=
@gmail.com/

And as you point out we'll get the benefit of consistent trace2 regions,
on the one hand it's a bit weird to have this UI code drive a trace2
region when we don't have a TTY, but I think it's useful. We could
e.g. eventually record some stats about min/max/avg/percentile
processing per-item while we're at it, that's unlikely to be worth it if
we need another API like display_progress(), but since we have that one
we can piggy-back on it quite easily.

Just some implementation nits: I for one would prefer "static inline"
wrappers instead of macros in progress.h, makes it easier to
consistently set breakpoints in gdb.

It's more work up-front, but I think Re Randall's question in
https://lore.kernel.org/git/00fb01d76859$8a6ebc50$9f4c34f0$@nexbridge.com
that instead of s/start_delayed_progress/start_delayed_progress_if_tty/
it would be better to just leave the "start_delayed_progress", and have
it by default do the TTY check, and also check for --progress and/or
--verbose/--quiet etc. itself.

We'd probably have some special-cases left even then, but I think most
of them can be handled with an isatty() check and the "standard" options
of --progress etc.

I.e. we have OPT__VERBOSE now, but no OPT__PROGRESS (we just use
OPT_BOOL). If we made the various common parse-options flags that impact
it callbacks that would munge a global variable we could then pick that
up in progress.c, and handle the common case of "git some-command
--no-progress" directly.

It would also make it easy to just move that over to git.c, so we could
have "git --no-progress some-command", which I think for --progress,
--object-format and other "global-y" options it we should have them to
"git" directly, not per-command, especially with us hopefully soon
moving 100% away from dashed built-ins.

Isn't the most common general rule just:

    int want_progress =3D progress ? 1 : verbose ? 1 : quiet ? 0 : isatty(2=
);

Well, that and a version that handles --no-progress distinct from "did
not provide it", so we need some "-1" checks in there. Maybe:

    /* Earlier */
    if (quiet !=3D -1 && verbose !=3D -1)
        die("--quiet and --verbose?");

    /* In progress.c after getopt */
    int enable =3D -1;
    if (opt_progress !=3D -1) enable =3D opt_progress;
    if (enable =3D=3D -1 && opt_verbose !=3D -1) enable =3D opt_verbose;
    if (enable =3D=3D -1 && opt_quiet !=3D -1) enable =3D !opt_quiet;
    if (enable =3D=3D -1) enable =3D isatty(2);

In any case, I think moving that to one place so it's consistently
checked would make sense.

Some things like builtin/multi-pack-index.c set "progress" as a bitflag
for IMO (this was discussed on-list before) no good reason. I.e. the
builtin should handle it with a bool, maybe the library wants a flag,
but in any case if we can do what I proposed above such libraries won't
need a flag at all.
