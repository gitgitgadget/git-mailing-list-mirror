Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666961F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeKMDUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 22:20:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55963 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeKMDUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 22:20:53 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so4583983itg.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aln5m/zaZvDWZzM0SHZGRo6zhoV+5uMiqiJYwRdk3KE=;
        b=Be5TuCabBmZBfaJqaKpUzLxduLQRd6Fj+8Lt2/p7oDAgxE5oZhDMnneZ+BSVbgcxg8
         7r7FmAngBz83AeNL625oGLrspALc7IlTdqD1Xl7hbhPmjFevG/DHNJm0LEmVDNOCNHdg
         8drjtSUJrmpmv2rr4+hH+mJvHmaeA2aras5KPB9DsFIqy1rtJXg3+tSR/ABsGk0CZfMf
         qqyFUAcv7f0gh4P2NK80tnHCMriPk1o2knxpeTgTEnetsLAIqtdzZY6TTxXZGWAly7q1
         1nBcmE6ihC6ovXQuz9k4kNiw/DF/qyxEbq/nrLbc+Ka49i0O9dFQqc7IiXAucKYYrP7v
         x9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aln5m/zaZvDWZzM0SHZGRo6zhoV+5uMiqiJYwRdk3KE=;
        b=BMAT/NG0CU6Za8AJT85AKETRRGdxLoP0wnysHs7T4GrUKIfumSXrnYpeDoBDTL8TBn
         HlnsNGWW2AQEu9rZVL3Nr3DTYwX6GTA28xF9tPrupcvtncQPMqsJYv1esXOPnB7Ii4v6
         UKyfv44t7cafL3xeea0qo/xiDBwkpVfMvCBAcGFNgGYZ+HGNaTbccU5KAopAqwzTSnHj
         ArMHx4tHZx4ZFnYJUkXZjRMlvikCf3KCiB7XH4pYaw4LZW+TSMFv1d/FUHn6OVEntf+u
         5dKM+AdiCCIqCfTG1F4pzfQ8+/c1BoaSvrfM1YGk5WbNCsZddnRroOrDItTVvX5+sLAT
         N65w==
X-Gm-Message-State: AGRZ1gKdgn1cDraSng9bOEZzsNd6UkgSt9b8pc8W6fLthDTum8YYsIoW
        cTiJ5gUTDX0eFIc5e8O56KGN8kbOuboYLAQI62Y=
X-Google-Smtp-Source: AJdET5eJITKjDYpiz9aLui9fL0uPVg2AN8mT4RYLHMnVit2OSUK71vQ85aEiw5ZOaDWhobmmX0yUZkw1/Sbprmg2zbQ=
X-Received: by 2002:a24:61c2:: with SMTP id s185-v6mr543951itc.70.1542043601410;
 Mon, 12 Nov 2018 09:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20181110120707.25846-1-pclouds@gmail.com> <xmqq36s63idd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36s63idd.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 18:26:15 +0100
Message-ID: <CACsJy8DZy2hozNypxizF=LmJn8gw9z5HGhV0paiMuM9+gxYVvg@mail.gmail.com>
Subject: Re: [PATCH] checkout: disambiguate dwim tracking branches and local files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 7:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > @@ -1079,9 +1079,15 @@ static int parse_branchname_arg(int argc, const =
char **argv,
> >                */
> >               int recover_with_dwim =3D dwim_new_local_branch_ok;
> >
> > -             if (!has_dash_dash &&
> > -                 (check_filename(opts->prefix, arg) || !no_wildcard(ar=
g)))
> > -                     recover_with_dwim =3D 0;
> > +             /*
> > +              * If both refs/remotes/origin/master and the file
> > +              * 'master'. Don't blindly go for 'master' file
> > +              * because it's ambiguous. Leave it for the user to
> > +              * decide.
> > +              */
> > +             int disambi_local_file =3D !has_dash_dash &&
> > +                     (check_filename(opts->prefix, arg) || !no_wildcar=
d(arg));
>
> What you are computing on the right hand side is if the arg is
> ambiguous.  And the code that looks at this variable does not
> disambiguate, but it just punts and makes it responsibility to the
> user (which is by the way the correct thing to do).
>
> When a file with exact name is in the working tree, we do not
> declare it is a pathspec and not a rev, as we may be allowed to dwim
> and create a rev with that name and at that point we'd be in an
> ambigous situation.  If the arg _has_ wildcard, however, it is a
> strong sign that it *is* a pathspec, isn't it?  It is iffy that a
> single variable that cannot be used to distinguish these two cases
> is introduced---one of these cases will be mishandled.

Is it that different between an exact path name and a pathspec?
Suppose it is a pathspec (with wildcards) that matches some paths, and
we happen to have the remote branch origin/<that-pathspec>, then it is
still ambiguous whether we should go create branch
"<that-pathspec>" or go check out the paths matched by the pathspec.

> Also how does the patch ensures that this new logic does not kick in
> for those who refuse to let the command dwim to create a new branch?

I would hope that it would be "--" to settle all disputes. But it
looks like "git checkout foo --" is explicitly a candidate for dwim.
We have a hidden option --no-guess to disable dwim. Maybe it's a good
idea to make that one visible. It's at least clearer than using "--"
even if "--" worked on this case.

>
> >               /*
> >                * Accept "git checkout foo" and "git checkout foo --"
> >                * as candidates for dwim.
> > @@ -1094,6 +1100,9 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
> >                       const char *remote =3D unique_tracking_name(arg, =
rev,
> >                                                                 dwim_re=
motes_matched);
> >                       if (remote) {
> > +                             if (disambi_local_file)
> > +                                     die(_("'%s' could be both a local=
 file and a tracking branch.\n"
> > +                                           "Please use -- to disambigu=
ate"), arg);
>
> Ah, the only user of this variable triggers when recover_with_dwim
> is true, so that is how dwim-less case is handled, OK.
>
> That still leaves the question if it is OK to handle these two cases
> the same way in a repository without 'next' branch whose origin has
> one:
>
>     $ >next; git checkout --guess next
>     $ >next; git checkout --guess 'n??t'
>
> Perhaps the variable should be named "local_file_crashes_with_rev"
> and its the scope narrowed to the same block as "remote" is
> computed.  Or just remove the variable and check the condition right
> there where you need to.  I.e.
>
>         if (remote) {
>                 if (!has_dash_dash &&
>                     check_filename(opts->prefix, arg))
>                         die("did you mean a branch or path?: '%s'", arg);
>                 ...
>

I still think handing both cases the same way is right. In the second
case we would not find 'origin/n??t' so we fall back to checking out
pathspec 'n??t' anyway (expected from you, I think). But just in case
the remote branch 'origin/n??t' exists, we kick and scream.

I think you see 'n??t' as a pathspec, but I'm thinking about a user
who sees 'n??t' as a branch name, not pathspec and he would have a
different expectation.
--=20
Duy
