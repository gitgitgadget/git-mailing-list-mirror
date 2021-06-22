Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C36C4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 01:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6EF60C41
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 01:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFVB3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVB3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 21:29:30 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C5C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 18:27:15 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p42-20020a056a000a2ab02902f33d81f23fso10299458pfh.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WBIzV4B2RmEVWzLyHSmQWX13hFK4YjARYE8QSojH3QM=;
        b=XVuu8dpZIFDFnmjSFn25T0wf6zucrzCROhIkjVG3ArwD4EmLFr2uhDGpkdj23li2wm
         uLT6D6nhoNxxmDDZw2Vh8AjcVYvgHPdsiOHM9i9oM5w6FVFFyrfc3z9E7ne8MAn/xWN0
         1q4eIxYA/5delkTqypcKDZIYtMSFiPS2oNGGxtooqp485ubkN2kgTVxuUvU7mgv+1fFj
         Amca85nHucPli9nA20ySX2DJVnY6wxYfCXeC7Xv0/o8NwyHBKSWW0H9/2XIHA2bWQTy8
         bnOZIQG8wwlT7Q/uUbYxf4wUjltu62mHA9CKTpCQzM6HppIkIpde66OzXvWsZ4pDGkrf
         Cv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WBIzV4B2RmEVWzLyHSmQWX13hFK4YjARYE8QSojH3QM=;
        b=EUiZANYDtCTqtCthHjzK0OLPW2lkhuiqS0GL4iv0LRWtPlxHdFg3vf2c2Bhv5yeTkK
         ff8P5SkgHLav5ZJDZFpaL+UbtlwA5sMoOYysaL2w30sKjU8+97OEYyx7/15YGEIUKvew
         S7OcmJwEISaGAINzH4ijzm4i7f8CguNgRLm8yABffnOy4ff04SY3GPt/aXMMnLwxV+cF
         MzEZYg8vQqtAkqMevJMJKSpyPpQNq1EBOcPOteJMbrwUgK7u+shsVTpvVyvlLcJeY26d
         gOhQXfGyFlCZX5sCJWKna2+mp1AQzOKBvwAw+6Hy3m2VZ/9uT6ByQUllMqae5pnuY7+G
         iAAw==
X-Gm-Message-State: AOAM531zXzBWeZNJYkKknGH0k40HWN24QN8AEVxg0WyO9KOdADAjbp8I
        Gvr+59dRsNOuAxPhl3pKeuJ9tV0mcu76FxM33cAy
X-Google-Smtp-Source: ABdhPJx8UBjur8MViXhQigrkrBJZULmzA4sHN2wRBoYJrWPA4A7k9KWFQNp/TEJyp5s0w7rhaZMYSBJRdlFxBfnOPW5y
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:ea03:0:b029:2e7:8445:243c with
 SMTP id t3-20020a62ea030000b02902e78445243cmr1047290pfh.54.1624325235016;
 Mon, 21 Jun 2021 18:27:15 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:27:12 -0700
In-Reply-To: <87k0mn2dd3.fsf@evledraar.gmail.com>
Message-Id: <20210622012712.1203208-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87k0mn2dd3.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> And then, instead of doing what I'd think would be the natural result of
> >> that: Simply supporting an in-repo top-level ".gitconfig" file. We're
> >> still going to seemingly forever have them be an even more special
> >> snowflake with this facility, and the reason seems to be mostly/entirely
> >> to do with working around some aspect or restriction of Google's
> >> internal infrastructure.
> >
> > I don't think that this is "natural". In particular, I still don't think
> > that hooks should be tied to code revision. E.g. if we make commits
> > based on an old revision and push them, we still want them to follow the
> > latest requirements.
> 
> Even for real-world centralized workflow situations where I've seen
> people think they want that, and the end of the day they almost never
> actually want that.
> 
> Even something like code linting is a good example, to make it
> Google-specific: say for a Go project: Are you going to pin your linting
> tool/version to whatever understood your YAML format for the linter as
> it was specced 10 years ago when the project started?  It's simply a
> giant hassle to have a piece of code operate on every version of your
> project ever in a way that doesn't break.
> 
> I think in practice the designers of this feature don't actually have
> that in mind, but a "close to trunk" workflow, where you'd expect a hook
> to only need to operate on revisions for the last few weeks or months,
> because that'll be the oldest think people create new topics from.

This is probably true, but it still means that people would want any
hook changes to work retroactively, even if it's just on code for the
last few months. So they still need some independence between the hook
and the main code.

> But I think the burden of proof is really on the other side here,
> something that works entirely differently than the rest of git needs to
> have a good reason. Our in-repo .gitattributes don't work like this, nor
> .gitignore, .mailmap etc.

Not all of Git works this way though - e.g. hooks themselves, and
config.

> There's also real world uses of git where the "branches" are wildly
> divergent, e.g. I've worked on a system automation repo where the
> "master" was just a stub template, and every team had their own almost
> entirely different "repo-like" branch. Probably a bad idea for various
> reasons, but Git supports it just fine.

I presume this repo either does not use hooks, or its hooks are built
for such a branch setup? I envision that the admins of the remote would
only suggest hooks that work with their branch setup.

> For the centralized use-case what's the problem with just having the
> hook do a 'for-each-ref --format=' invocation or "cat-file --batch" on
> the "origin", and eval what it finds there? I'd think that gives you
> what you want for the more centarlized workflow, while leaving git's
> implementation working like the rest of our in-repo files.

This would future-proof such a hook, but not make it work retroactively
in the past. (The repo admin could just include no-op hook for all hooks
to future-proof, I guess, but this wouldn't work if we ever introduced
new hooks.)

> >> I think it's just un-git-y to have a meta-branch that in some way drives
> >> not only all other branches, but all other revisions of all branches,
> >> ever.
> >>
> >> It breaks expectations around git in lots of different ways, you can't
> >> fetch a single branch and get its hooks,
> >
> > Are you saying that each branch should have its own hooks? That might be
> > reasonable in certain projects, but I don't see how that is a Git
> > expectation.
> 
> It's a git expectation now that I can add git.git as a remote, also
> chromium.git, and linux.git, fetch them all, and happily switch in the
> same repo between entirely different codebases that don't share a
> history.

This expectation holds only if you know that your hooks can tolerate
such a scenario. If you're using remote-suggested hooks, I don't think
it's a matter of "before, I could have many remotes but now I cannot"
but "before, I had to install these hooks myself and now it's automatic"
- whether this workflow is supported or not would be the same before and
now.

> >> I think I get why you want to do it that way, I just don't get why, as
> >> mostly noted in those earlier rounds why it wouldn't be a better
> >> approach / more straightforward / more git-y to:
> >>
> >> 1. Work on getting hooks driven by config <this is happening with
> >>    Emily's series / my split-out "base" topic>
> >> 2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
> >>    valves etc. around this, I suggested starting with a whitelist of the
> >>    N least dangerous config options, e.g. some diff viewing options, or
> >>    a suggested sendemail.to or whatever.
> >
> > I've replied to this above.
> 
> Not really, even if we went for this one-HEAD-version-to-rule-them-all
> plan wouldn't it make more sense to generalize it as a
> refs/remotes/origin/magic-config, and we'd discover a ".gitconfig" file
> under that commit/tree.
> 
> I.e. whether we generalize this to config in general is orthagonal to
> whether such config lives in HEAD or in a magic ref.
> 
> With hooks as config I don't see how you'd make any of this
> hook-specific, there's other config where the "every revision ever"
> applies much more strongly, e.g. sendemail.to. If that changed for this
> project tomorrow you wouldn't want a patch based on "maint" to send
> things to a different ML.

My opposition to .gitconfig was that it is per-commit, but here it seems
that you're saying that there are reasons for it not to be per-commit
(e.g. the sendemail example).

> >> 4. People who want this "I want my hooks to apply to all revisions ever"
> >>    could probably get 99% or 100% of what they want if their hook is
> >>    just a stub that does the equivalent of:
> >>
> >>        sh `curl https://git.google.com/$reponame/hooks/$hookname`
> >>
> >>    You'd then simply forbid on your servers any changes to a .gitconfig
> >>    that did anything with the hook.* namespace.
> >
> > This would work if set in .git/config (not version controlled), but not
> > .gitconfig (version controlled).
> 
> Sorry, what wouldn't work? I meant you'd forbid pushes to your in-repo
> .gitconfig in your "master" branch or whatever, just like you're
> presumably planning some stronger ACLs for this magic hook branch.

The "I want my hooks to apply to all revisions ever" wouldn't work if it
was per-commit .gitconfig. (It would work if it was in the magic
branch, but at that time, what I understood by ".gitconfig" is the
per-commit version.)

> >> With such an implementation you don't need a magic
> >> "refs/remotes/origin/suggested-hooks" refs, just some state machine (I
> >> suggested e.g. GPG signing chains as an eventual end-state, but "show a
> >> diff every time" would also do) that keeps track of what config (and
> >> hooks are just one such case) has been OK'd, and which has not.
> >
> > This sounds complicated.
> 
> On the contrary I think anything that leans into git's
> content-addressable security model is way less complicated. You don't
> care who you fetched Junio's v2.32.0 tag from, what matters is that the
> signing chain validates.
> 
> The plan of having this magic branch means a whole new trust model for
> git, you trust magical authorized remotes. If you trust signed content
> chains you can trust hooks if their last modification can be traced to a
> signing authority you trust.

The security model might be preexisting, but the things needing to be
built around it make it more complicated. Take this case - I presume
this means that the client would need to tell Git that a certain public
key is considered trusted (perhaps prompted by the server upon clone, so
the client would only need to copy and paste "git trust-key $HTTPS_URL"
or something like that). Whenever a user wants to update a hook, they
will make a commit, and when the PR is merged, the merge commit (or the
tip commit if fast-forwarded) must be signed with the same key.

Compare this with trusting that commits coming from a certain HTTPS URL
are fine. The workflows are the same as for a regular code commit.

>     It's really just:
> 
>         if (hook_content_changed() && hook_content_same_as_in_ok'd_revision_from_upsteam())
>             trust_hooks();
> 
> But while we're on the subject, it seems like a very generous assumption
> to think that just because you trust hooks at a given revision (or
> always trust the latest), that you implicitly trust them when *combined
> with* all past and future revisions from the same repository.
> 
> Even without a malicious actor that seems like it'll inevitably break in
> all sorts of data-destroying ways. E.g. people commit stuff
> accidentally. A hook run under a "git bisect" that navely does an "rm
> *" will eat your data if you land on a revision that an in-tree "-rf"
> file.

I think we have the same problem with current hooks and other config,
and we have been dealing with them relatively well (as far as I know).

> But once you get to a malicious actor who can say push a topic branch
> but not hook updates, will your hooks deal with files with whitespace in
> them, arbitrary crafted content etc?
> 
> So I'd think that's an even better reason to prefer the in-repo
> per-revision atomically committed plan, and only trust hooks for the
> revision they're shipped with, at least as a default git security model.

The malicious actor could include the same hook in their topic branch,
so I don't see how the per-revision hook is better than the all-revision
hook.

> >> I'd think it would even work better in the Googleplex, you could clone a
> >> co-worker's branch and execute their hooks, since they're the same as
> >> what you've pre-approved,
> >
> > In the presence of .gitconfig, how would you know?
> 
> If it's the same config, or you can automatically OK it. So "same" was
> discussed above, or you could trust any hook that's only doing a wget of
> some trusted domain and piping that to "sh".

Extending trust to hooks that are exactly the same makes sense.

> You trust e.g. chromium.git's hooks, but I clone it, patch it, and
> re-push it to somegithost.com URL. If you go with trusting content it
> becomes easy to install those trusted hooks for the common case, but not
> if your entire trust model relies on what URL you git clone'd from.

If the repo administrator provides a key and signs their hooks, then the
repo itself is indeed more portable and does not need to come from a
single source. This may be useful, but I'm not sure how useful this is,
since hooks are typically provided by projects. And as far as I know
projects generally have one source of truth, so the portability is not a
big plus.
