Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A275DC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C28A2072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y4NDsh9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAQV1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:27:03 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35064 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAQV1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:01 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so15755595vsc.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTgcB9QAB43/jfVmqBypZEP1pg1DzFMVTnVa5oJ+3Es=;
        b=Y4NDsh9CdMZuylson2uZiHxZPzN5VtlU55ZJzdmPEprP58b6a2AADD7SBOG82ayx43
         c6wKXvaA7qbPlRBzekEStazMb6APtwhNKEw9GP6R5i1VqKX3xkZbj0szXmdfO1i6D0fQ
         rqkoIOnDnQGmA0t7UAo6viigoXU3RQfYXP6M1dutO98pohfQFWyi1Ne0hAM6xYCCVSuv
         i+EUn34VrH6f9GieUJJpy9j6a7kAkL7iSmuWzT1FAfdzUaH232L9hiWVKvUOj1JdIvNP
         MSf37/OZNhc4eDYeK/qCOnlQJqu+keILRrxeAqEolgvZ13MzKLJRPA70X4LoGKvgYuZn
         ZXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTgcB9QAB43/jfVmqBypZEP1pg1DzFMVTnVa5oJ+3Es=;
        b=YL5phuvedZwXSLi/yYSjUDbqDR1ahZN8qpYkIVB15w5HvVraaub0m1JRITDxmJQiI8
         7uwwBXJMmo6hZZrq1cbrOOkXbPOZgVVLERFy5DbszFlbI6uJ8sVTgnUXiNUwNs35ONL4
         UfSSju3itO5B58NZjLTFgDnEeio93kQZfGJRQVMKBMcr6musT7NlxhKFxxU/3DmKVJ93
         4uQ7ujXsg2rAma0npWTFXzNdKEMSjaTL/8w90RJYn+Pnpf/CB0ZxeGK0b4pGNiWYc1yf
         bchfab2TlHulriw12cRAkj3HQrTi9RJ5foGv5hIZrPLMCVnRX6P4dkBsVsh3UolBVgzf
         15rw==
X-Gm-Message-State: APjAAAVU0z1XNHUZDYOt3kgGaDkgSqcqkAnNpnWYqkFZE/VD9eAw7EIG
        tmIRRmk6YY5iGlFowh1q/4rKknDSvHIKGax6FQ0=
X-Google-Smtp-Source: APXvYqw/VUYOLEdFeihfkurYOXGs9P62NY8jl0HgomRaouFKwwGmOpIf/FlrV06NJig1tMitNb3G7oOuZtLEAsWLx2g=
X-Received: by 2002:a67:ec41:: with SMTP id z1mr6165141vso.197.1579296419706;
 Fri, 17 Jan 2020 13:26:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
 <pull.478.v3.git.1579275102.gitgitgadget@gmail.com> <61ff3c64b5bdec4aaca71caa63efc23888713315.1579275102.git.gitgitgadget@gmail.com>
 <xmqqsgkddbjz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgkddbjz.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 17 Jan 2020 22:26:48 +0100
Message-ID: <CAKPyHN2vZbJparPNVQ1C9nOKk5ZrfeOZWxwbcLnTbwbdJWMLgA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] config: add '--show-scope' to print the scope of a
 config value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 10:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +--show-scope::
> > +     Similar to `--show-origin` in that it augments the output of
> > +     all queried config options with the scope of that value
> > +     (local, global, system, command).
> > +
> >  --get-colorbool name [stdout-is-tty]::
> >
> >       Find the color setting for `name` (e.g. `color.diff`) and output
> > diff --git a/builtin/config.c b/builtin/config.c
> > index 52a904cfb1..d5931061e8 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -33,6 +33,7 @@ static int end_nul;
> >  static int respect_includes_opt = -1;
> >  static struct config_options config_options;
> >  static int show_origin;
> > +static int show_scope;
> >
> >  #define ACTION_GET (1<<0)
> >  #define ACTION_GET_ALL (1<<1)
> > @@ -155,6 +156,7 @@ static struct option builtin_config_options[] = {
> >       OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> >       OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> >       OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> > +     OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
> >       OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
> >       OPT_END(),
> >  };
> > @@ -189,11 +191,43 @@ static void show_config_origin(struct strbuf *buf)
> >       strbuf_addch(buf, term);
> >  }
> >
> > +static const char *scope_to_string(enum config_scope scope)
> > +{
> > +     switch (scope) {
> > +     case CONFIG_SCOPE_LOCAL:
> > +             return "local";
> > +     case CONFIG_SCOPE_GLOBAL:
> > +             return "global";
> > +     case CONFIG_SCOPE_SYSTEM:
> > +             return "system";
> > +     case CONFIG_SCOPE_WORKTREE:
> > +             return "worktree";
> > +     case CONFIG_SCOPE_COMMAND:
> > +             return "command";
> > +     case CONFIG_SCOPE_SUBMODULE:
> > +             return "submodule";
> > +     default:
> > +             return "unknown";
> > +     }
> > +}
>
> It is a shame that with this defined in the main part of the system
> test-tool still needs to carry its own private copy.
>
> I wonder if it results in a better system if we rename this to
>
>         const char *config_scope_name(enum config_scope scope)
>
> made it externally visible, and use it in t/helper/test-config.c
> and get rid of the private copy scope_name() there?
>

+1 and please keep the order in config_scope_name the same as in the
enum definition. Will base my 'remote rename &
branch.<name>.pushRemote'  series on this then.

Bert

> > diff --git a/config.h b/config.h
> > index f383a71404..91f851e925 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -35,10 +35,21 @@ struct object_id;
> >
> >  #define CONFIG_REGEX_NONE ((void *)1)
> >
> > +enum config_scope {
> > +     CONFIG_SCOPE_UNKNOWN = 0,
> > +     CONFIG_SCOPE_SYSTEM,
> > +     CONFIG_SCOPE_GLOBAL,
> > +     CONFIG_SCOPE_LOCAL,
> > +     CONFIG_SCOPE_WORKTREE,
> > +     CONFIG_SCOPE_COMMAND,
> > +     CONFIG_SCOPE_SUBMODULE,
> > +};
> > +
>
> And this is the logical place to make an external definition, if we
> were to go that route.
>
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index 983a0a1583..b654a6d2f9 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1766,6 +1766,64 @@ test_expect_success !MINGW '--show-origin blob ref' '
> >       test_cmp expect output
> >  '
> >
> > +test_expect_success '--show-scope with --list' '
> > +     cat >expect <<-EOF &&
> > +             global  user.global=true
> > +             global  user.override=global
> > +             global  include.path=$INCLUDE_DIR/absolute.include
> > +             global  user.absolute=include
> > +             local   user.local=true
> > +             local   user.override=local
> > +             local   include.path=../include/relative.include
> > +             local   user.relative=include
> > +             command user.cmdline=true
> > +     EOF
>
> The HERE-DOC is over-indented.  All the body lines should align with
> cat and EOF.  The same comment applies to many "<<-" added by this
> patch---mimick the "<<-" that appear in earlier part of the same
> file.
>
> > +test_expect_success !MINGW '--show-scope with --blob' '
> > +     blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
> > +     cat >expect <<-EOF &&
> > +             command user.custom=true
> > +     EOF
> > +     git config --blob=$blob --show-scope --list >output &&
> > +     test_cmp expect output
> > +'
>
> Missing blank line between two tests.
>
> I wonder if we want to revamp the tests for --show-origin that wants
> to make sure a funny filename is quoted properly.  For that purpose,
> CUSTOM_CONFIG_FILE is given a funny pathname, and it would have been
> OK to use that only for a single "do we quote properly?" test, but
> instead we use that same funnily-named file as the source in many
> places where we do not *care* how --show-origin quotes the pathname
> at all, and end up having to skip with !MINGW.
>
> It's a bad tradition that started at 45bf3297 ("t1300: fix the new
> --show-origin tests on Windows", 2016-03-23), I guess, and is not a
> new problem introduced by this patch, but it should stop so that we
> can have a better test coverage everywhere.
>
> Other than that, I think that the new feature added by this series
> is a sensible one.  Thanks for working on it.
>
