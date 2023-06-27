Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85887EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0TxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0TxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80755FA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b80517fd4aso18925915ad.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895586; x=1690487586;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SVPZCjkbRoILWlvXYfNOhbjcBAU2ORqSjNzGz0BCc1I=;
        b=PTGzuyo00oxTKYl64qSWoBtSdxSuxIBg4F6/hL7MAYcvc4wdLheQk13eSpVmzyiLhI
         2V2LsTYlBxjlNy7vtYj3yVi4D7dP0rPujWv6UfGDkPq3/25N/RUi1fPxxVV1hrY8dMx4
         wVpPCA/XrHI7GAYum9KsKVIayDnqtr/bpTto4sIEas0eSgzvz0vm1JOY5XduAK/nNOyR
         yWmM3odkbE0oPhLC6vCsLuYubEK3LohaJwDOjkJ8itrT58FoeNK8tjYurQ1+YzbqtYuQ
         BF/oCXVfrak1nHDcU6b8rzb2S5bg3MhiToGYI+3gzqwoPqK7TsEtDLEnUn0I0hNhto/B
         ut+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895586; x=1690487586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVPZCjkbRoILWlvXYfNOhbjcBAU2ORqSjNzGz0BCc1I=;
        b=QUuNm6br4PkZD3p18p8Ii6pQ1chfc/Cx4WXi81bJJ9UBlDYpF8bYBY0ikjvog8y5L6
         2HfvVSY4HQxQqoVWjg04JD3CO075OE9FoY8chtwtA/ZGziljJraSW9GkvSGrLip6NsoL
         Wr5n9eI7zXL08YzyErpNJpQ1/4KO339o9akBs/twmM2e5IJYcEntnlQR6SnTVMyP9hUr
         TrDjrz8Z7HkbfRK/K9fBtFNioTR+w3YFQlzL1aXEQnO4A84VYcD9SY7m3tTizuM3/6h5
         C7rrXDmUQByN8ey2Mklitqq0AFyMUX1n5c1PYXh3DJzXrIEw8lCv3bNKxqlW/Pa0EAjF
         c5fQ==
X-Gm-Message-State: AC+VfDyInbmd/I67W8KnF10+x0URB2iMcsTCKQ7AOUMPUZbw2OvtdS/4
        jK+Ni5455DU3c+i/wXavetKnT+5aiYatRE+sr2yED/pz4TMBFaWBsOhKoPvTwkNuE+tfJtNc4cD
        /FqXC2stcIrLh4dZ3fWI/SYyF6yv76dQhhFu0Xu55qNKNB78FoXaPB3KJ6b2HXT7adQ==
X-Google-Smtp-Source: ACHHUZ6aP0Txt/X6RF47Ptq+Kyd+51QyKfNo6/Ln11mJ4MQQ2Gd7S+S9oTj2v+Z1O1FVCWduDCt+Onhv2SbEu2I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:2905:b0:1b7:f5be:c934 with SMTP
 id lh5-20020a170903290500b001b7f5bec934mr1137921plb.9.1687895585982; Tue, 27
 Jun 2023 12:53:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-1-calvinwan@google.com>
Subject: [RFC PATCH 0/8] Introduce Git Standard Library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduction / Pre-reading
================

The Git Standard Library intends to serve as the foundational library
and root dependency that other libraries in Git will be built off of.
That is to say, suppose we have libraries X and Y; a user that wants to
use X and Y would need to include X, Y, and this Git Standard Library.
This cover letter will explain the rationale behind having a root
dependency that encompasses many files in the form of a standard library
rather than many root dependencies/libraries of those files. This does
not mean that the Git Standard Library will be the only possible root
dependency in the future, but rather the most significant and widely
used one. I will also explain why each file was chosen to be a part of
Git Standard Library v1. I will not explain entirely why we would like
to libify parts of Git -- see here[1] for that context.

Before looking at this series, it probably makes sense to look at the
other series that this is built on top of since that is the state I will
be referring to in this cover letter:

  - Elijah's final cache.h cleanup series[2]
  - my strbuf cleanup series[3]
  - my git-compat-util cleanup series[4]

Most importantly, in the git-compat-util series, the declarations for
functions implemented in wrapper.c and usage.c have been moved to their
respective header files, wrapper.h and usage.h, from git-compat-util.h.
Also config.[ch] had its general parsing code moved to parse.[ch].

Dependency graph in libified Git
================

If you look in the Git Makefile, all of the objects defined in the Git
library are compiled and archived into a singular file, libgit.a, which
is linked against by common-main.o with other external dependencies and
turned into the Git executable. In other words, the Git executable has
dependencies on libgit.a and a couple of external libraries. While our
efforts to libify Git will not affect this current build flow, it will
provide an alternate method for building Git.

With our current method of building Git, we can imagine the dependency
graph as such:

        Git
         /\
        /  \
       /    \
  libgit.a   ext deps

In libifying parts of Git, we want to shrink the dependency graph to
only the minimal set of dependencies, so libraries should not use
libgit.a. Instead, it would look like:

                Git
                /\
               /  \
              /    \
          libgit.a  ext deps
             /\
            /  \
           /    \
object-store.a  (other lib)
      |        /
      |       /
      |      /
 config.a   / 
      |    /
      |   /
      |  /
git-std-lib.a

Instead of containing all of the objects in Git, libgit.a would contain
objects that are not built by libraries it links against. Consequently,
if someone wanted their own custom build of Git with their own custom
implementation of the object store, they would only have to swap out
object-store.a rather than do a hard fork of Git.

Rationale behind Git Standard Library
================

The rationale behind Git Standard Library essentially is the result of
two observations within the Git codebase: every file includes
git-compat-util.h which defines functions in a couple of different
files, and wrapper.c + usage.c have difficult-to-separate circular
dependencies with each other and other files.

Ubiquity of git-compat-util.h and circular dependencies
========

Every file in the Git codebase includes git-compat-util.h. It serves as
"a compatibility aid that isolates the knowledge of platform specific
inclusion order and what feature macros to define before including which
system header" (Junio[5]). Since every file includes git-compat-util.h, and
git-compat-util.h includes wrapper.h and usage.h, it would make sense
for wrapper.c and usage.c to be a part of the root library. They have
difficult to separate circular dependencies with each other so they
can't be independent libraries. Wrapper.c has dependencies on parse.c,
abspath.c, strbuf.c, which in turn also have dependencies on usage.c and
wrapper.c -- more circular dependencies. 

Tradeoff between swappability and refactoring
========

From the above dependency graph, we can see that git-std-lib.a could be
many smaller libraries rather than a singular library. So why choose a
singular library when multiple libraries can be individually easier to
swap and are more modular? A singular library requires less work to
separate out circular dependencies within itself so it becomes a
tradeoff question between work and reward. While there may be a point in
the future where a file like usage.c would want its own library so that
someone can have custom die() or error(), the work required to refactor
out the circular dependencies in some files would be enormous due to
their ubiquity so therefore I believe it is not worth the tradeoff
currently. Additionally, we can in the future choose to do this refactor
and change the API for the library if there becomes enough of a reason
to do so (remember we are avoiding promising stability of the interfaces
of those libraries).

Reuse of compatibility functions in git-compat-util.h
========

Most functions defined in git-compat-util.h are implemented in compat/
and have dependencies limited to strbuf.h and wrapper.h so they can be
easily included in git-std-lib.a, which as a root dependency means that
higher level libraries do not have to worry about compatibility files in
compat/. The rest of the functions defined in git-compat-util.h are
implemented in top level files and, in this patch set, are hidden behind
an #ifdef if their implementation is not in git-std-lib.a.

Rationale summary
========

The Git Standard Library allows us to get the libification ball rolling
with other libraries in Git (such as Glen's removal of global state from
config iteration[6] prepares a config library). By not spending many
more months attempting to refactor difficult circular dependencies and
instead spending that time getting to a state where we can test out
swapping a library out such as config or object store, we can prove the
viability of Git libification on a much faster time scale. Additionally
the code cleanups that have happened so far have been minor and
beneficial for the codebase. It is probable that making large movements
would negatively affect code clarity.

Git Standard Library boundary
================

While I have described above some useful heuristics for identifying
potential candidates for git-std-lib.a, a standard library should not
have a shaky definition for what belongs in it.

 - Low-level files (aka operates only on other primitive types) that are
   used everywhere within the codebase (wrapper.c, usage.c, strbuf.c)
   - Dependencies that are low-level and widely used
     (abspath.c, date.c, hex-ll.c, parse.c, utf8.c)
 - low-level git/* files with functions defined in git-compat-util.h
   (ctype.c)
 - compat/*

There are other files that might fit this definition, but that does not
mean it should belong in git-std-lib.a. Those files should start as
their own separate library since any file added to git-std-lib.a loses
its flexibility of being easily swappable.

Files inside of Git Standard Library
================

The initial set of files in git-std-lib.a are:
abspath.c
ctype.c
date.c
hex-ll.c
parse.c
strbuf.c
usage.c
utf8.c
wrapper.c
relevant compat/ files

Pitfalls
================

In patch 7, I use #ifdef GIT_STD_LIB to both stub out code and hide
certain function headers. As other parts of Git are libified, if we
have to use more ifdefs for each different library, then the codebase
will become uglier and harder to understand. 

There are a small amount of files under compat/* that have dependencies
not inside of git-std-lib.a. While those functions are not called on
Linux, other OSes might call those problematic functions. I don't see
this as a major problem, just moreso an observation that libification in
general may also require some minor compatibility work in the future.

Testing
================

Patch 8 introduces a temporary test file which will be replaced with
unit tests once a unit testing framework is decided upon[7]. It simply
proves that all of the functions in git-std-lib.a do not have any
missing dependencies and can stand up by itself.

I have not yet tested building Git with git-std-lib.a yet (basically
removing the objects in git-std-lib.a from LIB_OBJS and linking against
git-std-lib.a instead), but I intend on testing this in a future version
of this patch. As an RFC, I want to showcase git-std-lib.a as an
experimental dependency that other executables can include in order to
use Git binaries. Internally we have tested building and calling
functions in git-std-lib.a from other programs.

Unit tests should catch any breakages caused by changes to files in
git-std-lib.a (i.e. introduction of a out of scope dependency) and new
functions introduced to git-std-lib.a will require unit tests written
for them.

Series structure
================

While my strbuf and git-compat-util series can stand alone, they also
function as preparatory patches for this series. There are more cleanup
patches in this series, but since most of them have marginal benefits
probably not worth the churn on its own, I decided not to split them
into a separate series like with strbuf and git-compat-util. As an RFC,
I am looking for comments on whether the rationale behind git-std-lib
makes sense as well as whether there are better ways to build and enable
git-std-lib in patch 7, specifically regarding Makefile rules and the
usage of ifdef's to stub out certain functions and headers. 

The patch series is structured as follows:

Patches 1-6 are cleanup patches to remove the last few extraneous
dependencies from git-std-lib.a. Here's a short summary of the
dependencies that are specifically removed from git-std-lib.a since some
of the commit messages and diffs showcase dependency cleanups for other
files not directly related to git-std-lib.a:
 - Patch 1 removes trace2.h and repository.h dependencies from wrapper.c
 - Patch 2 removes the repository.h dependency from strbuf.c inherited from
   hex.c by separating it into hex-ll.c and hex.c
 - Patch 3 removes the object.h dependency from wrapper.c
 - Patch 4 is a bug fix that sets up the next patch. This importantly
   removes the git_config_bool() call from git_env_bool() so that env
   parsing can go in a separate file
 - Patch 5 removes the config.h dependency from wrapper.c and swaps it
   with a dependency to parse.h, which doesn't have extraneous
   dependencies to files outside of git-std-lib.a
 - Patch 6 removes the pager.h dependency from date.c

Patch 7 introduces Git standard library.

Patch 8 introduces a temporary test file for Git standard library. The
test file directly or indirectly calls all functions in git-std-lib.a to
showcase that the functions don't reference missing objects and that
git-std-lib.a can stand on its own.

[1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://lore.kernel.org/git/pull.1525.v3.git.1684218848.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/20230606194720.2053551-1-calvinwan@google.com/
[4] https://lore.kernel.org/git/20230606170711.912972-1-calvinwan@google.com/
[5] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
[6] https://lore.kernel.org/git/pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com/
[7] https://lore.kernel.org/git/8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com/

Calvin Wan (8):
  trace2: log fsync stats in trace2 rather than wrapper
  hex-ll: split out functionality from hex
  object: move function to object.c
  config: correct bad boolean env value error message
  parse: create new library for parsing strings and env values
  pager: remove pager_in_use()
  git-std-lib: introduce git standard library
  git-std-lib: add test file to call git-std-lib.a functions

 Documentation/technical/git-std-lib.txt | 182 ++++++++++++++++++
 Makefile                                |  30 ++-
 attr.c                                  |   2 +-
 builtin/log.c                           |   2 +-
 color.c                                 |   4 +-
 column.c                                |   2 +-
 config.c                                | 173 +----------------
 config.h                                |  14 +-
 date.c                                  |   4 +-
 git-compat-util.h                       |   7 +-
 git.c                                   |   2 +-
 hex-ll.c                                |  49 +++++
 hex-ll.h                                |  27 +++
 hex.c                                   |  47 -----
 hex.h                                   |  24 +--
 mailinfo.c                              |   2 +-
 object.c                                |   5 +
 object.h                                |   6 +
 pack-objects.c                          |   2 +-
 pack-revindex.c                         |   2 +-
 pager.c                                 |   5 -
 pager.h                                 |   1 -
 parse-options.c                         |   3 +-
 parse.c                                 | 182 ++++++++++++++++++
 parse.h                                 |  20 ++
 pathspec.c                              |   2 +-
 preload-index.c                         |   2 +-
 progress.c                              |   2 +-
 prompt.c                                |   2 +-
 rebase.c                                |   2 +-
 strbuf.c                                |   2 +-
 symlinks.c                              |   2 +
 t/Makefile                              |   4 +
 t/helper/test-env-helper.c              |   2 +-
 t/stdlib-test.c                         | 239 ++++++++++++++++++++++++
 trace2.c                                |  13 ++
 trace2.h                                |   5 +
 unpack-trees.c                          |   2 +-
 url.c                                   |   2 +-
 urlmatch.c                              |   2 +-
 usage.c                                 |   8 +
 wrapper.c                               |  25 +--
 wrapper.h                               |   9 +-
 write-or-die.c                          |   2 +-
 44 files changed, 813 insertions(+), 311 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h
 create mode 100644 parse.c
 create mode 100644 parse.h
 create mode 100644 t/stdlib-test.c

-- 
2.41.0.162.gfafddb0af9-goog

