Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhL1BNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhL1BNx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:13:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35FC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:13:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so67650971edd.8
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/sytOIiK0wOp710woxg8M8x2tWThHT6NQHSQmvDDMk=;
        b=mxb1MhslPJ3CcKg471NNsr5E8FJQmutDodZR0JQUBLtHSuQTDr0l75Fvn5QjNoJeU6
         2BdT8MVxi2GL57eJuyzqr/3VfzJR7RJiDUk+Kjwx/Jl0il8V/8AI9YoLDNXveyOoDJBM
         FUIfbWmNv8FUKfwi/nyZ5m/n9hhBHgfL1dj5yD5fwgRv/J6xS7D83Y7rTm2pdQ3BIzJ1
         AzK5S0pnLcappEPrIs8VEFhRqmG85VweCM0Hxd2Eek9HQGkfBluXSZHKDUTi8pxOz3W8
         YFCmUjHXdkIfjNsGd2saPYp1TerIaDH9JWjBSVC6AbpVxlUY9LVjHCyjDG4NIU/do0oy
         igbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/sytOIiK0wOp710woxg8M8x2tWThHT6NQHSQmvDDMk=;
        b=a3hWiOEunVqmSw0T6n3OQToVqDyfC6wiFP/JyxyTeXUFqhoA6N9VAxNF2eCNHeHsUb
         hg9FlwyyGCKxOIvKvwUiYfe3eFwIF216ypnEyAPba+IBTt5nbP1w8w2Ew/fLo2ZHC96d
         mnM9UtL02d5ZpfnP4JXZz745Vfo6mwSlor3J+e9hQLkbgCNjRgHXc+FqVhcMR6tbz2/d
         u8ZwuzhZH9fDqbdjpUezL4nwIZKzCjEwSDIJWhFb8W+GTJ9B+SgP7O8Y06bf7yOmBA53
         ykO09un80JOwMUGzQAvgze95tmqXujG2fY83emahCZ/radwrlewb2cmW5ShHaJlmfYXS
         q4qw==
X-Gm-Message-State: AOAM53140ARtd2kW1VKkaBXhGMEvKRcuZVkLtu6kgMV7gcrCwDvvzrXq
        AWYi7ayrwdgMNSG3DwbdQr4h5hLG3SdDBVBBDcU=
X-Google-Smtp-Source: ABdhPJymoQXNKXL5i718g7VKxhwD7Z9PR3Lr0o+DU+Jc7YBZxTdkFQuALgiDiWlKzL6qKwPsQAWr+bYaMgDhglOtdso=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr18589442edd.228.1640654030989;
 Mon, 27 Dec 2021 17:13:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com> <cover.1639509048.git.jonathantanmy@google.com>
In-Reply-To: <cover.1639509048.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 17:13:39 -0800
Message-ID: <CABPp-BFLNqLuJ8o_6YZDYgd=Ft+wc9EjBPX+RRzwAdASKSW2bw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Conditional config includes based on remote URL
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 7:25 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Thanks, everyone, for your comments. I've followed Glen's code
> suggestion and Junio's documentation suggestion, as you can see in the
> range-diff.

So, the basic idea is, in a setting like Google's, you can have users
install additional files on their system out-of-band, and have the
users specify a simple line in their configuration to make use of
those additional files -- or portions thereof.  It's a way of easily
providing potentially large blocks of pre-vetted configuration for
users.

Seems to make sense.  (and I've read over the code lightly, so feel
free to take this as an Acked-by.)


But can I back up and comment on a bigger picture item?

This mechanism requires somehow getting additional files to the user
separately; projects that span companies (git.git, linux.git, etc.)
won't likely be able to make use of this.

Scalar also has a mechanism for providing potentially large blocks of
pre-vetted configuration for users.  It does so as part of a new
top-level command.  And it does so with a very opinionated set of
values that are not configurable.  Thus, while I'd like to use it,
they use a configuration option that would break things badly at my
$DAYJOB.  (Too many gradle plugins using jgit, which doesn't
understand index.version=4 and will blow up with a very suboptimal
error message when they see it.)  And, it's very specific to scalar;
we probably don't want to add a new toplevel command everytime someone
wants common configuration to be easily grabbed by some user.

It would be nice if we could find some more generic solution.
Granted, I can't think of any, and I don't think this comment should
block this particular series (nor the scalar one), but I am worrying a
little bit that we're getting multiple completely different solutions
for the same general problem, and each brings caveats big enough to
preclude many (most?) potential users.  I don't know what to do about
that, especially since configuration that is too easy to propagate
comes with big security problems, but I wanted to at least raise the
issue and hope others have good ideas.  If nothing else, I want to
raise awareness to avoid proliferation of similar
pre-vetted-configuration-deployment mechanisms.  I'm CC'ing a couple
scalar folks as well for that point.
