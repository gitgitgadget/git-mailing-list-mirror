Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1ED27E
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289612; cv=none; b=hak/fGMW6BSU5Px40oX0IEmLTLKmubqeP0kksn1o+13OgAuVOuTSjW5ocKsUxP/FRY4hUDCJ98J272a6/CAD7vT5LiNgN4/6Y33+Eld8PrZ+RdXem+ncFLMlKDbDJI30F7UStnL2feBniiYUvFtRDOKpr0vF223v/+N+qs3mOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289612; c=relaxed/simple;
	bh=xAOjPu8YrbFYkxkrrDyCnHo3pgxZ74/iAIC+fP6HqGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijQRZDuo+5QJw19S00Lcb9tRQ7IhGtNZjyZjcA2JvEPoICrfNUtbHtNaqpClC4IBM8Ft6Aa71ryy79nBwrKa8lHKfLluZtUbg1EMLwToehOpT0XEVIBAh20Vb17OnCP+N9PmAOriSwjDqjl34jjTtSK26xR1yJu5PhInkUMrwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZsO7dWlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFZSZKKu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZsO7dWlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFZSZKKu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3329B140011C;
	Tue,  4 Nov 2025 15:53:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 15:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762289609; x=1762376009; bh=RtgLvxyy8b
	iyWBfIGDknzYMKNgwHZzkIWzlMMlcYHqg=; b=ZsO7dWlonVf1jcvCmHbg5L/IWi
	BLirugTRteYUWnD2Pb5a4EI8bowUnUia30TWOqQKO6VCKsim5wop1knvRGNYubl+
	ZcW9rMjk5sLYCTfsR7B9Gl7HXz2uy79WF9LN3pyyjywZEjK8CX7TpuuAyWEYoZ3y
	F3GTzTo+BZ8h2AhE2CE9AMCF/fw9PxYf8SXGFWo7BJNhfnzPdi99Fws3U3S1ZOHy
	prCij0+pHZrvwpoE4XSu803jwgtN42QA+TgzYv1483Nf1EJC58Qd9iDPWDeQXY9c
	sjyFOJImYED1onw7qVKDYEmBidxfLCypNBQl2Gh60FUdcHZCNtmJbu3USfzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762289609; x=1762376009; bh=RtgLvxyy8biyWBfIGDknzYMKNgwHZzkIWzl
	MMlcYHqg=; b=MFZSZKKuXvuFeoYiGU3nRl2wvb02VnTXbpvOyAmm0ahH6U/2zSb
	c4wnEAgBJamNASQXmJPi/k4032bUZNtU6UOzvCKnIIav1uJiDqnuytCVCrDu2aoW
	K/oj8+iY2v8ydFMf/76ERxXZpJsFKu4NmMgYxtetx2kZaoq/bP0eTeH8i+Zh0670
	x5atR6YnlkoVwES5beMuqI3SCPGVhOU4b2Hg2sDMhA4z0/mNI8fm0AflxyxAhb4k
	d9v9dE6f/rYVpjb56nOTdpHOWjeu2JeLjRtGsqJK/7FnlEbVSt8z6PtxlHtzkA70
	gJGCCfnb/lNqgP0RVPpo5MEl1aL5ozJW+tA==
X-ME-Sender: <xms:yGcKaSosAVajot4dmJJIefMplK9yxVajgW1AiDdRb1NglRRdUsXiDA>
    <xme:yGcKaS6Os80hN1q13npYLbD2rSkELNX4Yzc80VE952rm5zj6HF5CKp9xQRHQBGQCZ
    dZdw2FZl0wS4cjHqE8YM2o5tk7OxEjKfq7D5rxBnA0yDhLxkp6oxw>
X-ME-Received: <xmr:yGcKaZe53Mj1Qpj6448IldPTL_AXNeEtPPD43u4FTMAF8EvRwGiZ67gY8ds8HzMiv-IabeQIdFq1AtXv1_m5NoHzgpefoWzO0qg3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yGcKaX4dnGwrEpdh8_sUFPF0fWBc3FE_o-UHo7ZtbpiwN5OxNzyh9A>
    <xmx:yGcKaQuX1DwY74KuoJLb8Ubgth3O9OJnzQMATVH4UU2LRwFcbmAzWQ>
    <xmx:yGcKaXiRqQCfnMOeK4frYX-AiiylUYyniVRdTpiMIb22vszThvdYvA>
    <xmx:yGcKabobXz9SFQP1hIk1vHEB-9cUBOuY9dmgm8rbkXL1J0CagTx1Nw>
    <xmx:yWcKabvLk43SfC7-AmAekCfsV5Ce3I1LXA1d-SmUnqne_upP94BEsIMU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 15:53:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com> (Julia
	Evans's message of "Tue, 04 Nov 2025 10:45:25 -0500")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<xmqqtszf2kro.fsf@gitster.g>
	<8b70796e-b5a4-4f70-8b27-c0ed80d1fc4d@app.fastmail.com>
	<xmqqpl9yshrr.fsf@gitster.g>
	<9ff9d97e-2fae-488c-990b-cb574fbe8c71@app.fastmail.com>
Date: Tue, 04 Nov 2025 12:53:27 -0800
Message-ID: <xmqq346tpliw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> The problem with "A branch refers to a commit object (by its ID)." is

Ah, I didn't mean to say "you must use exactly that phrase".

But branch refers to a commit object, it does not refer to the name
of a commit object.

Perhaps "a branch ref records the object name of a commit object",
would be better?  The untold implication of the phrasing is that
anybody who reads what is recorded by that ref can then use the
result to refer to (find) the commit object.

> it introduces some more potential for confusion: it makes it
> sound like there might be other ways to refer to a commit object
> than by its ID.

Yes, there are unbound number of ways to refer to a commit object.

 $ git show-ref refs/heads/maint
 bb5c624209fcaebd60b9572b2cc8c61086e39b57 refs/heads/maint

The branch ref let you refer to a commit object by recording its
commit object name bb5c6242, but for humans, it is much easier to
refer to the same commit as "v2.51.2^{commit}", which is far more
memorable.  Of course I can use master~32^2 to call the same commit
object, which is less memorable gives us a hint that the tip of
master fully contains that maintenance release.  What's more useful
depends on how the name will be used, and the hexadecimal object
names happen to be how refs record the objects they refer to.




