Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB77341AAD
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833286; cv=none; b=jFrsX0mGYXjbNWkW6l7nk/EGEhgKH1LvG8BruewnoGFoqxAGHS6uY/+lipXGKv2Tx0z70h9UYiU7FY7vek58PI8SsdGpJ/R07lw3geMREJc7YVvVdtkN8AlR/8lHyw0Fdy4iZruAhX7ZViJJR6WpDu76cCIaUeKjYKzVp1SQ3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833286; c=relaxed/simple;
	bh=JUsENW1XE42q9HG42Bqr0JFM4DawELudw2+ydFiai7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AfJVy+O12CCWlgPCjFXQVgzydnDCIjV5s7hCJAp4neZk8ZMDvcqCmyl8+8c1epkhqcZhwCaU4w7/JWki6ey3kkB02DkJv6EJg6GiaKyWquncKgIR+1ubZK+0mZbNfpctT/xeWvYLilXOzDWDHIT6SPUph4mcOk392Q5h0qyCXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=JHVYS/Tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJD/z0P7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="JHVYS/Tu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJD/z0P7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 648DB14001A6;
	Tue,  2 Sep 2025 13:14:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 13:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756833283;
	 x=1756919683; bh=NWWLfqjX5DbBSQXLWGICmvbGU4at7riDtRVmwo8x4jg=; b=
	JHVYS/TuG/yeMoaM6NdfsBoIrVNNKe+IKoEC6IX9+NkIROEl7aNrf++4ahqryeiL
	J+gc4LEFAmAGTyD0AaVimA7y0bRt+CQwddNw8+HzFseQXWDA0Fr2H1bZh75etL6M
	lTdB6GOUNnsKWkA/vx/WaMxPBXojOpUvH2zRwFbpWYvPgulnVDmc4XXr7MP3XHys
	B98S/+UAKxSM9Hl2MGvNlIq1dC4EjdUHk9PNKqTOQgSafF/A4W8jH+54sZN4tJM+
	mci1htiOUc4h0WimwOxexNkPiqorvdgQYEh1j7J7z44L8Sgek8BiMbCfILL1Buiy
	za6sBA6PaGzul7slN3zNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756833283; x=
	1756919683; bh=NWWLfqjX5DbBSQXLWGICmvbGU4at7riDtRVmwo8x4jg=; b=b
	JD/z0P7aK+4tmPdvfH6KDXOCGtEYZhMjpXMSwg2VQujlMBL47woKjrT4Fyabz3AT
	jp1dx9vhAaCXbU2fiNFUCk6zInebv7QrThAT7Gac3rhIDt9Ivx2wwhHBJnL8NQ8O
	Z1kChmT8UlLZgMHovOwkG9OCAO/NY533jZshj1GwUcLGAeP7MuIByKJ0j5chwY7m
	NoXKRiyQpJa10zLBUr5DZBIi8eQqn8KzQgPjEHLFhHJ7Aec5jm4fyLr8PlNL1Y37
	O70K0dqrhATGqNoAMzECM3vqY1EbBIpS9Zx97cKW3IbuHG/AuO9uGNvr6D4vHZE/
	w7kgFL+Aie9jvndXsHMVQ==
X-ME-Sender: <xms:Aya3aI7mR6HnIHbtBazcOcba_Q66LfuvYK_-PsSGbxTPYApiodzm-A>
    <xme:Aya3aJ7anjvqXFMHanq1N9QiobTinEEElNm_o1vBTCfrDgs6XDIrvtNLHxoD9GTiV
    pTv0ryVpXqOpYws9LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgrucfg
    vhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpeetje
    evheejjeduhfevgfeggedtteeuieekffeutdfggeegudfgkeeiudffteegleenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Aya3aBDVo1pIw_tnSYMBo84_XhrofLzrPjQY_ce8fc9PjVmicMyQkA>
    <xmx:Aya3aI9NL8FSIQhxGB3SfQ7OC36WFg4-NBH9kDct7fAZER1UBU-etA>
    <xmx:Aya3aMLNPJFTmYqMqsLNPEYpeQMlficGoqwUOMtKmMGZvgzLmctYWw>
    <xmx:Aya3aBj7gurQ8gQLRdJMidzsdiOY8Zc-x1UPQ9QFXdxL4pOaHscCtw>
    <xmx:Aya3aE-xKbOWLb4IwYl-7f1Z96WZok-UVb44A5NEFZlw6cs5YL3-5IPE>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20EE1780070; Tue,  2 Sep 2025 13:14:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aye-6GR96UBw
Date: Tue, 02 Sep 2025 13:14:22 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <a9351a8a-09eb-4fc7-92d2-fff5e504dbcc@app.fastmail.com>
In-Reply-To: <xmqq1poup1am.fsf@gitster.g>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
 <48e7f230294e131007032ef8850456a5c0493ef9.1756467934.git.gitgitgadget@gmail.com>
 <xmqq1poup1am.fsf@gitster.g>
Subject: Re: [PATCH v2 1/5] doc: git-checkout: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> You seem to have forgotten to update the proposed log message ...
>
> https://lore.kernel.org/git/de40e0ed-ca12-41b0-acd0-3c594078cc14@app.fastmail.com/
>
> ... to avoid making it just an enumeration of "these random things
> were done in this patch" (and instead tell a coherent story).

Thanks for the reminder, will work on that. I just realized today that I can
use `lazygit` to make it much faster to edit my log messages :)

> I do not understand "switches commits".  When you move to a commit
> (i.e. your HEAD can point directly at a commit without referring to
> any branch), are you switching one commit with another?  I do not
> think users would view it that way.
>
> Phrasing it with "switch to" may make it easier to handle.  Then
> your previous state would not matter as much.

Agreed that "switches commits" is weird, will use "switches to".
