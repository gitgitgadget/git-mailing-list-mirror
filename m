Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2FC433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B817361108
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhILOjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILOjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 10:39:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F13C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 07:37:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b10so8357835ejg.11
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ffN2BiTmzOBh/s74N4CyORj3Fkhqip40W5swlbskHZA=;
        b=NJQZnZcXkGQDO8NRzmGEVcmKn7PIndyS6hwUh4lHaYxtkymHoyyowAro1MgkVix3+2
         jPxgRBgLkSaL6ORXRJtJVAxIoo9HQZM4ijib8yzaE19Foo3lZY5rwvsPFq4PTvzIkHny
         uuseK+p5kUC73cacIfAut1NsLVEUxJDumMhYYdQo2o8YFGCL8kOHjf2FraOy2optjV69
         R1bhyL6i2Wb2eQDCM3lFc4PHlEV2tjljVrazPCesmyjYBkE/7qbbmH16BpSgDdQ+Gn+S
         wp5Jqz1bz8JxPH8FKG5prNC2E1YLNCvmD8B09FoQ+zqFAYC3s8njMDXQ44iyHd6WWU7l
         Dx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ffN2BiTmzOBh/s74N4CyORj3Fkhqip40W5swlbskHZA=;
        b=eQXVUA7uFkemKGBvMBkrAhIE0MjD+s3cwNakvDgZXM5LXqpCgdyOccp7LWC3GgXtWa
         fuGic3EJJFuJTmUQXJL317laEQxLyi27ouz4er6ey+spLwnlPXrKlLd8O+TT4S4r2C9k
         h3dFrddQ7V1dacjFVDP7ba9Z+lDDbRH3fVCiOmJG+hpiB5+/zVZfviTquSACh9DDAXwt
         CeelOWfdJLdkPBRL90io4uhJtyKPH4eR5l5Chb9Rr3yeoZfec/eW7XMmuoVwABuLlxVa
         cFPKMhBCGNW+5lGVYpWtG7A7KzZPi4BL+KhDfA8jsoTT9klXRUVs9lh7zL1BOBz5whQm
         XhQA==
X-Gm-Message-State: AOAM531ux6yjxRmyAaP377UwGzieg9fNDvhUpFEiQoK5v3yJWKKBcLAP
        lfHq9NQTSycEktpYewECDdA0JWQs9fz+xQ==
X-Google-Smtp-Source: ABdhPJxl+kVAoQO9WW2fWSv9cipHTBlwPPucdq4oE0Tm0hg0aDOWdsszsRYwNN4jW665QMfhttA8zw==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr2894890ejc.20.1631457464648;
        Sun, 12 Sep 2021 07:37:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i11sm2440760edu.32.2021.09.12.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 07:37:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Question about timezones in commit & tag dates
Date:   Sun, 12 Sep 2021 16:21:18 +0200
References: <b39aab0a-bf53-9e33-59a7-d4f1a06e72a7@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b39aab0a-bf53-9e33-59a7-d4f1a06e72a7@gigacodes.de>
Message-ID: <87fsu997wn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 12 2021, Fabian Stelzer wrote:

> Hi,
> while working on correct key rollover and verifying signatures for past
> commits for the ssh signing topic i am trying to understand how Git
> deals with timestamps for commits & tags.
> For ssh signing the user will manage expiration times within their
> allowedSigners file. Those timestamps do not carry a timezone and i
> would assume a user (or automatic generation of this file) will assume
> the systems timezone for them.
> Therefore i wanted to pass the commit & tags timestamps adjusted to the
> system timezone to make sure key rollover will have no gaps or failed
> verification's especially when commit and system timezone differ greatly
> and might roll over to another day.
>
> However the commit & tags structs only seem to carry the objects
> timestamp as is, simply ignoring any timezone information. For the ssh
> feature i can easily enough parse the ident line again from the object
> header. But while looking at the usage of the existing date fields i can
> see that objects are sometimes sorted on and compared by these dates.
> When commands provide cut off times (--since) i think they might include
> or exclude commits erroneously when they were made in a different
> timezone around the cutoff date. ("log --since" indeed gives me some
> unexpected results when mixing multiple timezones. Based on some simple
> testing i think it just stops output when a commit falls outside of this
> window, even though there might be one before it wich is within)
>
> Is my understanding of this correct and this the expected behaviour?
> I think generally for git this does not matter much. But in certain
> situations this is problematic.
>
> I would have assumed that git would either add the timezone as well or
> adjust the commit timestamp upon populating the date field in the commit
> struct to UTC but i could not find anything like it.

Timezones are ultimately display information that's confusing to humans,
but not machines. Machines just need to deal with epochs, or when a
human supplies them a date convert a formatted date + timezone pair to
an epoch.

So in the key expiry case, I'd expect that any such system would say
issue keys right now, now as in time(NULL), and we'd set those keys to
expire after some time, say 1 day, so time(NULL) + 60 * 60 * 24;

If you're in UTC that might yield a very satisfying (to humans, a
machine won't care) expiry time. I.e. you'll get keys issued say at
midnight, and expiring midnight the following day.

What you're saying sounds to me like you're conflating the two
things. So as an example, any bugs in the --since logic aside, surely
the sane workings of such a feature is to take a formatted date +
timezone pair in the user's *local* timezone, convert it to an epoch,
and then filter on that.

That's going to give output that's confusing to some humans, but is
correct. E.g. if I want all commits since 00:00 on Monday I might be
surprised to see commits from Sunday afternoon, that's going to be
because we took my idea of 00:00 on Monday, converted it to an epoch,
and then used that as a filter.

Anyway, maybe I've misunderstood you. I just don't see how something
like key expiry would need to concern itself with anything but
epochs. If you conflate timezones with that and say "here's a key, it
expires at mindight" surely you'll have some keys last mere seconds,
others 10 hours etc.
