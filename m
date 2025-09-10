Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9125C804
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511528; cv=none; b=ogfjH0jtniwEp4cZe3MS7szCvcth8jGXbkZfot1Bx3NgIWRv063RPJFy3jgANSQcfNsG5H5cmfLyTGzbdbyjK3KdgIfGqC2rwRX8Q17Vf+nUpA7suOEs9i8/HnLhwmGftViGCa+FbfMIEidj2wh5G6DZmxpdfN9xgsg8lGw14AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511528; c=relaxed/simple;
	bh=ag9olTSBiAi6MEnOH6WEuT7R+cmVT2nuSJ79I63NnjY=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=VJD/qVP1qqb4z+UEZ6mpWJ1h0+WRq9p3c4EbiBRluncRQL9wQDwEivEf/zY1qUclnTRIYiyUbIo68iSW05dwb6aEDhOJXl7uoqyJgslMyQ2LyQ0oD5a5Z7UztL+1Ko7eBokzMCIxMWGmm2VICqCnohjNbFH6d1JnX1lfObRqi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdesai.in; spf=pass smtp.mailfrom=cdesai.in; dkim=pass (2048-bit key) header.d=cdesai.in header.i=@cdesai.in header.b=Vx0aHIEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezgpL4IV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdesai.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdesai.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cdesai.in header.i=@cdesai.in header.b="Vx0aHIEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezgpL4IV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F181AEC042C
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 09:38:45 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-06.internal (MEProxy); Wed, 10 Sep 2025 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdesai.in; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1757511525; x=1757597925; bh=ag9olTSBiA
	i6MEnOH6WEuT7R+cmVT2nuSJ79I63NnjY=; b=Vx0aHIEBwIvPBIXwBJsBJn9xgn
	KiEaYWpUIQPDSw57xwYxXqAvHVKucy2vSMfuYAgdxu2Haei1cNRWjfR+/pPILLxD
	QX90brrZZRZyHujhMi/gbhxDnXEsdGAeTg2VRSHZH2SO6OiBa3BGjvPunRzGNl11
	Q7OnM2XoeXadu1jAM7U6inl8GNcbbPOMmUQwJ2Nc3noxrdhKQbTyhdpUptpFTXrf
	eaajQxE2ThTzKeF4wTpanSlf/IQEjwO5BQ/CBbiZlUQbLOR2soB+vYT42oVpZAsq
	F7VymRhDmrqc4hWPGpLwCgJtd/32/3pSdfmpeCCcpZnkJWi2wBnBKgD+iziQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757511525; x=1757597925; bh=ag9olTSBiAi6MEnOH6WEuT7R+cmVT2nuSJ7
	9I63NnjY=; b=ezgpL4IVEElN3smh2fQI5fCZT/TLzLsMITPjmhVqjOpj2Rg2sAp
	4HLHkieDFfSTr3ctaDOxSXUr64t4dC98Z+PLlE6Lwwzg/1Wo5NvitSCu01lNtgCX
	66oNqa6szOvStWjoTXWtFsp0lrPNYBbYk4PxdDhhYtKb4a7kQteAVare6ymWTeUw
	pGpk3FozZk/qfP/dew/DbRoaBeCRoNn70WhHEZqcAlJbeRf6WWVbl0AM8UTwykXi
	4yrkvSM9TvYstgCNZ27GQThDUpA9q4ozU1FwuxttOTKkrUNgUj8UaXYFFY90Vexp
	qYgtMuvXaQSpCBEY41px2Uy979JIwIQhRrA==
X-ME-Sender: <xms:ZX_BaBj_wSB80YZBbPvqWSPP-SFdF7--G4lPT95PJt3Bwy9sgGgn5g>
    <xme:ZX_BaGBJ33_SOj-NSCQ-0TCOapTeTSUToLFl48J83u-Quux9F1WodlrC9bTTCNHyz
    LjwUXFERGI0yzX6WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttd
    enucfhrhhomhepfdevhhhirhgrhihuucffvghsrghifdcuoehgihhtsegtuggvshgrihdr
    ihhnqeenucggtffrrghtthgvrhhnpeevtdfhhfevgfeigeelvdekieethfdufeeijeejud
    ejiedvudevueeufeduhfeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtsegtuggvshgrihdrihhnpdhnsggprhgtphhtthhopedupd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:ZX_BaEZEcDQl58CXcxDwYQ4S0tX17m8Byg7m3i9AsBHqF7jjlfDKnQ>
    <xmx:ZX_BaDrr0HZdlmsbU75ixS3qUyTR33-tOFf4iLg6yrn-grbK0bMFug>
    <xmx:ZX_BaJ8wbTHEJcxcwZryvm2YzrgfTry4JGXjmlaD197vWy5hz9EuTA>
    <xmx:ZX_BaC-Xv-hS2O23RJgKRdjbDFuhckULoDcS5X0wL6IIFneyXm_9Iw>
    <xmx:ZX_BaDgxtsLKVaKmqCVprGZ6eQgyB9TfAJ3R6NFQUF3K3mNGvZl8bZAp>
Feedback-ID: i928945cb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B345B2CC0088; Wed, 10 Sep 2025 09:38:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Sep 2025 19:08:24 +0530
From: "Chirayu Desai" <git@cdesai.in>
To: git@vger.kernel.org
Message-Id: <b32a369f-87c9-41f6-b1cb-81273945dc17@app.fastmail.com>
Subject: Using command nominated for removal: whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Hope this email finds you well!

'git whatchanged' is nominated for removal.

I still use this command. I usually run 'git whatchanged -1' and 'git whatchanged <commit>' to quickly see what files have changed in a particular commit.

I guess there might be some alias I could setup to achieve the same - it's more that this command has become a muscle memory at this point so I kept hitting the removal message, and here I am.

Thanks!
