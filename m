Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3462C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90525206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUhAfvkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgFJUM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFJUM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:12:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DCFC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:12:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e5so2735154ote.11
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyS6YigYyPKXz9d+K4jypPwLt4EzP9v7gDRDNiIJhNg=;
        b=XUhAfvkI2HmLrnMkIhIUf1iwTpgoaOuOjC0e+sAsnmQxdzxGmkuAcNykdSDtG/gYtM
         kBm3dU9jUcEI5/EUlJdKtTP93ucZDrxep0wI3sNKW3ZAm5yFlWecAuby7qHV7ZAsluh+
         0vaYFUWOK2Px2P77/3pqnVM3K+ZjNVkRZsLzii7WRRLgb5Tr42QsgN2Tn5WM5MWzEcD6
         39kqiLqpxUImJ+AlpcqOKkxwF9+MDEqkAiq3EH1ciABSUbQLVOLHw2bryJzdN+cyW//G
         ISW2JojtzkoyfBZvl+cF8JkGWooobcnf009ep47647q2tvgiJ8emhP9vrnwXmN/KJlCU
         qpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyS6YigYyPKXz9d+K4jypPwLt4EzP9v7gDRDNiIJhNg=;
        b=CEkoHJXJhanSV3htYIVR0/X559h8gS4Eic7VPbNvUwi3DrVMrOLKIfEWIZiLBHso0P
         zmCPFcAWpi+ablrdnqJTPNy6tHnpKVfEcXQRoNUbnhsiFgpK+drUH30/oUWiAwV9CjWH
         b0srHjnFYb6SfZQFe+BV2BVC5HY4iVwBayX3pBCIbgt5YeLnKW4+aJS7P+YIGfGZ+tIB
         CXFLlvO85RlV5ylIeY6l3iP4n+mAr4Ai4K0aRFRrol6Eve22rdxYlk9yXIh0JKiGihtY
         +rUSuXKmGZRk460NGN4vR+4wqyG9cqPtHPd7VJ3GswZidRP83BUMcvnHzGfGKF5JIb2r
         bXBw==
X-Gm-Message-State: AOAM532SiQkmKErKa6fugLqlmdY8drDtN6y+ZSlB4kiJeRcJ60rDZwA7
        dbhK2tE0GnPF/IczEJ2FucIY727harRiA0ay5cw=
X-Google-Smtp-Source: ABdhPJwdcjcNKBNNFAL30mvwxY4gCiameB/q36cYjn9LM7Qd9FCU58p5PZgEUi3s1o3+JAKIVqPN6e3wcHPWKkrqu/s=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr4149230oti.162.1591819976956;
 Wed, 10 Jun 2020 13:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
 <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com>
In-Reply-To: <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Jun 2020 13:12:45 -0700
Message-ID: <CABPp-BFW7iXwG20h15=DJJCsaRCPbB3fmXicvxGie1aTtHW4Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 9:23 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Wed, Jun 10, 2020 at 8:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 5/22/2020 10:26 AM, Elijah Newren wrote:
> > > +This may mean that even if your sparsity patterns include or exclude
> > > +submodules, until you manually initialize or deinitialize them, commands
> > > +like grep that work on tracked files in the working copy will ignore "not
> > > +yet initialized" submodules and pay attention to "left behind" ones.
> >
> > I don't think that "left behind" is a good phrase here. It feels like
> > they've been _dropped_ instead of _persisted despite sparse-checkout
> > changes_.
> >
> > Perhaps:
> >
> >   commands like `git grep` that work on tracked files in the working copy
> >   will pay attention only to initialized submodules, regardless of the
> >   sparse-checkout definition.
>
> Hmm, I'm a little confused by the "regardless of the sparse-checkout
> definition". The plan we discussed for grep was to not recurse into
> submodules if they have the SKIP_WORKTREE bit set [1], wasn't it?
>
> [1]: https://lore.kernel.org/git/CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com/

I flagged some issues with that sentence...and an additional issue in
my original sentence besides the one Stolee flagged.  It seems to be
easy to mess up a simple summary here.  :-)

But I do want a simple summary of some sort; I want
Documentation/git-sparse-checkout.txt to be an end-user guide and not
an implementation spec.  Perhaps I can bring up a simpler example that
will make it easier to see my distinction between the two -- let's
consider the case of unmerged files.  I think all of the following
statements are true, but some are meant strictly as implementation
details of relevant subcommands, while others are deduced overall
behavior observed by end-users:

* If you just ran merge or rebase and have some files with conflicts,
'git grep searchstring' will search the conflicted files for the
searchstring
* When searching the working tree, git grep should not do any special
checking for whether files are in a conflicted state
* sparse-checkout will never set the SKIP_WORKTREE bit on an unmerged
file (despite sparsity patterns)
* sparse-checkout will delete all (regular and symlink) files from the
working tree when it sets the SKIP_WORKTREE bit for them
* sparse-checkout will not delete files from the working copy if it
doesn't set the SKIP_WORKTREE bit on it
* When merging, if the merge machinery notices a conflict, it must
clear the SKIP_WORKTREE bit and write the (conflicted version of the)
file out to the working tree.  (It is also allowed to clear the
SKIP_WORKTREE bit for files that are not conflicted, though we'd
rather it didn't do that so much.)

These statements above are not incompatible, because some deal with
the implementation of git grep (the second item), others deal with
implementation details of other commands or machinery (all items after
the second), and the first item deals with the combination of
behaviors between sparse-checkout + merge machinery + grep.

So, even though the first bullet point says "git grep...will search
the conflicted files" that does NOT mean git grep should check for
whether files are conflicted.  My proposed update in v2 that I'll send
out (once I come up with one) might use similar broad brushes.


Hope that helps,
Elijah
