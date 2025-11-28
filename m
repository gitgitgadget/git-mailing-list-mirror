Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08322D795
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314968; cv=none; b=Hp9svaPod76zi16eG1IwWgW2fa2vHxZR7UGx/z4TPhFKuvNdiLYjT3MKNHLJklQSinDuLfe81Y/B2ZWr+LLDGdksru3fp+z+hlHD1S3vtJ9gsI6KDohXq8P0rV+hl4A67yfr1vuID0ToHiQr2eVUOZ/026+2YbS50Ki3BgvVn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314968; c=relaxed/simple;
	bh=ApnsRgLwRfMP4bsJy+3P9BX/6cngbl+QPv4aikFNj6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wqpx1ydcJY+r3rZXYEDBVsrXo3iocPe7KRvNxpB607pnwZxAtw4KGzQmDJ3PwhrRb1yogxz7p9XrZlEclTqI3fJjlsIdcFmTLepiOi7SUy8yseAGh+1DYCHQfEvUEh7y1iWoiKP1ZZxargO/mCX54YSSFf19r2mQSQ/jFwIp+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l4y/lh2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOzlUWYv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l4y/lh2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOzlUWYv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D85C4EC073E;
	Fri, 28 Nov 2025 02:29:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 28 Nov 2025 02:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764314964; x=1764401364; bh=V+TxAULPKO
	kAF/OcquGKsTqtqkvSnjBK3hNyhNZrI9I=; b=l4y/lh2lDE0LftKPX9o+P9B1/D
	NBXwb5tk5NTIca9xG9YmstYrQ5IdU28zc5Ex0sdgnQwxavtxhuJy8tuMQS/GQ2ZY
	gxX349ohYZ/oMSBZukYzrR2nYJ+BsfLyZC15GQNiYPcxVcz5MnW/Ez3kxb9+LUB2
	k6oig+SaTo6bgb81N1DID8tiIjsAaIUk5+uIYQbYrRMF20PCAASe4kaNIve8ethU
	RLthkCmMr1+IIlQPpZzmpKzzUQDVBcR7I2Q2b66B0O/wA/P3PER7wEoR9k90RWLo
	m3UkJW3OSA5DGgsiBeogFSzZXv87BZZzYaTPvMsRA2X6TW7+FMDEWzCy3+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764314964; x=1764401364; bh=V+TxAULPKOkAF/OcquGKsTqtqkvSnjBK3hN
	yhNZrI9I=; b=MOzlUWYv0fk5iJHtPIvqydebd5nxsbGFAolKf/XNF6A0MFlyDws
	4YaaOgMRgAWM351OiRDgENKoe1pZtKjP070XkTZTSK9uyWQ22UmuZjbl6TxHpHoA
	pv2tZEa3YkF8RYDBzpm6KU0yNgdZq3n7nV2NqWJmxp7mdbNAvpu4e1oRSS2SukTp
	bZ88eAW86aSIloRGe9VfyS2zfOrutwben68SYqAbBBY43lnLn67D/lyiYqdlSMH7
	41n+4CN4e55zln4uHJrn6pwyJD73ds0CCZnijdd7FvAmvGgDQPUizuECBmwoxY/g
	tXQQnTBsnQUzkEb7vv0YABDDjyuQcVAcpNQ==
X-ME-Sender: <xms:VE8paRqeAiy-VWI2KdqbxzHLtSNk60NNav1iUx1qnIYC9yCI8kBXXQ>
    <xme:VE8paaptT8YJqDvPftENe54Iotp3BVPocTEitfMYoMyD_whxOKCnsvFre7wyQGx3g
    r_H2-0d7q4YM46vk8ZVS0xYa7p1THSGAQijW8Hb70mXaNgirIVz>
X-ME-Received: <xmr:VE8paTN7-r6XKDj5qi7OREKWS8qPNubkMG5r5kjvmg-yPppbji6KqB4Lj6EjcngE5vreW_92wlHQIdpkF-aCAJZC8sFQJl5LfxMW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:VE8pabxUegED0PwY1XRwyJFj3Th-RC3ICzse3CtrljAfLBVXogX-pA>
    <xmx:VE8pacsxyFsH5j-hy6uR0Ys8R3XkoTXRiZxIQbjin_ezWTn0LhKYIQ>
    <xmx:VE8paU7jszDiErK3RnlKcMYt35eSM8ZCjFFcmZl641Wy5RByMzEBcw>
    <xmx:VE8pabTvohLtmYbDWx_HBw4EKBMthih5CIvx9xLjeAUx1FGxZWh3HA>
    <xmx:VE8paSt_QazFI6Czg4lBOqiW_55QEBFWdkghlqLSWUGneKnwr2YYmBZV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 02:29:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] replay: drop commits that become empty
In-Reply-To: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 27 Nov 2025 16:15:54 +0000")
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
Date: Thu, 27 Nov 2025 23:29:22 -0800
Message-ID: <xmqqbjkmk431.fsf@gitster.g>
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
> If the changes in a commit being replayed are already in the branch
> that the commits are being replayed onto then "git replay" creates an
> empty commit. This is confusing because the commit message no longer
> matches the contents of the commit. Drop the commit instead.

If a commit that originally did two or more things is replayed on a
destination that already has only part of it, then the extent of the
change the replayed commit makes will shrink, and the commit message
no longer matches it, either.  It is a lot harder to notice the
situation to prompt the user to rewrite the resulting commit
message, but in the degenerated case where the entire changes go
away, the rewrite of the resulting commit message is very simple,
which is to remove the commit altogether.

Makes sense.

> Commits
> that start off empty are not dropped.

Makes perfect sense, too.

> This matches the behavior of
> "git rebase --reapply-cherry-pick --empty=drop" and "git cherry-pick
> --empty-drop". If a branch points to a commit that is dropped it will
> be updated to point to the last commit that was not dropped. This can
> been seen in the new test where "topic1" is updated to point to the
> rebased "C" as "F" is dropped because it is already upstream. While
> this is a breaking change "git replay" is marked as experimental to
> allow improvements like this that change the behavior.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Elijah - I'm not really clear why we were setting result->tree before
> calling merge_incore_nonrecursive(), was it just for convenience to
> avoid declaring a local variable or have I missed something?
>
> This patch is based on ps/history

As I take this more as a rfc/rfh than finalized version, it is OK to
depend on the topic that is known to be rerolled soonish.

> I think dropping commits that become empty is the sensible default,
> if it turns out that some users are relying on the current behavior
> we can add an option to retain the empty commits.

I think it would be a good default to drop what becomes empty.
