Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A942D7814
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765961; cv=none; b=go17aclSSucki85XJZRCR5YG9RTLLiIO2Fd4plM/XXLMFrtiEB40UdZQnzr3WPzhPVsTd/E5+4aW7VXoLt3h3awtrzvf9KWTLsS0W0HbtEUN+IFskjoXF6HzSy8oxq3lbfzySJI0zkpSq+CzvBaXwvFvVkZd9QsM9D3rn1PsqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765961; c=relaxed/simple;
	bh=ZrQ/LeGcRvNHWXK+Amn8oa0sUv8C/tKhGVikrDWsiJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onR609k0O/Re/lw3N6TGCWMhjTtfNd94hUXHrKwcZB0N6m54qQ8YrEyG1ZPwlSQeDl7sbNtFQf6i9xb4lY2n8/KK9rJn8gUbeZ6r5D6MGuvCDxXeUvtFA9oe2N0bN/D30WNmTBsEeIU6qU2g9SYwk9thj4QhT2txGhpYGO+DtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZieGaJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QyaZ5pp2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZieGaJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QyaZ5pp2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F5297A0120;
	Mon,  6 Oct 2025 11:52:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 06 Oct 2025 11:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759765957; x=1759852357; bh=0wApmaO4we
	UF4SrVEc+o0sylAwzRzAekkzvpF639G4s=; b=PZieGaJ/tKyhqx22BpojV9dO1m
	Ksb1OJ1Pjfz6pkLPyDfzk4eantdCezV0NN3u/hq3pPEyo5817xFYIYhqgb+P6wio
	vANrjwPqIWC90iKxTWonEHy9/qpvwsgWYJj3eqD3yf1lRL2/jhT4kAJ6Sb1HOnIO
	5BIUZOIcW2F+OOrjZEqkzJJKHmGkalv1M6wM9MbrFYszS6Hd6mhT6eBdVLFIcgQY
	rr8ZKcCi4GN+MAs+H5oR/cOLg1fs1L/dM9JpcZfrfOf7Xw1tUPRtO05+ca0h0Xkv
	tSzf/cDFMSKK0O+wWXYq7RoB0XN91BOrfZHIlPUjiqWLHIuu5Iui7wVnwJiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759765957; x=1759852357; bh=0wApmaO4weUF4SrVEc+o0sylAwzRzAekkzv
	pF639G4s=; b=QyaZ5pp2w4nUYkSdTgu6cuS16XLG9aKgG+xBlcIMjM34YWByIXg
	wKITaqNzUpFZ3pPH4YMlymaV4Dpr0sOJ6mfSWrOTtlBwdIr0I0zuOVkQ2KfqZ30q
	oXbCcfXWRq4+w30gglr1CclxnuNa3yAkMeB/toPHrWFVrTjavhAGtO+VRAFZITbv
	txk6nWdNNGo3+EYMPVw2OfJen3UjMttFlmCxJ5BdRcv0bu72ekkjP7vJlC8b6yRQ
	5sbzM2zv2behW27dSAU7+3dYfHqhRgS+EL67eydE702zBkv90tjjRWASy/AtmAni
	cBv53xmKIrUgHr5kNVvXo+HY0MFzU7OSdlQ==
X-ME-Sender: <xms:xOXjaAvpTWrHdseZq41IYpIES1uu0fMqYpjKelOTM8QLrAZK0nOmMg>
    <xme:xOXjaMgWGTFlNhVA43F2JKS903eLfViKStMIgCo3Ew_k2XfBeKHWp0eV8s6sN5B3B
    VSAtx1x70WQSe7kovAHgkcay2eh8ukSvr9eyPexM-R-w5Axaw5IJQ>
X-ME-Received: <xmr:xOXjaB8hE3bOKZJLJSppn4iOh4Xfxhwi5x2v27OUXITVSiOG68AVvGe7mNVBEUU2w0v-7NqePb5KFlajTiFndWGXr7Z1qsCuDMQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohephh
    grnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehhrghnhihouhhnghesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esshhighhmrgdqshhtrghrrdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:xOXjaPsRZFWcloBSml8yejAK5yiKkIB08bDG7_3cCe0-twR0PDkJrw>
    <xmx:xeXjaFq4ZalOtByIKUhqXXFxewxyK1_ZxYtPlIL4bw47dKgqQzAyWw>
    <xmx:xeXjaDpYoGOKnIS_bb6jydURodZFno4LGpTY5sWZV5hHUuGEyxTDhg>
    <xmx:xeXjaEb9xJ5S0BrqoIPYRnB9Ny_04Aa5yu9nKHJtmhHN5NOkGGvNig>
    <xmx:xeXjaMywy2jRfyImhb5yo6CwIgHKhcqqr3wLP58HgiJfeLBQbkG5JEim>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 11:52:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  ps@pks.im,  Han Young <hanyoung@protonmail.com>,
  Sigma <git@sigma-star.io>
Subject: Re: [PATCH v=2 1/1] files-backend: check symref name before update
In-Reply-To: <20251006004639.GA1462753@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 5 Oct 2025 20:46:39 -0400")
References: <20251004144223.23436-1-hanyang.tony@bytedance.com>
	<20251004144223.23436-2-hanyang.tony@bytedance.com>
	<xmqq347xrp5o.fsf@gitster.g>
	<20251006004639.GA1462753@coredump.intra.peff.net>
Date: Mon, 06 Oct 2025 08:52:35 -0700
Message-ID: <xmqqtt0cqb7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> This leaves the readers wondering why refname_is_safe(), which has
>> no direct callers other than "git show-ref verify", is sufficient
>> for the purpose of this particular validation.  All other callers of
>> refname_is_safe() seem to use it only as a sanity check combined
>> with other criteria.
>> 
>> For example, refs.c::transaction_refname_valid() calls
>> refname_is_safe() as a small part of its validation, together with
>> check_refname_format().  It also refuses to touch anything that
>> satisfies is_pseudo_ref().
>
> Yes, if we wanted to add a check here, it should be doing the usual
> check for a syntactically valid refname and falling back to
> refname_is_safe() only for deletions.
>
> But I'm not sure if this check is that valuable. We are in
> split_symref_update(), which takes an update to some symref and splits
> it into an update to that symref's reflog and a real update to the
> underlying target ref. So we are not checking input to the transaction
> here, but the existing state of the symref on disk. And in theory we
> should have checked that target already when we wrote it.

Yes, it was Karthik, I think, who pointed out in the ealier round
that the set-up procedure used to demonstrate the issue indicated
that it was essentially a corrupt repository doing an unexpected
thing, and I tend to agree.  What you wrote in the previous
paragraph matches the reason why I questioned "is this enough?"

> I do think there are also some gaps in our symref target checks (as well
> as a few other spots). I have a series to fix those that just needs a
> little bit of polishing, and hopefully can send out this coming week.

Thanks, looking forward to reading them.
