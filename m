Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C81F8660
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275731; cv=none; b=o4bsMAWzyfSnIOOOI2WtyKarn3iCPd6mEoPqoqojeBwddmgiC/6SmQxvEOYiC1o1f0Z3SrzIyDu7m+dIJ/Ld/zcAlG9maTV8tPQQYKL6q41yq2QSgN54Yl0PnoZKHsHWgwyPiyCZOQ7EKn96HtL3J1FoAJN9SFnNekoPzf+KDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275731; c=relaxed/simple;
	bh=ad8LSvDJM+az4scRIl1bMl1wkzw9J4kaFf5NfhXKXlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8quyF4+yvA9L+LyYmDUXA41e72KnvyYb7I9R/jLMwV1y8L58rkTWVn03TWDwQbvLZmlTh0LBOSrhhQHXB3ZxBrBsjxCRkEesPfKFhopMuQXDToD8aiY1be+GK8T4sbSoiVm1OLrPvIuktDu1B8pQezWnbDygEmK19+os3We9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZIX5aIK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbN/RCfx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZIX5aIK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbN/RCfx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 572F711401C8;
	Tue,  7 Jan 2025 13:48:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 13:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736275728;
	 x=1736362128; bh=N/TbxJEgOpSHvsbqTbXsL75oKnVLJ5RFMFwLhHUIzDY=; b=
	hZIX5aIKsboM5ZwZgUVJPlp3RmInic6HtpBEuyuvRZoJjfZo2tF435ny/EXWAMTL
	UsOuv+L4ux6gTlNZsrY2ouyxVLK8Gn8G6JNP6/RsyduJNqMLrVJNjeMi3R1ZbmFL
	QbUp2xaA0tL+e7EwQEY2b3FyDmR4zld6O8xryxNk+R6TrCcOBQao/0xf8rR7Migm
	06Ra2gUrmhm8susy8ker/ytYT/zl+YNybDwFLui/ZjO29m6uQykLfLIgz2EYuvgR
	UfQps891oxs+Kkhn8SXLxHuM9NsgeRuBtdkSWiNgJgXgNBs6mIoCa0SgsEokIW92
	n2lsEKe5NWQmoQusSqJE3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736275728; x=
	1736362128; bh=N/TbxJEgOpSHvsbqTbXsL75oKnVLJ5RFMFwLhHUIzDY=; b=h
	bN/RCfxLHvEZ7HFWWvuR5JV82O1UGTFmio8HvUejNWt3/MN33MXvehZto8mRT6pj
	bOm8+PcoCbp0XRbmfLHyDnLARw5QNgz0MvPc4hy6ZjRhq1eSBmuSv1PA0FyQAmOq
	GAwouSM0G32b6+/B+DHLoOkeM2mYUqGuL1P5fuuL7RZjxtOnHvNcaej332Z1nBwC
	wrAgX+4NKI6bCl6ZVjSKAJ0w1V7tZJeZrZ//irWv8lb8pNXRgqH3XGfv74KAK4s6
	kNSDyqU22bJ3c2MhW2Yf5av41FwOgOPzA+BuLaD4DCDuzVL+imgANLpZKxCS0kCT
	uTWQecweCAnQFlaEQ8Yhg==
X-ME-Sender: <xms:EHd9Z2stJ6zc3KHRpq9RMu1o-nCu-3i02IYDkSUeu_ccqZ0BVdCogw>
    <xme:EHd9Z7eUFnCmGutM7fuHlMvWKEELgADAImUugR6vMp5F8Ng_BpmreiKhzMK5UNHB7
    SBuQpNptuNvOsEFdA>
X-ME-Received: <xmr:EHd9ZxwUTsVeUwRopQXdKMNqMkdMoexoG5pZ3CWOa96uO_IkEjdXi-Wu_java99nxH3hQP1wrPm4gGDlidH9hOW-Gx9Ozn4-Pd4b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgshhgrmh
    drkhgrnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:EHd9ZxMkAz-EWDorY69McCIitQH2JVjzsT8lRN7QquOeO5w442RuLw>
    <xmx:EHd9Z28yh56x_UszPaCuZXGxFMYN-a_9CWuXhU7C157gSu2MR-FP6w>
    <xmx:EHd9Z5XPGjgG3IKoCYlHi3hadzMUgEAgvca5Eu_jB24MltDKW7N0fA>
    <xmx:EHd9Z_fR4_-wklGnP5G_8wd5zHByZxE5IX4Vhx4A4XXb1a-0-QOh-w>
    <xmx:EHd9Z2zDNmRmUofbemtIzq_jd4tFmgB9VKdu_SNpMxG8CxlD63uT7bb_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 13:48:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v3] maintenance: add prune-remote-refs task
In-Reply-To: <CAG=Um+1tD+taKyN35x6q8ynjgrp+nVPBbuff5FUm6HUp3qe+fw@mail.gmail.com>
	(Shubham Kanodia's message of "Tue, 7 Jan 2025 22:59:07 +0530")
References: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
	<pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com>
	<xmqqbjwnra9u.fsf@gitster.g>
	<CAG=Um+1ch1sKC0H8MJoFv=6iSK3pvA=03AKXmvhm5DG=H8T1rw@mail.gmail.com>
	<CAG=Um+1tD+taKyN35x6q8ynjgrp+nVPBbuff5FUm6HUp3qe+fw@mail.gmail.com>
Date: Tue, 07 Jan 2025 10:48:46 -0800
Message-ID: <xmqqmsg2sbn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> Junio, what do you think about my previous suggestion — do you think
> that changing the remote behaviours is a blocker for this change to
> make its way to master?

Yes, changing the behaviour of an existing command in the same patch
that adds a new feature, and doing so without clearly explaining why
such a change is a good idea in the proposed log message, are both
huge blockers.  Not just to 'master', but to anywhere near 'next'.

Thanks.

