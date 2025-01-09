Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13794BA2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448589; cv=none; b=PNMvjuvJwzsKjEJArHr6LEQa/XmR8M0DptIWn4e499OeP2glAGvfgo6ubPnRkQq1IgBYibMKtFKRsn9xsJVzECKSi4QYU0WAa7VcsSGx8qAJqtv/LdfseZpYX7oenONeLAQXAwBpNkW+CWxeVY8BU7XHtBjXNM2+lkonKh6dycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448589; c=relaxed/simple;
	bh=MHRONqPE2qXnFlay6K38iAZmUj0m05fw+nC8+PvHjE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poy92KI4uMe9joi9a19Xs+fEbhBS0GlxGh8hKnopbqh6x13T2zFUv5MMutjAzeqMsLzI6i69uzbPGqyI2ph65aFwreI462iUh2Q1KRuAAgDS3DNWkpNcOpk3oPZmxW3RkFm4bCknsr9lJf9vjAOKPUeZTKH0Qik77is75NvEHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vll8LWSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9uaOsqI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vll8LWSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9uaOsqI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09C6425401D4;
	Thu,  9 Jan 2025 13:49:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jan 2025 13:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736448586; x=1736534986; bh=alReDiOaJ5
	OPgbgoILbaWnba6/WC16BFXhAIWQNkryo=; b=vll8LWSdq3WCFtNPZL4z1KIBVK
	gJ7I3FBtTE0FunfKb9bxireZZsGLq8LwWZJMVLFoXOqcXvobnTQ2nUpmNft5M4LW
	7d4vrx8XSnqwdpxMDaNb1WuSn2xRzoT1og2SSrUzCHmZUEQrRTULE2PE0yE4O2ux
	c+KtRvydnjKUd+HA5KU7v2WXzPd109lnuhUASZkiYTMQ2B4FvpQUxvz5BAxfM94w
	EyoK1mKcyKEJXYtdLebvlns+qkSHhld1+Avw5lqzEG83c/kLquEm7QaksTTrNla7
	6zMh7LrIfk9PnzD0v6zwMqeketZf404UjqA63sCGeMJDBClwJR4Vo6fb6j3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736448586; x=1736534986; bh=alReDiOaJ5OPgbgoILbaWnba6/WC16BFXhA
	IWQNkryo=; b=Y9uaOsqI8wBDI+vPoN2gqI9p08fFwXiF8xq0ok2JxqRWYH5cI72
	m7KTIy/+6mGeT0pZrOBic1hM7WPUOWvynwjM4qL6Zy4ZUEQrBtZp4ZMCwTm5Yirw
	KIhzhfYMiVZV109SzSwLkg35fvYeCe6waqdRlM1biPoGpLFkP1F/x6RJhssC1GFh
	MXhiYepjhBnvDbrh33SBEZSWhInuiBYnq2+6X2Y63vd5axTy3E+D/vrKNMrM1Jfa
	0gU4LtDlBPw6EZD3aUoGYA3AA8Rx4eaTrj0SzF/hPOrFmpdZ6Koh7b6m8qgYAFE4
	Ln3uOFb/nYbLJDUQpCQxdo56V/T4Nm6Om7w==
X-ME-Sender: <xms:ShqAZ-H-KoCAhkTIzIFlewgVhqk3kRTPFEFpKJK3FO3a8ZYulqOWnw>
    <xme:ShqAZ_XHrpC-VyukAjoTdBthBhVuQlLDb91XdrWKjxerv6FNxbQhy_rzBU7MTLdlB
    ZQ6uF2H7eSmcBBCXg>
X-ME-Received: <xmr:ShqAZ4KZTWW8LiDA3nsuUKs_jPE_XvJXWP9uZoD3OAYsESbO5kzxfc5eZhVUVgXi7pDVSsP4xUcP4N5Z4HshlHOT4dhrRBwu2Hc1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ShqAZ4GUsF5m2mmM0e1UD4ADwNvQXQJKBCqdJCLSGUxGPuLAO85WfQ>
    <xmx:ShqAZ0XlyvfljHhNY4a6Cv3edpLc2yrtL0IcukceZBfAnMAc-s_GuA>
    <xmx:ShqAZ7M44n3p1RPgiM-Ivvlq0_POPuQQwFcG0UCkbKbFDQlhTp4B1w>
    <xmx:ShqAZ72H5MkCRF-bGMwVqI1CAA8UNono47ms2TBHoqmbHzX9fPXXWQ>
    <xmx:ShqAZyxxBk11usvZxQ86O-x_F67IA-rV3v38vpeAGOvzuv9_GGrkcUr9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 13:49:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 04/14] combine-diff: use pointer for parent paths
In-Reply-To: <20250109084229.GD2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:42:29 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109084229.GD2748836@coredump.intra.peff.net>
Date: Thu, 09 Jan 2025 10:49:45 -0800
Message-ID: <xmqqikqnizzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Commit d76ce4f734 (log,diff-tree: add --combined-all-paths option,
> 2019-02-07) added a "path" field to each combine_diff_parent struct.
> It's defined as a strbuf, but this is overkill. We never manipulate the
> buffer beyond inserting a single string into it.
>
> And in fact there's a small bug: we zero the parent structs, including
> the path strbufs. For the 0th parent, we strbuf_init() the strbuf before
> adding to it. But for subsequent parents, we never do the init. This is
> technically violating the strbuf API, though the code there is resilient
> enough to handle this zero'd state.
>
> This patch switches us to just store an allocated string pointer.
> Zeroing it is enough to properly initialize it there (modulo the usual
> assumption we make that a NULL pointer is all-zeroes).

Yay!  Every time I see an array of strbufs, my skin tingles.  Thanks
for cleaning this up.
