Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6828FC
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358618; cv=none; b=tKgIuqRpmaktOAL0uisY143YSV+Fsz+SLHDLxqnCJmXlOgku8jEVv4CYkTMKz9kNrkG8/FJjW9OGzOlD8vJPLQAEGD+BjlD21uZQGHCxnx8eStYtVsNWq18qIN7KBgkSvyQspbJDmKUJHu7uEgqx2/rz4w0En+2WCz/zWMnheeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358618; c=relaxed/simple;
	bh=RrK6GZjGeb4PJfg7TmLQDI2EKJ14+gE/VTrPCXkmrqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSVL8OxXxLRBJwIYRvUEVlpyfNs3Q14OAHOgDBHHhDAVnHpU0Ebk0XDVAChFUj6P2A9ktUSbTZMlG0s351klxTAF0Uqch/H4rzv1IVZ1Fpj/anZ8t5tt0l0DmNBqAcpexAT5PrL6cfDVk5cu5hFkMqiUYGmLzen7hd7/49bh5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CbrRnxL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIKXDNfH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CbrRnxL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIKXDNfH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98AD61140203;
	Thu, 26 Sep 2024 09:50:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358615; x=1727445015; bh=0gi8H1NmD1
	9kB023bSN2Q+Z1OEdmEHQURnQAWRq0jMI=; b=CbrRnxL3ohKWz/JE81Tdmw1Qsy
	kiSm1sSJEbMcQNMIbhNaQ61BRWfU12vFsm7/OB+I7yFkH8ui/PYSErKhxbmK/uDr
	lARWMz0Oh/nDB3dgQt1oKXrxfr3dJ3OIvcUCfFppwmSR04DpGw3NWci4/QZLjY30
	cS3bl6mRIWuDUv+XUDgm4mkTj0hVjgHSjskfXFGMedSiAxyKpIDPRI65JypvpkJI
	1kpUFJxM+CJQEQc7WBzcG+RSrORDCwnXfpbgd4i6klSEKV5VHYlqmc30O4zJ0TaY
	E9F1582NR6xBkgb023Pw2UULpLQlFowFl5S0OuT/Ik9irepKlAEpzj9BYWPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358615; x=1727445015; bh=0gi8H1NmD19kB023bSN2Q+Z1OEdm
	EHQURnQAWRq0jMI=; b=JIKXDNfHYjBeC1LKl8Z5tg/Rf0KwdRRwEw1OQg3BIuP3
	jP0Z712wZiTcv26adDXFdMfOyICPuYJBg4jykb5mfn6iUB4vjcVuiOloQ+gfNCI8
	F2h43CBV9aZbjQhnIb1qyAOi3Mt/j37JV5M/W3pISy/XXIgukBHSz0Orbib/f9Iv
	g1nDNxya4OPnI2O07oGqwnqvz0qbTtK9bRqJ2MEZVLX8kbG3b9IwsrcZFZx3EkVI
	TXHcl7XfGGnVpblz0ktgr7c4C33YXI1HueS9M+efndXd4UKOwP1KH+G054sJWiay
	ZtlcFwDrRvcOCodk6Hoc5/pBMsl0ZkhPWDJ2CZxB3g==
X-ME-Sender: <xms:l2b1ZhFNYNWtu4ow1GdKBwly3wuXPQYd5rnx1MLSks_0jkvgTGYRqQ>
    <xme:l2b1ZmUy4HBJkQG6k5c0L8oQQLhoGE2LiRF5QHWo5OyKu8zd1klmLFPs5SIWMZ9Md
    4Wuz97ehrzdeaywqw>
X-ME-Received: <xmr:l2b1ZjKLOH9s_fdFxTEdDY3S9AfUSo7407KYkrhNYrzka-CK4U2GKrQZHiwHCdex-6U84Jsb4Ax-mawXbeu0TLHsbIicOFTD0lkQUwbvnuwfcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l2b1ZnGcHevlr4mZ9tMr0aR_ohh6ygisiun70TZaDLUhPfQEkPcZWA>
    <xmx:l2b1ZnXmmCgkYwc0qAfrpsJeaU5PKsylCL-_JcuKPUksb0v6EOvK1w>
    <xmx:l2b1ZiPa6RJ1NNu62JDmiZTfMjWhEjnhj0I96KNX5ye69p_KUGB05Q>
    <xmx:l2b1Zm3kbgxf-FJm1mOG5SKywXzYt-MKP0migOkR0qokLKxwZVJzJg>
    <xmx:l2b1ZkhtjOlK4BMgol9x7cbX6cJmnrD0Rmq-FOKoZsSuFOn-IWFK_dqn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7fc71184 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:36 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/28] send-pack: free cas options before exit
Message-ID: <ZvVmkXDIyCqpYKZm@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215539.GH1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215539.GH1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:55:39PM -0400, Jeff King wrote:
> diff --git a/remote.c b/remote.c
> index 390a03c264..e291e8ff5c 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2544,7 +2544,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
>  /*
>   * Compare-and-swap
>   */
> -static void clear_cas_option(struct push_cas_option *cas)
> +void clear_cas_option(struct push_cas_option *cas)
>  {
>  	int i;
>  
> diff --git a/remote.h b/remote.h
> index a58713f20a..ad4513f639 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -409,6 +409,7 @@ struct push_cas_option {
>  };
>  
>  int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
> +void clear_cas_option(struct push_cas_option *);

Nit: I was wondering whether we'd also want to fix up this functions
name to conform to our style guide, which says this should be called
`push_cas_option_clear()` instead. But I don't mind it much, so please
feel free to ignore this nit.

Patrick
