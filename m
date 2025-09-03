Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25D2EA481
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894539; cv=none; b=rv+0clCDFiySntWcy4mLsnBLRsHJ0TUwbb0bHNDf5o+C9Hcu5M9MQ9L9QK3BH6ObrTxQPxucdp5/bDCJtG682GyD3yBuugAhGwz9Y7poTxCVF+PjB5FOEp/tg3iLsO9C5jpoWmOWdiVuMEFmkV8ErFjuhF9c6Rw1WTxcolMRKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894539; c=relaxed/simple;
	bh=5FgOLselTfoT2t/IbXSwCOK2yeJeQUe+A0NP/iDOIjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW2j3KoPIj4VSLg/gmxWlPYyZ8xp30WAcDebvCOB/LeGK/RdXsrIOeNumS3WmcXH+Bf9S6ylT1CTLmmNwJbEOhiuhREpy4wtNmSKByjMJxsXawastHasxNIgS4z4kGc7v+O4TKPeNpbMgIpVvI5JQqiFmJR9dyYoZYFhu+l/gdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RQ15TJt6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJ0f/tBr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RQ15TJt6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJ0f/tBr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E4F114003FB;
	Wed,  3 Sep 2025 06:15:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 06:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894537; x=1756980937; bh=7AqIQMonCy
	FxXJTRb8mq1caHbE2wMLLgX5uTmZ/lZaM=; b=RQ15TJt69YBRENS/bZy9DP/bqj
	VWfrvQJ1rmMSQRyS2tfZtEhobznsVzfXAEBfTU+2B4G12hQhSLC4a/uio4Cixof6
	tBPtmem2ho3CKnmAQjMQNvR5aIf7Cq5NPbRjzkLgPTq3gxMqduSNZBDDwLZeZyTQ
	bJOq4t9CJpOt9B/p88mTfHpuXlE8pESz/njIJ24ol9RTr2iO1Riv098fcycaRSRK
	YQm5yvqINI1VbOg4gz9HxapRxGg8lRnpeC+eOnzRLuo3FKTfqSb5MG7nSk10oJUM
	QoltwNVPDeKx+XYWVll79udVjtJ3b/IdNM50OBm2rrqQKAvkcVN37YZnGjqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894537; x=1756980937; bh=7AqIQMonCyFxXJTRb8mq1caHbE2wMLLgX5u
	TmZ/lZaM=; b=nJ0f/tBrbcABMnXbvZB55KUawMs7GXFLb2IhQjioQGyUCxGXsol
	GHwC84gWyjnSRC+/CNNG5yojQRgw0eLmBFUWbU57OMk4vauU/ZVS+YxVFGLzBsxZ
	XIBxJe8ZpyzslfYSjzVfeLgD3+uv5C/lPHq1pTZrUwzImAcel+v61/76Kfc9jUts
	5MFximo8HVLqkBqBOc5RKcr4K2aIv8SC/7TSYBBkArrLSvTWI0/lZ30+en+pLyaj
	iHvGsunZXbao0empR3A8SswTvtX3GBfQEqxt5tFHgSMCtxFTVrrVmX6Ce/+5P7t6
	sr4hgp8rfy8ksm2Rg1vTgebGEO/b+h9+ZJQ==
X-ME-Sender: <xms:SRW4aJ9LygXFPhmTLwqNiKuSsWPz51DydocoD1vo2GCNuIQgj1dejg>
    <xme:SRW4aPM2SFXy48es6MiOSJdypRCECpBfvd044-Uz0d85rLPQxBag8O2vVzuoWQ5Od
    L1O1gSKKExFq8WvIA>
X-ME-Received: <xmr:SRW4aHF0N8gOrnXAOF2uyk1i7Jh0uigEISq4kpqs7__rXMaDGsLj8Mn8vrZcCu7oqUopM3zaPXz7BBKFOdb_LYbYXq4LvuzO6tN_P74>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    dttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SRW4aNRzYmxe0feRrkNjyvTZ5tbNpviyxEAFDujkvLBBZy90MnkAfg>
    <xmx:SRW4aEsRpY_4QD3AetAVK3s54OmYI8Xik7I5IiX5osDZfOTDYZJy6Q>
    <xmx:SRW4aFIAZ2mcmz9La-tCizRSAYVGozpgtr5tC0rwjjkzg-AzKZ7oqA>
    <xmx:SRW4aJkpgBupcs-nd0VRlWl_UJVOgsx1varC6nNZgrVpXMpM2UuBoA>
    <xmx:SRW4aC9s1ACuahPAOe7kgay7nDgrpFv19n8n_moET_h0YL7--bcewA2W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d983d6c1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:36 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:15:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/6] midx-write: simplify error cases
Message-ID: <aLgVRMxNUrdScrjk@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <7be25cf5349c389cf2887ab5b852779fc364bd7e.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be25cf5349c389cf2887ab5b852779fc364bd7e.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The write_midx_internal() method uses gotos to jump to a cleanup section to
> clear memory before returning 'result'. Since these jumps are more common
> for error conditions, initialize 'result' to -1 and then only set it to 0
> before returning with success. There are a couple places where we return
> with success via a jump.
> 
> This has the added benefit that the method now returns -1 on error instead
> of an inconsistent 1 or -1.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/midx-write.c b/midx-write.c
> index 14a0947c46..047ffdcdbf 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1046,7 +1046,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  	int bitmapped_packs_concat_len = 0;
>  	int pack_name_concat_len = 0;
>  	int dropped_packs = 0;
> -	int result = 0;
> +	int result = -1;
>  	const char **keep_hashes = NULL;
>  	struct chunkfile *cf;

I personally prefer to keep the result uninitialized and then assign the
result of `error()` to it. It's almost the same lines of code as we have
right now, but it has the advantage that the compiler will complain
about `result` being uninitialized if we ever forget to set it. So it's
overall way more explicit, and the compiler protects us.

But seeing that Junio previously recommended to go into the direction of
setting it to `-1` I won't insist on such a refactoring. So please feel
free to ignore this comment.

Patrick
