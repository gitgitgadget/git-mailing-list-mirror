Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AF221540
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207806; cv=none; b=pwK1MCZIDcM+LcloN+a6BFszo6IjMzn92m30LeFcNMjaZP8TEHYCXZd+PA4YOpzVnDviroc43pgmLtobVllF3mmY6TGJugFqauADIL57/SdmihnLImOP3r9u/Ke2vseXgZsXVHFczDOWXTKqDealCAB6R2SotnLeMXoSDkFg1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207806; c=relaxed/simple;
	bh=yPSMt5KiNTob+yDpoA2zGj7QuSpsdEOk7fYbiGllVa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mC86BkNjO61XBLKYS+HEmhvMEd0R6gTBfIlKuVc1AIBTpXZS0YjbBOBx9pfyeKWMwB0kQw4X0mTpD3mP6V7zUVRH8g0HRY30r6TciLF+WDL/DMTBNVz7Q5QZ0izWA5D+rb9/KFGzYBVmCzjufelsPXBTI71lvj1VTXGUDRRAr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qQO4cy/W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmOtYyFj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qQO4cy/W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmOtYyFj"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A989F1D00093;
	Fri, 23 Jan 2026 17:36:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 23 Jan 2026 17:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769207803; x=1769294203; bh=Alx8+Z3iIn
	BZpcXLW9hV7zBMAI8nbu58lpYK+4iEh8U=; b=qQO4cy/W5jBW/V9JCZsqRyhTA1
	gDyKXCk+spCsvNrutteAXM7dlcJmqAswubwvWR68yVE8bao8hMNgVvoZOheBlDx4
	PFRySh7hhZEDNAJKKEEkKIaplzUNdDJMY3lSDEVyYEZCLQ2DDDpMVvRBSKwcpo13
	gks9Y4oGUyCQmupE5AUz/tQV6Tx+jPeLgyGZgWf3s+dyu7RvUoWo2dvDGYCIQeVk
	o8vqEA9WnL7qFF13IuedhrK306eCtZtofRiH7Q6OWG0VRpU6nRLYJqTvoGbnKPM9
	/ybWKkDvDrf905PGnoB/+yrKZ8ZtbA9c+3m3H9exFJ982Ml4ncQ3KGLXfwUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769207803; x=1769294203; bh=Alx8+Z3iInBZpcXLW9hV7zBMAI8nbu58lpY
	K+4iEh8U=; b=FmOtYyFjoyxG7gPQwz5HDY/cVhaFiBSY38vqPP0xjJqo6SdOA/M
	O0VULMT+MSIOQFkFQJ4PUmCj0gFHjPhjN56TTvuXxL/uMFaHT0bfgcpqRzCxQnpx
	2bN7jknttDpOG7W9K2OQBrbVoxalaji8wriSOgBGbXAAS1FhY+soFoup+XADDlLW
	Aa1JS5odnkNi1esdzMW1n7D0D8/gT588L+d6TpV4fMB95DIgkOZdrYZ8fMn03v7E
	FmKwSyEei3fiUHZHCEPwDH8XAQW0QxJFWDKoY5QsgxIAQ/oEqlJh2CgSHskUEzCx
	NPhgL9Nal5rl3786CvPsZrUI2HZzE7r2Uog==
X-ME-Sender: <xms:-_dzaaI-5HyUUulwsNu_Wot_DtU7o1Sr7SmKiMWJyL8kyfarT4IGag>
    <xme:-_dzaZL3-tm2N14rQNZw5lCegrYno322GZYTDj5YsStcBSxhXR5k6W8ZQBdP-Na7k
    yT7D7fWeVIyYzzdG0Fcnbdz3kYVPDxAe8Mk-Z45T7Mvv1pivSeq7w>
X-ME-Received: <xmr:-_dzafuiyo7qWAZIMtbKlkrLRgVhUnSoDrzX42qbwvImuMgWcMjOew-4hm5d80P4f06fTgEoTnN4kHbcVMd7vIUWyngBkERst3XQntk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepkhhlrghushgvmhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-_dzaeT0OJ3pcU9LFlPJj8XzIPkSHsfpqvaRul2NyPmhOAUE43JiGQ>
    <xmx:-_dzadNStkQvh28_IKgzMtnGh5gX_supXxYV3YsN_zXLr_ZjzPYopg>
    <xmx:-_dzabYjJbNF-yklqg4O220dFP3QseKimsAmJFqwjcPS3UA61Z14xg>
    <xmx:-_dzafzLmOzjUQP9STQogytby7Gg4BS6zNTpdfAWq-imqUhaRbYfQA>
    <xmx:-_dzaVquyAfC4tlZdHF4SA_3a76jfN3q_EJbGs-HxQ8ed1zr8h2sd5z8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 17:36:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Klaus Sembritzki <klausem@gmail.com>,  git@vger.kernel.org
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in
 za, and I am 1aa
In-Reply-To: <20260123210643.GA2728629@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 23 Jan 2026 16:06:43 -0500")
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
	<20260123210643.GA2728629@coredump.intra.peff.net>
Date: Fri, 23 Jan 2026 14:36:41 -0800
Message-ID: <xmqq8qdogdmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
>
>> $ # My initials (ks): 1aa
>> $ echo ks | sha256sum
>> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
>> 
>> $ # 50566750337
>> $ echo thinking | sha256sum
>> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
>
> Oh man, I've got deadbeef!
>
>   $ echo jk35252822 | sha256sum
>   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
>
> What could it all mean?

Sorry, but I have to admit that I completely lack humor receptor
cells.



