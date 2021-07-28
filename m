Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE8C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B0A60230
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 18:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1S0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1S0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 14:26:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D92C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 11:26:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id az7so3183944qkb.5
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LIaB4YraJ1OZGrP6O/KrMAm9jmdYb5bfPlRaVSKJwbk=;
        b=sCdAbl4mQv+oN1k/PK1OjMjLXQ0Smf2YbXthhBeXj5VgX0s/DDjiuBvQuZbGnuh3vY
         WJJTCcfbSQgpzpQE4ponXpjNrK3X9BOENP4jOrO3NoHQFqzT+JfqcvC7ARIwGAqws5yR
         141Qxuw99u/DfZZj1589vOvnKXMWky4O85qmi8Wr6X8YhEYOO4rGmPylSMah14hWGu68
         ZLmeZrEAicgICU4voB6biR8Xo2CHheHCDL95iofl74piRVZVcvpvQzogFA49Ik7lIgx2
         LbchZq3UB69Y7uaj3ZQpB1JEiTdZD5Z8xRrT7ByabD+3h8PcnhD4+jjzkywF5CKn3CA9
         hMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIaB4YraJ1OZGrP6O/KrMAm9jmdYb5bfPlRaVSKJwbk=;
        b=TMukarKyHjh7/BX+YQJgoqSCNtUI7ES5Q0oEam+fklCdIGM/P9SXVMbYN1v/iJAS6U
         wdGHpu19WI92qAxj9vssP6UccjfX60B8mDBfq3eSl838vtX5FfJ8dTg3SOhYZ/sByXT3
         46hcEOcCeLSgcpAQZUo4gRw6G+r/xxCzXgXH4MHZguQ7QjL46nxKl25kEy62jl9VapSS
         mBzq2mw6CgX3l/WbRg3HKHREsa/Cf8zZjj0/b8Hl/aYFAMlMn/yLuiw8+FgZ0FySUgM1
         T73yr5tQgmT2YygQmnJlJpDJMF1JjYPkTW8JVawnLyVOybn+udDKYLleiwO6v73LbUug
         4PLw==
X-Gm-Message-State: AOAM532Je+Qri4Sokc4fKV2MR1eBAdXmP9wwHwIFUVVf3i4AWf3voiB1
        i9eccoPAvVwInXjKffw/PkQ=
X-Google-Smtp-Source: ABdhPJybC60TYChLvpO6ml3f9PjKdVzjjBfKGcTORWkIKSFxYdLDd7o5BeGHIFhZyHUjEVkqEC4O+g==
X-Received: by 2002:a37:82c2:: with SMTP id e185mr1024171qkd.434.1627496779397;
        Wed, 28 Jul 2021 11:26:19 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id v6sm411011qkp.117.2021.07.28.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:26:18 -0700 (PDT)
Date:   Wed, 28 Jul 2021 14:26:17 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support setting up a remote tracking branch
 upon creation
Message-ID: <YQGhSTc9NoB4xEGA@erythro.dev.benboeckel.internal>
References: <20210728135041.501850-1-mathstuf@gmail.com>
 <20210728135041.501850-2-mathstuf@gmail.com>
 <xmqqim0u9vnb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqim0u9vnb.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 10:48:56 -0700, Junio C Hamano wrote:
> Ben Boeckel <mathstuf@gmail.com> writes:
> 
> > The `branch.autoSetupMerge` works well for setting up tracking a local
> > branch, but there is no mechanism to automatically set up a remote
> > tracking situation.
> 
> This description is probably insufficient to explain what's missing,
> probably because "set up a remote tracking situation" is a bit
> fuzzy.

Fair enough. I finally understood what was going on with "tracking" only
recently. Usually I would track the remote's branch of the same name,
but I found that "tracking" `origin/master` instead of `myfork/topic`
makes `fugitive` render the following:

  - commits on my topic that aren't integrated (this makes it easy to
    tell it to "amend this commit" using its keybinding;
  - commits on `master` that aren't on my topic (so I can see if there's
    anything relevant to rebase on top of); and
  - diffs against my fork's branch (as last fetched) so that I can see
    the status.

Maybe this is a tooling issue, but I saw this as a potential way to
avoid having to specify this information on every topic I create.

> Without this patch, I can do this already:
> 
>     $ git checkout -t -b topic origin/topic

I should note that the *vast* majority of my development is done using
the fork-based workflow. I have `remote.pushDefault` set to my fork and
I use `push.default = simple` (there are only a handful of repositories
where "my fork" is also `origin` and I have, on multiple occasions,
wanted to make forks even there).

My normal pattern is that I'm on the target branch already, so I have:

    $ git checkout -b topic

which doesn't do any tracking. Just `-t` makes it track my *local*
`master` when I really want it to track `origin/master`. AFAIK, there's
no shortcut for this other than to give the full `-t origin/master` at
branch creation time (and as something I do all the time).

> And after the above, we have
> 
>     [branch "topic"]
> 	remote = origin
> 	merge = refs/heads/topic
> 
> Of course, you can instead use a short-hand DWIM, e.g.
> 
>     $ git checkout topic ;# assuming origin/topic exists
> 
> gives us the same thing.  In either case, topic knows to integrate
> with the 'topic' branch from remote 'origin' and push back there.

This doesn't match with my usual experience in fork-based workflows. I
want the topic to track `master` and then my `remote.pushDefault` makes
sure it goes to "the right place" when pushing.

> So instead of saying "there is no mechanism to ...", be a bit more
> specific what you can and cannot do in this first paragraph.
> 
> Then we can describe the solution we'd propose in the second and
> subsequent paragraphs.
> 
> Thanks.

I'll work on an improved cover letter to give more background.

> > +branch.defaultRemote::
> > +	When a new branch is created with 'git branch', 'git switch' or 'git
> > +	checkout', this value will be used to initialize the
> > +	"branch.<name>.remote" setting.
> 
> You mean without "-t"?  I offhand do not think of a reason why this
> is a good idea.  How would one create local topic branches that you
> plan to merge locally into your own larger topic branch to be shared
> with others?  Shouldn't there be an easy way to countermand the
> setting by this configuration?

Everything goes through merge requests for the projects I work on
day-to-day (even contributions to "my own" projects due to CI
workflows). I added a test that `--no-track` works for this case (which
given its rarity for me is the right tradeoff at least).

> > +branch.defaultPushRemote::
> > +	When a new branch is created with 'git branch', 'git switch' or 'git
> > +	checkout', this value will be used to initialize the
> > +	"branch.<name>.pushRemote" setting.
> 
> Ditto.
> 
> > +branch.defaultMerge::
> > +	When a new branch is created with 'git branch', 'git switch' or 'git
> > +	checkout', this value will be used to initialize the
> > +	"branch.<name>.merge" setting.
> 
> So the expected use case is to fork multiple local branches, to
> integrate with the same branch from the remote?  I think we can
> already do 
> 
>     $ git checkout -t -b xyzzy origin/master
>     $ git checkout -t -b frotz origin/master
> 
> and you can lose -t with branch.autosetupmerge setting.  As the "git
> branch" command needs to get the name of your branch (e.g. 'xyzzy'
> or 'frotz') and which remote tracking branch you start from
> (e.g. 'origin/master'), even with branch.{defaultRemote,defaultMerge}
> configuration, you wouldn't lose that many keystrokes, I suspect.

There are times that I want to branch from HEAD, but track `master` (for
example, a branch destined for backporting to an older branch). The
equivalent of:

    $ git checkout release
    $ git checkout -b backported-branch
    $ git branch --set-upstream-to=origin/master

> Or do you plan to make
> 
>     $ git branch xyzzy
> 
> a short-hand for
> 
>     $ git branch -t xyzzy origin/master
> 
> when defaultRemote and defaultMerge are set to 'origin' and
> 'refs/heads/master'?  It would be way too confusing to start the
> new branch from origin/master in such a case, as everybody learned
> that "git branch xyzzy" that does not say where the branch initially
> points at uses HEAD.

No, it would just *track* `origin/master`, not branch from it. It should
be shorthand for:

    $ git branch xyzzy
    $ git branch --set-upstream-to=origin/master xyzzy

Though I personally use `git checkout -b` far more often to create
branches. And since "every" branch I make would have `-t origin/master`,
I wanted to have configuration to do this part for me.

Hopefully this gives a clearer picture of where I'm coming from.

Thanks,

--Ben
