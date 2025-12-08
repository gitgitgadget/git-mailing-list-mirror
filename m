Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E221254B
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765232646; cv=none; b=lQg6CTDbp3kLZPvZbRskEpKh/yedH0R95Vf1CsUlDEt5jyW/wL5m2dRqLA2tI9bgW/jrcNXyH4DluDfG8P1uDy786cMI60jqdpWrcZAS6okGmhLBK3pLho8O9aBb2d+m9lqGabcCYWXH1xEcIyYvrx4J7RGTlaYpCKo6bz3Stdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765232646; c=relaxed/simple;
	bh=VVOw8QIyTuVid8fdXij4E/e2qV6gDQKZGHTN75zOkZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OwNkZPi1Q2pNbRMxRtrrWoZpCvVw1hkHsmL6EoegB+HOuuCE7O7Fc51tB3Ed2lPqgkpXYHPIC4ibkdFgkJ8HWnVyPzhHTaF4fET42jR6P8XUVzwzWvzMq9hjk162Nf3xvtHcFtK2VL4/eZctSnBKG7TeJTs2YCq1eIwFugVEOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P77gFp9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vmMKUgLB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P77gFp9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vmMKUgLB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9DC01400228;
	Mon,  8 Dec 2025 17:24:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 08 Dec 2025 17:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765232643; x=1765319043; bh=Mi1imrnGGZ
	qvv1ep4woYiVA2eD0qpuUfPmeCjHliwVA=; b=P77gFp9pMzCNVQoWaO2fAmqAsl
	GhN/35CAOW3qqe6a2PUv6yzQmZxLQ0ronwD/7cmyWaZ5NgM4x3pJWyo0bAgA/HvH
	OZCFEDX0HuqV+Tr41vU2KKQ4TSQhHMwTmyFAjbLcLqn/mGhjEL4MHA1Z/GmouF6y
	YrAd+rmOizQBTMxdnVAmshyRQ2CIKaJoihXnap+EkYi8ztzVSTNaYTxdCaRXDQYE
	RQTnevSWwJ/oRsV/6Kd8KXwkpjUGxMuGJ9FxmOJMTp8r09YKABDcn0PDukjaX6LH
	WQZr/jmLYrTFgpvGcm9pdActT8AdDCg2y8V3kWERwrW3oMtqR50VDeI7010g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765232643; x=1765319043; bh=Mi1imrnGGZqvv1ep4woYiVA2eD0qpuUfPme
	CjHliwVA=; b=vmMKUgLBcMz2GUSHWSzZIEsh3IOAnGs5usv4qqGyfzT74NJLLFd
	811N6S3XFu8dyOpsWNxc0dFrr7uEaHLvVmrJoiMjRs1knQGsxriGPBAbscKFYSLb
	RLu6OCAizwR+dg0TUCDtvkQcyUenjiR175+aHi7dd6LxduDq/VgVJLPLjE7FHezP
	csoNmL5tzrodocf1adLcUR46UAYJ+Ei7L2U5SCmKlNQd9Jqv+xDh8mAjTAGT6S0N
	ckf/+XBishBw2KOV3sHtyfQYOvWV78aLtoDVdhqgvIiRNZjgScjhyeXQwXcFyW0Q
	4zHulpmooLf4s6OnFSa9h01pe7gb1klunDQ==
X-ME-Sender: <xms:A1A3aemOY4bh6PRogDUWSX9IXsNlAMls2mz2JI5o_Idpz2z2nN6PCg>
    <xme:A1A3ac3vw9oVr_dYsgNOaavhD8Njy8gQzsDMGtwkp07Psi-O6gUJtAaPmNGjoT-li
    Yu43NGoGFNnjzcocKDG2nhkX_GQRczgcgx6WMnxBwgBjugYUGS4-g>
X-ME-Received: <xmr:A1A3aRpWxXPCMZzgxTpkduhHOoZ_-0bxub1CNAJvj3Stfj-HuqncUCUnPMFqw6tFxynVErgLriM-UCMx3ZvAbIlxg3VtFJhv8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprghksegrkhhkrghrthhikhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:A1A3aRcTeVsG8_mUhMVzYkLGpC8Qe2kW0sakwblT91M5G0T4u5LrUg>
    <xmx:A1A3aYoAKfLYJ2EQhOMAZPzeoERYQg2QHC-eeXHUJuVoEQivsbE_BQ>
    <xmx:A1A3aaGEv2sw6hmL3P7rSZjaxE59AISvmXUv4DqZyg705fyIgQyzuw>
    <xmx:A1A3aQsyC1yfeFlMW9eyFr1zXKQMYSfXTq-gX5EzoyW-6s-4NsavYg>
    <xmx:A1A3adJgzR90IQmzWCRDGcNjXCkMlcfsNriYxXJPaYYvQiYaqx8JDqMx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 17:24:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kartik Agaram <ak@akkartik.com>,  git@vger.kernel.org
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
In-Reply-To: <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com> (Phillip Wood's
	message of "Mon, 8 Dec 2025 14:30:44 +0000")
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
	<04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
Date: Tue, 09 Dec 2025 07:24:01 +0900
Message-ID: <xmqqa4zsliim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> "git push" updates refs/remotes/origin/master when pushing to "mirror".
>
>> 8. Try to fix the problem:
>> 
>>    git pull --rebase
>
> "git pull" tries to find the fork point between origin/master and master 
> which is the tip of master because "git push" just updated origin/master 
> to point to the same commit as master.
>
> Unfortunately I'm not sure there is an easy way to fix this. For now I'd 
> recommend doing
>
> 	git fetch && git rebase --no-fork-point
>
> instead of running "git pull --rebase".

Yeah, it is an integral part of "fetch" to update the
remote-tracking branches, so this is harder to fix.

It may be possible to stop doing the fork-point computation in the
"git rebase" phase, and instead do it _before_ we run "git fetch",
to figure out what part of our history needs to be transplanted on
top of the upstream, run "git fetch" (to let the tracking branches
updated), and then run "git rebase", telling it exactly what range
should be transplanted onto which commit to update the branch
currently checked out.  That would be a much larger change.

