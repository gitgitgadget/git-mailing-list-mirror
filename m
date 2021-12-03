Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2068C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352498AbhLCNh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbhLCNh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:37:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F8C06174A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so5696106wru.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9uCJY6fbVgRTHxcF4wAkFjWBUySPlU/DsH2NOmfZ060=;
        b=T6J8lpiZErPkPixm7jdoIna3CWirf/CbbCIb4GbJInBuKUVXqZ7i458VM2kRTbovli
         JEGtIwVm1ZW4lW81wUXplYyaDBl91XwOxC8yUvPRdkKVMDNj5wXoyb3NUODjzsvvFOha
         t+OJDluMv/HO+D7wS8S5GOobFrGv+vkex57asDpxyCKSOUlX7E5n3de6QCreKsMEHQ7i
         Lv9tZAL34IH5iQyeg3RnkrMcXcIM9B/KfLMq3nN15MwUUR8uJQwicf/psDjKX9nXvrXT
         4BHz6h8upzDjpuafjhcVHLj9q8bJyuuUIY3NYfbzBasOhhLOtMTyUQO7zo/T0QLwZaYq
         xUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9uCJY6fbVgRTHxcF4wAkFjWBUySPlU/DsH2NOmfZ060=;
        b=SL/KRcba235FclD6dbkkTEMl2rysrAhT2P72G8tX4sxQ9LDV1ZhQHP6jtL2QfTr3vf
         70kBbFGLXbVB8ZOCrOntmE8TozEVuSGA2I7iGdP/I4WKM872tBeyXl6aRjSAMsSpftyZ
         9mb5xBvh9IbpcbzIt3ukpZgLPwwL7D8+O3y6Lo7I731nRgqY3vVay1uPMlcce0M8lgAM
         acTpKGWMQaBUn3iNRBj3rBqlFJOjRUukybc8hPw7ZrA7aBpQnDjIui3gEW/c638PlCq3
         7yEZeQ89ubfiDMamrvqa7KtCQgvucu/6BlbjPMlfSMDjD8uQbwUpJbKMRZWz95VKFZSb
         l8dQ==
X-Gm-Message-State: AOAM532+IyBEPPvRYb1yqiTAxyCLLuafCIouiZuLmHZg/uO4BXnG2uDh
        jowbRk+eSmGSxgPyKw4QLNcV2eMcNB8=
X-Google-Smtp-Source: ABdhPJyjuFqIv6h1SRGb3MUrQh/3dcJRyLNfjmGXNApeMoa1fl4jtk59++Eet2IB3NKpfz14pG8VuQ==
X-Received: by 2002:adf:b34f:: with SMTP id k15mr22794374wrd.125.1638538471208;
        Fri, 03 Dec 2021 05:34:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm2551554wrm.76.2021.12.03.05.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:30 -0800 (PST)
Message-Id: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:14 +0000
Subject: [PATCH v10 00/15] Upstreaming the Scalar command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr: This series contributes the core part of the Scalar command to the
Git project. This command provides a convenient way to clone/initialize very
large repositories (think: monorepos).

Note: This patch series' focus is entirely on Scalar, on choosing sensible
defaults and offering a delightful user experience around working with
monorepos, and not about changing any existing paradigms for contrib/ (even
if catching up on the mail thread is likely to give interested readers that
false impression).

Changes since v9:

 * The patches to build Scalar and run its tests as part of Git's CI/PR,
   have been dropped because a recent unrelated patch series does not
   interact well with them.

Changes since v8:

 * The rebase on top of v2.34.0, which changed the default merge strategy to
   ORT, should have changed the default for merge.renames to true. This is
   now the case.
 * Accommodate preemptively for ab/ci-updates which invalidates assumptions
   made by this patch series that would still hold true with v2.34.0 but are
   no longer valid in seen and would trigger CI build breakages.

Changes since v7:

 * Clarified in the commit message why we cannot easily encapsulate the
   Scalar part of the CMake configuration in contrib/scalar/.
 * Improved the README.md.

Changes since v6:

 * Rebased on top of v2.34.0.
 * Inserted a commit that adds contrib/scalar/README.md, containing the
   roadmap of what I have planned for Scalar.
 * The Scalar test's definition of GIT_TEST_MAINT_SCHEDULER has been
   adjusted to accommodate for a change in v2.32.0..v2.34.0.
 * The config setting defaults now include fetch.showForcedUpdates=false,
   which has been identified as helping with a performance issue in large
   repositories.
 * To avoid mistaking the current patch series for being feature-complete
   enough to unleash onto end users, I moved the Makefile rules to build
   HTML/manual pages to a later patch series.
 * The patch that adds support for -c <key>=<value> and -C <directory> was
   moved to its own add-on patch series: While it is obvious that those
   options are valuable to have, an open question is whether there are other
   "pre-command" options in git that would be useful, too, and I would like
   to postpone that discussion to that date.
 * I added two patches that I had planned on keeping in an add-on patch
   series for later, to build and test Scalar as part of the CI. I am still
   not 100% certain that it is a good idea to do so already now, but let's
   see what the reviewers have to say.

Changes since v5:

 * Fixed the commit message talking about make -C contrib/scalar/Makefile.
 * Fixed the git ls-tree invocation suggested in the manual for scalar
   clone.
 * Invoking make -C contrib/scalar, then changing a source file of libgit.a
   and then immediately invoking make -C contrib/scalar again will now
   implicitly rebuild libgit.a.

Changes since v4:

 * scalar delete now refuses to delete anything if it was started from
   within the enlistment.
 * scalar delete releases any handles to the object store before deleting
   the enlistment.
 * The OBJECTS list in the Makefile will now include Scalar.
 * scalar register now supports secondary worktrees, in addition to the
   primary worktree.

Changes since v3:

 * Moved the "Changes since" section to the top, to make it easier to see
   what changed.
 * Reworded the commit message of the first patch.
 * Removed the [RFC] prefix because I did not hear any objections against
   putting this into contrib/.

Changes since v2:

 * Adjusted the description of the list command in the manual page , as
   suggested by Bagas.
 * Addressed two style nits in cmd_run().
 * The documentation of git reconfigure -a was improved.

Changes since v1:

 * A couple typos were fixed
 * The code parsing the output of ls-remote was made more readable
 * The indentation used in scalar.txt now consistently uses tabs
 * We no longer hard-code core.bare = false when registering with Scalar


Background
==========

Microsoft invested a lot of effort into scaling Git to the needs of the
Windows operating system source code. Based on the experience of the first
approach, VFS for Git, the Scalar project was started. Scalar specifically
has as its core goal to funnel all improvements into core Git.


The present
===========

The Scalar project provides a completely functional non-virtual experience
for monorepos. But why stop there. The Scalar project was designed to be a
self-destructing vehicle to allow those key concepts to be moved into core
Git itself for the benefit of all. For example, partial clone,
sparse-checkout, and scheduled background maintenance have already been
upstreamed and removed from Scalar proper. This patch series provides a
C-based implementation of the final remaining portions of the Scalar
command. This will make it easier for users to experiment with the Scalar
command. It will also make it substantially easier to experiment with moving
functionality from Scalar into core Git, while maintaining
backwards-compatibility for existing Scalar users.

The C-based Scalar has been shipped to Scalar users, and can be tested by
any interested reader: https://github.com/microsoft/git/releases/ (it offers
a Git for Windows installer, a macOS package and an Ubuntu package, Scalar
has been included since v2.33.0.vfs.0.0).


Next steps
==========

Since there are existing Scalar users, I want to ensure
backwards-compatibility with its existing command-line interface. Keeping
that in mind, everything in this series is up for discussion.

I obviously believe that Scalar brings a huge benefit, and think that it
would be ideal for all of Scalar's learnings to end up in git clone/git
init/git maintenance eventually. It is also conceivable, however, that the
scalar command could graduate to be a core part of Git at some stage in the
future (such a decision would probably depend highly on users' feedback).
See also the discussion about the architecture of Scalar
[https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/],
kicked off by Stolee.

On top of this patch series, I have lined up a few more:

 1. Implement a scalar diagnose command.
 2. Use the built-in FSMonitor (that patch series obviously needs to wait
    for FSMonitor to be integrated).
 3. Modify the config machinery to be more generous about concurrent writes,
    say, to the user-wide config.
 4. A few patches to optionally build and install scalar as part of a
    regular Git install (also teaching git help scalar to find the Scalar
    documentation

These are included in my vfs-with-scalar branch thicket
[https://github.com/dscho/git/commits/vfs-with-scalar]. On top of that, this
branch thicket also includes patches I do not plan on upstreaming, mainly
because they are too specific either to VFS for Git, or they support Azure
Repos (which does not offer partial clones but speaks the GVFS protocol,
which can be used to emulate partial clones).

One other thing is very interesting about that vfs-with-scalar branch
thicket: it contains a GitHub workflow which will run Scalar's quite
extensive Functional Tests suite. This test suite is quite comprehensive and
caught us a lot of bugs in the past, not only in the Scalar code, but also
core Git.


Epilogue
========

Now, to address some questions that I imagine every reader has who made it
this far:

 * Why not put the Scalar functionality directly into core Git, even a
   built-in? I wanted to provide an easy way for Git contributors to "play
   with" Scalar, without forcing a new top-level command into Git.
 * Why implement the Scalar command in the Git code base? Apart from
   simplifying Scalar maintenance in the Microsoft port of Git, the tight
   version coupling between Git and Scalar reduces the maintenance burden
   even further. Besides, I believe that it will make it much easier to
   shift functionality from Scalar into core Git, once we took the hurdle of
   accepting the Scalar code into the code base.
 * Why contribute Scalar to the Git project? We are biased, of course, yet
   our data-driven approach provides evidence that Scalar helps handling
   huge repositories with ease. By contributing it to the core Git project,
   we are able to share it with more users, especially some users who do not
   want to install Microsoft's fork of Git. We also hope that a lot of
   Scalar (maybe all of it) will end up in core Git, to benefit even more
   users.

Derrick Stolee (4):
  scalar: 'register' sets recommended config and starts maintenance
  scalar: 'unregister' stops background maintenance
  scalar: implement 'scalar list'
  scalar: implement the `run` command

Johannes Schindelin (10):
  scalar: add a README with a roadmap
  scalar: create a rudimentary executable
  scalar: start documenting the command
  scalar: create test infrastructure
  scalar: let 'unregister' handle a deleted enlistment directory
    gracefully
  scalar: implement the `clone` subcommand
  scalar: teach 'clone' to support the --single-branch option
  scalar: allow reconfiguring an existing enlistment
  scalar: teach 'reconfigure' to optionally handle all registered
    enlistments
  scalar: implement the `version` command

Matthew John Cheetham (1):
  scalar: implement the `delete` command

 Makefile                         |   9 +
 contrib/scalar/.gitignore        |   2 +
 contrib/scalar/Makefile          |  45 ++
 contrib/scalar/README.md         |  82 +++
 contrib/scalar/scalar.c          | 826 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        | 145 ++++++
 contrib/scalar/t/Makefile        |  78 +++
 contrib/scalar/t/t9099-scalar.sh |  88 ++++
 8 files changed, 1275 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/README.md
 create mode 100644 contrib/scalar/scalar.c
 create mode 100644 contrib/scalar/scalar.txt
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1005%2Fdscho%2Fscalar-the-beginning-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1005/dscho/scalar-the-beginning-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/1005

Range-diff vs v9:

  1:  3a2e28275f1 =  1:  3a2e28275f1 scalar: add a README with a roadmap
  2:  50160d61a41 =  2:  50160d61a41 scalar: create a rudimentary executable
  3:  74cd6410931 =  3:  74cd6410931 scalar: start documenting the command
  4:  37231a4dd07 =  4:  37231a4dd07 scalar: create test infrastructure
  5:  a39b9c81214 <  -:  ----------- cmake: optionally build `scalar`, too
  6:  8c6762def30 <  -:  ----------- ci: also run the `scalar` tests
  7:  936ee0475ad =  5:  4439ab4de0b scalar: 'register' sets recommended config and starts maintenance
  8:  09a15f86c3d =  6:  376056066a0 scalar: 'unregister' stops background maintenance
  9:  42121a5764d =  7:  c865e89beb3 scalar: let 'unregister' handle a deleted enlistment directory gracefully
 10:  6afb2eb4163 =  8:  3f8b0abd7d6 scalar: implement 'scalar list'
 11:  dd4e3a4b761 =  9:  60659c47196 scalar: implement the `clone` subcommand
 12:  abd9c8827cd = 10:  45aca840764 scalar: teach 'clone' to support the --single-branch option
 13:  5601f82dbe1 = 11:  15e649a1734 scalar: implement the `run` command
 14:  08e4f548aa8 = 12:  2a3fb40bd9a scalar: allow reconfiguring an existing enlistment
 15:  0cec6dbd2cb = 13:  efd808a0c4a scalar: teach 'reconfigure' to optionally handle all registered enlistments
 16:  835f1c79792 = 14:  8b69462b906 scalar: implement the `delete` command
 17:  4ee1b701c7b = 15:  b5f416d79b4 scalar: implement the `version` command

-- 
gitgitgadget
