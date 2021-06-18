Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A330C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 08:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F56613AA
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 08:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFRIG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFRIG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 04:06:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D0C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 01:04:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d7so7489725edx.0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BCx5/NDXazZ0k6zGwuXFcIRjMcDo5hppKaxnDHztjWo=;
        b=SNgkCdpt4tBLpN5Jmt07WiVqjJ4//QMF5Pwy3i36JbSbj4DYpl3J/jTjRrhIv2lwOo
         lx+5NXOILQCd7MAhbfDKWGHWyu4SPktYmX6cfNG9oThSOcZX/O5i08/HGW9Z98x005sw
         7IR/ppd9q3cC0jYcW6DTTRijPQi5pkm3UJ7KkmVSjO3E1FlX8aITdzcylKA5W2DEGJHJ
         PkTUm9cFnYM65MUrHA6wcWEc454frpFDhsPs0vfM14ouhJdC/dZk9EkleG9/gftKnQWt
         G/EIs2bjZh0M49R+kDqqaMm9QUCl7jMCdL3JFo20mop8HSf6AoR/BTgzeyyZzLarVCP9
         +Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BCx5/NDXazZ0k6zGwuXFcIRjMcDo5hppKaxnDHztjWo=;
        b=ewrEmwNUju9qQdd4OXakXc/B2T4Z5lQBclW1UqBF2IeAHpll8+Hp8LDoeRqRBgPbSY
         AFgxn+ptPy2koKlXg0E0c8Zr/m4K9xAeNbWd0m/Ml2yjnR6U9B0upsNuiv9izCRfy/Ni
         BvgaBLgzOvaaq3DB7n5/TRg/zJChte/VZ2j3F9+ncjBQdrx5czBe6jstD5JvCjh0VsEa
         phH16rRG2l1FLnSXVxMhUv4N2LqaPJgJpJMNJ08+nxVW47WF+ddpiV6pCccV8qcwoL43
         RCIiRRNU2srHjsRz0evnKSwBXdA9C9TEDdg7CLK0mgmoplwCi26g4e5bTGYCS5bbI45x
         DY3w==
X-Gm-Message-State: AOAM532ZIwcTMC3vIKVQfab0SU//kZ70bnJEKZTynTGHBaBIHJ+3RD54
        XE6jprLZCtFM7BpiCPqRHn8=
X-Google-Smtp-Source: ABdhPJxUyeJdVG8CRLje54AecAlZHCkpisYqFBRbLREhQMWUNdxWhqAuA/xZq1Cuj3Q5/g6l1+TRSg==
X-Received: by 2002:aa7:cf0a:: with SMTP id a10mr3274722edy.329.1624003454696;
        Fri, 18 Jun 2021 01:04:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d24sm5948630edp.7.2021.06.18.01.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:04:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Date:   Fri, 18 Jun 2021 09:24:56 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
        <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
        <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
Message-ID: <87wnqr4n0i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 18 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-06-16 at 19:54:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The references to "gendered prounouns" etc. are gone, perhaps there's a
>> good reason to re-include them, but the point of "isn't that issue
>> solved by recommending an orthagonal approach?" is one of the many
>> things Stolee hasn't been addressing in the threads related to this
>> series.
>
> I think I've addressed this.  Sometimes you can avoid referring to
> people and therefore avoiding pronouns, and sometimes the prose reads
> better if you talk about the user or actor.  Also, sometimes you need to
> discuss a matter at length and using variety in your language is
> desirable, so you may want to, for example, avoid continually using the
> passive voice to discuss the topic.
>
> I don't think it's fair to just say "don't refer to the user or other
> humans if you'd need to use third-person pronouns" because I don't think
> that's applicable in all cases.  I, for one, don't intend to write my
> commit messages in that way because I think it will make them
> substantially worse.

You won't have to. Reading this and your slightly earlier
<YMvoNcFXnHo0KXH3@camp.crustytoothpaste.net> I think you've missed that
as of v2[1] of this series the proposal to is not to enforce this policy
on people's commit messages; so we're only talking about code comments
and documentation at this point.

> [...]For example, I often discuss the behavior or
> expectations of users when writing FAQ entries or other documentation
> and sometimes we'll need to use pronouns.
>
> I agree that in many cases we can effectively rephrase to avoid needing
> to do this, but if we acknowledge that sometimes we will need to write
> using third-person personal pronouns in some cases, it's worth
> documenting what those should be.

I agree with you as a general matter that anything we come up with,
whether it's a prose guideline, coding style etc. won't cover all
cases.

But perhaps we disagree on whether that should be a goal of our
guidelines at all. I don't think it should. It shouldn't because it
simply won't work, the amount of guidelines we ask contributors to read
becomes a zero-sum game at some point.

Assuming that most contributors attempt to at least skim them we've
already reached that point. It's a trivial task to find recent
submissions of patches that violate one guideline or another.

So the criteria for inclusion shouldn't be whether we can think of cases
they apply to, but whether those cases are common enough to warrant
explicit mention, keeping in mind that any new addition will dilute
whatever advice we're already giving. Having gone over the number of
occurances we're fixing [2] I don't see how this qualifies.

As Stolee said upthread[3], referring to Documentation/CodingGuidelines
("[]" edits of what I understood him to mean are mine):

    [It's the document that we] should just be able to point to [say] "here
    is the decision we made"

I just don't think that should be a primary or secondary goal of that
document. We have e.g. this mailing list discussion to point to for some
decision we made.

The CodingGuidelines is what we're asking people to read when they've
e.g. found some data-eating bug in git and are about to send us a patch,
but before that we're asking them to go through a fuzzy checklist of
items checklist. It's already 20 pages in my browser if I were to try to
print it.

1. https://lore.kernel.org/git/pull.975.v2.git.1623246878.gitgitgadget@gmai=
l.com/
2. https://lore.kernel.org/git/87o8c4wkn7.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.c=
om/
