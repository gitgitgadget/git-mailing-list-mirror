Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8730DEC7
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664468; cv=none; b=jWvAplBbBZaVznSeRvmjIfNAZKR/LM7IrZX3C11riIQZAuEZ/6rkjui16ntWgdZj9zdBx7h0zp8+ySKAdEZuiy8dJa59XSbzgmniexS/cyLOWGs+bAdQ/aYH6y6233elK8zvYBR6MzeDOOpbV4Wz+qNp+1dWW6rv0ov00u9G/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664468; c=relaxed/simple;
	bh=0GutNnbR+gFt8CJLWGHWUNoFzs4fCgo+fdtfb/8DUAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyEexADsd5ibcZsGZ8tYFDr6FF7DI45gY8T10n6wAEtfmwRD5zpwEColW72XDh5TczojQ4qoghXP2lXXfsqxVBaMfW75pPOZqGdH7lz9JabO8gR1mK5qZ/rji7Z6JST38kKJ5WdZN0spOFAkmE6K3WK1KkHWTBdy35vYvOUrCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIywBZ+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MvIvWK5/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIywBZ+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MvIvWK5/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0309E14000D0;
	Tue, 23 Sep 2025 17:54:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 17:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758664465; x=1758750865; bh=oOjZAtX6OA
	KbHNcZ8hOV8opawvjV2E18CRogF6MfTZs=; b=MIywBZ+ta4J6E7z3V6m0bAXynW
	785vILzT809mbY4YtM6b14pN7Uj28ZMEFjbx3HT9mm9r+OLWH6wUhQYPOfDQfQPu
	1u2Z2Jl4Lc/fy4HoKWozYFZXcD6SAOZ4Sv+WuJhY4IJn23qPrqHFC86kS2VQKxlw
	gh4muC2kdD5JdTncNtPuoi9xy4dKH9SXr/RXdyUqw9Lg2sNwMrRPbcz5jnqEMn7K
	SJgFRCl8oCRz7/MgU2A/VKnmTJydmMLYvth40PDiv3aLszXoTGihhb6cZCGYu3Zw
	r+ReLtfN1uDji2Oo39FtA+kzo68OXmnLKUsO6Vs9kafhMGdWWuiQl6XIj7zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758664465; x=1758750865; bh=oOjZAtX6OAKbHNcZ8hOV8opawvjV2E18CRo
	gF6MfTZs=; b=MvIvWK5/dkL5xTtWfMvvZrBatXtMp/ZkTiliYiM4QqjcQSXWMy2
	4RXTMXK0MGvSngM4rgzzvxuJtPEJp7nqLX6nILn+JZNp8yr5bsiT10qvcepdYAQq
	/5sAhi5TYIOCn2FY6YQnS6UKAISFSJ2wK93zMZ0b/z/W81lqYCjIjtcydukjmHCz
	kj7KvbrfOMOnXHqhh30yYB4NoEnoEY6/rTdQDd6zXbySe8zIIzpktRw7zRvev0yy
	5eF5MKw23qGXhuJ8p69YBv8N3oBbO5tp0yBMw1njYI2AxOgRzBNxuf1xVMTKK+pn
	OtuJ3Qc/U/Rm9of3mGqxzAfyqqVIAVm+zkg==
X-ME-Sender: <xms:ERfTaPB2InaaCeeoUtPkR6uJn5fb4iiFkCkn9yaKXRpxRPiEKtWP6w>
    <xme:ERfTaJOFOQDjYEucI9rw7v-VqYSt9aoZkB9P9LuGLHoqzlrmdDwKAoswbbVrCCU78
    -i7wn5IEN7MnAG27-ZGi-5qo91AvbsbJc9jm-7rSqKWwpvRYon0oQ>
X-ME-Received: <xmr:ERfTaEZMx6xLvpb8oX6g9xggwYdzeTwIwhBFbcba1tsFEARd3-EmBTOKPbFayDwPpgj1pJHvB7QqBABtcl97LG46lckG3r3aN5Uh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ERfTaIvN14e0Kw91K8tp-Z3yk0u82OKJIkQpfVeB9RBzsolZ2HcmKg>
    <xmx:ERfTaGM1JyZ3NN2qL0PTjfwvfurvhqu3Pg0ZJCRhwmI-KkgTgr_PoQ>
    <xmx:ERfTaP7LHBlSHgkpdO-x9TayXReuTLCP0dPKKt5WIDBUpM_Uf34yWQ>
    <xmx:ERfTaMSFufAw_FxMd6zTQDGu03mYsyoj5YuFd0yMKeViftQorhLP3Q>
    <xmx:ERfTaDTaYbNfWMiytxJwvaLISMXx9d9Zvc74-jou1FD1CMuB9jG9xz7T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:54:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] doc: git-push: clarify section
In-Reply-To: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Tue, 23 Sep 2025 18:10:47 +0000")
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 14:54:24 -0700
Message-ID: <xmqqa52komwf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a continuation of the changes to git push, from
> https://lore.kernel.org/git/pull.1964.git.1756240823.gitgitgadget@gmail.com/
> . These changes to the refspec section got kind of big so I'm moving them
> into a separate topic.

It is somewhat awkward to have two outstanding sets of patches to
the same file under the same theme from the same author.  How would
this relate to the other "git push documentation" topic?

Thanks.
