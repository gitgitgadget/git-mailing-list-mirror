Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0B35A39F
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786444; cv=none; b=V3U/DYRIO9oUJ3iGzkg9CJVAu+ugD2qrmWyFgE3rTB3/G9YJS4loQM0LO4yiAh6K/D5UZvEjvmOvMWje/oA1EcPgXxUb7vwvYMW1/H54o/UHJk9t1HsBGwgpEFpR5lbKf7ii6NUw3bCAn/0mzzHidBuVVZjrub37ADXaxYqBvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786444; c=relaxed/simple;
	bh=ZbdoCYvD7wM5JGHw+ZxkUNaxAwtjZd02O+7kB/aXDfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mp5QPH2N2/oMRUJVldcmadDkQinpU1rrYbt0/AmBpRwG2m+Eego0cDjJfj7WWp73C1F587y7aAFZRMCCHr1JTu07hKRigS3gHqVpSUoZAUBqgmUZmI/uN8zyq6vk7ml0Fsbp4fIk44Og5ey4KnOVBdL4OdVNnOxVY1qN23poW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVGNE9eI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cnCVJjCF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVGNE9eI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cnCVJjCF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C9421EC00A4;
	Thu, 14 May 2026 15:20:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 14 May 2026 15:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778786442; x=1778872842; bh=10s2AH4Flz
	ItCMckv5nvzNYD+vTyhFEywleEf227qEQ=; b=AVGNE9eIYJoLIyYAsMbOb0Ikih
	8XxEIhyzmLNVlAEZmig78n7u5IV5PA3jeNHbZ3tam5iu3Vui1QupPiq85OAFA4+h
	yPk7RPDvuThCeisjR0EOF8qwbuJAbgILBQS/2WlxWVM/puMhNeR+HvTgK/swgQ+q
	RR8DmrACYW82CgJ1xGS43ubsKOUw8Zk0x6TD/2bO+whiOw3kqAra1XMcdlshxHD/
	gGCmKapLitqTv5NIN/aMqA5QwbQQ39N2sNXyvYNMK9ZhjOhVk8R/uJ9avLqvj8zk
	IsHWa9mL6hM1O9GKPRdAeLpCTwKAbVdmhtOo2NZhLPqscJQP8TvW7ba8wu6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778786442; x=1778872842; bh=10s2AH4FlzItCMckv5nvzNYD+vTyhFEywle
	Ef227qEQ=; b=cnCVJjCFzA8FS3N2Y+TfOTOOzd/iyjqtvKZ4jEdETIjI2snRljV
	R11chKphJL2STANm4pLGfG7BOMA7I8NlEqbHQpPBtpPP7e73JUEgxshiuRAx3OUo
	V5aVQ7/ISFQTj+7dpfYu9AoZQaZWYPPde6Rx2ylKis1Mt9CbkGYmWPeIHDILtEI5
	qqsN7KvGc6Z1OhQ+KuXosmPKwv6G9T21VLkKTWliq1QkJokOcaITWP45JvHfEMn8
	UaM+v+jQkEc1oma6UKl+kNZozlP9wIACGJR+LOJ1l9aTeUOlNRZMU8mAHuPdYClm
	TC/KnO+ksRaMZHz3VFRm8RcxHCYO+5hIYhQ==
X-ME-Sender: <xms:iiAGasvEJxzIFy7L-h3ifCe70xkddosdNxQ2vW89cGFqI07GdZxrpw>
    <xme:iiAGagftD5CjlldEheIC0Kqqve6J69uLprqmJ8ak_8nQ-21NLmVH6o95s08jLmFw1
    07Fr2pQV5Azvtq7ohv7SEKBD2Jt0OJ7KHMA6tH_LcVoIxJPmCBaxQ>
X-ME-Received: <xmr:iiAGasxDGqis4-5Uvu-ebWCEiSAo_U-v1GjHq82xLt4gcAMEfXygZql8dBXsuV2UfYff9Rk2l9QyZS8oQ1yvRnj3oi3-VdgUHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveellefhgfdugfetgfeuteegvdffvefgveetgfetheegkefhfeeuveeigffh
    geeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvggsth
    grrhguihhfsehntghfrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:iiAGauEzSG2PuL9ZFZm6t_4YzZH3kxvOT1an09q6yUL6V-agcOR4iA>
    <xmx:iiAGaoxyBwV3fGymQ-fV1xkSlsEhXQNsWIJNhWZ_4evYm6-m7VGBOA>
    <xmx:iiAGanvbuyQju-GBYpxNZuMyx1eRnAP0EK_QLzmQOmZPON20vSv_hw>
    <xmx:iiAGat0IfPKmU-_yxU-2DWIMO0e6U4D6hs0YsMaUDOmrsUGskcwqiQ>
    <xmx:iiAGati6ZDNNLk2uLnMhvlJkLbGwupnpED369oNV5W_BPU2OB-YZ-dpV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:20:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sebastien Tardif <sebtardif@ncf.ca>
Subject: Re: [PATCH 0/3] daemon: fix network address handling bugs
In-Reply-To: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com> (Sebastien
	Tardif via GitGitGadget's message of "Thu, 14 May 2026 15:46:29
	+0000")
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 04:20:41 +0900
Message-ID: <xmqqfr3tg5me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix three related issues in daemon.c's network address handling:

Thanks for separating patches so that each of them addresses one
specific issue.

It would have been better if you sent this series as [PATCH v2] as a
reply to <pull.2299.git.git.1778291290159.gitgitgadget@gmail.com>,
which is the previous round.  That way, the mailing list archive
will keep the related discussions together on the same page.  If we
visit the page for the cover letter I am responding to,

  https://lore.kernel.org/git/pull.2300.git.git.1778773592.gitgitgadget@gmail.com/

nobody can see that there was a previous iteration so those who
looked at the earlier effort cannot refer back to it and compare.

> IPv6 address corruption in lookup_hostname(): getaddrinfo() is called with
> AF_UNSPEC hints, so it may return IPv6 results. However, the code
> unconditionally casts ai_addr to sockaddr_in and passes AF_INET to
> inet_ntop(). On IPv6-only hosts, this reads from the wrong struct offset,
> producing garbage IP addresses. Fixed by checking ai_family and handling
> both AF_INET and AF_INET6.
>
> IPv6 address truncation in ip2str(): The sockaddr struct size (ai_addrlen)
> is passed as the output buffer size to inet_ntop(). For IPv6,
> sizeof(sockaddr_in6) is 28 bytes but INET6_ADDRSTRLEN is 46, so long IPv6
> addresses are silently truncated. Fixed by passing sizeof(ip) instead, and
> dropping the now-unused len parameter.
>
> NULL pointer in execute() logging: REMOTE_PORT environment variable is used
> in a format string without a NULL check (only REMOTE_ADDR was checked). If
> REMOTE_PORT is unset, NULL is passed to printf's %s, which is undefined
> behavior. Fixed by using a fallback string.
>
> Sebastien Tardif (3):
>   daemon: fix IPv6 address corruption in lookup_hostname()
>   daemon: fix IPv6 address truncation in ip2str()
>   daemon: guard NULL REMOTE_PORT in execute() logging
>
>  daemon.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
>
> base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2300%2FSebTardif%2Ffix%2Fdaemon-ipv6-and-null-port-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2300/SebTardif/fix/daemon-ipv6-and-null-port-v1
> Pull-Request: https://github.com/git/git/pull/2300
