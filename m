Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A830BBBC
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223530; cv=none; b=U0OXc4oG9ubn7OoK9HBqOPSilp+nzLm3MW8nlGEcNtdFF7tVOtrdH1qSble3a3YTuGg+AmGtKTyACrfN8PfQrgwL8/PymSB+OOVlRhkQOQQ+BhDuCvbxcRjTSCVLX5wsfsSAMgALMMJ1+m+jZpGlhCkFFiSvXiPMAoMMc3VoUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223530; c=relaxed/simple;
	bh=gEJAY3W91pq3shOxp0po6XZmQ1WUqgGlgmxe40jmTEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3uYAtdHqWIKAg+UJ+/KPBIQDfc2k8Yzu9TYrFjGPjObxY41NH5654ZoExsR3YSlcArt73W3OcBxPNCVfGA3r5e1khvknuLo/LUU5Hfem2BDwVmfsMjRFfkf2z0pCsB+PS6uekWhYxR0hdfkjC/E/K7AL1jXLK0ygZwPSoL1iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBs0HjYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7DD4Kol; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBs0HjYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7DD4Kol"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E45DEC01B0;
	Tue, 26 Aug 2025 11:52:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 26 Aug 2025 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756223527; x=1756309927; bh=gEJAY3W91p
	q3shOxp0po6XZmQ1WUqgGlgmxe40jmTEE=; b=nBs0HjYEoo7VmHI7YdoAYvDVrJ
	W7s4sEi7LDWZK7swZiSup3w5wltSgjmQK4z3BieC9PlfOUg7K1/MGUtm9BCDiGdl
	6rPfEbYChChpIPCiKEfTB5NmfYjTUm305p86fNSdx1Ipe/UP+yYdKJzJKbk0H7TM
	6lvd/0QWvGOZNIvVRPv8Ha6ThkuBXvtIh7oprxH4zsmQHMF77ivq+qI0XX0tslfH
	IzsUAhqUHUr5gb01ag2dOoFksdVbEmJ6TSUZzp0WYRjjhW0bFVxOjVu0HDvz12Aa
	tNoAo4nHhjsh/mYgmLg45X56K+dS2E/ep0WUUiSE5p4UMwowALi7hjCTXQxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756223527; x=1756309927; bh=gEJAY3W91pq3shOxp0po6XZmQ1WUqgGlgmx
	e40jmTEE=; b=Z7DD4KolUD1SCB09rKV86yfLO2ipi4sgju+Y2WkTMg4RhSfSlvx
	fLgaXehqBJOyBO2XsLumgfdMs4fcKz/VHSRQKLmhdQA5Mz5wdYOSWPk20dfuMNPo
	JP1yOgxdiKNfS+JWGf7eA+nKGdYvteGwpKIihRxiUWRYVCYYBaWaC3rG0DVTn3Wt
	l5/EjWZ91bw67FQFd8IpsY9fDlpaiOLvZVjlJtYPBiwYBlvL6ezJrUIT0tG7kr9O
	KtkGNF7lYBOAspNX4/rvlLzYi3gYol0VwlP/DGMbSR3nDxFZUHgo7FgLo4x4Zhd+
	upcZMft+JyHIqAtbi3MQFMO6RJXb07t//uw==
X-ME-Sender: <xms:J9itaBA9btdXDT3q-A_If35elseBhqSZEhmC6N7xkWvGpu1vPO-Klw>
    <xme:J9itaNE70NrPJqSKl-EAknQCdMf64KWuQjmhlO7TDpAeNLwiSpyjUdtlxXhVtkDSq
    my6jPcVk8kqbiKokg>
X-ME-Received: <xmr:J9itaDCswjFSO5dNcPZigN3mYzMXMWB2xfToiXcGGvJqqgbqTYAKP_DndFENH28ooxD8Ou17ZoHPVkisXoqEbrr85eowlskK_LiYjl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:J9itaNVEi7oj7N720bTIAQGgzh3muCqd81cZxARvIG4_6bvmVS88QA>
    <xmx:J9itaHoMzQljs8fd4FFDiB6BUeD3A1z-Ho8MoZ5ZXcmL4bocrDglgg>
    <xmx:J9itaJRH1iVFfHcqaU6LntHlATlAJ1ztIb-BEDh_XeLiOqqkxvqRBQ>
    <xmx:J9itaB1tZIMU9BDsWjqAG1B_LrRo0L8L5QbdGo_AOkA0spO9-Yk6mw>
    <xmx:J9itaOODaQz1w7kPdHehV7wYnyC1qktXC0ulJrL43x4YeSEdJF5SCYNb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 11:52:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/3] config: warn on core.commentString=auto
In-Reply-To: <5dd897c95e680c4e3f26ec3945fe649b4b61681a.1756215326.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 26 Aug 2025 14:35:27 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1756215326.git.phillip.wood@dunelm.org.uk>
	<5dd897c95e680c4e3f26ec3945fe649b4b61681a.1756215326.git.phillip.wood@dunelm.org.uk>
Date: Tue, 26 Aug 2025 08:52:05 -0700
Message-ID: <xmqqldn6krmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As support for this setting was deprecated in the last commit print a
> warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
> Avoid bombarding the user with warnings by only printing it (a) when
> running commands commands that call "git commit" and (b) only once

"commands commands" -> "commands".

> per command.
