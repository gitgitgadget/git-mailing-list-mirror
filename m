Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE73E63B0
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251909; cv=none; b=UB+lu/wHtzz11t+YzeHzoxm3J57jTA1Gu12cQ/dqkcJ7XDaUfIlsbn4JqbrW3lhhoHMnvwwgTRx1UxsO1Axwyj9H4CcU1nZpt7mnwzTnbjvGjVT8JQvozObkZMteU9u16LauSYKth5jxMYELS2lPv330jj7W3N5YnHrGdxwR7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251909; c=relaxed/simple;
	bh=70kqb0zCdNeBY8SzZoD0ekyzlOIXdnlrHCUdVeK+Uh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ClEkiwuawKkQhvAOfPZtYM44GS60ByXTj/qutxORQyIdqR8BHp2FKiZ5mLVz+u0O/DlA1tv71j+WzT9iwejAHhCFiIY7CQC9yw8L2N4DCXTcUJFl/xuEpHHwtjBC51i34HwlsJib0zbsVIgJAveLAy2tBBzVUuizjyBmiQsDc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WiQdepof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8z56icY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WiQdepof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8z56icY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E88CBEC064D;
	Wed, 11 Mar 2026 13:58:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 13:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773251907; x=1773338307; bh=4uhu3h97Z0
	cqTCIa/NQFSgMPaSaUwP2FBv3HD7l6j0I=; b=WiQdepofqMD/u63Q6VblJ5hedD
	M740j5Wu3UAy+yypKJCpuFExTnPBcUQbnO5qGsFjGoKBnRBnJOhCO0PAS/LXCkbR
	SkUQlouJO9U+gN4xil4oAMgqjVwEUD4zHjF86RgbWke1tIUN6dgpMUmoj9h3gSim
	HO0X4v46wVeFg9yV7h5CYvojvTpivf1iWodaiV/+8KxIbMzcc2LsmyXGTar9klFn
	prQc3YoPi0ruOtOwGlLvzkCJfmedJx+GE1fdbh96pQy6d6Vstr4I1FmvFvN7XDfs
	/j3lrwGbteVXGDTEzWOj9miWj4JG+iyfYPuIBhkivNhnhT7HHTwoKm9CEnaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773251907; x=1773338307; bh=4uhu3h97Z0cqTCIa/NQFSgMPaSaUwP2FBv3
	HD7l6j0I=; b=I8z56icYJhXu5e2vw0IIa4yBlY8WQXsy+ropqmxpN22PzEx7kYq
	dXqz8tlbqvp7lWcYi+nt5J/fv6Snr60IXN50YehwvHAhn3Rts1Z2NrF2/u/SM0jm
	MoHdMOYumghfVf/z59F4fh5rxt30I4PfjySZV5GNCp74a9z5IUMmnIFpRKuODNsf
	nWTvH/lNhXhaDgRl8M8Q1afYxJadJi/ZP9JNMCzL9de/5Q3KA0AwsN7dP67xg+eU
	b3pjjG7iCsbOxBG0VbR4wzJ9Xa6j7nlH0IH7x5xTAsJVotUbxEUfvFcV6HiNjhMP
	yQXsruC9OkyDV0kDUXL1tCVp7spyNRejEsQ==
X-ME-Sender: <xms:Q62xaSjHc1V3BGMYe9jgvh3pHNW5UqNLUMUw20DlGd86PoYppTxJ8A>
    <xme:Q62xaaez62Focbc5uxXHciRbfNTPCR2yN7rll0vCqEPIIB5tSR-RRpdO3xjzPlR0h
    ASDsXwVyfi8-5_u9a2gKkcvHaPdctbSmx2RP9xl4prJA92sCTb8Rw>
X-ME-Received: <xmr:Q62xaXeQNRkkQGI-o5rDHk43chtBhOYKleBoR8hCazTithq7a4oBWtRTHLS97B5CYTCXUwT9Pwnpo_P99z41O43xtUrosl-8RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtshhhuhhn
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Q62xaU_wFySpCXHirKfmJHPajFaS1A_3s6hZmINcD87PwFLJBL_xUg>
    <xmx:Q62xaTnHTVXnpCjVO_7Xd8Y0_sVgAdeGMZjIUX7cmuEHXX7MHxezEw>
    <xmx:Q62xaW-KOFRDLsYttOFVfe2StvtDyiMVdCsipgZSsmKau7mVV6gdSw>
    <xmx:Q62xaRm1mfZU3_B1wmUfKJz6hT43AQApU4zaDyG4F9hlPXGo8kWMOg>
    <xmx:Q62xaafUWILiGNd9qHq1PEYjdZfdP7mxi2sZR9k9l3irlneo4UJ91Uyr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:58:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] transport-helper, connect: add atexit handler to
 reap children on abnormal exit
In-Reply-To: <20260311142021.3464789-1-cshung@gmail.com> (Andrew Au's message
	of "Wed, 11 Mar 2026 14:20:21 +0000")
References: <20260223165147.3294516-1-cshung@gmail.com>
	<20260311142021.3464789-1-cshung@gmail.com>
Date: Wed, 11 Mar 2026 10:58:26 -0700
Message-ID: <xmqqsea6p7st.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Au <cshung@gmail.com> writes:

> When git exits via exit(128) on transport errors, child processes
> (git-remote-https, ssh, proxy) are never waited on because the normal
> cleanup paths (disconnect_helper, finish_connect) are bypassed. When
> git is PID 1 in a container, these un-reaped children become zombies.

Could you tell me more about the real use case behind such a set-up.

These children become zombies, and then what will be done to the
container that lost the "git" process, running of which presumably
was the primary reason why the container was brought up in the first
place?  Wouldn't these zombies go away when the container that
finished its sole purpose of running "git" gets dismantled?

Thanks.
