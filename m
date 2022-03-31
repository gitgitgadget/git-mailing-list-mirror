Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B48C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiCaKVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiCaKVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:21:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F813BADC
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:19:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so27579954edw.6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oc1DXqiVZ4hfgQsWiu2yXoUBfCPk1G2i3yjP1wMHcwA=;
        b=T+SKS/Ueu2agsNQ1w2DDxURZG114+Zy99gcE+omijGGS6HZyynTvXz0tUTmA2Rdbut
         eJZSth3s4SGEfQ+6AF0QQajSz+z0WICD7kv9s10v+Gk8zhlcaLPzTjP50qfsvMiS6kg5
         AStR97Wbb4xFGy4seiKWv2ryk/mj+eUROL7I4+fOYQZOuNacCtHM1YlS+QTUj2LZEEk/
         bWAu9zIByWdh2JayqU7r460qJeVGardk2vHKLoJBktOvm5Inega+opU4HTQlrNBr4WNV
         btAtUDi80bXJ2Vbd8dchfbR8rQKYc2CVUs1eslmzFORATAbw9d/D/2MRDZ0bOKbEuNRR
         3ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oc1DXqiVZ4hfgQsWiu2yXoUBfCPk1G2i3yjP1wMHcwA=;
        b=0uSJqpvFEwUSdi97NhpEo0Rt65EQ7v0VF396ZpEsUArHzlOM995uGrfFQrzJs4foN/
         A1BzJaK/CtRls1RxBNB8hAas5uas6P7LHQ/yq5hz7o6pnjJUVW4fOiYstHtdUeAx8bTf
         2hym8nch3Kc/JFjzlBwEt26xi2OIoWc8R+H0fb58oJmCY49I/RtXwwttcKwzWVmhxnQW
         nuHc0GvxLOH+sW009RUsm8/Xlmljhr+fr65+EK3OW4Wq3wNTHMGVfEzkZh8STv8Nkrd2
         JwxQkfpZgc7Sfw4PO+UXiclN7DySeErWc/YLEnnE1tyGeKdBhzW0EhR29K9/fZRWHaV6
         Jmhg==
X-Gm-Message-State: AOAM533v4CZn41UPv9nO8qYHXAm7vGbyXC/ASzN8iJfQ8r/JhUvbB2mH
        H25UzhUmSkhqqqEmhlVbNQs=
X-Google-Smtp-Source: ABdhPJxp6AD7pJzArlRLltOWdZ8aiDg63iUbXHnCsAc7khpz9cbqCgheJKoQ49LAvmnRzCms+Ax27A==
X-Received: by 2002:a50:baa1:0:b0:418:849a:c66a with SMTP id x30-20020a50baa1000000b00418849ac66amr16051871ede.234.1648721991955;
        Thu, 31 Mar 2022 03:19:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v26-20020a50955a000000b00418ebdb07ddsm11230770eda.56.2022.03.31.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:19:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZruA-000LZ3-E9;
        Thu, 31 Mar 2022 12:19:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
Date:   Thu, 31 Mar 2022 12:10:20 +0200
References: <xmqqy20r3rv7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy20r3rv7.fsf@gitster.g>
Message-ID: <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Junio C Hamano wrote:

> We raised the weather balloon to see if we can allow the construct
> in 44ba10d6 (revision: use C99 declaration of variable in for()
> loop, 2021-11-14), which was shipped as a part of Git v2.35.
> Document that fact in the coding guidelines, and more importantly,
> give ourselves a deadline to revisit and update.
>
> Let's declare that we will officially adopt the variable declaration
> in the initializaiton [...]

Typo: initialization.

> part of "for ()" statement this winter, unless we find that a platform
> we care about does not grok it.

I'd think that waiting a couple of releases would be sufficient for this
sort of thing. I.e. contributors to this project already have
access/knowledge about a wide variety of compilers, especially the
"usual suspects" (mainly MSVC) that have been blockers for using new
language features in the past.

So I'm in no rush to use this, and the winter deadline sounds fine to
me in that regard.

But on the other hand I think the likelihood that waiting until November
v.s. May revealing that a hitherto unknown compiler or platform has
issues with a new language feature is vanishingly small.

> A separate weather balloon for C99 as a whole was raised separately
> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
> on all platforms we care about, we can stop probing the features we
> want one-by-one like this

Unfortunately this really isn't the case at all, the norm is for
compilers to advertise that they support verison X of the standard via
these macros when they consider the support "good enough", but while
there's still a long list of unimplemented features before they're at
100% support (and most never fully get to 100%).

We also need to worry about the stdlib implementation, and not just the
compiler, see e.g. the %zu format and MinGW in the exchange at
https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.com/
and
https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.com/;

But I think we're thoroughly past needing to worry about basic language
features in C99 such as these inline variable declarations.

> (it does not necessarily mean that we would automatically start using
> any and all C99 language features, though).

Yes, particularly those that the standards committee backed out of or
made optional after C99 would be good candidates for avoiding
permanently.
