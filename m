Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0239C63682
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiAZJeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 04:34:09 -0500
Received: from mout.web.de ([212.227.15.14]:49003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiAZJeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 04:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643189644;
        bh=RfFHC8gTaYxj4NSTIJG6edGswG/kDPzrVtW8sJGFtYs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SlEClEp2j7kZ6sCwWEtC226bSFAYM9GVbuqEVt2MCl/fJg8JUbZZ7V7PNZcy5wsID
         rlQc1e0QiUqAakSNBNqSJi4Xsre95xClESppOoMGw4EkxkNKHljobYMv1Fyp+0Gbac
         EE39KcRo2C3lauf8HEEbCU9zZe16+lAMiJFYuIJg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1mFERx1y8H-011nW0; Wed, 26
 Jan 2022 10:34:04 +0100
Message-ID: <f48cdebb-ff49-24b0-973f-b3e7954e11c8@web.de>
Date:   Wed, 26 Jan 2022 10:34:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 1/5] Implement `scalar diagnose`
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ce85506e7a4313a4ae21ef712b84d8396ac45cdc.1643186507.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F6MduvFtw2mcAq7/zaZo8S/ufl+H3Q4vg50oY6AXrTPhc6GCgmU
 DPr0Vnp4ApsmeIeTiA+wZalSzwbMTeQ9ssBHXIMiYfIbPUqZYTNx1lKdg5eWlCujPzAT/h8
 /Y5aEiyksncO/KDskePdMqhqmJSRMQzmwlAaZfd+rw4Hri00hbvmcIPsxC5QnfJR6oPMCrc
 GPIA5fw7oNgdxcjpjH3kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LhKTunxVThY=:aBtRq/raoPmaKNItC6AvOM
 WYJ/I6WDI/L1XrgdD0jP9yC3PMobYZ0AKUBPhu9x7uDoL/xuYWGdbPm6LI/O/fi6wPDGZidr+
 gHMQfGdLDP1aDSzYWlztbSuOapyoMkYhnR5ux8Swbm1CvNh4E9uhzLyhVo6preUAoou1XWJ00
 Q+Aqc4YoKcEx5i0ltLkYJ3BBwLvT6dy0icBfcIZtq1wpChjrfGjPjhUQR8kB4N4r37hJi9AN9
 r3asZ7Q9cjgszf8XZZC5pcMVfF6zoMLZ1/I9fj7JT9L0SRJ8ZzFsgprzxDc4kqwBIV7GB4Cc3
 HtWWa8fLTuGn0PB1PDwB1K0AHrRWyo0TW45ED1XT3MmTa0npayegpzHCt75MKKCYRwvVL0QTo
 6YEnDcg0pCVW4U29+IOdWyYUj3ugkce0JshM3//80419XPAmh33fNdXUV171fmRPS8PjN3u45
 IUV5kKdawbNSgw1QWlror5cRhyhYPEenVwjCEJ7Xwy7Kis8zgwZKOsUtZlLjmgAInNeZ7D81x
 zJkwsQYVljRqMNUH4u2fQg8hi69WvyH1bJ/mZ5ty70VVyDqF9PryOEJc2BQ9SQlAU8zBX22wN
 iJ0VxWmfSbobqy4Ex9HpZVfSKlFnoAv2a3RZaJo3qt2j+ldhPOz+CGmAspy0/Eav3qLewhivN
 Ot6BfelCkfuKkT0xyi/DAOpetgZFzdejFydBQ5m/oWW5eraRmjGoxHocLokScTxTl0WO8NHCt
 yu8DrctevqcdstyQIOoGZko9iefrX0l+Lupe3A5wNS/Ie8gWPdUsumMIYPgcDrEy9VP4Fr410
 EPeZ4rCQJL22i6769wQCugZZDAtxdKv45HuUoam8KZ2SIkbZmF521Ax7sAqFQLg0OX29Lesji
 8iwE4RVls0ybbqerjXJtNVWRjK0cvil+XrVaGirGOMv2P58FRFysiZdhZ2tZEzlSoyqgzvs47
 ZEcCYVHt2QFf7wKov/Dth+cstlznwsocqoaiC/Inhu6bDalGd/6D2K+9lDUaxgKvWXsGkLt8+
 ZNI7OF+UJqvEPy7OTRL9hQjZkI+wP+UvIFoxaUZgdwngPnqWsA4gGHF+C6XkAxZVfg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.01.22 um 09:41 schrieb Johannes Schindelin via GitGitGadget:
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

git archive allows you to include untracked files in an archive with its
option --add-file.  You can see an example in Git's Makefile; search for
GIT_ARCHIVE_EXTRA_FILES.  It still requires a tree argument, but the
empty tree object should suffice if you don't want to include any
tracked files.  It doesn't currently support streaming, though, i.e.
files are fully read into memory, so it's impractical for huge ones.

> Also note: Due to the frequently-spawned `git hash-object` processes,
> this command is quite a bit slow on Windows. Should it turn out to be a
> big problem, the lack of a batch mode of the `hash-object` command could
> potentially be worked around via using `git fast-import` with a crafted
> `stdin`.

Or we could add streaming support to git archive --add-file..

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 170 +++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.txt        |  12 +++
>  contrib/scalar/t/t9099-scalar.sh |  13 +++
>  3 files changed, 195 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..13f2b0f4d5a 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -259,6 +259,108 @@ static int unregister_dir(void)
>  	return res;
>  }
>
> +static int stage(const char *git_dir, struct strbuf *buf, const char *p=
ath)
> +{
> +	struct strbuf cacheinfo =3D STRBUF_INIT;
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	int res;
> +
> +	strbuf_addstr(&cacheinfo, "100644,");
> +
> +	cp.git_cmd =3D 1;
> +	strvec_pushl(&cp.args, "--git-dir", git_dir,
> +		     "hash-object", "-w", "--stdin", NULL);
> +	res =3D pipe_command(&cp, buf->buf, buf->len, &cacheinfo, 256, NULL, 0=
);
> +	if (!res) {
> +		strbuf_rtrim(&cacheinfo);
> +		strbuf_addch(&cacheinfo, ',');
> +		/* We cannot stage `.git`, use `_git` instead. */
> +		if (starts_with(path, ".git/"))
> +			strbuf_addf(&cacheinfo, "_%s", path + 1);
> +		else
> +			strbuf_addstr(&cacheinfo, path);
> +
> +		child_process_init(&cp);
> +		cp.git_cmd =3D 1;
> +		strvec_pushl(&cp.args, "--git-dir", git_dir,
> +			     "update-index", "--add", "--cacheinfo",
> +			     cacheinfo.buf, NULL);
> +		res =3D run_command(&cp);
> +	}
> +
> +	strbuf_release(&cacheinfo);
> +	return res;
> +}
> +
> +static int stage_file(const char *git_dir, const char *path)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	int res;
> +
> +	if (strbuf_read_file(&buf, path, 0) < 0)
> +		return error(_("could not read '%s'"), path);
> +
> +	res =3D stage(git_dir, &buf, path);
> +
> +	strbuf_release(&buf);
> +	return res;
> +}
> +
> +static int stage_directory(const char *git_dir, const char *path, int r=
ecurse)
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
> +
> +	while (!res && (e =3D readdir(dir))) {
> +		if (!strcmp(".", e->d_name) || !strcmp("..", e->d_name))
> +			continue;
> +
> +		strbuf_setlen(&buf, len);
> +		strbuf_addstr(&buf, e->d_name);
> +
> +		if ((e->d_type =3D=3D DT_REG && stage_file(git_dir, buf.buf)) ||
> +		    (e->d_type =3D=3D DT_DIR && recurse &&
> +		     stage_directory(git_dir, buf.buf, recurse)))
> +			res =3D -1;
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&buf);
> +	return res;
> +}
> +
> +static int index_to_zip(const char *git_dir)
> +{
> +	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	struct strbuf oid =3D STRBUF_INIT;
> +
> +	cp.git_cmd =3D 1;
> +	strvec_pushl(&cp.args, "--git-dir", git_dir, "write-tree", NULL);
> +	if (pipe_command(&cp, NULL, 0, &oid, the_hash_algo->hexsz + 1,
> +			 NULL, 0))
> +		return error(_("could not write temporary tree object"));
> +
> +	strbuf_rtrim(&oid);
> +	child_process_init(&cp);
> +	cp.git_cmd =3D 1;
> +	strvec_pushl(&cp.args, "--git-dir", git_dir, "archive", "-o", NULL);
> +	strvec_pushf(&cp.args, "%s.zip", git_dir);
> +	strvec_pushl(&cp.args, oid.buf, "--", NULL);
> +	strbuf_release(&oid);
> +	return run_command(&cp);
> +}
> +
>  /* printf-style interface, expects `<key>=3D<value>` argument */
>  static int set_config(const char *fmt, ...)
>  {
> @@ -499,6 +601,73 @@ cleanup:
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
> +	struct strbuf tmp_dir =3D STRBUF_INIT;
> +	time_t now =3D time(NULL);
> +	struct tm tm;
> +	struct strbuf path =3D STRBUF_INIT, buf =3D STRBUF_INIT;
> +	int res =3D 0;
> +
> +	argc =3D parse_options(argc, argv, NULL, options,
> +			     usage, 0);
> +
> +	setup_enlistment_directory(argc, argv, usage, options, &buf);
> +
> +	strbuf_addstr(&buf, "/.scalarDiagnostics/scalar_");
> +	strbuf_addftime(&buf, "%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
> +	if (run_git("init", "-q", "-b", "dummy", "--bare", buf.buf, NULL)) {
> +		res =3D error(_("could not initialize temporary repository: %s"),
> +			    buf.buf);
> +		goto diagnose_cleanup;
> +	}
> +	strbuf_realpath(&tmp_dir, buf.buf, 1);
> +
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "Collecting diagnostic info into temp folder %s\n\n"=
,
> +		    tmp_dir.buf);
> +
> +	get_version_info(&buf, 1);
> +
> +	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
> +	fwrite(buf.buf, buf.len, 1, stdout);
> +
> +	if ((res =3D stage(tmp_dir.buf, &buf, "diagnostics.log")))
> +		goto diagnose_cleanup;
> +
> +	if ((res =3D stage_directory(tmp_dir.buf, ".git", 0)) ||
> +	    (res =3D stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
> +	    (res =3D stage_directory(tmp_dir.buf, ".git/info", 0)) ||
> +	    (res =3D stage_directory(tmp_dir.buf, ".git/logs", 1)) ||
> +	    (res =3D stage_directory(tmp_dir.buf, ".git/objects/info", 0)))
> +		goto diagnose_cleanup;
> +
> +	res =3D index_to_zip(tmp_dir.buf);
> +
> +	if (!res)
> +		res =3D remove_dir_recursively(&tmp_dir, 0);
> +
> +	if (!res)
> +		printf("\n"
> +		       "Diagnostics complete.\n"
> +		       "All of the gathered info is captured in '%s.zip'\n",
> +		       tmp_dir.buf);
> +
> +diagnose_cleanup:
> +	strbuf_release(&tmp_dir);
> +	strbuf_release(&path);
> +	strbuf_release(&buf);
> +
> +	return res;
> +}
> +
>  static int cmd_list(int argc, const char **argv)
>  {
>  	if (argc !=3D 1)
> @@ -800,6 +969,7 @@ static struct {
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
> index 2e1502ad45e..ecd06e207c2 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -65,6 +65,19 @@ test_expect_success 'scalar clone' '
>  	)
>  '
>
> +SQ=3D"'"
> +test_expect_success UNZIP 'scalar diagnose' '
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
>  test_expect_success 'scalar reconfigure' '
>  	git init one/src &&
>  	scalar register one &&

