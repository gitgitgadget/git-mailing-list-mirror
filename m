Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3693F4DF3
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563739; cv=none; b=fQ0hRlx7F2g9AusIVWoC6UCro0uwnI9aEoYeq1+RaXw69lhrkoDu8CVxsc6axPDCEHzjOBPwg/qix2x7u3gjtTFFIACR1PO1l2rSutPSJFmo2/OAsAgN6PI0elv3B/aIDK11YnM0R9anjyBo+qa2aa0aID6vrqTtAIdyskDEuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563739; c=relaxed/simple;
	bh=JzlL4m66U76h/1DSwBAJqa9NTIRGYJwxjwsKiX+049c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onoj6tpR4pZI6POkkqR4CZwhpJUFlsiPzbJ+YOY06seHcWVmWNus9Tv9h1YVmivhXx7bRs3oZczN9M0Sm1P3vLv1A6wKP4xy+U7zqiz0cMEuDUdsWVa/WfYDzD+Vxx9LdPrhVkGUoTIpdtgOuP/zUYoIwe5AwXJQzI778KnnSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bc0Q3Qgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbsA2sW/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bc0Q3Qgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbsA2sW/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 97B95EC01A9;
	Thu,  4 Jun 2026 05:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 05:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780563737; x=1780650137; bh=f+ycuDKvb3
	1CyOZgm2ft16CI3KjhtJZEtKbGqCU+0jg=; b=bc0Q3QgqalCEaASkVztIjzdDQu
	+yvAd9rs/v9HO21Ug10RfVUe2+/EsNkPvaUPHGKUSxgqVnJ1XS/45UeB8Yr9wnCZ
	MslTGF0Zt237Sm+xfAmxhEPLW+EcfAQrFB8AGa6zKM7kAMXTAT7ZVsFffYwT1MwB
	o0Ya/jnW0R5+lkrUQCMCf3pq9/xb0B3XaEotGp4Dw+Q5BWgezPyE/cLXnhKw++EK
	jPBrwQTS0yh1DNfcAawcl9vWJH3Bts3ENRgwAjsh2CbEvmGaBos+S+I1jDO3NP13
	kEFM2j5PGZKevZgSkR+SYW/f1fy9WM0VnyknrM0r6d4Yh+Hxqk/LX1+fePBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780563737; x=1780650137; bh=f+ycuDKvb31CyOZgm2ft16CI3KjhtJZEtKb
	GqCU+0jg=; b=TbsA2sW/XxEPaWGrjpW1FULDcEQGaOTgKsFO6Z6WwX4Z8H2UacS
	JYthLkIzyjGn2iNO1c66q8lOw10lM4ey9EMGErxr6O1iHoZtIYdvdyHuCmbvjULH
	/cwrRgFtcNWpFGIVDHPwYLVFMziangPnULsIbt+plEZs5AkXGNEPtaV4n3LG9Yu+
	iCyQ4LvkTNNzZnu+duycHLKKw71ymPg+nEIKZSgs4+G2eXZhHGsNSmimZ78BWWVB
	NhthZjlkxjDaDTdT/0wQ3GnumsfyBQQM/nH8hc7P74a8SEcnnCF8ApLmtZ++yEF9
	RMmZzxii+6Y1EB7rLgfEBOIIcVQTOmtVnWg==
X-ME-Sender: <xms:GT8hatKDxXXZvRthjH0JZyHdsnTeQ3B40xIwkrpLFOilWiPYCsO7KQ>
    <xme:GT8hagnE8exRzsVHUIJ-1XD-LvEBy8LYdtPC-h6VH5M60lonmXfv1ugES9XpqWl_M
    FltsZdQqp4anifzOCUwz8TV0tT1MvTE-SbuV60TfbX1kBEErhWhGQ>
X-ME-Received: <xmr:GT8hajGW2tN3ppHkDDanFtMF9Wbf-8BKjrs9hI9Y7qF9aW3TgCaUcU5QaG4JsIKbhNSQ5IB04OZ9Fa2RjOJlSWnb-VSnKvnUdejpIuhnbjs>
X-ME-Proxy-Cause: dmFkZTGFLCKX/vggYM5jwwyMt8rt+EypqxrXadveFJWkzsKpDa8asC0zOR5+W2LIpwzuJl
    72XDLeBCaVV9maRLOWkDKQW3QdgJowIlVHQ9mpvFMc8hryZYsx9kBUqOl29D59daArvypx
    F7gLSH3A3Vuw9NoAruQjW72IDZAQKJllvycfambcNbPQevxREaJI2vkYBrf6PmflEfXRx/
    LF+Cv3A+bMmu4nDsa0fbKATZHXNlBt/OlNAVCwbvhVwjU5g5yAWC3X+9R4wngkzdzcIGSc
    swrDKmHcbZcNjt83IdcBtlQl4ZUuMa0xcSF10ZDF5kQCU0KOhgzn4Orn0FX4SR8cw4XoPl
    dzGd5tB8+Prp+Z5v9yVJ88KK3eMFKlKymtObu1SvMJqHD2BbwHNVSBiBvV7Vv+y2QaRFBd
    jLt6bYXm0OV4C0nKOFiY9RhiJjSoQEanFr03g8qApskTlBiJVM941ELWIDdb8J+Q6+ftwR
    lP50WoR1s8fB/1Rglj0nbdXd5HmKE5tWE8Xo/yG649Vsh4i6JCbp5jIq8S7IxCYHI2OFwe
    fw6zQD67lXF1Uwg35INoCfYlP48OZjG4mmCrhRZuQQ8tNENrR3lqo7p0CkObRhPSf1cbBL
    h6MqTo1ngSYmoY94Qxb23eSjMM3Yws9kFGzQpXCpZ5HKVWpStY/J9IHiQM/Q
X-ME-Proxy: <xmx:GT8haoF8-HJ2tEoyStNlyLeEFURNdKbMnXYC21jmJUuRjjuVlfiW-w>
    <xmx:GT8haoNk9kKN5zB4IAnIZsqAEEXhbwD6OVodIzaEoik1DPbOJDJwIQ>
    <xmx:GT8havH-iy7eolg92gr1eMAjYP28GuSHtSDGHudhbffzN-DfCw-4UQ>
    <xmx:GT8hanMcpwoiJFMadsXF8siTSHshmQ1nML0Ays48Hq0-bPM9TlWvaQ>
    <xmx:GT8haolz0PnZHAqTEOF7ZSeyVT75bue-ukVAoEqj4fDStisxThzcJwA8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 05:02:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2acbda8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 09:02:16 +0000 (UTC)
Date: Thu, 4 Jun 2026 11:02:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2 9/9] builtin/history: implement "drop" subcommand
Message-ID: <aiE_FtbkLVjXdSVX@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im>
 <xmqqmrxbqir4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrxbqir4.fsf@gitster.g>

On Thu, Jun 04, 2026 at 08:58:07AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +static int update_worktree(struct repository *repo,
> > +			   const struct commit *old_head,
> > +			   const struct commit *new_head,
> > +			   bool dry_run)
> > +{
> > +	struct reset_head_opts opts = {
> > +		.oid_from = &old_head->object.oid,
> > +		.oid = &new_head->object.oid,
> > +		.flags = RESET_HEAD_SKIP_REF_UPDATES,
> > +	};
> > +	if (dry_run)
> > +		opts.flags |= RESET_HEAD_DRY_RUN;
> > +	return reset_head(repo, &opts);
> > +}
> > + ...
> > +	/*
> > +	 * If HEAD will move as a result of the rewrite then we'll have to
> > +	 * merge in the changes into the worktree and index. This merge can of
> > +	 * course conflict, which will cause the whole operation to abort.
> > +	 *
> > +	 * If we had already updated the refs at that point then we'd have an
> > +	 * inconsistent repository state. So we first perform a dry-run merge
> > +	 * here before updating refs.
> > +	 */
> > +	if (!dry_run && !is_bare_repository()) {
> > +		ret = find_head_tree_change(repo, &result, &old_head,
> > +					    &new_head, &head_moves);
> > +		if (ret < 0)
> > +			goto out;
> > +
> > +		if (head_moves && update_worktree(repo, old_head, new_head, true) < 0) {
> > +			ret = error(_("dropping this commit would "
> > +				      "overwrite local changes; aborting"));
> > +			goto out;
> > +		}
> > +	}
> 
> This block is skipped under --dry-run, but update_worktree is
> equipped to (and indeed run unconditionally here) run in the dry-run
> mode.  Does it mean that "git history drop --dry-run" that user runs
> to see which refs may be updated will not get warned about possible
> worktree conflicts that would prevent the real run from happening?
> Unless there is a compelling reason not to, I think --dry-run should
> be a close simulation of what would happen without it.

That's an oversight on my part indeed. We _should_ run this block with
dry-run, and it shows that we're definitely lacking test coverage here.
Will fix, thanks!

Patrick
