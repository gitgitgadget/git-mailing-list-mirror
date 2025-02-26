Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDF21D58D
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594291; cv=none; b=lg4EziZYIy6TDpNKvZtKilkdpS1D7Mrz0/08ZA3ZWyqWHC+0qlfULZhUbr7quahOEu2f14VWlkVzCxE1t01LnDBd2vdBIu5DBXtX28Y2C9g587XqTdxdSSdIDNqEewaoPMgHkTvD4DtvkUjRaCRa2RT2dOLeeWqsvshxC95Zv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594291; c=relaxed/simple;
	bh=+JnJi7/WxAUs2FxemOKp1Y6vOka0Oy3acAffwaofo3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kTkIxdE6BYZQuoyfQWeweVoZ6SBs58CaxhVJ6tYuY8P14p6RaTtoovlBzlC0gqhMho0mTYWkpJ10O2WajbBWbALUZzs0bhEGTMBAgFp2o5FHE8LyD0NyX8FvRWsPXYOrk5TOtu0epN9oW+4gU4Lb79Li4vNEBw/yrS3PjD8xRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vbfo1BAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwF0oaoZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vbfo1BAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwF0oaoZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F169311401A4;
	Wed, 26 Feb 2025 13:24:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 13:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740594287; x=1740680687; bh=WA/W3siIbL
	NWs/EnsWVCb0lYK2E2JbqHKcnsXyWBQ3w=; b=Vbfo1BAcuECJpPUNHKRqLjQ5xU
	jcB6zfUEIgsHS8pQZmbr0Vnvph88+cX+q0fjeBw6RjVE/oOY3CRMz7qn9Ulxfmgg
	J4TCsmvIQsV50qlYZzzgsMKwpuYNjaqXG5OeJJ0HNRf1eDMg7Dbn7MVIqVSEHJix
	MjOY7bt5YzL3CdF0zZV9vUCths3hwGZMDybr3T845YNxNKetfVrZxdBvMwBH6IrU
	W7TnSwOEZatKSZcTgFvhL7ujESnfuyxdgfW/9m7FferA0EQwXqQzO44eSfW260Ug
	LtckUEsuMJMe3a554yyZUNkCZjS1ta1uQMoqcz6DsJTJxW0ooO0VcV2/SMLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740594287; x=1740680687; bh=WA/W3siIbLNWs/EnsWVCb0lYK2E2JbqHKcn
	sXyWBQ3w=; b=MwF0oaoZISRGQjpF/ZMBr6SzbuIhM13ekx9l0gmMhVceFY+w7xl
	WL8R/E7p2+CmjG12wgdxLb4ToweZlQhOe0K92f0TCmhPhGNiO/+KH98SwYrQ1Tif
	Zi7HBcuVtzVyjE1rQvF6PNXfjRTL3jkTHY3O64SIvvbXwKb2rdtvIlOztD8xKwDY
	G+CYw7q2b5u3kD4wwxSYfLgL6DCBmy01VHYAlEViD5T2R3vA6ifqXYJACWFXU/2v
	eyOSANX8FWLb7NKWwQdS+FwehoRuLyCLaBRLr5Gb+AYqcNAzZmx3ItvjOS1QcgbE
	febI/rUoyZm3lh9D42Aa8No7hEqjDlRYMjQ==
X-ME-Sender: <xms:b1y_Z8PxjSWvz4NnFfdnlcWfAUqBYtOPdKmLeBlYDmHOHTZaC3leGQ>
    <xme:b1y_Zy8-X8aeYlOIRnE-RONjCyp_A9KvMxJGEnBIMbqNBcN04hXY_eWCCV6Dc-9gW
    KO-9zBsoP0126cfAw>
X-ME-Received: <xmr:b1y_ZzQMIBXMpFOJuafI-vVgh9Ux9_eFUMCdEvlnNmkfFllfkRrbZX_zwu0RQNlv-1YEzYM7y5DW_NkHQi2dQfKaJmlJXKrdGnst>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhffelkeffvdduhfegjeekhfefhfduledv
    gefggfffjeffvdehueehjeevudejjeenucffohhmrghinhepphhruhhnvggpuggrthgrrd
    hnrhdpphgvnhguihhnghdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpth
    htohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b1y_Z0tWb2ajFCztwtPEip-Z79X3JeZ4l9dVcHBypOdAjyV_6eknFA>
    <xmx:b1y_Z0fkVnhgcwdtcBpkwf5Cw5cdmmx_6j_tTUPYiku6q5sCR6pL_g>
    <xmx:b1y_Z42YcdIanLZowRwbFyS1uP2RzNgnNwaaB-QSPefJQS1BHcGzQQ>
    <xmx:b1y_Z48zBgT4dnqWzWolt5Y08JJ9xK2-AH7hgR4pfjHVheU1th3FwA>
    <xmx:b1y_ZyuyYNwmfpjqVBGcWRK99oeC3eCUiZYjq3zYQ4hKni7AsWIqv-LC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 13:24:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  phillip.wood123@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
In-Reply-To: <20250225233925.1345086-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 25 Feb 2025 17:39:24 -0600")
References: <20250212041825.2455031-1-jltobler@gmail.com>
	<20250225233925.1345086-1-jltobler@gmail.com>
	<20250225233925.1345086-3-jltobler@gmail.com>
Date: Wed, 26 Feb 2025 10:24:46 -0800
Message-ID: <xmqqjz9cd0nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static void flush_diff_queue(struct diff_options *options)
> +{
> +	/*
> +	 * If rename detection is not requested, use rename information from the
> +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> +	 * does not mess with rename information already present in queued
> +	 * filepairs.
> +	 */
> +	if (!options->detect_rename)
> +		options->found_follow = 1;

An ugly design decision that may be suboptimal from maintainability
point of view.

The parts of diffcore_std() that --follow wants to bypass may happen
to be the same as the parts that this new caller wants to bypass,
but who guarantees that they will stay that way in the future?

> +	diffcore_std(options);
> +	diff_flush(options);
> +}
> +
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct strbuf path_dst = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf meta = STRBUF_INIT;
> +	struct rev_info revs;
> +	int ret;
> +
> +	const char * const usage[] = {
> +		N_("git diff-pairs -z [<diff-options>]"),
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	struct option *parseopts = add_diff_options(options, &revs.diffopt);
> +
> +	show_usage_with_options_if_asked(argc, argv, usage, parseopts);
> +
> +	repo_init_revisions(repo, &revs, prefix);
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		usage_with_options(usage, parseopts);
> +
> +	/*
> +	 * With the -z option, both command input and raw output are
> +	 * NUL-delimited (this mode does not effect patch output). At present

Probably "effect" -> "affect".

> +	 * only NUL-delimited raw diff formatted input is supported.
> +	 */
> +	if (revs.diffopt.line_termination) {
> +		error(_("working without -z is not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.prune_data.nr) {
> +		error(_("pathspec arguments not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.pending.nr || revs.max_count != -1 ||
> +	    revs.min_age != (timestamp_t)-1 ||
> +	    revs.max_age != (timestamp_t)-1) {
> +		error(_("revision arguments not allowed"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (!revs.diffopt.output_format)
> +		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
> +
> +	while (1) {
> +		struct object_id oid_a, oid_b;
> +		struct diff_filepair *pair;
> +		unsigned mode_a, mode_b;
> +		const char *p;
> +		char status;
> +
> +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> +			break;

There should be a variant of this function that takes delimiter
parameter.  By declaring an int variable that is initialized to '\0'
(because you only deal with "-z" input) and passing that delimiter
variable to strbuf_getwholeline() would future-proof this code path.

How builtin/update-ref.c:update_refs_stdin() works may be inspiring.

> +		switch (status) {
> +		case DIFF_STATUS_ADDED:
> +			pair = diff_queue_addremove(&diff_queued_diff,
> +						    &revs.diffopt, '+', mode_b,
> +						    &oid_b, 1, path.buf, 0);
> +			if (pair)
> +				pair->status = status;
> +			break;
> + ...
> +		default:
> +			die(_("unknown diff status: %c"), status);
> +		}
> +	}

Amusing; looking good.

> +	flush_diff_queue(&revs.diffopt);
> +	ret = diff_result_code(&revs);
> +
> +	strbuf_release(&path_dst);
> +	strbuf_release(&path);
> +	strbuf_release(&meta);
> +	release_revisions(&revs);
> +	FREE_AND_NULL(parseopts);
> +
> +	return ret;
> +}

Nice.  It is surprisingly compact and had everything I expected it
to have ;-).

> +test_expect_success 'diff-pairs recreates --raw' '
> +	git diff-tree -r -M -C -C -z base new >expect &&
> +	git diff-tree -r -M -C -C -z base new |
> +	git diff-pairs --raw -z >actual &&
> +	test_cmp expect actual
> +'

Amusing ;-)  But a very obvious and important thing to test.
I would have fed <expect to diff-pairs for this test, though.

Other than that, nicely done.
