Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BED15D5B6
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633726; cv=none; b=frw6ZtzbLKefeKTFPlO0HJwVxxhal9yV5g072GOAMHft/mmSfI7k8TFn3Is8aKiFfzs6KDTdBE0esew18bG7fB9cwuGC1lkaPB0cMRJH13qHKHtmClMuSwBafERURZPxBeG0SuchI75eNYLZghWIKIVHU1I0wwiPwTNEka67nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633726; c=relaxed/simple;
	bh=nr8Q7R8jEbWMSinYnIEJXS8+dHf99HH8IPSISx2Fvt4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gAsQESExO8hyiM/t2rJOjrsBQBu9jDuZoP/Ex/fidInxEnOLKIUhf2+0svGn5S2aWX/WGMakiONicL3GgBYZhhJj65swXEeKaMAsJCE1L/vdakZAc7/i7INMml9x9t/A29jMo+ag7zWdNwvxQvkep2/qpKeSla3i1NrVPY1y6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=cS4lH+Mb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXH1GThn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="cS4lH+Mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXH1GThn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 71F74EC0339;
	Tue, 19 Aug 2025 16:02:03 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 16:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755633723;
	 x=1755720123; bh=Gs+dx0gW04Jpfbihf/VieAWjt1YdlIp+t8s/PiBwOR0=; b=
	cS4lH+MbdAckZ8rnoiDiIzB85Kh84+ciZnwY17nJCSnr+RRdH2nd04dLroaA3SMj
	l/7m4DbFxm6DMKNyw1DrnI2YcCMKyG06R4PDgYloCt36A3ZH3CF4KL/UYnZrsft4
	OLXIwQvBKFCrGwV6LEc/fwUAvKLCWQKGE+sZtz36biGhfhFlwpQJftL7aON3P2q/
	Rt7SkPjxF5ER64brNikTFp3wugfhpcss21Kl+iZFwSHg7htlALBLA2ppFLyo2Quo
	zPY3VR+jpYMnaEaxdtaTwrzbKeO3/asFBM+DRoKdcNVYfKsHE0oIN3K/s/Qc7hQL
	LQ7kRnMMPM/JEWvWUrXXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755633723; x=
	1755720123; bh=Gs+dx0gW04Jpfbihf/VieAWjt1YdlIp+t8s/PiBwOR0=; b=U
	XH1GThnlKyYzz+qgVsfAi3WE7EmQAucFMZc7RUDKH3ZklJSYYz3c5ng65QN0nOQk
	1olLi/LkeDUFAkqO+wg92F9yQVQKWLp+kev3IU1XP/Q0KQRlUqOwN4uXVOklnDzw
	wTjSzUhzUKPtsmUIInaIWzmX9ITX/3ok50FICXzOmrCtRR9t9X+pX4DQcxHAxlcr
	eTNYyyKQoQ0FpgV+DE3gAoEcgv553MWnhGilybUIkiT77mkMLmiGOxtlMf68l0Ze
	wj8AGt3ReHpyFtfdlXBtBz6Gci7Hb0clkO7QjyyJFWdczn0aHfVqYjgUAUbodpyu
	bUlS75nBAw2GTqMoARlrQ==
X-ME-Sender: <xms:O9ikaE1QbHSWe-SfbFIDfsQkUzkQAqPYM0vfijGa1a7J-K5-dLnE7A>
    <xme:O9ikaPF6NfeNjnofN1W35A8XcQBikj2kDiDx-nEBHY9lrVgWRWWfkYxF3Cii4QJ92
    bPBzOnU-0frugpx7Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O9ikaNREsV1fT4M-xYXNX1_eu3figSN6tWnyABrmF-sR27m9kQi81A>
    <xmx:O9ikaHiVNtrwnXRN2dtIGz3qeTqvbE44ewgzSPuB8nV8-yDhBWagcQ>
    <xmx:O9ikaO-SV118Fg921KLjTwnS2UAogIs3zPm6ozX5uBcERJ36bCzYxw>
    <xmx:O9ikaGHAqDA6_SgNmeKBPtbZow6zf3jJSVl59AAvlGCRpsrYibaOJA>
    <xmx:O9ikaMb-CjEx44bolsQ9SbIE-ZZDSIvtMOV9fLmXhvcwqoPohTefI1N7>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25CDE7840B2; Tue, 19 Aug 2025 16:02:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG4p1e8HXaxo
Date: Tue, 19 Aug 2025 16:01:42 -0400
From: "Julia Evans" <julia@jvns.ca>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Chris Torek" <chris.torek@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <44ae4747-e9f5-4d46-8793-9c57dd184f91@app.fastmail.com>
In-Reply-To: <3896226.kQq0lBPeGt@cayenne>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <5004213.GXAFRqVoOG@cayenne> <xmqqqzxcr1ck.fsf@gitster.g>
 <3896226.kQq0lBPeGt@cayenne>
Subject: Re: [PATCH v2 1/4] doc: git-add: start man page with an example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> I think Julia is referring to the fact that you can record the state
>> that is different from what is in the index (or, what has been
>> accumulated in the index by the past use of "git add" command that
>> is being discussed here) with "git commit [-i] <pathspec>".  You can
>> do
>> 
>>     $ edit fileA fileB ;# assume both are tracked
>>     $ git add fileA
>>     $ git commit fileB

I was actually thinking of `git commit -a`, but it amounts to the same thing.

I'm going to remove the "By default": I agree it introduces some
unnecessary confusion, similar to the "It typically adds..." in the current
version of the man page. I'll instead be more explicit:
"When you run `git commit` without any other arguments.."
