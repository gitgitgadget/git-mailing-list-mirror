Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B40C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F9E61945
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFYSRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFYSRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 14:17:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C6C061767
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:14:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a133so10042010oib.13
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uudTaYORW7S+rYhh23X8ifv+yY2JSfgevKQkAuh7sqM=;
        b=tkFgxlMdPh74uqycAP0QMAt0eASPc8PxKM/r3jzkN08opFEcBPgnnveFDizsO/ZOzr
         6x/SI4R7GBhahZPovT8TDnnkCmS4dKLRPtNvbDJJa2wS64ViJLBSueveTgAHFIsX5Ygm
         VYchIMo1L4P9dkZED98+Kvblv9+COY/ZUkeVRa2XzsGvzy556ir2ZxW4UI9mQv6Irqis
         oqVzWx1MnPDHMvdaTiS1C1h6DDhAfbrDcQNBM9KBj7p/LvW+wmajx+nmX3P84SGZ9ZFO
         8ggDbokcay0fsw5J9eMeu31MZKr341hJ07A8DLaQwqZCxAG/QWaOwJ7u9eKwRDAZjW2v
         Z5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uudTaYORW7S+rYhh23X8ifv+yY2JSfgevKQkAuh7sqM=;
        b=ENjpwZCkyMNhP2nsbMXGX4rWPovVjvN8OVSRSuslZ81PP13fiiWauJ2rYNeZiJekUb
         mtPr7mkp/URZZVBjSyQsDSIW6LIRy89uJkE9+WXs842paxNwCpyoRuDGO+DSsyY00+eT
         bz+9Rnd8HE9WU9x4E48CYvn8byV3zQBelkm6jv3FXuz9TCv0alw6JkJkoI+Zi8AS0DqH
         ORbK19RBsgwVOGwscOmMKna1v0OWItqYBqA797HZeJByuVfLrf89mv2bwMpWwUbz6U6i
         cBxeVEqbrxYNvNOCvUrfGb1q6v+qFLcmbegvqomIzu3Cf2izE3+NhN3mjQgSMtJtIncW
         J8hA==
X-Gm-Message-State: AOAM532jWsOKUbNphgZvMhx9JX+KNSsfCJ6xjMFVkBUOwcwS2tpqintv
        eOphq3TG3/1NvF8VaTep5uw=
X-Google-Smtp-Source: ABdhPJyNPbyfegO8GzwUIzGApPBFrXaoXRASqmug3cObzErowMBa7CAUK9YAV3f8rdEsFqBiQJ2/1A==
X-Received: by 2002:aca:d58f:: with SMTP id m137mr7023628oig.34.1624644896176;
        Fri, 25 Jun 2021 11:14:56 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l28sm1508211otd.66.2021.06.25.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:14:55 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:14:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Message-ID: <60d61d1e44307_cc8d20878@natae.notmuch>
In-Reply-To: <87y2bs7gyc.fsf@evledraar.gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
 <87y2bs7gyc.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I'm a bit surprised at what seems to be some hostility or annoyance tha=
t
> I submitted this as a set of patches. That's ultimately something that
> saves everyone involved time (well, except me by coming up with said
> patches). To borrow some words:
> =

>     "Talk is cheap. Show me the code." =E2=80=95 Linus Torvalds.

Words I live by.

> If I give you feedback suggesting that maybe we should reorganize this
> thing to split out refactorings from behavior changes I'm asking you to=

> do extra work. Ultimately neither I, you nor anyone else can really kno=
w
> if such a proposed effort is going to be better until it happens.

Indeed. That's why a lot of time instead of simply replying to a mail
with an idea, I actually attempt to code the idea, and only then send te
reply.

I would say 90% of the time what I originally thought changes once I
actually try to implement it.

> It's can be really hard to see how/where to split things when you're th=
e
> author of the code. It's really hard in the "theory of mind" sense of
> things to explain an idea to someone who doesn't have the information
> you have.

More like impossible.

No comic simply writes an act and goes to an auditorium like Carnegie
Hall to simply present it knowing full well how people are going to
react to it.

You never really know how other people are going to react, so it's
better to not make assumptions, just try and find out.

> I think I've made a good argument above for why this takes you a step
> forward, not backwards, I'm hoping despite this initial reply that
> you'll come to agree on that.

Not to mention that the goal is not to land Emily's patches, the goal is
to improve the code while minimizing the potential breakage. For that we
need as many eyes as possible, and in my opinion your reorganization
patches totally help in that regard.

The fact that this makes it easier to land Emily's patches is an added
benefit.

> In any case, writing code is hard, but splitting it up like I've done
> here is rather easily done. It took me about a day with waiting for
> "rebase -i --exec=3D'make test'" equivalent, and that's from being most=
ly
> unfamiliar with the code in question beforehand.

It's easy if you are an expert at rebasing, which not many people are.

But you can't become an expert if you don't do it, over and over. So
it's usually better to not think too much about it and simply do it.

Cheers.

-- =

Felipe Contreras=
