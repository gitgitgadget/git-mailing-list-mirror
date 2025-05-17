Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449E15B971
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507005; cv=none; b=GWRk/WVfS25rsoy/JKSkmzNdcW+5pKDj3lPnC3SP9iSJU2Iy8LNfljUakbGwQkTlpqm+An2kVkEqkQCG5xsy2heni4ZDhB78ngYAbWl5x/pVqBOYzQtcnq9kqRVV4REi7/iGxodcNgBZaZbaEezvF3gAAjwaQrVioMgQF5s/ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507005; c=relaxed/simple;
	bh=YVVv1F0n4GVmtjneFSvS9XarYS0u1KiZQ3l4LRs0aVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1QgtVNmNKf0wQ/ZpgDi3JKTbVuz6v5vNRIPzCClTAG31EoDMmKcyvQt9vHwNiWhYVPIycCjgmG1ImidQRH8W7R6CdX+1Rdq6qPhYkLucTNn2973Cp5IRcoBCnyqMwju2HbWr2XMjyTNmEL896BvZfx72hHs3t1w3G3XwDxSmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hBDqsqUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mb2fBoVO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBDqsqUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mb2fBoVO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED18025400B2;
	Sat, 17 May 2025 14:36:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 17 May 2025 14:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747507001; x=1747593401; bh=ow+CD+jBDs
	ad3Xp11K6Fh2KCk640HC2D7Ch2JMx+S0g=; b=hBDqsqUJQCQAo/zPM9p3YmZMea
	k6ASp81cKhD2MBWTJbRGsRI5dANpg7hTY+hqjgKx9xCZ3gbIdsCuzczZ+EVOOiZ3
	SyUL79uxQHMDmzN5zr9bHGiQ3dD0ik8XKW4TFTF2LLlQBJnEyeDhVu1+pcENmsZa
	NfT+NG9TMEqZGU4quzVs32yC3ZprmAZ+5Dh6Vh9aki1o+Ly1OrFwgHi07UM4x+SE
	wUYDZR+xSnOF4wak0Ge7TwqI1zy5FVFgEyqsm+eac6kBkAz00l0jlcR1Nv9O5zwy
	cNy8ivZMGGKC7gocTw5nsDKaiWgGp8FvFE7Yo0Rs9vroFzVogI6VC34jpdPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747507001; x=1747593401; bh=ow+CD+jBDsad3Xp11K6Fh2KCk640HC2D7Ch
	2JMx+S0g=; b=mb2fBoVO7UB6xsRBdiQdlGmQMFBQYN6V0zghBLJW4iVJfqB0gpi
	uKP8OoV4YXtUnSFDeY1BNPpmb/hmPyaMFQ5D2aQxA1KTb1HQNZYdF8SberOt7WmE
	+vpt/PzC1wLtnqdq9YgHCGRjQzEpqaWrYqh/PBMmRxP8n+8iGzjCe5/WyEJ34+co
	xtOwHoRCiXATj8DF+/gCb0vzH0eMw9gA8MSURyjkos2orsKoETzEgubjNBdKukSI
	KpS4ztrVAZHSRD6v36XcIv3QJrOS3gHNYJahf8Mz5mnxnA0kwIvePfrflHbG2ck/
	HR6jYFfzqLi1o2sVyP8GW2bnmIX+5B187aw==
X-ME-Sender: <xms:OdcoaBd1eN_qtmiQPToTaxCE0pJPEdhIgc8sOpFnh9wf9KlkiGecOQ>
    <xme:OdcoaPOgpor5vtP33fQt2mgaPvPqVxIdhrWq5vvvAtHnOZEOndntd0BU2wQ9BxC6j
    rLl73QCuZcrnYRa-A>
X-ME-Received: <xmr:OdcoaKgx8c4jgdDhZG3aP6-C2V7CAcVr70hTfLAQvsGc9dYJQ9hRbC9cBZUPzKr40m1PsWzRyAlD-M6_XcIIDIXaub0hSVeucp_0_rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:OdcoaK-AEotk1yyae4dbTTk-i3w5S4Hk-mmUTybax-QEOBM4cHelPQ>
    <xmx:OdcoaNvIFXb1roHOHOEQMgA3LyP1VasvIZy3fZTtk-UtzepUCytT-A>
    <xmx:OdcoaJHjhW6XFkuefUKuTBrshJPsCfs9_5E96ndvdx9OZ3ycYhYEkg>
    <xmx:OdcoaEO8v1MbrgNlCjdlzmykpBNIIcrQQcRJg8jsbqT1Shs7ujmxrQ>
    <xmx:OdcoaG6a1h8u6ojfsOosynrlaO-JP0IyOpEBtSdtMmhJ5qB07iqUi-yq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 14:36:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question About Sorting the Index
In-Reply-To: <1008ijb$6j0$1@ciao.gmane.io> (Jon Forrest's message of "Fri, 16
	May 2025 16:43:37 -0700")
References: <1008ijb$6j0$1@ciao.gmane.io>
Date: Sat, 17 May 2025 11:36:39 -0700
Message-ID: <xmqqfrh3qe2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Forrest <nobozo@gmail.com> writes:

> P.S. I'm trying to read the Git source code to get a better handle
> on what actually goes on in the index but this is taking some time.

Depending on the style of the learner, I often recommend reading the
very initial revision of Git, i.e.  e83c5163 (Initial revision of
"git", the information manager from hell, 2005-04-07), to quickly
get a feel of what various pieces there are and how they fit
together, by doing

    $ git checkout -b initial e83c5163316f89bfb

This would give you a mere 1244 lines spread across 11 files, which
is something that can be read from cover to cover in a single
sitting and see how various data structures relate to each other and
interact.  In the past 20 years, we of course have added features
and auxiliary data structures, and the various details of the
implementation have changed, but the really core part of the concept
haven't drifted too far from the original.

For example, the fact that the index is first read into core, each
entry is represented as a cache_entry in-core structure, and the
code accesses them via an array active_cache[], and that array is
sorted per pathnames, haven't changed.  In the 3-4 months that
followed that initial revision, we added higher-stage entries that
are used to represent a merge in progress (together with sorting
rules for them), and later we added prefix-compression for the
pathnames, but the basic structure of the index subsystem hasn't
changed all that much over the years.


