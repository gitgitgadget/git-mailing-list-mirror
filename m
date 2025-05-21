Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D8262FE5
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833263; cv=none; b=kCjhaxaLjEOSksxP3QgH1L+wJkBRQ1l4sqoCJybVlHgQA6kdFu5UUqOoCqnoz4lvBML/EM7YelNdfUYwLvjirBDrXeB6YiWDA14zGcHTZ1vK9mfgixQfjyhffK5gG461qalKJtgjt9kr5nYNTisoXyrUc+qFMI2nMygGYLLfSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833263; c=relaxed/simple;
	bh=iAmch3XiYv6kttHLHhLy0Wi1S0hCCg2LqEXTe6UqgUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dag0zoW2gX7iHpdTJFFtZyQOC0KTRakxfzfrXMGlnI6/E5aGIaO6o0lMGnI4S/QwzLDcR3wc4WRgLiKc37fXXuQb8kl6kH/Oq9dhpOJsaYBX0LcKvKfYo9ieUmb55FlUipORZ5zH/PJkHNJkQNsZQrAbctpJyWyKa8RjxPvx1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RICHZhDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nuKOtkXy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RICHZhDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nuKOtkXy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A80F1140104;
	Wed, 21 May 2025 09:14:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 09:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747833260; x=1747919660; bh=kJvle0Z7o1
	zeYKDfg9oqHkFYVx8c4H0IoNnOhqLHcMg=; b=RICHZhDRIjjamL0xVW+kVNLkeB
	ckffHc1YEdKOa8+dHFvziNQ4I9qOPrqDHyUNuCNnmtHA5YbY4W16iSukEfwG9Txm
	axlcXLar2725EjT5KUdQlUADiAed4IWDt1AscbS7DKc/TRfenumbpcTjQq29Agrq
	UXUPcTRlF/Cs9X3Tv4qgxpzD1/Piudgrq6BLVp7Xl58gERiI8rZ2lwOAP83c2rOE
	KTMw+dIqOH1D+W3KIQv3ODwvliuEp/9xc8WyqHQl4XjjZvNDRUHX0X2vbSLUcJrn
	xLXs++wFCPldL86RVAyaTXXx1YV+ijfued7C0eiIlJ6e4I3CjdrO7V92e8Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747833260; x=1747919660; bh=kJvle0Z7o1zeYKDfg9oqHkFYVx8c4H0IoNn
	OhqLHcMg=; b=nuKOtkXyegdJ6lBTnT9cUEjBYPM3/t1JIIeoEVRwizMC67f/OcA
	0Yvfx8WXtCHsVTckCU027WOE41x7CsMgYSvhmi+e2s2G3Jk0rbGub5bvYIV/u2fK
	OdOBDkHGq4XrSl+VNe30vLX3phwe8qo4AVDpwdlajxnCs4EirjHcDEgnRBIlX3Wm
	q8VW5V5/Lbd/4tNqiyc1dLTM+BCOoXvXxGKOyMqLaR67ArPQE1/mAHmqmxW3w80f
	fDAqXuQWbkmVhUVR8JFNM8iAkZ9vce4GOH3l/M/coNtd9rH2aSaqMM/pAik1N2hd
	OEosKuEYm2KAJRXeJ2SDMibOvm5NX6ldKgQ==
X-ME-Sender: <xms:q9EtaHCeGq9q6FuH1svLNwLsBIy-subDxPzjtSfoKzwCvcCq0Ley4A>
    <xme:q9EtaNgx5O-HeQdzsysNd8Z7lEfFM-NtEGPOE42YUkl3IFDmKBcHANoIcqtYUob5L
    l-qyAkPgYTDhw-dWg>
X-ME-Received: <xmr:q9EtaCmhcWNWIjVGHZKE6l8hcZIG6WsFFJII0qGch7rNMR_0p_VkhId7QuD2PxmNHb4DN1a8z0K3FVfPU_e3nAxPbX8REFhlAWWY-dY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffg
    fedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhn
    vghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:q9EtaJzg29J-qZZljFeR0AWinXkIP1YH8BxaKfjwJG5AV6aTEI1jIg>
    <xmx:q9EtaMSOfufQ-sZKA9gEtjbECfZ5k_5Eol1zRpVbNVV03U97K98lIA>
    <xmx:q9EtaMZ9vVpPeyYmHGMiXMmsw9welbe9Hz2UUU6XQZ_qskrJTvEj3w>
    <xmx:q9EtaNQC1Pqz-lCzUVmye5xqIwCyO-vJYt0dYER_YCGC45YxYvHMcA>
    <xmx:rNEtaO2QJ6vSd6Pml0G10L-wdXla6HxvSS--5EhNPfywi_ei-4YAMqEE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:14:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 3/6] doc: notes: split out options with negations
In-Reply-To: <xmqqfrgzhzbp.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 May 2025 12:11:38 -0700")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<d2b6864b7072faa2c804c98ce7758b666e11f00b.1747763769.git.code@khaugsbakk.name>
	<xmqqfrgzhzbp.fsf@gitster.g>
Date: Wed, 21 May 2025 06:14:17 -0700
Message-ID: <xmqqsekyds2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> -`--[no-]separator`::
>>  `--separator=<paragraph-break>`::
>> +`--separator`::
>> +`--no-separator`::
>>  	Specify a string used as a custom inter-paragraph separator
>>  	(a newline is added at the end as needed). If `--no-separator`, no
>>  	separators will be added between paragraphs.  Defaults to a blank
>>  	line.
>
> OK.
>
>> -`--[no-]stripspace`::
>> +`--stripspace`::
>> +`--no-stripspace`::
>>  	Strip leading and trailing whitespace from the note message.
>>  	Also strip out empty lines other than a single line between
>>  	paragraphs. Lines starting with `#` will be stripped out
>
> Together with the post context lines, it is unclear what the default
> behaviour is for the command.  It is not a new problem, but
> hopefully the remaining 3 patches I haven't read would address it?

I guess this was left unresolved after the series, but it is
perfectly fine to leave it outside the topic.  Somebody else may
want to look into how exactly stripspace behaviour works by default
and how this option affects [*] and document it here.

[Footnote]

 * IIRC, we made the default to strip, unless the message came from
   an existing note in which case it is left intact; but whoever
   does the documentation update should check it.
