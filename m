Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D92E541F
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612309; cv=none; b=HMPnbrBPEu2IvaabROpCKM3qbvnS9ipvKqd8EbwI/ldLmBrPKWhQnBiAIbNT524YUxjYwOvyLdFJk8Ls9tNZOANbpfJNuj3tOSMiNtlhYQJjyYRkY8hrRNz9ZN4mVVtvjk+EL7XZr5N3sbpolx1v0jhV+7ykeG43cKIS2rTKXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612309; c=relaxed/simple;
	bh=KgsLatHaJBSGdrKBbKiWkcw4H87Ys0F0FAypVuepU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8jqSqaIBGj65e4zEZjkKJhPJ60GlP4MsbeZCcuTuOTUHtYa2MunG1ZhLNEp2ipD2kDDN2ANeial0bBAPn0903gGnBAAMuYjiJGqLtDXyytNeeoD/upcr6qP17QExz6tO6fuYELC09v1obvcGgzXf1mWj0R//txNgokGrCGYHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JzFqsjYm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=luc5+Cr4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JzFqsjYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="luc5+Cr4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5ECBC1400186;
	Thu, 16 Oct 2025 06:58:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 06:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760612306; x=1760698706; bh=ulBXZgTQHG
	c8mZ+fZi1UlLYyP7TPE24jcljThSfz9HM=; b=JzFqsjYmz0HaF/rs3EK4Pt+d8p
	5qNgJSWAhlqNNc1OXoL8R0yX2S/iOitFBFGq8z4Nr+F6Z7GQWLXC3Ps0rveZ22bg
	guet6tozQSWu8jmtL06Ce1GPuSPZQ5YgyURatKhb/hIdNdilRDC2MO+SVoysDQ4Y
	9BIvwWLuO/f4x6no+aXPWLikT74xJ3g2xF6oHnOHFXCob2XQZcgcBBxeDs/l5DO5
	PRy/rRFrrum1nD7riaKS0a7JQV0lh8FdLhS+0p9FWoPFRumePbOqdIGULrLXZI0a
	W7ueD2g1Rm7GZbmwE0n8GhMyR/XmNTtHHPps/WMvzfvbPQj0IB6YUV+uuhYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760612306; x=1760698706; bh=ulBXZgTQHGc8mZ+fZi1UlLYyP7TPE24jclj
	ThSfz9HM=; b=luc5+Cr4/GkvHZl6oMB5Sng8EUHO7vXNOfX9guoEedHQQ6rF6Fa
	q4rwpC/EGjx4yG/5jbePovFqZ4OStHjHBvQlf1s1sSSjSppZPqPflqfq5Yiw3QdR
	gCAsXfUMotC13GRzZvd8EueVI1oqzroMR1EINntC4rGdq9JaMD7595KaJlkFxikm
	7kCPBGLGWvP/vmyvwtulYgK1Z5W8OvLo04pqH73FFOdnXfgd86/4mDrCE88CRwQm
	87LQ84bdUeC3EixcBZcHbHyTZwb5hhMxOZ1V5UpbYfv4e3q60Qoc0HlI2qymlEuV
	u/DOTB8FNW6k+NIAvjGaABnIFiL3jgrWGdg==
X-ME-Sender: <xms:0s_waHJ1f684FDW7hEJ9CCcZsTOiHY9_T8aN1v2KhgwkUkDWInkI4A>
    <xme:0s_waO2uUlXwf8k-wkY2pUlx2VEqwAkIz5v9o6Zl2YHDMLFms2mhTW8y3icMHtD62
    Xe_1-yN2qcHf3ACatBT-51vAEtYLStS8gY3bV_ls4dFvDcANXdgjw>
X-ME-Received: <xmr:0s_waJjDnK6l-7r4gKUooQNAAL_3mfjrsprMwjkXc4L3I5ap1Gi6sp12jrhf_qAlkM6H5vIUnkXQj4LxbFzPknCn9Gz4H1oVHAwGj5mEuIFECQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:0s_waHVHhzTzsS-ZAiYZR4wzGJlgG-tcLFk8dsUFgOjqA8JXLJW0iw>
    <xmx:0s_waAVaHqQLPSiCVThmi7pQRL1AhQhqOHp3tF0Wp-EFHitzv26Fgg>
    <xmx:0s_waPjwmAerntcRvD-_fz2JViYrJOL4ES67UKRPjF_v2GI4fhf-zQ>
    <xmx:0s_waDbgRedPqNWP718s29ZQoLPZp6wItol0a3TNZrudMy0BSfarPQ>
    <xmx:0s_waAPsBs1YbRSW_6CedEfkPxe8BNhIDTVxq8uZTqGQzqkz90cgEu9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:58:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f914bc5d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 10:58:23 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:58:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 3/6] builtin/repo: introduce structure subcommand
Message-ID: <aPDPyEVOTSU6NuOH@pks.im>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
 <20251015211213.361797-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015211213.361797-4-jltobler@gmail.com>

On Wed, Oct 15, 2025 at 04:12:10PM -0500, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index eeeab8fbd2..4575cf9467 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -156,12 +160,201 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
[snip]
> +static void structure_count_references(struct ref_stats *stats,
> +				       struct ref_array *refs)
> +{
> +	for (int i = 0; i < refs->nr; i++) {
> +		struct ref_array_item *ref = refs->items[i];
> +
> +		switch (ref->kind) {
> +		case FILTER_REFS_BRANCHES:
> +			stats->branches++;
> +			break;
> +		case FILTER_REFS_REMOTES:
> +			stats->remotes++;
> +			break;
> +		case FILTER_REFS_TAGS:
> +			stats->tags++;
> +			break;
> +		case FILTER_REFS_OTHERS:
> +			stats->others++;
> +			break;
> +		default:
> +			BUG("unexpected reference type");
> +		}
> +	}
> +}
> +
> +static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
> +			      struct repository *repo UNUSED)
> +{
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct stats_table table = {
> +		.rows = STRING_LIST_INIT_DUP,
> +	};
> +	struct ref_stats stats = { 0 };
> +	struct ref_array refs = { 0 };
> +	struct option options[] = { 0 };
> +
> +	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));
> +
> +	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
> +		die(_("unable to filter refs"));
> +
> +	structure_count_references(&stats, &refs);

I only noticed this when taking a look at the last patch that introduces
a progress meter, but I think we should change how we count references.
The way you do it here means that we have to temporarily store all refs
in an array, which is completely unnecessary and thus a waste of memory.
Furthermore, the resulting progress meter will be somewhat useless
because it only starts counting _after_ we have enumerated all
references already. The second phase where we basically just classify
the refs by type is going to be orders of magnitude faster and probably
not noticeable even with millions of refs.

Instead, I think we should use e.g. `refs_for_each_ref()` and count them
in the callback function. This means we don't have to store them
anymore, and also the progress meter becomes more useful.

The only downside is that we cannot set up the progress meter with an
upper limit. But I think that is an acceptable tradeoff.

The other patches all look good to me, thanks!

Patrick
