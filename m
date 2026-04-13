Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AF346AD7
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120322; cv=none; b=WxGnZzdhTngt+umuAVGqOQdH/MrqhXp/llfvxICyJvrcIA7SKt/IbS7K2MqoAncH+W0/c7Sly0gzJikoLcYofFXM6SWq+oRjjDH+aV1Ugqiy2VWmmar7u/Ykkc9dwr3/stqcjXNc8jj5DR6CotSYDJHK8pEFDoqZeYhHsJ1PeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120322; c=relaxed/simple;
	bh=p+ZYhF2CPsbUhxiFvbYoPlhREgl3acLhkhTsoxGLYIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GyRY+9LXr2XVygtMGMuJiXhU9bY5h9ZhTzObvEk8j/gKXWG31RHyiBRztqWMwhHrOIlp+9Ggt69QUoNAzzaH6fIGjojpoxolfJk0o+RGkcbwHMjoHqzWZZgHkxuQ0KlpS7GUgoT6aMhI1rJrPSE5l9VbNQzW2PksPF0WOCsoDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFdOP1/V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dx9ej/Hx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFdOP1/V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dx9ej/Hx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AA7F5EC046D;
	Mon, 13 Apr 2026 18:45:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 13 Apr 2026 18:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776120320; x=1776206720; bh=a/KL99uujS
	Yl8z5bi+9ZHnQeW4Ia5Qziivyo+FiUBcA=; b=WFdOP1/Vo25FSuYjGowAM5IXlE
	y/gYXUbGHIkhBKMytLy0JJbV3gOAlxaSZEkGTNEMDGXdURrr74+xLKMi8nh4jx89
	1zCQErrECKHnlcVheb2umjk74qq2kgqVYBabsbXkNDJLjU1INv+WJ/ShB58fbwIx
	t28RVciY5qOhZzJaiJLlUsrwcjZEgat6g3kxBSl9M9m8/eUubS4hfnSBpM35n0cO
	EEArkAcg5VuvLNgajLVswMLEhVNyfF/0s6Gz7p0LIrdlIQIsH/uvTA5Xt1KPxOWT
	+sD/lu21iasSWEw1HQr0902pXFRAfaSm1muCtGIGrqITu5rmTYm4C3Q1kUlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776120320; x=1776206720; bh=a/KL99uujSYl8z5bi+9ZHnQeW4Ia5Qziivy
	o+FiUBcA=; b=dx9ej/HxYz+/rNNJWoLKPAo3VksoX7V15Uk5doHWd+folF6pVms
	HWQI65vFP9c63wEE5onsVPshlzSOLP8iPBUK+6lF1pIi3JphOzufaWpy/AgGypSn
	G6PYmXgxRlnLhsAJQ2ZaKq+AtQDoLz/q+6hX56DZfzEMqDkMjpXrrw7y/YnHuoDy
	DLTki4KsC1EPEFw7KT0zxNboYAJBm2vDChVDDai00xv/fSkEaczn3mwFJqH7Tea5
	DPJfnEjpdsC7X00EtyyjXcNUVPLgfdxQA8KwCsuklDOr0rXf2fJ10Vw3lcT0L9s6
	/vQsEN4XzF031mCG7Z3NrgPW9to5Vrb9Z/w==
X-ME-Sender: <xms:AHLdafNzukZT70oZ9qTIWiIb7hOEvKPRgkiiXh5sCfjWVhwfowSU5g>
    <xme:AHLdacO0YT49LA7VCX5HofKKdhKuv-_yj5vtEsjqpYFavBtodYqXfKo5j5LZ6ta6F
    9L3g-0Xddi4rLkW74iOMTx8uz9gwNmrffay1aatJgbBmq0NE_APfA>
X-ME-Received: <xmr:AHLdaQgFCQEIzX22H79mQPpjyDZGH5DhZD3DDYZdbCk2XzMxaxOHCeomGXqhbiHRlR79aLtw9mIB-1l3HShVe9tDpWPTkg2B3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AHLdaZvCa601wx0WsN9gQhEsuqCF3s_3tcDgCjs6Gb8-4Jw4uHHaMg>
    <xmx:AHLdaWTyUcDHiWSPb-XBk0_g1ka9e9ZNgZevK2qaxjfuj4HOjrl8gg>
    <xmx:AHLdaV1sJwFgDWm7sJCVojHrcc0HqALsj_ccIjUiyBBrOxJ93HqLxQ>
    <xmx:AHLdaTsNu-gh1qah8wzuTgJdrKop0uGyRQ-DE0S4TCeQ0oQ53F4lfw>
    <xmx:AHLdabR7tHkYk4qEtfu7KUdy4rW7-uEE0xeQLZ6fq8fw1OsjC25IvLMw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 18:45:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Jeff King <peff@peff.net>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/4] checkout: 'autostash' for branch switching
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 12 Apr 2026 11:51:41
	+0000")
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
	<pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
Date: Mon, 13 Apr 2026 15:45:17 -0700
Message-ID: <xmqqa4v6fpj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Harald Nordgren (4):
>   stash: add --label-ours, --label-theirs, --label-base for apply
>   sequencer: allow create_autostash to run silently
>   sequencer: teach autostash apply to take optional conflict marker
>     labels
>   checkout: -m (--merge) uses autostash when switching branches

I have been trying this in my real workflow and noticed only one
minor annoyance, which is that the stash entry only says
"autostash", which is not very illuminating.

Because I almost always have either 'master' or 'next' checked out,
when I start outlining a "how about this" kind of change, they are
made on top of these branches, but when I say "checkout -m topic"
after that, I _know_ that the rough draft change that becomes a
stash entry is meant to be part of the "topic", either to extend it
or refine it.  Because the code that creates the stash entry knows
that we were in the process of moving to 'topic', it would be nice
to see the name of the branch we are moving to (i.e., 'topic') on
the title, e.g., "autostash while switching to 'topic'".

Other than that, it is a very pleasant usability enhancement.

Thanks.



