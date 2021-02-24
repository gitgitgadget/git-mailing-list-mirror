Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605DC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27F564E85
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhBXTNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhBXTMP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:12:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C7C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:11:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id m6so1962226pfk.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6D0zSTKs4Asdy++3xAA7v3GMu7WoQnOuL9SQpNQPGoQ=;
        b=tZJOtibZiXYm4ONc7sWBH5mSOBa+IvLwm7jezyQdhx7jZ2DhKEk5ZFuW/AOQIXBXsl
         C70wobkB5fffiDyZX4sNGgzxUuGByFruKmSc0pAhDImom28trub53Q7yEnot4xoQQz3X
         3UnIaLTx1JdmGKM7zQH7T9jk4d3wsZkafEXEFgoyYuIc01t/GvSDuz53T/ulmrFCFn/4
         bBH1Nwdm/qhoxcwarTDqYHMFiwVV6zmHcnK3sAOjeytAtMeIwitmoDVcdtnE9ygZdaKN
         cEfVHdajhM69TZfpDtSuhLSioHwHQHorB5aKelfEejoFWVX0aUOSlaRA19RB7tEnWpIe
         sBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6D0zSTKs4Asdy++3xAA7v3GMu7WoQnOuL9SQpNQPGoQ=;
        b=W/6WCHAbF0qLGZ6NvReQxNETh7b9wOqNX8dNbF36bvbBXFLm62pyaFA/FPCXmjBY8r
         Dzfu1cNPTIv1d2frd8Bvwl2J/FRa6f5oSsWuHGc22sv6kE5rh/7Cm6GQpBSqR/17UKC4
         ZsdVpZ0c4KjfsYRrG9ZK9kLn0YgcDUnJhvIbDU1x7MmOCOYZTTa42sO4JzzM8p9na4uY
         Iih7nfM2hyfQePI4xDIEnpZbM7Ghzy2EWCTw0tKv1gF6X5aoelGAbi1cdVdfI+i9lN6h
         xkYpat1U0niDLDg/s+AGFIfv3IwK6qE6wpSlAZw1PvEXijzrNuT3JaxtkBl6bGX7OUHb
         WukA==
X-Gm-Message-State: AOAM533GyshRNnhzbtD/1+IM9HBx73MDrIYYazCkapoRAzzzUCEzkMty
        E/T/qIA1sk9EN4I+23sMSZmeNtSTJ+FOZZzdhFA=
X-Google-Smtp-Source: ABdhPJz0egFZzJQdT4jalVKjZsruKg4Y25oYlE3kJfxOKiNmz8md74UzROWSJToZP2U9bXO8E1pp30CHSjIbaMMtIY4=
X-Received: by 2002:a62:e809:0:b029:1ed:c7ec:179b with SMTP id
 c9-20020a62e8090000b02901edc7ec179bmr8456827pfi.43.1614193898733; Wed, 24 Feb
 2021 11:11:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 24 Feb 2021 20:11:27 +0100
Message-ID: <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 Feb 2021 at 00:57, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +that is not completely understood by other tools. Enabling sparse index
> +enables the `extensions.spareseIndex` config value, which might cause

s/sparese/sparse

> +other tools to stop working with your repository. If you have trouble with
> +this compatibility, then run `git sparse-checkout sparse-index disable` to
> +remove this config and rewrite your index to not be sparse.

While I'm commenting on this..:

There are several "layers" here, for lack of a better term. "Enabling foo
enables bar which may cause baz. If you fail due to baz, try dropping
bar by dropping foo." If I remove any mention of the config variable from
your text, I get the following.

 Enabling sparse index might cause other tools to stop working with your
 repository. If you have trouble with this compatibility, then run `git
 sparse-checkout sparse-index disable` to rewrite your index to not be
 sparse.

I'm tempted to suggest such a rewrite to relieve readers of knowing of
the middle step, which you could say is more of an implementation
detail. But if we think that the symptoms / error messages might involve
"extensions.sparseIndex" or, as would be the case with an older Git
installation,

  fatal: unknown repository extensions found:
          sparseindex

maybe there is some value in mentioning the config item by name. Just
thinking out loud, really, and I don't have any strong opinion. I only
came here to point out the typo in the docs.

Martin
