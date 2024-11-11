Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C914AD3F
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348385; cv=none; b=cyvd/fJCRaZfmgJc4NFcuox+74LaVGyOKopCjall4hyhGbyfr7igTJWJDPSLjAMeETTdg3dkG7hkfU3Wrq2tXkDTTwFgMEo68bguZu8tYVIWdjRmNuy/iQ71uOgs5fqO4L6hRk4tKWdXhbmhHAUcdsvjd2KBSa2Ts9645PPZ+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348385; c=relaxed/simple;
	bh=T8d0oKp57apl00ZlKwPpiESLxUxl5nz/nSvgv5fEjyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6EOxF5Nc6NzhL9mMI2bHG77F5hR/6MyzaiA2jfXMTgAG3+8Jb/FfliSbJ5JveQNG5K12TZLbKqcp/+T1zEkDKe2bPm7GmUjLw/e8XgSQICynHoi/Wyzp/bUVniMk9JHbDc801r4b5FHcQBEn0JfWy1PAvr2geGY1mz8zO2Ql94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJuGeMY0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJuGeMY0"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e681ba70so772e87.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731348382; x=1731953182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj9QZXxSQtJ+ZeixV1Uveb1eNVCouLqL+q3OrmU4TCo=;
        b=EJuGeMY0NYDpkYrMzchJVrko7v7vmPg8uNdHma8c8GjTbaKZjhsuxbcILq6WPNwuEt
         q0mXYvICKdZnHwfSqrU3+3oJmq5tHMwuPqmNe0wQkG1YOT6HvFC/R6RcwSsaaquwU52S
         g3tr+vXIoZAEpH3iS0ozDCT+WjnK+EXdeaCFGTJvIX3EbiW/+D6vymEiZFRnFX6lm4GC
         o608IFLR/qIV/xnNmRLmJsbPKBeexQV+gCi42169QOqUeSiJ0Kjc3vovuUaeKshxgs/0
         gnS1r8Qqyy1XlxSxIe7jmERbaRKWEzs7Mmo9LRYkFNvLDzYO06bOLvFzR9MyrTDbx+Ac
         tpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348382; x=1731953182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj9QZXxSQtJ+ZeixV1Uveb1eNVCouLqL+q3OrmU4TCo=;
        b=kpVe7VDW03WPObJx49burRbSt3ZVe5siCEcL4AJ+FLJV3rIg5WYXsE3chQGjwKIi6x
         MgRZle448qRrn99ZvFA5oWvP5zgve9MP1SS6Jo18vwtzjlIEFqyr6YtTsfY251pgze4k
         2bFH1/vBDNXSsNsYUGKJObTKTuXAiyFx8vUeZ5440RpGSoPZcep+732JDG7WFiGtU9mx
         scFf5t78N7uNgXozuqZWdU5I4eLLJhGIzajRW+skKYyHJQ0peps5jZUPIcMJwZ1/13GF
         ZBjDEJpZC/W1pYiNA38oCPqAyI7mkBQFVAlKz2Zt+pfD5StnXoEFnBi478vLR9DMdi3U
         MxzQ==
X-Gm-Message-State: AOJu0Yy1Z0xhQ77q6pu/lrCmiYrMaDkJFt1+w2vVAvDNhma6YxXW4ef6
	lFa7Y56sM0qRHnRpn5ycOKSfJvTMGV9zZ4C1+Pz2BCNuTcDowvlwQQjAMVDXvp1XsKfwhOOaDbw
	93O0NFaGT0UJsUqho2ZiLq3b2uAaD2Bl7V/6w
X-Gm-Gg: ASbGncudFG3fhryY20ED48K+gH1SKkIYwacVBk7Vdm59mN+IA1hLJZTS+lCoJW9e2W0
	FojwrQOM7QgB4zQcc7BYb2MM9xU6Vkjdv/743biE6dx7E73/1iAeE6X7YO4U=
X-Google-Smtp-Source: AGHT+IG8kSSgSHwFM+PmxynJs+fID+IHe4Q+eMqg/t1Sb2KO51mo1MQhVeH5V1bEtghkLO5ycsAXf7jCnu2oFQQJIPs=
X-Received: by 2002:a05:6512:473:b0:535:3d14:1313 with SMTP id
 2adb3069b0e04-53d8bcf3b9emr513799e87.0.1731348381636; Mon, 11 Nov 2024
 10:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com> <ZzGtD4Jz9Wj6n0zH@pks.im>
In-Reply-To: <ZzGtD4Jz9Wj6n0zH@pks.im>
From: Calvin Wan <calvinwan@google.com>
Date: Mon, 11 Nov 2024 10:06:10 -0800
Message-ID: <CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and unsafe tasks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, steamdon@google.com, emrass@google.com, 
	me@ttaylorr.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 11:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Fri, Nov 08, 2024 at 05:31:12PM +0000, Calvin Wan wrote:
> > Certain maintenance tasks and subtasks within gc are unsafe to run in
> > parallel with other commands because they lock up files such as
> > HEAD.
>
> I don't think it is fair to classify this as "unsafe". Nothing is unsafe
> here: we take locks to guard us against concurrent modifications.
> What you're having problems with is the fact that this safety mechanism
> works as expected and keeps other processes from modifying locked the
> data.
>
> > Therefore, tasks are marked whether they are async safe or
> > not. Async unsafe tasks are run first in the same process before runnin=
g
> > async safe tasks in parallel.
> >
> > Since the gc task is partially safe, there are two new tasks -- an asyn=
c
> > safe gc task and an async unsafe gc task. In order to properly invoke
> > this in gc, `--run-async-safe` and `--run-async-unsafe` have been added
> > as options to gc. Maintenance will only run these two new tasks if it
> > was set to detach, otherwise the original gc task runs.
> >
> > Additionally, if a user passes in tasks thru `--task`, we do not attemp=
t
> > to run separate async/sync tasks since the user sets the order of tasks=
.
> >
> > WIP: automatically run gc unsafe tasks when gc is invoked but not from
> >      maintenance
> > WIP: edit test in t7900-maintainance.sh to match new functionality
> > WIP: add additional documentation for new options and functionality
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > ---
> >  builtin/gc.c           | 173 ++++++++++++++++++++++++++++++++++++-----
> >  t/t7900-maintenance.sh |  24 +++---
> >  2 files changed, 168 insertions(+), 29 deletions(-)
> >
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index d52735354c..375d304c42 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
>
> It might make sense to split out the git-gc(1) changes into a
> preparatory commit with its own set of tests.
>
> > @@ -815,7 +824,12 @@ struct repository *repo UNUSED)
> >               atexit(process_log_file_at_exit);
> >       }
> >
> > -     gc_before_repack(&opts, &cfg);
> > +     if (run_async_unsafe) {
> > +             gc_before_repack(&opts, &cfg);
> > +             goto out;
> > +     } else if (!run_async_safe)
> > +             gc_before_repack(&opts, &cfg);
> > +
> >
>
> Style: there should be curly braces around the `else if` here.
>
> >       if (!repository_format_precious_objects) {
> >               struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
> > @@ -1052,6 +1066,46 @@ static int maintenance_task_prefetch(struct main=
tenance_run_opts *opts,
> >       return 0;
> >  }
> >
> > +static int maintenance_task_unsafe_gc(struct maintenance_run_opts *opt=
s,
> > +                                   struct gc_config *cfg UNUSED)
> > +{
> > +     struct child_process child =3D CHILD_PROCESS_INIT;
> > +
> > +     child.git_cmd =3D child.close_object_store =3D 1;
> > +     strvec_push(&child.args, "gc");
> > +
> > +     if (opts->auto_flag)
> > +             strvec_push(&child.args, "--auto");
> > +     if (opts->quiet)
> > +             strvec_push(&child.args, "--quiet");
> > +     else
> > +             strvec_push(&child.args, "--no-quiet");
> > +     strvec_push(&child.args, "--no-detach");
> > +     strvec_push(&child.args, "--run-async-unsafe");
> > +
> > +     return run_command(&child);
> > +}
> > +
> > +static int maintenance_task_safe_gc(struct maintenance_run_opts *opts,
> > +                                 struct gc_config *cfg UNUSED)
> > +{
> > +     struct child_process child =3D CHILD_PROCESS_INIT;
> > +
> > +     child.git_cmd =3D child.close_object_store =3D 1;
> > +     strvec_push(&child.args, "gc");
> > +
> > +     if (opts->auto_flag)
> > +             strvec_push(&child.args, "--auto");
> > +     if (opts->quiet)
> > +             strvec_push(&child.args, "--quiet");
> > +     else
> > +             strvec_push(&child.args, "--no-quiet");
> > +     strvec_push(&child.args, "--no-detach");
> > +     strvec_push(&child.args, "--run-async-safe");
> > +
> > +     return run_command(&child);
> > +}
>
> These two functions and `maintenance_task_gc()` all look exactly the
> same. We should deduplicate them.
>
> >  static int maintenance_task_gc(struct maintenance_run_opts *opts,
> >                              struct gc_config *cfg UNUSED)
> >  {
> > @@ -1350,6 +1404,7 @@ struct maintenance_task {
> >       const char *name;
> >       maintenance_task_fn *fn;
> >       maintenance_auto_fn *auto_condition;
> > +     unsigned daemonize_safe;
>
> We can use the enum here to give readers a better hint what this
> variable is about.
>
> >       unsigned enabled:1;
> >
> >       enum schedule_priority schedule;
> > @@ -1362,6 +1417,8 @@ enum maintenance_task_label {
> >       TASK_PREFETCH,
> >       TASK_LOOSE_OBJECTS,
> >       TASK_INCREMENTAL_REPACK,
> > +     TASK_UNSAFE_GC,
> > +     TASK_SAFE_GC,
> >       TASK_GC,
> >       TASK_COMMIT_GRAPH,
> >       TASK_PACK_REFS,
> > @@ -1370,36 +1427,62 @@ enum maintenance_task_label {
> >       TASK__COUNT
> >  };
> >
> > +enum maintenance_task_daemonize_safe {
> > +     UNSAFE,
> > +     SAFE,
> > +};
>
> These names can conflict quite fast. Do we maybe want to rename them to
> e.g. `MAINTENANCE_TASK_DAEMONIZE_(SAFE|UNSAFE)`?
>
> >  static struct maintenance_task tasks[] =3D {
> >       [TASK_PREFETCH] =3D {
> >               "prefetch",
> >               maintenance_task_prefetch,
> > +             NULL,
> > +             SAFE,
> >       },
>
> It might make sense to prepare these to take designated field
> initializers in a preparatory commit.

Thanks for all the stylistic feedback. I agree much of this can be
cleaned up to be simpler, but I sent this as an RFC to gather feedback
on whether this patch directionally made sense. Will clean everything
up in the v1.

>
> >       [TASK_LOOSE_OBJECTS] =3D {
> >               "loose-objects",
> >               maintenance_task_loose_objects,
> >               loose_object_auto_condition,
> > +             SAFE,
> >       },
> >       [TASK_INCREMENTAL_REPACK] =3D {
> >               "incremental-repack",
> >               maintenance_task_incremental_repack,
> >               incremental_repack_auto_condition,
> > +             SAFE,
> > +     },
> > +     [TASK_UNSAFE_GC] =3D {
> > +             "unsafe-gc",
> > +             maintenance_task_unsafe_gc,
> > +             need_to_gc,
> > +             UNSAFE,
> > +             0,
> > +     },
> > +     [TASK_SAFE_GC] =3D {
> > +             "safe-gc",
> > +             maintenance_task_safe_gc,
> > +             need_to_gc,
> > +             SAFE,
> > +             0,
> >       },
>
> Hm. I wonder whether we really want to expose additional tasks to
> address the issue, which feels like we're leaking implementation details
> to our users. Would it maybe be preferable to instead introduce a new
> optional callback function for every task that handles the pre-detach
> logic?

This does sound like a good idea. However, would there be any issue
with running all pre-detach logic before running post-detach logic?
I'm thinking if pre-detach logic from a different function could
affect post-detach logic from another. If not, I do agree this would
be the best solution going forward.

> I wonder whether we also have to adapt the "pack-refs" task to be
> synchronous instead of asynchronous?
