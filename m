Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8F8460
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810529; cv=none; b=hN+o9k5qJkOZea+yH9eKzpkJeQXkvZ4GTJ1YJlwVRQiVLdqMxHmxFPQ+Z1Bv++btHisn0PpZJ4jpJNrV491KrbJbFE/IyHEhSjz8rYZE/LCNZSC4fivQT4jTHcqtM7Mrjxn2TBXbCh5nJZw2PQLjlKGeHByinES+Yb0SKgKZ38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810529; c=relaxed/simple;
	bh=tOasZbcJMnYdOcFGv+YVyXYlfPr7iOKBFGrdSWtGGzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdQBZx/USRNabfFxy/48NxyFHyXj/StnUYZ7xv1x2t8wxtqcVffqe1MWbqgVDgBb/bpk6ekanofGVL3WVpCQw07/TMuWpramrw28ZfTsP6/G1evsxGz1fDx/WhgkmpZD7U/R2KD5rvELkIiStffnG/1fp9NsV7qQfw9Hlgl3vrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YqP4bOfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwS/uSYP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YqP4bOfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwS/uSYP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 937051D0012F;
	Wed, 11 Feb 2026 06:48:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770810527; x=1770896927; bh=WKR4nidAf4
	eBYPccyIDvmL6gHZw7WHx2GS+p+9DpFxw=; b=YqP4bOfliMBegexd4SxDMJvuPw
	HNNwcI1amt5xKt4x38QbKV4kkkut140BM9Ake0f3Mx4UGlWgDHdTmb1WvLiawC4/
	zEWayns9LEAzEc1wgiom8CBts4jYNw1BISVogSpq+Z0JfV7DxV9w9EwS0AxnpDdt
	UWYHg1+haRJwklsLiRXvCqyjREelmM6uUziSWynTiBfis3wVCJvqwyBY9+sFqvmg
	zp9uWgt7LI+iVxn6vu/kSq71eYTuQuUKMS6GWw0px2lPeGYGvIp5TzIOTpdJ+zAS
	mTnk3r/EOVelmTldOSdtSF1UqAYKMTMtZp2ibSZx+u+kkR9mRpCnftVpYdnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770810527; x=1770896927; bh=WKR4nidAf4eBYPccyIDvmL6gHZw7WHx2GS+
	p+9DpFxw=; b=UwS/uSYPIu73i0/oiRR9TZFAOJojigpn65ubVHFwyKdkCOEDcR9
	S1h8W72qDYav8LklVQETaI+hNuTF4Yp7F5kTgjx8GZZqU2ZS0v7WEttzV89oas1E
	lceiGjCD5/yCDwJ/U7Ms7p5oa0aKvawRvEbw8UOHAWn3SuHTwfg4Cxy6awdJUZm1
	0eB0ejRxBktyYdXh8pz2oXUsw/pgbpem3bePpKnM64ILfP3sf39SkcNzzF82PUDh
	Y2COZd22kjcB9ZW4VurOl98JP0RUnlK9QXarcceKmVoDuQ5moI1HRDFKKKF3eHsz
	I3PeCtWXk0IsePOmYQWSg8adl8R1CXPL1Aw==
X-ME-Sender: <xms:n2yMaSGs1oPKORKLC7PsJ7f9_TfK-5L4zMMQ5X5ojVYCByUPu5ibCw>
    <xme:n2yMaSbr4dtoVZ8RsuOhWQneqT4kLQ6lIfz5pg_1rjEobs5dpmioWBDF1TRJlDBvU
    eZeu0Fqxuf-VVtG1IxJ3FSRP81Kk2IHW6qStHXZp7zkh1kjKlZUoRo>
X-ME-Received: <xmr:n2yMaSUBCucE6bC8-DRy2DMi16LSywKnqf6-t2-GHLm7wWiuWzG9mBkTkq31YXZkLtnxYT9fDbxIcE-a4_6T0dYaUBNdryFnI4RENg07uhDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhu
    uggvrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:n2yMaYnYTvU6UowCOHZjowx39Wvn8joY1ik3VN5EodCk85u8uzuqdQ>
    <xmx:n2yMadDWp90YjZ6eQGzmLVWDAjaxwjV5O_Lmh2f_5LXlQiyEUqkE_g>
    <xmx:n2yMaXhU7XMxte-ILQ2SzVeZ642LajsF378zLfji1xvQ9U-kUgJ6Tw>
    <xmx:n2yMaawXVAfyr6oNCzY-2IIvZtywFxoaN4wmt3t_anoRn7FWgwuXLg>
    <xmx:n2yMacFFt_hZ7OzuuZo9GCGOWIQfraSBcoTsNGOqchcdW05QrYoaNzLQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:48:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbea190d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 11:48:45 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:48:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 8/8] fetch-pack: wire up and enable auto filter logic
Message-ID: <aYxsmsQlbm4t2zLY@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260204110818.2919273-9-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204110818.2919273-9-christian.couder@gmail.com>

On Wed, Feb 04, 2026 at 12:08:13PM +0100, Christian Couder wrote:
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 40316c9a34..5e9a969e31 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1661,6 +1662,33 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
> +	const char *promisor_remote_config;
> +
> +	if (server_feature_v2("promisor-remote", &promisor_remote_config)) {
> +		char *remote_name = promisor_remote_reply(promisor_remote_config);
> +		free(remote_name);
> +	}

Huh. Do we only call this function because it calls
`filter_promisor_remote()`? We don't seem to care about anything else
and do some more work to assemble the `remote_name` string that
ultimately ends up being pointless.

Maybe we should instead expose that function?

> +	if (args->filter_options.choice == LOFC_AUTO) {
> +		struct strbuf errbuf = STRBUF_INIT;
> +		char *constructed_filter = promisor_remote_construct_filter(r);
> +
> +		list_objects_filter_release(&args->filter_options);
> +		/* The result of resolving an 'auto' filter must not be 'auto' */
> +		args->filter_options.allow_auto_filter = 0;

We didn't resolve though, we only released it. So the commend doesn't
seem accurate to me anymore.

> +		if (constructed_filter)
> +			gently_parse_list_objects_filter(&args->filter_options,
> +							 constructed_filter,
> +							 &errbuf);
> +
> +		if (errbuf.len > 0)
> +			die(_("couldn't resolve 'auto' filter '%s': %s"),
> +			    constructed_filter, errbuf.buf);

I think `gently_parse_list_objects_filter()` already returns non-zero in
all failure cases, so shouldn't we rather:

	if (constructed_filter &&
	    gently_parse_list_objects_filter(&args->filter_options,
					     constructed_filter,
					     &errbuf);
		die(_("couldn't resolve 'auto' filter '%s': %s"),
		    constructed_filter, errbuf.buf);

Patrick
