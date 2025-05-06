Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827B27C85C
	for <git@vger.kernel.org>; Tue,  6 May 2025 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510049; cv=none; b=ptO5gBUddZSpJPayjK+y0gxdX9RSPGM+zq59vwn79TnrA2LySmTiB5J6VjXNtBC0phDoKMKcF5yFce9MSl1CXgITV6+yEpkzivejnV3Av1hK8OKAbaJm8jQ5UZlyWvlVmfuyBmGSNmGmV3Atfkz6wxzDjWxDZCrbW/+iByTWtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510049; c=relaxed/simple;
	bh=Wlxwh2IREyq5DKDbs66Gb00IIoJmrEQdOhKxBPNZSYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeoxL60A6pbx/eZZ5bH4knRu0PShwLCVRSz3wHiivLg48/1xOo2yZfEdHwMgk/j6vy7sIqO+h1O/0KbPspV/HEn01g5IOZW6AQcupcNW0g6LJbL1Sd/COgoWXcCOpu5WNhW6aerVEaeTgg3XOOEgpZbxfe7BV9VoS60xSjaZm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PBEj3UZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPTnA9Fq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PBEj3UZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPTnA9Fq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C896138148B;
	Tue,  6 May 2025 01:40:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 06 May 2025 01:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746510046; x=1746596446; bh=xFGvGxGLNn
	T5/wg/mxqVhU6dsbyDo9uFd9uwiw3ScoM=; b=PBEj3UZxdya5pKneUEjrgwePU9
	7xaphVPdEABsa8ttJ4PqJvXhzeABxBNwRcLn3DAbWKN6p4bVPOy75J2hls9r/uXY
	zTPvuDAb2rUDbbnEp1fURYU//ETea9ihJ/AtCzfugJ4E1EuTStuzRdpIHNKhb9ap
	VKoF9xvS7d4orBRouSQDpvEbz7WjWrOWtKXQ0I2KgpQHc2VJGb1hRrVNn91AqYyn
	7avEGAzQk6uHeoq2lKqZNQdcqbdnFVcZALmbiJnepx8uI7Wsxb451eVQxJVvM6l3
	UJiWH37Gxke9wrd4M2xjdfymoJjBSx+WFjQ9jreFWAWObQPfhBytDBTqx5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746510046; x=1746596446; bh=xFGvGxGLNnT5/wg/mxqVhU6dsbyDo9uFd9u
	wiw3ScoM=; b=dPTnA9FqlZ/I5Cekt+Hq2dYUhhb2xEaYtlGvvP/Sdr2wqIfjzqO
	2imjmNlff4URTfeXTQFtxi9PUIXCzS6SjvRwDO9JwL1yLLEQDJb7wOtXxGZTFpKd
	mlHNqauIqPnHnhc8xLfHCaXaCvxNkBuHR0uq1yfef6Q9Z7bvHr8sQiPJHzucFANO
	/aYJc3HZqe85guZ/zC51gyinzA1nfdhiQlTv6TYSe8muIJF+bRE6mfYHmvPnQFNQ
	oZpKKBqZIGL64uqZ6Uu5m9IihLWmbRgUYfRYOVtdCGaXScdoAl5VYNhi/AbbkObp
	FFW6XRluZ7wDraX2VQksvgXK7WEC8UH2q9w==
X-ME-Sender: <xms:3qAZaCAL216nidUR-O0j1SvdnzwDU-GnzWBN4LMq6PcQb1hkKiZpgQ>
    <xme:3qAZaMiYuHiuEqL37dKJt7_IW3D774yu6hkdtgjkUfxUqW0SIvBmu1oTAZdbIWZBP
    ku81bwhMlew7gj4yg>
X-ME-Received: <xmr:3qAZaFkVnX9YxNtcGhBkqbt0f0qgHs7MeobsLraqhSeqE7vpQL6x9nuiLhkDTXY9vtGbhv7Og7dR0N9Au7Mkg5_TgiS7M0YFJO3top-J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepgeetuedugeekvdegjeefjeeiveeljeevhfejieev
    veeigeekgfdtudetueduvefgnecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprghrnhho
    uhgurdgsvghrvghnughsvghnsehsohhprhgrshhtvghrihgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3qAZaAx5_5dBXeLUmqeshlxOdi2j-WyDz9aODnUkaNLnLfU_YYvysQ>
    <xmx:3qAZaHQW23nRhf9dEiKIHdt3MJ9yq-IGA9q2CTjCpQI2tDzLnp6ojA>
    <xmx:3qAZaLZjS4STi0Gsjy-11fvB0EunhRNG9vofp2GTa5FOiemlhiezlQ>
    <xmx:3qAZaASKFEIJ3ceN3A2MjLvn1YeDC8ctXKc8y0nMsArpYLVOsR0w8Q>
    <xmx:3qAZaE5NEq0MmzCxwhlrCFu79YowTbq0POhq_7bQlAEP05DDu_3UGW5->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:40:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3b1636d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 05:40:43 +0000 (UTC)
Date: Tue, 6 May 2025 07:40:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
Message-ID: <aBmg1_wlF2fuk96M@pks.im>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <xmqq5xieq3fs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xieq3fs.fsf@gitster.g>

On Mon, May 05, 2025 at 12:10:15PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Many of the tools in "contrib/" fall into this category, and to the best
> > of my knowledge there isn't really a clear strategy for that directory.
> > So from my perspective, we should either rethink whether it is worth it
> > to have "contrib/" as part of Git, or we should at least do a spring
> > cleanup and drop bits that haven't seen any love in the last couple of
> > years.
> 
> Things in contrib/ should either move up (to become a part of the
> core), move out (to become an independent project), or disappear.

So this very much sounds like staging drivers in the Linux kernel, where
[1] seems to match the description of yours. The only problem is that I
haven't really seen the described movement -- many of the pieces haven't
been touched for years.

I'll probably just send a patch series to get rid of at least a subset
of them. I also think that we should adapt the README and rephrase it
according to what the modern intention of this directory is, which seems
to have changed.

Other than that we also have some bits and pieces that _are_ actively
maintained, but that just don't have a better place to live:

  - CMake.
  - Coccinelle rules.
  - Contacts.
  - Credential helpers.
  - Diff-highlight.
  - git-jump.
  - Shell completion.

Maybe they should be promoted and receive a proper home.

> But isn't git-svn not even part of contrib/?

Yeah, Dscho already corrected me.

Patrick

[1]: https://lwn.net/Articles/324279/
