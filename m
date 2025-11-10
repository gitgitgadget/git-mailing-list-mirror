Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D62FF652
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766696; cv=none; b=ovEatQYGDTsvUNzg+OJ3nOU05TPrDt7PSlDMEJTiAIzuYGCCyDsjLtgfCEYDvhiheyHkbf0GyyHI8bqR6BEDhxi8eeczJls1em9GVs/4ymLAxHx0KpEbYdmZdoMv3KQJIIHxwIzJZDNRqzDhwO8dWPeCqS9VHksk8UPj+I5RhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766696; c=relaxed/simple;
	bh=QGDa8t55eop2YR5AOlMhYXdD5Xis/rohaZjFEvMYLPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+o6OZZDOXOW0eZblLlgqsCqAuhAQ/IK6kHMs1j4PWaFKAwadkzK7pD4aWZeE3QwGsbgmdsURtW5LySeVHK/kTVEosP4uAeSi6cIpReHTbrgvF03UQmo9uniAUo9Jpis2pIrRfvwWXhmPa9RBFhB0GQUf1gQwcRrwLp/AL5oPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xy5Jd6NL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb+QfZZ/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xy5Jd6NL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb+QfZZ/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CBC41D000F8;
	Mon, 10 Nov 2025 04:24:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 04:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762766692; x=1762853092; bh=q7JvDKKaOE
	UdhhPIJ0uFz8Hw2IyQ38tuR9nDSpvES1o=; b=Xy5Jd6NLP7OWW5Te4VwdbzqERR
	WWLhD3rjqK4cc0PBjmvzJv0uLIHPHUH/7Yp0/bhCOvJ3aDUChyEKakYXhr7XeZEC
	0rpVWNOmeifsKFQjD5OKOMXwJPZfqtoVTu/x126q1o4zHCQubbQPC2UANvjx/H0y
	5bOZfL2ViDmPqBqhZvug4AT9XzkEBYgXUDV8WiNQUt2As3SA4D6xx9rEzZtd1YcM
	Xg3dkf5LIVcGZnBZxmad2MnkowAyacTzZSSDKF41Mt7eQ8DRG3hl5y81W0ntsQmk
	gbaLvorMub99wnKfd40F+DuXluBrOwjBLP+LhMOSQoj3AgtuWJpIGmtKe72g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762766692; x=1762853092; bh=q7JvDKKaOEUdhhPIJ0uFz8Hw2IyQ38tuR9n
	DSpvES1o=; b=fb+QfZZ/YVDy02jvQ/Urm1O26VKfCWHNf/xkXL5agbwsRiaRv+T
	GuxxXKKhC9zAkgR89s4d1T8kQZbvqxg3ZB6uy4NENW0h8GbH+E2SgarLlp2EQvRU
	1szzsJmmkeUktwXrF+xHUZ2yCnZY2iRB3xR/Ih7ZLXsaNRtv00g9H7vVCckCgqQu
	GMSdmzROk3ncHg0TzLVUDOaXclOB74zYs74eOROuGmxObQGn0K6JiV6NVDHbiCca
	w1z/THDqzMGDuFnC7MaEQBh+lfrshMwcDkHll3JcUy3gxxuaoRoTUYRuHy4MBy65
	9TNxpuxHgpxr5Ll8YXvtmYsrL8haKGX3i6A==
X-ME-Sender: <xms:Y68RaQ5OCeLgI1vrhp41NRzbupH3Dy9mfpQqOx-2mQ35Socht9AXrA>
    <xme:Y68RaYy2K86TTmZZd3A3sDhdybYBDtd2YDfIQVnUtdFfN586A7sMaUWZXX4Edyj5Q
    smXiXZqGYlBeVV5iBTJM67wMiVx6dmz0yh9B9TE9ZxMvUjgt96Ro94>
X-ME-Received: <xmr:Y68RaXwUwWJ1Q0Uq08fr2UoW87ZlAMPcRKp76uWM8S0H-3JWf9W1dlUFpeyPu7H4kPAoRcg_j5PpRh4yEDsxzZ6MvZ1EUjoPKvLbjrBDEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y68RaQxLjnSqHmCm532dK0O-YcHz7ksIWMKT9AWZYHkFF6DEv8htlA>
    <xmx:Y68RaRZ5KEQMpZD98b0nrxWiDujXhMNo9oE6TINgoJ9Nm1eYb_jT8Q>
    <xmx:Y68RaRWsSRqCKALmnw_tu18TfRVTNN45yBXxa05hzJs_b2OBcZT8vQ>
    <xmx:Y68RafhqjpEI6u3_ruCw8GQimAXVaAqHZzcRlvlg6MrcHjU8amViiA>
    <xmx:ZK8RaZQBJjImD2V0cZw1893clP9qr6QdOE_YkK_O3SoezAvIh_cloZmH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 04:24:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e0ca925f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 09:24:48 +0000 (UTC)
Date: Mon, 10 Nov 2025 10:24:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <aRGvVwRcsJA9CD9c@pks.im>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>

On Sun, Nov 09, 2025 at 10:22:54AM +0000, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Add --committer option to git-commit, allowing users to override the
> committer identity similar to how --author works. This provides a more
> convenient alternative to setting GIT_COMMITTER_* environment variables.

Yeah, I can see how that's useful.

> diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
> index 54c207ad45..a015c8328e 100644
> --- a/Documentation/git-commit.adoc
> +++ b/Documentation/git-commit.adoc
> @@ -12,7 +12,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
>  	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--date=<date>] [--committer=<committer>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>  	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
>  	   [--] [<pathspec>...]

Nit: I'd move `--committer` before `--date` so that it comes directly
after `--author`.

> @@ -181,6 +181,13 @@ See linkgit:git-rebase[1] for details.
>  `--date=<date>`::
>  	Override the author date used in the commit.
>  
> +`--committer=<committer>`::
> +	Override the committer for the commit. Specify an explicit committer using the
> +	standard `A U Thor <committer@example.com>` format. Otherwise _<committer>_
> +	is assumed to be a pattern and is used to search for an existing
> +	commit by that author (i.e. `git rev-list --all -i --author=<committer>`);
> +	the commit author is then copied from the first such commit found.

This matches the description of `--author`.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..88e77cbaab 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -690,6 +691,48 @@ static void determine_author_info(struct strbuf *author_ident)
>  	free(date);
>  }
>  
> +static void determine_committer_info(struct strbuf *committer_ident)
> +{
> +	char *name, *email, *date;
> +	struct ident_split committer;
> +
> +	name = xstrdup_or_null(getenv("GIT_COMMITTER_NAME"));
> +	email = xstrdup_or_null(getenv("GIT_COMMITTER_EMAIL"));
> +	date = xstrdup_or_null(getenv("GIT_COMMITTER_DATE"));
> +
> +	if (force_committer) {
> +		struct ident_split ident;
> +
> +		if (split_ident_line(&ident, force_committer, strlen(force_committer)) < 0)
> +			die(_("malformed --committer parameter"));
> +		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
> +		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
> +
> +		if (ident.date_begin) {
> +			struct strbuf date_buf = STRBUF_INIT;
> +			strbuf_addch(&date_buf, '@');
> +			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
> +			strbuf_addch(&date_buf, ' ');
> +			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
> +			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> +		}
> +	}
> +
> +	if (force_date) {
> +		struct strbuf date_buf = STRBUF_INIT;
> +		if (parse_force_date(force_date, &date_buf))
> +			die(_("invalid date format: %s"), force_date);
> +		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
> +	}
> +
> +	strbuf_addstr(committer_ident, fmt_ident(name, email, WANT_COMMITTER_IDENT, date,
> +				IDENT_STRICT));
> +	assert_split_ident(&committer, committer_ident);
> +	free(name);
> +	free(email);
> +	free(date);
> +}
> +
>  static int author_date_is_interesting(void)
>  {
>  	return author_message || force_date;

A lot of the infra in this new function is shared with
`determine_author_info()`. It would be great if we could refactor it so
that the common parts are shared given that this all is quite
non-trivial.

Maybe we could have something like `determine_identity()` that contains
the common bits between both functions? It might ultimately not really
be worth it, but at least the functionality in the `force_committer`
condition feels like it should be pulled out.

> @@ -1321,6 +1364,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (force_author && renew_authorship)
>  		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>  
> +	if (force_committer && !strchr(force_committer, '>'))
> +		force_committer = find_author_by_nickname(force_committer);
> +
>  	if (logfile || have_option_m || use_message)
>  		use_editor = 0;
>  

Is it the right thing to search by author here? Shouldn't we rather be
searching by committer?

> @@ -1930,8 +1978,13 @@ int cmd_commit(int argc,
>  		append_merge_tag_headers(parents, &tail);
>  	}
>  
> +	if (force_committer) {
> +		determine_committer_info(&committer_ident);
> +	}
> +

Nit: we tend to not use braces around single-line bodies.

Thanks!

Patrick
