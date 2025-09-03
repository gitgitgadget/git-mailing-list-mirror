Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218A27FB2A
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884210; cv=none; b=MMXjgb8zr8aWb7Y7dB3hkBiYqAeFYRW9Gw8l8xBKkBw20ehGmllFKcDpUx9kFBMLLvvpodMcB4ODDai6UOM2Yof0cM54tmv8ZCVMLD9TfpFR+vBNePMGignVAINgMnH8yBAa5/z7pxbpt260JFfRgYQyW3q/oe3TMthvyhNaiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884210; c=relaxed/simple;
	bh=KtBC3NSDs3Eb048+zmNq3WdOOwVeTkbYPD+I9GAwQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR8TmDfTectLAu6q3CjquV8q+mJO0x01rSQUXXeMXB37K+F09BNyzzscs9bBoIVjnuY+NIJ/93mXD1VceKcPD16K5CtVGuXYVjB4R54XnmMKHhwjOlaw/iUeu3VyqsHcLXcqP4UG0GyoXphOx+7o6NLCUKeBP0uIaoADs11+Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YaDXtnQA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CU6H21mp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YaDXtnQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CU6H21mp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 93865EC034F;
	Wed,  3 Sep 2025 03:23:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 03:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756884207; x=1756970607; bh=1LYho9XHXF
	CevCssBAIwseL04l4iXcbQ5fq6eO6yKWU=; b=YaDXtnQAPhNwRs32lq4iTRJu/q
	wqGV5ayYH/9nyr+gVXVtINigbJWH0cvnu/x4llamAq9lRX3isiaamYe1JONFzxRZ
	RIkadWglzmnJEb0kwdGPFf9avnBLiQetyAwf4K5RslD+z8axdFRBDnrDOcMrN6lR
	alfgz84DfDSpf7osKbEn05jitj4wyFegImqLUmz4pbp2wfBIsFOTyVU9z7ZvRxXM
	CXSWfJICOuEWMk5T/XfMddIOHBYgT4qAPgBXhV9ap8OuUW/aGYPr/+y86nKy+NjR
	ILH2qscWT0YmBNJOWJ5yzNlj6veUOYBIaRsYF6WN8YGzbC5A9fbN+ocDUVGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756884207; x=1756970607; bh=1LYho9XHXFCevCssBAIwseL04l4iXcbQ5fq
	6eO6yKWU=; b=CU6H21mpHeSVxl/HgfbKFh8VkNlXgPoTnczwdtLxgdYk1D33WOZ
	rPF9khzT2FHKbvIQVE9q+qAJaDgt9T/w358cAM1yYUvIJOP8RBXQjDGCaQwcEn7D
	zTNuTTtwyWDoruz09nEsMHn/WF6wfi8l7GamB7DbeIWGPvXFN7p2Mh5uf1TQzMj5
	/3QriD1NYZPc/p1jY9xumSJUYD1b6bOrJNdIbkViMZ3aC1MT3wcWUx3kZidZCFG3
	yAIt6SRH8lUV/Orx6KtCosO62YRaiMZlhr+dWYud8v5zMeFJQbXP6zGYDpvojJls
	B3odaXkOF4ENaxdr0DMqL141E58KZaARiSw==
X-ME-Sender: <xms:7-y3aPUYE3L-gswk_dFXo7BoEfxfQAx46xBFn0DaaOTk3VyIa9of9w>
    <xme:7-y3aOc5y5y8Rr6GLStxhPNo8Kd53QMInPaVeURZS7H6GxKz7N5rmJQ8p_b-3V7Wg
    lUuHtkwiT5Ge5yP4g>
X-ME-Received: <xmr:7-y3aIWyEhbjl8SUllgan6-Droc8JRIXWTgkBmehBOoit3qaAz6BSYbTLq_ulryd5MwCuNmmmuKhVw2z0I6WTB7OqeJOqjB2nP41-mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepihhsrggrtghoshgtrghrsehlihhvvgdrtghomhdrrghu
X-ME-Proxy: <xmx:7-y3aHeKyIj5m1ic_VKdP_HBNwMkl9kh4FSOxGJ75IAuQ1taqGs0_g>
    <xmx:7-y3aEOfrKRsK_2UFpYttskxuzHqPze6iPXUYilMxc-PmlfMNlK0SA>
    <xmx:7-y3aFgPRI6iDaamvuP0-2b2pgzok1tap7IKEze8NRc1Q8rDQQoAug>
    <xmx:7-y3aH2mAwehFrc5iubK_ZGOF0zbvFnX26TMlWppgka4drk6QJxRPg>
    <xmx:7-y3aNbSO7X1WFZAPoTgKwmivd16pTUmu1o2fHnbY_FnFRbQeHE0Rhl8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:23:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69bafe67 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 07:23:24 +0000 (UTC)
Date: Wed, 3 Sep 2025 09:23:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] stash: pass --no-color to diff-tree child processes
Message-ID: <aLfs5EDk-krJHnmQ@pks.im>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821071517.GA1839835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821071517.GA1839835@coredump.intra.peff.net>

On Thu, Aug 21, 2025 at 03:15:17AM -0400, Jeff King wrote:
[snip]
> Reading that referenced thread again, Junio was in favor of reverting
> 4c7f1819b3 and replacing it with something that didn't kick in for
> plumbing (thus fixing the root issue). I argued against it somewhat
> there, but now I think I was foolish and agree with 2017-Junio. ;) I do
> think that fixing it now carries some risk of people complaining,
> though. So I'd rather do this immediate fix and worry about the larger
> problem separately.

Fair. I'm also in the camp of that git-diff-tree(1) shouldn't ever
produce color unless explicitly asked. After all it's part of our
plumbing layer, so it's basically expected to be used mostly for scripts
and not for users.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1977e50df2..c55628aafc 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -377,7 +377,7 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
>  	 * however it should be done together with apply_cached.
>  	 */
>  	cp.git_cmd = 1;
> -	strvec_pushl(&cp.args, "diff-tree", "--binary", NULL);
> +	strvec_pushl(&cp.args, "diff-tree", "--binary", "--no-color", NULL);
>  	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
>  
>  	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> @@ -1283,6 +1283,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
>  
>  	cp_diff_tree.git_cmd = 1;
>  	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
> +		     "--no-color",
>  		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
>  	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
>  		ret = -1;

The line-wrapping is a bit funny, but I don't mind that too much.

> @@ -1345,6 +1346,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
>  
>  	cp_diff_tree.git_cmd = 1;
>  	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> +		     "--no-color",
>  		     oid_to_hex(&info->w_tree), "--", NULL);
>  	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
>  		ret = -1;

All of these make sense. It feels a bit like whack-a-mole, and fixing
the root cause would address that. But I also understand that you shy
away from addressing it due to the high chance for regressions.

There's also a call to "diff-index" in the same file. Do we also need to
adjust that instance?

> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> index ae313e3c70..0bddbce504 100755
> --- a/t/t3904-stash-patch.sh
> +++ b/t/t3904-stash-patch.sh
> @@ -107,4 +107,14 @@ test_expect_success 'stash -p with split hunk' '
>  	! grep "added line 2" test
>  '
>  
> +test_expect_success 'stash -p not confused by GIT_PAGER_IN_USE' '
> +	echo to-stash >test &&
> +	# Set both GIT_PAGER_IN_USE and TERM. Our goal is entice any

s/is/& to/

> +	# diff subprocesses into thinking that they could output
> +	# color, even though their stdout is not going into a tty.
> +	echo y |
> +	GIT_PAGER_IN_USE=1 TERM=vt100 git stash -p &&
> +	git diff --exit-code
> +'
> +
>  test_done

Patrick
