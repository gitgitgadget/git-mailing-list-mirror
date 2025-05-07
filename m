Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D34B1E7B
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640090; cv=none; b=JpW1jR1RJvHCZijjxT5vvPjhynq23cMKz7dfWLDmOV+GZB/ox0bVHM8/Hj2UezuQOfmf/LFBIxUbt1AE9c7rhnxrfITpj8izw2SOB1IrhylNzUGK9RPK0W7R8716VGaOz7XcEx14DX8qkddyNjGpV4cpKdyPdT8drjbH+s2pvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640090; c=relaxed/simple;
	bh=uW/2CSCx3y1Yehfkmivoo0ehDoYRhqTeHGklIeQnwes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qeKSP8A6hA4ivcn6GZYEoBsv/nUUENtL+TEbozLAiOVP/1tONBJ94Qfu+FlW6rwTeU5eYDIPAfI2YVXvvnNLCHK/G93doBT0w6p3WUHvaIJvEgryeDajr2zjAHPKVH81hetllhDdEuXBM+OJ2HOorNlDVOWLRypri3Zli18ClkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gE66A39G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFKqwFC8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gE66A39G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFKqwFC8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C939B114016D;
	Wed,  7 May 2025 13:48:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 13:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746640085; x=1746726485; bh=Na8Uzl+5ll
	EoNFGlxXK7T+fPZAi/1RYDnKbiJt9ReV4=; b=gE66A39GjuoRtUtNphdHHiuuRa
	PFDCTYqdw0KaVDUeAMHAmXZKY+HMMrJcZqyCzr37xIQ1rFg1Zx27aZcb9UQoObFk
	7VRrQqVqNbhtMN+un5S6HPZRW1Z9rIjIReOV1ouDcXuxZXE0S+3rGyA4Kh9lvp/s
	b16FInm+DtdFdUBFhWXYP2pj/PhPVssq2hw9StN0ieTgLvpZT/aKgWv6mOSbgWd0
	yow05jGGU5p/pGL0HvZBTuASpEp0+0IWNY21M1NYbLcDIP4nz1Wlj1OyQndZHEZs
	uZRKMrzsjo1jz0sT9XmnG6zD9Fl/IyJ0IlBJ7ZIE0rEN0dfxOmgmJ98BBRpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746640085; x=1746726485; bh=Na8Uzl+5llEoNFGlxXK7T+fPZAi/1RYDnKb
	iJt9ReV4=; b=eFKqwFC86KXTAVQ+Xtok8plPqTJa3A9e7dIazjGVg5LQeomaue8
	wWi0Y2KJKFBrbTEwth2o8CViKm24qNgyuDM4U7IQ4GIP2DCkJ1RGgher2kuFneV2
	jSWuaSdKOtN0z/fJxUbeqJ4spnUP6vNjMHIxPypX5htpUWOA0SAVv7ZGnZ7Hypc5
	x0dw25vdUrr9k3GnJN6aty95ryhO5ANWYjUN6yNzlR2biJrJ0/jGoXalyOok6Wyx
	LlgW6hrxDRzOaGRIBkNjoTe14FwovS+rPF+ZjNQjRVR9XfWsXSWBa2ufNd6fDrEh
	0ugSm1FMcr8crZjUFMC9vL3StQErJJFFt3A==
X-ME-Sender: <xms:1ZwbaMTbj8M4js2Ogo0u-tc0B8rkdd1T4x8VWBzrBAGLHj4zFs0Iow>
    <xme:1ZwbaJzGWFyF5Ofy2RRJ_IEqpfPwHe_V_j72dyJUZDcMsgw2r_ed5Tzz2rVfj67vE
    1uKp8HZcmHxSqKHiQ>
X-ME-Received: <xmr:1ZwbaJ0QbWss7R4oIg6JvLJpD8VfdWn5g_lPlpfSIjXZwZyAiQ6IT_FwHfE0j-T8O9SdocEfGt9IuN5qxUkdvYsakwnFSA7olUjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1ZwbaACN_HW08x5t-CcGc0tBjgVj5X70kyHjxV4KLw1wIen-X_-8Cw>
    <xmx:1ZwbaFjNeVvZXJUEA9QKT0ijdphL4vYmfY0--fNrpmhQwKd9BurjZg>
    <xmx:1ZwbaMoaYH-r4Pc2GOsHa8k8lrhteWwG3EqkoiQSC9Z-CJ0odqiTRA>
    <xmx:1ZwbaIh10uSt1zngpebAeVRA087nQl_OxgHfd3CwCXbTfdCQ1QgIhw>
    <xmx:1ZwbaJQ0cXOd8zJM-9y0iLFQyTz5iqtC3zEAgm8kAKDi0r_MpLAliSXy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:48:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] contrib: remove "git-resurrect.sh"
In-Reply-To: <aBsEooYbNl1cjlFO@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 08:58:42 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
	<xmqq34dhijnq.fsf@gitster.g> <aBsEooYbNl1cjlFO@pks.im>
Date: Wed, 07 May 2025 10:48:03 -0700
Message-ID: <xmqqjz6scnxo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> If we did that, a user can trivially learn about the old state of that
> branch (and even states before!) even after they have accidentally
> deleted it. Just type `git reflog show refs/heads/branch` and you got
> it. There wouldn't even be any extra need for a new command, this feels
> simple enough to me.

If we have a way to enumerate reflogs for branches, including the
ones that have been deleted, then the user can learn what to give to
"git reflog refs/heads/<branchname-they-no-longer-remember>", so all
will work well.  I like the direction.
