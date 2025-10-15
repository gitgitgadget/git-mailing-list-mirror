Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA82566E2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536945; cv=none; b=YXw1A1Q9TnuW+dFIrRLtz4SSr8Hovcicju3B46HzxFyD7pwMcUBC54h3DPkxe+ZZv+hIoPH9rlyZ6LmMHs860DTEDnLI4XbyoMfLM9kIlZsCopm07VPWyyqjUlqH4ctQPNWuPfdtReFgVkvxCZBN84hW+KL/BLcaxuQPA3p8GOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536945; c=relaxed/simple;
	bh=twkhPlVYo4hiPPjMBT/78E3yGwQAO23ln5TpdxfCpGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uffGXvLP5W6fOE/VUrQC07354BEHkjG3uJTjrjE6Uz1UIaXbrtAJaZGW2vXI09VT0BT91Or1M2r3YYmJscQX8jDKH02sUhXvgKzkLhwMv8iHCcVD6c9e7jN2MysRLday9I5GA7b+UxhPupjvKN0Y+85Nil9AK442irjjCW8l2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dOemxw80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKv9Zp/f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dOemxw80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKv9Zp/f"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AFA014001A8;
	Wed, 15 Oct 2025 10:02:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 10:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760536941;
	 x=1760623341; bh=nKlBorwu/H8pdMsqglaavF/ec5ICwHK1K2jzMqIFZAE=; b=
	dOemxw809rA7UrfTCNm8+OhXVkE5C4+/75v4tTe9xITHaF5tIUuY/brfJX7RyeBh
	pSHmqoNMA+cYvdnlCV9xsLdwQtouV4sS6xSdYv1B+J6RP4HYgaKhnC3Utmf3ik/s
	Z8/gKzix8nbuiVp8VsvyVSLSGli8mcWYdRxvynXZ+YZs+5qTEiWfUtiX47jR7WlW
	HbumYog3PzIIDhzSQ1G9Fxz8CNXE0n8lqGTTjXm81PGF0/P8zy1Bs57fg4KzddVj
	ca3zvdR2aZqRENKMm60aA0jm2TdqnQE3ZuUZdvtW5gG7YJceL/swXJEiq7rn7F+k
	O+qT7SZ3spwiQpfaDkp3Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760536941; x=
	1760623341; bh=nKlBorwu/H8pdMsqglaavF/ec5ICwHK1K2jzMqIFZAE=; b=V
	Kv9Zp/fNnjc7kcR28tRI+v0Q3lSUlnsbDsymsQp+5o3XT37XWbssoTknty3Es9Pd
	OqbdvVbxnzBafuiLPPxB0Fh9NUi8FvAIqqN+FUB/C8E84wSsm7KEFfu9gktb5XxS
	7R+es4mrEKeseLohl+/OMt2uVJvaRwEHg8gBbqYsVhH+jUGIqB/s9+MHLxUsyhqn
	JxjZdiO6W3g+oXUTg9CqidM91uF5AsezVqd5D7bAbS3RGLzsvXl9WihRbeJktTC9
	aviWiZ+3+MGy9j24RYaVCPMSsaftKEnPVoPraooFOfZ7cLnyh08TfSe88/+AH1y6
	sramrJ937SvGJq3NJiN7A==
X-ME-Sender: <xms:bKnvaL-byB0dFcnnOjEHRUVKvEaWslrtvM9COGLiFBHxX_qBjX2X9T8>
    <xme:bKnvaCi--vtY0yXZSiXbsMZY3nUQGLFbJQRbMLM5ihWeDhUqqGNxBffE0lPsZQ0nW
    1FixxpOYkc6t0Jics5TpozuksobyiG17RxblrbB_gJUqfS3uraS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bKnvaAGS2JXrygXy40NjjkWin9mKHvv1XTH9Mdvc9p639XX-3GAvFA>
    <xmx:bKnvaExe5SV4xUKRnFquCMR-8j8cFnK1PGV9ki9GS5zD_3lEFtuNKQ>
    <xmx:bKnvaNqBXJOzV400dFNOleRCU_3ytmHKBFDZ5zRHWWSIEDOTtyqNHA>
    <xmx:bKnvaGgMMre81R1hRaHRYkYnjmje3_7JmJfARBJtOQIVtNuJnjJgEQ>
    <xmx:banvaEcyn3pccVxJAreWl4W8JdzKL_70mKB1nB3UY3E-8N8Vzq1gnZUb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 76BEE1EA0068; Wed, 15 Oct 2025 10:02:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMyiYKusIPWs
Date: Wed, 15 Oct 2025 16:02:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git <git@vger.kernel.org>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <b4331d08-5105-4788-880e-af710cdcdd59@app.fastmail.com>
In-Reply-To: <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty>
 <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
 <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of use
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025, at 15:58, Li Chen wrote:
>[snip]
>  > (if that=E2=80=99s what you are doing).  It is to recreate them as =
if the
> series
>  > was perfectly written to begin with; if one patch introduces
>  > `--trailers` and a test file, then there should be no need with
>  > follow-up patches that improve the test file style, refactors it, a=
nd
>  > so on.
>
> Thanks for the tip. I split the changes into separate commits to ease
> review,
>  as Phillip suggested in
> https://lore.kernel.org/git/d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail=
.com/.
>
> It seems I may have overdone it? If so, I'll try for a better balance
> in the next version.

Thank you. It seems like I should have skimmed the previous rounds
more carefully. :)

Cheers
