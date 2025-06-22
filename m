Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892E2745E
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750565926; cv=none; b=Fdd0zWUMeYmFLX7HSXzSTOHduQOSwfMcONXLv43HivrTmavkccTp9JQJrF5ppaZrj70pQRjEgCGe2rEem6iYrOcame8PI5R3ufdpyF5mobk+MvVt2Cy1QnLT6CKP5eU0fSaW5oXolpsUZvzuhCv6dArv0ZpQKe/9pVPYIF41gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750565926; c=relaxed/simple;
	bh=13aFcUT527o2MTsAu0I4ruIljbK79Hw8ifyD8jy4JeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPyl7sK7KL2gul9/DCacJXShCzKunG4nRFH81KrEJtRdqSLLEed+IwPa0l7x0P4UFDCm+E8T65FmjAGOYSQhnuWSzQ27sbNhHupUomLvMmiLYh82w8kTDRAM5M3Bg1tBenRpcMLUroH9mCI/KxIy8orT6JwBw5lIzTX7I/cW/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G94N8Jib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBa6sR+N; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G94N8Jib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBa6sR+N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CB0511400C8;
	Sun, 22 Jun 2025 00:18:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 22 Jun 2025 00:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750565922;
	 x=1750652322; bh=8WoUMBuDqlW/x/vWlMaLafF0aGjWH8iFTXLjvhc0AuE=; b=
	G94N8JibnI0daZlPUjXIU7VmAQdDali8E/vtnMWaePSleAq1fLWozUmY0R1OkTU/
	bc4JjdSmUnCITBc88FFPfYtaUuUjXDL+PR/KPeu2D/tjxNIhh7+VeGT/lfh0KWT+
	aLzRuzyZFbF3gQMH3UuxT3OYS9Klvk2D92Yosaixm0FLn79Vg4dCP3juvtZ6EfM1
	ZJ5o8KyVj0rPxvZcT5CKInzPxSPPj+Nan0wESacrjFqn7Qie923zroZ0vTx6E51Y
	wYQzWzc34J8rkJr1nUErA05yUaA0uUJL2RaasbPZL6xqKPAHwgZMxhSeUAEZjokY
	ZDpWjwBHYrLVHCZTER3Eyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750565922; x=
	1750652322; bh=8WoUMBuDqlW/x/vWlMaLafF0aGjWH8iFTXLjvhc0AuE=; b=c
	Ba6sR+N+C+Ent1HMaS3Q373mzHd5aNIVH4L3RCH4dTq6FZb/Z4bfTOsCJWJvYskd
	VXWHlDJhnQngQH6cx5G/o9Xu07tdVgJjWEPodr7oEncN0837xaQ8X7at1+mjcOjl
	clE6xRlAKl94n4xhO/TgndmazcyIpXKJB4ICJs3grfPY73mi9BtX2yA5brQHF0Jh
	a3ECWcfWVUxj/uc+Z67B2JfezvYfg8QtwJ5qX5Z1Ce1q5IrOCJej6PQues3lnJz2
	0cHfKh0rVnhRn9dEgFghKFDKDgGow96h892eSknwfRq3yNQZmASXL+aeioMHfjBJ
	YZA30Z/sP8FF8W0Xdi6pw==
X-ME-Sender: <xms:IoRXaFqJfNVTqWwDdi6L72R6eZAC-55V3h-hScrxEXm62GQwKx4x-g>
    <xme:IoRXaHpzW7xbi7XgAO5A-2Z8wcko73aVXUKy75E4gxHQoCnmEhS8lDeA-q-Axm3Ee
    VRmUKZkgq1tr-WLhw>
X-ME-Received: <xmr:IoRXaCMfiJRBGuVcFWsEAe4uyhfytk1zQ2hyK0j3XKsA1Qf7uqHzgN1hb0upYtlkWgrlTaoVWEzHLDnVftli9SSbbK47Y7ThsU5JwIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptggrrhgvnhgr
    shesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IoRXaA4gFt15r67Dw802unu3jdDFTLoxVwVg77I-F06a3Jfii-iLnA>
    <xmx:IoRXaE7-Y_CfHlZ0DX4W278AFP6cwk3bD-qzMxvDFRKr1utGEqIB5A>
    <xmx:IoRXaIj328VkY1lSwhjZaCf9rx_ITfzzbf_Yte0zSuYy1h87L3eGWA>
    <xmx:IoRXaG4mCnPZXqSNT9PAMpF-P2zuO4SapNSawkI4gr6o1nTmQ6qE4A>
    <xmx:IoRXaD9kU5Y_YGtRVplilNW8xd8mKe1e4NVJfVPM2m_2kP0RHMhP3HDQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Jun 2025 00:18:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFC PATCH] coccicheck: fail "make" when it fails
In-Reply-To: <CAPig+cRtSzjA=P_-WhRw9rRmTmFMGibKuHYn_ZuN935fcffveg@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 21 Jun 2025 04:09:40 -0400")
References: <xmqqwm97bv7c.fsf@gitster.g>
	<jyof56xql2c23gyckxzmry4smkt2uk64lyofqxk34olzn7evgf@ltq5tiqo4qyg>
	<CAPig+cRtSzjA=P_-WhRw9rRmTmFMGibKuHYn_ZuN935fcffveg@mail.gmail.com>
Date: Sat, 21 Jun 2025 21:18:41 -0700
Message-ID: <xmqqa5608l3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Jun 21, 2025 at 2:29 AM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
>> On Thu, Jun 19, 2025 at 08:35:35AM -0800, Junio C Hamano wrote:
>> >  coccicheck: $(COCCICHECK_PATCHES_INTREE)
>> > +     test $$(cat $(COCCICHECK_PATCHES_INTREE) | wc -c) = 0
>>
>> Definitely a nitpick, but I think using `-eq` instead of `=`
>> and might even come handy from a portability point of view.
>
> Junio has previously expressed[*] a preference for `=` over `-eq` in
> this sort of situation.
>
> [*]: https://lore.kernel.org/git/7v8v3m50ds.fsf@alter.siamese.dyndns.org/

Heh, you have an infinite more memory than I have ;-) 

That one is 12 years ago or so, isn't it?  Not that I changed my
stance.

Having said that, I suspect

    ! grep -q ^ $(COCCICHECK_PATCHES_INTREE)

might have been easier to understand.  We do not want any file with
even a single line in it, and "grep -q" knows to short-circuit
(i.e. if the first file in the COCCICHECK_PATCHES_INTREE list is not
empty, it does not even bother to open the rest of the files).

