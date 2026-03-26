Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39E3F166E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527670; cv=none; b=PyZTkPZvZAVnYMHfp7UhA8pe4gGRwy6lmsZPgTLDNkdSI2DM2TdkxePveRITKJXEYjKXZQeSRyJfJi9Ft0ruo+zyXw/3nNLPg2UvCzi3qgsGFg2Ekwmfpag/2y1F4KiVjBaWPnlsv6LhY84EquHm/NAc/RnpmncSugiK/wZI8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527670; c=relaxed/simple;
	bh=M2qCGOOKKa6Vu/vUuGeYaJPijXZW6VNvYSzCfBZAU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYgsfpZfFW0jB0hA7ctD2bWKcuDCyJSsQKkj9WBaH2VSchAEopupMmYwIO/6WTVuTPvNd9N+eZDi0Rbb/4TmymlHgYTKsAJ4plyTwTtIgbo9H+X4Kfpd80v99VFU2jU4vKCjarQEMtz88lbpBF4McuW5ROblGhblKE13V2k3aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gw3Ze5DA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSXh9+ia; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gw3Ze5DA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSXh9+ia"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 187CC7A0067;
	Thu, 26 Mar 2026 08:21:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 26 Mar 2026 08:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527667; x=1774614067; bh=acNXEG3C9p
	3RtvSPbxxhxSD+Ss19u8xrBKF6j0kUJRA=; b=Gw3Ze5DA6FEqoDTI1+DNglFHxE
	ziH1Kr5l97MbbGJOFZzmcZt2pYi+lPM63xs+JbCVdeXyupBpWyfA8kDs0WUBrYnP
	RvTalB/XDPnWbeclcimLrzvTpxrC/9vdx9YDg0Dxy7ar+Ul7QKrg6lCi140Sfzbr
	XMALmWYCSho1SpaUiYmRnkHBwhNCUqyDNvyWqT1xcsKAXWfsYmh5acpQEDGX22Sg
	bx7QxvOUUuwqq5fqmdO0SghP5bDGZn0dbbAWPcKwMX4/lLZGGltw00CH3oGBlHMM
	v262ZSbHsl8elPpuu6hwmQ47SdFqEpysfz6r+vH5hMPupkuSM41qePhKXo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527667; x=1774614067; bh=acNXEG3C9p3RtvSPbxxhxSD+Ss19u8xrBKF
	6j0kUJRA=; b=qSXh9+iaS5Gbm1QYigDtXqy8XVm42VuosFgcWVwNJNZY71u/r3c
	ZOqbM6NTb2mVUt5FyvcbZfggUORi5DMcAQr8TFkLMOf3xfiCoSzOz5ftDM7EPhOF
	w8dSDeBn/MwLbZTpEH30CsuTFIEWjkEFTqkB4tqBk0od2ijGgaZx2blEfZKu2AQW
	UDQ+ftBObhS2rt2V1mEgClIDxnxc6Pg+qG316Fk4KEepW1pChX3cTMIUXddOu3Xs
	XT+rhHjEzvfJmWQ6jVoC3KJ1pYTZKLfh2v1ZvCmx7khTkwpUi+S4ZvIXYQW0eqRu
	UaUJwAbM6zaa1rUKmWpEO4ooGmVER+rqPAA==
X-ME-Sender: <xms:syTFaXgdfcoovFQODB15oHBkdQ0Ifc_RgGidIhkm33ox5McDiJMM0A>
    <xme:syTFaWRgLdkaHfwe7KI53iy9s9CdNoAugGTu3qTyInG4TnG330u04xueIm2ab2H7c
    0eAdRi19ddzArakYfDYawVHPd7MASS0BMGTb0IU7QpsPKeVBIRREw>
X-ME-Received: <xmr:syTFaZW-X7zX0WJMaeUL-lsdZ1nVIMbce_7b-COB7XHYDMAu3FtXvnHdTxEeJTJoaISsa9e-Xmchxgo-EKHAsaf2H0T9-ZEuv_aRWwgWzZC6Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:syTFaaRxCbAuO7ViAbQfcXgDh9F1UqxclJoHteoRG5RstQqNZkehjA>
    <xmx:syTFaTmPA7M5MzH4vroESeXn5WCkNlzGufnpX5iYJ9y5002uYPuA8g>
    <xmx:syTFaQ6RCjTm5-dcFGJgvex7phKfriqF30VAjxkz0gV6mutzv4qWVA>
    <xmx:syTFaZiylPdkbmN5jzxDWQBm-Nt4j9xvtSfEb6D5MwKb3qnGfVV2hg>
    <xmx:syTFafBgiw8m13zALf6644B5n6pNofNK1zCMt2dc4S5tba-uS_YADS9O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccf8558b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:05 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/16] promisor-remote: keep accepted promisor_info
 structs alive
Message-ID: <acUkr2xxQZSJU2lL@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-8-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-8-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:10AM +0100, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 3116d14d14..34b4ca5806 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -912,17 +912,10 @@ static void filter_promisor_remote(struct repository *repo,
>  			if (promisor_store_advertised_fields(advertised, store_info))
>  				reload_config = true;
>  
> -			strvec_push(accepted, advertised->name);

Okay, here we used to store the name of the accepted remote...

> -			/* Capture advertised filters for accepted remotes */
> -			if (advertised->filter) {
> -				struct string_list_item *i;
> -				i = string_list_append(&accepted_filters, advertised->name);
> -				i->util = xstrdup(advertised->filter);
> -			}

... and here we used to store the filter, if any.

> +			string_list_append(&accepted_remotes, advertised->name)->util = advertised;

Instead, we now store the whole remote, ...

> +		} else {
> +			promisor_info_free(advertised);

... unless we don't want to accept it, in which case we free it now.
Makes sense.

> @@ -932,24 +925,23 @@ static void filter_promisor_remote(struct repository *repo,
>  	if (reload_config)
>  		repo_promisor_remote_reinit(repo);
>  
> -	/* Apply accepted remote filters to the stable repo state */
> -	for_each_string_list_item(item, &accepted_filters) {
> -		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
> -		if (r) {
> -			free(r->advertised_filter);
> -			r->advertised_filter = item->util;
> -			item->util = NULL;
> -		}
> -	}
> +	/* Apply accepted remotes to the stable repo state */
> +	for_each_string_list_item(item, &accepted_remotes) {
> +		struct promisor_info *info = item->util;
> +		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);

And instead of iterating through the accepted filters we now iterate
through the accepted remotes and take their respective filters from the
promisor remote info.

> -	string_list_clear(&accepted_filters, 1);
> +		strvec_push(accepted, info->name);
>  
> -	/* Mark the remotes as accepted in the repository state */
> -	for (size_t i = 0; i < accepted->nr; i++) {
> -		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
> -		if (r)
> +		if (r) {
>  			r->accepted = 1;
> +			if (info->filter) {
> +				free(r->advertised_filter);
> +				r->advertised_filter = xstrdup(info->filter);
> +			}
> +		}
>  	}
> +
> +	promisor_info_list_clear(&accepted_remotes);
>  }

Patrick
