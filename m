Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D25282F1
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798947; cv=none; b=UGd2jQKmP1k6cOaJfw4lZCsqAcvNrr/UWnAxzm7en+Qv2KeYaH327MRY6V9P3leILxi0P6yTmX75LhvKDr5puFPFuv+zLNDRZJFYkAY3eTnqmwvFlkK3wgN3w5NeTBEoUPh8QI9usSBc/FihuYSMYmu/eb5s9n+sitV/aZnfcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798947; c=relaxed/simple;
	bh=iKubcb0WtSv5y6pgo23RBfra6zHE/Eu6lOWv28aR0h0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=miInn7j+RC3RjRy+AkmrI29JpmBpsT4sPZCPui/og2BZMsYC6Xcj51s9iJlcsLK1cUPB1XnIupzEmo8K30W0plIlwQg/ifvP5zC44aYcrQUqaNdslyzbe6PHIl1Q0QEU5uD9rUeaMiijwbxgTRvfiJfo+sQiHpXzGIifkOBuAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F61I9WM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lk4b5pew; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F61I9WM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lk4b5pew"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DEE031382CF9;
	Wed, 12 Mar 2025 13:02:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 12 Mar 2025 13:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741798943; x=1741885343; bh=XzB5Beu5U2
	uFC2aX3WLV8+f2nbgg+SiDTaaXNwyPtSc=; b=F61I9WM27IwWK1gA0QBAN3We+D
	znapNrTVX22Qe/H/lJRBhTH48Np8R0qpcs2VVKUsC/etJ2A0ZUVff2WbWqCbLj0v
	oNnTBD6PHwOMqBwRcEav8cm6a73tkd8yMT2luiDmzDhcCkZGVCpdJok5Bh/Z1P+X
	2YQkIQNb7QFrarR4jxVeWYrDhtCKuxJBL/Q0Jr7ADCACFPXbwTh9cLDGgzjKPFmU
	O+q/ei1zYyaMRW2N89InAq98AbzeaROpV3mwKF5R51500xbU9mAeVX0w4JEqIqEN
	m9ICAQCozsI22ru3QAB2FxpHkPxJk46lkSeVzJbHcqoYVUU7jgAIms/gEc4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741798943; x=1741885343; bh=XzB5Beu5U2uFC2aX3WLV8+f2nbgg+SiDTaa
	XNwyPtSc=; b=lk4b5pewwzNzm6WEXPuouH5jAJ51F2XiGSXYMMeLfUldflP8KA3
	nLvGGFYQGfFbJVV9XIFcIdN/fctzeGvvRstRSxi0WZaqp1b4DPt6YWGQbED26joL
	v/Aa9VLKJxvuB/PgCOOnXAUIdsRTQVhtOuy/4AIR1QLQYf2fSBYG2Yvw5r0C7yDR
	CSpuBbwDyGtWfK4tWCQN2WkPjxS4og3UvmeZ2KkAbP064MFCvZsh8JviSnbUsBA/
	pNfrpyW7vfXmjM1eMMHbo6YG9UBLLSUc+vaDjo8RfShYkK90YVDimYKDKBieAggC
	XHGdGfz4A/6kNBSZbboKZLugzM4Ydino90A==
X-ME-Sender: <xms:H77RZ0O4nTZK8lgHUGYAUv319XGwA2aTYlbtdZP5opm_eTNEzES3Ig>
    <xme:H77RZ6_CbTTAuz0MtxWXT4I7VNPUJkTQ6PNJI9fS24jeYPlTRZU4_54mIqBWuA4Pj
    tdgKYFxaAM7Xz1BxA>
X-ME-Received: <xmr:H77RZ7R2WSI2Dr1Usr46J5srrl912xzRV6XwBJvPeh1Igm9YwlImSmN9zmGYDeSPOY6OipWvAhfFtJ_DXhUZTJnkkvDzKFk5gBZ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:H77RZ8uukMuZPWZu_IUHXBMkbfRj5iiRymHkRvqUUlikR5VqM-v54Q>
    <xmx:H77RZ8eSDBMFTPxw1cUBJe_dBFCGMPL0wea7qLOR9cR3BQD36Wwy6A>
    <xmx:H77RZw3lk8rzQlYu7oA8wyp9DSQt07zRy-CCe_7TETJKY_SJki703w>
    <xmx:H77RZw_GWwGEcsAiIEXzgLRxc3KnvMMdvSh8oHH97EiiBTefGAtsLQ>
    <xmx:H77RZy1oURU323D2KgFOwG-Mtb6CwKEpOL3d2H6oardNZxgLLsGvoP_I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 13:02:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250312114628.2744747-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 12 Mar 2025 12:46:28 +0100")
References: <20250311152413.1059343-1-christian.couder@gmail.com>
	<20250312114628.2744747-1-christian.couder@gmail.com>
Date: Wed, 12 Mar 2025 10:02:21 -0700
Message-ID: <xmqqecz2yyg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>  	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> +		const char *url;
>  		char *url_key = xstrfmt("remote.%s.url", r->name);
>  
>  		strvec_push(names, r->name);
>  
> +		/*
> +		 * No URL defaults to the name of the remote, like
> +		 * elsewhere in Git (e.g. `git fetch` or `git remote
> +		 * get-url`). It's still possible that an empty URL is
> +		 * configured.
> +		 */

Not a huge deal as it is not telling any lies, but does the second
sentence need to be said?  An element in the urls strvec being an
empty string is not all that more interesting than it being an
incorrect or malformed URL to those who are reading this piece of
code, is it?  It is also possible that an unreachable URL or
misspelt URL is configured, but it is not a job of this piece of
code to worry about them, just like it is none of the business of
this code if the configured URL is an empty string, no?

> +		strvec_push(urls, git_config_get_string_tmp(url_key, &url) ? r->name : url);

More on this below.  Unlike "git fetch" and "git push" used as the
source and destination, the remote URL used in this context are
exposed to the outside world, and I am not sure the usual r->name
fallback makes sense.

>  		free(url_key);
>  	}
>  }
> @@ -356,7 +362,7 @@ char *promisor_remote_info(struct repository *repo)
>  			strbuf_addch(&sb, ';');
>  		strbuf_addstr(&sb, "name=");
>  		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
> -		if (urls.v[i]) {
> +		if (*urls.v[i]) {
>  			strbuf_addstr(&sb, ",url=");
>  			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);

We used to advertise an empty string name to the other end, but we
no longer do, which is a good hygiene to be strict on what we send
out.

But now our updated promisor_info_vecs() pushes our local name
r->name as a fallback. The idea of r->name fallback is to use it as
a local directory path for "git fetch" and friends, but the local
pathname has no meaning to the other side, does it?  Is it something
we want to let the other side even know???

What other uses do the name/url vectors prepared by
promisor_info_vecs() have?  Is it that we use them only to advertise
with this code, and then match with what they advertise?  If we are
not using these names and urls locally to fetch from in code paths,
I am inclined to suggest that promisor_info_vecs() should not shove
these fallback URLs (local directory name implicitly inferred) into
the names/urls vectors.

On the other hand, if other callsites that use the names/urls
obtained from that function do want to see such local pathnames, we
cannot lose information at the source, so we'd somehow need to
filter them at various places, I guess.  And this place that builds
up the string to be sent as capability response should be one of
these places that must filter.

> @@ -409,12 +415,42 @@ static int should_accept_remote(enum accept_promisor accept,
>  	if (accept != ACCEPT_KNOWN_URL)
>  		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
>  
> +	if (!remote_url) {
> +		warning(_("no URL advertised for remote '%s'"), remote_name);
> +		return 0;
> +	}

Except for the above "no URL advertised" warning and returning,
which is absolutely a good thing to do, I am still not sure how
relevant various checks for an empty string new code added by this
patch makes are ...

> +	if (!*remote_url) {
> +		/*
> +		 * This shouldn't happen with a Git server, but not
> +		 * sure how other servers will be implemented in the
> +		 * future.
> +		 */
> +		warning(_("empty URL advertised for remote '%s'"), remote_name);
> +		return 0;
> +	}
> +
> +	if (!*urls->v[i]) {
> +		warning(_("empty URL configured for remote '%s'"), remote_name);
> +		return 0;
> +	}
> +

... would it be so different to pass an empty string as to pass a
misspelt URL received from the other end?  Wouldn't the end result
the same (i.e., we thought we had a URL usable as a promisor remote,
but it turns out that we cannot reach it)?

>  	if (!strcmp(urls->v[i], remote_url))
>  		return 1;

Past this point, I am not sure what the points of these checks and
warnings are; even with these "problematic" remote_name and remote_url
combinations these warnings attempt to warn against are used, as long
as the above check said it is OK, we'd silently said "should accept"
already to the caller.

> -	warning(_("known remote named '%s' but with url '%s' instead of '%s'"),
> +	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
>  		remote_name, urls->v[i], remote_url);
>  
> +	if (!strcmp(remote_name, urls->v[i]))

The 'i' was obtained by calling remote_nick_find(), which uses
strcasecmp() to find named remote (which I doubt it is a sensible
design by the way).  This code should be consistent with whatever
comparison used there.

> +		warning(_("remote name and URL are the same '%s', "
> +			  "maybe the URL is not configured locally"),
> +			remote_name);
> +
> +	if (!strcmp(remote_name, remote_url))

This is matching what r->name fallback did so it is correct to be
strcmp().  But (1) it may be way too late after the above "return
1", and (2) if we are *not* going to use it, perhaps we shouldn't
place it in the resulting strvec from promisor_info_vecs() in the
first place?

> +		warning(_("remote name and URL are the same '%s', "
> +			  "maybe the URL is not configured on the remote side"),
> +			remote_name);
> +
>  	return 0;
>  }
