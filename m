Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A924C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567D6610A6
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 10:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhDKKEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKKEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 06:04:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9269C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:04:36 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b10so10370753iot.4
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tWR35t4ETC9oLiRtDc/k2Cz/ZwMRENgsBUWS1+w2wkE=;
        b=OcYVsWzQCjynHYiIfbofpLGpKbq+Va8XcYOCsRmnPV7t/QGoKMD7Qfv/poR99O3t66
         TMAr7eijVJBYGfeYkYCsBFqD2I30Q5wFS9rsqlZybOLdqjeAjiBFW/BVXtOtGh0j3jsJ
         yuHOHhnVCxXEbi04O1n72KzdzS870QbGrs90+u/TiYeTnNtmEL7uuXnznqAFfhKwoh0C
         TkkvdkA5+Wg0YSjyKd4dzw/mIS27xh+4BBERHh3ghv5yi22EcF2e9QEp/IpwSpxKgraj
         hDOVe+INdKoi3UXXQKkBJ51nJ0jRaopYrBGF/e8KrYpzIGTIYvNnVY/Jv6hNGz0fsLHr
         /4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tWR35t4ETC9oLiRtDc/k2Cz/ZwMRENgsBUWS1+w2wkE=;
        b=c3rJagB2fgR3YLCNAPUuK2FRxFydpsWVTqJkiW4zUA1zEJ4AQeiUmm3ZAoNatxVzzw
         IPdVzLILHnxTVTjURpLvfhxr79E1TJH5/QMIwQfVax+B7k/spRitFV234tJuOWy54lJ8
         lCQcQPIApHBv7+aW6D0WnIpzeKwSTQgnXy6SRL++9MfSYYfj8DM/EiFHbAg0Q2KVH5+X
         la4jceFA+vNQt99HDVOXV9J7oN9y1UCmosl3bzZUmyhg0PR2iRJKbsf+UTq8O3/iR3kH
         uUPyZ6bFZgOjU2iLz7Jeqkvm4C0c3ZY6okJRKAqhZEUfpR7M/nxpUYp56YNlbHku0qgy
         i/mw==
X-Gm-Message-State: AOAM531FXl4hj/ZbVXolTWfLdHCUmEexg64guHlZD8LyTetOZzwjUNKU
        MG+JHrP6A5jHmEzD2s432UVLJ0GQ7ZFyNn013qQ=
X-Google-Smtp-Source: ABdhPJyHKfw/k6HvZsL9VOhvZb3cbiiHVpdFMTIjLi0TE6GdBbnVQUWOOEnWTufYJ7cH5/GB3FDJ7DdsqwDmUWwaAgg=
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr6648847iom.154.1618135476303;
 Sun, 11 Apr 2021 03:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210407173334.68222-1-mirucam@gmail.com> <20210407173334.68222-4-mirucam@gmail.com>
 <xmqqeeflycf9.fsf@gitster.g>
In-Reply-To: <xmqqeeflycf9.fsf@gitster.g>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sun, 11 Apr 2021 12:04:25 +0200
Message-ID: <CAN7CjDD02yjB2QX2VQxfVie6OchkVLfH3Hog8s1jXZw5uDDTzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El jue, 8 abr 2021 a las 0:09, Junio C Hamano (<gitster@pobox.com>) escribi=
=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > From: Tanushree Tumane <tanushreetumane@gmail.com>
> >
> > Reimplement the `bisect_run()` shell function
> > in C and also add `--bisect-run` subcommand to
> > `git bisect--helper` to call it from git-bisect.sh.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
>
> If I am reading the patch correctly, this removes the need for the
> $GIT_DIR/BISECT_RUN file that used to be used to keep track of the
> state?  If that is true, it is worth noting in the proposed log
> message.
>
> As far as I can see, nobody creates $GIT_DIR/BISECT_RUN anymore.
>
>     $ git grep -e path_bisect_run -e BISECT_RUN
>     bisect.c:static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>     bisect.c:   unlink_or_warn(git_path_bisect_run());
>     builtin/bisect--helper.c:           BISECT_RUN,
>     builtin/bisect--helper.c:                    N_("use <cmd>... to auto=
matical...
>     builtin/bisect--helper.c:   case BISECT_RUN:
>     t/t6030-bisect-porcelain.sh:        test_path_is_missing ".git/BISECT=
_RUN" &&
>
> What if a run script tried to read from (or checked the presence of)
> the file for its correct operation (e.g. I would imagine that "do
> this operation when run interactively, but do the same operation
> silently when run from the git-bisect machinery" may be a reasonable
> thing to do)?
>
> This change just unintendedly broke such a script, didn't it?  The
> change makes me a bit worried.
Hi,
thank you for reviewing!.
I don't know why the need for the $GIT_DIR/BISECT_RUN file was
removed, so in the last patch series version I have just sent,
I have added the creation of the file and it contains bisect_state()
output as in original shell script version.
Regards,
Miriam
>
> > +     if (bisect_next_check(terms, NULL))
> > +             return BISECT_FAILED;
> > +
> > +     if (argc)
> > +             sq_quote_argv(&command, argv);
> > +     else
> > +             return BISECT_FAILED;
> > +
> > +     run_args.v[0] =3D xstrdup(command.buf);
> > +     run_args.nr =3D 1;
> > +
> > +     while (1) {
> > +             strvec_clear(&args);
> > +
> > +             printf(_("running %s"), command.buf);
> > +             res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
>
> Nicely used sq_quote_argv() with RUN_USING_SHELL here.  Goodl.
>
> > +             if (res < 0 && res >=3D 128) {
> > +                     error(_("bisect run failed: exit code %d from"
> > +                             " '%s' is < 0 or >=3D 128"), res, command=
.buf);
> > +                     strbuf_release(&command);
> > +                     return res;
> > +             }
> > +
> > +             if (res =3D=3D 125)
> > +                     strvec_push(&args, "skip");
> > +             else if (res > 0)
> > +                     strvec_push(&args, terms->term_bad);
> > +             else
> > +                     strvec_push(&args, terms->term_good);
> > +
>
> bisect_state() does so much that it was a bit hard to follow for me
> (who hasn't been following the bisect-in-C topic very closely), but
> the code around here roughly corresponds to the following snippet in
> the original scripted version.
>
> > -             git bisect--helper --bisect-state $state >"$GIT_DIR/BISEC=
T_RUN"
> > -             res=3D$?
> > -
> > -             cat "$GIT_DIR/BISECT_RUN"
> > -
> > -             if sane_grep "first $TERM_BAD commit could be any of" "$G=
IT_DIR/BISECT_RUN" \
> > -                     >/dev/null
> > -             then
> > -                     gettextln "bisect run cannot continue any more" >=
&2
> > -                     exit $res
> > -             fi
>
> I see that the contents of the file BISECT_RUN is shown to the user
> in the original but is that part of what bisect_state() does, or did
> we lose it during this round of conversion?
>
> > +             res =3D bisect_state(terms, args.v, args.nr);
> > +             if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> > +                     printf(_("bisect run success"));
> > +                     res =3D BISECT_OK;
> > +             } else if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
> > +                     error(_("bisect run cannot continue any more"));
> > +             else if (res)
> > +                     error(_("bisect run failed:'git bisect--helper --=
bisect-state"
> > +                             " %s' exited with error code %d"), args.v=
[0], res);
> > +             else
> > +                     continue;
>
> In any case, being able to check the return value from bisect_state()
> and switch is so much nicer than having to sane_grep in BISECT_RUN.
>
> > +             strbuf_release(&command);
> > +             strvec_clear(&args);
> > +             strvec_clear(&run_args);
> > +
> > +             return res;
> > +     }
> > +}
> > +
> >  int cmd_bisect__helper(int argc, const char **argv, const char *prefix=
)
> >  {
> >       enum {
> > @@ -1086,7 +1146,8 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >               BISECT_LOG,
> >               BISECT_REPLAY,
> >               BISECT_SKIP,
> > -             BISECT_VISUALIZE
> > +             BISECT_VISUALIZE,
> > +             BISECT_RUN,
>
> Now this new one has the trailing comma.  I'd suggest doing so in
> the previous step.
>
> Thanks.
