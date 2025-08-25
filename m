Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251223BD04
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136767; cv=none; b=kyxbxk39s/eljBP/7AifbKI0+GSv/szckmE5QVHPvPOkeUbLd0fFUBEKr/6yo/uSPX4dcL3U5N0mVa9DGwkdswgo9oOxmwuL3Q6a7Q2YcIxed2W+a4uEJRXMKh65AAkpm3NkwcGAEbFRpvm+aeb2k+il3xZp6yfjLcVA424WBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136767; c=relaxed/simple;
	bh=W8JwFoJg4nevOWqCJagvdN/lKS0AJY83r59PEwBysBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6KdeJQKVXyxPq+uIR8Qc/1t1mu/SORQ6NdPLU0p7k6deRaI73aQ8iZHA6JlOTCEGF6mpotbyNimJNP1Cyggo1Di2/PiwDFDfPKBOxori7wnnlULA9aBGRkqYS+bwLli57NU/2tn526uBNOTFDCMyGq6BFj3RgF5EpVybPwweAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2/BPJqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czOAxUKk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2/BPJqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czOAxUKk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B48C7A0127;
	Mon, 25 Aug 2025 11:46:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756136764;
	 x=1756223164; bh=US/XDgonTIZFryD+K3YgGxe1e3seLeLWNuEZf4Y6gHM=; b=
	e2/BPJqHUFATe+DTwViVo8NC4LNvpZWsStQNuASN1h6xLTNuKhVYeC3iyBDUfo9y
	UM2O66xQ9Ipu6IITe7HZ8HBkR/tZV+fJacmIeTM1DItnIVhSjZAL1UO8uH1VL/fy
	ZE581FEkSz8bQNBS7ATBG2106tVtgyB2xXLbnFyrxnO+M6GuiRBl2jsOHTHVuZyn
	dmK8nsT+FAZ++DvZRls23iYy76UkL4uMz9L5YW3g01CfSyI7mpaGYDT35KHWKQc5
	JNUOEw7GcByAoEnLEHZQKGRJHJDaB24vdpHTRgxjBtdQBfwq6sPLj2US98GoE5B4
	xtt04VxTWymDg32Qd/HY0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756136764; x=
	1756223164; bh=US/XDgonTIZFryD+K3YgGxe1e3seLeLWNuEZf4Y6gHM=; b=c
	zOAxUKkMGYrUV7v8KP0+DovFEk6Db/BeldnrTCGZwsbfZmOPKUvCbVj/ARLWhklK
	HYeLEgc4f+2p9TrhRVzNf9dDC8nWx7nwwUxetShEFDtI8YXJN1ZKSewJK1VodS5z
	CQ/UOtEklf9oRj4adluF0CPYQKJiB4XUE9EpXsTd0IArrkwEsixXTwjiqP6ymCZO
	wVOEx0UND+nZLlNPxSkzO3kTu3wDUa/Z1qEnutt/Fm59kGLna+fpAHGfh7VXFoxk
	uVH0SQ4X8/u9gh6Y+8Rp8zyPo+8FoEpewyhAd61AgRcAlwyhfN1nZV6HgaYkD3IO
	7ig3JBwOOJG9UuE69GxKA==
X-ME-Sender: <xms:O4WsaCOvx4lF0SkKD4p-6eN23a1n2yXrM-8D-m_9g5tG5pUlXW0xTQ>
    <xme:O4WsaMeWtYJ-xjwjZ6FOvR7MKAKo0LlFhINLAfFVjvWLAaHg3HO7wQJEdt_513h8E
    EQwp9AfqTIKZa_oCg>
X-ME-Received: <xmr:O4WsaPsm3ePAY8UEOoC8ZH6kca3oZ7GlZTsNjuyVwAGAj_TiRLxzxr9n-zlL_SzfW4ZD43RApfP_7XYlwzERCJBNYvGAkbgr-LTX0Zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O4WsaNnXqITiO8GBJRNQfOW_7aOjxTGtUZV5QJF0xdM-pt1-6PfaUA>
    <xmx:O4WsaBw32VsS_nFfnAL6luWAO0JawjuFJ3k3UxAV96VD0qrSSsbNsA>
    <xmx:O4WsaPPmCK8xfJel825WtWD4xyOLT4lv11MqXNeL7uCCA9tnja24JQ>
    <xmx:O4WsaNrovR-zuejsA8_PpNfVhalF8bUR9-YdFQHGET9JnVTB7WE-gA>
    <xmx:PIWsaEoQwty_hcaOOyHpeLdBzb6cPATOynS-My9s881W-kHpZDLjRJuY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 11:46:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 3/4] t5510: prefer "git -C" to subshell for
 followRemoteHEAD tests
In-Reply-To: <aKtq47vmCrUZCUCF@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sun,
	24 Aug 2025 21:41:23 +0200")
References: <20250819192004.GA1058857@coredump.intra.peff.net>
	<20250819192716.GC1059295@coredump.intra.peff.net>
	<aKtq47vmCrUZCUCF@szeder.dev>
Date: Mon, 25 Aug 2025 08:46:02 -0700
Message-ID: <xmqqfrdftnet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> I for one think that the original is much more readable.
>
> With the subshell it's quite clear, even at a cursory glance, which
> commands are executed in a subdirectory, but when using '-C dir' all
> over we have to look closely.  Furthermore, when there is a command
> outside of the subshell, we can be fairly sure that it's intentional,
> but when a command without '-C dir' lurks among many others using '-C
> dir', then we can't be so sure, but have to investigate whether that
> was intentional or oversight.

Unfortunately I tend to agree.  A few downsides I find a bit
problematic in the subshell solution are

 - The temporary files subshell creates sometimes are harder to follow

 	( cd there && git foo >../actual && ... ) &&
	test_cmp expect actual

   than they need to be.  With "git -C there", obviously paths used
   when they get created and used match:

	git -C there >actual &&
	test_cmp expect actual

 - Test framework helpers like test_when_finished and test_commit
   that rely on the global shell variables to keep track of the
   states do not work well inside subshells.

 - Some platforms have expensive forks.

but in a context that these are not huge problems, I tend to prefer
the "cd in a subshell" pattern over

>> +	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
>> +	test_config -C two remote.origin.followRemoteHEAD "never" &&
>> +	GIT_TRACE_PACKET=$PWD/trace.out git -C two fetch &&

especially where "-C there" is harder to spot.  If the above were

	git -C two do this &&
	git -C two do that >actual &&
	git -C two do something else &&

i.e., with aligned "-C two" to make it obvious that these are doing
their thing in the same other place, the tradeoff might have been
different, though.
