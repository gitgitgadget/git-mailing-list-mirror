Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6305FC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216572098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM/6UGfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDXV04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXV04 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:26:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4BC09B048
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:26:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o10so9209458qtr.6
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iFeXnmiq2iAaBYz9ymNddOt/3VBPpUtsS9kaRfBEe0=;
        b=bM/6UGfC+M3IyOnDAcvKHJc5rkreJI592SUxhoUlzaUQ+TyWu8GgJRnqKkQBTM905z
         9QSbAb0fKIYN2mZggGo97CeJS7mzM2LODgaKIQs/IkC3EGJ1uyu9GjndFNP17wyvVZpt
         4G/7UPWN+at+nJlWAUbCL5WRdEQfPt7o/1kE+AcTIE6CCRE9h1d0MAYBGYoCq6rlOckn
         19EZqQBQ6b0MNk0UNYT+V/0aIAt8A4kImkGH4fFJSrrIQh6UY6r7/ZpeYdOFukoI9uZ7
         bAuMi4BOh5b/gU3fSKSofBE0kf0Tahsfy+cIARGwAl2P9fpySEaJ+V4iGiZ4OH35Rnwk
         ozpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iFeXnmiq2iAaBYz9ymNddOt/3VBPpUtsS9kaRfBEe0=;
        b=X2dVduHIuJpK9wQ2gQ8aUZzbfZKwPLXllajZuahgzcUuSbxO4J1wzhu0YAG0N7nyRy
         c7wKavskxU0yAiPxIZ3pjEr5Zd+Xwy0PvxQw+1YXT7jMovflhFGpew/AqSioRymA8Kr3
         yITL7tgtSXJy00i/FR8tMa0miP1tX9Q8sTRIayCAbqb4gN9acCtQyV4RjThN+v+5lnxl
         OwS4sE6hxsGMkytPaFABnPvpprM4kFnGHJSby6P21RLQhLl0MXhGrDoXoofuhp8PCkAX
         DXccpcTkxtqQG4l5TnZ5B02ITdVULcXgs7KD4TrMKLaz2vB6Jjr9rjsW4iGeFZab5TdD
         SERA==
X-Gm-Message-State: AGi0PuZdcVpqmp3ouIvcqeTFGYjUhxw3alQyo/4YQPqY7HSgm53t8HXC
        o/fLyooxdkvaYbo++vu2FYjhlOp++h6K4CUeN6s=
X-Google-Smtp-Source: APiQypK+y/vYhidF6s/uyFs0N7LP4MOI24D/q7feB+eFTC9C5uErf9Fz7ypARZtEpV4xbpsRLxJXuRw5Y8oi40OGE1k=
X-Received: by 2002:ac8:7448:: with SMTP id h8mr11900663qtr.225.1587763613472;
 Fri, 24 Apr 2020 14:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <35a3554df3e4be98f20837ecb08bf6a7a890aadb.1587700897.git.gitgitgadget@gmail.com>
 <20200424172823.GK1949@danh.dev>
In-Reply-To: <20200424172823.GK1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 02:56:42 +0530
Message-ID: <CAKiG+9VTWuLvi3b+ynHmqvkNuEPZS12hcvRYcd-omoYvBOzKtw@mail.gmail.com>
Subject: Re: [PATCH 4/8] cmake: support for testing git with ctest
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 10:58 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:33+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch provides an alternate way to test git using ctest.
> > CTest ships with CMake, so there is no additional dependency being
> > introduced.
> >
> > To perform the tests with ctest do this after building:
> > ctest -j[number of jobs]
> >
> > NOTE: -j is optional, the default number of jobs is 1
> >
> > Each of the jobs does this:
> > cd t/ && sh t[something].sh
> >
> > The reason for using CTest is that it logs the output of the tests
> > in a neat way, which can be helpful during diagnosis of failures.
> >
> > After the tests have run ctest generates three log files located in
> > `build-directory`/Testing/Temporary/
> >
> > These log files are:
> >
> > CTestCostData.txt:
> > This file contains the time taken to complete each test.
> >
> > LastTestsFailed.log:
> > This log file contains the names of the tests that have failed in the
> > run.
> >
> > LastTest.log:
> > This log file contains the log of all the tests that have run.
> > A snippet of the file is given below.
> >
> > 10/901 Testing: D:/my/git-master/t/t0009-prio-queue.sh
> > 10/901 Test: D:/my/git-master/t/t0009-prio-queue.sh
> > Command: "sh.exe" "D:/my/git-master/t/t0009-prio-queue.sh"
> > Directory: D:/my/git-master/t
> > "D:/my/git-master/t/t0009-prio-queue.sh"
> > Output:
> > ----------------------------------------------------------
> > ok 1 - basic ordering
> > ok 2 - mixed put and get
> > ok 3 - notice empty queue
> > ok 4 - stack order
> > passed all 4 test(s)
> > 1..4
> > <end of output>
> > Test time =   1.11 sec
> >
> > NOTE: Testing only works when building in source for now.
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 142 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 25de5b5bc35..141ccefa559 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -23,6 +23,7 @@ include(CheckIncludeFile)
> >  include(CheckFunctionExists)
> >  include(CheckSymbolExists)
> >  include(CheckStructHasMember)
> > +include(CTest)
> >
> >  find_package(ZLIB REQUIRED)
> >  find_package(CURL)
> > @@ -680,3 +681,144 @@ install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/
> >  if(MSGFMT_EXE)
> >       install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
> >  endif()
> > +
> > +
> > +if(BUILD_TESTING)
> > +
> > +#tests-helpers
> > +add_executable(test-fake-ssh t/helper/test-fake-ssh.c)
> > +target_link_libraries(test-fake-ssh common-main)
> > +
> > +add_executable(test-line-buffer t/helper/test-line-buffer.c)
> > +target_link_libraries(test-line-buffer common-main vcs-svn)
> > +
> > +add_executable(test-svn-fe t/helper/test-svn-fe.c)
> > +target_link_libraries(test-svn-fe common-main vcs-svn)
> > +
> > +set(test_helper_sources
> > +     t/helper/test-tool.c t/helper/test-advise.c t/helper/test-bloom.c t/helper/test-chmtime.c
> > +     t/helper/test-config.c t/helper/test-ctype.c t/helper/test-date.c t/helper/test-delta.c
> > +     t/helper/test-dir-iterator.c t/helper/test-drop-caches.c t/helper/test-dump-cache-tree.c
> > +     t/helper/test-dump-fsmonitor.c t/helper/test-dump-split-index.c
> > +     t/helper/test-dump-untracked-cache.c t/helper/test-example-decorate.c
> > +     t/helper/test-genrandom.c t/helper/test-genzeros.c t/helper/test-hash.c
> > +     t/helper/test-hashmap.c t/helper/test-hash-speed.c t/helper/test-index-version.c
> > +     t/helper/test-json-writer.c t/helper/test-lazy-init-name-hash.c
> > +     t/helper/test-match-trees.c t/helper/test-mergesort.c t/helper/test-mktemp.c
> > +     t/helper/test-oidmap.c t/helper/test-online-cpus.c t/helper/test-parse-options.c
> > +     t/helper/test-parse-pathspec-file.c t/helper/test-path-utils.c t/helper/test-pkt-line.c
> > +     t/helper/test-prio-queue.c t/helper/test-progress.c t/helper/test-reach.c
> > +     t/helper/test-read-cache.c t/helper/test-read-graph.c t/helper/test-read-midx.c
> > +     t/helper/test-ref-store.c t/helper/test-regex.c t/helper/test-repository.c
> > +     t/helper/test-revision-walking.c t/helper/test-run-command.c t/helper/test-scrap-cache-tree.c
> > +     t/helper/test-serve-v2.c t/helper/test-sha1.c t/helper/test-oid-array.c t/helper/test-sha256.c
> > +     t/helper/test-sigchain.c t/helper/test-strcmp-offset.c t/helper/test-string-list.c
> > +     t/helper/test-submodule-config.c t/helper/test-submodule-nested-repo-config.c t/helper/test-subprocess.c
> > +     t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
> > +     t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
> > +
> > +add_executable(test-tool ${test_helper_sources})
> > +target_link_libraries(test-tool common-main)
> > +
> > +set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
> > +                     PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)
> > +
> > +#wrapper scripts
> > +set(wrapper_scripts
> > +     git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
> > +
> > +set(wrapper_test_scripts
> > +     test-fake-ssh test-line-buffer test-svn-fe test-tool)
> > +
> > +
> > +foreach(script ${wrapper_scripts})
> > +     file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
> > +     string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> > +     string(REPLACE "@@PROG@@" "${script}" content "${content}")
> > +     file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
> > +endforeach()
> > +
> > +foreach(script ${wrapper_test_scripts})
> > +     file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
> > +     string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> > +     string(REPLACE "@@PROG@@" "t/helper/${script}" content "${content}")
> > +     file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
> > +endforeach()
> > +
> > +file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
> > +string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
> > +string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
> > +file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
> > +
> > +#options for configuring test options
> > +option(PERL_TESTS "Perform tests that use perl" ON)
> > +option(PYTHON_TESTS "Perform tests that use python" ON)
> > +
> > +#GIT-BUILD-OPTIONS
> > +set(TEST_SHELL_PATH ${SHELL_PATH})
> > +set(DIFF diff)
> > +set(PYTHON_PATH /usr/bin/python)
> > +set(TAR tar)
> > +set(NO_CURL )
> > +set(NO_EXPAT )
> > +set(USE_LIBPCRE1 )
> > +set(USE_LIBPCRE2 )
>
> Hm, really?
>
>

These are generated by default on the Makefile also.

> > +set(NO_LIBPCRE1_JIT )
> > +set(NO_PERL )
> > +set(NO_PTHREADS )
> > +set(NO_PYTHON )
> > +set(PAGER_ENV "LESS=FRX LV=-c")
> > +set(DC_SHA1 YesPlease)
> > +set(RUNTIME_PREFIX true)
> > +set(NO_GETTEXT )
> > +
> > +if(NOT CURL_FOUND)
> > +     set(NO_CURL 1)
> > +endif()
> > +
> > +if(NOT EXPAT_FOUND)
> > +     set(NO_EXPAT 1)
> > +endif()
> > +
> > +if(NOT Intl_FOUND)
> > +     set(NO_GETTEXT 1)
> > +endif()
> > +
> > +if(NOT PERL_TESTS)
> > +     set(NO_PERL 1)
> > +endif()
> > +
> > +if(NOT PYTHON_TESTS)
> > +     set(NO_PYTHON 1)
> > +endif()
>
> I hope we have something like:
>
> PYTHON_PATH=/path/to/my/yet/to/release/python/to/check/if/it/works/with/current/git
>
> If it's ready, thanks.
> If it isn't, no, I'm stressed enough by CMake.
>

Yes it can be done.

> > +
> > +file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SHELL_PATH='${SHELL_PATH}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TEST_SHELL_PATH='${TEST_SHELL_PATH}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PERL_PATH='${PERL_PATH}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DIFF='${DIFF}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "USE_LIBPCRE1='${USE_LIBPCRE1}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_LIBPCRE1_JIT='${NO_LIBPCRE1_JIT}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X=''\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
> > +file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
> > +
> > +file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>
> CMake recommends to not use GLOB for this kind of things, themselves, no?
>
> > +
> > +#test
> > +foreach(tsh ${test_scipts})
> > +     add_test(NAME ${tsh}
> > +             COMMAND ${SH_EXE} ${tsh}
> > +             WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
> > +endforeach()
> > +
> > +endif()#BUILD_TESTING
> > \ No newline at end of file
>
> Please fix your editor!
>
> --
> Danh

Thank You,
Sibi Siddharthan
