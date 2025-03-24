Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431819C542
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817431; cv=none; b=Bme+7GDvUfkwUXAlZfW0RLy5ynBB/2qNocbGx+Ag3dBWvdUbg9Ur7hYmI1dAFboyhtbrc6GkMxRNWxmJDLWii6vL792L897KPGsdu/qyYJLJd3e5uxXe4d0QGAhUonOg44AqDSYZA2Z+NzTEOoZFqqFGld2GWhK05K6iw7YBVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817431; c=relaxed/simple;
	bh=RrYFJGLsTBvs7OLKO/9hNiEHnpHIbJ72CfCIwpnn8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPExHW3ZCKbKVXpEZqQ74SrgC8bgQbyloD81rxhPTooqFXmpSCUhT9rE6/Cav9zvRzAZ9H7UjX3OvjLXZJyZz4EIbmtsPY3yQ02mhUZg4tEVSGdQBAQhkOp1vL/oOUZmMp3OnFslSLPTlwjlhlYZ4vfMTVPWTNJDB6dIlL0r/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J/DpE0Xl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkh7ogNB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J/DpE0Xl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkh7ogNB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EF7A213833A6;
	Mon, 24 Mar 2025 07:57:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 07:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742817427;
	 x=1742903827; bh=UZrq5IltqCAUS3ITMqS1dA7D7BB2vP9t3U/0Q74gBTE=; b=
	J/DpE0Xl2Ot4yGG5kyJCU/70HLG6JiIgl8rgru3xHcMcIpC6i511vc3t9Ikn3u0R
	i7DocrB3z3LYpul+68qwRRULQ891KjfQaHio7OdK9ck505Qlw4jWyt+jS5L3JSG6
	HF6LOytAIyZ4UmS7g2ncqHRqQ6sZMltEQqO3mxGGKyyA9xU2TzSOjGrn3//1V7kx
	J1/61uBgiWqklR7JjZsxMyhtEKICbRFOTjOmHAuNpPcDPXzIBEY+hVbxMHtN4PnA
	IDAA6HBvdbuF7LC1U5CtgmoFWsorstcaMlIghnh9FAa5NdWWAnymNlkkNCy6bfai
	kUdlw1fZTMCScceEaffIQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742817427; x=
	1742903827; bh=UZrq5IltqCAUS3ITMqS1dA7D7BB2vP9t3U/0Q74gBTE=; b=f
	kh7ogNBgZHHQ15QRz6KWdY9Vea3TCCSJo0/4EMfD1chFP7FNvOoQQjmdPB5dMOdm
	/W9pzNZHtiZ5PmF/TyL9qiGDkIA9au8f/xIRPYBED+RSmb22ReLkoD1jR2H+lT/2
	PwHBdcpTFUTSiPdCj3/5Uk4XaPV2g9dPIwF/GVVtKgNGtKdFmee+Wo7FOsWtSqJv
	lRN2q2rv72jp0FGyLLnSZAIAb11bx47Uw7tA5WMEBF8u3XuyuwJ9CCpt8CTCnYui
	2kgKqHNi/CgPHYLrL8GnQyeQAraO4T71EEJE+llAw8AM3/IN5dF3VLSFKV/eHAk+
	8uJlAsCEJdsEYe8KQQVdw==
X-ME-Sender: <xms:k0jhZwyblj6KPCXif14zLCG5tko7TbuQFj2eM-E1ZRP4yvb511pTng>
    <xme:k0jhZ0TocpQXv-bynTSegw0ttDa3W5CLxDVblm56uOUBlp4fBvZJfjHNA-vgv55GU
    dl2LEr-vWxM_AJHaw>
X-ME-Received: <xmr:k0jhZyVVqn8RlJ3HdxXjyjXEDYm4hVWqbViXvJshdYQgua7p_L23gEQEH4IJgjUjJw9w6sQUtUtxZyMcBbU2AkZ9AFRFv7sl7n1NZJdUkjWZt-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtth
    ffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeejfefhgfeuleeuvdehteevfedtueetkeegiedu
    jedtuedvteeuhedvfedufeetfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddthees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:k0jhZ-jqBD1dan4aB1PwzCixqx-EMsaMDwj0Z5ZDgllIXANubWxhHw>
    <xmx:k0jhZyA5SGCxbe3pIUqcH3QtXokhuh-UUxpMP5JntV2Xr5i9t3pqhQ>
    <xmx:k0jhZ_KuecxAHhhFbxvpeTiAmAyh-PDlb1VJXPPakn6QAWjQPcsmjw>
    <xmx:k0jhZ5B6svhjD_-rL5dVJPUZ9AFAYhXSQfcXkQFGYqes46N9c7WT8g>
    <xmx:k0jhZ1NKNSNyG2scq0N-_gDVZs5phRb5yl0X0r3Cj_a7prZZKPX6DhYn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 07:57:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 426852de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 11:57:05 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:57:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC] Machine-Readable Repository Information Query Tool
Message-ID: <Z-FIkHiyGc0jnHX1@pks.im>
References: <CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38mdFgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38mdFgA@mail.gmail.com>

Hi Jayatheerth,

On Sun, Mar 23, 2025 at 08:20:18PM +0530, JAYATHEERTH K wrote:
> With GSoC proposal submissions starting tomorrow, I’d like to
> understand more about the procedure.
> 
> As part of my microproject, I worked on modifying tutorials where we
> create new Git commands[1]. I also have strong experience with C and
> Shell Scripting and would like to contribute by developing a dedicated
> command to fulfill what git-rev-parse was originally intended for.
> 
> Could you provide more details on how to proceed?
> 
> [1] - https://lore.kernel.org/git/20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com/T/#u

all requirements and steps should be listed in [1]. There are two
mandatory steps:

    - Finishing a microproject. You have already started on a
      microproject, but as far as I can see there is still feedback from
      Junio that hasn't been addressed.

    - Writing your application. This would be the next step once the
      microproject has been accepted.

As spelled out in the document, you can optionally also help out on the
mailing list by reviewing other patches. This is not a strict
requirement, but getting more involved with the community is a good way
to increase your chances of getting accepted. You are of course also
free to do another microproject or search for any other areas that you
want to propose a patch for.

Thanks!

Patrick

[1]: https://git.github.io/General-Application-Information/
