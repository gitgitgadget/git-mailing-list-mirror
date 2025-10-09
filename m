Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E92765C3
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043566; cv=none; b=E8PrrLK3s7sWP41xSdGBvK5It8K9dQgjs7z1KLIlBX5pdOXaGsWqdTYgGTLD2hE7BnYy3wjZ0xzWE7qbkkJd9gkrDiBaau+TjstlY1N26/VTjelyEK3SrkByRa+QdruqU4B0ZjVzXtblROZeChSFCIGq7ZmLnz5LkMYprl+pBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043566; c=relaxed/simple;
	bh=xZy/TY62VIC7eC2Nq3OrzmTP76kUubUdD+r/1m5qJnc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N26RJ78GmJid3/q1GRm+88a+TmEPxaRGhUkQOpFNW8FyhKI6po24/KJkUIFfNf0Lt2oEbVeJmjJdIHw+qyXLEHi46HYZiOynOrMGxYZglm4fu24Z+w9XUv5g7hfCwU768qaIFlxiN72q5v72qcqdnZk3DJ/3wsZCjqe+wNgT+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CbXNKjgY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vt6LTGUn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CbXNKjgY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vt6LTGUn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E43EEC01F7;
	Thu,  9 Oct 2025 16:59:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 16:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760043563;
	 x=1760129963; bh=xZy/TY62VIC7eC2Nq3OrzmTP76kUubUdD+r/1m5qJnc=; b=
	CbXNKjgYfgWoJi0wnntg7RBZ+3EeB/7lKnlbxngXcEfan9kkwcerkklnC0iGKcWI
	7KyZOX3vigbo79OytzUAQF6NwxoK8mTXOg91fY6XNwoNTLIueLWRMPQXId3EyoOT
	TX4Emh3sS3yRno3a7z+sye6O92h2hrPXbh8gKwOfk85tRTgOgTboZznhbeb5Gb9i
	2wA5oywJ+G15kYNlwpLxBQ5M3cwDsD7CAf5L0fShp+3YbwxTtw12cbzs0XTSaIwY
	ZI8afoL9jOKpslipSsbvoSDJJZmQrP8JPlJj2mENHItQZ0LXXmri2s/cmriwhZQD
	WbXCNDf6HTgHG0qsXbWOpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760043563; x=1760129963; bh=x
	Zy/TY62VIC7eC2Nq3OrzmTP76kUubUdD+r/1m5qJnc=; b=vt6LTGUnYlVjKi5+l
	DFqAm2xYbfdtOV/e1+TfWEpnBBwl8B0VBfRXT2IbzoY9iGFsPV52+UWDNA6AGB2K
	osU+mUgKyhfl43gFg7UPfB9Jpc6Ar+FholS3aCkXF0qJVUXissLhx3zfbBn+5SOL
	n96nq8if98N4XI7LcKnjmFLeUEB2GcvzNecpkwtqvR1bZaCm25a6DiLVwdSSzWMF
	bWDVru9+dwVN84mglAYgjg4FZCgyVH/MiBmB4vVvMAtSnJIK8SPbwaOeazbrI3R/
	Dut2/qXoX2jOelyR52gh5OfrPcZZf4Qo+GcnL/R79YPCH7MEj75EYiT9qzJLWhwU
	yJHow==
X-ME-Sender: <xms:KiLoaPoWGuPGa53Vf5TYPbnQDbLFM5daJ31yy-D3KWiwhIFWjFPZH6Q>
    <xme:KiLoaEc4x_iqW0T-YKL6q4rBMe9-cTOiZG2GrV3kiTQQr7-QyGyZ8zWQH0HVDQxke
    PSEUzunrzBSfYBnv73mQlU3I5XNryJzUhabwu7HRnGcmy9G9BzYTfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhshhgvrhhrihhlsehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KyLoaKUwYAKh-BUNcFjRHSQ9WFnO2wB377drFUNqbelW-NYlsKUlfA>
    <xmx:KyLoaEg9n4QSKQes-ORdYXV20YWKc_RYLpb9BqnTfan8SCbpMYSu1w>
    <xmx:KyLoaF9FAmE3YZ_teIsXVVorBKGslWL7EslfiOompQY94mmFBne7iw>
    <xmx:KyLoaODOdkta2YNV1ODVcP9qO9SlLIGgM-VbfRAko52ObVid3C22Rg>
    <xmx:KyLoaHMPm-6mHtH9HGCcD7mClpPEjppPhRtWN_56ww_AQs8Dx4_Iaujz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E3AE41EA0062; Thu,  9 Oct 2025 16:59:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ads84nkLJqqg
Date: Thu, 09 Oct 2025 22:59:02 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Justin Sherrill" <jsherril@redhat.com>, git@vger.kernel.org
Message-Id: <dc5de1b6-db24-499a-bee3-3eb2208ae08b@app.fastmail.com>
In-Reply-To: <a6067200-a7cf-4632-85f0-8c6bcd00a5c1@redhat.com>
References: <a6067200-a7cf-4632-85f0-8c6bcd00a5c1@redhat.com>
Subject: Re: 'git whatchanged' is nominated for removal.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening

On Thu, Oct 9, 2025, at 22:53, Justin Sherrill wrote:
> i recently got this message in my friendly git client:
>
> $ git wcp data/aws/insights-prod/account.yml
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.=C2=A0 Thanks.
> fatal: refusing to run without --i-still-use-this
>
> This is just me raising my hand as I still use this feature :)

This command is being removed because it was supplanted by git-log(1) a
long while ago. Both commands use the same machinery, just with
different defaults.

You can replce it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
