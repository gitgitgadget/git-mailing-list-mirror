Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F1C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F3960F12
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhGWIkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhGWIkH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:40:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8871EC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:20:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nb11so2754392ejc.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=odmo3IZ73Xye8l1PLihE8kzgDyHjVEyJaG5+ahcu2og=;
        b=FFC7c6Aq9nk21QPvdWai23qBPgJ14bkDUgVwdl+j9JKd/w8EAH98zSe7Q8QsgHtpei
         nV0NAZ0EdAQRB3PYioJTqF5ix3qFx/E/S6uDyOlGyJtzxnpsV2AhHPay/ctFsJ9AEsRl
         7c0ivVYKSGWhcQvcMYwtoKtUEGkbrsLXXd07nJJU411PjSzZ+hArK2qg2fmI6BmKdyCt
         YCD7VaZm7Yb0fXZOYElwAwe+pg0EzRlaFALj/bu+jlnnEKoa7nZBNglEZGJ+B/dIWzIW
         ybzVrgb/s9pquzWllci+jR1i0yxsYMRHgupfAepQoukJIr8oVFVrjU8f7mrCWeT39DA4
         8twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=odmo3IZ73Xye8l1PLihE8kzgDyHjVEyJaG5+ahcu2og=;
        b=XVXChH6ftZL7BgnI2xyi9xD1+6ZJ7ycsagTavt5KnUL59WrS/WIwqx/NyrHh5aoz0Y
         nMuFlRZtIMqEYSNKwpLZyVT95NVOtUyiePkVrCb3BLe9tDHZP6BmkFD0afi/vdJa1e+6
         vllXy91W00E49c8cUePlnGQXJW05c5FM1BfhxjsNHw6iaE63e5ZH8bvQJApgcwGhcB4B
         cemwIKuAb4X7AomdvqhirMgo7Zuk2/I8cXPEYNEj7tLYAYtEIqOJSRFBMZ7sXNpp+Eus
         4ktP+Rxr5ZIhWHbWsvzdZb3XRfI02MicKdYx23kAlkJc9l0Nt/oil08l7CStr6CZs84a
         PocQ==
X-Gm-Message-State: AOAM530YDH9KrRQFXU9HNjXj0ZNWgejDnrtZL2g6RhsJ0ngzIMz+Qj/h
        ICTNSe5HXOtHIDXxLMapOkI=
X-Google-Smtp-Source: ABdhPJx25l2BpKgj6Glb1ar3pTnew5ZvaxUsR4+NJ2SlwNqbYhXkiMCSVBe45HVCTk+vbBuihMwCJQ==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr3758115ejb.5.1627032039855;
        Fri, 23 Jul 2021 02:20:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p5sm7934078ejl.73.2021.07.23.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:20:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/9] hook: allow out-of-repo 'git hook' invocations
Date:   Fri, 23 Jul 2021 11:18:22 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-8-emilyshaffer@google.com>
 <87tukuy7vc.fsf@evledraar.gmail.com> <YPn6LInRNmpfffuC@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPn6LInRNmpfffuC@google.com>
Message-ID: <878s1xtmgz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 10:33:25AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> > Since hooks can now be supplied via the config, and a config can be
>> > present without a gitdir via the global and system configs, we can sta=
rt
>> > to allow 'git hook run' to occur without a gitdir. This enables us to =
do
>> > things like run sendemail-validate hooks when running 'git send-email'
>> > from a nongit directory.
>> >
>> > It still doesn't make sense to look for hooks in the hookdir in nongit
>> > repos, though, as there is no hookdir.
>>=20
>> Hrm, I haven't tested but re the discussion we had about
>> RUN_SETUP_GENTLY on my re-rolled base topic is this really just a
>> regression in my changes there?
>>=20
>> I.e. I assumed we could do RUN_SETUP for the bug-for-bug compatibility
>> step, but send-email runs out of repo hooks and we just didn't have
>> tests for it, or am I missing something?
>
> I'm not sure. I could see a case for you including RUN_SETUP_GENTLY on
> your series and adding a test for sendemail-validate + core.hooksPath in
> global config. I think I also don't have support for that case here,
> actually....

The narrow goal of the base topic is to be a bug-for-bug compatible
version of what we have now on "master", just via a dispatch
command/API.

So yeah, that git-send-email.perl behavior looks bizarre, but let's fix
it in a separate set of behavior changing patches on top, no?

> Anyway, it looks like right now git-send-email.perl:validate_patch()
> doesn't bother if it's out-of-repo, so this wouldn't have worked before (=
and
> still won't work even after this change). So either I can add a patch to
> my series to allow that, or you can modify your patch converting
> sendemail-validate to 'git hook run' to drop the 'if $repo' line and
> teach your series to behave correctly with nongit+hooksPath. It looks
> like in my earlier attempt at the series, I did drop that check and run
> 'git hook run' no matter what kind of directory we're in.

I think this was one of the things that either needed a test change in
your series, or I saw tests for changes to existing but untested
behavior, I think this was the latter.=20

I completely agree that the behavior is weird, probably undesired and
should be changed. I'm just saying that we should split up refactorings
& behavior changes.=20
