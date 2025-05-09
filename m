Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DE22D9EF
	for <git@vger.kernel.org>; Fri,  9 May 2025 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779809; cv=none; b=PudSRMMvhw06N3Gmiv8fdFb624V8bo+P4VoGoHIhES/cdAz0ZOTnAjhgB3jmgfEE1k4y4dt+L4B/MOHf0R7O0NQDp8WDt7y1lVat9FpLxgyxh2G8UO08IKV+YEBTEDeBQqQCFRQjGCI4a+PQNaRRAOpIV7EIJ4Q9xW5sNtgknvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779809; c=relaxed/simple;
	bh=NLrgRXOVBqY1yfjpBJlyfQwuOKiDXWvOWybmXI8eOsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFWdwMYUZ37KSf2ECTG/NCSKogwBzyXd2aRXVSCbBiPvDg/1DWyivOS7S5F/O71yOFL5VT8Y0c5eAINo+4BhLXKR03u++Ew8DB5R4Ri1vibMHwumPQjBHtkaG5Z1QwuZW+AQX6XonwQOZ2gBzgeDG/asZMaa1S3VZl8WF0YphtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tsZOUYym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTQ5E7+z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tsZOUYym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTQ5E7+z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1879114017C;
	Fri,  9 May 2025 04:36:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 04:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746779805; x=1746866205; bh=5Gn1daxIds
	o3vuo/i4ZoyaTeGYDXEA61ipE5ezz4pno=; b=tsZOUYymLlmRMpmqsFpR22rBTK
	6C84dN14yEFCv/OFG0SCO0af8lWmlswORKiQq5I+5jV7tqynclJSH2jvUhbvHS/m
	FSzItP8LHoUsiOnoRaeWDRNlFerlFhhueOwhxNUDPczC5PARvsRenQNZR5im09RS
	boHpo6nDLY3l7nn9NekQsUDvm0JsPyklbxV59TlyTXBPwR9k3x8cnehN4XGuz21F
	0RZI5z8cLO0WBMfwMl1dkfQZzeGdpAdrufHQQEzlxj09OUP5cmucgd4lxtzs3Krw
	AEt+kG+QLWvbt0NA1sduyEJlgxAzudYGyPnHom4nr9SERYi+FLeGJX0DrmjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746779805; x=1746866205; bh=5Gn1daxIdso3vuo/i4ZoyaTeGYDXEA61ipE
	5ezz4pno=; b=lTQ5E7+zCzXXtkNTl+eq/TxJyPZ+B2cJGYcudUDqAsnfLfIve1t
	ARNOR6vMB15B4Dgpp4QujXMis1Y2RInkpjajwV2HJ3YtMgwBumXqBVIW4DLzTBlL
	Nb9YcobmwLlGdyO+bIWbbOj3MORS5N/QOyHpMjbFOdnlDgsbcRaAfSyt2cIAX2tr
	+v16NV3/GXrTOBb9zIr8YRBbpreNxgBJk0P2pjM3tgNKfVfKd6L5vkOpgrfirrYd
	aa3di3w2N0D405D79ytGbJhpEeXoxj5OTTvuAIn/9nYKrCjSsDWRiTIOkAoLzbxn
	0Wx495pKUn9lsRQKsN4zIBwo+IoVZ5FmvjA==
X-ME-Sender: <xms:nb4daKF9Hnap3sY1F0e9Ih-fw-0rA7FzD_n3THMRnZoe3zW9DW3C5g>
    <xme:nb4daLU_PGZENEj7RP0pm9uTAwMBzFOURnUbdyU4QVIzygmM4Tyce4zT-QRRmv2RP
    PEn0mu5vtzPykMbng>
X-ME-Received: <xmr:nb4daEIWIFF0bxpzMLeJ2l799ptydaFNzIX4Tsy4PBlR0W0-1OZP8LHT_nKjgDaW8NIUkNY2Hy8Uw0eRd1RHT_cocGgDmsduWOjNfRBqaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudegtdejffduffeggeevudejgeeuveeiuefggeff
    geetvdehieelfedvueejffehnecuffhomhgrihhnpehophgvnhgsshgurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgrugestgho
    mhhsthihlhgvrdgtohhm
X-ME-Proxy: <xmx:nb4daEEyZGQnanPQFMM4fuhjFT7J4WyLuBHmoWiNmoMi31wlwRb3ww>
    <xmx:nb4daAWQ_7Hqb0pwOpWcV4KH_4gDfP8fWamcucSn22gO-pDr-oHwWQ>
    <xmx:nb4daHNstwC8TnFgIHUIYU7AGiKRIcuMVz4dWsY2pYygY0fmOTg_1Q>
    <xmx:nb4daH0QKkD9G0cQj8CvuI3ENOGmd5JjJSjLlv4QycTbGZVia_42-Q>
    <xmx:nb4daGH8L8viLI-sXiS-BomwoXgxSd8zHfcuBV28k5JA8tkWePxiXcfD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 04:36:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc631863 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 08:36:43 +0000 (UTC)
Date: Fri, 9 May 2025 10:36:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] thread-utils.c: detect online CPU count on OpenBSD /
 NetBSD
Message-ID: <aB2-lwKPOnj3EH0b@pks.im>
References: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>

On Fri, May 09, 2025 at 02:13:13AM -0400, Brad Smith wrote:
> OpenBSD / NetBSD use HW_NCPUONLINE to detect the online CPU
> count. OpenBSD ships with SMT disabled on X86 systems so
> HW_NCPU would provide double the number of CPUs as opposed
> to the proper online count.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  thread-utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/thread-utils.c b/thread-utils.c
> index 1f89ffab4c..374890e6b0 100644
> --- a/thread-utils.c
> +++ b/thread-utils.c
> @@ -46,11 +46,11 @@ int online_cpus(void)
>  	mib[0] = CTL_HW;
>  #  ifdef HW_AVAILCPU
>  	mib[1] = HW_AVAILCPU;
> -	len = sizeof(cpucount);
> -	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
> -		return cpucount;
> -#  endif /* HW_AVAILCPU */
> +#  elif defined(HW_NCPUONLINE)
> +	mib[1] = HW_NCPUONLINE;
> +#  else
>  	mib[1] = HW_NCPU;
> +#  endif /* HW_AVAILCPU */
>  	len = sizeof(cpucount);
>  	if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))
>  		return cpucount;

This change looks sensible to me and matches the documentation at [1].
Using the number of online CPUs instead of existing CPUs certainly
matches the expectation of what this function should reutrn.

Thanks!

Patrick

[1]: https://man.openbsd.org/sysctl.2#HW_NCPUONLINE~2
