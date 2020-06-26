Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B1C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A442089D
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRXD+de6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFZV63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZV62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:58:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E10C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:58:28 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so9969138otr.12
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srxpKufT3KLsaRqmrifd457ScfM8kJf0wZcugjoQX+4=;
        b=dRXD+de6wUpLcj/p+QNZQmMGGBcTrdf6bYROEu4GkY6quJGEWTqrHn0xohWS0AcHcp
         6baOV/Cyovz3LhGLB9ZJo4gQUOtte0MRiGMs8mz/g3eSVlBxjZvILVbYcUNcZVZxmp8J
         1k7IzINseUuq3yUHGZKxifkRDQARTKBx+zKpGAD8Vy8OEzJ+ij5aoVey7H2nyjKZuM/v
         wPeVEM/qjPYKS7jpsXvwC2GK4UozqGg/nRz4KcbPKI81uuTND++MnoZX/EOD+AfwLxcJ
         BphRmstQNU/zQjl3BKaUvO0335cjWx5oJ1XCbYkvZm5Wa8xnDsB/eatRfS544s4kRXXt
         AJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srxpKufT3KLsaRqmrifd457ScfM8kJf0wZcugjoQX+4=;
        b=FSLC8zRi/250/YXOFaKtfoapYqh1pzikZJKVqBc19gnjGY5v/6yczrUxtAfk/306I8
         vT8jytFRH0alt6Kz7qUw7kPJjUcgZOM8QiWSzoFb1XmZRtQfJahULdFv6fQVSs0GpXtP
         OMzmzoO2lCS5kcFVUnQlqzaB9Hw2TIU4HuIeVkqTXkR5k6Ids83CZqYUMknCCd4ATMyA
         vtvHgXjVSIAkcRCqNYQkEIFilP8KZFH6RFW6pDMYE6URWdC3xN5g92oScVqS9GeULY67
         pvLllYd+SqomzwGy+vGCiZZVxsP9EuE8MN8KrAXv3qEJVLAGBglIAT0TfC24zDAm9P2O
         uddw==
X-Gm-Message-State: AOAM5305qNmVmHJ10y0SFAA+Tm7Ezhb064C8PYwwMjIf512IEBmwc5cy
        On8PDr6nETxvCEY20ctVdJ+zfF1plwcHga5Zl4U=
X-Google-Smtp-Source: ABdhPJwY5we47b/Jm7qJ+K26B00EHWGhhkzlj10OfFRj9oAu8XhNdW/s7G0Df+x64CK+UuWzqmUdeqhDCd4lkv/u6WM=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr4296761oti.162.1593208708062;
 Fri, 26 Jun 2020 14:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com> <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
 <20200626203539.GA1173768@coredump.intra.peff.net>
In-Reply-To: <20200626203539.GA1173768@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jun 2020 14:58:17 -0700
Message-ID: <CABPp-BE7y5YD4A+QTn-2Vu5aS8c_pzQ2096Y7GRqeOOSJKwJHQ@mail.gmail.com>
Subject: Re: Regarding Git and Branch Naming
To:     Jeff King <peff@peff.net>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Craig H Maynard <chmaynard@me.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 1:39 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jun 26, 2020 at 11:33:53AM -0700, Chris Torek wrote:
>
> > On Fri, Jun 26, 2020 at 10:19 AM Craig H Maynard <chmaynard@me.com> wrote:
> > > Does the git init command really need to create a default branch? Perhaps that step could be left to the user.
> >
> > The HEAD pseudo-ref must exist and must contain a valid OID or
> > branch name.  (If it does not exist, Git says that the directory
> > is not a repository.  Perhaps this test could be weakened, but
> > that's definitely a fairly big change.)
> >
> > In a new, empty repository there are no valid OIDs, so HEAD must
> > contain a branch name.  The branch itself need not exist, but
> > whatever name is in HEAD is the branch that will be created
> > when the user makes the first commit.
>
> We definitely _could_ extend HEAD to allow a "not pointing at anything"
> state. Presumably for reading that would behave like the "pointing at a
> branch that doesn't exist yet" case. But I think the experience it
> creates for writing is not very good. I.e., I think the best we could do
> is something like:
>
>   $ git init
>   $ git add some-files
>   $ git commit -m whatever
>   fatal: HEAD does not point to any branch
>   hint: use "git checkout -b <branch>" to make commits on <branch>
>
> Perhaps that's not _too_ bad, but it feels a bit unfriendly (and
> definitely more likely to cause backwards compatibility issues than
> picking _some_ default name). There would also be a lot of corner cases
> to cover and debug (e.g., "git checkout foo" moving away from the "no
> branch" state should make the usual complaints if we'd have to overwrite
> or modify index and untracked files).
>
> -Peff

The error doesn't need to come that late; it could come at the "init"
step when no branch name is specified.  If that's desirable, a
necessary first step towards that would be making a plain "git init"
throw a warning that we are creating a repo with a default branch name
of <whatever> since the user didn't specify one.

Of course, we could decide to only take that first step and never
escalate it to an error.  It'd still leave us with some default name,
but would de-emphasize it some.

Not sure if I'm in favor of either of these ideas or not, but just
thought I'd point out alternate possibilities towards
removing/de-emphasizing the default initial branch name.

Elijah
