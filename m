Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AC299954
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693212; cv=none; b=SbHvglNxdqHo8IjTNpZmZFeTQqr+rlrz30rQRLHOj2cxKV8EOxX8XaxAeWLwgBmf4iSh2eyKj2PSo92CaWLZyeJfhaLCJ76V5PTL3y4AXCwjHJEYjyRgnZf3ms9t+6eXeQ2hlm42ib1SuFypO6Hmk06FYiJEwjDgFrtGNaVcXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693212; c=relaxed/simple;
	bh=XUyI1hJeQYaIECWLZ3g+kCgr1ktfX7q5XUGoQ1Cqsbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPJ6hLD8GYU9KcHwrZCulwMXaonLW52T9uwAgzmxD7auJgoZKEhXqLnZnJUkNjaosgaM0T8h+A3WITRtLz8sB0rvVsayZL5pwpyp9XoMszk3SMqe0oFg3hqRC9Yb31cyC1pNR/BRsVqb2T6q4Jm0mH+2C5GYgQF4K+ODfjJM0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dVhOREda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivdz8V1F; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dVhOREda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivdz8V1F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FE357A01C1;
	Sat, 21 Feb 2026 12:00:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 21 Feb 2026 12:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771693208; x=1771779608; bh=EWDgZLdZhW
	m5QoGEqH9pGXU7V/0NhYo2SHlgcohE9Dc=; b=dVhOREdaWMaDrkjxeIKMjUSt/d
	Y8Q2rGG6BVxdlWeXwwyp6eDnXxh0phAI6hxhbNLPvyZywbwI2gecQazr/KxtfwkC
	nJzkdSrzUIQoboe7ZkWLczTi/qOBlpi2WYwywf7uU/8DlC2Uh7yBd8B76GaVLTiO
	HC3cZ3ZTIyUnYVWQXqFW35IRvc1VQo8dm9YYU4Kiwnq2bJoG3NgKBwvWUOzv0FEh
	DP1TAUllmBINmpvTIe752uvQOMLhky6T9pq8bEGp1MiNfbjq9+Vl3NIChUT6HaHI
	GD6TWgS5J0baY0AfafCZrHtjjaXo0ECCv5w3QnnVUBrAkzHkV2f8c+GyImwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771693208; x=1771779608; bh=EWDgZLdZhWm5QoGEqH9pGXU7V/0NhYo2SHl
	gcohE9Dc=; b=ivdz8V1F+UOholwg6WUtJhgUvnaG9md2nxjvAVPNRVH2TOggG53
	MEwBQBMfGjTTRHXdi/USmuh/f2V7lhHcUHGTB0XRQpWUUM7i7QlYmJ9HsKLj7qvF
	PV4YME3PvgsfTiJlNIox6+Kzdlz6jl1Am4bLLoAyioaBdsd47f+Q7iLDMX9Lg0/V
	sh183yC/X3IbiUXgCkrhj1s64R0M6PaSXrLJWc44OEvWN9Xe7Y41hCk2zd+VUGoc
	rPdli8SkeyEGTE+KUoD7JW6uwHzFeIgieBzlA8ZURLurCF/zYAopXUWWqWoh4PAr
	uLgZfHY/3XS7o6WdD3O35aSbWKS1TJQv11Q==
X-ME-Sender: <xms:mOSZaXHXeXxtBZqlW6HH910uVpXOfQNj9m5VQnr7Fiod80DzKAwapQ>
    <xme:mOSZabUBy3QOxbecejGp0WgavCq3PcEz2O59oAFpWcgaJQGgAuNcEwasER0MQhogV
    A3fVP7cN8I1zduFoGmLNMAiTh5wzImE7iipUScCNOQwhtPHdyIlAA>
X-ME-Received: <xmr:mOSZaeJlvhQRDAVeMJUHmub8PF7VJ-BsT5dfBG1q7GYfSytIbvOb8m-7ziRQsQ0FCMFWogDmZKo0czy1UFYn8NBicNGSL1kKFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhrohgvlhhssehthhhomhhsvghnrdhiohdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:mOSZaT97EqaDE8igtcRYUyr-N2XJeyO2tP_92EyFWLlRuk8speAZGw>
    <xmx:mOSZaZJJ7j2hMl2zIJifO--IzfwEhxDF6qZoYhZwxlKvpv2JwHwdZA>
    <xmx:mOSZaQnNvDFY-fPkrveX2IrShqN_9eSAlSkdKiInKe4pS-VsS4oMYg>
    <xmx:mOSZaVN20CcIh3lhtRZc6qKZuOoqXkRQ5YTWlbXiJUYcvX6eZF8NQg>
    <xmx:mOSZaZr6BNDZss83QEcXG7aUjSLtakH7qLfJW9PWsCWsne4Pntu2p8vq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:00:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Troels Thomsen" <troels@thomsen.io>
Cc: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
In-Reply-To: <xmqqbjjgiz3a.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	30 Dec 2025 09:37:45 +0900")
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
	<xmqqfr8uk61i.fsf@gitster.g>
	<a16bf8a6-2f57-4794-91b5-92615f184c4b@app.fastmail.com>
	<xmqqbjjgiz3a.fsf@gitster.g>
Date: Sat, 21 Feb 2026 09:00:05 -0800
Message-ID: <xmqq8qcmt4kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Troels Thomsen" <troels@thomsen.io> writes:
>
>> On Sun, Dec 28, 2025, at 15:57, Junio C Hamano wrote:
>>
>>> Fixing crash is certainly a good thing, but when the namespace is
>>> segregated and receive-pack wants to get updates only within the
>>> given namespace, would presence of such a cross namespace symref
>>> cause updates outside the namespace through the symref, defeating
>>> the point of setting up a namespace in the first place?
>>>
>>> I am not objecting to the new behaviour, but am not sure if it is a
>>> sensible one.  You _might_ be able to argue that an attempt to update
>>> underlying refs outside the namespace through such a symbolic ref
>>> should result in an error (i.e., a fix to the current crashing
>>> behaviour is to die in a controlled way).
>>>
>>> Thoughts?
>>
>> I think it's important that the symbolic ref needs to be explicitly
>> created on the receiving side.
>
> Yes, and that can cut both ways.  In an ideal world without any
> end-users who make any mistakes, deliberate cross namespace symref
> may be a handy feature to break out of the namespace jail on purpose
> in a controlled way.
>
> But if the symref was made to point across the namespace boundary by
> mistake, catching it as a misconfiguration may be a crucial chance
> the user has to prevent it from turning into a security incident.
> And that is why I asked.

The review discussion thread ended here.  I am dropping the topic
out of my tree now, but I do not think it would be a bad idea to
resurrect the topic that turns the uncontrolled segmentation fault
into a controlled death that calls die("hey, what is that cross
namespace link doing there?").

Thanks.
