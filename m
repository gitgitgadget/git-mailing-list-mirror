Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4462C237E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230870; cv=none; b=L4+VVzlGiEZYU9KQgB+m1baXY7zW3tLfWmIIL/rmaat4VYSJh3MPHqbt4aolNq9ChgT1lsJIHpL+2+znNnmCpek6qzhzQ0E12aCzN45qLvC6scxcdySFMGm/wXmpzsv84p3BhCiM7FhiO8ar64Mj6vou59jBBMT67LrE/uuJTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230870; c=relaxed/simple;
	bh=JNJwg600qmrmAuhtMgRl7h/X/AiLK6ENYvOs6e+Hgrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFlRHqPKOeBn4unznid7yCfhR/8g7j/hcs+S5n+zhRaAh/0gwToQL1OcmS9q7PM3Fui/OacTQ7ITu6V+Czj/bs0jySMMt5f9PZ10/XhtJLBxc3MymORFT14WxcY4KldpH9wz6E9KvIpR1lkTY8kqBl61dkgap7R8XR+5JTg6mN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V7Kl1cKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KW2gCe2Q; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7Kl1cKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KW2gCe2Q"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 795BA1D00257;
	Fri, 27 Feb 2026 17:21:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 27 Feb 2026 17:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772230868; x=1772317268; bh=1PLMe6JyO0
	CdCxUoRtnoPGaYos+gzZAXjekYzuT7PQs=; b=V7Kl1cKlOudmIsqLTQJk3HGOJX
	iSFVPcfEwC8qrIED1/anxt68eo9PJR2Y8rWVLX7XzFGpYrds4GUsjVtD+s2+Kgca
	6KBSYK4RO+cjbgX6tQrDcujTw9smjD3oTA6BxyWOzZtXJR6ONYh+XZKbGOWhwhBL
	qVyhtNzE1yhq5kHpTYxgbpT35YglXJpDyAO165jyOCZyGszm1SOOTNqcCm8ofdF9
	OACeg5UOGW/t9s3Ebe9GV66yMp/08EXuTy/g4LfxTj35NI7yK0K8Cq497IYi/AIo
	KVG4xpbT5sjfrPoxXGSfziAVz1+BPwQC2tU2KE250dkqtYuenrNLEI3lbbBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772230868; x=1772317268; bh=1PLMe6JyO0CdCxUoRtnoPGaYos+gzZAXjek
	YzuT7PQs=; b=KW2gCe2QWwlB4A7Kd0oyrpz0DQmL5iJ+GtCSsCpAMSEgKBrdBCO
	ihurSdjpTlt+VIgZU6YUFJAAODT7erFfaqtGCwheiztD1t5bGDFHtkGmoDuDb7nP
	n6txan/Sti0cKOBcVUvC+hLyMDf9cGgXftsYnN92YeYSW8nvrRlg8hrn8nCtR9iy
	ti9LJ7itMnoe0Fnk6Y5bDC61nX1FILbc0d8MBNbWJbPwery8TzbTG3noMYhVCFZV
	H7NllFxqRi9kwGr53QPVDLNiHux+F6ZzhU7tilTBeDF72X7//hGjb9A6I8rsR22D
	okv1X4Ht43qZVYHAhQHg9YjwT/06kbyyXTA==
X-ME-Sender: <xms:1BiiaSH5zbSHN3iD6gcXCWjziOOkSymPBZcROwPqsVyMfZkENTWYWw>
    <xme:1BiiaaV5IbVxpD4yyt4oqAhx6tiCNjPNwSzPemOnUv4AifsvQOq-Q0ePGl4pEtzuX
    nfZJcqgO1W4QHizwfhV8A9WjDJjSZoZpRuuQy76DPdqwLcmMGarlA>
X-ME-Received: <xmr:1BiiaRIXkdqMAuQHiSW7SmIZ7-qrCNjigJcW8LPW8D-UsQ88veqJ4bzxF4pW7FYwOkMHsfoc6B7-DRaGwZk6BKWT5-jY2Szv3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1Biiaa8MOSTGEd4ghu0dI0GRKRj1x-RsiToO6_rFH0OYxpcvvuwxwA>
    <xmx:1BiiaULWRM7wPTfxL97hl68r7C2oAHuy8Snj3-mlwbZCJijlVVwe7Q>
    <xmx:1BiiafnTPLutaF8dGXm50LY4yf49bFkBylmKMJznjK6A8n_a7cYN0Q>
    <xmx:1BiiaYMKzz6msvx7zlMMXWoWOK2AnBCfuTzhoNQumofhP4b-qJULAw>
    <xmx:1BiiaTJBSNsoP_wqCe1olOQhzdSQpmBI-mbEkWvpqXpnoXuucBSgnilu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 17:21:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 4/4] format-patch: add commitListFormat config
In-Reply-To: <aaIQcXgOVLHXP_WM@exploit> (Mirko Faina's message of "Fri, 27 Feb
	2026 22:51:57 +0100")
References: <cover.1772156996.git.mroik@delayed.space>
	<cover.1772196510.git.mroik@delayed.space>
	<f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
	<xmqqecm6rs6s.fsf@gitster.g> <aaIQcXgOVLHXP_WM@exploit>
Date: Fri, 27 Feb 2026 14:21:06 -0800
Message-ID: <xmqqy0kdomjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> Or we do not have to worry about these if we just use what the user
>> gives us without any DWIM.  I just do not think we want to see the
>> "not a shortlog?  must be log" burned into the syntax that will have
>> to stay with us forever.
>
> Since we already require the prefix in the command line might as well
> just make it the same for the configuration file.

Sounds sensible.  Either with or without DWIM (with escape hatch),
being consistent between the command line and configuration is a
good thing.
