Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF6BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5929E64E24
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhBWSMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 13:12:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41910 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhBWSMe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 13:12:34 -0500
Received: (qmail 26616 invoked by uid 109); 23 Feb 2021 18:11:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 18:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1958 invoked by uid 111); 23 Feb 2021 18:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 13:11:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 13:11:53 -0500
From:   Jeff King <peff@peff.net>
To:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utku Gultopu <ugultopu@gmail.com>
Subject: Re: [PATCH] doc: `--date` in `git-commit` accepts approxidates
Message-ID: <YDVFaTGnPCfuJQSa@coredump.intra.peff.net>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 05:35:46PM +0000, Utku Gultopu via GitGitGadget wrote:

> From: Utku Gultopu <ugultopu@gmail.com>
> 
> Document the fact that the `--date` option in `git-commit` accepts any
> date format that is accepted by the `approxidate_careful` function,
> which is located in `date.c`.

I agree it's worth documenting this a bit better, but...

>     I guess this patch is not ideal, because instead of properly
>     documenting, it refers the user to the code. However I wasn't able to
>     find documentation about the "approxidates" which I can link to. Please
>     let me know how I can improve it.

...yeah. I don't think the phrase "approxidate_careful" is really
meaningful to end users.

Perhaps we can leave this hunk intact:

> +DATE FORMATS[[DATES]]
> +---------------------
>  
> -The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
> -ifdef::git-commit[]
> -and the `--date` option
> -endif::git-commit[]
> +The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
>  support the following date formats:

since it's true that --date does accept those formats.

And then at the end of that section, expand what it's willing to take:

ifdef::git-commit[]
The `--date` option (but not the environment variables) will also try to
make sense of other more human-centric date formats, including relative
dates like "yesterday" or "last Friday at noon".
endif::git-commit[]

-Peff
