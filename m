Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E8CC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 16:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3834619EE
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhF0QtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0QtW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 12:49:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CDC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 09:46:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so15862282otl.0
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Rx90+P90UgdqHyVpzt96Mom81W0Q9Tu5qbpOW8P8MC4=;
        b=fADXJlnGfEsVWnRyWnx9yIAgUuhnCyEUx6mHRyuM3ZokZjL8jMNda2ir6YVBfSGrfR
         vu6EjWHV3X0jjsXL4lcrPfDx1N8KNJZyJ2ISYBIi79arkjJcHPZ9fiEqNEfILdlqKBgF
         /X80NdlSUfNdS7bAGEg7iPVrB4LHcH4mhrox7UYBsf4fISsGeYNOlFEpOEYqbRVY2Gjr
         aDgbtvnIAnBGudJ+dhic0FC/c4gXtgxXPnzhTk/08BdvVV2imSu+Zemqdeqn/wiCtP9g
         pzFjVNgfQB2O58XcWvfzXPD9ua2WAmmEJ7mqTM457s4awKS25161np6UCu98RbsQN2pC
         yeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Rx90+P90UgdqHyVpzt96Mom81W0Q9Tu5qbpOW8P8MC4=;
        b=OAMIjGc2sd/2XUjNNN1OWGervpOkUG0wI/IPpcJY4ZFLioslf8hdQThE46d6DrO371
         VVorc6PDLv3B23f17jYeRumSLhRsJAUI6jshorRUqCitLKqSqKL+nHzPTS+wQ6DH6hIM
         q/jpJwV8+oDCYUnSmD6gvg8PDW8PAjnE1NylVQP1KPdaQm5zreoLX5ymBLzphdPsDAmv
         T+6WiNjGhIbKd+4m9/FOTlBj4vcuhd6utQGYJZv/YshLBOA48x0vW0u0ux6k5IN+oEuS
         ATp2YkUvqUf0Zb8rs6atYMNWML6UIt7vsNEGtM/sFeotZl4JdOsiIdCpZMu6X35XkkBS
         SDeQ==
X-Gm-Message-State: AOAM530/DryE7rZenb11pDb51rxuBUnG0UaHVZ3joSRTSlFIhSgApogh
        fqTLvPKFMo5fq01aquvKagM=
X-Google-Smtp-Source: ABdhPJzOtjxBWZnsNH05L+9IBZSqxAGI+clf0GwFj4iMDJ9WL6Am7uD06n2DPTTj+xtb9GiSE6JqhQ==
X-Received: by 2002:a05:6830:1e7b:: with SMTP id m27mr15993115otr.123.1624812417635;
        Sun, 27 Jun 2021 09:46:57 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id z6sm2634254oiz.39.2021.06.27.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 09:46:57 -0700 (PDT)
Date:   Sun, 27 Jun 2021 11:46:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60d8ab7fe0761_ba5a2208b@natae.notmuch>
In-Reply-To: <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
References: <20210627000855.530985-1-alexhenrie24@gmail.com>
 <CABPp-BGko7BP6ZMyRKwKrv0xz7FM9ehe67HSAtzgHF9eV2TD3A@mail.gmail.com>
 <60d7fbb770397_b8dfe2087d@natae.notmuch>
 <CABPp-BGXQ4vbFf6Gx21X-Ms+1VQsZfod1waNJZQxVmB7b-gD7Q@mail.gmail.com>
Subject: Re: [PATCH] pull: abort by default if fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sat, Jun 26, 2021 at 9:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Elijah Newren wrote:
> >
> > > The code changes look good, but you'll need to add several test
> > > changes as well, or this code change will cause test failures.
> >
> > Wouldn't you consider sending a patch without running 'make test'
> > "cavalier"?
> >
> > > Thanks for working on this.
> >
> > Such a completely different tone for a "cavalier" patch depending 100%
> > on the person who sent it. Weird.
> 
> First of all, attacking a random bystander like Alex is rather
> uncalled for.

I did not attack Alex, I simply pointed out the fact that his patch
breaks the test suite, which you did too.

I asked *you* if you didn't consider this "cavalier". Your reaction
seems inconsistent. This question has nothing to do with Alex.

I don't throw personal attacks, nor do I chastise contributors for
attempting to improve the project. That's your department.

I focus on the ball, not the player.

-- 
Felipe Contreras
