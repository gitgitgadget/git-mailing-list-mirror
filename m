Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83FC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E1960F6E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhIUUqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhIUUqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:46:50 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6AC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:45:21 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q14so250088ils.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3AASOvgtM4ozJgSYn5Vj++m2KO55zudzBrouztJL3Zs=;
        b=hBnHYKSzybuCOyTLN6R9VUQ1+zZXggJlnD46lu7OIsP4KIQMWu3H378/FH6HV1fgvg
         ezivNEpYGSEMnDzHRiGviCK6UYBRKmD/09GBeOeRcCyYUN3iKpM4VXO9byx2xKSETpCm
         YEWeWMFrUnY81RTQ1TELtTXTfrWqrbDE39fzWVMRD8AHoDcns9h9HEBTG2JtCTiKzcpx
         +WI1PjqCaLE/tBdy9PT2V0OLvWv2uzGKwv9lFbHpxEPZ75U92VDeraIjWp56iz6QDsS1
         NElaD+qxuNcqOKZQ0yYDmGdVxkwih8Qz6Ov4UnGyEOarmBnLFazOWPhTN84unCoYBAac
         JKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AASOvgtM4ozJgSYn5Vj++m2KO55zudzBrouztJL3Zs=;
        b=S/DOst3Mgp2Al/QLmpxjRfNCuhf/itpl19JvwRIaV0iWsrXRZqX6I43/MTk2CCEzJY
         aWpY7yh3hUgSwjABHSYkfLGsAuQm1L235f8PQMqM9+O/ab78lUCt8gkt0SF00GBeb/DW
         O0uUN+9z51lj4tYG8zthpW6UKxqLDMu3HRoJmOufwyMNc0G+IpS5NHba2wzmtj4cvCUn
         oS3gA4bELxwpxWft92nwtHYmmxCEJrZBJptPe/yCPjvnvIqXqMJk+hDvIfTzZOiYs1MO
         LRjLshgaBsS00atNj33SnmHgsNceJIaLIDCgkDio8Tl9KiKkRh6W4AZMI+5zN9tSMz1K
         BYgg==
X-Gm-Message-State: AOAM533tlo4bW5ibKUMCl8F4lVSXh+eRhTdoJfZvvlBJPRNk7It1+XSG
        MnnVXzkFY0ozPvdFit2P4QaUFZhbJ/ktOQ==
X-Google-Smtp-Source: ABdhPJwSWSMmKrQbP5MAdX1/O+6mYjnrA8uJgEfXPIwCU/J/c2hkNlUOhY2etl1tpZLWfjdhlamFrA==
X-Received: by 2002:a92:cb49:: with SMTP id f9mr23118881ilq.119.1632257120815;
        Tue, 21 Sep 2021 13:45:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o11sm28673ilu.0.2021.09.21.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:45:20 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:45:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUpEX7mmZ0WPvbYK@nand.local>
References: <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
 <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
 <YUoJGV0wj0ba7n8X@nand.local>
 <3c9af4e9-f3db-99af-d875-fb11bc8a643e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c9af4e9-f3db-99af-d875-fb11bc8a643e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 02:56:01PM -0400, Derrick Stolee wrote:
> > I thought that it might have been related to your third patch to change
> > how bad patterns are detected. But I ran the following script after
> > applying each of your three patches individually:
> >
> >     rm -fr repo
> >     git init repo
> >     cd repo
> >
> >     git sparse-checkout init
> >     git sparse-checkout add foo
> >     git sparse-checkout init --cone
> >     git sparse-checkout add foo
> >
> > and the only difference is that we started silently dropping the bad
> > "foo" pattern after re-adding foo in cone-mode starting with the second
> > patch.
>
> In patch 2, we "detect" that the old patterns were not in cone mode
> because the core.sparseCheckoutCone config is false when parsing the
> patterns, so use_cone_patterns is 0.

I fear that we're talking about different things. With your patches, if
I munge my .git/info/sparse-checkout file, I can easily get something
like:

  $ git.compile sparse-checkout list
  warning: unrecognized pattern: 'foo'
  warning: disabling cone pattern matching

to appear. But I'm wondering why the same doesn't happen when running
`git sparse-checkout init --cone` while the existing sparse-checkout
definition contains non-cone mode entries.

I could be holding it wrong, but I was unsuccessful in getting a warning
out with the quoted script.

> Let's move the discussion to that thread so we can interleave the
> patches themselves.

Sure, if you want. I just found it easier to reply here since I can more
readily quote the things I want to respond to.

Thanks,
Taylor
