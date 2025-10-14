Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084C1EDA02
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474653; cv=none; b=VTLu++gR1RUZhd45MzLJaYjekRGADu8bvwbudk2A1OjCV9DTj6cVMRlDpm1BBi5CqLbn+cD569DJZFeXJK+H2ehhowrBYE3ZaVIodq7CWfXUEgZNFCwteJOJ6+HyvLq2dX6LBj5/wbJp7J4kaG0TCEuAnDiZ7vpdFgX2fFHDlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474653; c=relaxed/simple;
	bh=J71DwBKyUUMq8G0wDuupOTrzlE3MyYT7w0P94BNBE08=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mBQY4xB231Rf0Cyi3KZZcPysnao6dtZCi4DhNLK+x7gEpv4lBnLQS8Mk5JzxSSjlcPsVo8fMiQvRuED0UjK++qwb9+K4OvFmWWcPDDQtliHJIfu7+yXTo2xuigVXegTmRYQXC1o1SPKpJUmZyPqoA6eYZm/4fL7+akbWFAMeQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EAvezmJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2KHTfyr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EAvezmJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2KHTfyr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 81B75EC09D5;
	Tue, 14 Oct 2025 16:44:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 16:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760474650;
	 x=1760561050; bh=YvdMowlmGKXG2BPkk1+GDQOp9YcOfiYm4chfrJvV5nY=; b=
	EAvezmJr7SorglA1KiHqWmZhc7RqbdAMYmfjy6VmtjtBexOOEEA7A1osMRf1Arkd
	j86DsBjCz6MG3SVlJV08c9tmlDmh1kIm6DtAuLA6VKdBD86izT/AwPJfyB5UsA7e
	6w/fLiluDpsBU2do1fpHX4vu6lrpQRk001WIU2R0aPgZwm4NkT8rEANFi6wtqn4w
	JR/k159R5wqpAJlOThOZn0oKI7QtTHBYAlLjZ62SEpNazO3ZdeO5aV/g1TudD7pB
	nUrYZwxIrBznOdP3OuY7+vlveUBNA+hQUH3NuMk4zx4c+m12faERcO0o6JuPjsSa
	y53a2e9g24qQtnacYkIy8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760474650; x=1760561050; bh=Y
	vdMowlmGKXG2BPkk1+GDQOp9YcOfiYm4chfrJvV5nY=; b=e2KHTfyrFmUI7ECSr
	Xx68fa2GEJvaPoVKsXaaNBp3Kkkuts9gHnPd+3HmotFQNVxsLRozFdk9olEIwTTN
	NbAPNnwbFQub+vWyojBrYBvsBbDtDEkfK7DcckBRPXkpaWvp9Miqvg8AYric/A+O
	DOFcOQJlFuYB4ACQcQQQzjMo2nKP3zccmFK1f+8jzAGlZwtMtNlflxGOPg8HJecE
	M5NU67A9YzukP2AO+CNW0ns5lbbczGxpsZDZPU+YZVsS4KrdOb6dBIhS+waCD/8p
	BcWDojGVQdZaf0+gDDD6oJWMRkijZ+8s5RRAP41nSiG6ydk/LFEd+9OFWqxsctbs
	9tLww==
X-ME-Sender: <xms:GrbuaKdghHyhoC0cEAnS7TXJiNLXyHOCeBa2YQhGt969eyzptp6-iUQ>
    <xme:GrbuaPAEtrppULUjivmbTQew-9EDTdh14TBMBC2_OX5qyyl0qe8ly-joEzsYcGYwf
    1du-QYO1olP8iVhpzqs6ZXi8e33pIyygGS48LBk4lOtdy15me-yMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GrbuaKl29bQjHYPdWX59DslqRDMyBcWlsexWjk0FqXcUTn6vHUhhdQ>
    <xmx:GrbuaNSpgdURR6ZB3vk9HrhMaAXKPwFatj0NoNYGvajpVDZrc-NqnA>
    <xmx:GrbuaMLaJFayolIcQJvg9sMPT7-p2t6AuY0K7Rvt-Z9MhQdHZGA7wA>
    <xmx:GrbuaDBXQMwqeAlVWrUZdoM9127y6h8Ph7GEJ7WkPWsDHdFmYxUUNQ>
    <xmx:GrbuaE_2Nv4fFzVwcZEyaYKEl3EDi0QazSKlzWKTz4sj3unS6W4Tdvez>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F4FF1EA0066; Tue, 14 Oct 2025 16:44:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW6mDwFNbgGo
Date: Tue, 14 Oct 2025 22:43:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <0995ba92-1feb-4103-b6bd-b792c13a01d2@app.fastmail.com>
In-Reply-To: <20251014122452.1851103-17-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-17-me@linux.beauty>
Subject: Re: [PATCH v4 16/29] sequencer: add trailers to message before writing file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
> Added trailer processing to the in-memory commit message
> within do_pick_commit, ensuring fixup/squash commands
> remain untouched before the message is written.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  sequencer.c | 19 ++++++++-----------
>  trailer.c   |  4 ++--
>  trailer.h   |  3 +++
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5103ae786c..552e629e4f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
>[snip]
> -static int amend_strbuf_with_trailers(struct strbuf *buf,
> -									  const struct strvec *trailer_args)

Weird indentation.  This looks like it needs clang-format.

> +int amend_strbuf_with_trailers(struct strbuf *buf,
> +       const struct strvec *trailer_args)
>  {
>[snip]
