Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD42C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4567C2076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuTQ1twD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgKXMfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbgKXMfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 07:35:20 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A5C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 04:35:20 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so20664584edq.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 04:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dGkrMUWNlhh0waG+BMtMKP+XrMI9DAqUTCes6FFUA88=;
        b=LuTQ1twDa180rOW22r1qBhoZ9lEt3b5npT6+8oW1ImDC1q1xd7P0qcY8FtOOf7BBTq
         ewhi0MkKQ35kIYTeyXDe7bQH4MIVRdaPUl8CsZsWROFtXEPPk3w6PlUH/X3chRJ+R30c
         1nokmti6/0tbIpe30P94lTRKtFK/O2x+e4c1dgLWJhIzod3353QrLFEjZtJMoouuFQYF
         JQ+Ee9XHdrPmFDjpwKfETqrRIfkWD+5pWldODsUz27P57I2cLTROwHcHSf8ilN0/EOJA
         CLBQKeFA5QLd6tcfVzX6Noc5+u1A/sM5tNeftOiUm9HD6FYwr4uTgY0vASIbpW3rGzNT
         GC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dGkrMUWNlhh0waG+BMtMKP+XrMI9DAqUTCes6FFUA88=;
        b=DYGUs5HeodBbgkh8SjEfmKKtgrwiIvZgbmZnd4CXzcHHSw2U/FesaZEVzMEojCC4K0
         WauSdEueRpDQbN0WB7gIysFtmR5JXOQqM2lg2sUu/kFS+gfG6bX/G/27G6sUoPmWms13
         cxKbwrH1s9fcRiz6DB6FoRhcEMJawZ1eAR/8bH3VBma/k1C85QytlyeAZof5OaS3q0vE
         KAudXLymwm/TRG2qSRN25pnU/mIHqQzvFylxILAMZD/snYJVf/ZcaHZXGZus2jXpJ6Yy
         4+dWF6cSYTbOWFZu3HNYRSl/AYb28yqT1uL+scNPzZWvN8iRkmxorq7gHsRQn2qbgrpK
         oHTw==
X-Gm-Message-State: AOAM532lTXAZnKQviP+xvuv5F4Y+x+dN0NSAI7EOXvAeqTskQA2r/RdF
        k1SmLekdJZzzxoOwAn8rqDsCPrQNy4SyMg==
X-Google-Smtp-Source: ABdhPJyYeHYySFoUspUgBo+yYI4b4G3R295dL3qjNyGyTiNH+0v3T9GCmD//c606imIPtbj+MjF6vg==
X-Received: by 2002:a50:fb07:: with SMTP id d7mr3533770edq.169.1606221317959;
        Tue, 24 Nov 2020 04:35:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id b21sm6732460ejg.93.2020.11.24.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 04:35:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] config: add --literal-value option
References: <pull.796.git.1605801143.gitgitgadget@gmail.com> <87k0ugp3mg.fsf@evledraar.gmail.com> <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
Date:   Tue, 24 Nov 2020 13:35:16 +0100
Message-ID: <87blfnoruj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 20 2020, Derrick Stolee wrote:

> On 11/20/2020 8:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Nov 19 2020, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> As reported [1], 'git maintenance unregister' fails when a repository is
>>> located in a directory with regex glob characters.
>>=20
>> Just as bikeshedding on the name: Did you consider something
>> thematically similar to the corresponding git-grep option,
>> i.e. --fixed-string[s]. I see -F is also free in git-config(1).
>
> I definitely wanted to be specific about "value" in the name,
> since some options include regexes on the key as well. I'm open
> to new ideas, and combining your idea with mine would introduce
> "--fixed-value". Thoughts?

Hi. I see you've already sent a v2 with that. Looks good to me. FWIW I
didn't feel strongly one way or the other about it, either would be a
fine choice by someone who's eyeballing this more than my cursory
glance.

I just wanted to point out the grep option in case you'd missed it,
since we've got a bazillion CLI options all over the place, and
sometimes there's an existing option that's thematically similar to a
proposed new one that's easy to miss. So we can re-use (or partially
re-use) the name, behavior, or not.
