Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC86C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE51864DA8
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhBWQWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:22:42 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:44129 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhBWQWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 11:22:41 -0500
Received: by mail-ej1-f48.google.com with SMTP id w1so35303205ejf.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 08:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVtwFs95BdEzikDm+yn9M8lHpluxumwuETdHaK+E+1M=;
        b=DoySIo98D9dcTU/nQKHGRLI/M8BVuD3/Btm09Nmts1GOUlqz0cw9YWQCNecCBQmMma
         mzJyql8ylQd0qHJhvspuyAOma+3ngDp6rDSW6VfijLorMXhgoclMnEcY3oKVF0WyrRfL
         q+FPtskLzG/iHYWmQg6yYaY7QyZmaN6srh3kJfXuwJGuSE9t/FFa3DbgV78hTdDV9atv
         iQk5l2CJ3Qz9PEwJHAtMoJEG9aBERsT8OO5QFWjmvqnywZRQmkKiQtcDAr89629ixdQB
         pE4Y1vgDQ8T9Rj84lhMZOHtkbDIh4xeJ0b6L+52kIygEwsdjO2yEQhLfzNS0kSEfEPgP
         uiPg==
X-Gm-Message-State: AOAM530/tMKCAgiLpouI0TVQj7eHUTIHlLJ4mr/5cPDbZS1ML0+csXDT
        yqXUbC0DVjKsmqwULvK8ibWAIJvG4Z1ACPJ7Gbw=
X-Google-Smtp-Source: ABdhPJzkTvZeqJrcEbs+AwhyeBnxPYmh8TiahkCkCuTd9qn/ETZ3x2oNNJwScxaWYPe7oRPTnoPXbIwzuTZLQpmbb2w=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr27472943ejb.138.1614097317005;
 Tue, 23 Feb 2021 08:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20210223073107.40675-1-sunshine@sunshineco.com> <5653230a-20c2-321f-7ea0-93ce59858532@gmail.com>
In-Reply-To: <5653230a-20c2-321f-7ea0-93ce59858532@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 11:21:46 -0500
Message-ID: <CAPig+cTWZSe+e5JnTLMDt+F7NxdLG0fFqqSavkyo_YN7B7Affg@mail.gmail.com>
Subject: Re: [PATCH] maintenance: fix incorrect `maintenance.repo` path with
 bare repository
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Clement Moyroud <clement.moyroud@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 7:26 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 2/23/2021 2:31 AM, Eric Sunshine wrote:
> > +test_expect_success 'register and unregister bare repo' '
> > +     test_when_finished "git config --global --unset-all maintenance.repo || :" &&
> > +     test_might_fail git config --global --unset-all maintenance.repo &&
> > +     git init --bare barerepo &&
> > +     (
> > +             cd barerepo &&
> > +             git maintenance register &&
> > +             git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>
> I'm concerned about this test passing on Windows, but if the CI build is happy,
> then I'm happy.

I had a slight worry about Windows, as well, but (1) this is copied
directly from an earlier test in this script which does pass on
Windows, and (2) I tested on Windows, and it works fine. So, all is
good.

> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks.
