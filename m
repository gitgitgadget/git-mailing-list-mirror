Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A93C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D6161101
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhIIPiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhIIPiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:38:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFDBC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:36:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso3008060otv.3
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhOqxAva400shL+1pzzLyNEfGzssHXeXExzY1cD/p2Y=;
        b=KQiefSHRTWKi/GAlZRZrfExrTu229AC8W7XMbaPJsTvRSsGMEJE9kNuACv+pbxEDJd
         NqUcottZYXyP0ojJLk3G2KqneXyeYVsuV/Uy5mQZYTnU4+oZ/X9vd3RmNStTNbPkOKsW
         9LRtI7hCdOBwz/nli4LCY9udH28/HVxZ1y69TksaMle2UpKxf83PwlEY9+v7i4wmymog
         nUYCd191Z5EE1oaXsqi71V0hkBq47tclx36Wo7ACQ5Zzp9U3JSi4VQNc+a341a51W/fO
         Yrd8gpA9zHMr+hAXw4GFGrzH3JPYBXRPYrbW2I7pnCjuVEsM0FmGCYwjTeK6w7A/vdsE
         BTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhOqxAva400shL+1pzzLyNEfGzssHXeXExzY1cD/p2Y=;
        b=DJhDAnMyuMuImdEeuAJyxybQmBrPrC4Y/gCPuzu+MyBgftiuIEwB/RPvOwJA6nGFm3
         LOm6AdU9IhXYfyY/FB31haq/xNLm/Rkk/9h6IkHif3fDX9Ziso5/4+lXkG3+sWbGo8eK
         59koMuDCR8usDkgB8w6EbEDxoVBnwn0mzV+I4pxQxcIPujABbczmD0bZb/WXWM22kR2v
         Yq+aFtgqcFAQi+sipkoaXrDs7P5BQEysUwOpyRw/mcRXvvT1ADwq0IsIDNHRhzAd6zAO
         ZqWajj0pZUwnsXj9ZzlmUgSLHERmYYdy7GUQdKzbBM+LhPIkdtzepd3r3ji2SRXELByN
         QVZw==
X-Gm-Message-State: AOAM530c9r+EDx5D4cX4Ud4iqVQMN/+Up224FgBUfX3qX0x5l/qW1NIa
        Nk70kLDilfeK7E6tlN0r4QqMWzP01YOlZwM0ot6/x+YSyFc=
X-Google-Smtp-Source: ABdhPJwEC3BQLBAx+BYrXf3HiaFXDzbzvzGLL1pYQL3OTQ2xPptSNeoNCdiQpgJ8S2fNP1oWVvefJ/N2nkbzoVC4T5U=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr420511otv.25.1631201817877;
 Thu, 09 Sep 2021 08:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <b8c7d3f84508ae0fb300f47c726764f4cbf46be9.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <b8c7d3f84508ae0fb300f47c726764f4cbf46be9.1631129086.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 08:36:45 -0700
Message-ID: <CABPp-BGxYVP6X6v5eu4grZUgDb6hmHYVDEwT1Cu4u592KeQ1fA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] scalar: create a rudimentary executable
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 12:24 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The idea of Scalar (https://github.com/microsoft/scalar), and before
> that, of VFS for Git, has always been to prove that Git _can_ scale, and
> to upstream whatever strategies have been demonstrated to help.
>
> With this patch, we start the journey from that C# project to move what
> is left to Git's own `contrib/` directory, reimplementing it in pure C,
> with the intention to facilitate integrating the functionality into core
> Git all while maintaining backwards-compatibility for existing Scalar
> users (which will be much easier when both live in the same worktree).
> It was always to plan to contribute all of the proven strategies back to
> core Git.

s/always to plan/always the plan/

> For example, while the virtual filesystem provided by VFS for Git helped
> the team developing the Windows operating system to move onto Git, while
> trying to upstream it we realized that it cannot be done: getting the
> virtual filesystem to work (which we only managed to implement fully on
> Windows, but not on, say, macOS or Linux), and the required server-side
> support for the GVFS protocol, made this not quite feasible.
>
> The Scalar project learned from that and tackled the problem with
> different tactics: instead of pretending to Git that the working
> directory is fully populated, it _specifically_ teaches Git about
> partial clone (which is based on VFS for Git's cache server), about
> sparse checkout (which VFS for Git tried to do transparently, in the
> file system layer), and regularly runs maintenance tasks to keep the
> repository in a healthy state.
>
> With partial clone, sparse checkout and `git maintenance` having been
> upstreamed, there is little left that `scalar.exe` does that which
> `git.exe` cannot do. One such thing is that `scalar clone <url>` will
> automatically set up a partial, sparse clone, and configure
> known-helpful settings from the start.

s/does that which/does which/

> So let's bring this convenience into Git's tree.
>
> The idea here is that you can (optionally) build Scalar via
>
>         make -C contrib/scalar/Makefile
>
> This will build the `scalar` executable and put it into the
> contrib/scalar/ subdirectory.
>
> The slightly awkward addition of the `contrib/scalar/*` bits to the
> top-level `Makefile` are actually really required: we want to link to
> `libgit.a`, which means that we will need to use the very same `CFLAGS`
> and `LDFLAGS` as the rest of Git.
>
> An early development version of this patch tried to replicate all the
> conditional code in `contrib/scalar/Makefile` (e.g. `NO_POLL`) just like
> `contrib/svn-fe/Makefile` used to do before it was retired. It turned
> out to be quite the whack-a-mole game: the SHA-1-related flags, the
> flags enabling/disabling `compat/poll/`, `compat/regex/`,
> `compat/win32mmap.c` & friends depending on the current platform... To
> put it mildly: it was a major mess.
>
> Instead, this patch makes minimal changes to the top-level `Makefile` so
> that the bits in `contrib/scalar/` can be compiled and linked, and
> adds a `contrib/scalar/Makefile` that uses the top-level `Makefile` in a
> most minimal way to do the actual compiling.
>
> Note: With this commit, we only establish the infrastructure, no
> Scalar functionality is implemented yet; We will do that incrementally
> over the next few commits.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile                  |  8 ++++++++
>  contrib/scalar/.gitignore |  2 ++
>  contrib/scalar/Makefile   | 34 ++++++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.c   | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+)
>  create mode 100644 contrib/scalar/.gitignore
>  create mode 100644 contrib/scalar/Makefile
>  create mode 100644 contrib/scalar/scalar.c
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8f..2d5c822f7a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2447,6 +2447,10 @@ endif
>  .PHONY: objects
>  objects: $(OBJECTS)
>
> +SCALAR_SOURCES := contrib/scalar/scalar.c
> +SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
> +OBJECTS += $(SCALAR_OBJECTS)
> +
>  dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>  dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
>
> @@ -2586,6 +2590,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>                 $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
> +contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
> +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> +               $(filter %.o,$^) $(LIBS)
> +
>  $(LIB_FILE): $(LIB_OBJS)
>         $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
> new file mode 100644
> index 00000000000..ff3d47e84d0
> --- /dev/null
> +++ b/contrib/scalar/.gitignore
> @@ -0,0 +1,2 @@
> +/*.exe
> +/scalar
> diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
> new file mode 100644
> index 00000000000..40c03ad10e1
> --- /dev/null
> +++ b/contrib/scalar/Makefile
> @@ -0,0 +1,34 @@
> +QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
> +QUIET_SUBDIR1  =
> +
> +ifneq ($(findstring s,$(MAKEFLAGS)),s)
> +ifndef V
> +       QUIET_SUBDIR0  = +@subdir=
> +       QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
> +                        $(MAKE) $(PRINT_DIR) -C $$subdir
> +else
> +       export V
> +endif
> +endif
> +
> +all:
> +
> +include ../../config.mak.uname
> +-include ../../config.mak.autogen
> +-include ../../config.mak
> +
> +TARGETS = scalar$(X) scalar.o
> +GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
> +
> +all: scalar$X
> +
> +$(GITLIBS):
> +       $(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
> +
> +$(TARGETS): $(GITLIBS) scalar.c
> +       $(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
> +
> +clean:
> +       $(RM) $(TARGETS)
> +
> +.PHONY: all clean FORCE
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> new file mode 100644
> index 00000000000..7cff29e0fcd
> --- /dev/null
> +++ b/contrib/scalar/scalar.c
> @@ -0,0 +1,36 @@
> +/*
> + * The Scalar command-line interface.
> + */
> +
> +#include "cache.h"
> +#include "gettext.h"
> +#include "parse-options.h"
> +
> +static struct {
> +       const char *name;
> +       int (*fn)(int, const char **);
> +} builtins[] = {
> +       { NULL, NULL},
> +};
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +       struct strbuf scalar_usage = STRBUF_INIT;
> +       int i;
> +
> +       if (argc > 1) {
> +               argv++;
> +               argc--;
> +
> +               for (i = 0; builtins[i].name; i++)
> +                       if (!strcmp(builtins[i].name, argv[0]))
> +                               return !!builtins[i].fn(argc, argv);
> +       }
> +
> +       strbuf_addstr(&scalar_usage,
> +                     N_("scalar <command> [<options>]\n\nCommands:\n"));
> +       for (i = 0; builtins[i].name; i++)
> +               strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
> +
> +       usage(scalar_usage.buf);
> +}
> --
> gitgitgadget
>
