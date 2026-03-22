Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F75C8CE
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217392; cv=none; b=QG5D3ZOTwSGFFI75z0CpJve6ukIWib1fqmKv3ILgSFLjCe7g4IvMU6AHi75mWJ6qAWFLWQkWjn6o5lLDCTdqgfrvM0INI0Nn7kcLi6GcM5oULrJNqSomMf6jLMfgZFG4IurmHNAFh6RZ7opggXB3f+ayTgRNhN+o/5c2pd/qRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217392; c=relaxed/simple;
	bh=craAHipXnr5mpEFWH/jTJkPrSvbSvyVMYoPRprnG8ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hLEGFxHm+VpOzxTPpnrZyawMOWaSywDA1AYlbjboe7PrrjYM2T5MB25Lbf8uSpzxMYy0GbHG/D2LBGIXXzbCwR+dtWY69yUk7kntsiA9VF2/l3KDT0gd0WkcUmbq0XlXwH53ddg21mQfZeMEfD7vIPESmsId3Vb6hntgLrzbg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BXEPju02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1FKQ+na; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BXEPju02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1FKQ+na"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C48911400142;
	Sun, 22 Mar 2026 18:09:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 22 Mar 2026 18:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774217389; x=1774303789; bh=p2VcR4Ls/L
	T8Cr1Jhj13d1emt1x7Pe58l/HC/cjm5NU=; b=BXEPju02buufNDAE1HTBvJp7bL
	HJX49qpiABVrM1YGxMaTBs9fzUvLJwb/yrCoJWfezzTzyqKYYNoS5eD6wEMxU5av
	+a3K5lvih11CcNKP+TbAyjy116qWr0NZG5r8vwl8NR6VGfTfKITlf5l7W/YVJmIh
	KVhYzo9wPy2y4IRkgDFioFnWxCPPDmLh76W8bu6yi480ZqoamuKnulGipIfoP4sc
	uPWTaTlkRdPz3naF7bGCKekC5ytsiQwXSFoEJbwR2orxzUQP0BKEnyXf70SItVXM
	NMKLDp14630SFMlM8M2PkHM9fif25OEFXN3iofsbKxYXHeI1DR85i9f+SEBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774217389; x=1774303789; bh=p2VcR4Ls/LT8Cr1Jhj13d1emt1x7Pe58l/H
	C/cjm5NU=; b=q1FKQ+naxg4wfcSDWBW0mnU7kLNy4l3z3OIgEu/Kf0cyRUfeCHN
	0otwxxvclLgka3G5FpmEwf8kZt5OKNA9pEEOJCvsb6L8Pb+MwRaOaBhMHy5jgw8V
	2yV/fsvfDql2oXQj6ORKNdSZYhbJRftWaHh5aSwdfHM6d2d9CW+iWCoIJvfisChC
	WzqRgA1NHLH7Ndl9f4/XLpxBiZ4N0PBBBjux6UN3sXguER122Z5xXxY8aGvGZzN/
	0uhlWptw1GR7vrURUWMB5xWd4Dm8dlkk6ZNLQvM5IJcof9IRR2GftrwI2ZmbcrwN
	524BHBhLXyioYZwAxJi2rNyEDBuylKeEGyA==
X-ME-Sender: <xms:rWjAaeX1LgpCkQmdvFWkURRjjm3Yzv_MNubRjqCTR8v7YxrDiZLHIw>
    <xme:rWjAaXJX0kOVKY1jTfWHp5f9OYI8xfsv4cbYiKjaifiSA-0N_0_yEM1VECZ75GDW-
    GKTRMMz6Nyd58MNZ9H0DeRf7pEJKRcPkTYK64OlLDAwHX2QpJfAsg>
X-ME-Received: <xmr:rWjAaW3g3cfv5G5kayi7C2DoHiEeeRSvzftExcrXIuU34u9Dd1WkvzVWTKksZMLXJ2zPVfmFq7Wn5n1Qj2STWujMNN_ECWW8ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghl
    ohhoshgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:rWjAacJ9Cwz-95zLapcsOhkmIXhQcbA1nBWGr1h9BVACLVVou1UX0g>
    <xmx:rWjAaZiv1vpqQpyd-h3NWJRHTFCe-bPRQA76z-uCWE_Ddp7jpGSc_g>
    <xmx:rWjAaUDLTTijmqSxyYOIP_aDrMXwUMC1roWG4YS7rOtcmc6djw-w_Q>
    <xmx:rWjAaT5ze1Ax2Yk4FYYTXVE-lQVqqalpyCG5Tes0zUi4QVyJXmvq8A>
    <xmx:rWjAaTdbJe6zY2Baj2vvWyChBDomOtKjJYYRMgfqESEPmo9YTr9A6Zwa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 18:09:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,  j6t@kdbg.org
Subject: Re: [GSoC PATCH WIP RFC v3 1/3] graph: add --graph-lane-limit option
In-Reply-To: <20260322203801.637769-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Sun, 22 Mar 2026 21:37:59 +0100")
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
	<20260322203801.637769-1-pabloosabaterr@gmail.com>
Date: Sun, 22 Mar 2026 15:09:48 -0700
Message-ID: <xmqqeclb7byr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Repositories that have many active branches produce very wide outputs
> with 'git log --graph --all' making it difficult to read.

If you have active branches, whether they are merged to some very
small number of integration branches or they are left updating
without getting merged for a long time, you'd end up getting very
wide output from "log --all --graph"?  Or is this a problem only
when these active branches are merged and having to show merge
commits create the need for wider output?  I cannot quite see which
from the above description.

>
> Add MINIMUM_GRAPH_COLUMNS = 1

This unfinished sentence looks a bit out of place.  It is unclear
how that variable about "columns" related to "lane" that is
introduced in the next paratraph.

> Add '--graph-lane-limit=<n>' to the revision options, this option
> needs --graph explicitly and rejects values under MINIMUM_GRAPH_COLUMNS.

"and rejects values under ..." -> "has to be at least 1".  And the
previous paragraph that consists of a single unfinished sentence can
be discarded.

The implementation detail that you happened to choose a C
proprocessor macro instead of hardcoded constatnt to write the lower
limit is not something readers of the log message needs to know.
They can see that in the "log -p" output easily.  

What is more helpful for readers to know is what you mean by
"graph-lane", what you are counting, and why you want its lower
limit to 1 (instead of 0 or 2).  These reasoning behind the design
is much more important to record to help future developers who want
to fix bugs in this code or who want to extend the feature this code
adds, without violating the underlying assumption and design goals
of the original author (i.e., you).

> Add graph_max_lanes to rev_info and store what the user set
>
> Add graph_needs_truncation() and teach it to know when a column is
> over the limit following graph_max_lanes, if the limit is 0, treat it like
> no limit.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  graph.c    |  6 ++++++
>  graph.h    |  2 ++
>  revision.c | 11 +++++++++++
>  revision.h |  1 +
>  4 files changed, 20 insertions(+)
>
> diff --git a/graph.c b/graph.c
> index 26f6fbf000..a95c0a9a73 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -317,6 +317,12 @@ struct git_graph {
>  	struct strbuf prefix_buf;
>  };
>  
> +static int graph_needs_truncation(struct git_graph *graph, int col)
> +{
> +	int max = graph->revs->graph_max_lanes;
> +	return max > 0 && col >= max;
> +}
> +
>  static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
>  {
>  	struct git_graph *graph = data;
> diff --git a/graph.h b/graph.h
> index 3fd1dcb2e9..9a4551dd29 100644
> --- a/graph.h
> +++ b/graph.h
> @@ -262,4 +262,6 @@ void graph_show_commit_msg(struct git_graph *graph,
>  			   FILE *file,
>  			   struct strbuf const *sb);
>  
> +#define MINIMUM_GRAPH_COLUMNS 1
> +
>  #endif /* GRAPH_H */
> diff --git a/revision.c b/revision.c
> index 31808e3df0..aeddf2d166 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2605,6 +2605,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--no-graph")) {
>  		graph_clear(revs->graph);
>  		revs->graph = NULL;
> +	} else if ((argcount = parse_long_opt("graph-lane-limit", argv, &optarg))) {
> +		int max_lanes = parse_count(optarg);
> +		if (max_lanes < MINIMUM_GRAPH_COLUMNS)
> +			die(_("minimum lanes is %d, cannot be set to %d"),
> +			    MINIMUM_GRAPH_COLUMNS, max_lanes);
> +		revs->graph_max_lanes = max_lanes;
> +		return argcount;
>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
>  	} else if (!strcmp(arg, "--no-encode-email-headers")) {
> @@ -3172,6 +3179,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  
>  	if (revs->no_walk && revs->graph)
>  		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
> +
> +	if (revs->graph_max_lanes > 0 && !revs->graph)
> +		die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
> +
>  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>  		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
>  
> diff --git a/revision.h b/revision.h
> index 69242ecb18..597116f885 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -304,6 +304,7 @@ struct rev_info {
>  
>  	/* Display history graph */
>  	struct git_graph *graph;
> +	unsigned int graph_max_lanes;

This is "unsigned int"; don't we want the other places (like the
on-stack local variable handle_revision_opt() uses to parse the
value from the command line) and the parameter used in
graph_needs_truncation() helper function all consistently use the
same type?

>  	/* special limits */
>  	int skip_count;
