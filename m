Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 14:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiCDOy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 09:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiCDOyz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 09:54:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B691B0C51
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 06:54:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt27so18118750ejb.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5bxWZiRo2pBEWyYZdCU/e7EnxFXZylvLMJGQmN6swuE=;
        b=LWUaanQKwyHL/vK2+jkZdF61cXZzomiyBMeZ81HgCO5Ts4JZMgB2gfJERMLcv20S2i
         V6FIPVqtwRAraiOXMY0oaXacp2wh/5P2UiEXTkDWDIo9nD3/RemH7KQOAmgn4UnmVzUY
         +wT0DYvDxKfn1JQgXgF7PHDZ/nsTcsx+BEXoWuh9fA9LTegcbOrwv9pFp6IrfLj+l4Q0
         cmkcMEzNyq6Ttg4yBrijQuheLIEfybX2nq8HLRGFxWFG5jEJl6kod26srw52uCIpqfZ8
         a+uHLe1JS2bXCGRfiozf3zRwKUn+BdhIoengpdyMkjrQssHOAELTn6chY8mmufc8DRod
         dUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5bxWZiRo2pBEWyYZdCU/e7EnxFXZylvLMJGQmN6swuE=;
        b=oOqzm/NOtff/YEajdqJ8cYNkVzHiwZ/YAnk3+IG7Jp6flI7pzMq1DObDC2sbii38RE
         7VFY1YaJblVGRYRxBn9DHyF4Ng0ztIsT5q+YJZpqmb7L75ztwsF90TEurkad/qctWVIi
         feDgr+QAMm0a6S2lihRc5iZSGwSuI0MWvgH6Zdw18XCSqamA+bv3lV2Wd4GAqUq1xdQZ
         K4cL66ZSeZvgDIb34B+yHaYGNxWy6ixGGCqzoIN+eMtXmAKS/fOvydA2d8tbg7yjXoXN
         5nYE0OViZnmxgoC7pfiqwHG6ocC7KGsx4ELBNBqVrbiL2qNXCwAD/0nOxRGmamq7nLT6
         xYrg==
X-Gm-Message-State: AOAM531rA79PGHqxgVUtEdPNKDWnQaC7l3AE0P0Bm06A4eDolVv4peRF
        ygYFQkKka7YBTA4jhMPIlAs=
X-Google-Smtp-Source: ABdhPJzF4geNuwvVlxL5PNjIMt4DGfzG8K0It/rOci2byVpqzwyDibgCLhQBqtl0+14pR8WJ+sYYWQ==
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id i3-20020a170906444300b006cf6a7d5f9bmr31331523ejp.12.1646405646218;
        Fri, 04 Mar 2022 06:54:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gb11-20020a170907960b00b006d20acf7e36sm2008313ejc.144.2022.03.04.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:54:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ9Jk-000MzG-LJ;
        Fri, 04 Mar 2022 15:54:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Date:   Fri, 04 Mar 2022 15:49:58 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
 <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
Message-ID: <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 04 2022, Derrick Stolee wrote:

> On 2/24/2022 9:11 AM, Derrick Stolee wrote:
>> On 2/23/2022 5:17 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
>
>>>> There have been several suggestions to improve Git clone speeds and
>>>> reliability by supplementing the Git protocol with static content. The
>>>> Packfile URI [0] feature lets the Git response include URIs that point=
 to
>>>> packfiles that the client must download to complete the request.
>>>>
>>>> Last year, =C3=86var suggested using bundles instead of packfiles [1] =
[2]. This
>>>> design has the same benefits to the packfile URI feature because it of=
floads
>>>> most object downloads to static content fetches. The main advantage ov=
er
>>>> packfile URIs is that the remote Git server does not need to know what=
 is in
>>>> those bundles. The Git client tells the server what it downloaded duri=
ng the
>>>> fetch negotiation afterwards. This includes any chance that the client=
 did
>>>> not have access to those bundles or otherwise failed to access them. I
>>>> agreed that this was a much more desirable way to serve static content=
, but
>>>> had concerns about the flexibility of that design [3]. I have not hear=
d more
>>>> on the topic since October, so I started investigating this idea mysel=
f in
>>>> December, resulting in this RFC.
>>>
>>> This timing is both quite fortunate & unfortunate for me, since I'd been
>>> blocked / waiting on various things until very recently to submit a
>>> non-RFC re-roll of (a larger version of) that series you mentioned from
>>> October.
>>>
>>> I guess the good news is that we'll have at least one guaranteed very
>>> interested reviewer for each other's patches, and that the design that
>>> makes it into git.git in the end will definitely be well hashed out :)
>>>
>>> I won't be able to review this in any detail right at this hour, but
>>> will be doing so. I'd also like to submit what I've got in some form
>>> soon for hashing the two out.
>>>
>>> It will be some 50+ patches on the ML in total though related to this
>>> topic, so I think the two of us coming up with some way to manage all of
>>> that for both ourselves & others would be nice. Perhaps we could also
>>> have an off-list (video) chat in real time to clarify/discuss various
>>> thing related to this.
>>=20
>> I look forward to seeing your full implementation. There are many things
>> about your RFC that left me confused and not fully understanding your
>> vision.
>
> I am genuinely curious to see your full implementation of bundle URIs.
> I've been having trouble joining the Git IRC chats, but I saw from the
> logs that you are working on getting patches together.
>
> Do you have an expected timeline on that progress?
>
> I would like to move forward in getting bundle URIs submitted as a full
> feature, but it is important to see your intended design so we can take
> the best parts of both to create a version that satisfies us both.

Hi. Very sorry about the late reply. I relly meant to have something
read to send at the end of this week, but it's been a bit of a
whirlwhind of random things coming up & distracting me too much. Sorry.

I'm also totally on board with that goal, are you OK with waiting until
the end of next week at the latest?

Also, as noted in the upthread
<220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to chat
in a more voice/video medium in parallel (maybe mid-next-week) about the
high-level ideas & to get a feel for our goals, conflicts etc. Doing
that over very long E-Mail exchanges (and the fault of "long" there is
mostly on my side:) can be a bit harder...
