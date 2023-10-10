Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2672CD8CA2
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 15:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJJPUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjJJPUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 11:20:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A32A7
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 08:20:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a516b015cso1083142276.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696951201; x=1697556001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xZ35rMOcSgROfd9iA+c1DQjtHqGaQa41aPQVahLqSM=;
        b=Q490OnPwQC6N3YAZnlt7XaUmmEuHZ/+ViZ79VL2iZxgMJexscEh2PkZEF+pD1lI6si
         G53F3SbeDg5w6u++/GyhUKTAtRKI8EaQPNYTSJnzsYsuRGI4E/xGBYH0WRGpZEMBjeJM
         38SLVUHsbvIkbDLCo4XUhc+NYYqfLCLvVZNpu7DG18IFPReXbGjRQg89sFTpGHzmgG7L
         expMu0n+ZHR/JWaSrhlGVMz/jMpPR1sMPX6IEYsx8JizZAjSrACi9U1q4eX/SNN6UauN
         GAfcC3TCNF5l0ZCwC4K/IU92irRd7DpxDUP72Wrvxjaqf/ceh4NMIgQ5APZQMffJ6ghN
         LlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951201; x=1697556001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xZ35rMOcSgROfd9iA+c1DQjtHqGaQa41aPQVahLqSM=;
        b=pPgwdfsJnNNmkl7XmecVri9Xje3D1ZT2K+/W0o1JuWc1pm6CVtJYGoEyCvX2QUhnP8
         cjvmWMYZNPQDqjiChUsNpKg1r01VabdoFF/fwcGO8gv/gR/GworsBHI549iTypsfamVi
         MmWJxYnlhmUDeIvVOJIj6ZrzCvGhqsWRd5Gcv1qXdznDSW7alQ3JPRLRviQJogYAveCh
         4hGsf9PodrZ/Yvx1wCrHgAOz+UQNLLJSbq3bWkRIABNYBE4CK2jsLRXLQrknRXhCaXDb
         IuKDxK8YLDAvGBsG+pdVcNZ3voOirsG8lS8yfrddZ5ul1QkSzX/RehHchQrI0iSr/0w4
         zfew==
X-Gm-Message-State: AOJu0YzIE2UAyI6kjf+deB/pmVbWhgfgaQzDraLURJYRxBM4GcCvyZq5
        7qBzEujTHoO7aAG+OmGQcMI13oc0xW0m4nIq8g==
X-Google-Smtp-Source: AGHT+IHXXfe3sU/IZRsRJdLlPm82PEtSPsZVsFRicBC8DR2p6A8IBJbC0nUgIElXFGEjdwyFqe6BtG5sWXeUTVvxwSw=
X-Received: by 2002:a25:db8e:0:b0:d9a:60c8:c5ff with SMTP id
 g136-20020a25db8e000000b00d9a60c8c5ffmr1958795ybf.65.1696951201206; Tue, 10
 Oct 2023 08:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011546.509-1-naomi.ibeh69@gmail.com> <xmqqlecbzl5e.fsf@gitster.g>
In-Reply-To: <xmqqlecbzl5e.fsf@gitster.g>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Tue, 10 Oct 2023 16:19:46 +0100
Message-ID: <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much! I'd definitely make those changes on my next patch.
Should I begin work on version 2 or should I still wait for additional
input on the version 1?

On Mon, Oct 9, 2023 at 7:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Naomi Ibe <naomi.ibeh69@gmail.com> writes:
>
> > Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to gui=
delines when using d
>
> Subject: [OUTREACHY][PATCH 1/1] builtin/add.c: clean up die() messages
>
> > From: Naomi <naomi.ibeh69@gmail.com>
>
> The name and address on this line come from your commit object,
> which in turn would have came from your configuration.  You have
>
>     [user]
>         name =3D Naomi
>         email =3D naomi.ibeh69@gmail.com
>
> somewhere in your configuration file, perhaps in $HOME/.gitconfig or
> somewhere.  When contributiong to this project, you want that "name"
> line to also include your family name, as it should match what you
> write on your Signed-off-by: line.  A focused way to do so without
> affecting your author identity for other projects is to add
>
>     [user]
>         name =3D Naomi Ibe
>
> in .git/config of the repository that you use to contribute to this
> project, e.g.,
>
>     $ cd ... to the working tree of your clone of git you work in ...
>     $ git config user.name "Naomi Ibe"
>
> The space above your Sign off is to fill the details you omitted on
> the title of the message (which would say something about "conform
> to guidelines" or "clean up" without mentioning what rule the
> original violates), making the whole thing something like:
>
>     builtin/add.c: clean up die() messages
>
>     As described in the CodingGuidelines document, a single line
>     message given to die() and its friends should not capitalize its
>     first word, and should not add full-stop at the end.
>
>     Signed-off-by: ...
>
> > Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
> > ---
> >  builtin/add.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Thanks.  Otherwise the patch looks good.
>
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index c27254a5cd..5126d2ede3 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -182,7 +182,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
> >       git_config(git_diff_basic_config, NULL); /* no "diff" UI options =
*/
> >
> >       if (repo_read_index(the_repository) < 0)
> > -             die(_("Could not read the index"));
> > +             die(_("could not read the index"));
> >
> >       repo_init_revisions(the_repository, &rev, prefix);
> >       rev.diffopt.context =3D 7;
> > @@ -200,15 +200,15 @@ static int edit_patch(int argc, const char **argv=
, const char *prefix)
> >               die(_("editing patch failed"));
> >
> >       if (stat(file, &st))
> > -             die_errno(_("Could not stat '%s'"), file);
> > +             die_errno(_("could not stat '%s'"), file);
> >       if (!st.st_size)
> > -             die(_("Empty patch. Aborted."));
> > +             die(_("empty patch. aborted"));
> >
> >       child.git_cmd =3D 1;
> >       strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
> >                    NULL);
> >       if (run_command(&child))
> > -             die(_("Could not apply '%s'"), file);
> > +             die(_("could not apply '%s'"), file);
> >
> >       unlink(file);
> >       free(file);
> > @@ -568,7 +568,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
> >  finish:
> >       if (write_locked_index(&the_index, &lock_file,
> >                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> > -             die(_("Unable to write new index file"));
> > +             die(_("unable to write new index file"));
> >
> >       dir_clear(&dir);
> >       clear_pathspec(&pathspec);
