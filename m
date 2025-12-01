Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E430DED1
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593906; cv=none; b=sI3mwm/xzESQLdWQRw3Tv47708HX4x3HVfbPb61lNgsSpTVsrxDzsjVXIjiOd4rrRTnHO46w6GEQ+92y5mMtEyfc7Xtl3sRHGoBD4Lry3TB75GlzAHPXyV6jc8JbJhSSHV3iHIi4Dpx5k3NDpeSyw5rAaHQba7rl41HAg7ikLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593906; c=relaxed/simple;
	bh=PNhX4tRKTZK9jyOaMPwbnxiP3J6y7mQtDc+ECSk+7pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtVlIsdZ5AvnKd7WqAdCI9yjt9fBgtKy1HcLh8R1tVVthWIWX+897LbFRLp2OrP4HRh10DH5XPLN5h5C6A88UYTYnTLvRpwtNxEXuVU7OURf+H2YYpBFMdok18tgktH/YXm7dRzHcdXd7BtdxML0f8hFF54lM9ws3sTBz0ABK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kvdmoCfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IiVG5Qq+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kvdmoCfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IiVG5Qq+"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D1FEAEC03F8;
	Mon,  1 Dec 2025 07:58:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 01 Dec 2025 07:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764593903; x=1764680303; bh=0Jor9rym7f
	eDxI46Sgm2UDNvBZoTCKwm08waeDMFGuM=; b=kvdmoCfjvTvkojlLSqqAwu/irk
	qvHzzpywrGkSP1P5IrsmjZm+6072bGYz3zhOARi1eayuU3JfH+wH8gDMfG8aMpP/
	odsqNv6iKKV36aOb4xW/Nj2JxI37RDUat90nMsJv0A52zbAaBEkPPKRvXAclJ7so
	9mIcDdWKgIBwRhGtpRoHq4x3Z0DEitTy6iQ84Zs5ve32AvIJtCXJVCTUaDr++kgy
	XqEVKzgtu64BdUn3+vmpqSa2sR28dRvstnLULstZwbQ1cjiDHmE5gTO07rapirBk
	QLEbTDay/KbVZjs1yUR3PWQtyMf4fnZ8QMo6UrVtQCvwCQ/v5jw5DI4weLmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764593903; x=1764680303; bh=0Jor9rym7feDxI46Sgm2UDNvBZoTCKwm08w
	aeDMFGuM=; b=IiVG5Qq+mup/fR4theNCbvxR32jiFwoUTZPYxh3GeYgv99nnqmv
	Tl1lsazkjSufMXsogn0e50gIXk3DDjDcBsaZos89QMyrq6KpDyS9jCfS6VXb/kzB
	YyY6/CNNzAIsmywPMXcKcMu2LCBBwHW2lZl2rPXC0gjG/189kaiDLEBv3z2VZJT6
	Zj1jT4olSBu0w9HJDw+QALQq11pRKiTWtSee7ZA6LYIq6uhyN5Gg1qw0/52Qzl0X
	2mzpUcRjOehGBrWBxd8PsjsX7UK8ZqAXMZV1Ec0rSuqRJvBRfJBSKrVBLIwnK2Rf
	lhTXCdY/AilnY1qaAcTHUb6qrGcQVF3vHqg==
X-ME-Sender: <xms:75Ataai3jQFt4tSRcJ1NOnPAM6WoSMfDtsQt3EmBoTKaEkC01I1GPg>
    <xme:75AtaR4JZRYHDLpN5bxjdYg9-OsO6ZHJwspnp8Imz-mfyFYWCS9DPy9SN6tzBhSCY
    37esWcAvWiUJBk_w8RYf6c0JH_8N9p9015-y50ty-U1pAFkSKD93ew>
X-ME-Received: <xmr:75AtaaZo8F2to42F5EVdQVfYyZv1i3VDl2R_a16_gq6ncMYM2gC17Z4kQRixsen8ZPQlxxkpUA2kwN97DzihDysBpcvfYKCLeak0ZYPK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:75Atae7cCvBcZAmAWj1Q1R0SYJ44BaIxZsMQOLNop2t8Bw75TwIdeQ>
    <xmx:75AtaVCimzs4CSRqVhQBmMXjMChjuBCZpzplr-OV64ObSIzTa7WkgQ>
    <xmx:75AtacdV1DrI0ETlDDpwNOdGDeq7GfG_M47Bd5H7O3GczQ_Eo7CCRA>
    <xmx:75AtacKXJs2hfQdZyGe6ufqYTbeG6Ru1BA-p0ndAmgL2HJGkt91HSQ>
    <xmx:75AtaQXDmeF6seYSLoc3OuJTBbv8Eo2CjZMcE1cu9om-sDoNHC_SfLIf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 07:58:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6dc89f60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 12:58:22 +0000 (UTC)
Date: Mon, 1 Dec 2025 13:58:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com,
	sunshine@sunshineco.com
Subject: Re: [PATCH v8 3/3] fetch: fix failed batched updates skipping
 operations
Message-ID: <aS2Q6y_hnwBxycGk@pks.im>
References: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
 <20251121-fix-tags-not-fetching-v8-3-23b53a8a8334@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-fix-tags-not-fetching-v8-3-23b53a8a8334@gmail.com>

On Fri, Nov 21, 2025 at 12:13:47PM +0100, Karthik Nayak wrote:
> Fix a regression introduced with batched updates in 0e358de64a (fetch:
> use batched reference updates, 2025-05-19) when fetching references. In
> the `do_fetch()` function, we jump to cleanup if committing the
> transaction fails, regardless of whether using batched or atomic
> updates. This skips three subsequent operations:
> 
>   - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.
> 
>   - Add upstream tracking information via `set_upstream()`.
> 
>   - Setting remote 'HEAD' values when `do_set_head` is true.
> 
> For atomic updates, this is expected behavior. For batched updates,
> we want to continue with these operations even if some refs fail to
> update.
> 
> Skipping `commit_fetch_head()` isn't actually a regression because
> 'FETCH_HEAD' is already updated via `append_fetch_head()` when not
> using '--atomic'. However, we add a test to validate this behavior.

This raises the question what happens when this function _does_ get
executed again. But we're guarding us:

    static void commit_fetch_head(struct fetch_head *fetch_head)
    {
        if (!fetch_head->fp || !atomic_fetch)
            return;
        strbuf_write(&fetch_head->buf, fetch_head->fp);
    }

And as we only `goto cleanup` in case `retcode && atomic_fetch` we know
that the above function will exit early. So this is a no-op change
indeed.

> Skipping the other two operations (upstream tracking and remote HEAD)
> is a regression. Fix this by only jumping to cleanup when using
> '--atomic', allowing batched updates to continue with post-fetch
> operations. Add tests to prevent future regressions.

Makes sense.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4b113d7c27..a1ca4e1ac7 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1639,6 +1639,94 @@ test_expect_success "backfill tags when providing a refspec" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
> +	test_when_finished rm -rf base repo &&
> +
> +	git init base &&
> +	(
> +		cd base &&
> +		test_commit "updated" &&
> +
> +		git update-ref refs/heads/foo @ &&
> +		git update-ref refs/heads/branch @
> +	) &&
> +
> +	git init --bare repo &&
> +	(
> +		cd repo &&
> +		rm -f FETCH_HEAD &&
> +		git remote add origin ../base &&
> +		>refs/heads/foo.lock &&

Hm. Is this compatible with all supported systems? We typically write
this as:

    : >refs/heads/foo.lock

But I have to acknowledge that I only do this because some people that
are more knowledgeable than I am know that we need this.

Other than that I'm happy with the current state of this patch series.
If the above turns out to be a non-issue I think it should be ready for
'next'.

Thanks!

Patrick
