Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35602C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDB164F6C
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 11:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhCQLrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 07:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCQLqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 07:46:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8FC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 04:46:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so662409ply.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SnNgB8z6SVjxvqOizLESCNp6BjAvtTYrFadYdsB9KYY=;
        b=ozKZ7QZxQbZ4NmpEiYyryuy/nCt3lRe+xOLDOhXEaEm3ASFFVQSfD8eQ8J1begCWGg
         rvUT9Mb86681H9oMNqcyXRquKWkV+Z6XSRI6VbJ2JJNZEJQmlSWJwUpyYaaFOam/PK4p
         QCwqUpWOFqgdKOl5i18ZEJUjS1sAE+HBODzaKrVhfAqGduxBVYjfLarSZe9SAqprB0BX
         H2du7uJa6CaAhgO8hHfTXeU80k1QxL0oLbkUPwJhhdkhmBGSiAXJ2SCJGcol6xmGkabA
         ERYWcvmBeanNA58Tcsoxs1O4SvYQcMx9T8F9dsj5FxsMDF0fiAiFwN5QTcvXlIrHwVyg
         a9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnNgB8z6SVjxvqOizLESCNp6BjAvtTYrFadYdsB9KYY=;
        b=BqUMGwBlKDDtrWz8PKW+QNUMtaR046mQFmS3Gds2oes0fneMJhOg671fKqFd9I1bvU
         jq2as57PpxnJ5OzQsN6CuP+rYqKlI0JmlFycSHxukEW6iJlJECx2m+sHnPkVUauisrkf
         WF5PyF3WEtUL3tzGdfsVlzLcpVKzdCz3dAkDv5E9W84SnpRIjavfOgCGg31CGdr5D9Za
         +zWquY5e4IL0avJtx5TAaMfJkHzWILbmgrXbmo7B6X7T1b+837kDZ4ofcUzDsj+tjio3
         lh/8t8qe1YCxjaAMGQnoVYfBbKEr7Q+ONrZhxbaE55R3HYMgrceD1pQv1SCWxGSE0jl3
         nbEQ==
X-Gm-Message-State: AOAM530kX/5XMtpOOkM90Z+JSOtExk5qicAOnZgAMtQ6yxT6MA38kRWM
        2sy/qq8FYsupjify8H3QGHs=
X-Google-Smtp-Source: ABdhPJxe7m1ZYIpjgwqOop+0He8LGscB5YxpboJJlBunZn4vjQ1szGlwVLuA+DT4lpjbdE+5BIQ8RQ==
X-Received: by 2002:a17:902:fe96:b029:e4:2f39:9083 with SMTP id x22-20020a170902fe96b02900e42f399083mr4025706plm.47.1615981601376;
        Wed, 17 Mar 2021 04:46:41 -0700 (PDT)
Received: from localhost ([113.185.87.32])
        by smtp.gmail.com with ESMTPSA id f135sm19407502pfa.102.2021.03.17.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 04:46:40 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:46:38 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] format-patch: allow a non-integral version numbers
Message-ID: <YFHsHg/R9la3IwEv@danh.dev>
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
 <xmqqzgzsuibf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzgzsuibf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-25 10:13:24-0800, Junio C Hamano <gitster@pobox.com> wrote:
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but if we can provide `format-patch` with
> > non-integer versions numbers of patches, this may help us to send patches
> > such as "v1.1" versions sometimes.
> 
> I am not in principle opposed to support a fractional version number
> that comes after an integral one, which allows users to signal that
> it is a minor correction that does not deserve a full version bump.

I'm late into the party, but this rational sounds greate to me.

> If we were to do this, I would probably suggest a preliminary patch
> that refactors the hardcoded "reroll_count - 1" out of diff_title()
> so that the helper takes two "reroll count strings", i.e. reroll
> count for this round, and the previous round, as two separate
> parameters.  Teach the caller to pass "reroll_count - 1" for the new
> parameter in this preliminary step.

However, if it's only a minor correction to the major version,
I _think_ it makes better sense to compare with the major version
instead of comparing with another minor version.
When a reviewer reviews v3.5, they can just compare to v3.
In a hypothetical world, when another reviewer jump in and a major
change required, v4 reroll also compare with v3.

In other words, we will have something likes:

 - v3   vs v2
 - v3.1 vs v3
 - v3.2 vs v3
 ....
 - v4   vs v3

The good side of this approach is: the logic to choose previous
version is simple.

The downside of this approach is: reviewers need to re-read the
changes in v3.1 v3.2, etc... However, we can reasonably expect those
changes are small enough, they're minor changes after all.

And they will need to re-read all the change if the major verison was
increased.

-- 
Danh
