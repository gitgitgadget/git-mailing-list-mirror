Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0A13AA2A
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853644; cv=none; b=EosmSpkZaayZy+KOJmoC8B88Q+NG+rDqOQlg6s4+tb1csuUgu8QyzHuOdweOg8YOgpo+34p4Z3oG+EWuRru1VGM+6HNlHHhrDDCUDGWResPqhcGannZ18bSHl+yUAzIegKcXUvh6BugJ0aGawNTWkTnvGdbMQ+BQBPnL1hB2vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853644; c=relaxed/simple;
	bh=RF/nHunv96tFpSElRjYh1ExtiRhLm8XtOMTMX5/YMx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDIWIsrhweusBxDkUjj0JsQY+qMHm6SyFnbss/Qd+oUw7T55VotgVHhZHZgUNJcG2gO5h9fTf9S63gcp+vRwmPYFNubS+A7PZ/KpUMwkrrULLlQVmtNx5Z9aU70gYv6rSwRH6Sf2jJ/7E5/DCUzO3TlcCKX97kbx9MzwcId/v74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSdDub5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isD1NaQl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSdDub5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isD1NaQl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D0DF411401E9;
	Thu,  2 Jan 2025 16:34:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 02 Jan 2025 16:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735853640; x=1735940040; bh=s9Ez+A1H5d
	9hlXeWnyZ+MoiJUtpuHWNchKETSZUBels=; b=qSdDub5qEISkYIIUmo/n4owqvm
	cN3LtL2oVk/W6F5JGwFNz3BZ44jkAKRmvizlc6DTbZ2fxrSgGRkBuJKe4b2+ipbe
	dBBz07C+krQ7pu/b+8aln7+jQXkYeqGJZ24pIi+FrgK9EBmQGaHuELeP+GnHA72L
	FjKsG3i1Y24e/a/PHJA13qkBVklKVf3lUMMuTEr0ifgc0xZKpwXxF0dwa7nqiyk/
	rLa4O8jA2pSKycOb7PoR6yXNLkQpYbOrMmd+bVPjDwyEBm79pZHEEOTdNaHgzDeT
	tLXcYRlqKu7cVoCN68/iSheqPzvWX1FUQ9WFGmONm2bubrb0568K3gTjvgcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735853640; x=1735940040; bh=s9Ez+A1H5d9hlXeWnyZ+MoiJUtpuHWNchKE
	TSZUBels=; b=isD1NaQlmiRQjkslZY8AF7EiuTfmmFKbh1S0gIV+h6BpKKB2g11
	9KEVdq2maHZv4bYQALjaF1JsehnbcrS9kKLFXvfjEYdbvT4Csutj67JEzItfwtvj
	g2H2Zu+bW0KvhwHW+9P5L1V/ICsxyi3ah9L93ZpnFKrX8IRuWm2asZreSvnA2JMq
	+rfHbIqQYAVYOaI4V1MS12fLHRHuMBROwSsXCGPrP+EIFuQBE98XXtgPs+7gY+Kw
	l1OWF0dpP06/DtIl9MqpeRsQ+uvY7lgWuY2xi9tjOKY0CRj5tbM+jSeFK77tnz/A
	kTS0qAdphjHz6nSYr3Mq8gKaQpDcM0eksrQ==
X-ME-Sender: <xms:SAZ3Z2QVZg5Xo2l5DPAaF4Ffhpi9gCi0A66JZnGt0SRgO8oFgYC7Dw>
    <xme:SAZ3Z7wP1ZCp9baPflHTRA6XgEckQ2BNCfghM863pnZ15sUqD8C6ChLQzQZrX-AbD
    2Hii7zsjN7W3PwIcA>
X-ME-Received: <xmr:SAZ3Zz3zipeeiSyzRh5dMbZMafbwSlT1HFsZ8gQ82vxZuQur6khVO6tliInJRIOXvt43qJCynNbHa0rqS_Fv1eWLkkQw_QBBPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhfuhhnnhhivdefgeesghhmrghilhdrtghomhdprhgtphhtthhopeguohhr
    vghmhihlohhvvghruddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SAZ3ZyDL0cNWPBIUMSo9jif7gwDy4PNVzJvzYva66twVH1IpRZLFWA>
    <xmx:SAZ3Z_gAlhrV3MbIQEY2Qpepxk2MoB2OzK58jFBQEYXGsuWg2iESBQ>
    <xmx:SAZ3Z-rVQ4xuizo4226fygk9mDcPyKQBbNFONJekgZjye_VtkcwJWg>
    <xmx:SAZ3ZyjiZz2EuBHaqc-Rpd7kPe_wphlPty5iUX__TOrV9oBIeVsiOg>
    <xmx:SAZ3Z6Wb01AoWpaQ-k96foooTtjCZFvubZ7gzvrlEw-LwRNWuKOfg6Mx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 16:34:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>,
    Jonathan Nieder <jrnieder@gmail.com>
Cc: git@vger.kernel.org,  AreaZR <gfunni234@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH] git: use U to denote unsigned to prevent UB
In-Reply-To: <pull.1849.git.git.1734488549111.gitgitgadget@gmail.com> (AreaZR
	via GitGitGadget's message of "Wed, 18 Dec 2024 02:22:28 +0000")
References: <pull.1849.git.git.1734488549111.gitgitgadget@gmail.com>
Date: Thu, 02 Jan 2025 13:33:58 -0800
Message-ID: <xmqq5xmwuchl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AreaZR via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> 1 << can be UB if 1 ends up overflowing and
> being assigned to an unsigned int or long.

 * Spell out what you meant by "UB".

 * "1 ends up overflowing"?  One is one; as long as you have two
   bits, it won't overflow.  This needs rewriting.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5e5afa0f267..a636e71e05c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -223,7 +223,7 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
>  		ce = the_repository->index->cache[pos];
>  		if (strcmp(name, ce->name))
>  			break;
> -		seen |= (1 << ce_stage(ce));
> +		seen |= (1U << ce_stage(ce));

Here "seen" is "unsigned" initialized to 0.  Matching the type of
the value that is assigned with an explicit U does make sense, but
as Jonathan already pointed out elsewhere, as ce_stage() cannot be
more than 3, this would never overflow.

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index c5ed472967a..d0104dfa0c7 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -270,13 +270,13 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
>  	unsigned dirmask = 0, mask = 0;
>  
>  	for (i = 0; i < 3; i++) {
> -		mask |= (1 << i);
> +		mask |= (1U << i);

Ditto.

>  		/*
>  		 * Treat missing entries as directories so that we return
>  		 * after unresolved_directory has handled this.
>  		 */
>  		if (!n[i].mode || S_ISDIR(n[i].mode))
> -			dirmask |= (1 << i);
> +			dirmask |= (1U << i);

Ditto.

There are a few instances that left shifts by 31-bit, which requires
(1 * 2 ** 31) to be representable in the result type of signed int
if we want to avoid an undefined behaviour,, but even if your signed
int were wider than 32-bit, it is a good hygiene to write your bit
shift as (1U << shift_count).

So I am not opposed to these changes.  The guiding principle should
probably be "bit patterns should by unsigned by default, unless you
have a strong and valid reason to use signed" (and the only single
plausible reason being when you take advantage of fact that the sign
bit is propagated if you shift right); as most of the changed code
paths do deal with a signed result that is representable and does
not risk any undefined behaviour, it is an inappropriate rationale
to justify this particular patch, I would think.
