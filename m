Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40850C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349211AbiC3RR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349202AbiC3RRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:17:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF646B11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:15:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so42916679ejb.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qqUtwALQJml9wizHYoZ4P2nRVc5Huq/cimNpLgshEtE=;
        b=KRLE2aUtGNHeAifVSQfJkpdJi/2V2y6HYmCsGLw0XLyAdnIk2ysXR2gkHu/Km7OI0Y
         K/ini0Le7kcsFnHpEu6OxRKXFYdvOCyA1gvYQk9faCJwWXPotmTZ5heZrSUlKRMyxq5o
         WHw7Y3Q/mJRQhYnAmVA26vSPFvRtrGEj4CqSADjgZk27s4qXUNB/XlXk2K3n89WploJf
         sDLhtU0tIE+Mtj9KOoLP3jxrYsCL+pLWNJhxZwIs+Q7xJvg50J2ssjzKP0CAlCJ+Q1Li
         S0VGld/eeNwd42h7gk7STuKdVAZb+oAIm7jm+ECdskekEwwkPV/u8i5TpSUc12slG/aa
         0CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qqUtwALQJml9wizHYoZ4P2nRVc5Huq/cimNpLgshEtE=;
        b=yfVqMTae4lkEO/RTXJrA44HC8KFBlmFWHzdVxImlIKJSlUUGnzMTY1/xbdPhk7cxhL
         mJlBGTJdPKaTtmLAop7+IxSPJFKy4bLFlHZ1gS+PWulnmPNS+9ZFJkOVadR4CYVpZmiX
         KNflGhJWXQF+TaLtLL5Ly67KEaM/xCD3k455yd4BK4FEDHRvHv5vlkLU1e4VLhUkXDg8
         +KMHWR57V6yfEcAAgJxGwB4au1oOb+Uqh414FZe7Xb4jcq0h3bdsHoFLavPgxcpm7kRb
         ePqlxlgF9/1k48lqqk/80Xo+x6t/PHwQJEpW67EgaDYr6DmSI5hhRI4cbYVsS5C4YWEc
         wdKg==
X-Gm-Message-State: AOAM531lUFxIPfxa5gsrz7xnkiH7AuxAKkoON1kzrfFG+0e71l6sj6kZ
        /I/mk/uJWJP5j/WYba1QOic=
X-Google-Smtp-Source: ABdhPJx9YZXKcGQEJyrsBPBuyhbeYXOZc4080m9pOK1Ip8984cNo2+6SHSO7+Xh0gs8zF7/QvCmNbg==
X-Received: by 2002:a17:906:d146:b0:6da:f381:4dfe with SMTP id br6-20020a170906d14600b006daf3814dfemr602855ejb.670.1648660538145;
        Wed, 30 Mar 2022 10:15:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm8456618ejm.188.2022.03.30.10.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:15:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZbuz-004N5S-11;
        Wed, 30 Mar 2022 19:15:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
Date:   Wed, 30 Mar 2022 19:14:58 +0200
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
 <CAPMMpoiNZ8pvrZmMqJsRV2x+Fvq-=hpih1GGSLMe=KX785Dk0A@mail.gmail.com>
 <CAPMMpohJEbfA0_0qR8jqOAXgBuwo+Nf=BkVjr0UkjeMa+STHkw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPMMpohJEbfA0_0qR8jqOAXgBuwo+Nf=BkVjr0UkjeMa+STHkw@mail.gmail.com>
Message-ID: <220330.86v8vvnyyv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Tao Klerks wrote:

> On Wed, Mar 30, 2022 at 4:23 PM Tao Klerks <tao@klerks.biz> wrote:
>>
>> On Wed, Mar 30, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> >
>> > On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:
>> >
>> > > +     if (tracking.matches > 1) {
>> > > +             int status =3D die_message(_("not tracking: ambiguous =
information for ref %s"),
>> > > +                                         orig_ref);
>> >
>> > This isn't per-se new, but I wonder if while we're at it we shold just
>> > quote '%s' here, which we'd usually do. I.e. this message isn't new, b=
ut
>> > referring again to "ref %s" (and not "ref '%s'") below is.
>> >
>>
>> I will fix the below, but I would default to not changing the above
>> unless someone thinks we should (not sure what the expectations are
>> around changing error messages unnecessarily)
>
> I take this back. I will update both - the change is in a "variable"
> part of the message anyway, and it's hard to imagine any tool
> actively/purposefully parsing the ref out of the message and being
> caught out by the new quotes. Any coordinating tool would already know
> what ref was being branched / having its tracking remote info updated.

Thanks, I'd be fine either way, it was just a suggestion.

Aside from what we do here we don't support third-party tooling that's
grepping our specific human-readable output, so changing any such
messaging is OK.
