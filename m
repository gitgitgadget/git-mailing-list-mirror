Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBB190676
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529966; cv=none; b=cajdCcNzqM7PrBZxDvrocYwFq8mrLELDURC54WkYhDdgbm3QoELYaEBk/j6GggICVYhwHr4m/lNIIKL9nI12vD7tWS9eABNmbA9Koxj7d2cBAs0aySPwQWngizXoGzXi16fb2aKi3Ncu36p5tvorkqv87/7zIhhk2TbuJYLrEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529966; c=relaxed/simple;
	bh=CiQJr9ofrDIMmnTBEpEleqfyqXrsZkTivCGBeRHI5jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnzhRYT+h8J5vqOVk+iraLVFXC3TV/blbpWbSIj6W3DE0ENsYdXFu7zIsnqBMlaNAY5NLOUZx2CipxQxQ9FwMB8PMUAife1PobaOaB3q/5E8nde9Qk7LHrZD/yiQjVzrv8tcA4qovmFsYrrLYHaSc3Aed0BRdx0/in6VjYBmHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nm4/rw7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cseuoQMA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nm4/rw7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cseuoQMA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A02F5EC05B8;
	Mon, 14 Jul 2025 17:52:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 14 Jul 2025 17:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752529963; x=1752616363; bh=4o7pBWA3nn
	uz9+eSCZHGyCkzxLCXF1H6g8ydOsPYu/I=; b=Nm4/rw7s3MG/CNjz9GnmopaI8n
	v+x9uCTyOhmM0vx1LsT87iFralpPWzOJIrVsTXdYq8VWzNWACN8NW7BpisnyC285
	ixC+FhO1CwhFxqA7lYkCtPMfSgAnUNdU7ImRpKPdjadHbgEIFSkbBkonXLZUDBEt
	kryB16/V7xVYatJBv05RMyz134v29xoTsLBYMSAdmicn0p602Dba+8mXMjQAYRiB
	E6ImWt19aTBIqX/pdxffzi/P50lgsLap6o58kScxMg1Bhq0rOF5Vg4fjrW1NtwI+
	1h998+CnIhsjfcRVltahFh34fUcWRZcZWYqHOJ13XMCLxhSr0PhmCabeEjtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752529963; x=1752616363; bh=4o7pBWA3nnuz9+eSCZHGyCkzxLCXF1H6g8y
	dOsPYu/I=; b=cseuoQMAmXxCP+zdN24A0wjQL3lHSx7JavuC1SaQ5aWy43+qPcp
	YbQnjZrb0dbE+SXcbR3819MmvHp45l1vVgMjjH+GmT1rRzG5XKOUzpI2zljjgGYM
	9laXEdKQI9zx8nyVe7toB2pp3jXUAO4NShuwEtAcGTofrQOiC5rgey8wh7sWegq0
	Hr8p6tN4aRKp6ZrfxqLicgKy/7UDbxVJMcvEUgYRebZdm5wJhcDxh2e1iYWUVBCb
	oFvo713Paxx4SoTw4Q04t8EbNQOmNAYIbpYlbGhGwI66hycANxgUQFE/qGaQ4oF6
	nQWighChqL1MbkyAvEA0rtpIudQlUhDQ9Kg==
X-ME-Sender: <xms:K3x1aNfOg_U7KO_mU9mGJ766-QuqH7hlyzFOuclt6HNvk7Zm6euDew>
    <xme:K3x1aDqW612OXtyBJlYpNWBClNe3ygJcBrCL8QDoPfHjdt0XVh-XkA1i60kdi6UuF
    WSAHlnSy95t6D54mw>
X-ME-Received: <xmr:K3x1aG-CrFPcBb_a7euWORKlqMsgnoeQrxeaksrH8-TV0PEwhuEVVPbCK8Rmrj485p4-SiDUF1r0WPsfUmzVNGCHFsetKuFWnogkI-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehfedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrg
    hrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:K3x1aHcSbYQKuPU4xWUPuXDOh6GeJnsHVuclJCTApNtoJOoYiCNapQ>
    <xmx:K3x1aILl6yei01vqeg9khIZsKfVUD2mKsSLrAwhjThonIRJzyspXTA>
    <xmx:K3x1aPj6g01nA36BAZBTFkUn9UGrKdAz1ciSiIXRMGm7Outg3Dowug>
    <xmx:K3x1aOSvGgB4ExfLYO8tyoGvvqxZqgy2M7wqp56_ohPKdmcV_o5T8g>
    <xmx:K3x1aDAQbIZJlSqmI8VwibaJFL49mX9EHgqqutGCI4DR7pSr71AV373M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 17:52:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
In-Reply-To: <313e3b1a-a095-41ec-adb9-fc500589b979@gmail.com> (Phillip Wood's
	message of "Fri, 11 Jul 2025 14:14:42 +0100")
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
	<xmqqfrf368lz.fsf@gitster.g>
	<313e3b1a-a095-41ec-adb9-fc500589b979@gmail.com>
Date: Mon, 14 Jul 2025 14:52:41 -0700
Message-ID: <xmqqecuil9sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> much happier if we set errno on SIGCHLD in patch 1 - the argument in
> [1] that a non-zero errno might break something because signal() did
> not set it does not make much sense to me.

Not to me either.

> At the moment it does not
> matter because there are no callers that check the return value let
> alone errno but if a future caller does start checking for errors
> there going to be surprised by errno not getting set.

True, again.

Let's queue this round and then patch the errno issue up on top
after the dust settles.  "might break something" may then happen,
at which time it is easier to see where that breakage came from,
and we can go from there.

Thanks, all.

