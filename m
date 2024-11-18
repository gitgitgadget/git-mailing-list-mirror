Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650C1E49B
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935282; cv=none; b=L1RQZmi8m6HuD1hZLz7NM7CTK7UmbsN6t6sB3WiLM9vbSvCgZBab0y+/IMt/nBB2NUyVKqjC2/vXbnQ//1rOwEub4xPp4E0w0K1dFYa65u8lKFIoP0Q4+2Xr4ha/rH/Ml+Eh/mUocLALj200oV2ZH2tFBJ2JHRifsYlapIeYNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935282; c=relaxed/simple;
	bh=9zVD9WMX7/OORBgh0v/0BqaWKOmXYcjOYv2Yyw4OMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FofnXuV67T7wTjnVMN4+KU8D/gZfJprad98Dv+vVAOBKHgKKJCsXrlAstDrBr7WhknMbJqAbEgPI7I9ancX/UchBlQ6wVfWb+vlo17CQI7vwjfU2q62KSFJVXFKI8wGa2k9M9lbZfMQhtWoCLlb/YMhaWcglmPfJR337tZ5CLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wim4v/CA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVCQytq/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wim4v/CA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVCQytq/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F2F071380687;
	Mon, 18 Nov 2024 08:07:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 08:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731935279; x=1732021679; bh=LorefhhcE1
	N7eWNSFMHdMgU0VLe8Da1fTP/6PQIZjNU=; b=Wim4v/CAlh4fj8iC1nYo85Sbui
	D0mrBuxZwTXSdXQHMtTRwZfS6Cp7aX8htrv52EdVhlcezzhfG0oX+MdW58REknhh
	jAYSo4Vlu/QRuuNkuCGIPVOvYKh+UCnU730k4fvjJXFUiHTuUhqHhd+I0IZtMARh
	Tl+bxtDapZIrNBs5Cvv+x58Gm33IXghzjEJMYqMwtIlV1idm4TNm679ibsZ5VQXj
	2TTAL5ou/hQ80VfYhqA+5FyeRxwXsgzSRbjYwL2EapWOyWA+11PXK9LEVeU45srw
	pz7SjmRXHrbfKhYdb5LcYvq+8/jTb1iS+qx+Dyt0563nJE2DpiOmxOo0RVbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731935279; x=1732021679; bh=LorefhhcE1N7eWNSFMHdMgU0VLe8Da1fTP/
	6PQIZjNU=; b=cVCQytq/nNn8LWVhZcRO7yEyYa3UO2xqUZQFOkNUxBo4jUSLIao
	iXr7J+DbDRvT2JBfK/ULQt8hFPuzyMmZ06mF7fSQPDjsFWQ6A0WOIgX1tMHQEtAg
	67JjFZrn1bw/VZDVoLnyILZe/r/4LhxIGOsLm7FfKpePkJBbB4m1c0Zi/Ikv7MR2
	ly6zFaVxHZFgTctX0Mylo8rXyKnarTpI7KYZvwNIpvHPNt9uu+7OP3R+MmsdoWPY
	9/T51qeJ53tG/Ss+e3TS8qD5ESpvArkMS64BcBkLL3TGK7WLYW1LYtfYTXlZ84E6
	7STJkufEPWEYqLotPHzO9D6843ilyqYAM0g==
X-ME-Sender: <xms:Lzw7Z7VMs0GKy8dTugRHyvBHydxjOuRRd66hQafNX4ZDIMkP04Oqwg>
    <xme:Lzw7ZzljFAWZumDFlA9JGXTFHZPRNiBzKcnPKvnvPMRO5ELobxe93KOZj_lldIbRf
    GA3vyET3klhnHCsbQ>
X-ME-Received: <xmr:Lzw7Z3bNv1hePktb4A7ptG7Dgqoc8Mv91uT25Uzo6pBMO1t4K0GGuSARGcBvodK7htbfz89_wxx179vy_-SMaYj7eci23nRTeOhtytmLQEk97qUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Lzw7Z2Xr7R0-iE0UkFpbPPWa2DePe68-_hUeAdErWwpaF5tFaTkoDA>
    <xmx:Lzw7Z1m8KVMSvnaMZgmufiKOS_K3xryQ20zAz8piNCR84SHh1iiuxQ>
    <xmx:Lzw7ZzfE7ziQ4UIOuAQYDZLQg2wWzdY1TKtzgGMwREFSz5s_11ZHIQ>
    <xmx:Lzw7Z_GGsa-weHO88HQuRb67SrlDsOCYlsbnQJLIBy8tywFz0cyI4g>
    <xmx:Lzw7Z6ybBOFkIwHIt6K0SsfcL-gPQemM65q0UsAxZgCmjARCXxajTPF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 08:07:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cd2f946 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 13:07:10 +0000 (UTC)
Date: Mon, 18 Nov 2024 14:07:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
Message-ID: <Zzs8JJO_HCLrEBM0@pks.im>
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
 <4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
 <xmqq34js1kd2.fsf@gitster.g>
 <Zzr4cgk_5MJNcHm1@pks.im>
 <xmqqjzd0k92c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzd0k92c.fsf@gitster.g>

On Mon, Nov 18, 2024 at 09:42:03PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >     ps/upgrade-clar
> >     wm/shortlog-hash
> 
> Unfortuately, these were both based not on 'maint' but on 'master',
> and cannot ever be merged down to 'maint'.  The last topic may
> deserve to be cherry-picked to 'maint' when the time comes.

We got several reports about build failures with clar on esoteric
platforms, and ps/upgrade-clar fixes those. Distro maintainers can of
course cherry-pick those patches, but I think it would make sense to
pull them into a maintenance release.

I am happy to  provide a backport for ps/upgrade-clar if you agree with
me.

Patrick
