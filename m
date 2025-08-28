Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769F285049
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412349; cv=none; b=lUOIJY/GAgGtwLoBlNQRTLgW74FDfjUpNarQXN8BQyEDhjr3fYjbnO2U8mI6AoZCEjw0Maj8DBV2il4aF0oehe++VrLXFzVRH/dW9ad8IWicNrcQZPPU65wrs1MLNV45AMno4WfH5kwWJSS9DRMnQM9Zh6pmnKSwUTAg7Y5lg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412349; c=relaxed/simple;
	bh=rul3ze6Qkxoi9kBccF2HKVDj4bk8Ylg738mwxs/xeQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUJPUrFsk1UzVgrsDgAaHtmfTO0MIyUVNimu/Ip3y/gDlorm+k1Hej1B9e4JBnvg/gtpdcEGhDmGAIXEE4upDZZ2vu3DxqjdTQg05Wuy78Rt8CWWK6zSf/Wqh1Ilwj4lIzZlGuuKQSa692fV+pfLvcPzJLz5uJn9m2bMQY4W9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SzcCgUQg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RyhZmZ0D; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SzcCgUQg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyhZmZ0D"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E4B151D000D3;
	Thu, 28 Aug 2025 16:19:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 16:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756412344; x=1756498744; bh=lBFPhut5hr
	tZkT2ee90oM7HzQ3p/3hQSMnlZPYotKL0=; b=SzcCgUQgajtA8A678oObHncz8U
	wIdCD+I8z4QVzbd4OtvN0zNyVQYQeW7tSB0k1e38JpwWyMJUFlCTIbPzdUSWZ5fo
	nijfKgIHwDa3BcZve1kuKf4gYomxz6CMcIqb8gZ9eiFydPwYoPwahIF3q10s5jp4
	FmZuC8FCp0DPu2E9SF5KUZop8ISAb9900Puv5EojplLvaTQKfN2u/PkyKO9mkM6K
	QhH3rPOHpCllHwQfZzRDmrctAIDfBr9HwxVbajL30fYHRcHSTZbao4YrmeizJPuU
	shObR6+OK8//FQhvksQ3Gzx42VshyzbW8wRhkvnuh1DCfj5PHfcK2Q/oTiUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756412344; x=1756498744; bh=lBFPhut5hrtZkT2ee90oM7HzQ3p/3hQSMnl
	ZPYotKL0=; b=RyhZmZ0DbRcs4k4k85uriSrv2SGqbd+vMnqfH6RyWl4dMrQP3oG
	J8f8jS82TQ21X/vJrgjFpGTm7GinugGsHRf0bTVfOpNSR7enxDkohZzrh0cbA6U1
	LDutbsptXHDlouCBuuOQmMkx85VdEBOMhMYVTsr7YG+8vydMwOkwhfKndmh5ogW9
	Id1juKGoQ7CzR3vheLN9CRD3sxRCQYoHHlNRFgtPmHTmaC23paDNmtl6PZFvxLXH
	6PotbTz95HfgOWgIzMGc/owBuoVYgSKV1Ts4ygWRF70ifqKb4MsUMAkEbhhYVjML
	P9oDA20sJNgB0MCuF8wd8OLDFquRtAcfN3g==
X-ME-Sender: <xms:uLmwaB7cFWuDxp8YlM1TV8f55Yc8eFzTs9wIFpqxi3FNihL3ddfNsg>
    <xme:uLmwaKY_zM4VFuFQfmIlEqOZozscn-Scb8RKjuHVcdBPq3QTvQSGi3lD9v-VZ3_er
    q-rijxF0IckRctPxw>
X-ME-Received: <xmr:uLmwaO5nz7QurIeX7sDPNEezQzXuoVZ04H9VJOOiOOsRF2o6UG0qdNNQwkomJIDQRc1ZJinc2D7YTO4jDy9xkznny5RYCY9sJyGbazk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uLmwaFDRLLzFli6TYoF7z-scLscZ07jqbFMdwxwpc225ufNAd_80Pw>
    <xmx:uLmwaMdY37xHFmarFnOqasCtBmFqVmxFpeamnvu9eV_AE26nLhX1kQ>
    <xmx:uLmwaMLeiNSdI9s7ElSg17WVFi4P18x-eGtThp3VOPW7ZBzyv3uljw>
    <xmx:uLmwaP1lsgSq9_1Irvdm2FayNhd3PVUaYtoPEwR-q0gCykEKWjCGWw>
    <xmx:uLmwaI878KwXFacP03Np1dnoLMcBUjKzfeENWUTxGdHSY3KLHJRYpYtA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:19:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] midx-write: only load initialized packs
In-Reply-To: <4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Thu, 28 Aug 2025
	17:39:51 +0000")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 13:19:02 -0700
Message-ID: <xmqqbjnzurm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
> implement support for writing incremental MIDX chains, 2024-08-06) to
> allow for preferred packfiles and incremental multi-pack-indexes.
> However, this led to some conditions that can cause improperly
> initialized memory in the context's list of packfiles.
>
> The conditions caring about the preferred pack name or the incremental
> flag are currently necessary to load a packfile. But the context is
> still being populated with pack_info structs based on the packfile array
> for the existing multi-pack-index even if prepare_midx_pack() isn't
> called.
>
> Add a new test that breaks under --stress when compiled with
> SANITIZE=address. The chosen number of 100 packfiles was selected to get
> the --stress output to fail about 50% of the time, while 50 packfiles
> could not get a failure in most --stress runs. This test has a very
> minor check at the end confirming only one packfile remaining. The
> failing nature of this test actually relies on auto-GC cleaning up some
> packfiles during the creation of the commits, as tests setting gc.auto
> to zero make the packfile count match the number of added commits but
> also avoids hitting the memory issue.
>
> The test case is marked as EXPENSIVE not only because of the number of
> packfiles it creates, but because some CI environments were reporting
> errors during the test that I could not reproduce, specifically around
> being unable to open the packfiles or their pack-indexes.
>
> When it fails under SANITIZE=address, it provides the following error:
>
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
> ==3263517==The signal is caused by a READ memory access.
> ==3263517==Hint: address points to the zero page.
>     #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
>     #1 0x562d5d82d3ab in close_pack packfile.c:354
>     #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
>     #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
>     #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
>     ...
>
> This failure stack trace is disconnected from the real fix because it
> the bad pointers are accessed later when closing the packfiles from the
> context.

"because it the bad pointers" -> ???  Perhaps just drop "it"?

> There are a few different aspects to this fix that are worth noting:
>
>  1. We return to the previous behavior of fill_packs_from_midx to not
>     rely on the incremental flag or existence of a preferred pack.
>
>  2. The behavior to scan all layers of an incremental midx is kept, so
>     this is not a full revert of the change.
>
>  3. We skip allocating more room in the pack_info array if the pack
>     fails prepare_midx_pack().
>
>  4. The method has always returned 0 for success and 1 for failure, but
>     the condition checking for error added a check for a negative result
>     for failure, so that is now updated.

So did the callee think it is signalling an error, but the sole
caller was not taking that as an error, and that was one of the bugs
this change fixes?

Even if that is the case, I still do not understand why we want to
say in the callee

	error("message");
	return 1;

and adjust the caller to it, when we can just say

	return error("message");

in the callee(), especially if the only caller is expecting to be
signalled by a negative return value for an error already.

>  5. The call to open_pack_index() is removed, but this is needed later
>     in the case of a preferred pack. That call is moved to immediately
>     before its result is needed (checking for the object count).
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c                | 38 ++++++++++++-------------------------
>  t/t5319-multi-pack-index.sh | 17 +++++++++++++++++
>  2 files changed, 29 insertions(+), 26 deletions(-)

Thanks.

> diff --git a/midx-write.c b/midx-write.c
> index a0aceab5e0..d8f9679868 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -920,8 +920,7 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
>  	return get_multi_pack_index(source);
>  }
>  
> -static int fill_packs_from_midx(struct write_midx_context *ctx,
> -				const char *preferred_pack_name, uint32_t flags)
> +static int fill_packs_from_midx(struct write_midx_context *ctx)
>  {
>  	struct multi_pack_index *m;
>  
> @@ -929,30 +928,13 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
>  		uint32_t i;
>  
>  		for (i = 0; i < m->num_packs; i++) {
> -			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
> -
> -			/*
> -			 * If generating a reverse index, need to have
> -			 * packed_git's loaded to compare their
> -			 * mtimes and object count.
> -			 *
> -			 * If a preferred pack is specified, need to
> -			 * have packed_git's loaded to ensure the chosen
> -			 * preferred pack has a non-zero object count.
> -			 */
> -			if (flags & MIDX_WRITE_REV_INDEX ||
> -			    preferred_pack_name) {
> -				if (prepare_midx_pack(ctx->repo, m,
> -						      m->num_packs_in_base + i)) {
> -					error(_("could not load pack"));
> -					return 1;
> -				}
> -
> -				if (open_pack_index(m->packs[i]))
> -					die(_("could not open index for %s"),
> -					    m->packs[i]->pack_name);
> +			if (prepare_midx_pack(ctx->repo, m,
> +					      m->num_packs_in_base + i)) {
> +				error(_("could not load pack"));
> +				return 1;
>  			}
>  
> +			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
>  			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
>  				       m->pack_names[i],
>  				       m->num_packs_in_base + i);
> @@ -1123,8 +1105,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  			ctx.num_multi_pack_indexes_before++;
>  			m = m->base_midx;
>  		}
> -	} else if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
> -						 flags) < 0) {
> +	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
>  		goto cleanup;
>  	}
>  
> @@ -1223,6 +1204,11 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  
>  	if (ctx.preferred_pack_idx > -1) {
>  		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
> +
> +		if (open_pack_index(preferred))
> +			die(_("failed to open preferred pack %s"),
> +			    ctx.info[ctx.preferred_pack_idx].pack_name);
> +
>  		if (!preferred->num_objects) {
>  			error(_("cannot select preferred pack %s with no objects"),
>  			      preferred->pack_name);
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index bd75dea950..49705c62a2 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -989,6 +989,23 @@ test_expect_success 'repack --batch-size=0 repacks everything' '
>  	)
>  '
>  
> +test_expect_success EXPENSIVE 'repack/expire with many packs' '
> +	cp -r dup many &&
> +	(
> +		cd many &&
> +
> +		for i in $(test_seq 1 100)
> +		do
> +			test_commit extra$i &&
> +			git maintenance run --task=loose-objects || return 1
> +		done &&
> +
> +		git multi-pack-index write &&
> +		git multi-pack-index repack &&
> +		git multi-pack-index expire
> +	)
> +'
> +
>  test_expect_success 'repack --batch-size=<large> repacks everything' '
>  	(
>  		cd dup2 &&
