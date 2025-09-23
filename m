Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376430F809
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624787; cv=none; b=IfJ6Zqs4hPQADiAb9iGD7J4v+YOyT3ToNmiC9+n5el6cgI7bRgBU71aUU/kSTc0F8lCDgGUY1iCo0VR4yB1YEupUg/e7f/A9hdEJrUYYogm75ISA0X6sEPON1Jg7tGiH9+w7Kx2upjXsmHgNxvijgF7DUQJvcQKT4yZPhP0ExeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624787; c=relaxed/simple;
	bh=5HR3hZzBS+3VgMaox0OkT61v/qp1k/k07af45FXgajM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSoIBV6AqgTQkGOz9MvWtlEedhYZs8ARFqaCrrx3x/2YIAzk3oj8vAPMuCrUys85hZDI2lb5UrN4G0/lfSc8Xxx+AIPBFLWX6+/v+c6T5Ci6Qpxl8yFCBjMbQpds0f4+s8G2bux4ucxaJIjcBhBPQ6ONzf6ba60Y0bIV1kn32mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tIqC+sIY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avUIaGpl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tIqC+sIY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avUIaGpl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 752417A0067;
	Tue, 23 Sep 2025 06:53:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 06:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758624784; x=1758711184; bh=Bsm01LuDGQ
	Bu7J6gbv6/GqFbS9hrKWmIe6ffGNIbFOo=; b=tIqC+sIYZ/v9hMNwq+SVve62sJ
	3bw8Tloet4oz8dOjNhBnOGO6Tnam+gqieaeUZba26LrEj4HEVkImnsc4F5O3oEW9
	RwPrj8sYjYYfWfM8xQO1n8ohG6ekytWm5ptu8kNA0qdlEJijMWW9ESfYIp1GH8C7
	WrcaYvWJl/hNEvfU2j2t08tviGiUwWss+0G567Y/jTmhPhscgRk+u3LUM2yNLTvb
	5UTleR05qN61K83PY34weCiTNEzZ6NMrKGl4+IpxWBxkqsEq1P/m5/IDHGMPHHqO
	WOXg5A0qEZ4ebH54sPjT85h48x0JP3Jmur5up27Y4gIieL+HF7+mmfgtaLFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758624784; x=1758711184; bh=Bsm01LuDGQBu7J6gbv6/GqFbS9hrKWmIe6f
	fGNIbFOo=; b=avUIaGpliFNL6Xti5ecRtoKHkxOGdPPC5oMZuP/sG7zqN7S6+ki
	Kyz4iKY5zibCFaHitAJt5Kmo6cCDmiyznGkDCHs16KYqPnsThEJVMDmfOekBKsMb
	UHwVMKK9vHahjgxmjpFBsDih/8P58LM3BTf5pySLJnABgoG6vxhoPv2PXqJUIsEo
	oBUluU2sQeWuW/2ZQ6XY5mOltGnldBV9c9GZM2iRlx30d5cyNEJGkbg/cTVJX9f4
	ChcpjRzUJT/CjoSavL5ts7c6gkLNDERlgCg5jEkwsxg8m1tV5djOdP7VdzJi1irR
	pE1ButE3TLc+NoYfUipZ/XUsmXp4gslJPQA==
X-ME-Sender: <xms:EHzSaDjnQjaB51UbfBcENajcHDls2vkkpwnYIHVYfpzqESN5yfhReg>
    <xme:EHzSaHe6qp9eqV-51OQsyKQpwsDNaO5HsS9w-36_3yV-al4r3pqCOKTA5f2oC034l
    bDieH58WBW3z2offEoBQT_3CdlmLNejwwa7dpDmyqAoA-BIStGn5A>
X-ME-Received: <xmr:EHzSaAdXaqshZ0p00p_GTzjObTB6OyEwVgsDsDZtNmXAQgqQRXq6R7OV-xhHaos5NfL4hk9tpZNButqklcRy6z6P7bPo_sAfbevzE7N3ya8N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:EHzSaJ_btbuM0cBtVhgXSQBA3jE5tAgolwof0fXBRYd46SIhmw4maw>
    <xmx:EHzSaEnYtBIFwU453WsaQ068qb0Zhbf28cjMNdnOsZ7rHtrI_hagug>
    <xmx:EHzSaD8uLy1JtGcaD_QiSu3eAsQoVeR0AaQBvFFRZmCu_WkPPf9clA>
    <xmx:EHzSaKlUilI1wTqMicwN4rfBSPiw60vxkD6Qe8G8GCk9qCHUNT1xHg>
    <xmx:EHzSaC4itwB_v-dUyBxuCNH-fpLjB9_GCRt0n4Sk3HHisO-P_7tIfrEB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:53:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a71973d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:53:03 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:53:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 3/4] builtin/repo: add keyvalue format for stats
Message-ID: <aNJ8DIPI0v6Jhn5C@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923025700.3046260-4-jltobler@gmail.com>

On Mon, Sep 22, 2025 at 09:56:59PM -0500, Justin Tobler wrote:
> @@ -157,6 +160,8 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	if (format == FORMAT_TABLE)
> +		die(_("table format not supported"));

We can deduplicate this error message by saying "format '%s' not
supported".

Other than that, let's fail closed and say `if (format !=
FORMAT_KEYVALUE && format != FORMAT_NUL)`. Like this, we won't have to
update the condition every time a new format is added, which is easy to
forget.

> @@ -286,6 +291,32 @@ static void stats_table_print(struct stats_table *table)
>  	strbuf_release(&buf);
>  }
>  
> +static void stats_print(struct stats *stats)

I think it would make sense to call this `stats_keyvalue_print()` to
clearly distinguish it from `stats_table_print()`.

> @@ -359,9 +390,16 @@ static void stats_count_objects(struct object_stats *stats,
>  	path_walk_info_clear(&info);
>  }
>  
> -static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> -		      const char *prefix, struct repository *repo)
> +static int repo_stats(int argc, const char **argv, const char *prefix,
> +		      struct repository *repo)
>  {
> +	enum output_format format = FORMAT_TABLE;
> +	struct option options[] = {
> +		OPT_CALLBACK_F(0, "format", &format, N_("format"),
> +			       N_("output format"),
> +			       PARSE_OPT_NONEG, parse_format_cb),
> +		OPT_END()
> +	};
>  	struct ref_filter filter = REF_FILTER_INIT;
>  	struct strvec ref_patterns = STRVEC_INIT;
>  	struct stats_table table = { 0 };

Nice that we can reuse the callback.

> @@ -369,6 +407,10 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
>  	struct stats stats = { 0 };
>  	struct rev_info revs;
>  
> +	parse_options(argc, argv, prefix, options, repo_usage, 0);
> +	if (format == FORMAT_NUL_TERMINATED)
> +		die(_("nul format not yet supported"));
> +
>  	repo_init_revisions(repo, &revs, prefix);
>  	filter.name_patterns = ref_patterns.v;
>  	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);

Same comment here regarding failing in a closed way.

> @@ -376,8 +418,17 @@ static int repo_stats(int argc UNUSED, const char **argv UNUSED,
>  	stats_count_references(&stats.refs, &refs);
>  	stats_count_objects(&stats.objects, &refs, &revs);
>  
> -	stats_table_setup(&table, &stats);
> -	stats_table_print(&table);
> +	switch (format) {
> +	case FORMAT_TABLE:
> +		stats_table_setup(&table, &stats);
> +		stats_table_print(&table);
> +		break;
> +	case FORMAT_KEYVALUE:
> +		stats_print(&stats);
> +		break;
> +	default:
> +		BUG("not a valid output format: %d", format);

Nit: it may be valid, but definitely not supported.

Patrick
