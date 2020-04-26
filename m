Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CAC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8305D2071C
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 13:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVPB8+su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDZNa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 09:30:26 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF9C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 06:30:26 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c24so14473309uap.13
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XjmiUQlnDxZ5Mvc9GLzW0QgO3hBLQB/9i/va1z8LXM=;
        b=ZVPB8+suArJzZzMluw0Jfp1zZmVMo3fIb1ilq+S18lDHq5UtKNbHerYRS4fVsAlZa6
         b90lZTtUOx/vMrdO9+/kghAUfv7pRJXmWhxYqjMoJ9FNk822BS00kuqh652EYxZXo9OJ
         k9i3/gnYbn5RibRn/PTxFOIQGlh2asSwZHhXBkQhZy4V4Htu+yNFyPLQWeT7csK1eFGO
         P+/Se6jF2Z6LVq8jLuCsmXBmx+6lQ3V0InIVVhWJQpCnu4j89AnS3niKxvJgSJeMNpjT
         NVvjC+vaGJ7UuLlDp2qL5IdOxqxDkgzdfVDywYEKtGzNFXrNPz5qN+qy1LHFWWkEqr2E
         3WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XjmiUQlnDxZ5Mvc9GLzW0QgO3hBLQB/9i/va1z8LXM=;
        b=GxdVVzdIOxoJCMHXj8bClU77wRg3NvcTti1w48r3efblAKlsnHjby9AZp5Sn6cPSVl
         pvMs58pVPoyLY6QHPxHhmgejc9E39CvB1aMdwTo2P6qDoqT9IiS8L8bNNb12+ZZLU6ni
         rNDWeMbMKsW9Q9Zw3ZkPW5YoHsHaBk5WF1OWT9d1UHEBR9GLEvmTr0X6X3erQ8zufMFX
         JKUZD0Z21pEhTGYah6HPioo/Asrl9toM63br8YlI59mh+h+eKsZbZKBqWLB51sEjoYDF
         M2SOr21LEFGAmPoV/QOvJoGTumdiqXQnnz+9qewyMwnsq+KA6wxV+3JMSR8++9yM0d25
         3Kjg==
X-Gm-Message-State: AGi0Pua8ZC1xDR5jqaN+/nIox4+hqmS7Bn4kmAN5FKzv/RAr7dWT0rkC
        /W1fk/H62bL14mVtFk1FPbjZpENe/XPGcGPYXk/0/fMl
X-Google-Smtp-Source: APiQypLBH6UABt+X9qMG/rRCm8kP8ieoLT3c2aj1mJvE6fyRjkvc2sfz7PuKjlVH2+Srf+FuSz2JWoJMzbXkL1PPBX0=
X-Received: by 2002:a67:6dc7:: with SMTP id i190mr11847435vsc.75.1587907825667;
 Sun, 26 Apr 2020 06:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200425235716.1822560-1-maxmati4@gmail.com> <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
 <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
In-Reply-To: <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sun, 26 Apr 2020 09:30:13 -0400
Message-ID: <CAOjrSZt7WJy1vv97Rw9MFJyTcB2Ehqq9BjGrXMtV95oB5p53SA@mail.gmail.com>
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?UTF-8?Q?Mateusz_Nowoty=C5=84ski?= <maxmati4@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, bwilliams.eng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Given the extra config environment settings, could/should the
> --show-scope (or complementary option) also show/clarify these
> environment variable settings?

I'm lukewarm either way on this one, I think it would be pretty trivial
to write something that did this, so that only leaves the question of
'should' we do this, which I don't really have any particularly strong
feelings about.  What would this even ultimately look like? perhaps
something like this for a command of `git config --show-scope`:

system var=option (currently ignored due to GIT_CONFIG_NOSYSTEM)

Which kind of begs the question of how many people set that variable
and then forget that they set it?  Although I can totally see why it would
be nice to have some kind of config flag that's a big
"Just show me everything that's going on option" which considering these
variables would probably be a little bit more than the current next-best of
`git config --list --show-scope --show-origin`.  Again though, I'm not
exactly sure how useful such an option would be.

-- 
Matthew Rogers
