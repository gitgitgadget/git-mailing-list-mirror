Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF782C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A989C64F8D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbhCDV1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbhCDV1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 16:27:23 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB5C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 13:26:42 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t9so6018661ljt.8
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZEzSwkUkQFo4P9897DCXPA79dxTchPQPdrb5qidPN8=;
        b=hf1Lv82Pnix2AnixF8J1RjKJtcdOu1ZtZQ7TOuM8IIbTZkcUBDHOl0eTCpUHQvEI0a
         Ywh66cNz7dVHUrMpMh6upl2LotgwFHn0SeMQxvSzDL4bJXk0K5cqtZo2/jaUWdFhhgFl
         6zlwCi1OZkgoNG6AYXHsFHrfztWfw0NCTrurmlmQaF7g3T2rmgnF7OFO4KxeGjmOk1eu
         GEpA1flAF911HNAUZSycAcmsfnfLEGkwaiG/7xJTtA+kRait1bNwCt6PbsYfHJYzZgQo
         IIkGbetxd2bxVSx08dmyn71iIyiPvFxcK2Bxsu8otacyI+Axc7cTemKBteTv89QtiNim
         TnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZEzSwkUkQFo4P9897DCXPA79dxTchPQPdrb5qidPN8=;
        b=oqIn9Bh7Uo4FCLD9Cic0PuBui7Wjr/K5/UHDsvxqadVL3Of78CKUk4CO0mskTEb06p
         zIsKkRoR0qus+nJPgVl6EyhuPvvAFaPmiDODaVaTREMm/0rIRsjAssuASOIWWxnhApQk
         /j1/M+IHuwT8XJH8KjpVYYHHQiytH4XUto0uO3odDnFKY40rIt+kTfdRRz4mJ5PG86dH
         5MihhGi09aL/u+lSJLQVzlXrVa27XNiIbAPoxwBM4D1YCI1rb348OaXJD+Wuwrgkk2Hk
         9fevU2ZvhppgtZmgyS/KyjqmGQmPTa+4c8gu5tGLt5Jf+kosdcD0e3kaS4wvJiBVCLQb
         8DIg==
X-Gm-Message-State: AOAM531ZQip3EWIKDAkVlH8rlay3AhT/Vb15zVLXXladYGwPQOBJLQXA
        Vpiu9JfvqLeR7T7d369lpSUMB38KHAHALxYj7ehmEw==
X-Google-Smtp-Source: ABdhPJx4r6jGS69JO3W3YJSCnh8ylVETqKM7NlZnwPq+VYP++6ZP1Fxs2gbcnETzzb+2NR1K/+eECK1f/tec/wnRR+Q=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr3367023ljg.291.1614893201368;
 Thu, 04 Mar 2021 13:26:41 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
 <20210304152315.18498-1-matheus.bernardino@usp.br> <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
In-Reply-To: <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 4 Mar 2021 18:26:29 -0300
Message-ID: <CAHd-oW4+4ccgLjoKqygSzqZXgk7Ljhe_ovSVSsJoJv=4kyv1eQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 2:22 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 7:23 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > On Wed, Feb 24, 2021 at 3:50 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > Hmm...here's an interesting command sequence:
> > >
> > > git init lame
> > > cd lame
> > > mkdir baz
> > > touch baz/tracked
> > > git add baz/tracked
> > > git update-index --skip-worktree baz/tracked
> > > rm baz/tracked.  # But leave the empty directory!
> > > echo baz >.gitignore
> > > git add --ignore-missing --dry-run baz
> > >
> > >
> > > Reports the following:
> > > """
> > > The following pathspecs only matched index entries outside the current
> > > sparse checkout:
> > > baz
> > > hint: Disable or modify the sparsity rules if you intend to update such entries.
> > > hint: Disable this message with "git config advice.updateSparsePath false"
> > > The following paths are ignored by one of your .gitignore files:
> > > baz
> > > hint: Use -f if you really want to add them.
> > > hint: Turn this message off by running
> > > hint: "git config advice.addIgnoredFile false"
> > > """
> >
> >[...] Perhaps should we just rephrase the sparse warning
> > to remove the "only" part (and don't try to avoid the double warnings)?
> > I'm open to any suggestions on alternative wordings or ideas :)
>
> The only thing that I think was problematic about the double warning
> was the contradiction between them due to the use of "only" in the
> first; if we remove that, I think printing two warnings is perfectly
> fine.  So, I'm in favor of just rephrasing as you suggest.

Ok, let's do that! I may be overthinking this, but would it be enough
to say "The following pathspecs match index entries outside the
current sparse checkout"?

This is not wrong per-se, but I think it doesn't sound as informative.
I mean, another add/rm execution could also have pathspecs that match
sparse entries, and yet no warning is displayed because they also
match non-sparse entries.

I haven't thought of a better alternative yet, but I was considering
something along "The following pathspecs won't update any paths, but
they match index entries outside the current sparse checkout". (The
idea is that "won't update any paths" include both pathspecs that only
match sparse paths and the ones that match both sparse and ignored
paths, as neither will be updated.)
