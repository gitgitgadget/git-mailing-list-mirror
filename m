Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DE1EB1B2
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454623; cv=none; b=U6VQghm9o+fUNtkkjPziXogD7dFVyTV5freAr/qGyuEy9KZ95PfNFCxArscashnfEmOGi5+XOFEdNFULAfYvilMYafMBsrZoIUjbNKRgKylgY7LwNkhFTaXL3EoZWhIHn2VMZ1SLS+CmBn1Elv4N96oAOJbTgbgjS/n/358/nuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454623; c=relaxed/simple;
	bh=+cZMVTKDMNNv13jiBvD/eg+Fa0URq7LtXqEYn0srB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na9QzFTIlimwuCPuB7oghi1HyOxRA5/+Mrl3aclDjXGCWmjKtx21X5WWSbugCvB79WMbJI4BVXepV2hOYuhOftmOjuL3XLIXPG8IPqwjVkaknGslBgn6BaiVuVt8UiEpUUULzNOHecAeeS0/cZ9aR8lQezA0p7kEZe3vADPbt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EH6d7vtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTiHUDj6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EH6d7vtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTiHUDj6"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 810DC25401C4;
	Thu, 20 Mar 2025 03:10:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 03:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742454619; x=1742541019; bh=EyGaQJrtpV
	nhidg3Ch/uRhQC0BxuFvhRHlQ817+NhD8=; b=EH6d7vtmMdRjDjpYcZRL62CvN5
	/pXMhpquZsOv80szK72ynXiNfkFjZEw58ZUc9rQqSugpiUa9q0yvUmMZ0l3148TB
	DEyEzhjaKYzjZpxNynri32f3nihS8FCk2SQGjymLH5jyEeF4WjXxd57nkQKUPDE4
	Xy0W5TR90620iE4yI9SevAQBA+a2BFinMxM4maOEXvAu4B0DytrJ+AOMOzCk9yzZ
	4QkNeWa2Y3iI5/2150mpiL2RbkgBEhzzy7b5ZOYxZzKiQSp8BmJLvWkqKAsi2cpW
	+i31ABKLWDjyDRNIdm/RymJlZy78d3i5pLcMOFLwRnxM7ZcVv89nUu8NP4Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742454619; x=1742541019; bh=EyGaQJrtpVnhidg3Ch/uRhQC0BxuFvhRHlQ
	817+NhD8=; b=BTiHUDj6fjlooPeACSYTiXdaNIalvOjWUH0fnbxwC8HOMNEXSQv
	+MqC036z4GnO/Blej4wBw5ogtDqwD6BvKJPu48PKfnUJtjg+ZWX5ynyZ7Cf25MXC
	3hiKLyRGaMQ7snDFAgDnd3ztctCzbWSH1kXDxtIFu4QY6WRZ+3FQJIqQ5GwxbiTb
	pBmLU1bbFsZ3l9LwmxdT3pceDF3lZZmKuCwug8VnYhd7Q6+N/AZrIWDC4nWP5qAW
	MkVmfhn5Gtx2TnUsRtj9bWsyxJPmbyChyLvWxzxch1F6q9Usmyq0az/9E/dFXY0i
	1QqCTERxMZDt80CQZLoL3OLOhUZKflQq14g==
X-ME-Sender: <xms:W7_bZzgmWl3_h_bKa0n_oNNrAZn2dKwqW42BiB3b1kbegRYUUBYhsg>
    <xme:W7_bZwCyTtENCoYWfH95cYXpyiNL4W9VbUQJy6ZRUcfye2Vgazk31jhOhcJY9TO5E
    pHxrqV0a9DYAPaPDg>
X-ME-Received: <xmr:W7_bZzEizuEuSTGynXsQvWin2DXgYLiCu8gCNdaz6_BJdBdbfrVIVmYZgkTxf0LdWAquFiIYwvZZ9JNe254iNppmLUQE41GSoO8wS9PL-c4NtCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:W7_bZwQBjJ9LomJ3eq2y8VlXHeAPldZ6f895ClXHYoC3SkL-UlKJRg>
    <xmx:W7_bZwzLeVtYNFjJ8LWZ3_elaB-YRh_rrDM7eCsxhXCQKIaiN6v6qQ>
    <xmx:W7_bZ27YPnc1gXGOK83bd9V1PqfSgBvb-qKjN_EpszgiGjArmPwkGg>
    <xmx:W7_bZ1yMOphQTZYR0uB52ZVRFseCJdE934efeV4Qq3MD0QipOhauww>
    <xmx:W7_bZ6vK9r5FLe1bU1sGIJ5s_txUzr3Y5jc-2wgJebGs-5Ck5URbdkVC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 03:10:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62f0e2b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 07:10:15 +0000 (UTC)
Date: Thu, 20 Mar 2025 08:10:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH] ci/github: add missing 'CI_JOB_IMAGE' env variable
Message-ID: <Z9u_UlxCDPFlOubZ@pks.im>
References: <Z9qNNq0p10YJCZYo@pks.im>
 <20250319163328.525284-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319163328.525284-1-karthik.188@gmail.com>

On Wed, Mar 19, 2025 at 05:33:28PM +0100, Karthik Nayak wrote:
> The CI setups of GitLab and GitHub use a common dependency management
> script 'ci/install-dependencies.sh'. The script install the necessary
> packages based on a combination of the "$distro" and "$jobname" env
> variables.
> 
> The "$distro" variable is derived from the "CI_JOB_IMAGE" env variable
> set by the CI configs. In the GitHub CI config, some of the jobs are
> missing this variable. For the 'Documentation' job which depends on
> 'meson' being installed, this raises an error since the 'meson'
> dependency is never installed.
> 
> Fix this by adding the 'CI_JOB_IMAGE' variable to all missing jobs. We
> don't add it the windows jobs, since they manager their dependency as
> part of the CI config and no further dependency management is needed.

Makes sense. We didn't install Meson beforehand because we accidentally
didn't install any of the base dependencies. This is fixed by setting
the expected environment variable, and that already pulls in Meson for
us.

I think this fix is preferable over Junio's fix that manually installs
Meson as it fixes the root cause and because it's more robust going
forward in case we ever happen to pull in any additional dependencies.

Thanks!

Patrick
