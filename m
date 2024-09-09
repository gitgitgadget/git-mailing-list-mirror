Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C118C008
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916117; cv=none; b=ai+d+T5j8YENImLwhJn4FalLTra26SyMRR9XbXCph6iCOXYmdOC3h6VdC/B59lf67BZDB8bM/aJbAMfLb6JR6t+w134+jYKHxiSFX55NbXMUxzbHPVkNaPevs6UqASEiilhNLSYBarLwDhyT2s+dPSAYajjWelKsIX4fk93xw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916117; c=relaxed/simple;
	bh=z26yfYCu3kp/j5A/U2X+7ncOUUOht3c+X7V95sFHN9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INsrjGOeDZacqhJypyZiPIJnV9K43MCJHdr7iMqBzsms22PIZPcW3sCGj5jm6kkB4aNiQYeijHdIqjlvUXxvJJLHJmDVH4jGOkDq02o7zRjVJ4v1Q/QnfZiIv/DzgbKYBjUxZyQwTz5wnxAaLfjcWi19C6CouA7SQYfmSCkKwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFryfq+T; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFryfq+T"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso5198749276.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725916115; x=1726520915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mRG66rhPVnmpItnv1q+3i9iRvEATt0kdC+QqEown6k=;
        b=QFryfq+ThxjYNsoqIkZ3ME4UEzgEkYYaZM4YJImqJ6SqSOhE+p3+1wDiyRAL4qyMz3
         kYVbxI8pluI23pC67G6wQARhQCVzMMueXXdNsjshtduHA9vLdmZDGxih/nqHVY7KIEqd
         ZcTr6+9GKyiXeu65DbANoPtAz/8TmVIT1KlSNtDU0CnbUn65vMaaKaoMpjxIub2ecmAo
         7WcNJBF9oyrHPt0nKlV9V5t0nXPrrVHcae4/nXlfsEJ3U9TzzjXSm6SLJU53Dq7cbukg
         SnYoJok0dDRGOQDfwO8Ro46BQjwmBRUSfpEA/iS3UoCGn9c+2LcRN+NbHiIGhw1lfFEd
         pT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725916115; x=1726520915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mRG66rhPVnmpItnv1q+3i9iRvEATt0kdC+QqEown6k=;
        b=c5kwee8DBIegdRWv20bUn6bJfDm/3HVZ+ys5JvOsTelrO48hqBqQNQU7PBfK/6DEsP
         jf/qasjluXL0wnEastasWXTTt1I3maV8nW1i+6TUNsGduDbSXsbY0nKosQR6wq6gpTRy
         +jb+5vGSPkcUYsbgyFxrPxwMXJhKuf06ZVFnth2Zr9C/pARwVBES0HcDHSR56WpVYQsx
         AzPsNzj8CKtPDtcxCjH1O/+3NALhY24hPeTGINn8M8mHT6sb5BaO1Yd34+fBYvNu1xFy
         iX98grikFqlVojd5kimsgUj0hop6iwShBgZUybxNiqu+anLVDrGgHm3kdGJJOflJM1KK
         0QgA==
X-Gm-Message-State: AOJu0YzmeyD+p57jtzSNvMih8eJu5lwy7syWrF8pgLDcCc45gERT9Rsx
	IgeamWsJnv+0Mf7X81CDaF6gkbLr0nHtV1jpG3HPPlxWaIC5MJCokoghKypBwNA5+PjPWhLp1KB
	SRUl0PFfs9a1hoD+A9rY9n4KWA5UzMJMF
X-Google-Smtp-Source: AGHT+IF3D1ki2bRdN7jmPG1pkWVROf9fpe+r2ebQFobdy4iOS60DmQ6kEfr3qwWi8QCt0pGrk7ZzoBYp7k1snPAU4Ok=
X-Received: by 2002:a05:6902:2102:b0:e1d:2b8d:7a0a with SMTP id
 3f1490d57ef6-e1d3486a429mr12983626276.3.1725916114665; Mon, 09 Sep 2024
 14:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <3301a34f76303c43feaf4eb9d6913fbeec439e97.1725555468.git.gitgitgadget@gmail.com>
 <ZtrdljxBJtnaUEla@pks.im>
In-Reply-To: <ZtrdljxBJtnaUEla@pks.im>
From: John Cai <johncai86@gmail.com>
Date: Mon, 9 Sep 2024 17:08:25 -0400
Message-ID: <CAOCgCUJWrOeYK1ugVVe3wdj23+KgBWtMD0XH0EZHc2rZgRGVtg@mail.gmail.com>
Subject: Re: [PATCH 1/3] builtin: add a repository parameter for builtin functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, Sep 6, 2024 at 6:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Thu, Sep 05, 2024 at 04:57:45PM +0000, John Cai via GitGitGadget wrote=
:
> > From: John Cai <johncai86@gmail.com>
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 40b61ef90d9..3b9bc93ed9a 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -358,7 +358,7 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
> >       return exit_status;
> >  }
> >
> > -int cmd_add(int argc, const char **argv, const char *prefix)
> > +int cmd_add(int argc, const char **argv, const char *prefix, struct re=
pository *repository UNUSED)
> >  {
> >       int exit_status =3D 0;
> >       struct pathspec pathspec;
>
> Nit: all of these are now overly long as we typically wrap at 80
> characters.
>
> > diff --git a/git.c b/git.c
> > index 9a618a2740f..0ea6e351dfd 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -31,7 +31,7 @@
> >
> >  struct cmd_struct {
> >       const char *cmd;
> > -     int (*fn)(int, const char **, const char *);
> > +     int (*fn)(int, const char **, const char *, struct repository *);
> >       unsigned int option;
> >  };
> >
> > @@ -441,7 +441,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
> >       return ret;
> >  }
> >
> > -static int run_builtin(struct cmd_struct *p, int argc, const char **ar=
gv)
> > +static int run_builtin(struct cmd_struct *p, int argc, const char **ar=
gv, struct repository *repo)
> >  {
> >       int status, help;
> >       struct stat st;
> > @@ -479,9 +479,11 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
> >       trace_argv_printf(argv, "trace: built-in: git");
> >       trace2_cmd_name(p->cmd);
> >
> > -     validate_cache_entries(the_repository->index);
> > -     status =3D p->fn(argc, argv, prefix);
> > -     validate_cache_entries(the_repository->index);
> > +     validate_cache_entries(repo->index);
> > +
> > +     status =3D p->fn(argc, argv, prefix, startup_info->have_repositor=
y? repo: NULL) ;
> > +
> > +     validate_cache_entries(repo->index);
> >
> >       if (status)
> >               return status;
>
> Looks sensible.
>
> > @@ -736,7 +738,7 @@ static void handle_builtin(int argc, const char **a=
rgv)
> >
> >       builtin =3D get_builtin(cmd);
> >       if (builtin)
> > -             exit(run_builtin(builtin, argc, argv));
> > +             exit(run_builtin(builtin, argc, argv, the_repository));
> >       strvec_clear(&args);
> >  }
> >
>
> Why don't we need a check for `startup_info->have_repository` here?

We do the check inside of run_builtin(), which calls the fn() directly.
There's a call to validate_cache_entries(repo->index) in run_builtin(), so
if we passed in NULL then we would need another guard to prevent a segfault
in run_builtin().

>
> > diff --git a/help.c b/help.c
> > index c03863f2265..e7cdfab6432 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -16,6 +16,7 @@
> >  #include "parse-options.h"
> >  #include "prompt.h"
> >  #include "fsmonitor-ipc.h"
> > +#include "repository.h"
> >
> >  #ifndef NO_CURL
> >  #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
>
> The include shouldn't be necessary. You can instead add a forward declara=
tion.

indeed, I'll remove this in the next version.

>
> > @@ -775,7 +776,7 @@ void get_version_info(struct strbuf *buf, int show_=
build_options)
> >       }
> >  }
> >
> > -int cmd_version(int argc, const char **argv, const char *prefix)
> > +int cmd_version(int argc, const char **argv, const char *prefix, struc=
t repository *repository UNUSED)
> >  {
> >       struct strbuf buf =3D STRBUF_INIT;
> >       int build_options =3D 0;
>
> Patrick
