Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB321E480
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624778; cv=none; b=YEEM9tzwlLTZ5TKjBWS3JEmzEcb2iiDzcaZsxqnvYrLCIkpTsE5a4lBtDRlpW10M0/15NDP5Re1uaKoMlR1RTlVbeN04U5OcXN0SEKi5AcZTAaW5a6nJzhuPQQX8j8yNbTTzKMuTsvlNKntBTddkRlBqoPjYxZgT6u1mVw0/h4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624778; c=relaxed/simple;
	bh=HawwWVA6FwKCL1Q/J7BDVRLDIqeKF4bSRA7pjvJk0PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBdujp70IJUWfVy4+QQJ2X0Lr91cgyzs1tkmocYbxBqLWLeGS4yTru6g9fZbUAWAynRrm7Y4JN5vzqQYfYVxKq+0bGE/0EUoM2LLAMV5Npcn5RjuRkIzxKkbUtezAD1z6onmagWFh+YAhN6sVR63jKsiH6K6fqdpxBTXgHyJhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ioA8M+mo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+lTjYjO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ioA8M+mo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+lTjYjO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DE6631D00269;
	Tue, 23 Sep 2025 06:52:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 06:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758624774; x=1758711174; bh=Ok5gSUIu0o
	EL6IrZABGDLSni38z6LQyw2Vkx+UijFmo=; b=ioA8M+moV4Ad+uyyO8KJUD5oWJ
	E8BJu2jh1gfi5kUoXfvWLMDpcwybsiQ8BgIEennznssa1V9QseidjB8YhVe5BFts
	bkS5mHcNqD4eam+UslMKr5Jh+XcRkTiw2NY5FXPGaSEgRElYtWkH8c+9s8QwgHig
	2Iwveqc3hQe6XVcxDueWQ+rp31o6Fvi1yLQnUX+bvdkUg+mhvgshOAUL4UlZckfI
	SoN/wrUPnAJeEFCOpsuy7N8SuOrtPXnSdy0x9m5rRvP2E8VJjKJMgXzucpWC2uxY
	4n5l15w08B+WEO2/yGaoUSwkTymDPrBT1UDoIHbnOpxCyw3bDES79P0Q3y4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758624774; x=1758711174; bh=Ok5gSUIu0oEL6IrZABGDLSni38z6LQyw2Vk
	x+UijFmo=; b=I+lTjYjOYmTrkG8IbGk/DBpXXA0KkO+ifNvyFKvQDhPqM1jVsji
	jFOTTEU3cOJS6wm8tdaQGWdpKBTXFAn/TiBRyvAwfrLHhIAQFRaSY7ZvfIGmbozl
	9DWFcYz0fj0vq6JAqQDXo2daWwDMAZWk8BlUoU9jRYz89XbUhGs2zMt220etwtj+
	59jr8n1IZ6zUNu4ydNCW5VfAsLTW2QnnAmxRajgzlvmcdPpenO7YQzlPOyAoO+ow
	jrqlW6Ty+CLEQf8VvySEzwD2salwc72eEuV+evgCYa6KxqgC1LJWb1tkVo9I6p3F
	2zn0gavyKQNvFlGCUcbt9rZWMms7oBhYCUA==
X-ME-Sender: <xms:BnzSaJ_bH9J9A6gOox_rZimZZpffzkepWeRM__ruq-hormQibh9pxQ>
    <xme:BnzSaFJURyGWrgGIRlHw10GdQ724qCOCB2C_ox3Jd6JE4OfwEi_-_WJPvt82tTUdD
    pNroLHNnkINZpddDYFfY19uXFEZuxi-5gvZhNEFfCzSmNuBRSolXw>
X-ME-Received: <xmr:BnzSaEabNk3Kv1pAD0b14v-DFiwprd7BbPPr-fli1pPNe9vTvvp3umpzqO5Okcv9pzeyhxCNWv56RUR5HbmXclHBr7o16GIjr8VtHfe-jnkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:BnzSaHKEE7FPmFaTH3OYbeiDw3anGbbroM_b_AVx9h3FfvOnNFhfSA>
    <xmx:BnzSaCBMx02pjpbCsD4lp36gmLyB8JCrXJ9ULBHBXVitDakuNBKfjw>
    <xmx:BnzSaMqqUSSBLEgbMtM7gXjg-jur1xyTKDX6S9tWgyQDEcRBEWAUlw>
    <xmx:BnzSaNg9QuKLfD1a0ICO8Tg90MFtJCCJJCV9i2Brzd6XTvy2sq6g4A>
    <xmx:BnzSaLmhWG1LXXJ9EZiyrTlvyaUhD1oO_Z5w3LfD-cSAO9dGPlMVIzgy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:52:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1932b6ea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:52:52 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:52:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 1/4] builtin/repo: introduce stats subcommand
Message-ID: <aNJ7_GoKT5ea4QJE@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923025700.3046260-2-jltobler@gmail.com>

On Mon, Sep 22, 2025 at 09:56:57PM -0500, Justin Tobler wrote:
> The shape of a repository's history can have huge impacts on the
> performance and health of the repository itself. Currently, Git lacks a
> means to surface key stats/information regarding the shape of a
> repository via a single command. Acquiring this information requires
> users to be fairly knowledgeable about the structure of a Git repository
> and how to identify the relevant data points. To fill this gap,
> supplemental tools such as git-sizer(1) have been developed.
> 
> To allow users to more readily identify potential issues for a
> repository, introduce the "stats" subcommand in git-repo(1) to output
> stats for the repository that may be of interest to users. The goal of
> this subcommand is to eventually provide similar functionality to
> git-sizer(1), but in Git natively.

Nit: "but natively in Git" would read more natural.

> The initial version of this command only iterates through all references
> in the repository and tracks the count of branches, tags, remotes, and

s/remotes/remote refs/

> other reference types. The corresponding information is displayed in a
> human-friendly table formatted in a very similar manner to git-sizer(1).
> The width of each table column is adjusted automatically to satisfy the
> requirements of the widest row contained.
> 
> Subsequent commits will surface additional relevant data points to
> output.
> 
> Signed-off-by: Justin Tobler <jltobler@gmail.com>

Is this command built on Derrick's git-survey(1)? If so, it would
probably be nice to add a "Based-on-patch-by" tag.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 209afd1b61..7762329551 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -43,6 +44,12 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>  
> +stats::
> +	Retrieve stats about the current repository. All references in the

s/stats/statistics/

> +	repository are categorized and counted accordingly.
> ++
> +The table output format may change and is not intended for machine parsing.

I guess we don't yet have a machine-parseable interface in this state,
so we cannot ponit to it.

> @@ -156,12 +159,160 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  	return print_fields(argc, argv, repo, format);
>  }
>  
> +struct stats {
> +	size_t branches;
> +	size_t remotes;
> +	size_t tags;
> +	size_t others;
> +};
> +
> +struct stats_table {
> +	struct string_list rows;
> +
> +	int name_col_width;
> +	int value_col_width;

You assign the result from `strlen()` to these fields, so they should
probably be `size_t`.

> +};
> +
> +struct stats_table_entry {
> +	char *value;
> +};
> +
> +static void stats_table_add(struct stats_table *table, const char *name,
> +			    struct stats_table_entry *entry)
> +{
> +	int name_width = strlen(name);

`strlen()` returns `size_t`.

> +	struct string_list_item *item;
> +
> +	item = string_list_append(&table->rows, name);
> +	item->util = entry;
> +
> +	if (name_width > table->name_col_width)
> +		table->name_col_width = name_width;
> +	if (entry) {
> +		int value_width = strlen(entry->value);
> +		if (value_width > table->value_col_width)
> +			table->value_col_width = value_width;
> +	}

I was wondering at first why you'd ever want to not pass an entry, but
we use that to have "dividers" in the table. Makes sense.

> +}
> +
> +static void stats_table_add_count(struct stats_table *table, const char *name,
> +				  size_t value)
> +{
> +	struct stats_table_entry *entry;
> +
> +	CALLOC_ARRAY(entry, 1);
> +	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> +	stats_table_add(table, name, entry);
> +}
> +
> +static void stats_table_setup(struct stats_table *table, struct stats *stats)
> +{
> +	size_t ref_total;
> +
> +	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> +	stats_table_add(table, _("* References"), NULL);
> +	stats_table_add_count(table, _("  * Count"), ref_total);
> +	stats_table_add_count(table, _("    * Branches"), stats->branches);
> +	stats_table_add_count(table, _("    * Tags"), stats->tags);
> +	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> +	stats_table_add_count(table, _("    * Others"), stats->others);
> +}

Would it make sense to not translate the formatting directives, but only
the actual words?

> +static void stats_table_print(struct stats_table *table)
> +{
> +	const char *name_col_title = _("Repository stats");
> +	const char *value_col_title = _("Value");
> +	int name_col_width = strlen(name_col_title);
> +	int value_col_width = strlen(value_col_title);

These should both be `size_t`.

> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	if (table->name_col_width > name_col_width)
> +		name_col_width = table->name_col_width;
> +	if (table->value_col_width > value_col_width)
> +		value_col_width = table->value_col_width;
> +
> +	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
> +		    value_col_width, value_col_title);

Aha, that's why you went with `int`. You can use `cast_size_to_to_int()`
to convert between the types.

> +	strbuf_addstr(&buf, "| ");
> +	strbuf_addchars(&buf, '-', name_col_width);
> +	strbuf_addstr(&buf, " | ");
> +	strbuf_addchars(&buf, '-', value_col_width);
> +	strbuf_addstr(&buf, " |\n");
> +
> +	for_each_string_list_item (item, &table->rows) {

We typically don't have a space after between the macro and its
arguments.

> +		struct stats_table_entry *entry = item->util;
> +		const char *value = "";
> +
> +		if (entry) {
> +			struct stats_table_entry *entry = item->util;
> +			value = entry->value;
> +		}
> +
> +		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
> +			    item->string, value_col_width, value);
> +
> +		if (entry)
> +			free(entry->value);

It's a bit weird that we free the values when we pretend to only print
data. Sure, we probably don't ever have a usecase where we want to print
data a second time. But I still think it would be nice to separate
concerns.

> +	}
> +
> +	fputs(buf.buf, stdout);
> +	strbuf_release(&buf);
> +}
> +
> +static void stats_count_references(struct stats *stats, struct ref_array *refs)
> +{
> +	for (int i = 0; i < refs->nr; i++) {
> +		struct ref_array_item *ref = refs->items[i];
> +
> +		switch (ref->kind) {
> +		case FILTER_REFS_BRANCHES:
> +			stats->branches++;
> +			break;
> +		case FILTER_REFS_REMOTES:
> +			stats->remotes++;
> +			break;
> +		case FILTER_REFS_TAGS:
> +			stats->tags++;
> +			break;
> +		case FILTER_REFS_OTHERS:
> +			stats->others++;
> +			break;

Do we want to have a `default:` case where we `BUG()`? Otherwise we may
not notice that we undercount the overall number of refs.

> +		}
> +	}
> +}
> +
> +static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> +		      const char *prefix UNUSED, struct repository *repo UNUSED)

Not a new issue, but I'd rather call this `cmd_repo_stats()` to note
that this is the entrypoint. We might as well adapt the other subcommand
to follow that naming schema in a preparatory commit.

> +{
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct strvec ref_patterns = STRVEC_INIT;
> +	struct stats_table table = { 0 };
> +	struct ref_array refs = { 0 };
> +	struct stats stats = { 0 };
> +
> +	filter.name_patterns = ref_patterns.v;
> +	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);

`filter_refs()` may return an error code which we should probably
handle.

> diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> new file mode 100755
> index 0000000000..27c32ec45f
> --- /dev/null
> +++ b/t/t1901-repo-stats.sh
> @@ -0,0 +1,59 @@
> +#!/bin/sh
> +
> +test_description='test git repo stats'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'empty repository stats' '

Nit: I don't think it's necessary to repeat "repository stats" in every
test name. That's already clear from the test suite.

> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git repo stats >out 2>err &&
> +
> +		cat >expect <<-EOF &&

s/EOF/\EOF/, as we don't need to expand any variables.

> +		| Repository stats | Value |
> +		| ---------------- | ----- |
> +		| * References     |       |
> +		|   * Count        |     0 |
> +		|     * Branches   |     0 |
> +		|     * Tags       |     0 |
> +		|     * Remotes    |     0 |
> +		|     * Others     |     0 |
> +		EOF
> +
> +		test_cmp expect out &&
> +		test_line_count = 0 err
> +	)
> +'
> +
> +test_expect_success 'repository stats with references' '

Same comment regarding the name.

> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m init &&
> +		oid="$(git rev-parse HEAD)" &&
> +		git switch -c foo &&
> +		git tag init &&
> +		git update-ref refs/remotes/origin/foo "$oid" &&
> +		git notes add -m foo &&
> +		git repo stats >out 2>err &&
> +
> +		cat >expect <<-EOF &&

Likewise regarding "\EOF".

> +		| Repository stats | Value |
> +		| ---------------- | ----- |
> +		| * References     |       |
> +		|   * Count        |     5 |
> +		|     * Branches   |     2 |
> +		|     * Tags       |     1 |
> +		|     * Remotes    |     1 |
> +		|     * Others     |     1 |
> +		EOF
> +
> +		test_cmp expect out &&
> +		test_line_count = 0 err
> +	)
> +'

Patrick
