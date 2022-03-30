Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A5C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbiC3TNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350823AbiC3TMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:12:47 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45F31374
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:10:34 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HrPSajpWlRWyWmGJKUEA1Mn/2DWofjROYakKNdWODdQTILnz1dE95KOJSx0gWfdnVUcU913dkICgNMQ6My6ou5/l8fyyYwHNc/Ock0Alv1N7Gwm/68zU3MM8cTY7RfI7WDVlbTedQrnALoxwKOetsocMZIaRE6WcCCuaJssrQlFqQCLM1YulO+kzi4g5nbFZbpRr1qRwNBHkxqiSef8B/QUXIjNugYchIYv1R1ipsvjsKcmlnIJegX1+xJ6WSrs7u0TSM/WuyxYe7DvwYCc+EzFQa0mqf3EYP9kwDbbeGZudvMVDH4vmdU1h2/wJspe+MHp0ZhpBGdFCwt8dquzhQg==; s=purelymail3; d=slashdev.space; v=1; bh=55QtVv122IPhPWVq39t6oUUBCCkhc+B+a7nPqcJ8b8Y=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=mW45wmQo65lM5cH/85zjz8aL1royzmh016EmW5TvBp2ffyvx5J1Jd7QTlNhSJLnQ6Bp9nW569fXkIZPuh2Tes4Vh4sYFkzZxdzpojsu1E6iuZCxyWjjM7B6RiilQhTtmmtwQ/1qJ/5owiJBzhATg5vpquNDj7haSdLhEU5txDj/N8SyyJI3EebpKNkOU2alw7Biz5wchX+aLU6VF6pAzZ2EjdhRtCde/Iz1/g2DdiEhVYlzgC5xCAp/dIUE/gxftybQrA7iySHb+rC5of5by8LGSDnLbAitGLu8LyR83ljeXfY26nBLH+DjywfKVlcqVW/oEiyWMvCo29lOI7iv7lA==; s=purelymail3; d=purelymail.com; v=1; bh=55QtVv122IPhPWVq39t6oUUBCCkhc+B+a7nPqcJ8b8Y=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -291021704;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Wed, 30 Mar 2022 19:10:28 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     git@vger.kernel.org
Cc:     Garrit Franke <garrit@slashdev.space>
Subject: [PATCH v2] cli: add -v and -h shorthands
Date:   Wed, 30 Mar 2022 21:09:56 +0200
Message-Id: <20220330190956.21447-1-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of "git -v" to be synonymous with "--version" /
"version", and "git -h" to be synonymous with "--help", but not "help".

These shorthands both display the "unknown option" message. Following
this change, "-v" displays the version, and "-h" displays the help text
of the "git" command.

It should be noted that the "-v" shorthand could be misinterpreted by
the user to mean "verbose" instead of "version", since some sub-commands
make use of it in this context. The top-level "git" command does not
have a "verbose" flag, so it's safe to introduce this shorthand
unambiguously.

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---

On Wed, Mar 30 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On a second reading I see that there's an implied "change the behavior
> to ..." there.

Interesting, I haven't yet thought of it that way. I tried to be as
precise as possible this time. :)

> The translation files are updated by a process that the translation
> teams(s) use, see po/README.md. I think changing this from under them
> is probably more disruptive than not.

This doc slipped past me. Thanks!

> nit: minimize the diff here perhaps by keeping the existing line, and
> doing -h or -v on a new line? Your indentation here is also off.

Whoops, the indentation looked fine in my editor with a tab-width of
four. I'll make sure to review the patch more carefully next time!

> FWIW I have an existing branch (unsubmitted) at
> https://github.com/avar/git/tree/avar/parse-options-h-3 where I added
> some tests for "git cmd -h" behavior, which seems to pass with this
> change (not unexpected, as this is for the top-level command).

Do you think it makes sense to add tests for this behavior as well? I
originally refrained from adding them mainly due to lack of experience
in the project, but I'd be happy to add some if necessary.

Thanks
Garrit

 Documentation/git.txt |  4 +++-
 git.c                 | 12 +++++++++---
 t/t0012-help.sh       |  2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 13f83a2..302607a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
@@ -39,6 +39,7 @@ or https://git-scm.com/docs.
=20
 OPTIONS
 -------
+-v::
 --version::
 =09Prints the Git suite version that the 'git' program came from.
 +
@@ -46,6 +47,7 @@ This option is internally converted to `git version ...` =
and accepts
 the same options as the linkgit:git-version[1] command. If `--help` is
 also given, it takes precedence over `--version`.
=20
+-h::
 --help::
 =09Prints the synopsis and a list of the most commonly used
 =09commands. If the option `--all` or `-a` is given then all
diff --git a/git.c b/git.c
index a25940d..024d463 100644
--- a/git.c
+++ b/git.c
@@ -25,7 +25,7 @@ struct cmd_struct {
 };
=20
 const char git_usage_string[] =3D
-=09N_("git [--version] [--help] [-C <path>] [-c <name>=3D<value>]\n"
+=09N_("git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>=
]\n"
 =09   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--i=
nfo-path]\n"
 =09   "           [-p | --paginate | -P | --no-pager] [--no-replace-object=
s] [--bare]\n"
 =09   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
@@ -146,7 +146,8 @@ static int handle_options(const char ***argv, int *argc=
, int *envchanged)
 =09=09 * commands can be written with "--" prepended
 =09=09 * to make them look like flags.
 =09=09 */
-=09=09if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
+=09=09if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version") ||
+=09=09    !strcmp(cmd, "-h") || !strcmp(cmd, "-v"))
 =09=09=09break;
=20
 =09=09/*
@@ -893,7 +894,12 @@ int cmd_main(int argc, const char **argv)
 =09handle_options(&argv, &argc, NULL);
 =09if (argc > 0) {
 =09=09/* translate --help and --version into commands */
-=09=09skip_prefix(argv[0], "--", &argv[0]);
+=09=09if (!strcmp("-v", argv[0]))
+=09=09=09argv[0] =3D "version";
+=09=09else if (!strcmp("-h", argv[0]))
+=09=09=09argv[0] =3D "help";
+=09=09else
+=09=09=09skip_prefix(argv[0], "--", &argv[0]);
 =09} else {
 =09=09/* The user didn't specify a command; give them help */
 =09=09commit_pager_choice();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6c3e1f7..6c33a43 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -181,7 +181,7 @@ for cmd in git "git help"
 do
 =09test_expect_success "'$cmd' section spacing" '
 =09=09test_section_spacing_trailer git help <<-\EOF &&
-=09=09usage: git [--version] [--help] [-C <path>] [-c <name>=3D<value>]
+=09=09usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<=
value>]
=20
 =09=09These are common Git commands used in various situations:
=20
--=20
2.35.1

