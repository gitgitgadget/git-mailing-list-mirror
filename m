Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFCC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1AB6125F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhHXKBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXKBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:01:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A5FC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:00:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so1664717pjb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EqVUB2frvKlXztgJ8bYCWHb96BvhbE4HwPQe8JXSbcE=;
        b=Oz8mHOcvHyq36g/XbKtijX5gNmU2b6vwOAZSTQoRu60tqolbJoQqEsVCLZydotANZh
         y2dYalExvvB3cuMQGgGkQhvOjfwIsoucy6vSTzFV8y63ucLSZEGROv68RONbcLts7em1
         fkC9CW51FHPhLHwnpbFZI3lgDXvMB71ciJm2kXZ4TRHX0iVQRVJrpEu9HhOnw4N5cWeg
         vQ86PFGhb2FlLk41g1WLPW3/06X7M4sUb3GhE5KNq7ZFS2MV/1evInaF++J21+BpWwIM
         VCVGeR/cMjM1qVGT0ZtMU99RRvnhSL9ANTPw93fHSWLbE3UQfdBdAxIv/0aRCgKDZNEx
         AJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EqVUB2frvKlXztgJ8bYCWHb96BvhbE4HwPQe8JXSbcE=;
        b=RW+rp3Ngyi+xB5Lkg5bMB68NrUQXp8kATl4wcFM5asbtnVhBMCvjiHIwVi2iOOtQZ9
         cRUxv4t4lDryVqCEzQRqV9T8zgCYqln6IpWxFskTSRbRs1CMhU0seX+bHXVwbi3GgQwv
         q/HM0W6wRxDcwpYdqDiiqy71dlZ5nPrSQgmwpslhK4pSD+ZxuDYNEYBOVLpDbL3TOuon
         qreahubeH9YfPePAYzqljNkVql5reaLzWkOYAP3OkGRCFJZyikOzEmh+hlA+RQ2Rj2fw
         LQX+8zxBo2EDtY5dVboK9ZiceeA6eVzVsth/WQcAvnvB3u8Kv+O1zswCNrCryoXeme25
         lTnw==
X-Gm-Message-State: AOAM530z2rHB8h/el3+FilboEPHENtFg0Dd+C4qwJZETocTGMYJgW9LW
        36ToXo0fZRg1wtWF7nxpgV5gZNjSguELkw==
X-Google-Smtp-Source: ABdhPJxrxZbdJiVk/7fRskTOGVS9Z+6f7vMSWYNB0cUWGANQr0fB262FnIPkWqEaqF0yTMpLQLCimg==
X-Received: by 2002:a17:90a:ab94:: with SMTP id n20mr3609966pjq.146.1629799224103;
        Tue, 24 Aug 2021 03:00:24 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id t12sm23054032pgo.56.2021.08.24.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:00:23 -0700 (PDT)
References: <m2lf4wys5o.fsf@gmail.com>
 <a834f42e-e92a-ed2c-66db-971ea25bf1bf@gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>,
        Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] The Final Git Dev Blog(s)
Date:   Tue, 24 Aug 2021 15:23:54 +0530
In-reply-to: <a834f42e-e92a-ed2c-66db-971ea25bf1bf@gmail.com>
Message-ID: <m2k0kbduxb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 20/08/21 8:05 pm, Atharva Raykar wrote:
>> Hello Git Developers,
>> This is my last week with Git under the Google Summer of Code banner.
>> This week's update will be different from usual, as I have split it into
>> two separate posts.
>> These are:
>> 1. The Technical Report: https://atharvaraykar.me/gitnotes/final-report
>>     This is a largely impersonal report that describes the current status
>>     of my work.
>>     Mentors: this is what I will be submitting to Google as my final work
>>     product.
>
> Thanks for the report! It's well written. Some comments:
>
>> Portability: Non-POSIX systems like Windows don=E2=80=99t play nice with=
 shell
>> script commands like grep, cd and printf, to name a few, and these
>> commands have to be reimplemented for the system. There are also
>> POSIX to Windows path conversion issues.
>
> I wonder if that's a valid claim. The shell script version of the
> commands use a lot of *nix utilities to achieve their goal. This comes
> as a hindrance to run the corresponding commands on other platforms such
> as Windows which don't have these utilities. That doesn't mean those
> platforms implement those utilities for their platforms. From what
> I know,They just use an emulation layer in which the *nix commands would
> be available. Using an emulation layer is costly and not an ideal solutio=
n.

Maybe I didn't phrase it well enough. Maybe doing a
s/reimplemented/emulated at a cost/ would fix it?

(Welp, unfortunately I cannot edit the GSoC project description which
has this same text. That blooper would be set in stone.)

>> Miscellaneous
>
> You could consider mentioning that the first two changes have been merged
> to the 'master' and possibly also link to the corresponding commits.

Okay.

>> Structuring Patches
>
> Structuring was indeed an overarching theme your work.
>  > This taught me how effective communication makes software scale=E2=80=
=94your
>> changes should tell a story that=E2=80=99s easy to follow, so that the c=
ode
>> can easily be picked up by others by a mere examination of its
>> commit and list history.
>
> Good point.
>
> Speaking about structuring, I must mentioned that the structuring approach
> has paid off very well till now. I'm inferring this from the fact that
> the reviewers haven't expressed any concerns about patches being too
> long-ish to review. Having taken a look at the patches that aren't on
> list yet, they seem to be structured well for ease of review too.
> So, good job!

Yes, the strategy has worked well so far. I would say my only major
error was holding onto some of the patches for too long, because I did
not still have the right idea for when to send the next series.

>> What I learned over the course of this project
>
> Good to see that you had some good learnings from the project. :-)
>
>> Do let me know if it is missing anything.
>
> I don't think you missed anything. There's one thing which might
> be worth including in the report, though. You could have a section
> called "Organization of the work" or something like that which
> gives some details about the branches that contain your work and
> clarify which ones are still relevant at this point. This could
> help future readers (including you!) to quickly get an idea of
> the branches and code in your fork.

This is a good idea. I will update that blog post soon. The blog's home
used to have that but I did a poor job of keeping that up to date.
