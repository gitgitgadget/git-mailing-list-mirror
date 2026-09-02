Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAA3B42C7
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378760; cv=none; b=lazKnpMhP9zganAVtM4Pqdx6PxrVzKOHwwFoq+QfdDX5W2k6GKLtCiZ1c9n2xD8lnhFSSpK5ykpCp0bz6TSx1q+MSzejH7dV3mkiojfq5F2AUoR/9eyLwI0K/xyeujqsuGZAiqrhm4NSO8HpermYQvBdECIFTZulDLlJi3WYrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378760; c=relaxed/simple;
	bh=mu+fogzVQcAI6B08S8beYK9nKc++Qocgywwutfu91RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCTH40G1zaGqEWtHI4q55FLL427gctOn8lRTuIR9QpteZrDS30aJUWWS5Td3d/j97RvG+ng2ljMBt15Qj0J2PUEWBDg+Ezpz9u4Un2+Fi/L7FSF2NYwmKv+eq0DrfyVqpE6cLfYTE1uQKnzEFDpxvF8CIWfT5MbO9VoKziMZ1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dBAUgqzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAxTm7vI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dBAUgqzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAxTm7vI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D33C01D000B0;
	Wed,  2 Sep 2026 15:52:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 15:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788378751; x=1788465151; bh=Zicr227oqU
	FLMknsnNSUsmu/vr2w3Isfqk+7Uqjb4SI=; b=dBAUgqzi241jK9X5Wkf3ZzqSIe
	BJTv/kml9Q320SBFU6Gy+d6dtqWRqz7dBbh3yG0f659Jl8Sm/RTdqedF4tux1hbF
	Tl+76j0pDFkE7m2HRLUkr0BaWWyNfgiTuy0svdjXeDza7ZlJFFwbwcLdyWcchPpr
	iq/UdMimn6sqbF1kaxe8hYqgCs9gugXW0LzsPKZPjeFk9BqCW1zw0bkUKtqkNLh/
	TSfwG090JGlz8FDAyv+eAhwxYGFzPgvchcppjqXmw5KClxhjgSDDne1hDYR/FQcn
	/jR/u+pryRky8P6+S2/2U+3MQFzCrIzWuTfqcHRUHyYm9qRzERrOObrAVJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788378751; x=1788465151; bh=Zicr227oqUFLMknsnNSUsmu/vr2w3Isfqk+
	7Uqjb4SI=; b=RAxTm7vIUxCbwXXu+laBB5MByte4qMuvf6Y9CFng9FOqNV7pHle
	xiu4t6FJv94ulSrRT790aq2XNRT/54kPGDMg48tumPK6v01LXn5nSzVdFmnwnJQT
	mHrDWfbCC+Gd5R6pkiKzF3LI1yo2SbRWI10V82uCoYXeHdXcWRQwHGHudurCTy3D
	YW07qfPIyVYNIrOFu30y82kWa1HxmgCEtZUNfxIWFxRx1T2bOWAy515AF8rUdAsm
	IRkKqbr7FevWJBygpkO6GsPSn9pFWNGKxN86WFU2v0TbRKRn+5CxfAAUOHsyBtHH
	gPUNWkQrWUeIm/TH1VsnCfPKdhSM6eMr55w==
X-ME-Sender: <xms:f36YapT_XIO0oU9d9n-KddJsiNed-7yRuHVM6OFGxLlbGEQQw_L6qg>
    <xme:f36Yapqw1IvZ8wNqTctle3bVYKqgaaDVWgTt5_EQOByn5mQvyPmWCTcJHMS21oHek
    wv41jQYONIooxxIaClk6UasrorL5tNOsvgCp_V-eYb2BW_A2HnxzQ>
X-ME-Received: <xmr:f36YanIgRJ34eLmM7JemFKSv0_6Y8znTPQtkF0Oo5nscosDEqmzDHNo0NLYmFz2ALoW3OuI0iHUplqWgpRPPJDzyL1bOXov8dQ>
X-ME-Proxy-Cause: dmFkZTF9xYGVwqUG+lXw1HXtf6YNnIOGPXWkb9HZjFw5+XIhffgaubiZmlo05W7sD4q73N
    xnM2NoUiUEYRn5np93cAlWLKmoxJfGr6OGBkkTs3pfrbCnDSoWQlDJXXa7iYs3pQ/Um6bv
    Zrb66dmieCpbqh+uzkXS+xXaHO/15hy3HdvMcX2ij5d4IAv3vjVmYa+jo+rpCgPQQbdvR5
    CyGZPWXnazbIzCCwnp4C/OWPU3uym91zHXZFWpG5dj2IswmS/Sdsgk7hdeBX8cY0OLtdsX
    x9VO/z6j76WcR6Ht1NzPsf+hSYiTGf39HXv9bndtYG2AfJUpu19/FGI/X+MQRpu8tbFkFf
    TcQOf+IOGYM8TR2OIvg5IXGxu6JrZ4HTilxF1NMgNX1Imqx1S2sPcaeGveqKNbDFCtfzKM
    c7LgPIu6c6ML/sdCUh9UmVpehZwMlANjom0w7xRgK7YHwzZ0TUS+VwhaXMqLpBPXjXG6MD
    rYBNUDcrZkTVmqrmVYc0nV4Nm36QNVAS8NA2dpbtRyDALpWwcWmxj2sKlIc4QXgjUtzS39
    nk2oIzZrruRnQHlo04riXCIpauAG8Yx+2J1FqX/0MVW4lTzKrhhgEDvBTzYhLOT1ImR7KY
    ffcmWo9JCpMcdur6SCt5B306vi+OLd4bvxliDEe+0njLPsYy11U96oJYP34A
X-ME-Proxy: <xmx:f36Yaspm4XU8zxOipqIxV6BOitK2xySfrDMdkST-p7xOu_XIb6vUIQ>
    <xmx:f36Yavz8n9aO0WDPQgGmOvT4hHuG9Q0fyo393DP60CkOaN7VOzZhQQ>
    <xmx:f36YagN5tePLq0fM6bRHkA7ewZNID4nmkGR66LJEEu-tzW61YvojeQ>
    <xmx:f36Yak6A-n2i493C2tGWDayoYcddYSREfA0GO2uzG-iybUf92RsPQg>
    <xmx:f36Yan5pLtkDsoKIWaR9PJEVAk6sEgAkD73oWXPX2sJL4pHdAPdvxe01>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:52:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/2] checkout: separate autostash conflict advice
 from branch-switch message
In-Reply-To: <935fa0a9ae69f269a8a79f213f02aa4ed1e8279b.1788373743.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 02 Sep 2026
	18:29:03 +0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<935fa0a9ae69f269a8a79f213f02aa4ed1e8279b.1788373743.git.gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 12:52:30 -0700
Message-ID: <xmqqse3rh1mp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git checkout -m" stashes the user's local changes when it cannot
> perform the checkout, and then applies the stash.  When applying the
> stash results in conflicts, the advice on how to deal with them is
> printed directly on top of the branch-switch message ("Switched to
> branch ..."), making the two hard to tell apart.  Print a blank line
> in between so that the advice and the branch-switch message are
> visually distinct.
>
> apply_autostash_ref() reports whether applying the stash resulted in
> conflicts via its enum stash_apply_result return value, so only print
> the blank line in the conflicted case.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/checkout.c | 15 +++++++++------

This iteration looks good to me.
