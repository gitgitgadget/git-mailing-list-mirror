From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 6/6] worktree: new command to fix up worktree's info after moving
Date: Mon, 18 Jan 2016 13:07:36 -0000
Organization: OPDS
Message-ID: <9356A7868C16468A804C30EBD6E4A307@PhilipOakley>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com> <1453116094-4987-7-git-send-email-pclouds@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 14:07:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL9X4-0007ai-HO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 14:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbcARNHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 08:07:39 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:30810 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755005AbcARNHh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2016 08:07:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A6JgDS4pxWPL4KFlxeGQEBAQELAQIBAQEBAYMKUm2GXm2BC7EshAQehWsEAoEyTQEBAQEBAQcBAQEBQSQbQQEBAwsCg1wFAQEBAQIBCAEBGQQLAQUeAQEhCwIDBQIBAxUFAgUhAgIUAQQIEgYHAxQGARIIAgECAwGHdQMKDK5UhlWFVA2DdIEAhVWEf4JPgVWDUC6BGwWHZo80AYE5hA6GH4NWjSOFb4EQh16Ebz40gQVfhA2BSwEBAQ
X-IPAS-Result: A2A6JgDS4pxWPL4KFlxeGQEBAQELAQIBAQEBAYMKUm2GXm2BC7EshAQehWsEAoEyTQEBAQEBAQcBAQEBQSQbQQEBAwsCg1wFAQEBAQIBCAEBGQQLAQUeAQEhCwIDBQIBAxUFAgUhAgIUAQQIEgYHAxQGARIIAgECAwGHdQMKDK5UhlWFVA2DdIEAhVWEf4JPgVWDUC6BGwWHZo80AYE5hA6GH4NWjSOFb4EQh16Ebz40gQVfhA2BSwEBAQ
X-IronPort-AV: E=Sophos;i="5.22,312,1449532800"; 
   d="scan'208";a="838877308"
Received: from host-92-22-10-190.as13285.net (HELO PhilipOakley) ([92.22.10.190])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 Jan 2016 13:07:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284291>

=46rom: "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" <pclouds@gmail.com>
> This is a low-level command that can be used to correct worktree
> information after a worktree is moved. The idea is like 'index refres=
h'.
> In future we may do "worktree refresh" automatically to keep it from
> being pruned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> Documentation/git-worktree.txt |  8 +++++++-
> builtin/worktree.c             | 18 ++++++++++++++++++
> t/t1501-worktree.sh            |  9 +++++++++
> 3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt=20
> b/Documentation/git-worktree.txt
> index 62c76c1..306aeec 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
> 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>=
]
> 'git worktree prune' [-n] [-v] [--expire <expire>]
> 'git worktree list' [--porcelain]
> +'git worktree refresh'
>
> DESCRIPTION
> -----------
> @@ -65,6 +66,11 @@ each of the linked worktrees.  The output details=20
> include if the worktree is
> bare, the revision currently checked out, and the branch currently ch=
ecked=20
> out
> (or 'detached HEAD' if none).
>
> +refresh::
> +
> +This command is required to update worktree's information after it's=
=20
> moved.
> +Executed from inside the moved worktree.
> +
> OPTIONS
> -------
>
> @@ -140,7 +146,7 @@ in the entry's directory. For example, if a linke=
d=20
> working tree is moved
> to `/newpath/test-next` and its `.git` file points to
> `/path/main/.git/worktrees/test-next`, then update
> `/path/main/.git/worktrees/test-next/gitdir` to reference=20
> `/newpath/test-next`
> -instead.
> +instead. Alternatively you can run "git worktree refresh".

Shouldn't this note also include the caveat about the run location?

=2E..run "git worktree refresh" from inside the moved worktree.

>
> To prevent a $GIT_DIR/worktrees entry from being pruned (which
> can be useful in some situations, such as when the
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 475b958..0183ce0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -445,6 +445,22 @@ static int list(int ac, const char **av, const c=
har=20
> *prefix)
>  return 0;
> }
>
> +static int refresh(int ac, const char **av, const char *prefix)
> +{
> + const char *gitdir;
> +
> + if (ac !=3D 1)
> + die(_("Arguments not expected"));
> +
> + gitdir =3D git_pathdup("gitdir");
> + if (access(gitdir, F_OK))
> + return 0;
> + if (!startup_info->first_gitfile)
> + die("BUG: .git file's location not found");
> + write_file(gitdir, "%s", startup_info->first_gitfile);
> + return 0;
> +}
> +
> int cmd_worktree(int ac, const char **av, const char *prefix)
> {
>  struct option options[] =3D {
> @@ -459,5 +475,7 @@ int cmd_worktree(int ac, const char **av, const c=
har=20
> *prefix)
>  return prune(ac - 1, av + 1, prefix);
>  if (!strcmp(av[1], "list"))
>  return list(ac - 1, av + 1, prefix);
> + if (!strcmp(av[1], "refresh"))
> + return refresh(ac - 1, av + 1, prefix);
>  usage_with_options(worktree_usage, options);
> }
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index cc5b870..821831b 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -423,4 +423,13 @@ test_expect_success '$GIT_WORK_TREE overrides=20
> $GIT_DIR/common' '
>  )
> '
>
> +test_expect_success 'worktree refresh corrects gitdir file' '
> + git worktree add test-refresh &&
> + P=3Drepo.git/worktrees/test-refresh/gitdir &&
> + echo corrupt >$P &&
> + git -C test-refresh worktree refresh &&
> + echo "$TRASH_DIRECTORY/test-refresh/.git" >expected &&
> + test_cmp expected $P
> +'
> +
> test_done
> --=20
> 2.7.0.96.g5373197
>
--
Philip=20
