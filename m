Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEB1C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1946861989
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2XVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2XUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:20:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07126C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:20:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q5so10857481pfh.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4gqFvfqcMnd1pG/gn1EOS08boXlxxXT/pcWS98CCNRY=;
        b=RyXzuiTe5ykUHKZckHJnNz9swlUdLosjubcp7r/xTzn64CemgEUACZl2/vhvgP0VKv
         7lnzZeZCM4zf4pnREPCO4++qp4AfAHTW5d9qaZ9Q2dPAI4276SRrXUcjCXsVfPZ7pA2M
         cLaWtn4EWuY6wSjba1MfCfX3vJ3RIRK29PEQJAnv4zdziAVFihWcGKZHZqVxYqWZj6zm
         wXziQKLUVl9PTzZjBilrR/4eyNnsb2gR2MYuRgPaobSAaH9qEoKLkkRuIOtHaC4Sikj1
         ctjivtrVMfTUqSJojKhZpDqa4zw65FjNnb7APP7smaZ/TGE48Wk3hDmQdxxWfaFAGjX4
         M8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4gqFvfqcMnd1pG/gn1EOS08boXlxxXT/pcWS98CCNRY=;
        b=tpiOFJw0fQOYrEj+DkcVwztsDVe58YiZ+TIKXk0tHvVh3WeT1WcVdZsh+VV7ZYi0To
         aBGJQvVrz4BJWOSXjLRDnRkaE28ikN1I6n4jmDnZxmRrdWzl6c4Pb9YHzAT+z37JlvnM
         kmM8nivYuNFFnd7qla2oNH2aF07KxogqjNp4E3iVrb2/oraV5hidGzyohGvoouGYNbE8
         dt383AAhcXK7yOGlAlQZbxpDudZtrPl9lYmw7E4IFYjWMgZV5rncNdoHhQqyoAWWgite
         82qf3wBvBgINvvlOcsBke3bkpflc/J2Mu6JoMLbXh26/mzufxtpGCvGu3zErsTQuQo0V
         xuRA==
X-Gm-Message-State: AOAM532rrC76Clpnp5D22a6PNleJJIldmB50cqhJ4iXA725dv+cXUobG
        sRiHNyPQtSVjrsr4KBL+HCHx4A==
X-Google-Smtp-Source: ABdhPJyMD8NBIiuiTE+a+3HvSypCl0dJNbE2mSyxLxiQq9ZUvzes8ejey3Q+wT2bIKnz0bX+zlP2Hw==
X-Received: by 2002:a65:63d6:: with SMTP id n22mr26349766pgv.393.1617060042001;
        Mon, 29 Mar 2021 16:20:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id h6sm18738157pfb.157.2021.03.29.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 16:20:41 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:20:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
Message-ID: <YGJgw5QPKFyv4HSG@google.com>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 01:43:36AM +0000, Albert Cui via GitGitGadget wrote:

> Change-Id: I5f6747524b97c51dfe5fa28e48ea03981b2da5b8
Oops :)

I avoid this by setting gerrit.createChangeId = false in my global
config and adding an alias:
  alias.gerrit-commit = "-c gerrit.createChangeId=true commit"

> +Server-side vs Local Checks
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +* Helps developers catch issues earlier: typically developers need to push to
> +the remote to trigger server-side checks. Local hooks can be run anytime the
> +developer wants. This is especially useful if the project has slow
> +server-checks; catching issues locally can save the developer a lot of time
> +waiting for CI. They are also useful for locally reproducing an issue identified
> +in CI, helping resolve issues faster.

Big +1 to this - I hate having to wait for a push and CI build, possibly
queued behind someone else's work or an earlier mistaken push, to check
whether my stuff is right. :)

> +In the ideal world, developers and project maintainers use both local and server
> +side checks in their workflow. However, for many smaller projects, this may not
> +be possible: CI may be too expensive to run or configure. The number of local
> +solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
> +Bringing this natively to Git can give all these developers a well-supported,
            ^~~~
This is a little vague here. It sounds like you might be suggesting to
standardize server-side CI config in Git-controlled projects.
> +secure implementation opposed to the fragmentation we see today.

The point about solution fragmentation is a strong one and I wonder
whether it's being emphasized enough. There is obviously a need, or else
people wouldn't keep writing all these things in the Prior Art section
:)

> +Security Considerations and Design Principles
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
[snip]
> +  ** Since developers will likely build their local clone in their development
> +  process, at some point, arbitrary code from the repository will be executed.
> +  In this sense, hooks _with user consent_ do not introduce a new attack surface.

It might be worth saying that we want to make configuration of
project-configured hooks to be approximately as easy/automatic as
building (that is, the user still has to explicitly run a build, and
isn't prompted at the end of their clone whether they want to build it
right away).
> +
> +* Give users visibility: Git must allow users to make informed decisions. This
> +means surfacing essential information to the user in a visible manner e.g. what
> +remotes the hooks are coming from, whether the hooks have changed in the latest
> +checkout.
   ^~~~~~~~
Better say "fetch", if we are proposing this magic branch thing.

> +* This configuration should only apply if it was received over HTTPS

Meaning, non-HTTPS fetches should just not update this special branch?

> +* A setup command for users to set up hooks
AIUI, this is proposed to be part of `git hook`, right?

I don't think it needs to be part of this doc but it'd be nice to also
support installing just a subset, like:

  git hook setup pre-commit
  git hook setup --interactive

> +* Users must explicitly approve hooks at least once
> +
> +    ** Running the setup command should count as approval, including if the user
> +    consented during the clone
> +
> +    ** When a hook command changes, a user should re-approve execution (note:
> +    implementation should not interfere with requirement listed in “Fast
> +    Follows")
> +
> +* Automation is able to continue to use clone and other commands
> +non-interactively

One interesting point - by using an advice instead of an interactive
prompt at clone time, we get this for free.

> +Fast Follows
> +^^^^^^^^^^^^
> +
> +* When prompted to execute a hook, users can specify always or never, even if
> +the hook updates

I think we want to base this on the remote URL, right? I know we talked
a little offline about how to mitigate vs. malicious maintainer (for
example this whole mess with The Great Suspender) and I'm not sure what
solution there might be.

I wonder if it's worth it to notify users that their always-okayed hooks
were updated during fetch?

> +
> +Nice to Haves
> +^^^^^^^^^^^^^
> +
> +* A method to skip hook execution i.e. `--no-verify` works everywhere

This part I'd like to discuss more on-list - I think it would need to
happen as an argument to git.c (e.g. git --no-verify commit blah), or
else we'd have the problems we have with --no-verify today. But is that
too ugly? I think everything else (even teaching parse-options to grab
--no-verify regardless, which, ick) would still be prone to issues,
since not everybody uses parse-options and not every subcommand
implementor knows their subcommand will invoke a hook. (For example, the
nice surprise when rebase started using some different strategy and
invoking the post-commit hook way more often, off the top of my head so
details may not be correct.)

> +* Support a “warnings only mode” where hooks run but don’t block commands from
> +executing

Same as --no-verify. I wonder whether it's "good enough" to do these two
as configs? hook.skip-all=true, hook.ignore-result=true?

> +Implementation Exploration: Check "magic" branch for configs at fetch time
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Example User Experience
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +===== Case 1: Consent through clone
> +
> +....
> +$ git clone --setup-hooks
> +...
> +
> +The following hooks were installed from remote `origin` ($ORIGIN_URL):
> +
> +pre-commit: git-secrets --pre_commit_hook
> +pre-push:  $GIT_ROOT/pre_push.sh

Hm, I thought we wanted to consider storing the hook body in the magic
branch as well? To avoid changing hook implementation during bisect, for
example?

> +....
> +
> +===== Case 2: Prompting after clone
> +....
> +$ git clone
> +...
> +
> +Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
> +
> +pre-commit: git-secrets --pre_commit_hook
> +pre-push:  $GIT_ROOT/pre_push.sh
> +
> +# instead of prompting, we could give users commands to run instead
> +# see case 3

Yep, I think this is a better idea - I glued together the two UXen below
:)

> +
> +Do you wish to install them?
> +1. Yes (this time)
> +2. Yes (always from origin)
> +3. No (not this time)
> +4. No (never)
> +....

Offline when we discussed this, it seems like users will just smash 2
("whatever gets you to stop bothering me") regardless of whether the
hooks are actually coming from a source the user trusts. So I would
prefer something like:

  $ git clone
  ....
  Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:

  pre-commit: git-secrets --pre_commit_hook
  pre-push:  $GIT_ROOT/pre_push.sh

  If you wish to install them, run `git hook setup origin`.

> +===== Case 3: Re-prompting when hooks change
> +....
> +$ git pull
> +
> +The following hooks were updated from remote `origin` ($ORIGIN_URL):
> +
> +pre-push:  $GIT_ROOT/pre_push.sh
> +
> +If you wish to install them, run `git hook setup origin`.
> +
> +If you wish to always accept hooks from `origin`, run `git hook setup --always
> +origin`. You should only do this if you trust code changes from origin.
> +
> +To always ignore hooks from `origin`, run `git hook ignore origin`.
> +....
> +
> +===== Case 4: Nudging when hooks weren't installed
> +....
> +$ git commit
> +advice: The repository owner has recommended a 'pre-commit' hook that was not run.
> +To view it, run `git show origin/refs/recommended-config:some-pre-commit`. To install it, run `git hook setup origin pre-commit`
> +
> +Turn off this advice by setting config variable advice.missingHook to false."
> +....

(Full disclosure: this was my idea.)
I realize that some folks upstream may find this is too chatty for
general use. I'm hoping being able to shut off the advice globally might
be enough of a mitigation; maybe we can gate it behind an experimental
config or something if folks aren't so sure?

> +Implementation Sketch
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +* Perform fetch as normal
> +
> +* After fetch is complete, Git checks for a "magic" config branch (e.g.
> ++origin/refs/recommended-config+) which contains information about config lines
> +an end-user may want (including hooks).
> +
> +* As part of the fetch subcommand, Git prompts users to install the configs
> +contained there.

Like I mentioned above, I think we probably want to drop the entire
interactive installer wizard concept...

> +    ** User responses to that prompt could be "sticky" - e.g. a user could reply
> +    "no (this time)", "no (never)", "yes (this time)", or "yes (always)".
> +    Always/never indicate that the user trusts the remote this config is coming
> +    from, and should not apply to configs fetched from other remotes.

...which also means that we can drop trying to express this briefly and
instead say something wordy in a flag to `git hook setup` (or whatever
we call it).

> +Later, we might want to do this before the initial clone is performed; that
> +workflow looks like:
> +
> +* During clone, perform ls-refs as normal
> +
> +* If the server has a "magic" config branch, fetch only that config branch.
> +
> +* Prompt users as described above.
> +
> +* Perform the rest of the clone.

This part I'm still interested in, although I'm not sure how to
reconcile not wanting an interactive prompt with wanting an early step
like this during clone. Maybe that's what this `git clone --setup-hooks`
(or maybe, `git clone --with-recommended-configs`) is for?

> +Pros
> +^^^^
> +
> +* Repository owners have a method for providing recommended config for
> +contributors.
> +
> +* Installation flow happens without additional user intervention.

I think when we wrote this bullet point it was to express "the user
doesn't have to run something else to discover these hooks exist". But I
don't think "without additional user intervention" fully describes
what's proposed here, either. Hrm.

> +
> +* Keeping config branch and history separate from code branch and history means
> +it is versioned, but not tied to user's checkout.

Probably worth discussing/including that we intend hook contents to also
live in the config branch, to make sure we're running the same hook
regardless of checkout/bisect state/inspection/have been working on a
feature for 6 months and have been fetching but not rebasing/etc. I'm
not sure I see that explicitly called out here...

Actually, I found the following (pasting from much earlier in the doc):

  +    ** This could be a path to a script/binary within the repository
  +
  +    ** This could be a path to a script/binary contained within
  submodules of
  +    the repository
  +
  +    ** This could be a user installed command or script/binary that
  exists
  +    outside of the repository and is present in `$PATH`

Maybe this part needs to be modified to explicitly refer to the hook
executable being tracked in the magic branch?

> +Cons
> +^^^^
[snip]
> +* Turning a "set and forget" command like clone into an interactive session with
> +the user is not ideal; care must be taken to avoid breaking bots.

If we notify and nag, but don't interactively prompt, then we get happy
bots for free ;)

> +
> +* Inflating configs and executables from a remote tracking branch which is never
> +checked out could be slow.

I wonder about this. This seems to me like something that might be
drastically slower or faster depending on platform. Hmmm.

> +Future Work
> +~~~~~~~~~~~
> +
> +* Extending this to allow repository owners to specify specific configurations
> +in general e.g. this repository should use partial-clone with these parameters.

Offline I think there was a little discussion with Stolee about whether
it made more sense to *only* approach this specific problem with this
document, as the hooks are also config, and so they could come later.
But I think if we want to store the executable in the magic branch (and
I do... since I keep bringing it up :) ) then it doesn't make sense to
say "build it for config and everything else will follow".

> +* Extending this to support submodules: We want to make sure this works in a way
> +that's easy to adapt to submodules, who would likely need to run the same hooks
> +as the superproject; for example, submodules could inherit the superproject
> +config.

I'm hoping to send an RFC patch introducing such an inherited
superproject config ... very soon. I hope. So there wasn't much detail
provided here, intentionally.

> +* Sandboxing hook execution to provide higher levels of security.

I think this says: "Can we run a user hook in a container that only has
access to the repo in question?"

It sounds like a complicated answer. I could see legitimate reasons to
want wider access than just the container - for example, some
hook-specific configuration that doesn't fit the Git config format, or
even something like updating a stats file to keep a record of how many
commits I made/pushed/whatever every day, stored in a central location
for reference at performance review time :) But I also don't know alllll
that much about containerization - I think there are ways to hand over
access to other needed files like this, right?

But then, I also feel yucky thinking about Debian telling me that my Git
install also needs me to install Docker... :)

Worth thinking about and discussing at a later date, I'd guess.

> +[[prior-art]]
> +Prior Art
> +~~~~~~~~~

I wonder whether it's useful to mention (in mails, I guess, not in
the checked in doc) why these are bad - do they duplicate work between
each other? Are they engaging in bad practices when interfacing with
Git? etc.?

It would be a lot of work to collect, so maybe it's not that useful..


Thanks for writing up v2 / mailing it, Albert.

 - Emily
