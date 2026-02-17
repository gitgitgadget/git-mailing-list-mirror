Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572A2C11E9
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313068; cv=none; b=JNIYeQx2FiWHDAkU0rM4P1A4IkTphJHkzzvKnvY0Q1Way77x21Kg5m8xdgyOO6zHKj/gq0s7P4iDdywreGaVruR9JFVPt9Rz0kuzJYv/bL3jPCLeMjLNrUNmGOkqdlDffZrK2TypaLq9Aug/wTywKSg/SUxfHwJpSV59JKOXl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313068; c=relaxed/simple;
	bh=ErpdmuYMpEE8kV6Uw3ZhEfGX9sYg5ZgqdK13m/WsqQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGjF01T/5o7VtYC2nQJwoGfLam3WRhAzAcRkNlylM3URfkJBh2hzeAmvEyTRH4x7XbQm5PF0+NGWMd+ttmiDBokgrq640qTNQxoczFUh+nt9b8Xg5V/bEJM6Tz9W4VWfDpiOqw1E37nxtlHlkMEcvHAHUGV1hojnTYnKhaPL/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L+ThB6D4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuWb4hXV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L+ThB6D4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuWb4hXV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B4081D00350;
	Tue, 17 Feb 2026 02:24:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 02:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771313066; x=1771399466; bh=vy0JdWAey1
	S9NmkGvvqXrM1ZjK42bfiwzgcuAdXIJBQ=; b=L+ThB6D4vLh1iiu3rLZCX0BnJF
	1wDdLMbf6yVJ9uzUx5Vv0VpWM5E6wDOQEtoeyB/3H9WPw2er1ci0E9NZ4GmBcVLA
	KeSK5EXOfFUBr81GzV0CDvtnfkUXcDtGjGF3KH0v5Gifp5WY5hI/m6cbzWBMkPx4
	3R0xqE2qZMucvGXHvPal35ZHf8sTpo8TbYW/IqxwBnpq/fKgW8LS3fv77VK4gxIT
	oF3j/d6VnTRRp3ZM15iKrl2QjxUws8XA4bIls8IUiXVEkkECWKqEjG9k7v4kq+X5
	jtHZl82U6ZhYM/0iM0Fa6mywz8DgYAv/ldT+pwEDmFA3lEuESj17LRjlFMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771313066; x=1771399466; bh=vy0JdWAey1S9NmkGvvqXrM1ZjK42bfiwzgc
	uAdXIJBQ=; b=KuWb4hXVHsCb3nwsYZHVYDQAnbob6+1xfzbB7eyjuNraX/FvRNa
	v6cdFoyrPwrI43fkS1qHtEaMFa3jPcUIYXdRlmKevPqLw3ToRU10IBli6d/DmmqK
	4+78SKuGZD3uVxFaeHdJ0JyyI4KXrbOcgpVkz7TWHaaJytaimEaZ1Yq903T0bFa+
	LHXXsJLZfLBty/Bl/XGHcQHgyEhI9ujX0ZGpyyULHNj5dEbX6Wubkzy1pTi1Jyjz
	uvtaiAhf3y/af72rNIYYjGAnagrVje4ufy6ms+XFUh550VJ5oicmDmbK5k9CqTiW
	dmlpk2mAn95jw9VMAJ72nB7VYKjy6Gm3fAA==
X-ME-Sender: <xms:qheUadoMkbUwRpGNa12xHwAAGzqIUB3zlH4XM8EDAIQY2VcURTGoFw>
    <xme:qheUaWoVdegnPhLZg-QIN2hoOMq0rmpXD6-NSX36aJHLEPKYybFavXfYgXHFbRTop
    EzSSVIN8znSSmNz3TYUO3nbqcUSj4_B9bH5tyb4XMVXhAG_8ts8ug>
X-ME-Received: <xmr:qheUafNnuUKU2hRIeBinWeaCee1mCkNstOVn50JHqv96yeNy1VXLEQnytPsEaCiyrmhgNePNHj_ZN3od4GjoBdE5Tbfmmk29xfWKnfswdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:qheUaXyieWMnPAwsH08MiAMcC9uGUJN1csegmRZA1NrwXgc6jgrAog>
    <xmx:qheUaYvMVqL0mn-ZNf-EuUkkiPMIqfByLfjjDNDCpODZIkkKmixUYA>
    <xmx:qheUaQ5HdINjE84keCCM35eEqW2JxHUx0KA5yDzKAH_LpYVhDczVVg>
    <xmx:qheUaXToK50mt2uAZzRHymZ3rl7e1wFSEmLuDAhCOpX4zFSq-HTyBQ>
    <xmx:qheUaQPevzapKnJC9Cnt7CV8ZomuVH5-eaqT_q08qDJ-kpkZD1SClcal>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:24:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 699e8985 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:24:24 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:24:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v6 4/6] refs: move out stub modification to generic layer
Message-ID: <aZQXpb7RMW83eGxe@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com>

On Sat, Feb 14, 2026 at 11:34:17PM +0100, Karthik Nayak wrote:
> When creating the reftable reference backend on disk, we create stubs to
> ensure that the directory can be recognized as a Git repository. This is
> done by calling `refs_create_refdir_stubs()`. Move this to the generic
> layer as this is needed for all backends excluding from the files
> backends. In an upcoming commit, we'll also need to extend this logic to
> create stubs when using alternate reference directories.
> 
> Similarly, move the logic for deletion of stubs to the generic layer.
> The files backend recursively calls the remove function of the
> 'packed-backend', here skip calling the generic function since that
> would try to delete stubs.

Tiniest nit: it might make sense to reorder patches a bit so that the
creation of `refs_create_refdir_stubs()` and this patch here sit next to
each other.

What's missing a bit in the commit message is the motivation. What does
this step enable us to do that we couldn't do before?

> diff --git a/refs.c b/refs.c
> index 11d028232b..a24602c9bf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2190,12 +2190,59 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>  /* backend functions */
>  int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
>  {
> -	return refs->be->create_on_disk(refs, flags, err);
> +	int ret = refs->be->create_on_disk(refs, flags, err);
> +
> +	if (!ret &&
> +	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
> +		struct strbuf msg = STRBUF_INIT;
> +
> +		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
> +		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> +		strbuf_release(&msg);
> +	}
> +
> +	return ret;
>  }

This makes me wonder: if we called `refs_create_refdir_stubs()` before
we call `->create_on_disk()`, could we even do it for the "files"
backend? Just a thought though.

>  int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
>  {
> -	return refs->be->remove_on_disk(refs, err);
> +	int ret = refs->be->remove_on_disk(refs, err);
> +
> +	if (!ret) {
> +		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		/* Backends apart from the files backend create stubs. */
> +		if (format == REF_STORAGE_FORMAT_FILES)
> +			return ret;

For symmetry it would be nice to not have an early return here, but also
format the condition for this block in the same way as we have it for
`ref_store_create_on_disk()`.

Patrick
