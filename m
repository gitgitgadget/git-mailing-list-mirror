Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F73264F8
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610178; cv=none; b=F3QxISLq3hOa9Jr9IjZQy5mYqOB1bs55XGvq6xvg81WHqlPlyYYg+3le3L36vIrF/tQCk/aYddpAl7pO9+74IPO08rWdiE7fiOLyNZiM2Qint/+VCN71W4jCFkA7i+0OCtFO6GEjeJkM8YpYyowfUaI9+0WxCon43vLB2KaYhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610178; c=relaxed/simple;
	bh=tI/WU1kHVDILhvjc5sDty5JJ59JZ8VSAu0aWsproHGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+ZXpRGO+qAU3Lxp1wEz6iGfIbzRF82KceSLgfO0K7E+vgfeHEyp+T0maoRZ83MinPWIdDfzKRhKtzjILtoLGXN1X1+9Wet0va0Pakzm7an0G64O78xBBM+coe+n08x2xBO4KICu50oi+f6LymE6invL6AkHIYFwm4+Ire0hLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWU0AdTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnwbP6SQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWU0AdTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnwbP6SQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CCE6AEC00C3;
	Wed,  4 Mar 2026 02:42:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 02:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610176; x=1772696576; bh=fEcV7hoFzG
	qT9NaB2sPrBQ+VMT7O86hH4cwJSkq3Yy4=; b=fWU0AdTL4JHifJi8CdMZKRW7iL
	1+ovO1tLi72jikVIoMirhbAcTPUmAxBZDWTl3/lZjEmSzks0xZ5CPhaLY4m0xJnC
	xyBpj4nJkC+zwC8KKt2JaIXfnEXFywTfKrcFQej9CbdAKehRNZfieQ2+OEiuScON
	fhbvdfa9DBTNtWV5QTw5ONszzYvSF7DVWprYN7FP7xHOpEhOtITg31w90a8Oj/hu
	zYElpjRUm3pLAzTsN/xDn7KqEyCCheHUBzI6ooRsOGAWewXk2HFRCyKu6pTAMQa3
	TJNTMBkYlgitKqI0WDKJn3+0qYTeuns7rzplt3s11or9OzfgnQpTHNs+fYrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610176; x=1772696576; bh=fEcV7hoFzGqT9NaB2sPrBQ+VMT7O86hH4cw
	JSkq3Yy4=; b=pnwbP6SQkuYT17em3TMNUXmVt3yM5ZL/5F2f3Pm9Ta/kz4bm6FX
	Yx5foBNCrHcA7ZO+16f7UCEdzvqHYopXDxH/5BDWtDDsyAkbCHRHSHOyPKybFyU3
	HH1fRPxPuH5HiesvZFDONwkjk2qKHiCQTPFkavLUgXKPugxS0yq05O7NFJMTIS0X
	WZ9maA16bjIoSMIvL2kOS1LTqO3DL/KNbX/ZVkTKFtEZuOGzPMhSprx64AxPZ1MR
	xTSz8DoYXZ1Cz2rOIioJr0MEM7wMeEbWAKFAUx3d0bugsr9BwS6LFEjL+6jVuQjS
	/f0SVRQvq0DBUFjqjfkTXfN0wZ4h+XOjXsA==
X-ME-Sender: <xms:gOKnacnJYX4j69-CSAF6AlOYtBDfLBHFFuORNWaedkVwAwlFz78fTw>
    <xme:gOKnaTR4C7Bs-GzsGBlZNqT1gl09m68cgVpWVC8ApbFe1CVbRZx4TtI5dSsulxGG3
    Ivrb3J1paVgCUM0PeiRLYQe_H-F96IFEVhlDmTRiNy99U0UtcuZ3A>
X-ME-Received: <xmr:gOKnaYDuTl9AzBqCAHqldrHjNRB05BljSIEF31Hs3qCu_nzWymDbns8C4oBgadCkNcXKAWBEeh3_fQPQlXXSQC_0hOEu3pNVOdIfPzp0_CmGNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gOKnaSQQrUUN0-v68edWuQqLtdHhkxuSnYSwsNisahoU1TxbG30tOQ>
    <xmx:gOKnaeqywarqfPfre2TBppI5RsgcCaOtTRnKsUIThKvYFBlcdL6_7A>
    <xmx:gOKnaczqgKFqh5RVR9yOdO6JFaAGjtW6xnQ0uXsnNaPoGP0zoJFSkw>
    <xmx:gOKnabJKumBxRK--W1ulvKWnjXKuzuMzeasxNrs6E70hXNEIM9jj4w>
    <xmx:gOKnaUsFnpc_MgKXlxvkOx7nz-Tp4OtgTbFghrpN1gCN3kzhf6bgfbdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:42:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f0d31ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:42:55 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:42:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 04/10] fsmonitor: use pthread_cond_timedwait for
 cookie wait
Message-ID: <aafifU-befdZW4O0@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <0a586709524f36c189cc32159b643a49abdbd51c.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a586709524f36c189cc32159b643a49abdbd51c.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:17AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> The cookie wait in with_lock__wait_for_cookie() uses an infinite
> pthread_cond_wait() loop.  The existing comment notes the desire
> to switch to pthread_cond_timedwait(), but the routine was not
> available in git thread-utils.
> 
> On certain container or overlay filesystems, inotify watches may
> succeed but events are never delivered.  In this case the daemon
> would hang indefinitely waiting for the cookie event, which in
> turn causes the client to hang.
> 
> Replace the infinite wait with a one-second timeout using
> pthread_cond_timedwait().  If the timeout fires, report an
> error and let the client proceed with a trivial (full-scan)
> response rather than blocking forever.

One thing that I'd be happy to learn about is why specifically you have
chosen one second as a timeout value. Are we sure this is always enough
on a loaded system?

Patrick
