Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53E1A7046
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258007; cv=none; b=QX2v6TkZYNJ5aSQ8IMzryb9z7L5up7fBcWkR0oXYHhVbUkc3XBzHih5KaCfa23PrfMFlrTVA9vt1BXruZ5uIo17GtI3mBeelwUHcD8/rLxQdt6N5t+JhucurNAfHajA5SKVFVhMfp0JSxPz1JEr//CAQlMYChjqVUkla89OTYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258007; c=relaxed/simple;
	bh=F/yE9ABWyEZmMDMsVT5nDF7roo739BYQOjXnsQnFzao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqIvG2Cb0YnGJIy6UTMi/1AXQykkyqf30Cz4nIy/gzgbDHQBvQB/F2ux2LkeJPiSby63/kmlYsrojC4NOR8BVPD+cMaAzPn9y/4A2nil/20T6Ji4THnv/PCYLrOLme/hygD580XyITJDnVMSG5tfZWzeVoQPyMdVA0E0thsnJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jGlqs2e4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mudw9CAB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGlqs2e4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mudw9CAB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A2F5114009C;
	Thu, 30 Jan 2025 12:26:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 12:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738258004; x=1738344404; bh=0kcno/kNwO
	046fEkX/H1hQe7w9W7lHNxK10iEcENY7k=; b=jGlqs2e4Ur/DYEHkuA/ubxCYDQ
	gS2zchCNwvNeuFXF92xcT9cigFDqPlmC00bcOVhRN2aqB6HniRhYl2CDGdi7TScJ
	um0T4qJFfnbHoXplco09iI3B3+mDsCgGbD9DPxZyRi1ToFPXgrzlofDQnZCrnJz0
	mCBEQP29troGizLMhaaVDwNDSIdPJ2YsWHAGmKZ6g9RRt9OqgtsZdkz/97Aaw0Uo
	J8LR55U43nKQGeIvfm2pruzuP9Z74qE2BBudv03DPCvMmJsFvSdjGtfL3CbSwzzo
	Yv/SzWbZziqvvKPgXenLX+ruDe/fx6Cp9/8a3wydgeVqSmD7FPHyzLQDXRUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738258004; x=1738344404; bh=0kcno/kNwO046fEkX/H1hQe7w9W7lHNxK10
	iEcENY7k=; b=Mudw9CABjkFxlIjXINld4u6bymF0EfcyLrMMmwiilghR/+Odftx
	pJQ+DSjxLouKNTdGyJ7CSWsn7dnm36IXn/uFlYBi2aa+NbXs7XR/trv3WlT9MWWs
	KPm+v8fpYqqFTN4abuWQ/jb1c8IrKPUbuonKwHQH6DEomQd1HL8UvR5eW7mTeyJ+
	Q6HRjns/0+hZI7TQBLCr3Vvw7/QsR+Tugu4u6PzHd9WvEUzlwefOTEHs8HfZiL95
	OMVsvfMMvC+cmAi14IOYZ1MOKODtAI970WiacpiFk2YAKb2GAdxZ+m9BLzV7Xpsk
	OWobdH1oeYsF3w6W8jN++oR6iH7FNnk4bwQ==
X-ME-Sender: <xms:U7abZ652OxwV4jSytgZtE1UETTwwJNopmxiVqFZvS9rT3VSVfkU-lA>
    <xme:U7abZz74TwbE2Qt8xsNvbHBesuKY7S20QuiVIDRZ2l7jELZSHwU1Be59L2hgbniwe
    Ej5iOMvd6UoKMCmZA>
X-ME-Received: <xmr:U7abZ5e-nB1uKGlGy27EnYQqP9dDpLG2qvXFPd9_bTp2hYk2nQZGUSx9suSs7MHVm-B843Lij3SqfaQNV9zfVGv95EOJFVvk0OHp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:U7abZ3I8EFkVvE2g4HSAIXmXqWrm66lf0HuewyhBpT1IVOQkniXXwQ>
    <xmx:U7abZ-Lsk1MykNHWdrTjZHX4C35LMjZKcUlG-3Vj4gAzaQnKVvfZ-A>
    <xmx:U7abZ4yEDVr48aR2cVqDJaBkg-NWz2GxFtr8b1YXQwv-u79OSWxODw>
    <xmx:U7abZyLJhIiIWEFSUr63XyKigYtWMgpyhBAV6pCpADwELm0ScN5lMA>
    <xmx:U7abZzGa5ZbB9pL8ss1t75LAMRWm9BKOmdxmJFTsq3R1GTlE7Q-ulDEs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 12:26:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
In-Reply-To: <Z5rkFcp_awa2hjxu@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 30 Jan 2025 02:29:41 +0000")
References: <xmqqwmekvubv.fsf@gitster.g>
	<20250128164606.GA1688180@coredump.intra.peff.net>
	<xmqq8qquom4t.fsf@gitster.g> <xmqq4j1iokvv.fsf@gitster.g>
	<Z5rkFcp_awa2hjxu@tapette.crustytoothpaste.net>
Date: Thu, 30 Jan 2025 09:26:42 -0800
Message-ID: <xmqqtt9gfc19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-28 at 18:26:12, Junio C Hamano wrote:
>> Here is what I'd directly apply to 'next'.  The merge-fix mechanism
>> knows about the same change, so when I merge the bc/doc-adoc-not-txt
>> topic down to 'master', the same tweak will be made as an evil
>> merge.
>
> I agree that seems like the right solution.

Thanks.
