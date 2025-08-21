Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC0286410
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771705; cv=none; b=WxhOCKjAyUm1NfM3djfitl/ck8ISuI6MwcKo0QZB2QCAFlKylesyPoOKM5qkp+9fnumzUZZdc8aiCN07PC7PmvlOYs0xqN+DnIv9WEUlcv4pdnAeHPvEEoGqLAwClOihpV0ryp4u3JFgwLaxdKc32je8odS4TONSGiKCrO4X8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771705; c=relaxed/simple;
	bh=EuTn6J+2A5ouTu2XYUEvk4q7aRC6bKw3B9+MCXCGVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXg5wn7ZMHFDjG0S7jWWc+I6eGJkDqBwNp8O8/DlSIUMerEzDanx3KuLtt7zjLEO5D2rAr96Mn+d8iJ0411YqtJ14/v4Ay0sR8zRc1UnEnUlO6PTYKjNHGltnOD883025cNUWNGvT3Hl3tOiR9L0Wt4J70IXki74hgT8sg/ykdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S7eCgnHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aGDb8qUG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S7eCgnHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aGDb8qUG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AB971EC0089;
	Thu, 21 Aug 2025 06:21:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 21 Aug 2025 06:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755771700; x=1755858100; bh=JY5VTwPOLL
	lui4quusb0MdPJxAtInjZjGMxpnQ5k+zU=; b=S7eCgnHTUr/DttSFIItNA0n5BM
	iZB4wZeccjlM+cYQSLboQBTmGBXwk1JMFJB+Lgn8STh73mebQpWTfY6y/E+DEpo7
	KU4E1qLb5T5OwJBb/VUCOhKNrlOUyTLyUewqKK6mvTarwHxJVbdt/TaZr37J/O3e
	vMxMPHpuQFRRUlwwIAR8NMorDvso1eNDbK4Byesh65yDLWxAXN/lZzVO3m08cXdq
	yuKL/Sn+S1MG0DkO6s4C+FZcv61LLwmpCe/4jTN/5A9M8R5Hcs4fkNes9TNyNUD4
	kgcNb5tAF30Vpub/HIx8q3KUuwLwuJbcnulCJOcCsokYrdmhU6OSF/4jHHXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755771700; x=1755858100; bh=JY5VTwPOLLlui4quusb0MdPJxAtInjZjGMx
	pnQ5k+zU=; b=aGDb8qUG06WzkTauMR/0p6uaX/ph257TmyQJEB7Qx5lXQeVdule
	EjP//46tz/57Tc3eG63KhJgmhWaxGWrmCY+f9nOLh0N6x32DcsY3ogpybhyfYmBz
	fUGD3ndGE1mBMMJFCYiZQlAxEsNZ2lYkd8awpWT7TaunMooQN9YjRVc9SP716tsk
	cm9qBuXnV1BHg6vnNlDw6bNd3HoAUlUxk3xpatAhoWEsdj4/Mhg3jZ4Ps45h9VHV
	HspegzD/0QLCAF2fhTnXsaNjs1JJhYifc0xbyz6plHpLop6NGH/MdUviJom1IoyN
	BGWyDb/CME+LrBVY4NSA07ArYEKu2aFF13w==
X-ME-Sender: <xms:NPOmaKOrFUmwgYhhfD62ck3M3i2iGcmxejF-ljN3NYJP2LFvXasZ5A>
    <xme:NPOmaMOOMF_dUuGN2wJM7X5ZQfJ1iZXh5Ok2YIVPUCn2wyaJ9QC04l1Qj5_L1jmB3
    LAlu8WTaRDZPOfcMg>
X-ME-Received: <xmr:NPOmaKt-fsbLt6qpd6aCHpAQR0qIZcmqnHPDUEl63oGeGvQK4IBmTo9UAAIgMeDBcFqEDTuHdOfAFIlWrCYAkBBxaQFdHtc7T71SWuFq5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NPOmaGUMr6OIbhN-9F7_pJxmfTkGXGbr9UKUcY_IdtqT_0SR5rLecQ>
    <xmx:NPOmaCuGWASTjjBA9HtUFGmC-enEqDI2o4Rhuxi_BG00Hac_oCI0iw>
    <xmx:NPOmaCXMssmeSCwMq2sLuomGuDLtG4EWXHjU7aXmka_WWzfsJSdRZg>
    <xmx:NPOmaFnq1C8p_rfXUTfzWtLR2SlZzsCuhOQXSMrPQZ5hQMpZEkujBg>
    <xmx:NPOmaCK9swvfgxhPaAx3ONL09VCzoI4nPPPpV49xg3GgTl9WOV6RpLYF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:21:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dee381fb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:21:38 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/2] builtin/refs: add 'exists' subcommand
Message-ID: <aKbzLhqryk5d-zgh@pks.im>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250821085246.929307-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821085246.929307-2-meetsoni3017@gmail.com>

On Thu, Aug 21, 2025 at 02:22:45PM +0530, Meet Soni wrote:
> As part of the ongoing effort to consolidate reference handling,
> introduce a new `exists` subcommand. This command provides the same
> functionality and exit-code behavior as `git show-ref --exists`, serving
> as its modern replacement.
> 
> The logic for `show-ref --exists` is minimal. Rather than creating a
> shared helper function which would be overkill for ~20 lines of code,
> its implementation is intentionally duplicated here. This contrasts with
> `git refs list`, where sharing the larger implementation of
> `for-each-ref` was necessary.

I agree with this decision. It doesn't really feel worth it to share
code for such trivial functionality.

> diff --git a/builtin/refs.c b/builtin/refs.c
> index 76224feba4..617d8ab138 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -113,6 +117,48 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
>  	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
>  }
>  
> +static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo UNUSED)
> +{
> +	struct strbuf unused_referent = STRBUF_INIT;
> +	struct object_id unused_oid;
> +	unsigned int unused_type;
> +	int failure_errno = 0;
> +	const char *ref;
> +

Let's drop this empty newline.

> +	const char * const exists_usage[] = {
> +		REFS_EXISTS_USAGE,
> +		NULL,
> +	};
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
> +	if (!argc)
> +		die("'git refs exists' requires a reference");
> +
> +	ref = *argv++;
> +	if (*argv)
> +		die("'git refs exists' requires exactly one reference");

We can combine these two error messages to just say `if (argc != 1)`.
Also, the strings should be marked for translation.

> +	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
> +			      &unused_oid, &unused_referent, &unused_type,
> +			      &failure_errno)) {
> +		if (failure_errno == ENOENT || failure_errno == EISDIR) {
> +			error(_("reference does not exist"));
> +			return 2;
> +		} else {
> +			errno = failure_errno;
> +			error_errno(_("failed to look up reference"));
> +			return 1;

I'd personally prefer to se a common exit path and use `goto` so that
one doesn't have to worry about whether or not the `struct strbuf` needs
to be free'd in error cases. But I'll leave it up to you to decide
whether you want to do this change.

Patrick
