Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2B34C130
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393330; cv=none; b=Jv9xNa9mbwLveHxDeKSQOuj/hZfb1vC2IOuJB9bU08OMYX4fu3/7gLP0nr9DUBabAEx32KCHaYaPvAjc756ucIjQfZUrlLVRjF6cU8fIN1NlMmxiwI5maX8hioC+UpHhG8CFF4/H2yd3IDHNuf1g1BcYE41rRmv+5cpM9V8gews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393330; c=relaxed/simple;
	bh=9QjHUqNRkJD4NIljA7qZVYQ358OswRVIvDN0hOnMoJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQFXA5DvX37hdjf72Zt1NjRaEfFhpt10V6RP6iP6mmxqoc7Ad8lw9YGVi+tdLGGumc3D/dLmJsdhh3wlwUZSKEIQoB2KFsZeKfZDUkgyxds0UAbCX9eEIgrPQXtkG/BcNdoJhWHogZjfw273dM+1xAFr2pzQciOu/ltPAfKAJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nExfauVp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkmxZs5o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nExfauVp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkmxZs5o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 43BACEC0479
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:15:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 13:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791393328; x=1791479728; bh=x7joEPmNS8
	IGzCmEms5DFc9Wxt53CcmYFW8LuOYBhEs=; b=nExfauVpREbpNGr2ySgH3HUVmS
	rCIU7WVE5iQzV1ubqGoeRaPgQL42iLxWNFnp6hVcJSzI4pCdcrsxnMIjYTvv0hOj
	TCTOO8xW8HMIsjYJ97ueqLFsWy/roSepcerbRsQ7Ml67FE0VfV4pswHU2YkYmBxL
	Ter8ZMETJW0j9Qw+D+n8tadae9lW8VkoAbkHH5yis/tADFHMOdIGjO/QEkg3S3dN
	Wqqy8EbV7bLpyPCcZoXCfBgoTdd7WrItI+5i+08xWeiEDAK4Jfg9hLATG2L+mmLF
	wexB7GnvLtIxGL+t9KjhXYDNzCMPPIIVhUiPHE6W4JlXmuZPOQ2wyR8GZX8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791393328; x=1791479728; bh=x7joEPmNS8IGzCmEms5DFc9Wxt53CcmYFW8
	LuOYBhEs=; b=QkmxZs5obqExhUF+8D4UBE9WHTop3WE1L5JlOiTKc2WgGlH2zmb
	KkwCg2P8Q6CTyjLR+tmO3b52sxcJ7qBmkfAmrPo683XSkKVp+zUX+l8cmkwXebNT
	VudaZPs3QC2lRG/hw8g625az3UMe0ToFAapLcfxtvqGGJqrAWlLSBYlk1U1KANZY
	OatiU8XgxTNbKQC5hSzKiaHwzrPn9D7gyzGjTGTm9nmh8/7ZnIesiWaF8hF3NPUn
	4StWP8RARR4iIR7Okl9lm8p0Bkavsh5rQF0w+wAXxNSxxUBSbqEt4fq4QWBFKnvo
	7biwt27XCwD+B7OxYuCDripbfejiCKsAwpQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791393328; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Wqrfm0sblEBj3d86NEDPDNPwU+1y06YCCMIun98QAC0VvZ/
	wnyU10H32lzQwICEvGcgBodQ6Ub2B6RS+ZI/PmvEilebJgaoxvO2EjGhN6DQ+4XR
	Ritfj1s4yR997hsdtgQHWXG57ctTqjjp13cKed+Q0xsRE0b95khfgKFTOV8TQ+bj
	Yb5CGzJ7v/+j1E2CuhHQMvs6uyC03XPLA3dOAZ7BZr2WYZZNPm1VSAuZguRIrP/G
	ErTSr5nS0o4MmQ7hE4cTpHXQDpSW1o9GpJy1WPfZZDmrlaGk/s0du18kymegNi17
	/G0q5HQgnlUVtXprjq2Cro3d0QxjOAyw1QbXjbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wBYRF+QRHQuDJy9WZ5/3dk3lO0BLABxU8i2pxNkmDVs=:9QjHUqNRkJD4NIljA7qZVYQ358OswRVIvDN0hOnMoJw=;
X-ME-Sender: <xms:MH7GamdFllsMBOxX13JtXcrowVho5yFe7sHou8uOukiYylOAnSO-ag>
    <xme:MH7GanPXeLH3OFg6yJ7mbI28wNMojFoACEebT2mpVNJXmtrVpROp89WFrG4om9_35
    wh5HkypSrqZPkLiXPaU-jrXB5z7eP5u77rG1h_TsugawuaM8OlqR_Q>
X-ME-Received: <xmr:MH7Gasgb8-eULSknwuZF-EOWl4-8p8RqtnuN9Fp8OJhQid9IpIizheERpcCeoG_ieoIa-gbmWbcBmcfkMs-5Xhmx3_KV8qbpJQ4g>
X-ME-Proxy-Cause: dmFkZTFVVmAjWNTq6MFgdcLb6wnqK4AXGeX0nfs6TO7k6ZZAJoio5A4GipGW1wOTm/ZfHH
    9uC4fqRPKo0L3c+X8KvOVHlOro8d+121ZGMC+wdv7V8dEwjaXHT4ny6p7UUPOD4rgo3dBL
    Gjicb0ap+JBjdyeM+93m8zeBu1gmpMkbuE2i0w/hmaHNLX0LEY1k1TYfMbuj+rduR6tiri
    LaJ+Xdqff1u6U2jzmKgzQmLaHgocJ2gcEHmHoGxolLbJIp8woMwnyDNRX4+bGtCfw3JX71
    OkaZ6KncoEhtZ2bkaggUfnva+TNxmF9O6JG9H6SicE4oXFkhlCkvhPPDtjPol8Sgw4Cvl4
    tESSoKkgD53gAzDklGsteJ0GjHbxxn3PK00dtN/fD+pUfcC/ugGpGpJgUrvzh4D+xITj5F
    DKOPzJX8t+USlA0Ez4ck8T5XxpDjkWqQuDjEzs5doyXq9Z2MwCqoywMRqo8p5INfZ+qRrr
    w+T4UXjxcFJNXJnIEi6JCjDhwMpni3EXHOZXsJthm2enU8kBNaFzrryJwM3GVDFZs87utr
    hTsEjc8VJp8Zv9uPpAjPiq5q1YpSdNAkv9pMiZ8+1fFc0N/hkjHbAgV1/lweTsJMgKZSE2
    +BThlBQFcmYtt3byilagq7MvxL9xZk+8yHL6RQ3fCtcEL6YDoW4+gSmIvBTg
X-ME-Proxy: <xmx:MH7Gai2S-BKCTfrxroYbl0PC-Wvja9tVHx96eyAShpFutn_KUKRBhA>
    <xmx:MH7Gaujg59uHkhbCQB2vIX0Wno0R6yioo4fyy8HDI9Gma7v47fmIgQ>
    <xmx:MH7GaqeAQcrCQvccN19Idt3yAjsmXfHkEppdBUysBa9Fii-zm4wGLw>
    <xmx:MH7GapnkWOtiVpPs2gQ2iPc0aq-6k2u9LiGzgy8wMu6INOWWMpNPeA>
    <xmx:MH7GanAu_112ji5NpIzvePXcPMJUtacrzhEtADw7kTUxGyt6qEpOlHAv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 13:15:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH 2/2] stash push: remove duplicate changes detection
In-Reply-To: <725487d3-5a07-40c6-a603-990a661e0193@gmail.com> (Phillip Wood's
	message of "Wed, 7 Oct 2026 14:46:08 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<95b7d582a2f86a3db4a9e182e482e9eb904ddeee.1791218125.git.phillip.wood@dunelm.org.uk>
	<xmqqpkxmgb00.fsf@gitster.g>
	<725487d3-5a07-40c6-a603-990a661e0193@gmail.com>
Date: Wed, 07 Oct 2026 10:15:26 -0700
Message-ID: <xmqqa4opa0up.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Before the precontext of this hunk, repo_refresh_and_write_index()
>> is called to refresh the index.  We used to leave early when
>> check_changes() saw no need to save.  We no longer do so, and
>> instead keep going.
>> 
>>> @@ -1743,8 +1737,15 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>>>   
>>>   	if (stash_msg)
>>>   		strbuf_addstr(&stash_msg_buf, stash_msg);
>>> -	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
>>> -			    interactive_opts, only_staged, &info, &patch, quiet)) {
>>> +	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
>>> +			       patch_mode, interactive_opts, only_staged, &info,
>>> +			       &patch, quiet);
>> 
>> And we call do_create_stash().  The first thing it does is to call
>> repo_read_index_preload() and repo_refresh_and_write_index().
>> 
>> Are we refreshing the index twice now, even though we know nothing
>> has changed in between, when we run "git stash push"?
>
> We've always been doing that when there is something to stash (which is 
> the normal case).

So when there is nothing to stash, we only refreshed once but now
refreshing twice is not a regression?

> To avoid that we need to make the callers of do_create_stash()
> responsible for refreshing the index.  At the moment
> create_stash() calls do_create_stash() without evening reading the
> index, but do_push_stash() needs to read the index to check if it
> the pathspec contains paths that don't match the index. That would
> also avoid calling preload_index() multiple times.

Yes, that exactly is the right direction.  Then we can reduce the
number of check_changes() without increasing the number of
refreshes, right?

Thanks.
