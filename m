Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A581B4F02
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385812; cv=none; b=ngRo2kO6sj8xu9TAQW25uWayO5z6lD5X9hN6e8D98oM7bysHP4dLhgkc+iypYBsTPNORFc/FmC/DMIHiO1hBoIj08M0SrRwqyoxMR//jVS9eAtzcJSGLCfM1TMew6e2exhPvQA4wb9fVOAmR2DADGXmGkGoRngllx4fTtMZlHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385812; c=relaxed/simple;
	bh=jf4S0TkRkX8A2KcR5ihi/ZrEg9uE8WTIeRSNkCBAii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FflXpC4ksG+vBSspNKqMIb0N6svNPs5KiY47Q7GYjb2eDjfkC+MHwWH5T5pyIJQrD8HkommtFmFgS9Z2PRh6rWlqyCy1GzljMk2BDrVfsEsCBCcX0Nm1rWWRN4jOJQ2l1t3lZRo+neQ3/14tN6dd85v4Fr5jxdURoSPyTw848IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=je2dFx/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oR08eJei; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="je2dFx/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oR08eJei"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED6F51140241;
	Mon, 20 Jan 2025 10:10:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 10:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737385808; x=1737472208; bh=Nw4mOSwoId
	k20Rs6KmeumimrXMVu/kg6MoeY7/gEHTg=; b=je2dFx/oNyZ5EkJghNGZsHMvrW
	+qMOQeJj3XZJWd699nzr3hcN4dUVUX7ET7qTm22tmx6QE0nFnx5GXecmAsibfmng
	R+fr2lLquF++GNGRD9j/PW7FhbcMc563d4xnydsKV8R6dUKGb45L3adOHqcSm46Z
	zUF4kxlRw7MrcKAbwfWGpuFU6S0+WEA+etibppHX9aRLP9TshZB79+ULVrxKIR4e
	h/IFND4rNCNmzIuMWH7Uu8oDIQHysqbmQS+gpr6jEo0coyxmFlr8WL1TNnFhySlV
	ixGTkzMo+X+OsKnEH/0nCMFnUsK2i7fj+RIZSfzvgQOE1GiX9dqyX3ZUiExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737385808; x=1737472208; bh=Nw4mOSwoIdk20Rs6KmeumimrXMVu/kg6Moe
	Y7/gEHTg=; b=oR08eJeiRVQ9jAgoLKV6FgUS99Qbx35h0+Ztm1xgzqfTomdHolu
	3uS1SwWsihDG/CiRc4QUpabbEnwqAdgNS8cpPqbjpJgcm6eEVtFQY0dsyz7vYe+y
	myk/u2iYGiFrCvDfiwzCqSFDPXKqMG5xKzzWxlfTUyTPyhF4CFJSq9mNY/SyHSmI
	0v7LJSlee/G+JyJs7czStVRj+aLHdVo/nU8mEGFsDf4DCkV3OoKRCWGyjJw4O8EG
	8QIpUM15pVIvotlHJRL5By/5KiKags8vF0+EUG+NgHGn5WDOaakwppM2UZqdgUTR
	vfPgwjmK/GhC5l0d2tWbyQFy0rET451YUIA==
X-ME-Sender: <xms:UGeOZ0qWX9dxW0mrTb7utBm1jT-X53sD5wOjx8yDGTseZmzxUFheew>
    <xme:UGeOZ6qV55RBsCVojcMqdjyFNSnB5fT4FKNQUDEM5XJtsGbgzHZB0EZX1FYsJ3kuJ
    sW2yvkiKLzp3sKtbA>
X-ME-Received: <xmr:UGeOZ5PNKdMXtIZNK10IBWUr_r9eITKdQEnuslCF474HpqVRxVRCP9Um-3UXpylXW93ex3TIf9Zc7lpokBm1VZ4zxeEyWXUVrdy7RJ3CX0phWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UGeOZ74F5rnQtoE_vkYOerwnjBwUBspc2ikJonWuG5OxO3pDEhlTXQ>
    <xmx:UGeOZz7qhBumKyjevfajzeng25TzUORkGFi_nd2v5fCqZjqAdRBR2A>
    <xmx:UGeOZ7gMGljACVJfs6D89dd1BzTwPWThpKQdmyVKHqePQ_gI-_5mLg>
    <xmx:UGeOZ95LwqbrycmIg_kSqMQhhPf_4JYxvd6B5NHljpVpct0jlpuqjA>
    <xmx:UGeOZzHBXzPUHB5oRcgFIsrbHooUi1cVQSkbSZ4cF7LToLLTQVhlsCDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 10:10:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23767b45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 15:10:07 +0000 (UTC)
Date: Mon, 20 Jan 2025 16:10:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix -Wsign-compare warnings
Message-ID: <Z45nTojf3D6hDdMk@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
 <CAOLa=ZQXF8ewDVmusbXPSCPPp9qqj2JRTvZeiiDZRckG5BpV6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQXF8ewDVmusbXPSCPPp9qqj2JRTvZeiiDZRckG5BpV6g@mail.gmail.com>

On Mon, Jan 20, 2025 at 05:07:23AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > during the last steps of converting the reftable codebase to become a
> > standalone library I noticed that the new -Wsign-compare warnings
> > created a bit of a problem due to the `DISABLE_SIGN_COMPARE_WARNINGS`
> > macro that we started using. As a consequence I wasn't able to easily
> > drop "git-compat-util.h" anymore. This patch series is thus addresses
> > the issue by fixing all sign comparison warnings in the reftable
> > library.
> >
> > Thanks!
> >
> 
> Most of the patches were straightforward and look good. I left only nits
> on one commit, which doesn't warrant a re-roll.

Thanks for your review! I'll send v2 in a bit.

Patrick
