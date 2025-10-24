Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F9324B15
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318822; cv=none; b=kUrtpqIpVaB1899S0MAXi1JoJNRfF83zYWqiaLYaunCT1f7hBQ7/0tn0WylSvhhZzB3/0OVHOt1smzWAxFyPXAWVFq26XJ48uPG4tZHD5ixnfslxQW2UjiOoN5wwTva51HTlN0rqV3mlRGyfCHxMrfXp1iVx5AEvzKGZVyMRTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318822; c=relaxed/simple;
	bh=NGSu787by52yH7nHG3mY641K3wORSfPrrAtajBZzX68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOS19E3iKgl8aTzfBTHwEl7iNfpscjTK3+a6Pp/95qP1LC0AiAoYnUc1zeAho1XlMhKDw5wW+3havhYGC1YYbmJQZKuQEdVnhF82G6vA8RaBGYjksz8jcaCeGqaJ9/XmO/3n5W3WZUYWutZb0cKBZiFtZwSFxoFr75x5M3M28h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I6abUltW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KanphXae; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6abUltW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KanphXae"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F6D07A0090;
	Fri, 24 Oct 2025 11:13:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 11:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761318818; x=1761405218; bh=NGSu787by5
	2yH7nHG3mY641K3wORSfPrrAtajBZzX68=; b=I6abUltWvn5tFUfnA/Ob/dy7KA
	lmGHT909s1yqZ0Hshw+Ca/I1Fpaeoh3B1v04lAZpWK1ibVM5O2NGAFpA2ukJP5SO
	T3FzE3jinVhP42sqDjrDBwcvLAikZnz8uRYPZbCpfslPhkwhn6eCVCzl8WAmP9c5
	A1haWOGzCeYh1Vx5gut88R4ltRyL7A2e627vsfY+dZW6Ye8kPwG4RMMnrmGlTOBb
	o9WaOoWwssNX4pA0wwJjUDwUbTknaMrQBglcVAkn/XSlRl9VlsvmFxs+0SH4bD4T
	6KnTuzfNnP5qlSZ62TTPggag/ze3G6mehOZSO5OzY3q+66b+e5Ox4Rt7WJvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761318818; x=1761405218; bh=NGSu787by52yH7nHG3mY641K3wORSfPrrAt
	ajBZzX68=; b=KanphXaem5v4YAZKEKN7Vp2bMHDdH/JE8pN3QNNvVkXxi1NwFl9
	sElztz2bMil8OtW/fKAej0OEYrUR9QtB059Iy6lx3Ap5UFtoof8g/4/u4pj5DjOe
	k9/bjOSXDBhi8rN1m3FuMxaGhojyP5nX8JdJZOZ+G/n0pGohfn8sDu9yXN7h7Nrj
	YHfRvZt6ehI5zdMFYTZXRyuYE5lKAvrgbzY9dZZL9yv+VConLq1skOHIDTdj5DNf
	gm9aFMTeRDgxOJKMXTxew35HU6bn1lPHxZTpBM4rsbhbl1cGKBuo3wjYbYIJiRQO
	2J91dj9Gb546ADqo1gVSumscl//jz+3ipQQ==
X-ME-Sender: <xms:opf7aJo-svlK6fNNKv7IyYQ_4NKDi0t5BcgTL-56Y9UdI7SDhGyVzg>
    <xme:opf7aPVEjK7sSGTUNixMAAOnuPWQWgAOj2fVm5KpztFAHtGSzgizKfWyTZpWRKODO
    xhtHEMT0IUN6EBFlzI246fjn5-_DQRp3sPuptWw19U-v54nOpEGwQ>
X-ME-Received: <xmr:opf7aADVTKhuwqM09yoQpak3cLKJcqsf9edsyVdWYNcUjlYyMb975l4TUHjHgU7SuvA2GSKJjVTei5lhxRyL6gCAvGssHs1WZHxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuddtleeigedvuddvheejsehqqhdrtghomh
    dprhgtphhtthhopehrvddttdelkeduuddufeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:opf7aL0gAvAJAPbZz76x6brQb_FrWKAxsGzq2mszD8PZ1FReWRC86A>
    <xmx:opf7aK2NA5X-iQ8kyv_d7F4vN8EccptwF3sdyDEfJvPBVVCZ481GQw>
    <xmx:opf7aIDfeNTGEK2nD-KxS_ioQeZlNsU8sYDW5-v9PI0V2wG_Tl0zkQ>
    <xmx:opf7aB6gTChB-7GVxcC0EUAXHXVTylpCjc4iTNT68w9gaxGya-av7g>
    <xmx:opf7aJE44BHsoe3kXG3l5RO8AKEpVNTAt2f4a7E6dYDaevIi_PJypJSA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 11:13:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: RuanXinyu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  RuanXinyu <1096421257@qq.com>,  RuanXinyu
 <r200981113@gmail.com>
Subject: Re: [PATCH] refs: add missing remove_on_disk implementation for
 debug backend
In-Reply-To: <aPtCvwvNUtFXqrpv@pks.im> (Patrick Steinhardt's message of "Fri,
	24 Oct 2025 11:11:27 +0200")
References: <pull.2082.git.git.1761295094982.gitgitgadget@gmail.com>
	<aPtCvwvNUtFXqrpv@pks.im>
Date: Fri, 24 Oct 2025 08:13:37 -0700
Message-ID: <xmqqikg4qqn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Signed-off-by: Xinyu Ruan <r200981113@gmail.com>
>
> Tiny nit: typically, the author and DCO should match. But the autor is
> "RuanXinyu" whereas the DCO says "Xinyu Ruan". I don't really think that
> this is something that warrants a new version, but I wanted to point
> this out anyway so that you can fix this going forward.

It may not warrant a new version in the sense that I could tweak
while queuing, but I need to be told which between the two is the
name to be used before doing so.

I can make a guess and use the latter but it would cause me yet
another piece of extra work if I guessed incorrectly, so...
