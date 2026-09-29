Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A9503BE0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680193; cv=none; b=I6rSPd4I3S0B6eaGraecu6E6nlO5gMsKsoK3IxZ+WhPfbsRLyws13gxsswmIScyVwh/Ejt+k/3NeGHnQ1xZWT+KqDGLJy749ezPwvwcdBDZIz8dBlPnm5opdh1dYRiMjANB1alR6vVHRQ7M0AaF2hYwQoO5fFY4wX0ZaTjh/nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680193; c=relaxed/simple;
	bh=kX4DONp2AZsAMWNThKzlbIkWuGQZ5iyR7Gfy8NvYGJI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E44WZq78heywWTjB6k45x9rT8jKZOZy3R4p4hmEceQXDXKLnALRhIdBJ9d1eFfAhcAJBQVB+T3DWJpzwra1SG92R1Osa7TDhTy9vFq8lcwNrWMCy53SE/jWFCCXHRaJXETRD29c9citqvLGhcFOweyGGV4rdzDecwOiHJ+xHBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=3My7kd55; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnRrKYZy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="3My7kd55";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnRrKYZy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 25DC2EC13FA;
	Tue, 29 Sep 2026 07:09:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 07:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790680191;
	 x=1790766591; bh=nNzMq3AvsftSAFASqQL+RgITr0D297XW4fQAKhy/Pto=; b=
	3My7kd55uoKKBE1Yl+fW5xZ9LCKvcOGPJgLmPSWSZ1FlreCMtG6Nfa9U85wA41WO
	T1181aD+WIzHFtBF719CIG8nA+LPGd9o7Ic0Nd5ffKzTq7xxJbqCl79p+HL8YiwG
	5vPhR0R6BmTxfz4cj/LBNzCssnz/NdpPB2Fu2FGrvN56gaydn32Oiv1mBNot2j3x
	imf4EYOC8gszgir/INY5e5/y6+6S1TtLt2GDHNNFeKlzR4RjPEbPeLe9ZMVc8T/j
	iL8YI48TevKT098+lDW5Z3NWaRvoluc8CQvKD19Nx6Xo1wloFBtdg7DaFRFivbRZ
	8dBw9fEmRGgTFmDipKNBTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790680191; x=
	1790766591; bh=nNzMq3AvsftSAFASqQL+RgITr0D297XW4fQAKhy/Pto=; b=T
	nRrKYZyJYZY91GVOUyW5H8kUhMBCjTWGlDkG8aH+ePnomzu6l1nIe4kgBgroyCsK
	L+TWtv4bX/Q3KQaSfiZJQXfAroUwvOrxQI4xwmYju27fW5x0ynRLG5rsUhytzLa6
	idLsOnrBeH2FXLqxrhP59L5rXJnmjpNOSbHzxLc7TgcXJj52rtK0gQPvYZCs2gAR
	QzmO2mFeE/yBgkEoO1wKVQ1sxZRDpFYXPmei/HZVCfNg06VrdxzMfqMWzJfnjW76
	U+lbPURR3qvgGUlTemW9K8HELSw4wnTfbSTMqQtUZfIS0tBrPrTsAOl+e8fGEazi
	RPvCB8tjuh7y9hOhGqQ9Q==
X-ME-Sender: <xms:f5y7aglCo0svn3XGO8Wj1UWwIaf5YgWSEGN3s4V7qvBB1lO0QMzNoQ>
    <xme:f5y7aqoHsmsccLWn2veMwKL2kxzruxtm3HSYtrtIUBiiJJzDD3tq2uaAMHPvj5YRS
    aioDJoKCMuaL7xLmq_o-6hFTQYcXzF2BScuhCihnwhXfcDafI7omME>
X-ME-Proxy-Cause: dmFkZTE0fctSQLEskDK/m2bwLXBggNry92cKxDsDv9n+vBopUrnZsn1LDJcNfNF6mjlDYj
    lnwv0+1CsfymIqvSc+nYuXbJgskK79gphzuyb7LZwbc1aNsWRy7AVnuw+pf35Lq3qnC5ZL
    5VSFOo/AzMdJac6WDekAZ99daIzHx8H8zxnIH0I4sUpArSbaP2UU0BNChVqNF+YE+lee55
    MFH4IHem1zVg5d6cfbndReRPjN9fpDmCMWkcXvK4/hfxRj230U7oDepn9zqb1N8g0mMHcv
    aYJkFpWUhDNp2Re5tlM1wAppD8bkL8zR6VHngYcSURmwfxE0M7Nsa9OECGKaf8X34oQ4Sd
    gJ1swB3O/h+7kCluvkNqwRxuButYxOgXtrql2Jgy3qzP/fP/qRoB6inPuy/GDExJpamk74
    2P98zAcgpAJxO0greUDbULtYtYRHXxLa+rQ3NxCWxnZJFNdviGzX1B4hQb1gLh1Gd50IqS
    oYEKaZWLrBcirP1aYf3cu+m8LludJ4ucFlBax8tBk6Syg2P6KfH3sbDvurxY8cwaw83LtD
    odnwXJC6WRhsvbZ9GSPp6TjTg0LigUiARgPw9EowvFWbVXRnHl66wcle09s5fnmhYjWGJH
    dQ1AblKjJviuIV3IcbdQxzpHlye15YrW8LcCeFYHI3h+H4BMCZzlo5qe09Dg
X-ME-Proxy: <xmx:f5y7alh5gia0v2_x1pUNARN63Jr0rSR25VgGtXkG9Jl_eO6kOmflBw>
    <xmx:f5y7ahw-fbS9afOJCZ775Ui0J0cx8eNT9ror5ZwKhWf659CuAz12Kw>
    <xmx:f5y7aoIVUlN_bzj1mx1NKl8Yf8YygvUDvNERzRmndRhxCCBHLS1CCw>
    <xmx:f5y7aoR1r9PuAwGzRweLCqWdGJTMAHUROK_TXAkg8N-kYl3D0F_Wgg>
    <xmx:f5y7alfaw-RgdS_SBqitu9wk07gKAJAC9lqTXpKhN_CBiEe06HcpdosK>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE133780070; Tue, 29 Sep 2026 07:09:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Tue, 29 Sep 2026 07:09:08 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <258b3e1f-3bd7-4e4f-be42-06a9d52dbb91@app.fastmail.com>
In-Reply-To: <8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqq5wzojy31.fsf@gitster.g>
 <8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I'm not planning to replace gittutorial-2 since the material in it
> is already covered by gitdatamodel and gitcore-tutorial.
> Let me know if you disagree!

I realized it might be useful to summarize the content of
gittutorial-2 to give some context for this. It introduces these
commands and files as a way to learn Git's object model:

	git cat-file
        git ls-tree
	git ls-files --stage
	.git/objects
	.git/refs/head/*
	.git/HEAD

gitdatamodel explains the Git object model in a different way,
and gitcore-tutorial introduces these same commands in
more detail.
