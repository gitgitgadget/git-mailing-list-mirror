Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiDKKar (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbiDKKam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 06:30:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59174434AC
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:28:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so17733695edu.10
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sjBCu0KgYAtgThuQqYF4l2WtZlXqAtEWMDFk+exEq+A=;
        b=ms5s1dGsx6t4fW24zBc/0xJLCgvDmY1BuhbQptJr2FSW3T3n0oqhKkZmFTAJ///KUu
         tfO4leNE0A23Qua5IsYn8kDWlUX/jIZvDkfqFr2ZsPGtvs/ebxh1g3Hn2LdU+jhECxvj
         sT1E0MI0K0X/WJCuQQ525LsiMDKrdZn3c6KporCJJqC53hlX1gN2C2nqQphsJQEG7nk1
         RgAd9Pacd0uTvTZLV33tJHGXKxBqhIMbwhcxwdxTFB9RoZMUVhyoeXNW5jaAuJq6ojvl
         JQJihdp5YJJHlQ2pxuZQBXIeYY5xjYxWfP93RoDFyHjWPqODCV0z1MMHcyvx5kxBe413
         8kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sjBCu0KgYAtgThuQqYF4l2WtZlXqAtEWMDFk+exEq+A=;
        b=VhDffpOgH1iiYiPsM/LOYalOd9FC9zLnUjXIHSRIVq31p5oahJjxKpk+8qdlRJZMv1
         Dom217FtlLwCyJFUSalsKD4AcAY+3Dh5Q1czxNW1SNJsenFTPwkXDqqW0QYGCIOlzYhO
         JAabCKt03fvV85KSfNsClk8LQlkEi1/9DEQ9R9n0jt1BRitWSI+H2pB5LeCOVJW1KEzb
         nVAEC1pGmQUWJlvAUW6NYq2t74Qel9uY4OmNPVglbT3EsPP9CU52F7Wa03/it+5tj4VE
         0j9PhphiRcN6dIH1nkQm+XxaJ5xnA9GEKZCYTHIyMrgszGtfuEW+5C0u34dotXI6ClBQ
         MiOg==
X-Gm-Message-State: AOAM5323QX0+x+ytNn4/8/wnl/lPrhrNkEwd/NT1ZM6vIIz/P7Jw3uzf
        7DfUS4N8W2UZYDVdz00+ttM=
X-Google-Smtp-Source: ABdhPJzAcHPXizc/1z3IlnN55BDljg9cOCNhdhXA9Oi8Ur9FHirizBeYqaUUGGCKdEjq9Vmlo1uLMQ==
X-Received: by 2002:a50:ef03:0:b0:41d:7084:13e8 with SMTP id m3-20020a50ef03000000b0041d708413e8mr9624224eds.54.1649672889782;
        Mon, 11 Apr 2022 03:28:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm9176279eje.15.2022.04.11.03.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:28:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ndrHE-000P9B-MH;
        Mon, 11 Apr 2022 12:28:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Christian Couder <christian.couder@gmail.com>,
        jurgen_gjoncari@icloud.com, git <git@vger.kernel.org>
Subject: Re: Make commit messages optional
Date:   Mon, 11 Apr 2022 12:24:41 +0200
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
 <220408.86r167bxra.gmgdl@evledraar.gmail.com>
 <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+JQ7M-uSatD4=HHxaqe4yVAJ5WGuWC_BprX4hnfKSrt6-1GEg@mail.gmail.com>
Message-ID: <220411.865ynfkj7r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Erik Cervin Edin wrote:

> At the risk of bikeshedding.
>
> The case in favor of not allowing empty commit messages by default is
> that most of the time, empty commit messages are useless.
>
> I've written my fair share of poor commit messages (-,..., wip, foo).
> Sometimes I've fixed that retroactively, sometimes not. The advantage
> I see with empty commit messages is that it's more ubiquitous to
> "write something better" or "whatever". The downside is I can't git
> log --grep '^$' to find them.

You can:

    git log --invert-grep --grep '.'

> On Fri, Apr 8, 2022 at 7:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> E.g. I wouldn't mind if we made pushes start failing (probably guarded
>> by appropriate isatty() checks) if the user was pushing content without
>> commit messages, unless some option were overridden, or we could start
>> sternly warning about that. Ditto for merging a branch into another one
>> (especially if we can see it's the default branch).
>
> I could see this being a potentially nice option but also pretty much
> .git/hooks/pre-push.sample but with rev-list --grep '^$'  (which
> doesn't appear to work)

The reason it doesn't work is that our --grep doesn't allow for matching
across the whole message, we should fix that, it would be useful in
other contexts.

But for this the --invert-grep above will do what you want. I.e. if our
--grep matches any one character and we discard any that matched with
--invert-grep we're left with empty commit messages.
