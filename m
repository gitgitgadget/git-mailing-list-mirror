Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEEFC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE99214DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 06:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOIOxM7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA0GqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:46:20 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46923 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GqU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 01:46:20 -0500
Received: by mail-qt1-f173.google.com with SMTP id e25so6570233qtr.13
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 22:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Kzr03U4ihuKzzKBh/y4uc3eFbyefE9LZri29b67G9zU=;
        b=IOIOxM7G330+gFQj9Yplr1guWUVjxMECPBTJF4UwNzYq3NczyoQorUvtYcW5mwxSo7
         rfHCfMqscwxfi1fuoJ8eP++2T/UpD2F2+EzCCzweHJxBSsR5nPTJWxeN1+3FIll1a47Q
         +bIgQqRzgYGV9t3H48k7j1EVB+0d+51PaWrO3hjtZOn7hB1xRtNQQbpirupbzoGhXflq
         4VyiAPiwi4d/SiIerKzJcTf+yyjV5j3Wq/cICfLk4FT8xUd04UvTZUwn3xE6ECkrk7eU
         AzXcDGkbdJ3twHzZuB6Y7sghLmBR4vV9Ab+4JD0vmathxmwUzYhTUZdonnvptyRbcQk9
         jnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Kzr03U4ihuKzzKBh/y4uc3eFbyefE9LZri29b67G9zU=;
        b=EC9VL6TA4z3FxRN74XgyQoCuPo30m4xRE9YpJleoVB+Z8X1ev5xDyNXbEK8b0C+xDf
         wdSmar4IJ6v5VekrY//nKWpIoY+mn/UiGLFDjzLyzzsZtAkBDyW1ABfAT1c6Qv+kyv7i
         AD+boe1Bw8beTBuuRYvYvSqCsnjVdZ5/l+KoKRibewXWUfkCz0yNpW9nYrF0CCVDRZIw
         74MuK+VLitvcBcuWPizhYsaTNNw4RS0CzG6wQMfydJO0mHAAPAAYwskOd3pJtScO65yj
         pgvzIEUAgk3lLoXkisXx5V8ifnkGJh0Q/ys11Z/oo74F1Pk1YFi5TZVsa3caTuEcMxrZ
         cQUA==
X-Gm-Message-State: APjAAAUbeHYOLmPIZtRtAB9Iku8eV0nwY5LLoAC89xBkTYkXBeE4npt4
        UJHyxgYl8TbPTP2qvWQh/bCsMOK2cxLnor/Ta9k=
X-Google-Smtp-Source: APXvYqzSoZM99WEKYnrg+OXV5uJ9EsH45idk69chCjOtEOfll5+ECms12nuEyhjDfKMvi6Yh9GjghQts7CfYEtZM4GI=
X-Received: by 2002:ac8:410f:: with SMTP id q15mr14307239qtl.192.1580107579210;
 Sun, 26 Jan 2020 22:46:19 -0800 (PST)
MIME-Version: 1.0
References: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
 <20200127055509.GA12108@coredump.intra.peff.net>
In-Reply-To: <20200127055509.GA12108@coredump.intra.peff.net>
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Sun, 26 Jan 2020 22:46:07 -0800
Message-ID: <CAOTb1wd9D3YytevTt0cGnw1o-9cN1-yxCqbuH4oLH1KB6mzEeA@mail.gmail.com>
Subject: Re: git-clone --single-branch clones objects outside of branch
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 26, 2020 at 9:55 PM Jeff King <peff@peff.net> wrote:
> On Sun, Jan 26, 2020 at 04:39:52AM -0800, Chris Jerdonek wrote:
> > However, when I attempted this with a local repo, I found that objects
> > located only in branches other than the branch I specified are also
> > cloned. Also, this is true even if the remote repo has only loose
> > objects (i.e. no pack files). So it doesn't appear to be doing this
> > only to avoid creating new files.
>
> This is the expected outcome, because in your example you're cloning on
> the local filesystem. By default that enables some optimizations, one of
> which is to hard-link the object files into the destination repository.
> That avoids the cost of copying and re-hashing them (which a normal
> cross-system clone would do). And it even avoids traversing the objects
> to find which are necessary, instead just hard-linking everything.

Thanks for the reply. It's okay for that to be the expected behavior.
My suggestion would just be that the documentation for --single-branch
be updated to clarify that objects unreachable from the specified
branch can still be in the cloned repo when run using the --local
optimizations. For example, it can matter for security if one is
trying to create a clone of a repo that doesn't include data from
branches with sensitive info (e.g. in following Git's advice to create
a separate repo if security of private data is desired:
https://git-scm.com/docs/gitnamespaces#_security ).

I'm guessing other flags also don't apply when --local is being used.
For example, I'm guessing --reference is also ignored when using
--local, but I haven't checked yet to confirm. It would be nice if the
documentation gave a heads up in cases like these. Even if hard links
are being used, it's not clear from the docs whether the objects are
filtered first, prior to hard linking, when flags like --single-branch
and --reference are passed.

> This one behaves as you expected because git-fetch does not perform the
> same optimizations (it wouldn't make as much sense there, as generally
> in a fetch we already have most of the objects from the other side
> anyway, so hard-linking would just give us duplicates).

Incidentally, here's a thread from 2010 requesting that this
optimization be available in the git-fetch case:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=573909
(I don't know how reports on that Debian list relate to this list.)

--Chris
