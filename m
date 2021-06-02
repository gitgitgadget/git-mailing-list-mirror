Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA19C47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B900761360
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFBFcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFBFce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 01:32:34 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606EC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 22:30:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u11so1638328oiv.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=l7t5g03d9Rnxu5uvmI8FFLVer2nlOnzqOn8qbPFmrAE=;
        b=UvPWn2vYnM8QU9M7Nf0owkaZ7sOdvUSSKRUV2+bC9dsRgrvcEdmfslZIBgblGDjAkj
         yCzUdxavx+HYKu8AlQeQpR6bsdqfZpdjzwyD584j1DQxX6rM6NOy+zR/nfXr1f1N49ML
         0yTZhbPbHkKI6aSAWEWMzFPBSENvUFbVklHMMIKVfTj3QKyJZ72P6gtS2k1cGcDbYrJe
         8xZLRw+xVqqfZJI35+0Ob6CDktCnx5Xp23PQ9EUEnZb3eZmuy4XiHyYQ5/EB3lMhql0g
         8LGyKuF3zuXP4yvQMzw5t4BuovZ6qVXGrYnr7ZnFVrAjtv+HGLJFbuUxkAXRHhdefnbM
         fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=l7t5g03d9Rnxu5uvmI8FFLVer2nlOnzqOn8qbPFmrAE=;
        b=P6XvB/jVpvCoiEbx/RKBlhdK1NWpu8vzQMzF4gkicVE9GcW67nLwAG0mbmZmUkTezi
         /zF3dE4cI1+pIkZScG4C9zGGNR3VTkee5gOo/sKizdkOI0+Agplc0nC4hHFqMwPKFVOr
         LhE23asccpQbiV7b2bbKvaMJQyNkyUB/DqyQ+pX/2ztc4g35e0BEUiP+zlEnHiEpceVI
         KQb2Czij2IPgKFAATmBYUB1uQbNXgirGgersWS/hQWFQ3eLu8jUwnVwABCXEQpyvjb0N
         Wmu+oMRKr86u93oNRGQcsL+iODTNdYjDkHJfYhQJiREQxUrYh/sXvetZOX3cElonAe1J
         df/Q==
X-Gm-Message-State: AOAM530gFxGqfI0498ydcAGrC16nK+PpXsck+l0LSXO9RMUS2WAebBy8
        8rMnSOpydR8yrt+or6+3Jfc=
X-Google-Smtp-Source: ABdhPJxNIrRB0NYjsdIgflZDgczj6ZW+KHuNJEr2wooPnOXWDWfOZ9Dtz0nGF3Y9XhMHFWREWQEFGw==
X-Received: by 2002:aca:2417:: with SMTP id n23mr2430514oic.111.1622611850736;
        Tue, 01 Jun 2021 22:30:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v19sm4334045otk.22.2021.06.01.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 22:30:50 -0700 (PDT)
Date:   Wed, 02 Jun 2021 00:30:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Message-ID: <60b71788c0e6d_67d0208d4@natae.notmuch>
In-Reply-To: <YLZ5H2Muh39Q4M5T@google.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Fri, May 28, 2021 at 02:11:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > =

> > After suggesting[1] an another round that the config-based-hook
> > topic[2] should take a more incremental approach to reach its end goa=
l
> > I thought I'd try hacking that up.
> > =

> > So this is a proposed restart of that topic which if the consensus
> > favors it should replace it, and the config-based hooks topic should
> > be rebased on top of this.
> =

> I'm not entirely sure what you're trying to achieve by sending this
> series.

Have a better review? By having a more reviwable series?

> It was my impression that the existing config-based-hooks topic
> was close to being ready to submit anyway (since Junio mentioned
> submitting it a couple revisions ago); rather than churning by reviewin=
g
> a different 31-patch topic, and then re-rolling and re-reviewing a
> (reduced) config hook topic, wouldn't it be easier on everyone's time t=
o
> do a final incremental review on the existing topic and then start in o=
n
> bugfixes/feature patches afterwards?

Not to me. I tried to review your series and I just couldn't.

Maybe it's something about me, but the whole point of a review is to
have as many eyes as possible on the code in order to spot any potential
issues. If some eyes have trouble parsing the patches, that's not
optimal.

=C3=86var's approach is easy for me to follow.

> It would have been nice to see a more clear discussion of patch
> organization sometime much sooner in the past year and a half since the=

> project was proposed[3], like maybe in the few iterations of the design=

> doc which included a rollout plan in July of last year[4].

Not all of us are being paid by a big corporation to work on Git.

Some of us are doing the work on our own free time. You can't demand we
spend our own free time on a certain patch series as soon as possible
because it's more convenient for $corporation.

Git is an open source community project.

> To me, it seems late to be overhauling the direction like this,
> especially after I asked for opinions and approval on the direction
> before I started work in earnest.

To me it's completely the opposite; it's never too late to overwhaul a
patch series.

In my opinion you should be thankful that somebody took the time to try
to improve your series *for free*.

Cheers.

-- =

Felipe Contreras=
