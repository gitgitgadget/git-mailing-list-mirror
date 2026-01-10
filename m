Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA619F137
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010557; cv=none; b=D8SNOLf+gmpSE1WpNz5tkrcWGsMfORWVnqFo1JXXtpz7vuKzZVoFByYIhRbDdF3fdfTijh/3pS1Hn/w11nNaAPKGL8C23z78HaOz9FoGUO4xLLejwsYBgCJkmL8M+CQrwzePhYvcJqfjlEt1azUzYyS3MMkE5jqlg7MtriULfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010557; c=relaxed/simple;
	bh=a9K4mLz81IHSq0MquH2oT/cPkgsQAm3TIXWqCIZD0l0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g08wMDLGOL+vDCJeqwScwh4Wzo+CgAYs4OqhokxMrGckzmbfSyipae7l1F1CkZWuUQ8qkqoAcJpxRtoslCQcMK80Te23NgxKqUrKpyiXHAae0w0kPM2EYmHRsTf6wfsPa2YCJ4cMPYxNGMzuEj+erZGExLiuQ7o6MhPad0e+BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fAlUQpxF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ds/KOe6x; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fAlUQpxF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ds/KOe6x"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 55A611D0004F;
	Fri,  9 Jan 2026 21:02:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 21:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768010555; x=1768096955; bh=zYX4bspzSm
	2xgfu86WvDmNBDarwvTsdzSCx3bs5uYaA=; b=fAlUQpxFBVKD6RqPcbJPfF02pj
	4v+cIpHNO8g5Qw+M0IunuRyw+S/GEeVZZsK/T/qsWu/57BTfxvnV4mgb6FS2rDaK
	au+rIOWDqZKO8GXm18sjJQx+pKyuUYv66WRYMgwraZl4IZFcOq3R9gXaEosYyO6k
	MWhLzyU2G1BIdYhsU4W2gWcHIvoXoBGwwpuU7kQ5fjCJua7tuM6e8nTWdP8odNEW
	9Xx/guF0TiGTBgY0BvqKDJ+dXMSUlqpNVN3LGyyURJm0gqyOCAMYyZ0T+imoS9uo
	5CQ9CEpyW57IiX5qKrBnCYBwthslY08xuDJ+lXCCuWyh+dBuvaV/Lc6vQgqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768010555; x=1768096955; bh=zYX4bspzSm2xgfu86WvDmNBDarwvTsdzSCx
	3bs5uYaA=; b=ds/KOe6xIuQ5pmW9VPUXyFKe7jsPzN5CqWq6xhwS+nMLlOg9q8p
	n3a3T3yHrffzqV6VuhhBkfISPPMn/0PSd6fE785fKmO/33MSffMrUokSiwQdTrRP
	VRPorNcsrBgX5hzw5nV1C49+2eV6eCY8Vlkmi5WMa/A5sqou1lIakQy4XBll/2nR
	Yi0RqZXuPDGkTscUEs/xw0y5ks443yVW18jdnUJuM9hOIMKRJyBdcREQqbi2kX/B
	A557iyogWbdNWmMwWumAi+RTVrhosHBCcg61IDGPSFRkSJFa5Sx4SIeY6gElQAWh
	gkus2Lfx7rRw5d4uWFR4hBcm8wtRC1PyCMA==
X-ME-Sender: <xms:O7NhabewXG7z--heuTJDgH7HAAAD4Rbch5ONYRBWniUGXsp6lui4jA>
    <xme:O7NhaYNoHkLKILFIyl9k0-Xf9GywfR83sPnpVQcN8X-WYXI4sKSgtLxkd7o_BnNOF
    NXFpqOluj3gu7G46jNHhTWM2FBajQWfDDXYtx8UNVMcZ9cQuGj5dQ>
X-ME-Received: <xmr:O7NhaZg_htmyANC7FlRzjCdOYJYXF5rgtk23dUlqIZlf_GsUUbRtHw16d9fhcCVOg330DD8squ8leMG1pbhinjr0DHwHlN8cfWeRm1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O7Nhab2xi4SJGE6tqo_hhlMurCTXOkjKEU_89Yj6WwWlp5myfL_AZg>
    <xmx:O7NhaTixp15HKOqASYDhIlGhUgu7qEl4GL8B9iNFdscA33A134gjiA>
    <xmx:O7NhabcS1TSndXdhPiEzioTx8C_qC6O_kj2IeYZmaVveSYjsgmSGyA>
    <xmx:O7NhaWl1KGhP6Ti7euMG_2D7M--YsAZmfZot7dDRjqPNKsALsX-MVA>
    <xmx:O7NhadDTA9QMaU4lKGFF-9Y65LX0Z0RjA8G1AhC9Y08nIfOvAYeQ_b95>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 21:02:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v19 1/2] refactor format_branch_comparison in preparation
In-Reply-To: <451d7a498617fbcbeb08ee644cb621cbf6af0bd5.1767984037.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 09 Jan 2026
	18:40:36 +0000")
References: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
	<pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<451d7a498617fbcbeb08ee644cb621cbf6af0bd5.1767984037.git.gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 18:02:33 -0800
Message-ID: <xmqqjyxqtebq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void format_branch_comparison(struct strbuf *sb,
> +				     bool up_to_date,
> +				     int ours, int theirs,
> +				     const char *branch_name,
> +				     enum ahead_behind_flags abf,
> +				     bool show_divergence_advice)
> +{
> +	if (up_to_date) {
>  		strbuf_addf(sb,
>  			_("Your branch is up to date with '%s'.\n"),
> -			base);
> +			branch_name);
>  	} else if (abf == AHEAD_BEHIND_QUICK) {
>  		strbuf_addf(sb,
>  			    _("Your branch and '%s' refer to different commits.\n"),
> -			    base);
> +			    branch_name);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>  				    "git status --ahead-behind");

OK.  We _could_, just like we moved the "upstream_gone" case to the
caller, move the "up to date" case to the caller as well, but this
reads well now.  And we do not need the (!ours && !theirs) case in
this if/else if/... cascade.  Very good.

> +/*
> + * Return true when there is anything to report, otherwise false.
> + */
> +int format_tracking_info(struct branch *branch, struct strbuf *sb,
> +			 enum ahead_behind_flags abf,
> +			 int show_divergence_advice)
> +{
> +	int ours, theirs, sti;
> +	const char *full_base;
> +	char *base;
> +	int upstream_is_gone = 0;
> +
> +	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
> +	if (sti < 0) {
> +		if (!full_base)
> +			return 0;
> +		upstream_is_gone = 1;
> +	}
> +
> +	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> +					    full_base, 0);
> +
> +	if (upstream_is_gone) {
> +		strbuf_addf(sb,
> +			_("Your branch is based on '%s', but the upstream is gone.\n"),
> +			base);
> +		if (advice_enabled(ADVICE_STATUS_HINTS))
> +			strbuf_addstr(sb,
> +				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
> +	} else {
> +		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
> +	}
> +
>  	free(base);
>  	return 1;
>  }
