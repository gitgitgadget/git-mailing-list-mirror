Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2BCC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033AD611BD
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhDCFIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhDCFIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 01:08:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85499C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 22:08:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v26so7094353iox.11
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UKEFzL8D/7HOztvL+OfbBRC9TgNEcAeJWi+KMwy6gbA=;
        b=qtaqvrhm7suN0ypqZAOP4YlIvp0+fL4XnPvnu+OQpCEwgU0+lFCmhNHXc1s4n2TsLo
         Dpv5Uk6weNjuzGNMrZc/mlROl33qJgAh1AUB3qIHe+pdRWecLp6jEmtBaR2F2RJvpXEY
         74h5qXserjz6X9d3vcPjAPcSfp+3ok6VtVoSY0Hn7JfGltNd5L4PUIvbULhmzdz8bIY3
         x3fY5+v9lYghma/xVeln3auEGeOAsvHpTOjvW6/p+TVvihElOkFjg7VvOCULKhq2E6r7
         ifXKko2mnNxG3Y4uoGJaN2F/48LZ9cYIdAcB95ssOFefYVTuBwT9466+V7sD7DE1dT+Z
         4ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UKEFzL8D/7HOztvL+OfbBRC9TgNEcAeJWi+KMwy6gbA=;
        b=ErnyzmTXCEIQoqWyJyXTFDqudL5j9X9tqx8fyTnAQ6UvvL2fMpH88oGzWGT9C3HItn
         EworH4VVPKOPU388w9QqxfY1RlyFDC3Q6vZ7PQGaASkRL7hU19PWdZArpUsDccBQv3in
         7zDsZW/n2wvbJ2SLB+pTYiOL84WpX5ytp55qKHGuQwuTsTdT63dYuwC1Mzgt3Ic5atGE
         eX41goe+BMmWXtNEp/EfYMHd//PxzK9IQKQpUfvH/vWKkKgTwRcNjqZ06awcEDwLEP4S
         cCgtyF/xnd8tKprFd93Q90ivTpI4jbq5TVA2LaHXHVcQV9JipodrBDcDy6vD6JDTAV4h
         cOqA==
X-Gm-Message-State: AOAM530DRixytgWNn8ILD0CSYQX9xU60V1sByaU4MkqRCxH7zunHRY5Q
        hJYDnnlQlm6iUWFf7gf3hE/Y8F5WacQI6nWAvRJMiajmmNTun9G4
X-Google-Smtp-Source: ABdhPJxuWGR7Gb0FaZAPbVEdVAz9kQ+gfcsGIghJELR4XxKzA8/nbrwQF0KgIvKo+PeEAGYlWERqqUAk3t2kEOEtiMU=
X-Received: by 2002:a02:ce8d:: with SMTP id y13mr15457500jaq.29.1617426496828;
 Fri, 02 Apr 2021 22:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
In-Reply-To: <xmqqim544dl4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Apr 2021 13:08:05 +0800
Message-ID: <CAOLTT8Tq+-tRzgG1AFD2cE2Vp9z3E94eW1eyN2BxKKg17FzTng@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:49=E5=86=99=E9=81=93=EF=BC=9A

> > +the behavior is as if a special '<token>=3D<value>' argument were adde=
d at
> > +the beginning of the command, <value> will be passed to the user's
> > +command as an empty value.
>
> Do the two occurrences of the word "command" in the sentence refer
> to different things?  I do not think this is an existing problem
> inherited from the original, but as we are trying to improve the
> description, I wonder if we can clarify them a bit.
>
>         ... as if a '<token>=3D<value>' argument were added at the
>         beginning of the "git interpret-trailers" command, the
>         command specified by this configuration variable will be
>         called with an empty string as the argument.
>
> is my attempt, but I am not still sure what that "as if" part is
> trying to say.  Does it mean with
>
>         [trailer "Foo"] cmd =3D foo-cmd
>
> and the 'input-file' does not have "Foo: <some existing value>"
> trailer in it, the command "git interpret-trailers input-file"
> would behave as if this command was run
>
>         $ Foo=3D git interpret-trailers input-file
>
> (as there is no <value>, I am not sure what <value> is used when
> <token>=3D<value> is prefixed to the command)?
>
> Puzzled and confused utterly am I...  Help, Christian?
>

If we don=E2=80=99t want a input-file without any trailers to execute this =
command,
 I=E2=80=99m thinking that we maybe need "trailer.<token>.ifmissing=3DdoNot=
hing"
or something else, otherwise execute this 'alwaysRunCmd' for create a
empty trailer like "Signed-off-by" and users can use it to add content.

> >  +
> >  If some '<token>=3D<value>' arguments are also passed on the command
> >  line, when a 'trailer.<token>.command' is configured, the command will
> >  also be executed for each of these arguments. And the <value> part of
>
> This talks about 'trailer.<token>.command'.  Should this be changed
> to '.cmd'?
>
> Or does everything after "When this option is specified, if there is
> no trailer with ..." apply to both the old .command and new .cmd?
> If so, that was not clear at all---we'd need to clarify this part.
>

Because ".command" will be eliminated, may be only leave those
description Information to ".cmd" is better.

> > -these arguments, if any, will be used to replace the `$ARG` string in
> > -the command.
> > +these arguments, if any, will be passed to the command as first parame=
ter.
> >
> >  EXAMPLES
> >  --------
> > @@ -333,6 +346,55 @@ subject
> >  Fix #42
> >  ------------
> >
> > +* Configure a 'see' trailer with a cmd use a global script `git-one`
> > +  to show the subject of a commit that is related, and show how it wor=
ks:
> > ++
> > +------------
> > +$ cat ~/bin/git-one
> > +#!/bin/sh
> > +git show -s --pretty=3Dreference "$1"
> > +$ git config trailer.see.key "See-also: "
> > +$ git config trailer.see.ifExists "replace"
> > +$ git config trailer.see.ifMissing "doNothing"
> > +$ git config trailer.see.cmd "~/bin/git-one"
> > +$ git interpret-trailers <<EOF
> > +> subject
> > +>
> > +> message
> > +>
> > +> see: HEAD~2
> > +> EOF
> > +subject
> > +
> > +message
> > +
> > +See-also: fe3187e (subject of related commit, 2021-4-2)
> > +------------
> > +
> > +* Configure a 'who' trailer with a cmd use a global script `git-who`
> > +  to find the recent matching "author <mail>" pair in git log and
> > +  show how it works:
> > ++
> > +------------
> > +$ cat ~/bin/git-who
> > + #!/bin/sh
> > +    git log -1 --format=3D"%an <%ae>" --author=3D"$1"
>
> Unusual indentation here.  But more importantly, I am not sure if
> having both 'see' and 'help' examples is worth it---they are similar
> enough that the second one does not teach anything new to those who
> studied the first one already, aren't they?
>

Ok, I will think about other examples.

> > +$ git config trailer.help.key "Helped-by: "
> > +$ git config trailer.help.ifExists "replace"
> > +$ git config trailer.help.cmd "~/bin/git-who"
> > +$ git interpret-trailers --trailer=3D"help:gitster@" <<EOF
> > +> subject
> > +>
> > +> message
> > +>
> > +> EOF
> > +subject
> > +
> > +message
> > +
> > +Helped-by: Junio C Hamano <gitster@pobox.com>
> > +------------
> > +
> >  * Configure a 'see' trailer with a command to show the subject of a
> >    commit that is related, and show how it works:
> >  +
>
>
>
> > diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers=
.sh
> > index 6602790b5f4c..923923e57573 100755
> > --- a/t/t7513-interpret-trailers.sh
> > +++ b/t/t7513-interpret-trailers.sh
> > @@ -51,6 +51,77 @@ test_expect_success 'setup' '
> >       EOF
> >  '
> >
> > +test_expect_success 'with cmd' '
> > +     test_when_finished "git config --unset trailer.bug.key && \
> > +                         git config --unset trailer.bug.ifExists && \
> > +                         git config --unset trailer.bug.cmd" &&
>
> It is unwise to use && between these three "git config" invocations,
> I suspect.  "git config --unset" exits with non-zero status when you
> attempt to remove with an non-existent key, but you would remove the
> .ifExists and .cmd even if .key is not defined.  Perhaps
>
>         test_when_finished "git config --unset-all trailer.bug.key
>                             git config --unset-all trailer.bug.ifExists
>                             git config --unset-all trailer.bug.cmd" &&
>
> would be more sensible.  Or if we just want to remove everything
> under the trailer.bug.* section, this might be even better:
>
>         test_when_finished "git config --remove-section trailer.bug" &&
>
> as we can add new trailer.bug.* to the system and use them in this
> test, but removing the entire section would still be a good way to
> clean after ourselves.
>

Good idea, This removing is also more efficient.

> > diff --git a/trailer.c b/trailer.c
> > index be4e9726421c..6aeff6a1bd33 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > ...
> > +static char *apply_command(struct conf_info *conf, const char *arg)
> >  {
> >       struct strbuf cmd =3D STRBUF_INIT;
> >       struct strbuf buf =3D STRBUF_INIT;
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> >       char *result;
> >
> > -     strbuf_addstr(&cmd, command);
> > -     if (arg)
> > -             strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> > -
> > -     strvec_push(&cp.args, cmd.buf);
> > +     if (conf->cmd) {
> > +             // cp.shell_no_implicit_args =3D 1;
>
> Do not add new code that is commented out.  Besides we do not use // comm=
ent.
>
> > +             strbuf_addstr(&cmd, conf->cmd);
> > +             strvec_push(&cp.args, cmd.buf);
> > +             if (arg)
> > +                     strvec_push(&cp.args, arg);
>
> Thanks.

Thanks.
