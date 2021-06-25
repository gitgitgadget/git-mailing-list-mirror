Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D917C49EB9
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 10:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F5461434
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 10:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhFYKYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhFYKYV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 06:24:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71916C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 03:21:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df12so12725731edb.2
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j5KtqhmUcrw14/eTH2UnPhB/B9DcYn7UraUK5BnLDVM=;
        b=lse3lJHxs9v6Nc9ny8CqvcvX95yaEjR0hSg0Q7tEPlRMKIwL2CawRNhChDlum6Pfcc
         Kn0eL84RyjysEeU7wWZLxlKkfG79m4pj2YPhrVLwLDZMwwtFHeZUXu2SZTn+oLq3oDyH
         1mAXialvXmr04khUJ9aySx+oN6d3iskGljdkt3fdH4sLqYigV4JqTHi85xKWAaDuyhko
         H9hUu6N0DSSet8pfgBcxlOY3K/7hlpowPkrF/4uWkyFzJshHeeDfgAlQ5TIrRFzTsiHM
         dykNLKOWXl9WASfUoWUJTf7e+opPNb8AKup5cK8y8m3ICXY0Ndha4D98awlf4wz53qPF
         U7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j5KtqhmUcrw14/eTH2UnPhB/B9DcYn7UraUK5BnLDVM=;
        b=SKjz4qYTIiQiWA8E/PaeNHOqR7PlBY2nhifKv6pcQRZkUfIRpaCJ9GmreTX91pZ6FS
         JWZUnvRVGSfNVmBgjbl4navsvnKuLepSuhmnksWFam7G8uwTp0Y3lf4XRp3mOLOTZa4O
         2amefP+MiquAoFVuysUSUD1Gmnj8DQqmUYDJaxzxiCJOLSxXEDxJTAS4LIEtKWBDRcmO
         n8uEsKGvS5GcMlTstOdk29FxZu+ZVIeeWulwthch2rQThzTFdz2Yn5jQAJqyfXDFgDXS
         wa5llBXULNZDw3oVDcZILs2sZBzHjXKco6MzuwT9awZHwqipVpGr3pt6lS9j7IbcQdFC
         3q3g==
X-Gm-Message-State: AOAM530xLw6N55oYZU5Pr8cNkJtZOThAAaKvLq9uQeE5cCMG7lWC27VT
        fPldL3+oUIT+8uF/uUz42QU=
X-Google-Smtp-Source: ABdhPJzCUwOLq2ILvEmcj9z5URe39buz5zELbdhmnbT2huH3r8Ijps0NfIQiTj0HMQ94UpPWohCILA==
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr13619080edb.62.1624616517895;
        Fri, 25 Jun 2021 03:21:57 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k21sm610683edr.90.2021.06.25.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:21:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Fri, 25 Jun 2021 11:49:14 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
        <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
        <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
        <87r1gs1hfx.fsf@evledraar.gmail.com>
        <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
        <871r8r1hwe.fsf@evledraar.gmail.com>
        <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
Message-ID: <87fsx6xn0b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Jeff King wrote:

> On Thu, Jun 24, 2021 at 03:53:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> ..and "this behavior is really annoying on one platform we target, and
>> >> the fix is rather trivial".
>> >
>> > Yeah, that's a fine reason, too. I'm not entirely clear on what the
>> > problem is, though, or why this is the best solution (I expect you
>> > probably explained it in an earlier thread/series, but if so it went in
>> > one ear and out the other on my end).
>>=20
>> On *nix systems you can open a file, and unlink() it in another process,
>> on Windows this is an error.
>>=20
>> AIX has its own variant of this annoying behavior, you can't clobber (or
>> open for writing) binaries that are currently being run, you can unlink
>> and rename them though.
>
> Ah, right. Thanks for refreshing me.
>
> TBH, I don't find this that serious a problem. Your compile will fail.
> But is rebuilding in the middle of a test run something it's important
> to support seamlessly? It seems like a bad practice in the first place.

Yeah I think so, and I think it's good practice, it enabled development
workflows that you and Junio clearly don't use (which is fine), but
which are useful to others. For me it would result in more total
testing, and earlier catching of bugs, not less.

Quoting an earlier mail of yours[1]:

    I think having the test suite loudly complain is a good way to
    remind you that you have not in fact run the whole suite on a given
    build.

It's useful as you're programming you save/compile, and have the tests
run in a loop in the background, and are alerted if they start
failing.

That's not really possible with git currently without having that loop
continually push to another workdir, making it work in one checkout
helps for some workflows.

Yes it could allow you to run format-patch and send-email while you're
50% through a full loop, or not just run the full tests then, but at
some point I think we've got to assume some basic competency from
people. We also have CI running the full tests, and I could have just
run tests 0000-5000, compiled, and then run 5001-9999.

As a mechanism to prevent this it's not even reliable, it won't always
prevent this due to races, you'd need to e.g. issue a "git version" at
the start of a run, then "Bail Out!" if you detect it being different at
the end.

> It would likewise be a problem if you were running regular git commands
> straight out of your build directory. And we do support that, but IMHO
> it is not that important a use case.
>
> So again, I'm not all that opposed to atomic rename-into-place
> generation. But the use case doesn't seem important to me.

I guess because we use computers differently. I often have say a full
test run in one window, see a failure scroll by, re-make in another
window, test in a third, it's annoying to have to go back & forth and
stop/start things. I typically run the "main" one as a while-loop.

>> So without that "mv $@ $@+" trick you can't recompile if you have a
>> concurrent test (that you don't care about failing) running, and we have
>> bugs in our tests where e.g. "git-daemon" gets lost and won't get killed
>> on that platform, so you can't recompile and test without tracking it
>> down and killing it.
>
> The "git-daemon" thing sounds like a separate bug that is maybe
> exacerbating things. But we'd want to fix it anyway, since even without
> blocking compilation, it will cause a re-run of the tests to use the
> wrong version (and either fail, or hit the auto-skip behavior). I've run
> into this with apache hanging around after tests were killed (we do try
> to clean up, but depending how the script is killed, that may or may not
> succeed).

Yes, it's a bug that should be fixed. Right now if I try to login and
fix it (and numerous other bugs) my second full test run is guaranteed
to be impeded by having to track down and kill things.

The in-place-move works around that perfectly, so as a chicken-and-egg
problem of getting to a point where it's not so annoying to fix things
that I give up I suggested this rather trivial "&& mv $@+ $@" change was
something worth carrying.

1. https://lore.kernel.org/git/YEZsON5OxUiDkqPG@coredump.intra.peff.net/
