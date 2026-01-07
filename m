Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC52FE571
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780348; cv=none; b=mkMqqIril72RqZz6pBAkYqaN0VnFeR+9TFvGK11PCnyrk+Ks/gpey1y05NPTJwlyE6xgB/n59+uFQIhACxtcNLWhUW1GgU2Pzmsf0MH/WnBKISWgoApDll7yy3mKGH/BOefHxIzoum+KA1cujojFCYZ6Yg8vMVHCIYclvZ6YrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780348; c=relaxed/simple;
	bh=AOQJq3a8CFcZnZ4KZezntOnp/LuRmd6mPlSATn1hGJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTPyDGYIGuhPkjE5vSAxYK4iLpsizvHwOBbczrCMYm4VeFl0izX67rqa2cBhaqSwpJxlhw4bjZ1Z4sOcJol6Upd09nTrre9sRCXqMN96MQKuXdEga+6hvrspj7e4O4lgi8OfwzJ9JKxUv242t0f1ipIuvAh68xInuApPjQip+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XbCuQRAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHWr5AWc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XbCuQRAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHWr5AWc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 55FD0EC026E;
	Wed,  7 Jan 2026 05:05:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 05:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780346; x=1767866746; bh=jf5CRme8/w
	4T3oGO9Wgl3YV+nqLlQ+upIMLX7ZspKP4=; b=XbCuQRAXV5PulPegUAdCOZpsqr
	iauDjgwzx4YJaPNUkxtotE/NGDlXJ0Vvss7JBgf0dfd95MYu/v6Astf4gIcMvBm2
	LVKMWU3S0kobn8ocnGndQh0iOOAV4Bp7jZckVMDBqmfLZEE2XJbh+9sZKHG3CSQq
	PUSVQh6hDey+dzZC8/n6DA50JTo8MfwdQNm0ziUDUzy5IVPRU2lJWYHsA54Crk5q
	73Lva8KJfifv2DHldNd2DeP9Yh6vTuhd07K01V3h9z9HrA128N6idw6Rm1EcPNzD
	fagLzoxIoIUAchpGIjnt088fhBAF5kP34ZzbHiKJ7jYDCaLukzJqrhUbYg4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780346; x=1767866746; bh=jf5CRme8/w4T3oGO9Wgl3YV+nqLlQ+upIML
	X7ZspKP4=; b=RHWr5AWcXnCZM3AVBjGwtFRg1IrdopHrxvVxzq43c507PsskOl6
	PZoy+Q3Luh/19gZpu3S7lccUT24xXmtySVB4Z0Iwn1AVkiwp/ILgIWw4eVo6J6SF
	ucNAa4dNmQCLU2M3CmtiKITc6ln9p284XfyuT6F0Z/fBaL12BWvDwePwOXXbi453
	qPp1PAX/C/uuGuz/hOt2jvwmWpKKYZGDyYzi0yzydOuOJ7ja36CEhWwX9I2dvI81
	4NOuo/gh3Sr5S+q4ojgpRKC7mt3ZMBRCwlW9LOHLe58QMYTdkm16PHzEXGeiPclL
	RSYnpqHSb0W1gFOx/faSCohAnNELtpjrcNA==
X-ME-Sender: <xms:-i9eabnc5cifgdvnBEqxwKzQj8IDtFqahCBcItZAT2t4ugmiihUW6w>
    <xme:-i9eaRE1h_Xa4i5LCNXN3sbCtS7Ksqm7qhetlvsq092Ws8v30VZmA2OD7AGhijB_R
    I1Gs9lGZevFWbu-4Y9GR94jXiAJ7m1pbqrPk7y5MucO5xTMvw-EUQ>
X-ME-Received: <xmr:-i9eaT66LplK8pW5iZ99GSRFlOId_jQXT6JgWJtw--_yZ2S-5fZDUZfmksZsZ13x42jDZzPiHx_X_0bqWLXrYqRUXXle2t5QrDDXuiwusHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-i9eaZluEDgH75Ae-ZJL2OM5E3S3sXa32qTz8mlG-bnHRkgl0aVu1g>
    <xmx:-i9eaYphHY26X7bQyuPxPmmJIMOrAwvSqFIg2y9tJ8Fx9F4RbwxgaA>
    <xmx:-i9eaYvjqWSmIG5YVhMnlOnqeGyQOMnc9dqd9F8D80aBR3iTPX0UNg>
    <xmx:-i9eadEfw0DfPsMRMzwZf_RMDoulo4dSwPJuXkhgYV9rhVrJ4Ko6Gw>
    <xmx:-i9eaRoaLPFoEB_3EmngRPImAPynRR61k2DGTfScQLD76PDuoLeCLU-W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88b380da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:44 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] promisor-remote: keep advertised filter in memory
Message-ID: <aV4v9WhL95Gcqr2t@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-9-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-9-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:12PM +0100, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 8d6d2d7b76..d5f3223cd0 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -837,6 +838,7 @@ static void filter_promisor_remote(struct repository *repo,
>  	struct store_info *store_info = NULL;
>  	struct string_list_item *item;
>  	bool reload_config = false;
> +	struct string_list captured_filters = STRING_LIST_INIT_DUP;
>  
>  	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
>  		if (!*accept_str || !strcasecmp("None", accept_str))

Nit: I found the "captured" terminology to be somewhat confusing. Can we
maybe rename this to `advertised_filters` to clarify?

> @@ -890,6 +899,25 @@ static void filter_promisor_remote(struct repository *repo,
>  
>  	if (reload_config)
>  		repo_promisor_remote_reinit(repo);
> +
> +	/* Apply captured filters to the stable repo state */
> +	for_each_string_list_item(item, &captured_filters) {
> +		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
> +		if (r) {
> +			free(r->advertised_filter);
> +			r->advertised_filter = item->util;
> +			item->util = NULL;
> +		}
> +	}
> +
> +	string_list_clear(&captured_filters, 1);

Ah, I was wondering about memory lifetime first because we ask
`string_list_clear()` to free the `->util` pointers. But above we set
that pointer to `NULL` in case we retain it.

> @@ -935,3 +963,23 @@ void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes
>  
>  	string_list_clear(&accepted_remotes, 0);
>  }
> +
> +char *promisor_remote_construct_filter(struct repository *repo)
> +{
> +	struct string_list advertised_filters = STRING_LIST_INIT_NODUP;
> +	struct promisor_remote *r;
> +	char *result;
> +
> +	promisor_remote_init(repo);
> +
> +	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> +		if (r->accepted && r->advertised_filter)
> +			string_list_append(&advertised_filters, r->advertised_filter);

Would we ever accept a promisor remote that _doesn't_ have an advertised
filter? If not, should we maybe `BUG()` in case the advertised filter
has not been set?

Patrick
