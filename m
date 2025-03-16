Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E51D53C
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154824; cv=none; b=SGaesFQ8gjYJSOgFGNr5jlGSwF9CMJTTJbskvxa4JUDZuNYeURlISlvM91UtcjTxPZb/pf5o9S5qi82KmTrBzcuj11xzwu9GMeVm5G+JHbmGUAfmyvJdAAgmrB2xcDQjlyBW7e81MXBOKZXa2DArU8q98t94J67nGtadHFzvZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154824; c=relaxed/simple;
	bh=zXsXrNR75UE28sHslzISJMxo9LM5Up7U4V016YvRTXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TgSy4pJP94J6JUyQCXnJN66O+IDRCJ/WtvbFh0r84cH11EeLD9zYq0j/ThFuTknjujnT48rrrozAkudjdow2bCNzw3aCWp1X31W30TcH7I483R3/9rqI91Fw8QzR0/fuOyRQWlF3PoI5FrZR0DVR5xaMPqCR4iMB5S3Hc9zVO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zNbLSSOi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndAyFDuf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zNbLSSOi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndAyFDuf"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B62A32540164;
	Sun, 16 Mar 2025 15:53:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 16 Mar 2025 15:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742154821;
	 x=1742241221; bh=tSd21HLpf127oFfK3anzBEaqEPBJiCNQTYX50nYwMhE=; b=
	zNbLSSOiidmmcJZovLI56oISo0fcllYGtoyZmvfR6ytJy/dZ8txTppPqtSCZb6eT
	PFLmH1S/GJrZNFNE5xBK3lNAzFTbaSSdhRU0oUI3KEkWVCuBkX9zvr03ouRbsWS0
	3buOczuOIxiUuTgjkdrgE/pkCbPazx+KLAMfHkbW8A07aAsvtI2LzePyfedlIlfJ
	8nINHSw+8rTcJ8KeTow8GrRo+h2q+O2/C8w0yBdnt+MMNsRHZgNQ5BgF3GhpkuVR
	4mWhSM0gYD9TGDS5m1dC5JJDhDt7/eqBplrGaaNQrmZ0hBwSCqaRHmKSMVgWhI8J
	nJ0whm3iMOvuLE5ApVM8Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742154821; x=
	1742241221; bh=tSd21HLpf127oFfK3anzBEaqEPBJiCNQTYX50nYwMhE=; b=n
	dAyFDufJYJVwMOFvfIO4XDA4f6hzodP0zk9dpwR+SOjNFALhZtAYw3fOB1sJE5dA
	jiTaVdNjCZGicNnDBBcNRQOwSHomQcD9V7mGzRIZ/Y0bjqh3JOXVxfJ9KE+iJCag
	dPfeMjUQoU15rM7Z+7eoe5dJhEzYiT8wY/9y+8Qf2W4DjD29Gny1mTiWz/TYeqAr
	FicJzP1ZOcSnSwBhuxKhnxdWKy91ZnSm/ZrdsEcIvJWaKzZ3aHU17inPao9FlBin
	glNTZzl62+MLegNJD5x2+LIKvgIwyHPqAbndT0gxBfovA63198f52FaIjuEv56+p
	RqGKc+KM2p1PsPh7Aczgw==
X-ME-Sender: <xms:RSzXZ60Awu_tEeaVdZniMrV0FWfeHqHZyVW34JwXi2rO9ObKYnmVRA>
    <xme:RSzXZ9HTp0-ffFpvX5dvrHt3OmC1Fh3FHQbkv8q6ODMsyTBDrE9n16vuJy3wefssR
    rrjBJwRjV1OVHrXFg>
X-ME-Received: <xmr:RSzXZy5OzyzxfNnZ-CFG6_L9lZ8Uhd-NZTPZ-WeZ09tOEi6yVUyiYEQVTx120oxBsqadiBxDyxJmmkQAGemz1AUrOKUxgexyOjBbelY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhgrshhonh
    duudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RSzXZ70JzY_CiFR0bci-4bgunB6MRT-m54jtcuL_ZbkU1-1oVa8ftQ>
    <xmx:RSzXZ9G3jI2oPsTHkZgeyIGRIkx09V42bVxhrgbfbBTDw8QIxlf8cg>
    <xmx:RSzXZ0-mouWv0LTj74z5lGBehohBivv5ML1XsKlGoO_sS443N1537Q>
    <xmx:RSzXZylbHS0Cr1wtC3RsvG65etq11IwTd2MLXyhtijUQ76-a6b06qA>
    <xmx:RSzXZxjGRQWCtEUf0Eh1-iHz2y4CmXRUCIeir_WIF7HXAks-lZc42lz0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 15:53:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jason Cho <jason11choca@proton.me>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
In-Reply-To: <8c9a3966-2746-4619-9f77-ca95797dcab8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 15 Mar 2025 07:38:59 +0100")
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me>
	<NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me>
	<4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de>
	<xmqqikobdz7l.fsf@gitster.g>
	<8c9a3966-2746-4619-9f77-ca95797dcab8@web.de>
Date: Sun, 16 Mar 2025 12:53:40 -0700
Message-ID: <xmqqiko8da63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Am 14.03.25 um 23:28 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>>  t/t4055-diff-context.sh | 10 ++++++++++
>>>  xdiff/xemit.c           |  8 +++++++-
>>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> Oh, I love a patch like this that is well thought out to carefully
>> check the bounds, instead of blindly say "ah, counting number of
>> things in size_t solves everything" ;-)
>
> Converting xdiff from long to size_t is still a good idea, I think, ...

Oh, no question about that, especially if the number of counted
things are somehow proportionally related to the size of in-core
memory regions in any way.

What I do *not* like is the recent trend in the patches I see.  They
stop thinking there once they blindly replace int or unsigned or
whatever with size_t and the compiler stops warning.  Even though
compiler warnings can be a useful tool when there is very little
false positives, they are merely tools to improve the code, but I
see more and more confused patches that seem to think squelching
warnings is the goal in itself, without thinking if the resulting
code is actually improved.

And I didn't see that in this patch.  The patch was actually written
with real goal of improving the code in mind.

> but
> would be lot more effort and thus more risky.  

Perhaps, perhaps not.

> Comparisons to upstream
> would become a lot more noisy as well.

I am not sure how much of that matters these days, though.  Are they
still active, or is the code perfect and pretty much done?  I somehow
had the impression it has been the latter for a long time...

Thanks.
