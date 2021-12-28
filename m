Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA03C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbhL1XNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbhL1XNT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:13:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA931C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:13:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id h33-20020a17090a29a400b001b20b7d48dfso12882094pjd.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/S+BQxCVfGdUM38cCsYCOopoImO7a8TN66X1ZToM8A8=;
        b=RvtgSa4MuOd8CkfTk+Bl6hIqepCGSJCa6cag7VVbOwGmB/a1pwywrzxv2+KS8cE76z
         7XF4cIYPEId6PLQY/CXE/WRU2NfiE8uXczzGWD/DqLVaRDjB0eGAZ5bmbpqTQmJJq4vF
         nrYQP7xHkOLK+enaB59xy1+xMQ4Li6mLdiW7iJpcmQbliLixin2MqnTiu1GJPAi04AO6
         RRgInfyo1AzhIGJk6pt1EWQDYERR90LKyzJvHoDq/QzTMsE3aCvcKdDWNhuA9Y01ggO6
         08sBJ293jr8i24N8P8beKshAnHh7m5DU3i6EEXTqcdfDPMtPuB2ptu0Aqa/8ctM/2tNK
         6vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/S+BQxCVfGdUM38cCsYCOopoImO7a8TN66X1ZToM8A8=;
        b=bM8lBI+Ogdj163zruqhFKqSsu6UoXS8IQDc/AMmc4SMXXxMt9pNCNGX7843+3aZk2I
         X9kse8fgGo1jcA9os5zb3eGl68YuI+bQIoFMg6ZgcTUiF1T+dW3HzyFrhr8UXbB/zxJy
         UbZZi+oYKjR0tAYZAQ8KpIPtd+5Azn6FOo9EC8FTgCI+VUBAPXd3VvZFsTNNqH2HGD9c
         qtRunbOjBY0AhyuHk4tYP8YUJO7zG2W2LSOO6mfctIsFyNhKn0zsmdF5o4Hmmuwwd7Tb
         AsGVdT1IYodUBMzcTSvUYSAXGE+zhe+0osuoVBjkMJPotgzzWy/KhqrbJcNoN9LtcyeG
         Cdug==
X-Gm-Message-State: AOAM531uCR3OzzM9NruhykeSb8M/8mdt5r314Ht/diwxkGXsYFFaEImG
        wu2whQc5GPIRWuChKaA/50IIBG/07wsURA==
X-Google-Smtp-Source: ABdhPJzuVg9sxXQVbjwFaG3V0sCrpQ8GFXvmVBi9KZDHpBj+H2Ck623cAaZE5GJq3LECPqUOU+eRbVA+EHr36Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ce04:: with SMTP id
 f4mr29111593pju.10.1640733198346; Tue, 28 Dec 2021 15:13:18 -0800 (PST)
Date:   Tue, 28 Dec 2021 15:13:07 -0800
In-Reply-To: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
Message-Id: <kl6lee5w5nng.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1639509048.git.jonathantanmy@google.com> <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Conditional config includes based on remote URL
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But can I back up and comment on a bigger picture item?
>
> This mechanism requires somehow getting additional files to the user
> separately; projects that span companies (git.git, linux.git, etc.)
> won't likely be able to make use of this.
>
> Scalar also has a mechanism for providing potentially large blocks of
> pre-vetted configuration for users.  It does so as part of a new
> top-level command.  And it does so with a very opinionated set of
> values that are not configurable.  Thus, while I'd like to use it,
> they use a configuration option that would break things badly at my
> $DAYJOB.  (Too many gradle plugins using jgit, which doesn't
> understand index.version=4 and will blow up with a very suboptimal
> error message when they see it.)  And, it's very specific to scalar;
> we probably don't want to add a new toplevel command everytime someone
> wants common configuration to be easily grabbed by some user.
>
> It would be nice if we could find some more generic solution.
> Granted, I can't think of any, and I don't think this comment should
> block this particular series (nor the scalar one), but I am worrying a
> little bit that we're getting multiple completely different solutions
> for the same general problem, and each brings caveats big enough to
> preclude many (most?) potential users.  I don't know what to do about
> that, especially since configuration that is too easy to propagate
> comes with big security problems, but I wanted to at least raise the
> issue and hope others have good ideas.  If nothing else, I want to
> raise awareness to avoid proliferation of similar
> pre-vetted-configuration-deployment mechanisms.  I'm CC'ing a couple
> scalar folks as well for that point.

Yes, that's an accurate description. To reiterate what Jonathan said in
his first cover letter [1], the primary motivation is that we want to be
able to 'suggest' hooks to users. There was an RFC for this
'remote-suggested hooks feature' (docs [2], RFC implementation [3]) but
it ultimately stalled due to security concerns I believe (this was
before I joined the team, so I'm not the most familiar with this).

It might be worth re-reading those threads since they tread on pretty
much the same ground of shipping pre-vetted config (this is directed at
me too, since I haven't read through those in detail). I've also been
told that we're (aka Google) still looking for feedback on [2], so feel
free to share any thoughts on that thread too.

[1] https://lore.kernel.org/git/cover.1634077795.git.jonathantanmy@google.com
[2] https://lore.kernel.org/git/pull.908.v4.git.1620241892929.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/cover.1623881977.git.jonathantanmy@google.com/
