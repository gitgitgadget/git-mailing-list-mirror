Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB115530C
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753227342; cv=none; b=YGRgVgndqSbMUhImh4J7gRt7vOevqZaO1G3o6K9Mu8Kxd7rtLMkHT6NyQm8xpGJpO0+lTYoCfujvUy9itALGrYrEIvdIMCKWE9eeK4YplVDyGSZ/tEhlt5rGNsnPK4VQX9gB4GDiQ4xsGiFi+0eUamOg66Bm5L9kipOMNqJnwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753227342; c=relaxed/simple;
	bh=CPzfmhENCNRPp7GZOiHr4rgnb4ao3jSxlb/SX7LfJak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTIiI6aW+/fjTw9zroCk+5vnLLBgUDu5GPv9ckkrBxO1BFZkv+/+gybCPeRds3VxbByFCDteVXdCBLamWLz8RgZZ0l6qX8xwcMnYEI/dZth8VxG4Drk0kQUa7VX7WlDaDrlHS4riKvl+33hKPBk6Gnhn5yXeicKPAxNRiI5CjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BCkiqLeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWj0RJQM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BCkiqLeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWj0RJQM"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B101EC00EA;
	Tue, 22 Jul 2025 19:35:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 19:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753227339; x=1753313739; bh=CPzfmhENCN
	RPp7GZOiHr4rgnb4ao3jSxlb/SX7LfJak=; b=BCkiqLeSoj5Lt+xf6aWMoLcVmk
	LMiKY34blkJiy4TsIJgXvuYdcsGyTaSt3becLnnu0k0D/87T4oKxib4NxmLDNp91
	4WdV4LoGncWdfUB8cqsmiwt6W8C1bHhknffWILnkNet9dGdmV4fkk+TVcDskbcNo
	1Hu7x1GdB8GGKNfSNiBF4bGR8fS1KQOurLqiP8ksMP9t6OZZrqm27m7RlvifGMDv
	ffIm82IIwPTtHBM7HvwGDobeWD3Nfqda751EhXyDEqp06sPVrSqlpEwfkCvtCRVF
	ToXehpsJcPeN0o7mpRvaujsIK9v515GN4ohn+uuaiNHN18wWhcGBVQv21sFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753227339; x=1753313739; bh=CPzfmhENCNRPp7GZOiHr4rgnb4ao3jSxlb/
	SX7LfJak=; b=cWj0RJQMq+BwzG9galjSslUtZU8hb7XjxQbC4NKH7z78iZ8aWQk
	xUZDSngiQCkXdipwjNElt2ancP18Cl+1/TOMi2j6pXfbBbFb9Zuy386Isv3hMNyL
	TW9DHIyEf9tf40bM32gH2pKByWaqFz+5VBpn8snNXKYKvm9V64vAny7fBd/JFMtz
	yphMzfbRPrF5G2aIiw6Bt2WM1mPGpSKt9z+2CEnBUP98NPW0r5LxvxKxvDtP4M8V
	PG0VeBegt6lnXpNWQ6R5/OV5l98wSFVH/STOMDnsAIsy7VBxeV92H5YgLeTz6CpG
	x6HIPXRVDZFI8HZULt/jqzhiMohvC1i/+Jg==
X-ME-Sender: <xms:SyCAaMhfHXDuy-9GU0fAV0TxsZ3rEK4P5gF9fuq2OSzrRq6KTPerag>
    <xme:SyCAaAgLAoDcPkwDvKeb374l5OTK-Y_C5GndP3H4ls-Cp8r71o96ztcz9YgJdGrcE
    nGXLoh13BCLOHnnRA>
X-ME-Received: <xmr:SyCAaKgMyfc0UWscU9hW5pODBfa4rY9h9Gmb8qsD9IfMw563FPFfQny693jsXCYnBSGAu1JjtmRulhnC0H0m8gAqTrGQRfD9HbkvNBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SyCAaIIQ77HnjR8LBy9Obt51Ue27F46W46Pq1E8C0C-OkIVJcIk6Tg>
    <xmx:SyCAaBEtc4N8zLsTgTdUCa61nha_m33-6vdvkRGSaFT2UcPsv0ZWSA>
    <xmx:SyCAaES-bBKoxrWE_EtsFRLhZeGBQKQs2EDN3pzLQ5B05n9SmhMBVA>
    <xmx:SyCAaFdcX-FJ5QyIrAc0O-z9VPumVMB2AG2uAFzjQJHEulilh2MSAw>
    <xmx:SyCAaPmpKuh1m9OwvHvdQN9k4Jw9eUMGT_UnCv6CpflDWjEbSgVb3q7y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 19:35:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,  <git@vger.kernel.org>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
In-Reply-To: <72f13c54-d5c7-4366-bba2-b641d9e2b0c7@intel.com> (Jacob Keller's
	message of "Tue, 22 Jul 2025 16:22:35 -0700")
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
	<20250722045456.GA824456@coredump.intra.peff.net>
	<fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com>
	<xmqq5xfjrew1.fsf@gitster.g>
	<72f13c54-d5c7-4366-bba2-b641d9e2b0c7@intel.com>
Date: Tue, 22 Jul 2025 16:35:37 -0700
Message-ID: <xmqq1pq7re7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> I am about to send a v4 that squashes Peff's work in and adds a
> Co-developed-by tag. I think that makes the most sense.

That's fine, except that we do not usually use the phrase
"Co-developed-by" around here X-<.

