Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1362C43381
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806492311E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAFRBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbhAFRBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 12:01:40 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDAC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 09:01:00 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 81so3322328ioc.13
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fuJMsl4U3sh3pNQXgE0gs4kPuYcTtHBF8FpDXjMdhs=;
        b=n9OJk8k2Vty7kj0tHEAlm39nTMSo8qQXBLEC9MT8pA0+FabRS625X/VrrwTHgmy2Ox
         UOhwPyGK1rc76PgbGptWk0VIMGi9KEeuFhott1VJqhBKCgEFxRmDWZEgm41c8i5kqzpo
         RbLrX/kQVgoDjPtnwmHXAN8VieNxKJa6tBBSGNtss0DZBxs+UU/oEYAtCHmwuW8rSeXb
         r1i3FQgPBkJRLxPbDuu51/MnoBygcMVWYoT3U97h4/dBg073kv1+br++A/eFJjgDULYd
         7mxPBPViSG9GFMGfLXkhDVj00XACP7xgf+K4T4uNk9Epl9i1kqRmYKBImG/9hK86G1+A
         QU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fuJMsl4U3sh3pNQXgE0gs4kPuYcTtHBF8FpDXjMdhs=;
        b=ste1vFpHOPLvJZw7lmqwNv6IX9uNk65IBMlTD84OKNW5+a3gdCYNb2QZx6Ssjc9/bs
         f4cZjrvXGSgqIhvHB9T26155ZOjSpy+Vy/3WBHuQTq+nJwbHyj8hRG0M+fDZQrgIeQlj
         UANoxBqt/ZijevL6+31N1SY/IPHcM9UFKjbo6pOQxWtybZo4aKfiWRP+2tKkO7+yeG9v
         o+O6ybw8zpB57sCQ5Crq979HSxi+TWk6Biu6NHiuCr+djD0NjrPIxJPIXIJxEyVpaFkv
         JKgtl5WdK9iUv71vxJFEYmnx5So0xlYC0tOqWDvrbqqMNVtSLJ14mUQSaSMbONqjevOh
         8qKQ==
X-Gm-Message-State: AOAM531LW6gR9qISatJB9pOnM8a0AG788KE4nnLEUJVMcUSIhfsw+Mxu
        /WHhyEvYFiNy7Y8/MILKw3bwgmsnXOBNEHe4zseE6PUA
X-Google-Smtp-Source: ABdhPJwpSA1745B9NjT8R5kFp64HH/X3RWVUu7OwcbA8tGxLxQ5pnaJkgaN+WSTWKGtha2pWCb5Fq9eJFcpGa49KL6w=
X-Received: by 2002:a5d:9cd0:: with SMTP id w16mr3633979iow.2.1609952459992;
 Wed, 06 Jan 2021 09:00:59 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
In-Reply-To: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
From:   Jim Hill <gjthill@gmail.com>
Date:   Wed, 6 Jan 2021 09:00:49 -0800
Message-ID: <CAEE75_1fnvzOid-xfNOtd0eZfh_y8QizfLGAP_ceOeTQdJy2tg@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 8:18 AM Stefan Monnier <monnier@iro.umontreal.ca> wrote:
> create a new orphan branch with a new matching worktree

There's a much shorter sequence

    git worktree add -b new new $(git commit-tree `git mktree <&-` <&-)
    rm .git/refs/heads/new
