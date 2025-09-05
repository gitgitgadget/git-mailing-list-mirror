Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD528641E
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092218; cv=none; b=DmZmBhJaeWegUdfmfH21+St0XqCPNQglfvEuVSCy2CmjLs1VU6ybHR+1D9qWmDZ562qk8VuKIAC558dBKTMpMYVvEame+0PHE7DaVL7ZP/BofCtKPteeUEPpYdw+lEeTppyxQovFlfKHdahusXe5LyPTLPIBMkxYTI3rj5mU2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092218; c=relaxed/simple;
	bh=ng6DCjii0k+VyGQ96ER8Rt3FnYGfp9kr5HS3QXSpH2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXJIJV//ULWBZc+hmCMZm42cryoJkMgz5PMrWnjrRas2ONENqOl7mOSlZyH99VYY4exT9i1hXkYi7odFjNDtKYXhRGLYsrRU2og8KFWF2OzMlgFOYstDb1BYVRqh73r+pKQRYjllcxjLQRAC6QlYloip+WmThFzy+9B62ZFT0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zArOsDJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuVeMtOQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zArOsDJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuVeMtOQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 32425EC04D4;
	Fri,  5 Sep 2025 13:10:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 13:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757092215; x=1757178615; bh=PI/WFAl+aW
	9EFWV8OulzIOUi+0/AdIrrF7KunlSWIu8=; b=zArOsDJXy1Tnclsng0fZRUtpbe
	en6HqOsYEOKaeRCnPYhwk9qfK1oeDOqc6cWDx2QWYOD2zowloAJZPIrjpsVonG6G
	FR0rqdQEJYEbUVK4IHjo4ey6yUojyEmSkP6e8qqnWQIeA3kI0rMMotD1nbJAQ5YQ
	1FNgmXVkEGCR7UaRW/4SRG4sc3QWDUVXyt1G13UODip/YvMNH+11mlHEAL8Ygebd
	OgSiZKmdBfyDP3hDKG9M4QiHBt9iW/gOk6Mqs9c412PTLakt0re1b4UmS3md7fvr
	KVKKC8JzQCGbXTI4dkYP4QT9F+jug9EHXMW+ooOMcYeH5dreXcjo1jc5vSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757092215; x=1757178615; bh=PI/WFAl+aW9EFWV8OulzIOUi+0/AdIrrF7K
	unlSWIu8=; b=ZuVeMtOQkVHpbKF7j6PVrlqC4/1fsU6R2MxYYKppAueQ2ocn+qj
	I/EOUFhtkKODoYHqspF/r+08K+12wLmEB+LSpQyD7faYSJwF1F2TY7XB+g6RDUBn
	s4D8L+Y0M/fSeHokzrPCzmHQPwgO4lhxv+Z9fx0ViXJFl2G07volix7iqJKk1SWl
	F/Wpj+XwuIKYYFtvhKPTahWSckG+q/6gyyGucQreR74Jo18vIQVeenJOnJj+m37Z
	mnPI0uN1UArNpVexGHmqw83ad3IilpcFVLSPtyqKhCTbMtkAHnoc8gQhrgBUA7CJ
	LEECDZ3Vxv9HmFtcgGDXev3fYuskDoxf0KA==
X-ME-Sender: <xms:dhm7aPHZq0kX4iFAzxK9x3Q1yCfm3A_2aW4dWXv29cboZ2QXzs-d_Q>
    <xme:dhm7aJMmRDN7Rp9heXD7nsWOvF7mcUE5p4SFRWwwYu1qGtV27zSuS79fscepBEWOW
    Hp82-50DuRjmMYNOA>
X-ME-Received: <xmr:dhm7aA40vSUeZanu6dXNVwficH6o8D-NnWieVth6yajzc4Fm2ggJkWRq3-FpmGF5JFBj7qeO2yPO6J9E2y8LS_JU_XIK2uBlVg0lwbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghr
    tddtudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dxm7aMjtu7BtjzbnCQMBKi4t7j84uTQWYhS3BeLRrmktShh_qtt8OQ>
    <xmx:dxm7aFekp81QjYYBo3qaniTDmM9PsBKQyoF-OL8pujzDls5cMzJjHQ>
    <xmx:dxm7aEwfQukiM6fe6byXRtENxbtktQgyhRWFxh6pSbZ-nFtjcEpqcw>
    <xmx:dxm7aE2CIfO2PjRfymeyOG9-92tXwRL0wNO6cp7_gljKGoarr7G63w>
    <xmx:dxm7aMF6FZt4d8FpXQNGhqajCu1D1VlAfksquQvzMiJZ2PqtLTyiPSyn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 13:10:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  phillip.wood123@gmail.com,  ps@pks.im,
  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <xmqqv7lx56kn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	05 Sep 2025 07:15:20 -0700")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1752882401.git.ayu.chandekar@gmail.com>
	<CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
	<47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.com>
	<CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com>
	<xmqqv7lx56kn.fsf@gitster.g>
Date: Fri, 05 Sep 2025 10:10:12 -0700
Message-ID: <xmqqldms3jwr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ayush, what's the status of this effort?
>
> Currently a topic by Derrick is built on top of this one, which
> means it is stuck waiting for this topic to stabilize.  Should we
> ask Derrick to rebuild his topic independent from this topic and let
> it graduate sooner, and when you reroll this series, you'd base
> yours on top of whatever the Git codebase looks like when it
> happens?

I tried to (re)adjust Derrick's ds/sparse-checkout-clean topic to
build directly on top of 'master', which involved removing its first
step to make it depend on the global core_apply_sparse_checkout and
core_sparse_checkout_cone variables, which was not too bad.

The result is queued on 'seen' I just pushed out.  Derrick, could
you take a look to see if I screwed up any?  At least it seems to
pass the tests locally.

I've ejected the ac/deglobal-sparse-variables topic from 'seen' for
now, but perhaps it may want to be rebased on Derrick's series when
it is rerolled.  We'll see how fast the sparse-checkout-clean topic
can enter 'next' and graduate, hopefully soon enough.

Thanks.
