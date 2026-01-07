Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F72FE05D
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780344; cv=none; b=bkeylIfHzCgR699ck10KvFEGdAOimFv689YJjTo19WV/W1A3OXdpTzLjB9xin5L719uv6bXGWq0nJ8+JM6NDFJuzqg1F1Qu0vFMThkrFoHzw9+clW3kgObDMAHsCObzhXlTxZCLGBHmoQ+snvb8iBHcl4cKbnuvrgAHgE0w8V44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780344; c=relaxed/simple;
	bh=9GEP+8hbC4JifWOz7B8TkD7SD4fqp0B9AnCXY0WN61o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+gq3FIqyqeT8ClYvLzUbTKEQO8GhZEm3wKPq7CdjQ7Gm0zQlwgzp2jBwJQC3k3OHPv5mIc69brQozE+bOVt8fcTNORnJs1IDyZpXHhMCR6L4omzao+4QN7RRIB+p6NcOHekDiAs3G2/aizYObDHIQBDBTLl+ClPKq81h9Ftz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pn901qVr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0cWf99bU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pn901qVr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0cWf99bU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BB754EC0269;
	Wed,  7 Jan 2026 05:05:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780341; x=1767866741; bh=9oMn0YYNwu
	OhLvhNimK255nWYBVmVheMYeTr5DQTXSU=; b=Pn901qVrHB0rCY6Ft0ACjUJjvW
	K5daTrvHUwjFrDdhPXSOC+2gXmEDiRx9+cjNAOvqWyUJiHkuL0BJ9RCVV7m7LS64
	+GWE1BOj86YT0llJ+6o8FTH1tbm/edgPWih8tV02goiZWO3FLAvV64GAZrMEUb0a
	8RpRatCaBgZSyiKzfSB4/lMA7yJggIE8mRi+e2KWmfccRGaO902D3BaqKMwxItUx
	d2qrmLntYyuwRrXqHUECoQl9aSrBfMNYNym+wflb8vhXNU2M1iCP8f7lQeNZDxKx
	8O72N/7GPspjzVlUriXdwKEBZAb+fI89gc0Kqz8YdhIPlJGKxgRPWMyRXbdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780341; x=1767866741; bh=9oMn0YYNwuOhLvhNimK255nWYBVmVheMYeT
	r5DQTXSU=; b=0cWf99bURKfM9BvmO/Rqk3uSVpcp6SS5sLMfRBCvNojF92YeP8B
	kCWgU0f4WCdyYbCBG6g8L8Pw0S2mwuhvJsbZsNrVXQeeO2Kjvvs31tiyX8oYfr09
	HH1MKrOZYpvjMP+WYqi4+IuqGAOK+kyNjLUjEBvmThG1Q6wEbZGfvVvwWHDdjeX4
	aRJVoSQXGr9ac4IGXnR2RhkiaNWD3pzktOUqOvH7NiN0GsQkR5r13p61RB6SGcFQ
	JZ6l+Kgg3jv/RKjop15wj8g4+VbWFM5JrwTwOPfhlxgMILamInzEdDgtfqWqe+6a
	Ptb89kQFX/1REufYAn4bOxJhxcH0gf6tpSw==
X-ME-Sender: <xms:9S9eaQfkpQAVi5ccE8spIa0DcToveXeYfNcmNAn9BItyv1ibvLyjbg>
    <xme:9S9eafw8OIXh8DoknOSXjgIXQACeoyrOKtBrlTLF4TY3bScjX1442_ZXVBkHpEmu7
    TXizQLc7sURFQawelcbEnLjIvn4cqOspBP7PyGxIczpaBb0aLBC>
X-ME-Received: <xmr:9S9eaX_Nu46vRot7ZmssAHiuwakjQRnrLC7feXQfHKnpnD1cb6HGufacsq7Q58faeUE2bES7Y15kPYHaTp72HHjAl_fo60gzAJo8NBNcNFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesth
    hugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:9S9eaXhtX1v0-zrWPmrcSEeAvuiltGD1mo9oz_SrfJ_wkfdekdll5A>
    <xmx:9S9eaeHL6PB3HMfS69Rl5ejSNgrQCY1408aiKEJH3Xcvjtnpzq90Mg>
    <xmx:9S9eaW9QkT927wVg_QNgvcdljHv58MdEXHhypP3UW-euSs7A6SiREA>
    <xmx:9S9eaVz035Xemv1NWzrqG_3dhqwIJ4EwGxsWZGlaY0_eG3M_--Sryg>
    <xmx:9S9eaZhSVQvgLX8Zf_FeyhMecZb1ergmCpnfMgz7CRLsMdfVzUCN5cOp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf8a9109 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:39 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/9] list-objects-filter-options: implement auto filter
 resolution
Message-ID: <aV4v8HCe6CLqXJ-1@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-8-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-8-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:11PM +0100, Christian Couder wrote:
> In a following commit, we will need to aggregate filters from multiple
> accepted promisor remotes into a single filter.

Ah, interesting. I was always operating under the assumption that when
the server advertises multiple promisors, the client will pick only one
of them. And that made me wonder how the client knows which one to pick
in the first place.

But of course it's possible to just pick _all_ of them by combining the
filter.

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index f13ae5caeb..4a9c1991c1 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -230,6 +230,41 @@ static void filter_spec_append_urlencode(
>  		     filter->filter_spec.buf + orig_len);
>  }
>  
> +char *list_objects_filter_combine(const struct string_list *specs)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!specs->nr)
> +		return NULL;
> +
> +	if (specs->nr == 1)
> +		return xstrdup(specs->items[0].string);
> +
> +	strbuf_addstr(&buf, "combine:");
> +
> +	for (size_t i = 0; i < specs->nr; i++) {
> +		const char *spec = specs->items[i].string;
> +		if (i > 0)
> +			strbuf_addch(&buf, '+');
> +
> +		strbuf_addstr_urlencode(&buf, spec, allow_unencoded);

Shouldn't we use `filter_spec_append_urlencode()` to do this?

> +	}
> +
> +	return strbuf_detach(&buf, NULL);
> +}

I'm surprised we didn't have such a function yet.

> +void list_objects_filter_resolve_auto(struct list_objects_filter_options *filter_options,
> +	char *new_filter, struct strbuf *errbuf)
> +{
> +	if (filter_options->choice != LOFC_AUTO)
> +		return;

I wonder whether we should rather `BUG()` in case the filter is not an
"auto" filter. Otherwise it's easy to get the callsite wrong, as the
user may expect that the filter gets resolved tdo the new filter, but
it's actually not because the original filter wasn't an "auto" filter in
the first place.

> +	list_objects_filter_release(filter_options);
> +
> +	if (new_filter)
> +		gently_parse_list_objects_filter(filter_options, new_filter, errbuf);
> +}

So as menitoned in a preceding commit `list_objects_filter_release()`,
will retain the `allow_auto` option. But when resolving "auto" filters
I'd expect us to not accept "auto" in the resolved filter anymore.
Otherwise, if `new_filter` was "auto", we'd still end up with an auto
filter, wouldn't we? I'd rather expect us to abort in that case.

Patrick
