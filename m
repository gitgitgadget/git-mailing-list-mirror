Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7397C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 20:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiHKU1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiHKU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 16:27:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43649F0D7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 13:27:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so35381127ejc.10
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=tHb4Z/qG38LdQgnsaId+UBIJgxQQG19RWvqPr6plr5M=;
        b=f24/TvcoMIpnaYp6gvMZErSVcf9ejycnfmLNnVznj1Q3hydTICcMD11zsw7+3BAAru
         qM6eb3bswrYm12Vgsl2UnW9TqZmNDpiIvoBMBgLbAKxwOg5IZ5XfighO8SpwA1uZKbZU
         xr7TgXNGkcG9J22nNOVr33aW4aC5gDtHt4XRPBbMzUKkSWOp52nQoGUrqh1CJFk/OEaI
         FNluNT4ht3Dn5sn8dmJj/uCtpp4uIr7nAJ5BHcxUOCazKlh7wG9TsQPn667kDFSyOppR
         DuhOgNLUtFKzf1lO/9Z1czDdmA+1kogU2VN0t+anVrrSHtD6/iJmGExuwrelkLOMfbvZ
         SErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=tHb4Z/qG38LdQgnsaId+UBIJgxQQG19RWvqPr6plr5M=;
        b=N0BfClhVg/E39WuWzWnSGK3slkVVVDsvUj5MH/Kq9dwKm03MbHTr0l5fA2a7EBGv1w
         HuyXojAMIx/4vReyr1BdKkm4wVfX1EsrTHhmLXcDjE+7+0PSsonUvXem9SW8ls9WP2s+
         A/gvDB4jM0z2XVSsuyeSokRsFvstipBi2IiKW1hHdtbGnPitfi2wbMRm+Kv92RuAp7gf
         gY72mYTewN9HNlbl9wloKvx53dGGIC1KHLkFWDMQig/o26J1+zVTO3Uue+Nb0en2wSzT
         LKYQAI0Omu9ZPrgRqBAaW3Rwme5XODbxgsH5npUoq5Tp+pkldLIJmUfJhRAfQQ1dJjoT
         NUow==
X-Gm-Message-State: ACgBeo0CJgHnctN1jE2a0cxUkHT/5rIj1+EB6u4ORk4TV2WD4san0aAh
        LRm9jKeqBOlHzYwaVV3fyHQ=
X-Google-Smtp-Source: AA6agR4JZLy+5d1J63j+VQwd+FF3WzA8JrlouCtRvumsslPsmZlSa/9hjON0skqc+D3S2AdcAxy5jg==
X-Received: by 2002:a17:906:cc50:b0:730:b5fd:89cf with SMTP id mm16-20020a170906cc5000b00730b5fd89cfmr510842ejb.221.1660249658399;
        Thu, 11 Aug 2022 13:27:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b0072b85a735afsm42058ejz.113.2022.08.11.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:27:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oMEmH-001K2r-0G;
        Thu, 11 Aug 2022 22:27:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Date:   Thu, 11 Aug 2022 21:30:43 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
 <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
 <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
 <220805.86zggirb7b.gmgdl@evledraar.gmail.com>
 <2184ffe4-4fde-878f-052f-e7dcdebe8161@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2184ffe4-4fde-878f-052f-e7dcdebe8161@github.com>
Message-ID: <220811.86k07eplty.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, Derrick Stolee wrote:

> On 8/5/2022 10:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Aug 05 2022, Derrick Stolee wrote:
>
>>> Now that this version removed the notes ref from the
>>> decoration, the stance for inclusion is simple:
>>>
>>>   If Git offers to color the namespace with color.decoration.<slot>,
>>>   then Git decorates with that namespace by default.
>>=20
>> I'm a bit confused, sorry.
>>=20
>> So aside from "notes", if we have a color.decoration.<slot> applying to
>> a ref now, it's a bug in your series if it's not showing up anymore?
>
> The possible slots are:
>
>  * branch (refs/heads/)
>  * remoteBranch (refs/remotes/)
>  * tag (refs/tags/)
>  * stash (refs/stash)
>  * HEAD (HEAD)
>  * grafted (refs/replace/ or GIT_REPLACE_REF_BASE)
>
> These are exactly the namespaces that are now shown by default in
> this series.

No, e.g. "tag" doesn't mean "refs/tags/*", it means *a tag object*. Try
this on master:

	git update-ref refs/archived-tags/v2.36.0 refs/tags/v2.36.0

Then on master:

	./git -P -c color.decorate.tag=3D"bold blue" log --oneline -1 v2.36.0
	6cd33dceed6 (tag: v2.36.0, gitster/yw/cmake-use-pcre2, gitgitgadget/yw/cma=
ke-use-pcre2, tag: refs/archived-tags/v2.36.0) Git 2.36

But on "seen" currently:

	$ ./git -P -c color.decorate.tag=3D"bold blue" log --oneline -1 v2.36.0
	6cd33dceed6 (tag: v2.36.0, gitster/yw/cmake-use-pcre2, gitgitgadget/yw/cma=
ke-use-pcre2) Git 2.36

Before that "bold blue" applied to *tag objects*, but your series has
made it apply to the refs/tags/* namespace.

I noted this (indirectly) before in
https://lore.kernel.org/git/220726.86tu73ncf8.gmgdl@evledraar.gmail.com/;
I.e. that I have a "refs/built-tags/" namespace.

So that specifically seems like a regression by the criteria you've
established for inclusion. I.e. we have objects that are impacted by
existing coloring config now that your series is hiding, seemingly
because you've conflated "tag object" with "a name in in refs/tags/".

I *also* think it's overzelous to hide *uknown* things by default
because we think we might add more *known* internal things in the
future, but that's a distinct topic from this more narrow case, which
seems to be a clear regression by criteria you're establishing &
advocating for.

> If someone adds a new color slot, then that would need to be
> justified with a reason why that slot is important. We've already
> had discussions as to why showing a decoration for notes is not
> valuable to an end user. The stability of this config option (the
> last addition of 'grafted' was in 2011) is good evidence that this
> core set of namespaces is all users will need.
>
> By contrast, the use of "hidden" namespaces is relatively new and
> is expected to increase in the near future.

I really don't see how you're making the leap that because nobody's
bothered to customize the coloring for things in custom namespaces that
it's OK to hide them entirely.

I just leave everything at the default color settings, aside from (after
checking my ~/.gitconfig) one bit of diff coloring default that I found
annoying.
