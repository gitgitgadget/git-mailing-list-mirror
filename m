Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6C349B15
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390951; cv=none; b=oQnRA0qIxQ+ottZNMzU46mZlbE/Z4+4mGozJpPkbm8uVJfUBzzjg4j+CNYg87LJPtcE49VnWrMPnCCD89Fe2eViXpMVEmwC4WyhaAea5tcyp6ssOyw3rE1bSKp8J1CrToaGIS2jqJfTKib0C4kU8JoaiAo4mOHKevfHAg3RjnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390951; c=relaxed/simple;
	bh=skM1aZMe/PRhGcmc8Qg5orGDmpWY0GdeafRkHOG0oLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EacddJxEef3tyTL1KkPccV2Ff4KQsohOi9o7cIk9mdJbtioCfwZ30YzDx889IYQpb+is4PR8HfZHUz8xdOLI1qPz3lHIsq9v/qd5VuNbhNQyMuDI3TsARWScwTZgNwb9WOvl0NqrfA1nXr6FFnwsihk2NkSxOe+YZQWvX2rEmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=joHk3XPR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0bjPVcs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="joHk3XPR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0bjPVcs"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F21814000B2;
	Tue, 24 Mar 2026 18:22:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 24 Mar 2026 18:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774390948; x=1774477348; bh=v/Fk2d5g/v
	PHbAQDa7ILxapt3wEFi9qoMqcl2Opn6Gw=; b=joHk3XPRd3EOP8TSO+xaD7vudp
	eX2e/1hLwjvoDfNg0KL/WedJThvm7bbIAE5zb4eKPBKNUPEtS4wxXJZOHOLDWkBx
	PygiT5Xp7Ojl7Tw/Y2XlyxAgax66kf3uQC+FCMRXrb1JZmvQQ/TicFLl0/l9MqY6
	t2T+I41cXAkUAu1/KXy03BGDzTwiy9vvcrrq1rZNGLN3dpAHyBDjBa2czht56K5H
	tY1VYnooLLAp1lQdhaaGRHNdIpYoRer/jCfKt9uPR+orf1hT6WALkhPgsZgWJ+83
	+StZyk2xw7XQV0e8CO7HycrwpQv9z3L8v4C2axI2+33FZv5gjFkD7PIs7jNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774390948; x=1774477348; bh=v/Fk2d5g/vPHbAQDa7ILxapt3wEFi9qoMqc
	l2Opn6Gw=; b=C0bjPVcswEZPwbsqxaSq++vuzlsiPQe6sbPq9jcquD/TzzS8tRy
	RcRrIbs/XevqHrYehB3jNjG0VgXZaVRSUhFKyL5zxZbG8WiZJQttTZraMEdgxQz0
	iaOBi/d/wP7x/LXmCTj5B6P7gud43iZvFeEACxlF4QXPG4k8LOJNtziWM/E2Y+lS
	MDV+IvwQeot0am6OUqofpk+EHpr5Vrnu5hLm0U5DaCTNgN4n1vI+1WdimSfTvNMm
	n5apsPjYgdV6IUORkD1FMgy/CGam9bgTcMSjelR9diyrx6RicxuwHd98AzULnl5z
	Jmr175nEpO9HJe5XSk6KQCNavA6lDRFa9tg==
X-ME-Sender: <xms:pA7DaaGws6ff1YLhBMLQxK4GKyQB2wQR8RgDAFKAs-CAr6eizjdopA>
    <xme:pA7DaSWbza18DJ2WIEZHUysOQwsdiwT-jGJga8uyb9UHLSfYP93DETzPttgQInjDi
    O2_42FCEGeI6oVHjHbAIYphNCFLp9OEUxF3QXfAHtVEtmBLdP3JQA>
X-ME-Received: <xmr:pA7DaZJa9ENEtnUPsZFElVLEBIxOHsq24rMZsSYqm6zuFLQI867tQy86w1D9Gd6xHUBxI6DCG4tXU64-Z_rLIq8gjLHcRlxWgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pA7DaS_KIWx6Baj-XWKTQcric8Wnx53IVMADi78hhjrbSR-oEylOlQ>
    <xmx:pA7DacKFnji8rA6xFPBLWyY7sytZ6HUOPLHxNSkj7rVuucsFVAahUw>
    <xmx:pA7DaXmNGWFu_mj0AImAn3qaFUbu8zAlB4Gphff6oBrxBJL-GuGOFw>
    <xmx:pA7DaQMGcy7e9kDgY3L90y_XhRCoz_oPCkDkUHAuG7os03xz2zOYXA>
    <xmx:pA7DabnoMon-Lt30vfrPbpoWHQC8jY3t5tK3AFLy3CXbnhwuZMKwmGf1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 18:22:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 1/4] fast-import: add 'abort-if-invalid' mode to
 '--signed-commits=<mode>'
In-Reply-To: <20260324215513.764739-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 24 Mar 2026 16:55:10 -0500")
References: <20260324215513.764739-1-jltobler@gmail.com>
	<20260324215513.764739-2-jltobler@gmail.com>
Date: Tue, 24 Mar 2026 15:22:26 -0700
Message-ID: <xmqqpl4syijh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 13621b0d6a..dcbc5bc82d 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -822,6 +822,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  			die(_("encountered signed commit %s; use "
>  			      "--signed-commits=<mode> to handle it"),
>  			    oid_to_hex(&commit->object.oid));
> +		case SIGN_ABORT_IF_INVALID:
> +			die(_("'abort-if-invalid' is not a valid mode for "
> +			      "git fast-export with --signed-commits=<mode>"));
>  		case SIGN_STRIP_IF_INVALID:
>  			die(_("'strip-if-invalid' is not a valid mode for "
>  			      "git fast-export with --signed-commits=<mode>"));

There are a few similar hunks in this patch to fast-export, but I am
not sure what is going on here.

I may be misreading the code, but this error, and the similar one
for strip-if-invalid that is already there, trigger if the command
is given "--signed-commits=abort-if-invalid" on its command line,
and when we see a signed commit in the range we walk to export the
commits.  Why shouldn't the user get the error immediately while the
command is parsing the command line options?  You may be sharing the
underlying parse_sign_mode() with import side that may support more
variants, but that is not a good excuse to make these two

    git fast-export --signed-commits=abort-if-invalid
    git fast-export --signed-commits=i-dont-know-what-i-am-doing

behave completely differently, no?

You can either move these "no, these subset of options are not
available here" to fast-export.c::parse_opt_sign_mode(), or even
better yet, teach parse_sign_mode() an option to say "hey, you are
being called from fast-export, so pretend that you have never heard
of options that are only available on fast-import" and error out
right there, can't you?  Or would it be too _early_ to give errors
to users?

Thanks.








