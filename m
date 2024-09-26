Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192085956
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358612; cv=none; b=qRCy1jTcswc0nd7ZRyaHLgoOhiawph7yrtbou4O5rH+04iV4l2I06MbeyMPT8+GO16OeD4QhABMDYej5SRqQvwyAwGaZon83+IkC8jUG9pkPvWuXVslGX4npAkCkgD0FS+XQjp4r3Fv6Yvqggwz8RWst7iL7gn/6epRcNdBYXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358612; c=relaxed/simple;
	bh=n7jYyO3TWWJnJz0HweemNOv2Gl8QtWKBu6B983GGInc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcDIVpHZX8HsmGBh+NnfuWUt8bOV7TYDfOY4NtX7qg7lLGaKNlRtPNNMfFMsCjaRl75bN/XSRbOCpuzdEoilwC0JT9x6Ja5LJB2Mzw71of7rYBC6fl/O3wB3Y2h7ZaGc8mS2liWYCjJku6IbR+83td+mzRvHBsH3rSuPeZf/0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uyd2L5Yy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjQCYIrx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uyd2L5Yy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjQCYIrx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9723B13802BF;
	Thu, 26 Sep 2024 09:50:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 09:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358609; x=1727445009; bh=3TmrQsXD2e
	AgJJbWuNwUdF3iBsj55H/6UlqWZp5g59s=; b=Uyd2L5YypenXvUSo9bzOAaX0yt
	HUfkQUUWSrG5Nh4OjLGjusOaoK07vrfN8w0+DEtWM1W9wx4PRVcFubwq6iX+/zkq
	+N8V1l+B5NBBopQaOsWTGXnmwER3wjHsXxaFBJqAglKg94hvW5KQs4xPFs+ENrNJ
	68N7aKIH6GONIJXXDj31h1SNT6s/3eQCk97iP/Lgbi28owTggjJ1qultuYrZvg+4
	HdT+KMnakm5rsN/plGbmr4TaDmu13MptAESe3fRdua46HUX26+lQLt36ENPcdnA+
	UGT8m42uziu4qcNyccUkdqbVZG9UwPzjpP1HF58dMBar8Bl8uRGj889/UpCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358609; x=1727445009; bh=3TmrQsXD2eAgJJbWuNwUdF3iBsj5
	5H/6UlqWZp5g59s=; b=fjQCYIrxnjNUy45AGZZQbnOVjsi83qbZHu/6Wra/1XGh
	Jk8a7nYRyYXeEyTVggNCHEOLvbLwR8C94H3H2iDBCisi7QLrh9woiX7PpibqNV4U
	4EvLk8QvcozeQxulPjYRhxQk4darNqCAkm4vBdlWln+tooNlrPpbLJoRb+xfFDFJ
	KI4t68vLp9dQzw8Zveo83h0yprWHHntASDTaVFmDlqlPiMbSEhvTHpbf1H4W6vzr
	zGH+XIJD/EuoQGyI6SMrHP0dQjapIlJ8znzaWHQnXuddIz6uurSlUSXmMcXPLqCc
	5nFb80+LnVMvRegU2UUhcfrclBU1UWBYRw5YBWBVVg==
X-ME-Sender: <xms:kWb1ZsGUtHEnlmGbruGkhBnvIvAXPSF7Ro0XVFvWCwjwJ08K-x7Cjg>
    <xme:kWb1ZlXYam-le_QsCex48vmOffi5-LpqWBXI691H2YZSTIUZnMG9JPaS8hj0LaBLu
    wGqRpuF669qLFRD-g>
X-ME-Received: <xmr:kWb1ZmLSloqNMGWfiC2ouXykE1fZg54fsSKV_d-096iSFsKW0_Pm30SfGQ0LjLwt5usKF_7eTMPmwuQsds436S2hQ9riXfg06y96UibjKukM4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekueeivedvje
    duudehtdetieefteeuveegieevhfffhfeludeufeeuteekheelueenucffohhmrghinhep
    thhoohdrihhspdhhthhtphdqshhhrghllhhofidrshhhnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kWb1ZuELd7ZCluBjgvPDowbA2xNEuwGVpF9SUo7E76h0nGQC4ykKlQ>
    <xmx:kWb1ZiX5C_PtEdHE2VLbG5hAfNn9vdReeMBVtXMr4sIcpuiGcjXf_w>
    <xmx:kWb1ZhPv8oJU0K00iBKJBqIjVil2qJ1HPGpPO9aP_digGaH0IxzJJQ>
    <xmx:kWb1Zp1uXFa4giTFEsJCfydYgU1U1_Sbk2Ga0lpJmp7Lu2f5CcdBPQ>
    <xmx:kWb1ZvglbX5Hn1ttAh_RXRFe0fuZo_TyMgK5VpyPJIaQpdkBNwNuUeZ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a72a0bc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:30 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/28] commit: avoid leaking already-saved buffer
Message-ID: <ZvVmjbMujO1h2sQp@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215434.GG1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215434.GG1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:54:34PM -0400, Jeff King wrote:
> When we parse a commit via repo_parse_commit_internal(), if
> save_commit_buffer is set we'll stuff the buffer of the object contents
> into a cache, overwriting any previous value.

Interesting. I saw some cases that I think could be caused by this, but
couldn't make much sense of them.

> This can result in a leak of that previously cached value, though it's
> rare in practice. If we have a value in the cache it would have come
> from a previous parse, and during that parse we'd set the object.parsed
> flag, causing any subsequent parse attempts to exit without doing any
> work.
> 
> But it's possible to "unparse" a commit, which we do when registering a
> commit graft. And since shallow fetches are implemented using grafts,
> the leak is triggered in practice by t5539.
> 
> There are a number of possible ways to address this:
> 
>   1. the unparsing function could clear the cached commit buffer, too. I

s/the/The/

>      think this would work for the case I found, but I'm not sure if
>      there are other ways to end up in the same state (an unparsed
>      commit with an entry in the commit buffer cache).
> 
>   2. when we parse, we could check the buffer cache and prefer it to

s/when/When/

>      reading the contents from the object database. In theory the
>      contents of a particular sha1 are immutable, but the code in
>      question is violating the immutability with grafts. So this
>      approach makes me a bit nervous, although I think it would work in
>      practice (the grafts are applied to what we parse, but we still
>      retain the original contents).
> 
>   3. We could realize the cache is already populated and discard its
>      contents before overwriting. It's possible some other code could be
>      holding on to a pointer to the old cache entry (and we'd introduce
>      a use-after-free), but I think the risk of that is relatively low.
> 
>   4. The reverse of (3): when the cache is populated, don't bother
>      saving our new copy. This is perhaps a little weird, since we'll
>      have just populated the commit struct based on a different buffer.
>      But the two buffers should be the same, even in the presence of
>      grafts (as in (2) above).
> 
> I went with option 4. It addresses the leak directly and doesn't carry
> any risk of breaking other assumptions. And it's the same technique used
> by parse_object_buffer() for this situation, though I'm not sure when it
> would even come up there. The extra safety has been there since
> bd1e17e245 (Make "parse_object()" also fill in commit message buffer
> data., 2005-05-25).

Okay. This feels a bit weird indeed, but the fact that we already use
the same strategy in other places makes me feel way safer.

> This lets us mark t5539 as leak-free.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit.c                      | 3 ++-
>  t/t5539-fetch-http-shallow.sh | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/commit.c b/commit.c
> index 3a54e4db0d..cc03a93036 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -595,7 +595,8 @@ int repo_parse_commit_internal(struct repository *r,
>  	}
>  
>  	ret = parse_commit_buffer(r, item, buffer, size, 0);
> -	if (save_commit_buffer && !ret) {
> +	if (save_commit_buffer && !ret &&
> +	    !get_cached_commit_buffer(r, item, NULL)) {
>  		set_commit_buffer(r, item, buffer, size);
>  		return 0;
>  	}

And the fix is trivial.

Patrick
