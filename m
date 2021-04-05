Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA96C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C80D613D6
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhDEWpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhDEWpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:45:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407FCC06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 15:45:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o16so14269120ljp.3
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yUi/tIl9vm0YxAr1r0AmrngzLdw2XVIloGa8ssLEHRw=;
        b=Ln3o1Zo3wDKwDPWw7pCnhMcmNWzXwRmKv0YuJdP0NMZTk2mpaecZPrzNn9cZVgbBKH
         6UFeHg179zPZu9Gxab9ojUq3f66HUOcOHr4ydiTcYCvhPis3tyBE74mqj7xKFpRVXXRF
         RsCucb1u13oLLaEmD8wvgQ/50culp5mOXFNXEAIaRBnxEWYL6kVatVxZLXuUjU0xVc46
         fgkLZhWfZQbNevHwD6e+M6cOmh9mgYpQhHRNzua1cMUFukKAPXdshG/DU1z0SUXKSc7c
         5xSXuX1iwLLIVA9PaIFWyOBft82lgYIDJOXubhPIv6CXBlWMciXFVImmiiOczljTjO6y
         SGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yUi/tIl9vm0YxAr1r0AmrngzLdw2XVIloGa8ssLEHRw=;
        b=ipuGu1rJoGnsqYrUMgyN4hiM7mpHF1tdlWxdxmowrlmC8ssjxZVKM45pwsOZpDmynL
         LvLyAm94Qb1xOQSCwr/phto1IWEzQomD9g4jjhL1fQYCuf+ElfmmmDyyBlVV/gscQWPX
         HuqaYc4B6dlGoDb+Sbyqf8p+Q9wqo4S/qqwCf2MkiOoivfIFlRJZ0Hbs+iNdhD6KLcP5
         TQLn9oAxBq3psvh9aO2uL1oxzcQGf7ktLqQf2HqSG4TIBU9xoglo5ul6cnMAGarcXuSH
         maMPfSeDvAb/il2LFksP0cOmnU3eQN7rx3hDNgt7VkHrQRTOlu9OGI/0WyjU9nNafB/8
         tM5w==
X-Gm-Message-State: AOAM5316H6P282fLHDoqXrGQ2WDUEjkmNMcGgCVMIbWT84nZELKJUOgS
        i4DDjEBJuMYX4/8OXSPZ8s9JDB67YYi3oUngD8w=
X-Google-Smtp-Source: ABdhPJwW23DmIfGZaaehJ7Xb3qtbg/1ILL34qe3UDUEvFYghn7ogWwTp1DitknU1IIFJKEdgN0a8/G4IdWFJzsYR+v8=
X-Received: by 2002:a2e:7618:: with SMTP id r24mr17153591ljc.420.1617662722217;
 Mon, 05 Apr 2021 15:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
In-Reply-To: <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Mon, 5 Apr 2021 15:45:10 -0700
Message-ID: <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 8:24 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/25/2021 9:43 PM, Albert Cui via GitGitGadget wrote:
> > From: Albert Cui <albertqcui@gmail.com>
> >
> > Hooks today are configured at the repository level, making it difficult=
 to
> > share hooks across repositories. Configuration-based hook management, b=
y
> > moving hooks configuration to the config, makes this much easier. Howev=
er,
> > there is still no good way for project maintainers to encourage or enfo=
rce
> > adoption of specific hook commands on specific hook events in a reposit=
ory.
> > As such, there are many tools that provide this functionality on top of=
 Git.
> >
> > This patch documents the requirements we propose for this feature as we=
ll as
> > a design sketch for implementation.
>
> Sorry for being so late in reviewing this.
>
> My first reaction is that this feature is suggesting multiple security
> vulnerabilities as core functionality. It also seems to be tied to
> niche projects (in number of projects, not necessarily the size of those
> projects).
>

According to it's GitHub page, Husky [0] has 22M million monthly downloads =
and
is used by 437K projects. Many projects, both big (e.g. Android [1],
ChromeOS [2],
Angular [3], Webpack [4]) and small have use cases around hooks configurati=
on,
so I don't think it's fair to say this is only needed by niche projects.

> I was recommended in conversation to think of this as a way to take
> existing ad-hoc behavior and standardize it with a "Git-blessed"
> solution. I'm not sure this proposal makes a strong enough case for
> why having a "configure-hooks.sh" script in the base of the repo is
> not enough. It simultaneously does not use existing precedents like
> .gitattributes or .gitignore as direction in using the worktree at
> HEAD as a mechanism for communicating details. I find using a separate
> ref for hooks to be a non-starter and the design should be rebuilt from
> scratch.
>

Right, this entire proposal is trying to get to a "Git-blessed" solution,
and I should make the need clearer. A few reasons for standardizing
this come to mind:

1. Many existing "standard" solutions. A multitude of existing solutions fo=
r
this use case speaks to the fact that a basic config script is not sufficie=
nt.
I mentioned Husky above, but here are a few more; basically each
popular programming language environment has a solution for this.

https://github.com/sds/overcommit - Ruby
https://github.com/pre-commit/pre-commit - Python
https://github.com/Arkweid/lefthook - Go
https://github.com/shibapm/Komondor - Swift
https://github.com/typicode/husky - Node

These solutions all handle the installation and updating of hooks. A
"configure-hooks.sh" script doesn't handle hook updates, unless you go thro=
ugh
the trouble yourself of implementing and maintaining that.

2. External dependencies. The existing solutions require users to
either have those
toolchains already installed or an explicit installation step via an OS pac=
kage
manager, so there's a lot of friction for users, even when using these
standard solutions.
This functionality shouldn't require external dependencies, and most
certainly _how_ you
set up hooks shouldn't change depending on your coding environment.
Fixing this is only
possible in a world where Git supports this functionality natively.

3. Improving security. As you mentioned, hooks are difficult to get
right from a security
perspective, and standardizing on a single implementation allows us to
give developers
a well-vetted solution with a better security model than what exists
today. For example,
we're proposing making it very clear to users whenever there's a hook
update. This isn't
something that existing solutions do.

I'll also say in general, the Git project is much more likely to get
security right than smaller
projects, where oftentimes even popular projects end up unmaintained.

For the design feedback: what I'm hearing is that you'd prefer a
design that keeps configuration in the worktree. I'll leave discussion abou=
t
implementation to those on the list better suited :)

However, one thing that I should have mentioned in patch about the design
proposal (as Emily Shaffer touched upon in her response) is that since the
configuration is separate from the code base, it allows you to go back
in history
or to older branches while preserving "improvements" to the hooks configura=
tion
e.g. maybe the project has shifted to using a newer version of a linter.

This functionality has pros and cons. Bringing improvements to checks
can be useful
e.g. it's arguably better to bring older code up to newer code style.
But it also makes
it less possible to replicate the exact state of older history. This
is a problem that
server-side checks also have.

> I also expect that a significant portion of users will see a message
> like "this repository needs hooks" and will just say "yes" to get rid
> of the prompt. There needs to be sufficient opportunity for users to
> inspect the hook configuration and avoid frustrated or distracted users
> from doing the wrong thing.
>
> Server-side checks should always exist, so users who don't follow the
> project's guidelines using the recommended hooks will be blocked. The
> important thing is that there is an easy way for willing participants
> to install the correct hooks. This doesn't mean we should make it
> almost automatic.
>

What I'm hearing here is that you don't like the interactive prompt, as you
noted in the UX feedback below. Allowing users the chance to inspect the ho=
ok
configuration makes sense to call out explicitly as part of the security mo=
del.

> Also, please proactively pursue a security review of the feature,
> including non-technical risks such as social engineering, forks, or
> other possible attacks. This idea seems so risky that I would be
> against accepting it unless a security expert has done a thorough
> review.
>

Agreed. We already did a security review internally at Google. The main
feedback was:

* We need an explicit opt-in opposed to setting hooks up automatically,
e.g. a command line flag like --accept-hooks at minimum. This is primarily
to distinguish people who are just cloning a repository to browse the code
from people who are developing.

* The average user doesn't have the ability to review hooks in general
(security is hard and obscuration is easy), and if the user has
already opted into
this feature because they are engaged in development, it's very likely
that they're
already running build scripts, so the additional attack vector here doesn't=
 seem
like a big issue.

If there are other security folks I should seek advice from, please let me =
know.

[...]
> I think providing a way for repository owners to _recommend_ how cloners
> should interact with the repository is a good idea. I think starting with
> hooks is perhaps a significant jump to the most complicated version of
> that idea.
>
> As you think of this design, it might be good to think about how some
> recommended Git config (within an allow-list) might fit into this system
> as well. I would have started there, with things like "Use partial clone"
> or "use sparse-checkout". Those are really things that need to happen at
> clone time, they can't really happen after-the-fact, which helps justifyi=
ng
> a modification to 'git clone'. The hook configuration doesn't _need_ to
> happen during 'git clone'. More on this timing later.
>
> The .gitattributes file is the closest analogue I could find in current
> functionality, but it operates on a path-based scope, not repository scop=
e.

I am happy to extend this patch to talk about configuration in general with
a specific use case of suggesting hooks. However, I do want to separate out
"what should we do when?" from "should we do this?" Based on this feedback,
I'm hearing "we should have a design for suggested configuration in general=
,"
but I don't think that necessitates that we should implement, for
example, partial
clone configuration before hooks configuration.

>
> > +Server-side vs Local Checks
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ...
> > +In the ideal world, developers and project maintainers use both local =
and server
> > +side checks in their workflow. However, for many smaller projects, thi=
s may not
> > +be possible: CI may be too expensive to run or configure. The number o=
f local
> > +solutions to this use case speaks to this need (see <<prior-art, Prior=
 Art>>).
> > +Bringing this natively to Git can give all these developers a well-sup=
ported,
> > +secure implementation opposed to the fragmentation we see today.
>
> I'm not sure this is a good selling point for small projects. If they
> are small, then the CI to verify commits is cheap(er).
>
> Local hooks should never be used as a replacement for server-side checks.
> A user could always use a repository without the local hooks and push
> commits that have not been vetted locally. The extreme example is to have
> a commit hook that compiles the code and runs all the tests. Would you
> then remove all CI builds?
>
> Making it easier to adopt local hooks can avoid some pain points when
> users are blocked by the server-side checks.
>

Sorry, this wasn't meant to come off as "small projects don't need CI." It =
was
more to say, "small projects today are already primarily relying on
local checks,
so we should make that easier for them." I clarified that a bit here as wel=
l:
https://lore.kernel.org/git/CAMbkP-Q4_z-nQzJwr2ZeM16deHKmzr=3DZ4908UzgOyk9F=
A-gKEA@mail.gmail.com/T/#u

[...]

> I appreciate the motivation in this document. However, the motivation
> doesn't really justify why this should be baked into Git itself, since
> a "configure-repo" script in the base of the repo would suffice to
> achieve that functionality.
>
> The reason to put this in Git is to standardize this process so it
> is not different in each repository. It might be good to spend time
> justifying that angle.
>

Thank you for the feedback. I hope what I wrote above helps.

[...]
> > +* Trust comes from the central repository:
> > +  ** Most users don't have the time or expertise to properly audit eve=
ry hook
> > +  and what it does. There must be trust between the user and the remot=
e that the
> > +  code came from, and the Git project should ensure trust to the degre=
e it can
> > +  e.g. enforce HTTPS for its integrity guarantees.
> > +
> > +  ** Since developers will likely build their local clone in their dev=
elopment
> > +  process, at some point, arbitrary code from the repository will be e=
xecuted.
> > +  In this sense, hooks _with user consent_ do not introduce a new atta=
ck surface.
>
> It is critical that users are presented with this consent at the correct
> times. For instance, I believe configuring local hooks should only be
> done _after_ "git clone" completes. That allows a user to inspect the
> worktree to their content instead of in the middle of an interactive shel=
l
> session or something. (The "git clone" command could output a message to
> stderr saying "This repository recommends configuring local hooks. Run
> 'git <tbd>' to inspect the hooks and configure them.")
>
> We've had enough code-execution bugs with "git clone" that I want to
> completely avoid that possibility here.
>

Responding to this below in the "Consent through clone" section.

> > +* Give users visibility: Git must allow users to make informed decisio=
ns. This
> > +means surfacing essential information to the user in a visible manner =
e.g. what
> > +remotes the hooks are coming from, whether the hooks have changed in t=
he latest
> > +checkout.
>
> As a user moves HEAD, we should similarly avoid updating the hooks
> automatically, but instead present a message to the user to update their
> hooks using an intentional command.
>

Responding to this below.

> > +    ** This could be a path to a script/binary within the repository
>
> Binaries will be tricky if you want users of multiple platforms to
> interact with your repository. And scripts can be slower than binaries.
>
> How could someone build hooks from source using your workflow? Perhaps
> users are expected to locally compile the code before configuring the
> hooks?
>

"Binaries" was primarily referring to packages like pylint which are instal=
led
at the OS level. In an enterprise environment, these could be
installed automatically
for the user.

> > +    ** This could be a path to a script/binary contained within submod=
ules of
> > +    the repository
>
> This gives me significant chills. Proceed with caution here.
>
> I understand the reason to want this feature: you could have a suite
> of repositories using a common hook set that lives in each as a
> submodule. I just want to point out that this adds yet another
> dimension for attack.
>

If we notify users about changes, both to hook commands and to the
underlying source files, we can make this safer.

> > +    ** This could be a user installed command or script/binary that ex=
ists
> > +    outside of the repository and is present in `$PATH`
>
> Like `rm -rf ~/*`? I'm trying to think of dangerous things to do without
> elevation. It could help here to clarify the intended user pattern here:
> "This repository requires that you install tool X." This seems unlikely
> to be necessarily true at clone time, so the users will have a broken
> state if they don't run some extra steps. How will that be communicated?
>
> Requirements like these make me think that these repositories would be
> better off with a script that configures the hooks after checking if
> these things actually exist on the PATH (and installs them if not). I
> would lower the priority of this one for now.
>

As mentioned, for enterprise deployments, this can be solved by administrat=
ors
installing any necessary software automatically.

Otherwise, I think ensuring the tool is installed feels out-of-scope
(as written in
the doc); it's not like Git makes sure compilers or build tools are
installed today,
and even today, users could set up Husky hooks that rely on $PATH tools, so
we're not introducing a new problem.

Some day, maybe we could have a `post-clone` and `post-checkout` hooks,
but I think this is all out-of-scope of the immediate discussion.

> > +* This configuration should only apply if it was received over HTTPS
>
> Avoiding http:// and git:// makes sense. Why not SSH?
>

Left off SSH accidentally! Definitely makes sense to include.

> > +* A setup command for users to set up hooks
> > +
> > +    ** Hook setup could happen at clone time assuming the user has con=
sented
> > +    e.g. if `--setup-hooks` is passed to `git clone`
>
> This is not enough consent.
>

I hear what you're saying. How would you feel if this specific
functionality was behind
config (that enterprise environments could ship)? What I'm thinking:

```
#~/.gitconfig
[hook]
   allowCloneInstallFromRemote =3D $REMOTE
```

IFF $REMOTE matches the config, then `git clone $REMOTE --setup-hooks` work=
s.

(We could even get rid of --setup-hooks and rename the config to
hook.installOnCloneFromRemote but I think requiring user consent is
still best here.)

> > +* Users must explicitly approve hooks at least once
> > +
> > +    ** Running the setup command should count as approval, including i=
f the user
> > +    consented during the clone
> > +
> > +    ** When a hook command changes, a user should re-approve execution=
 (note:
> > +    implementation should not interfere with requirement listed in =E2=
=80=9CFast
> > +    Follows")
>
> Users should explicitly approve hooks any time they would change.
> They should also be able to explore the source of the change using
> whatever editors and tools they want, so the worktree should change
> to its new state without new hooks, _then_ the user could consider
> updating hooks based on that new state.
>

As mentioned above, developers will execute code locally anyway when buildi=
ng.
Do you think allowing users to opt-into hook updates significantly
increases the attack
surface? I should note that existing solutions already do hook updates
automatically and
silently (since they use a trampoline script); this proposal is safer
from that given
1) we ask users to opt into auto updates and 2) we warn users about changes=
.

> > +Fast Follows
> > +^^^^^^^^^^^^
> > +
> > +* When prompted to execute a hook, users can specify always or never, =
even if
> > +the hook updates
>
> I don't understand what this means. "when prompted to execute a hook" are=
 you
> saying that the user will get a message saying "Git will now run the pre-=
commit
> hook, are you ok with that?"
>

This should say "When prompted to install a hook, users can specify always =
or
never, even if the hook updates. For security, this consent should be tied =
to
a specific remote."

[trimming some duplicate points]

> > +# instead of prompting, we could give users commands to run instead
> > +# see case 3
> > +
> > +Do you wish to install them?
> > +1. Yes (this time)
> > +2. Yes (always from origin)
> > +3. No (not this time)
> > +4. No (never)
>
> I'd rather see the installation as a separate step. That gives more
> weight to the users' consent. Even if you do have a prompt here that
> says Yes/No, *do not* include "always from origin".
>
> > +=3D=3D=3D=3D=3D Case 3: Re-prompting when hooks change
> > +....
> > +$ git pull
> > +
> > +The following hooks were updated from remote `origin` ($ORIGIN_URL):
> > +
> > +pre-push:  $GIT_ROOT/pre_push.sh
> > +
> > +If you wish to install them, run `git hook setup origin`.
>
> Good. Stop here. Perhaps also describe this as something that happens
> with "git checkout" because it matters when HEAD updates, even if the
> commit was fetched earlier.
>

Sure, case 3 seems like a reasonable path to pursue. Sounds like auto-updat=
ing
is the main point of contention here.

[...]

> > +Implementation Sketch
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +* Perform fetch as normal
> > +
> > +* After fetch is complete, Git checks for a "magic" config branch (e.g=
.
> > ++origin/refs/recommended-config+) which contains information about con=
fig lines
> > +an end-user may want (including hooks).
>
> I think this is the wrong direction to go. You are recommending a few thi=
ngs:
>
> 1. Some branch names are more special than others.
> 2. Hooks live in a separate history than the rest of the repository.
> 3. Users cannot inspect the hooks in their worktree before installation.
>
> Instead, think about things like .gitignore and .gitattributes, as they c=
an
> change as the repository changes. Make a special _filename_ or directory:
> for example ".githooks/".
>

#2 is a feature, as mentioned above, but certainly just a
"nice-to-have." I agree we'd
need a solution to #3.

Thanks for all the feedback!

Albert

[0] https://github.com/typicode/husky
[1] https://android.googlesource.com/platform/tools/repohooks/
[2] https://chromium.googlesource.com/chromiumos/docs/+/HEAD/contributing.m=
d#Upload-changes
[3] https://github.com/angular/angular/tree/master/.husky
[4] https://github.com/webpack/webpack/tree/master/.husky
