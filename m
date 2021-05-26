Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC5AC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D28613BE
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhEZXjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEZXjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:39:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB3C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:37:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jt22so5105402ejb.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FUm3i5b/GDx6EX3g57BYAhoxugbhrDrZCN+AmqthL5E=;
        b=k+n2x1dapZAZP0Ib85HO8xqdieV7OXV2kWZSWQ+iHxlhXVWxVwErm3dNoSpAorDC13
         MzDShoerOf/rMrGCC2SL548qfcLl4Ci2KbDwpeY+TFn5Ms1DSz8UquQcHOmxb3tsvY4x
         gLIgcGNt2DCqzRt78qVIoGr40Q1g5vwelmZBpS3Azbwz+jSUsZeLIsXQWtisBdSrFvDq
         JD1ptqclEX+0zSxyUyIAqeZgs++YAT/miGMqsNx1WiI01ovXgSLwpB/tEXTFl2+Jqfhd
         l5Ll0KAnkS/NTYKkTNANHFgIvrbbSSAZgmx07O4tHNEmPbWbIE2K/n9WXdQ+vIA20r/A
         YqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FUm3i5b/GDx6EX3g57BYAhoxugbhrDrZCN+AmqthL5E=;
        b=VcroKbnZan9J5qf8mw1bxJyJ4xeCm4j1Zw79yHUUqa+ulYrMkE71FKEfltmB/mkMR7
         edhTRbjkZs8q5HV3VoiGHwILbYPHROv1JmZJrBgxpb4J/aGjorGls2RMs2wWdxFy4gpE
         dKuE3Bu5MnT+3Fs3qD+wPm0+OPq5U8n9MF5NbYmM9bAxMjycfAtvI1eoy3mKfxBLEuro
         T1fAycdrz1ze0GW6K5bhI+DBv0/WmAtg+GHHcR7bMpUQcJcwlDr9XrHqIWRxkqd+gYGi
         qStIDVG3ijFlR4vHZihn5L22SANmQb6rrcrAK7WBDI1pvNIbONoADqXjqa1Tdmexa9DW
         YxDQ==
X-Gm-Message-State: AOAM530HK3D1JAq4L0Y9OMttL7g25dEL8Z1cxCSwRWRCPVDzx0ojDR2Z
        EGPPdc9oDiSoCXNMadfmWc4=
X-Google-Smtp-Source: ABdhPJyYWVv5/KaTigDV3JdcOjb35z4Tx/vB05z3r/EsPeWtTeJpNB/xksFq0fozL2Y+E7lUtowUJw==
X-Received: by 2002:a17:906:b048:: with SMTP id bj8mr780484ejb.236.1622072256900;
        Wed, 26 May 2021 16:37:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bv17sm207141ejb.37.2021.05.26.16.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:37:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Date:   Thu, 27 May 2021 01:35:21 +0200
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <60a7fe0b2dd8d_558062087@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60a7fe0b2dd8d_558062087@natae.notmuch>
Message-ID: <875yz5m5hd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Felipe Contreras wrote:

> Jeff King wrote:
>> Of course there's value in coordinating. Everybody _can_ hang out on
>> their favorite venues and eventually talk to each other, but it's much
>> easier if everybody agrees where to go. :)
>
> I don't think it works that way.
>
> I "everybody" agrees to move to Discord, many old-timers won't. Same
> with Gitter. And if most people were on IRC, many youngsters wouldn't
> come.
>
> There's a limit to how many chat applications you are willing juggle,
> and adding one more just to chat with git developers is something many
> people won't do.

In the case of IRC though there's many IRC-to-X gateways that allow you
to somewhat have your cake and eat it too, e.g. there's one for
discord[1].

I haven't tried it, but I use another channel that has an
irc-to-Telegram (the app) gateway[2]. It works quite well. Aside from
the Freenode v.s. Librechat question I wonder if there'd be interest in
having such a thing running for #git or #git-devel.

1. https://github.com/reactiflux/discord-irc
2. https://github.com/FruitieX/teleirc
