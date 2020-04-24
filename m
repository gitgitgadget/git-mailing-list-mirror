Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7851CC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E672098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZwbyTps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDXVYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgDXVYz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:24:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4BC09B048
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:24:54 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ep1so5448635qvb.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2c3RknG+UxeteCsZkJkUEiJhB3vZikm6CUo/9QLVuE=;
        b=WZwbyTpshaDiPdjPcrltk5R/lRYFc5mmpnjVi3r7eHj4w7Lbb3ypRYCvV0/gYD2+Ks
         AdK7khP5XD5q+86ZPt5POpbY9pcuY/kDO09WJzV13jLz/ml6mjS4eAB9S+ZzmuA7Gpwr
         DwiLE+CwWrX6a+MsWWcCzso/l1f8bDOlQ+v3ya8o2XuyKtLtcWPFuw2JdRezCmEjnE2S
         Aa1zQQNm4Jm/ZDK9URfcYqBMevlCFhCzQ27hvRewLTHrTKUneVh14zp6NP8IrkevmYtt
         B8AyrFj1ykwE/B8H+O3pzE0KUaYDUUuSw3gjdcGBzTvyvBkiLiHC6EakoVMiwguDs2iz
         qBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2c3RknG+UxeteCsZkJkUEiJhB3vZikm6CUo/9QLVuE=;
        b=K7WU4QKY6nO27BR0NlqAhCi1z80D9ecBCVKXRi8F+tRkdw+rNWD3LXltWjR7R91zG0
         fU76XSlXFLOiPwAprqtGZRS0CMhlappCQskWj92nNu0AlE0aVlBfpF2dJ6qQlTXCiHWq
         M+gavtW4j4AlIxs9u7N1sDO9/ZqBszknMQoLIAQSNbX3hGn1Mu/E/DkfIsk7ZaO0z7PW
         rx/bs4ZCRTFSCYzppf12AT4yOVF8RZPKBt9+eeIjI+EzTHmic/yF/wq9LHcL2EQzLiU4
         nJUr5WDGL+at5foUyfRa2uGSvJjrzwth9+bt4WfFNZC82oFdOFl/s9Emt7S0Y3JcapMB
         i4gg==
X-Gm-Message-State: AGi0PuZlH8CfplN9cV4TZQn2AoGlzuyYDiJ/qHN3yOtu0e8WrujAbpaX
        Jc6ojoShHNjc52LOF7Wnf+ecoHxw8U7VceacMmOrHg==
X-Google-Smtp-Source: APiQypISLlNtmTTNjd4Kr6xCOBUIFusSug7M/YH34EggyTGSf9mpJGwruKyk1zBiUlKpeYGxrbejtBVce/OOD/KTHMQ=
X-Received: by 2002:a05:6214:108a:: with SMTP id o10mr11412889qvr.213.1587763494141;
 Fri, 24 Apr 2020 14:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <10390063a398feab86519ba4e4fd9d03f38cd0fd.1587700897.git.gitgitgadget@gmail.com>
 <20200424172312.GJ1949@danh.dev>
In-Reply-To: <20200424172312.GJ1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 02:54:42 +0530
Message-ID: <CAKiG+9XWjASSJBx-=HWJ7-8_7fdJbEth2ZdMeSZLkviyUza1hQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] cmake: installation support for git
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 10:53 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:32+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch provides the facility to install the built binaries and
> > scripts.
> >
> > This is very similar to `make install`.
> > By default the destination directory(DESTDIR) is /usr/local/ on Linux
> > To set a custom installation path do this:
> > cmake `relative-path-to-srcdir`
> >       -DCMAKE_INSTALL_PREFIX=`preferred-install-path`
> >
> > Then run `make install`
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 788b53be873..25de5b5bc35 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -13,6 +13,8 @@ project(git
> >       VERSION ${git_version}
> >       LANGUAGES C)
> >
> > +#TODO gitk git-gui gitweb
> > +#TODO Add pcre support
> >
> >  include(CheckTypeSize)
> >  include(CheckCSourceRuns)
> > @@ -631,3 +633,50 @@ if(MSGFMT_EXE)
> >       endforeach()
> >       add_custom_target(po-gen ALL DEPENDS ${po_gen})
> >  endif()
> > +
> > +
> > +#to help with the install
> > +list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
> > +list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
> > +
> > +#install
> > +install(TARGETS git git-shell
> > +     RUNTIME DESTINATION bin)
> > +install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver  #${CMAKE_SOURCE_DIR}/gitk-git/gitk check
>
> check? What does it mean?
>

It is part of a TODO for gitk, will remove it. Sorry

> > +     DESTINATION bin)
> > +
> > +list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
> > +install(TARGETS ${PROGRAMS_BUILT}
> > +     RUNTIME DESTINATION libexec/git-core)
>
> Ubuntu install exec file to /usr/lib/git-core?
>

Yes it does, but when I do `make install` the programs go to libexec/git-core

> > +
> > +set(bin_links
> > +     git-receive-pack git-upload-archive git-upload-pack)
> > +
> > +foreach(b ${bin_links})
> > +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
> > +endforeach()
> > +
> > +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
> > +install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
> > +
> > +foreach(b ${git_links})
> > +     string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> > +     install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> > +endforeach()
> > +
> > +foreach(b ${git_http_links})
> > +     string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
> > +     install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
> > +endforeach()
> > +
> > +install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
> > +     DESTINATION libexec/git-core)
> > +
> > +install(DIRECTORY mergetools DESTINATION libexec/git-core)
> > +install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
> > +     FILES_MATCHING PATTERN "*.pm")
>
> I think distro gonna complans about this pattern!
>

What are you trying to say? Can you explain a bit more.

> > +install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
> > +
> > +if(MSGFMT_EXE)
> > +     install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
> > +endif()
>
> I thought we want to check for NO_GETTEXT?
>
> --
> Danh

Thank You,
Sibi Siddharthan
