Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDBF1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfHFVyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 17:54:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfHFVyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 17:54:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so42219104pff.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BrNTkkQ/BQOP3pqV2RlqC//k2slve7s49qonAEs1I9w=;
        b=XC7zBZ9QGP67uZ0mAvm14YJpO64wkU0NUlrDM1pleMrRircEhLLW2rfiqerUnB+zkB
         q/5aEuaiCey1sEJ3qug9x5INep2krQVggWEuidUuUv7Q5ArJXTRWV4MUzu2ZCqBv0Y84
         z0aVojRtkcKV+j1uph6J79mvKJ8ZuMqNAXfLFr9Udt1zgTfinn3jUIkVqrUJ3vzazsLQ
         QfuzObKWnpnxeo4jY09VcSazm8D3cNhffmbSjoPtUOhX5vQwMzpwAAWnIMGMq5YnuZLR
         NXnkM4Rp/iQXASUhIuvG0BnjIGtp+lty3t2+xzKBsFPI/QJ98gGJdAI2Paf2hJkbGQ0k
         mZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BrNTkkQ/BQOP3pqV2RlqC//k2slve7s49qonAEs1I9w=;
        b=XBLKxeCmdJdH2OUVT9fShIG5e4jlX+kMrZJszC7Bz+rSm8xXzGOppC9EuJjnhly1j9
         AhpUtuT4WWuyhDHh/H4TrP0cih1q3cD8DQExa8oMGo8EQgAvde3jNXiHUfoE5cPx0BEa
         EdiXtctXJ9KoD7sDPijzn6qW2qIb4+GpE7HN+I1LsIkVhuIzk0e82J0j2TlFG8SnZOab
         r1rIkuA40NQzSBwmjR0g5uSs2YjbA+Eo7Xm/+8TlzgfVF4IkrliHxFZpILBB1Nu5kDtW
         zuzQm8zVvIMTimK+ETvyhmb8Ppt5Nq3NFpFfTXDEZocdkuC0i+kDVwrMOI8F3VfqBSpY
         lKxw==
X-Gm-Message-State: APjAAAUitQAm9vJZIYQxorX6bVr56qY78OlgCDC445Cs2/Y/1CXXCsrk
        RRoPwpBldsbvs3hHJvmM2858sQ==
X-Google-Smtp-Source: APXvYqyKBXE56GsgAXW8GX/QKboqtdGc90+TPVdflskF+e2yyfeg/pnVSYyj7XB09jTdkFdpORCTqQ==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr5304084pjb.115.1565128492054;
        Tue, 06 Aug 2019 14:54:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id x67sm92938573pfb.21.2019.08.06.14.54.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:54:51 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:54:46 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
Message-ID: <20190806215446.GA59629@google.com>
References: <20190726220928.GG113966@google.com>
 <20190805223350.27504-1-newren@gmail.com>
 <20190806202829.GB26909@google.com>
 <CABPp-BFZig73jXKkKNaz=YpT4enB3_ARQ1KTz_ttPYobkY6Bhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFZig73jXKkKNaz=YpT4enB3_ARQ1KTz_ttPYobkY6Bhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > +
> > > +             test_i18ngrep ! CONFLICT out &&
> > > +             test_i18ngrep ! BUG: err &&
> >
> > The BUG is gone. But should it not use i18ngrep? BUG() isn't localized.
> 
> Technically, yes, you're right. However, this line's purpose isn't
> correctness of the test but documentation for the person reading the
> testcase about what it's real original purpose was; my real test was
> the "test_must_be_empty err" check I have below it, but I added this
> line just to document the intent better.  I kind of like the
> "CONFLICT" and "BUG" lines looking similar just so the reader of the
> testcase doesn't have to try to reason through why they are different,
> although I guess it does present the problem that more careful readers
> like yourself might do a double take.
> 
> If folks find it more readable to use regular grep instead of
> test_i18ngrep, I can change this line as well as the "core dumped"
> check immediately below over to regular grep.
> 

It's fine by me, I see your point.

> Thanks for taking a look.  :-)

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
