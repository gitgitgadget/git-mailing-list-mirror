Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFD1B4250
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740064; cv=none; b=j2OrGq8tAMbECS6Djt7jJ4wiICKnNSRbQyyaN3TpGWcpQBsWgAAuSABX2j9qfE4ap86WcAcD2Rb+CiRqIpFPFjUnVl2ORWDHTIoI8Rojd/ktusVIg1lSGZf+BnlrhppIdfGT7EC+a8OcYQm/G05BphmqmMcpEBQ3quGa5OUa8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740064; c=relaxed/simple;
	bh=X53J4iuGHBRBMHcA2yhzMiFHe/FDW4ZDsTPZPi7sH7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCIwXjs7gTm4CbbJnXG48EYcn0cN86Ci/zDL9VKEhBLSalNa6b6AN7zUg7B9WHAEUjM5fX1s24il298Yea7HuGcndDqV4xK5lJRe6C2q9U869izvtJAs+ZA9JVXr0Cw38kcg1USwg3hnI6GpaJrzLL8i58zVpZZ8qQBJozJwzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g3JRbiHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0YpN2+4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g3JRbiHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0YpN2+4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E4E201382795;
	Fri, 28 Feb 2025 05:54:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Feb 2025 05:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740740061; x=1740826461; bh=jWZ5YSw6Cd
	qLOjt2PL/WFgXLwnXjzr4876kr5hnHvkg=; b=g3JRbiHTeHWOtKkXpk9WZgTg3S
	cNWeUSlegjUsXp6NzrPlK9nlqOsMrmbZKAUzZfUUa4Vk8x1yuHZ6A4fbtjWbiGoT
	Ih8MqYIX0ZrTbwRr3CEMP64FsDxHORUe0cIdw4yvARz81XP+H2j1w1PyoAfBnRCG
	FsM6IaDgdPVe1RbOlA9CgJpL1VBK2gy/eA3TsOmHWuX7WB/XpItGfp/wKiIFIvO0
	l9LCVeLuvzJlHbOfjzcg2LbihA83zZ/mfg53H9kFqR+q9nZstSxYwuAwHQtXIknN
	H+gOk1Z3cbXXrZjBTbPxUkCMz4AcPs/5AfhDl8oeEuyJ+kUTJxFBy9ML1eXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740740061; x=1740826461; bh=jWZ5YSw6CdqLOjt2PL/WFgXLwnXjzr4876k
	r5hnHvkg=; b=t0YpN2+4ONNvRmDPX5uCi9s4UBhQeR6eoDgjhicbXkL6jlji7uU
	LNNbNnXHcj8FKjQ0GdNiLUE5z97kLO4iWBiw9kfxTbZKUQkzODmXnbBhPWNvVokd
	j6jP8EvE3CRoN2zlbmDvajglDnp/tc3z4XxMkEGcLGG6eYOuS00EUsljrff1Ex48
	0TVkDQtdHcABZYPWbqX7C8zRQWTDquSJCkl9vWBLNuF8lWvsTAHj5hrJ+kPwhkpY
	GQvUv5D1jH7cUXRjIdJN/sWWLljPBj6Yh7W/Xs7HaokyeJzk6YfbvPIyoDoBNuby
	OLASp4awTrQ29mHWLhRYE9CjSnYa4d6SDUA==
X-ME-Sender: <xms:3ZXBZx4RaNko-d6iVLFKJC7w0c3QuUsnczITw9SYBZOnxUOCxpjbnQ>
    <xme:3ZXBZ-5ZTiQkbg9NW0d-QxZzTTtfa6jdU0R4ZF0-tgpJorgKzcZA5OldVAmKrwHYO
    hCP6jAMN-zDgfYtPw>
X-ME-Received: <xmr:3ZXBZ4d28ByOJwgIGeOoetZ7qpafN9qNTneK59MWYPcBChK_xcjyucWwFopAzQOvnkmwcwOJskG0_jhxkwr6kEyVsegYy2aFYOxIsWrVUjl65nzi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:3ZXBZ6ItN_hKp1vlyRClWHVZa2D2uNycUR9MExaXXpV08tzPBrqw3Q>
    <xmx:3ZXBZ1K-GQyF4HR33RvDAHJiuyzjI6394CFLmn7eeQSxc3lzG5mfbw>
    <xmx:3ZXBZzxRcljtkplz0Ovz9rBFNMcohVtzUSYnQ52oA_aMvDocHH9zaA>
    <xmx:3ZXBZxIQlruDZSrFTDFdjMGEI8Qs8ROwo9CPFdkjh7C5BwNse_9IVg>
    <xmx:3ZXBZyHP3jdyndgHnHZGTJs7-3NOPbFUcIT5f8vYx9uMRlTcznMmifX6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:54:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc09c5f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:54:19 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:54:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
Message-ID: <Z8GV2k64arkWGpFA@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
 <xmqqseo35ic8.fsf@gitster.g>
 <Z71qQvlqtoOwDabu@pks.im>
 <Z8D0p8oKEmMqmzrJ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8D0p8oKEmMqmzrJ@nand.local>

On Thu, Feb 27, 2025 at 06:26:31PM -0500, Taylor Blau wrote:
> On Tue, Feb 25, 2025 at 07:59:14AM +0100, Patrick Steinhardt wrote:
> > I see that Taylor's series has been sitting in an unreviewed state for a
> > couple months already. I can review it with the hope of moving it
> > forward and can then pull it in as a dependency of this series. But I'll
> > wait for him to chime in first to see whether anything changed about its
> > current state.
> 
> It would be great to get some review from you on that series. I know
> that it has been on Peff's (CC'd) radar for a while, but that he has
> likewise had a few off-list things to deal with lately as well.

I've done a first review today. I'll delay my patch series a bit until
your series looks like it is close to landing.

Thanks!

Patrick
