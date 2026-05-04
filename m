Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0ED199931
	for <git@vger.kernel.org>; Mon,  4 May 2026 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777872015; cv=none; b=YwVZijS+LncOLaZ2Prw2M9tDVYY3itDklbOY/U1UXlg/XYViW1vmN1ogW2MBzulIXRQ5LAM9yjV/rfC3yb3Qclp8g5H+koAfIoHahGJqHalId80B+h/NDFBjCISGYGutOZeNKbGZBktB9PDUkagm/0vY4OF7hQBNRWhRsF+Duds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777872015; c=relaxed/simple;
	bh=vyUb+78Lt8tpN22BMpF6qf47bvROU2fwYY/F0E6jZFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQgXtqDd63TRyP5HjzoSt1w5idSRy7f3IhywbsF1DB3n1IDqGCZEOYQP6z5WTjHjg1RMMR+TkabfkxR8Xhe3AwWM832XtGItBcFt7fqY+q6PtVLBzy9OM5/fkM+CQZAt+rAndzSNNjAZQ0H5eP2ggXeD0oJKvq8GYiKl6mmeepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+wt9KpV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9ehH0Xk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+wt9KpV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9ehH0Xk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A68A7A009D;
	Mon,  4 May 2026 01:20:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 01:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777872005; x=1777958405; bh=0x3JT/iOEz
	mY0X6BPW1s3FD9GXxoc0bYBkUKbwKUOt8=; b=c+wt9KpVtfdldK2Fs3Hek6FIoM
	mfuygl1v5PIn/uX0GIHdAULozrfb7uwc0+Gm+LHzxvDqGbJSH5FlEvZonHldu6uG
	12E8eueOI4GsQoR8Z6RsgR6OYeqJr1g5vUeUckyBhyXmrSNkq058QSPUTZfBd/gJ
	AfJ/5TfMijNxjTnVDVV1vXLVJ7/0+j4/Ltb7ZsVQvgECC7TQuPcuicCh3retqw9x
	b+sNW9eJnamIoIBziahf2dfNELb4JGlgwd75s2JvB+d6bw6QaKlKAtMWUZqIk9OV
	uzrZBm6zHM/LxHJHWqJhAOwTSiVg48qjoSehJgi5gAWRUK8HrcZtn1DTlstw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777872005; x=1777958405; bh=0x3JT/iOEzmY0X6BPW1s3FD9GXxoc0bYBkU
	KbwKUOt8=; b=Y9ehH0XkG+op8HMPtWJwhUg2wThLQMPVsCg1jmwK7ZHC8Q6m/W2
	sQUyuDutfTAPeg/SlzYfKiFU8bVxmrDYYOQ5nVr/reEPrTkXUfTtxVdcvbeHKtHi
	mhIRYLWo0WtgERJ/OPmUaWQ/MpF95Luy5zXxj4vPgYOIGPJXh988i5SUFGmesaFn
	Y8wdF1gohCUqCn0p4MAD81VCwgI5I1FHQjVd7InibyNSMZY0McLuI/FQUbWawS29
	0C6VUPov2SsO7i5Uc1kc09sibEVa2CF+Cf5Occf7m5MG6yqelPr+f+J/FiZiIdye
	Q9/F+rV9GxpHfWN0gtWM2K6mUNHAu+dfF6g==
X-ME-Sender: <xms:hCz4aeNEHF5WFc7bPpykKggjwUNAwIzEUUpcqNkIao4ThP2cngAtZQ>
    <xme:hCz4aZgt_UrULVlHsSxsBQTgsbzIp2Vghhwsvw2fjvmEK4JWzFwq4E1CXZXpP7MbX
    Eh5I10KdEnHXVVwQ_3-_Fag_Op8H1ReYnhLk5lNzEwDik0eUiFK>
X-ME-Received: <xmr:hCz4aZsyibBRKapaPS4bH9pmn-qiAYeh4z7WoaQjmeE7R6xJmKjXSFaXtknZscIMntol6-SrUNkj0OC8ErfCzea4JQvBVK2HVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptggrthesmhgrlhhonhdr
    uggvvhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegthhhrihhsrdhtohhrvghk
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hCz4aVjPOq_tEAO7jEXy1lTUzvyB-L2zc8iN_giEIllY2sJhPo6f2A>
    <xmx:hCz4aXYwkUOTJ3MHAyV55KmMF_DlSZveudVpgPkmtqjo8UW0E_8g-g>
    <xmx:hCz4acYdJhD3THn3hPHcfroShN5PwamUFfEa6J3ww1do2mOKdOrZYA>
    <xmx:hCz4aUz6QtmxoosxwGDg-e7A9Zya2CU_B2XalW9q52L2bKsZrubDNw>
    <xmx:hSz4aXRjpWCM1ZoAmvk85qIB9a8UnmB9hT45QYoUGXNUI3Q5n26vwJ_M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 01:19:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v5] revision.c: implement --max-count-oldest
In-Reply-To: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 30 Apr 2026 21:52:45 +0200")
References: <cover.1777249165.git.mroik@delayed.space>
	<2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
Date: Mon, 04 May 2026 14:19:47 +0900
Message-ID: <xmqqik93px8s.fsf@gitster.g>
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
> history (the oldest commits) they'd have to combine --max-count with
> --skip. This is not very user-friendly.

To use "--skip=<n>" for this purose, you'd need to know how many
records are going to be omitted to begin with, but that means you'd
run the command without count limitation once only to find out how
many records there are.  "not very user-friendly" sounds like an
understatement of the year.

They can do with something silly like

    git rev-list ... |
    tail -n N |
    xargs -n1 git show ...

and that does count as "not very user-friendly", I would think.

> Teach get_revision() the --max-count-oldest option.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/rev-list-options.adoc |  3 ++
>  revision.c                          | 77 +++++++++++++++++++++++++++--
>  revision.h                          |  2 +
>  t/t4202-log.sh                      | 14 ++++++
>  4 files changed, 93 insertions(+), 3 deletions(-)

It looks like this needs measurably smaller damage to the codebase
than the other --reverse=before approach ;-).

> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 2d195a1474..736f34efab 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -18,6 +18,9 @@ ordering and formatting options, such as `--reverse`.
>  `--max-count=<number>`::
>  	Limit the output to _<number>_ commits.
>  
> +`--max-count-oldest=<number>`::
> +	Limit the output to the _<number>_ oldest commits.
> +
>  `--skip=<number>`::
>  	Skip _<number>_ commits before starting to show the commit output.
>  
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..3aaa77ced5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	}
>  
>  	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
> +		if (revs->max_count_type == 1)
> +			die(_("can't use --max-count with --max-count-oldest"));
>  		revs->max_count = parse_count(optarg);
>  		revs->no_walk = 0;
> +		revs->max_count_type = 0;
>  		return argcount;
> +	} else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
> +		if (revs->max_count_type == 0 && revs->max_count != -1)
> +			die(_("can't use --max-count with --max-count-oldest"));
> +		if (revs->skip_count > 0)
> +			die(_("con't use --max-count-oldest with --skip"));
> +		revs->max_count = parse_count(optarg);
> +		revs->no_walk = 0;
> +		revs->max_count_type = 1;
> +		revs->max_count_stage = 0;
>  	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
> +		if (revs->max_count_type == 1)
> +			die(_("con't use --max-count-oldest with --skip"));
>  		revs->skip_count = parse_count(optarg);
>  		return argcount;
>  	} else if ((*arg == '-') && isdigit(arg[1])) {
> @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  	return c;
>  }
>  
> +static void retrieve_oldest_commits(struct rev_info *revs,
> +				    struct commit_list **queue)
> +{
> +	struct commit *c;
> +	int max_count = revs->max_count;
> +	int queuei_count = 0;
> +	int queueo_count = 0;
> +	struct commit_list *queueo = NULL;
> +	struct commit_list *queuei = NULL;
> +	struct commit_list *reversed_queue = NULL;
> +
> +	revs->max_count = -1;
> +	while ((c = get_revision_internal(revs))) {
> +		c->object.flags &= ~SHOWN;
> +		commit_list_insert(c, &queuei);
> +		queuei_count++;
> +		while (queuei_count + queueo_count > max_count) {
> +			if (!queueo_count) {
> +				while (queuei_count > 0) {
> +					c = pop_commit(&queuei);
> +					queuei_count--;
> +					commit_list_insert(c, &queueo);
> +					queueo_count++;
> +				}
> +			}
> +			pop_commit(&queueo);
> +			queueo_count--;
> +		}
> +	}
> +
> +	while ((c = pop_commit(&queueo)))
> +		commit_list_insert(c, &reversed_queue);
> +	while ((c = pop_commit(&queuei)))
> +		commit_list_insert(c, &queueo);
> +	while ((c = pop_commit(&queueo)))
> +		commit_list_insert(c, &reversed_queue);
> +
> +	while ((c = pop_commit(&reversed_queue)))
> +		commit_list_insert(c, queue);
> +}
> +
>  struct commit *get_revision(struct rev_info *revs)
>  {
>  	struct commit *c;
>  	struct commit_list *reversed;
> +	struct commit_list *queue = NULL;
> +
> +	if (revs->max_count_type == 1 && !revs->max_count_stage) {
> +		retrieve_oldest_commits(revs, &queue);
> +		commit_list_free(revs->commits);
> +		revs->commits = queue;
> +		revs->max_count_stage = 1;
> +	}
>  
>  	if (revs->reverse) {
>  		reversed = NULL;
> -		while ((c = get_revision_internal(revs)))
> -			commit_list_insert(c, &reversed);
> +		if (revs->max_count_type == 1)
> +			while ((c = pop_commit(&revs->commits)))
> +				commit_list_insert(c, &reversed);
> +		else
> +			while ((c = get_revision_internal(revs)))
> +				commit_list_insert(c, &reversed);
>  		commit_list_free(revs->commits);
>  		revs->commits = reversed;
>  		revs->reverse = 0;
> @@ -4543,7 +4610,11 @@ struct commit *get_revision(struct rev_info *revs)
>  		return c;
>  	}
>  
> -	c = get_revision_internal(revs);
> +	if (revs->max_count_stage)
> +		c = pop_commit(&revs->commits);
> +	else
> +		c = get_revision_internal(revs);
> +
>  	if (c && revs->graph)
>  		graph_update(revs->graph, c);
>  	if (!c) {
> diff --git a/revision.h b/revision.h
> index 584f1338b5..e157463cb1 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -309,6 +309,8 @@ struct rev_info {
>  	/* special limits */
>  	int skip_count;
>  	int max_count;
> +	unsigned int max_count_type:1;
> +	unsigned int max_count_stage:1;
>  	timestamp_t max_age;
>  	timestamp_t max_age_as_filter;
>  	timestamp_t min_age;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 05cee9e41b..668c231cf1 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1882,6 +1882,20 @@ test_expect_success 'log --graph with --name-status' '
>  	test_cmp_graph --name-status tangle..reach
>  '
>  
> +test_expect_success 'log --max-count-oldest=3 --oneline' '
> +	test_when_finished rm expect &&
> +	git log --oneline | tail -n3 >expect &&
> +	git log --oneline --max-count-oldest=3 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
> +	test_when_finished rm expect &&
> +	git log --oneline | tail -n3 | tac >expect &&
> +	git log --oneline --max-count-oldest=3 --reverse >actual &&
> +	test_cmp expect actual
> +'
> +
>  cat >expect <<-\EOF
>  * reach
>  |
