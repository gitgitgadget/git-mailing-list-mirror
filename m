Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63176C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 00:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjBYA5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBYA5e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 19:57:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A914B4FA81
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:57:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n2so1326107lfb.12
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 16:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAoFlncshlQcwELxYyAA2KmKVbDU/33wo40SSlCAytM=;
        b=Q8DtDbsXy5cQ9SG+BxTkoDbzg+JKM2CTIq17H05uAvI6goUSrZlvwJXA0P+ciWyQg3
         yX7XtnyxGhuT5MNAqnYCJCMoxm4ITT04qC/Au7aJqZcUMOxu4xuGzB1KpsTfpxmXucTu
         Wlk941/0WAexsgZdVzF8+1QHc3E3H/pq10teWXqVsKU72JvRQVL7Z6A4VcbKYgGMcTUr
         jNdLdOC6MZe1VC7x4aX+fBMx+OHNNbVMYSh0tL/W+tuv0By1TupNZtnaRjqBM9mkgM30
         ccaK2OcMEUj7pE1t8qn7Gw+DaNd8ml5GaDo8lmLNaGDPvFZG86tPAhcV1ZW1weyRg0sj
         l+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAoFlncshlQcwELxYyAA2KmKVbDU/33wo40SSlCAytM=;
        b=4YbQ/pKOZFIgMPQvxwBGzVPOQvf8Tbktwa8sbDHzaqA4sLieJ4ZLzSDy3bTZv18I/D
         Dz6969v/9TW1liw8R3e4u8G/GhIqOM903LvIN5mBTLr5sBPlbXqtoCL/Lr5Wdm6/h93X
         cZGtIlu1XQf5XKid5EvY85Z6rEc3pzPzsb7N9hmusRRiAxChHrBsDHP6QO0dxsYY0g1G
         EKTNBbjXmdVv5w8ZHm42XRt7GHlcl6lEuoXp0P54+03blvw40EdhsHU2RXKctswaRzzu
         Q8MAfAprKuWzHz+4HC07u2ms2OjCDLKUdb4S2X5FcBDXr7CG1o9SFlheryGzEYhjVwEb
         yUAw==
X-Gm-Message-State: AO0yUKVlNBpRksl4fXpw38SAC2w0z8/MgNQWzOiezDHi+oDBi0Q79Ugq
        7MXg+DXUKiwqKzilRu/HN/VmtQkF5FuEYnPN6rs=
X-Google-Smtp-Source: AK7set/UtUO/vQwlEyHu29jS/9cgRNz/0WAiKpNMxKdQ6xEflj3nKOgOxlis4au7p5yeahJ1S46Jwx6IAuRvqyz+5AE=
X-Received: by 2002:ac2:5387:0:b0:4d5:ca32:7bbb with SMTP id
 g7-20020ac25387000000b004d5ca327bbbmr5469994lfh.2.1677286650837; Fri, 24 Feb
 2023 16:57:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com> <20230225001023.2047457-1-jonathantanmy@google.com>
In-Reply-To: <20230225001023.2047457-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 16:57:18 -0800
Message-ID: <CABPp-BEqPrrQAp=YbjS-=8Cdat4fFCrhs+yrk1TBWrRY3t93Tg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Header cleanups
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 4:10 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This series cleans up headers a bit, trying to remove excessive dependency
> > on "cache.h". I created this series a while ago, but decided to clean it up
> > and submit it due to Emily's recent thread and suggestion that this might be
> > helpful to their efforts[1].
>
> [snip]
>
> > [1] Search for "Extremely yes" in
> > https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/
>
> Thanks, the series looks good.

Thanks for the reviews!

> I especially appreciated the separating
> out of alloc.h and moving function declarations to the .h of the same
> name as the .c file their definition is found in.

There are several more cases where we could do this, but my series was
already long enough and I wanted to get it reviewed (and make sure
others agreed with the directions) before adding more.  I'm glad you
like this direction, since I'd really like to move more things this
way.
