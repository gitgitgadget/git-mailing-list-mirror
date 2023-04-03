Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F9C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjDCREL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Apr 2023 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjDCREJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:04:09 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1172125
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:04:08 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id bi39so1140636qkb.13
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcnkQU0JI5pN8zYYkw9kfp7xb3y/NElYfvbMfdm0DP4=;
        b=a3TW+9YubUGTQkNBYWgvzD/d146mArSk/f1Na9iNzB9LG/cMy3nrgL4qBIDzSjECyQ
         UzAiHMm17B9vyWRMs8EpIa1x2343sgJ7cR9Tl7g1mjzYQaQiFTzGIHPLuLzPP+lx/3Bi
         ztBHeiXuem4wPK1hGZ5YNBhZtPCRDt6n2xtRLfelf5NIzqogOJJOoe17Drtcgcvv/amq
         4LatZBoFAoh55CIeLxWQyKQSDRWxnNfXOjqcGw3zMZJplrcxXYnWyP5Ki8MeUiHQfvYb
         95kop44ZwvZkK+QqXGB5tFpPpIjqQJtXxVLQMo0pj80yNSH0qO/MX1WabOC27xEgG2A1
         0wpQ==
X-Gm-Message-State: AO0yUKUSsuqxZad3WDHw2JNgifJej6HPxhKzuxoawrBsuxKqINtW4VMm
        S8okDO1v2vpOLgi9o1Atdt9ouTer9mGeXELkNMFcoIrq
X-Google-Smtp-Source: AK7set8k+hG7c62uDCy7QLg7+VLvFM/ZYFaJO7FxAkTz2mNVNUgrfGGkp1NSIraO5eJ3/lCxzH6/on+YFOxQhHa11Fk=
X-Received: by 2002:ae9:e856:0:b0:746:a6e8:39cf with SMTP id
 a83-20020ae9e856000000b00746a6e839cfmr9563112qkg.8.1680541447066; Mon, 03 Apr
 2023 10:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230402113607.2394-1-edwinfernando734@gmail.com>
 <20230402191709.19296-1-edwinfernando734@gmail.com> <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
 <CAPNJDgeHTpoU_eCPPL-adT7R112SyoBdwJF+RbZR6fPPKqSkMg@mail.gmail.com>
In-Reply-To: <CAPNJDgeHTpoU_eCPPL-adT7R112SyoBdwJF+RbZR6fPPKqSkMg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Apr 2023 13:03:56 -0400
Message-ID: <CAPig+cTsqucz0K3e-n0nuu8B87Voaumq9+vtFz0OUCyktszGuA@mail.gmail.com>
Subject: Re: [GSOC][PATCH v4] t3701: don't lose "git" exit codes in test scripts
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023 at 5:35 AM Edwin Fernando
<edwinfernando734@gmail.com> wrote:
> On Mon, 3 Apr 2023 at 07:25, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > However, it's not clear what breakage you are seeing. In my testing, I
> > don't see any failures, either in a9f4a01760 or after applying your
> > patch to "master". Can you provide more information about the failure
> > you're experiencing?
>
> I cloned git again, ran "make" and all the tests in t3701 passed. The
> local repository I have been working on so far still gives the same error
> though. The error message is not very helpful so I haven't included it. I
> ran "make" on the faulty repository and the tests passed this time. So I
> think the problem was that whatever "make" does was not up to date.
> Also please ignore some mails you may have received because of
> misconfiguration.

That makes sense. An outdated build could indeed account for an
unexpected test failure.
