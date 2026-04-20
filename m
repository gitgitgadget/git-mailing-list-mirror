Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EBF3148C9
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672715; cv=none; b=bIb366tDa2qnmIU/eKQpnVrpRQCiHJnncPNm3gZUkresYAE6Di5kUPnPY4sU6IzaPBlhWCRUDp5hSiq6qo8hhqvpoBAJq+iKKPG/fvrHZjaI6LNhM2eeGxE3ytM/UsB5U31YtR4kSlQrRe0pOQwFVR0KlKKLLtgbNF+nHhnKrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672715; c=relaxed/simple;
	bh=BAVtYhR8JEX4XEE6itRDGE6Grv5ayysoxRzDcKijWVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9JvTBo2PKs86lA7ycLMsgZ/PC5sklKVJ04G/TVxOQZIytx18UXgBxABWfkM5K/yygri1t9kJ88SmEW91u3nQ4UJt93oRy6Bkg7F63XoPd4AAa92nTe5oLSYlZnwSxLIJhL0eFL1DSnRhlMooqZVWUAi45OLII2EnW4ga0wMMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v8HnjfGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtSYiKSj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v8HnjfGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtSYiKSj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F920140004A;
	Mon, 20 Apr 2026 04:11:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 04:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776672713; x=1776759113; bh=YJ+RHWd6cx
	sAOiwWIXNPu9i7hF7AE7ZG+4NAWqxQSyU=; b=v8HnjfGQvtpyrrNdtOZulLNJxk
	N9lrX9x10nqR9jD+FyJNcDif2Jjd7pR9iWuFOEcCDqSmHUDZVQUJ8f3gA9XNkYB7
	2t2odLi8751vhCX0mj0cK2QNHjvwUxMrK87nOLwmjPsTFArcSN4hUgsIHmcem4lz
	BKcTi/yO8BiDgXcKQd7OTN9/sQtjXg2YiGLL0ZRAWrDsLlPAKRi+bHdrb06OI7bP
	wh3C4Epj/4TS0jiYASIxX1WLhgcBdUWU1kU9tj6lJ9TdfIN2Kw0QRi/T/Lh+vOdn
	w6mvkSOkqpXKsbKDG0b/h/tfvN6scR71R9Ad4fG7SvHx0NrFh+085vCI8sKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776672713; x=1776759113; bh=YJ+RHWd6cxsAOiwWIXNPu9i7hF7AE7ZG+4N
	AWqxQSyU=; b=rtSYiKSjaKjFgvHc+kVsdNuljupyduK2dATSJ/GPaCc0nC0Rg+z
	me5LjzcZegVjhHqVyWIU7WLdx4pPvRiYiql98a3+iGJLToQjJ5dm4B6xRuAxIbCy
	g5tiLfH7pIw8wBme29fWCKoUP8s3Iir9aAeAmcWw2MASDDGmnbUlPfXabTHFtWWE
	DMFshQUxcuWZpvGJiv9/lYxciWV7FFQVQM7UB1b/9kDaE4B0KwdsdUtvkUzztyxj
	RZ9abRnB6duRHd2FnRytmu2PD+TPLUoKccJz2KuHfsjs/mZv96zJtDXO9Ju6rVh6
	zcut9cpx/avJ+2v4bVBfSmU/iob/lLvLn2g==
X-ME-Sender: <xms:yd_laRYttg_0kzUqwNq612yEPVOPVn--lJJiDmk0f6_cGUC9CXkHRQ>
    <xme:yd_lafa2iWQNiz0HH_VLULKpsaUuK7HQKE8w2nCvCoehEfriVwpARX6y2D0qAuQjA
    8hCPB3uScN4WhHyGflqYXp1VuHP6NBpNDUVdIm_jU02o5hE9_yZlg>
X-ME-Received: <xmr:yd_laY_4tfXG2SR8jnK2JNiTzi2QP7XiCSpX0Cbm6rfNQRDMSRSgD5IPvSgS0YJxunLfj89661ZDZLdp_uI59PanPx8B968YWIwxgauLzFXK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yd_laehcvxpeZln6Au6YOBdMpq_CPu9pCsVwmXfEsiGYZEwgjMh3Ug>
    <xmx:yd_laYc0FNQOMcJvy-kciK2MQkt864sI11HA8d3BaIQt5rlVX2_0tg>
    <xmx:yd_laVr11UCU5qN4ADqpDefmY9ty7lxK5WTwtoEwQtNDmB70RdiFmQ>
    <xmx:yd_ladBma5gEOim69797E97Xw7hdK1gTc4_oK-lyF6eUeHcRS0Xq_A>
    <xmx:yd_laYfHYEJ2WR8JrDlNtGhSqWtBMTL1-rURZGAWabXR43uzKNUTnzfp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:11:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7656558f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:11:51 +0000 (UTC)
Date: Mon, 20 Apr 2026 10:11:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/7] fetch: add --negotiation-require option for
 negotiation
Message-ID: <aeXfwnHvfnujAiqF@pks.im>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
 <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c80cef2e25ecadf894cf42661d39dc82493f47.1776266066.git.gitgitgadget@gmail.com>

On Wed, Apr 15, 2026 at 03:14:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> Add a new --negotiation-require option to 'git fetch', which ensures
> that certain ref tips are always sent as 'have' lines during fetch
> negotiation, regardless of what the negotiation algorithm selects.

When reading "--negotiation-require" my mind immediately shifts towards
a mode where we require the remote to have a specific reference, and if
not we'll abort. That's of course not what you're proposing here, but I
would think that I may not be the only person making that connection.

Would an alternative like "--negotiation-include" or
"--negotiation-expand" be better?

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index c07b85499f..85ffc5b32b 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
>  configuration variables documented in linkgit:git-config[1], and the
>  `--negotiate-only` option below.
>  
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

This interaction makes sense. You can basically say "send only local
branches, but please _also_ send that one particular ref over there".

> diff --git a/fetch-pack.c b/fetch-pack.c
> index baf239adf9..a0029253f1 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
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

Okay, so here we now unconditionally send our requested object IDs.

One thing I was wondering is whether we need to flush eventually. It can
happen that the user specifies millions of refs, either intentionally or
by accident. But I guess the answer might be "no", as the intent of the
feature is that we indeed want to send all of those to the remote side,
and the remote is being asked to consider all of those OIDs.

Patrick
