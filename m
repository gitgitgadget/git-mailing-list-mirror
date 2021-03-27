Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893FC433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D456192A
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 19:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0Txq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0TxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 15:53:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B391C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 12:53:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hq27so13420051ejc.9
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcJ/hL/KZLTqWKf1W+cGu5KIiDZS9ajmFVSDV2QM8T8=;
        b=PM4ZtRPVkprDDGbzikzkOIWigNSC30r60cS4GoMqZOa159LpEsJ/DkcT6w2BjbzNrb
         LiIcg4xJKxHOU3GBvsFH6d5BK3vc664tI24cUu4mpPl2I6mCJAftnVoXhxRw/aeFt1nK
         2FMmS9aZIoOTsUfsy2aWlt4pQErCZeIey82jSPYmrx3c7LbXAs9IixuQToRDTU5XDWTr
         g1NyuFrBrUsVB0RqJwbmccdkB4HGZeLoL2TMEGRpXCiVzK5rXN5PZJP620YqPD6XrAy3
         YoYeAgHw1GW4Ti6ewyu/aKf6WC4YdDx3oROyQvAXRyAEyoO+y+s0ChdXYoZXKwcRvqru
         apJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcJ/hL/KZLTqWKf1W+cGu5KIiDZS9ajmFVSDV2QM8T8=;
        b=HCdKWfOtC/E1KWlr923r06u2tfbXgJyPfHl4aDFlDSczCgmwJvTBu0bseT70aVGJV9
         NyIm9lQ6S4LtNGHfvU/roziA7nWqm3ao95SQLUjT2x+PVE81YyGy3+D1+ZZ7EzzGnQpO
         mNfQrh0HHBRKO+HilJOCTUA9DHFkCjAus0D2Lxvm2z0yGtegzSU3+1H7R4zFHQZNhprj
         DTdhjHdMvKNhqExow8oooK0RZZ6UGJeyIK7XEem57lWxRfrhG+X2w9w0LuGFCkcsur+B
         h3+ZIFg+JrrdFNcEPnbU+CyJVSq3ThenpiXmsz2SwDzgVfRFgid6aFsSMg0D0ryW2uDy
         67RQ==
X-Gm-Message-State: AOAM5309EQBqiWlwBA0fyLpZVRKo8NzGMaXFiwMUUKOjDllNXKiBiWzf
        iDJ6ia+th767SA74d2+pnf1tDJqLCmkp5HVRdO4TIy9zZjhp2A==
X-Google-Smtp-Source: ABdhPJy5k8VQ9ikkYt88d1PubEckBai3YFoBArwXbJhJRp0K2ocbya2CADkBcnYlTvKCUNLnPLM/EdSpUIQdEaC2aDg=
X-Received: by 2002:a17:907:68a:: with SMTP id wn10mr21782595ejb.551.1616874803107;
 Sat, 27 Mar 2021 12:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
In-Reply-To: <xmqqk0psqxqo.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Mar 2021 20:53:11 +0100
Message-ID: <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 27, 2021 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -252,6 +252,16 @@ also be executed for each of these arguments. And the <value> part of
> >  these arguments, if any, will be used to replace the `$ARG` string in
> >  the command.
> >
> > +trailer.<token>.cmd::
> > +     The command specified by this configuration variable is run
> > +     with a single parameter, which is the <value> part of an
> > +     existing trailer with the same <token>.  The output from the
> > +     command is then used as the value for the <token> in the
> > +     resulting trailer.
> > +     The command is expected to replace `trailer.<token>.cmd`.

s/trailer.<token>.cmd/trailer.<token>.command/

> > +     When both .cmd and .command are given for the same <token>,
> > +        .cmd is used and .command is ignored.
>
> Christian, because ".cmd" is trying to eventually replace it, I find
> it a bit disturbing that the description we give here looks a lot
> smaller compared to the one for ".command".  I am afraid that we may
> have failed to reproduce something important from the description of
> the ".command" for the above; care to rend a hand or two here to
> complete the description?

Yeah, sure. I just saw that you already asked about this in this
thread. Sorry for not answering earlier.

> As I cannot grok what the description for ".command" is trying to
> say, especially around this part:
>
>     When this option is specified, the behavior is as if a special
>     '<token>=<value>' argument were added at the beginning of the command
>     line, where <value> is ...

This is because when a number of trailers are passed on the command
line, and some other trailers are in the input file, the order in
which the different trailers are processed and their priorities can be
important. So by saying the above, people can get an idea about at
which point and with which priority a trailer coming from such a
config option will be processed.

> and
>
>     If some '<token>=<value>' arguments are also passed on the command
>     line, when a 'trailer.<token>.command' is configured, the command will
>     also be executed for each of these arguments.

Yeah, this means that when a 'trailer.foo.command' is configured, it
is always executed at least once. The first time it is executed, it is
passed nothing ($ARG is replaced with the empty string). Then for each
'foo=<value>' argument passed on the command line, it is executed once
more with $ARG replaced by <value>.

The reason it is always executed first with $ARG replaced with the
empty string is that this way it makes it possible to set up commands
that will always be executed when `git interpret-trailers` is run.
This makes it possible to automatically add some trailers if they are
missing for example.

Another way to do it would be to have another config option called
`trailer.<token>.alwaysRunCmd` to tell if the cmd specified by
`trailer.<token>.cmd` should be run even if no '<token>=<value>'
argument is passed on the command line. As we are introducing
`trailer.<token>.cmd`, it's a good time to wonder if this would be a
better design. But this issue is quite complex, because of the fact
that 'trailer.<token>.ifMissing' and 'trailer.<token>.ifExists' also
take a part in deciding if the command will be run.

This mechanism is the reason why a trick, when setting up a
'trailer.foo.command' trailer, is to also set 'trailer.foo.ifexists'
to "replace", so that the first time the command is run (with $ARG
replaced with the empty string) it will add a foo trailer with a
default value, and if it is run another time, because a 'foo=bar'
argument is passed on the command line, then the trailer with the
default value will be replaced by the value computed from running the
command again with $ARG replaced with "bar".

Another trick is to have the command output nothing when $ARG is the
empty string along with using --trim-empty. This way the command will
create an empty trailer, when it is run the first time, and if it's
not another time, then this empty trailer will be removed because of
--trim-empty.

> I cannot quite judge if what we came up with in the above
> description is sufficient.

I don't think it's sufficient. I think that, while we are at it, a bit
more thinking/discussion is required to make sure we want to keep the
same design as 'trailer.<token>.command'.

> > -* Configure a 'sign' trailer with a command to automatically add a
> > +* Configure a 'sign' trailer with a cmd to automatically add a
> >    'Signed-off-by: ' with the author information only if there is no
> >    'Signed-off-by: ' already, and show how it works:
> >  +
> > @@ -309,7 +319,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
> >  $ git config trailer.sign.key "Signed-off-by: "
> >  $ git config trailer.sign.ifmissing add
> >  $ git config trailer.sign.ifexists doNothing
> > -$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
> > +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
> >  $ git interpret-trailers <<EOF
> >  > EOF
>
> This change would definitely be needed when the support for
> ".command" is removed after deprecation period.  As it does not take
> any argument, .cmd and .command should behave identically, so making
> this change now, without waiting, may make sense.

By the way the above example is an example of why we might want any
configured command to be executed at least once, even when no
corresponding '<token>=<value>' argument is passed on the command
line.

> > @@ -333,14 +343,14 @@ subject
> >  Fix #42
> >  ------------
> >
> > -* Configure a 'see' trailer with a command to show the subject of a
> > +* Configure a 'see' trailer with a cmd to show the subject of a
> >    commit that is related, and show how it works:
> >  +
> >  ------------
> >  $ git config trailer.see.key "See-also: "
> >  $ git config trailer.see.ifExists "replace"
> >  $ git config trailer.see.ifMissing "doNothing"
> > -$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
> > +$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \"\$1\"|| true "
> >  $ git interpret-trailers <<EOF
> >  > subject
>
> This, too, but until ".command" is removed, wouldn't it be better
> for readers to keep both variants, as the distinction between $ARG
> and $1 needs to be illustrated?
>
> Besides, the examples given here are not equivalent.  The original
> assumes that ARG is there, or it is OK to default to HEAD; the new
> one gives no output when $ARG/$1 is not supplied.

Yeah, I agree they are not equivalent.

> It would confuse
> readers to give two too-similar-but-subtly-different examles, as
> they will be forced to wonder if the difference is something needed
> to transition from .command to .cmd (and I am guessing that it is
> not).

I agree.

> Rewriting both to use "--pretty=reference" may be worth doing.  As
> can be seen in these examples:
>
> git show -s --pretty=reference \$1
> git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$1
>
> that it makes the result much easier to read.

Yeah, thanks for the good suggestion.
