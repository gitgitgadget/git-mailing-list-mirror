Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EBCC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 19:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiBVTMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVTMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 14:12:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9B329A0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:12:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s1so6197149edd.13
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C29LHm5+FpRgjXiiXAR9TGgl068Tx66u0utZ5TXEkWM=;
        b=hS+lqRLmv/CDIEP0CCHKzOaim38Bo2cmVpuXi4KcbgIPk3yCa/7Ql4CNwPJzj8Fn2N
         9WciDHUWp3+iINkOfq7Z9QqQyFLtlH6FLTgCUrcFwTJHfAoomZ5EbszVnLWReqHzJ9HE
         D6ZoZ8aIqKpifnBnGc6krTC3vZNcEkiWVAM9Ru8sELGnn9DQVQt0rVkXVyakuXqoLsXb
         B9tV41fPN0GoGBmLa1kqqly8Ip6eWkZk76gh+9IAtVKd/t9gLcaps8DRNk2FswKsA3hB
         I3i1ftdzpq5whI1xkN6EH0C55LUNrnhfVGo0yMvNCEkXWKbnuIL3iw9RjEsHnf7Atcf/
         IVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C29LHm5+FpRgjXiiXAR9TGgl068Tx66u0utZ5TXEkWM=;
        b=a4YVJbygIZ3xxHhyTgtXGQW6F3KgQ8UZEbMzwpE/+rRIIQWDaeGYxhB7+p77zsVZMu
         o+dS6o0DY4Yanf+8Szm2+mcQ7e5iFg/k7yiGgFRmOU4yy1nRql+oNX8Hrkq5PvTg7iSr
         y2r0ic9PuWo9sxe0YQJVCdwoKugDPPiJdaxrTmX0te2tdMt5TGQXRMRTZCcTItp9MUpW
         Nx7cgpJCICnjUgr5fF/SOMfwAWrutK3hOAo9m1goxo9uV1Zvy2S8X97fCu+tDMYRW+j7
         Mxu99aM04PxmRG+NSFRwtST4NU1Yn9oWGX5wRC7Te0W4WC7J7bsvw+7PdtN3xg00daeQ
         jpFA==
X-Gm-Message-State: AOAM533m4l/iHfdw4s2cez7ImFq+1k4gph8eBrsiT4LJ9duUpFqxzOSX
        HL4XU2bCyIVJ7U/I4RqQLXNjNIZExeGlxLAo0m+DmuvfG9RAJpXO
X-Google-Smtp-Source: ABdhPJwYoEl6huDhuTCDpYh35nEA1u1nqoMTI3HG/L1rS1JGmOznOc7TWLAX0qsfBD5Mj+2O7iLGZ8ZUOhUa2JOEfp8=
X-Received: by 2002:a05:6402:2750:b0:412:f7a6:6d52 with SMTP id
 z16-20020a056402275000b00412f7a66d52mr13059417edd.187.1645557134641; Tue, 22
 Feb 2022 11:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com> <220222.86pmnf6ket.gmgdl@evledraar.gmail.com>
In-Reply-To: <220222.86pmnf6ket.gmgdl@evledraar.gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Wed, 23 Feb 2022 00:42:01 +0530
Message-ID: <CAC316V4ptAWJDgkcDrN8Gt7fSm4MtJFB7xqC4JTcEX0OW8a6rg@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think these changes are good, but it's not the case that we try to
> avoid using pipes at all in our tests.
>
> It's often a hassle, and just not worth it, e.g.:
>
>     oid=$(echo foo | git hash-object --stdin -w) &&
>
> Sure, we can make that:
>
>     echo foo >in &&
>     oid=$(git hash-object --stdin -w <in) &&
>
> But in the general case it's not worth worrying about.
>
> What we *do* try to avoid, and what's actually important is to never
> invoke "git" or other programs we invoke on the LHS of a pipe, or to
> otherwise do so in a way that hides potential errors.

Sorry, I have not mentioned it properly in the message but my
intention is not to remove all pipes but to remove only those, which
have "git" command in LHS.

> That's not isolated to just pipes, but e.g. calling it within helper
> functions that don't &&-chain, but pipes are probably the most common
> offender.
>
> The reason we do that is because in hacking git we may make it error,
> segfault etc. If it's on the LHS of a pipe that failure becomes
> indistinguishable from success.
>
> And if the test is really checking e.g. "when I run git like this, it
> produces no output" printing nothing with an exit of 0 will become the
> same as a segafault for the purposes of test.
>
> And that's bad.
>
> But just invoking things on the LHS of a pipe? Sometimes it's a good
> thing not do do that, because we'll be able to see a failure more
> incrementally, and with intermediate files.
>
> But it's generally not a problem, our test suite assumes that the OS is
> basically sane. We're not going to call every invocation of "sed",
> "grep" etc. with a wrapper like "test_must_fail grep" instead of "!
> grep".
>
> The same goes for our own helper utility functions such as "q_to_nul"
> etc, as long as (and this is critical) that they're implemented by
> shelling out to "sed", "grep", "perl" or whatever, and not to "git" or
> "test-tool" etc. Then we need to start being as paranoid about them as
> "git" on the LHS of pipes.

Thanks here for providing me with a broader context of the problem.
What I understand,
It's not just about "git" on LHS of pipes but more broader to anything
custom where
We can miss exit codes but I think as a low hanging fruit I can start
with "git" on LHS of pipe
and as I will understand the codebase more I can work on other custom
helpers too.

Thanks,
Shubham
