Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22F189B8A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533688; cv=none; b=Zzn4hUlMVP9orbMX3tx7TEuWDvFH4duKz/WYR+Q+5Vjipg8IHkgmR8nJJQ+p+uk+88NP7vsCyhXQHbpRjM9cKkaFMj+O+EPacs8b1dfAk5oBzWn5Uw9PTAwQP16ZHVfVE0ucwBdmmt22lYOZLPasgaDqQwK1iHad41nWqZHaSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533688; c=relaxed/simple;
	bh=GjUKfEfDuisWhY8eNDENfwJsRPCRU9g8QAGyzjv99Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ3eqaDNyhb/QHU7/e/xipsp2UFf/PR53mtG94ulAbVGo8xVcqqwuhU3otM2OjcwOwEnGTyleMyIAeuM3C34UTU2qBH88yi9lS/ef3C44c2lBS+K/QesKq9cw2KQXG9GOsWfV+0KfePWXoVvaaO2ahzYyQYKrN1CqigdceGAFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ikJfCipx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+L9+bfz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ikJfCipx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+L9+bfz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A4239138035A;
	Thu,  5 Sep 2024 06:54:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725533685; x=1725620085; bh=NXc7sLA3gH
	YWMu+dBE8AnnfFGTqSdCKzaFA0CmFnIo0=; b=ikJfCipxUIHDnEqhZ6sQ/GVimb
	SlNbnW8hUmD5pbQpjXY6W5WOX/6q766NQVU82XbVksvJpFznUWN/TAb+yCGyCKAZ
	SwDwiC3xpic3p/hnisSDBbLwujI+WdCvirCiAzIIVYuTc0B0vzWqAsY+NhwZHXpp
	Fzs4W0IRMXJ3IxTuwV5raBqa/57WelfJYLyXiwjegcDx4IEEOWO5U92mqxAO96ss
	f4NOvX1fKp0c4vVE5ia+JqH4jzrboK4VsrpWIj8Kougg5jOOe9afHdnZBl4kOOJW
	x51kK+LAgOuLgPhC5Q3hDPGtKBWSYq9bW11NW+yQqdat5cgkMfvl54PYO1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725533685; x=1725620085; bh=NXc7sLA3gHYWMu+dBE8AnnfFGTqS
	dCKzaFA0CmFnIo0=; b=N+L9+bfz3ryCp8YmUqYCJNUn/YfE3+LMimHJpcLVjY2T
	JGVwJQILzgUM3k2ov0LtbS7Jh2gTxAqjXx1DF/Xzjvz5pTUuxJZKy1HCG7ggFcJa
	f/Pwztm6j+pUp3q/B+JpcGiV/wlyAfJwACmnvOR4xhgejF7HyJVfHIaGZiYYMXxF
	Mo64I7kk26Lw9KmL2wU+M9+mA+aLsUEtvMa+R3YTDhi6qQE8H3a+Uchht5FrzrAU
	DsDanSDVHWyAR6g/ff7XNvDk6ksu+TPLXKfzS124KPuTBUgjV0rKlBGUT5cxLy8h
	Uql47xQC1JDNTk/o4vTiL5dbobiXSzGduXl9yg9puQ==
X-ME-Sender: <xms:9Y3ZZv6jvt-4nYMlLFrXiprF4-WapOEw-RxtljrQx_0rGifWCzJ30Q>
    <xme:9Y3ZZk4joEUUXkBNtsStNATIxtPLPHwZJZnfo55krjc4DY2rsQ56TeFGPoRFE_0xk
    3wf3_QE37oQp7NJcg>
X-ME-Received: <xmr:9Y3ZZmd0L6yKaeXBjsYmE8xedoN3nOXsPTx0k2Rbfo0eW-vJGJGt5pn7YMTao65mNxGihwewKxuh79Dm3Lp65ZTfOsyI4GasaKL5apBFHUL1f7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9Y3ZZgKGoNiDvpNVTmKGlnCg3MJJtBRlaZ3p5f1yVtzKdICNo6ylLg>
    <xmx:9Y3ZZjKf2vY5LfZAHFvxXrzYflavu1Jj4sK2wrTvcp0kymhP6Of2hw>
    <xmx:9Y3ZZpxQGyWhY2_UDbKSzpt1nc7-c5iQ4zd3apHKNmZGldriNP9Dxg>
    <xmx:9Y3ZZvILe2GtKOD2kfg9sHQzlhyhgCwKQWczb_G_gYDOzA2jSwyBZg>
    <xmx:9Y3ZZqWgE2jF5Xn1CafDTL33tzO5N5BRysevcsoxPm7dfIqb7B8Dg3Li>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:54:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be83b804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:54:32 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:54:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
Message-ID: <ZtmN6sZCvDy1BGfn@pks.im>
References: <20240905082749.GA88220@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905082749.GA88220@coredump.intra.peff.net>

On Thu, Sep 05, 2024 at 04:27:49AM -0400, Jeff King wrote:
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 2604ab04df..f1bd31b2f7 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -336,8 +335,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  	if (safe_create_leading_directories(sparse_filename))
>  		die(_("failed to create directory for sparse-checkout file"));
>  
> -	fd = hold_lock_file_for_update(&lk, sparse_filename,
> -				      LOCK_DIE_ON_ERROR);
> +	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
>  	free(sparse_filename);
>  
>  	result = update_working_directory(pl);

Okay, we die on an error so there is no need to check `fd`, either.
Makes sense.

> @@ -348,15 +346,17 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  		return result;
>  	}
>  
> -	fp = xfdopen(fd, "w");
> +	fp = fdopen_lock_file(&lk, "w");
> +	if (!fp)
> +		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
>  
>  	if (core_sparse_checkout_cone)
>  		write_cone_to_file(fp, pl);
>  	else
>  		write_patterns_to_file(fp, pl);
>  
> -	fflush(fp);
> -	commit_lock_file(&lk);
> +	if (commit_lock_file(&lk))
> +		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
>  
>  	clear_pattern_list(pl);

I think the error handling is broken. `commit_lock_file()` calls
`rename_tempfile()`, which deletes the temporary file even in the error
case. The consequence is that `lk->tempfile` will be set to the `NULL`
pointer. When we call `get_locked_file_path()` we then dereference it
unconditionally and would thus segfault.

Other than that this patch looks sensible. Also kind of curious that we
never checked that `commit_lock_file()` was successful, so we wouldn't
even notice when renaming the file into place failed.

Patrick
