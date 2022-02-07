Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05900C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 20:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiBGUCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiBGUAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 15:00:20 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF35C0401DA
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 12:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644264017;
        bh=WohQMNlWySmGRIX8JKIyRGCajPISsbJ624f0U5fdIiE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cmH6pwRJ7MaQ8OqfHhUHK+U3XkFPGaoi+s0SF9RbWdwp8IXC9F1UCVwhjlUdFKhGH
         MWIC9LPBo6Dkeulo61zrZvJreAdVD0ezgJ594odBfzJ+Q6p6r1VyUJob0zKp1k26Z1
         sTWezefDzgKcI2qzixhxeaObAKQE1GM4BLh7sVn0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3Yg-1o81o10ZLU-00r1Bh; Mon, 07
 Feb 2022 20:55:13 +0100
Message-ID: <ef70b87e-989b-e99c-b4ca-2b91c05defcf@web.de>
Date:   Mon, 7 Feb 2022 20:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 3/6] Implement `scalar diagnose`
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <0d570137bb6aef675f4f5d74d140ace1dfba5eb7.1644187146.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0d570137bb6aef675f4f5d74d140ace1dfba5eb7.1644187146.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJDZc8eMyC0p2A3zrekMqkKgxfFNBSfxq4QCecsBuItOhO8ZpNo
 0pHvtAlq4iY4IyOzNMUq4JnEWgQnRhXOpTz3Jx4Ifc3nBAreDGvCZxiE3a0rDsO6DNkONnI
 VtM/RHbMPM9e14yxapzrKfZ+udXD42sLZ2BrEdzX9PEg+ULi1Fzk4yOcbK7Dv9JsZHNkJlw
 pe3J97C0tKrBTEBNgM0EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMjj8AmLyTE=:weuleYTQ3n47IYKVqk4MgK
 pgqLAdv0qL9fpVIVo3Zi+FsKxuVSukDQ7lUzySwQ/1JmIdcWgA7wwRxlQ/OATbPQRkQsWucqT
 CcAGHbPzOpGY3rFGTJIeYT53ChVbi82b7bJogZ6VUFu+Iw/HsLd+AaiEc2rc/u60kwXVcucTA
 N+SRPj/KreXpFmWy5KpW8OO9kd1w/w4kswRcOrf2Gbbidp7HziIqi6fyt+GjF195yYcYkboKx
 cTcpvZPNRqjBqJacngDxhJYAhvUmZABW1uKnQLPxfmAaybOpxHG5EJdWOxT7/vr5iG8xpXGIa
 qD+pO98utIghYwOXRzxelvu8gJ/m2BFjgkTaQuaRry+gpgh9ltvRPR3MpXdnwEbYpHyVH3NOp
 ZXrl1mF9BSUnnShBxdBb5+QjXrWqJB6yGUMd1k75UdDKbc05eqtePErHM3sap3ov/nY4/F3hX
 Svawpo/cMHtspQyoM488rCkuL4g2rOgVEhn4g0fE7jcP0W7D2pIjI2itl/EI5SOX0nObYy3Z4
 Ch4rJUVJ1gr1L1SIINhGDsqWcTfB3UrjVDVEdVcHVDuwYdGaLFXsQ1aWzCGnLtNTEFUkmV0wR
 2G+6/bSu9FxWyMMqbuRWw62E++bUWaa7L+IxTt8422aRxlaiBjS0dc3O9catx3swLG5AqRU4Y
 +R1lk9m56h9Erv62naP/HiST0Gwv+/d0tSZ0CeaP4A741bn8t7bE6swyV9qCaPNeWpEI8380Q
 xYSZVwrkuTGg+2nNDqv2/Swj7Ln0TvVO2EMQj0cYVrAZ/QoI5VCo31PgEaQd/Zl4WRcp25pk3
 jbsif3mZzMe8/vhaJn9XKeNLqNzE8JAfIg5cGMYUKCUo71JpVgfTl7v3CI/WwBQd3XLvUkBBV
 8ETtjoYBYU+YR18aN85zorhqDVF+KWBXB7WcxvwrtbDWDnZiUR+AOG7wSnisSkLpwllzyIuE5
 nP1KbLqcgPxMaLFJ5FWV0RpTLWWH196vV8YuI693bzOXp4oOzufUp3uUTbEfSA0Eccqgt5ID/
 NbgySYeegw027qteG3npD1PV0SdErl6FFMRA0p8RUR/Clh6I7d7s4MD7uLq7ZjZay86b3TRKn
 AEjkePrxTTih7E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 06.02.22 um 23:39 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Over the course of Scalar's development, it became obvious that there is
> a need for a command that can gather all kinds of useful information
> that can help identify the most typical problems with large
> worktrees/repositories.
>
> The `diagnose` command is the culmination of this hard-won knowledge: it
> gathers the installed hooks, the config, a couple statistics describing
> the data shape, among other pieces of information, and then wraps
> everything up in a tidy, neat `.zip` archive.
>
> Note: originally, Scalar was implemented in C# using the .NET API, where
> we had the luxury of a comprehensive standard library that includes
> basic functionality such as writing a `.zip` file. In the C version, we
> lack such a commodity. Rather than introducing a dependency on, say,
> libzip, we slightly abuse Git's `archive` command: Instead of writing
> the `.zip` file directly, we stage the file contents in a Git index of a
> temporary, bare repository, only to let `git archive` have at it, and
> finally removing the temporary repository.
>
> Also note: Due to the frequently-spawned `git hash-object` processes,
> this command is quite a bit slow on Windows. Should it turn out to be a
> big problem, the lack of a batch mode of the `hash-object` command could
> potentially be worked around via using `git fast-import` with a crafted
> `stdin`.

The two paragraphs above are not in sync with the patch.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 143 +++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.txt        |  12 +++
>  contrib/scalar/t/t9099-scalar.sh |  14 +++
>  3 files changed, 169 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 00dcd4b50ef..30ce0799c7a 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -11,6 +11,7 @@
>  #include "dir.h"
>  #include "packfile.h"
>  #include "help.h"
> +#include "archive.h"
>
>  /*
>   * Remove the deepest subdirectory in the provided path string. Path mu=
st not
> @@ -261,6 +262,44 @@ static int unregister_dir(void)
>  	return res;
>  }
>
> +static int add_directory_to_archiver(struct strvec *archiver_args,
> +					  const char *path, int recurse)
> +{
> +	int at_root =3D !*path;
> +	DIR *dir =3D opendir(at_root ? "." : path);
> +	struct dirent *e;
> +	struct strbuf buf =3D STRBUF_INIT;
> +	size_t len;
> +	int res =3D 0;
> +
> +	if (!dir)
> +		return error(_("could not open directory '%s'"), path);
> +
> +	if (!at_root)
> +		strbuf_addf(&buf, "%s/", path);
> +	len =3D buf.len;
> +	strvec_pushf(archiver_args, "--prefix=3D%s", buf.buf);
> +
> +	while (!res && (e =3D readdir(dir))) {
> +		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
> +			continue;
> +
> +		strbuf_setlen(&buf, len);
> +		strbuf_addstr(&buf, e->d_name);
> +
> +		if (e->d_type =3D=3D DT_REG)
> +			strvec_pushf(archiver_args, "--add-file=3D%s", buf.buf);
> +		else if (e->d_type !=3D DT_DIR)
> +			res =3D -1;
> +		else if (recurse)
> +		     add_directory_to_archiver(archiver_args, buf.buf, recurse);
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&buf);
> +	return res;
> +}
> +
>  /* printf-style interface, expects `<key>=3D<value>` argument */
>  static int set_config(const char *fmt, ...)
>  {
> @@ -501,6 +540,109 @@ cleanup:
>  	return res;
>  }
>
> +static int cmd_diagnose(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END(),
> +	};
> +	const char * const usage[] =3D {
> +		N_("scalar diagnose [<enlistment>]"),
> +		NULL
> +	};
> +	struct strbuf zip_path =3D STRBUF_INIT;
> +	struct strvec archiver_args =3D STRVEC_INIT;
> +	char **argv_copy =3D NULL;
> +	int stdout_fd =3D -1, archiver_fd =3D -1;
> +	time_t now =3D time(NULL);
> +	struct tm tm;
> +	struct strbuf path =3D STRBUF_INIT, buf =3D STRBUF_INIT;
> +	size_t off;
> +	int res =3D 0;
> +
> +	argc =3D parse_options(argc, argv, NULL, options,
> +			     usage, 0);
> +
> +	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
> +
> +	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
> +	strbuf_addftime(&zip_path,
> +			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
> +	strbuf_addstr(&zip_path, ".zip");
> +	switch (safe_create_leading_directories(zip_path.buf)) {
> +	case SCLD_EXISTS:
> +	case SCLD_OK:
> +		break;
> +	default:
> +		error_errno(_("could not create directory for '%s'"),
> +			    zip_path.buf);
> +		goto diagnose_cleanup;
> +	}
> +	stdout_fd =3D dup(1);
> +	if (stdout_fd < 0) {
> +		res =3D error_errno(_("could not duplicate stdout"));
> +		goto diagnose_cleanup;
> +	}
> +
> +	archiver_fd =3D xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 0666=
);
> +	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
> +		res =3D error_errno(_("could not redirect output"));
> +		goto diagnose_cleanup;
> +	}
> +
> +	init_zip_archiver();
> +	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=3Dzip", NULL=
);
> +
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf,
> +		      "--add-file-with-content=3Ddiagnostics.log:"
> +		      "Collecting diagnostic info\n\n");
> +	get_version_info(&buf, 1);
> +
> +	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
> +	off =3D strchr(buf.buf, ':') + 1 - buf.buf;
> +	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
> +	strvec_push(&archiver_args, buf.buf);

Fun trick to reuse the buffer for both the ZIP entry and stdout. :)  I'd
have omitted the option from buf and added it like this, for simplicity:

	strvec_pushf(&archiver_args,
		     "--add-file-with-content=3Ddiagnostics.log:%s", buf.buf);

Just a thought.

> +
> +	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks", 0=
)) ||
> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", 0)=
) ||
> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/logs", 1)=
) ||
> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/objects/i=
nfo", 0)))
> +		goto diagnose_cleanup;
> +
> +	strvec_pushl(&archiver_args, "--prefix=3D",
> +		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
> +
> +	/* `write_archive()` modifies the `argv` passed to it. Let it. */
> +	argv_copy =3D xmemdupz(archiver_args.v,
> +			     sizeof(char *) * archiver_args.nr);

Leaking the whole thing would be fine as well for this command, but
cleaning up is tidier, of course.

> +	res =3D write_archive(archiver_args.nr, (const char **)argv_copy, NULL=
,
> +			    the_repository, NULL, 0);

Ah -- no shell means no command line length limits. :)

> +	if (res) {
> +		error(_("failed to write archive"));
> +		goto diagnose_cleanup;
> +	}
> +
> +	if (!res)
> +		printf("\n"
> +		       "Diagnostics complete.\n"
> +		       "All of the gathered info is captured in '%s'\n",
> +		       zip_path.buf);

Is this message appended to the ZIP file or does it go to stdout?

In any case: mixing write(2) and stdio(3) is not a good idea.  Using
fwrite(3) instead of write_or_die above and doing the stdout dup(2)
dance only tightly around the write_archive call would help, I think.

> +
> +diagnose_cleanup:
> +	if (archiver_fd >=3D 0) {
> +		close(1);
> +		dup2(stdout_fd, 1);
> +	}
> +	free(argv_copy);
> +	strvec_clear(&archiver_args);
> +	strbuf_release(&zip_path);
> +	strbuf_release(&path);
> +	strbuf_release(&buf);
> +
> +	return res;
> +}
> +
>  static int cmd_list(int argc, const char **argv)
>  {
>  	if (argc !=3D 1)
> @@ -802,6 +944,7 @@ static struct {
>  	{ "reconfigure", cmd_reconfigure },
>  	{ "delete", cmd_delete },
>  	{ "version", cmd_version },
> +	{ "diagnose", cmd_diagnose },
>  	{ NULL, NULL},
>  };
>
> diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> index f416d637289..22583fe046e 100644
> --- a/contrib/scalar/scalar.txt
> +++ b/contrib/scalar/scalar.txt
> @@ -14,6 +14,7 @@ scalar register [<enlistment>]
>  scalar unregister [<enlistment>]
>  scalar run ( all | config | commit-graph | fetch | loose-objects | pack=
-files ) [<enlistment>]
>  scalar reconfigure [ --all | <enlistment> ]
> +scalar diagnose [<enlistment>]
>  scalar delete <enlistment>
>
>  DESCRIPTION
> @@ -129,6 +130,17 @@ reconfigure the enlistment.
>  With the `--all` option, all enlistments currently registered with Scal=
ar
>  will be reconfigured. Use this option after each Scalar upgrade.
>
> +Diagnose
> +~~~~~~~~
> +
> +diagnose [<enlistment>]::
> +    When reporting issues with Scalar, it is often helpful to provide t=
he
> +    information gathered by this command, including logs and certain
> +    statistics describing the data shape of the current enlistment.
> ++
> +The output of this command is a `.zip` file that is written into
> +a directory adjacent to the worktree in the `src` directory.
> +
>  Delete
>  ~~~~~~
>
> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-s=
calar.sh
> index 9d83fdf25e8..bbd07a44426 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -90,4 +90,18 @@ test_expect_success '`scalar [...] <dir>` errors out =
when dir is missing' '
>  	grep "cloned. does not exist" err
>  '
>
> +SQ=3D"'"
> +test_expect_success UNZIP 'scalar diagnose' '
> +	scalar clone "file://$(pwd)" cloned --single-branch &&
> +	scalar diagnose cloned >out &&
> +	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
> +	zip_path=3D$(cat zip_path) &&
> +	test -n "$zip_path" &&
> +	unzip -v "$zip_path" &&
> +	folder=3D${zip_path%.zip} &&
> +	test_path_is_missing "$folder" &&
> +	unzip -p "$zip_path" diagnostics.log >out &&
> +	test_file_not_empty out
> +'
> +
>  test_done
