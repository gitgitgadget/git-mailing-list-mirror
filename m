Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB8C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjECXms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjECXmq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:42:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084A8A6C
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:42:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso3024138a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683157362; x=1685749362;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vak3OrfhZBZDVPZOoTYpyxf7upf6w+DJ1DUoK2I4VJU=;
        b=FMsIT0DH8bckjZYeHPVuqdWLTLYka5v2yGGJ3Q2R525VufGlujKWAoDLl4F3S4IjiB
         d/qifh0mBfxEgQ7Facnr23hRiLd15szOp+F5eOwjakLMvN0P5Pqte/pOnSGT9J84vKhd
         zbZ6kdbFZlJU6XO+kcLKzjbVrMzv4AF7ad9wSvSsm/DF40r4nKq/YOK/q/TcrwyWsaK8
         NxUTBFHJees+Sfo7xGkyjKyxxTuALSp/vVHiodVz/Ljeb2v4c4toEeGOk4NwwyrJvmbD
         FjE/iQ/cqOZbkWKXlNXyg2B8LgF4iY5aIrK3fwxDbNupAOrtK4imETilUpw1M3DZ3fTV
         ETmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157362; x=1685749362;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vak3OrfhZBZDVPZOoTYpyxf7upf6w+DJ1DUoK2I4VJU=;
        b=h7TYaJCZbrBMgE1KwX+k+o182A3PNqEP+Twj/RO7wpXifm6Snn7YFIwDKpfsZRiaeo
         yaFKXKs9514B23IqaN4rfp5WDjkGnj8BcIzBVrtmJ2ntdR1nf2gBmQYa2ZeM0MYhuTZR
         4u/u+O7TPRvBzAqCktMUjCqV0yB0PgBk1YrczCa12YIn0yiskkXu01Ic48n/nIfsc0qN
         j/gsGASQv0fY3a1tl70ytIUxn2Y+s6Yf+j7jgk2QGj78IZ0t0PgD0nvwf+wcjaujicU+
         0kTCPv6LK0OCftyGxnCrErVj+RAdGGABbq60Q7313ZDORED76IC7Wcp9BtWFMThYPU9R
         zk0Q==
X-Gm-Message-State: AC+VfDz+Ggd7WLrQMwDqCnlg1bkFBoWmB5DL0a3JTE1hyJvgUT3kicGK
        MiLghzNi8pA7UV523Ye6CNI=
X-Google-Smtp-Source: ACHHUZ6LLyzp0UX+0YDgwcpFkBeXFFg0XGEWRS59R9NXS8+CFULcQfHLaU4DJG2TWets+BspDgQzuQ==
X-Received: by 2002:a17:90a:9dc9:b0:24d:fcc0:1949 with SMTP id x9-20020a17090a9dc900b0024dfcc01949mr395938pjv.12.1683157362321;
        Wed, 03 May 2023 16:42:42 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n35-20020a635c63000000b00517be28bcf9sm20615583pgm.86.2023.05.03.16.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:42:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce `pack.extraCruftTips`
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
        <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
        <xmqqv8h9m2az.fsf@gitster.g>
Date:   Wed, 03 May 2023 16:42:41 -0700
In-Reply-To: <xmqqv8h9m2az.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 16:18:44 -0700")
Message-ID: <xmqqjzxpm172.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +Multiple hooks are supported, but all must exit successfully, else no
>> +cruft pack will be generated.
>> +
>
> Now, we are told this variable refers to "hooks".  If that is the
> name we want to call them, we'd better use the term from the
> beginning.

I was updating the "What's cooking" draft and here is my tentative
summary of the topic.

    * tb/pack-extra-cruft-tips (2023-05-03) 1 commit
     - builtin/pack-objects.c: introduce `pack.extraCruftTips`

     "git pack-objects" learned to invoke a new hook program that
     enumerates extra objects to be used as anchoring points to keep
     otherwise unreachable objects in cruft packs.

     source: <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>

I think I earlier saw review comments on a side thread that
mentioned "repack -A"; when I read it I didn't quite get the point
of the discussion, but after summarizing the gist of the topic as
above, I _think_ I tend to agree.  This should not be about "should
we have these extra objects in cruft pack?" but is about "should we
keep these extra objects alive and exempt from pruning".  What these
extra tips tell us is that the part of the reachability graph rooted
at these extra objects should be treated as if they are reachable.

Storing them inside cruft packs may be a reasonable choice to make
today, in the sense that among various object storage mechansim, the
cruft pack mechanism may be the best fit in today's system, but it
does not have to stay that way.  Naming the variable to specify the
hooks with name "cruft" in them would make it hard to explain once
we find an even better storage mechanism to store such a "not really
used but want to keep" objects.
