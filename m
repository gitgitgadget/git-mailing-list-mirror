Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC9C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4C214AF
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgzf17n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXVdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:33:01 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB1C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:33:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c23so8678267qtp.11
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwllQ4udBZg4Ng4Wb1/HwTGDEqBh0cWwmrDAhqsqduU=;
        b=pgzf17n9WpikDo/kgahPdrwtMF2gaQrWQDc+UeG10TZrOqZJsiaN95FzPpdNlyikcN
         QiWiwv3JDQ/JAhw1Hc1H96xVj57PLwU0vxswRa7rGbH3y33xRBZaCPtmN5+JZs3TFrOK
         pTraQC506CZqoUlnDnH0a9DGWl3ORjqLttDepOhlWhmw43/qldtb2cqag1DnO8kpzmxl
         uU8oH5KZv0cMczxW8t6A9ATKVT8USFvIA/0njbe300FSSXy4CLfFIOEo+uHfR+4zZrs5
         O+zoYXpoVVvMRq1hOAZv1kLuJTR+vNezo4r0OVzJmwpTqvLcaw/mjg6MmyuCtjBN9oUF
         wWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwllQ4udBZg4Ng4Wb1/HwTGDEqBh0cWwmrDAhqsqduU=;
        b=Qk3uC8qVig6+FIGG7wzASoVlsdACuJve7+aqvhKHEyRizmqiV9Sd2qtOWNYsDljnV0
         FtJWx9ue8Men49oRVogWfiXcEOEbYwWhDmkaJxWAVbr962dWeUWW6iTCgaeiryiwZfYZ
         Twjn66u6D1Ka6vKjDPiuCcOLmz7+DA2xiM7HtH440gZklstuoQxF55oqZ29FdsXG+5m0
         QfP3cJgzf70douoGLpZhVDNwCZXD+IunMEOsbqOCnGge57Tk5uBcGSvIzLuviJuzd3r9
         GdIg8gXLjZZCT1hHrfIR/ARAydqXx5Hvg2+/4SbrXnqUIxxhenrlF4eo6UaVYC75Jytw
         336g==
X-Gm-Message-State: AGi0PuZjMR8gkjWmEFIbAvmvWZoxyDZH/L5ukLxNMPOZvhANF2G6MQoM
        1OsmqQyYRPWE+/L+Q+JOrP1NjHZjiFmwEoaO8Ns=
X-Google-Smtp-Source: APiQypJoMULCB9d1zbcDazp02eJ1qd0MqixJn6cV1qWxL9DPaeUUKC4XRi7ceFXzkQnkKxJn0N1+YWKmod9lIyAilS4=
X-Received: by 2002:aed:258a:: with SMTP id x10mr11541305qtc.51.1587763980787;
 Fri, 24 Apr 2020 14:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
 <20200424173433.GL1949@danh.dev>
In-Reply-To: <20200424173433.GL1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 03:02:49 +0530
Message-ID: <CAKiG+9V=bJNqrHRy8y8cbjkgzrmhOMMz47+8fgfQARAetx4MFQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] cmake: support for testing git when building out of
 the source tree
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 11:04 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:34+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch allows git to be tested when performin out of source builds.
> >
> > This involves changing GIT_BUILD_DIR in t/test-lib.sh to point to the
> > build directory. Also some miscellaneous copies from the source directory
> > to the build directory.
> > The copies are:
> > t/chainlint.sed needed by a bunch of test scripts
> > po/is.po needed by t0204-gettext-rencode-sanity
> > mergetools/tkdiff needed by t7800-difftool
> > contrib/completion/git-prompt.sh needed by t9903-bash-prompt
> > contrib/completion/git-completion.bash needed by t9902-completion
> > contrib/svn-fe/svnrdump_sim.py needed by t9020-remote-svn
> >
> > NOTE: t/test-lib.sh is only modified when tests are run not during
> > the build or configure.
> > The trash directory is still srcdir/t
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 141ccefa559..29a23eb11f7 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -812,6 +812,25 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
> >  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
> >  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
> >
> > +#Make the tests work when building out of the source tree
> > +if(NOT ${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
>
> IIRC, CMake recommends _NOT_ expand variable inside if()
> This very inconsistent recommendation of CMake (when should I use
> ${var} and when should I use var?) is one of reason I hate CMake
>

I know, I got taken aback at first, but then you get used to it.

> > +     file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> > +     string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
>
> I don't know what is going on here!
>

We are trying find the relative path to the build directory from the
source directory
file(RELATIVE_PATH ...)  requires a file in the to "whatever" directory.
The one file that is always present in the build directory after a
CMake configure is CMakeCache.txt, so we use that.
Then we remove "CMakeCache.txt" from the variable "BUILD_DIR_RELATIVE"
to get the actual relative path.

> > +     #Setting the build directory in test-lib.sh before running tests
> > +     file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> > +             "file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> > +             "file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> > +             "string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY\\\"/../${BUILD_DIR_RELATIVE}\" content \"\${content}\")\n"
> > +             "file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> > +     #misc copies
> > +     file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>
> So, some sed will be used in Windows without POSIX-like system,
> interesting!
>
> > +     file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> > +     file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
> > +     file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
> > +     file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
> > +     file(COPY ${CMAKE_SOURCE_DIR}/contrib/svn-fe/svnrdump_sim.py DESTINATION ${CMAKE_BINARY_DIR}/contrib/svn-fe/)
> > +endif()
> > +
> >  file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>
> Remember cmake won't be re-run if nothing was changed in CMakeList.txt
> If I only change some code, and I decided the change I make should be
> tested by a-new-and-independent-test-script.
> I need to re-run cmake manually! I don't like it, at all.
>

No you don't have re-run CMake.

>
> --
> Danh

Thank You,
Sibi Siddharthan
