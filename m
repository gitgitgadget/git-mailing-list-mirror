Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BD9C38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjATGmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 01:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjATGmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 01:42:49 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD7CA04
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 22:42:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e16so4557680ljn.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSpik7PhuhjuVMvJQB2vF6d45dj+tqr3GTsRwrcLJp0=;
        b=LfROdpjfbQOfhGoO/5dlghDkN0Fa60ras1Rv8F+Fc6S47S6Q/XXORwuAX2MpRZ20eR
         6v4zre7ojiY+gnlkx4TZ6phuQ0pEjJA/nGwK8BpZc6tyaAdpciuCJt3v35Rx7on9dcLf
         bJ+9WNJLnF56km6hwaztbprUAvG5h1SdpKS7uXWqbipuLlZJjNTBy6O+dY7Wys19qAei
         kKmrMBmB88Q7jK3ITesvu24FgqKswXvH9fRH7GWDIKmN0QyHgVXQmhGTTfimVjbTFEo/
         D/uWx8VEKDDFZoInnjQwU1iSdmXPiyXL6I43IFlYP5dO6tQiasyNKxw1nib8d3MOvJt9
         KLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSpik7PhuhjuVMvJQB2vF6d45dj+tqr3GTsRwrcLJp0=;
        b=Cp2NQ9WDWrePFa6tQm01Z0P/gJzEYRxeBNIZzTrJ1tLZUPrN6D+2l7u2dODMvn+6TS
         LjwY0nX6yOoV2joCF6ABcsOYEBSNUrodilnt55pSCV73WbYXw2qjVrwhIKFic3vPNlUp
         uETUkZqT+++JaWuC84PoEMd13MrbE/pSN4/CBGiYXqDBdsNS3PwF6QWP7Jj2zbWzFgDd
         28viX/XihlcApH2ayc3Sb/eUq1a8gXPDeJImMfcGCqF8knQw/SJPxaD+2Czjct3f7FmM
         m/GwZWdAxlM4cM1eOY4UNVtqPZAtD8B6VZrAZHQYfTOhQv+VV2FenhRUh7swVJnoAaPh
         n7lw==
X-Gm-Message-State: AFqh2kp9hRq2kkZhh3pfRiVOiF8Bw3T0mP0/EozUvuM7V//dOBR5bL3u
        lm/fa0SBQphxL5MuJwKH9fd0vhaqDKA4iFOHfbo=
X-Google-Smtp-Source: AMrXdXv6STTELIuDXyXZvfRZgW4XJyx+rE2f2INBreHEie7mMa2/W2AgDwopA24VA+fvTM/TEmYB7wR5duE3ixsXko8=
X-Received: by 2002:a2e:9d99:0:b0:27f:e221:293c with SMTP id
 c25-20020a2e9d99000000b0027fe221293cmr1275518ljj.163.1674196965991; Thu, 19
 Jan 2023 22:42:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
 <CAPig+cQj4Gi+ikkPz3wffqGZVz5uALGzYV25nio3k4+cthP9Uw@mail.gmail.com>
In-Reply-To: <CAPig+cQj4Gi+ikkPz3wffqGZVz5uALGzYV25nio3k4+cthP9Uw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jan 2023 22:42:32 -0800
Message-ID: <CABPp-BHCKweQR=i8sZx2Nrh3YTXCThys7=EeN+jsxvLb=L_KVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2023 at 9:40 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 20, 2023 at 12:14 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The `-C` option to rebase was introduced with 67dad687ad ("add -C[NUM]
> > to git-am", 2007-02-08).  Based on feedback on the patch, the author
> > added the -C option not just to git-am but also to git-rebase.  But did
> > it such that the option was just passed through to git-am (which passes
> > it along to git-apply), with no corresponding option to format-patch.
> >
> > As per the git-apply documentation for the `-C` option:
> >     Ensure at least <n> lines of surrounding context match...When fewer
> >     lines of surrounding context exist they all must match.
> >
> > The fact that format-patch was not passed a -U option to increase the
> > number of context lines meant that there would still only be 3 lines of
> > context to match on.  So, anyone attempting to use this option in
> > git-rebase would just be spinning their wheels and wasting time.  I was
> > one such user a number of years ago.
> >
> > Since this option can at best waste users time and is nothing more than
> > a confusing no-op, and has never been anything other than a confusing
> > no-op, and no one has ever bothered to create a testcase for it that
> > goes beyond option parsing, simply excise the option.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Is there a chance that this patch could break some existing tooling or
> someone's workflow or alias?  If so, perhaps it would be better to
> continue recognizing it, but as a proper no-op? That is:
>
> (1) continue accepting the option but mark it PARSE_OPT_HIDDEN or some such
>
> (2) completely ignore the option
>
> (3) in case someone runs across it in some existing script or example
> and wants to know what it does, leave one mention of it in the
> documentation, such as:
>
>     -C<n>
>         Does nothing. This option is accepted for backward compatibility
>         only. Do not use.

If an option becomes a no-op over time due to other changes, this
would likely be the route I'd lean towards.  I'm just not sure it's
merited in this case.

We already turned numerous no-op choices in rebase into errors with
commit 8295ed690b ("rebase: make the backend configurable via config
setting", 2020-02-15), where we started pointing out that apply-based
and merge-based options were incompatible (as opposed to silently
accepting competing options and ignoring ones not supported by
whichever backend happened to trump at the time based on the options.)
 So, there's recent precedent to jump directly to errors with no-ops
in rebase.  Those cases are slightly different in that options were
only conditionally no-ops, whereas in this case we have an option that
is unconditionally a no-op, suggesting we might be able to do
something stronger.

On top of that, I just can't find any evidence of anyone ever using
this option: (a) it was only put in as an afterthought by the original
author (who was only really interested in git-am -C), (b) there are
absolutely no testcases in the testsuite covering its behavior, (c) my
searches of the mailing list and google don't turn up any hits though
admittedly it's hard to figure out what to search on, and (d) while I
tried to use the option at times, it was only because I was doing work
to make backends consistent and switch the default one and trying to
understand all the inner workings, and even then I gave up on it and
punted it down the road.

And, of course, the option never worked as advertised anyway.

That combination makes me think nuking it would go completely
unnoticed outside this mailing list.  If others would rather see the
more cautious route despite all the above, I can implement it, but
likely alter your step (2) from ignoring into throwing an error
message (or at the very least a warning).
