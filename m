Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBEC47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BA5610C8
	for <git@archiver.kernel.org>; Sun, 30 May 2021 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE3NY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3NY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 09:24:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E3C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:22:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d20so3841778pls.13
        for <git@vger.kernel.org>; Sun, 30 May 2021 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZ84LVLAiTCjg6nA0bSF4Ktmjheo0mI+E3BDM0Cu870=;
        b=KO6tSOHu8ipRoX4Bkc/25VuDqlfwiGpmpskj7CO5udeCuq2tfwo3/WW7416kTfw26B
         Zz8dv6QDkBM1dokp90cSKaZHWBRNQLxxBM2OWvxgRyVjVWlpvpvqYkFJd82xEVtHNj+r
         O4vcWehM5hjpYEAVBl51K/oxdimasUjqJi9tTMAWVdri8POhj9vYYpaBkWGTbtLPNogA
         D/wLMFDqgSiWCXnnTnvrtnWXeJXwOT4/aaGbAlnlI+LFWkvtrBuGDg04q8RoE9J5Aryz
         /zQ+S7/EA9+EN3/Hnij2NSRUo3AlQ5ECYLd2e4eAlwO1x42Oj0kHj8MEj7kMXhES65CX
         YnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZ84LVLAiTCjg6nA0bSF4Ktmjheo0mI+E3BDM0Cu870=;
        b=mLH82S5x6keNO7kmLA57wVdHVVYk5uvRVmmPIZ4zxWB6IFScK1ImrNzqWOgLSzV0yv
         9J8NxGE+ArxekLchkLFvn6vbXSp0FP0v6YFhZQQqJk1ctM4j9LNp9uIPnNxqGEnPqpVb
         RY5z3WOZM/46eeF9kGsOxaEx2WMr9GQmVa6p1DhXCOFOxGOOR8IjPAPkSyDH4PAEv4ZK
         u6N3+MVxfsFnHPcvF2yz9wh412w7WwAq0qmJzQAibmr9B8kMR1NMSpV/Nqpx3O13+mIp
         Ga0jRK5GQ1AnmFiAP78LtiFWiWIAZORIhjNsiCxJ8lFgns8QGc6Z7HP0Npx1b1PcyMwo
         mGFA==
X-Gm-Message-State: AOAM533g9DCDaOeU2Bw6XWG0PWvERlXkTlkJ9VKm3oRDx6+hKMxKBmkq
        yH/c5KGwrq1bhI0QiMlIjMht9NT93C2/SicCkDg=
X-Google-Smtp-Source: ABdhPJzGYBN6/6MCuCr1pWIE9lmXY7C22qT/JHMdxx3thFb7Zl08Ou3lsM2Q5Bl16u9qUCzEgmdwlB5fhYaJgCykXDs=
X-Received: by 2002:a17:90b:3001:: with SMTP id hg1mr2304088pjb.169.1622380969692;
 Sun, 30 May 2021 06:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email> <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email> <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com> <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
In-Reply-To: <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sun, 30 May 2021 09:22:39 -0400
Message-ID: <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 30, 2021 at 6:52 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> quick thoughts..
> On 30/05/2021 01:14, Matt Rogers wrote:
> > (resending because client reconfigured to not use plaintext)
> ;-)
> >
> > Reading through the documentation, Visual Studio seems to support
> > CmakePresets.json [1]
> Is that stored with the project, or with the VS installation (still to
> read [1] beyond a v quick scan..)

This file would live in our source tree next to our CMakeLists.txt.  It's kind
of cmakes answer to the problem CMakeSettings.json was trying to solve.

> >  for handling configuration of cmake options.  It
> > might be worth it to keep the defaults as is.
>
> Given that it's just changed, do you mean ' keep it as new - Ninja' or
> 'keep it as old - VS generator'..
>

Users should be free to use arbitrary generators and have them work
out of the box for normal use cases (here I'm thinking of IDE integrations
as well as just running builds).  So you should have the option to use
either Visual Studio with Ninja or with the Visual Studio 2019 generator.
I personally prefer Ninja, but maybe somebody is stuck using an older version,
or would prefer to have a .sln file for other reasons.

Personally, I think that most users not knowing anything would go in
thinking that arbitrary generators are equally supported with perhaps
a small number of knobs.

By default Visual Studio 2019 is probably doing an invocation something
like:

mkdir out && cd out && cmake -G Ninja ..

Which would ideally just work automagically.  But if for example you wanted
to support using vcpkg as a package source, we're pretty much forced to
provide a knob here (what if I wanted to use Visual Studio as my IDE but
not want to use vcpkg to manage those dependencies for example).

I think the best middle of the line solution would be to just provide a manual
knob for turning vcpkg support on/off here and offer configurations in
CMakePresets.json for both situations.  The only downside here is that I believe
a lot of IDE's are aggressive about running the cmake configuration step and may
try to install vcpkg even if it is unnecessary.  But automatic
generation can generally
be turned off by users I guess.


-- 
Matthew Rogers
