Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2123E324
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820016; cv=none; b=KmQkFQkKvbeC7T7IRusBsM1w5uDxBNcyA8lT2P5clpO9cASbOIFMQNj9U20WWWRCaVrko005ZUPr2DLC0YAwTB6LRx7B2Hu1U9A3WdRxJfg+m7oihxD2FW6uElQ3LCQ46jkT+KYjkS8NxZxR3045mwXPIOlV0q7mdFTSTUXWehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820016; c=relaxed/simple;
	bh=1yqjA4KSySah2NyWqqpj+fVLNorrADR5j5G4hJzqz1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtNDYb0wnnvQKDK0PPtLK86JBqcrqc9Tl8J5DN3RZqYdINtVvDlGROo1zUgXnldF3izdiW7LPTes7vFUh5eYEXZiiG1iYsxEn0rO6kZ8jL5EE1G8qsQiQw8aeVLr+rrK+5Xd8/Dk1SVqJHw7kdGekyWngPbHm1qf6RSVLKJ+nOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FzbYP7gp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBoJEr1N; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FzbYP7gp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBoJEr1N"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 50CB9EC02D0;
	Thu, 18 Jun 2026 18:00:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 18:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781820014; x=1781906414; bh=pRdXXqgXAH
	HhjLA/NgSCaeG/WnE2WsV4UL1+xqev2lo=; b=FzbYP7gpkG+vfMzHlKOHynBJBz
	YCH0fV5u6fhqfp/WoZHhuTGFYRK4/hkKjUUMU38BVUx5StIjcXUF/tavbR+5tLPk
	gVV2760Xf3HasTXJQaLkj7+zHKObLJz27SaxplPbUBJO9LFIrlc6tzq1tUmenyFG
	kAq66T0G79NgfnuWUE76XfwV2mKOYDfZDSS0ghNY3T4/za9DWCkmvw2Q6pAjPFvv
	/T0kDS620EoTV5jhRAQlEi4Eo+iCi3N618WnhbgtEwvVjx86qlPnUKOfn0AY7o1U
	LS/MhVdoqMkH8tTfDEG6UFJpSOtTfDbWzxfltI5aIxxI62vd8zUPucpv4lVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781820014; x=1781906414; bh=pRdXXqgXAHHhjLA/NgSCaeG/WnE2WsV4UL1
	+xqev2lo=; b=TBoJEr1NqktahqHRsvt3tnW3mp8Qc9OZez2h6yFu7EjGsdfEHLx
	lJFOpuW/593JXn/Ez1+rdovrafvnzdnui3EKcLIueoSqvP9s88i0ab5izeROYGVD
	iBckT2I0Q1eXQ3rI0CNPE2Vh6Z635J1AsAoBN92fEQaXr4FKgyJAWF/ivlr7OI+E
	XJ2dfS6bOSfLBYZpmiz3HXc5AHfku/+W6JQAFhQFXRJn2usvxjOxk8jZMBobI7RO
	Xt0jfp1oQYrUv8o0hcTMpRd7Y1NC0ESjtNFNFmePQBb6EZWwZt4QBnZa5KRB+26E
	Yc65hjGo5PtCgXZH/LtysWKcl+pNFeMx7BQ==
X-ME-Sender: <xms:bmo0aow1cQ6pNkVA9xHzmyNLq7Zx2A3D8knNNtxLJbY0LMF28LXvdg>
    <xme:bmo0ajJ7jLzYLObstZcg7BFYQZWghCQuxnc6MVNuuvXcYAqiNjbg-tSxAbeIqZG8N
    fBYx8Opo-e7Fp0BI91hqD7mxfwFpnhsbPu-pZdo8PqO_UwEYM_Y3Q>
X-ME-Received: <xmr:bmo0airzqQ-kgSMuEqcZEuiu03p4Hv4kON-oXTmb_ufzP84r_-RntDFaj0TjoK2xU09qRBDhFuXHD_Rqi12g1h5mkv5gxP7QC52Y>
X-ME-Proxy-Cause: dmFkZTFKjv/SYDqxPEmgUb6YMpvmpscru8yzTlqy83evJJripu2U6I3+ywL1ln/PMQbFhL
    4Mc6hUmUXsdLqAnKoKqwYc5vuoVIXFIK9vLEaBMgWaZr8nDxq2zQhQHvDb89b8HeNDmqOa
    UJKDNR7bEb2iwI7UIqyei5VuIepzALsequgW3bpaZLCrCRQXsxoT5XHcUe+xfOCQ5Hx90F
    P/yrODWpVX5NQyTj7SbJItRKMI1Q8Mb442SuuCJj/PjzmBqSULmyAuFmhlNgHvCXLCLndj
    tvl0GSbhLBYHq3YEBrYOXa47aTxT5pBvcpX1i/lGGpphLft7nvrJ+I90df69eTXjNNzxpF
    +OD7Fkeh+2lM/d9UpgqQzz32SHdHEflWmBdgi9l9+PMGXpxXIzZSIpgTA5pPcF1Ytf7O0p
    1ZAQgi4n4Wlm+VjzTW55IzH+ppCxq/+T/PJ/3tAs+IhH9oCpKGfZ68Lj298UkalBWIXluE
    tKbkWKI0XiBYpWzMF61kY6HbsDU3u7oTjtllcgQ4yafyEC/IGsDMFJ87Dx3LlNu/WBn3Ph
    8iTLliww5u0PRZs+hlZuBOwLOvq8uucYGB0WTG6nWVlQVghZlhMliDBPzVGsFERvGP3/Ot
    Z3HY1j096zz0ZkDxrni0SxIz3FDke6Ix5oX048EoslOwCm3bbOiD718dc0ag
X-ME-Proxy: <xmx:bmo0aiJvLXhEN_VyCd2DyBnuVnFOdiouKLX0m-QREeMzDAm_d9sfaA>
    <xmx:bmo0anSaniFf0Wp5uG7tZKqXiOrUbomh9NBTdpSD1cQzNcoa1PrDHg>
    <xmx:bmo0ahtVOM6RfEFWul3T5NScj3sVS5i055I-3OvJ0knozLqPaASCrQ>
    <xmx:bmo0aobGj59KbfpUuMhdsW9NvIH6cl4Hq0F73Ndjr1nf_qWGGEhtpw>
    <xmx:bmo0atZPX0Brf5jn8lweBi9to-wBTyoSsB3ZBQAdnKh2miBGilj-6tnV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 18:00:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Michael
 Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 5/7] line-log: support diff stat formats with -L
In-Reply-To: <a70d861d27a13459bab34f6681b3ccfe2f20d0d8.1781806593.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Thu, 18 Jun 2026
	18:16:30 +0000")
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<a70d861d27a13459bab34f6681b3ccfe2f20d0d8.1781806593.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 15:00:12 -0700
Message-ID: <xmqq8q8bpl03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
> index 72f639b5e7..1a25f55bb1 100644
> --- a/Documentation/line-range-options.adoc
> +++ b/Documentation/line-range-options.adoc
> @@ -9,10 +9,14 @@
>  	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
>  	You can specify this option more than once. Implies `--patch`.
>  	Patch output can be suppressed using `--no-patch`.
> -	Non-patch diff formats `--raw`, `--name-only`, `--name-status`,
> -	and `--summary` are supported.  Diff stat formats
> -	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
> -	currently implemented.
> +	The following non-patch diff formats are supported: `--raw`,
> +	`--name-only`, `--name-status`, `--summary`,
> +	`--stat`, `--numstat`, and `--shortstat`.
> +	The stat formats show range-scoped counts: only lines within
> +	the tracked range are counted.  `--dirstat` is not supported

If "range-scoped" is a widely known term (as opposed to a new word
invented only during the introduction of this topic), the above
reads well with a nice rhythm, but otherwise it may be easier to
read, i.e., something like

	The stat formats counts only lines within the tracked range.

without having readers learn yet another new term that is only used
here.

> diff --git a/diff.c b/diff.c
> index 6233a96bf0..026fafeb90 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4289,7 +4289,18 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  		xecfg.ctxlen = o->context;
>  		xecfg.interhunkctxlen = o->interhunkcontext;
>  		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
> -		if (xdi_diff_outf(&mf1, &mf2, NULL,
> +
> +		if (p->line_ranges) {
> +			struct line_range_filter lr_filter;
> +
> +			line_range_filter_init(&lr_filter, p->line_ranges,
> +					       diffstat_consume, diffstat);
> +
> +			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
> +						   &xpp, &xecfg))
> +				die("unable to generate diffstat for %s",
> +				    one->path);
> +		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
>  				  diffstat_consume, diffstat, &xpp, &xecfg))
>  			die("unable to generate diffstat for %s", one->path);

It is pleasing to see that this can be done with such a surprisingly
small change.

