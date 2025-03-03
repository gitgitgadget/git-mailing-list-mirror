Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A71F0E2E
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039170; cv=none; b=upXmkMkkCfJX/CpeSmDsNrEgIruTCKfl3a4/vFYZDEAU0NgOfMCw2HZH+IRWScyVv5EYUK4HETflb6Ux36o0oSs4nbXEh5gbHeiIhgxlRl50QWZD4GmPBdJYNKKrxwW3zof7lm4j8A4fp4QoUkKBF5VXWG9qyQfe0sY0Lc8TZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039170; c=relaxed/simple;
	bh=NUnvY/0hTZFbf8s9OLiREVueI8H60NIfxXIU7D3Ft08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNk8EM+vVgCumc36dv96RsRJmbxknA4CyX5g+YAMHo+JdJBkZTasBX1+Y/lWungdz555A9R8hS0PFuNIj5gqLkK30i4m40ojEcZtxQfVunJ6e3643hYtWbbmE/1SITFRoI1GXcIgwWP4E/+X52Q2C9om3Gs9AiTE4OD1N9m2qLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ReG3CJ1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VudYkoqK; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ReG3CJ1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VudYkoqK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD86F25401FA;
	Mon,  3 Mar 2025 16:59:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 16:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741039167; x=1741125567; bh=26jpApjLdR
	KrYaKaYOcLgOd5jFcM1EfrsLUG5RGzY7Y=; b=ReG3CJ1zBWc/PbzzkMnDMwipMJ
	Lqk4o6slctNkX63klFLD2bYRPeaKEdLliMPTA+KLvzazo8LilLZt5pkPXEAzDxrH
	1KTI85btQk9W1T9o82c0pNZFu0ySu2WhQqwna3APIbV3IzOKNrpfh09+OYiD95J6
	Nx5SW5shWMxjXYS/ln+dY0AObw21f43ZsJcAjPIsEos6nMTq8zeMtMR9OaG2BQ1B
	zc2v18u/RzfV2NzwuKG9Tz25tqzwFezIwmTSzXgWXJ6Vg45rhGcOtkgz2fmiO9/W
	lVYG8jw5x2r0mr0hxtdNANP7gaJzXuarxI25FEJFqz01IfaZlsHBSjUyHhUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741039167; x=1741125567; bh=26jpApjLdRKrYaKaYOcLgOd5jFcM1EfrsLU
	G5RGzY7Y=; b=VudYkoqKDNkrIgvtr4ennzO4QvTIK0gEpMefiLglxSdahQpVWtL
	5DslLmlGhABJ3sZMxiD4cZCHBA65/d/N0uIMeE+U13/mkKBHVZNRr8PTjOAMUE6a
	oEAX4rb32cMr34Kmdy9qWwNbsvhwYw2rO/OWxo6lS5gN837/9Y0RSGsutQXJ3T72
	6wzmdHB6GesYuHhT0EAyJt2vhyOoS8H9C/3Mry4mm38dKyC/szPnX/PKRkOinXQY
	1mW49a6Dek/c+1+zv77SHN6yT40virSloQo6TaSWn4a++mT2bupKFDMxgnDedPFA
	22Zx3kLtEhEhIjluNORbG4Tlx0g/ynB64LA==
X-ME-Sender: <xms:PybGZ5tewPS9nD2aC9zWD7rf89BbYQDcAhoU4Fi5PU7-u7ZM18B0mg>
    <xme:PybGZyemwfMOBfVuJQ4nfuAfMaoq_LYjVEzI6uBW-l5fKbXcoiDnOzSw52vPpmAPx
    xdD7Kr7peGx9GyLlg>
X-ME-Received: <xmr:PybGZ8wgD7riv2R1l2C8PN1sVQ5x9ANtTtNRslmXEOPQyBVIaqvW7vQiqDilgYbD6NV_JGdgPZAWYymUAnNRnXgUz2DB0idgeNWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:PybGZwOr2zjzKXsmMDf0dZfmVMbUuoxoP1qfN3QJENzBXFwF2a_JWg>
    <xmx:PybGZ59GNA4l8HIc7YLuwYl7UBGbGZJSstE2fOJVeNymPu5tkltVOw>
    <xmx:PybGZwWIL4FkD1iPrUaPZ0lX69HCAh9JoxaqrzKOOalSLXVuBXEtUA>
    <xmx:PybGZ6f5quIY9afiBdTf8V99ndy1D0QCdT8NZPuhbfbzY5yZV1McTw>
    <xmx:PybGZ1Z2LYyEzYUgtlB39zS1uN_VOXCq7yZXcD1_mkuBGOPAAO8_ja-i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 16:59:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/34] howto/new-command: update reference to builtin docs
In-Reply-To: <20250303204443.360595-10-tmz@pobox.com> (Todd Zullinger's
	message of "Mon, 3 Mar 2025 15:44:07 -0500")
References: <20250303204443.360595-1-tmz@pobox.com>
	<20250303204443.360595-10-tmz@pobox.com>
Date: Mon, 03 Mar 2025 13:59:26 -0800
Message-ID: <xmqqfrjtvkqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Commit ec14d4ecb5 (builtin.h: take over documentation from
> api-builtin.txt, 2017-08-02) deleted api-builtin.txt and moved the
> contents into builtin.h.  Most of the references were fixed in
> d85e9448dd (new-command.txt: update reference to builtin docs,
> 2023-02-04), but one remained.  Fix it.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/howto/new-command.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

;-)  This is orthogonal to the txt-to-adoc gotcha but is a long
overdue fix to even older breakage.  Thanks for addressing it.

> diff --git a/Documentation/howto/new-command.adoc b/Documentation/howto/new-command.adoc
> index 880c51112b..ac73c98be7 100644
> --- a/Documentation/howto/new-command.adoc
> +++ b/Documentation/howto/new-command.adoc
> @@ -48,7 +48,7 @@ binary); this organization makes it easy for people reading the code
>  to find things.
>  
>  See the CodingGuidelines document for other guidance on what we consider
> -good practice in C and shell, and api-builtin.txt for the support
> +good practice in C and shell, and builtin.h for the support
>  functions available to built-in commands written in C.
>  
>  What every extension command needs
