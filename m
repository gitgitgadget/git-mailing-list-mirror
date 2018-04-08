Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159281F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeDHXEQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:04:16 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55988 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbeDHXEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:04:15 -0400
Received: by mail-wm0-f54.google.com with SMTP id b127so14523925wmf.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KSo6O6Xwf4R/4Rmfg/xRnIIY+ITk9FAzxCr60izlw84=;
        b=V7gnoJQ02Vq49/++KPvnFXl1X3A8rUxPJeXsXCG550xGThm0JSzZHPMsTVA4txbG0T
         2RVRo9wslUdrk572yHiDqGNODglIaeMYFUPZlETga4VxzbbsxMwfzuVAecB2svEUvdJq
         pmGFvx+Lawru8h+7uE3d50i6T5GEqIgVIxLK/BYuJePkHiXbUznKDhIgZsrWfWpXvf+/
         9aLp20Jg/KZTu1jQnq9y+sGpABWkYFOnkATCbti7gI5rLFWuoJA0JY4GkoioQJ9gjd5H
         EFVqWZ6DEWJQLsKiSLstynRFA6h+d8iW4lzvvweBhB3ugaKOnbmUdbcMh+kkDBAkoDwe
         UBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KSo6O6Xwf4R/4Rmfg/xRnIIY+ITk9FAzxCr60izlw84=;
        b=ZUxZolTC9KwDxlPytS3H/h0SvTyjKaL7XmZ4iuhz0RokeQGem7Vgv0L3ws5/FrgCFi
         qMReacNIQmgTuic2nRMvZFz8j7emCfu6F31CgTSzt/kRje+1hhJcYTLZcuE+LZRmXfta
         ugjtsCySeUpSXHv8qvgAFIje+njqsBpsO58ifV/SnMaBi878th//Fi1b/fcUh5s2EQLi
         OqmB/Dt1hVRp3mwz2EnvXztjvftKNel0/gAAZfjZjsne3i0N0fXY7oXJrlJy9TwNKCSF
         6NucDfLJGbmYDh1yV6LTeYASX5Kn5Vzp+WoHKzdNJTLXWBnCrvgPN+O6qjtA6UGi0tgr
         1WAA==
X-Gm-Message-State: AElRT7FOEEHtVpGJmHCuZMcRwV1pHRdig3oMdtxqhtSqARyJTFN8EeIZ
        Ga9ZBOkX4HB0M4Pyx+nno6bEPepN
X-Google-Smtp-Source: AIpwx48C0Q45r1jXacAFoEWiw0QPp+lZvO1Lp9z/5h4L2UhNCRN9RduDIeuVY8beeduQCYf7Om+Qyw==
X-Received: by 10.28.167.204 with SMTP id q195mr17953052wme.48.1523228653976;
        Sun, 08 Apr 2018 16:04:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 31sm11645097wrm.68.2018.04.08.16.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:04:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: After a rebase, ORIG_HEAD points to the previous tip of the branch?
References: <CAFU8umhSAufzbPBDMVt4ekcWjPa4Yymh+NeW=BYa8ARuRuZcbw@mail.gmail.com>
Date:   Mon, 09 Apr 2018 08:04:12 +0900
In-Reply-To: <CAFU8umhSAufzbPBDMVt4ekcWjPa4Yymh+NeW=BYa8ARuRuZcbw@mail.gmail.com>
        (Ilya Kantor's message of "Mon, 9 Apr 2018 00:10:16 +0300")
Message-ID: <xmqqy3hx8fmb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> Immediately after a finished rebase, is it true that ORIG_HEAD points
> to the previous tip of the branch?
>
> So that `git reset --hard ORIG_HEAD` will cancel the rebase?

I wouldn't recommend people to depend on it; rather use "@{1}",
perhaps?

Before reflog was invented, ORIG_HEAD was primarily a handy way to
back out of "reset", but because the implementation of higher-level
porcelains like "rebase" may internally use things like "reset"
without giving it much thought about clobber ingORIG_HEAD (largely
because there is an expectation that modern end users would be using
reflog more than old-way ORIG_HEAD), cases like stopping in conflict
and getting told to skip and continue may not preserve ORIG_HEAD as
you wish it to.
