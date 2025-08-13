Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8D2500DF
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099022; cv=none; b=agogwyJNnB85N3dZLu/f797aNSB62Cj9UA4ROMIgwz8xtNFXZSwxop3/h2EQIzzxiF+c899KGNfJeesQTZvvBT2nQ7JLuZG+Kj2ppiZlKCyzt5LZ6kcPCWkh40KxHNGhSfKeebUlz8HGY90D3jMZG07N1adQybwRkF7g8lrRl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099022; c=relaxed/simple;
	bh=a4zhnBD+LeoKHTudEJoseoYovpfdRBulQCNjKXBauHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ePAg+Q+8YacvxKQDysuINxroy7tLhyWXFbkO+NY6Rcr1yyuWwVF/obO2WIuWyUKPqmOFPHGu3YgYyImR3GSoq9DPXP7J/xT8BsUIIptNMiHbzb/mRK3KdydrA7WsAgw8MIB5cFepst70OQawb663Vp9S9HizSXmU3C0rpOQeOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=guYCun4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vq3Cm5Ug; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="guYCun4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vq3Cm5Ug"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 959827A013A;
	Wed, 13 Aug 2025 11:30:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 13 Aug 2025 11:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755099018; x=1755185418; bh=T+UD0olYzX
	OrtE2V+T19pmYyjL3/oOuQQETmmUzEzxs=; b=guYCun4IJ6n8aH3Xn5NDjLIYzp
	dK3mfSyV5txaJzcv6bAqhEoWs2H3rM0OPxWHmk51VNdZOu6v2Snzu1fvBmSBb7rc
	T/ta9a043nRo39pL58y0qsolF+0whKeyppbJtTMYzylec5WTJPbAc4PsWWGvB57L
	eb1lLilO6sRX/lpGsWFmQrHtH197vfl4IryYKECaDtszBG3jXRnL4Dx0gwWv+lpO
	kMt9o8SY74hX1oG3z00XvoNg1ONdxIZzZDz5/A0qMBSp1tZEwsUx0bzu1CQd8CZj
	cbkg4iVPWtHR2TkmHHf5JZ8DMJbhnO3Vqc4rYgTjDgjzQDqApzQR8N8gMZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755099018; x=1755185418; bh=T+UD0olYzXOrtE2V+T19pmYyjL3/oOuQQET
	mmUzEzxs=; b=Vq3Cm5UgNr2rMfeJN4UHYD10I8TIZbUlSYB2a4FqZyTK4LOArAB
	KGgjiT6GejJidW8b8Dm0HO+IMIhZk/IoTUItlzwy8fHJGca9cjDqHI6q/BOBdH89
	7FFqbNIS8Y2BPHaarrbarJjN1/vS148SYESkG+svfkS7gLhlTY3blQro4oQPq01a
	m7RjukXI1TMpQdoq3nAVoSL2TOoq0jGT2M0S384hXvExBVndHVjJt17xfAUTqrXX
	LiOWmJZ8u3yHNZYac0Ly0rj99wha1o59yAA+48IKo4AAbKzEBysjCTXEjqsrD4CR
	lb9WQDa1joPnlB8dVSMRjHv8jwJ8L3OjdDQ==
X-ME-Sender: <xms:ia-caATWry1nDC13h-fXrlSbEgA7xeDPFIevS2YFvRtZwCqUoZXaEA>
    <xme:ia-caBDAU2YbR8EHaYlGEgiwtV5TSUREEeSoh7OvoDZrFuzbgfoG3Qs6dvrLDkDj3
    y_X9jsnBL25HGzvhw>
X-ME-Received: <xmr:ia-caHSqwadox3e2kSZIQCIrL0w0Lcm6W8FrEYLh87LWbn8dQL1NVneOjylkzL2PPsiCxpenUGKowwrD5Gx5KbAk4sAl9z33LCbGakk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtrdhv
    ghgvrhdrkhgvrhhnvghlrdhorhhgseguvghtthifvggsrdguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:ia-caPpG65Go3-sVgVcMQScoiybFYES32Pf9sHT4-_Unky2jejc1Bg>
    <xmx:ia-caJxV-8cUg-wAfNQu3yUxqYeAAqjhpNfLA3Pau66F4Sotbk1wGA>
    <xmx:ia-caEKlkJZlcOA3l44vZwhwicqpP3h9babbmnU0A0wnLUdxhJSF6w>
    <xmx:ia-caLJpFgg50fuMocS2BHfasXAPV9bwzNJiK8s3T-0HhM_Eup46rw>
    <xmx:iq-caERFrHE47SxEiZS-8_4Vm96mrp0xHrIPpZI8ZNjkTl2FQ09QfPgu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:30:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>
Cc: git@vger.kernel.org
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
In-Reply-To: <12fe17735317215aa0de58a20055193a@dettweb.de> (J. Dettweiler's
	message of "Wed, 13 Aug 2025 10:51:50 +0200")
References: <12fe17735317215aa0de58a20055193a@dettweb.de>
Date: Wed, 13 Aug 2025 08:30:16 -0700
Message-ID: <xmqqjz37nss7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"J. Dettweiler" <git.vger.kernel.org@dettweb.de> writes:

> **Proposed feature:**
> A new option, for example: git stash push --only-unstaged
>
> ---
>
> This would:
> - Save only the unstaged working tree changes to the stash.
> - Leave the index both in the working directory and completely absent
>   from the stash object.
> - Make `stash pop` safe even if the index has changed in the meantime.
>
> ---
>
> **Benefits:**
> - Cleaner workflows for splitting commits during interactive rebases.
> - Safer testing of staged changes in isolation.
> - Avoids unnecessary conflicts on stash pop.
>
> ---

What is the downside?  If the users of "git stash --keep" can keep
using the same workflow by switching to this new option, you
wouldn't be proposing it as a separate option---rather you would be
proposing an improvement to the "--keep" option.  So there must be
something that the users would have to do differently if they switch
to this new "feature", but it is unclear what that is.
