Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41395C64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 14:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjBVOzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjBVOzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 09:55:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7F311FB
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 06:55:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id bq17so8216742oib.8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OSNLZtpr7EwFCyaDh6qAbyQlNInrvftsfr42+AzVKA=;
        b=jI9Y23vZeWnDvJcqCsK+qjRUD+68m1c3sMXkP+xia0xoa+sdy/p1Z63t5h1reqHVso
         PNilzTT6n9pVtGeezdGujD4Cg58jtG+8oQLpHXeNX0e1VWhRoctHALjtlugC2mNCnK8S
         CY7Kw+H5+wwGyYrR/XMKKb6sIWBwo25ZFiJPaZV7yGcmt0Qic+6ImjrTktJRshv275zQ
         lzVih0EWbF78ohJz3M1V77psLSq/duOWKqElu00Zfsq51K8fBTguFa0mdUz0HzqmAfBt
         P3QZyIPllTZFSFBfA/KGFsnPYfwjpV7CMDTcFc5cl7DIwFVfJf0tSjqukppaByW0Cv1F
         dsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OSNLZtpr7EwFCyaDh6qAbyQlNInrvftsfr42+AzVKA=;
        b=7EXEu9+jbfyir7uBvYDmdC9DtKfcoFMXw6ANp5sehMMY4NYBZi0xQHnte9uJZ+HwHj
         mBbmjvUFYFDDT9bsQ1vHpJ+pRpiHq4RkIlTfEckSvEIk0KAKx3x28j1gz8eBtgKSJnYs
         9p5V38lszz+VlsSCwGNDvrYBxCtWJVY0R8H6U8e1NC38+D6+k5Lg1Amt7f7E7iEFjHYg
         byacYjPhXlZFiJ5dMBk1bskCVI0fw/E7NQRSg1UCBzjrE12b1chxM9BLSgUsuxowa3j6
         0VAE6vrlAtiavQFdscObFOxlRWkkxw5Sc8x07hBUvC6PIfwXwoAKbiOS09ksyqsQXsL3
         xriw==
X-Gm-Message-State: AO0yUKVD/jr4aWlg3Jbhg4+6pmdtEpBK3uOZffQNhR12UlIozZmAlpuX
        B6PSRr//O7sUYvjKEnGha2VJ
X-Google-Smtp-Source: AK7set9dwBzCktjDkq+j6L+tj8NCmx0M4uDVgNIhKw7SHBfWvMT1w7Ulf3b+rP7E3tzUIL7UgTH7sQ==
X-Received: by 2002:a05:6808:485:b0:378:648:afec with SMTP id z5-20020a056808048500b003780648afecmr3689409oid.30.1677077742026;
        Wed, 22 Feb 2023 06:55:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:fde2:9814:beb7:963c? ([2600:1700:e72:80a0:fde2:9814:beb7:963c])
        by smtp.gmail.com with ESMTPSA id p124-20020acaf182000000b00383c76d07b3sm1073705oih.52.2023.02.22.06.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:55:41 -0800 (PST)
Message-ID: <13e0737a-7d66-7122-9dab-f7659948cda3@github.com>
Date:   Wed, 22 Feb 2023 09:55:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/17/2023 4:12 PM, Emily Shaffer wrote:

> This turned out pretty long-winded, so a quick summary before I dive in:
>
> - We want to compile parts of Git as independent libraries
> - We want to do it by making incremental code quality improvements to Git
> - Let's avoid promising stability of the interfaces of those libraries
> - We think it'll let Git do cool stuff like unit tests and allowing
> purpose-built plugins
> - Hopefully by example we can convince the rest of the project to join
> in the effort

As I was thinking about this proposal, I realized that my biggest concern
is that we are jumping to the "what" and "how" without fully exploring the
"why"s, so I've reorganized some of your points along those lines, so I
can respond to each in turn.

## Why: Modular code

> - Having clear, modular libraries makes it easy to find the code
> responsible for some behavior, or determine where to add something
> new.

> - An easy-to-understand modular codebase makes it easy for new
> contributors to start hacking and understand the consequences of their
> patch.

Generally, having a modular codebase does not guarantee that things are
easy to find or that consequences are understood. The correct abstractions
are key in this, as well as developing boundaries that do not leak into
each other.

Unless done correctly, we can have significant issues with how things are
communicated through layers of abstraction. We already have that problem
when we want to add a new option to a builtin and need to modify three or
four method prototypes in order to communicate a change of behavior to the
right layer.

I've also found that where we have abstractions, such as the refs code or
the transport code, that the indirection created by the vtables is more
confusing to discover by reading the code. I've needed the use of a
debugger to even discover the call stack for certain operations.

> - If we can swap out an entire library, or just a single function of
> one, it's easy to experiment with the entire codebase without sweeping
> changes.

I don't understand this one too much. We already have this ability through
forking the repository and mutating the code to do different things. Why
do we need modules (with vtables and all the rest of the pain that goes
into it) to make such swaps?

This only really matters in the fullness of the libification effort: if
everything is mocked, then subsystems can be replaced wholesale. That's a
lot of work just to avoid experimenting with a fork.

...

You said this about how to achieve modular code:

> - Removing references to global variables and instead piping them
> through arguments
> - Finding and fixing memory leaks, especially in widely-used low-level code
> - Reducing or removing `die()` invocations in low-level code, and
> instead reporting errors back to callers in a consistent way
...
> - Making module interfaces more consistent and easier to understand,
> including moving "private" functions out of headers and into source
> files and improving in-header documentation

I think these mechanisms should be universally welcomed. One thing that is
tricky is how we can guarantee that an API can be marked as "done" and
maintained that way in perpetuity. (Unit tests may help with that, so
let's come back to this then.)

> - Clarifying the scope and layering of existing modules, for example
> by moving single-use helpers from the shared module's scope into the
> single user's scope

This one is a bit murky to me. It sounds like that if there is only one
caller to a strbuf_*() method that it should be made 'static' inside the
caller instead of global in strbuf.h for use by future callers. Making
this a goal in itself is probably more likely to see methods moving around
more frequently due to the frequency of their use, rather than natural
groupings based on which data structures are being mutated.

What measurement would we optimize for? How could we maintain such
standards as we go? The Git codebase doesn't really have a firm
"architecture" other than "builtin code calls libgit.a code, which calls
other libgit.a code as necessary". There aren't really strong layers
between things. Everything assumes it can look up an object or load
config. Are there organizational things that we can do in this space that
would help decoupling things before jumping to libification?


## Why: Submodules

> - Operations recursing into submodules can be run in-process, and the
> callsite makes it very clear which repository context is being used;
> if we're not subprocessing to recurse, then we can lose the awkward
> git-submodule.sh -> builtin/submodule__helper.c -> top-level Git
> process codepath.

Previously, there was an effort to replace dependencies on the_repository
in favor of repository structs being passed through method parameters.
This seems to have fallen off of the priority list, and prevous APIs that
were converted have regressed in their dependencies.

Should we consider restarting that effort as an early goal? Should a
repository struct be the "god object" that also includes the default
implemenations of these modules until the modules can be teased apart and
no longer care about the entire repository?

## Why: Unit testing

> - Unit tests. We already have some in t/helper/, but if we can replace
> all the dependencies of a certain library with simple stubs, it's
> easier for us to write comprehensive unit tests, in addition to the
> work we already do introducing edge cases in bash integration tests.

Unit tests are very valuable in keeping the codebase stable and reducing
the chance that code was mutated by accident. This is achieved by very
rigid test infrastructure, requiring _replacing_ methods with mocks in
careful ways in order to test that behavior matches expectation. The
"simple stubs" are actually carefully crafted to verify their inputs and
provide a carefully selected return value.

The difficulty of writing unit tests (or mutating the code after writing
unit tests) is balanced by the ability to more explicitly create error
conditions that are unlikely to occur in real test cases. Cases such as
connection errors, file I/O problems, or other unexpected responses from
the mocked methods, are all relatively difficult to check via end-to-end
tests.

I've personally found that the hardest unit test to write is the _first_
one, and after that the rest are simpler. The difficulty arises in making
the code testable in the first place, as well as creating infrastructure
for the most-common unit test scenarios. My expectation is that it will
take significant changes to the Git codebase to make any non-trivial unit
tests outside of these very isolated cases that are presented here: strbuf
manipulation is easy to unit-test and config methods operating on
config_set structs should be similar. However, config methods that
interact with a repository and its config file(s) will be much harder to
test unless we start mocking filesystem interactions. We could create
test-tool helpers that load a full repository and check the config files
present on the filesystem, but now we're talking about integration tests
instead of unit tests.

> - Being able to test libraries in isolation via unit tests or mocks
> speeds up determining the root cause of bugs.

I'm not sure I completely agree with this statement. Unit tests can help
prevent introducing a new fault when mutating code to adjust for a bug,
but unit tests only guarantee expected behavior on the expected
preconditions. None of this necessarily helps finding a root cause,
especially in the likely event that the root cause is due to combining
units and thus not covered by unit tests.

## Why: Correct use

> The ability to use Git as a library also makes it easier for other
> tooling to interact with a Git repository *correctly*.

Is there is a correct way to interact with a Git repository? We definitely
prefer that the repository is updated by executing Git processes, leaving
all internals up to Git. Libification thus has a purpose for scenarios
that do not have an appropriate Git builtin or where the process startup
time is too expensive for that use.

However, would it not be preferrable to update Git to include these use
cases in the form of new builtin operations? Even in the case where
process startup is expensive, operations can be batched (as in 'git
cat-file --batch').

> Of course, we haven't maintained any guarantee about the consistency
> of our implementation between releases. I don't anticipate that we'll
> write the perfect library interface on our first try. So I hope that
> we can be very explicit about refusing to provide any compatibility
> guarantee whatsoever between versions for quite a long time. On
> Google's end, that's well-understood and accepted. As I understand,
> some other projects already use Git's codebase as a "library" by
> including it as a submodule and using the code directly[6]; even a
> breakable API seems like an improvement over that, too.

One thing we _do_ prioritize is the CLI as being backwards-compatible as
possible. We already have that interface as a stable one that can be
depended upon, even when the Git executable is built from a fork with
different implementations of subsystems (or operating differently in the
presence of custom config).

## Why: Virtual Filesystem Support

> Of course, there's a reason Google wants it, too. We've talked
> previously about wanting better integration between Git and something
> like a VFS; as we've experimented with it internally, we've found a
> couple of tricky areas:
>
> - The VFS relies on running Git commands to determine the state of the
> repository. However, these Git commands interact with the gitdir or
> worktree, which is populated by the VFS.

The way VFS for Git solved this was to not virtualize the gitdir and to
pass immediately to the filesystem if a worktree file was already
"hydrated". Of course, an early version was virtualizing the gitdir,
including faking that every possible loose object was present and could be
found via a network call, but the same issues you are bringing up now were
blockers for that approach.

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

This is another case where the issue is that Git isn't aware that it is
operating in a virtual environment and doesn't speak to the virtualization
system directly. Git could talk to the virtualization layer as if it was a
filesystem monitor, and that would prevent a significant amount of these
changes. Preventing 'git checkout' from writing files to the worktree also
requires some coordination. The virtualization layer needs a signal that
it will need to update its projection of the worktree (the
post-index-change hook can do this)  and the Git process needs a way to
mark the index with skip-worktree bits for the changed files (while
keeping the bits off for files that were previously hydrated and not
changed by the index update).

In this sense, we already have _some_ of the pluggability (through hooks)
and could extend that ability more either via more hooks or by making Git
itself aware that it's in a virtual filesystem. This pluggability could be
extended by using pipe-based communication like the builtin FS Monitor,
except that the communication is a new protocol that can speak to an
arbitrary implementation on the other side.

I've said before that the goal of using git.git with a virtual filesystem
(as-is, no custom bits) is unlikely to succeed _unless_ there are changes
contributed to git.git to make it aware of a "filesystem virtualizer". I
also don't think that inserting plugins is the right way to solve for
this. Users will want to use the Git CLI on their PATH for both virtual
and non-virtual repositories, so the distinction between them needs to
happen at runtime, likely via Git config, hooks, or protocols.

## How to achieve these goals

> I'm also planning to send a proposal for a document full of "best
> practices" for turning Git code into libraries (and have quite a lot
> of discussion around that document, too). My hope is that we can use
> that document to help us during implementation as well as during
> review, and refine it over time as we learn more about what works and
> what doesn't. Having this kind of documentation will make it easy for
> others to join us in moving Git's codebase towards a clean set of
> libraries. I hope that, as a project, we can settle on some tenets
> that we all agree would make Git nicer.

I like the idea of a "best practices" document, but I would hesitate to
focus on the libification and instead aim for the high-value items such
as lack of globals and reduced memory leaks. How do we write such code?
How do we write (unit?) tests that guarantee those properties will be
maintained into the future?

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

I can see that making a library version of config.h could be helpful to
third parties wanting to read Git config. In particular, I know that Git
Credential Manager runs multiple 'git config' calls to get multiple values
out. Perhaps time would be better spent creating a 'git config --batch'
mode so these consumers could call one process, pass a list of config keys
as input, and get a list of key-value pairs out? (Use a '-z' mode to allow
newlines in the values.)

However, I'm not seeing value to anyone else to have strbuf.h available
externally. I'm also not seeing any value to the Git project by having
either of these available as a library. I can only see increased developer
friction due to the new restrictions on making changes in these areas.

If this first effort is instead swapped to say "we plan on introducing
unit tests for these libraries" then I think that is an easier thing to
support.

It happens that these efforts will make it easier to make the jump to
providing APIs as a library. Not only are unit tests _necessary_ to
support libification, they also make a smaller lift. Unit tests will
already create more friction when changing the API, since either new tests
must be written or old tests must be modified.


### Summary

Generally, making architectural change is difficult. In addition to the
amount of code that needs to be moved, adjusted, and tested in new ways,
there is a cultural element that needs to be adjusted. Expecting Git's
code to be used as a library is a fundamentally different use case than we
have supported in the past, and most of our developer guidelines reflect
that. We don't hesitate to modify APIs. We prefer end-to-end tests over
unit tests whenever possible.

There are focused bits of your proposal that I think will be universally
welcomed, and I think the best course of action in the short term is to
demonstrate improvements in those areas:

 * Reduced use of globals.
 * Reduced memory leaks.
 * Use error responses instead of die()s within low-level code.
 * Update header files to have appropriate visibility and documentation.

The things that we need to really focus on are how we can measure progress
in these areas as well as how can we prevent regression in the future.
Unit tests are one way to do this (especially with leak detection), but
also documentation and coding guidelines need to be updated based on the
new patterns discovered in this process.

I mentioned the_repository earlier as a partially-complete architectural
change. I think the_index compatibility macros are in a similar boat of
being half-completed (though, the last time I tried to remove these macros
I was told that it wasn't a goal to remove the macros from builtins). The
sparse-index's command_requires_full_index checks are also in this boat,
so I understand the difficulty of getting a big change 100% complete (and
in this case, the plan is to do at least one more GSoC project in the area
to see what progress can be made that way).

We should be careful in committing to a very long-term direction without
first delivering value on a shorter timeline.

Thanks,
-Stolee
