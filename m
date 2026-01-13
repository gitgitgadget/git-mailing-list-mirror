Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4232B98F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327631; cv=none; b=pp4fAlCz/PU5wA+RMZdvJo6MTHgL3gH9qMRQ57I4BC/Du8UUdhAsMqjILr4AW65KON7ZBAYFbw30qEb2uB6boWXvOL0KYZsjgn5Px7Xrf/Rnet5tB6NfgGwV+YjOE/kZ9jTBpQwlVnyE+u1EShtky8sdajI1nbroYMLh6+VsEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327631; c=relaxed/simple;
	bh=m6djnerB82wp2AIGsHOTwxyaU0o/Ps8JdtXSS8htEEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9cQFVSJ/eg1yOEfzzYNsrdkwVIYx1Cudi5Qj1zqkOHQ3VimWlU6dzXERcL5DPI1tDqA+NuOYuoE+CiAHpAshNJLzjWXt5JppBuKA0hslpzEMyLKWG/E5gVbNcLqKI32u6XX7tM9LRUSXtvx5C24ltBorDVIXwazsBqDbjw64g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd3jGmli; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd3jGmli"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5636b2fde95so1089971e0c.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768327629; x=1768932429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S3rbEg1xp9kZMNxxNW2A9wC6fDpfeOW7Tun7s0zieY=;
        b=Fd3jGmliHRH7RKZOszRscagZB38LLQtR9poVcffRhjzofs7c5zxki3Lxp0ulnodxI0
         KJbGRnLCnwF4oy6E9oY/LllDCAlFDV4qEocpFQpTlKg4lb1BEvPd1V4idbL0Q5b3cYze
         8Wfb3Hhf7NCwzTIuCb6OnMDs692MCyoDNPyEKE91UAXIKwnpbOFgQIRfT1zirdGqA2eZ
         cmes5HnfBg4PEm1vbpeRrOfDZqf39pOm052rauDQ75aaB4XI/EYoVRoEbmmcOMI3k8db
         vKWoL5TOD5ZFVBulaPjwaodc2urfQ9E08McljR+CLVmB5NNuGbPxJCkIsbxmwMjAGmQ3
         yDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327629; x=1768932429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/S3rbEg1xp9kZMNxxNW2A9wC6fDpfeOW7Tun7s0zieY=;
        b=WCZlHlydC3++0YYY8ojaJQ0d3vuF7txHBBfetu5+z8vxifGNopmKSkRjS50+vYrnm7
         1rfc8hj8ncitXKKv7vVluqsYX+spwJW3la8lXjDU0jdOONiq7Drvt33hjxi+Vgiujxkc
         xGyMpcnT61eTLDf1IVQQZVFEaCTGOB49fZZPfAq/cxrC3k1DBPE9usDY43vF9Aql8J/e
         PQmlLZr05FUSuihweLpKxyJ2HQTeMXv1WHFthku5IZ1SvHy9sOy5GA2XdGALuWO48b4x
         aG9r6KDjkOnYCZ96hB8fJokcrXh+9GBsRLxve+vH7eWPVQU0QKw5INb1IdUTsVzxGp6i
         x4hA==
X-Gm-Message-State: AOJu0YxVp2uwjfpamCGyFt9ILq1hZ+2YQrUrb/FCf5xzrsld/TAEY+v0
	QFrJqf+kWrPsb+i7OkDvG4qTZrlsgAy49VmZe8rYNQPdM4HOIuxW+7uGU5iBmUqf2WEIaEyFKiC
	Cb7ACxddlDCCPN7MkDUzRzheqPRVdTSTWCRML
X-Gm-Gg: AY/fxX65jtqnfa0L+D/Pb3GVRGgCNjwFlK5nDgVT+Yi0gOdbMC+bnqhO7oWY7XbD0ox
	JprTtIMNwR4Zb9HMJ1aIQ9bcYmUSu4cFyTxVxl4NGD3OT9r6U2fZcUfzCXeYCqNY3az2QFU2hFb
	Cr0DkJMc99yXD4FTgMsmrhDIVePXb9UcxyibiWazlWxYhd4+Nt87/Uj4pATLwNk6bCT6BxLCYK8
	w3gIUZnsZ1rgCEQjcs4bRPsRbAqeROfnnYA9pkFtUeC/pOSQeNKTcN4Cl3n31Gm3lPVhs2X+f2C
X-Received: by 2002:a05:6122:1da2:b0:55b:8f06:75c with SMTP id
 71dfb90a1353d-563a09e9d9amr53924e0c.10.1768327628797; Tue, 13 Jan 2026
 10:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local> <xmqq7btljvt2.fsf@gitster.g>
In-Reply-To: <xmqq7btljvt2.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 13 Jan 2026 19:07:06 +0100
X-Gm-Features: AZwV_QiXAoTlFjWZ1ulsVjSpWW7MqIznwamIz1FgYqivR-H_q3jZ7mD5wBW3vrw
Message-ID: <CADYq+faUHdCJ-CEnG5vGxkytW1O36pODd2SwXsUW+nbhE+RCnA@mail.gmail.com>
Subject: Re: [GSoC PATCH v1] builtin: stop using the_repository
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > The builtins use the_repository global variable which might
> > not work well when running many repos in the same process at once.
>
> This is true, but ...
>
> > Stop using the_repository in these builtins to align with the goal of
> > libification of Git.
>
> ... in general, each file under builtin/ is about a single command
> that _uses_ libified part of Git.  So it is perfectly fine for the
> libification goal to include "libified functions should not assume
> that it works on the_repository, but they should accept a repo
> parameter to tell them which repository to work with".  But it is
> not necessary, and I would say it is harmful, to subject builtin/*.c
> to the same criteria.  The builtin command implementations can call
> libified function by passing the_repository to libified API function
> that expects a repo parameter.

Oh thank you Junio for clarifying

>
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> >  builtin/bugreport.c    | 13 ++++++-------
> >  builtin/bundle.c       | 13 ++++++-------
> >  builtin/check-attr.c   | 26 +++++++++++++-------------
> >  builtin/check-ignore.c | 27 +++++++++++++++------------
> >  4 files changed, 40 insertions(+), 39 deletions(-)
> >
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index f78c3f2aed..77eb8bd9c1 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -1,4 +1,3 @@
> > -#define USE_THE_REPOSITORY_VARIABLE
> >  #include "builtin.h"
> >  #include "abspath.h"
> >  #include "editor.h"
> > @@ -37,7 +36,7 @@ static void get_system_info(struct strbuf *sys_info)
> >                   shell ? shell : "<unset>");
> >  }
> >
> > -static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> > +static void get_populated_hooks(struct repository *repo, struct strbuf=
 *hook_info, int nongit)
> >  {
> >       const char **p;
> >
> > @@ -50,7 +49,7 @@ static void get_populated_hooks(struct strbuf *hook_i=
nfo, int nongit)
> >       for (p =3D hook_name_list; *p; p++) {
> >               const char *hook =3D *p;
> >
> > -             if (hook_exists(the_repository, hook))
> > +             if (hook_exists(repo, hook))
> >                       strbuf_addf(hook_info, "%s\n", hook);
> >       }
> >  }
>
> It is not strictly necessary to churn a file-scope static function
> like this one into taking an arbitrary repo parameter, as the only
> caller of the function, presumably cmd_foo() in the builtin/foo.c
> file, would pass the_repository anyway, whether it explicitly names
> the_repository or passes the repo parameter that it got from its
> caller, git.c:run_builtin().  We _can_ consider a change like the
> above as a preparation to potentially move these functions to the
> libified part of Git, so even though I said it is not necessary, it
> is also OK to perform such a change.

Okay thank you

>
> > @@ -93,7 +92,7 @@ static void get_header(struct strbuf *buf, const char=
 *title)
> >  int cmd_bugreport(int argc,
> >                 const char **argv,
> >                 const char *prefix,
> > -               struct repository *repo UNUSED)
> > +               struct repository *repo)
> >  {
> >       struct strbuf buffer =3D STRBUF_INIT;
> >       struct strbuf report_path =3D STRBUF_INIT;
> > @@ -141,7 +140,7 @@ int cmd_bugreport(int argc,
> >       }
> >       strbuf_addstr(&report_path, ".txt");
> >
> > -     switch (safe_create_leading_directories(the_repository, report_pa=
th.buf)) {
> > +     switch (safe_create_leading_directories(repo, report_path.buf)) {
> >       case SCLD_OK:
> >       case SCLD_EXISTS:
> >               break;
> > @@ -158,7 +157,7 @@ int cmd_bugreport(int argc,
> >               strbuf_addftime(&zip_path, option_suffix, localtime_r(&no=
w, &tm), 0, 0);
> >               strbuf_addstr(&zip_path, ".zip");
> >
> > -             if (create_diagnostics_archive(the_repository, &zip_path,=
 diagnose))
> > +             if (create_diagnostics_archive(repo, &zip_path, diagnose)=
)
> >                       die_errno(_("unable to create diagnostics archive=
 %s"), zip_path.buf);
> >
> >               strbuf_release(&zip_path);
> > @@ -171,7 +170,7 @@ int cmd_bugreport(int argc,
> >       get_system_info(&buffer);
> >
> >       get_header(&buffer, _("Enabled Hooks"));
> > -     get_populated_hooks(&buffer, !startup_info->have_repository);
> > +     get_populated_hooks(repo, &buffer, !startup_info->have_repository=
);
> >
> >       /* fopen doesn't offer us an O_EXCL alternative, except with glib=
c. */
> >       report =3D xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 06=
66);
>
> All of the above look fine.
>
> > diff --git a/builtin/bundle.c b/builtin/bundle.c
> > index 1e170e9278..ef21ccfd89 100644
> > --- a/builtin/bundle.c
> > +++ b/builtin/bundle.c
>
> Is this patch meant as a microproject in preparation for applying
> for GSoC?  If so, we ask to limit one quality focused one per
> applicant.
>
> https://git.github.io/General-Microproject-Information/#only-one-quality-=
focused-microproject-per-applicant

No, this patch is not meant as a microproject.
I previously read in the General-Microproject-Information section
"After it's done, work on different things"
that we can keep contributing after a micoproject if we are itching to do m=
ore.
So I just want to keep contributing.

Do I drop the "GSoC" tag and send a v2?
I will not include the tag in subsequent patches.
Thanks

Abraham.
