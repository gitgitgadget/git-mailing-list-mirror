Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAC2E8B67
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778751; cv=none; b=QvBDfWpI8zmk2Bd+3GfAoWzfmhMZhZIar3fnmJ99AdweFeTkbWtNzeONMDAj7lNGA+Lec4b4hscdHUEDDaXSnf6InbWTnzIpOQnS9pAA0ftYo6nGvEUwRgmdtLzUgUYkZwMkuvkz/H6O9ue+zTxU5kikHJ0283TYg6pxC+4ANuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778751; c=relaxed/simple;
	bh=bch4ODnAbZCFbtSs5Ub5HQc4SqFv8rMASVUEnOsII/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7JgMzGEWoztNJadyYKnIzc0CCGKixNu/A2DCR+bwVRPscpZGeI0TPUOA6gBa5peTwkh4vDRcVlzT4zYSnCuxeaBAfPNvoB2xC9igKA9CvZ78NYAyQ5nQYkR4w3ZcIDi68WB8cOPtS1w6WkdX3ne1LBUmbyHMIRJnmYo+eb1LnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i7glQpBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BV+RbN4n; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i7glQpBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BV+RbN4n"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 70640EC00E0;
	Thu, 25 Sep 2025 01:39:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 25 Sep 2025 01:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758778748; x=1758865148; bh=H6MCu7hxnS
	JD7i3sDVMz+rxYgYu6nx5sgkQagMPnQ9w=; b=i7glQpBG/HtHBua44lPdIbzrr7
	yR4OrgdmEPnitlM70pghBw9vXDsYiyLiufLFzT2839k4jwUfOP9EGpNGEl6hxl3S
	ljnNBeGrfh9uKBHKmM4Hrm7/X4cOGpxgoyEndTjir4GRreG1kPrBM6RQpiPjqz9u
	QvON1PUdUyJm7aDRrNiPWILmAnGD7F1UsLEOi1cmHx6VdMRn1UuPek8Oe0bLlFUv
	hxSJx0u1a4QqeMKLt/8Fj0L/IE4OGNrY4q8SrFyx9Cg/uyogtEqA/3cfmf0ksfzW
	/LjT9aHcUKOZCcWdNzLwH0hYzY4ErljF9WrPtTQz5GJxLqcX2YREgbPzJRog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758778748; x=1758865148; bh=H6MCu7hxnSJD7i3sDVMz+rxYgYu6nx5sgkQ
	agMPnQ9w=; b=BV+RbN4nWHUltJxTmndZ3V6WHqsle7ebkb7Z0UKIwfvvPMbf4XV
	X7AamE5Fc8j05+1fntpK8XfIol4GX6tk2upF4pXiiFqjxKgFKOzywBMYCp01D7Z5
	u4UISNLC2VhBSC9S5zPtUYyTZnsKnwD8z9o/JF6FbLMtoARn+3D5ZPUdrUmyoQtT
	TbrSKazhn9amGpuveWP/4E7m0qtPtsk2YMnBjo0duZjSB9WtPg3QQze7DSV3GQTr
	f7El97/7MCJNjsQqTQv3YseH+jCKwJKUp+Fm8Q8y6Sv4oWc0D8uQrxwCujtiP08M
	tGCXXkQjAFl5+CgoIVlTqPzg7Px7362fBPA==
X-ME-Sender: <xms:fNXUaIhvfMlLwPQiekAIaeOtUocFB4lv1q57PdQAqq9op79HRcDVZg>
    <xme:fNXUaIekYQlwOecPscsOxJ3_wWBtvW1eqI09O6OhvF9bL1Cylesz4bi2XfwF4EHwx
    kKDvw7Oa1Nqy4xPGmTbAS4nbmI9IiLoJb1mowr6fkZN78cOILPS>
X-ME-Received: <xmr:fNXUaNdfVqu5zUy7n01ahL5vKWHXtYLRhH7BrSGHmHf5AU6MaDoQH2BYHV7tLMcpU02qmUML_XGFiXGlW0NUjMSuxVydl_4EkA3XXNqbuKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeijecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fNXUaC984ELm7CTQT15-EfNO8i9XmwAQ_N5oJSpjC-voW9Y88wvxyA>
    <xmx:fNXUaJmV3NDCPlk2vfVdA2g1jItfM5qv8FqWROsJnLgCDawOmi85zA>
    <xmx:fNXUaE-p8L2mdMtGPvcg0MgEhaWoE4zdFp9bsJDh1mzcaxLJ0DQU0g>
    <xmx:fNXUaHkaPBxzNUJtRKq4wIg3goKL9f5dgu3nOQBOh84SKHRLp0kEIw>
    <xmx:fNXUaD4t0j6TGIsHVFELTu_YaNYEWtfg-gXmSGJt0BsQacre25Bi2fzj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 01:39:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d992f947 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 05:39:07 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:39:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 5/6] builtin/repo: add keyvalue and nul format for
 stats
Message-ID: <aNTVdy4hhLDlMpVT@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924212426.2930029-6-jltobler@gmail.com>

On Wed, Sep 24, 2025 at 04:24:25PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 0b8d74ed3e..db21b75522 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -52,7 +52,26 @@ supported:
>  * Reachable object counts categorized by type
>  
>  +
> -The table output format may change and is not intended for machine parsing.
> +The output format can be chosen through the flag `--format`. Three formats are
> +supported:
> ++
> +`table`:::
> +	Outputs repository stats in a human-friendly table and is used by
> +	default. This format may change and is not intended for machine
> +	parsing.

Let's mention that this is the default format.

> +`keyvalue`:::
> +	Each line of output contains a key-value pair for a repository stat.
> +	The '=' character is used to delimit between the key and the value.
> +	Values containing "unusual" characters are quoted as explained for the
> +	configuration variable `core.quotePath` (see linkgit:git-config[1]).

In the current state there is never any quoting, so this statement here
is a bit misleading. Should we maybe drop that part?

> +`nul`:::
> +	Similar to `keyvalue`, but uses a NUL character to delimit between
> +	key-value pairs instead of a newline. Also uses a newline character as
> +	the delimiter between the key and value instead of '='. Unlike the
> +	`keyvalue` format, values containing "unusual" characters are never
> +	quoted.

Likewise.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 8f130bca66..fe7d43f78e 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -312,6 +317,33 @@ static void stats_table_clear(struct stats_table *table)
>  	string_list_clear(&table->rows, 1);
>  }
>  
> +static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
> +				 char value_delim)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addf(&buf, "references.branches.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->refs.branches, value_delim);
> +	strbuf_addf(&buf, "references.tags.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->refs.tags, value_delim);
> +	strbuf_addf(&buf, "references.remotes.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->refs.remotes, value_delim);
> +	strbuf_addf(&buf, "references.others.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->refs.others, value_delim);
> +
> +	strbuf_addf(&buf, "objects.commits.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->objects.commits, value_delim);
> +	strbuf_addf(&buf, "objects.trees.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->objects.trees, value_delim);
> +	strbuf_addf(&buf, "objects.blobs.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->objects.blobs, value_delim);
> +	strbuf_addf(&buf, "objects.tags.count%c%" PRIuMAX "%c",
> +		    key_delim, (uintmax_t)stats->objects.tags, value_delim);
> +
> +	fwrite(buf.buf, sizeof(char), buf.len, stdout);
> +	strbuf_release(&buf);
> +}

Same question here regarding the buffering. Can't we print to stdout
directly, or is there a reason not to?

> @@ -389,17 +421,25 @@ static void stats_count_objects(struct object_stats *stats,
>  	path_walk_info_clear(&info);
>  }
>  
> -static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
> -			  const char *prefix, struct repository *repo)
> +static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
> +			  struct repository *repo)
>  {
>  	struct ref_filter filter = REF_FILTER_INIT;
>  	struct stats_table table = {
>  		.rows = STRING_LIST_INIT_DUP,
>  	};
> +	enum output_format format = FORMAT_TABLE;
>  	struct repo_stats stats = { 0 };
>  	struct ref_array refs = { 0 };
>  	struct rev_info revs;
> +	struct option options[] = {
> +		OPT_CALLBACK_F(0, "format", &format, N_("format"),
> +			       N_("output format"),
> +			       PARSE_OPT_NONEG, parse_format_cb),
> +		OPT_END()
> +	};
>  
> +	parse_options(argc, argv, prefix, options, repo_usage, 0);

I think it would be sensible to introduce this call to `parse_options()`
right in the first commit that wires up the new subcommand. If we don't
do that we otherwise accept arbitrary arguments without raising any
error, and neither do we know to output help.

So we should move the addition to a previous commit and probably do the
following:

        argc = parse_options(...);
        if (argc)
            usagef("too many arguments");

> @@ -407,8 +447,20 @@ static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
>  	stats_count_references(&stats.refs, &refs);
>  	stats_count_objects(&stats.objects, &refs, &revs);
>  
> -	stats_table_setup(&table, &stats);
> -	stats_table_print(&table);
> +	switch (format) {
> +	case FORMAT_TABLE:
> +		stats_table_setup(&table, &stats);
> +		stats_table_print(&table);
> +		break;
> +	case FORMAT_KEYVALUE:
> +		stats_keyvalue_print(&stats, '=', '\n');
> +		break;
> +	case FORMAT_NUL_TERMINATED:
> +		stats_keyvalue_print(&stats, '\n', '\0');
> +		break;

This reads much nicer now. The newline as key-value delimiter is a
curious choice, but you simply do what we already do in `git repo info`.

> diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> index 315b9e1767..d2c1b6e307 100755
> --- a/t/t1901-repo-stats.sh
> +++ b/t/t1901-repo-stats.sh
> @@ -73,4 +73,37 @@ test_expect_success 'repository with references and objects' '
>  	)
>  '
>  
> +test_expect_success 'repository stats with keyvalue and nul format' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 42 &&
> +		git tag -a foo -m bar &&
> +
> +		cat >expect <<-\EOF &&
> +		references.branches.count=1
> +		references.tags.count=1
> +		references.remotes.count=0
> +		references.others.count=0
> +		objects.commits.count=42
> +		objects.trees.count=42
> +		objects.blobs.count=42
> +		objects.tags.count=1
> +		EOF
> +
> +		git repo stats --format=keyvalue >out 2>err &&
> +
> +		test_cmp expect out &&
> +		test_line_count = 0 err &&
> +
> +		# Replace key and value delimiters for nul format.
> +		tr "\n" "\0" <expect | tr "=" "\n" >expect_null &&

You can do this without the pipe:

    tr "\n=" "\0\n" <expect >expect_nul

Also, let's call the file `expect_nul` (with a single 'l') to match the
format.

Patrick
