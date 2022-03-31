Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E430C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 15:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiCaPIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiCaPIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 11:08:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35802128FA
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:06:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bq8so34778190ejb.10
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KW2Nli8wt5QOd/2uRcxQCarFVVHs/ec4U5mnp6+1mnY=;
        b=hPXtVm+N6Ac0sK7ThQUk+SoBAyE6ayJzxp+EKo4OCwBZUTCfmq4B06ENobMZNsWxOP
         zJgCsHRytSIZUrY9TYof3daCqzWGaragJL153HCyBo5xgaK1zOXP80xutZjT9+C3/r7q
         tVyJBjkQcBep7iUSmjAcLMV54prPGSpC7vaUlz8SSWxrFQV6IzVCyOUgIVoxhtCDeTVD
         mSMua1UxhbSEQV80xWA9CORHrwnAYZaBBr1iVI5uHzyxUBXdAQ2cPHOVU2w4SSjkK7kL
         EPRG2ejuNOaY5ygmnfpGX+a1I6ipboOtq7o4k+OcsIJMsWRIAvLKB5oQQLV4GqoWViv5
         JR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KW2Nli8wt5QOd/2uRcxQCarFVVHs/ec4U5mnp6+1mnY=;
        b=u0QudBoVrzE30wXBcyRaWe20ij0rSlN06XacnmKYdw/Zqe/b70jS6NJzRETwb72AF2
         tQWFJU39PmFcfwgV6wmlW/rCFrOH7VvKy5qCm/SaezuEGElj8cG4BEcfiOeWo/sfwU8o
         j2l8RyOfurtmmU295RF/rEprwnHWSjP9gl7A48AcQBrph9cGcBaKVIrCjite7X653ZRw
         QtiivWXPgudJ0GI8hnPRy+pnVZr6vQzVlbnPXtXOb2jO35FG4Z3zKC/XQPmyONpn/YDt
         HEFnqRsS1I457romzIxYTN4CzZLFz3hyLy7fy4JPYcmD85yO+ky00kWGeKhGEdsO+FHx
         xtZw==
X-Gm-Message-State: AOAM530YCrG5rAUk5fNTbBZyPzTwR48xouKAQ0YNLTgZkpFX9zARiAxt
        0GyqvevHk2ToGb4A0G7s5Zw=
X-Google-Smtp-Source: ABdhPJyH0fOZ0iwyEW8eprrJduH5CiqfNrBsnoNSZ0gnE35IeWaNbnXnBwT3YtgPJGmUoCIS4Bfoag==
X-Received: by 2002:a17:906:a20c:b0:6ce:a87e:5013 with SMTP id r12-20020a170906a20c00b006cea87e5013mr5137189ejy.379.1648739211952;
        Thu, 31 Mar 2022 08:06:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id au22-20020a170907093600b006e4ad0bf8f7sm822451ejc.91.2022.03.31.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:06:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZwNu-000VGU-Rk;
        Thu, 31 Mar 2022 17:06:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
Date:   Thu, 31 Mar 2022 16:58:07 +0200
References: <xmqqy20r3rv7.fsf@gitster.g>
 <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
 <bf44f83b-0d18-8132-58cf-13155bfec40e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <bf44f83b-0d18-8132-58cf-13155bfec40e@gmail.com>
Message-ID: <220331.86sfqyp3ed.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Phillip Wood wrote:

> On 31/03/2022 11:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Mar 30 2022, Junio C Hamano wrote:
>>=20
>>> We raised the weather balloon to see if we can allow the construct
>>> in 44ba10d6 (revision: use C99 declaration of variable in for()
>>> loop, 2021-11-14), which was shipped as a part of Git v2.35.
>>> Document that fact in the coding guidelines, and more importantly,
>>> give ourselves a deadline to revisit and update.
>>>
>>> Let's declare that we will officially adopt the variable declaration
>>> in the initializaiton [...]
>> Typo: initialization.
>>=20
>>> part of "for ()" statement this winter, unless we find that a platform
>>> we care about does not grok it.
>> I'd think that waiting a couple of releases would be sufficient for
>> this
>> sort of thing. I.e. contributors to this project already have
>> access/knowledge about a wide variety of compilers, especially the
>> "usual suspects" (mainly MSVC) that have been blockers for using new
>> language features in the past.
>> So I'm in no rush to use this, and the winter deadline sounds fine
>> to
>> me in that regard.
>
> Agreed, I think it is worth waiting so we don't get into a situation
> where we end up having to revert changes that are using the new
> features because we discover they are not supported by a platform we
> care about.
>
>> But on the other hand I think the likelihood that waiting until November
>> v.s. May revealing that a hitherto unknown compiler or platform has
>> issues with a new language feature is vanishingly small.
>>=20
>>> A separate weather balloon for C99 as a whole was raised separately
>>> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
>>> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
>>> on all platforms we care about, we can stop probing the features we
>>> want one-by-one like this
>> Unfortunately this really isn't the case at all, the norm is for
>> compilers to advertise that they support verison X of the standard via
>> these macros when they consider the support "good enough", but while
>> there's still a long list of unimplemented features before they're at
>> 100% support (and most never fully get to 100%).
>> We also need to worry about the stdlib implementation, and not just
>> the
>> compiler, see e.g. the %zu format and MinGW in the exchange at
>> https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.com/
>> and
>> https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.c=
om/;
>
> That's a good point, it was a surprise to me that the problem is with
> MinGW rather than MSVC.

Yes, thanks a lot for tracking that down.

I wonder if we can supply a compatibility sprintf() shim for that setup,
there's nothing urgent about it, but the verbosity of the casts and
PRIuMAX inline adds up, especially as we've started using size_t more
widely:

	git grep PRIuMAX -- '*.[ch]'

Either by e.g. grabbing the sprintf() shim from say gnulib, or our own
shim that would intercept the "const char *format" for sprintf(), and
pull a trick similar to what we do in strbuf_addftime() to rewrite the
format (of a copied string) on-the-fly.
