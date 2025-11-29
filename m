Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B21391
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382297; cv=none; b=etMx9nXjTIXAE9e0qmTWtRDE13aCN13qGl3Yp97Q+1gXHmDtWQU3GcuCQGLAcEypUMtF1GpD6UX+dP+a/s5hUy68gCWvKAfzrkHezrSNux+uwCesS4XFsJ93JS68ywYDfs5xOMAwh+mdQO6VNK5h8tJU6iRG5oImTNyZbZ2P9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382297; c=relaxed/simple;
	bh=gr/s0PK+NO/+KVXfT7c/jMWqfnolZxJE1EFCmrHjwUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2TN5o3XBCpMy1Lt29heYIAIy8jYZPbCcuV2Z5UvBllhcYupWA5GCOVm2JOzAbiKKJxKR0LxPdZGlFCYWsHN3X8S8q2Y6j2JZDHKLYdgbNnfLsRNeNvKeePKZpgK2aEG0uYwTPn20EgkgXCzqSCeFVxXLGMr2NraN02i9EViQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C4Wrb7iX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0v0hmZ7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4Wrb7iX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0v0hmZ7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AF5F91D002F7;
	Fri, 28 Nov 2025 21:11:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 21:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764382294; x=1764468694; bh=ANr8t7cmAT
	A8qGZvBplxzR4UhkNpcwaw9Z8T2DK1nec=; b=C4Wrb7iXFxtr6kjajo7PoUY+Fk
	4aaokWncHJ9MXOCi9ZljE/kUNz2DH+PwYQ3xQ55ka+citAMt+K5XeJm01sAuzaZt
	reTJfKnCU7JxDndYtZODSfV6D4OjF8IyRxKUhP6Z4RRmlGZsA7bm0Bx9+IPlOdtq
	1v+I0EnmtvMJhccQxebj3VgC97LpLEmyoOobKhRQOjWZUxWWSHiLxIew2n0SBbVu
	hclIsALedriKHM4Y6LPjqfJYqCVXWj/8Nn7/6jMuwHUkiNgoVBJPrFHq1IXoeS68
	J39bRc1ROPHShalShuGU847ZhgRu/ez4b6JHqQHPzmaoby9NSSsYY7MRZ0YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764382294; x=1764468694; bh=ANr8t7cmATA8qGZvBplxzR4UhkNpcwaw9Z8
	T2DK1nec=; b=a0v0hmZ77cxIGjWMHFD5fre4qHitF9/qmSogOc9TnsWPz3zm432
	NWf47Yo1Nr8WV/ZPVj5jo4JO2kxY4aZacZNjdTkySj/k57Alhu+UU+5SEIgFdrHK
	RXxBGmRHlXdi5SpvxT47JxOHPb79JfuM2vrhGlfs9Euae3Yk8EUR6jHhdAArLJr3
	R0H5JbElXNdnPgZ+Gk+bf/jHP82RhLbs/Cr0X7kQ0z+lBlIXpy4ZecGSLzTrZXw9
	mANOD8KSwfSJQBYb46Rgcdp/NtXpD7V+2GRo+Rq0t5JL+oW8NBddU/Jc6NJgsUaV
	NBswUTrKOfTR+UV8zv0zGENQesL1XTHBIgA==
X-ME-Sender: <xms:VlYqaddqvgPr7D0nLuug3TGpL3gZ7Ax7Jc2etoBNgsGWHlEpH2M8Jw>
    <xme:VlYqae7otZN02JwjWtaLv9GpKAJ_bS5nJBHCf59hRcL2IXlMol4XZ7DlaA8U5JysO
    3YRUDTODky2eyoxfKdgsOfk4KmRLxPW2crn6u5NKWLwlsFW9oJ78A>
X-ME-Received: <xmr:VlYqaQVc5buhCUUyFCsR5BUD1KBIZytccINd2Xv82qDHjcypa2S1LW8o1JgyK_9xmIWSuBIwgZRXzDC8ZizgS-0oHVTaPsQ-7BTG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegrnhguvghrshhksehmihhtrdgvughupdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VlYqad4b3h-YFXVRl5F8ocStZBGttUcQJGAcAwKzoTuz4muXuEGqKg>
    <xmx:VlYqabogubn8456tHbsvqSyjpZCiEpcHll_6W4Fo-krwpfB2piPtZw>
    <xmx:VlYqaQkq4m2f_QkJrF-SAF-0i2Oqjde59GrN0pzY82BHXFe0yzmN6Q>
    <xmx:VlYqaXNyZJcwTpss8H0tHmwZFnpmard1MX7pNGJWPmWoQgpWNTx0Hw>
    <xmx:VlYqafA8uDttsXIkJpPaO5lgezEZ3Mrmn5RNT8TLTAuB2axxJYDniUsn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 21:11:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
In-Reply-To: <xmqq8qfpioln.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	28 Nov 2025 18:01:24 -0800")
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
	<xmqq8qfpioln.fsf@gitster.g>
Date: Fri, 28 Nov 2025 18:11:32 -0800
Message-ID: <xmqqwm39h9kb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This dates back to v2.52.0~4 and is clearly a maint material.
>
> Thanks for finding and fixing.

> Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized memory

Let's retitle, as inproper is not a word.  Is

    Subject: [PATCH] last-modified: fix use of uninitialized memory

good enough?
