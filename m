Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719F1F1534
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007859; cv=none; b=HLVp/CS+hYLLj06czsFpB8agrggqvD2dHehG8+UhKAgO3ksbIdBzDMU5S7gvnM0xg2uQMqckfBUbWnMVtguio8I/b05KKPKjzdqh0c+I8S1ItxjaM8ghG99lVnMQTbjMUTFZyQ9nuf5xC4Yu/L2zQryXmVZefnNCw+1uocaPjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007859; c=relaxed/simple;
	bh=57zdvZBHSb1H1EBL8voMwbbK5u8cfFE/IXpzhEEotuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgMsnpUth3F+xdnOrCKLIbRfwSoWcjiSC5GgpQ0iGLmK8/S8LV0NHjdMrlzwBG+8vQ/lrUXa6hcERTrY6C2VK/XCIVsTvS1TsK5kWcf+DbYVAyTPWA9B4HOht6uK7ki/8/oET0PWiybHiPY1pg8M0f443DIpLZJBdRO/ZwNY3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JovBzJA1; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JovBzJA1"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65b6b69baf8so1666673eaf.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768007857; x=1768612657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89zXmuFLsdO5Nhc0MGAEqMZpffvbGKDPgiwbW3/T+W4=;
        b=JovBzJA1TcHYNlZg9yC/fPXtJlH/LW7HLGSNI+8qzHxUzsMqcscORbL2wDMAmMXsg4
         2H9WPUHkWfhuqYSrlPbgtAq8raNisngQaFw+OxygzP4Y5B82udP1jTAxJJcSVwP7VZ4Z
         fsO5VJeXfL8exDqkYEEdPiSlXI1A/DLHNappUSfd19c2TJB5lU8cdl9Cij/7sFQeqLdJ
         IyX6UdOQPhvT8xcFQQNZlbHM+eqSGRX4alt2805y87ciGHsqT8uZ2amyJlmrVs9bA+Lx
         Jd6CQ66EJl7MAwWhfWeDektZUVf6AknXyGsPU29qhtvtF9dp0poULit6+/I/y7NPQhMf
         yNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768007857; x=1768612657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=89zXmuFLsdO5Nhc0MGAEqMZpffvbGKDPgiwbW3/T+W4=;
        b=CIn4u3Rxx+iYM5F4g2ICKcoxOpPVRn6zreDmHRiXuoDvojwIgwsruZ8c39/DsnVlU6
         Qo1HnasJOD4S2di1j4bjUuc4wHOaXzKsQiktTxhqP2tn5KdBraEvAA3iRQASsfguug6U
         72uj70EVPA+Qg03NzA1fyGYIpbvEzo8LIN+1vwcHadB9n5m2szSz3C+D9UrXCgPDqm7F
         hcjXT/iLopjQcfqKC63UHNu2i2SqPYWNUt8sZAnrE4X7h2NWxxhyMMGfnIm6PJPA/oyQ
         t57PQRlt3O9EKi8kJ32IgqbElLlDGtU/v1SYWdCSC7xEQYXwSg8SgNyUlA4b696IUELZ
         GleA==
X-Gm-Message-State: AOJu0YwFskndILEBhsDpA1tBhquNpB1xyZYsWLPsUSDiPBzHqXFhI3ZW
	BnjDSMq2PhffU1nbSAYumz1q0/DXuJ5Mj5+XqDFoChORQmAT+Oa+U3HtGrUJ5neeLcjT5B0SD/h
	6BPzQXpA0Rd7h8B+BQ3wUi/edQZfRndU=
X-Gm-Gg: AY/fxX7tnJA84KqszUrKMo4JfehuKSUGVzV68yYHXoT3nCJaLj4DDXT7ZDVmz1rcO3i
	YLXmLDfOLux8/7WtUYsj4/UYNGtzCT4jogiBPjHkK5PS+sDV34UNCRVpfgE+W4ZESHjifp8gvyZ
	Vj2MTN5MAwF//QFd5RkKr0np2xoh3+idl+fBgqGuvWvbCizu6H0PoKyIzZJNGKjjfRBYJcBYVxA
	H12K3xPrZJFYz3oz3lGK2cNowyZD8QTDP637xHPinJ37pqg8lxiPAwBRiGdjVWyyJS2ASkv9p5R
	Ote4yzIqlG2H45L82awsJ9H5fxw=
X-Google-Smtp-Source: AGHT+IENVl3reWx4pZEFgiBpBp8gAVU8/ATSG9kua80jjMUy861FjUuP0x1Aie+5MaIBXUEDc2UQDtjPRff1EVsFUqQ=
X-Received: by 2002:a05:6820:f064:b0:65f:5a60:3d3b with SMTP id
 006d021491bc7-65f5a605135mr4352777eaf.62.1768007856960; Fri, 09 Jan 2026
 17:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im> <20260109-b4-pks-history-builtin-v9-6-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-6-8766101814c6@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 Jan 2026 17:17:25 -0800
X-Gm-Features: AQt7F2pH96Vc3Bh8jD2glonFXBzjX5lnAYbnNYLiV7zPqUT8zJvh0uKmPT1iN0Q
Message-ID: <CABPp-BF3jat7zStaydVa=fGHd7b=k6_KgDHt41XkOz+fMF+gbQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] builtin: add new "history" command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When rewriting history via git-rebase(1) there are a few very common use
> cases:
>
>   - The ordering of two commits should be reversed.
>
>   - A commit should be split up into two commits.
>
>   - A commit should be dropped from the history completely.
>
>   - Multiple commits should be squashed into one.
>
>   - Editing an existing commit that is not the tip of the current
>     branch.
>
> While these operations are all doable, it often feels needlessly kludgey
> to do so by doing an interactive rebase, using the editor to say what
> one wants, and then perform the actions. Also, some operations like
> splitting up a commit into two are way more involved than that and
> require a whole series of commands.
>
> Rebases also do not update dependent branches. The use of stacked
> branches has grown quite common with competing version control systems
> like Jujutsu though, so it clearly is a need that users have. While
> rebases _can_ serve this use case if one always works on the latest
> stacked branch, it is somewhat awkward and very easy to get wrong.
>
> Add a new "history" command to plug these gaps. This command will have
> several different subcommands to imperatively rewrite history for common
> use cases like the above.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitignore                     |  1 +
>  Documentation/git-history.adoc | 56 ++++++++++++++++++++++++++++++++++++=
++++++
>  Documentation/meson.build      |  1 +
>  Makefile                       |  1 +
>  builtin.h                      |  1 +
>  builtin/history.c              | 22 +++++++++++++++++
>  command-list.txt               |  1 +
>  git.c                          |  1 +
>  meson.build                    |  1 +
>  t/meson.build                  |  1 +
>  t/t3450-history.sh             | 17 +++++++++++++
>  11 files changed, 103 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 78a45cb5be..24635cf2d6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -79,6 +79,7 @@
>  /git-grep
>  /git-hash-object
>  /git-help
> +/git-history
>  /git-hook
>  /git-http-backend
>  /git-http-fetch
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> new file mode 100644
> index 0000000000..5a9d931efc
> --- /dev/null
> +++ b/Documentation/git-history.adoc
> @@ -0,0 +1,56 @@
> +git-history(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-history - EXPERIMENTAL: Rewrite history
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git history [<options>]
> +
> +DESCRIPTION
> +-----------
> +
> +Rewrite history by rearranging or modifying specific commits in the
> +history.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +This command is related to linkgit:git-rebase[1] in that both commands c=
an be
> +used to rewrite history. There are a couple of major differences though:
> +
> +* linkgit:git-history[1] can work in a bare repository as it does not ne=
ed to
> +  touch either the index or the worktree.
> +* linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
> +  current point in time. This may change in the future.
> +* linkgit:git-history[1] by default updates all branches that are descen=
dants
> +  of the original commit to point to the rewritten commit.
> +
> +Overall, linkgit:git-history[1] aims to provide a more opinionated way t=
o modify
> +your commit history that is simpler to use compared to linkgit:git-rebas=
e[1] in
> +general.
> +
> +If you want to reapply a range of commits onto a different base, or inte=
ractive
> +rebases if you want to edit a range of commits.

"If ..." with no "then ..." ?  This sentence isn't complete.

> +LIMITATIONS
> +-----------
> +
> +This command does not (yet) work with histories that contain merges. You
> +should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead=
.
> +
> +Furthermore, the command does not support operations that can result in =
merge
> +conflicts. This limitation is by design as history rewrites are not inte=
nded to
> +be stateful operations. The limitation can be lifted once (if) Git learn=
s about
> +first-class conflicts.
> +
> +COMMANDS
> +--------
> +
> +Several commands are available to rewrite history in different ways:

Um, what are they?

> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index f02dbc20cb..fd2e8cc02d 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -64,6 +64,7 @@ manpages =3D {
>    'git-gui.adoc' : 1,
>    'git-hash-object.adoc' : 1,
>    'git-help.adoc' : 1,
> +  'git-history.adoc' : 1,
>    'git-hook.adoc' : 1,
>    'git-http-backend.adoc' : 1,
>    'git-http-fetch.adoc' : 1,
> diff --git a/Makefile b/Makefile
> index 1c64a5d2ae..c0569ed8e4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1418,6 +1418,7 @@ BUILTIN_OBJS +=3D builtin/get-tar-commit-id.o
>  BUILTIN_OBJS +=3D builtin/grep.o
>  BUILTIN_OBJS +=3D builtin/hash-object.o
>  BUILTIN_OBJS +=3D builtin/help.o
> +BUILTIN_OBJS +=3D builtin/history.o
>  BUILTIN_OBJS +=3D builtin/hook.o
>  BUILTIN_OBJS +=3D builtin/index-pack.o
>  BUILTIN_OBJS +=3D builtin/init-db.o
> diff --git a/builtin.h b/builtin.h
> index 1b35565fbd..93c91d07d4 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -172,6 +172,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv=
, const char *prefix, struc
>  int cmd_grep(int argc, const char **argv, const char *prefix, struct rep=
ository *repo);
>  int cmd_hash_object(int argc, const char **argv, const char *prefix, str=
uct repository *repo);
>  int cmd_help(int argc, const char **argv, const char *prefix, struct rep=
ository *repo);
> +int cmd_history(int argc, const char **argv, const char *prefix, struct =
repository *repo);
>  int cmd_hook(int argc, const char **argv, const char *prefix, struct rep=
ository *repo);
>  int cmd_index_pack(int argc, const char **argv, const char *prefix, stru=
ct repository *repo);
>  int cmd_init_db(int argc, const char **argv, const char *prefix, struct =
repository *repo);
> diff --git a/builtin/history.c b/builtin/history.c
> new file mode 100644
> index 0000000000..f6fe32610b
> --- /dev/null
> +++ b/builtin/history.c
> @@ -0,0 +1,22 @@
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "parse-options.h"
> +
> +int cmd_history(int argc,
> +               const char **argv,
> +               const char *prefix,
> +               struct repository *repo UNUSED)
> +{
> +       const char * const usage[] =3D {
> +               N_("git history [<options>]"),
> +               NULL,
> +       };
> +       struct option options[] =3D {
> +               OPT_END(),
> +       };
> +
> +       argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +       if (argc)
> +               usagef("unrecognized argument: %s", argv[0]);

Oh, the manual is just a placeholder that you'll extend later?  That
makes sense, but it would be less confusing if it started out with "No
subcommands are yet supported, but will be added later", with that
sentence removed in the next commit when you add a subcommand.


> +       return 0;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index accd3d0c4b..f9005cf459 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -115,6 +115,7 @@ git-grep                                mainporcelain=
           info
>  git-gui                                 mainporcelain
>  git-hash-object                         plumbingmanipulators
>  git-help                                ancillaryinterrogators          =
complete
> +git-history                             mainporcelain           history
>  git-hook                                purehelpers
>  git-http-backend                        synchingrepositories
>  git-http-fetch                          synchelpers
> diff --git a/git.c b/git.c
> index c5fad56813..744cb6527e 100644
> --- a/git.c
> +++ b/git.c
> @@ -586,6 +586,7 @@ static struct cmd_struct commands[] =3D {
>         { "grep", cmd_grep, RUN_SETUP_GENTLY },
>         { "hash-object", cmd_hash_object },
>         { "help", cmd_help },
> +       { "history", cmd_history, RUN_SETUP },
>         { "hook", cmd_hook, RUN_SETUP },
>         { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>         { "init", cmd_init_db },
> diff --git a/meson.build b/meson.build
> index a5a4e99b25..3a1d12caa4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -610,6 +610,7 @@ builtin_sources =3D [
>    'builtin/grep.c',
>    'builtin/hash-object.c',
>    'builtin/help.c',
> +  'builtin/history.c',
>    'builtin/hook.c',
>    'builtin/index-pack.c',
>    'builtin/init-db.c',
> diff --git a/t/meson.build b/t/meson.build
> index 459c52a489..73006b095a 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -387,6 +387,7 @@ integration_tests =3D [
>    't3436-rebase-more-options.sh',
>    't3437-rebase-fixup-options.sh',
>    't3438-rebase-broken-files.sh',
> +  't3450-history.sh',
>    't3500-cherry.sh',
>    't3501-revert-cherry-pick.sh',
>    't3502-cherry-pick-merge.sh',
> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> new file mode 100755
> index 0000000000..417c343d43
> --- /dev/null
> +++ b/t/t3450-history.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history command'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'does nothing without any arguments' '
> +       git history >out 2>&1 &&
> +       test_must_be_empty out
> +'
> +
> +test_expect_success 'raises an error with unknown argument' '
> +       test_must_fail git history garbage 2>err &&
> +       test_grep "unrecognized argument: garbage" err
> +'
> +
> +test_done
>
> --
> 2.52.0.542.g9473a8513b.dirty
