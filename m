Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC025202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbdGMS3T (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:29:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34051 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752651AbdGMS3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:29:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so8102594pfe.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r3v9CcnHCcng0Hf35ClRDJ+CIGuZ9Q6tAKoBDw66meU=;
        b=YmYtZ4N+xL79Hb/w34wtd5TQX6+xddRGsTnBf05WgVj/mKB+4GmyZ+XCQjsDKrOF8O
         tMOzzC+ISqreckL1sQ9OASTgBS9KLbcemZzVLd0D8xSuJGgA+Zf2CFBPkLfqAqamKQSS
         VebWWeEmGoAXjzxVcCvnw5wuJqyk078afUeDEl20Ph3Ue9bCR/g5VP/2vpFXB31B29n9
         /f0JqxlTY1N9b9VwSqQcaO2z8EruaelorBn4y9QQdI7XgBr00EwacDfUFeRzrkgayfJk
         E4bZHWhvAO9XBGEgDvUffdeOqPZUa6f5+qdXr5iJ2ut0w2qyRzytaYxh9iRftgjXt794
         iytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r3v9CcnHCcng0Hf35ClRDJ+CIGuZ9Q6tAKoBDw66meU=;
        b=JjQtXOsrlNVbQWVy/N6d+O8YGrIwhluNUQ9R9JYKri419Drup18Bls5M1cs0l6IgDA
         Z7Jy3RcnDpuWdsdB008Gpvmfop5RThu/xi/lCo8v9bl+dHDKKtWM9GDYlpMXSgj0Vzj9
         it4b41b4lyA0RzKDN5miOiUA1IbcWequcP39Y0CX7Hpje6KM/XBZz+vJpsWzWd4mTVMb
         gnKycIxeDdfqlLBm3tu6xLob4bNCuuE58jJbD2YfNNnKb3kOYNyZf0ZnpxH6LjHIu0eK
         1Ue3U5ObVKUik6dCHzYk+f6CptyDcgKxoOU0oz2kHsT0retf27gEaTjNpD0ddoHGa3+a
         bUxg==
X-Gm-Message-State: AIVw112Vy7IZA8+Mr6YVi3z+hix4vPuYpqJSnoAL9BWua6TUkXxzYTQl
        VKlYiZWimsxAFg==
X-Received: by 10.84.148.203 with SMTP id y11mr11661657plg.211.1499970552226;
        Thu, 13 Jul 2017 11:29:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id s64sm14796769pfd.77.2017.07.13.11.29.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:29:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
        <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 11:29:10 -0700
In-Reply-To: <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 12:58:41 -0400")
Message-ID: <xmqqeftkxkax.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Because perf-lib is built on test-lib, it already reads
> GIT-BUILD-OPTIONS. And the Makefile copies several perf-related values
> into it, including GIT_PERF_MAKE_OPTS and GIT_PERF_REPEAT_COUNT. So you
> can already do:
> ...
> But right now the perf suite is not useful at
> all for comparing two builds of the same tree.
> For that, I think it
> would be more useful if we could define a tuple of parameters for a run.
> One of which could be the tree we're testing. Build opts are another.
> Tested repository is another. And then we'd fill in a table of results
> and let you slice up the table by any column (e.g., compare times for
> runs against a single tree but with differing build options).

Yeah, I think we saw this discussed in not-so-distant past, for
which we want a good solution, and it might be the case that such a
solution can be made easier to use with a separate configuration
file (which this topic may or may not be used as a building block).

> So then I think your config file primarily becomes about defining the
> properties of each run. I'm not sure if it would look like what you're
> starting on here or not.

Yeah, I suspect that the final shape that defines the matrix might
have to become quite a bit different.
