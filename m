Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7712114
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735846386; cv=none; b=dUARTJ2kgftoWknnefLtDk1WX8yAb7ypkFYV8HRe3OFbuzRYXJSEEwLB5AFx0QFIqsCS4aDAwQPTPwTObQR84p1m2pQxVUqZbKLnBHZnFLCGzS/z/bR5Rk9VWpyxITK1QoXEdBEpwZP5ZxmBeyH779tuFMZ0McJaTMG4+R59vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735846386; c=relaxed/simple;
	bh=Qtdge14cabXuh9lhGCrPH2GmK6tw7xwmuqYIVTGYLH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQjtEI/pWcwfyWGXtnWppJbTGsNIFJQguIb+O1KjREfrGrjSkjL7n1vYPc00QDbgl1n8kbXU62zSpZVXn54duI4KbcXH43G3UjuRJq7pyZDXzDt+3ZofofMPduu/jQ6YNpOTc90TNo/H/diGWM5pygrtzTqPrpJy6wR6yRh9JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kk8BKVBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCL8pR+f; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kk8BKVBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCL8pR+f"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CB3A0114017B;
	Thu,  2 Jan 2025 14:33:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 02 Jan 2025 14:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735846382; x=1735932782; bh=+BdxJyi6/i
	Cc81Eli2z+N67QwIdW4ys1Sh08unpyZZI=; b=kk8BKVBEoBIwG8MoU58H+2srxE
	N6YjRgdsKMMLQ2b38CTmr28P+2qU5+3YffX4HaqwYn2w6V2kEoiy5Ma1mJcOYeWZ
	YbhFcjFL8mGsY1JlKuW/8Ebr7x8bsAvl8eQZ3Nn2vX4y2i4HVb9BlGepbJ1KdGND
	BM6GoBl7wg7M2DdkGKGxNaTQzNdLUfWnWYtDlE4dUjxzHOxROGR+ubHUQLkE4RHf
	8F1mkCRw+I62Na99MMOWqb2DX+lTRYygXu15ioXvkKAhlTFwmVanocbB/fVOBCUO
	uT7gZ8WFyZSlmNlpNXgmkcf170O49K0W7qOXz7fiAGb5eJyq+QS/r3WXKWqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735846382; x=1735932782; bh=+BdxJyi6/iCc81Eli2z+N67QwIdW4ys1Sh0
	8unpyZZI=; b=eCL8pR+fBNVhWC2nVtD1bqSLuYQep3cKkGmBmBEjqU8jTmgTNbJ
	HVnuPGEAys4T6AyHVS9p6saZi+2WnrIy1TRhXJUAG+2cYGXZ4yJq2YaVEtN0AFtt
	9DCaQq8mq/2Sg1yBAfW7ffHkd3npcESmE05WXKXBQ3pE0w7a3jmQ8sRIk4/5dxVz
	YAnkGrqfbJ441P5fQkqVyeeTVN/XJwLvl1NA+AfpJYBi6PbwBLVocWL5VkQcaO93
	NYnmdZ0XR8OP2zG+sJT4J974fnGD4NNT1IBlSK7r06JoGM2/5eWIQTtETE1MAXbb
	NnuQPYtkvcNooXGd5I+T+qyJnE99ozbUuAA==
X-ME-Sender: <xms:7ul2ZwJB0PZnstquY-POl0017L4V8C0D0oB1yBVNDRW9Q_EvsxfWuQ>
    <xme:7ul2ZwKW4SKudOB6Xj8OVJ5cCSXaVSpD-u6gfai1q1jbYjym5yViTxjO6QcYW6pix
    Eoxc82g2qiY-kIm0Q>
X-ME-Received: <xmr:7ul2ZwsDC4TfLFT4tE1Vqa3vFHFxM3ExdXel2vhwsAs0eKQOmrxKQL6PTQs4P7GwlXc7w4k_yrrFCE_TBVCimFLRLNCWiC8qug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:7ul2Z9aZc7oAFhDS9rclVlytgUdN96oarYzbh2LAtkZsvEp3tWcS1A>
    <xmx:7ul2Z3aI-uC8IA7KwiQk7Mzs4taLHQaNHjXrCqmsVsoq0-HIUYHQFw>
    <xmx:7ul2Z5C69IIe8B2NqHm88Mf7zbquxgJyqOW9HuLFv9WbJPdAjm8-6w>
    <xmx:7ul2Z9ZgLvEZkB-qix9pgOEXUz_iN6uL0Zjp6MjNLCBlfgBIB84lcQ>
    <xmx:7ul2Z2X0_iIWhADyThoQWmwz5mHNv-UjpEd8BSkec0Q-u153jThr8ciC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 14:33:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in
 git.git (Dec 2024, #11; Mon, 30)
In-Reply-To: <20250102190623.GA848764@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Jan 2025 14:06:23 -0500")
References: <xmqqpll9xehr.fsf@gitster.g>
	<20250101191422.GC1391912@coredump.intra.peff.net>
	<xmqqa5cavz8h.fsf@gitster.g>
	<20250102023224.GA3853144@coredump.intra.peff.net>
	<xmqqzfk9uvjd.fsf@gitster.g>
	<20250102190623.GA848764@coredump.intra.peff.net>
Date: Thu, 02 Jan 2025 11:33:00 -0800
Message-ID: <xmqq5xmxui37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>   <SUBJECT: DESCRIBE YOUR REVERT HERE>
>
>   Revert the following commits:
>
>      - 7a8d9efc26 (grep: work around LSan threading race with barrier, 2024-12-29)
>      - 526c0a851b (index-pack: work around LSan threading race with barrier, 2024-12-29)
>      - 7d0037b59a (thread-utils: introduce optional barrier type, 2024-12-29)

Ah, I love it.

> You could perhaps even auto-populate the subject with:
>
>   Revert jk/lsan-race-with-barrier~3..jk/lsan-race-with-barrier
>
> similar to how git-merge uses "Merge branch ...". But it's a little
> clunky to read, and unlike merge, it's a lot easier to use names that
> are not very meaningful (e.g., I checked out a new branch based on that
> one and then used HEAD~3..HEAD, which is worthless to mention).

Yup, agreed.  The commit title is much less interesting to automate
than the "we revert these three" list.

Thanks.
