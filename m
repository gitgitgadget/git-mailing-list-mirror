Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4D32143A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624782; cv=none; b=otBWQ8et/VikvYq7OMV01xjxup0K3ytWAvS09CDtUUpvL4gi3lme4pIdBl08lOZcY2ny6XsayAWMFV03yZWULvF0fyxXKI0aHc7ik9pp/Y6IjnDLTrmVDYc4GxCiBnrQYcqBRG9pIhqt7kNd3N+h4ioiNz9BFw7vcLNi0VnH9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624782; c=relaxed/simple;
	bh=pKxgXG5AdA3K7jYdCmz95sfBq3vWMo9DwysVBpTaAQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFK/NRhc5WWCvR1B4MfcMNVYr1yq4s9IctKuWxWnndVU6J3nV9CTGdm7/jRNGy6hb0wFd4+dT+3k4j0j9erFm7WS03OAOJ8oRDSkocTDRpo47+vZqn2X6mklG/sdw53M4BkW/VsHDbLv8E/OZOxszGwQHbLlaT8YCk3+KR9d54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AgiNDZqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cmmOwVnw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AgiNDZqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmmOwVnw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24DB07A017D;
	Tue, 23 Sep 2025 06:52:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 06:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758624778; x=1758711178; bh=4OkUHHqsuy
	9WIQyz/i9zfxNyC0H5UUOlXlDsR7afBNM=; b=AgiNDZqRMTJMyatYFpOFUZZhhi
	Tzb7VEeSuE/CjPu7+zcZsVGEsOyoqVId4BzaQvgy2h5ePItHYgIq0ebgT3fPeWId
	IOwSJCTWdAvzveX3EdGMXB4Ob1cC6Xfa1CXIH0eaUnk72wuikavKmW5esJmCL7Ww
	A7ZRWhQfVyCSDALgnIs2S3DCG/o6bG02dDRiXN2NZxlkRAuXEq4/0oVDpjzJMO7g
	eEdebJD6SEwUP1wm4TBQLC4BThCZVw72u6X7+ZdYoeGbyNhS+kyfRjVHEuiyqv0c
	HXukJRiKDE9iNs9kX27QwV5JzlRYbsJ4luDkuGXE3TdWMiFKceZcTTmxoXUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758624778; x=1758711178; bh=4OkUHHqsuy9WIQyz/i9zfxNyC0H5UUOlXlD
	sR7afBNM=; b=cmmOwVnwa3x7mGRAs/ZLPHuYZCnZ1Pf+krvxCMhfxpPjnBBXpg4
	7Dsmo/aULqh5B641GbhPdE2tF2upP8LDudUps2UNhFPm/J6ogm/Plgy1T9StLlxM
	eW820a5CNAk10q+9e1XpfkJRym+jozDhtzaQwZhwtbB7Dp0zbByC3VLGR6DNVz2U
	b1v8rRVNUltTh3tjaGcYcd8TFISOyHMmYtJ6TvyCslej2iUlEAwiBJltR873Hstt
	fls4qYnY2lA4DbRW963EYVfRHum4QOcPlnTRANUQCuUfQG7LonzWhhamz5cYYNNt
	ODvY9vOcoM6K9t5/+KZip/nlp9DAgcDhT4w==
X-ME-Sender: <xms:CnzSaBIhS0GlcmaRiMtDYaRU3GtkhXSH1ZEM2Z16UIY-URi30gxB5w>
    <xme:CnzSaEk4HRcOGiihPxhWyxYZL7QFmIWDE9E5F2bPBPds7nKCmIC4MVr0rfZCHp8wM
    P9f4mbnNtJhCsOUNg7YGglej2cqysRWlVuwry4GLg3gT_gQOMoFUgo>
X-ME-Received: <xmr:CnzSaHGVzH0QgB01Kfy0Vi0VOLtMvXenemIyMe4DBwHaJJfoDkwRSsMwPGpnDNUVdarAXXHrbp8ll0BZ6x9cz-YIJdrfCW21A6THRdhCCuDJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:CnzSaMGqVQloXghnIH4BaZui1qVxQ_wl7ptWrJsTooBudREEDCMvUg>
    <xmx:CnzSaMOVMCPcYwdQUpNyO75Z6RslznEq5VRleacGKfQyRK82zPOzRg>
    <xmx:CnzSaDF3ktYoDYKhPcebs7Z0jEDhaOml2FRvlZTFE_Wn8S2T6qI4_w>
    <xmx:CnzSaLPPccDCaCNPF8cFFradAUS8H8BQPQXWGQOAl_dv5q15izRDpA>
    <xmx:CnzSaCCtIaIFM8PSleB_TuQS2peU9_2fe0WbWUJXlIC8L4Do7tf2okOX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:52:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4baf7ed8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:52:57 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:52:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 2/4] builtin/repo: add object counts in stats output
Message-ID: <aNJ8BvTZ_yNSrBA6@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923025700.3046260-3-jltobler@gmail.com>

On Mon, Sep 22, 2025 at 09:56:58PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 7762329551..2a67abfca8 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -45,8 +45,9 @@ supported:
>  `-z` is an alias for `--format=nul`.
>  
>  stats::
> -	Retrieve stats about the current repository. All references in the
> -	repository are categorized and counted accordingly.
> +	Retrieve stats about the current repository. All references and
> +	reachable objects in the repository are categorized and counted
> +	accordingly.
>  +
>  The table output format may change and is not intended for machine parsing.

I already wanted to mention this on the first commit, but would it maybe
make sense if this was a bulleted list of information that we surface
right from the start? Then we don't have to reflow the whole paragraph
every time we surface new information.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 15899dd74c..a24ea0e66b 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -159,13 +161,25 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  	return print_fields(argc, argv, repo, format);
>  }
>  
> -struct stats {
> +struct ref_stats {

Nit: let's call it `ref_stats` right from the start instead of renaming.

>  	size_t branches;
>  	size_t remotes;
>  	size_t tags;
>  	size_t others;
>  };
>  
> +struct object_stats {
> +	size_t tags;
> +	size_t commits;
> +	size_t trees;
> +	size_t blobs;
> +};
> +
> +struct stats {

I'd maybe call this `struct repo_stats`. `stats` feels quite generic and
very close to a collision with `struct stat`.

> @@ -207,15 +221,27 @@ static void stats_table_add_count(struct stats_table *table, const char *name,
>  
>  static void stats_table_setup(struct stats_table *table, struct stats *stats)
>  {
> +	struct object_stats objects = stats->objects;
> +	struct ref_stats refs = stats->refs;

We can avoid the copies by making these pointers. Not that it'd really
matter all that much.

> +	size_t object_total;
>  	size_t ref_total;
>  
> -	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> +	ref_total = refs.branches + refs.remotes + refs.tags + refs.others;
>  	stats_table_add(table, _("* References"), NULL);
>  	stats_table_add_count(table, _("  * Count"), ref_total);
> -	stats_table_add_count(table, _("    * Branches"), stats->branches);
> -	stats_table_add_count(table, _("    * Tags"), stats->tags);
> -	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> -	stats_table_add_count(table, _("    * Others"), stats->others);
> +	stats_table_add_count(table, _("    * Branches"), refs.branches);
> +	stats_table_add_count(table, _("    * Tags"), refs.tags);
> +	stats_table_add_count(table, _("    * Remotes"), refs.remotes);
> +	stats_table_add_count(table, _("    * Others"), refs.others);
> +
> +	object_total = objects.commits + objects.trees + objects.blobs + objects.tags;
> +	stats_table_add(table, "", NULL);
> +	stats_table_add(table, _("* Objects"), NULL);

Should we maybe say "Reachable objects" here to clarify that this
doesn't count unreachable ones?

> @@ -282,25 +308,80 @@ static void stats_count_references(struct stats *stats, struct ref_array *refs)
>  	}
>  }
>  
> +static int count_objects(const char *path UNUSED, struct oid_array *oids,
> +			 enum object_type type, void *data)
> +{
> +	struct object_stats *stats = data;
> +
> +	switch (type) {
> +	case OBJ_TAG:
> +		stats->tags += oids->nr;
> +		break;
> +	case OBJ_COMMIT:
> +		stats->commits += oids->nr;
> +		break;
> +	case OBJ_TREE:
> +		stats->trees += oids->nr;
> +		break;
> +	case OBJ_BLOB:
> +		stats->blobs += oids->nr;
> +		break;
> +	default:

Let's `BUG()` here. This case should never happen, and if it does
something is seriously wrong.

> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void stats_count_objects(struct object_stats *stats,
> +				struct ref_array *refs, struct rev_info *revs)
> +{
> +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> +
> +	info.revs = revs;
> +	info.path_fn = count_objects;
> +	info.path_fn_data = stats;
> +
> +	for (int i = 0; i < refs->nr; i++) {
> +		struct ref_array_item *ref = refs->items[i];
> +
> +		switch (ref->kind) {
> +		case FILTER_REFS_BRANCHES:
> +		case FILTER_REFS_TAGS:
> +		case FILTER_REFS_REMOTES:
> +		case FILTER_REFS_OTHERS:
> +			add_pending_oid(revs, NULL, &ref->objectname, 0);
> +			break;
> +		}
> +	}
> +
> +	walk_objects_by_path(&info);
> +	path_walk_info_clear(&info);
> +}

I guess this can take a while, so having a progress meter would be great
to have to give the user some info what's happening. I guess it doesn't
have to be part of the first iteration thuogh as long as this is
something we plan to add at a later point.

> diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> index 27c32ec45f..c6a7f08be5 100755
> --- a/t/t1901-repo-stats.sh
> +++ b/t/t1901-repo-stats.sh
> @@ -20,6 +20,13 @@ test_expect_success 'empty repository stats' '
>  		|     * Tags       |     0 |
>  		|     * Remotes    |     0 |
>  		|     * Others     |     0 |
> +		|                  |       |
> +		| * Objects        |       |
> +		|   * Count        |     0 |
> +		|     * Commits    |     0 |
> +		|     * Trees      |     0 |
> +		|     * Blobs      |     0 |
> +		|     * Tags       |     0 |
>  		EOF
>  
>  		test_cmp expect out &&
> @@ -49,6 +56,45 @@ test_expect_success 'repository stats with references' '
>  		|     * Tags       |     1 |
>  		|     * Remotes    |     1 |
>  		|     * Others     |     1 |
> +		|                  |       |
> +		| * Objects        |       |
> +		|   * Count        |     5 |
> +		|     * Commits    |     2 |
> +		|     * Trees      |     2 |
> +		|     * Blobs      |     1 |
> +		|     * Tags       |     0 |
> +		EOF
> +
> +		test_cmp expect out &&
> +		test_line_count = 0 err
> +	)
> +'
> +
> +test_expect_success 'repository stats with objects' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 42 &&
> +		git tag -a foo -m bar &&
> +		git repo stats >out 2>err &&
> +
> +		cat >expect <<-EOF &&
> +		| Repository stats | Value |
> +		| ---------------- | ----- |
> +		| * References     |       |
> +		|   * Count        |     2 |
> +		|     * Branches   |     1 |
> +		|     * Tags       |     1 |
> +		|     * Remotes    |     0 |
> +		|     * Others     |     0 |
> +		|                  |       |
> +		| * Objects        |       |
> +		|   * Count        |   127 |
> +		|     * Commits    |    42 |
> +		|     * Trees      |    42 |
> +		|     * Blobs      |    42 |
> +		|     * Tags       |     1 |
>  		EOF

I quite like the output format, by the way. It's nice to read and makes
it sufficiently clear that this is not expected to be parsed by a
machine.

Patrick
