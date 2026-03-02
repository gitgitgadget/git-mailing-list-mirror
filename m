Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573C308F15
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492480; cv=none; b=iliRjbPb+mrE7H7uHOdVEMasKLlUtgHoNcsDAmt7rOdBwjz1Uj5VIrvikHaV7w2Fbi27snTgXBwxkuB9K2lsaGY+fSQcVjeNHVxnra0ju4Cnoi1bFa/dLEC3SzocVEX8APUh2rvhl3bZR/Ed+S+AFsvNbeEAX2ZEsPaGLyXQ3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492480; c=relaxed/simple;
	bh=U/fJEYZUrneoYuYGfbvv33B6gEcfrroEdzVFqgXfzos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LqxrBtLUMFxt3OPQ6z6dYbwwS2biBuccZGsITvOvYOWiAgSMTbU9ss510Y1LSmuxZHHhyHnZgsxZV//YHxUPTj68VqfeMNoQuxSsZpWp7+xvoiPIkzaz0fF1D/BSMt21IHRkWm6TWquPtQlybMMOiIu1WZm9clz9K3sN60D4tHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GBvljWWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbJjhsbN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GBvljWWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbJjhsbN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D78E1400074;
	Mon,  2 Mar 2026 18:01:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 18:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772492478; x=1772578878; bh=mB3v4/xE74
	E1vBdEBvUhGk8jPa+MlyNnuMw1EfI+RKU=; b=GBvljWWYHGHOKwsrl1gZB2ASTl
	lDNqN5P9zHBmOQsBLbJm7g3dZmL2Ebjz6H7fz99/slTsZQI58X8Ae4+cIABygXMj
	4qemmpXxgcMxE+4sSNemB2TUsbq5dp1hn50Ty/lAjPkgFSvUWspsLniJ4cTKRyJK
	eoeK57nQuR5rn/DaIpPskh53GbE8oA8eT95lIcMJ81U7AwuoYouzL93aKrdMq+U/
	lRBfQz0ltJeOSu0WndpKPuqL40fPpOcT1GQZWy5PF/801kyulSZk/d/hOfxEm7n/
	XcCR6/bsM9dIdaHCnYN5mJPxva9+aANtsA2mMsf0mavC79s1MP9Kyz2Q39yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772492478; x=1772578878; bh=mB3v4/xE74E1vBdEBvUhGk8jPa+MlyNnuMw
	1EfI+RKU=; b=fbJjhsbNwwc0xJRnm3fZFPQ03yXQ0629RL8i/uJ52PK0likajJ6
	ChehYG5Nipnq58lxATjUzL/YlfTL4P7/NUzdeC6BABqRU2CIUZB9hKRJ8iP6TvTP
	DJ2MF25/VivUQLEAnM0AaAVABRTDrk1xpxLskXmpMrr9ZALwzwC5xbpI8PFY8D6Z
	iAjV4NS3PPsSs9OtNXiO8rBodLja/k7Zj/rnR0BCxqb2Sh5Y0B5iq5BXH6GiL0QV
	tQtmAXs2NAsYOJhgGH/hOmvPm8LURh1ajJVa40CCLNSIH9MWg+EGpLCw8vkwaQgA
	z/H8bApGfExjjYQy2FYkdo0s8kPJcoxE8Fw==
X-ME-Sender: <xms:vhamaTKAUnqb1WR1RohV84t_iYTIz77JHoGqHy9CCcTtN4yE1h7kiQ>
    <xme:vhamael4N3A4W9TIpytr2WT1Tz4aPhQKrmWyjfu709jJlQzWoI8ptmrN_s7ViRS9a
    lgifEivsUHokTd0DHwUmIItqHmgyUdHANAnBPsNRwf8BQ2YqL1rjw>
X-ME-Received: <xmr:vhamaZHZiVeceG-QB4dOcPytoJjlf6pXlSktFZhMs3cmCDUDppUXvRBGlsi2hHnRJFgmMEW8ZKb2n-OA5Ha6W3vPLK03tERH1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghn
    iihordhpvghgohhrrghrihdvtddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:vhamaWFsoFcCSo6m-qd_AH1wwkYb7KjCFYDGTv4Ng6bRFZsu1_zs-g>
    <xmx:vhamaePGeuKkRELX3Bz0iATEU3qAOPQGvhLpo5sma0wdyvfczzl6Lw>
    <xmx:vhamadEhzPrNcBxCzD3c7GqXx1AH-PtI0Tb4nBf4fZZGlzWUUQkkQQ>
    <xmx:vhamadM1ywclNEwL7AaFtYFj41QRZc1OzKGQ6_OX6LUoWnt5_-35GQ>
    <xmx:vhamaWkAlairC2eCx7ykIksq7dgCi0rrwtiEg2MrpZ7WD8-IoGndXB3o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 18:01:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 3/3] doc: gitprotocol-pack: normalize inline code
 formatting
In-Reply-To: <e0e4ea3d22d11d8d6b6e721228f1420cb8dfa612.1772467050.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Mon, 2 Mar 2026 17:10:58 +0100")
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
	<e0e4ea3d22d11d8d6b6e721228f1420cb8dfa612.1772467050.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 02 Mar 2026 15:01:17 -0800
Message-ID: <xmqqms0px2de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> Uniform inline code usage for command and process names.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
>  Documentation/gitprotocol-pack.adoc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
> index f4c9e024b0..63d3971037 100644
> --- a/Documentation/gitprotocol-pack.adoc
> +++ b/Documentation/gitprotocol-pack.adoc
> @@ -117,7 +117,7 @@ process on the server side over the Git protocol is this:
>  SSH Transport
>  -------------
>  
> -Initiating the upload-pack or receive-pack processes over SSH is
> +Initiating the 'upload-pack' or 'receive-pack' processes over SSH is

These are not `backquoted` for <tt>teletype text</tt> typesetting,
like the other hunks in this patch do?

All other things in these three patches I found them reasonable,
except for this hunk.

Thanks.

>  executing the binary on the server via SSH remote execution.
>  It is basically equivalent to running this:
>  
> @@ -131,7 +131,7 @@ two commands, or even just one of them.
>  
>  In an ssh:// format URI, it's absolute in the URI, so the '/' after
>  the host name (or port number) is sent as an argument, which is then
> -read by the remote git-upload-pack exactly as is, so it's effectively
> +read by the remote `git-upload-pack` exactly as is, so it's effectively
>  an absolute path in the remote filesystem.
>  
>         git clone ssh://user@example.com/project.git
> @@ -163,7 +163,7 @@ supports passing environment variables as an argument.
>  
>  A few things to remember here:
>  
> -- The "command name" is spelled with dash (e.g. git-upload-pack), but
> +- The "command name" is spelled with dash (e.g. `git-upload-pack`), but
>    this can be overridden by the client;
>  
>  - The repository path is always quoted with single quotes.
> @@ -377,10 +377,10 @@ In multi_ack_detailed mode:
>  
>  Without either multi_ack or multi_ack_detailed:
>  
> - * upload-pack sends "ACK obj-id" on the first common object it finds.
> + * `upload-pack` sends "ACK obj-id" on the first common object it finds.
>     After that it says nothing until the client gives it a "done".
>  
> - * upload-pack sends "NAK" on a flush-pkt if no common object
> + * `upload-pack` sends "NAK" on a flush-pkt if no common object
>     has been found yet.  If one has been found, and thus an ACK
>     was already sent, it's silent on the flush-pkt.
