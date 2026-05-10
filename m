Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEC13B58A
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778456246; cv=none; b=UEwp+KJNDoKXhFU7Apxm6qXkCA0WaqG6mWr1fcBkGPTDH7z2IXPfGrQ7gW4WdhB99Ru9wdIKRZ5jPEiJQzNcvlJwWLlaxOw6Txb44QNYNK9aCYeMsw2UWfDcfrijVOWPJk2twZfTYM1uqAmHlaBKiXc3pJtX8/IRS0/jOOEiQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778456246; c=relaxed/simple;
	bh=Y3JiA5eeNgtWQESxf8oh+jtJbJQNCVj1iEtMdq3XcF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmnE5zQ1G0SYUdQQNnZaK9DPpKoo9oZ1wVZafai0MAf87CLvlFzNaHQcU3cbzaETeWr5/J+ev50LEVaEKVWkC6SghveWhayuV2PeFhYKfxN9YUtVDQWtwOulbQSTOJCzWhwQ+m8q9Uq491g+Xt3Azo745SG9xrgnRzaMplBXp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mFAKyNsC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WccYZZfK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mFAKyNsC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WccYZZfK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EBDAEC0276;
	Sun, 10 May 2026 19:37:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 10 May 2026 19:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778456244; x=1778542644; bh=lNjr22lHAH
	bXHZ0S5cAeKRBgvKtN9hBe/jJpJuYM1qs=; b=mFAKyNsCfFsyWS+H19oDjei67k
	bpf1nqmW58qfMlIL57opalUYpwlyGdUbEaLbh8elU44bFB6bwvJgvNag9+fNs+Pm
	pBr1ZHtA19bfo41jatEf3xlRG2Xhvbrcu1uOHIj9DG66pA34kf+ktToc43vhiJus
	Ouf9xt+5+s+0Ko3qpFdzV469UEf4UiZtaTKX7rd8Csr8QElO0ArRfmN1i2273QDA
	q186PnxzuRbKSPSfX187b8hALAwuuHAEYBfR7X4IebvM//t8v6ZT9Vn6jGDgoHxG
	RG9Y7z1bMveIU5ht1RNXHyEF5gdBU19ejN6YxMcwkqIa69dvpdZdRb8y2ePQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778456244; x=1778542644; bh=lNjr22lHAHbXHZ0S5cAeKRBgvKtN9hBe/jJ
	pJuYM1qs=; b=WccYZZfKx+Gp/V1Jot0O0v+SfLHxk62gIt7QWc8utJ0TH26YpfL
	eoUAawA+nnQLTQgmN+E2zNScdvoT2FA8oYZsAPouzBa/dEnGPpBph/cc+w89jkAm
	ikGleSl6pRO6NFSlc6Hd1KY6/egpr9m9bI/NIBysqDYUdfQC0RgyS8WwAtv183Yy
	PWJPSrit+VTtz+BDcXYv64EVTSfU98PJ3F6/r2vwRYTyHGETtyBnElc/j6bXZrHa
	OuuKesj/vxrhc5CUrXBS51zTBptYgMe/pgh+hrLQHMhjmlwVvW6z8UGFGw6lbRHF
	g8v07LHR0GOzFAW4/hMp+3W2iduPKc3NlWw==
X-ME-Sender: <xms:tBYBaopjvx6Q6czwkTT_vPN-FVxu86qTC-jrGpS_xnTRr_-c6Uebvw>
    <xme:tBYBalhEUJXLtX2MA9sgQJnNdYbVhSY4KS-bltPyKrsOErguWXsqeOtgfDnai4o5Z
    psCyU2COmIe6HQAHO5KH_mlbzWs8iTRWCJoPBD1keNsJpxrLyMUNgM>
X-ME-Received: <xmr:tBYBali8xqRS3O0fx1sCEGg9-myWY-O7Cr7Jy6WrA_JXSFCOz2idEr-ufRZxGhQwn76nJxOFkwmFR3963WEol8PL0b1icUjlxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrghilhesrggshhhinhgrvhhgrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tBYBarhrlixo90r-Eb7umKY8LO2plMlcOznhuTiEgfDnpMBYfFW4sw>
    <xmx:tBYBalLqiDO0hsNxeVVj8vAl7JyBqZ399b886cb8AYaAJrNUsb6ezg>
    <xmx:tBYBaqHKZRfNbpYP1jnlqI8MzGW7A_GZ1YRWvMmtrSa-k8RhIXs5zA>
    <xmx:tBYBapQ0CSver1LqrPJmIimMhfhQWqEf1GAVaUGKAgJhU7WAhkVUrw>
    <xmx:tBYBauyj0-wBqy4_cL-gdQRofG-90k9nE6AsYLK1mg3yf8LOqf0W-tSM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 19:37:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: mail@abhinavg.net,  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
In-Reply-To: <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com> (Phillip Wood's
	message of "Sun, 10 May 2026 14:37:21 +0100")
References: <20260506023944.90691-1-mail@abhinavg.net>
	<xmqqqznk9ih8.fsf@gitster.g>
	<0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
Date: Mon, 11 May 2026 08:37:23 +0900
Message-ID: <xmqqv7cu96q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Your long topic branch may have local unannotated tags that point
>> into the middle of it, marking strategic points in the topic.
>> 
>> With this change, the command no longer moves them when it rebases
>> the entire topic.  Isn't it a regression?
>
> sequencer.c:todo_list_add_update_ref_commands() calls 
> load_branch_decorations() so it does not update tags and the patch is 
> correct.

OK.  And with "%d", the existing versions of Git would have produced
something like

    pick 31e8fcabd8 # rebase: update-refs (HEAD -> rebase, tag: mark)
    update-ref HEAD
    update-ref refs/heads/rebase
    update-ref refs/tags/mark

it would have failed to work due to the "HEAD" thing, so even though
existing versions of Git may have added such local tags to the insn
sequence, it would not have been a workable configuration anyway.

OK.  If we never supported such a workflow to use local tags as
markers, then the strategy taken by the posted patch to limit us to
local branch refs is a very good thing, I think.
