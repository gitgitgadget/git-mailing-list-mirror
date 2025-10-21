Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45634B673
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067141; cv=none; b=FDLnwl1ymt2k+VcpCkEKQwoEIZh6rKGdOmw3zGYGtTNXSmMfSqewsf7cU3NT/ly7XJaIsrWSG+sMEqMJwqaJgXVcyqjTfQDqoV1tVpfBzTdMxjjcYqJOABaoUq70PqHudMB1+YXB2mHQIlt9JQ9nRnFBmG/ukWiLGX866RxAFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067141; c=relaxed/simple;
	bh=0cXMfUto2G3J1hqK91Vmx/bo3k84OJmlFGXyEnvlTUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l8gsST5t/NIrgRFd/huZUg62/R56J51VSaXLmcs5EeoohesByfG+LSjVtfs2SmXjmqWYDfdFMSSOK0P21sabsCxJQ0W5enwcVycE90wToEEnlpzjv3IDk9dFeS4lVLFkiSsiVwJY7Qpg0ulQ2thxuLsEkhz6Gr2c3qJC4cUG5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O4U69xyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5Qa4Zj1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4U69xyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5Qa4Zj1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 934BB7A0102;
	Tue, 21 Oct 2025 13:18:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 13:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761067138; x=1761153538; bh=f+mTKeBxyI
	OZzr3ogKDcc3WsG7eRUdhSfwD6TzWi2Vg=; b=O4U69xykt66Os6TKbgJhRTHAdu
	Tw0bE6oOI3dxm4x34dhVL1UifHNcDaJ1jjJ0ebWF/sfyWz6jte6Ftg5fluQtAPa+
	TFq3XthoIBDhQwYc2uivwIQ3hCUV1bn25Ei8gwi0MZTDuftYkeydVQ/553Q9aYMb
	IFBneSnUbZbH9p3MVgB/UPdA1u6da/FK4T3aaxE7awVE/SYGQLC6WsXG84a0U6Wq
	l2FnA0XWYNVbYFNiDgYFjzgQ3BojlIhw2RVxq1b+lB1CCqOxGZMqV5OSCZc6aeB3
	vABrcOkyvK8Ne1ehI6zuqE5BkKWc16+0iFEmlNyxoXGJb0qz1FGh0JkTOobw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761067138; x=1761153538; bh=f+mTKeBxyIOZzr3ogKDcc3WsG7eRUdhSfwD
	6TzWi2Vg=; b=R5Qa4Zj10Fl6nMXwbSwLB8w1NKhByNNlLTG0SJHVHIbjOqM1UeU
	YIPlxJBRpTyo2ib7yiPV3fnFXctATDTeeRJJFlMzJH4i8bxWN3dhP3PTRRfJTgkH
	0WCv3FLejc1yZnbGV33n80ArPfou8/HR+dmpzS75SmBoQJnM6n+lCLL4ndeimKhb
	kdwedbtwOBn2L6J7ivJoFx5LW7qzU9h3YLITWQpEJWI7gC2d2f15dA2l7jENUrAn
	m9Ovvbmn8koOiUTYg3C+ZXeWgPCjEM9Ar7AOAiLhlQ0Q8mO+g6nLAwgobHiTrqaK
	QIUTBYKBrClWYoLsqfEY1OAf6bvPkYTolig==
X-ME-Sender: <xms:gsD3aGEhs1dwDbhbjnaWlAz8TJSofHe8D8uGXaws3xWgje_fStLAIg>
    <xme:gsD3aONC20U-ifAdgLJxm3b5sjNnRBa3n0TxBaYN0yXRkLLVfo7ylmlCWPVNq8C2u
    _bv5AEvo2OtmR9acDbq5XBdoT7L3woMfLX_nHmUQ9_8Xmm659gt>
X-ME-Received: <xmr:gsD3aIf_yeIHNjnqDoppsXzdUA05Cj9Qe67W1CmWykZpHya7b22_wrF86L0U1L934_g8uxMd0swKo9w3LxE3Ip84t4WNqXOY8eKC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gsD3aLtAqjM09qlsCeUNIKPWcBHP5wSJtuzAiQyQXHcJSWoxvjW91w>
    <xmx:gsD3aJlOHwGKRlHSzhH2H5Hen4sYj8alnt3TSSF7uvCMqtjrxAwYMQ>
    <xmx:gsD3aNxG-sHtbhcmQNpf1SbKr2v3vffW04ptKvbjEzMpTbv6VCixWg>
    <xmx:gsD3aLMbQ-RY6eB31P83i7g2Y0PSpmNLlk6SI4FuZjlS1fVeQD4XKQ>
    <xmx:gsD3aK-6PwYm2R1LiO7towsXuvccaq3Wk7hNR86iJGTBJGAtUwQHSE2s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 13:18:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/9] xdiff: use ssize_t for dstart/dend, make them last
 in xdfile_t
In-Reply-To: <9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com> (Phillip Wood's
	message of "Tue, 21 Oct 2025 12:32:55 +0100")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<1fa9a7d7d1c309f2f651da351ba7bc0b36272d91.1760563101.git.gitgitgadget@gmail.com>
	<9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com>
Date: Tue, 21 Oct 2025 10:18:56 -0700
Message-ID: <xmqqecqww4u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/10/2025 22:18, Ezekiel Newren via GitGitGadget wrote:
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>> 
>> ssize_t is appropriate for dstart and dend because they both describe
>> positive or negative offsets relative to a pointer.
>
> Isn't ptrdiff_t the appropriate type for an offset to a pointer? ssize_t 
> is not guaranteed to be the same width as size_t (this has caused 
> problems in the past[1]) and is only defined by POSIX, not the C standard.
>
> Thanks
>
> Phillip
>
> [1] https://lore.kernel.org/git/loom.20150207T174514-727@post.gmane.org/

Thanks for bringing up a very good point.

We often consider that a function that yields what we would normally
put in a size_t variable, when we _know_ that the return value would
not be so big to exceed half the range of size_t, can instead return
ssize_t and use the negative half of the range to signal error
conditions, but as the cited incident shows that it is an easy
mistake to make.
