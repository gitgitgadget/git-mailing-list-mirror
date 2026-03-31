Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A93FA5D9
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975046; cv=none; b=TYvKoSypkDtwKtFiG9Gc04V8UWaUooBvfYhLzdnT1V0lcscmF/yfjZOidj9OeiCzx/avujyyIxPpf9XMquP80DUfkgl8fl3LERV1rLxX1EHIV++zBV8fOQYkYtjloBKQQATO/7tEmoKKA31AuD8T1ApSwNsdu1fGcFyt9vNLU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975046; c=relaxed/simple;
	bh=YACnDrXXV7iQnN0eujgXKp/3BNQx+8tw1igvNReQNsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jy4Nv2a8e5d0KFvClZvirlkL/YcAuu37tsl/YMoxk74zaGzK7ec3d6BUI/GVtPVMTgwvUVel34CsHaiyUte1yFxavlPgGuiHJJZrRRJtiejwbnFht/rbE+t/gUppFDJJ8TrugQp/UNPL6mVI5nuiAOQbuzTbDVRjY9kMdCBln3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bThahNN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXgdVE71; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bThahNN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXgdVE71"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E3ED140020B;
	Tue, 31 Mar 2026 12:37:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 31 Mar 2026 12:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774975044; x=1775061444; bh=ez7A+wm52t
	/RSuzlZuZAT1Wg3Nyrb783BX7cd7s3pso=; b=bThahNN9DaBcV5Z1VkwP05vFyI
	8jtydmYYW1CB7qILOBY/M2O4AiiV0y4axzS0h+9HzaSLUDYaIR9xC4rR5wnSDChS
	HPpMTVma8MjB1CoaQf1FytKY2GYxMk2O9INeXBfYc8Ge/+xq98u0RsbQ6wGIsxeD
	cF5DhONGKvcgpw5OPNSBgBl6rTlt/MXH+W6shu1b/5KtFaqTTT2Ww3tPVATrKuV1
	lvIFG7TnMLMHk/e1SP1ppyTh91gERAiDdVzeVigmfeWH6Nr7FY1M5aS8DLOYSoTh
	JQmsEaKSspSlQQ8Fz45EEWz+jKgYu3A9P4kF/UrEPVmeR4H4T9u1OHEu5GOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774975044; x=1775061444; bh=ez7A+wm52t/RSuzlZuZAT1Wg3Nyrb783BX7
	cd7s3pso=; b=cXgdVE71FuUHmpl8wXloMkCAcvRlDYX/3TvCySGfOQCwbTHhBAm
	Ab4kSUJZveHnSjGiWJpHF5cWQQH2g9xtl0yAHFk+qaWfanRTsjqsjkHKNjLiJupP
	pZ0QdfbW1Vboe+GiKVR4yrJdbQeRtBZkuw9/NMLlPV2VlUdLxIiHPg6SArSXwh8G
	VLec6BPUhdIbcUTu9Ggw8AVRIYTWjCk8WI7+4X5bEhp5mr35yz3Nyb1ItAY48rll
	6FNur3Mus4zwXq4eRhbtc/mOVMfydixkIVzDTQgcAkOt63QlCGSWYiIdxEbW3yoR
	yjhW6Y7vSRjXd05Bps6lh/x2KsnDtnCwFuw==
X-ME-Sender: <xms:RPjLaYRdV5nw93IqTgz7fMCZ85tc66o0WsulzD9De_tcCjN1fnYhfw>
    <xme:RPjLaYBttXT6ZcR_6JBla6zzttbnxUSmMu3rxmtbIp56aAC-e0K0KYmFQric4xiTt
    74NoLAufW7Vp0Zzq9sByyq3Si79ipLEz0qFGRV8-Q6TvYm1C_zQiw>
X-ME-Received: <xmr:RPjLaYF75I5_cglykIh-v67LFpHLUBy5tU-PlqLNthf8w951Tm5t4uizVEZFqQJORoLaA0GfRfwCsu5iyVO0t8oTNTQKTM_TSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    ohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhh
    uhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:RPjLaSDq2WUYdttb_ReQ-EfDk2MoLMxBHW-3Q_Co1_E5yC5e1h2vVA>
    <xmx:RPjLaQVEVgOYdSItzNFTNsiJ939tVXNex4wvnk_x4DacZCkpzAsq6w>
    <xmx:RPjLaerTwEm2gEyUfqWLJzScMyirvwFKp7MqlMbi5czl87dDhRQGPA>
    <xmx:RPjLaUTSEGGsHDUic1eqSDNEBVCfEVkhDwA2mGoGlynoTZaMBRxGKA>
    <xmx:RPjLacTgCrZNY1LAIxDszaxFV8Y08xUvsCahxEbunw6tJsvPqoWJ1fXO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:37:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
In-Reply-To: <84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Tue, 31 Mar 2026 06:19:18
	+0000")
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 09:37:22 -0700
Message-ID: <xmqqse9g0xbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> When GIT_TEST_SPLIT_INDEX=yes is set and the fsmonitor daemon is
> active, tweak_fsmonitor() can hit a BUG() assertion:
>
>   BUG: fsmonitor.c:27: fsmonitor_dirty has more entries than the index (2 > 0)
>
> The fsmonitor_dirty EWAH bitmap may reference positions from a
> previous index state.  With split-index, cache_nr can be smaller
> than the bitmap expects because entries have not been merged yet.
>
> This is related to the issue that 05f28e4b3c (scalar: use
> index.skipHash=true for performance, 2025-06-04) worked around by
> disabling GIT_TEST_SPLIT_INDEX in t9210, noting "the issue should
> be resolved in a series focused on the split index."  This fixes
> the fsmonitor bitmap side; the index.skipHash interaction remains.

Let's ask for input from the author of that scalar commit 05f28e4b3c,
which hints that the fix should come with the focus on split-index.

I also have to wonder if we should bury the issue like this patch
does, which is not limited to the split case (i.e., the assert
should trigger if the requirement is not met while split-index is
not active, but the patch castrates it), instead of mimicking what
Derrick did to work it around on the test side, leaving the
production code still broken, which will give us better feel on the
urgency of the split-index case in the real world.  I dunno.

> Two places hit this:
>
>   - tweak_fsmonitor() calls assert_index_minimum() without the
>     !istate->split_index guard that the read path (line 98) and
>     write path (line 128) already have.  Add the same guard.
>
>   - fsmonitor_ewah_callback() unconditionally asserts and then
>     accesses istate->cache[pos], which is out of bounds with
>     split-index.  Replace the assertion with a bounds check that
>     silently skips positions beyond cache_nr.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  fsmonitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index d07dc18967..5e5a4fadea 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -33,7 +33,8 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
>  	struct index_state *istate = (struct index_state *)is;
>  	struct cache_entry *ce;
>  
> -	assert_index_minimum(istate, pos + 1);
> +	if (pos >= istate->cache_nr)
> +		return;
>  
>  	ce = istate->cache[pos];
>  	ce->ce_flags &= ~CE_FSMONITOR_VALID;
> @@ -805,7 +806,8 @@ void tweak_fsmonitor(struct index_state *istate)
>  			}
>  
>  			/* Mark all previously saved entries as dirty */
> -			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
> +			if (!istate->split_index)
> +				assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>  			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>  
>  			refresh_fsmonitor(istate);
