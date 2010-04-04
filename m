From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 4 Apr 2010 15:43:25 -0700
Message-ID: <20100404224324.GB12655@gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com> <1270392557-26538-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYXX-0003qQ-Mp
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab0DDWnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 18:43:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39544 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab0DDWna (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:43:30 -0400
Received: by pva18 with SMTP id 18so1468032pva.19
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DJaFE02q8+2X8mT6T00ctBjYVb/9kxNARO3628cPwHw=;
        b=hUQXYFkOTA8pVKIKiseZHIxgrYFObUx4TWAPzKG0gchOELBmPQvyqObqMPF7mKdTPW
         /n74nf5YhWC/mirgPsv77K3VyhxprROfImGy1jFfluICm3UM4qVJdqsu8q+mOCWy+dRY
         Cn0Q8UZFMCC9HpS8Abt1jOY+mj3lP48u/GkKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YiWO7kFjS4uIgRuj1KOoB8ITMOBMMEnD410s3jEqOrr9BZfp04nAhozuz55lwZXgcz
         x0gIREuxwLEmTFFzwCjDl7CEgOUqhXs2Xe89lE2Ue69mPWxUdHqPfkzvnGYde0ytX/6H
         9YMZEdJHCWylS7MtOzzOZ7iwtCKeDbNJTN0jw=
Received: by 10.115.133.39 with SMTP id k39mr4078209wan.198.1270421009662;
        Sun, 04 Apr 2010 15:43:29 -0700 (PDT)
Received: from gmail.com (cpe-76-174-56-199.socal.res.rr.com [76.174.56.199])
        by mx.google.com with ESMTPS id 21sm408830pzk.0.2010.04.04.15.43.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Apr 2010 15:43:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1270392557-26538-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143961>

On Sun, Apr 04, 2010 at 02:49:16PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> Change git-commit(1) to accept a --allow-empty-message option
> analogous to the existing --allow-empty option which allows empty
> trees. This is mainly for compatability with foreign SCM systems.

It's hard enough to get co-workers to write good commit
messages.  I wouldn't want to encourage them to skip writing
them altogether (by the existence of this feature).

Is there any reason why the git commit-tree plumbing didn't
suffice?

(in other words, "sure we can", but I'm asking,
 "are you sure we should?")

Just my $.02.
Hey, we just had a small earthquake.  Fun =3D)


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/git-commit.txt          |   12 +++++++--
>  builtin/commit.c                      |    7 +++--
>  t/t7510-commit-allow-empty-message.sh |   41 +++++++++++++++++++++++=
++++++++++
>  3 files changed, 54 insertions(+), 6 deletions(-)
>  create mode 100755 t/t7510-commit-allow-empty-message.sh
>=20
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 64fb458..2c1c2e1 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -10,9 +10,9 @@ SYNOPSIS
>  [verse]
>  'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--=
dry-run]
>  	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
> -	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
> -	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] =
[--]
> -	   [[-i | -o ]<file>...]
> +	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e]
> +	   [--author=3D<author>] [--date=3D<date>] [--cleanup=3D<mode>]
> +	   [--status | --no-status] [--] [[-i | -o ]<file>...]
> =20
>  DESCRIPTION
>  -----------
> @@ -131,6 +131,12 @@ OPTIONS
>  	from making such a commit.  This option bypasses the safety, and
>  	is primarily for use by foreign scm interface scripts.
> =20
> +--allow-empty-message::
> +	Like --allow-empty this command is primarily for use by foreign
> +	scm interface scripts. It allows you to create a commit with an
> +	empty commit message without using plumbing commands like
> +	linkgit:git-commit-tree[1].
> +
>  --cleanup=3D<mode>::
>  	This option sets how the commit message is cleaned up.
>  	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c5ab683..7fd963e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -65,8 +65,8 @@ static const char *template_file;
>  static char *edit_message, *use_message;
>  static char *author_name, *author_email, *author_date;
>  static int all, edit_flag, also, interactive, only, amend, signoff;
> -static int quiet, verbose, no_verify, allow_empty, dry_run, renew_au=
thorship;
> -static int no_post_rewrite;
> +static int quiet, verbose, no_verify, allow_empty, allow_empty_messa=
ge, dry_run;
> +static int no_post_rewrite, renew_authorship;
>  static char *untracked_files_arg, *force_date;
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -141,6 +141,7 @@ static struct option builtin_commit_options[] =3D=
 {
>  	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-re=
write hook"),
>  	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mod=
e", "show untracked files, optional modes: all, normal, no. (Default: a=
ll)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty =
change"),
> +	OPT_BOOLEAN(0, "allow-empty-message", &allow_empty_message, "ok to =
record a change with an empty message"),
>  	/* end commit contents options */
> =20
>  	OPT_END()
> @@ -1293,7 +1294,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
> =20
>  	if (cleanup_mode !=3D CLEANUP_NONE)
>  		stripspace(&sb, cleanup_mode =3D=3D CLEANUP_ALL);
> -	if (message_is_empty(&sb)) {
> +	if (message_is_empty(&sb) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, "Aborting commit due to empty commit message.\n");
>  		exit(1);
> diff --git a/t/t7510-commit-allow-empty-message.sh b/t/t7510-commit-a=
llow-empty-message.sh
> new file mode 100755
> index 0000000..d7dc0da
> --- /dev/null
> +++ b/t/t7510-commit-allow-empty-message.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> +#
> +
> +test_description=3D'git commit --allow-empty-message'
> +
> +. ./test-lib.sh
> +
> +commit_msg_is () {
> +	test "`git log --pretty=3Dformat:%s%b -1`" =3D "$1"
> +}
> +
> +# A sanity check to see if commit is working at all.
> +test_expect_success 'a basic commit in an empty tree should succeed'=
 '
> +	(
> +		echo content > foo &&
> +		git add foo &&
> +		git commit -m "initial commit"
> +	) &&
> +	commit_msg_is "initial commit"
> +'
> +
> +test_expect_success 'Commit no message with --allow-empty-message' '
> +	(
> +		echo "more content" >> foo &&
> +		git add foo &&
> +		printf "" | git commit --allow-empty-message
> +	) &&
> +	commit_msg_is ""
> +'
> +
> +test_expect_success 'Commit a message with --allow-empty-message' '
> +	(
> +		echo "even more content" >> foo &&
> +		git add foo &&
> +		git commit --allow-empty-message -m"hello there"
> +	) &&
> +	commit_msg_is "hello there"
> +'
> +test_done
> --=20
> 1.7.0.4.298.gc81d
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
		David
