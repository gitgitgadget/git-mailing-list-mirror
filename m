Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928652C3259
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522537; cv=none; b=Eq1IAg0VvROqyAlrVHvL9q94gUGw6sVUVKMwtZFy6jbRqHMXX6NAuvJ3RAdP6qToda82ZyxuEtq1KeM5E7YiLRHA2sC9yTydzuCF+dnwTwySw91Uz/zkY8PB83puO482KjNS8bfGJkvmknUKWDq6PL49g+RQ8PnuUJ21cXIxOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522537; c=relaxed/simple;
	bh=uy8Je41RQX2LKm4dwVy5Heie2ugfylITeBwB0n3K8Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Av8dwDDAMe8vQQA4eLvYYeaO1Rvoyl31Lq8PVcdTM/XzFWT49jKj2VKjXvnDqMvn37ZRRlRjOD8X0ZZoitsya4zZpdUFkwGsg2ZHHLRZlJtNf1d0vWz67ejcNMh6KTNoXWfgKBu2M9KJegxAeiMGCBlQfuQCzSFPlCVXsfGDR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwPFYnSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCOeE25m; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwPFYnSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCOeE25m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B4DE9EC0251;
	Thu, 19 Feb 2026 12:35:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 12:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771522535; x=1771608935; bh=wRNkAinTIA
	1fCiyxwIdmu6eSxqE1a7USn9UpTn/Emxg=; b=bwPFYnSQeCYcFoe54ikmvL1HgV
	PI9HB3Ru9qSe2g5BfkyvKKgUf7AW08maqFMy6+8DV9k7INulpv425/5XkRQkvMid
	cKgk3ycRk6M3uEW1oAKnnZZGOIkUw3naMiN2l5yUB9LbtEX5pw4q7kE9UnzyjS4s
	nIsxiehEP+2f3hMzkBbeFxtbl3irWXoKT3TR7iemdWORad1oS/TivSWyhdhMt96Z
	yopZApBbq5smENl363c/WyHS2hShAY1OXl7g1Eam+YYgfndNYN/A87/4tk6q+L2v
	tmG/N/w4IMqDTUIgCailz/z131Jq697jbSTy2xwtDQwM0ZWXG/229T14xEew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771522535; x=1771608935; bh=wRNkAinTIA1fCiyxwIdmu6eSxqE1a7USn9U
	pTn/Emxg=; b=MCOeE25mqbtah7bemyQbSyxJ5tdMmjVa6Kp4ye9dsS9Eq5R43fY
	51A34fMUOqaz9Y2XT+mQlevcSnQS3aNPkL6430V309B4fQav02TIs95qscOk8avT
	XNJ4uKuxnaTOt6w73MPRPYa+9+bHl+qkz4Q2odm5NJeuiuWkxevlbcUnu1QJfBky
	1+1fStwYUnb630X1xTgErdlZtbdsuiL7mom6/2KsJ5bgGBvj2nkJxKG+ZT3c/gTr
	rcPvAJTyG6XEBu6CpXU4kqAlcDM2jI5RpRIkCCnOMnEwjHGuC+TRC3lFVfx00aRz
	7O7QREMbtqG/FCqRjpXHxkz5w1iP2vXPK2g==
X-ME-Sender: <xms:50mXadcbfXeuMMKrM1LXfmssQ88ODUcjCcO3cm1sJ56B5BNnU-_JNw>
    <xme:50mXaSHrqH4NAxSUiT_w3lhPINkQ2M0ZL33a_9Esi0Xi0zIheEYKSyIBaeGJA56Vl
    -h7o5yr-vIzLTaLQcnTC_Bt1pDhlQuNwOuB9hps99rOFOzy6G-vZw>
X-ME-Received: <xmr:50mXae1VqrScWSAx-8Sb1h0__8GFOIYe7NTsu-trS-_pATG8CGsT1jSrBw0jim4kGfIQHj-2eD3um9JZ7bItYWytU1cL3vMqwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhlrggsrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:50mXaSmu1jfi9DbQ08AuseU13htZ0fG-N-xpQuzIdTWL-TrXYKQBVQ>
    <xmx:50mXaW-6wvfOyRAZMoLJdlB-PLGurftz4pTIPSmxf6hDj705r-4haA>
    <xmx:50mXafp0uZVIEmR5AAfN8Rqe2GA57DBu7Fv_lcg1zeChdMaG1kpaYA>
    <xmx:50mXaXmywFdRl7QKXja2_4UAPxC3rsZ2dGxIbHnEjg0RMI_IMIepug>
    <xmx:50mXafGl4eAVz-bIBwPbNnH4u00VrUqNnL4CqKYa0rM9_6ZKdc9Ij_gt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 12:35:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 1/3] commit: avoid parsing non-commits in
 `lookup_commit_reference_gently()`
In-Reply-To: <aZX4w8C5In9gEF33@denethor> (Justin Tobler's message of "Wed, 18
	Feb 2026 12:26:21 -0600")
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
	<20260216-b4-pks-receive-pack-optimize-shallow-v1-1-e98886daff2b@pks.im>
	<aZX4w8C5In9gEF33@denethor>
Date: Thu, 19 Feb 2026 09:35:33 -0800
Message-ID: <xmqq7bs87i1m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/02/16 04:38PM, Patrick Steinhardt wrote:
>> The function `lookup_commit_reference_gently()` can be used to look up a
>> committish by object ID. As such, the function knows to peel for example
>> tag objects so that we eventually end up with the commit.
>> 
>> The function is used quite a lot throughout our tree. One such user is
>> "shallow.c" via `assign_shallow_commits_to_refs()`. The intent of this
>> function is to figure out whether a shallow push is missing any objects
>> that are required to satisfy the ref updates, and if so, which of the
>> ref updates is missing objects.
>> 
>> This is done by painting the tree with `UNINTERESTING`. We start
>> painting by calling `refs_for_each_ref()` so that we can mark all
>> existing referenced objects as the boundary of objects that we already
>> have, and which are supposed to be fully connected. The reference tips
>> are then parsed via `lookup_commit_reference_gently()`, and the commit
>> commit is then marked as uninteresting.
>
> s/commit commit/commit/

Will locally amend (no need to reroll only to fix this).

Thanks for carefully reading.
