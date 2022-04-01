Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F1C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 08:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbiDAIHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbiDAIHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 04:07:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413732675B6
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 01:05:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg10so4191753ejb.4
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8d1B/E80vSKUrCz3Phw0NLZ+foQaHDh5mudwyXqey6I=;
        b=lliGJ8RLFaijb1hrH6PgFdsGDbS4zZ6Mo2BN8AWbPu/XwN6ToMYvwVTWrZ5VAtm+DT
         l1/NHqHysakrRRXj4qbS+9eAwilURRmu4uL1ccM8Qr9tt7yGQnFBC9EG/w8JTLsh07+T
         PET30E0AofH639mV4Gk7RXCPT8XkBswTydIiGeDYTrkvkk4Y0pA9GSIs2WDXNLtrQLn7
         MIUlITMHugu+masLGCXTGX2pOAxOgU2lXv1gJdFyMGNW/RuxtkyJp9UlP+ru1R3LktAS
         5uoDfLjcVHGpvQgfq+FvZCkKHmhYN8AiM4Jzmx3TkRJe3EN6RgVbWH/JN9XrCEqrrcio
         sNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8d1B/E80vSKUrCz3Phw0NLZ+foQaHDh5mudwyXqey6I=;
        b=znPNfnEbUZesJrBjixSz3CL3VErjGDLbKA8BWRJ6C+D4XHBe2BQQ+AEXMI4hDiRCfu
         tuzpTUlo95TTex7CRoss4WgoD7e/uoB0E1vEmpavufeMXf3GRw8oW/YRv57G3O2WwHgt
         wL//Xx77CMjI7cRzb+LBLQyiD7emolY9pfbZUMUfRnTidGSx4cKzsPV2vKzj1DRN/yeF
         hxrqcDiVTrzQMiab5/UWBYhaULehXlPO18x9nTJ6w0GzYbdlMuu9FtVsBm1kiO+c8s9Q
         zARAwgxTL88UiMMwEHB6MCMBkCKNYMs2bCSarr2vfybt4EnHTK3lnpUCxzgNfw1kMw14
         f1Iw==
X-Gm-Message-State: AOAM530WVbhZ9xtHZXqccIc6WQvci8idxYlLFR79yH84WpdkZgQe81ZJ
        CcI5W52Z8ZHPBRTKTnkKefA=
X-Google-Smtp-Source: ABdhPJyTirApvzLdv7sT184fwU4TzCXQKZcct0TT2i0H8xx9f4giyDCjOXnrbHPqn+RO5lnpMepfLA==
X-Received: by 2002:a17:907:c00b:b0:6df:cd40:afc4 with SMTP id ss11-20020a170907c00b00b006dfcd40afc4mr8231508ejc.629.1648800343537;
        Fri, 01 Apr 2022 01:05:43 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm740556ejm.188.2022.04.01.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:05:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naCHu-000w2N-8U;
        Fri, 01 Apr 2022 10:05:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com, Tao Klerks <tao@klerks.biz>
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file
 into cone
Date:   Fri, 01 Apr 2022 10:02:56 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
 <220331.86ilruqup6.gmgdl@evledraar.gmail.com>
 <CAJyCBORNQEN4WNfuYbO264qz0W6d-rbT6z=T_-AZF5jY36c1yQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAJyCBORNQEN4WNfuYbO264qz0W6d-rbT6z=T_-AZF5jY36c1yQ@mail.gmail.com>
Message-ID: <220401.867d89p6sp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Shaoxuan Yuan wrote:

> On Thu, Mar 31, 2022 at 6:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> More odd indentation, and the braces aren't needed.
>
> Got me again :-( Will make a change.
>
>> >       }
>> >
>> >       if (gitmodules_modified)
>> > @@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
>> >                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
>> >               die(_("Unable to write new index file"));
>> >
>> > +     if (advise_to_reapply)
>> > +             printf(_("Please use \"git sparse-checkout reapply\" to =
reapply the sparsity.\n"));
>> > +
>>
>> Please see 93026558512 (tracking branches: add advice to ambiguous
>> refspec error, 2022-03-28) (the OID may change after I send this, as
>> it's in "seen") for how to add new advise, i.e. we use advise(), add an
>> enum field, config var etc.
>
> I actually did use advise(), but I noticed that it prints to stderr
> and ... nevermind,
> I realized that printing to stderr is OK. But can I print to stdout
> since I think users should
> be "reminded" instead of "warned"?
>
> Anyway, I think using advice() is probably better.

We've typically used stderr in git not to mean "error", but to
distinguish "chatty" and non-primary output from non-chatty.

So (leaving aside that we're unlikely to add advice to plumbing) if you
emitted a warning() or advice from git-ls-tree you should be able to run
something like:

    git ls-tree -r HEAD >output-for-a-script

And get the advise() on stderr, while the "primary" output is on stdout.

There's a recent-ish (last year or so) thread where I think Jeff King
explained this better than I'm doing here, but I couldn't find it with a
quick search.

In other words, you can just use advise() here, don't worry about it
writing to stderr.


