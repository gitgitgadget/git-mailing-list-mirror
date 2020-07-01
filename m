Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB7C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48D32073E
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofC88mRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgGAJ7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAJ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:59:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E7FC061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 02:59:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so19056565edb.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J9OGBzCmvUWTZe1dG/0B3uwbTCwMyq8O3IPyxLC8UNw=;
        b=ofC88mRxJlZeYnUAW6GxfpSt3FLhsvz1MpFaVGyaBwO/jjhHR+7NBAl6HNqnwB2PwJ
         aWZS2lwfVSWJX3ra29sn13nT+Vz3/Vt5JX4q+3ZEUNYLd6URv9u6/eczUHYh7/xc/Qxo
         5BblK7Cm35psZ9SF3bvTMmTdRvJ++4rc9hm2DdRzaMrH9mcaWW60buCF58VsZlMac4Ty
         7MQSeuEqGRSitotf7cg0JPTWKBPjdtYxJ7ycSUQkTVVFGIEAvIRbdEisp9IPed8AKNUv
         zV+sPBmsdNTX6A1ZpQr3e4uD0ZOictCAzemefOyHSyi2+NbnMmsEthD1zkamdnHhkKP8
         odTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J9OGBzCmvUWTZe1dG/0B3uwbTCwMyq8O3IPyxLC8UNw=;
        b=nEogmql+EDq0ER3NPco3hCSn58qOX/88RkXO1orOmqMulL+t7eQLeyLHL+UNal+T1K
         4l3Yk2Pm8BywFpcTiu8hu+RFbuAG2XwzDbtDawZ9NoAdrqgOY8RoebUJaZcUN0b3RbiB
         S+r98PLuKUrYsKhAMpO57psty8adFFt7gV5n149okHOQreFQDi/Y6bH/rRn/JpEe2lj5
         kqVWvtOVU8wyDzUfCv3mmGlU1Ce+hMf0jZKjX2sghjHYOQi3MQHYYXr4+Kxg/nKNIzBh
         th02iFBSWXTylPqaB25tFtf7MMqQLvK5Kod5z4Q589u0HzTwgHN4fBX7SsMpdEaj6/ge
         jqeA==
X-Gm-Message-State: AOAM532NY4Oj4N7G6ZMnv6jnJ64GM1tBx8lNyNlY8lowtwj+SKHEi7Dy
        zUFZ4spEWvNbNcOqN+6eB7eLy8YeYmLT4gaS0L84Px3e4K0=
X-Google-Smtp-Source: ABdhPJziNwEL6dwcYKNZ5NQE1nCayiZGVKPCAE+Ip8VOZFdCA/44vLX+rwAUrZVsC6jhXNA6Qf5fSyAM29OwEbWoZrE=
X-Received: by 2002:a50:cd1e:: with SMTP id z30mr27244995edi.364.1593597543573;
 Wed, 01 Jul 2020 02:59:03 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Wed, 1 Jul 2020 11:58:53 +0200
Message-ID: <CAL3xRKdZyE+9r-bPTDo_Fiz=nT_Y7uve+rvBqQZxjL-DYMGYpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
To:     peff@peff.net
Cc:     dstolee@microsoft.com, git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

On Tue, 30 Jun 2020 15:33:40 -0400, Jeff King wrote:

> > > It might even be worth considering whether "changed paths" needs more
> > > context (or would if we add new features in the future). On a "git
> > > commit-graph write" command-line it is perfectly clear, but would
> > > core.commitGraphChangedPaths be worth it? It's definitely more specific,
> > > but it's also way more ugly. ;)
> >
> > Here's a third option what about 'graph.readChangedPaths'. I think that
> > Stolee and I discussed a new top-level 'graph' section, since we now
> > have a few commit-graph-related configuration variables in 'core'.
>
> Yes, I like that even better. Probably "graph" is sufficiently specific
> within Git's context, though I guess it _could_ bring to mind "git log
> --graph". So many overloaded terms. :)

I would suggest using 'commitgraph.readChangedPaths' as I was planning on
implementing the same config in [1] but never got around to it.

From an end-user perspective, not server admin, 'graph' is very much
correlated to 'git log --graph'.

Using 'commitgraph' instead of core could also help us enabling more config
down the line that equate to the current options in 'git commit-graph write'.

I.e. something like 'commitgraph.writeSplit' might be desirable to tune the
behavior of 'gc.writeCommitGraph' to use '--split=replace' strategy.

---

@Taylor: Thanks a lot for implementing this.

On Tue, 30 Jun 2020 13:17:36 -0400, Taylor Blau wrote:

> We're planning on using these patches as part of a two-phase roll-out of
> changed-path Bloom filters, where the first phase conditions whether or
> not repositories *write* Bloom filters, and the second phase (controlled
> via the new 'core.useBloomFilters') controls whether repositories *read*
> their Bloom filters.

Could you elaborate a bit more on the 'two-phase roll-out' mentioned here?

I was looking for a way to verify whether a commit-graph chain has been
written with Bloom filter (and force it to rewrite if not) but there seems
to be no straightforward way?

Do we need to implement a flag in 'git commit-graph verify' to check
for Bloom filter existence?

[1]: https://github.com/gitgitgadget/git/pull/633

Regards,
Son Luong.
