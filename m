Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920A1A0B15
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771747088; cv=none; b=O6L2rAXf9KAxT8VcLXzfsT9K8/VRj04RxYokW43u/VK9DKdzZGfdlfIvCcMn+Ee5nGxjSFzWJv9lVlj8g7CENqvo78pWfus3uEaUZDBXG7OUldZ2rpBXIIKA5WJXR8eaPP4snfs5rzVBOduDfHv8NCkYLkwKJ3UCHo4pLKbbC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771747088; c=relaxed/simple;
	bh=ByVQRuGEsX+xKbARWVP1eLURrbnsJIHnQ0QCbgp7j40=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N6K1nBZ5vsI3mC6dP37mHcoCAGq1j2sjq4Hi2B2p5iPpUrTL9FQl9BxqwKYncVBkjx+rsvdYPnFBZOdxwVZn/kwiHH/CPkVQC3oaVwjy0WDZwClf8HS3eAIvkMTEhjYbqgROFp5IU1MJQg1JgAgVwrr/wMe6DHoqA37040bCd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomsen.io; spf=pass smtp.mailfrom=thomsen.io; dkim=pass (2048-bit key) header.d=thomsen.io header.i=@thomsen.io header.b=ccZ9uGBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pqvSbwEF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomsen.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomsen.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomsen.io header.i=@thomsen.io header.b="ccZ9uGBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pqvSbwEF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87A4C7A00DE;
	Sun, 22 Feb 2026 02:58:05 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sun, 22 Feb 2026 02:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thomsen.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1771747085;
	 x=1771833485; bh=ERn9rHYTU3u/f8rPCiPTpXmDMPH/XWBeG4bc4h9ICPU=; b=
	ccZ9uGBpMyNhLhxGyA4wYo6tROvIqvlqVYB5miXfsNksmS1Yqft4sx0gR7wU8cIw
	D822yj0oblxnPUUDg8GzJuVFS4+Rm7YRT5objA0W2moAenwHUtwkeOlGsvBCqQiF
	bn6qZCku1cKRQ8nQQkjA2qM3DPUpeu6V4m0SKUQY0jMtmeZccd2BqMOjfzMiX4B/
	jXSLcDSo3X6kZe45ILQCXNUOZB+P06PTGs3E+o7t730sfF1+ljXkxIKD1mIvfDpN
	qaXrtK5oth2YgMr2Bg8bBWudSvJtmfRksVc5oXMaEiC44oykRUgfebygCcTNwBsV
	FxgbIFmKd+Qnv85YwXUcrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771747085; x=
	1771833485; bh=ERn9rHYTU3u/f8rPCiPTpXmDMPH/XWBeG4bc4h9ICPU=; b=p
	qvSbwEF3OowceG5zHd/y6ChimMvVOclg1rUmipOMlLI05StY0iDrC5PnYjGwUVI3
	I8QCMHa0tUuiYer5xSWPas+50JGYgpqY8ZjW/m58b1HF9+nuLW0humn1JpsjZUlP
	H1yjcmG7dnG8xQkgONx1zyhk9jeRcuX2hVdcgq/380VkB0ZZsMiinr5DcBvjOb2t
	ai+jpkslpk8WVSF1s87oq1S6Iy554nRV7hrR2QmTziJPQVR7LH+TMmR8PNzR6/Eo
	co6B1X1o5TGt+15OlcfsHM54el8K1UcbE8RmL3e4dhaVI7sNZ+mkNU3h0gZFeQ0J
	L5DBC/nIHPUqlq2sp2d0Q==
X-ME-Sender: <xms:DbeaaRBJMkQgFYRX3sZIBogEqN2NeViC5-CDExoClXEEBLHmwcBHyg>
    <xme:DbeaaaVPXE2PKXzFxd958VkbbOhvUsNasmcKvUy9OFRhq49wC9-VCPeE_3y7ju8M6
    pmuD3-x79viMZnHhJJLV9v1spgRTNGFzqpMqAbMW3UZLxL4YrZCqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvfhrohgv
    lhhsucfvhhhomhhsvghnfdcuoehtrhhovghlshesthhhohhmshgvnhdrihhoqeenucggtf
    frrghtthgvrhhnpeethfevhfetveeijefgtdejleeiffeffeeghfffgeegueelheekfeet
    vdetgfffffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehtrhhovghlshesthhhohhmshgvnhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DbeaaecxaADWW47qQQwQ7tWXP69Qfo00fwbYJ_GpIJPW784D6P-gWQ>
    <xmx:Dbeaaf9M8QQIQ9c2jfdJ-KSeEGq2DiE0c4k3fz61-Lxjlz9Kex8pJQ>
    <xmx:DbeaaSleYG3pVjmf1CMnVAXSLxm-rOQeV9ouhm0p40raMZ9fRN-2Sg>
    <xmx:DbeaaZ9u_oxmJrziimA6BEfAUI5wbdrPMEHvj5N0EOwdcvpcNYRxyw>
    <xmx:DbeaaU7B9cl_LWLd5dfyCgkePKDmH5k3o-Cx8-cB3JAGqYYGM7AGdJLL>
Feedback-ID: i64d840fe:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07D1518C0067; Sun, 22 Feb 2026 02:58:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABPpY6NV6337
Date: Sun, 22 Feb 2026 08:56:55 +0100
From: "Troels Thomsen" <troels@thomsen.io>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <ead4041f-bbc3-41ea-8729-9534e69e5e83@app.fastmail.com>
In-Reply-To: <xmqq8qcmt4kq.fsf@gitster.g>
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
 <xmqqfr8uk61i.fsf@gitster.g>
 <a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com>
 <xmqqbjjgiz3a.fsf@gitster.g> <xmqq8qcmt4kq.fsf@gitster.g>
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Feb 21, 2026, at 18:00, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Troels Thomsen" <troels@thomsen.io> writes:
>>
>>> On Sun, Dec 28, 2025, at 15:57, Junio C Hamano wrote:
>>>
>>>> Fixing crash is certainly a good thing, but when the namespace is
>>>> segregated and receive-pack wants to get updates only within the
>>>> given namespace, would presence of such a cross namespace symref
>>>> cause updates outside the namespace through the symref, defeating
>>>> the point of setting up a namespace in the first place?
>>>>
>>>> I am not objecting to the new behaviour, but am not sure if it is a
>>>> sensible one.  You _might_ be able to argue that an attempt to update
>>>> underlying refs outside the namespace through such a symbolic ref
>>>> should result in an error (i.e., a fix to the current crashing
>>>> behaviour is to die in a controlled way).
>>>>
>>>> Thoughts?
>>>
>>> I think it's important that the symbolic ref needs to be explicitly
>>> created on the receiving side.
>>
>> Yes, and that can cut both ways.  In an ideal world without any
>> end-users who make any mistakes, deliberate cross namespace symref
>> may be a handy feature to break out of the namespace jail on purpose
>> in a controlled way.
>>
>> But if the symref was made to point across the namespace boundary by
>> mistake, catching it as a misconfiguration may be a crucial chance
>> the user has to prevent it from turning into a security incident.
>> And that is why I asked.
>
> The review discussion thread ended here.  I am dropping the topic
> out of my tree now, but I do not think it would be a bad idea to
> resurrect the topic that turns the uncontrolled segmentation fault
> into a controlled death that calls die("hey, what is that cross
> namespace link doing there?").
>
> Thanks.

Do you think your original concern could be addressed by adding a note
to the security section of gitnamespaces?

It seems somewhat relevant that you're unlikely to create a symbolic ref
within a namespace without first consulting the documentation to
understand the ref format. Combined with the lack of interest in this
thread, and the fact that no bug report was filed for years, I suspect
this feature combination is rare. That's not a good reason for a bad
default, but a symbolic ref can already point outside a namespace; you
only can't update it.

If I fix it by rejecting updates as suggested, I still wouldn't be able
to do what I wanted in the first place. Is there a better way to propose
such a change?

In any case, thank you for your time.

-- 
Troels Thomsen
