Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475942236F2
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282632; cv=none; b=utN8o19meZ99dFwAVwIGUhlYwyLFaEhVmO+yFwhX5psC7KbcR7NSUVjNjH8Wx9fB2eKUfq2gD6dMjT8U+tGSOlJy4p4o8lycSjvwaDF8qGDiZrmVmF5cWYTCmOuEFdVYCbk2m6JYrExG5ytfdK6xyu1YMctxLi8al3GW6PII8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282632; c=relaxed/simple;
	bh=aV+0YK/lxV2dnIrUQbMuE1mUAUSGQO9Ad4rJ/7kmU10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAWueJhjP+3oYH6oEntjNkhNYtvAD9a4g0PgBqE4s2240uPUTsKXvrDqRaVbmWEE9A3AvIj0D4El2AKKIidEAHdnIVPh613XdbKTDYU5Hxx4n/BqIknl+z8XpXVxgVIavejafNcw8qk8jUoFfO0m0+kHZySZCl50xgRYQmaCOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f2LgyuSg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsuQekjE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2LgyuSg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsuQekjE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 839B01D00287;
	Wed, 15 Apr 2026 15:50:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 15:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776282629; x=1776369029; bh=z1NE1MdsyZ
	9slOU4IUGQCGC9iFVkIqxy3eAscXw0mVQ=; b=f2LgyuSgQseDDRaOmd/DhRQOxX
	gGvwEyMcdLtYOppc0YR1C4XXnczJFBkhwne4aOA/ZJAbH66NalLQjsVkDhKx4/mk
	2XqN028+BfY0WofK0Xw5BZud875bnwG6kpdtCYskaUg4dG0uiJ1Eo++9xbONAGbo
	G3xVPusgCbWroWxVN+4+AQRR/sjJkRrk5URrXCOQE/3FBVhfwRrgZIaWbPse22yy
	3XEdNcAUIjDtbzxHQ/vJDywtvyFVO+b1vtAm7KlwWUEeECk4B7Ubt3dEmrBwivRo
	NgW5SnZyMi7/SIQK/VA80VcxFMGLbLWh6WDqdkGTvTPN2NdGTo/ZYdEWxIfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776282629; x=1776369029; bh=z1NE1MdsyZ9slOU4IUGQCGC9iFVkIqxy3eA
	scXw0mVQ=; b=JsuQekjE0YyPAnXpRWWV9DSU4A5qsSTYoKHhSpeCriS7+CCQJYz
	ygbijrv9/uMy/ow0IjgFZAmYtRpKAEWHUv33EcHQRhSqZBqHd8p6d6XwRJbD5RlY
	1kYkYmlYJw5W0CauzmS8YwU4Gb2IQnHdpdePIzyB6gsNafS8/F1netaNFqLlxPrE
	gNTZ9PoEVXjF3q0AbpNe0BtaqEibii4lBL64I99g/mlGXKwJGHXjT1c17dsXPycv
	lEz+46sVbCuFFI/r1SewCwI65oKrour4qMc09S+hE28NTbZWqr168uYQb+6gIcb8
	253MqYl/bw/wRwu1axIxWted6hiKK7m9OHw==
X-ME-Sender: <xms:BezfaU0mtMzmFmCD52su5My5pD4jXeliYKYxlTAX59YH83D8rZwWIw>
    <xme:BezfaV9jRjM26tW88Z4AFkPqvQwLBke7uX-yEdyX4g8rYfAakY35bDNlM3KOh_Ad4
    ppAl7CBpOeh7WYotEPbmJ6NRZGZLYCmwpF7Ct98EbJflDCkfqiSpg>
X-ME-Received: <xmr:BezfaVM85rLszh0xu9Q7cSERwieP9hc0js15vqkzlILlh-iUftXbe8E7Pld2NviqXyckWXsTGAGVGUpfn1IZ3EOSHiQSK6oSYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BezfaZdrXyJ0pbpdu896zLgxcAijJ-LdmRjgnAbd8jYFRoW44sacqA>
    <xmx:BezfaUU2lLNavKqMfJLD13Rbbt0-AzG5DEYCSZp-UjPS-dgnOR0Xcg>
    <xmx:BezfaRhzdYBTPgXY4fFSUMAW6CbbW_uNcxeO6C50kruMcxHNPtsulg>
    <xmx:BezfaT_ZwnfZQZ93Gg2CrHRFriURJ6SjOUdgu3vORtxQ865siIOxYw>
    <xmx:BezfaYuQqE7se2fmQb87e2jddMYcxD094rIt9H0oLYBeMe9h81kb4eG8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 15:50:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/7] fetch: add --negotiation-require option for
 negotiation
In-Reply-To: <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 15 Apr 2026
	15:14:24 +0000")
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 12:50:27 -0700
Message-ID: <xmqqik9s57gc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +`--negotiation-require=<revision>`::
> +	Ensure that the given ref tip is always sent as a "have" line
> +	during fetch negotiation, regardless of what the negotiation
> +	algorithm selects.  This is useful to guarantee that common
> +	history reachable from specific refs is always considered, even
> +	when `--negotiation-restrict` restricts the set of tips or when
> +	the negotiation algorithm would otherwise skip them.
> ++
> +This option may be specified more than once; if so, each ref is sent
> +unconditionally.
> ++
> +The argument may be an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
> +is the same as for `--negotiation-restrict`.
> ++
> +If `--negotiation-restrict` is used, the have set is first restricted by
> +that option and then increased to include the tips specified by
> +`--negotiation-require`.

Very readable.  Nice.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 57b2b667ff..b60652e6b1 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -99,6 +99,7 @@ static struct transport *gsecondary;
>  static struct refspec refmap = REFSPEC_INIT_FETCH;
>  static struct string_list server_options = STRING_LIST_INIT_DUP;
>  static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
> +static struct string_list negotiation_require = STRING_LIST_INIT_NODUP;

I thought _tip was renamed to _restrict in an earlier step, but that
was only in the transport in [3/7].  Perhaps we want to rename the
file-scope static variable negotiation_tip to negotiation_restrict
in an earlier step, like in [2/7]?

> +	for_each_string_list_item(item, negotiation_require) {
> +		if (!has_glob_specials(item->string)) {
> +			struct object_id oid;
> +			if (repo_get_oid(the_repository, item->string, &oid))
> +				continue;

The configuration (or command line) says --nego-require=refs/heads/main
but this old repository only has refs/heads/master; we do not want
to error out in such a case.

Is it true, though?  nego-{require,restrict} feels quite tied to
each project and unless the configuration or command line options
are applied blindly regardless of the project, such an error should
not happen.  Perhaps the user who gives a command line option
"--nego-require=refs/heads/naster" may want to be reminded of a
possible typo?

> +			if (!odb_has_object(the_repository->objects, &oid, 0))
> +				continue;

This is a bit curious.  When does the first condition holds but not
the second?  A lazy clone whose ref-tip contains a missing commit
promised by somebody else?

In the presense of "promised objects are allowed to be missing"
rule, silently skipping a missing object here is certainly
conservative, but this is not an object that is buried deep in a
tree hierarchy, but the top-level commit or tag that is directly
pointed at by a ref, isn't it?  I am a bit uneasy that we ignore
such potential repository corruption (i.e., a missing object may not
be something a promisor remote promised but simply missing).

> @@ -474,7 +511,25 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
>  	flushes = 0;
>  	retval = -1;
> +
> +	/* Send unconditional haves from --negotiation-require */
> +	resolve_negotiation_require(args->negotiation_require,
> +				    &negotiation_require_oids);
> +	if (oidset_size(&negotiation_require_oids)) {
> +		struct oidset_iter iter;
> +		oidset_iter_init(&negotiation_require_oids, &iter);
> +
> +		while ((oid = oidset_iter_next(&iter))) {
> +			packet_buf_write(&req_buf, "have %s\n",
> +					 oid_to_hex(oid));
> +			print_verbose(args, "have %s", oid_to_hex(oid));
> +		}
> +	}

OK.  I think it makes sense to send these early.  We have already
dealt with the usual "tips" by calling mark_tips() way earlier, but
that hasn't produced any "have" yet, and these will go before the
ones from traversal.  We do not traverse from these "require" and
that may be why these are not called "_tips"?

And sending these early means the other side has much less chance to
say "we've heard enough, stop!", so in a sense they are of much
higher priority "have"s (I wonder what happens when they do want to
say "stop!" while we are giving a lot of "have" from this loop,
though).

>  	while ((oid = negotiator->next(negotiator))) {
> +		/* avoid duplicate oids from --negotiation-require */
> +		if (oidset_contains(&negotiation_require_oids, oid))
> +			continue;

If objects rechable from "require" are traversed like others, then
this "avoid duplicate" would become unnecessary, right?

