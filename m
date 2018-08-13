Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED671F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeHMWgs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:36:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33336 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWgs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:36:48 -0400
Received: by mail-it0-f66.google.com with SMTP id d16-v6so12529699itj.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKAzOMq1aOtN9WXjQvbMkpTsxiSGkK7lhNnFOj3e/SE=;
        b=hrVE6WubZgH8GWEliLPsGn6guSyv3bR09ra7grAh1NLMVajClhp3yWbgog2HeOgRpL
         M9jDwtBDc3pAETnyR3mcHngMSLG7cM6HZMze7y1C4F/Jh7bBCpH3mP30zUiYDsVl/s3l
         LGkQjd8QBXzlgVG0tmJfz2QaUSDKJfOBiN/LToQ/xM3oA9nRNgZKAIS8V3Kjzi4lxrOk
         MlEBCZdHE3CN/IlpvPHayV5CGRQGUAZs/GCf3MtkKFet8FwoxHzDolXS2faLxx6YQrU0
         JL8p0ZM/Il0a9Cbg8BhKhDpqbFkxS8S45tbt4xvIEXW8RnyTTHAdANYv7oCpKKDWRO2H
         ZJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKAzOMq1aOtN9WXjQvbMkpTsxiSGkK7lhNnFOj3e/SE=;
        b=uhYrjUWWd6HE/4qoqnsYkufEVwxNb2Xxn0BBBLPnMGnBtPgOiuM4fAvExWf9xqNQkx
         JSAKgLgtNpurL84JlC9k2KJY63ibQ+8AfhMjjWWFhU1Ea4tfh9gM3C7n+nrkdIWFD0li
         p5fnduUrZmb6IsQb8iGj8JRIdvn6CyA1tpsnT6fog1p/WdLvvqJC70U+NNK4fE+s2XOB
         ryZVeBrT90+ERuZzMw42pcePx4xIzGNt1t2aohpfPnnXMtYLWgbA5or4AB6KV8xAqjYR
         uxUHvVQSII/F2FaOKeOuYM5tPFP+fr8JCZf6bAWXPR18vmNWsbg87KQ1/JMGjnZ0GZiy
         1Xlg==
X-Gm-Message-State: AOUpUlHTPtP6gTKiGT3NegoiiwanKPgTtBFwRkk22gmjut/A+jGSB3pf
        TxbGBpln/mR9YzOWce6IcSyU5e+u46DDO3FVG/c=
X-Google-Smtp-Source: AA+uWPx+COtkyPji55FTjRi/JwtH9K1/8e5NBiBGnpLVCz3Y+dBANzYSpQ98HdYPdG+utF9kMdYEq/UHRWg92Lwp+xw=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr12253256itc.68.1534189987412;
 Mon, 13 Aug 2018 12:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
In-Reply-To: <20180813192526.GC10013@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 21:52:41 +0200
Message-ID: <CACsJy8Cxp9+xiMB6C71Kr63EWyAni-K0ZwVBbpBjUieDbZ+6AA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 9:25 PM Jeff King <peff@peff.net> wrote:
> Am I the only one who feels a little funny about us sprinkling these
> performance probes through the code base?
>
> On Linux, "perf" already does a great job of this without having to
> modify the source, and there are tools like:
>
>   http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html
>
> that help make sense of the results.

I don't think I have really fully mastered 'perf'. In this case for
example, I don't think the default event 'cycles' is the right one
because we are hit hard by I/O as well. I think at least I now have an
excuse to try that famous flamegraph out ;-) but if you have time to
run a quick analysis of this unpack-trees with 'perf', I'd love to
learn a trick or two from you.

> I know that's not going to help on Windows, but presumably there are
> hardware-counter based perf tools there, too.
>
> I can buy the argument that it's nice to have some form of profiling
> that works everywhere, even if it's lowest-common-denominator. I just
> wonder if we could be investing effort into tooling around existing
> solutions that will end up more powerful and flexible in the long run.

I think part of this sprinkling is to highlight the performance
sensitive spots in the code. And it would be helpful to ask a user to
enable GIT_TRACE_PERFORMANCE to have a quick breakdown when something
is reported slow. I don't care that much about other platforms to be
honest, but perf being largely restricted to root does prevent it from
replacing GIT_TRACE_PERFORMANCE in this case.
-- 
Duy
