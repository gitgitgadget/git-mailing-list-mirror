Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103003176E4
	for <git@vger.kernel.org>; Thu, 21 May 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372051; cv=none; b=DStvrp7/ZtK9wEZwtWOUNYNxt2cbXOxkf+qoCU0p0EYztmC+zwE24uyV7JfRElpdRvNJXgwiXBo9HHbFMKkM7oEJwVo6Bg+NAVP/Uk6Fowq6uO4MYVnNflz/z6VaPQRgTZcLzfDI+MV4N1KP0ol8Q+ZI9xGRr2Z3Cnp42vvlx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372051; c=relaxed/simple;
	bh=NOxmv9K7BtZBIX0s3tdoaFRsglGpolADQZZhvpFUOZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poP7XxFeCP36B8pKFsDru6VGQCTzs7d10kofII6I4ahVrRPv/jLwI4H+yEBP2yE3PdVnDllDYmy5D82qqCtOrFtXbrLn9zFuIPgLLU6o6JHOWetLraB2eo+oYojsz7v280Ant9GRZfa7fAmtKpS2/OU/A7GWHdM1CyF2LCx++zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JGEQ4VFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2+UOOGh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JGEQ4VFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2+UOOGh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD6017A013F;
	Thu, 21 May 2026 10:00:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779372048; x=1779458448; bh=rgvtrQNOWG
	garLaJkDiVYIGFV/0CEfkOUDH/yhOMz64=; b=JGEQ4VFvqCAA1LI2u59gxWk6O2
	j89C0MyWP87hiJKWmeDOAOh7jTOB6yTSZJJdB7VVlk6HMqq+kbAtAkkOCH/qwbnP
	4s34Fr1+wQNhGooSGwla+f6ChTPn9YaX2QEAlNkzFX45WAG4JYqJG756iEZDTQS9
	HE7RWBF++oI99XfQARVfKtWC1eEkuGAdyuxSOuhTRoURP3c7z2uVKzNWtdr1J6Wv
	YFAe/EK2lYfryjNgrzx46eTa/0QttR2teQXmJov+mBnsU3pSlhxYrmSWikge8e7X
	GZ+QrUjmj2IoH54oMQvhk+eCG6mcHWN4aeeI35bogKDjoN8UnK7NEz1DKPeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779372048; x=1779458448; bh=rgvtrQNOWGgarLaJkDiVYIGFV/0CEfkOUDH
	/yhOMz64=; b=o2+UOOGhIlAlpOeFyOTVGwnYuR1IKTWsrckuXACaqfthqn88MBJ
	/IS1lfbs6s0QMNPR1Nhg3QDKFWO5CbzhqCL8nF7bZHTEeBNkWxZxbygu/3wi0Qnx
	dNhntGljZgitm73kInz9tEATSnkRL1CbpaTgYB3f/17s41Rz0Q6FSG/pQ9uFho4Y
	swsOvxMgjAtFfCg4A6jZlDeZ5oq/00ONwhpxgp1yQ+aW35aIBRAB2tHVGy8MmaVC
	jZQmKLo6s5kB9UzQ8t1ozxDkqRsCHK3jP12eO2A4e65AU4yzCQYgaYv3+FYpBfSV
	fHXBQRE2HnIXKHN9LjQtIhuyOvZdG8QbUXg==
X-ME-Sender: <xms:EBAPavN24wpaZ6trfOqQqxIP_QCY9M38j6UjC-45mA1wTj1TWd5LHQ>
    <xme:EBAPasP7iWBYZ3f8amxhqNE1_9rFPWbJmXEpT0rPJTVWIZKF0Wvz47qZRyEt9uB7X
    iRU8SBeOFEcWJujwKLNqPjVHlqPby4njCTicD7tX1RJJ3-nkR8D>
X-ME-Received: <xmr:EBAPaghA-S_3pkY7MkzMvwBktVayxSJi4o_eRXxpoJhvAeIAw3ZfmbIvaFIIqntBUb-OlcI2lTiPH1f_isRXq7i13v9yJjKPBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhrvghgsehhuhhrrhgvlhhlrd
    hnvghtpdhrtghpthhtohepvghrihhksegtvghrvhhinhgvugdrihhnpdhrtghpthhtohep
    ghhrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EBAPapvhtuKyURmPxUvNn6MnMTJ5S5Zl2vljjylNGkHDJ93fCX4GdA>
    <xmx:EBAPamQlKIPYbCR5Om9NFWccJlvNaYRg6TByRUSX2SDOUc7nYzVxOg>
    <xmx:EBAPal0jLWzth5RMfb0dE4IMG4mi3QjMagQYFddkD4ofOxGvHtVjHQ>
    <xmx:EBAPajv4k1CkbFClzD-PHNcMTygWjF7vF9ybhz05VwIKL9ooIvqDWg>
    <xmx:EBAParc34w11aYv1bnRuFFuwDi8Q7IyHYOwk3YiXkpeh5SL9W2-uesH5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:00:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Greg Hurrell
 <greg@hurrell.net>,  Erik Cervin Edin <erik@cervined.in>,  Greg Hurrell
 <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH v3] git-jump: pick a mode automatically when invoked
 without arguments
In-Reply-To: <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com> (Greg
	Hurrell via GitGitGadget's message of "Thu, 21 May 2026 13:45:09
	+0000")
References: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
	<pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 23:00:46 +0900
Message-ID: <xmqqlddczwtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      * Removed stray # from README.
>      * Don't both teaching "auto" to select "ws" mode, because it is always
>        subsumed by "diff".
>      * Update usage string to make clear that git jump --stdout foo is not a
>        synonym for git jump --stdout auto foo, because distinguishing
>        between foo as <mode> and foo as <arg> is fraught with ambiguity.
>     
>     In answer to Junio's question:
>     
>     > If more than one interesting cases apply, what happens, and what
>     > should happen?
>     
>     it's an ordered choice (merge > diff).

After 'diff --quiet "$@"' says "nothing interesting between the
index and the working tree", I actually think it may be worth using
either 'git diff --check HEAD "$@"' or 'git diff --cached --check "$@"'
to see if ws fix is needed.

But I am not a target audience of this feature, so I'll let others
figure out what to do here.
