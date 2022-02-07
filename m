Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9CC433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 20:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiBGUCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiBGUAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 15:00:11 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 12:00:09 PST
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D3C0401E2
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 12:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644264007;
        bh=oiu2t/UZli3QoFRDdWlEBNHS7fBbcvgCRM64WeqYYC0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W2APpHJIrCNbb2p470zzBVBbuDSb7EozpgAf+H1fsHHku6scTcr7UAeGOAvTUhaoS
         I1TWgVpzaloyT0zS9SKwfLFe8wkXFXUmgrNPs02JAtYPqo3tsUu5g9C8Du2cAdD8X3
         ajJXCpJ1pnEYU0OxRnL9DjdGeZXJzv/zmCUHJf1E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmvd-1o2pnV2sBz-00mIKa; Mon, 07
 Feb 2022 20:55:02 +0100
Message-ID: <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
Date:   Mon, 7 Feb 2022 20:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HlHey4RzPos1v4nSAofl0T1ETTXrTh83TPwxKNacp/hkSI/HuC1
 djYz8bHoHKH1z1/uK8OTou7WS59TFaciRHKifH9i1pALSsKnXSflEm4geynkch3DODbt22H
 lTuuTChuEizTEhPCrS6ia542HYq8zLK2qajgMyQeCvHRP953Bwh8nt2xtIUr0Aobwbn5RiH
 FpHbd99iQ4JFs8P5ZV7Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+YsgcD1lKZ0=:YsqPIQj+DmyUtF4emA9DaU
 24Djb8EH3JVQ39PgYWhONqg1ov4FrkwWDVNzC1gz2x15YM+rlOwPY1GUq6gXR5oD1nviVyv+4
 kBPCEMU0MnLicEg6Dq3oc6uBX7mr42bIvOiumq3ySQRoLqn6U0wcBe3WjX/U5NHEUiGUB9vnr
 oQKMYN08rZL+yxDb2MtFQCETFETsukdjyp0VO8ATjbKeqGCW1FzXjRcAzYGDHrKRcKIwUqsvI
 lXsIUpyUwZRrioF56grT2nZTeSE6R6rRDdylTYUBb2kWr21IHO3D3Y4MxNYNK9OyeKrcirM/j
 4GuRrvs0j90JYdSb7eytH6i1zF8v8le+a6yNhD6TOt3LuzTFPpOWQZzZ/kbVV+zc98o1EX1z9
 PeIF/dXGRwqqF5qaogbGARrs5WFQOfTdpVAKT0nJS/rUkL/HVQqaYVV+KougdeLZZCYMJWzBI
 AOFr6bmD+blFgnXnfJOeS0LINS9N/M9DF2zDJtFZvaADJu+C3XBzPZ4urKWA1lrCfk9z8zPj5
 68iS4oHv32pWJc1JmDN2tbYckEfwPKzg7/3Ifuiu0LNql4VJN3GQ4rPY4wZ2t63Y64PR+p3gR
 pRNcNdpzEnv2c2LkY91kdax2cW8pDZPeM0/Ove0vhR5+VB8ge13w6tMMcdEMBHMa3aSDbtspC
 YyZOXA1wnAWEP2rrj12VnEbJ8QRnGN3TlFAGAEVn4J7u7hDwNKzTClszhK6sF63E+Sx/RRcM1
 YcvPdQitXxvztRptvm5HL8JbWtC/pgIBwwObzw3gq416ysJDqI5Tuz+kMx4cE/vd8SKFrfdA0
 BU/moGXjqtAHyBk15uiV9djr7vRkg0rxiUzAAVZ5/9ACEB6mC+fRdAYcoCsrc/9Nl2XsSWhlM
 IUQIUyNaoqgVP8P1whPZvMac84hLM+kLSlPD6Rm10/wUsjflVjk+EfV3STsiZNRjSdvpsBhxR
 oCfi59tJN/bz/TFijdlFp7k8zB1HAwlMqmlqBoTPTnDrfxMJosW3S7mdo+KLM8Z/dERPOHvce
 e4DT1jnH7kEXZr8CicsAfLT5Z7SpJ/Hk06L2UWyGMK7QRcCkTA/bRnsqUiKO5P0Fzg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.22 um 23:39 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> With the `--add-file-with-content=3D<path>:<content>` option, `git
> archive` now supports use cases where relatively trivial files need to
> be added that do not exist on disk.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-archive.txt | 11 ++++++++
>  archive.c                     | 51 +++++++++++++++++++++++++++++------
>  t/t5003-archive-zip.sh        | 12 +++++++++
>  3 files changed, 66 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.t=
xt
> index bc4e76a7834..1b52a0a65a1 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -61,6 +61,17 @@ OPTIONS
>  	by concatenating the value for `--prefix` (if any) and the
>  	basename of <file>.
>
> +--add-file-with-content=3D<path>:<content>::
> +	Add the specified contents to the archive.  Can be repeated to add
> +	multiple files.  The path of the file in the archive is built
> +	by concatenating the value for `--prefix` (if any) and the
> +	basename of <file>.
> ++
> +The `<path>` cannot contain any colon, the file mode is limited to
> +a regular file, and the option may be subject platform-dependent

s/subject/& to/

> +command-line limits. For non-trivial cases, write an untracked file
> +and use `--add-file` instead.
> +

We could use that option in Git's own Makefile to add the file named
"version", which contains $GIT_VERSION.  Hmm, but it also contains a
terminating newline, which would be a bit tricky (but not impossible) to
add.  Would it make sense to add one automatically if it's missing (e.g.
with strbuf_complete_line)?  Not sure.

>  --worktree-attributes::
>  	Look for attributes in .gitattributes files in the working tree
>  	as well (see <<ATTRIBUTES>>).
> diff --git a/archive.c b/archive.c
> index a3bbb091256..172efd690c3 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const struct=
 object_id *oid,
>  struct extra_file_info {
>  	char *base;
>  	struct stat stat;
> +	void *content;
>  };
>
>  int write_archive_entries(struct archiver_args *args,
> @@ -337,7 +338,13 @@ int write_archive_entries(struct archiver_args *arg=
s,
>  		strbuf_addstr(&path_in_archive, basename(path));
>
>  		strbuf_reset(&content);
> -		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
> +		if (info->content)
> +			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
> +					  path_in_archive.len,
> +					  info->stat.st_mode,
> +					  info->content, info->stat.st_size);
> +		else if (strbuf_read_file(&content, path,
> +					  info->stat.st_size) < 0)
>  			err =3D error_errno(_("could not read '%s'"), path);
>  		else
>  			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
> @@ -493,6 +500,7 @@ static void extra_file_info_clear(void *util, const =
char *str)
>  {
>  	struct extra_file_info *info =3D util;
>  	free(info->base);
> +	free(info->content);
>  	free(info);
>  }
>
> @@ -514,14 +522,38 @@ static int add_file_cb(const struct option *opt, c=
onst char *arg, int unset)
>  	if (!arg)
>  		return -1;
>
> -	path =3D prefix_filename(args->prefix, arg);
> -	item =3D string_list_append_nodup(&args->extra_files, path);
> -	item->util =3D info =3D xmalloc(sizeof(*info));
> +	info =3D xmalloc(sizeof(*info));
>  	info->base =3D xstrdup_or_null(base);
> -	if (stat(path, &info->stat))
> -		die(_("File not found: %s"), path);
> -	if (!S_ISREG(info->stat.st_mode))
> -		die(_("Not a regular file: %s"), path);
> +
> +	if (strcmp(opt->long_name, "add-file-with-content")) {

Equivalent to:

	if (!strcmp(opt->long_name, "add-file")) {

I mention that because the inequality check confused me a bit at first.

> +		path =3D prefix_filename(args->prefix, arg);
> +		if (stat(path, &info->stat))
> +			die(_("File not found: %s"), path);
> +		if (!S_ISREG(info->stat.st_mode))
> +			die(_("Not a regular file: %s"), path);
> +		info->content =3D NULL; /* read the file later */
> +	} else {
> +		const char *colon =3D strchr(arg, ':');
> +		char *p;
> +
> +		if (!colon)
> +			die(_("missing colon: '%s'"), arg);
> +
> +		p =3D xstrndup(arg, colon - arg);
> +		if (!args->prefix)
> +			path =3D p;
> +		else {
> +			path =3D prefix_filename(args->prefix, p);
> +			free(p);
> +		}
> +		memset(&info->stat, 0, sizeof(info->stat));
> +		info->stat.st_mode =3D S_IFREG | 0644;
> +		info->content =3D xstrdup(colon + 1);
> +		info->stat.st_size =3D strlen(info->content);
> +	}
> +	item =3D string_list_append_nodup(&args->extra_files, path);
> +	item->util =3D info;
> +
>  	return 0;
>  }
>
> @@ -554,6 +586,9 @@ static int parse_archive_args(int argc, const char *=
*argv,
>  		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
>  		  N_("add untracked file to archive"), 0, add_file_cb,
>  		  (intptr_t)&base },
> +		{ OPTION_CALLBACK, 0, "add-file-with-content", args,
> +		  N_("file"), N_("add untracked file to archive"), 0,
                      ^^^^
"<file>" seems wrong, because there is no actual file.  It should rather
be "<name>:<content>" for the virtual one, right?

> +		  add_file_cb, (intptr_t)&base },
>  		OPT_STRING('o', "output", &output, N_("file"),
>  			N_("write the archive to this file")),
>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 1e6d18b140e..8ff1257f1a0 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -206,6 +206,18 @@ test_expect_success 'git archive --format=3Dzip --a=
dd-file' '
>  check_zip with_untracked
>  check_added with_untracked untracked untracked
>
> +test_expect_success UNZIP 'git archive --format=3Dzip --add-file-with-c=
ontent' '
> +	git archive --format=3Dzip >with_file_with_content.zip \
> +		--add-file-with-content=3Dhello:world $EMPTY_TREE &&
> +	test_when_finished "rm -rf tmp-unpack" &&
> +	mkdir tmp-unpack && (
> +		cd tmp-unpack &&
> +		"$GIT_UNZIP" ../with_file_with_content.zip &&
> +		test_path_is_file hello &&
> +		test world =3D $(cat hello)
> +	)
> +'
> +
>  test_expect_success 'git archive --format=3Dzip --add-file twice' '
>  	echo untracked >untracked &&
>  	git archive --format=3Dzip --prefix=3Done/ --add-file=3Duntracked \
