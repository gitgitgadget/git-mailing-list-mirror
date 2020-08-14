Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5BC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88DC20B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX/cf2VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHNMXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:23:19 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D1C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:23:19 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id l184so1958923vki.10
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jy/swLtMr4SsgM/06TBAuuB0R0cGc0nWPo09MMwx1uY=;
        b=jX/cf2VULk/ZsOJnPuId6o2DIpToxYdGfmjIVMXKezpSnmdSCKh0fTotVNGLnVovyN
         0v1iH7lGXIhoCkIWamOZDtcn+yFxhUBgDtp+98TqK1VSxvsvCeqzgn5YgqFdJlORFd+/
         hzNdpj3TlfDc8XJnQoBbf5i+iJRlgxAz6/JAVmp/nbOYpDpPCVsN7BkWVYIrIiRL4Jm8
         wCSMtkaSsKLUeak++4eRPjThe2NJyNp4kqGOX7py8NRQtOuTtYgta/VF4KYDlFb03J3K
         HDPOcJU2uwMCo2UTRPffzjMXSkpAwR2+2IJk090LE0tQqLeTE7W1rrdaDIJja9D/AoYM
         UU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jy/swLtMr4SsgM/06TBAuuB0R0cGc0nWPo09MMwx1uY=;
        b=UJlQtPoKWXgXiUdjjq4Sj2m3N33UCVdOFGuXP9jSkyb2jUIbgrYj/Qjv6d+tTLfToa
         Y1MESt8fuImVwyPCFLmjEVRH/ite8NK1mA5XZJYKJbOKu0NklPCy1zYetO+q3Nyj9Yek
         4MPSPPRCqadKoTVyKpgFzx5GAXJg6FYbHHbwaISrD17+jSd69S6PQv512ht1Hhccl/MS
         6yc9KuBOoOULhcJCBCa/ahf4xZZ8KuD61wkTrb9kT0rg6ER+lMN/TWd5ySF4U3TIy/MT
         UnfFgPWcTY7UvlHOogUO+ghF4vzqblwWvYiDJ3p6YqJ72awZe4uk6M6lOv2DQ4X0ci6X
         O0lw==
X-Gm-Message-State: AOAM531XSs0UYyzaaunI9qdlVBAXYD7FtQoWFFHIUt8mAxvn5hhvzcNp
        ng2IDNzae1zk4tYOGFzRhPSRryg3ED7calEFgPA=
X-Google-Smtp-Source: ABdhPJxqVpVhH3GNApw7zrnVWrTs997V0Qqj/ofe6o9AfPgo760H3p20fTigWg33TSdfxthqO7QUxQRxYIwBySiPpOg=
X-Received: by 2002:a1f:93c1:: with SMTP id v184mr1153539vkd.62.1597407798802;
 Fri, 14 Aug 2020 05:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <902b742032ae19087392538936cc81768a59e0e1.1596728921.git.gitgitgadget@gmail.com>
 <CAN0heSrvJ4nZnMH=CPyNrZTkEXsZm2htT5kzN+RfzPXgXW=oSA@mail.gmail.com> <0380dcbf-82a0-68d0-b421-9f5c5a640ab5@gmail.com>
In-Reply-To: <0380dcbf-82a0-68d0-b421-9f5c5a640ab5@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 14:23:05 +0200
Message-ID: <CAN0heSqoPAx84-o2JKSjM6b+Jp2rk_j6p68iJg30AGDa+6HeeA@mail.gmail.com>
Subject: Re: [PATCH 05/11] maintenance: add commit-graph task
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Aug 2020 at 15:30, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/7/2020 6:29 PM, Martin =C3=85gren wrote:
> > On Thu, 6 Aug 2020 at 18:50, Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-mai=
ntenance.txt
> >> index 089fa4cedc..35b0be7d40 100644
> >> --- a/Documentation/git-maintenance.txt
> >> +++ b/Documentation/git-maintenance.txt
> >> @@ -35,6 +35,24 @@ run::
> >>  TASKS
> >>  -----
> >>
> >> +commit-graph::
> >> +       The `commit-graph` job updates the `commit-graph` files increm=
entally,
> >> +       then verifies that the written data is correct. If the new lay=
er has an
> >> +       issue, then the chain file is removed and the `commit-graph` i=
s
> >> +       rewritten from scratch.
> >> ++
> >> +The verification only checks the top layer of the `commit-graph` chai=
n.
> >> +If the incremental write merged the new commits with at least one
> >> +existing layer, then there is potential for on-disk corruption being
> >> +carried forward into the new file. This will be noticed and the new
> >> +commit-graph file will be clean as Git reparses the commit data from
> >> +the object database.
> >
> > This reads somewhat awkwardly. I think what you mean is something like
> > "is there a risk for on-disk corruption? yes, but no: we're clever
> > enough to detect it and avoid it". So from a user's point of view, I
> > think this is too detailed.

[snip quite a bit]

> Back to the point of your comments: I'm not sure this second paragraph
> is required at all in the documentation. The first paragraph already
> says:
>
>         ...then verifies that the written data is correct.
>
> This "written data" _is_ the top layer of the chain. There is probably
> no reason to dig deeper into _why_ we do this in this user-facing
> documentation.
>
> So, I propose just deleting this paragraph. What do you think?

Yeah, that makes lots of sense. Thanks!


Martin
