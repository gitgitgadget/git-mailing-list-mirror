Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64243C38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 03:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3955320782
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 03:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnf2cHro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgDUDI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgDUDI6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 23:08:58 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3274C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 20:08:58 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j16so10818656oih.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UML+eBfMD+blOfVltflS64x/viGPpZhtx3IfNeiqVQ=;
        b=jnf2cHrovxNKfSNNyJYXZSKCN4NeEvmkKngghsa0zAETyG03PdxTqwAZbIz0PbJydM
         wy46pdIixSmY3prM/5spIis8stS3rIUeDSiRscKDaQFs9t2rvXAATCE/3rQUI7lwAt7i
         95Yn2PJK81s2CRF3EjtZF8uYl+RRcKipFWQsyFSNqcqGo2Hcjif6DpkDXnR3Dp5OBz3M
         k/CD+qkaT5rrj725FuPQZrldCOes9t99nwG/ra+KgN87xQCc0LrrcKAuGOJImo6jCkjY
         Lr7mXh4zVPCQvaodhguugpzM/LBiEjqfPjZHEAUYBTB8hwzQL06FfIs8Zf4myZQHErfZ
         6Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UML+eBfMD+blOfVltflS64x/viGPpZhtx3IfNeiqVQ=;
        b=pj2CyLa8uphy/RHN8oGwLPJjfrI0K7wS/qJB7dh7I37FNEFdO21mqtrZPCDeVgm4Fu
         xxZ5WruDeeoZeqtb/Hz0e8LLG7fwmun5l8F73NPWGdiEnN7Tqx5AiHoMbPb2FZECgEpw
         wR36/TfDJdVwAPEiGjDJw0Y4XCRs909TSFwQAfxmhc3WIAEN4LlijWY3JGXuF4aEhIEY
         HJeb5iKAFxFUDv1JlTEoYPjnFRbCdswg9rxLPH9bRHnXtjnp5sbYiO8IJJo7bskjVLFq
         5JMWIw1r9iV/PNvf738+mlTpf/2WbjsQKdwRBuYorWx0B2IlAxkMXIOn2GxL3xQZehmW
         NM4w==
X-Gm-Message-State: AGi0PuYIwJgDxPCZJNXiAWCQpz82OxCDaqHLa17WBzE4ZevMDMKUXcqP
        uwMpftvbQgCGpy59R4AixCS/Hwxab055Adjk5jA=
X-Google-Smtp-Source: APiQypIEqWexJhHh/LE9O2EIDBS47RcGjQc7Mn3AngGjqKn52YdBS0bZ5oT50+FAHrCT3DRihTX7vXjRlu6Qu3ZvgL0=
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr1840973oii.167.1587438537966;
 Mon, 20 Apr 2020 20:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
 <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com> <CAHd-oW6PQNC-ZFj6ydbHFzfL4KpSwXVSd8s3H429tOiRgSra8A@mail.gmail.com>
In-Reply-To: <CAHd-oW6PQNC-ZFj6ydbHFzfL4KpSwXVSd8s3H429tOiRgSra8A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Apr 2020 20:08:46 -0700
Message-ID: <CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 7:11 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, Elijah, Stolee and others
>
> On Tue, Mar 24, 2020 at 7:55 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Tue, Mar 24, 2020 at 4:15 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> > > <matheus.bernardino@usp.br> wrote:
> > > >
> > > > Something I'm not entirely sure in this patch is how we implement the
> > > > mechanism to honor sparsity for the `git grep <commit-ish>` case (which
> > > > is treated in the grep_tree() function). Currently, the patch looks for
> > > > an index entry that matches the path, and then checks its skip_worktree
> > >
> > > As you discuss below, checking the index is both wrong _and_ costly.
> > > You should use the sparsity patterns; Stolee did a lot of work to make
> > > those correspond to simple hashes you could check to determine whether
> > > to even walk into a subdirectory.
> [...]
> > OK, makes sense.
>
> I've been working on the file skipping mechanism using the sparsity
> patterns directly. But I'm uncertain about some implementation
> details. So I wanted to share my current plan with you, to get some
> feedback before going deeper.
>
> The first idea was to load the sparsity patterns a priori and pass
> them to grep_tree(), which recursively greps the entries of a given
> tree object. If --recurse-submodules is given, however, we would also
> need to load each surepo's sparse-checkout file on the fly (as the
> subrepos are lazily initialized in grep_tree()'s call chain). That's
> not a problem on its own. But in the most naive implementation, this
> means unnecessarily re-loading the sparse-checkout files of the
> submodules for each tree given to git-grep (as grep_tree() is called
> separately for each one of them).

Wouldn't loading the sparse-checkout files be fast compared to
grepping a submodule for matching strings?  And not just fast, but
essentially in the noise and hard to even measure?  I have a hard time
fathoming parsing the sparse-checkout file for a submodule somehow
appreciably affecting the cost of grepping through that submodule.  If
the submodule has a huge number of sparse-checkout patterns, that'll
be because it has a ginormous number of files and grepping through
them all would be way, way longer.  If the submodule only has a few
files, then the sparse-checkout file is only going to be a few lines
at most.

Also, from another angle: I think the original intent of submodules
was an alternate form of sparse-checkout/partial-clone, letting people
deal with just their piece of the repo.  As such, do we really even
expect people to use sparse-checkouts and submodules together, let
alone use them very heavily together?  Sure, someone will use them,
but I have a hard time imagining the scale of use of both features
heavily enough for this to matter, especially since it also requires
specifying multiple trees to grep (which is slightly unusual) in
addition to the combination of these other features before your
optimization here could kick in and be worthwhile.

I'd be very tempted to just implement the most naive implementation
and maybe leave a TODO note in the code for some future person to come
along and optimize if it really matters, but I'd like to see numbers
before we spend the development and maintenance effort on it because
I'm having a hard time imagining any scale where it could matter.

> So my next idea was to implement a cache, mapping 'struct repository's
> to 'struct pattern_list'. Well, not 'struct repository' itself, but
> repo->gitdir. This way we could load each file once, store the pattern
> list, and quickly retrieve the one that affect the repository
> currently being grepped, whether it is a submodule or not. But, is
> gitidir unique per repository? If not, could we use
> repo_git_path(repo, "info/sparse-checkout") as the key?
>
> I already have a prototype implementation of the last idea (using
> repo_git_path()). But I wanted to make sure, does this seem like a
> good path? Or should we avoid the work of having this hashmap here and
> do something else, as adding a 'struct pattern_list' to 'struct
> repository', directly?

Honestly, it sounds a bit like premature optimization to me.  Sorry if
that's disappointing since you've apparently already put some effort
into this, and it sounds like you're on a good track for optimizing
this if it were necessary, but I'm just having a hard time figuring
out whether it'd really help and be worth the code complexity.
