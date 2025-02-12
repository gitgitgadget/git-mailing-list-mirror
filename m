Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45B205E28
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352230; cv=none; b=XjoZn8/ZxkiLewcAiIErln2Qi9Flb1PoymNqzx9KCC9l6BwOGF2/fvlE6JagvLGYrlfSWHryHtCj9YXhdxKQWsVrmD7C5vgBr7CkVBZdKlEtps6E58g86cUacVg9dj/L5yxN7jMFRXEqH3Zab5NTYmQi6h8lXTk8HTtPDo8UcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352230; c=relaxed/simple;
	bh=4rHgSDc/eQiweaYNXEbt2XVGgibWHAjSfXLkCuVV7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4OFOP2rFcSujARR3x2RfHsmQq0drimmDWxgsYxIxvBuY4s+F9jy+qdFK/wqCEbyKmYeBbjJLZ+WlG2u80juz9hic8CF3HtCgtoyV5qHIWPOvQ4RpOlRxnT14X9DRIaxmTaHc38C5B6CJhNR+5RFKhWftd8889BdWPeH9dzBVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hCczUnDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5fQxZNn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hCczUnDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5fQxZNn"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FD4013809C6;
	Wed, 12 Feb 2025 04:23:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 12 Feb 2025 04:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739352227; x=1739438627; bh=tcwqdVZJfy
	bjSyKvGXw0E6lQGQITaPfAX2E+KmSZGug=; b=hCczUnDRnr1nu4hbsa0LbnUcxd
	GQeIy2w0WhH7Vhi8wmax5Eh9iCewWah+9T+TyRcaIwTTIR1TL2gUO+zB6n4ZF7aO
	75hRV1x8zoXZJfUId6uaWBnN9JlBqqUVYa54R/FY4Indss4RHo9Hd7H5q8+btAy6
	hOnmmmklKGH6VIt6XY22lJb3XLhHtnv2dQLttah3V/URNup7tXX5FylU43KWvx0d
	AoMFbQS56OAJArDLQy+7TdRY9QWocwWLIteBL6oAa8YDdY8mRU+fahRSKF01pUsF
	D+7m7LaQzX9DJEvYV2IQfogZptggDqrJGLx/7Mo0tjmTaPYbqHAUB9qy3kWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739352227; x=1739438627; bh=tcwqdVZJfybjSyKvGXw0E6lQGQITaPfAX2E
	+KmSZGug=; b=d5fQxZNnXa/SdFds4vCeXFAn98qQbHIkxAh98FDYKQlY1MS5Q3Y
	XPxlzIoxR+n1WXgtWsEu+X/nR61MvBZcvqhDMwBC033v6H/TsVwlrU0WS11JpRuH
	9vcpRfKRtrXcWHL5ukSrSs1PZjyIyiYiGipFdDxb6fIp6poS8V7gGYS0OQrJ08UJ
	LwckriX0krrt8f5YDf+eatwpPltkJDaGssG0IjyeeILxDLpitSWmRsJ7B7mWxeEI
	I8B+xVL/cu7xQxafL6ewdNl3fpwKDT772pn60SdMncI+pBjiwT3iVlNrgiD1aImF
	+xwTWGyy+55her7Ywx/cKVpSCamOA7JJzbg==
X-ME-Sender: <xms:omisZ2QAON_qj1uc3HlKuq3p9n2In57Z-9UKoq77ayyMR4C30BsSsg>
    <xme:omisZ7weWLehmLTfITB-foNFQqJpBY1_Mikq8PbtcZ-s-PIcCRnQXKB3UfEBwLry1
    hycIKufcfAKnBvV_Q>
X-ME-Received: <xmr:omisZz1W0pAVNGhovWFT2_J54515FEwAgBPUZfw8SjMiZ5oNRISS_FTEeWP7iHPf_oeCvWNJaGBZDW7I4odVXPc7KtH6eamOazAfIiSQoYkwvXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgvdetfffftdekgfeiheduhfdvteektdekledvffeu
    ffeuteejudeigeffgfdvgeenucffohhmrghinhepphhruhhnvggpuggrthgrrdhnrhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:omisZyDyKE51kYriwCDzGfzIz-NLt-zFGwAh9j-dE1y72vfKefw9OQ>
    <xmx:omisZ_ibu0L8L-Y6eFV9hXM52mgboDCCArcB4qH0_JfffqB8RUVQAg>
    <xmx:omisZ-rUiFFvt968AHu4hDj5krCarePtaDG5VtOZxjLI2rqy79I_oQ>
    <xmx:omisZyh14kw9kFRA7cgUNaPPSGvo-z-pdlg3oCB-pgBMO-jEPJxedg>
    <xmx:o2isZ8stW4CZd8zCpRDCtBgwSNKLLK-BieHhqPHLO-FZeOcB5uRimia6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:23:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48e613dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:23:45 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:23:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <Z6xooEvy3w11T_px@pks.im>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212041825.2455031-3-jltobler@gmail.com>

On Tue, Feb 11, 2025 at 10:18:24PM -0600, Justin Tobler wrote:
> Through git-diff(1), a single diff can be generated from a pair of blob
> revisions directly. Unfortunately, there is not a mechanism to compute
> batches of specific file pair diffs in a single process. Such a feature
> is particularly useful on the server-side where diffing between a large
> set of changes is not feasible all at once due to timeout concerns.
> 
> To facilitate this, introduce git-diff-pairs(1) which takes the
> null-terminated raw diff format as input on stdin and produces diffs in

s/null/NUL/

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

I really like this new design, thanks for working well together!

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

This should use `[synopsis]`, which allows you to drop the quoting.

> +DESCRIPTION
> +-----------
> +
> +Given the output of `diff-tree -z` on its stdin, `diff-pairs` will
> +reformat that output into whatever format is requested on its command

Reformatting from my point of view implies that we only rearrange bits a
bit. But we're not only reformatting the input, but actually compute the
diffs.

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

I think the "flushing" part is a bit hard to understand without knowing
anything about the command internals. As an unknowing reader I would
assume you're talking about fflush(3p), but I think you're rather
talking about when we "flush" the internal diff queue and thus compute
the diffs.

So I'd rephrase this and not talk about flushing, but about the
behaviour observed by the user instead.

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

This reads a bit weird. The first thing that trips me is the "should".
Does it or doesn't it handle the output of git-diff-tree(1)? The second
part is that this, at least to me, implies that other formats of course
aren't accepted, so why point that out explicitly?

> +Here's an incomplete list of things that `diff-pairs` could do, but
> +doesn't (mostly in the name of simplicity):
> +
> + - Only `-z` input is accepted, not normal `--raw` input.
> +
> + - Abbreviated sha1s are rejected in the input from `diff-tree`; if you

s/sha1s/object IDs/

> +   want to abbreviate the output, you can pass `--abbrev` to
> +   `diff-pairs`.
> +
> + - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
> +   the initial `diff-tree` invocation.

Makes sense.

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

Missing translation.

> +	return ret;
> +}
> +
> +static void parse_oid(const char *p, struct object_id *oid, const char **endp,
> +		      const struct git_hash_algo *algop)
> +{
> +	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
> +		die("unable to parse object id: %s", p);

Here, too. Do we also name this `parse_oid_or_die()` to stay consistent
with `parse_mode_or_die()`? The same is also true for `parse_score()`.

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

You can use `strtoul_ui()` instead, which does most of the error
handling for you.

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
> +	repo_init_revisions(repo, &revs, prefix);
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	argc = setup_revisions(argc, argv, &revs, NULL);

We need to check whether `argc > 0` here. Otherwise, unknown parameters
may simply be ignored, I think.

> +
> +	/* Don't allow pathspecs at all. */
> +	if (revs.prune_data.nr)
> +		usage_with_options(usage, options);

Should we give a better error in this case?

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

Missing translation.

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

Missing translation.

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
> +			die("unknown diff status: %c", status);

Missing translation.

> diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> new file mode 100755
> index 0000000000..e0a8e6f0a0
> --- /dev/null
> +++ b/t/t4070-diff-pairs.sh
> @@ -0,0 +1,80 @@
[snip]
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

Formatting:

	for i in diff*
	do
		git diff-pairs -p <$i ||
		return 1
	done >actual

> +	done >actual &&
> +	test_cmp expect actual
> +'

Patrick
