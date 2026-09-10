Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C038E100
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029336; cv=none; b=JdWlPQuvI0I6vBiJFj1du2TCmGbBChxR7qxZG1FR8uMBM465QxbdZrJFAzCfmFOIrbcEpjwnaJa1YJCY1s9zSOrf11Rxr5M4qa1sS9YiQLH5ubPzcV52cL7WvVsPhKvzoPEUaJklCivc/CD7uES3cV+kL7r1+7dvT9fLR7kzznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029336; c=relaxed/simple;
	bh=MZEUlYlVJSouhvdW6dhQv+JpIdBQ1dlGPLmGQ/HI96M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpRsHP+W1neykzCqLOPQzprqJ7kpuPw6U+eUYc2i6lmKKEKA9x5DFKVhh1EDH7euAKcdMCwoo/VkMLEa7bH69M1fRbmn/BvngEz/43801cAtIkOq26F7zgU3QkMwtmCCbB8+vn4YBYtwUdJDriA6ABQYimGo3hGhXbdBM+tl79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D/tc6qlr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYkFj/7r; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D/tc6qlr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYkFj/7r"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAB057A0127;
	Thu, 10 Sep 2026 04:35:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 10 Sep 2026 04:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789029333; x=1789115733; bh=P71aMsSVnt
	lKlaaHp/y2msR1Ld4SDYZjOx4ijM4Qd8I=; b=D/tc6qlr1bmzH9y4cY0+2Oez0H
	0tygJ2mSR8qHDU92RUpuhjJZopeAbzNiUSXQ6OQEhE0QW2o4iov2sGFaBxUOI8pM
	yk5ZyKY5YHAgAl2m2nBVutuxX/R7NdA0oGRgu2yYg0tNA13c0+cAH0NkNr+ofcwg
	2bkVKETVoP5o024KRtiJy4JXaBLUTenqmeK5WKI8m0t+r6YMECKafJiAzLDicQsB
	eBqGVkb6qWwsCaIEYNTZXIgIkxI45tm0Gt5w5hYEJmNCaDgci4Eiq5IhPK2shWA3
	5SN8jkqAmgihh4sxRmQVQXgx6iv+tDjdhE3d/BOfF04yHcqWAAhB20SKBgzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789029333; x=1789115733; bh=P71aMsSVntlKlaaHp/y2msR1Ld4SDYZjOx4
	ijM4Qd8I=; b=GYkFj/7rjUnRda6yX6QYsOLtyWQrCQ5k0iY+gGyXmbM1yclDqPd
	7KBLV+pLOAVMMFtpFpQ5kdnIBGrir7rTASqfUtLV4o37gvwjDy4+wf6MR9ROZc8I
	sfWH0UxTq4CM9IQuMidfG3E0QBZ8NfBOt6Hv/C3Fvz3VTvGEnzyK2Zh7aOZII7eB
	3b0nMn/Dj+BTra0CW5wdWtLNiwghKr+ScNq624z0dOpiUd9k+1fALThOui6bdOD+
	IxvduSdq+MkftDYs7DTuSInufHhgkpQ9h8yW1vxMy/q2jecM5cMopzdUR+GE8MFI
	739V0xRQnJDMBjY4Za7uYIXfcJQW0EVXKZA==
X-ME-Sender: <xms:1WuiannzejWcMAB6Vdylfp5x1ZEBjggg5RYQgUGuzpFmlirTkuy0lQ>
    <xme:1Wuiag0AOHau2cPerS0_0446OhURSGVkdVpEDX7ECdNdUelXzHNI-4T3N2qOWI3Yr
    hi-l_d1_YlgGfW3WHtf1KEkNyRdwfqrQ0Df-HG7zLZXSvtrJcwJn5w>
X-ME-Received: <xmr:1WuiarSpKCzEvCOT38c9SxGidf6qGGnrknkFIM22Ic-5ebeQEud3OA>
X-ME-Proxy-Cause: dmFkZTE4cQUiJ5k5OyTBEAgh7SuuUXMXPqTzQWiZNKlDS3ikiWWu3zG2U1IBtzn7ZKKXjf
    srJKMwOfcYjwL3UqsX/P7Dm0AXTFFfLT/64HcJs/QbLdKJQnMO9PaUZBNGk7UyDsroWogm
    c+S6uCEVRowusEtw5EcQNFwvZ1tNk9YcMuQZ3rGjw9v5zcI4/xBX/fmB9C2KGzoYJLPp5I
    KriDTesLGXFX31+FPW5g3reJZH3P1+KFp8SKnnNFwNTx7JwVnqHZh+dOkA8FIM82WalGbB
    CByxnrB5QWf03rKtaGpoCT6LUvOtr5EMn5rMncz9bLNdu5MUTmyaL4EtxdvwnyRnFU02lE
    jAXIVeoDsgkPYogTZWhC6+81KBnEYmAJ2JCyb/WHZjV9NsJKkvnhj7G514KVJchgh7deTm
    ykKvyxNOtEeldYz3tUJZX4PFUfYzvyVIe/UHbaKTO7wh184JTb+Ej5VbKQv/JL7pe8I0We
    tCIZ5z9jQPmZ02/KrMfojaTUwcHIfTax+l6amoGp/bURZDlTPCfyVmWidwtg3B3WoittRd
    t/OZVRSudQup3BGOC/BqMBTkagRKaG8xJ87NgkpHNyCcPgqoAtl4bmx3Pd68Om52Tc/hB6
    IMEmz4+COMqNVG9QHEDZow/ZX+oe6Y5HTa4Ri0MZNL0MFMyRkKOHZ0jvMgtw
X-ME-Proxy: <xmx:1WuiaqtCkgcmyhsqcnwa4fQgCtx9ioW1zSfNx6fzSHeO6F720wN1Zg>
    <xmx:1WuiaoaClkqJmazhSP--mtdOpIYfWexyLcarGLlncIHw9vi87eqB_Q>
    <xmx:1WuianvieSB6AAJmpK4ROQRBnyT_yD3-Kuuu5IdNt9BT1TtViP06mQ>
    <xmx:1WuiaiGjWKT4pEGrFl2sMl2CowXHwQwUSrOURWBXc4KpLeE-sn8QJg>
    <xmx:1WuiagW-OvRxkAK-BGmU37PtotI5FcVI7dEYv6qoFy3KILHYPLG4W9AA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 04:35:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b399344e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 08:35:31 +0000 (UTC)
Date: Thu, 10 Sep 2026 10:35:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ariel Keselman <skariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs/files: avoid packed-refs lock for root ref deletion
Message-ID: <aqJr0ZB8qpthTEGT@pks.im>
References: <CAMuXvLD_ZsT8Jnfs_x6yO_aW6hrxQyjnuES_b21cq8a7nD=sKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuXvLD_ZsT8Jnfs_x6yO_aW6hrxQyjnuES_b21cq8a7nD=sKg@mail.gmail.com>

Hi,

On Wed, Sep 09, 2026 at 11:45:46PM -0700, Ariel Keselman wrote:
> Hi,
> 
> Deleting root refs in the files backend unnecessarily locks
> packed-refs, even though root refs cannot be packed. This can cause
> post-commit cleanup to report an error after a successful commit in a
> linked worktree with read-only shared metadata.
> 
> The attached patch skips that lock for root-ref deletion and adds
> regression tests. All seven new tests fail without the fix and pass
> with it; broader ref, worktree, and sequencer tests also pass.
> 
> AI assistance was used to generate the patch, tests, and commit message.

Please consult Documentation/SubmittingPatches. The expectation is that
patches will not be sent as attachments. I'd recommend using a tool like
b4 to send your patches, which handles a lot of the nuisances for you.

> From c5d12e97a78123965590553fddc0dd78af3e006e Mon Sep 17 00:00:00 2001
> From: Ariel Keselman <skariel@gmail.com>
> Date: Wed, 9 Sep 2026 22:16:50 -0700
> To: git@vger.kernel.org
> Subject: [PATCH] refs/files: avoid packed-refs lock for root ref deletion
> 
> Deleting a root ref queues a packed-ref transaction in the files
> backend, even though root refs cannot be packed. For example, holding
> .git/packed-refs.lock makes "git update-ref --no-deref -d AUTO_MERGE"
> fail, whether or not AUTO_MERGE exists.
> 
> This also affects post-commit cleanup, which deletes AUTO_MERGE after
> updating HEAD. In a linked worktree with read-only shared metadata,
> commit succeeds but cleanup reports a packed-refs.lock error. Deleting
> CHERRY_PICK_HEAD and REVERT_HEAD is affected as well.
> 
> Skip the packed transaction for root-ref deletions. Keep loose-ref
> locking and packed-ref deletion for other refs unchanged.

Makes sense indeed. Root refs are never packed, and consequently it does
not make any sense for us to try to evict them from packed-refs, either.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a4c7858787..41887f180f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2981,10 +2981,13 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  
>  		if (update->flags & REF_DELETING &&
>  		    !(update->flags & REF_LOG_ONLY) &&
> -		    !(update->flags & REF_IS_PRUNING)) {
> +		    !(update->flags & REF_IS_PRUNING) &&
> +		    !is_root_ref(update->refname)) {
>  			/*
> -			 * This reference has to be deleted from
> -			 * packed-refs if it exists there.
> +			 * Root refs cannot be packed. Do not acquire the shared
> +			 * packed-refs lock when deleting a per-worktree root ref.
> +			 * Other references have to be deleted from
> +			 * packed-refs if they exist there.
>  			 */

Nit: I feel like this comment is a bit too focussed on the root refs
now. A small, incremental change could've been:

	/*
     * This reference has to be deleted from packed-refs if it exists
     * there. Note that root refs are never packed, so we don't have to
     * deltee those from packed-refs.
	 */

>  			if (!packed_transaction) {
>  				packed_transaction = ref_store_transaction_begin(
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index 74bfa2e9ba..b7f3287841 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -519,4 +519,50 @@ test_expect_success 'symref transaction supports false symlink config' '
>  	test_cmp expect actual
>  '
>  
> +for ref in AUTO_MERGE CHERRY_PICK_HEAD REVERT_HEAD

Isn't it a bit excessive to test for all these different root refs? I
don't see much value in doing that.

> +do
> +	for state in existing missing

Likewise, I'm not quite sure what we prove here. Should be fine to just
test with an existing root ref.

> +	do
> +		test_expect_success "deleting $state $ref does not lock packed-refs" '
> +			test_when_finished "rm -rf root-ref" &&
> +			git init root-ref &&
> +			(
> +				cd root-ref &&
> +				test_commit initial &&
> +				if test "$state" = existing
> +				then
> +					git update-ref "$ref" HEAD
> +				fi &&
> +				: >.git/packed-refs.lock &&
> +				git -c core.packedRefsTimeout=0 update-ref --no-deref -d "$ref" &&

Setting the timeout shouldn't really have any impact on the test result,
should it?

> +				test_path_is_missing ".git/$ref" &&
> +				test_path_is_file .git/packed-refs.lock
> +			)
> +		'
> +	done
> +done
> +
> +test_expect_success 'root ref deletion preserves packed refs and their locking' '
> +	test_when_finished "rm -rf root-ref" &&
> +	git init root-ref &&
> +	(
> +		cd root-ref &&
> +		test_commit initial &&
> +		git update-ref refs/heads/packed-branch HEAD &&
> +		git pack-refs --all &&
> +		test_path_is_missing .git/refs/heads/packed-branch &&
> +		cp .git/packed-refs expect &&
> +		git update-ref AUTO_MERGE HEAD &&
> +		: >.git/packed-refs.lock &&
> +		git -c core.packedRefsTimeout=0 update-ref --no-deref -d AUTO_MERGE &&
> +		test_cmp expect .git/packed-refs &&
> +		test_must_fail git -c core.packedRefsTimeout=0 update-ref -d refs/heads/packed-branch 2>err &&
> +		test_grep "Unable to create .*packed-refs.lock" err &&
> +		test_cmp expect .git/packed-refs &&
> +		rm .git/packed-refs.lock &&
> +		git update-ref -d refs/heads/packed-branch &&
> +		test_must_fail git rev-parse --verify refs/heads/packed-branch
> +	)
> +'

And this test feels like it's testing almost exactly what the other
test does. The only difference is that we have an actual packed-refs
file, but that can easily be squashed into the other test, too.

That being said, what we're missing is a test that creates a single
transaction that updates both a root ref and a non-root-ref with a
preexisting lockfile. Such a transaction should fail even though we skip
the packed transaction for the roof ref itself.

Thanks!

Patrick
