Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B4C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312596127A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhDZOxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhDZOxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:53:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88AC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:53:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n21so8673910eji.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=t6xw/E9Oaojz9Sf9oQS6h6+rvCziUCK6z+9ou6KOlSI=;
        b=WqR1mYcQpetU7PFEzOFzp0T/ZgfFaeXWQKJyHpFHIsnUNwXbkfkf/evqJE6VZ4qAob
         y0IFKhgeGf2AjlQf8DLkgWHwdYrtXI9VqlXcN7HxEsy/fJ42hJicC3l6EFbor96IO5kD
         jGortloCmNCJZJL6FPWvfy4apjjmlRVV4a4IbTR34HgAychLbhJqS1xOQL6zWWhA4Abg
         c0awSafgpdcRzjiPjMEzRen+uhzVVZ/hL9qBj8qXPZCTDe5KEJyLCV+K+QqcPDaeOxPP
         4JyhUkMlH0QPNhV6yWHDdK1QfYaTvCP7PCLcNSNZP+A7TRu220rDXsahvGS71H+HaVQa
         IORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=t6xw/E9Oaojz9Sf9oQS6h6+rvCziUCK6z+9ou6KOlSI=;
        b=Nm5REI1fCB7AFGB0wj1kzZpz87VS8OOubmNxrPIw5v6pqVgdVIrFvmFaZmj1rThFRP
         H8iqLz+0qF7NZ7ge/Z+M2Dj71M3nwpisSFSIp58T2R8zVwXvkMMPFgUb/vOgnPMLHrIE
         C/09oFspo2fcWXP8hsFzo0tka2Tbe0U4GNtoTr/iOGTXwVkJq4zvftXMAqxLk4YX2LzL
         uEVY59BQbPTbzeRTibEuEcCr7JtbDuewprAqFT0aeSg/xDphGPdjYEg5KEXFFRzDYlV6
         y3ks01sVADrzT611rO30kJ7h+1GEdTiBDPPxwCY71w6mmYWmLAoCViEKFlwfCPN868kE
         Aj2g==
X-Gm-Message-State: AOAM531YifX82hthcVONb7dVYzHfLLM5Bu0hLVAig2q084qZJusqdeg9
        q0WFbqGjO8GaBU6LTNDdfa8=
X-Google-Smtp-Source: ABdhPJyvr2tNXkmov/Bwgh94psPxcaD8pA3XmkyEhTzbZ4Y9Y/dFWg10OI9iD7DAKGLXHh58oU+caw==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr18444647ejb.42.1619448784326;
        Mon, 26 Apr 2021 07:53:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p4sm434022ejr.81.2021.04.26.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:53:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Date:   Mon, 26 Apr 2021 16:36:19 +0200
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
Message-ID: <87fszd3xo0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 26 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-04-14 at 06:13:26, Jonathan Nieder wrote:
>> [...]
>>  4. What other tools would you like to see that could help?
>
> I think we definitely need a bug tracker.  We extremely frequently lose
> bugs and feature requests on the list and people aren't very likely to
> search the list.  If we could use the same one as someone else, such as
> the kernel, that would be ideal, because it means people are more likely
> to already have an account and therefore the friction to report a bug is
> lower.  Alternatively, we could use something like debbugs which is
> controllable entirely by email and therefore requires no accounts (but
> does require someone to occasionally prune reported spam).
>
> I know full well why we don't use a forge-based model and I'm not
> recommending that, but I do want to point out that forges solve all of
> my pain points, and I do have a much quicker turnaround time on patches
> when I'm using a forge.  So ideally we'd have some standard or
> recommended tooling, whether built by us or by others (e.g., an open
> source project for patch workflows), that addresses these pain points so
> that everyone doesn't have to build their own and turnaround time can be
> improved.
>
> I have seen replies downthread that some developers really are reticent
> to use more common tooling, like web interfaces.  While I do want to
> keep our project as accessible as possible to as many people as
> possible, I worry that by catering to folks who don't want to adopt this
> tooling, we are drastically reducing the number of possible contributors
> of all sorts (code authors, documentation writers, bug reporters) by
> not doing so and worsening our own experience in many ways.  I do think
> we should adopt modern tooling (e.g., web interfaces) provided that it
> is usable for people with accessibility needs, even if that makes some
> people unhappy.

I'm not disagreeing, just replying to point out that I think for your
suggestion & others having as much of a split as possible between "what"
and "how" would, I think, be useful in moving things along.

A web interface is a "how", but it's also implicitly a "what" in the way
that most people think about it in this context.

I.e. it's not like we couldn't have a bug tracker now using the ML,
you'd send a patch, Junio would pick up the report and we'd drop it into
bug/some-description.md (with some handwaiving for formatting, merge
conflicts etc.). We'd remember bug reports, feature requests
etc. forever, and patches could atomically change/close/remove those as
they fix/change/implement them.

The point I'm getting at is that the "what" we're also implicitly
discussing is the developer community shouldering the burden of keeping
such a tracker and the information within it up-to-date.

A web-based interface that worked like our mailing list does now would
be one that, say, deleted your bug 30 days of inactivity (or otherwise
made it as "archived" as something in the ML lore).

I couldn't find a reference to it now, but as I recall (and maybe I
wrote some) there's been some prominent defenses of this model of
development in the past.

I.e. it puts the onus on reporters to make sure their issue is being
addressed, if nobody cares to pick it up it probably wasn't that
important, and we shouldn't so lightly assume the fixed cost of adding
that one-off report to an ever-growing list of reports we'd need to
continually look at / curate / keep up to date etc.

But none of that's an argument I'm looking to get into right now, or
really have much of a firm stance on. I just wanted to point out that
it's a clear case where a "what" is being conflated with a "how".

I.e. we're implicitly not only talking about how something gets done,
but a big change in what gets done.

I had a similar comment upthread (or in a side-thread) about how much of
the suggestions of making use of the various reviewer/approver
PR/MR/whatever tools in the wild seem to simply assume a move away from
the long-time model where there's effectively only one approver/merge
master/committer (i.e. Junio). That's an entirely defensible argument,
but another case of making a "how" and "what" argument at the same time.

Maybe the people proposing both a "how" and a "what" will have an easier
time if those are untangled, and we change one thing at a time.
