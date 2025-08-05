Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3111712
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417028; cv=none; b=qg4yrWYr8TxvrtfB3Ni0Hzt01991ycMRIqbkxdvQkh898UkXBboufcVz32b/co8mnw26FZRye/YM7zQvlixbsC/y7tJC5IppWWOsUgUt3OedU7JTHSp88m7uIy5EM+7NFv0uHmOQbzMrHsmLYlF1sSCdU8tHGqOpG2yBV4YobDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417028; c=relaxed/simple;
	bh=JpeuAMMf/Wt9N5MOBwvmvEaOpzHyWhXQjYvMoHEiubg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iC6x0oNiV7xRCuKpHKI/G3Vp6zYt17bBFi5jHS0DobveMpe05na4AvPf5TxqtZZvxZdVUHDtXkdmmwWX+6zBL3NjyjJrlQfX2o5BUigQuDJNv60urphDiSW2+qTBKxZKhu01cYoU47GVc5lItAhGa8xT9UZi11P1TRKpjYPYLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fdhUuR9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9CIjTen; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fdhUuR9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9CIjTen"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA23F140012E;
	Tue,  5 Aug 2025 14:03:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 14:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754417025; x=1754503425; bh=X9dQGkCj38
	AJJaKNBoUaPdN8RFgdFCOjIEWVkm++UNc=; b=fdhUuR9ctNW3vzih1WVA6XXZxB
	U7TKf23qhApigtH/K8x76SYGcoRbjcmLgfmNAdlCcChJbRhJSkpalZv5MCVIDQMf
	agYW+MiZ3GCKbjgpaJqsTG/8SX4TyLkj3bj57Vj/mS1GpEDAUOyUnK35aatEihaR
	JpoazAnprioWgy40Xv1Vy7AqmolIv9OBJrRPtzYhPKiToIZpde86IhPKkn7bX/WU
	/r713DzdThosmLLNwXGUOXJpJHmQuedw6YpYN+Z5wasNNHYZf9FBsdnyAgRHhrpt
	+3bdA3Y373JRxWomITERd2wJg1zg4u/nZBv3rwYdTP5gANlZEPikNv9C+uWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754417025; x=1754503425; bh=X9dQGkCj38AJJaKNBoUaPdN8RFgdFCOjIEW
	Vkm++UNc=; b=X9CIjTen5B9N/Ion80+r27Q+34CwSriBp2IVaXm74MW1PbxRjcW
	VTwrOyBcBHNbA9at95Ou0YXlSKbRUSZpZ4AXDJ3dNODi6aHXQCrgCT69P5GuQWfV
	mwmxjtL9UEB56MqDmB8mFAHYw7a4d6wvee0DZBpJwbumYeNNExtBw18bQihYgMJX
	me1ReP5zOms6xVXAyJYedfYwxB1jHpb5Tr/Q7wEh8Ba2nfKgjj8OhMmsYoMBINFZ
	mI8dfn6VT8rzq9INaSaBRgFCENCgEeylMzd6OQRRQK7U95qRbAcCUIIMsV+PfXdP
	v9A65uexXcvK7w/5JGsqIDWqcISZavmvRzw==
X-ME-Sender: <xms:gUeSaH_lDvKIIZeY9bML-HMSzK4vrkybTjwbDF5nl8_rPpnQtFn16A>
    <xme:gUeSaOTehZMWLa_24Nwt6Prbtu0o4HENxoJTRBmnYHvXDU3w3G-PJAiVrQlzBYqUJ
    p5nGqVPBlovZy0B0A>
X-ME-Received: <xmr:gUeSaBnNkCHJxQaaXQ5Yv4x1rSnyYtysTHK9UytVMV8CcqqcQrVddH3fwQ2iGJFqG1nCL6VnmRSTWXG0JKUa1SGbgWbMqa-YGzhAqMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:gUeSaGT_ONHI5FhfM2TUWWv9yZNeZRH9neaFd7xj1o7IU33VSPzrLA>
    <xmx:gUeSaHPjfsGVOTJvR6E7z11HeGXNpGm17viDSlHhMs3z6uEqXTn4pQ>
    <xmx:gUeSaHU9T1PlIXxGK0HGlZlzdwAZ8aBPCBIYz_tEpG0MbQ9Iowi5sQ>
    <xmx:gUeSaGcv_eLWk47JsDsYQ9CzmmbsUny1vJEaxD7aklNMXcyCU5A6gQ>
    <xmx:gUeSaDtart3cqK8cGkuN58OvR8yoU56YlSfVx6TvZPhoIS3gRlGpZDtf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:03:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
In-Reply-To: <87y0rxub3m.fsf@iotcl.com> (Toon Claes's message of "Tue, 05 Aug
	2025 15:55:25 +0200")
References: <xmqqectr57ax.fsf@gitster.g> <87y0rxub3m.fsf@iotcl.com>
Date: Tue, 05 Aug 2025 11:03:43 -0700
Message-ID: <xmqqms8dzlvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * jt/archive-zip-deflate-fix (2025-08-02) 1 commit
>>   (merged to 'next' on 2025-08-04 at 4444b611dc)
>>  + archive: flush deflate stream until Z_STREAM_END
>>
>>  The deflate codepath in "git archive --format=zip" had a
>>  longstanding bug coming from misuse of zlib API, which has been
>>  corrected.
>>
>>  Will merge to 'master'.
>>  source: <20250802220803.95137-1-jltobler@gmail.com>
>
> I see this was merged into 'next' with 4444b611dc (Merge branch
> 'jt/archive-zip-deflate-fix' into next, 2025-08-04), but was reverted
> again in 5297b08916 (Revert "Merge branch 'jt/archive-zip-deflate-fix'
> into next", 2025-08-04)
>
> The fix in this patch definitely was the correct way forward, and it
> fixed the issue at hand. So I don't think it should have been reverted.
>
> I've sent a review and some patches in response, suggesting for an
> alternative fix. I'm not claiming my fix is better, and it might
> introduce other bug. I don't even know if the changes are even required.

The intention on my part was that the merge was premature before
other people expressed their thoughts.  Perhaps the list may decide
that "we must loop around git_deflate() until we see STREAM_END" is
sufficient, in which case I'll merge it back again.

Thanks.
