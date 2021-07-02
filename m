Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C2C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E656611BF
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGBWeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBWeU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:34:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2429C061764
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:31:46 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l26so10472208oic.7
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4ET1PHCTSTrczGXa4ThCUm/4GwA2lFl+dmI8JYkJSGg=;
        b=jlHlPRCZdHu3x3a2nhbt1ug1vzeZJSlgvCansVFlcVlDu3lMJ4GLBncTYRkLsE0KmZ
         tyKAQbKqwn425x2+Q0hI1ZBRVnXp9JEUqzT+EmKmcInWOXKOw70u9vo82VDg3GWQjX5I
         t2CsZrk2leKK9rayrZ+kklilCp37VTZrm/R8CniTSkBo+HugnkZnHiTZIynRLLKECxeD
         x5tIZ6CfG7T4sfpzEqDiUw8EVPOpALY1eFj0430yF08AfSZb8u9b9dY7PfHnEN7qpArC
         ifF6lU+Yndjpt6lGBgftCxcOqHhRD10SCq/6XyBiI8nUGGiImKNQf8mP1EL8sRHUPq6o
         31ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4ET1PHCTSTrczGXa4ThCUm/4GwA2lFl+dmI8JYkJSGg=;
        b=gACngjHWUIo2SiJ9tWvx1aaQ1o1EUsHOLWcllnDwXlXJZ/F6wgFin6di3xL0DwB+dH
         VVR0CxWJmRSo0xo3D9XtSp8HmJwun1zWW3wrzL3XBRDzJNTy6Rppt43ciccKNpytmZho
         sxUYE10RFqqh8/tBUgNass+yUjWjQbdEak5rrs+e1GGVtga1tBDX8i60mrMvm5RxNtfM
         OF1KKJScyI56rg5udyhlfnexJEFIek/6LdeZ83WYgvxsQb+fB4KihkVFzRVOMKRdTgzV
         lRBWPpmm86Vq+QNUNmKhK7j9Cp7+NSMoJ6tjo5t4ZrLFZrriHKTH/MoMHyHCV8Ko1T+3
         BwTg==
X-Gm-Message-State: AOAM533cebBFAxG1MlFcEDEicge8rLwVTkoDNuLz+4YX3crO+97O716T
        SA4F1w5VieopDqbp7dGzjUk=
X-Google-Smtp-Source: ABdhPJxwCsUNKPScYxqGjILDo1ouVNbSKsptd7i3q1Y9a2TKUYzSyoFfBCWQ2zN40RbRxXsLhpEEGQ==
X-Received: by 2002:aca:d941:: with SMTP id q62mr1633216oig.166.1625265105301;
        Fri, 02 Jul 2021 15:31:45 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x17sm881379otp.48.2021.07.02.15.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:31:44 -0700 (PDT)
Date:   Fri, 02 Jul 2021 17:31:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'martin' <test2@mfriebe.de>,
        'Andreas Schwab' <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60df93cfb0f44_28bb2084f@natae.notmuch>
In-Reply-To: <03ce01d76f8d$b0cfa8b0$126efa10$@nexbridge.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
 <60df7ee3128d6_28bb2086c@natae.notmuch>
 <03ce01d76f8d$b0cfa8b0$126efa10$@nexbridge.com>
Subject: RE: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On July 2, 2021 5:02 PM, Felipe Contreras wrote:
> >To: Randall S. Becker <rsbecker@nexbridge.com>; 'martin' <test2@mfrieb=
e.de>; 'Felipe Contreras' <felipe.contreras@gmail.com>;
> >'Andreas Schwab' <schwab@linux-m68k.org>
> >Cc: git@vger.kernel.org; '=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason' <ava=
rab@gmail.com>; 'Junio C Hamano' <gitster@pobox.com>
> >Subject: RE: [PATCH 5/5] config: add default aliases
> >
> >Randall S. Becker wrote:
> >
> >> In my opinion, default aliases are not a good path. If a command is
> >> intended to be part of the git command set, then it should be a
> >> builtin not an alias.
> >
> >Commands cannot be overriden, aliases can.
> >
> >All SCM projects have aliases, except git. Why do you think that is?
> =

> I do not think my intent was conveyed. Default aliases made by the
> product provider, regardless of who that is, are not a good path.

Why?

> If I was RCS, I would not make an alias that everyone had to take.

Nobody has to take them.

> Same for git. git has aliases, but they are for the user. If the
> end-user team wants to implement a particular set of primitives for
> their environment, that's fantastic, and entirely possible in git. But
> I do not want to be constrained by someone else's primitives that are
> not core product.

Nobody is constrained.

> >> Users have their own alias setups and implied conflicts are just goi=
ng
> >> to be confusing and end up in help, examples, presentations, and so
> >> forth.
> >
> >There's no conflict. Either you use the alias or you don't. Just like =
today.
> =

> Then what is the point of this? I want my aliases, not someone else's.

Then use your aliases. This patch is not for you.

> Again, if it is a core git alias, it is not an alias, it is a
> supported command and I should see it in the git help -a output.

A core git alias is an alias, and you will see them in the `git help -a`
output, in the aliases section.

> >> If you want a default alias set, publish it as part of an extension
> >> set, like the bash-completion, so that the user has to take action t=
o
> >> install them in their environment. Do not do this in the base git
> >> product by default.
> >
> >The whole point is to help users so they don't have to do extra config=
urations.
> =

> The whole point is that a user team should give thought to the
> functional extensions they want, as a team, which is where aliases
> come in.

Once again, this patch doesn't prevent anyone from doing anything.

> We, as git contributors, should not be telling them what their extensio=
ns are.

We are not.

> >Today git is pretty much unbearable without a configuration. Default a=
liases would help quell some of that pain.
> =

> Git is entirely bearable particularly in my own pons and medulla.

Good. But you are not the average user.

> >> If I was a committer on this project, I would have to be much more
> >> convinced that there is long-term value in this series than appears =
on
> >> the surface.
> >
> > 1. It doesn't affect anyone negatively
> > 2. You don't have to use them if you don't want to  3. They don't aff=
ect your aliases, even if they have the same name  4. Everyone has
> >aliases  5. Every SCM in history has had aliases
> >
> >What more would you need?
> >
> >> I am sorry if I am coming across too strongly on this subject, but I=

> >> do think we are overloading alias capability and intruding on a doma=
in
> >> that should be reserved for our users, not ourselves.
> >
> >But why? We provide plenty of defaults so that users don't have to con=
figure git in order for the program to be useful. And we will
> >continue to add more defaults.
> =

> I remain unconvinced and I found the assertion #5 somewhat specious
> and incorrect. SCCS and RCS use Shell aliases.

> There are no aliases in ClearCase.

Yes there are [1]:

  checkout | co [ =E2=80=93res/erved ] [=E2=80=93unr/eserved [ =E2=80=93n=
ma/ ster ] ]

> Granted Perforce has them, but that is not a sufficient differentiator
> to use that over git by any stretch.

All the popular SCMs have them:

 * Mercurial
 * Subversion
 * CVS
 * Clearcase
 * Perforce

> I've expressed my opinion, and it's not my decision to adopt this. So
> whatever happens, as long as it does not pollute my community's
> expectation of git. Although, providing aliases will handcuff future
> command naming.

That's not true. Nothing is handcuffed.

[1] https://www.ibm.com/docs/en/rational-clearcase/9.0.0?topic=3Ducm-chec=
kout

-- =

Felipe Contreras=
