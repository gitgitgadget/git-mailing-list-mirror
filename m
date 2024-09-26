Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B141482E2
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358630; cv=none; b=ci9u23XStkwUvOU1FV5LBaJcvbbvkPUgvqoYZGEkS5b3D6/5bVpQHl24j6mqt2ET+VSP167ozSSuYJsNu74csIYvZ9w4prPfm44qR367+WJnKGFbac6cW3+AXTkk+l4vB0MNGFaNzaB1rLxV7KCo8TAJq4viFxtii+b6tvLHE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358630; c=relaxed/simple;
	bh=4HaZrTg5rccEbknNRGiZPcfWtBxFYQ5ieKZv3MeAugc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh/yWSBtgMTLqniGeHG4c1EIgEtSRsU3Ah7asOKzo3IZaFv/Fk9HQGL7oAtpN64Evl9hKudfNblGAcyawmsOO3LjUaw2JfDU3BKaKGSEjEFM5Tkm4kPVh1+570zdUfdVUj6L/uHPDEGLKUewR5MyDqD/xmVdN/AzywCuPPN869U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PdK7I8iG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/M2WdhK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PdK7I8iG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/M2WdhK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BBB2213801DE;
	Thu, 26 Sep 2024 09:50:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358627; x=1727445027; bh=9K8baDZzp1
	XiBSctPK5abDAlzCUQxGgrtKmqjrfA6io=; b=PdK7I8iGToYY1I8fX1I3uy/pNs
	DactHwhMDhc/soTkKckOPB57xSJL8xvpOWN2icx3G9ivHH6aKETPz0CMaCpQYp17
	fZ/yv6i+HblXEeb+as6WZvF5vgjp4GQE2jJaktU6rAx0WMsvyxugL4HXE2I/ocMv
	VmYimQ/UrQgZ08yhMYmXYU5HaYCRgjGW5oco2UQf8NjZHpqq3UVmT6IxpGAGPGgb
	HJ9vyw2PM8vp7I+UaANa9/rNXJQwc+rAGJuymqE1lB1j057FMd7KyFYx5SeGSJkg
	EaJenmxLiolytaEOce8kGivKxgD0ZBkpbac7eZ0gS5WI7+NtO9K5+PyHaY9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358627; x=1727445027; bh=9K8baDZzp1XiBSctPK5abDAlzCUQ
	xGgrtKmqjrfA6io=; b=K/M2WdhKcSQ2+qPXw51GTdFMKp1SOg6S7jiiV86Z1liZ
	c0qic/y1pOktEQ7LdYFhq8vHTBU/rZI0nEkaP3sV3+Iqua+h/gfUno3Uon/f7POu
	4Lzu4yHIEbXfFqdFi9S97Azh0EJz+VaWqSqs+l/EntBD5JI31iYvMZLG0OgXgLl8
	OMjH/z1499NTx8boAEazupzZC32BpCfvjFAebiidqD5GWGE6KgjdG70QxOb3+dDC
	d1t/vcaQk/wKdwJwpaFaOCiGJaPe0gHd6gUThR4FdvVpd/7rYzCXb32AbK9Q3a2H
	FvXv9PVyVG2723Voai2BE2k8XPh2HZe3pCPQlB3keA==
X-ME-Sender: <xms:o2b1ZvW8zgvQml1ztc_coejx3xlTwUcJWx_c7eOIDGy3kDpuLeAFKQ>
    <xme:o2b1ZnmunLTLTyD5bzgIt9LCIGvgBrY3lmAbbrUN_qDc2ssE1AdmtzvtQOwcMj92p
    rf92crFib62lSRlSA>
X-ME-Received: <xmr:o2b1ZrZXY2iEc9STGNpIOS2uYfgEu1NRQY5ebsRlt6SD_hpLpRts_NeLJ7ypWAx_LXQelmO9CA89SHRgtEwJxoih3NGrPH6np_6Jzopyk2Uyjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:o2b1ZqVIxafb4MWM_Rt9fs-MNaa_TwRmbuhS82lmiw2RNRyk1SaDdw>
    <xmx:o2b1Zpnwo_gVc5PDOBl8YxE2cRb0IoEIuX0hXTvjajNG6KxNPK5RZg>
    <xmx:o2b1ZneD6SOnmrQ_HOw2Jdr8443oz6xPCuIm2OmEy1e3YeEaY2QFpw>
    <xmx:o2b1ZjF12-xyTpi-HK6twa0aD1fLHddP5GQCL8imf-ZulV5hII5s7A>
    <xmx:o2b1ZuwXeWnSHAVU-1K2F7mjOPMmlFPwLpT7Ws1oTwZmIpOVDFeKMTvR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e52e24cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:49 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/28] http-push: free repo->url string
Message-ID: <ZvVmoARjOAiAqiIz@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220446.GT1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924220446.GT1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 06:04:46PM -0400, Jeff King wrote:
> Our repo->url string comes from str_end_url_with_slash(), which always
> allocates its output buffer. We should free it before exiting to avoid
> triggering the leak-checker.
> 
> This can be seen by leak-checking t5540.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http-push.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/http-push.c b/http-push.c
> index f60b2ceba5..52c53928a9 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1972,6 +1972,7 @@ int cmd_main(int argc, const char **argv)
>   cleanup:
>  	if (info_ref_lock)
>  		unlock_remote(info_ref_lock);
> +	free(repo->url);
>  	free(repo);
>  
>  	http_cleanup();

I was wondering whether we also need to free `repo->path`, which is a
`char *` as well. But that is only being assigned pointers into command
line argument strings, and thus we do not have to free it.

Patrick
