Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045F226CE8
	for <git@vger.kernel.org>; Tue, 27 May 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330879; cv=none; b=kmhi/cfoegwqMuQnfenpKZ/8VMjq43TDx/B4fdZlpvit1VE0YU/JFg5+0W1o3EoleEpO/H6tv4DgTssyn0tRPvsRqURO4vE30g4UwkJxy4ew6VA23z3NyD61DD9SrU49cgE+liJ6EmUWHebEup4dY+rOGP54fH3ewBWDPXfN/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330879; c=relaxed/simple;
	bh=14FxUU3soiGQtWMcU/6GuAcnu1NV7/ZF8HxspT3J7I8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hKubpbuEkkgSHnFLG4lbOx3OYqs4bXGLkrAblxWnTi7Py31tc5NrBmrUIqetLLDAaq3DXWkV2y3JfiRzwDtwiT5L5kql5S+4NeljsNrLwrHAWE54akSwNmziwtT+gwvlw69MAiYfcgUIrFS+XpJQkDRn+/8AZ9iPWImYzHojyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cNVdGQMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CG+sxEOD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cNVdGQMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CG+sxEOD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D3B1D25400CF;
	Tue, 27 May 2025 03:27:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 03:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748330875;
	 x=1748417275; bh=a1Ok0+a1Pn8Ua0L6r6IWNUrZwYl3isR/GE2GG9IpoV8=; b=
	cNVdGQMslr4JwdtT/FmjEHh1THMcrYwWbQhnAz4hc6zMk6MSLjfmeF0lJAUE777t
	iW3SasvHE3zlAjuF6RTFiLNLQG+l/KxpQ0Z+XdFqxjQ2fJfO3/Kjx73oi31ISQEP
	w4lg6UewLIi0phoE6jg8ohVJ/poeCOwo0q/ro7oO+QJXiymtXg2FtQ40kmDwytk8
	vexOVBGxBsJG/qceRfvyDS3gvcif1RaYExsgF7T1ms+0AfwGmsumzmgBJIoOC2bz
	XMG0DNz1nX6zRyMCJ9GhYCddo6E2jDSfn6tRbiujZ8oht1N8xNYtl9KKa2CdSLnp
	Sh0kqzg7oq2LwzSL9vxJVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748330875; x=1748417275; bh=a
	1Ok0+a1Pn8Ua0L6r6IWNUrZwYl3isR/GE2GG9IpoV8=; b=CG+sxEODC+xmPm3+O
	Xx7+hs6b8CAl18cgT0SXpMDdzg11kehSbRIt4ry/v9so9A6tLby0lTT1XcUlEKn1
	GYx5zRMpGXppYUcM4FHDXVJmzTgPUoqTZJtnXNT43HvSCXlwgWbOrCilkBEe2Vdp
	5Tw5pfbcviJuzZha33zI3J/8tCnv0Hh68ADv2frVIWyQfjvSVGD7EX/hqtKSmc1X
	dYyQFu43+IxjpiRwnuTqJzYactZtU0qp6F4f1Vm6c6V0giU4rrT9cJjxHYSDl/93
	COIrlDaZMU6LnRzrPmgcb2FXsWiDY4Dg6BUa1QLbhaks2icAgC4NZuL4wkhQkUpp
	GAzTA==
X-ME-Sender: <xms:e2k1aDX4GyQLmqJVl2QEBxTk4tvab1mah2y-tlIJ5fwPGOHTrnEJw84>
    <xme:e2k1aLlouo_pCkz3g9lph3K6lW5xxNQWu_j2KN9puAQjCdpOg75_WV3A2I5XP17rp
    7_8nMHzYcTvZVhaFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleejkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfe
    ekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehulhhrihgthhdrfihithhtvghnsggvrhhgsehkihhsthgvrhhsrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:e2k1aPYkYZzc_zw4NjyC47LURXMQhG9oOviiKD01he77Du0nEWDYxg>
    <xmx:e2k1aOUsPYiemeDAGnmUpx_7AvvsUyfZj9pX1oGq-Z4RAq43ykYl1A>
    <xmx:e2k1aNmfwS2AFzdwQ3Q-d189up1xAetPAoVZhtCIbzzSNHqIwayc0Q>
    <xmx:e2k1aLehAHwTw_jeUdIvgQyhdz2FU2JAIxdI6XoC6FUCrcTShjIlRQ>
    <xmx:e2k1aHsE7Zfl_2JDm9LB5gMi7wvF8_dBoK9O7sTfKKLgbh6WnENsQfA3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 703741EA005F; Tue, 27 May 2025 03:27:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T02049728c729551c
Date: Tue, 27 May 2025 09:24:58 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ulrich Wittenberg" <ulrich.wittenberg@kisters.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <24a091bf-daef-4c97-b233-1a0f5c329f25@app.fastmail.com>
In-Reply-To: 
 <FR0P281MB28795FB4A108A6044273B39C9464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
References: 
 <FR0P281MB28795FB4A108A6044273B39C9464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
Subject: Re: Bug in git branch --show-current
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 27, 2025, at 09:00, Ulrich Wittenberg wrote:
> What happened instead? (Actual behavior)
> The command returns absolutely nothing.

This is the documented behavior for detached HEAD.

It sounds like you want to know what branches point to the commit you
are detached at?

    git for-each-ref --format='%(refname:short)' --points-at=HEAD refs/heads/

-- 
Kristoffer Haugsbakk
