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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07022C433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49CF64E07
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 14:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhCNOOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhCNOOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 10:14:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330BC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 07:14:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w65so31941517oie.7
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BPsd+yTKlrPn0HLtYO7yZYdwTMJ1JH32hbNbh1GmEYI=;
        b=GmWAPTL41q2KcDH7gU/PWOnaO5UmEkFTo6x1jLJ0G8gSmSJ8RSnM2Ob0FL/SOwx6YA
         IvgWGRAGou58uQ8FmWLnwALcHU52f3d474WPnqmQZwmnmPxiqk804yCJsUY7wV4X/LM5
         jYLu32SzJ3ik5vNtRmQsKG206e4ZqgkF0tVYoIc5v+EvKC/PPV3Db4pN4WBihvlXJq3f
         +mo5ZWkdCG4ozPvAMf0eJb0+StRMs+ItAjr4eEzoVfDKFRJ58KJQ1aNc4n0tjPoaSOgj
         8Nm6we0cxI65xXe6iNSdUQnhiCVxmRunlUrat6mcrtT1YoN0O6/vxzWLirjnmhjy2i+c
         73UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BPsd+yTKlrPn0HLtYO7yZYdwTMJ1JH32hbNbh1GmEYI=;
        b=gQumqxOK2EMb8G35Xh8J+xKLtlbU7jsJ70e8ylvnfjKE+tUjMu4e0t2Mwd3ryoHRih
         I+04mBbokZS4LFCr/XLdRy2GacGFbhX9QOmMyN0sl70OQWSaIpF6TkFM7Xj36tfsXPUB
         KN8dq7HP8Ue8pPHej/5xpGEmYuwNUMwlNTvnggXOktFFRj4p3cytQi/Fa6gDl8XDbk+J
         bgDDC3QmFecSr1d1cxX/XS5AQqULpurrwbxbUMPiR6oSKNU+jTZ2pQzr6zJDbVU1ghr1
         73ITpJC7sU2bnNy14Jh+HNO2mW5tSqzrpniUb51rZynSzN+6ArqlY8tqNy8IeYI1CYHA
         9kgw==
X-Gm-Message-State: AOAM530xGOjdH9visizsfoKM49VfGlqxGCdO6amUOvJe1ndrLSJRLaae
        cZ97kAcJicw61lfYg8tnRRjpv1ZGTlx/mTo03i0=
X-Google-Smtp-Source: ABdhPJyh2iWZwBtefLbmCER1ua9yEvaxt1qc8KUx2OmhJofYpJBR4EzdjmK6MUN1wHaH2XHRDgXTmO2K1YvPN+G6E1Q=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr16098451oia.44.1615731244418;
 Sun, 14 Mar 2021 07:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
 <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com> <87czw1yj6q.fsf@gmail.com>
In-Reply-To: <87czw1yj6q.fsf@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 22:13:53 +0800
Message-ID: <CAOLTT8RKg_yMnxQ7FXX=bytAEST8KMKbCyeP6LemRdZvvQ5Kpg@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC] commit: add --trailer option
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=88=
14=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:46=E5=86=99=E9=81=93=EF=
=BC=9A
>
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 739110c5a7f6..abbd136b27f0 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -113,6 +113,8 @@ static int config_commit_verbose =3D -1; /* unspeci=
fied */
> >  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
> >  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, =
*ignored_arg;
> >  static char *sign_commit, *pathspec_from_file;
> > +struct child_process run_trailer =3D CHILD_PROCESS_INIT;
> > +static const char *trailer;
> >
> >  /*
> >   * The default commit message cleanup mode will remove the lines
> > @@ -131,6 +133,17 @@ static struct strbuf message =3D STRBUF_INIT;
> >
> >  static enum wt_status_format status_format =3D STATUS_FORMAT_UNSPECIFI=
ED;
> >
> > +static int opt_pass_trailer(const struct option *opt, const char *arg,=
 int unset)
> > +{
> > +     if (unset) {
> > +             strvec_clear(&run_trailer.args);
> > +             return -1;
> > +     }
> > +     run_trailer.git_cmd =3D 1;
> > +     strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
> > +     return 0;
> > +}
> > +
> >  static int opt_parse_porcelain(const struct option *opt, const char *a=
rg, int unset)
> >  {
> >       enum wt_status_format *value =3D (enum wt_status_format *)opt->va=
lue;
> > @@ -958,6 +971,8 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
> >
> >       fclose(s->fp);
> >
> > +     run_command(&run_trailer);
> > +
>
> There is slight problem with running the command unconditionally.
> If no --trailer is passed, then the opt_pass_trailer() backend
> is never called, which consequently will not set the trailer
> command ".git_cmd" option to 1.
>
> This will lead the run_command() API to not interpret the command as git
> internal, and attempt to launch as an usual command "interpret-trailers"
> that will likely not exist or launch an unwanted command that is not
> part of the GIT suite.
>
> This can be seen by running `git commit` without any options:
>
>      $ ./bin-wrappers/git -C /tmp/test commit
>      error: cannot run interpret-trailers: No such file or directory
>      ...
>
> The `.git_cmd` should be set to true before running the command.
>
> (the above output is from a built version with v2.31.0-rc2 + this patch
>  for confirmation).
>
>
> Furthermore, in my opinion, we shouldn't even bother to run the command
> if no --trailer is passed, otherwise, we always be paying the cost of
> launching an OS process regardless if the user doesn't want to add
> trailers in theirs projects.
>
> With that said and based on this current implementation, maybe an
> improved version will look like:
>
>         if (run_trailer.args.nr) {
>                 run_trailer.git_cmd =3D 1;
>                 run_command(&run_trailer);
>         }
>
> Naturally the `git_cmd =3D 1` will be removed from opt_pass_trailer()
> function as it won't be necessary. As minor bonus, we don't end up
> setting the value for every new --trailer :).

Thank you, I didn't notice the problem before :).

>
> >       /*
> >        * Reject an attempt to record a non-merge empty commit without
> >        * explicit --allow-empty. In the cherry-pick case, it may be
> > @@ -1507,6 +1522,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> >               OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("=
use autosquash formatted message to fixup specified commit")),
> >               OPT_STRING(0, "squash", &squash_message, N_("commit"), N_=
("use autosquash formatted message to squash specified commit")),
> >               OPT_BOOL(0, "reset-author", &renew_authorship, N_("the co=
mmit is authored by me now (used with -C/-c/--amend)")),
> > +             OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("t=
railer(s) to add"), opt_pass_trailer),
> >               OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-b=
y trailer")),
> >               OPT_FILENAME('t', "template", &template_file, N_("use spe=
cified template file")),
> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commi=
t")),
> > @@ -1577,6 +1593,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> >                       die(_("could not parse HEAD commit"));
> >       }
> >       verbose =3D -1; /* unspecified */
> > +     strvec_pushl(&run_trailer.args, "interpret-trailers",
> > +             "--in-place", "--where=3Dend", git_path_commit_editmsg(),=
 NULL);
>
> Style: The "--in-place" part should be aligned with the parentheses
> much the like the following line with the "argc =3D parse_and_validate_op=
tions....".
>

Well, the CodingGuidelines say it's both vaild. But you are right,
try to keep the same format as nearby code will be better.

> For example:
>
>         strvec_pushl(&run_trailer.args, "interpret-trailers",
>                      "--in-place", "--where=3Dend", .....
>
> >       argc =3D parse_and_validate_options(argc, argv, builtin_commit_op=
tions,
> >                                         builtin_commit_usage,
> >                                         prefix, current_head, &s);
> > diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> > index 6396897cc818..4b9ac4587d17 100755
> > --- a/t/t7502-commit-porcelain.sh
> > +++ b/t/t7502-commit-porcelain.sh
> > @@ -154,6 +154,26 @@ test_expect_success 'sign off' '
> >
> >  '
> >
> > +test_expect_success 'trailer' '
> > +     >file1 &&
> > +     git add file1 &&
> > +     git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@ex=
ample.com>" \
> > +     --trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
> > +     --trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
> > +     --trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
> > +     -m "hello" &&
>
> Perhaps here, the --trailer lines and "-m hello" option should be
> indent in order to make it clear that these option are part of the
> "git commit" from the above line, something like this:
>
>         git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@ex=
ample.com>" \
>                 --trailer "Helped-by:C O Mitter2 <committer2@example.com>=
"  \
>                 --trailer "Reported-by:C O Mitter3 <committer3@example.co=
m>" \
>                 --trailer "Mentored-by:C O Mitter4 <committer4@example.co=
m>" \
>                 -m "hello" &&
>
> > +     git cat-file commit HEAD >commit.msg &&
> > +     sed -e "1,7d" commit.msg >actual &&
> > +     cat >expected <<-\EOF &&
> > +     Signed-off-by: C O Mitter <committer@example.com>
> > +     Signed-off-by: C O Mitter1 <committer1@example.com>
> > +     Helped-by: C O Mitter2 <committer2@example.com>
> > +     Reported-by: C O Mitter3 <committer3@example.com>
> > +     Mentored-by: C O Mitter4 <committer4@example.com>
> > +     EOF
> > +     test_cmp expected actual
> > +'
> > +
> >  test_expect_success 'multiple -m' '
>
>
> Hope these comments are useful.
> --
> Thanks
> Rafael

 I am gratitude to you for helping me.
--
Thanks
ZheNing Hu
