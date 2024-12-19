Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25D41C79
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619623; cv=none; b=CeGZ+IFU9dey938MTPE8tF8RyTvVFip3XQt800tg628wYDWv/u9H4CfsTxWR9WEV0MfmHtQfcwCNjsFuOlJTiacrDPlhkqW3u5DRVUQ+/Yb2wu96LLInAHp4UdOLoaIwhnrinSjw5kzPuVSPxdHTFE76X4KErcF2WzAKtvNxejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619623; c=relaxed/simple;
	bh=jF1xgaZDvQcVTtr0gFCmQ/8g+P/IAdhec/Fo9hVJaNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3yByWXGcW+WBq1EmZJ86qlvr3IzmsaOi0Tb9fP2Oxn1fcaJ0VDZfKxggC56A3JTp/4VPTlJniHrL105qXhZ7lLHjGYkCcaJDDB/urbo5TV5h3Pcm1ZuMWlmMfXACw+n0QZuwjSFm+QShWpAvo5bw/rphYQ1NPxiuBWCN+r5Wis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YmHJfQgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lIZo/Gv3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmHJfQgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lIZo/Gv3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA1A7254012F;
	Thu, 19 Dec 2024 09:46:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 19 Dec 2024 09:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734619619; x=1734706019; bh=CtlD3l+4Yh
	EgXMV7Lv/UnZbIzMuvtifirntSWfA5VcM=; b=YmHJfQgfoPI99zpYMMRr6Wpbkz
	LEC5uvxMhZTycAWOtSGBdJtrJPqrMQt8AsipgAO8tBuxT0f9xrXaPQU8yr14JIe6
	I/qKWD9dXfRDk3PjBLgRDFFbzNCylFYuOtomTsP5mia3rWxpucFQYwwy9EFRdwzv
	47lsObjQtoiXMPKS2rv5nYb6hFghSS4XqRzLQeqK/yACVeezjIjWTTHrr/fKKqto
	hFuzU5pXiAAZqYhQiSA2pBdbyBAZq/qzZ8CzvyBbB0NpN2F/c83mB9qX+AGQ+Xxd
	gNSjqz42sCUSq2z42h7SCQpzjSmmeKFzwvoMK42AdwjPDq9HRpJxRxiKaEew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734619619; x=1734706019; bh=CtlD3l+4YhEgXMV7Lv/UnZbIzMuvtifirnt
	SWfA5VcM=; b=lIZo/Gv3zSm7K2gp8KkwSEKaxJ0K2JDg5L7SeQ/KBekP26ZYtp1
	cIjSxZNKjo2JS6FRlPmKnso16+/YA9U96AknGzeuORi17WlYFBT72rNueBtnA2gp
	qkq02DqdPYUwt8U4zd+q2psIg6wheUaer/W+k1qI+kqkllQVnuTkTx9IYGyU022g
	4qOVt335ytglMLWT3/rUWTEaHCQ1vgWRuXrqXFtwms6pUWwavcjd09Dg+UAitq30
	SqM25DAnILREyJApBt9aIaDYKEXfQ0TX1411ZdYIfkxGUnj17LSOxzaPMkwgP6Oj
	p+TioN7n76EDrO4f0nNb5TY8MAKEph4Zacg==
X-ME-Sender: <xms:4zFkZ5kXoW2p9pZfDQb5U_R0a-6Q6tkfRfG4gGg_NZ7PoBMqpr-nXA>
    <xme:4zFkZ02ezB_pU-30LX5MFafaoxu8g-jzArrgR_5HfLymSZMiYnWy2pNlW2C2ufDlI
    k3VxXRM0X_wR5bbIg>
X-ME-Received: <xmr:4zFkZ_rstAy1b4-HH5hJJD4WSJ9RqEQ_uUx9cP2e5Le_ht-Ca_4kvpVnNidcaIPUopZPmMKrYH22hlegmsLKGo8cbHojTc_lWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrghgrshguohhtmh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtqdhluddtnhesghhoohhglhgvghhrohhuphhsrdgtoh
    hmpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4zFkZ5nuTH1GEzcxo1cNeVxPIoZL2JtZxdxnLNg3eAuqFxx8x10TZA>
    <xmx:4zFkZ33RbleysP_GvXTf2-vp2QbBTOf0Cp00yZHegSAt0jVCH0ucJQ>
    <xmx:4zFkZ4sciNCrcl_0ZtJS-Y1DXO7BScw6_Gqwj6A9kURiCe3KLKDh3w>
    <xmx:4zFkZ7WaWmBVv1TpG9CykugEU_Z5-I4mXV-7tQp5yykC68SmJYgwyQ>
    <xmx:4zFkZ39spSAVOtQ7C0F9mr-K37R43lNKeth129KOlvl9O5EUQ7xCAW-o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 09:46:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Git l10n discussion group
 <git-l10n@googlegroups.com>,  Jiang Xin <worldhello.net@gmail.com>
Subject: Re: OK to submit l10n PR with signed commits?
In-Reply-To: <xmqqh670nrb9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	18 Dec 2024 22:02:34 -0800")
References: <Z2KfIl87JOWdcGR3@archie.me> <xmqqzfktujuk.fsf@gitster.g>
	<Z2OAebI4pQ2K57vA@archie.me> <xmqqh670nrb9.fsf@gitster.g>
Date: Thu, 19 Dec 2024 06:46:56 -0800
Message-ID: <xmqqzfkrlogv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>> Instead of talking first about drawbacks, we should consider the
>>> upsides.  Why would we even want to see your GPG signature, when
>>> most of us do not even have your GPG public key in our keychains?
>>> 
>>> What are we trying to achieve by doing this?
>>
>> Just to ensure that PR commits are really from the respective authors.
>
> Yeah, but my point was that it would not ensure, because practically
> nobody has ways to validate the signature was created with your
> private key, and public keyservers have been tainted long time ago
> with fake keys with the same fingerprint, so would not work as a
> good way to obtain your public key and be sure it is yours.

I think I should rethink this.

Even though I think it is fair to say that more than 99% of people
won't have your public key and even if somebody gave them saying
"this is Bagas' key", they do not have a way to independently verify
it is truly your key (and I think the same thing can be said of my
key).  But in today's world, there are a few places that it does not
matter all that much that you and I do not have each others' keys:
hosting sites.

I think both GitHub and GitLab lets you register your public key, so
when they are about to show a commit (or a tag for that matter),
they can

 - notice it is signed;
 - look up the author/tagger/committer ident of the Git object;
 - look up the ident in their user database;
 - find the key(s) of that user account; and
 - verify the signature using the key(s).

and display the user account that the Git object is signed by a key
registered to it.

Now there may be ways to contaminate hosting sites with fake keys
that have the same fingerprints as the real ones registered to fake
user accounts, and that may render such a feature at the hosting
sites less useful.  I haven't thought through the security
implications.

Of course, $CORP or other organizations can have their members
register their public keys and do pretty much the same thing within
their closed world.  Safeguarding the public key database is their
problem so I won't be worried about, unlike hosting sites where
practically anybody and their dogs can create accounts ;-).

Thanks.
