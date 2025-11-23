Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1BCA5A
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763921216; cv=none; b=XyvoK4Wh4FrwmWvHbfo31uAyRAV5Ftvytoq9vkYIM7cXZidPndEnFDo6ySbmIvHLoP3FYdNyDfC2AGidPAQHurgRjHBy0bWM33LGCQsClFhtokwq/+DFEjsIYDrfzIzleAPDU9FTrwf3Tbikj+rZcdWNyEz3o8h+aS5OkpBsz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763921216; c=relaxed/simple;
	bh=5KZy669hGltUJdLEIbX5vC1W1wvhvDhl7JsT3nnB+9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AVi01zyzeuFVVKap/4ZKO1DaMQwCL5KBmd2SrYVSncWRGu/sSAixmQN1B9T1yOzTEnhtGtRMvX3140TWpuMddvrJuHSZx7p7DpBD/snpBe85jpGglYZo53aiOCY8Q0TXkn/mi/T3JbGMI4yDZWd8uMD1CUbhDlGgUvcQqUbQOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IQxWfxG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMa7smtJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IQxWfxG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMa7smtJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07E1D14000BA;
	Sun, 23 Nov 2025 13:06:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 13:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763921213; x=1764007613; bh=3eE4aiD0I7
	hIyw9YrM19pKx2S4Z07F6QS1u3sUWwofo=; b=IQxWfxG9lh4+4udFZwFTX9bZ6Z
	EjLP2PCcTBJ03WYtcQy7dEm1uGsqqdpkPhWn7bmYKBc9xAA3EMrqJdrN7zFvqO07
	SGFGMNMkgogViNK2qHT34nr0v/KhUgKDbiSHqy+1aKWn1+vbDXObMXjSb+/ZcLC9
	6I1XxkPgXJLmqzJATOZaXLmCLbiI9oY75XhUwdLU6qK0uVtq1zFCIg04M0gQkT6/
	7wtJmF6cowxkkimt2KhnZjrwdOuVXk1+mURQ/3HGt6pFynZteBTzM1SxOu7c1cJY
	5qAFILkwynIJkIfyl7SebyJOgf8oHs3kr7xvQLrwdM066o/cPlvrWb97woWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763921213; x=1764007613; bh=3eE4aiD0I7hIyw9YrM19pKx2S4Z07F6QS1u
	3sUWwofo=; b=hMa7smtJYP2vZBlAM6E3vrXzEAYeGmcEnwghaHw4xyDVr/TgqUc
	osA229KvewbSV8kz+DS7jK6XoLPfrEdjpyRQ+fTsBjKrYTCMmGzBAlxqyXYNSUfq
	26+N7qrZRvvzhERJ3lToUaiSfc3CanH8QKV45xaQhA05bWEpbNk3Yq8iOStPNNgi
	jOv2LeIXpgTd4izQ5UUGW2hatQTkUuBCcSJ4RiKR0xnMAaSKLm8xpF1S4/6U0oKk
	sf/+RXD5aCChA5GCI1LUfhTMVbJLZj64tVtWS8o07VRv9rcOOYvedwV0u2YMN4W3
	+ZQpDLLVl8vykQWDJ2GzW/qudUsmiwmhiQA==
X-ME-Sender: <xms:PE0jafsh6MLOIJ0NrSK76P6R2B-QpMt3HAsLLgF1mva_G-9t0qf93g>
    <xme:PE0jaSv-j4f-Vec-Ze02ge9I5jlKLKCuUSCBTXesITmOtm8b1F20whMHi2HuB5MT5
    oA3ULpmtYQpFGPPCOtBq869KjFmUqrgq8c1pmjzzsyIYz_4wdygqoA>
X-ME-Received: <xmr:PE0jaVC2kZuN1TCTu4zgC9FG4Pt52RBd5-fEFl2E7BZwphcu8Nse6DL8Q1k7QJCPcsLtpgEGgM8ZWh5YUF2IeO9J5T7e3PIoYMwq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeigedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:PE0jaUPuRSc3mQxi1y60AnC_BvbDEa__1lelA7q9suZdRydWCXgxWw>
    <xmx:PE0jaex4T5SzZ3URXFfNQ9C3vTPMDwfNM2-ugqbLOTD7K_WMHQsaGg>
    <xmx:PE0jaUXkVwCm-QusUOED0zv1kGr8eTXSgBs5iX9woWtk48u43Qenhw>
    <xmx:PE0jaQOL-NVojhUrPzGQJXTmkBnHkYU0F7ZUtLaNu4CsfQ0gMRU9hA>
    <xmx:PE0jaSvNvb7IvMA3St4HQH5FoOXAxseT2fUUuCzJixBR7Rhtkor78sE1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:06:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
In-Reply-To: <633f4d92-c258-45a8-9d32-116c94838e68@gmail.com> (Phillip Wood's
	message of "Sun, 23 Nov 2025 15:51:57 +0000")
References: <20251118091127.GA4175601@coredump.intra.peff.net>
	<20251118091218.GD529192@coredump.intra.peff.net>
	<ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
	<xmqqtsylz2xh.fsf@gitster.g>
	<633f4d92-c258-45a8-9d32-116c94838e68@gmail.com>
Date: Sun, 23 Nov 2025 10:06:50 -0800
Message-ID: <xmqqh5ukzkqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> All we need to do to accept a single minus sign is s/while/if/
> ...
> If we limit ourselves to accepting a single minus sign then this can become
> 	if (s == *ptr + (sign == -1))
>
> so we need very little in the way of extra code.
> ...
> A generic helper to replace strtol() that takes a length rather than 
> assuming the input is NUL terminated could be useful elsewhere but I'm 
> not sure we need something that complicated here. I do like the fact 
> that overflow does not cause undefined behavior though. Changing ret for 
> "int" to "unsigned" in peff's patch should fix that.
> 
> Thanks

Perhaps.

By the way, an interesting tangent is this.

The only reason why these fields under discussion are stored in
textual decimal is pretty much the same as the reason why the object
header expresses the byte-length of the payload in textual decimal,
i.e., to be independent from the platform natural implementation of
"int" type (e.g., endiannness and width), but unlike object files,
the index is a local matter (we are prepared for the same directory
accessed over NFS from two platforms with different endianness, but
we do not recommend network access to a repository in the first
place).  And a lot more importantly, the total number of the index
entries contained within an index file is capped to 2^32-1 (the
header has 32-bit count in the network byte order).  The total
number of subdirectories within a directory or the total number of
entries for a level of directory hierarchy that would form a tree
object from a slice of the index cannot exceed that number anyway.

And thanks to the design that made cache-tree an optional index
extension, we can make cache-tree version 2 where the in-core
representation is exactly the same as the current one, but only uses
different serialization when writing to and reading from the index
file.  The new serialization can use 32-bit network byte order
integers, or use our own varint.{c,h,rs}, to record these numbers.

A version of Git that knows about that extension could be taught to
read from the current cache-tree and convert to a new version, but
better yet, it can simply ignore the current cache-tree data in the
file, and write the new version when we do need to write the index
out with a cache-tree.  When such a transparent auto conversion
happens, one single invocation of write_index_as_tree() would become
more expensive than usual (because the last invocation of the
current Git left cache-tree data in the index and usually the next
invocation of Git would take advantage of it when it writes a tree,
but a new version of Git that uses the v2 format would behave as if
there is no cache-tree data in the index and build the tree from
scratch.  After that happens, the cache-tree data in the new format
will be reused and things will continue to work.  You could use an
older version of Git on such an index file and the same transparent
auto conversion will take care of the transition.
