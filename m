Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90303135A53
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404326; cv=none; b=dX/TpaAZXJ0T5f8M42NFGXplaIjHF52HAVBDWG9T4rVFKK07OXJtYL5sdX+4u/XA1yO/gM0/u5pTxTJiuftQCFCxXwyeqcO6iN3sf14AGHuA41oICfRonLGK85iPa1vWx1dtSfwsWNl8ukowvQcLHPCvOTGzcHW8xIHEdLuX9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404326; c=relaxed/simple;
	bh=w5Ok0U3eyGQKKZ/MhHZTrN3TdKRHZAJarNODTqa9DIc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h9odTaZbuGnkLyWtutFHHF105OAuMT0xY5o+wlPZh9ZOM4wv4vlxRG2yz1Aggwrv3jc03YHfFTYyCxhGedcfcOqHeGzG6uG8OwMMwwHObod1EtBWQlYYGUC67zIGjatecHljef3rnFhSZDWVZMyL6va3oE+DqpLSMrDt5kDNCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JJaJWywP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AGy9te8R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JJaJWywP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGy9te8R"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43FC72540113;
	Fri, 16 May 2025 10:05:22 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Fri, 16 May 2025 10:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747404322;
	 x=1747490722; bh=w5Ok0U3eyGQKKZ/MhHZTrN3TdKRHZAJarNODTqa9DIc=; b=
	JJaJWywPcOUMBWdl7y5xnDTGiEEhnoU0ZX9kJp4fyHGlSIneFuf8ps/S3wclQyN4
	C1VmCUWw49T26O5pOgZWoJu2VcmzXDNS6V+Hpp2ms10gX10SNwyWj3gaQ+5mkqZy
	bEd9hr1mlBqVnU39Z1jtCcuoARmibpiT915Haapx1GZzQ5OQkIKOl1xoJxkSMU3t
	2b6BZ2rOXMYN31cZ3XdmH23vqf0RPPBdzJ7t0oWvB/ia8x7fdnw/yNx9VIYyOr1h
	CZFihSY1VBaVzeRqS1u80Hfl7jeGpSgUYM7A8IKiBTHIhcN+woPdXWqyvsvfS2+G
	61NpaDj0BSR1/y/fGxTcIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747404322; x=
	1747490722; bh=w5Ok0U3eyGQKKZ/MhHZTrN3TdKRHZAJarNODTqa9DIc=; b=A
	Gy9te8Rc6mAKxH40VdsvVZGVYdx+6OxeP2WyFnPRZhkxFQbEBHIgci2rgwXIF9r7
	FZHQK6p3UIX6ADwjrvaeaQ8HKeL6g1SfSpVEqrvzahrZ/uDHbRrvKPiIq7nxTNR/
	ioZwEGgUjMhXi1WLwQYuC0zHXf1/r9Y3Vl3kzaG3y+7pELRZ+z/OpFqKVoM3FNwD
	JOUfEC23qJT4W6fsddKv/lfp3UeUcbL8/9hZ7acTPnSKxsNcfL6vJYpzXaQCqpZZ
	B4luK8DM4KBgjr4zdTdBlKhfwQ4rfNqBjC/SQjwdZOurWotX9aUWehtEfVFl5bGv
	izbtn6IuC97R5n8RovPuw==
X-ME-Sender: <xms:IEYnaAqMYSCR71UgIOQlzVFZWZyaCw0iyrKeGBVD1CZR342UNP_V8Xw>
    <xme:IEYnaGq4h3q0i7mo_qOqVpE-Z5quZwWxo5pivDzMPSerMDqB7ApPALf1V8k6-Ieom
    YPK_LkGQvZVm8FwTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhepudeuhedtudethffgtdfgieehfeevleeileetgfeftdeileeujeette
    fhveekkeefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IEYnaFMZkQAudgBmcovHiAXfXGKxs04TompNXfw3vy3pWIaTte9otg>
    <xmx:IEYnaH7G7zGRBvuDl0mRYlK2BKfe4W_y-MVY1vhZ3VZm0T4TgjdnCA>
    <xmx:IEYnaP572CvHJdetmu6YkLZPEE6ue3WqXyWEwYJnRCqBJX9zUlTBTw>
    <xmx:IEYnaHiboT2veV4IkGXmx7_-kd2Tuc-AGH6Eb0M17bSfmaw-aq-k8g>
    <xmx:IkYnaDJA5UYi9TeUAbUMGTEptaxaEFskb5bgQBpq2Wxa6SxPMOfLx9en>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62D80302005E; Fri, 16 May 2025 10:05:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfb196321f9faf9c3
Date: Fri, 16 May 2025 16:05:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: collin.funk1@gmail.com, "Matthieu Moy" <git@matthieu-moy.fr>,
 git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Patrick Steinhardt" <ps@pks.im>, "Eric Sunshine" <sunshine@sunshineco.com>,
 tmz@pobox.com
Message-Id: <2608da69-b554-4c45-b4b0-4b128e25c2a1@app.fastmail.com>
In-Reply-To: <20250516135540.218937-1-phillip.wood123@gmail.com>
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
 <20250516135540.218937-1-phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 16, 2025, at 15:53, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This script uses an extension to run an external editor from
> thunderbird that is no-longer maintained. Replace it with a different
> extension that is maintained[1]. The new extension uses a different
> separator between the mail headers and message body so update the
> script to accommodate that.
>
> Signed-Off-By: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> [1] https://github.com/Frederick888/external-editor-revived
> ---

Why the link after the signoff?
