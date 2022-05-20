Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F6C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 14:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiETOln (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbiETOl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 10:41:28 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49E457A0
        for <git@vger.kernel.org>; Fri, 20 May 2022 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653057668;
        bh=U/IGik8E+3ZaNZ+U67/oKmre7q5yubBH6dYbyaNNjZs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V7FUBhINhCxAkVErEAbNETZojzBhdsHLh6XdFxbrNKmAj2HJPw4OFZZB+zaA88M7t
         Qgqi3/z0lV9oRVHHQrqGDWG4hFL+9IPdayeSRll2o0gcM159BPIeOLL1AwMdxvQb7I
         R0yvDBSWCgjodGCxM4tWDKHc2KTK3+vvb9VELC9k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.168]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1oCECJ10p5-00O6wA; Fri, 20
 May 2022 16:41:08 +0200
Message-ID: <99ffe394-42bb-6c04-b8ab-2d67c38d7756@web.de>
Date:   Fri, 20 May 2022 16:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
 <42e73fb0aaca1f2498ed817c517859103d72d32b.1652984283.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <42e73fb0aaca1f2498ed817c517859103d72d32b.1652984283.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V8ZSdHoqupgG8q2q05yJ8sGHTvEgP4EWoGdRIcTyUKjJwwD1Kx+
 Sq8Ojk1TyWIViBGYNoKfAVEF3cAzP87ZuyHRg0nXsGicihsprNVBQPERTi1jWA9kyp+Mvw4
 pjdlvsrM/dvGIEFHnVpTrsWtU1XwP4/S5rHL+xDFuLMogeLhoCTbFGwtsUVPEgH96M2ez/W
 vEW8hm/3m6uxMhqOAQ15w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i+wt9ey66vI=:omSrav00V1ILJLNkxxhwJY
 ydEAOqcS1aAMcFCKlxL4jvAwUXJXUTAzdaL/m3jV4nRK3U/4Tbow15pMdHtpcsiBmCZ8bHU+L
 j84/ph8sDJeEXoxqb0kjAhViDqGC+roeNpY3/pFMF51ifXHkT0iToKLdRtWiqSdHXOxiOm5LX
 MnuSGgzjo7u6Lf4u/Zgg+6pRlRXoyUDCz8bfM2XUreSNLIEFsL6YBDPL0K8U+t/xcBJidEoeU
 wMO0FTB5hfThaOOJnqbmPwdpGA/EEA/agB1dMpIq45yoE+BYRRsdgil7kgFg5yxRAWvhTG4sV
 YxdOk/RUULgP4jWH4DpWzJ5CUeKSuyyWs/dpewgp9qy2BpyGIxzy+Sks7DD7qENWuJ3yZiRSV
 XbohyPOiEtJn1OJER7u3v59c4V4snxh8mMESbPirSsJEurxlDFB48SVEeC/iD9/QcQvoLvPVJ
 4FRc6nDNRbHD7OprdRqUPuAaJztgklYCutKdS99RdJLRJ7+Arzz383GD35/GOZr+UuTs1fwkV
 Z1Sn1ok8UaFHkGMpXO53egJ2NfVocAEYrJHsdm174Z/8bbA259LKUIddYRS5/9NqcHRdRcmv/
 voerS5m3Vbeheb+IlUjqWudWp9XJuU7TPGjBHVHuMB9qgK2um6jGNdAbapNF9fujlPiwTOZJ/
 TWmlgt81QnnLyxvee6KbBnFI8RIAtczNr6iBmKYeBZO3fzPPxvOo+HQYMBPi3EvOOdDbTBuWi
 I7FS87ZhWRxHSoom8dIbAg5QQRcEdsxUFvZc/7VtT8PLhxTNDHzCjP/cTRj1WSbBksqsJFw1q
 NSJPgniWaI/o1CnbCaEgNHK/j7Rn2j8bwWR0gDs/eBzx/yZ199RK1NtdP6kMeopUIo+MPS5UK
 z4/xPJApQxaHm94WgrhnveIgEdFJgEqdYTvVBfOVRRXnBUiZR4uHiiRKRKC20KRn47yAYJQM2
 0tZVWwa4rY4v59h9RE3k5eQ1WeKJvSp9Od6BrJh3wt+AdYlfGBVPq0d43YAGGORfYYIX4+dRb
 aWbceLwmGflliUK1nKuYOUEXRXICFqF+T5mVEZdgLgegt9w6l1A5BPL88DDuBF+8qoeLkb7WH
 vKSHqgiq7LTuEricY+Q0s43TrsWN4ZA4Dbo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.22 um 20:17 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> With the `--add-file-with-content=3D<path>:<content>` option, `git
            ^^^^^^^^^^^^^^^^^^^^^^^
That's still the old option name.  Same in the subject of patch 2.

> archive` now supports use cases where relatively trivial files need to
> be added that do not exist on disk.
>
> This will allow us to generate `.zip` files with generated content,
> without having to add said content to the object database and without
> having to write it out to disk.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-archive.txt | 11 ++++++++
>  archive.c                     | 53 +++++++++++++++++++++++++++++------
>  t/t5003-archive-zip.sh        | 12 ++++++++
>  3 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.t=
xt
> index bc4e76a7834..893cb1075bf 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -61,6 +61,17 @@ OPTIONS
>  	by concatenating the value for `--prefix` (if any) and the
>  	basename of <file>.
>
> +--add-virtual-file=3D<path>:<content>::
> +	Add the specified contents to the archive.  Can be repeated to add
> +	multiple files.  The path of the file in the archive is built
> +	by concatenating the value for `--prefix` (if any) and the
> +	basename of <file>.
> ++
> +The `<path>` cannot contain any colon, the file mode is limited to
> +a regular file, and the option may be subject to platform-dependent
> +command-line limits. For non-trivial cases, write an untracked file
> +and use `--add-file` instead.
> +
>  --worktree-attributes::
>  	Look for attributes in .gitattributes files in the working tree
>  	as well (see <<ATTRIBUTES>>).
> diff --git a/archive.c b/archive.c
> index a3bbb091256..d20e16fa819 100644
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
> @@ -514,14 +522,40 @@ static int add_file_cb(const struct option *opt, c=
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
> +	if (!strcmp(opt->long_name, "add-file")) {
> +		path =3D prefix_filename(args->prefix, arg);
> +		if (stat(path, &info->stat))
> +			die(_("File not found: %s"), path);
> +		if (!S_ISREG(info->stat.st_mode))
> +			die(_("Not a regular file: %s"), path);
> +		info->content =3D NULL; /* read the file later */
> +	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
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
> +	} else {
> +		BUG("add_file_cb() called for %s", opt->long_name);
> +	}
> +	item =3D string_list_append_nodup(&args->extra_files, path);
> +	item->util =3D info;
> +
>  	return 0;
>  }
>
> @@ -554,6 +588,9 @@ static int parse_archive_args(int argc, const char *=
*argv,
>  		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
>  		  N_("add untracked file to archive"), 0, add_file_cb,
>  		  (intptr_t)&base },
> +		{ OPTION_CALLBACK, 0, "add-virtual-file", args,
> +		  N_("path:content"), N_("add untracked file to archive"), 0,
> +		  add_file_cb, (intptr_t)&base },
>  		OPT_STRING('o', "output", &output, N_("file"),
>  			N_("write the archive to this file")),
>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 1e6d18b140e..ebc26e89a9b 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -206,6 +206,18 @@ test_expect_success 'git archive --format=3Dzip --a=
dd-file' '
>  check_zip with_untracked
>  check_added with_untracked untracked untracked
>
> +test_expect_success UNZIP 'git archive --format=3Dzip --add-virtual-fil=
e' '
> +	git archive --format=3Dzip >with_file_with_content.zip \
> +		--add-virtual-file=3Dhello:world $EMPTY_TREE &&
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
