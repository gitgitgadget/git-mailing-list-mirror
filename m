Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E5137C37
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495100; cv=none; b=baXThYrGhSSh6hpNzhuXE4miPUbZ0sDME7dMmHLRj6PjHbw/e4c7GR4Nsg+6cILmLB6NDLYvME93k7MhB+pK3LoCIqH83ezYK7RTyQDoNV/iHqNqC2uxrO9eNCCuQ+BDAn274v+4nlyaQ3MNDnH1Cn9kMMBiFaHBEA889N+r224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495100; c=relaxed/simple;
	bh=swGCddSJw9oga459Uz0tgthOGZLY8WvasyzZ+kgYfqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=krlhTHVDm/fSjctMFfLWfJVUzT6IiC0IAiQmZqp/9aJsqa1hJU8IlxssQIFTsaXWN8YjiXiMPcuEJ3JaG1ikUTKnHeVNqRxIBy+J3PaprZJKy8U7xUYIxoBE8+Buy6wMaLGYZ+a4xnU6cp30RHzjbCgoR6T/GBJq+CtxFUj6o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VetPyrsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqYvtg9V; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VetPyrsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqYvtg9V"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F3AD1380142;
	Wed,  9 Oct 2024 13:31:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 13:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728495097; x=1728581497; bh=hhIIVi1MYn
	biYHyY4Kzxk7HXU5KYsBxeBl+Q5PB0YeI=; b=VetPyrsZFk3ZZajgWVjd8mNbGo
	VINsJnKtNM1x2KS9qlDswyCjFY4CAvIqxaQWgZXAiK6gmPcVTBkO0PemByfvg0wc
	47TePJN2h6USMQ/+AAsVN+ImxtWBcyA+PLR40mBfGTdWhOJUDtO4hu4EwDkvbtvj
	46WCTE1PGLzszDqTdczeIvqEZkNZqUTlxU99ipsFsMYKYnrX5ecdvmuij/iDLVCI
	3J0AjLa/JbzCtQVwsfM/IZb3hSkBITkP0pOdfgayMLYojPjxB4teCkm2JgeNBbmE
	kKW0e2v1Q5AVm+/SPLTxE7+h5DOw3RkgoZfkvSXAxJRX0l/SsDcoFRJoOuoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728495097; x=1728581497; bh=hhIIVi1MYnbiYHyY4Kzxk7HXU5KY
	sBxeBl+Q5PB0YeI=; b=EqYvtg9Vgf5Tz2ZPUpKGGU7q9hZrnRdap+91ggWtFdhs
	348AqxX+9kLsOqnzgghIRbqYH+kwWcRZ0J4GTKloyN7XGDNMXb6IunMSgXCdO4Rl
	dEAlv12PjyyviCbhgRN1tglC6HVkJjVByflMBRahLFOv4a0RZM15Ssw7VvgC51Ur
	IzOgzqqUIkUricjlZuVaqVHRWfLjwGFaYWdgJGIZRAAZCeDr5vjNYjWuPry3lh5x
	azia0PI6sB1rJkBbkHJf3KFVi6IhKihw8ab1YH3/a4hyg7BAlRwVqLxgQfcrTC1k
	JmWg9PeV1HQry8opmQsjj+u6scuP/ErqK4+BUngWKg==
X-ME-Sender: <xms:-b0GZw2XY7cHdgJXhVW3yyKLg-Kw6-3rX_pf7AjH6mEYUvybt0KjbQ>
    <xme:-b0GZ7EaD12dw0VLMTcqjUvJOkAzXyxMb3hmA0pEm-_et3GrY-dPCs_7iVIuIvGAU
    tUiJqDxoP1cEfF-6w>
X-ME-Received: <xmr:-b0GZ4679UG5WF2J3Ej6LgCP1lehHD8bLGveMFsVxWJKvfhdswywB9dZQoippoZgl9IHF_Doj9WgW2FHTkgOvUkcZJoubH-xl_6p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-b0GZ53b7SuO_uxa2eHbSw57uBrufW_XwhPXWiu6DGi_B808xEh4EQ>
    <xmx:-b0GZzFUlT51ac5DKCR14Uxf1doH27qDozSyOPow84X3oEICauvC7Q>
    <xmx:-b0GZy97S2vUK0FGY6c9fCEbH1wfJ4q4btEE4vnuI7upoVqu2KOm_A>
    <xmx:-b0GZ4k-wUNCh8sC6ac1VFvhJPpxoSU_2TCHfXZtfZzjbrGgdHt-pw>
    <xmx:-b0GZy2zqCktaq9jlXtJPT1OP0AE8zHE4PP-Tuvc01qWNqr7-e9yNwT5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:31:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>,  Samuel Adekunle Abraham
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  christian.couder@gmail.com
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
In-Reply-To: <ZwYux_Nb9GwqPuuk@pks.im> (Patrick Steinhardt's message of "Wed,
	9 Oct 2024 09:20:45 +0200")
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
	<xmqq34l75pr7.fsf@gitster.g>
	<CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
	<xmqqo73u1n0k.fsf@gitster.g>
	<CADYq+fb9ux6K+m-8y0owopt_zKJmXXYLh6Rswot3r7UNX30LAQ@mail.gmail.com>
	<ZwYux_Nb9GwqPuuk@pks.im>
Date: Wed, 09 Oct 2024 10:31:35 -0700
Message-ID: <xmqqmsjduqrs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think that your v2 isn't quite there yet. As Junio mentions, he'd like
> to see an updated commit message that includes your explanations why you
> have done certain conversions the way you did. The fact that some parts
> of the patch required discussion to arrive at a common understanding is
> a good telling factor that a summarized form of the discussion should
> likely be part of the commit message such that future readers of the
> patch will get the same context.

What v2 had after the three-dash line seemed to me an OK material
for a proposed commit log message, but it should have been before
the line.  I suspect that it was from typical GGG gotcha?

Thanks.
