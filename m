Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE450276
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434725; cv=none; b=LccEuQK+NF/2LN5bp9OnPeSDqGuL/tS77u5OrwKPehGZjwnWWWuLMkz8XHDzAijTWppIGKoAT4wFCjvwuKKn+a9D4fSbI+Asg6h1AWGxs2HAMgsUNnRQqL3VhttWnegrpTWay88R1ZyRfyq/JaLNc0U9nXJEvEXsIEEQR2hYr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434725; c=relaxed/simple;
	bh=hQWjHDlCWHt4zrfnqO+VhvHCUr8+HjOyiiuybd/cuB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPMUPcwU1RGo99dCUr+63sfwtjCeRoyyAQ72TZ+ndIMQBvOb7XECxeQTW9B55RerIKYU+PiaIkS5+8nOh1de3w5MShzcQKWNNzcOLUa18kyVOmDUjfZWWeiHW+8rtMvmSOV0nJsZs2c0VHXIg3fgYqsCMzCX7rD5pkNAEYcAuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGCTj9L5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGCTj9L5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso34417445ad.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734434723; x=1735039523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Mn2TIaF9LvRin66CNfnOZItYYjIrpmCS3Y+jXS5io4=;
        b=iGCTj9L5j0AE16DTv25veKasOSZUUB6mdWTmliIZt6KTGBQqfx9S2kp6MUikCjCIIZ
         CQ4iqkKrCxCvpj83NCncv/fHeJV7HTYZvnkmu8gC2qJqjON4A8aYOMueyPNhlZHd6qop
         0rN8L4eKX/rDWlz/wtV2mTxlDC/TEMZDxiAKmGIx8BkwJN86l5Tg71ir2oaFGGGq+91o
         dIlkU2VPDEHMm6iQVZPHp9bDI+LADZVjSYz8jIUODuoU8YHhD3/1T5IrUQOuV5o44szW
         W65/2qw3IXekJbF2YDxgENeSB0qIS0/NhoA9COp3fhbHnRWuQ71xpZdu+RkqPcX4lnQP
         Xzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434723; x=1735039523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Mn2TIaF9LvRin66CNfnOZItYYjIrpmCS3Y+jXS5io4=;
        b=bnS61djj6hCB+FLDDoInsxfe/80GVjhf2iwY7LV1OEYfcZwFp7dNc41EjQSTg/Tfc0
         YHHZNe4j4zDcVnNhYHSMGHuOB975O+gFFXkj0oyXmGrEtTAFssHNAHHPk5snviX5yiAu
         yUtYY/dxSTWFabmzCjL0mHnPD+BesMOt8wrhiV8TKsF3DIQzCRz1P93E3dM6ZMbc6/kY
         QGuSF/TX4F/ckB8F03BtnSfem+Dors7u6B1apP70+Js74psSujv3arX3qXi48ocyyNBB
         YEOeD3bNDRVNlbRbVURJ1MMNOBxDGYHlZFk/OrUxJ+uL+ti1/gLJ1ZJ4zdPe6qeV+t/8
         MpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7CjPlJpuMBi/JxGIXFFU650SsDVupZvSVxEbU/nin0l0cZTDvVv56fU+8/nWcQNG6zhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxIWfAdLm5zWwix9ClBNs5sHy5ENnbBHT8oc4r+zaHzAnH2rg
	AK4CWTdGXOLTcWZZfPu4rOKNj7IvLcRrCUoyjRvQZJnFg8DyCz0artaiPpl9a8Me8FydLE4L6YC
	vGP5RUw2pZ4UDK+fmWJXU+h5vzlA=
X-Gm-Gg: ASbGncuTUe/7lBibq02Tq0L7e2e2rRAsNRRIzH9oDbY/pnK/Rb900QTJrLUaqWFJ+ko
	kwSuVYwkDiJvXcfECHIrQr9/x6ygimtl8A+M=
X-Google-Smtp-Source: AGHT+IEIFSghiu/KADQHkxNoc+IWDC82QYKg3PsJ/2VnGVDe8K7TM6xByMaBvhXMOL3JIM0GISI6TQsjxYDgfSKPte8=
X-Received: by 2002:a17:90b:2803:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-2f2d7f81d9dmr3888657a91.28.1734434723329; Tue, 17 Dec 2024
 03:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
 <Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g> <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
In-Reply-To: <CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 17 Dec 2024 16:54:46 +0530
Message-ID: <CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 4:51=E2=80=AFPM Shubham Kanodia
<shubham.kanodia10@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 1:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > If we want to have such a feature I'd thus claim that it would be mos=
t
> > > sensible to make it opt-in rather than opt-out. I wouldn't want to be
> > > surprised by remote refs vanishing after going to bed, but may be oka=
y
> > > with it when I explicitly ask for it.
> > >
> > > At that point one has to raise the question whether it is still all t=
hat
> > > useful compared to running `git remote prune` manually every now and
> > > then. Mostly because explicitly configuring maintenance is probably
> > > something that only power users would do, and those power users would
> > > likely know to prune manually.
> >
> > I am 100% in agreement with your reasoning.  If this thing is to
> > exist, it has to be opt-in.  We also need to add ample warning why
> > doing this asynchronously behind user's back while the user could be
> > working in the same repository is prone to cause surprises in the
> > documentation in big red letters.
> >
> > I however am OK with the idea of having it as an optional "task"
> > that is disabled by default in "git maintenance".  "git maintenance"
> > can be viewed as a platform-neutral way to set up scheduled tasks.
> >
> > A user may be a Git expert who knows what `git remote prune` does,
> > and understands and accepts the risk of confusion doing so without
> > explicit "do it now" from the end-user, but may not be a Linux or a
> > macOS or a Windows expert to know how to write crontab or its
> > equivalents on various schemes to define scheduled tasks.
> >
> > Thanks.
>
> Thanks for sharing your thoughts here. For some context =E2=80=94 I curre=
ntly
> look after git performance for a very large repository (60k+ refs)
> with a lot of active developers.
> I've observed that while power git users keep their repository tidy
> even without runnining maintenance, the majority of users infact don't
> know (or execute these), and
> run into performance issues. Easier fleet management was perhaps was
> one of the motivations behind adding this to `git-maintenance`.
>
> While its pretty rare that someone relies on a `refs/remote/*`
> reference (without creating a local copy of it in `refs/heads`), I can
> see why it can be surprising and an opt-in
> should be okay for me.
>
> Thanks,
> Shubham K

From aed935055aff819cce591eecbf6697f8e8e7b99e Mon Sep 17 00:00:00 2001
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 17 Dec 2024 16:05:16 +0530
Subject: [PATCH] maintenance: add prune-remote-refs task

Remote-tracking refs can accumulate in local repositories even as branches
are deleted on remotes, impacting git performance. While git fetch --prune
helps clean these up, it requires a full fetch operation which is expensive
for large repositories.

Add a new maintenance task 'prune-remote-refs' that runs 'git remote prune'
for each configured remote. This provides an automated way to clean up stal=
e
remote-tracking refs without requiring full fetches or manual intervention.
This task is disabled by default.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
 Documentation/git-maintenance.txt | 14 ++++++++++
 builtin/gc.c                      | 42 +++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 44 +++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/Documentation/git-maintenance.txt
b/Documentation/git-maintenance.txt
index 6e6651309d..3e0ca84de2 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -158,6 +158,20 @@ pack-refs::
  need to iterate across many references. See linkgit:git-pack-refs[1]
  for more information.

+prune-remote-refs::
+ The `prune-remote-refs` task runs `git remote prune` on each remote
+ repository registered in the local repository. This task helps clean
+ up deleted remote branches, improving the performance of operations
+ that iterate through the refs. See linkgit:git-remote[1] for more
+ information. This task is disabled by default and must be enabled
+ manually.
++
+NOTE: This task is opt-in to prevent unexpected removal of remote refs
+for users of git-maintenance. It is recommended for power users who
+are comfortable with configuring maintenance tasks and understand the
+implications of automatic pruning. For others, running `git remote prune`
+manually might be more appropriate.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4ae5196aed..9acf1d2989 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "remote.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "commit.h"
@@ -913,6 +914,40 @@ static int maintenance_opt_schedule(const struct
option *opt, const char *arg,
  return 0;
 }

+static int collect_remote(struct remote *remote, void *cb_data)
+{
+ struct string_list *list =3D cb_data;
+
+ if (!remote->url.nr)
+ return 0;
+
+ string_list_append(list, remote->name);
+ return 0;
+}
+
+static int maintenance_task_prune_remote(struct maintenance_run_opts
*opts UNUSED,
+ struct gc_config *cfg UNUSED)
+{
+ struct string_list_item *item;
+ struct string_list remotes_list =3D STRING_LIST_INIT_NODUP;
+ struct child_process child =3D CHILD_PROCESS_INIT;
+ int result =3D 0;
+
+ for_each_remote(collect_remote, &remotes_list);
+
+ for_each_string_list_item (item, &remotes_list) {
+ const char *remote_name =3D item->string;
+ child.git_cmd =3D 1;
+ strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
+
+ if (run_command(&child))
+ result =3D error(_("failed to prune '%s'"), remote_name);
+ }
+
+ string_list_clear(&remotes_list, 0);
+ return result;
+}
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN (1u<<0)

@@ -1375,6 +1410,7 @@ enum maintenance_task_label {
  TASK_GC,
  TASK_COMMIT_GRAPH,
  TASK_PACK_REFS,
+ TASK_PRUNE_REMOTE_REFS,

  /* Leave as final value */
  TASK__COUNT
@@ -1411,6 +1447,10 @@ static struct maintenance_task tasks[] =3D {
  maintenance_task_pack_refs,
  pack_refs_condition,
  },
+ [TASK_PRUNE_REMOTE_REFS] =3D {
+ "prune-remote-refs",
+ maintenance_task_prune_remote,
+ },
 };

 static int compare_tasks_by_selection(const void *a_, const void *b_)
@@ -1505,6 +1545,8 @@ static void initialize_maintenance_strategy(void)
  tasks[TASK_LOOSE_OBJECTS].schedule =3D SCHEDULE_DAILY;
  tasks[TASK_PACK_REFS].enabled =3D 1;
  tasks[TASK_PACK_REFS].schedule =3D SCHEDULE_WEEKLY;
+ tasks[TASK_PRUNE_REMOTE_REFS].enabled =3D 0;
+ tasks[TASK_PRUNE_REMOTE_REFS].schedule =3D SCHEDULE_DAILY;
  }
 }

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0ce4ba1cbe..60a0c3f835 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -446,6 +446,50 @@ test_expect_success 'pack-refs task' '
  test_subcommand git pack-refs --all --prune <pack-refs.txt
 '

+test_expect_success 'prune-remote-refs task not enabled by default' '
+ git clone . prune-test &&
+ (
+ cd prune-test &&
+ GIT_TRACE2_EVENT=3D"$(pwd)/prune.txt" git maintenance run 2>err &&
+ test_subcommand ! git remote prune origin <prune.txt
+ )
+'
+
+test_expect_success 'prune-remote-refs task cleans stale remote refs' '
+ test_commit initial &&
+
+ # Create two separate remote repos
+ git clone . remote1 &&
+ git clone . remote2 &&
+
+ git clone . prune-test-clean &&
+ (
+ cd prune-test-clean &&
+ git config maintenance.prune-remote-refs.enabled true &&
+
+ # Add both remotes
+ git remote add remote1 "../remote1" &&
+ git remote add remote2 "../remote2" &&
+
+ # Create and push branches to both remotes
+ git branch -f side2 HEAD &&
+ git push remote1 side2 &&
+ git push remote2 side2 &&
+
+ # Rename branches in each remote to simulate a stale branch
+ git -C ../remote1 branch -m side2 side3 &&
+ git -C ../remote2 branch -m side2 side4 &&
+
+ GIT_TRACE2_EVENT=3D"$(pwd)/prune.txt" git maintenance run
--task=3Dprune-remote-refs &&
+
+ # Verify pruning happened for both remotes
+ test_subcommand git remote prune remote1 <prune.txt &&
+ test_subcommand git remote prune remote2 <prune.txt &&
+ test_must_fail git rev-parse refs/remotes/remote1/side2 &&
+ test_must_fail git rev-parse refs/remotes/remote2/side2
+ )
+'
+
 test_expect_success '--auto and --schedule incompatible' '
  test_must_fail git maintenance run --auto --schedule=3Ddaily 2>err &&
  test_grep "at most one" err
--=20
2.46.2
