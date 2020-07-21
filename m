Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC58C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07FB2065D
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH4ocbd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgGURR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgGURR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 13:17:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB967C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:17:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x9so24893080ljc.5
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hERfJoYfQXcP3Fg4ZWHacBR7u3QzGp1x+e+8qp2E5Zc=;
        b=RH4ocbd/3YlGskrn1WJZ5EvR3BjMbNEi0BziIo8rlIanUD/dbC4HfNtmu+z5XABwjM
         7LFNLfflFXLcWTyQFLXLdFu0Efbsix3cQdzpRJfNYTlhQhMTrqP4anNdkzHt37bPlZ+d
         5Y0SoMN7ldN2yyI38lC+ZCBsffTYhyYPDP0+6DNSmKVbcNJmR6QHZp3YJezGmq+MJcdB
         JYt0TzeFRL6t+0lCf6w+ePqTRvaiti+MhZzNAFWfH5dOMuTc7KL7r1g2Hp8ope3YaZS/
         ePtQ9j5Vy/N5SZ2cXFjOCBWrGSLU+yWYCxVoH1kHwGXtQ1qu4bJ7fsNt5YRiuyaudUEo
         D1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hERfJoYfQXcP3Fg4ZWHacBR7u3QzGp1x+e+8qp2E5Zc=;
        b=Wyn6rXQZv5GS4TVa8MexKW1aFnXrWAnT44+jpPiiCj2RavCkQh1eU6r3KLXIRZh5j7
         6cxL8YwI1L4y0uO92/q9DvB3mw7A3S68n8p3Hkz/MQAxQ0AmqORdkFyWPrIr1hL37XYg
         qLDGdFtqpm39NlNWBrhrcxk2UDdEsgCzG2ou17e4G1wDSs9Q+JRd/Efz+q8SB+wgylkQ
         WT1Y5t3hrDzErszXdGwTe20/PGSYPJagf5pb5nQM4+Ta7oLcVXmZG7kimPiHKluqJ5h5
         ITDLKP0KJDm4SFejmhOVKP1teo7nWxwsymCy2MZqTen/ssQGV17Rs189OZ4dt/cAvvU7
         EmfA==
X-Gm-Message-State: AOAM532fEpsaZMiMsTblXNccydBP/2UbSPas/+/NevBcRla/sSEtQeQf
        6eNppQzJ6bDPjQP4vYFeB22yajMYk7DzVz6D2bY=
X-Google-Smtp-Source: ABdhPJzepu4mN3/kEJHF/ExZAr1YwXESzZeffz+1ptAWUTBFt9giuH8QG4be8kUJdiAM0j4J7D5zVUMLnk/1Hew5YME=
X-Received: by 2002:a2e:98d0:: with SMTP id s16mr12344835ljj.457.1595351847091;
 Tue, 21 Jul 2020 10:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
 <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com>
In-Reply-To: <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com>
From:   Alireza <rezaxm@gmail.com>
Date:   Tue, 21 Jul 2020 21:46:59 +0430
Message-ID: <CAD9n_qim=g62TnckSG3-=1yPDCwQc3u0kYouVSU3f_a3C+NtMQ@mail.gmail.com>
Subject: Re: Request for adding a "clean" merge strategy for a double-commit
 merge to deal with conflicts separately
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If there were an option to allow git log for a merge to show the
> difference between what an automatic merge would do (complete with
> conflicts) and the end-state that was committed, then the resolution
> would become very accessible and the rest of your request would be
> moot.

Happy to see there's already some interest to make this easier.
However, my main use case is not just to see those changes, ideally it
should be a separate commit to be easily reviewed in a PR, for
example, otherwise the reviewer must pull all changes locally, which
doesn't sound like an improvement, IMO.
