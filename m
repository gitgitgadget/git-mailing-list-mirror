Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B5C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF192177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0USfl1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGW3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGW3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:29:41 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77719C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 15:29:41 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j188so1086764vsd.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKjZc6rUOG9yDNbm5aprP2Hn+Jy2xBkVsjI48euZqzQ=;
        b=Z0USfl1/t55RINQYHHQB+F67dDW/gRXKDsaCm9yNpqG7DE8Gjl4+vn53lQzoYwp8Y8
         PxaYcWSKt4dswWaGCDY6AXEk6Huy+eXoFBddP80bFGM8SMnqJo3g/tqbp0mmOfUazlCc
         H5koM8Tl6rtf4I0t0WqAnMYqM9Ohp5chvtQFixPglVhnlPQaSMFsyltShMeJbTyQhemR
         Ynij3CSpnm8kYRS6CCGd2AsN2hQsEiHtUdZSxejH8+ShS1Nix2I6ZPvSESxQ8qWnmHjK
         2aDT2zCv3kuNbZoVNbRWvoRQ08JlLtMVTbhKXQ/MF6evCfBmA23hS84EH7YHq/ci6C+v
         e2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKjZc6rUOG9yDNbm5aprP2Hn+Jy2xBkVsjI48euZqzQ=;
        b=q7oNSHu/KqafilpFad5h7+C+82IAGFA8jeiKkTGVcRmxybDPP1MsriaSvWxEAt/xfE
         hFa3kTNKaesaDIGwN0bGYSi5JvIdINfhHa+hg+7kiSEgcB9AdK1RymmJzk5gO5NcQ9KI
         k5fV7+ad59lFDZ9YRJK+6U+dxWyabI+elJNQeJ0e256MeyigCIK6T20dnL36GAYUdpSj
         zp4FGDLto8TpIxdewQM8oJoNJiKh1lWVrsuXNdQ27U/HhiaYI0rGAXQyuf0cbye+AWHQ
         +hPGtgJnFiF7k60gDTkjReujUty8sBAnWTvSvmDI5O1ilQb3QaqUJGVprWCn3OJZXnFv
         c4wA==
X-Gm-Message-State: AOAM531OWpADzGK8dQKWqzXplhFRLD7PoOL1/zb982a3L/EdaNggMm3Z
        jj0NxPq/eFwQaOUMJClp8u/O58lq+0+tV0w/ubg=
X-Google-Smtp-Source: ABdhPJytYuG4PN8JSKuEsQLnTsRb+x3ijwFv6Lgc5ssm2dmUGYcUWVoKog8hbajGDU/HLmZxHdO4rNdSkDp9+89HQVI=
X-Received: by 2002:a05:6102:2373:: with SMTP id o19mr11658410vsa.118.1596839379922;
 Fri, 07 Aug 2020 15:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.695.git.1596728921.gitgitgadget@gmail.com> <902b742032ae19087392538936cc81768a59e0e1.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <902b742032ae19087392538936cc81768a59e0e1.1596728921.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Aug 2020 00:29:27 +0200
Message-ID: <CAN0heSrvJ4nZnMH=CPyNrZTkEXsZm2htT5kzN+RfzPXgXW=oSA@mail.gmail.com>
Subject: Re: [PATCH 05/11] maintenance: add commit-graph task
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, sluongng@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Aug 2020 at 18:50, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 089fa4cedc..35b0be7d40 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -35,6 +35,24 @@ run::
>  TASKS
>  -----
>
> +commit-graph::
> +       The `commit-graph` job updates the `commit-graph` files incrementally,
> +       then verifies that the written data is correct. If the new layer has an
> +       issue, then the chain file is removed and the `commit-graph` is
> +       rewritten from scratch.
> ++
> +The verification only checks the top layer of the `commit-graph` chain.
> +If the incremental write merged the new commits with at least one
> +existing layer, then there is potential for on-disk corruption being
> +carried forward into the new file. This will be noticed and the new
> +commit-graph file will be clean as Git reparses the commit data from
> +the object database.

This reads somewhat awkwardly. I think what you mean is something like
"is there a risk for on-disk corruption? yes, but no: we're clever
enough to detect it and avoid it". So from a user's point of view, I
think this is too detailed.

How about

 The verification checks the top layer of the resulting `commit-graph` chain.
 This ensures that the maintenance task leaves the top layer in a shape
 that matches the object database, even if it was ostensibly constructed
 by "merging in" existing, incorrect layers.

? I don't quite like it -- it's a bit too technical -- but it describes
the end result which the user should care about -- on-disk data is
consistent and correct -- rather than how we got there.

Perhaps:

 It is ensured that the resulting "top layer" is correct. This should
 help avoid most on-disk corruption of the commit-graph and ensure
 that the commit-graph matches the object database.

Don't know whether that's entirely true though...

Food for thought, perhaps.

There's something probabilistic about this whole thing: If a low layer
is corrupt, you might "eventually" get to replace it. I suppose it could
make sense to go "verify the whole thing, drop however many top layers
we need to drop to get only correct layers, then generate a new layer
(and merge and whatnot) on top of that". But the proposed commit message
makes it fairly clear that this would have other drawbacks and that we
don't really expect corrupt layers in the first place.

Martin
