Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76422087
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558972; cv=none; b=JJbKDK5PFdi64SlaKoWfExpt1qUi5Fu3jhQ89HotsM4esXHBGwBTDeEX+4cq88q9gWUq8oewgNq3+t3tFXaDOd5PmyEt23gjfF622CvoKqDOyHIu+/wtPGUuEhtFgkcTaIHsMtzVbyhV9p/wuYqomYc7f1ZoYOGwQOnw6exYwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558972; c=relaxed/simple;
	bh=kiMidEXyFPgbhQSIw0vK/jKq4Z4jXCRwAjtGkuLYStw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHFN72J2cgFA3UKsr4jIRCM+I4vFKrXTWVBBeSq8VUA7KTV8S57gAh30f7/RFnQd9xjVslrQ6tcrsfAZMtIkDHJeijArcFdxGWpmElwAgC/xLDcZoMFav4uKgJLpYR7u5Nfb2YxhM3j1nAGYymTJg605A+2K9JJOAadlejkvDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FD2R5SSL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eqh75wkP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FD2R5SSL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eqh75wkP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83DAD25401C1;
	Tue,  6 May 2025 15:16:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 15:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746558969; x=1746645369; bh=QgNX1SifgL
	ngmPeJkZqOZFEpCtlaTySluOWf2OALa7E=; b=FD2R5SSLiDmqqGoZsFEXFtSPpS
	grvD7gaUDZhKdX7eNwhpgmnl68Bej1vauE5Su6gY4oBQ0+CesRaC7/dXRdvDmbOS
	oDIqxgdJ4iLeIzJe48NkcwNDHR+XO3f5JUpAAw5xH+ZpFlI6pkC0luFe01tp9gEI
	fHX0EbmmG8aw1c2RVUO2dz7xNjmEh76CqE/HdDR0XQIjK2BLcMIuLoAwxUmYJC4u
	LEGUbxvYviseMnaHWVFUhaRf4/+T+SjCZTv4C/4BkRJRAuFaU3JeW8ZoXqUyPeKa
	7siZH8GV7bxgm5bFsFd3t12Q3P2a8k63Edl8p5Hi0gzkBk8KnoYpCveG3b9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746558969; x=1746645369; bh=QgNX1SifgLngmPeJkZqOZFEpCtlaTySluOW
	f2OALa7E=; b=Eqh75wkP+5G7dqEl1pNKOewcqmriq0138cbbEuK57osX2Y4iFUS
	rW/2G8rjUIoFibdQQuZNqpbyaiA5hgxFga27dgU5urkdTFEP1+/zQ+GOeG5TkMpm
	1vHjF8UC7k3YNFxyZqjqg/EUfuEhUtFbV7ffEXHRmQ72rIMA0C/pr3pniirjuroR
	+eLCujuMA8rBHPEVgd92cYJB7lE/AyPIDXsZv4f/450x7UpNngfGKx905r5pV46J
	b/GjENe5UJEBKlZc8CanMZNAtqXszcKJS056zbExUCHWdMoO13lzaLU8JbmbE6/A
	ZLJXHs58sOqlZQSyUA1+NgcoXKS3UYNeVag==
X-ME-Sender: <xms:-V8aaFLQPMExOqVpYS9lBT9QYNd1jcWI6W1V2c6sVACrvGz0X0URmw>
    <xme:-V8aaBJ7nFmHvQ7_m99FW5nbhimxFTG8ofJZMVpyELRQU46u1FrLGAveNNjYLT4KS
    u5jPJxHiYHgUF_DTg>
X-ME-Received: <xmr:-V8aaNvqKsbZogMOkX5IXB5wQbVeCo-Jj4QlR1lyjMXq8iWRRZ18qzmHrJNkvtaY0plZH7ES_3zGNTUkuRKZGp_01vjraXSLzT5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-V8aaGYtDqCFH5PjIbr8KCAQ2mGsBosYBmPVcJFlbqjYb9xxfJaD0A>
    <xmx:-V8aaMa8Hm0nH5yyiXutIuZSDDsqjA2DedQpiWrY-isH3JbR6TT7dw>
    <xmx:-V8aaKDgHk-HmAkuc7YxAQHkmKnKCRa_RzMtWht7innRgcM7mrNjSA>
    <xmx:-V8aaKb1ErROGM3jANQUyZu0v1AdJeNUOz2S6gyN5hCijhUP5KHWYw>
    <xmx:-V8aaCWu3ku0LyHjM1X_BQP0AUUZ9PFuGUmGrkdOFwEUEZ04CfdRT6Jk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:16:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 2/4] packed-backend: extract snapshot allocation in
 `load_contents`
In-Reply-To: <aBo7pcimOG19oInQ@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 00:41:09 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7pcimOG19oInQ@ArchLinux>
Date: Tue, 06 May 2025 12:16:07 -0700
Message-ID: <xmqqv7qdim88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> "load_contents" would choose which way to load the content of the
> "packed-refs". However, we cannot directly use this function when
> checking the consistency due to we don't want to open the file. And we
> also need to reuse the logic to avoid causing repetition.
>
> Let's create a new helper function "allocate_snapshot_buffer" to extract
> the snapshot allocation logic in "load_contents" and update the
> "load_contents" to align with the behavior.
>
> Suggested-by: Jeff King <peff@peff.net>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/packed-backend.c | 54 +++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)

Trivially correct, cleanly done, and nicely described.

Thanks.
