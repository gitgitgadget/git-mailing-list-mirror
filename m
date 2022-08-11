Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF63C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHKUdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiHKUdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 16:33:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824269F1B8
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 13:33:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o22so24352786edc.10
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=4BQ68PaEHwPn3jru7I5dAvDOI59yZaJ9owDzi5PdmlU=;
        b=ahglaC5sazKcmiLl0OcY/C0DinyC13gxv5KOFqVw0VvgsSiDNfXoRhcRz3+lfaq1uP
         ndV/9lxpE50hU14Saay2ZcSj/AETeyxiIc8g/ixasQaodSePF83LmjckJ4RUegYdmVvC
         KdtEfC4hS9BW+3LZNJOGrYCnQiwh7h+zxPLuXIdawYKw8kMnyyPfMdIuCYAbFoZMlOW1
         dJklIx0/g3uc2fWKlBFpdonWCK3g4FE8X/d1arAB/uSeXVdrirbj6xS8aClU3ljalEf1
         JqrIkjRhyM0HuKDqcC4VA1flNrWHuzcOxjw7ogN3osESOIcQ6IQMlFz24UGVM6HMcGOM
         yGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=4BQ68PaEHwPn3jru7I5dAvDOI59yZaJ9owDzi5PdmlU=;
        b=dYfixpOP+ZEltFCHwfpddwY1gnkJPBrkklCUBFymqdQ1Jea+3F4oyagK6mKyA8fPbV
         KKl68fqAmCoT2kVhgqIX6iv2iMi1MSSXELzjtonm0NgWXNE9ayXTPtf3LtaIombCgden
         2uqq8qGTxJUH2BzK90hO8qDgO9vCHfWcXEAyzxGnmdpcF3R0qXu1dH3vMp54y0I/hW6c
         hqQCG5ApfTCI01Ky5+Dg37DFXPe0oPKEFChiXwsZsYddmHfbiOxBbR0ah1NYP2FpAnc9
         0jTgJNeVHhrPQ5aWYXYpLzJCP7KlMMpqWG46ymRmLJCQoACobFtQYpAHK8qQc9ptcasi
         ufvg==
X-Gm-Message-State: ACgBeo1tLeN+GM23HSxF2OCHCxOndeGijUOE7h1fVWTJg3OvFLAjDyIJ
        UtcjCGLTk4ntNOlDPTy0QVI=
X-Google-Smtp-Source: AA6agR71bRzcQoiyQEOfaFw1a2ZC4wJmy1cWosQetvu/CIobwy5laeWXM4YlqcOzK/MGAxbzhXg6eQ==
X-Received: by 2002:a05:6402:32a8:b0:43e:5490:295f with SMTP id f40-20020a05640232a800b0043e5490295fmr738419eda.193.1660250009863;
        Thu, 11 Aug 2022 13:33:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906844800b0072af102e65csm43541ejy.152.2022.08.11.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:33:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oMErw-001KFr-1I;
        Thu, 11 Aug 2022 22:33:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 09/11] builtin/bugreport.c: create '--diagnose' option
Date:   Thu, 11 Aug 2022 22:30:22 +0200
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <1a1eb2c980635415c04d5c8d9a62bd972482d7dc.1660174473.git.gitgitgadget@gmail.com>
 <220811.86edxnqcdk.gmgdl@evledraar.gmail.com>
 <f9a5f658-7c6f-bb3a-d6df-0ab7d2908395@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f9a5f658-7c6f-bb3a-d6df-0ab7d2908395@github.com>
Message-ID: <220811.86fsi2plk7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 11 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Aug 10 2022, Victoria Dye via GitGitGadget wrote:
>>=20
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Create a '--diagnose' option for 'git bugreport' to collect additional
>>> information about the repository and write it to a zipped archive.
>>> [...]
>>>  'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <f=
ormat>]
>>> +		[--diagnose[=3D<mode>]]
>>> [...]
>>>  static const char * const bugreport_usage[] =3D {
>>> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format=
>]"),
>>> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format=
>] [--diagnose[=3D<mode>]"),
>>>  	NULL
>>>  };
>>=20
>> This still has the SYNOPSIS v.s. -h discrepancy noted in
>> https://lore.kernel.org/git/220804.86v8r8ec4s.gmgdl@evledraar.gmail.com/
>
> The discrepancy you pointed out was on 'git diagnose' (which has since be=
en
> fixed),

Ah, sorry. I missed that & conflated the two.

> this is a pre-existing one in 'git bugreport'. I decided against
> fixing *this* one because it didn't really fit into any of the patches in
> this series, so it would need its own patch. When balancing "leave things
> better than you found them" vs. "stay focused on the purpose of the serie=
s",
> I leaned towards the latter to avoid setting a precedent for other 'git
> bugreport'-related scope creep.

In any case, I'm pointing out the difference in one of them having
\n-wrapping inconsistent with the other, which is an addition in this
series, sorry about not being clear.

I see that there's also the difference in how they format "--suffix",
but that's pre-existing & we can leave it for now. I think that's what
you're pointing out here as pre-existing.

> If you have the patches to audit this sort of thing, I think a nice place=
 to
> fix this might be in a dedicated series fixing discrepancies tree-wide. E=
ven
> better, you could include the patches in your tree that detect them as pa=
rt
> of e.g. the 'static-analysis' CI job.

Yeah I do have those, and will probably submit those sooner than later,
and I'll end up spotting differences once they land on "master"
(e.g. [1] is one such case).

But this one is just one I eyeballed during review.

1. https://lore.kernel.org/git/220811.86o7wrov26.gmgdl@evledraar.gmail.com/
