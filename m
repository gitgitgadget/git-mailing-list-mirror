Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A02F8E8F
	for <git@vger.kernel.org>; Sat,  9 May 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360481; cv=none; b=kK3myPgUypCHhUyWuwQnTZTC/9pd2Nw7+QNZ8FmgcfTAF5wei80vFctab1dXl6dBOxxQyanKa8aU94pxp7jZo3Ow5BbcynBVnpETYAR9d++HFwnF+a6/EbylKPX7rcQJR3DkZU/ihB44f0Z8rgfweS5TlFk4DUeMW3mgo3CqD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360481; c=relaxed/simple;
	bh=RI2JGKJXnKBObeW/2FwTPtgmjkrMbvpFMHb8M/R6LJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjFTgV6i1z6AgmBSatChWxtaxQhcIB5ykZNRU6GGIGSZyeRNL4bQ+n0DoQKVpALSDh+XLA6BP/rLr1As2HhJNAhB9ZJKnufOHqvP0FoM/WRcVTkU447WRoOoT1PWKITW9tlHobB/3JpHinNd6qrgGr/aul8w+bqeH0JwAylb6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jeSyZVo2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUXq4n3C; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jeSyZVo2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUXq4n3C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D080D7A0088;
	Sat,  9 May 2026 17:01:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 09 May 2026 17:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778360477; x=1778446877; bh=9whQhcc7Hv
	iXtlX2PuFol2OZifB4L2oEWO3Z5zC4SyA=; b=jeSyZVo2VahoHw2DZqUTj0mqFd
	6N7VQYvBml94Lq/tgpYlfCstBFL+pXHPk/mhv+g6R/Ch362hxciPelRWab8X8tPT
	UOFOjbPXLlkTafogFBiKrRo3zv/yVn0BGh3BRTJ3EkXJadAjzifV2OZk+Ks3hBLT
	MZUh+qPkdJWrtg3wdyuiKFXCvu+a2AIQD0m7hy/rR7QurCcwiPkhrrf+OHfIQfrh
	sp0dz+KFO2qIm+t7Wp7EpGnHgNuU+4SXumhYGpuDrjIwZQ4ImoXek+q90C/YYL38
	3zdihL9/4LNJJFBagKU6+uPLals8Qd/PlWnpDYJ6iTbVPosLQyHNJggqup4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778360477; x=1778446877; bh=9whQhcc7HviXtlX2PuFol2OZifB4L2oEWO3
	Z5zC4SyA=; b=nUXq4n3COeIElJ8O7bebH09YF5gvtxaSp7zti4GoQSNrUvH0v+3
	BN6kYT+gg2woojGsGcDAetc040p6xIBV6coKHlQdmKFBtu5H1zTqp4gj9WwbzNbW
	mEoMA9uFB8AVhFH7032HgY/Wl1a+wh1yIGXd0YLJ5af2zHt4KQgwddWqiRa2wnnx
	D16+DsTheHZsEJXN2K5wdgEySotLc0w3PauNKGjN90+YYA/TON/LtE8h2bTVL+9l
	iMHzHxBRjTAcrgIS1CGCUXm8pqp7mIE71pFnCRiCItzkHAaSJoLUrwjN/1ZZ+xjL
	us7Np32Vh1BwtxMMlSaZPC/QaSKySB2Nvew==
X-ME-Sender: <xms:naD_aX7R5xpafqEhXJ5l3M5WEkvtpYJVXjjaUiIRDSN8pOuOGK1WFg>
    <xme:naD_aZdN35aVzsR75QnjkL5i0W6rHa9nra-Gmy0_mg-L98QmgrAXWAA5_6emcIG-e
    lXUxXSWdakS09J2M-azJTTiiqP2eMj_qx-qYdqjQ69iFNVlChU9BA>
X-ME-Received: <xmr:naD_aS7so8ngfuCDFibLmv0qxFvo0ewGoatE72P19j2_ziFHxsylMu0p5lKovQmiwooPMhb276lTuObFLyTIW1e21v3wr5900g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhn
    rdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgv
    khesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:naD_ae_k2e9qdMMOigAZcU6bnQHesg0HNxKYAXntzVNc0dxnT1-tDg>
    <xmx:naD_acEL543Y5z39W_emUjksEY7O-7PMwiP6YWvt8FlbtwUCXCX_VA>
    <xmx:naD_abXe3QxtZFbkS8BvDeicInKLoqb7GxvYmF9Q39W7_SQ4q7nr3A>
    <xmx:naD_aQ_aKqm5-JzHvvz-wuWhX9W3s3BVJEs-JlPzVvyP-NYYntorrw>
    <xmx:naD_adcvaObivjk8tt-U19Kl7lWeTa0KEzYJ0f3mNhEYYOceRE0SBYMh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 17:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
In-Reply-To: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
	(Mirko Faina's message of "Tue, 5 May 2026 23:54:56 +0200")
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
	<ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
Date: Sun, 10 May 2026 06:01:15 +0900
Message-ID: <xmqqcxz4b8mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to do something like
>
>     git log $(git rev-list HEAD | tail -n N | head -n 1)
>
> This is not very user-friendly.
>
> Teach get_revision() the --max-count-oldest option.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Since v5 I've reworded the commit message and rewrote the docs for
> --max-count-oldest to be clearer on its functionality.
>
>  Documentation/rev-list-options.adoc |  5 ++
>  revision.c                          | 77 +++++++++++++++++++++++++++--
>  revision.h                          |  2 +
>  t/t4202-log.sh                      | 14 ++++++
>  4 files changed, 95 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 2d195a1474..9f857cabcc 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -18,6 +18,11 @@ ordering and formatting options, such as `--reverse`.
>  `--max-count=<number>`::
>     Limit the output to _<number>_ commits.
>  
> +`--max-count-oldest=<number>`::
> +   Just like `--max-count=<number>`, it limits the output to _<number>_
> +   commits. But instead of limiting to the first _<number>_ commits it
> +   limits to the last _<number>_ commits.
> +
>  `--skip=<number>`::
>     Skip _<number>_ commits before starting to show the commit output.

Saving this message to a file and grepping for a tab finds nothing,
which indicates that the patch seems to be unsalvageably whitespace
broken, given that most of the context lines should use tabs for
indent.

What did you do differently this time?  The previous rounds did not
have this problem.


> diff --git a/revision.c b/revision.c
> index 599b3a66c3..3aaa77ced5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>     }
>  
>     if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
> +       if (revs->max_count_type == 1)
> +           die(_("can't use --max-count with --max-count-oldest"));
>         revs->max_count = parse_count(optarg);
>         revs->no_walk = 0;
> +       revs->max_count_type = 0;
>         return argcount;
> +   } else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
> +       if (revs->max_count_type == 0 && revs->max_count != -1)
> +           die(_("can't use --max-count with --max-count-oldest"));
> +       if (revs->skip_count > 0)
> +           die(_("con't use --max-count-oldest with --skip"));
> +       revs->max_count = parse_count(optarg);
> +       revs->no_walk = 0;
> +       revs->max_count_type = 1;
> +       revs->max_count_stage = 0;
>     } else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
> +       if (revs->max_count_type == 1)
> +           die(_("con't use --max-count-oldest with --skip"));
>         revs->skip_count = parse_count(optarg);
>         return argcount;
>     } else if ((*arg == '-') && isdigit(arg[1])) {
> @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>     return c;
>  }
>  
> +static void retrieve_oldest_commits(struct rev_info *revs,
> +                   struct commit_list **queue)
> +{
> +   struct commit *c;
> +   int max_count = revs->max_count;
> +   int queuei_count = 0;
> +   int queueo_count = 0;
> +   struct commit_list *queueo = NULL;
> +   struct commit_list *queuei = NULL;
> +   struct commit_list *reversed_queue = NULL;
> +
> +   revs->max_count = -1;
> +   while ((c = get_revision_internal(revs))) {
> +       c->object.flags &= ~SHOWN;
> +       commit_list_insert(c, &queuei);
> +       queuei_count++;
> +       while (queuei_count + queueo_count > max_count) {
> +           if (!queueo_count) {
> +               while (queuei_count > 0) {
> +                   c = pop_commit(&queuei);
> +                   queuei_count--;
> +                   commit_list_insert(c, &queueo);
> +                   queueo_count++;
> +               }
> +           }
> +           pop_commit(&queueo);
> +           queueo_count--;
> +       }
> +   }
> +
> +   while ((c = pop_commit(&queueo)))
> +       commit_list_insert(c, &reversed_queue);
> +   while ((c = pop_commit(&queuei)))
> +       commit_list_insert(c, &queueo);
> +   while ((c = pop_commit(&queueo)))
> +       commit_list_insert(c, &reversed_queue);
> +
> +   while ((c = pop_commit(&reversed_queue)))
> +       commit_list_insert(c, queue);
> +}
> +
>  struct commit *get_revision(struct rev_info *revs)
>  {
>     struct commit *c;
>     struct commit_list *reversed;
> +   struct commit_list *queue = NULL;
> +
> +   if (revs->max_count_type == 1 && !revs->max_count_stage) {
> +       retrieve_oldest_commits(revs, &queue);
> +       commit_list_free(revs->commits);
> +       revs->commits = queue;
> +       revs->max_count_stage = 1;
> +   }
>  
>     if (revs->reverse) {
>         reversed = NULL;
> -       while ((c = get_revision_internal(revs)))
> -           commit_list_insert(c, &reversed);
> +       if (revs->max_count_type == 1)
> +           while ((c = pop_commit(&revs->commits)))
> +               commit_list_insert(c, &reversed);
> +       else
> +           while ((c = get_revision_internal(revs)))
> +               commit_list_insert(c, &reversed);
>         commit_list_free(revs->commits);
>         revs->commits = reversed;
>         revs->reverse = 0;
> @@ -4543,7 +4610,11 @@ struct commit *get_revision(struct rev_info *revs)
>         return c;
>     }
>  
> -   c = get_revision_internal(revs);
> +   if (revs->max_count_stage)
> +       c = pop_commit(&revs->commits);
> +   else
> +       c = get_revision_internal(revs);
> +
>     if (c && revs->graph)
>         graph_update(revs->graph, c);
>     if (!c) {
> diff --git a/revision.h b/revision.h
> index 584f1338b5..e157463cb1 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -309,6 +309,8 @@ struct rev_info {
>     /* special limits */
>     int skip_count;
>     int max_count;
> +   unsigned int max_count_type:1;
> +   unsigned int max_count_stage:1;
>     timestamp_t max_age;
>     timestamp_t max_age_as_filter;
>     timestamp_t min_age;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 05cee9e41b..668c231cf1 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1882,6 +1882,20 @@ test_expect_success 'log --graph with --name-status' '
>     test_cmp_graph --name-status tangle..reach
>  '
>  
> +test_expect_success 'log --max-count-oldest=3 --oneline' '
> +   test_when_finished rm expect &&
> +   git log --oneline | tail -n3 >expect &&
> +   git log --oneline --max-count-oldest=3 >actual &&
> +   test_cmp expect actual
> +'
> +
> +test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
> +   test_when_finished rm expect &&
> +   git log --oneline | tail -n3 | tac >expect &&
> +   git log --oneline --max-count-oldest=3 --reverse >actual &&
> +   test_cmp expect actual
> +'
> +
>  cat >expect <<-\EOF
>  * reach
>  |
