Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C028C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF922075F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiuwFXWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgETRin (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:38:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4678EC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:38:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so3701323oif.2
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImHDNuSCQO8eGsi4oEBqke+0yp2gjCVRc7rjnFCzRMQ=;
        b=YiuwFXWuoFnB+WHxseCULg00DpJX6qonoxr4zt8RREyDpVjGnFc4glh452rQYYY+IA
         7cOInN27ga9qyJYudSCvNkBqRWAoZHBN00EClUfDLZpqC/ARHXh8SpG7O2Nys/rtEqmp
         EjIgnR1ng0vkISE3HLEwJhZYLyYPgqcaGbLdNoB3R9Tr81k8i3oTO59hlGa3fL4HFdiP
         Iguq+8VtXE2GQJ7ne1/jrEN3ZtqYW8YxxswxcQU94aGagNR1icRHtSPloi6f81pB54Kx
         JSiyrwB5fjGI4IrinRsBclS+c9HGTekrcTov6MgyM0CRAfpVRjwxD/SYKG7yhk66eEVF
         NEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImHDNuSCQO8eGsi4oEBqke+0yp2gjCVRc7rjnFCzRMQ=;
        b=F6woGG26VAoQUBuPWFv6jQyF61vakeYH86Quc4O01Uxf02afLQ4X1HxKfkiyDvUGTc
         /jh0mFcBha/3EXtZF0jvuOWOvaj6kexcaG4RPltZFzljVNZOb9wH5YEaR/UI+huoKIWs
         cLe3VsT2i3wUEdXXLuzLttTsvd0JquXNNjP3y1HQoVDgsZXiuNRWFF1VzXAUeIkm6rsz
         SEzFkZFMvVd9/s01ZjmYYJAWKhdVJgI5zMHf8ddGcauvNmUhRaebcSc0UHEyOm5mjIlQ
         W9QRpa6jjwrSI70BgoYnfCbdpzLiZ0KYn1fo17YQ59KugLkoJEsMgwSElFmEyRwIjqT1
         iYGA==
X-Gm-Message-State: AOAM5319s0sTpeVDB6xDkwNqJzphWvEKnMPU1KC8XcmvvT2YhxyKgE82
        PNaBcHYPfK6ue8EjYhfeCfCFk7QSuGclsi153ww=
X-Google-Smtp-Source: ABdhPJy0E8QwqXgrVKkjEZBGB64Q3Lxoxql7HPqAwjWPFto/pC25eF6rS/dR+6rN4nsiuwXwwhc7JimuxBZeII1GsEc=
X-Received: by 2002:aca:2b04:: with SMTP id i4mr4084750oik.39.1589996322339;
 Wed, 20 May 2020 10:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 10:38:30 -0700
Message-ID: <CABPp-BEz+XE48_vmEa4jmH53YSHUoj5G-OY+UT1mv92irQVEkQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 6:20 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ds/sparse-allow-empty-working-tree.
>
> BACKGROUND
> ==========
>
> After discussing the future of sparse-checkout at the Git Contributor
> Summit, Minh Tai caught me during the break to introduce a very interesting
> idea: in-tree sparse-checkout definitions.
>
> Here is the context: I was talking about how the Office team is building a
> tool to update the sparse-checkout definition dynamically as their build
> definitions change. They have a very compartmentalized build system, and
> certain "projects" depend on each other. To ensure that builds do not break
> as dependencies change, the plan was to have this tool run as a hook when
> HEAD changes. This is a bit expensive to do, and we were discussing how much
> we need this to be automated versus a part of the build process.
>
> This kind of idea would need to be replicated for every team that wants to
> use sparse-checkout in this way. That doesn't bode well for wide adoption of
> the feature.
>
> IN-TREE SPARSE-CHECKOUT DEFINITIONS
> ===================================
>
> Minh's idea was simple: have sparse-checkout files in the working directory
> and use config to point to them. As these in-tree files update, we can
> automatically update the sparse-checkout definition accordingly. Now, the
> only thing to do would be to ensure that the sparse-checkout files are
> updated when someone updates the build definitions. This requires some extra
> build validation, but would not require special tools built on every client.

I'm not sure how well having a parallel dependency structure will be
received, but the idea of auto-updating does seem really nice.  (I put
a hook in the build system that compares the timestamps on the files
that define dependency structures to the .git/info/sparse-checkout
file, and re-run `git sparse-checkout reapply`, which helps with
updating but is still delayed from the checkout/merge/rebase that
brought in new dependencies.)

> As soon as I sat down to implement this idea, I discovered some
> complications to that basic idea. Each of these sparse-checkout definitions
> should fit a "role" on the team. To continue with the Office analogy,
> suppose we had a definition for developers working on each of Word,
> PowerPoint, and Excel. What happens when someone wants to port a feature
> from Excel to Word? That user would want to take the union of the two
> sparse-checkout definitions. But what does that mean when we are working
> with arbitrary sparse-checkout files?
>
> This leads to the restriction that I built into this feature: we only care
> about "cone mode" definitions. These rely on directory-based prefix matches
> that are very fast. With this restriction, it is simple to understand what
> the "union" operation should do: take all directories that would be included
> by either.

Seems like you're adopting my idea of pushing folks towards "cone
mode" and limiting support for non-code modes[1], eh?  ;-)

I'm totally on board.  :-)

[1] https://lore.kernel.org/git/CABPp-BHKYR9QBcAG_pM6DniaeGS40X=ErKGGsvWa_KhogCZzEA@mail.gmail.com/

> Once we restrict to cone mode, there is no reason to continue storing files
> using the sparse-checkout file format. The list of patterns is larger than
> the input to "git sparse-checkout set" or output from "git sparse-checkout
> list" in cone mode, and more prone to user error. Thus, let's be simpler and
> use a list of directories to specify the sparse-checkout definition.

Ahah, you did come around to using a new config file[2].  ;-)

I like having simpler config files; sounds great.

[2] https://lore.kernel.org/git/c919513a-f41f-2ce8-60ed-e0b0733c0c7f@gmail.com/
 ("another config file")

> This leads to the second issue that complicates things. If a build
> dependency changes to a core library, but there are N "roles" that depend on
> that library, then the person changing that library also needs to change and
> validate N sparse-checkout definitions! This does not scale well. So, let's
> take a page from build dependencies and allow these in-tree sparse-checkout
> definitions to depend on each other!
>
> The end result is a mechanism that should be flexible enough to future needs
> but simple enough to build using existing Git features. The format re-uses
> the config file format. This provides good re-use of code as well as being
> something easy to extend in the future. In Patch 4, I tried to describe
> several alternatives and why this is the best of those options. I'm open to
> suggestions here.
>
> OUTLINE
> =======
>
>  * Patch 1 is a bugfix that should work on its own. I caught it in tests
>    after Patch 5.
>
>
>  * Patches 2-7 implement the feature.
>
>
>  * Patches 8-9 make the Git build system a bit more robust to missing
>    directories.
>
>
>  * Patch 10 adds a .sparse directory to Git as well as two in-tree
>    sparse-checkout definitions. One is for a bare-bones Linux developer and
>    the other adds the compat code for Windows on top.
>
>
>
> As mentioned in patch 10, this allows the following workflow for Git
> contributors that want to "eat our own dogfood" with the partial clone and
> sparse-checkout features:
>
>  $ git clone --sparse --filter=blob:none https://github.com/git/git
> $ cd git
> $ git sparse-checkout set --in-tree .sparse/base.deps
>
> Then, we have a smaller working directory but can still build and test the
> code.
>
> FUTURE DIRECTIONS
> =================
>
> There are definitely ways to make this feature more seamless, or more useful
> to us.
>
>  * It would be nice to extend git clone to have a string value to
>    --sparse=<file> and possibly have it multi-valued. This would initialize
>    the in-tree sparse-checkout definition immediately upon cloning.

Also in terms of future directions, I would like to have the option
for these to be passed to --filter instead of using --filter:none.

And on top of that, it may also make sense for users to be able to
fetch cones of history somehow.  For example, if they started with
`git clone --sparse=featureA ...` and later wanted to add the
'featureB' cone, it'd be nice to be able to run some kind of `git
fetch --sparse=featureB ...` command when they know they are on a good
network to download the history of objects that touched the featureB
cone instead of relying on the normal lazy fetching of partial clones.

This kind of thing could be especially useful if, say, we were in a
pandemic and everyone was forced to work from home.  But it'd also be
useful if you just had people travelling a lot and stuck in third
world places with low connectivity, like CalTrain.  ;-)

>  * I think there are some ways we could reorganize the Git codebase to make
>    our "most basic" sparse-checkout file have even fewer files. Mostly, it
>    would require modifying the build to ask "do these files exist on-disk?
>    if not, then disable this build option." This would also require adding
>    test dependencies that also disable some tests when those do not exist.
>
>
>  * Currently, if we have an in-tree sparse-checkout definition, then we
>    can't add more directories to it manually. If someone runs git
>    sparse-checkout set --in-tree <file> followed by git sparse-checkout add
>    <dir>, then will disappear as it is overridden by the in-tree definition.
>    The only way I can think to get around this would be to add these
>    directories through Git config, since we were using the sparse-checkout
>    file as the storage of "what directories do I care about?" but it is no
>    longer the source of truth in this situation. I'm open to ideas here, and
>    it would be nice to have this interaction hardened before moving the
>    series out of RFC status.

This seems like a big problem to me.  Actually, it sounds like two big problems.

1) non-extensibility

I suspect most will be happy enough with the in-tree definitions, but
there are always a few users that want to add to the pre-defined
sparsity sets to get some additional directories.  We could use
.gitignore as an example; although people have shared ignore rules in
.gitignore, we still allow user-defined additional ignore rules that
are not meant to be shared.  Perhaps we can allow users to use some
pre-defined additional file (similar to .git/info/exclude) or even
user-defined additional file (similar to core.excludesFile)?

We would still need to be careful to not allow the in-tree definitions
to depend on files that are not in-tree, of course.

(Even with my `sparsify` script which allowed things like `./sparsify
--modules moduleA moduleB` and which walked build system dependencies
to get the right directories, I still allowed additional directories
to be specified within a .git/info/sparse-checkout-user file.  Not
sure I liked the location of the file (it's sometimes hard to find for
users of worktrees), or the basename of the file I randomly chose that
day, but it came in handy for a few people.)

2) Ugly, overly verbose (and even error-prone?) UI.

If `git sparse-checkout set --in-tree <file>` means that any
subsequent checkout will blow apart any user-ran `git sparse-checkout
add <dir>`, then we really need to give at least warning and maybe
even error messages if people are using in-tree mode and use either
set or add.  Also, this feels like we're just about deprecating the
usage of set and add without the --in-tree flag, which could lead to
years of questions of "Why do I have to specify --in-tree every time I
run these commands?"  Can we avoid that somehow?

Maybe we just take advantage of the huge backward compatibility
warning we put in place and require non-in-tree mode to specify an
additional flag?  Maybe we just check the argument to set or add when
in cone mode, and if it's a file (instead of a directory) then we
automatically assume --in-tree (or attempt to parse it first and throw
an error if it isn't in the --in-tree format)?  Maybe we pick a
different verb than add or set ('use') and guide people to it instead
of `add` and `set`?

Also, as a side note, can people specify multiple in-tree files at
once (`git sparse-checkout set --in-tree <file1> <file2>`)?
