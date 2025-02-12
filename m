Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E29206F10
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353902; cv=none; b=PhiQmsNu/TzaKhG8SUU0Y6nIKT8WYrEnTP2ZahPKCS37EgJJ7IZyzzi2qhj0oLa7/MvFbSszY7BxHCi5G5vIafayMj9vNCbRf1FfhTbUpFHdeodPnub8VZKW7UJF6uwO8fkeCTCKROM2OGZJwJ1MrIWTSrHdi4aMLmXq32wD2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353902; c=relaxed/simple;
	bh=LJLYNzReEi7sjKbmfYCpKcYQFp48fHDmFesHbPiUi7k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vde4fWGeyK0dcT8Ny/pYwugn0Pqgk/NmvMGOADcX2qnEnrBFNuVPRrmC8/MnXluUoxGRrpKgWsVkVmZyLxx2T0Nwsvx7ZBrhs/A0tZGf2vTlTfzjLklhinTkbE7siYsLrjITisli+pab5yTwh/Y7IZtu5GydcHfMAN8jVylhqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngeGJwsk; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngeGJwsk"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso3957571e0c.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 01:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739353899; x=1739958699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Rospv4PIIUWP5kt3J6En09fp6zEHCchcl8SP4fG24=;
        b=ngeGJwskoaN+nG2+XoGBuwrfdLajuULO5MZ7sHhZmVySGLIsj0Eu5Tj5eqqWyIHAoB
         qQXW33QSUYItd6x8nLNyErVyNo/ebJM3d/yp5Az+3mV7VIQBlSktxRgA9dH5YFdUOQg3
         kbDFmiXcrXsO8/QZ0e2Gvw8A2e/9ucVamyGKDfefkRmOlPqokVk/cr9t3m/WNZH/E5xO
         vOTRUJVkVcfJF6Rg7aATgo3r3SjLSYk0gfOLF0RB1nZ0aZuoUduZwm9YsBFzljm3DCM/
         lJPTNBcMDLUJcRVed7xekjKq97cO+S01Pv/ZsL9MGqkD08tePqtZCxBAe4fSmH3CgHXd
         +xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353899; x=1739958699;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Rospv4PIIUWP5kt3J6En09fp6zEHCchcl8SP4fG24=;
        b=wr9HeI1ICJ/t2jqgwtXLI3oiqVOkysdEfoujw7sOehcf6FaUEMPW17uMYo1KJTJaUC
         d/9dupgCKo7NIW7BmSp3A+2nXJOKpdj0rjErPKcgXSwsQk5eI+JBGGBNheOrxqFY//+H
         TEWgxbJM7TLa4BqbFYB3Es64hf1yVp+dkkAjnipdkP0zaW9hEn2DWMBmlPe4RKyp4ZqP
         LNsNfvyzbl+jSfnqlIexbaFyi0GXtcD+qhbpK+3I5gSG8d96F6VA+XKTBZ0i799Z0MdS
         kOnFmC2icukS6wg3vyVi06jTMaxv1XKqpwYqRXWhO/mszZ4FEybt9iQpElek9d4gN3uP
         r+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUT726BJ1l8lnf40f8vPJMHK5T0uG/j8awivNuzzvKuFtQGxRDn1uSjPYGu242ffLq4HBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc6KBZboVF9JlpfnYNbK87B5gaQWDHwzT2jkx2ApK7G6VtaaT
	rJBWvRJQlSyC2T0IyXA0xdXmHufMjh2dQVptMnDsxxFlbHA38QcLc0hzhTm+H6DI7KKu/zbqiVF
	Dm4otNcQPu0vVPIb8epeCdzdNdZQ=
X-Gm-Gg: ASbGncskXjSvabkHCWH1Dkpbwm/bJrs4q8lFkkPTLyxidDspDhF64iqhbfR0YuQadnL
	shX7aAn47iN04PP1WHqcn8Bz7ONUZ8fnCcrHjzS98yxntC5qbKU8yt5p2dYOcCoO7x0Wgpzh09a
	6CRpScNhlQrYGnBdjw6KoBaC2UcqdffAk=
X-Google-Smtp-Source: AGHT+IElMjSK9sUCqogElbE1utCM5lf6pZSE/Vul+LC6qWm6IGvwoE9fPpAJrBsuPviNiLfylSqsb2Jp4vKw75JJGNY=
X-Received: by 2002:a05:6122:16a2:b0:520:6773:e5ba with SMTP id
 71dfb90a1353d-52067b2abdemr1860057e0c.2.1739353899135; Wed, 12 Feb 2025
 01:51:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 01:51:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250212041825.2455031-3-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com> <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 01:51:38 -0800
X-Gm-Features: AWEUYZmAvpYzxzAqXY51L0E1C3ZfaneFeNjtIA6m5apEgDizQs7C-vtrQa0DOIs
Message-ID: <CAOLa=ZR+UFv5+=KH6R9f+JB1GstDNSiv+xohWJuWJAsDyH_DpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000004c188b062deee391"

--0000000000004c188b062deee391
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Through git-diff(1), a single diff can be generated from a pair of blob
> revisions directly. Unfortunately, there is not a mechanism to compute
> batches of specific file pair diffs in a single process. Such a feature
> is particularly useful on the server-side where diffing between a large
> set of changes is not feasible all at once due to timeout concerns.
>
> To facilitate this, introduce git-diff-pairs(1) which takes the
> null-terminated raw diff format as input on stdin and produces diffs in
> other formats. As the raw diff format already contains the necessary
> metadata, it becomes possible to progressively generate batches of diffs
> without having to recompute rename detection or retrieve object context.
> Something like the following:
>
> 	git diff-tree -r -z -M $old $new |
> 	git diff-pairs -p
>
> should generate the same output as `git diff-tree -p -M`. Furthermore,
> each line of raw diff formatted input can also be individually fed to a
> separate git-diff-pairs(1) process and still produce the same output.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  .gitignore                        |   1 +
>  Documentation/git-diff-pairs.adoc |  62 +++++++++++
>  Documentation/meson.build         |   1 +
>  Makefile                          |   1 +
>  builtin.h                         |   1 +
>  builtin/diff-pairs.c              | 178 ++++++++++++++++++++++++++++++
>  command-list.txt                  |   1 +
>  git.c                             |   1 +
>  meson.build                       |   1 +
>  t/meson.build                     |   1 +
>  t/t4070-diff-pairs.sh             |  80 ++++++++++++++
>  11 files changed, 328 insertions(+)
>  create mode 100644 Documentation/git-diff-pairs.adoc
>  create mode 100644 builtin/diff-pairs.c
>  create mode 100755 t/t4070-diff-pairs.sh
>
> diff --git a/.gitignore b/.gitignore
> index e82aa19df0..03448c076a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -54,6 +54,7 @@
>  /git-diff
>  /git-diff-files
>  /git-diff-index
> +/git-diff-pairs
>  /git-diff-tree
>  /git-difftool
>  /git-difftool--helper
> diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
> new file mode 100644
> index 0000000000..e9ef4a6615
> --- /dev/null
> +++ b/Documentation/git-diff-pairs.adoc
> @@ -0,0 +1,62 @@
> +git-diff-pairs(1)
> +=================
> +
> +NAME
> +----
> +git-diff-pairs - Compare blob pairs generated by `diff-tree --raw`
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git diff-pairs' [diff-options]
> +
> +DESCRIPTION
> +-----------
> +
> +Given the output of `diff-tree -z` on its stdin, `diff-pairs` will
> +reformat that output into whatever format is requested on its command
> +line.  For example:
> +
> +-----------------------------
> +git diff-tree -z -M $a $b |
> +git diff-pairs -p
> +-----------------------------
> +
> +will compute the tree diff in one step (including renames), and then
> +`diff-pairs` will compute and format the blob-level diffs for each pair.
> +This can be used to modify the raw diff in the middle (without having to
> +parse or re-create more complicated formats like `--patch`), or to
> +compute diffs progressively over the course of multiple invocations of
> +`diff-pairs`.
> +
> +Each blob pair is fed to the diff machinery individually queued and the output
> +is flushed on stdin EOF.

I found this hard to understand.

After reading below, perhaps it would be easier to understand something
simpler which doesn't mention the internal queuing mechanism and only
talks about how the output is only steamed once we read EOF on stdin.

> +
> +OPTIONS
> +-------
> +
> +include::diff-options.adoc[]
> +
> +include::diff-generate-patch.adoc[]
> +
> +NOTES
> +----
> +
> +`diff-pairs` should handle any input generated by `diff-tree --raw -z`.
> +It may choke or otherwise misbehave on output from `diff-files`, etc.
> +
> +Here's an incomplete list of things that `diff-pairs` could do, but
> +doesn't (mostly in the name of simplicity):
> +
> + - Only `-z` input is accepted, not normal `--raw` input.
> +
> + - Abbreviated sha1s are rejected in the input from `diff-tree`; if you
> +   want to abbreviate the output, you can pass `--abbrev` to
> +   `diff-pairs`.
> +
> + - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
> +   the initial `diff-tree` invocation.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index ead8e48213..e5ee177022 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -41,6 +41,7 @@ manpages = {
>    'git-diagnose.adoc' : 1,
>    'git-diff-files.adoc' : 1,
>    'git-diff-index.adoc' : 1,
> +  'git-diff-pairs.adoc' : 1,
>    'git-difftool.adoc' : 1,
>    'git-diff-tree.adoc' : 1,
>    'git-diff.adoc' : 1,
> diff --git a/Makefile b/Makefile
> index 896d02339e..3b8e1ad15e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1232,6 +1232,7 @@ BUILTIN_OBJS += builtin/describe.o
>  BUILTIN_OBJS += builtin/diagnose.o
>  BUILTIN_OBJS += builtin/diff-files.o
>  BUILTIN_OBJS += builtin/diff-index.o
> +BUILTIN_OBJS += builtin/diff-pairs.o
>  BUILTIN_OBJS += builtin/diff-tree.o
>  BUILTIN_OBJS += builtin/diff.o
>  BUILTIN_OBJS += builtin/difftool.o
> diff --git a/builtin.h b/builtin.h
> index f7b166b334..b2d2e9eb07 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -152,6 +152,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix, struct reposit
>  int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> new file mode 100644
> index 0000000000..08f3ee81e5
> --- /dev/null
> +++ b/builtin/diff-pairs.c
> @@ -0,0 +1,178 @@
> +#include "builtin.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "object.h"
> +#include "parse-options.h"
> +#include "revision.h"
> +#include "strbuf.h"
> +
> +static unsigned parse_mode_or_die(const char *mode, const char **endp)
> +{
> +	uint16_t ret;
> +
> +	*endp = parse_mode(mode, &ret);
> +	if (!*endp)
> +		die("unable to parse mode: %s", mode);
> +	return ret;
> +}
> +
> +static void parse_oid(const char *p, struct object_id *oid, const char **endp,
> +		      const struct git_hash_algo *algop)

Nit: similar to the function above, should this be called
`parse_oid_or_die`?

> +{
> +	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
> +		die("unable to parse object id: %s", p);
> +}
> +
> +static unsigned short parse_score(const char *score)
> +{
> +	unsigned long ret;
> +	char *endp;
> +
> +	errno = 0;
> +	ret = strtoul(score, &endp, 10);
> +	ret *= MAX_SCORE / 100;
> +	if (errno || endp == score || *endp || (unsigned short)ret != ret)
> +		die("unable to parse rename/copy score: %s", score);
> +	return ret;
> +}
> +
> +static void flush_diff_queue(struct diff_options *options)
> +{
> +	/*
> +	 * If rename detection is not requested, use rename information from the
> +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> +	 * does not mess with rename information already present in queued
> +	 * filepairs.
> +	 */
> +	if (!options->detect_rename)
> +		options->found_follow = 1;
> +	diffcore_std(options);
> +	diff_flush(options);
> +}
> +
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct strbuf path_dst = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf meta = STRBUF_INIT;
> +	struct rev_info revs;
> +	int ret;
> +
> +	const char * const usage[] = {
> +		N_("git diff-pairs [diff-options]"),
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	show_usage_with_options_if_asked(argc, argv, usage, options);
> +
> +	repo_nit_revisions(repo, &revs, prefix);
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	argc = setup_revisions(argc, argv, &revs, NULL);
> +
> +	/* Don't allow pathspecs at all. */
> +	if (revs.prune_data.nr)
> +		usage_with_options(usage, options);
> +
> +	if (!revs.diffopt.output_format)
> +		revs.diffopt.output_format = DIFF_FORMAT_RAW;
> +
> +	while (1) {
> +		struct object_id oid_a, oid_b;
> +		struct diff_filepair *pair;
> +		unsigned mode_a, mode_b;
> +		const char *p;
> +		char status;
> +
> +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> +			break;
> +
> +		p = meta.buf;
> +		if (*p != ':')
> +			die("invalid raw diff input");
> +		p++;
> +
> +		mode_a = parse_mode_or_die(p, &p);
> +		mode_b = parse_mode_or_die(p, &p);
> +
> +		parse_oid(p, &oid_a, &p, repo->hash_algo);
> +		parse_oid(p, &oid_b, &p, repo->hash_algo);
> +
> +		status = *p++;
> +
> +		if (strbuf_getline_nul(&path, stdin) == EOF)
> +			die("got EOF while reading path");
> +
> +		switch (status) {
> +		case DIFF_STATUS_ADDED:
> +			pair = diff_filepair_addremove(&revs.diffopt, '+',
> +						       mode_b, &oid_b,
> +						       1, path.buf, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_DELETED:
> +			pair = diff_filepair_addremove(&revs.diffopt, '-',
> +						       mode_a, &oid_a,
> +						       1, path.buf, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_TYPE_CHANGED:
> +		case DIFF_STATUS_MODIFIED:
> +			pair = diff_filepair_change(&revs.diffopt,
> +						    mode_a, mode_b,
> +						    &oid_a, &oid_b, 1, 1,
> +						    path.buf, 0, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> +
> +		case DIFF_STATUS_RENAMED:
> +		case DIFF_STATUS_COPIED:
> +			{
> +				struct diff_filespec *a, *b;
> +
> +				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
> +					die("got EOF while reading destination path");
> +
> +				a = alloc_filespec(path.buf);
> +				b = alloc_filespec(path_dst.buf);
> +				fill_filespec(a, &oid_a, 1, mode_a);
> +				fill_filespec(b, &oid_b, 1, mode_b);
> +
> +				pair = diff_queue(&diff_queued_diff, a, b);
> +				pair->status = status;
> +				pair->score = parse_score(p);
> +				pair->renamed_pair = 1;
> +			}
> +			break;
> +
> +		default:

The only state I think is missing is `DIFF_STATUS_UNMERGED` (from
'diff.h'). Is that a state we need to handle?

> +			die("unknown diff status: %c", status);
> +		}
> +	}
> +
> +	flush_diff_queue(&revs.diffopt);

Now I understand what you meant by queuing the diffs.

> +	ret = diff_result_code(&revs);
> +
> +	strbuf_release(&path_dst);
> +	strbuf_release(&path);
> +	strbuf_release(&meta);
> +	release_revisions(&revs);
> +
> +	return ret;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index e0bb87b3b5..bb8acd51d8 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -95,6 +95,7 @@ git-diagnose                            ancillaryinterrogators
>  git-diff                                mainporcelain           info
>  git-diff-files                          plumbinginterrogators
>  git-diff-index                          plumbinginterrogators
> +git-diff-pairs                          plumbinginterrogators
>  git-diff-tree                           plumbinginterrogators
>  git-difftool                            ancillaryinterrogators          complete
>  git-fast-export                         ancillarymanipulators
> diff --git a/git.c b/git.c
> index b23761480f..12bba872bb 100644
> --- a/git.c
> +++ b/git.c
> @@ -540,6 +540,7 @@ static struct cmd_struct commands[] = {
>  	{ "diff", cmd_diff, NO_PARSEOPT },
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
> +	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
>  	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
>  	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
>  	{ "fast-export", cmd_fast_export, RUN_SETUP },
> diff --git a/meson.build b/meson.build
> index fbb8105d96..66ce3326e8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -537,6 +537,7 @@ builtin_sources = [
>    'builtin/diagnose.c',
>    'builtin/diff-files.c',
>    'builtin/diff-index.c',
> +  'builtin/diff-pairs.c',
>    'builtin/diff-tree.c',
>    'builtin/diff.c',
>    'builtin/difftool.c',
> diff --git a/t/meson.build b/t/meson.build
> index 4574280590..7ff17c6d29 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -500,6 +500,7 @@ integration_tests = [
>    't4067-diff-partial-clone.sh',
>    't4068-diff-symmetric-merge-base.sh',
>    't4069-remerge-diff.sh',
> +  't4070-diff-pairs.sh',
>    't4100-apply-stat.sh',
>    't4101-apply-nonl.sh',
>    't4102-apply-rename.sh',
> diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> new file mode 100755
> index 0000000000..e0a8e6f0a0
> --- /dev/null
> +++ b/t/t4070-diff-pairs.sh
> @@ -0,0 +1,80 @@
> +#!/bin/sh
> +
> +test_description='basic diff-pairs tests'
> +. ./test-lib.sh
> +
> +# This creates a diff with added, modified, deleted, renamed, copied, and
> +# typechange entries. That includes one in a subdirectory for non-recursive
> +# tests, and both exact and inexact similarity scores.
> +test_expect_success 'create commit with various diffs' '

Generally, tests for setup are named 'setup' so we can do something
like:
  sh ./t0050-filesystem.sh --run=setup,9-11

Can we renmae this to 'setup'?

> +	echo to-be-gone >deleted &&
> +	echo original >modified &&
> +	echo now-a-file >symlink &&
> +	test_seq 200 >two-hundred &&
> +	test_seq 201 500 >five-hundred &&
> +	git add . &&
> +	test_tick &&
> +	git commit -m base &&
> +	git tag base &&
> +
> +	echo now-here >added &&
> +	echo new >modified &&
> +	rm deleted &&
> +	mkdir subdir &&
> +	echo content >subdir/file &&
> +	mv two-hundred renamed &&
> +	test_seq 201 500 | sed s/300/modified/ >copied &&
> +	rm symlink &&
> +	git add -A . &&
> +	test_ln_s_add dest symlink &&
> +	test_tick &&
> +	git commit -m new &&
> +	git tag new
> +'
> +
> +test_expect_success 'diff-pairs recreates --raw' '
> +	git diff-tree -r -M -C -C base new >expect &&
> +	git diff-tree -r -M -C -C -z base new |
> +	git diff-pairs >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'diff-pairs can create -p output' '
> +	git diff-tree -p -M -C -C base new >expect &&
> +	git diff-tree -r -M -C -C -z base new |
> +	git diff-pairs -p >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'non-recursive --raw retains tree entry' '
> +	git diff-tree base new >expect &&
> +	git diff-tree -z base new |
> +	git diff-pairs >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'split input across multiple diff-pairs' '
> +	write_script split-raw-diff "$PERL_PATH" <<-\EOF &&
> +	$/ = "\0";
> +	while (<>) {
> +	  my $meta = $_;
> +	  my $path = <>;
> +	  # renames have an extra path
> +	  my $path2 = <> if $meta =~ /[RC]\d+/;
> +
> +	  open(my $fh, ">", sprintf "diff%03d", $.);
> +	  print $fh $meta, $path, $path2;
> +	}
> +	EOF
> +
> +	git diff-tree -p -M -C -C base new >expect &&
> +
> +	git diff-tree -r -z -M -C -C base new |
> +	./split-raw-diff &&
> +	for i in diff*; do
> +		git diff-pairs -p <$i || return 1
> +	done >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> --
> 2.48.1

--0000000000004c188b062deee391
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f4b007e6e7a78ac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lc2J5Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVNOQy85aEZQdkJ4cEtWQldXTll4aHgrWHBzN2J4bAoxbktiWlM1elNB
SWtNRUdKaWh6TmZNTGFmUHI3aTFoL3NzODFwMlR6UVkrVytKSTlDbDFGVzlUTVhFUS9wMmJ0CjhV
S1h3ZGJxYW5lMmxJTnVrQkpSa2NPNXhJOENvYmhIbm90WlJUdmg0bVpMRWxUbW9JYmpoU3lrajY4
WEE0Q04KTGlzSGpZKzFGTTdsK0pOMkwzejVOd283NEk4cDRqSTh0c1lra1N0dkdWTUpFaURHNVBD
RlplWHZua2pKb0wveApRY21rUVRCYkpaVDV0R1lwYUExcGdJZ1Z0ZW9yVHpLN2F6dGlaUWdFZlRJ
bGhRV1V1T3JUMytHUUZNNFczdlNxCkdhcmU1Y0I0blVSV3F3Yk5PNlpqVkZOWXgvVk5WK05WR1hT
cGZrWDhyUDVQWDN3djZlL3RKRTBxL1QvSy9kOGYKbUs5MVQ2Wk52UjN2QkFyOUIxbW9XWE9NSzM1
alJ2YkN5LzZpNnRoTzR1WjNHSmNLcnJyTThpVVVuT0FSRnowZwpaczR3TUxFL0JoT2RQWGJkY29k
RXZOWmtzVWlpcWN2Qzd3b1pmTGhjM1ozU2NvQkhzY2hJWXptaDZWTW9sUzZECkZWY0o2OFk0aTdY
MndZNXpPUU1NbWRid2VyOG5MczdMdnYyd000MD0KPUpSRDkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c188b062deee391--
