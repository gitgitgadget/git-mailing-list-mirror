Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290AC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1408F2098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE2wh/yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDXVUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:20:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBD7C09B048
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:20:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so5535977qtt.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCRtOXhjlunr6UtSmAorPysroYIKYzVAzQ+U8Qp4XCA=;
        b=tE2wh/yACIRaWK4aQe9pOWF3ww7Fcoq9eX/7mSflQ8XNbzb8NKLpD+sb1I3huSIpkO
         Au/FebuYzJNSb8MKNX0SFy/EvEyyAuzIbyNyRzu4+U7vM/qsYHz63B1Lue0mk0EnQ6Z1
         aC/ZtjxED7zSyGhRnwBIW1ho/XTfHVXp6BMXFXAEnEr6KzhpSav6l8twjRle7Kztl1Ve
         IvQy4opQjjyM6N0Djl+EqrURp3mrJKnDIB4OLz6cDCMaqHV0YfV89jROAlzKuzEG1+cn
         ZY76W1lNMGGHGWV4pwqdd5fCn+H9rJLUha9vS9HjjCdG7PSAdZNG2s/7QMG27g0L/tQv
         rpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCRtOXhjlunr6UtSmAorPysroYIKYzVAzQ+U8Qp4XCA=;
        b=CIiC57mdjl8PDUmVmFPQKoAhtv+wvu2JmRXAQpPEwTw4l5uLzIAkhvdG+S0JKwJ8F+
         go4Bmw2+vIssUWX6KB+uAzIxrO6bRnOI5sW15DW1tdeI4bHQcOcblrKDlMp+oL8PA4Uu
         f6W4fFxUPxSP3XG1Bcz0BAm4LRvx7qYqEng7Jv0mrAUnwFkZGyMWuLRY89aVjPBOe+wv
         oAyclk8Bj5IPzg2WVeDNKpFQ8NH6PYJHSEGhkhc4mvI/bitm77JhRzfM+dc/8P/sjScD
         0EpRxVrVzTyP7iCM2uG6EvNeDNRrzDCjKZrAZMwXEzZEWUsHLYloQhUMfyZjXj0bIfJ4
         a6Ww==
X-Gm-Message-State: AGi0Pua+Rn2juYHATqIycIJ210iGdndh8BA21Ap04NmF0usaIWenETJb
        6WbwmAo55Kqm7/BSMLbNQ95VAzacjXoEOKtbYzU=
X-Google-Smtp-Source: APiQypLS5lOKe55nZRHo2tKih3jsIdOD8avBSLl6hhKuuDgNuClid2leTzqSKilTb3YUDvb+mULfF0XtqpqsL2kbQEg=
X-Received: by 2002:aed:370a:: with SMTP id i10mr6936322qtb.64.1587763206947;
 Fri, 24 Apr 2020 14:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <ca242cf5bda74aafca6c169ad53ce33a62761027.1587700897.git.gitgitgadget@gmail.com>
 <20200424171959.GI1949@danh.dev>
In-Reply-To: <20200424171959.GI1949@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 02:49:55 +0530
Message-ID: <CAKiG+9Vs1nFR4Lfrh4g=7sNUu_yRr4mz-w=gRm_U7PqY9W5QBg@mail.gmail.com>
Subject: Re: [PATCH 2/8] cmake: generate the shell/perl/python scripts and
 templates, translations
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 10:50 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-24 04:01:31+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > This patch implements the placeholder substitution to generate, say,
> > `git-request-pull` from `git-request-pull.sh`.
> >
> > The shell/perl/python scripts and template are generated using CMake
> > (very similar to what sed does).
> >
> > The text translations are only build if `msgfmt` is found in your path.
> >
> > NOTE: The scripts and templates are generated during configuration.
> >
> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> > ---
> >  CMakeLists.txt | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 106 insertions(+), 1 deletion(-)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 73703bd321f..788b53be873 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -51,6 +51,11 @@ endif()
> >
> >  find_program(SH_EXE sh)
> >
> > +find_program(MSGFMT_EXE msgfmt)
>
> I suppose find_package(Gettext) can do most of this work?
>

Will change it using gettext.

> > +if(NOT MSGFMT_EXE)
> > +     message(WARNING "Text Translations won't be build")
> > +endif()
> > +
> >  #default behaviour
> >  include_directories(${CMAKE_SOURCE_DIR})
> >  add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> > @@ -525,4 +530,104 @@ endif()
> >  add_custom_command(OUTPUT ${git_links} ${git_http_links}
> >               COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
> >               DEPENDS git git-remote-http)
> > -add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> > \ No newline at end of file
>
> No newline at end of file?
>
> > +add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> > +
> > +
> > +#creating required scripts
> > +set(SHELL_PATH /bin/sh)
> > +set(PERL_PATH /usr/bin/perl)
>
> Really?
> Have you tried on, let's say FreeBSD?
>
> > +set(LOCALEDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
> > +set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
> > +set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
> > +
> > +#shell scripts
> > +set(git_shell_scripts
> > +     git-bisect git-difftool--helper git-filter-branch
> > +     git-merge-octopus git-merge-one-file git-merge-resolve
> > +     git-mergetool git-quiltimport
> > +     git-request-pull git-submodule git-web--browse
> > +     git-mergetool--lib git-parse-remote git-rebase--preserve-merges
> > +     git-sh-setup git-sh-i18n git-instaweb)
> > +
> > +foreach(script ${git_shell_scripts})
> > +     file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
> > +     string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
> > +     string(REPLACE "@@DIFF@@" "diff" content "${content}")
> > +     string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
> > +     string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
> > +     string(REPLACE "@@NO_CURL@@" "" content "${content}")
> > +     string(REPLACE "@@USE_GETTEXT_SCHEME@@" "" content "${content}")
> > +     string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
> > +     string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
> > +     string(REPLACE "@@SANE_TEXT_GREP@@" "-a" content "${content}")
> > +     string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
> > +     file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> > +endforeach()
>
> I assume this do most of sed magic?
>

Yes

> > +
> > +#perl scripts
> > +set(git_perl_scripts
> > +     git-add--interactive git-archimport git-cvsexportcommit
> > +     git-cvsimport git-cvsserver git-send-email git-svn)
> > +
> > +#create perl header
> > +file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
> > +string(REPLACE "@@PATHSEP@@" ":" perl_header "${perl_header}")
> > +string(REPLACE "@@INSTLIBDIR@@" "${INSTLIBDIR}" perl_header "${perl_header}")
> > +
> > +foreach(script ${git_perl_scripts})
> > +     file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
> > +     string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
>
> Hoped that this is tried on BSD?
>
> > +     string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
> > +     file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> > +endforeach()
> > +
> > +#python script
> > +file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
> > +string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
> > +file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
> > +
> > +#perl modules
> > +file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
> > +
> > +foreach(pm ${perl_modules})
> > +     string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
>
> So, the real source code have reference to CMAKE_SOURCE_DIR?
> I don't think so? It's purely my guess from previous patch, this
> function will do
> string(REPLACE from to file something_I_have_not_checked)
>

This if for getting the built perl modules in the right place "perl/build/lib"
Once I glob the files, their paths are absolute, hence a replacement.

> > +     file(STRINGS ${pm} content NEWLINE_CONSUME)
> > +     string(REPLACE "@@LOCALEDIR@@" "${LOCALEDIR}" content "${content}")
> > +     string(REPLACE "@@NO_PERL_CPAN_FALLBACKS@@" "" content "${content}")
> > +     file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
> > +#test-lib.sh requires perl/build/lib to be the build directory of perl modules
> > +endforeach()
> > +
> > +
> > +#templates
> > +file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
> > +set(hooks_templates
> > +     applypatch-msg.sample pre-applypatch.sample pre-push.sample
> > +     commit-msg.sample pre-commit.sample pre-rebase.sample
> > +     fsmonitor-watchman.sample pre-merge-commit.sample pre-receive.sample
> > +     post-update.sample prepare-commit-msg.sample update.sample)
>
> Too much things merged into one line, I hate it.
>

would you prefer something like this
set(hooks_templates
    applypatch-msg.sample
    pre-applypatch.sample
    ...)


> > +
> > +#templates have @.*@ replacement so use configure_file instead
> > +#hooks
> > +foreach(tm ${hooks_templates})
> > +     configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
> > +endforeach()
>
> What does this really means?
>

The way above replacements(sed magic) use @@.*@@, whereas the
templates use @.*@.
This pattern is what autoconf uses to configure Makefile.in, CMake
also has a similar feature (configure_file)

> > +
> > +#info
> > +configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
> > +
> > +#this
> > +configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)
> > +
> > +
> > +#translations
> > +if(MSGFMT_EXE)
> > +     set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)
>
> hard coded, so this is a regression, compared to old Makefile?
>
> > +     foreach(po ${po_files})
> > +             file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
> > +             add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
> > +                             COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
>
> find_package(Gettext) defines MSGFMT_EXECUTABLE, I think.
> Have you check Solaris option?
> Or is this tranlated from current Makefile?
> I haven't checked current source code!
>
> > +             list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
> > +     endforeach()
> > +     add_custom_target(po-gen ALL DEPENDS ${po_gen})
> > +endif()
> > --
> > gitgitgadget
> >
>
> --
> Danh

Thank You,
Sibi Siddharthan
