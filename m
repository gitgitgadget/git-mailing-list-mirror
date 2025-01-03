Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561117BB32
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735905949; cv=none; b=uJH7vD/OvXft5WUsn4pmqlrboOTpASRzRDJeuspsY3NTOKntgtZKCBcsRPc0p8W+zWx/e2hU7WBjuIzpld76GoygTBgEb5MYya8vpRDtDyYoqsdMEX+6BFWEHnmeWLN5qEyg7OEzzO0qBuTa1tr02a51AO0Uuk+hvSSvZE6juEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735905949; c=relaxed/simple;
	bh=nCfDKTIC8ihwkM7b6jUvIkOsQUq1X3MFmLls4uJ/hOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKna/wK7YSI5u9BFGqHDgw7pDfp71EOVA8xWMszt+Y6q6hBACOt3MIguFePdMTye298vYbz7Q7ggj1hK8OPMT0CKwEMLBltQr9rkh5Fm3e8n1nK9gNJ7l5tsLGqV8+7gnsFy0HSKbop062fSa3F2xpkHLH9KSArAHJNOIVrsPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sgem1z/K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDJYt7cj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sgem1z/K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDJYt7cj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 29D07138025D;
	Fri,  3 Jan 2025 07:05:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 07:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735905946; x=1735992346; bh=0MMnJ+Nyiz
	HUj0XbIOgJz0dCreMie34AxS/xyP5iitw=; b=Sgem1z/K61cdoouOjyqlDK9I0y
	S0zgmpniwYPFbsAQldXovDv5VwOJn1mGQX+JIeFkI5rMdlIGumf56bDL7uGefsi9
	su3nD40NDdWlJrjmQQ9nrF6XvsN7zpCfKqfBnZmjkocM9lazA3vNXGNXXkeN3lKT
	lURT8DmSKJ7+YrcwwH+LeV6sb20jDH2Se2LlYEiNr+Ul47GZhVP2cXJTTUaIetPL
	0n8CzWgJEw/VVSnBqphaHEbQHGbaZw3WDqQ9WQIFAkBB6Fw9G3/gMKKhfKbpyDoc
	f3Z6Pw9PQvxHNe80hbfc7A8Bv7UPY0J5nCx6AHwqdsREPCaOGKwVvUfz2KYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735905946; x=1735992346; bh=0MMnJ+NyizHUj0XbIOgJz0dCreMie34AxS/
	xyP5iitw=; b=GDJYt7cjXcGrgXh9PVa5CmoMyBjhLBLix8lDA8lnZSvXZCIiZhq
	p9IJe7yGVqs0agpGJhnBzLtkWASMCms+OZ4TNmjSh+FoGf0z8stcdujnkYq3XdaJ
	XbDEHQcc0K9o13WxmiswfB9Uy2nbtSdPOWCBYhKV1QLQfB6Grv4up5+VMbVDu7ni
	WXL9cyMRy0kh+YZ8m8A097BPL5mf9a3WYKpZUEZ+QnjlncDNff0E6rTaFYwi5RY3
	+peTJ3igQtrTked1cUbCS50O0EKYkyXnU/bCtqKfZ+snD6Od0axbHJyLcAIsF2YW
	HSX0vwHckA7h94iLUclVvjQ+zCcu4Rl8wUg==
X-ME-Sender: <xms:mdJ3Z9Lx9OH0btzJlOo8fvDKDpNeK9G04pnGIZpSEJg0T5JcxBTEyQ>
    <xme:mdJ3Z5K-G5iY0PEVDhym06cfAsbSRNEL1eE5S-jSjMPg3W5oRHryqKCYObMJKVCod
    YOtWM8m4Xkf_PaWQw>
X-ME-Received: <xmr:mdJ3Z1uo__Ljq4tyEHOjfQBfx5h1D3AMAbS4wDCA7meeCkkkJcW9TbQZmtUe3Fhw6GpfTBqjVe2b4wflq8n7XtP6wq6bcx-HWZldZeXYHENrYtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mdJ3Z-bc44osPi1vf0ypHNWiwyKZb9ScIT6Y7pAyq81pfrw3Ch_Kiw>
    <xmx:mdJ3Z0Z2xy-uAbTcy_45Vjs0Xkmx9SQcWNQHTq3zXMPaNyDeGU7aPA>
    <xmx:mdJ3ZyDcnsmJ3nVzYiNRJNTgOvBhbgMw_YUP8YE1EbbZcGmsrgWVrw>
    <xmx:mdJ3ZyYLhrKSFwUdQZ3hi10ZmJTjfhGOF8vR_0bXo7dR8_yDUeIEog>
    <xmx:mtJ3Z8Glej4ymgDinW-yVrIjkQgprHQV5cNlfdvyzWgZX-cBFMP8vJec>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 07:05:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9b229d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 12:05:42 +0000 (UTC)
Date: Fri, 3 Jan 2025 13:05:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] test-lib: rely on logs to detect leaks
Message-ID: <Z3fSj-NsSg2El2wI@pks.im>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201444.GC3305462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101201444.GC3305462@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 03:14:44PM -0500, Jeff King wrote:
> When we run with sanitizers, we set abort_on_error=1 so that the tests
> themselves can detect problems directly (when the buggy program exits
> with SIGABRT). This has one blind spot, though: we don't always check
> the exit codes for all programs (e.g., helpers like upload-pack invoked
> behind the scenes).
> 
> For ASan and UBSan this is mostly fine; they exit as soon as they see an
> error, so the unexpected abort of the program causes the test to fail
> anyway.
> 
> But for LSan, the program runs to completion, since we can only check
> for leaks at the end. And in that case we could miss leak reports. And
> thus we started checking LSan logs in faececa53f (test-lib: have the
> "check" mode for SANITIZE=leak consider leak logs, 2022-07-28).
> Originally the logs were optional, but logs are generated (and checked)
> always as of 8c1d6691bc (test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
> default, 2024-07-11). And we even check them for each test snippet, as
> of cf1464331b (test-lib: check for leak logs after every test,
> 2024-09-24).
> 
> So now aborting on error is superfluous for LSan! We can get everything
> we need by checking the logs. And checking the logs is actually
> preferable, since it gives us more control over silencing false
> positives (something we do not yet do, but will soon).
> 
> So let's tell LSan to just exit normally, even if it finds leaks. We can
> do so with exitcode=0, which also suppresses the abort_on_error flag.

The only downside I can think of is that we now run the whole testcase
to completion before checking for leaks, whereas beforehand we most
likely aborted the testcase on hitting the first leak. It follows that
we may now have multiple leak reports, and it is not immediately clear
which of the commands has actually been failing.

I think we're now in a clean-enough state regarding memory leaks that
this isn't a huge issue anymore though.

Patrick
