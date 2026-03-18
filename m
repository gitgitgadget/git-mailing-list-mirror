Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D03E3D86
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849931; cv=none; b=Yko2xxnxdr+1DpCQGMcH0rFiAdL3020AmJze7vkLkb/BCnNrrRvyuYEwp0O5F7hIlWUd/hi5O26CwJgcFqIDaONM/4iNsK27UxZb+tf7ce90zI9kdtOQBL1JklX1akjbOAhNQOAbwcUunu59An25UOXOJd/YwmVo2NqBtPi+luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849931; c=relaxed/simple;
	bh=iP43RjDnFG+uNd6sfYHclKhkrvHuUcTnAW+Ba9jxNx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSsMG7IJWgpcpSMxKK/1VEkOVvblWte9rgt4p3P+UmvWyqeMFahTvvVsdao1eujlkc+KtnEEFHmoY6LIIjRFnKrYnviqVOQybbc1R9vuAFiJ2rzFOZKYtDQi2PrVBKvwc631yl8TJ/Bq8akQk4tVEsglOAh25f1XgzeWdEyc8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L9rAFhEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnWWf4rK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9rAFhEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnWWf4rK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B74E140007D;
	Wed, 18 Mar 2026 12:05:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773849920; x=1773936320; bh=dkOHnX16QS
	sn153Hrfl/mksGzQFCzY0ghhhal/V4HrI=; b=L9rAFhEXcJc44t9u1yLl4gjEXO
	ycBxuNTzFM27l2MkiDc7S5C6zbx7QfYgiFAw2tsFFQAtrMUJ6aHoct0GVHQtZJ5C
	YbOwR+1RXTbP8ocAEYZZ1aX2nwH4OMUa5kS0CGzHR4VLEANXeMqNsLnHQlPX4tdD
	KZxw/lANExvzNqRPYOqNa6O1HMLofWZZfgz9sDmRsGURkQcXuL7xC2Z1iPYGEWUN
	nPVYfbKrGWeVVg/F7YEJ1YGZAubR+h6nbOq0t1TWDqeJ6AOMt0R8Jm3WJOqVYK2c
	/AKBsvBdWQBygNdzwlzp8Lf5fdy1q9py/3pAZLO5HruhgAYy7nwS1bVYM7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773849920; x=1773936320; bh=dkOHnX16QSsn153Hrfl/mksGzQFCzY0ghhh
	al/V4HrI=; b=hnWWf4rKm5BKDupPD7MF1evIDw7eCdEb47PEjTnU6McPtmA5n8F
	1+I1QgvnIaCrKX4tYjlzW+DRTHIht3mE+Z3M4PiFP70RyMsssADYWU233YHPiW90
	BEaQGbbuo84xAqAWAtZlOXl7CTnerFxVahFeOnmfp01jpEV/C1Lwjc+aI4lX5kDT
	jNcYDE215av+KendEpxIm+OZJZLDze7VAUa5nGbYAmqdriKUYJR3tGJ8GeVgPz+G
	H9Y01lm5h/P7DhkqGCSreata9krVgYdS41oX9q+l005HOwNWG9THe4NVrSbbrFa4
	aVkG4g7wC0y5mukHh3BcVmvHPsOIazw/RYw==
X-ME-Sender: <xms:QM26ac5-aMMwfWfgBGH6i60DILqivBMKEgQH67fzfwXZeZ4suwZa6g>
    <xme:QM26aQfyBtKjWaAWEAOEdbsLkq1oUbbauLbQBDUmI3IQiuVQYF0LNJcWiaK8wZcIn
    od_AZVVmWUWw_VL34zoLR_Ep7Udlc-prPlrEkSuqhcOE2ph8N7hzm4>
X-ME-Received: <xmr:QM26afEr-WHSyoOpKqC7zlhMmSF1d48rPSo3zZrrr9ihsSD-MXDw6fHJtlEOC8KDpuSeZjPNKDJaSoVa5HRTrz3iNntcl0J08g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QM26aRTxSiIFN7aKt7n2sP8VOU954ku5diJ_D6vqM9J2NFbxcwI5Ig>
    <xmx:QM26aVbNcAaMZIT1bgSUFHfV2u2BDQuIy8-WKoun0nxC73nFKmTtoA>
    <xmx:QM26ac1nbAfrbr-acGVpoiir3mNoJItQV_qxCsqttqqTgRj7FhocTw>
    <xmx:QM26aYpcbc6nXHzh-hyJ8qH6Rl9m5isaDLbix6knm1HkkgWTvJSdLg>
    <xmx:QM26aSHmwamJ0RP_pmbF91RfG25JyPKiLhq672rmc9AQKn7BLEO0jEWl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:05:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC RFC PATCH v2] graph: add --max-columns option to limit
 displayed columns
In-Reply-To: <20260317220929.120746-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Tue, 17 Mar 2026 23:09:29 +0100")
References: <20260316133426.117684-1-pabloosabaterr@gmail.com>
	<20260317220929.120746-1-pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 09:05:17 -0700
Message-ID: <xmqqzf45gm2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Repositories that have many active branches produce very wide
> outputs with 'git log --graph --all', makes it difficult to read.

"making it difficult"?

> Add '--max-columns=<n>' to limit the columns shown. Columns over
> the limit are replaced with a '.' truncation indicator. This only
> affects the visual rendering.

Being an option to "git log", I expect that readers would naturally
take "--max-columns=<n>" to refer to the total display width
consumed by the entire output including the log messages and
possibly patches when the command is run with the "-p" option,
whether the ancestry graph is shown or not.

But somehow I suspect that it is not what is going on here.

If this <n> refers to the width of graph part only, the option name
should hint that fact somehow.  Perhaps include the word "graph" in
it, or something.  As you use the verb "limit" below, perhaps
"--limit-graph-columns=<n>"?

> The commit mark '*' is only shown in two cases:
> - The commit is in a branch inside the limit.
> - The commit is in the first hidden branch, in this case '.'
>   is replaced by '*'.

> Commits on deeper hidden branches do not show '*' but the commit
> subject is still shown, so no information is lost.

Isn't "no information is lost" a huge exaggeration?  We are losing
the ancestry information by not drawing graph lines, aren't we?

> The original idea to limit columns was noted as a TODO in
> c12172d2ea (Add history graph API, 2008-05-04), which mentions
> gitk's behavior. This does not implement gitk-style column
> rearrangement; it only truncates the visual output.

True.  

IIRC, Gitk also allows you to click the chopped arrow-head to jump
to the other end of the omitted ancestry line, which is very useful
but is hard to do on a terminal output that is not interactive.

> git log --graph --all --oneline --max-columns=2
> *   b81d099 (M_1) 7_M1
> |\
> | | * 2d96ba0 (M_3) 7_M2
> | | .

I would call this output consuming 5 columns for graph part, not 2.
For end users, being able to specify 2, i.e., being able to say "I
tolerate wasting display columns to show up to two ancestry lines"
(or "two lanes of ancestry information"), is indeed a lot more
intuitive than having to say "You are allowed to use up to 5 display
columns", so I do not object to an option that takes "2" as its
value and produces the above output, but I am not sure if we want to
have "columns" in the name of such an option; "--limit-graph-lanes=2"?

> - I think --max-columns is a good name, but it does not have --graph
>   prefix, bcs it can only be on --graph I think it's clear enough.

If "git log --max-columns=77" ignores the option because "--graph"
is not given, it would be confusing to the users.

> +	/*
> +	 * If graph_max_columns is set, cap the padding from the branches
> +	 */
> +	if (graph->revs->graph_max_columns > 0) {
> +		int truncation = graph->revs->graph_max_columns * 2 + 2;

This needs a bit more commenting to explain where these magic
numbers come from; they are of the same value 2 but have different
meanings, right?  Like this (only to illustrate the shape, not
suggesting what the contents should read):

		/*
		 * Each ancestry "lane" occupies 2 columns, and
		 * we leave two columns before drawing the commit
		 * title and log message part.
		 */
		int max_column_width = 
			graph->revs->graph_limit_lanes * 2 + 2;

> +
> +	if (revs->graph_max_columns > 0 && !revs->graph)
> +		die(_("option '%s' requires '%s'"), "--max-columns", "--graph");

The naming is so selfish.  Among "git log" options that exists and
that will be added in the future, this design decision declares that
"--graph" is and will remain to be the only one that may want to
specify the maximum number of columns to spend.

If the option is named clearly to be related to the "--graph"
feature, another way to go is to make it imply "--graph".  If the
user says "I want to limit the graph output to consume no more than
10 leftmost columns", it is clear that the user expects the graph to
be shown.
