Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50A71F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeJRCRE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:17:04 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35290 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:17:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id d21-v6so18815338qtq.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 11:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdAMQzgNlK5qZA0L9cdR8PUe7sMR8zK7k6n/K0ukvFI=;
        b=HkmWt1tIc4fnt1OIIXVa+qNMOwI33mKqALlgHhVlM5nSMMWp8Fly1Atp52/Wysn/U9
         aN69wlqvak555PVJ1PUqEEAQfAAEbLavDnZV/m3DirQw27ZU+Ejd/4bqHd8YhPuaaE0H
         qUZZbtNqxF6eVZhFYbhu3343oF55i4pJmIl5LW5J3qOajL0E7zu3U9Ez9pRiPdx6lcpB
         k/L6nhKVEo0SQu6JVloi46PSQILN39uwhm+OWQAr9jKtYHHHSSyck+KIukVjyMCpQW9D
         bEhqfI+a4bdpiQAs9qzPjs37IF+zqi3nSimlqZd7Ali1/YnlOY5XOPPeKhTUz5HZWR+d
         xzWA==
X-Gm-Message-State: ABuFfoim2Y7AJTk4FplojeXYu6vt++wwDm/utV721N0jAm8jeaAioCGe
        G6/OK3hft8vZYCFZhfbwzwV6Hes2K5sLZ+Zd93M=
X-Google-Smtp-Source: ACcGV60l8+DuQwADWRL83RLpo4WcNoJmsTzZGfhpKAp/Zpt2XsuzpqMS/e3SPpxpWU1bnEYKMru7tNV55q3QnpDo1r8=
X-Received: by 2002:ac8:3097:: with SMTP id v23-v6mr25282444qta.335.1539800410659;
 Wed, 17 Oct 2018 11:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181017164021.15204-3-peartben@gmail.com>
In-Reply-To: <20181017164021.15204-3-peartben@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Oct 2018 14:19:59 -0400
Message-ID: <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 12:40 PM Ben Peart <peartben@gmail.com> wrote:
> Add a reset.quietDefault config setting that sets the default value of the
> --quiet flag when running the reset command.  This enables users to change
> the default behavior to take advantage of the performance advantages of
> avoiding the scan for unstaged changes after reset.  Defaults to false.

As with the previous patch, my knee-jerk reaction is that this really
feels wrong being tied to --quiet. It's particularly unintuitive.

What I _could_ see, and what would feel more natural is if you add a
new option (say, --optimize) which is more general, incorporating
whatever optimizations become available in the future, not just this
one special-case. A side-effect of --optimize is that it implies
--quiet, and that is something which can and should be documented.

> Signed-off-by: Ben Peart <benpeart@microsoft.com>
