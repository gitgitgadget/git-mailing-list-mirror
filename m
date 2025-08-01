Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EC14F70
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038069; cv=none; b=TxeGPgbYU7nXq9PGrqfN4lvo7Y71+mrMsL6oxFtvOLl4PRyAebuNLIYIsVeN70DFL/L1cc7/WqfsJrt3gp5UYgDa3m5kky6lQ3WV1EtM/Kk5Slma3pUHic+E+syeFAPGXG+lasstKnuNCqjlehNUAEFKQ3WgemyTgwHbHFUML74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038069; c=relaxed/simple;
	bh=qvMlxSa6Vk9IA9PWAWBiBHq1viwKIA7wqK5RDhYAr+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoP9Uz5SWAJTJHwiwgn6e8XDoH3ubWHt7MMrXC+hGHllHkUhluw9mJcNMShYcFckrATqR67TUA1I9b4roJpJUuihnIwHAMFSN7h3kM5F6xJik38xfVBNwIj1Z2UHOyWYu5KGWjWApn+w8GIeda5+nPn2280jjywIx60mG4WQRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RC+RN68R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5FiYisk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RC+RN68R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5FiYisk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEC8A1400103;
	Fri,  1 Aug 2025 04:47:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754038066; x=1754124466; bh=RCPSShiknR
	QLQ1pe6aT9+CsDDc4D9etJfHlyGiQOkoI=; b=RC+RN68RU6MtkAJk8ZBqxwPA1/
	Sqzb4NehVPkeVSweK7zacFaZfPyo7kfInbQA3W4Tm9P/YVZF69OzaejlYfZ8oAjV
	gPhpWze4LXeh9O9SkKxhW1Jks3PHdSGals5bEgnXLAKCdqlEpKF9c/WZJZ5c7Jd5
	MqcuDPdhltRmuV7qNyVC9PLQQdLOEx2TpBhTbZPX2+xU4nJhnYgdPcaBjDEChG1k
	11BqVfBTXrYwNLMbIDkd1f3XdJodUdttntVRsTBpn5uTr/3nlMCaYqv19gkMerP2
	6FyulyCQ3OygqiWIQ7NUC3jV8PWMbRwkZwFLW9zHxe4cBUTJbIcoEsYu/G7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754038066; x=1754124466; bh=RCPSShiknRQLQ1pe6aT9+CsDDc4D9etJfHl
	yGiQOkoI=; b=W5FiYisksoV6kNg2TdOlUwfg+vwMv71J1GEqa//Xq3HD4s9/zo9
	mvC5W2oS4TkY9ynVXn2DOS+30Ug8/x5zmKjxgeEsdUtJ1W/N4grCgUstw+eOsa2Y
	H27kQCftO4vtpVS6uwqzi0qJzgIpxGWWcMAcJmElMRrayGX77jQOpwHaZsd31L3e
	9Eyzzbj8Bb+BQHDARYToxODZjt9hdK7lwB723JMjmts3Jj52sKijz+jZggLJo1gM
	Fh0L1d9YiPbK/cZraxIZMYGqQJdMRONSof/3gh5/9VudpJWvQwkYmA3IHURjwuhN
	jHZL5ahT9ctDRxl1A0V0ChO5xLwC/r6SzZA==
X-ME-Sender: <xms:Mn-MaLIOPUz-YGK73tsLMgZlzlegxUAdkC1T8v4WDJQGELxWusymVg>
    <xme:Mn-MaPUjlG0SNw8C97hgCEfvK5xBEtTrcgOfENGJXOSQmF3uhSPzr4qPki1iX0h1s
    -rcFzc8cFu7bEAhlA>
X-ME-Received: <xmr:Mn-MaFi2F4RFT-nez5nvbzRkH-Pu58_y0ZLccpLJVZKbNQreeeRrCuPKv0ixGSSTgKOEJvAombSqCumoQ-4_cTD954HC3swX0lr-hFUEXGGW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Mn-MaC8x0t4qEv6MJLcwEdPQC8vdIFE8dYOU783LDx8nsQMJEcvMFg>
    <xmx:Mn-MaHAWm25e5MYdvgTaBs99qwChyt3cGVsBD2pRl6X-gwC9kvIXSg>
    <xmx:Mn-MaHLgBRnn6yd5XRxYemuscKT7MWhenKXuN_XUHzvTVqZTDgdKXg>
    <xmx:Mn-MaCn0EGb8bWLRBr8SmIn0MPhQ7hflCo7VRDvT-25DOdg9kcYplg>
    <xmx:Mn-MaFtLZUwWV6wz0C7-Lr-uPbHjT7n7DkWcu8T85TiQmHbrutK1-6Z8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:47:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cef268d9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:47:45 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:47:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] string-list: split-then-remove-empty can be done
 while splitting
Message-ID: <aIx_Lp67GZC9fHaF@pks.im>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-8-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-8-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:06PM -0700, Junio C Hamano wrote:
> Thanks to the new STRING_LIST_SPLIT_NONEMPTY flag, a common pattern
> to split a string into a string list and then remove empty items in
> the resulting list is no longer needed.  Instead, just tell the
> string_list_split*() to omit empty ones while splitting.

Neat.

Patrick
