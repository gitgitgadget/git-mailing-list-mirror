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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659FC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856C060F6F
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhHZQrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhHZQrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:47:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55472C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:46:29 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g8so3945383ilc.5
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7f65LYimGEEW+cp2Ks+HVW1Ui8fRX9LlkagbijYZMUE=;
        b=g7EJ5X1NDiyB5+Bx1owfov51ji1FRJBR81R1BqU7uJbyiNLaxeQ4rVmlSkXceneJ2l
         aPjsI1+ZaIXR9DsUwi41HBI4hoJNQTwJh4yYRhFpymvDuQjByx/QQUF8r5WqJv82Lnl0
         TqhWzlAbWdGZlGvFo3xMeIB88Wo32Xt3LVMPoO2c05RF4jGIyy3pI+S2J/DDoath99Yr
         K2aCV+3jjGgqXCXKcdO5Nf7+8tZWqP16Mm568yEEdVHsuQz+olztc8xSWcDS6VC2bb5G
         W4W9SM1kvevVD/Ax2VdqsfTYIf9oRC9UvIHlvY2MH9cjDZ9UrRTUzGckwU6Ol+8cswGS
         Tm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7f65LYimGEEW+cp2Ks+HVW1Ui8fRX9LlkagbijYZMUE=;
        b=pXPQsddYVQqZI3T4TsN28QBv0tOUoj30ge3KCsKIsb+2Ltn8W5atYJ/chlMatfB1we
         rC+NF8X3CvNmCM2JFMmU8RUFQSamiKNA8z9oV/HI4EJE/0RI4gU8aE80dK75aKj/mj7F
         tUhmSrvA1v9r50b2CNhxoeFENoV8De0W/GBlG5HMem2ke8PTOHqM/u2EXCiS5+KUnp0B
         Jqgry74V2ZnH+qULnnpaNczs6GHgTtRLgaSGpDO+4z9YbyDRhvuTVhbAVbWOVXbzX9ZT
         VCCDrm9lRwICD7L4agB/v8c2lAfkBDqS+ltN9I4iRXxXaD0Jj7IyRGOFZAwJHyMDkEZ5
         zYqg==
X-Gm-Message-State: AOAM532JSLyWbi2+kBGY/ebPEXP/YJfsq7iUUIfoAuCJf7gmpwC2LYOP
        hws0LyvnyKi4BUel4TnFe0ooKEWnSP6dinAwgYHCpxwLCsY=
X-Google-Smtp-Source: ABdhPJzxljuC+apxXy6VMV/BH6dwq+JDr87KxT/MCQ3uIrXqZcpUGbsOksYpw8q6rhLMki9ghFXxTfE62EaX/A1HXEI=
X-Received: by 2002:a92:c786:: with SMTP id c6mr3295078ilk.211.1629996388681;
 Thu, 26 Aug 2021 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210820172148.2249-1-mirucam@gmail.com> <20210820172148.2249-6-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2108241541190.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108241541190.55@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 26 Aug 2021 18:46:17 +0200
Message-ID: <CAN7CjDAzAqDHBDaQ9UXoB999tdzeGwgNcixf+oB73j5U2mFK-A@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,


El mar, 24 ago 2021 a las 15:59, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Fri, 20 Aug 2021, Miriam Rubio wrote:
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
> > ---
> >  builtin/bisect--helper.c | 102 +++++++++++++++++++++++++++++++++++++++
> >  git-bisect.sh            |  62 +-----------------------
> >  2 files changed, 103 insertions(+), 61 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 1e118a966a..8d33c809aa 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -18,6 +18,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG=
")
> >  static GIT_PATH_FUNC(git_path_head_name, "head-name")
> >  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
> >  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PAREN=
T")
> > +static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
> >
> >  static const char * const git_bisect_helper_usage[] =3D {
> >       N_("git bisect--helper --bisect-reset [<commit>]"),
> > @@ -31,6 +32,7 @@ static const char * const git_bisect_helper_usage[] =
=3D {
> >       N_("git bisect--helper --bisect-replay <filename>"),
> >       N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
> >       N_("git bisect--helper --bisect-visualize"),
> > +     N_("git bisect--helper --bisect-run <cmd>..."),
> >       NULL
> >  };
> >
> > @@ -144,6 +146,25 @@ static int append_to_file(const char *path, const =
char *format, ...)
> >       return res;
> >  }
> >
> > +static int print_file_to_stdout(const char *path)
> > +{
> > +     FILE *fp;
> > +     char c;
> > +
> > +     fp =3D fopen(path, "r");
> > +     if (!fp)
> > +             return error_errno(_("cannot open file '%s' in read mode"=
), path);
> > +
> > +     c =3D fgetc(fp);
> > +     while (c !=3D EOF) {
> > +             printf ("%c", c);
> > +             c =3D fgetc(fp);
> > +     }
> > +
> > +     fclose(fp);
>
> Rather than reading byte for byte (even if buffered), how about using
> `copy_fd()`? Something like
>
>         int fd =3D open(path, O_RDONLY), ret =3D 0;
>
>         if (fd < 0)
>                 return error_errno(_("cannot open file '%s' for reading")=
, path);
>         if (copy_fd(fd, 1) < 0)
>                 ret =3D error_errno(_("failed to read '%s'"), path);
>         close(fd);
>         return ret;
>
Ok. Noted.
> > +     return 0;
> > +}
> > +
> >  static int check_term_format(const char *term, const char *orig_term)
> >  {
> >       int res;
> > @@ -1075,6 +1096,78 @@ static int bisect_visualize(struct bisect_terms =
*terms, const char **argv, int a
> >       return res;
> >  }
> >
> > +static int bisect_run(struct bisect_terms *terms, const char **argv, i=
nt argc)
> > +{
> > +     int res =3D BISECT_OK;
> > +     struct strbuf command =3D STRBUF_INIT;
> > +     struct strvec args =3D STRVEC_INIT;
> > +     struct strvec run_args =3D STRVEC_INIT;
> > +     const char *new_state;
> > +     int temporary_stdout_fd, saved_stdout;
> > +
> > +     if (bisect_next_check(terms, NULL))
> > +             return BISECT_FAILED;
> > +
> > +     if (argc)
> > +             sq_quote_argv(&command, argv);
> > +     else {
> > +             error(_("bisect run failed: no command provided."));
> > +             return BISECT_FAILED;
> > +     }
> > +
> > +     strvec_push(&run_args, command.buf);
> > +
> > +     while (1) {
> > +             strvec_clear(&args);
> > +
> > +             printf(_("running %s\n"), command.buf);
> > +             res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
> > +
> > +             if (res < 0 || 128 <=3D res) {
> > +                     error(_("bisect run failed: exit code %d from"
> > +                             " '%s' is < 0 or >=3D 128"), res, command=
.buf);
> > +                     strbuf_release(&command);
> > +                     return res;
> > +             }
> > +
> > +             if (res =3D=3D 125)
> > +                     new_state =3D "skip";
> > +             else new_state =3D res > 0 ? terms->term_bad : terms->ter=
m_good;
>
> I do not care _all_ that much about formatting, but I think others on thi=
s
> list do, and might point out that the `else` wants to live on its own
> line.
Ok. I'll change that.
>
> > +             temporary_stdout_fd =3D open(git_path_bisect_run(), O_CRE=
AT | O_WRONLY | O_TRUNC, 0666);
> > +             saved_stdout =3D dup(1);
> > +             dup2(temporary_stdout_fd, 1);
>
> This temporary redirection looks a bit iffy. I wonder whether there is a
> way to tell `bisect_state()` to print to a given file descriptor, _in
> addition to_ `stdout`? That would also make `print_file_to_stdout()`
> obsolete.
>
> What calls exactly are making that print to `stdout` anyway?

I was trying to recreate the cat command with this solution as it is
in the shell script, without changing behavior or parameters in other
functions.
I think the most important prints to stdout come from
bisect_next_all() in bisect.c. The sequence is bisect_state()
->bisect_auto_next() ->  bisect_next() ->bisect_next_all().
Just to clarify: if we add a file descriptor as parameter in
bisect_state(), we have to propagate it to a lot of functions, is that
what we want?

>
> This is my only remaining issue with the current 5/6.
Thank you for reviewing!
Miriam
>
> Thank you,
> Dscho
>
> > +
> > +             res =3D bisect_state(terms, &new_state, 1);
> > +
> > +             dup2(saved_stdout, 1);
> > +             close(saved_stdout);
> > +             close(temporary_stdout_fd);
> > +
> > +             print_file_to_stdout(git_path_bisect_run());
> > +
> > +             if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
> > +                     error(_("bisect run cannot continue any more"));
> > +             else if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> > +                     printf(_("bisect run success"));
> > +                     res =3D BISECT_OK;
> > +             } else if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOU=
ND) {
> > +                     printf(_("bisect found first bad commit"));
> > +                     res =3D BISECT_OK;
> > +             } else if (res) {
> > +                     error(_("bisect run failed:'git bisect--helper --=
bisect-state"
> > +                     " %s' exited with error code %d"), args.v[0], res=
);
> > +             } else {
> > +                     continue;
> > +             }
> > +
> > +             strbuf_release(&command);
> > +             strvec_clear(&args);
> > +             strvec_clear(&run_args);
> > +             return res;
> > +     }
> > +}
> > +
> >  int cmd_bisect__helper(int argc, const char **argv, const char *prefix=
)
> >  {
> >       enum {
> > @@ -1089,6 +1182,7 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >               BISECT_REPLAY,
> >               BISECT_SKIP,
> >               BISECT_VISUALIZE,
> > +             BISECT_RUN,
> >       } cmdmode =3D 0;
> >       int res =3D 0, nolog =3D 0;
> >       struct option options[] =3D {
> > @@ -1112,6 +1206,8 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
> >                        N_("skip some commits for checkout"), BISECT_SKI=
P),
> >               OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
> >                        N_("visualize the bisection"), BISECT_VISUALIZE)=
,
> > +             OPT_CMDMODE(0, "bisect-run", &cmdmode,
> > +                      N_("use <cmd>... to automatically bisect."), BIS=
ECT_RUN),
> >               OPT_BOOL(0, "no-log", &nolog,
> >                        N_("no log for BISECT_WRITE")),
> >               OPT_END()
> > @@ -1177,6 +1273,12 @@ int cmd_bisect__helper(int argc, const char **ar=
gv, const char *prefix)
> >               get_terms(&terms);
> >               res =3D bisect_visualize(&terms, argv, argc);
> >               break;
> > +     case BISECT_RUN:
> > +             if (!argc)
> > +                     return error(_("bisect run failed: no command pro=
vided."));
> > +             get_terms(&terms);
> > +             res =3D bisect_run(&terms, argv, argc);
> > +             break;
> >       default:
> >               BUG("unknown subcommand %d", cmdmode);
> >       }
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 95f7f3fb8c..e83d011e17 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -39,66 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> >  TERM_BAD=3Dbad
> >  TERM_GOOD=3Dgood
> >
> > -bisect_run () {
> > -     git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail =
|| exit
> > -
> > -     test -n "$*" || die "$(gettext "bisect run failed: no command pro=
vided.")"
> > -
> > -     while true
> > -     do
> > -             command=3D"$@"
> > -             eval_gettextln "running \$command"
> > -             "$@"
> > -             res=3D$?
> > -
> > -             # Check for really bad run error.
> > -             if [ $res -lt 0 -o $res -ge 128 ]
> > -             then
> > -                     eval_gettextln "bisect run failed:
> > -exit code \$res from '\$command' is < 0 or >=3D 128" >&2
> > -                     exit $res
> > -             fi
> > -
> > -             # Find current state depending on run success or failure.
> > -             # A special exit code of 125 means cannot test.
> > -             if [ $res -eq 125 ]
> > -             then
> > -                     state=3D'skip'
> > -             elif [ $res -gt 0 ]
> > -             then
> > -                     state=3D"$TERM_BAD"
> > -             else
> > -                     state=3D"$TERM_GOOD"
> > -             fi
> > -
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
> > -
> > -             if [ $res -ne 0 ]
> > -             then
> > -                     eval_gettextln "bisect run failed:
> > -'bisect-state \$state' exited with error code \$res" >&2
> > -                     exit $res
> > -             fi
> > -
> > -             if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BI=
SECT_RUN" >/dev/null
> > -             then
> > -                     gettextln "bisect run success"
> > -                     exit 0;
> > -             fi
> > -
> > -     done
> > -}
> > -
> >  get_terms () {
> >       if test -s "$GIT_DIR/BISECT_TERMS"
> >       then
> > @@ -137,7 +77,7 @@ case "$#" in
> >       log)
> >               git bisect--helper --bisect-log || exit ;;
> >       run)
> > -             bisect_run "$@" ;;
> > +             git bisect--helper --bisect-run "$@" || exit;;
> >       terms)
> >               git bisect--helper --bisect-terms "$@" || exit;;
> >       *)
> > --
> > 2.29.2
> >
> >
