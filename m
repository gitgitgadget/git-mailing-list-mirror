Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBE2C9D
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514752; cv=none; b=p/nbYr3g8lMuqt1vjx26bWUE9xLvhrk+JXU0/SNgOqn3yVlHDf6RJvNH9mtHEv/OwLxSyoGrSXRlYxKTmpcazz89yueZa8EE7/zjLU9SSIkF3Y1YFErWs0lzS/5EsdA8543MbeA5It75ZeEgaqcMABaGhZlicmcby8h4qey8UZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514752; c=relaxed/simple;
	bh=HHW0gkDggvasOhe6OTwqUC9svbUbjJzu1qMOgPJgVsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFpzksPhba6R17KNBHveErSaSvx6YitaL+wIdR4q1zP2dKjnay1GRQQnJGZNhl2ZMKXqIvLJQxgEGUd8alJApEPgZ7GhPn1e+az8TlTDhVO72/tKKzuu9Qq44THhPVnoWBLkjMc2IFilG4iqOI16HFG/c8pSzUqPTAgsU9jVMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jIAr7U98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1Y4Hham; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jIAr7U98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1Y4Hham"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D1A53EC0485;
	Fri,  7 Nov 2025 06:25:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Nov 2025 06:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762514748; x=1762601148; bh=v+EpzLDo2M
	IcRKJ/JjKLitZI6K5vHHAx0lgrMgudq2E=; b=jIAr7U98c2PkX/kA2Q2g7YhfYT
	rfZzcTmq9nWzUOUItoZefDi87vcf5Xyan3SCr8sZlzXXxvVmrnUtJJDMO+uRW2f4
	p3QgGzpfIErCY/7IZ6aSaGH1v2R3FNL2l3beIWPwc0NL+IS2lwyZR3YwxHWx6ly+
	bSyRmhwF9tZdRP9QBaWrCoUVuoEDGykWQLx93WFDlC2aiiS4/EOfeIsYETArDsNH
	TPYPVvRnEk2DXa9cU6hQlLPVCNahhdif3yeCMGj+cc0RP22zzpMSNBjjPnd+As4C
	Ddi467dafsC8acnFLPjMu9tDp4wEyV9eJVnDRRXuMu02QNSeIJSyzhXU2ouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762514748; x=1762601148; bh=v+EpzLDo2MIcRKJ/JjKLitZI6K5vHHAx0lg
	rMgudq2E=; b=m1Y4Hham+MZHfdT04Cr6W6Laq+RgSYDcR527wd6lookQBzVUOO+
	IQ1YHBAMhK2azFNlxIyykL5Umi2xmbhu3eEkUSBtr1m0dOzSHWc6kvEeJCZeL+2k
	sksXm3ru391B2dQNhObKU4gFs35hXHtI8KJ3pogvu5mmA9KviCuQ8HiuKXXVj9Gl
	XGzMD2n+rjzdF0LOcRjKzNvmFvs1MA6WHDt5EPCKt/femFH8jI59dDpWGc42xdiP
	Pr2QY6rPjl34/YXirUCNBFm3MNNIxPIFbK1GIROeNAbZg+uOhtW7YgZnN9DKZM4R
	kosO+CZLJqhY93HMTzSJFZilxyUI/aNjRMw==
X-ME-Sender: <xms:PNcNaX3e8Vl7EvxAn5RRaRCq1HCQ7olRm8larzj-g1MNa-NCenkTQw>
    <xme:PNcNadgA7swbCYbO5ZWRT0e-kehWa32Drs2mvA-cyLkHiFNbkpNuo20k6kfi1Otq-
    Vbt4MZ1JxaW-TVpUXxASwVzbYWQZ6OQ-GpBcCpMw3F1B0ylH4tEXw>
X-ME-Received: <xmr:PNcNaVR0tmFCi0PZgVJtPeO9U-zHhVaEXWH6e4dfbsbmjznz1iLEAu7gWsEzQkjJsQ-NgDl9CSFgPnnlWfG1fNvIVL_34aRLCalwZ7kmuKXaQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghlnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:PNcNaWiDbYXIa0oUYEgcQJDH-Sgw0bqo6-GIKVvzdnso-pJoXwXcpQ>
    <xmx:PNcNad7e8fGe_ftb-xQTnPMkw7zhgVpRoko2FtDU5agDr0oBZiDchw>
    <xmx:PNcNabDZcFW3Uukl0-xvzidp4jRHEWGALYPLuFaLyTq_FODLk4Gh5A>
    <xmx:PNcNacbZs4BNspsEEjLFjUheE3U_aid33NSDjtpQl8Pog70-Z5ZuOA>
    <xmx:PNcNaRgpfJwPiaqpjVR3r12_ujnr9mUrmkY2Gcpdh3vv79O2cRTRR3er>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 06:25:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bbc9822 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 11:25:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 12:25:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: ps/rust-cbindgen (was: What's cooking in git.git (Nov 2025, #02;
 Thu, 6))
Message-ID: <aQ3XOTX0AT_eFc5P@pks.im>
References: <xmqqms4zhxp4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms4zhxp4.fsf@gitster.g>

On Thu, Nov 06, 2025 at 09:34:31AM -0800, Junio C Hamano wrote:
> * ps/rust-cbindgen (2025-10-24) 6 commits
>  . rust: generate bindings via cbindgen
>  . meson: rename Rust library target
>  . ci: use Debian instead of deprecated i386/ubuntu
>  . gitlab-ci: backfill missing Linux jobs
>  . gitlab-ci: reorder Linux job matrix to match GitHub's order
>  . Merge branch 'ps/ci-rust' into ps/rust-cbindgen
> 
>  Introduce cbindgen in the build framework to help interfacing with
>  Rust.
> 
>  More discussion?
>  cf. <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
>  source: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>

I've just chatted with Ezekiel about this and we agreed to let him drive
the topic. Please discard it from the tree for now. Thanks!

Patrick
