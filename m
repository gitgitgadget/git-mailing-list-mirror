Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14506770FE
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376315; cv=none; b=SfxQwFuI7cyBgr2hGVJkoEzj4uXonA8mmXs8wi3Vo6ACJtd54G3R4bRXSvo0cNbokGQZjllTjxkloUyiLlNg73xw2kkgv0tFo/sRUhwm/nTe14malBgaGMXjWuvKC+3WsQVb8nqhZUmQR6/t1t2Ks6uiYG+sCCZPLqVq/kH6zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376315; c=relaxed/simple;
	bh=cwo7Jv1Vaz/mj7xkldayRNKkMUrwSra9Pv+JCuRcEeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aVYzINC834o9oSev0d8/moXNubo8NGFLgLQ8IBTavqv7Ub6AA+IYBvQY85Ue+SlunhY+9RfXOg2kJfI2wQCxWk528BRIRf+phGi8k2LBZgrKXIcwLwytb3a0wV1DWyLHyruGG/faYnw9tneKs8zg45m6w2I5m4QO+FiO7ciHdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C7WqXkS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5IU+fzp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7WqXkS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5IU+fzp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 061BB14000B8;
	Wed, 10 Dec 2025 09:18:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 09:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765376312; x=1765462712; bh=Jw+JQbQ2mJ
	n6LVLekOriM4hWn80af8eRuNnw9GrXV+o=; b=C7WqXkS8tPVJsQPYJoaVHsIodo
	sRR7LNQ7C68CBxcXkJf2Ly8iGqeXDIXSt8VF4sbYRS0iYgB5b3RanR2LNyqjG5/C
	vni/aYRj9PW1bgARmWF9rN3HvdF+ltQU7Kh9b1sLvNChDlXbhaPE+dssaZT8Hx3j
	RF60HvantT0vwdVBaIaomCSbT9myAedqn0lOJUCaJSoUIWg0Lgk1OXHV4aNpq7vO
	DQyywT7P5/TModUjfzXrOhpU8dV/aeCSFVz15jivuSCDOcZrU8Ld/LVZZk49PHSR
	A2YpowJCUZmp1Wc9phVCKuKLw7pi8qKsKTfS5lzVyzVlkI1Pestia4/uHMNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765376312; x=1765462712; bh=Jw+JQbQ2mJn6LVLekOriM4hWn80af8eRuNn
	w9GrXV+o=; b=Z5IU+fzp2e4kliGivqyy48uAvCn9kzUcpfmc1WzIJkiqT7fa4Kj
	x4uby9zrozscDObn0F8FBjuSqFDEmoZaj0jKjF08hYaF2Kfhbbx3+mCWc0R8N4dN
	vHlZCrfFe6H0aKwqsHAP4gTAKGHI3oZsUghxZNisZr8pbfUmbuOgyQ0U20sSoAOu
	r8XJuSsPOoXzLh9kR5dXFCt/gR/v0Q7MB+Ngqz6FV8KmUmhNUkkcLf5gVCye67ay
	vmhihVARdBpL2LCr6xoYrEQ+eyH73Tv9vId7kQJC9Z4ThgZn2KLolKBGGl603EKS
	BDTXRCmP+JpoyqnbgEY4d4uGEvKsouqS2jQ==
X-ME-Sender: <xms:N4E5aW6EuuIpLg8dRFFqjr5vQOEber7KcsZT76Hi3k-20L1FojNttw>
    <xme:N4E5aZ5UtgrwWqHwrG8xdqRIyopeSMJF-H46yZZASnuZI4PfXesAIMQHCYz9L8PJC
    2mbzfS2XleK6mwsY7YP1yrU_FvLhMpUNu3YXBbApujc9QUHUCq_Pw>
X-ME-Received: <xmr:N4E5acGJjo37ddWWhl_1yeUC2d4QxIeofi29IJAQbIAbKRk5KA_FdN4eW9pUEHpGVJWQN6pz9cuc6s1PtDNUMCximMoOhLpbxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N4E5aRULGJKcdROKpvm7gysF3hiGd3JAr-SOH1YxAoynOG2r0cqGHA>
    <xmx:N4E5aYXmUL4dOT8-xMMpIWoV-pcFQAS0QGdF0rXcYhKNxevYAX_87w>
    <xmx:N4E5afKE3cKII0tGxVHVTiixYeIdu0p9y1TfjjwjwcUFBMMmirl6GQ>
    <xmx:N4E5aQDc-O_MeDoNd8Osed7xiabA_rRUdTmrNYib3lkrFU0LtauK0w>
    <xmx:OIE5aa_ZbBu6LXLVdOJPej8J_bMgN_tQKhP1qGr2_kPWQpJRV5r6RgW2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 09:18:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Matthias Beyer <mail@beyermatthias.de>,  phillip.wood@dunelm.org.uk,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,
  Martin von Zweigbergk <martinvonz@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com> (Phillip Wood's
	message of "Wed, 10 Dec 2025 11:34:20 +0000")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
	<aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev>
	<4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
	<bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
	<paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
	<a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
Date: Wed, 10 Dec 2025 23:18:29 +0900
Message-ID: <xmqqms3qh13e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Its mostly because I don't like too much magic and because I think being
>> explicit is always better than not.
>> 
>> So from my POV, I would expect "the simple case" to be "the simple CLI
>> call" and if I want the tool to do magic and "rewrite all the
>> things"^tm, that I would need to specify a flag for that.
>
> Thanks, that's useful to know. I'd assumed rewriting all the branches 
> descended from the rewritten commit was the natural thing do do but 
> clearly not everyone thinks it is.

It probably depends on the way one looks at the tool, as a building
block (in which case less magic may be preferrable) or a complete
solution for one part of workflow.  I probably fall into former camp
more often than other people, but for this particular one, I tend to
think it is less confusing if we moved all branch refs away from the
commits that are obsoleted by rewriting/replaying.
