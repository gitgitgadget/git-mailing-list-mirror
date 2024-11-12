Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6895234
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373635; cv=none; b=imD2S8nlffegoCgrtMqA2UxFkuhY0yu3oVXusgrlMQPHvSvGg4r8RaBtYiyLnZn0RxAqZ0Gb7jvAAmC9M05E5+MG8zmT3b6c6F+V8kFhNUli1j/wnZoxFxTfPkdKUnm/27zoxlIMMtl64y6CSzw03NOCcC4GoIdqaJbUeC/BGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373635; c=relaxed/simple;
	bh=px7N2nwrAR3J1Sqde7MPLF1jK2ZnzoVo7ScEp2/R84o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8mulkLgkBdfaLHDwnwSLkSjMfSldRz6yc86L1wHSQaHvNVYxk47HenBUFTY8lAFpNtd0BZr9bZP9UwqFlA5S0/4hArTKsZXr0w3LBY4dRWmfIq0CHQlzPCSxb/+/TAgSyJxExrPMJcmhiAx9AtUPC1GpKk+8hAP7YKqFZPO3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nIt/XNZy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HNDaIFv3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nIt/XNZy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HNDaIFv3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A3EC913806F1;
	Mon, 11 Nov 2024 20:07:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 20:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731373632; x=1731460032; bh=YJe0Z5j48k
	Ybg9KJoBANrMnSsYW22j8Gpw4Hs1oQHAo=; b=nIt/XNZyGbNi1JcaNlXSWbYKei
	ucJIxXLghLUflNqFLzunixSd8/oxBFQliuftRu0TXwSdozeM9buQj+u29tL7GIA9
	YPAJ6EJzC84LjSQrEHkn22kozyzfUXvzQVIIxlGgmupC/AmmxhwYoG3Yb6nd4DFx
	ScJD2/o/er57XiD9fKj8xjWGifcgCgVz/mZr/FtYbvsMB51y5t0uPbkKhqoDJlVm
	HJT2em0yj7wI5JZMw0CFbb80uymYVM47JvcQYwxOd+8N2CxkiTHyPcqwSnk5cjJ/
	OuL04uzK+0IkcoFo6J5lH1WGVpkRQbxjG88dtlrgdfzDW1BJcq13h8WfyopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731373632; x=1731460032; bh=YJe0Z5j48kYbg9KJoBANrMnSsYW22j8Gpw4
	Hs1oQHAo=; b=HNDaIFv3P6jVF8gf6vW2Ean8sZV4m37JBjYRMwr7mHhWSoTdmEj
	9laqCb8/eRXUhvnXpgMQ08toOpB9sTxZs0QKiK2YPuq+bm4WCYkonJwEHS2327rD
	coj3dMbG/C1ZhlMJ2764INxrJuGs5hxjNsh2z+piZsmaYcpSk3pGrTPyvc/jMQL4
	2pivOTRsYz/LwSJEhBZCQ7QyKBygnZ/F0vShUc2Gb5hP/41HPquSGxKAQAS2bHqN
	2Ba5S8Av5ZxBkPWaxuRqZEeshXClnME8jYdpiGqsoFz1rowtbMtMi0s7GUBdln58
	sa87j+KOjkYQfwk/pgFm30hKEiBl2EAMeBA==
X-ME-Sender: <xms:QKoyZzeVCdQLi7OKsLxuJ1oWwkxLsynBvqPIntgPS8c6TfgWA7lRag>
    <xme:QKoyZ5MOzmzAWbyOUWy9KK06IgKRLRQ-tgXuWzN7bSBi0GXp0gJkh4hr64l8ls1Qc
    zWRrD13-XzcWuPEDQ>
X-ME-Received: <xmr:QKoyZ8ieuFVEluPL6mTd0EI9T1SUNKUP1iNGuHPEokDUK6gDL1IduEmEIZ2PnbcKV3F-hXwWcSLsM2VfH8qJ6lCRmv4ZN3CKGttq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeite
    eujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QKoyZ0-3hnOD2eOY9m7Jp0DXqG3lR8sM9IDJQo06xfR3Ceb8XvmGgg>
    <xmx:QKoyZ_vKJPTh7k7uJzXrw8k1G8Z9YbSX34gTtZhQCMZROhtoxn4c1A>
    <xmx:QKoyZzGLUkxvxCCyuIhPt3xfEQ3sgKrSjg4TBHuUQIf3FPa0Hp9tEg>
    <xmx:QKoyZ2Pb_OloBJgYTZUpEyLW7V0hdHLBkqPdpeJmeZ-WYsc0OvBfuA>
    <xmx:QKoyZ_LF1I1imGpESrTT-NVL_epKlVv7IyAKsjbaqAKFK08Qn3NFPfOI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 20:07:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #04; Fri, 8)
In-Reply-To: <20241111235337.1691851-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 11 Nov 2024 15:53:37 -0800")
References: <20241111235337.1691851-1-jonathantanmy@google.com>
Date: Tue, 12 Nov 2024 10:07:10 +0900
Message-ID: <xmqqcyj18dkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> * jt/repack-local-promisor (2024-11-03) 5 commits
>>  - fixup! index-pack: repack local links into promisor packs
>>  - index-pack: repack local links into promisor packs
>>  - t5300: move --window clamp test next to unclamped
>>  - t0410: use from-scratch server
>>  - t0410: make test description clearer
>> 
>>  "git gc" discards any objects that are outside promisor packs that
>>  are referred to by an object in a promisor pack, and we do not
>>  refetch them from the promisor at runtime, resulting an unusable
>>  repository.  Work it around by including these objects in the
>>  referring promisor pack at the receiving end of the fetch.
>> 
>>  Will merge to 'next' when the CI breakage fixup is addressed.
>>  Breaks CI (with a known fix).
>>  source: <cover.1730491845.git.jonathantanmy@google.com>
>
> The fixup in your source tree looks good (verified at
> https://github.com/jonathantanmy/git/actions/runs/11787543288).

Thanks.  Will squashing it in all it takes or does it require more
(like log message updates, perhaps)?
