Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66391469843
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577112; cv=none; b=Uk/JToVmJJD4nzE3vcPhrzhaUeY/TlBcQzsCKpZMIlk1BbTvzUFB9D5ze4ToO1B6KmkOI5M32bQr55J5Q0hixKId8nSua91K50hUfZ3xnJu3Cqg7pUjSscI8NOSWwyC/xuMBooe9Sc9VbyIqa9iw1yx9nkXI1xnslw/Q/NEIkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577112; c=relaxed/simple;
	bh=WVA5VjPm1IXpfrBIJIBC9/8XVaCAm3OhI8TaYFVgbNE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UCZ/8yE0so8rd8nN/4xCfZybQ/y8DWj7XM93pjEFLp2Z00dVp/DBe20F4bcwSHfc7Izhi+x8+eowF/pX1HvaVmGSjTebPjLxKzyF4TezjWswAoeyHCAnjzuScrBqQCI137sbjJeFI/6QZR3ShU036rSQIagTmg3uSAmb/etcT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kjBuFBXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBp0bcBM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kjBuFBXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBp0bcBM"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id D0086EC00C0
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:18:29 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 09 Oct 2026 16:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791577108;
	 x=1791663508; bh=WRnvmWQzsvo1EwuCh/WMJKMw8Ty456wLnvLIXQbIOhw=; b=
	kjBuFBXbR0fTsB59EUtd52JnabxEIZTIr0XNeLNhz5vtGntVydw5gSiX2d8m9eYS
	LJCYGjyi5fBaNhxxBiUnbysoSGjdSQ8ykhDM57S3jjs8GyzBM48wf5a+2JVYDuGQ
	2FncdFRkumZYdih3zN3yrod86x+SHdD/ufHJMqVTdZKXA1iPfB/EXHOLIsuSkewi
	TaJveLZWvvnNUGnV84keeXu4GQ/1DXawWuHC8uafV4lVpcY4Yipvkk/ieZXZmtM1
	R8xyRgcDmYq7PA3Ngh9Gm3HsPmoOm5ck1RV6BGccoE4F7/UawCRH6MVAidf7tyTg
	HWCK2EyIRjWzC0y2AvulNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791577108; x=1791663508; bh=W
	RnvmWQzsvo1EwuCh/WMJKMw8Ty456wLnvLIXQbIOhw=; b=RBp0bcBM06dc6F1hs
	zVwtiXyIxHOKGmmG1fs0msbzCERCso+Ci2p1X4TMydbFwrjQiJvpmSFgUsvfJL5y
	pItEYfcq4E+tIUus1SdWRiXi2WuHgTqLUzo6rbXIjvUVh4LtgZMnNlKs1HYaT80V
	Wj990HAc2UW2v6TgPfwqty3Of6ijzExWJV41377L+R4LH0xijbp2768NvrhyfaU7
	B+7oiiyWCfUbp2MdqL0gbMn7kv6E/vLkIyl1fMWQoLfOZQMSEI0cYPAl9Bq6hdAU
	WXgvY4Zxi2kPp5hzm7mmPqVG5ZwFsqV1Q7E2TZyGQdxlJ6amSDNJIYBufQpoaKVu
	YFiUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791577108; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GdI63brxVTe4XTgza7JjuWVFTnVSVKkDwyDNxrIwfZR354O
	8NvrWbl3Bm0X4l2Y+1tG30qU0sgK7Hg+As2yNxgEtyiuYxSVMQLzqbwFvslg4HSN
	ebn5zLPO6VHTwmNx80/Dgw+XTwQOYXg3aP9xzf1ZNRNe3Vq36cdZYpkZX3wnkBUg
	TRTvsOuOlKUnETx+pXFYs2XuwiMssSVg6rNicKAqFNN8Z5j/Uz8TNZ1uMDwoq+LD
	u9xw8MdJjo2CT0fkNkJwFr7jmFXFmy8126UFbQnZ91+0ClMY7LbtOyC4+6vfJoNb
	FEm6sK0Dxz1n2lw6+bQkXC4cOLvKPe7syAGbtTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:E6nZ6SlRjJOHdhBcmv7oZMZEt4tF8i6KRKIjVY58e+A=:WVA5VjPm1IXpfrBIJIBC9/8XVaCAm3OhI8TaYFVgbNE=;
X-ME-Sender: <xms:EkzJaj5h4zA8Q_4iWCe9gY0IhUxmfRPWuaUwl8VSabEB7xo9kwjvm6Q>
    <xme:EkzJajvv5F5wEWj3-vhbm3aYQaIeRToOyMEeMS4sZAmOUq8IvvkJDzPMS-bNE0oTv
    OJEyEk8MNmtMvluhvcw9XaEUf29xHglYLExj7iWliFxcGUJAW3lDw>
X-ME-Proxy-Cause: dmFkZTFKr0dFnwnXnxGcI0H4JAe1iMO3fdQb8A83xc2AeoxYxbIsAk+jFgU4NlO+ygGYsD
    c5LJeE/81GeK2QJF75gMo2r/a5BrrInm+ODNfno29W52Hr0AtAPKaRmdapV8jfauIeV2Nj
    FKLwpVgjWkUHSNq21xqPIz/oeJgw5XWlG78LMon6FBLmbzyWKgAgw74hbkVaCFZBRlBB/m
    fKi7z92eH+MSjmx7Wi4HupRPVID+MjSsjcxPt38VIl1/JjHQIBUan80tI5+U3Em4DszKHb
    FlssM+fP/pXUfMUohk2jBn72v38wGtOrw51TEyc5KzL2WszuXagB8ZN7nUwIW1OhbS9tKk
    pZM+LFxsZkBcfIrIZA9hp0KqTv8zlWFW7f9dnLjSGS+OqcKC1zC1Lhk+wqOTF2ZhGZrUSy
    peNiWe4HtYrLwBn4WTTzSwn5TszxGXpI8CpFpcxecjrBghwt3Z5j46/XUGDOi3HO+bGIEP
    Du/wjesH8+9g7zAix8n70gJ83YOWQa5Z4yCTemy7s8ZUdqwvE1j1WdHS9AyfDRQboBWysc
    9DWHImm58E5GGeZkYod+ghsYByJjFBQLLtUfQFFcE33WKwmRn9Hd3sR45MSPDqbSP7g/GV
    TwRl1TgwlNMw+/XCLB2AmkXr/UcTEul4AhnQ0p6gLmjM3FAYoJwBFrUjpVGw
X-ME-Proxy: <xmx:E0zJaumT4HutNlsS4MhBKv7kMPAbH4LaqO2rLFDxUPKMb4ChM8T-uw>
    <xmx:E0zJajyZKBQXKwx3oHGS3RIfXA7RAbLvHyp9rW9iOKvPLGHSADDAuw>
    <xmx:E0zJakOkC0RGnrN69DETA4Pg9vD66VVq9TiVJcSU8FyVMnUsqcwrQw>
    <xmx:E0zJavQN5ZPhDEsq9PWdd1BrLWgSfXm2Hq6VYhPUcuIbX_vqYKMb4w>
    <xmx:FEzJaie-db9_FZspp-ARO1rcqyrolBtBV0e4ES1WEKmNqBVruiZvfgln>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B959622C009D; Fri,  9 Oct 2026 16:18:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 22:18:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jon Simons" <jon@jonsimons.org>, git@vger.kernel.org
Message-Id: <4fcdf05d-b558-4471-b696-bd7c285f49e2@app.fastmail.com>
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Subject: Re: [PATCH 00/15] push: speed up client-side refspec matching
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 9, 2026, at 21:29, Jon Simons wrote:
> Guide to changes:
>
>  - Commits are ordered to introduce failing tests for behavioral
>    changes and bugfixes, before the code change that fixes them

This project prefers introducing the 
regression test and fix in the same commit.

-- 
Sent from mobile
