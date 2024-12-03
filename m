Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3280604
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205668; cv=none; b=sKLvNncRpqceZwdEn1ThAjlUCBWHGGKndLR8rj1pnzmunVaKub7fMbT5gESjuQnwOinNMbcJLMqiNsDAXPuCzB5JkFB9BMsGlYABsPxPGqRRZWjzTVT5OFw38gDs42JB7ZXn3kEpYZqsBHX4HZv+G8mdBMngp9Bv4AwMLwQaQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205668; c=relaxed/simple;
	bh=+1c3t0vay3yzV9+n1zU4eyiaDDAMVEnpKGi9BeduAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv/Q0RwO6a3CnjbpqGz1hAC3i8x1BqCxNiN/C7cwaJ9lJk+GslkMbacqU0UGMW3uvf4FgSPiSxFViXc9CNf0+3wkIZKLpFEaSI9Z6zWjdTdtNqkGpSHYBm5iUdXDuKU0chMHyXdaTfIV5O+9Tjtyidx4rRXt6RcH2BtGseiIqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHOAwwCX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jf4dV0c1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHOAwwCX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jf4dV0c1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC86325401C7;
	Tue,  3 Dec 2024 01:01:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 03 Dec 2024 01:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733205663; x=1733292063; bh=QwzF4ztKOx
	zSCQs7oDHUmhrSAvBxLvAa29xz2wgyhe4=; b=PHOAwwCXo295qxT/FFRoPMOxgh
	rYA0r1wYV2yrInPeWSaSFbFPtjXZwYp3GDz3BR1lSmiqLFPiVybLMAC/Zx4W8FDl
	l7aZvZd+qX/xToDLg0YUMo6/iP88sAmFdsu160xz0Gu5xGqO/0ylM+++xwHkTZQi
	vDU5bjzgzEWUDstojXGo7nGIRifeEOfokE3bMyqClYhS/P93DJNSv0TPDHZ4U+yk
	xbjcYvzSBmIBypAh298wu+7GnqTgJSJleDw3ZoVtfJAoWLXxQM2swSws2LTN7IO6
	+5eHAjF3XeQ6SeLSUgyb4lms930Gs0ACzvTMYr4YEyajcEyYjiPQSpg+smAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733205663; x=1733292063; bh=QwzF4ztKOxzSCQs7oDHUmhrSAvBxLvAa29x
	z2wgyhe4=; b=Jf4dV0c13mIJVLyD05SARzH3uPSpQvxLNh22MqIqgbqRJtXpNY6
	4zrPiYbklZoBH5i8V1N8hy9AuG0V3MwtK8wCK/JMSllUPyfP/j1GGNZiHvihvFJn
	BV3NeqYMALFcpDUR4CglM43lWZVxmf+53B/j/bLt1PpIFbM2pGutk/7UrklFkcqv
	BO1mr5fohVR5zyg+EIQGTCcgzNydiTv5ZLUGqgU7PAVVa2K365/uRKm4CNsUc/Pf
	050uJUXv5AuIwPy00XNXWmv4D6zhFDh9qTwrjVHaPCNWnlus1LIqpGxi833emT/F
	d+4VrOpPyr/EGNJ3FONIpTdwCY0D/LH/q8Q==
X-ME-Sender: <xms:np5OZ0DIr7ZKjeUULiBbbpf-26NjVStvN1da12JjzJMfyRN196AGPg>
    <xme:np5OZ2jftxk8om4XpBfpqdkm5dXoHX1Nb6ModgeNphDd9kpJJzsiFnEQHfrbyMP-N
    E2ev72YtmIOBFblzQ>
X-ME-Received: <xmr:np5OZ3nnQUE8dqtA2NpNRqQ-srhdo2Y8_9x5MN6y4TJMdM9PNUFt70Xv97CQtZkYRhrOehBIOk-6ywTf-Bit822euV13o57MrddC30gJmEfCXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgv
    uggrnhgtvgdrtghomh
X-ME-Proxy: <xmx:np5OZ6ywdZVOQtM4-oyP0xa3jFeby_CY8UH4GPZtrJSu386wJtav5A>
    <xmx:np5OZ5SFqqKAroc5cthByRWEwLVTxC4tbKflPhajb__x2_Id79DLbg>
    <xmx:np5OZ1Z09HPNxCVEPxLx46a4MUzA0QjskSECet-34VQUDbpsa_ousg>
    <xmx:np5OZyRegEWkzyDGf3nh9Dq_FrAy-Z5SA3sKdu2P_CeS42qOF8hAOA>
    <xmx:n55OZ7fO2uYGKTsOipWG83CpbaiT9Evb4XDY1fuqXQt6b5GfAEsPYLWH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:01:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b339045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Dec 2024 05:59:42 +0000 (UTC)
Date: Tue, 3 Dec 2024 07:00:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, hanyang.tony@bytedance.com
Subject: Re: [PATCH 2/3] index-pack: no blobs during outgoing link check
Message-ID: <Z06ejDgTnC6gWXgx@pks.im>
References: <cover.1733170252.git.jonathantanmy@google.com>
 <300f53b8e39fa1dd55f65924d20f8abd22cbbfc9.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300f53b8e39fa1dd55f65924d20f8abd22cbbfc9.1733170252.git.jonathantanmy@google.com>

On Mon, Dec 02, 2024 at 12:18:39PM -0800, Jonathan Tan wrote:
> As a follow-up to the parent of this commit, it was found that not
> checking for the existence of blobs linked from trees sped up the fetch
> from 24m47.815s to 2m2.127s. Teach Git to do that.
> 
> The benefit of doing this is as above (fetch speedup), but the drawback
> is that if the packfile to be indexed references a local blob directly
> (that is, not through a local tree), that local blob is in danger of
> being garbage collected. Such a situation may arise if we push local
> commits, including one with a change to a blob in the root tree,
> and then the server incorporates them into its main branch through a
> "rebase" or "squash" merge strategy, and then we fetch the new main
> branch from the server.

Okay, so we know that we are basically doing the wrong thing with the
optimization, but by skipping blobs we can get a significant speedup and
the failure mode is that we will re-fetch the object in a later step.
And because we think the situation is rare it shouldn't be a huge issue
in practice.

> This situation has not been observed yet - we have only noticed missing
> commits, not missing trees or blobs. (In fact, if it were believed that
> only missing commits are problematic, one could argue that we should
> also exclude trees during the outgoing link check; but it is safer to
> include them.)
> 
> Due to the rarity of the situation (it has not been observed to happen
> in real life), and because the "penalty" in such a situation is merely
> to refetch the missing blob when it's needed, the tradeoff seems
> worth it.

So is this a one-off event that may happen once per blob, or would we
eventually evict the refetched blob and run into the same situation
repeatedly?

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 8e7d14c17e..58d24540dc 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -830,8 +830,10 @@ static void do_record_outgoing_links(struct object *obj)
>  			 * verified, so do not print any here.
>  			 */
>  			return;
> -		while (tree_entry_gently(&desc, &entry))
> -			record_outgoing_link(&entry.oid);
> +		while (tree_entry_gently(&desc, &entry)) {
> +			if (S_ISDIR(entry.mode))
> +				record_outgoing_link(&entry.oid);
> +		}

Without the context of the commit message this code snippet likely would
not make any sense to a reader. The "correct" logic would be to record
all objects, regardless of whether they are an object ID or not. But we
explicitly choose not to as a tradeoff between performance and
correctness.

All to say that we should have a comment here that explains what is
going on.

Patrick
