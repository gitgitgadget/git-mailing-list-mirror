Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53EC61DA3
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBVBon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBVBom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:44:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC231A971
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:44:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so370905pjn.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQaSeO3+w7O6SDa8iPy2l/5LwuC/T0SMrO2WhYeuNlk=;
        b=gVsNzhmi59cdkegGXb2Xm0lIrJ5SQQ0Ra1qadrttR7oT7OqwSu+f7poawz/0S1cro7
         Ywz5MaaK1QZiykqTOKAUjvTjyzYuqwz+QK8IeMEEpPlfsyEhgX3zWWwBmN7bOdQ/UIBA
         rppdwa54CaCqwFhrzrM083kA51QjWwdrXE5SPZMIFGFTjVVqM1kzzwz0XngFH/rDLkDR
         8UPCGYawFHianQ61XQvYRPwhE47Oz6yNntCGC0SjN+khAcCZHGId8rKJNQF8QifSeeVx
         jwEgdKhArBvx4nZrVPvysHl/wZTLbYUalndM1igTBHs4MEOmBoo6X++nIvTCeJvQhizw
         Ry8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQaSeO3+w7O6SDa8iPy2l/5LwuC/T0SMrO2WhYeuNlk=;
        b=i9noHtsChXBNpFlptJ7tD/cQ7L2ZyFEYNqg02gre7/TZ47nXSxfEE/hdUSWeqgs6Ym
         G5eAYFAQecS2L/gu6F5Aeyhxqm5zTUyuF5RvtwA4YDCsYO8KoIVCTOMgUVTcfk6Jnec8
         pDHPxh9LeyNhsKKhrefoP2ql3IUguFTur3s0Bjf5JiZcnz9Tzn37ZUwOlSeEvkrtNcwD
         aPpHOSgSR6gvT/ytk0wU9fLcLLXkTGnBk/DsFGB+a9MgeNyQdEgoKR5N2+lhFbKHFAGT
         SFyDT1R9yZ0Ba5SmatS9ulo8LvdlXwI5vh5GoHKcSSJ3oScad70+roXB5UnHpAaHdQnT
         afvw==
X-Gm-Message-State: AO0yUKUv9ERnS6npzKuIQU+Q9CeXUWKvf7e7QH/dROy9iHHSW+RdG3GO
        C2LjCDREam3kl2wCDGk1NBjZ
X-Google-Smtp-Source: AK7set/5CpuRnNOrHgGYwXloHrUEjkXIokF3wUdkS/AxHoFyPQp7UzwuMBYvhsxGZuWTD3DHcshLVw==
X-Received: by 2002:a17:903:41d1:b0:19a:a2d8:f252 with SMTP id u17-20020a17090341d100b0019aa2d8f252mr9088484ple.27.1677030278807;
        Tue, 21 Feb 2023 17:44:38 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902758300b00199309531d5sm3329957pll.172.2023.02.21.17.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 17:44:38 -0800 (PST)
Message-ID: <86e7f589-7576-5ed3-3dc9-5dec9ca346eb@github.com>
Date:   Tue, 21 Feb 2023 17:44:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Content-Language: en-US
To:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> Hi folks,
> 
> As I mentioned in standup this week[1], my colleagues and I at Google
> have become very interested in converting parts of Git into libraries
> usable by external programs. In other words, for some modules which
> already have clear boundaries inside of Git - like config.[ch],
> strbuf.[ch], etc. - we want to remove some implicit dependencies, like
> references to globals, and make explicit other dependencies, like
> references to other modules within Git. Eventually, we'd like both for
> an external program to use Git libraries within its own process, and
> for Git to be given an alternative implementation of a library it uses
> internally (like a plugin at runtime).

I see why you've linked these two objectives (there could be some shared
infrastructure between them), but they're ultimately separate concerns, with
separate needs & tradeoffs. By trying to design with a unified solution for
both, though, this proposal's solution may be broader than it needs to be
and comes with some serious developer experience ramifications.

For example, looking at the  "call libgit.so from other applications"
objective: one way I could imagine implementing this is by creating a stable
API wrapper around various hand-picked internal functions. If those internal
functions change (e.g., adding a function argument to handle a new flag in a
builtin), the API can remain stable (by setting a sane default) without
really limiting the contributor adding a new feature. 

However, my reading of this proposal (although correct me if I'm wrong) is
that you want to use that same external-facing API as a plugin interface for
Git. In that case, the contributor can't just add a new argument and
trivially modify the wrapper; they either break the API contract, or create
a new version of the API and continue to support the old one. While that's
technically doable, it's a pretty sizeable increase to the amount of "stuff"
contributors need to keep track of and limits the project's flexibility. 

> 
> This turned out pretty long-winded, so a quick summary before I dive in:
> 
> - We want to compile parts of Git as independent libraries
> - We want to do it by making incremental code quality improvements to Git
> - Let's avoid promising stability of the interfaces of those libraries
> - We think it'll let Git do cool stuff like unit tests and allowing
> purpose-built plugins
> - Hopefully by example we can convince the rest of the project to join
> in the effort
> 
> My team has spent the past year or so trying to make improvements to
> Git's behavior with submodules, and we found that the current
> structure of Git is quite tricky to work with: because Git doesn't
> execute on second repositories in the same process well, recursing
> into submodules typically involves spawning child processes, and
> piping new arguments through the helpers around those child processes,
> and then through Git's typical codepaths, is very tricky. After
> spending more than a year trying to make improvements, we have very
> little to show for it, largely as a result of the difficulty of
> passing information between superprojects and submodules.
> 
> It seems like being able to invoke parts of Git as a library, or Git
> being able to invoke custom libraries, does a lot of good for the Git
> project:
> 
> - Having clear, modular libraries makes it easy to find the code
> responsible for some behavior, or determine where to add something
> new.

This is more an issue of code & repository organization, and isn't really an
inherent outcome of lib-ifying Git. That said, like the cleanup you mention
later, I would not be opposed to a dedicated code reorganization proposal.

> - Operations recursing into submodules can be run in-process, and the
> callsite makes it very clear which repository context is being used;
> if we're not subprocessing to recurse, then we can lose the awkward
> git-submodule.sh -> builtin/submodule__helper.c -> top-level Git
> process codepath.

Interesting - I wasn't aware this was how submodules worked internally. Is
there a specific reason this can't be refactored to perform the recursion
in-process?

> - Being able to test libraries in isolation via unit tests or mocks
> speeds up determining the root cause of bugs.

The addition of unit tests is a project of its own, and one I don't believe
is intrinsically tied to this one. More on this later.

> - If we can swap out an entire library, or just a single function of
> one, it's easy to experiment with the entire codebase without sweeping
> changes.

What sort of "experiment" are you thinking of here? Anyone can make internal
changes to Git in their own clone of the repository, then build and test it.
Shipping a custom fork of Git doesn't seem any less complex than building a
plugin library, shipping that, and injecting it into an existing Git
install.

> 
> The ability to use Git as a library also makes it easier for other
> tooling to interact with a Git repository *correctly*. As an example,
> `repo` has a long history of abusing Git by directly manipulating the
> gitdir[2], but if it were written in a world where Git exists as
> easy-to-use libraries, it probably wouldn't have needed to, as it
> could have invoked Git directly or replaced the relevant modules with
> its own implementation. Both `repo`[3] and `git-gui[4]` have
> reimplemented logic from git.git. Other interfaces that cooperate with
> Git's filesystem storage layer, like `scalar` or `jj`[5], would be
> able to interop with a Git repository without having to reimplement
> custom logic or keep up with new Git changes.

I'd alternatively suggest that these use cases could be addressed with
better plumbing command support and better (public) documentation of our
on-disk data structures. In many cases, we're treating on-disk data
structures as external-facing APIs anyway - the index [1], packfiles [2],
etc. are versioned. We could definitely add documentation that's more 
directly targeted at external integrators.

[1] https://git-scm.com/docs/index-format
[2] https://git-scm.com/docs/gitformat-pack

> 
> Of course, there's a reason Google wants it, too. We've talked
> previously about wanting better integration between Git and something
> like a VFS; as we've experimented with it internally, we've found a
> couple of tricky areas:
> 
> - The VFS relies on running Git commands to determine the state of the
> repository. However, these Git commands interact with the gitdir or
> worktree, which is populated by the VFS. For example, parsing a
> .gitattributes or .gitmodules which is already stored in the VFS
> requires the VFS to provide a POSIX file handle, spawn a Git
> subprocess, populate other files needed by that subprocess (like
> .git/config), and finally collect the output stream of the subprocess.
> As you can imagine, this interaction of VFS -> Git -> VFS [-> Git]
> creates all sort of complications. The alternative is for the VFS to
> write its own parser (or use a library like libgit2; more on that
> later). But having a Git library means that a subset of Git
> functionality can happen in-process, and that filesystem access could
> be replaced by the VFS directly providing high-level objects or plain
> bytestreams.
> 
> - A user running `git status` in a directory controlled by the VFS
> will require the VFS to populate the entire (large) worktree - even
> though the VFS is sure that only one file has been modified. The
> closest we've come with an alternative is an orchestrated use of
> sparse-checkout - but modifying the sparse-checkout configs
> automatically in response to the user's filesystem operations takes us
> right back to the previous point. If Git could take a plugin and
> replacement for the object store that directly interacts with the VFS
> daemon, a layer of complexity would disappear and performance would
> improve.

Both of these points sound more like implementation details/quirks of the
VFS prototype you're building than hard blockers coming from Git. For
example, you mention 'git status' needing to populate a full worktree -
could it instead use a mechanism similar to FSMonitor to avoid scanning for
files you know are virtualized? While there'd likely be some Git changes
involved (some of which might be a bit plugin-y), they'd be much more
tightly scoped than full libification.

> The good news is that for practical near-term purposes, "libification"
> mostly means cleanups to the Git codebase, and continuing code health
> work that the project has already cared about doing:
> 
> - Removing references to global variables and instead piping them
> through arguments
> - Finding and fixing memory leaks, especially in widely-used low-level code
> - Reducing or removing `die()` invocations in low-level code, and
> instead reporting errors back to callers in a consistent way
> - Clarifying the scope and layering of existing modules, for example
> by moving single-use helpers from the shared module's scope into the
> single user's scope
> - Making module interfaces more consistent and easier to understand,
> including moving "private" functions out of headers and into source
> files and improving in-header documentation
> 
> Basically, if this effort turns out not to be fruitful as a whole, I'd
> like for us to still have left a positive impact on the codebase.

These cleanups/best practices are a great idea regardless of any potential
lib-ification. I'll be sure to keep them in mind in any future changes I
make or review.

> 
> In the longer term, if Git has libraries with easily-replaced
> dependencies, we get a few more benefits:
> 
> - Unit tests. We already have some in t/helper/, but if we can replace
> all the dependencies of a certain library with simple stubs, it's
> easier for us to write comprehensive unit tests, in addition to the
> work we already do introducing edge cases in bash integration tests.

This doesn't really follow as a direct consequence of making libgit
externally facing. AFAIK, there's nothing explicitly stopping us from
writing or integrating a unit test framework now.

Like the "make libgit public" vs. "allow for custom backends in Git", I
think this is a separate project with its own tradeoffs to evaluate.

> - If our users can use plugins to improve performance in specific
> scenarios (like a VFS-aware object store in the VFS case I cited
> above), then Git works better for them without having to adopt a
> different workflow, such as using an alternative tool or wrapper.

I'm curious as to what you want the user experience for this to look like.
How would Git know to dynamically load a plugin? How does a user configure
(or disable) plugins? Will a plugin need to replace all of the functions in
a given library, or would Git be able to "fall back" on its own internal
implementation?

> - An easy-to-understand modular codebase makes it easy for new
> contributors to start hacking and understand the consequences of their
> patch.

As noted earlier, I think improving the developer experience in this way is
independent of the development of external APIs.

> 
> Of course, we haven't maintained any guarantee about the consistency
> of our implementation between releases. I don't anticipate that we'll
> write the perfect library interface on our first try. So I hope that
> we can be very explicit about refusing to provide any compatibility
> guarantee whatsoever between versions for quite a long time. On
> Google's end, that's well-understood and accepted. As I understand,
> some other projects already use Git's codebase as a "library" by
> including it as a submodule and using the code directly[6]; even a
> breakable API seems like an improvement over that, too.

This hints at, but sidesteps, a really important aspect of the long-term
goals of this project - are you planning on having us start guaranteeing
consistency once there's an external-facing API available? 

If not, that sounds like an unpleasant user experience (and one prone to
Hyrum's Law [3] at that). 

If so, Git contributors will either be much more constrained in the
introduction of new features, or we'll end up with a mess of
backward-compatibility APIs.

[3] https://www.hyrumslaw.com/

> 
> So what's next? Naturally, I'm looking forward to a spirited
> discussion about this topic - I'd like to know which concerns haven't
> been addressed and figure out whether we can find a way around them,
> and generally build awareness of this effort with the community.
> 
> I'm also planning to send a proposal for a document full of "best
> practices" for turning Git code into libraries (and have quite a lot
> of discussion around that document, too). My hope is that we can use
> that document to help us during implementation as well as during
> review, and refine it over time as we learn more about what works and
> what doesn't. Having this kind of documentation will make it easy for
> others to join us in moving Git's codebase towards a clean set of
> libraries. I hope that, as a project, we can settle on some tenets
> that we all agree would make Git nicer.

I think the use of multiple libraries is part of the potentially suboptimal
balance between the "load Git's internals as a library" and "let Git use
plugins in place of its own implementations" goals. The former could leave a
user in dependency hell if there are lots of small libraries to load, while
the latter may work better with smaller-scoped libraries (to avoid needing
to implement more than is useful). And, the functionality that's useful to a
program invoking Git via library may not be the same as what someone would
want to replace via plugin. 

> 
> From the rest of my own team, we're planning on working first on some
> limited scope, low-level libraries so that we can all see how the
> process works. We're starting with strbuf.[ch] (as it's used
> everywhere with few or no dependencies and helps us guarantee string
> safety at API boundaries), config.[ch] (as many external tools are
> probably interested in parsing Git config formatted files directly),
> and a subset of operations related to the object store. These starting
> points are intended to have a small impact on the codebase and teach
> us a lot about logistics and best practices while doing these kinds of
> conversions.
> 
> After that, we're still hoping to target low-level libraries first - I
> certainly don't think it will make sense to ship a high-level `git
> commit` library in the near future, if ever - in the order that
> they're required from the VFS project we're working closely with. As
> far as I can tell right now, that's likely to cover object store and
> worktree access, as well as commit creation and pushing, but we'll see
> how planning shakes out over the next month or so. But Google's
> schedule should have no bearing on what others in the Git project feel
> is important to clean up and libify, and if there is interest in the
> rest of the project in converting other existing modules into
> libraries, my team and I are excited to participate in the review.

As a general note, this libification project - its justification,
milestones, organization, etc. - seems to be primarily driven by the needs
of a VFS that is entirely opaque to the Git community you're proposing to.
As it stands, reviewers are put in a position of needing to accept, without
much evidence, that this is the best (or only) possible approach for meeting
those needs. 

While I'm normally content with "scratch your own itch"-type changes, what
you're proposing is a major paradigm shift in how Git is written,
maintained, and used. I'm not comfortable accepting that level of impact
without at least being able to evaluate whether the problem can be solved
some other way.

> 
> Much, much later on, I'm expecting us to form a plan around allowing
> "plugins" - that is, replacing library functionality we use today with
> an alternative library, such as an object store relying on a
> distributed file store like S3. Making that work well will also likely
> involve us coming up with a solution for dependency injection, and to
> begin using vtables for some libraries. I'm hoping that we can figure
> out a way to do that that won't make the Git source ugly. Around this
> time, I think it will make sense to buy into unit tests even more and
> start using an approach like mocking to test various edge cases. And
> at some point, it's likely that we'll want to make the interfaces to
> various Git libraries consistent with each other, which would involve
> some large-scale but hopefully-mechanical refactors.

Implementing dependency injection (via vtable or otherwise) and unit test
mocking is a massive undertaking on its own, let alone everything else
described so far. You've outlined some clear, fairly unobtrusive first steps
to the overarching proposal, but there's a lot of detail missing from the
plans for later steps. While there's always risk of a project getting
derailed or blocked later on due to some unforeseen issue, that risk seems
particularly high here given the size & scope of all of these components. 

Intermediate milestones/goals, each of which is valuable on its own,
outlined in the proposal would help allay those fears (for me, at least).

> 
> I'm looking forward to the discussion!
> 

So, to summarize my thoughts into some (hopefully) actionable feedback:

- It's really important that the proposal presents a clear, concrete
  long-term vision for this project. 
  - What is the desired end state, in terms of what is built and installed
    with Git?
  - What will be expected of other Git contributors to support this design?
    What happens if someone wants to "break" an API?
  - What is the impact to users (including security implications)?
- The scope for what you've proposed is pretty huge (which comes with a lot
  of risk), but I think it could be broken into smaller, *independent*
  pieces. 
- It's hard to judge or suggest adjustments to this proposal without knowing
  the specific challenges you're facing with Git as it is.

Finally, thanks for sending this email & starting a discussion. It's an
interesting topic and I'm looking forward to seeing everyone's perspectives
on the matter.

>  - Emily
> 
> 1: https://colabti.org/irclogger/irclogger_log/git-devel?date=2023-02-13#l29
> 2: https://gerrit.googlesource.com/git-repo/+/refs/heads/main/docs/internal-fs-layout.md
> 3: https://gerrit.googlesource.com/git-repo/+/refs/heads/main/git_config.py
> 4: https://github.com/git/git/blob/master/git-gui/git-gui.sh#L305
> 5: https://github.com/martinvonz/jj
> 6: https://github.com/glandium/git-cinnabar

