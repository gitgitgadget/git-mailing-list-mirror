Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C2AC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1485E60C3D
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhENP2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhENP2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:28:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF012C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:27:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c17so24845624pfn.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wd51zbDK7MbSPqZx7ERtD5bIY0+W3RV2xmMggG4pB4I=;
        b=SqMKBuaQ36dbR7V0qwsi06wdZrSBwzP5/e0Hb0DEzfHQntCnh3XlqdHH1LHFg44wYd
         9a2r+czW/P5wj4waqzcnEIKlN7jPYO6LVX75g5AZEz9di4+jBkVnDs7mVACeod+8qvgA
         ni88CnJBbvjokvv+TeYKSXq57qzvlP5oj6NlqmJEr4kiKOsxImWF6nzE0W9eLOKk7/Wc
         kRWEKL+v8ntvqpDOB+JHFFwSNBenq4M6CP1wPAYxZsyU8U4q8T02hPifxacXaHAgQO76
         b6LbrkoO5mgMXjuczpruWK8pmae8rxX8KN2C1V5SC/mA8+N+j6mOmdOWMsBo9Hb4WebC
         Ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wd51zbDK7MbSPqZx7ERtD5bIY0+W3RV2xmMggG4pB4I=;
        b=dIA/FefI5tLG3Afaii3ucrcusjatbuo0bhhka5b631cLiJUF4lxz7eFebvJILuU0y5
         rfURPQ/zqN/B1Ibcw5ocYeRHXE+VIxGWd3/lWKZ/tnMsW+rh096JNDKhzyqTwQ+sPe1T
         HnhekfR/0TxW8fMV1YssF+ZlgFoZB5EBmfwqw1lkHhBsPYrhTzG1ZEKnistFYtyCem2l
         v0VO7deXnkae5PyjGBGt+6sOBO0JJCVK3AdhQ7cfY4/p08umdA7fky7rlbvq539srCt9
         CDlAVI1GShTIiXvkuKbdtZmrMK7cBOETYQ3CvCURhVaRlGp9YpWjzCHf7Gtiv6OAPb45
         SaMg==
X-Gm-Message-State: AOAM533hfyzeNrZsxsR7V5uYuVtohca5tcDXb6dzTIsoerlDhcjTBh6c
        tUE0Zyevq8tizoSikZLQaDexBqElpjFWNA==
X-Google-Smtp-Source: ABdhPJxYELPDB8yAPWsPOBCH0lew4Xz4Ej4/VrDD1dRJCZbuHlx31lvItklYSPLJqTCvnDnXDhtERg==
X-Received: by 2002:a65:654e:: with SMTP id a14mr1455221pgw.332.1621006058565;
        Fri, 14 May 2021 08:27:38 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v17sm4362089pfi.188.2021.05.14.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:27:38 -0700 (PDT)
Date:   Fri, 14 May 2021 22:27:35 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/howto: tracking git.git
Message-ID: <YJ6W50M+EJlIO1GJ@danh.dev>
References: <20210514124925.39229-1-bagasdotme@gmail.com>
 <xmqqwns177cv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwns177cv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-14 22:49:52+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > +Available Branches
> > +------------------
> > +
> > +There are several branches on git.git with different purposes:
> > +
> > +master::
> > +This is the most stable branch. Changes (topics) that are merged
> > +to master should have been stabilized in next and suitable for
> > +production use. Feature releases (vX.Y.0) are cut from this
> > +branch.
> 
> Isn't "maint" meant to be more stable?
> 
> > +next::
> > +This is where topics that haven't been yet merged to master are
> > +stabilized and tested for breakage and regressions. It gives
> > +a summary forecast of what next batch of topics that will be
> > +merged to master looks like.
> > +
> > +seen::
> > +This is the most bleeding edge branch where all excited
> > +developments happened. All proposed topics are queued in seen
> > +by the maintainer. However, these may be buggy (have breakage or
> > +regressions). When topics queued are deemed good and ready for
> > +inclusion, they are graduated to next for stabilization.
> 
> This is inconsistent with what has been written elsewhere about this
> integration branch.  In short, you should not read anything more
> than "the maintainer happens to have seen these topics" out of the
> fact that a topic is in 'seen'.  Not all proposed topics will be in
> this branch, and a branch that was in 'seen' on one day may not be
> there the next day, but that does not mean anything (certainly it
> does not mean the topic has been "rejected").

Well, I think most of this document's points has been written in
Documentation/howto/maintain-git.txt and
Documentation/SubmittingPatches.txt.

With only 2 above points, I think if we have this document in,
we'll have more things to maintain :shrug:

-- 
Danh
