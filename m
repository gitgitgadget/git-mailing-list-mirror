Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DF21767A
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990781; cv=none; b=INaTKRekr4BuJDxZVOPAj0aYNhrcVne3k87KkZmGa93wVYBjRHd98+oVEDoMh2WAd52Ydk06zUBVJN727C2fvcbBjkYIOtvByAJJfWE8/y8Uhk92PydfLlXsWdKj6hoAU7duTAHLLAXzkvPVeW/zFHnVAQxaqiV9Q6x2lZBrtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990781; c=relaxed/simple;
	bh=P1MhxbK6i1eAyUEeWFOzjGII2dIVvhc2dDE+UtWdNaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5nTk8RCfedoxSw8wWq5WRk63qeLMZaS2xod2qlb9fp3IUuTW9N0luaHVAmQLj50ZCadkABlp654TKKO7PiSrJk4oVEgPXDNVfnDmCcR6jBO6odzmqsehMi5DORNHmTxnasDlPHmoau+RUtMI4KdZ7tQWlogyl0yuAIgxaNlFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fmytw/NK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UpCVPAG4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fmytw/NK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpCVPAG4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E366B1D00065;
	Sat, 27 Sep 2025 12:32:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 27 Sep 2025 12:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758990777; x=1759077177; bh=WkyQNdp3d2
	akR2ajRdafWxd9gjZLkdzKAT0XMxkVsSs=; b=fmytw/NK25HNuu9Va9j60fyIgg
	/SlKSW1VO3EN1QUJf++US17/SeX54q+rXjoZigJeUBM9dDSVzlHBKjA3+08erTQD
	M+fPKP5jLSKlM06BXnPEfxi4YU7gjtdjkTpBOe8KSXhUCAYaZvpYNPBYINK3NHr0
	sCbUriH7XFDMe8RXjhVKVjcBrVFCxCI8NsVbMDBwuNYBoMYQWt/9P5OZAh7/X50P
	0nfqC2+9jHuzQTkngxni2TvhpFHqYphWMCWpIWksKK0QrqTtTq6Xi2zqwtpoGOTN
	ncEK6OG08NofOluyEDMfXAcQEhVxnMGEyAlyVDhm5MYStvHYDeCxrXgzhpoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758990777; x=1759077177; bh=WkyQNdp3d2akR2ajRdafWxd9gjZLkdzKAT0
	XMxkVsSs=; b=UpCVPAG4NbTEeIaPpGp2ULX+3xIJmW92nlyAY1vs1BMT2l1glVX
	1jO8CosLuI4Ev4iC5iYxr11VzbxQell6KclHjFm9O/xQpvSBTlD+Gqg2gB4AeHlx
	wxHkEwkJmJKZBgTaj5ThLcRlkgCcycJTvRR87D58+E+Vb9dAet8N1eRY2ZcyL4/x
	b75elVKNMap3c4QVt2wg2qeRCJm+sg9oIxx3HweG3qaQJ2WkLsc9TkvI1DCu14Ux
	BeiEwgSVc1zNfKlA2+WgyhFezOd4I0Bvc9dTjR6E76nD83PnvcYES1kpNGiatjPV
	hmOdbHad6mVeZeW9sNW0V/lWXFK0jbfz5zQ==
X-ME-Sender: <xms:uRHYaB8nFsP0CESkGQDQUH4il2Nw8e0WD9A7HGED-sDUq-epRIkh4w>
    <xme:uRHYaH-G9ujsatus2WiwvJblH2x8TLScuGrmygJw848VQaZzDZEraW9ai5GjOaXVi
    Xhoz870sk49Bm2yD3NByl64wVd99M8Z_S2WZS5Eee01Z73kDJU>
X-ME-Received: <xmr:uRHYaBQ6JbjCioRzXljRZq4bAek9QnfZ9Cp_WrKJ-vXgh0XyjJNtzz5Nlv2-XeXdu79DDIlQuONeoZk1hQoOR4xUYkIa0HSDET0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uRHYaLcgJ0sw-SpMWyvfLBY6GuJbJtWEwuDXMkxcqF0H0BccHap7Xw>
    <xmx:uRHYaFAsdkk4P54dQIWjUbMlRmNFgoKvuDbsBrKrAsewWTS-EluxLg>
    <xmx:uRHYaNkdLv-JWsS46Lrljn-_bHYDADRkkWghxwrsrgEfpCN2NA1xfg>
    <xmx:uRHYaAcHWjtJ0h7z4QMLz0gW7DG5BF2Ibze-Lfg59Nplu1wg15rfcw>
    <xmx:uRHYaNnzOMh6mzHLSqksK8UPchfYuIatE0hOsS0SR9RMR8SBWnacagAf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 12:32:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  sunshine@sunshineco.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
In-Reply-To: <20250927145049.723341-5-jltobler@gmail.com> (Justin Tobler's
	message of "Sat, 27 Sep 2025 09:50:46 -0500")
References: <20250925232928.3846-1-jltobler@gmail.com>
	<20250927145049.723341-1-jltobler@gmail.com>
	<20250927145049.723341-5-jltobler@gmail.com>
Date: Sat, 27 Sep 2025 09:32:55 -0700
Message-ID: <xmqqfrc797pk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The shape of a repository's history can have huge impacts on the
> performance and health of the repository itself. Currently, Git lacks a
> means to surface key stats/information regarding the shape of a
> repository via a single command.

Talking about "shape of a repository's *history*" may negatively
affect your goal here.  If a project is overly mergy with many
octopus merges, it would have huge impacts on the performance to run
"git bisect" over its history, so it may be interesting to know the
ratio of the merge commits in the total commits, and also the
average number of merge parents.  But after you obtain such numbers,
you cannot do anything about it, as you cannot afford to rewrite its
history only to improve the "performance and health".

And that is what makes "key stats" relative to your goal.  If your
goal is to give stats on the things you can control (e.g., how long
a typical delta chain is, how many loose objects there are that can
be moved to a packfile, how small would your object database would
become if you prune all the unreachable objects), that would cut off
some stats that may still be interesting but may not contribute to
address "huge impacts on the performance and health".

With Devil's advocate hat on, a single command that gives a set of
stats that are "key" to a goal of a single use case may not be as
useful as a collection of commands, each of which gives stats on one
aspect of the repository, that can be combined to help you address
various different goals.

> To allow users to more readily identify potential issues for a
> repository, introduce the "stats" subcommand in git-repo(1) to output
> stats for the repository that may be of interest to users. The goal of
> this subcommand is to eventually provide similar functionality to
> git-sizer(1), but natively in Git.

So, it is needless to say that the kind of "stats" obtained by such
a single tool needs to be chosen carefully, but more importantly,
its output should give users actionable output, as whoever designed
such a tool and chose what "key stats" are has a clear idea on
various aspects of repository.  "stats" measure the health of the
repository against certain yardstick, but it should come with a
clear instruction to make use of that measurement.  The tool may say
"the stats indicate that you have commits that touch too many paths
at the same time".  The users need to be know what consequence of
that finding is, and what they can do about it.

For example, what would the user do with the new knowledge that the
repository has 100x as many local branches as there are
remote-tracking branches?  Without breaking down these numerous
local branches into those that are still used in active development
(hint: peek into their reflog), kept as historical landmarks, past
development that has already been merged (hint: "git branch --list
--merged origin/master"), or abandoned cruft that hasn't been
touched with some changes that are not merged anywhere, the users
would not know what to do.

> +`stats`::
> +	Retrieve statistics about the current repository. The following kinds
> +	of information are reported:
> ++
> +* Reference counts categorized by type
> +
> ++
> +The table output format may change and is not intended for machine parsing.

Do we eventually want to give another format that is intended for
machine parsing?

In a format meant for human consumption, is it still sensible to
target fixed-column terminals these days?  Rather, would they want
prettier-formatted html, or csv that they can easily import to
spreadsheet?  (these are not objections but genuine questions).

> +static void stats_table_vaddf(struct stats_table *table,
> +			      struct stats_table_entry *entry,
> +			      const char *format, va_list ap)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +	char *formatted_name;
> +	size_t name_width;
> +
> +	strbuf_vaddf(&buf, format, ap);
> +	formatted_name = strbuf_detach(&buf, NULL);
> +	name_width = utf8_strwidth(formatted_name);
> +
> +	item = string_list_append_nodup(&table->rows, formatted_name);
> +	item->util = entry;
> +
> +	if (name_width > table->name_col_width)
> +		table->name_col_width = name_width;
> +	if (entry) {
> +		size_t value_width = utf8_strwidth(entry->value);
> +		if (value_width > table->value_col_width)
> +			table->value_col_width = value_width;
> +	}
> +}

OK, accumulate while measuring, so that you can compute the max
width of these things before writing them out, which is quite
bog-standard way to collect data.

> +static inline size_t max_size_t(size_t a, size_t b)
> +{
> +	return (a > b) ? a : b;
> +}

Heh.

> +static void stats_table_print(const struct stats_table *table)
> +{
> +	const char *name_col_title = _("Repository stats");
> +	const char *value_col_title = _("Value");
> +	size_t name_title_len = utf8_strwidth(name_col_title);
> +	size_t value_title_len = utf8_strwidth(value_col_title);
> +	struct string_list_item *item;
> +	int name_col_width;
> +	int value_col_width;
> +
> +	name_col_width = cast_size_t_to_int(
> +		max_size_t(table->name_col_width, name_title_len));
> +	value_col_width = cast_size_t_to_int(
> +		max_size_t(table->value_col_width, value_title_len));

If table->name_col_width and table->value_col_width were int to
begin with, none of these casts would have been necessary.  Aren't
we overusing size_t to count things that are not memory allocations?

> +	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
> +	       value_col_width, value_col_title);
> +	printf("| ");
> +	for (int i = 0; i < name_col_width; i++)
> +		putchar('-');
> +	printf(" | ");
> +	for (int i = 0; i < value_col_width; i++)
> +		putchar('-');
> +	printf(" |\n");

I wonder if people want to use unicode "Box Drawing" block and other
fancier things, as we assume utf8 for names and values, in which
case these printf would need to be "translatable", but locale
administrators should not have more say than others what kind of
line drawing elements are to be used, so perhaps the above is good
enough at least for now.
