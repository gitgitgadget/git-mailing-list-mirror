Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2425D53C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315673; cv=none; b=Gk6UpXrljTkOeV7ye+mBsgwyTtiEH9LziT+ntPP9d6xwHe9OL6HR1/x6uVIadUkIjHuKqhWkgAh10L2G/q4uYvKXnLBwmxlEtI1LpT00xLlhMfRDq3bKEBiUbTQ0+P1jBTwT2ZUdF6PZnGhojljXBko/l8bSypX3HMOJFFWPCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315673; c=relaxed/simple;
	bh=T/G9FNvoTj6BtO2AwhywUAkRl1OrDsedAQibNRKiEzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmyDOh/B3RxSIm+QcPn+TOgejfqCcDonfTgzWYGLXgjQs1ofrqKFSrSmrtlYpuW5e5uKeG8K1tbhO8aele/ZyJoJWscD4pQHXL5jWXzSfFrvQpWy/DJnS0pgWHrL7g1GQ+wKS6fvvlV8ekkk+MdROPfYCeRzKlnWrEt5LQYHRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PT3UyyE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ATInXplv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PT3UyyE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ATInXplv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DBAD140013C;
	Mon,  4 Aug 2025 09:54:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 09:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754315670; x=1754402070; bh=4xp2gYZGup
	EL+ZwMtOaQEY82TUiZLSJxzba58t6mX34=; b=PT3UyyE35l8uiJrw3LGrVSxm21
	C6XV4NZdPFXfl0g7S/57u7BM4EJfkO5gFRpSLezLo12EwRbp9Tz5suWACwcjVfZt
	nV/OS/hdhW6O3M4DJFocDOLdGYqXmo/oNC3uesjQuXUcnCICZ1s0KDQQi4oI9oiF
	8iebbIL91WXq96ems6npkqroJtF5zIhU2YU44/OIKrO8/FnoL0A7h6Gca26GItDY
	e5TEsFbJ45IS77oLAwa4xXOYWaTWFCWhEXqLzn4EVJweJY3DBvplqXNH4/cabHgo
	cKMykQs0AFPcaAUp0H3uwjufXT0Oc2XRKXuEBHAtVHpylg8kqLyUr4A54hOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754315670; x=1754402070; bh=4xp2gYZGupEL+ZwMtOaQEY82TUiZLSJxzba
	58t6mX34=; b=ATInXplvwLnEc25oIgK7jomHThX/l9b6lolQZI3KAfK0L+qURqt
	GXDcU59SbO4KaFYOaEEgGneqlOa3UBbYPMyHX0rEPFE6S7BmntVXhIvyN5Oj+pEt
	dGZZbVx9I3E9hRvGdzgnagNG8Z9YqiSVsAQOAs9flecKAgX+WmF25bcb8JJeQ3nP
	B0k+NV31CbsdngWectD0dFLnrFh0s6aGH2GdsxY2ibDQ9qGphVWlF9hyhVknxkVB
	uIbqLHnbmDNB3dHZn3fkM5p9xbbQvcNmRyK5IxirvMecfCH/IZ55Q7i4B8USTNjc
	T71KWTPtLq5bIiqcBVMYnO3SllgdNwpHmew==
X-ME-Sender: <xms:lbuQaPIzj4eJLK-gBNQhEcghSXsQo1fNOk2hrPojwXTLZ7RiUtmyhw>
    <xme:lbuQaOocz8JKciiTaGDRkU3oEz5wpoETS78S_he4nzEYvx-g_2hCobht-9LBDr295
    pkq526DZva5tw6buA>
X-ME-Received: <xmr:lbuQaOK1gh-Fl518PGX8cXwPyXtmVLEEwzYW9gAs71MQBG2Xwhb8VKokwucgOVcp6nLjIne_q8FxQFa0oYCjCisUy_-uTNZqFGVi3qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepth
    grtghhvghrrghsrghsihesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lbuQaDQ6frfz4v3IObArF5V8ReBPtMApAsZ774alJyute2G0RxP9Ow>
    <xmx:lbuQaNvZ9UwczY6q4finYKfUTueNMaANiEPvBisiiwy0vU53X9KhrA>
    <xmx:lbuQaEbMhbxbqmlcNH3d8i0j6a4Z_yB8Pn9iNIAkwRzq-CrdXJPB0Q>
    <xmx:lbuQaDEfeHbMBYwM03F0sOfOG6RZS0QnjpbkZaGmbGYCUZKS69CNKg>
    <xmx:lruQaKrEUxr7VgkAQeYTgF58qWO8i2MmJG2VudEgvx34rKqoKfiz6_mk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 09:54:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Tach via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Tach <tacherasasi@gmail.com>
Subject: Re: [PATCH] status: add --json output format to git status
In-Reply-To: <d62a30f6-af30-489b-ab55-4c01ed3f60c9@gmail.com> (Phillip Wood's
	message of "Mon, 4 Aug 2025 14:49:53 +0100")
References: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
	<xmqqo6t1n2sm.fsf@gitster.g>
	<d62a30f6-af30-489b-ab55-4c01ed3f60c9@gmail.com>
Date: Mon, 04 Aug 2025 06:54:28 -0700
Message-ID: <xmqqikj39oq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 30/07/2025 15:58, Junio C Hamano wrote:
>> "Tach via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> This provides a robust alternative to parsing traditional output
>>> formats, making it easier to build reliable tools and automation
>>> around Git status information.
>> The writer is obviously biased ;-) but I find this a bit hand-wavy
>> and unconvincing.
>
> I agree this isn't a very convincing reason. To me a more convincing
> reason is that virtually every scripting language comes with a way to
> parse json and base64 so if we emit json with path and ref names
> encoded as base64 there is no need for script authors to write a
> parser to parse our porcelain output. To me the fact that we have to
> encode names using base64 is a sign that json is not particularly well
> suited to the task but it is widely supported format.

Very well put.  Thanks.
