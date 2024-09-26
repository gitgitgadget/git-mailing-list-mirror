Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354B7D07D
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358609; cv=none; b=Q+6iEQqS1IGakqjlPqrjSwJSiZ3l+4jHxVzjN2n/h+J6NiMJOVa/c6N/is71fJX8T4GKpkU266Ydu85z4nOkIAkNXc2qNFi16K8LP/ZFP2jWRKFLR2Rae+Br0y9jFtCUxUnzb30isA1Qv4Ia97iTV01z5e4RYW6qVOnUvjMqyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358609; c=relaxed/simple;
	bh=paba1lIrvIXefJtnq/xOfT+pGsZm4dwiGoB/pWFN6Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9wTyx5/4sDYPaqKOjZDjcHivalSiv1Coj5mcDWYM8rN0lbFRMnMBAAx6bymNPMTdfJVEqpt8GMUlNrE140a9lwmd03kH6mh6sp/kV6S6jxhbifl8LSsC51m+qwCD7QmIKwqP345QMRK9gHyky68/8MYUHuAyOD8DcynF2EAUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0ZbdZUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pjLE2Ufe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0ZbdZUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pjLE2Ufe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72EE411401FC;
	Thu, 26 Sep 2024 09:50:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358606; x=1727445006; bh=kZ05zmhrRG
	0i9ZOov4chI9rOkFyvTnpBbLEGIOVuOdc=; b=B0ZbdZUC4yt1+cyLBps3hGV8ng
	IcOlM6OcLmE/69emrtzfU01TQNSs7hs7k4Dpd+/IL5vGtjafnvzStQwa2Hgl/ySo
	oksv0ifXmLlroSNWp2IOachlGf2MSY8FHotIE8d3RP+Du985mCx1wwDGhq4FT0xj
	zMWGasPR7hGNibEQegpvTbDAyFIJf9drTAfNb+p9FtJ+3WNE5rRwzCduujS8t/42
	CIpHuIrfoHTa5402crbxUjLI+iUHzeEN4eGKbhnvuD5GgkhngoLOoymygko6ZCuX
	pFKDkU3Flz0811du5aQT6v8NmJKuVom2OMNXsJtXxre1XNcTqlag4XlJMnNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358606; x=1727445006; bh=kZ05zmhrRG0i9ZOov4chI9rOkFyv
	TnpBbLEGIOVuOdc=; b=pjLE2UfeOnHR51jBL/HHaeOZIQv+BAkfOGCehX3ofSPf
	zYpIT/CGiwSzY1fhcxbAwOVpEBcVZ12zIWjAnuaRurRUstJ85KtQUTTdXAk6hGqZ
	7AQ5t0BmjDThTKyfB7bxnXn4cxo/4xTLhUHvvaJBCaN+7cys3XOip48Qsyv971N9
	i+xnX6SWPJRsAwKNVGDM9O5jctY2wVSY49yKNXrELobhdO/WPGYoqY5y22I+e7Q8
	B2WX5fUJLOM/H8J7AykWRp9oOe3kNMttM5icx7Rd7wjcAqPYcfOc1sucCQbQMOUa
	bo6tlwAn0clR3zAH8+zKEfdBOnjo4/Ws4XmXC5UWkQ==
X-ME-Sender: <xms:jmb1ZgYdGEmU7KRbFxuuZUpxF9ude3gfkYNDGmILM4MYhr7esQkegg>
    <xme:jmb1Zrbb1QatW3uRvdCjzvo4LbM8h0V2eLyuuSZyTQ5pLMH32BbUwvQmRRXymRisz
    ZnRIEj642_vu2dLxw>
X-ME-Received: <xmr:jmb1Zq9onGMz3Z-qOl3rYn5MwgOq_SLAD4EI7MDlKECmf6JH4dp4rBsZjiWWf3Dc3stzl7JLLBAAguF0vnt2BLkmxUXOowWgw2fTwbHadnqcCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedttdekffefff
    eigeehhfeitedufffgueduteffkeegkeevtdefkeehffeguddvkeenucffohhmrghinhep
    hhhtthhpqdhshhgrlhhlohifrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jmb1Zqo43XdWy3KQUNWOZEN_gJiRIkUyg_av9N7goRoUPKWw7ZscsQ>
    <xmx:jmb1ZrqgFa82RCtnqr8qBv0kDM79H9hy1Q_nJhdvT4zd3yt55j4WMQ>
    <xmx:jmb1ZoQn-_Jy8YcH8qfhEk5mcI59FD8OC98tj6A0Ok1QrJA5MIr0SA>
    <xmx:jmb1Zrr8vXJVg-q6x-fwsgclkpCgFzbUVh1RyMFrcglChzSD7-9oEw>
    <xmx:jmb1Zi1LSn5wZY3RiS4RgZoRzFiNZeHjWGdZ6kF94798fRxW66Coan6N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59d4fcf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:27 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/28] fetch-pack, send-pack: clean up shallow oid array
Message-ID: <ZvVmitkT-QUneqvb@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215225.GF1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215225.GF1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:52:25PM -0400, Jeff King wrote:
> When we call get_remote_heads() for protocol v0, that may populate the
> "shallow" oid_array, which must be cleaned up to avoid a leak at the
> program exit. The same problem exists for both fetch-pack and send-pack,
> but not for the usual transport.c code paths, since we already do this
> cleanup in disconnect_git().
> 
> Fixing this lets us mark t5542 as leak-free for the send-pack side, but
> fetch-pack will need some more fixes before we can do the same for
> t5539.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fetch-pack.c         | 1 +
>  builtin/send-pack.c          | 1 +
>  t/t5542-push-http-shallow.sh | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index cfc6951d23..ef4143eef3 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -294,5 +294,6 @@ int cmd_fetch_pack(int argc,
>  	free_refs(fetched_refs);
>  	free_refs(remote_refs);
>  	list_objects_filter_release(&args.filter_options);
> +	oid_array_clear(&shallow);
>  	return ret;
>  }

I wonder about the early exit path we have when `finish_connect()`
returns non-zero. Should we make it go via the common cleanup path as
well, or do we not care in the error case?

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 81fc96d423..c49fe6c53c 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -343,5 +343,6 @@ int cmd_send_pack(int argc,
>  	free_refs(remote_refs);
>  	free_refs(local_refs);
>  	refspec_clear(&rs);
> +	oid_array_clear(&shallow);
>  	return ret;
>  }

We also have an early exit in this function when `match_push_refs()`
returns non-zero.

Patrick
