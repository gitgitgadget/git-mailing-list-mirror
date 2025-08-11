Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E472E3706
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901971; cv=none; b=M/d9BZaQB8xW/g9t5m54dNiGM5tEFPevJw9Or6/1qr8Gh4tI/TqvDoL/FVbD6Vb7wnrz9GbB7T7f1TZdUDUxUDDDcM4k/txoYUXGwgSU+NlZxA2np8mvvGvksNeUhkDxkf3GP1KP06A70iAOOnFoxpZma+GsVAGya2pCDTRhyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901971; c=relaxed/simple;
	bh=afS9hz+hYO2o91Q4JauTTChuaUV9iN9oCibK+9r9RrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoGUXPZ+U40iwQMAXhbosCibiECjg4T+pTMBl7LHEbIFhUN5aMMcbSQI2GvPtFTeUfBgxpaHy0ceEVn7c/JB3jiAW2g84ACNeKW8qsoK1ru9/BCnVfcmv6TTo0Ie2oJxeb6TD8CQtQ0aHt9gScWBgd6Rcg6yD2pjKTgC3t8Geq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/siIMFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X755uW/0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/siIMFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X755uW/0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 493B8140009B;
	Mon, 11 Aug 2025 04:46:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 04:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754901966; x=1754988366; bh=lLg560Wft+
	DDEs0Q3SpimqXJElWEYQF3ryDviGJ5VJE=; b=V/siIMFpFy7tu/PplBHMbp47Uv
	lFzWsmUAIN6im3yfMEulEBjPXdpsiFZzgEicNFPbxS1D4M4U1kmMN6qfQKlGQYLP
	URPSKfcnEDjgp1P6gDUjGj7FOe05Aqq5vsqYqS0jf1HSyuPsA2stxk+lMOru33pF
	rLiwuYKUIym26jhmcpgWG5BDLfE+2KidTjW5EcHc7nuUIw5FmAV2F4sVQw1LN18O
	WBwBi1CAGV9YgyoHS3IUQHixuX9mtmxXhhg3ek3TC5JjtWzbK6qZGtsSPR0vt/3l
	JSRcDsFhBVHyB664SaiwCsIVBeYnr+o05Z9kSJzbhl+Nh+nUU+0ryLD5Y/ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754901966; x=1754988366; bh=lLg560Wft+DDEs0Q3SpimqXJElWEYQF3ryD
	viGJ5VJE=; b=X755uW/0yAI8EfrEOjQE+fW8sl/JUToEwrq0ZX3KHVYmWGAIs6l
	kVZS4LFMUpU5s0xlF9VDOU6jGlbLCfyEVUWu3xWZZxO7RrqQyj4MdWa2LrAGCYjf
	5bY5w5UZ+NRwJoIsu0mkf+lC8N/xjS7rzmnCBo8JMoTx3quTL+G75CZt4cEIqb82
	gNz0roGlPPqMeaVn4rta1+Hk3K9egfbSqXsMs9xrqUgLC8AQZOhQQtBeNvZKDhj/
	Bfpuem0+yDv0FF8VD62ikC7Ip83oXRBYscN7qY9MMQFDwTV9PH/2hNuy9uKybyDf
	slKK82INFnvspbaAQQPhdi4MbIfjx1EckpQ==
X-ME-Sender: <xms:zq2ZaPhsFausO8NFqUSEUuGrJ5gU4lg2imLp41uk3yIl7JNYMnolSw>
    <xme:zq2ZaPQ9JNF6dQO8wzb9fXHr-qcqWhAi7YZke5u-GWYXuMKm-MKcjr3IS4jE3c21k
    aUhWHxXGovJkQrnKw>
X-ME-Received: <xmr:zq2ZaIgc0jlfhDAjczxY3VZtTsFmTRok-yWGRN79Vgj0YBFL8jptCANYIr3fENp8krsdZOBtQ-sh8srQ-TlxKRQDJNetKd29MblQ6blk-O8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:zq2ZaH7R2QsORiBjccEfS-K1doMtj8S7aLSIG-d7UOZLC2LjJG30jg>
    <xmx:zq2ZaNDnrixE10zE3O397nHpqVGlmZS8L_3dwThBKcAvWR-CFoTcvA>
    <xmx:zq2ZaGadUKx4RhWnsati1EbRIgHWRJHPW8mdNdCQkCzzxntNP2yheg>
    <xmx:zq2ZaAZp87wDDGsV0ZpDo6MS99d-9yTzyfCr47om981hFasY95D6SQ>
    <xmx:zq2ZaCcYO6rRjAjYOZm3hYejJqzb45jIXMxpC2KUlAS-n6BXBqSorYDI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:46:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7fbfe292 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:46:03 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:46:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
Message-ID: <aJmtyLgv1so8qdY7@pks.im>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>

On Sat, Aug 09, 2025 at 01:14:13AM +0000, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> Start with an example that mirrors the example in the `git-merge` man
> page, to make it easier for folks to understand the difference between a
> rebase and a merge.

Makes sense.

> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a6..449f01fba560 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -16,6 +16,29 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +Transplant a series of commits onto a different starting point.

Nit: while this is one use case for git-rebase(1), I'd claim that
nowadays with interactive rebases there's the other use case where we
don't change the starting point but only edit the range of commits
itself.

So how about this instead:

    Edit a series of commits and optionally transplant it onto a
    different starting point.

We could also make the two different modes a bit more explicit by
pointing out both different use cases directly.

If you agree then we should probably also modernize the description in
the NAME section accordingly.

Patrick
