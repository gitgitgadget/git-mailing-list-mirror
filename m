Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B8242925
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226467; cv=none; b=StpqGxKu/Hn2boQk8EuCllbmPSUswWdH8mz/sdkvM4oDZMr1FuiQf6a3Z8tnRQdO4ekxCDtVopHlg+VHzBrQDIlVpUT5alEsiwmaClgNxXnhwCP9B/WbqW7dvqhf0B4s4WiZeBVW64dnfiv3UP2jJarXjSPtU18ptW1oLOYRgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226467; c=relaxed/simple;
	bh=s/HEVa0uxqGzCtM1PJjVVLtOpUan2OWo/4GbuiCW0LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Raaq/io/XEc4EcEvCwgXBLe/k7xS0VvZEfqFo5UNqsYpT+NeTlFgfI0SK78svkHVttDfZ5B9UzIZHC4PFWKBf2sAUWabkueRIrCp1orRaARD8cm4kn+l10Jerl5kCyqMTaEe9wq9opmtrJh89Fd02ujTa6fM4TXjLxe7qLlUWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWeEtvWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgOMp7xm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWeEtvWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgOMp7xm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F979EC00A9;
	Tue, 22 Jul 2025 19:21:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 22 Jul 2025 19:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753226464; x=1753312864; bh=AUlcUd5b40
	Twd6cRahedk/wIsw++/aFrgugReoke5a4=; b=BWeEtvWYqjLBBvOif74+NkECaD
	XiInbUoM5i+XgMJo/2fr3YHOli/qMR/8VO4QG/a/O9mBDPHLQ4e9wzzDdQ1mHZcr
	RKhyuVsFrbB3jXyGQsmqiWW3O0sxbnaHghIglSLtIpBUg+b21pLsUIAsjmXbw4oM
	P7pzhHMwE+K9z2XFN/VfMsvhe3DY8DMo5/cjUnta1Juq94fzufhtTr0DIttepfgT
	dhi6OI7CSe6AcQQ1mvXCGGf3VRTzAkt5O8x5KepGiF/YdLwrsRTolvUU+LI3Ectg
	PrbZeeDN803xHhQH5afLsO8eUj0MFAgVQSLuEl0tUiLMXNKpjzUX52naRtpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753226464; x=1753312864; bh=AUlcUd5b40Twd6cRahedk/wIsw++/aFrgug
	Reoke5a4=; b=NgOMp7xmGXD96Y+3Swxf8VifmWThT1yE4ASovqHp6H4Aqw1td0b
	J4JJgIA3hDCvVllXJX0A8bDs89D8a0P7NuOyrLQeskIX58rW77I9+BKNVqFMhFG9
	XhgmkEFtf8A/9+GQapaHHUox12i/HEDhpeBxKSmeesg+lDeM9BZtc4v64Q7Fvaih
	e0bMLvKCeK/1qMvDdd2J3mdB7KPXtgLpRDGbdLPFDOozT5CtVMrdJeBmSOlXgAza
	YHUdfdzu+6ZuH1cpTrWr2ol3miejkn+MCHIpHdrNNDLWcJkHrO2cyNgMd5SuEgrm
	NZJLE3tsp00Fspn60pJUzaObPcCT5xyG87Q==
X-ME-Sender: <xms:3xyAaEs0JDvDLhcbS7XcfNFwKSVyNfCoREu5lqtB6b4IdjANHBo1pQ>
    <xme:3xyAaM84nJeyRh6d4-0ALDQx7vGQ7n9W8LN-EdsDNX3nSMCW-5ldP5WJsdO3frOVT
    ZhLliq_ZsYRt54qiw>
X-ME-Received: <xmr:3xyAaGNUA0-4Rr1HFAf7N7m6Tr3u6FD0kaCAtraWTJ_A8q88CIcbkBSOOiPb7B9l8o_i0Kjix7TOxMruX66wQM8zv46_KinpP0ILYLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:3xyAaCGdlXwNiiCjJsZ15WVKCXZsuT4sz85Tdz2Yv-HY7RaRFjY13A>
    <xmx:3xyAaMTmR_PaSOvvWhWiSxYKgcDARvlvCPZhEi0yy5p4gSx3BdlsBw>
    <xmx:3xyAaHuh2jlIUJ9y4cNu0d4WodQnhrh1j1Nu5BrtlI_3m8YWuyq-Fw>
    <xmx:3xyAaMKEAI56uXoF5KzQCLOK1O1vPNeMrq9eXIQsyjHO-7JEBYDHxw>
    <xmx:4ByAaBipHbuS2P1U3CxUUl6sPBsqTrvXupQS0lIGoOyaLFfngHI9Gmn->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 19:21:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,  <git@vger.kernel.org>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
In-Reply-To: <fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com> (Jacob Keller's
	message of "Tue, 22 Jul 2025 16:10:24 -0700")
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
	<20250722045456.GA824456@coredump.intra.peff.net>
	<fd14c857-63a8-41e7-8361-bc816d4a47c4@intel.com>
Date: Tue, 22 Jul 2025 16:21:02 -0700
Message-ID: <xmqq5xfjrew1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> This needs to pass &data.policy.opts, no?
>> 
>
> You're right... I think I fixed that and forgot to actually commit it
> before sending. Ugh.
>
>> I think we might also want this test on top (or I'd be happy to see it
>> squashed in). It shows off your fix when built with SANITIZE=leak, and
>> also catches the bug that v2 of your patch had.
>> 
>> -Peff
>> 
>
> Sounds good. I'll send a v4 which squashes this in.

OK, or you can tell me to squash what I queued on the
jk/unleak-reflog-expire-entry topic that ends at 7c091149 (fixup!
reflog: close leak of reflog expire entry, 2025-07-22) down into a
single patch (or two to keep Peff's test saparate).

Thanks.
