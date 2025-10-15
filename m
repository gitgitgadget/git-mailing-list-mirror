Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E21313E1D
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512981; cv=none; b=UYuHTEOCNkcmd9FyXU3a3Ns7DwfCwAH9+EbQYhIGIWM/snk16cPnx7HZKL/OZuUZaqAxa5y/9bZpLb9Hu9tBSqdL/60rpzDlMQ3qon/NzoE7yZXsDwwkr1+2D8G+2s5Br3OYOx9pUNaSUmuvnrASFwRegg+CYhNLKCIVPb95o9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512981; c=relaxed/simple;
	bh=JarpcUu2bb+DOglU6mImrP6ScdoPGybJiL85K91sqvY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iBCdjDE4JCW5bwNi2su5PyYkxdy46OkOU9nuPJFiaIv60VtHqZuGJ1H4PjG9kIRgmlFgfl1ii3eTZBXYjYaXbYD3gnpqoF77hp7Lo6kuJ4DENhB4cABpEMkgXakX6jp1Q/rFjgui9onZmAWqp6We6oZqyCuRQ0turod/GrZaTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p3Tl660G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wc1DVD0N; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p3Tl660G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wc1DVD0N"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C9E67EC0108;
	Wed, 15 Oct 2025 03:22:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 03:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760512975;
	 x=1760599375; bh=JarpcUu2bb+DOglU6mImrP6ScdoPGybJiL85K91sqvY=; b=
	p3Tl660GF7TKJmzv97XCDXE+nFMqTTVk7XuNYVG+OUk21A3NLssj+m3LnmrDV6FS
	opwjSpZL8U4kmq1y+6VWWwA4ZSlbQ4IwwzuxwG1wtPXovgTAMEQK/ET9gJoVfzUE
	nrcLmL1emoeuu4WTRp8YQ7do6K7/CecsjllHH89cv3PcZXBoH/+CesOSfPyfFxLe
	rOPIzXLLqug8HxrgtRTu24IVNBntU1RBRR64QHmEXO9Cg5GV3K+YxIKSAfna4gcj
	LyQD+g0eAS2bNDloid2s/K5SmZOPUNBXf7Jzgetq5tU3hOQAW5DYfWxMZ2IIFdng
	SgHPs/94fngW38aARHgHZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760512975; x=1760599375; bh=J
	arpcUu2bb+DOglU6mImrP6ScdoPGybJiL85K91sqvY=; b=Wc1DVD0NH4nPv6jTA
	6Fo3Ebo3Dql0SnS4yQk9P5a+xONCVIRDPMP1u33ktVvhECr6Bzembibup1vMin0d
	CsJd9srdrvVQ5xYy/QRn8oYtQ99g5UghriNdvqIt8diU+cAKmcVE70XSsTqcHU2B
	YyVSEQdKrq5u+vAQlbv8K7+uTDCaxIdQ+TH8LPgGO8Vx+X4BBZzUbvdSc3c1eg4H
	9ZZdWPMS/oNLVoGeJ0vGSLLxkssvn9I6mMsEj5J6kuVuxr54+DCxB+oFXW9zcroc
	uQyMIEbUVQ5KL07r5BwN61WcaB/okuTz9/D1rihQ78vFRqXmrakmAe5h8Eu+uLhE
	tc6Tg==
X-ME-Sender: <xms:z0vvaJJ2uv0Fk-a-962s8JHRhfdJghh_fOO34RKkALuMjIKj1HIScbc>
    <xme:z0vvaP97ElWC96GYmaTPsDEzXkY0ggmJwnhWYYI2dOQmwrdNjmS20Qb0ML04b3BhO
    kwV66O7oDvSzHaPxgFS2_QAUKLqoepmqnq4FTd3mxuwW3rDNHil>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgtgestghglhdruhgtshhfrdgvughu
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z0vvaLdweVwterCOLxeHXEkZfz1wlVzl5pKpQbxyCGVBhpoGf38tJw>
    <xmx:z0vvaFhTRbNhOgVN6TEoPU5I2Uk_9jFpWLV4udtlQJShQ2-PbaY1gw>
    <xmx:z0vvaDo_Gp7MHWykgcYiQPd0V_zwftx7nT0QQBrpY-Zzi5skYBWxqg>
    <xmx:z0vvaFH_RC3lSNgUL9VkVQjXq8vGO1IxBPRsQs3E3tW5SiwMnZxdfQ>
    <xmx:z0vvaMNdMv3Bs10dRvSQhopHrqdI9AN30kN-F66_s1DDgw-tF55IoVsa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 350251EA0062; Wed, 15 Oct 2025 03:22:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ab9RnBP9Mk5N
Date: Wed, 15 Oct 2025 09:22:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Greg Couch" <gregc@cgl.ucsf.edu>, git@vger.kernel.org
Message-Id: <0d0ba0bb-304f-488c-ac45-58f01ec87c41@app.fastmail.com>
In-Reply-To: <870bd6e8-3253-4b25-85f3-9a12b074548a@cgl.ucsf.edu>
References: <870bd6e8-3253-4b25-85f3-9a12b074548a@cgl.ucsf.edu>
Subject: Re: still using 'git whatchanged'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 15, 2025, at 07:42, Greg Couch wrote:
> Please fix the 'git whatchanged' deprecation message to suggest using
> 'git log' instead of suggesting the painful --i-still-use-this and
> email. The current behavior is unappreciated.

This is coming in 2.51.1 which looks like it will be released soon.
