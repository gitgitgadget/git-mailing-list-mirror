Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94086213E8A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526934; cv=none; b=XHFaWoZGhSLNcfEzbOOkHSGWWFNTFvNqx1599+C7c6B55SMAnuowWhfX9VeWeZ1lm4BTxucExZxDmOF0MUTL1nRHncFKgZ4PZVCRfIdY/77fexlQzQCoWZkmpC8908FY8sPx5pspO8zxF8mxIy2OLQdywxC1ORFGT3B6XQ8AWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526934; c=relaxed/simple;
	bh=esdOh/114VqryXphJiqsWbltf8lfquqrui7etVL3UTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW6r97iKyNwOfDz5xIdCJHVk5Xo05V4SqS99ZrgO9C632KZ+eGmOPeNH6uqzjQE501DiNLRkPtg35cK/kOlHrfcAhJOxjjgkPHxrE1RvREqrHhdFi4tiqWe44vwrqG6JsVt2YoGTr0apUiZFYTVNxPiW+GzkQUOwztpdFWywtXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3PCgYGj; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3PCgYGj"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fc6fe05460so3614633eaf.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526931; x=1741131731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiPZUNEDTjBB3Rebs9veFNb5gzs8ioU4bb3nwC4v6fM=;
        b=T3PCgYGjgElpCNkvK+glUTJuSNM4NnZnpbZx9pV/OGm4krgQP5QOZHEM6QlxdFjH+k
         +TKIC1DzNlTrmXsHeNwd3ub0JP6BqFoCC9HCdBwuFfhSUux2oNS+QMemPiWCSU6Tvjez
         CpP9iCFKx0C8JA9klIhUyznltE5bARprlH5n4OPZr8WbNIrQuOSRh6rxO7YNWf6md1AK
         Zu7nkrivZZB/32IkGAmyZ2Tj1bQD/YADi86SCsnNLFrOJyqPGxIBNibQJC6HQyb/Hqy/
         5FEnR93mSV0PLc0hiaeR+028PBsmnq7gh39SVrj6cd9YqWmG3XzOJgmIpQWx2GcKJMbz
         pp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526931; x=1741131731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiPZUNEDTjBB3Rebs9veFNb5gzs8ioU4bb3nwC4v6fM=;
        b=Tw5JiSMvrRWPmM8ssr9XNkSMiXwXCMgxPUnGpbwZFhH7nVhJgukQtbhDpu1BEp8f/8
         gx796JhsJgTYsjqndULfipRpdW2aRlkdgpxjSIAMOdDTiundUb79j1T39ouPwMOIEMun
         PZ6v6I85UHYZPJYcPmTdmLO3DUP2tY/FHKGZG/VOVxEpXNHR/zon5rJx0lhhqp9ixxxf
         PvSD0u/NxLH13a7PHtZloP65hZrbGhjScbCr4MNVv5GY06jQgRSDezSAlu/NuKr6MDVx
         KG2sKhLrYApDKdaqN8qffGxqgw3ASHbcHer0kB50BJWnfiw/+Z21PSMavWpI37A/IxBu
         APng==
X-Gm-Message-State: AOJu0YzXFfjrJFm/ntybLBU5QjHMR2m1jVJwBejnhBLfmNDCU1nrCGnb
	kT4SvYKgclDl0LlrYHOgcl+9Ra9+3N+ZsUkk9xnJg1VnPANqjxW+SMXlfQ==
X-Gm-Gg: ASbGncta+LGANwHrEYfueXiz8bPeW6neloRAQ+vJPtgmy2QZQqf+CIH3wt8AN/rW2+o
	+OE/BxmGoI4W4e+aexogcdXDR9DIns1u+lVw5gXSPWMXjH5CE5fT/LDNXV463tyn6yZsZywvdFN
	EWX5SIgprQiTa6UvpA58XTCjJlC0iwY4uf9S7/rpkUmENNR0rigcRZPXO9bH7hwi9jqjABPcvcW
	Y43PuveVoH4ff0hwEaCxL7lkCiv0EgrI9DNp6Saq3v5i7yRVNn3rT5+YRXIFsAxb5J8X9R0Gcox
	z5XALyvCqcVixgyGYBg=
X-Google-Smtp-Source: AGHT+IHH47PNYVc2eCOelDZqdG9DFITks4S8NQfGyQnsVIVP3kKoMmHj7Jywk3O1puXwn94mEz1kMw==
X-Received: by 2002:a05:6808:11cc:b0:3f3:d742:c2bd with SMTP id 5614622812f47-3f547df9ba6mr750682b6e.13.1740526931376;
        Tue, 25 Feb 2025 15:42:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f541c4a4fcsm507852b6e.39.2025.02.25.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:42:10 -0800 (PST)
Date: Tue, 25 Feb 2025 17:38:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <4ymki6xozhiuzhbcgighwrw5rl5gt7r5yl4k5xpivb35yl3t67@6ko3l2knsc6q>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <CAOLa=ZR+UFv5+=KH6R9f+JB1GstDNSiv+xohWJuWJAsDyH_DpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR+UFv5+=KH6R9f+JB1GstDNSiv+xohWJuWJAsDyH_DpA@mail.gmail.com>

On 25/02/12 01:51AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Through git-diff(1), a single diff can be generated from a pair of blob
> > revisions directly. Unfortunately, there is not a mechanism to compute
> > batches of specific file pair diffs in a single process. Such a feature
> > is particularly useful on the server-side where diffing between a large
> > set of changes is not feasible all at once due to timeout concerns.
> >
> > To facilitate this, introduce git-diff-pairs(1) which takes the
> > null-terminated raw diff format as input on stdin and produces diffs in
> > other formats. As the raw diff format already contains the necessary
> > metadata, it becomes possible to progressively generate batches of diffs
> > without having to recompute rename detection or retrieve object context.
> > Something like the following:
> >
> > 	git diff-tree -r -z -M $old $new |
> > 	git diff-pairs -p
> >
> > should generate the same output as `git diff-tree -p -M`. Furthermore,
> > each line of raw diff formatted input can also be individually fed to a
> > separate git-diff-pairs(1) process and still produce the same output.
> >
> > Based-on-patch-by: Jeff King <peff@peff.net>
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  .gitignore                        |   1 +
> >  Documentation/git-diff-pairs.adoc |  62 +++++++++++
> >  Documentation/meson.build         |   1 +
> >  Makefile                          |   1 +
> >  builtin.h                         |   1 +
> >  builtin/diff-pairs.c              | 178 ++++++++++++++++++++++++++++++
> >  command-list.txt                  |   1 +
> >  git.c                             |   1 +
> >  meson.build                       |   1 +
> >  t/meson.build                     |   1 +
> >  t/t4070-diff-pairs.sh             |  80 ++++++++++++++
> >  11 files changed, 328 insertions(+)
> >  create mode 100644 Documentation/git-diff-pairs.adoc
> >  create mode 100644 builtin/diff-pairs.c
> >  create mode 100755 t/t4070-diff-pairs.sh
> >
> > diff --git a/.gitignore b/.gitignore
> > index e82aa19df0..03448c076a 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -54,6 +54,7 @@
> >  /git-diff
> >  /git-diff-files
> >  /git-diff-index
> > +/git-diff-pairs
> >  /git-diff-tree
> >  /git-difftool
> >  /git-difftool--helper
> > diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
> > new file mode 100644
> > index 0000000000..e9ef4a6615
> > --- /dev/null
> > +++ b/Documentation/git-diff-pairs.adoc
> > @@ -0,0 +1,62 @@
> > +git-diff-pairs(1)
> > +=================
> > +
> > +NAME
> > +----
> > +git-diff-pairs - Compare blob pairs generated by `diff-tree --raw`
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git diff-pairs' [diff-options]
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Given the output of `diff-tree -z` on its stdin, `diff-pairs` will
> > +reformat that output into whatever format is requested on its command
> > +line.  For example:
> > +
> > +-----------------------------
> > +git diff-tree -z -M $a $b |
> > +git diff-pairs -p
> > +-----------------------------
> > +
> > +will compute the tree diff in one step (including renames), and then
> > +`diff-pairs` will compute and format the blob-level diffs for each pair.
> > +This can be used to modify the raw diff in the middle (without having to
> > +parse or re-create more complicated formats like `--patch`), or to
> > +compute diffs progressively over the course of multiple invocations of
> > +`diff-pairs`.
> > +
> > +Each blob pair is fed to the diff machinery individually queued and the output
> > +is flushed on stdin EOF.
> 
> I found this hard to understand.
> 
> After reading below, perhaps it would be easier to understand something
> simpler which doesn't mention the internal queuing mechanism and only
> talks about how the output is only steamed once we read EOF on stdin.

I've reworked the documentation in the next version to avoid discussing
internal details and stick to discussing user facing behavior.

> > +
> > +OPTIONS
> > +-------
> > +
> > +include::diff-options.adoc[]
> > +
> > +include::diff-generate-patch.adoc[]
> > +
> > +NOTES
> > +----
> > +
> > +`diff-pairs` should handle any input generated by `diff-tree --raw -z`.
> > +It may choke or otherwise misbehave on output from `diff-files`, etc.
> > +
> > +Here's an incomplete list of things that `diff-pairs` could do, but
> > +doesn't (mostly in the name of simplicity):
> > +
> > + - Only `-z` input is accepted, not normal `--raw` input.
> > +
> > + - Abbreviated sha1s are rejected in the input from `diff-tree`; if you
> > +   want to abbreviate the output, you can pass `--abbrev` to
> > +   `diff-pairs`.
> > +
> > + - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
> > +   the initial `diff-tree` invocation.
> > +
> > +GIT
> > +---
> > +Part of the linkgit:git[1] suite
> > diff --git a/Documentation/meson.build b/Documentation/meson.build
> > index ead8e48213..e5ee177022 100644
> > --- a/Documentation/meson.build
> > +++ b/Documentation/meson.build
> > @@ -41,6 +41,7 @@ manpages = {
> >    'git-diagnose.adoc' : 1,
> >    'git-diff-files.adoc' : 1,
> >    'git-diff-index.adoc' : 1,
> > +  'git-diff-pairs.adoc' : 1,
> >    'git-difftool.adoc' : 1,
> >    'git-diff-tree.adoc' : 1,
> >    'git-diff.adoc' : 1,
> > diff --git a/Makefile b/Makefile
> > index 896d02339e..3b8e1ad15e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1232,6 +1232,7 @@ BUILTIN_OBJS += builtin/describe.o
> >  BUILTIN_OBJS += builtin/diagnose.o
> >  BUILTIN_OBJS += builtin/diff-files.o
> >  BUILTIN_OBJS += builtin/diff-index.o
> > +BUILTIN_OBJS += builtin/diff-pairs.o
> >  BUILTIN_OBJS += builtin/diff-tree.o
> >  BUILTIN_OBJS += builtin/diff.o
> >  BUILTIN_OBJS += builtin/difftool.o
> > diff --git a/builtin.h b/builtin.h
> > index f7b166b334..b2d2e9eb07 100644
> > --- a/builtin.h
> > +++ b/builtin.h
> > @@ -152,6 +152,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix, struct reposit
> >  int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
> >  int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
> >  int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
> > +int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
> >  int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
> >  int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
> >  int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
> > diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> > new file mode 100644
> > index 0000000000..08f3ee81e5
> > --- /dev/null
> > +++ b/builtin/diff-pairs.c
> > @@ -0,0 +1,178 @@
> > +#include "builtin.h"
> > +#include "commit.h"
> > +#include "config.h"
> > +#include "diff.h"
> > +#include "diffcore.h"
> > +#include "gettext.h"
> > +#include "hex.h"
> > +#include "object.h"
> > +#include "parse-options.h"
> > +#include "revision.h"
> > +#include "strbuf.h"
> > +
> > +static unsigned parse_mode_or_die(const char *mode, const char **endp)
> > +{
> > +	uint16_t ret;
> > +
> > +	*endp = parse_mode(mode, &ret);
> > +	if (!*endp)
> > +		die("unable to parse mode: %s", mode);
> > +	return ret;
> > +}
> > +
> > +static void parse_oid(const char *p, struct object_id *oid, const char **endp,
> > +		      const struct git_hash_algo *algop)
> 
> Nit: similar to the function above, should this be called
> `parse_oid_or_die`?

Being consistent here is probably preferable, I've updated per your
suggestion in the next version.

> > +{
> > +	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
> > +		die("unable to parse object id: %s", p);
> > +}
> > +
> > +static unsigned short parse_score(const char *score)
> > +{
> > +	unsigned long ret;
> > +	char *endp;
> > +
> > +	errno = 0;
> > +	ret = strtoul(score, &endp, 10);
> > +	ret *= MAX_SCORE / 100;
> > +	if (errno || endp == score || *endp || (unsigned short)ret != ret)
> > +		die("unable to parse rename/copy score: %s", score);
> > +	return ret;
> > +}
> > +
> > +static void flush_diff_queue(struct diff_options *options)
> > +{
> > +	/*
> > +	 * If rename detection is not requested, use rename information from the
> > +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> > +	 * does not mess with rename information already present in queued
> > +	 * filepairs.
> > +	 */
> > +	if (!options->detect_rename)
> > +		options->found_follow = 1;
> > +	diffcore_std(options);
> > +	diff_flush(options);
> > +}
> > +
> > +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> > +		   struct repository *repo)
> > +{
> > +	struct strbuf path_dst = STRBUF_INIT;
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct strbuf meta = STRBUF_INIT;
> > +	struct rev_info revs;
> > +	int ret;
> > +
> > +	const char * const usage[] = {
> > +		N_("git diff-pairs [diff-options]"),
> > +		NULL
> > +	};
> > +	struct option options[] = {
> > +		OPT_END()
> > +	};
> > +
> > +	show_usage_with_options_if_asked(argc, argv, usage, options);
> > +
> > +	repo_nit_revisions(repo, &revs, prefix);
> > +	repo_config(repo, git_diff_basic_config, NULL);
> > +	revs.disable_stdin = 1;
> > +	revs.abbrev = 0;
> > +	revs.diff = 1;
> > +
> > +	argc = setup_revisions(argc, argv, &revs, NULL);
> > +
> > +	/* Don't allow pathspecs at all. */
> > +	if (revs.prune_data.nr)
> > +		usage_with_options(usage, options);
> > +
> > +	if (!revs.diffopt.output_format)
> > +		revs.diffopt.output_format = DIFF_FORMAT_RAW;
> > +
> > +	while (1) {
> > +		struct object_id oid_a, oid_b;
> > +		struct diff_filepair *pair;
> > +		unsigned mode_a, mode_b;
> > +		const char *p;
> > +		char status;
> > +
> > +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> > +			break;
> > +
> > +		p = meta.buf;
> > +		if (*p != ':')
> > +			die("invalid raw diff input");
> > +		p++;
> > +
> > +		mode_a = parse_mode_or_die(p, &p);
> > +		mode_b = parse_mode_or_die(p, &p);
> > +
> > +		parse_oid(p, &oid_a, &p, repo->hash_algo);
> > +		parse_oid(p, &oid_b, &p, repo->hash_algo);
> > +
> > +		status = *p++;
> > +
> > +		if (strbuf_getline_nul(&path, stdin) == EOF)
> > +			die("got EOF while reading path");
> > +
> > +		switch (status) {
> > +		case DIFF_STATUS_ADDED:
> > +			pair = diff_filepair_addremove(&revs.diffopt, '+',
> > +						       mode_b, &oid_b,
> > +						       1, path.buf, 0);
> > +			if (pair)
> > +				pair->status = status;
> > +			break;
> > +
> > +		case DIFF_STATUS_DELETED:
> > +			pair = diff_filepair_addremove(&revs.diffopt, '-',
> > +						       mode_a, &oid_a,
> > +						       1, path.buf, 0);
> > +			if (pair)
> > +				pair->status = status;
> > +			break;
> > +
> > +		case DIFF_STATUS_TYPE_CHANGED:
> > +		case DIFF_STATUS_MODIFIED:
> > +			pair = diff_filepair_change(&revs.diffopt,
> > +						    mode_a, mode_b,
> > +						    &oid_a, &oid_b, 1, 1,
> > +						    path.buf, 0, 0);
> > +			if (pair)
> > +				pair->status = status;
> > +			break;
> > +
> > +		case DIFF_STATUS_RENAMED:
> > +		case DIFF_STATUS_COPIED:
> > +			{
> > +				struct diff_filespec *a, *b;
> > +
> > +				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
> > +					die("got EOF while reading destination path");
> > +
> > +				a = alloc_filespec(path.buf);
> > +				b = alloc_filespec(path_dst.buf);
> > +				fill_filespec(a, &oid_a, 1, mode_a);
> > +				fill_filespec(b, &oid_b, 1, mode_b);
> > +
> > +				pair = diff_queue(&diff_queued_diff, a, b);
> > +				pair->status = status;
> > +				pair->score = parse_score(p);
> > +				pair->renamed_pair = 1;
> > +			}
> > +			break;
> > +
> > +		default:
> 
> The only state I think is missing is `DIFF_STATUS_UNMERGED` (from
> 'diff.h'). Is that a state we need to handle?

The `DIFF_STATUS_UNMERGED` status is present when there are unmerged
conflicted files in the working tree that have not been added to the
index. I think this is a scenario where git-diff-pairs(1) would not make
much sense, especially if there is no working tree present for a
repository. It should be fine to leave this status unhandled for now as
it just fallback to the default case and dies.

> > +			die("unknown diff status: %c", status);
> > +		}
> > +	}
> > +
> > +	flush_diff_queue(&revs.diffopt);
> 
> Now I understand what you meant by queuing the diffs.
> 
> > +	ret = diff_result_code(&revs);
> > +
> > +	strbuf_release(&path_dst);
> > +	strbuf_release(&path);
> > +	strbuf_release(&meta);
> > +	release_revisions(&revs);
> > +
> > +	return ret;
> > +}
> > diff --git a/command-list.txt b/command-list.txt
> > index e0bb87b3b5..bb8acd51d8 100644
> > --- a/command-list.txt
> > +++ b/command-list.txt
> > @@ -95,6 +95,7 @@ git-diagnose                            ancillaryinterrogators
> >  git-diff                                mainporcelain           info
> >  git-diff-files                          plumbinginterrogators
> >  git-diff-index                          plumbinginterrogators
> > +git-diff-pairs                          plumbinginterrogators
> >  git-diff-tree                           plumbinginterrogators
> >  git-difftool                            ancillaryinterrogators          complete
> >  git-fast-export                         ancillarymanipulators
> > diff --git a/git.c b/git.c
> > index b23761480f..12bba872bb 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -540,6 +540,7 @@ static struct cmd_struct commands[] = {
> >  	{ "diff", cmd_diff, NO_PARSEOPT },
> >  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> >  	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
> > +	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
> >  	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
> >  	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
> >  	{ "fast-export", cmd_fast_export, RUN_SETUP },
> > diff --git a/meson.build b/meson.build
> > index fbb8105d96..66ce3326e8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -537,6 +537,7 @@ builtin_sources = [
> >    'builtin/diagnose.c',
> >    'builtin/diff-files.c',
> >    'builtin/diff-index.c',
> > +  'builtin/diff-pairs.c',
> >    'builtin/diff-tree.c',
> >    'builtin/diff.c',
> >    'builtin/difftool.c',
> > diff --git a/t/meson.build b/t/meson.build
> > index 4574280590..7ff17c6d29 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -500,6 +500,7 @@ integration_tests = [
> >    't4067-diff-partial-clone.sh',
> >    't4068-diff-symmetric-merge-base.sh',
> >    't4069-remerge-diff.sh',
> > +  't4070-diff-pairs.sh',
> >    't4100-apply-stat.sh',
> >    't4101-apply-nonl.sh',
> >    't4102-apply-rename.sh',
> > diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> > new file mode 100755
> > index 0000000000..e0a8e6f0a0
> > --- /dev/null
> > +++ b/t/t4070-diff-pairs.sh
> > @@ -0,0 +1,80 @@
> > +#!/bin/sh
> > +
> > +test_description='basic diff-pairs tests'
> > +. ./test-lib.sh
> > +
> > +# This creates a diff with added, modified, deleted, renamed, copied, and
> > +# typechange entries. That includes one in a subdirectory for non-recursive
> > +# tests, and both exact and inexact similarity scores.
> > +test_expect_success 'create commit with various diffs' '
> 
> Generally, tests for setup are named 'setup' so we can do something
> like:
>   sh ./t0050-filesystem.sh --run=setup,9-11
> 
> Can we renmae this to 'setup'?
> 

Good suggestion, I've updated.

> > +	echo to-be-gone >deleted &&
> > +	echo original >modified &&
> > +	echo now-a-file >symlink &&
> > +	test_seq 200 >two-hundred &&
> > +	test_seq 201 500 >five-hundred &&
> > +	git add . &&
> > +	test_tick &&
> > +	git commit -m base &&
> > +	git tag base &&
> > +
> > +	echo now-here >added &&
> > +	echo new >modified &&
> > +	rm deleted &&
> > +	mkdir subdir &&
> > +	echo content >subdir/file &&
> > +	mv two-hundred renamed &&
> > +	test_seq 201 500 | sed s/300/modified/ >copied &&
> > +	rm symlink &&
> > +	git add -A . &&
> > +	test_ln_s_add dest symlink &&
> > +	test_tick &&
> > +	git commit -m new &&
> > +	git tag new
> > +'
> > +
> > +test_expect_success 'diff-pairs recreates --raw' '
> > +	git diff-tree -r -M -C -C base new >expect &&
> > +	git diff-tree -r -M -C -C -z base new |
> > +	git diff-pairs >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'diff-pairs can create -p output' '
> > +	git diff-tree -p -M -C -C base new >expect &&
> > +	git diff-tree -r -M -C -C -z base new |
> > +	git diff-pairs -p >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'non-recursive --raw retains tree entry' '
> > +	git diff-tree base new >expect &&
> > +	git diff-tree -z base new |
> > +	git diff-pairs >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'split input across multiple diff-pairs' '
> > +	write_script split-raw-diff "$PERL_PATH" <<-\EOF &&
> > +	$/ = "\0";
> > +	while (<>) {
> > +	  my $meta = $_;
> > +	  my $path = <>;
> > +	  # renames have an extra path
> > +	  my $path2 = <> if $meta =~ /[RC]\d+/;
> > +
> > +	  open(my $fh, ">", sprintf "diff%03d", $.);
> > +	  print $fh $meta, $path, $path2;
> > +	}
> > +	EOF
> > +
> > +	git diff-tree -p -M -C -C base new >expect &&
> > +
> > +	git diff-tree -r -z -M -C -C base new |
> > +	./split-raw-diff &&
> > +	for i in diff*; do
> > +		git diff-pairs -p <$i || return 1
> > +	done >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_done
> > --
> > 2.48.1


