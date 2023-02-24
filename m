Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C2C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 19:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXTYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBXTYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 14:24:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179F168A0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:24:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so2889286wmb.5
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdgPT+VUswNUGUZyUg9cevQyY/H9Pmm8xJApyyPhPB0=;
        b=IlEs/Kulz6m/z19ORsdtR8DFvMjTW9ZGjhafHjWQwgsyoCsFtNhTksh1Pwp3oQMxhs
         7LL9mTntmAdJ3DHTlZdsXKujnrmwubZ2rFM6RayM/j65oi42izAUQE1btim97wTkEVc1
         C0wVybXFbvqqL1S710u3QGA1/yk6og7hViWr/aUAfgYfVqbdmNRN3rdEbFvP8mLQvxfJ
         dD6xNQgZayMx/FrbC+Kdr7JOnYsbHNT9uBUcHb4Sa+4cafDrmhYohxEPJnVr7Qnl3q/B
         BbZasAQU+1tC6cfqSzJwyALd5BouZeUI++IG21S3qLtVStB+xdPJCt9hJAFxtgEMTNxV
         32QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdgPT+VUswNUGUZyUg9cevQyY/H9Pmm8xJApyyPhPB0=;
        b=b2z60Tm3KbWkG1vLtu8BjDoQuh+CiJ9ysTv3r3Wr+7GHkK0K0GWexmuQ0PHs/F0Pay
         YAyW5gjhNY4NT/WaCChB18a5yo+MvhOYbgdL3L5S990vCJKdDLJPEtWxLsL2SkiGCU8E
         hNW/2LJUMXfGD5uLpwYyK+CPxBgLm9QZzuPN2V85NfkhMR70KDdBYaz6BnTYMwOTBHvp
         SbfV9jG8VrgA9SoM2YB2e3oyIhhzqmyjUAyFUKbvLptdDMI+Pp6X1POqEph6FBNo9YBQ
         GuEkeIfmNdKwlIypvtLIHdzWHGT9y4+RMfd/EIxIU2Vp+o5uMBBcInjdw118RagMY1gb
         qguw==
X-Gm-Message-State: AO0yUKVjyIB5ghevPyvX91lxgupXx5Ia06Nk8ihmHujEYc8ae30Ose9K
        7HPYU56M1zx7jc2SlvMFVCo=
X-Google-Smtp-Source: AK7set/AjnyOs7UibnjTZ4r4TvyRtk35jozEaM8y6XjvPYmlLC8jacJ2HCQukaYWCOh0sC2FuzB+EQ==
X-Received: by 2002:a05:600c:4f04:b0:3e2:1dac:b071 with SMTP id l4-20020a05600c4f0400b003e21dacb071mr604915wmq.13.1677266686090;
        Fri, 24 Feb 2023 11:24:46 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id n4-20020a7bcbc4000000b003dc3f3d77e3sm158362wmi.7.2023.02.24.11.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 11:24:45 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2b28155d-f82d-06b8-2df9-135608c6bf63@dunelm.org.uk>
Date:   Fri, 24 Feb 2023 19:24:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com>
 <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de> <xmqqy1on0yla.fsf@gitster.g>
 <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
 <xmqqcz5z0wdb.fsf@gitster.g>
 <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
 <xmqq8rgm29fw.fsf@gitster.g>
 <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
 <xmqqpm9yzxky.fsf@gitster.g>
In-Reply-To: <xmqqpm9yzxky.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/02/2023 19:13, Junio C Hamano wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
> 
>> Phillip is concerned about people and scripts assuming that
>> --rebase-merges is equivalent to --rebase-merges=no-rebase-cousins,
>> see [1].
> 
> Isn't that already broken when you introduce rebase.merges
> configuration?

Scripts using --rebase-merges are not broken by the introduction of 
rebase.merges so long as we follow our usual convention of always 
allowing the commandline to override the config (i.e. --rebase-merges is 
always equivalent to --rebase-merges=no-rebase-cousins). I don't really 
understand why Alex is suggesting splitting the config into two based on 
my comments.

> People and scripts are already relying on the lack
> of rebase-merges to flatten, and script writers will be surprised to
> receive a "bug report" complaining that their script does not work
> when the users set rebase.merges to anything but no.

That is true.

Best Wishes

Phillip

>> Tao and others are probably not going to like it if --rebase-merges
>> without an argument undoes a rebase.merges=rebase-cousins
>> configuration.
> 
> That is why I suggested to keep --rebase-merges= (with no value or
> an empty string) only for those who came from the world where it
> defaults to no-rebase-cousins and there was no rebase.merges
> configuration.  If --rebase-merges= is given from the command line
> without value *and* rebase.merges configuration is there (which is
> Tao's concern?), the command line option can error out asking for an
> explicit value to countermand whatever value is configured.
> 
> Wouldn't that work for folks from both camps?
