Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528C183CD6
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736281; cv=none; b=o+UL5/uUadulyjveaRJTZZyp6XoUgKHr4PRdTaCxpg2emLtfM7YBjn7twR6QSalb5rbQnzfZYDvjsTIfOqLSPnQBw0opjpxy++fZdACedJLFbhwWt0B/9bhqAib+zSAKuA4t72RqHqoHPPe5lacJjVVbF7p32u49UwBlp0kZ52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736281; c=relaxed/simple;
	bh=HfeuJCDwOy3TVFn6pr5Rn55yAxjGHRR5L6au8+6/ueo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIj6ye8Z9rdJCjIbj5CqthA70za6uhfk+Ky0gJY2zYxBnKgJYOFJHg+REmYe971V9Vhbgv4pUfeSWLLXTGHL1FYGnqjtaX88vbhvzF3l0k3HRpI8r1zuqGDaZPfCN3fL4kuBxBPskV9VsDtffTVpym+c/CvkCLxZYeIuQ2FmFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VjGit6oV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbRGOlt+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VjGit6oV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbRGOlt+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E4AC1380AE1;
	Mon, 30 Sep 2024 18:44:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 18:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727736279; x=1727822679; bh=84iXD+eV11
	mSI2cqnZc1Yz+xLKBd0of3s4zx36bOjz0=; b=VjGit6oVma6OJpnbCZ0KRbKI9T
	9UimBp0vnAkOO69dBaaRrd02kZx3uQjZVZOOxwqhKayOFZKHPiwjqVP3eaRL1LGv
	ZB8+euJcmm5iLNEgqXkMRrsje5jq8LXq1Z8Nyon1ooZxg73OT0wuVVfd7CkEmV8G
	rSCRFQ1S6M5KL3aUkY8FOhATr4ui9wnWyb1+snIqYq55apf3F7vEc1zslGL+wd+2
	OMp4MpqMJ4M8ZkK0sdp1F4rbB5efp64+Y3pcKLWOUyTwmZpIky48vkubn2CMVZ3d
	qUZoU9EwDUKUf4AIp5Q342sT98j1E8xQdSVNjUq4u8xNaBg2fzFL3rhBBYVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727736279; x=1727822679; bh=84iXD+eV11mSI2cqnZc1Yz+xLKBd
	0of3s4zx36bOjz0=; b=MbRGOlt+wX0cHDEBunmobgLGxPwFIvm2lw1J6jeZ61YF
	I47rxEvPaApUpKnMnzRbPk82/lLXbcfatIE/6T79Xvzd3s2plGddAml+cG9HE5iZ
	bWEikgjpxqaB8NYtwHb69qprLRpVK5itHPMJI+wb30pZCtmkAW9hvl9+M13Ou3on
	L+J/DFQCiThyqbxEU2iXynWXW0flCIhkz/UI82qFxtGpfo2BQJckedFZHPjAZ4Bn
	6RxmhmLGS/niokQyTrMoSNrP6IzAiomOfaI7tYsgHr9TmO6/1hWSazF2XifxFZ0l
	KCUPtteXu1FmC6VJnOiiCfNeBo1p9QwZfLuED7d+OQ==
X-ME-Sender: <xms:1yn7ZpGyllgVUhq3rV0fe8KDXbVRFSaIcooOgDC-SsQKnMpfyzjyRw>
    <xme:1yn7ZuVpOsCvxcbm93YpH6g490qj_eoHsz07Mc3YhIDECJf9M6RuiTpfABbOJ1oM1
    51KCZ_E5McPWmcjdg>
X-ME-Received: <xmr:1yn7ZrIsf4CutTzkh-Je3WVgBSL8r5GbbS2-BdRQR-mb7P08dFEu2BOvJKxAIKMqblo54Nl0Fp4B-L2DD-SaeSVty_PBX0y4un5WrDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1yn7ZvFfSc1UkPI4xvhuiAtAULo2xv-v18WCzCaKIKz7hnH-u-wZZg>
    <xmx:1yn7ZvUj4AA-fvyG9b7HfBxUuYnifqNrBhUcgozfyTHK5rzzzsErdA>
    <xmx:1yn7ZqMJgNw6CQOfaDPGMFkpS8NA2RyysxE2LgoJV5ZOOQOnJcabmw>
    <xmx:1yn7Zu0dDpq-ohnyBFLaxcVo99gJFBItb56QKEtvOpKg2v1m1474UQ>
    <xmx:1yn7ZlydmnuFvnSzlzAT4E9ypV99nWjTkA-3imzHe94nDuc_-i2YTF11>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 18:44:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
In-Reply-To: <20240930220352.2461975-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 30 Sep 2024 22:03:52 +0000")
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
	<20240930220352.2461975-2-sandals@crustytoothpaste.net>
Date: Mon, 30 Sep 2024 15:44:37 -0700
Message-ID: <xmqqv7yc3goa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ....  It is designed to be passed and returned by value, not
> pointer, and it is possible to do so in two registers on 64-bit systems.
> Similar functionality works well for error types in Rust and for the
> standard library's lldiv_t, so this should not pose a problem.

It should not, in the sense that "any reasonable platform should be
able to pass two 64-bit word in a structure by value", but isn't it
optimizing for a wrong (i.e. have error) case?  In the case where
there is no error, a "negative return is error, zero is success",
with a pointer to "more detailed error info, in case the call
resulted in an error", would let us take branch based on a zero-ness
check on an integer in a machine-natural word, without even looking
at these two words in the struct.



