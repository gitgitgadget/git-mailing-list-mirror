Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3F2661A8
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880836; cv=none; b=CoImG0nhLKi7tmeiJT6Xl6nF74/v9tzDAzPKorK1CdtykMtpcQNxu/yumkWvHyfTDwdXVZ87lHvJljOcFll+hnQQlSVVBvqDewOdPt0uPkq3sC1Gxmpm0mDjZ+zbvzZCIVHudJdxmdxaevNHAWmPZphM6ad+wlrERuGp7xKUh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880836; c=relaxed/simple;
	bh=RS3GUToJ3IjeuG/S66pRQ0gIRKfFgClOujUMnoh0QcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9kCHagc4a3wASm9POIenWaAO9joFK/SH92w+H4c8jjpqOYRmHppYpxnNAGzAUmmuSBSGJ3oXAEcFqf0EUuiDZGhzNHWZKFK3ZTsJNOX4yCYB56emTl/mVobiG0YNf5tm5RHxwBqmkG1CuNx7GoPo9kliabSjrBsuhOlEm99lYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+dRbZEU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+dRbZEU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so1718500a12.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741880832; x=1742485632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfm+IlbjxzAfAhd5/qbqeLNRW0+tcdnpANag1fEIktk=;
        b=I+dRbZEU9bEyfJgcPONqTLCND4XzOr8yOt5i3cZP791Hx0RHUZOYQ0e4u7GO3dsWiC
         HtVxqZGueKvMQBNDPD58sYolmZoy+qExfKxzIlINJYkVxeXGCFVLPFvIU17Fwlb+mvrp
         Bwmu7vnh8wBlx3/jbYVc6nhGijPOJ/fS7W7cGoeiZryn7vkj6N3X8TPFjRAIuXiive9j
         hA87a7k1e49W5bOuLYck0/bxVsmR6Lsjql4QextLRQssysxhbgHv+iOPNA7By3XuIAFk
         fh0P9pDJWYC2OK/+MQSYVcV2Nc5aOOiU9CSvbFBar+7YIxOJkWH+8eT+yTj/SDxAKHgQ
         +NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880832; x=1742485632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfm+IlbjxzAfAhd5/qbqeLNRW0+tcdnpANag1fEIktk=;
        b=Bb1sVAz45Ur+7G/go3ll3ABxAa28VplhCaYdwInXWSkEd4bHF8tHL5KYNjxMNhEmP/
         jdyrnQA0Ei5KSsNP9iXDAdaCx/mhPIIytnRvf6f/nU10rA0LMOAANzXgtciAXHt6odYP
         t94d7zi87t47B5y507pk5JArFdwhfDeR8pNxfeUJl9EEvK4/dCj8zlDdy9s088VZK8cu
         qGOQJo5h8gF76jLG9p8zxc6jrYunaFdkm/jgLDgIq7EvqPN18gDxdBr10+WA5i1+/Dpn
         1n1PB+573dk88HHoGdDkOq51GIDnKMdhKqrNWCcBUk4Xr86iBPoMKQeFne4WKqm5v2H6
         Pm9Q==
X-Gm-Message-State: AOJu0Yxv5YPLmTycuh0m9p9JJeyRhmQMpIG/jWPJVqHBqQSUh6SG/0wI
	ZKXn07WU5QAM401+blC6d/ZulW55k36eqVWuS8K1O1Qx5YMRw7cLwJKIrYbN0iqQiWYFz916mAC
	QtqqfREzRgiuM2kSmYlj5v2kAaBs=
X-Gm-Gg: ASbGncsX9H8glafAKxSG/eXKPccBAv1seAPCeInceOhgQFTUhmaRCa/JiPawbrd+QVD
	N60gLUNbox/anKrHtOSm8V6mXMvzq5AvIXH1NmeNXeaGKxnMOpI1y64GOiUxwmwscGC3RRqgkK/
	q2UJmx49WN4Dg3o8tVIT80/zM3bCCwnHJRIdKoiDBiDqUCRz3I5fPaGdYuI8Z5
X-Google-Smtp-Source: AGHT+IHqe8Tb9f54o6JiytPc5XtEeEhTC/GnIZIhEAw4p204rxbw1Y693wPo4IFJy/BQc/Mfc/40Z5ZsMzOJn8dyatM=
X-Received: by 2002:a05:6402:1ed0:b0:5e4:cbee:234c with SMTP id
 4fb4d7f45d1cf-5e5e22da6cdmr27597023a12.10.1741880830424; Thu, 13 Mar 2025
 08:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 13 Mar 2025 11:46:59 -0400
X-Gm-Features: AQ5f1JphQV2J6Yesi-KuBNZIBbxdHMXq_xthr6s1lEXfM71Wa25J3Ttkqa83G-8
Message-ID: <CALnO6CCvo+EiabE3LG2pmPZhM=M9_d80Mp_MyozXmHjE9srAWg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] Update MyFirstContribution.adoc to current codebase
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:15=E2=80=AFAM K Jayatheerth
<jayatheerthkulkarni2005@gmail.com> wrote:
>
> This updates MyFirstContribution.adoc to correct outdated information,
> improve clarity for new contributors following the guide.
>
> Key changes:
> - Updated the function signature of `cmd_psuh` to match the current Git
>   codebase, adding `struct repository *repo` as required.
> - Added a note on using the `UNUSED` macro to suppress compiler
>   warnings for unused function parameters.
> - Replaced `git_config(...)` with `repo_config(...)` in documentation,
>   aligning with modern Git practices.
> - Removed mention of the deprecated
>   `git-mentoring@googlegroups.com`.
> - Renamed `Documentation/git-psuh.txt` to
>   `Documentation/git-psuh.adoc` to follow the
>   correct documentation format.
> - Updated `.txt` references to `.adoc`
>   wherever applicable for consistency.

I'm in a poor position to judge, but I suspect reviewing this commit
would be easier if each bullet was a separate commit. See
Documentation/SubmittingPatches [[separate-commits]] (HTML:
https://git-scm.com/docs/SubmittingPatches#separate-commits).

>
> These changes make it easier for
> new contributors to follow the tutorial without
> running into compilation errors or outdated references.

Agreed as discussed in the other thread, thanks for doing this!

>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 83 +++++++++++++++++---------
>  1 file changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFir=
stContribution.adoc
> index afcf4b46c1..4236c9ae3e 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes=
 based on comments.
>
>  This tutorial assumes you're already fairly familiar with using Git to m=
anage
>  source code.  The Git workflow steps will largely remain unexplained.
> +This tutorial also assumes you know/understand C programming language in=
 a good capacity.
>
>  [[related-reading]]
>  =3D=3D=3D Related Reading
> @@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.ke=
rnel.org>
>  The https://lore.kernel.org/git[archive] of this mailing list is
>  available to view in a browser.
>
> -=3D=3D=3D=3D https://groups.google.com/forum/#!forum/git-mentoring[git-m=
entoring@googlegroups.com]
> -
> -This mailing list is targeted to new contributors and was created as a p=
lace to
> -post questions and receive answers outside of the public eye of the main=
 list.
> -Veteran contributors who are especially interested in helping mentor new=
comers
> -are present on the list. In order to avoid search indexers, group member=
ship is
> -required to view messages; anyone can join and no approval is required.
>
>  =3D=3D=3D=3D https://web.libera.chat/#git-devel[#git-devel] on Libera Ch=
at
>
> @@ -149,8 +143,14 @@ subcommand and contained within `builtin/`. So it ma=
kes sense to implement your
>  command in `builtin/psuh.c`. Create that file, and within it, write the =
entry
>  point for your command in a function matching the style and signature:
>
> +The following line represents the function signature for any builtin/<fi=
lename.c> file that we add:

This line doesn't look necessary, or should at least replace the
sentence immediately prior (which shows up in the hunk context).

> +----
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct rep=
ository *repo)
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +Before proceeding further, we should use the UNUSED macro to suppress wa=
rnings about unused parameters in the function.
> +This prevents the compiler from generating warnings when certain paramet=
ers are not used within the function body:
> +----
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *pref=
ix UNUSED, struct repository *repo UNUSED)
>  ----
>
>  We'll also need to add the declaration of psuh; open up `builtin.h`, fin=
d the
> @@ -158,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `p=
suh` immediately before it,
>  in order to keep the declarations alphabetically sorted:
>
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix);
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct rep=
ository *repo);
>  ----
>
>  Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
> @@ -174,7 +174,7 @@ Throughout the tutorial, we will mark strings for tra=
nslation as necessary; you
>  should also do so when writing your user-facing commands in the future.
>
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *pref=
ix UNUSED, struct repository *repo UNUSED)
>  {
>         printf(_("Pony saying hello goes here.\n"));
>         return 0;
> @@ -205,6 +205,9 @@ with the command name, a function pointer to the comm=
and implementation, and a
>  setup option flag. For now, let's keep mimicking `push`. Find the line w=
here
>  `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing=
 the new
>  line in alphabetical order (immediately before `cmd_pull`).
> +----
> +{ "psuh", cmd_psuh, RUN_SETUP}
> +----
>
>  The options are documented in `builtin.h` under "Adding a new built-in."=
 Since
>  we hope to print some data about the user's current workspace context la=
ter,
> @@ -291,6 +294,8 @@ Modify your `cmd_psuh` implementation to dump the arg=
s you're passed, keeping
>  existing `printf()` calls in place:
>
>  ----
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct rep=
ository *repo UNUSED)
> +{
>         int i;
>
>         ...
> @@ -304,6 +309,7 @@ existing `printf()` calls in place:
>
>         printf(_("Your current working directory:\n<top-level>%s%s\n"),
>                prefix ? "/" : "", prefix ? prefix : "");
> +       ...
>
>  ----
>
> @@ -312,26 +318,47 @@ on the command line, including the name of our comm=
and. (If `prefix` is empty
>  for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's no=
t so
>  helpful. So what other context can we get?
>
> -Add a line to `#include "config.h"`. Then, add the following bits to the
> +Add `#include "config.h"` and `#include "repository.h"`. Then, add the f=
ollowing bits to the
>  function body:
>
>  ----
> -       const char *cfg_name;
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "config.h"
> +#include "repository.h"  // Required for repo_config_get_string_tmp()
>
> -...
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct rep=
ository *repo)
> +{
> +    const char *cfg_name;
> +
> +    printf(Q_("Your args (there is %d):\n",
> +              "Your args (there are %d):\n",
> +              argc),
> +           argc);
> +
> +    for (int i =3D 0; i < argc; i++) {
> +        printf("%d: %s\n", i, argv[i]);
> +    }
> +
> +    printf(_("Your current working directory:\n<top-level>%s%s\n"),
> +           prefix ? "/" : "", prefix ? prefix : "");
>
> -       git_config(git_default_config, NULL);
> -       if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
> -               printf(_("No name is found in config\n"));
> -       else
> -               printf(_("Your name: %s\n"), cfg_name);
> +    repo_config(repo, git_default_config, NULL);
> +
> +    if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
> +        printf(_("No name is found in config\n"));
> +    else
> +        printf(_("Your name: %s\n"), cfg_name);
> +
> +    return 0;
> +}
>  ----
>
> -`git_config()` will grab the configuration from config files known to Gi=
t and
> -apply standard precedence rules. `git_config_get_string_tmp()` will look=
 up
> +`repo_config()` will grab the configuration from config files known to G=
it and
> +apply standard precedence rules. `repo_config_get_string_tmp()` will loo=
k up
>  a specific key ("user.name") and give you the value. There are a number =
of
>  single-key lookup functions like this one; you can see them all (and mor=
e info
> -about how to use `git_config()`) in `Documentation/technical/api-config.=
adoc`.
> +about how to use `repo_config()` ) in `Documentation/git-config.adoc`.
>
>  You should see that the name printed matches the one you see when you ru=
n:
>
> @@ -379,8 +406,8 @@ prepare it, and print its contents:
>
>  ...
>
> -       wt_status_prepare(the_repository, &status);
> -       git_config(git_default_config, &status);
> +       wt_status_prepare(repo, &status);
> +       repo_config(repo, git_default_config, &status);
>
>  ...
>
> @@ -1089,11 +1116,11 @@ The one generated for `psuh` from the sample impl=
ementation looks like this:
>
>  ----
>   Documentation/git-psuh.adoc | 40 +++++++++++++++++++++
> - Makefile                    |  1 +
> - builtin.h                   |  1 +
> - builtin/psuh.c              | 73 ++++++++++++++++++++++++++++++++++++++
> - git.c                       |  1 +
> - t/t9999-psuh-tutorial.sh    | 12 +++++++
> + Makefile                   |  1 +
> + builtin.h                  |  1 +
> + builtin/psuh.c             | 73 ++++++++++++++++++++++++++++++++++++++
> + git.c                      |  1 +
> + t/t9999-psuh-tutorial.sh   | 12 +++++++
>   6 files changed, 128 insertions(+)
>   create mode 100644 Documentation/git-psuh.adoc
>   create mode 100644 builtin/psuh.c
> --
> 2.48.1
>
>


--=20
D. Ben Knoble
