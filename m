Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71104C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 04:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F72F60FED
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 04:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhHMEMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 00:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHMEMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 00:12:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A50C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 21:12:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b7so10216520plh.7
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+9dizbsv4OXBwctDz4X5vYZ0td9f/Wdd4TZhuqxDYA=;
        b=SYVuQbW+999+VJfos20zR/U/dkJ9afxf/mVharnopaH69N27W0rdXyd+pAQSd1mjeP
         pJTMmNmnYr5P8/5XqUvApX72xBGeayaPIN7DwJ2pXNOaLglQ0obY2Z9PBGN0b9z2naB8
         BFGltwUEYTs+UFlDlvj+SNXxp6UosvahjBxyUpmiUzIfrdMTJzdr3c3h6q7hvLrrjWPg
         ESuHreuY0OirA6tvN5fuBQiNsR3cuz2L0o1Vzl8/aCPvJaLcDf6qC+kcHI+28tIqD3Fd
         VkL+fYugnYnO7dwjydBPHfae2P/Zf7ECuXpkXXK4pkVflgzp00qIM7o5vqdMQBQgprPN
         wUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+9dizbsv4OXBwctDz4X5vYZ0td9f/Wdd4TZhuqxDYA=;
        b=AuLUiuzG9vEnHm0TeO2TtCoRLtv+sTs5Fnw3B8d8eSkkSN15ATo6IFOHjnM6YPMc1R
         3JMmqqi2RRB4gs0BgJhMbgzogQmjBKWg5GtvuxXPoY86KHOToVq8d5vbj87dXS8WAaEG
         usM9zU3iBouf5+sw1SiyHScHfJJkbbtaUA5On4QOrjKX2Q5Ls/8VqSDjU/QKzStNH4Yh
         QYw+NIVcnCzy89R/4D3Gqg9xfu9Y3G0JXIzgIPHee2CXR2/eD40bQcFtZhbArHifEg66
         adFZ9OSYtuf9Wc1zK+Im3kSX/BI/y3KkT887patzK44Ci4AHsLcO9IpECYtfdOlF9VTS
         isyg==
X-Gm-Message-State: AOAM532+BBJbliS0kldee64ldXQwf70PuZR/0hUi/2qAhRhNluYc1L2R
        L+mqg20xd+bNYx2hiKWZAdl+eNdBNxzhfW9ZHdpJhA==
X-Google-Smtp-Source: ABdhPJyoVxjwVMlwGcE4X1aYWQfLISJ9zsMTuVYzdnXaCl7yeyT7/XpVi09wk0ePqSKnO8P7TxyEX3DIbUCq+HGICns=
X-Received: by 2002:a63:f342:: with SMTP id t2mr488194pgj.45.1628827945985;
 Thu, 12 Aug 2021 21:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com> <xmqqeeaz70ph.fsf@gitster.g>
 <YRW0pGXXWnY7C470@google.com> <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com>
In-Reply-To: <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com>
From:   Mahi Kolla <mahikolla@google.com>
Date:   Thu, 12 Aug 2021 21:12:15 -0700
Message-ID: <CAN3QUFa3TRh9rvV3xS8XWd-dTvMqS=2j5Vhvp0wP33oPte9_2w@mail.gmail.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Thank you all for the great feedback! I'm learning a lot as a
first-time contributor :) I will be wrapping my internship this week
and will continue contributing externally.

> >>
> >>>
> >>> Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.
> >>
> >> This does not belong to the commit log message proper.  Noting the
> >> difference between the version being submitted and the pervious one
> >> this way is a way to help reviewers and is very much appreciated,
> >> but please do so below the three-dash line below your sign-off.
>
> Mahi, since you're using Gitgitgadget, you would put this "since v1"
> content in the PR description, and Gitgitgadget will append it under
> the three-dash line when you /submit :) (Do keep the CC's automatically
> added by GGG so that your next version is CC'ed to those that participated
> in earlier rounds).
>

Got it, thank you!

> >
> > It seemed to me that trying out this change on feature.experimental flag
> > was the right approach, because users with that flag have already
> > volunteered to be testers for upcoming behavior changes; this seems like
> > one such that is likely to be welcome. By contrast, turning the behavior
> > on with a separate config variable reduces the pool of testers
> > essentially to "users who know about this change" - or, to be more
> > reductive, "a handful of users at Google who we Google Git contributors
> > already know want this change". I recommended to Mahi that we stick this
> > feature under 'feature.experimental' because I really wanted to hear
> > from more users than just Googlers.
>
> I agree that we would not want yet another config variable that users would
> have to set. If people know about submodule.recurse and want to always use this
> behaviour, they already have it in their ~/.gitconfig, so they do not need a new
> variable. If they do not know about submodule.recurse, then they probably won't learn
> about this new variable either ;) That's why I suggested to Mahi that in any case it would
> be a good thing that 'git clone --recurse-submodules' would at least inform users, using
> an advice, that they might want to set submodule.recurse.
>

When discussing with the team, we revisited the feature.experimental
design. As we have yet to gain strong consensus on making this a
default config value, we've decided to ship it under a different
config value: submodule.stickyRecursiveClone. Now, if the user sets
submodule.stickyRecursiveClone=true, when they run git clone
--recurse-submodules, we will set submodule.recurse=true. While this
may mean a smaller dataset (only people who know of this flag), we can
still collect valuable data.

As for the advice message, I agree that would be a really useful
feature. I'll submit that as a different patch.

> >>
> >> Perhaps a separate (and new) configuration variable (in ~/.gitconfig
> >> perhaps) can be used as that opt-in flag (I wonder if the existing
> >> submodule.recurse variable can be that opt-in flag, though).
> >>

Unfortunately, the submodule.recurse variable can't be used as the
opt-in flag because this would cause commands to run recursively even
if developers don't have submodules in their project (aka don't run
git clone --recurse-submodules). That's why the alternate config value
seems a better choice at the moment.

Let me know what you guys think!

Best,
Mahi Kolla
