Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4E1EDA32
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644621; cv=none; b=u6M9KYCMpacRmUnTZxH2tuJo90cA6K0g2O5RJP+yluzm+OuQ2azY/VE4SE/V5hOdo6aqMC0OmCl2GKlhqy4x0xMo9Q2FLvTkVRE6j1GXf/rDEwfY9VBMTzoH2La0ak3NTsDhPPVGAMwlA9QXsif2ZFxvcp8hum51JlnDgMUMvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644621; c=relaxed/simple;
	bh=spynUW6+6FoBzT6fu7u55oELLrtm5nHLiMMyd1VB5RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYwIdmmFto/qk58jQJ7KIk62RyZASejxXBecUe3sEPWMNJJ2kEGSUnyONWEs1iqpTHCAGUN8fIBh8ZV0v5yOMVFeeeU6Fo1B60bLElMT++o8iC6myQAfYW4cZAOT/bpFHIspf/lWxoHFVTIEEMqKKP8cw4f1n2mEKkYzjndq8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c0IF4gGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXR/mkQr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c0IF4gGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXR/mkQr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 051CA140021D;
	Mon, 16 Mar 2026 03:03:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Mar 2026 03:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773644619; x=1773731019; bh=RsvGSBLBEk
	5zkgnuoIBc4g/1sLa2IL/WWb7hJ8Q80lA=; b=c0IF4gGanrGn8O/orH4VkLMwsd
	lMmSvAaYMVb9YUCyg3wL9Lh8SuZBTcx6euonIJWTgjPMbuIgYhaVLM/KFGMosE/V
	ylnJc14CIRaA5e7JOnMN89p1wIdq4Opq3KBt1bbfDP6OTfK5PQQijKWkVujunWON
	7c5vQUeUth5Tm9WjL84d4BbN8EjeBL3whiDk9OA1jixHWDhsszz1IUjpTJljZ0wM
	xaWmXgKmZk00IJsdTMWwGLIifx5mxZZEHpMeb8LjqEp7dTobmv06dox4adry65Z0
	sCHeTOjRrOKfkETY8wp5bHGNBXM8PAZ1yagTO9cx7uKblT4jDUit+J6XG9vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773644619; x=1773731019; bh=RsvGSBLBEk5zkgnuoIBc4g/1sLa2IL/WWb7
	hJ8Q80lA=; b=JXR/mkQrxyrTJlw+os6h0QlxwC5KMn8hA/qWXOlvoOYhGO9iq7X
	5LXrJMRPsnW+lBcR09Sk6Ifj7EhhyCFnBzTAomdCsLtCZo1UCSVEYxWgp8BdLP5J
	1SbC260V5CIpe0Kcid06SNETKy4+8lKZdVD/4T4W3timq8M6BScjy73YKpmK6V69
	k3XH1ej9Wa+tLoZSocXPTF83YSTesS8Tx76p3GocVhVIbYn+VjmYP1rU03JTSKZY
	oCmuSrFq7hlxUo0m668fcpC2oERz4oECzzyG3t153BCmf0i7FG8hWBQBD0w85uxY
	ToKk3ddo0MECCzsl9L7A4QhsXHTl7VFh6Nw==
X-ME-Sender: <xms:Squ3aXuKEj-lfnx-FNvMFMpuh-QH9whTb5aTJCVU34UuqFCSGLOEww>
    <xme:Squ3afc44jmjnuI-gqa83VOuNu_wsIVSEAEruCSzmYJ7Bh6TmP4DhVd0IbhWKs9Th
    zOgTyv42vpO3xmwsSqkb0-9LjMCbhQDK2StDW9qMfxIxcKfRZgNgQ>
X-ME-Received: <xmr:Squ3afw4HghaOfAv25677ftdRjF3rkcHcx2gwz2MmTHhLmmK7HnVm_CeToMIFg9eAZEmwDzmK-B84O3v9Ml1IQsoYuJupqlu2rjr1S0QcrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvghrihgtjhhujeduudesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitgdrphgv
    ihhjihgrnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Squ3aVG5gIUI0ltUpflDvdm-WdF_0NIDQIjZv9clQVMtnADUGU9Tcg>
    <xmx:Squ3aTzjOkBWJ_fBdvDHdVTi3mix6nt3aOi-gGl4shB2lPRw64tpTw>
    <xmx:Squ3aWv2IBMwzYlDElXMeypNtxSmgC3GtyZcMIOhrY6D5EE4EoWY-w>
    <xmx:Squ3aQ0h_D6VDLPaQKI2gP8DEjokz9zqI5397Tdut_22pAouhxUENg>
    <xmx:S6u3afxll-79yiVf059fjaAH2pB-WJUAlUhS7NaRQ7UMNaQJhgpYVELA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:03:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6be3a4f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:03:36 +0000 (UTC)
Date: Mon, 16 Mar 2026 08:03:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ericju711@gmail.com
Subject: Re: [PATCH v2 0/1] refs: add 'preparing' phase to the
 reference-transaction hook
Message-ID: <aberRbSCbMtZrqxk@pks.im>
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260316045102.70551-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316045102.70551-1-eric.peijian@gmail.com>

On Mon, Mar 16, 2026 at 12:51:01AM -0400, Eric Ju wrote:
> Changes since v1:
> 
> - Fix commit title to follow "area: description" convention
>   ("refs: add 'preparing' phase to reference-transaction hook")
> - Correct phase names in documentation to past tense
>   ("committed", "aborted")
> - Fix the sentence about backwards compatibility with unknown phases
> - Update die() messages to identify the hook by full name and phase
>   ("ref updates rejected by the reference-transaction hook at its
>   preparing/prepared phase")
> - Consolidate author identity to eric.peijian@gmail.com
> - Add clarification in reply to the question about how to use the preparing
>   phase for write serialization

All of these changes look good to me, thanks. This patch already looks
good to me, but I'm of course biased as I have been helping out behind
the scenes before the first version of this patch landed on the mailing
list.

> Range-diff against v1:
> 1:  5f9f13a84d ! 1:  fb74f21d98 Add preparing state to reference-transaction hook
>     @@ Commit message
>          interfering with the locking state.
>      
>          This change is strictly speaking not backwards compatible. Existing hook
>     -    scripts that do not know to handle unknown phases handle the "preparing" state
>     -    string will encounter an unknown phase, and that might cause them to return an
>     -    error now. But the hook is considered to expose internal implementation details
>     +    scripts that do not know how to handle unknown phases may treat
>     +    'preparing' as an error and return non-zero.
>     +    But the hook is considered to expose internal implementation details
>          of how Git works, and as such we have been a bit more lenient with changing its
>          exact semantics, like for example in a8ae923f85 (refs: support symrefs in
>          'reference-transaction' hook, 2024-05-07).

One micro-nit: this paragraph could use some reflowing. But I don't
think it's worth a reroll.

Thanks!

Patrick
