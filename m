Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6B224F6
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414060; cv=none; b=kyH7z3GI/OcNExNrrRYY+Lqdm4GVO8da65kYTXwW2IDp9P3Vhyadg6PkVDkvQqFMYMcyjAb0WCbwa8GZe7j6qzMaO8x9+sEg4SZrfENu4P6X9e6IwxKAmiY2ZcrwslaYGgIA2duQo5n/SsuMMaEDPY9Bl/KVcfAVmDRR2OSYaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414060; c=relaxed/simple;
	bh=U16wavsHg0ZcfXZYay4cO1YXxHPnL5f5akY1XNYGuaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=huSbBtMhG+vOaNEbndyIUCPSc9ZtfMfyMRGDeyEROSRwSIx4S87qZXGpSUGqVNxWfp6usLe9Uks9fUa0zuA8nYwoY3SkoGLhkC3TLMC0UfAjrGeHfYDRBOqzaDQfAZiUsDPh37CnBp5tmRLSRzToeZqopYbEG50K2iaZ5w5XupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SmHZlfHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BILXrEwv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SmHZlfHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BILXrEwv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DC227138041B;
	Fri, 16 May 2025 12:47:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 12:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747414057; x=1747500457; bh=rwci5+0TtF
	tIjXNaesvJW4vCqVF4crGnoNChmWHd6Wk=; b=SmHZlfHqcVYBdme6A7gXMdqYUK
	B0t3y8Y/WQvQVjTgm7LFRFcyju9+4YXJzzw28ry3s7t8seG/4UbKdHZ3edL0t1ly
	xA3lknGWW1WhqKwnVWomE5ImbbQJBMOW/mTOn6UvUoz5TvjGWp62k+FH7SeBKA2k
	/7HWvnREITnvpts4M5vWDecTY9sTp0iWaPakj5yWfacWjQdNPerKSMdzDGDp3B/P
	4BxMHqNb7yHqlDovUbwSiz5SRaUYcg09n8Wxpdn1S6emisB5YwakZ4nmxh2zDWpM
	JwyZsN/PxnjuK1Hl/Fm4gSJnTt0GPKRU0d3CShYZwMxGjxhT6CCs63mv9fhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747414057; x=1747500457; bh=rwci5+0TtFtIjXNaesvJW4vCqVF4crGnoNC
	hmWHd6Wk=; b=BILXrEwvDgoZuQ+GIn+lg1Tpvn6GSN2PBD0Fbp9inrTLvXPJeBx
	CVvji4I6befw13j4dS3C8xBi/ZSW41/2lXXoi5QI0rEqN9jNMd02BY6QlPeqwPaV
	G3SAT9QcwnOnVoqdpfJo3hTVwoBoVuaivcS96MwOcM4WvVmUCMpJkZQ9qS1JutgE
	EIYLT0brWqEzZSjK4Zepg/yvMhT+WrrF76bnXqIeYy5akrmhKwejQhbcMl//p2ul
	7oH1TUrEbCChfG/2VfFhz8PmwPtwcaROvImQtO4rOOIdF/Dr/m9RoY6k+/wY5ie+
	KfU3FwQZUlaMVZG8OVpS2XRxSLNHC4ETydA==
X-ME-Sender: <xms:KWwnaHKeA1oiFLZPEIFNHAaoBH8p_xc1O7CMOdAurIE1nHFwrArZTQ>
    <xme:KWwnaLL-8sj2q3kDztILc0OANN85nHl_MIC2dvEWUNZSebc2pL3FtJUC68NvJSNfw
    gCh6zQTMlETm8WYBA>
X-ME-Received: <xmr:KWwnaPu1wv-zJCMWfHYt_6EgWJl-0LlCI37-JB1qB4Q8_SWLqvuMEA6l6nvkqF-MW6_rhrHqZ5BFm6TPqkYmARA6hftEWgB9Ucl2In0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:KWwnaAZqrofaoXtIJhjMR3nbZKu9RsgnECtQMtjSr85UnlF5-4kDxg>
    <xmx:KWwnaOZMUKbmz37Xdr2DP4NW69y1qqYBMWoHiHim20Nh078H6jMxiQ>
    <xmx:KWwnaED-Nc7OpIZfxhIsse0CYudpN9caWXsfDBg4uqZr0K1QUsiDFg>
    <xmx:KWwnaMZSCKXNJnCVuUCTKKLQy31DD6CAFzO3Wb2woyN7tGz43QrysQ>
    <xmx:KWwnaNl0st9TVbpX9e-qxkvZEjf893G24tixB9soRWl9fmVKFy_IF7sa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:47:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] cat-file: make --allow-unknown-type a noop
In-Reply-To: <20250516044935.GB22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:35 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044935.GB22242@coredump.intra.peff.net>
Date: Fri, 16 May 2025 09:47:36 -0700
Message-ID: <xmqq34d4wlhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> However, we can't just rip out the option entirely. That would hurt a
> caller who ran:
>
>   git cat-file -t --allow-unknown-object <oid>
>
> and fed it normal, well-formed objects. There --allow-unknown-type was
> doing nothing, but we wouldn't want to start bailing with an error. So
> to protect any such callers, we'll retain --allow-unknown-type as a
> noop.

Heh, unlike my usual self, I started reading this patch from the
changes before coming back to the proposed log message, and was
wondering why we still take the option.  It is obvious when the
reason is spelled out like the above and I fully support it.  My
sense of backward compatibility may have deteriorated over time X-<.
