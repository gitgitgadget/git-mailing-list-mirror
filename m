Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E06AA7
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742794058; cv=none; b=tl2BlgSNbS3xD9biz7MNk193/LD1sPkgamf10C1fsmX3jGP2y9rKuqfYI9rfIfyxrnx2O1FGXIo/VdXoFoIfgpt807ylMdUNsxCJzSmgDhwurS3ZFt0cIN6nVY871Xhk4oPqLG4QV8/9R+uuR1pI25msJIJB2E0M8Vo71pjdy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742794058; c=relaxed/simple;
	bh=gi5RHUisJUP8g7HzNJMiIifsIzbkd+cTbOu4xMAAMTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5cfKGaS6nZR+sxNKLl+CdNHU1Fk+L/OVCUlnIydgEdpRXrLX6MbXfJaxMQNPXO8QP2DsxHez8hDnJ1gwQ6+Yo4UuQ1KhzBCvVQbMj0/ExWECGhD7naRgPYWVzSpZ2/w7yu4lTV/yAEB9k2oTiu4zkB0pHqxFH9dJGkl3ANA8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wd4+ohiA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jh2eGynt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wd4+ohiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jh2eGynt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C1F41382CF0;
	Mon, 24 Mar 2025 01:27:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 24 Mar 2025 01:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742794054; x=1742880454; bh=gi5RHUisJU
	P8g7HzNJMiIifsIzbkd+cTbOu4xMAAMTQ=; b=wd4+ohiAzKQe43Tj94fn+++nZ5
	NusxAq7Tpl0wIgi9qEUusWSjAqPSiLbI6j2J4hRFff8tYfHe2mDyhM3jGnO9sg9d
	66MNYOX8Tm+4VCFcbSxvx3lMHDezzGBhLCPCsO+0CHlVkrJQSc/RIOjkXgO6zd8P
	Wp2IH0DpztKzmFz0k1L5gNTHumDrJI51Ba2EtpycZXn59mXiGU6iTy5b/F0+35KG
	BjN8+12o9h4/R5130abNC+a7IvqPIz1yEhpAuJ/dlSe5YU7gSHuUDpkdPwoqEqtJ
	Khak1xNhEhc9Pz98JAd5cw2HJ9IFZXOFCyJ9Di5vIp+yVfFWgs938HlqBBEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742794054; x=1742880454; bh=gi5RHUisJUP8g7HzNJMiIifsIzbkd+cTbOu
	4xMAAMTQ=; b=Jh2eGyntu/YZDZwiusDopB1nxV7hMkaz0Pm7io+9jrrXpo/DGUd
	GezvKLnqkUjF+twG4fnjhVTMmNm3flCXiOzEBEYKvlPYFxpz/1LvuLFWWhqm5BKN
	3h19FbiXpdUaGMGS9f5/+hFG3ToJqp8tppPJoe9jjOOAcN2COd5/UN0dz0AO5gcf
	1Jf/WKBNhHh6UDF0QVZvtMXExBK7Q8qoVyUg8TP+Ykcph1HVYV3G1lKVklU83CLU
	hG0IqdIfjtkibEV39COEe7ltzNl6TvVVp6eg4jifbZvr8MgPMi9eMItH5ApxGjAt
	eKdOwJLHjzpKKWOH5AlnmITQb2kR2gcaTaA==
X-ME-Sender: <xms:Ru3gZ6KrT92eUd2c6DRCHkoFx8fF7JAV-UUKpI0hs9zh2iHfMOZ5WA>
    <xme:Ru3gZyK8bczamQFP00XWQUUHGbYHNFWny20iqwWbmFlWjuG-2lwwXWFmpIvb-r1v4
    j8-3UfQDD9JymjtcA>
X-ME-Received: <xmr:Ru3gZ6v-d4T4Ym_M2S8AXSKecxY2dWGQKjR-idxJBmYdXxcLfVhQmr4VZi_Sxbo6V2xl3A2l81KjkDq0ga7vWqo86NT4haz5k83fMJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtth
    hopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihmhgr
    nhdrsggrghgrsggrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ru3gZ_Z8bIrmSAg-IKqzByx73zgoBw7iMqFOBWa360wRDbng2rhvjg>
    <xmx:Ru3gZxb9gSsXs00hRQ44y9ndyM38V7-x7SSRi492WdkNzY0EOWfuoA>
    <xmx:Ru3gZ7Ai6TQy4OZyTpHCF1MJLK3YgqV9cbS4LUNp-9YlP2hFhn1dww>
    <xmx:Ru3gZ3Z2SwlZ9WQ5OtTHXHbMZH0uJY6g6X042NxrIEcObwPYioNLOg>
    <xmx:Ru3gZznHEvtpoye6az4Su5_3A0foGPdlRPMcmGT-aHvzXp_dIa1EbjHs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 01:27:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: Re: [PATCH v3] shell: allow overriding built-in commands
In-Reply-To: <20250324032550.GA690093@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 23 Mar 2025 23:25:50 -0400")
References: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
	<pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>
	<20250324032550.GA690093@coredump.intra.peff.net>
Date: Sun, 23 Mar 2025 22:27:32 -0700
Message-ID: <xmqqy0wvov5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So it seems like a reasonable goal. A more restricted approach might be
> to provide a more formal hook/plugin interface. E.g., to run a hook
> script with the command name and arguments, and have it return
> success/failure to allow the to proceed.
>
> That's not quite as flexible (in your approach I could replace what
> upload-pack is doing entirely, cache its output, and so on). But it
> might be harder for admins to screw up. I dunno.

Yeah, we usually try not to be overly flexible for that reason, but
given that "git shell" is so limited that rewriting its services
wholesale is not all that much of a deal, I think it is OK.

I however wonder if it is worth admins' time and effort to add
features to "git-shell" using this new facility, or if they are
better off using something more established like gitolite once they
want to go fancier beyond what the basic "git-shell" offers.


