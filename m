Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342838B15A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644498; cv=none; b=G4azbqQaps2JhfAEmTzj4JvafZvQPOQL7wHfFIitntyE3cprYSDXKY9iGGc9TGV3bCX3sDUrltFEqD0wfmXNjrz1rUIKUEwavVXc7pHY6uvvYmWY+3JzQQuij/2JKUyiAWpJ6yU/XjtNxKP1MD9o5DKaovQJYAq5LIaNdr15F94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644498; c=relaxed/simple;
	bh=Ny9R5luC3NJfxgZVcIbIO2rLzE4yiBAdNKl1VBwWALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnsXMdlIIhrcZ9SA9k2mT++FYUxblTAlXlGRiN6BnOpiAuofpWzYpMCe9kXIUt6itBwWtQC4JSmDV1FhrTP1J/esV/FjXm4NMLdVIPbUXwU8zkjgIXxMfUGdunzgQphFCAEn8QXGQHyMHG9gttqfEpiwXn9XFQMf1lI8oRiloRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eDJjHfTX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MEivTClG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eDJjHfTX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEivTClG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E073EC040A;
	Wed,  8 Apr 2026 06:34:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 06:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775644494;
	 x=1775730894; bh=Zh0kNa3+FB7ypB/dRlcdTpZenc5NqT5Xoe9I5Fn+rC4=; b=
	eDJjHfTX7TB9o58+NFPqMYukjjAcPWovc2CZQEqC6jCvgQsTr19BwbrG1WtEqusF
	fNnA/ZoqKNIHyOafzBqy0S6HEnQA349xfNF04BsiEuWYZ/0khqnkR9pTuVmpXuz2
	1+QcS/XFxp5tvF0sRTuTjKBNROpFQuyI3VBxhBaZMvkdAZFXbhEy00dLaYxEYNsm
	km/3K5GxsK6Iv+Y03SHupR8hv2tgRrryHrrtyMKZonmfpvHpUP6GJhSN6m6PMt7q
	Laz4RQx17R0dJP0A+SjDn7gCJLh0Hfcbpt+WNP497pa1sAGn5sxxN7/tXbJ0X33l
	Oi2uWN9duDWBRE0yj8Hpqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775644494; x=
	1775730894; bh=Zh0kNa3+FB7ypB/dRlcdTpZenc5NqT5Xoe9I5Fn+rC4=; b=M
	EivTClGOA1VYnl8HIJd11Pr+Nm1b7yxfM4Zo7utYfqrXjI+jCKjsKjZTzqRYyFAb
	1y5i+YJTzaF+mSXJS4TkM8EIUtegjdhuXfFgACblHTTeERA15e+8uaMtLnvd+R/O
	0ClBSUz2t0Fsc+jjjGICgh6dHlTO31KqlD0tGD6v98VwglHPP0mFwBxGPwr+FVwo
	CQCjxFJaUG5/syw9+/MerHhFyWRdhCC+5sDvr7ycNwh3tEfm7s+6CUwhyO8/orAa
	iju7oPBsN8ZjHa7eZOgiVUEE1UDs1Jn+yMYGGytc1p4zdu6XzDYhDGWtVl3H4PXX
	kQim8VTNxzqqg7FIXzA1g==
X-ME-Sender: <xms:Ti_Waatrrko_2htHm3m9FU_idCTNsJ1Cu3ae5-TRDhxzDx5eI4PkiQ>
    <xme:Ti_WaW5xdb4fb8D6U383MFIWfI6ycYg2vmbIwncAphjw8Vv5q3su78Te8wKPOmEy_
    3yontiCc4f0WsR2QAnL0YfBO6EprSRaeIeaJCG_V_-rRoC6mXlXrg>
X-ME-Received: <xmr:Ti_WaTIo0MWKnI1BZX2q9cmrfd1twlsMXQX31pHG8eu1Wgvhni_4bAoq6xOTapuZAbhk-sbpioHtZwxsNME4w22sjhz6xyHb2SmHqJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhovghrghesthhhrghlhhgvihhmrdhi
    oh
X-ME-Proxy: <xmx:Ti_Wae6MoJAqDs9qAVhloy-DAxTjnLwPVYxn5VcUueR74HEZ8U02pg>
    <xmx:Ti_WaexQw4xNs27b3uuFofzhRsVdx0U9GS734rxcWvh-R8jPDDfE3g>
    <xmx:Ti_Waab9_rWFdUOv0R-W1UxJvkmlphlsAlxxVbV9m5DMi7sZjeyVkw>
    <xmx:Ti_WaYQtUMyv9tKjCUtGbU4k53u5dr11TUNjKXPI6OWz48Ip3_Df5w>
    <xmx:Ti_Wabk8Nc0kDj4gZhwF0kfrdk49_BHbOvDt03eBMxhhEMdXetqcTzgJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:34:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4093efc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:34:52 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:34:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
Message-ID: <adYvSZeN0ZVqwRhi@pks.im>
References: <20260403100135.3901610-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403100135.3901610-1-joerg@thalheim.io>

On Fri, Apr 03, 2026 at 12:01:35PM +0200, Joerg Thalheim wrote:
> From: Jörg Thalheim <joerg@thalheim.io>
> 
> When multiple processes write to a config file concurrently, they
> contend on its ".lock" file, which is acquired via open(O_EXCL) with
> no retry. The losers fail immediately with "could not lock config
> file". Two processes writing unrelated keys (say, "branch.a.remote"
> and "branch.b.remote") have no semantic conflict, yet one of them
> fails for a purely mechanical reason.
> 
> This bites in practice when running `git worktree add -b` concurrently
> against the same repository. Each invocation makes several writes to
> ".git/config" to set up branch tracking, and tooling that creates
> worktrees in parallel sees intermittent failures. Worse, `git worktree
> add` does not propagate the failed config write to its exit code: the
> worktree is created and the command exits 0, but tracking
> configuration is silently dropped.

This very much sounds like a bug that is worth fixing independently.

> The lock is held only for the duration of rewriting a small file, so
> retrying for 100 ms papers over any realistic contention while still
> failing fast if a stale lock has been left behind by a crashed
> process. This mirrors what we already do for individual reference
> locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
> 2017-08-21)).

Famous last words :) Experience tells me that any timeout value that
isn't excessive will eventually be hit in some production system. Which
raises the question whether we want to make the timeout configurable,
similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout".

> diff --git a/config.c b/config.c
> index 156f2a24fa..f7aff8725d 100644
> --- a/config.c
> +++ b/config.c
> @@ -2903,6 +2903,14 @@ char *git_config_prepare_comment_string(const char *comment)
>  	return prepared;
>  }
>  
> +/*
> + * How long to retry acquiring config.lock when another process holds it.
> + * The lock is held only for the duration of rewriting a small file, so
> + * 100 ms covers any realistic contention while still failing fast if
> + * a stale lock has been left behind by a crashed process.
> + */
> +#define CONFIG_LOCK_TIMEOUT_MS 100
> +
>  static void validate_comment_string(const char *comment)
>  {
>  	size_t leading_blanks;
> @@ -2986,7 +2994,8 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
>  	 * The lock serves a purpose in addition to locking: the new
>  	 * contents of .git/config will be written into it.
>  	 */
> -	fd = hold_lock_file_for_update(&lock, config_filename, 0);
> +	fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
> +					       CONFIG_LOCK_TIMEOUT_MS);
>  	if (fd < 0) {
>  		error_errno(_("could not lock config file %s"), config_filename);
>  		ret = CONFIG_NO_LOCK;
> @@ -3331,7 +3340,8 @@ static int repo_config_copy_or_rename_section_in_file(
>  	if (!config_filename)
>  		config_filename = filename_buf = repo_git_path(r, "config");
>  
> -	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
> +	out_fd = hold_lock_file_for_update_timeout(&lock, config_filename, 0,
> +						   CONFIG_LOCK_TIMEOUT_MS);
>  	if (out_fd < 0) {
>  		ret = error(_("could not lock config file %s"), config_filename);
>  		goto out;

Okay, so we now handle this more gracefully with concurrent writers. But
even if we handle that more gracefully, we still don't really have any
guarantee that the outcome will be reasonable, or even close.

The main difference to the locking timeouts we have for refs is that we
have an easy way to check for conflicts there: we simpliy verify that
the refs we want to update haven't moved from their expected value. We
have no such thing for our configuration though, so two processes that
race with one another will happily overwrite each other's changes.

Honestly though, I'm not really sure what to make with this. We could
of course also add some validation that the configuration we want to set
hasn't been modified meanwhile. But that would now lead to a situation
where we have to update every single caller in our tree to make use of
the new mechanism, which would be a bunch of work.

And adding the timeout doesn't really change the status quo, either. We
already have the case that we'll happily overwrite changes made by
concurrent processes. The only thing that changes is that we make it
more likely for concurrent changes to succeed.

So I'm a bit cautious, but I think overall I'm fine with this?

Thanks!

Patrick
