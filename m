Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650225CC6C
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764934416; cv=none; b=aSmdqk+w2Vh3nTZ4d4hhFXBre7byT4RyOu0Ipto1HAwxgSWN9ZaEMbL1ceoH4Kt8VLXHyZxtbAvaxSOX9eTaB3orfWjDvjtyhRrB0gdGKRyJvCX5OBeiiGtWNiWLA6+vmWT9jqqr8ah5B43ubE2qg3iNKHOnegeYBMQJFVaz8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764934416; c=relaxed/simple;
	bh=VM9n3JB5rk4DkKlhbQFgsxvktDy6LxJQ7ajR8Ib8YEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaI5dCBY9hH9vwI4B/6g8DXYUEinvGRZLbmTZ1uFB2u+XPchzOEK2utMRez0X4gWjVzRyE9CJoIpuguAqRKiAJIyC/qqh6avuzF3a6Y5nAs/9XYDM16tJkd5HrYdn5xv8/nJwoF2HRc68dXQwCOHZLbd/BjSZCHGc+EVeSFtuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BE40qFyG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6VorX/4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BE40qFyG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6VorX/4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 627D21D00198;
	Fri,  5 Dec 2025 06:33:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 05 Dec 2025 06:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764934410; x=1765020810; bh=k1uwGonKhX
	EV9i+9UEp0pdCGeoK53qWWDfgp6gRz9fo=; b=BE40qFyGWdq6jaAkK58iSCc9Oq
	P/8s4J5YzX8bDQMUuSz0uJ0Pl9bVt6Cj++B1mREzmZLr1RrGouSzKuUINCa4C5Kd
	QdDJxFIpxomN9SzmrJxdSVCq353ZsjnCZGAt/9h798eCR3WKUgwszinKv490pCLh
	JLJ9GnzEjTauwx4AIovy8sqbi4JesFvdbdeYzRDMt72iwS2hekhX2T2P4Mvyfpu9
	hfCuXG8pkxLv7O53Ah+eqHFlwsxtZ8XVn6I5LltoK/iVCBBVA1MkZxOAiaFzOpYm
	AaeTX88OMoomzBceuzJBpvEfkq2QIxQkTyfFmn/MqmxJAb4iQID2i5/eDr9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764934410; x=1765020810; bh=k1uwGonKhXEV9i+9UEp0pdCGeoK53qWWDfg
	p6gRz9fo=; b=n6VorX/4TXiPJEZw5v5W4/12QxxMowq5u2/Zerbz7LsVn3sagwG
	nbYjfQx3237gk9yubN8sAdYNAb2ML8GETXQX20+t7goF5MoCYCMTpYFZMJArTl0r
	Jt2+MkOj0m2UmHYxzHixbOVzY5nKOZu8xXPIl7xHER91pOHq9kGWEhjn3WzevEsu
	G/O5jjGqK34yaqciP7Hy7HGsN6H0j4hQhyBE/aXNgEXavpywVt2AnqJte2FUEhSs
	mmFtu+n11hcGC1g+U/WvI6jdMjFf0tqY1TDlMhQXd+GAekMlvo1iA9qHKgid7g2i
	pSWc8BBHZ7tx4GGFkogLsph3DNEFU0JCFlQ==
X-ME-Sender: <xms:CcMyaXl0wnECAwCVyLbjsC1oH_ZuZcyyEZ-Iae8_lbSeqEOBA2BOEQ>
    <xme:CcMyad5OcaKAZOWZqv89oQm9BAgqBuQ1B-UH5jSP3eq3NkTJWVULG19zlWUINyrlZ
    UYin3gSenbNxN9Ujx0Tjbabkt8mgDIIPicI-o_mxoZQwsNz4ijH>
X-ME-Received: <xmr:CcMyaYTg34s29s68NkqTkHzjDHVB4ay6EVCxeLWWxah9v11ILoR1ITsEBufSUGsZeqP0KbgTEP8ljbel8RnYDf24XxOzla-mYys_mdlDrKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhh
    rghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CcMyabynu_wPfei6xW86LMmPPJtY7gLGYIiWQoDUEzIu4p65VB_tWg>
    <xmx:CcMyaQq8qXGhtnMhL6Os1YjYb4cwL5xEG__ovKw9_v0ybahTSNuqMw>
    <xmx:CcMyae0c4KsAxbq5XWHhKcDrk8tPXgzymXej_5HJKFPbwP1ilzjITw>
    <xmx:CcMyaQwBYEKU6j3qQe8If2qq7OWbcCLZctlPgiNA1tSg5p5oG1q58Q>
    <xmx:CsMyaSysWs92TS4F6ynIpVntd8BpJCRULIqR648AHjCbBzCqvZtnrBu_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 06:33:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e208408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 11:33:26 +0000 (UTC)
Date: Fri, 5 Dec 2025 12:33:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
	gitster@pobox.com, phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com,
	johannes.schindelin@gmx.de, toon@iotcl.com
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into
 shared function
Message-ID: <aTLDA11AKs0jlxFJ@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202201611.22137-2-siddharthasthana31@gmail.com>

On Wed, Dec 03, 2025 at 01:46:10AM +0530, Siddharth Asthana wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 5476d39ba9..9f621aef4b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
>  		if (opts->commit_use_reference) {
>  			strbuf_commented_addf(&ctx->message, comment_line_str,
>  				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> -			   /*
> -			    * We don't touch pre-existing repeated reverts, because
> -			    * theoretically these can be nested arbitrarily deeply,
> -			    * thus requiring excessive complexity to deal with.
> -			    */
> -			   !starts_with(orig_subject, "Revert \"")) {
> -			strbuf_addstr(&ctx->message, "Reapply \"");
> -			strbuf_addstr(&ctx->message, orig_subject);
> -			strbuf_addstr(&ctx->message, "\n");
> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>  		} else {
> -			strbuf_addstr(&ctx->message, "Revert \"");
> -			strbuf_addstr(&ctx->message, msg.subject);
> -			strbuf_addstr(&ctx->message, "\"\n");
> +			sequencer_format_revert_header(&ctx->message, msg.subject);
>  		}
> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>  		refer_to_commit(opts, &ctx->message, commit);
>  
>  		if (commit->parents && commit->parents->next) {

Is there any reason why we don't also handle `refer_to_commit()` in that
new function?

Patrick
