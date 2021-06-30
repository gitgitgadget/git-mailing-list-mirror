Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0771EC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CA86113A
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhF3SaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 14:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhF3SaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 14:30:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E1C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:27:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w17so4581895edd.10
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jyFRn/OsXcsU8vNFFw/V2ayUsoGYLRcV3xZa15Dt4Sk=;
        b=gqL8tFiUlWflwUGV4tLaQAJ/MLbAWmOVvYnr1OsVU9D2q8D3nJGQ9yPw3xyMm9ACRD
         3eorkICqDmpI9yys3moEnM0OwT2eWj47rJ5sOLj7hT+Fc42Liq3N+v/J5Y7c5V0uQnB5
         c+5xPEvpo2hTS6I5EEcMffiLRptFtL3rxCzWPt3TlgZNxVClEYLBSdzGQWlQD0eBRPL+
         V45mUU6VYjRw7wfa+x9aHPOVzZQliSwyBUEN3IleNJTRAlwNL9bmYw7tKcFkJ5Y5weG2
         8Mjtu8du28rUD0s0TPs5Mc8gfvguQ3+5K4y+4WkO1yy37+6pgu/v7l6Ah9+p+8vhQtQI
         B9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jyFRn/OsXcsU8vNFFw/V2ayUsoGYLRcV3xZa15Dt4Sk=;
        b=pI8e+5UszfErkD7bRX0LLcfVdV+YC6umhozIerraCKQrqmjzOp2DKn6zgprJ5tGCaP
         7E2GFSJnahapR5d4tjB1fh9cO7GVXqFM5sLum0oOFAaSX3Be637SXxwEdTmG37+xUTW5
         SE448c+vhZ81RuwyZcGkQK9amSQC0Vn33o+SAYw0S2ZtBnoV15F0uDiDUTuaLOlKfOHQ
         BF0ljGYIlN/S8KzzbCJoXflgxZtERUQvLbQKCfWQo4oeu68T0BKEkcXNXI/o/zd3/luv
         Qfh79fn6fB86vqM4jjmesCfBe//2te5KPFYLj1PlkEjW49+QX00knl2Iy7bFgmT66mqu
         btlw==
X-Gm-Message-State: AOAM531iyIE6C+RccQ+XJpV9/aHZB4TprV+DYT/lf9A2NBpHp1rZzK3k
        /BJO7wmze5vMM1DNQZpLBSY=
X-Google-Smtp-Source: ABdhPJyUeeqiV7i7H6BR+rwd5Qi3qd3Jwf8AX8+0M65KJy84H1Z5XVg4tlA8t7jw1W2ql+AzdfLOSw==
X-Received: by 2002:aa7:d6d6:: with SMTP id x22mr47841227edr.224.1625077649478;
        Wed, 30 Jun 2021 11:27:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dd15sm13248466edb.45.2021.06.30.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 11:27:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: git log exclude pathspec from file - supported? plans?
Date:   Wed, 30 Jun 2021 20:22:35 +0200
References: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
 <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
 <YNywsEbFcrQFeH91@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNywsEbFcrQFeH91@coredump.intra.peff.net>
Message-ID: <87sg0zdx7z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Jeff King wrote:

> On Wed, Jun 30, 2021 at 12:59:43PM -0400, Martin Langhoff wrote:
>
>> long time no see! I'm doing some complex git repo spelunking and
>> pushing the boundaries of the pathspec magic for excludes.
>> 
>> Is there a reasonable way to provide a (potentially large) set of
>> excludes? something like
>> 
>>      git log --exclude-pathspec-file paths-to-exclude.txt .
>> 
>> Has there been discussion / patches / plans related to this? I may
>> have some cycles (hopefully!)
>
> You can feed pathspecs via --stdin. So:
>
>   {
> 	echo "--"
> 	sed s/^/:^/ paths-to-exclude.txt
>   } | git log --stdin
>
> works. Obviously it's not as turn-key if you really do have a list of
> paths in a file already, but it's much more flexible.
>
> I'll caution you that the pathspec code is not well-optimized to handle
> a large number of pathspecs. E.g.:
>
>   [no pathspecs]
>   $ time git rev-list HEAD /dev/null
>   real	0m0.033s
>   user	0m0.017s
>   sys	0m0.017s
>
>   [trivial pathspec; now we have to actually open up trees]
>   $ { echo --; echo .; } >input
>   $ time git rev-list HEAD --stdin <input >/dev/null
>   real	0m1.338s
>   user	0m1.294s
>   sys	0m0.045s
>
>   [lots of pathspecs; now we spend loads of time actually matching
>    strings; the ^C is when I got bored and killed it]
>   $ { echo --; git ls-files; } >input
>   $ time git rev-list HEAD --stdin <input >/dev/null
>   ^C
>   real	1m24.406s
>   user	1m24.369s
>   sys	0m0.036s
>
> The problem is that we try to linearly match every pathspec against
> every path we consider, so it's quadratic-ish in the number of files in
> the repo. I played a long time ago with storing non-wildcard pathspecs
> in a trie that we could traverse as we talked the individual trees we
> were matching. It performed well, but IIRC the interface was hacky (I
> had to bolt it specifically onto the way the tree-walker uses
> pathspecs, and the other pathspec matchers didn't benefit at all).
>
> I can probably dig it up if anybody's interested in looking at it.

If it's not too much trouble I'd find it interesting, but I likely won't
do anything with it any time soon.

One of the PCREv2 experiments I had very early WIP work towards was to
create a search index for commit messages, contents etc. and stick it in
something similar to the --changed-paths part of the commit-graph.

The PCREv2 codebase actually has (supposedly) a bug-for-bug compatible
implementation of our wildmatch function as a translator to a PCREv2
regex, I have a brnch somewhere where we run all our wildmatch tests
against it successfully.

So couple that with regex introspection, and a search index that
e.g. creates a trie bloom filter, then as long as your --grep=<RX>,
-G<RX> or pathspec has at least 3 fixed strings among its wildcards we
can ask the bloom filter "is this commit a candidate for this regex
searching this path/commit message/diff/whatever".

So you can have indexed matches for things like '*/test-lib.sh", not
just prefixes or fixed-strings.
