Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE46AC433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBBD2077D
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkq43crQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgE3S5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3S5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 14:57:09 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C2C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 11:57:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r16so2666230qvm.6
        for <git@vger.kernel.org>; Sat, 30 May 2020 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8qNdpzUNdOHQ4nbQ8fxtQKx8YG++q7SlZE5XEmjD+Q=;
        b=Kkq43crQKu4JDNNIEDbBSNpLervT9iekcr133qGnqppbliRvkKvYpv5Fex0+g9uSoh
         /KL4pLfkBd6VibcCX/1hZ+2FghaV/2KLVj1OYdHLb+keOR/re2prmi9m2yuYD0qVZW7d
         4Jkjydlo/G9/D3V24zO9Z/5ty5vX6mMduCXCDs3m8p6/e21pKxaZKixQDWWoS23/RyKl
         u4DN/lDX/4N6vViI/sBgkUe4rwrM6KX4afAH+wjy848D8jYhMEEfGncgT0644S7NsVEl
         LuCD5Slin1GyAXgfbuMFlbu93XcuV77hyKJVexk2EMuqly5nggaehqXhfbgvs5weorUk
         uZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8qNdpzUNdOHQ4nbQ8fxtQKx8YG++q7SlZE5XEmjD+Q=;
        b=WWBm8BbJlDioPCsvlDRYe68FMADYPsMPY0C2t5d2VrR6jH51u18GXOtLGpAm4ah/kb
         mC+XTJpbVjmLlZ/bzXCm2HMfFBN8OWKi6NuoDtADPe+sZoYlBYSksdrLiM1Kitbi5BJM
         wp5QVXpW10XiyVEWzCCk6IjWLKJmxUD/zLmuamUlEbEh3s6kevFQC0aP7SclUop+tiaZ
         E9a4m/xyQItnOiFjYpmJJeE6NJYoMU2keYW6reqsfiPh7p9qrQ2/71nAPHLWBwTuNQ+E
         d53vC8GiIcNEc29IyY7Jn+JJI0MbTfspeInJ68gYSIjeNqTyw/yiI6TPExK1w3zXx5vT
         Ygvw==
X-Gm-Message-State: AOAM531ezgivAnH+VGDfIuTJCHRF/zv9RN6xffZAP3YRkMybpGOWF1M6
        q47E+DSn1ekDlp2NB9UHv5i+54hDpPwVK9zews+7Zg==
X-Google-Smtp-Source: ABdhPJxFVbNkXFoi+rAplJRmmyAJbkXA15Qx8c7KFyGisU6tajs/A6zDBuvfP0QrDfOzTAOBLpfsAACjSgIWmuBJOu4=
X-Received: by 2002:ad4:57ac:: with SMTP id g12mr2111477qvx.226.1590865028566;
 Sat, 30 May 2020 11:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
 <xmqqwo4uy20z.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo4uy20z.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 31 May 2020 00:26:56 +0530
Message-ID: <CAKiG+9Ue1fqrzqHduZY4Pnsh4q+Thqq618JymkonmVhGewmM1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cmake: generate the shell/perl/python scripts and
 templates, translations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 12:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > Implement the placeholder substitution to generate scripted
> > Porcelain commands, e.g. git-request-pull out of
> > git-request-pull.sh
> >
> > Generate shell/perl/python scripts and template using CMake instead of
> > using sed like the build procedure in the Makefile does.
> >
> > The text translations are only build if `msgfmt` is found in your path.
> >
> > NOTE: The scripts and templates are generated during configuration.
>
> OK.
>
> > Changes
> > The CMake script parses the Makefile for:
> > SCRIPT_SH
> > SCRIPT_PERL
>
> Below the three-dash line.
>
> > +#shell scripts
> > +parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
>
> OK.
>
> > +set(git_shell_scripts
> > +     ${git_sh_scripts}
> > +     git-mergetool--lib git-parse-remote git-rebase--preserve-merges
> > +     git-sh-setup git-sh-i18n git-instaweb)
>
> Do we need to have enumeration here, which can drift out of sync
> with the reality?  Wouldn't we want to avoid it with something like
>
>  parse_makefile_for_scripts(git_sh_lib "SCRIPT_LIB" "")
>
> too?
>

Will do.

> > +#perl modules
> > +file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
> > +
> > +foreach(pm ${perl_modules})
> > +     string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
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
> Do we need to have enumeration here, which can drift out of sync
> with the reality?  Wouldn't we want to avoid it with file(GLOB) or
> something?
>

Will glob the above, and the po files as well.

> > +#templates have @.*@ replacement so use configure_file instead
> > +#hooks
> > +foreach(tm ${hooks_templates})
> > +     configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
> > +endforeach()
> > +
> > +#info
> > +configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
> > +
> > +#this
> > +configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)
>
> I was hoping that we could drive any build system without having to
> have separate rules like the above.  The idea behind all files with
> funny double-dash in its name under templates/ directory is:
>

So, I have to write the logic for determining the directories?
If so will do.

>  - double-dash denotes directory boundary
>
>  - when a template input ends with double-dash, it tells us to
>    create a directory
>
>  - leading "this--" denotes "not in a subdirectory but at the top
>    level of the generated template directory"
>
> so that each of them knows what the name of the file and directory
> hierarchy of the final destination is, and the result of transforming
> can be created and deposited at the final place mechanically with a
> single rule.
>
> > +#translations
> > +if(MSGFMT_EXE)
> > +     set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)
>
> Do we need to have enumeration here, which can drift out of sync
> with the reality?  Wouldn't globbing for *.po be sufficient?
>
> > +     foreach(po ${po_files})
> > +             file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
> > +             add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
> > +                             COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
> > +             list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
> > +     endforeach()
> > +     add_custom_target(po-gen ALL DEPENDS ${po_gen})
> > +endif()
>
> Thanks.
