Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F81C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjBBXtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjBBXtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:49:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE401117A
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:49:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w11so5410319lfu.11
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=evSdTB4PUquFfCxvkve7xb05IQ9Dh9gnxgmwNSoALLw=;
        b=nF4V4gS+dp6CQL4L+PylgMVz01vN2cOdQdIB/71xXmDx3qHTR1pnAtjzrH1baFvtaT
         T6SJbz3JHlW4u2tM/bZxAQAIWVY33nJKk+c0xfnkVq1dCrlndWULeMAQKSuzUUp0Id3f
         0liXkEgvIaevNv4e53nkwsB/v45p7sk9fuYAeGVxHWmpf2V6MUoGtTmCyjda+fWwvI4x
         Oqjjcnd0wUA+WMiIu3uFp2OmGHyBjPpVAQkQ6LsKCf/jkSMVuiZVKaA5aQUDwyTx9DLh
         c6tCnZ8F9nX6Giv6RvDfbYr58EMYiUdzGSuXu2OIQu/aojJvb9mesIDFxtTkktApKdP7
         X/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evSdTB4PUquFfCxvkve7xb05IQ9Dh9gnxgmwNSoALLw=;
        b=z0dOdsqgsFbKMIjEwMIQI6jWGhft3we+/KJTj7djNLqVtdImv1oPuPuyfwpLQ53GIb
         ABRxaYIFOnp8+LRkL01NGLpb111bawOT6mhlyNKJdPl7fkaL979/+j7M4ubZjPZ52amc
         KrGB871LWkMNnO8/sMVSYpURHMx/e8YNuM/NSbZT9EthjeL6XfSZ3kpc/ODuNYNHKRH4
         WErdq4A24ZZWyqgyVh5eVE6KbsIVof/tll+q+fsmoXrBKpk2QcSVWcuJ0OwTQ5TOBAVj
         fRZJgYdJI+xAkCmazB2aBPiZRT6b59q4Ecp3pdI8Y6uD6DLLtBC4MYkFDpyfd/3soXlU
         Agow==
X-Gm-Message-State: AO0yUKXALc3hIYp02rDPgkU/OdkDAVvDdvLWJ6olwmocvOm8sWgQA9bA
        FQfQAGZ8RvUBR0fqWdSUD5eN/d4qMgNqU3nof48=
X-Google-Smtp-Source: AK7set94tHbJkgPGKIr9Kx3RatTdhY6cQeoBXetRn85IQH4pxwizbrG/jPI0rHgLPXAiYeXL8QQhEHhBQf4IxU3IKAA=
X-Received: by 2002:a05:6512:3048:b0:4d2:381c:87dc with SMTP id
 b8-20020a056512304800b004d2381c87dcmr1460631lfb.124.1675381744963; Thu, 02
 Feb 2023 15:49:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com> <49581695-e072-ee3e-1748-f0b8112545ff@gmx.de>
In-Reply-To: <49581695-e072-ee3e-1748-f0b8112545ff@gmx.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Feb 2023 15:48:52 -0800
Message-ID: <CABPp-BFtxH_pNLsP1mR2ciwPt-GcpzWyvv4OJiVg+uns7FyaqA@mail.gmail.com>
Subject: Re: rebase --merge vs --whitespace=fix, was Re: [PATCH v5 00/10]
 rebase: fix several code/testing/documentation issues around flag incompatibilities
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2023 at 2:29 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 25 Jan 2023, Elijah Newren via GitGitGadget wrote:
>
> > We had a report about --update-refs being ignored when --whitespace=fix
> > was passed, confusing an end user. These were already marked as
> > incompatible in the manual, but the code didn't check for the
> > incompatibility and provide an error to the user.
>
> Thank you for working on this!
>
> FWIW this report (and your patch series) made me wistful about that Google
> Summer of Code project that I hoped would bring about the trick to combine
> `--whitespace=fix` with interactive rebases. But in that GSoC project,
> this goal was treated as a "bonus feature" and pushed so far back that we
> did not even get to analyzing the complexity of the task, let alone any
> details.
>
> So I sat down and started that analysis. The result is
> https://github.com/gitgitgadget/git/issues/1472 where you can see that
> addressing the incompatibility is definitely outside of trivial. It does
> seem doable, if Outreachy/GSoC project-sized.

Nice!  Thanks for digging in and documenting what is needed!
