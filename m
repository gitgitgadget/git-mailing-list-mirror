Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503AF1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbeGSSQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:16:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32902 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbeGSSQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:16:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so2308578wma.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZZvZ0mjpPNN3VVlgDWi9aempSlCbdwJ2fSTE329Y2jc=;
        b=dsftx+okbmSdyTE41xJmAsOqojmAFo0wCD9H0ujAZCakm2FqkCQfCJghQA0RREGelb
         ALhpNmzKn9pwaMjNew8gNuJvkUIJj2vKBN7JYKRzW7NZEIFflz3ffpyqccUxpb7kyxvp
         hN6f+5xsZquRLwusXNpxITPgPVdIH7xnAjMYAyIWf8681CsAtU6k0uTEOIfF7wtUt11N
         X58yFiAygNPOCaU2r5xKYhDtubasi8hEvU1DV4SZemIUJ/McTDJ2p5DXZgkDmqtKPaLN
         NnGk3xrZnwIilFc3W2BZ0/On/SB4XlpLcqcQ1yUdxJDuTmMK/tuA93Dy96kBWBbVe5sH
         vtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZZvZ0mjpPNN3VVlgDWi9aempSlCbdwJ2fSTE329Y2jc=;
        b=ROH/qq3kQZ3xIk3L3TSjwt5rJbJ3YoyHepBIylPKZiN2JUNwsaDfkr9iGUeeSkOEnj
         d1jAdI4nxRHyEeOu9ZFjctu8bcYfUNEtNMlGbGzRw/61uPlbovIUCDqo/+ruJ15svCPB
         6bAU2Tff7KnMDZz4ntaEZ+oIJmGFZoCSsWsmV6VGYN822pW5hEG0XpGpe0f5vXwjGDpt
         EJbvZ6na9SnM/K0rgZK4228a4YHm4LRsTN0wsEns6+r9Xu95/7lT394WH0l43FOsjpZY
         FG1GIeA/OvPzlDhlx9h/3tNreXodhIoba12oO+qi+o7ZDrs/9rlkrBh0KLNTi5pn/N5K
         BsMQ==
X-Gm-Message-State: AOUpUlHsp8+OEHOoo7CL5eDjyERclLmbHZl2rnI5HfkOe1DKhGqr53Wg
        I0rXLsZmhRYBq55EKJ6iQeQ=
X-Google-Smtp-Source: AAOMgpc4gGNm3g5gHgzWljpSak7gALXBX3PQdZQO0LuvthJ2eRJ2kXe7ZmFpj5J1v3TAFTidqwLPDA==
X-Received: by 2002:a1c:f017:: with SMTP id a23-v6mr5103543wmb.160.1532021562088;
        Thu, 19 Jul 2018 10:32:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c13-v6sm4951742wrt.24.2018.07.19.10.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 10:32:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in move detection
References: <20180718005311.136329-1-sbeller@google.com>
        <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com>
        <xmqqtvovgped.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZvHvMy6Lf-_Dtzbfaz2BFY2WonOfw-dDQVCOnS-a0=sA@mail.gmail.com>
Date:   Thu, 19 Jul 2018 10:32:40 -0700
In-Reply-To: <CAGZ79kZvHvMy6Lf-_Dtzbfaz2BFY2WonOfw-dDQVCOnS-a0=sA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 19 Jul 2018 10:29:21 -0700")
Message-ID: <xmqq601bgmh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> "git format-patch HEAD^ --color" produces red/green output
> (like git log would), so I do not see why --color-moved should impact
> format-patch differently. (i.e. if the user requests format-patch with
> color-moved we can do it, otherwise, when colors are off, we do not
> spend cycles to compute the moves)
>
> Maybe I did not understand the gist of your question, still?

"format-patch --color" done by end-user, especially when combined
with "--stdout", would be useful to show coloured output.  That is
what you are talking about in the above, but that is not what I was
asking about.

The question was specifically about configuration.  You may say
"diff.colorwhatever = on", but "git format-patch" with no command
line override wouldn't want to be affected by that and produce a
patch that won't apply, I would think.

