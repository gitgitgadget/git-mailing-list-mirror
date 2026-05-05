Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82037CD54
	for <git@vger.kernel.org>; Tue,  5 May 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985790; cv=none; b=G6I1C24U7jl0pJeTrdRpAKoxqp5DfW2YdY5Q5N7/9YS8QMBSrVNuS9twQPFCuK2pftIx8Rkzzn35XZcYeCto0JzcgWc5srGGq+mNGZndQR0gZGV+VijG1Hjr56yENmMjhGDEFPp77hX3b/LteMZE1/nQLPj+cxoIYK+DZ/KOLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985790; c=relaxed/simple;
	bh=Zdtsr9/+Fyv4Y57vpcIP+1c/1OAd811g/eaTgBF0WGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGGnyOj8trsQ+4FAzIm+8kie4eMXoPJ6YuaCTmfvwVwLMg2oeuOGIMJKOxBIhn+phoOvRfkcXGae1S5jBTx+63fOR6GSfnbM+au5+PygOQFc+Z32j9AIiHPnK7jMEoiff9pkbfmqa1B41QxWerlhpilaa85p06uZZn8jk9QTMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PjTKa5NV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etOSOQUQ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PjTKa5NV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etOSOQUQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A7CB1D00117;
	Tue,  5 May 2026 08:56:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 05 May 2026 08:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777985788; x=1778072188; bh=gW7JmqCHoz
	3dYlgyUErJP10NEvaywE/XJuW3tuBwZyU=; b=PjTKa5NVyefZzdACbaMgcdd4f8
	iRu8smiUrheZ6QypA5j1eOkG4qYK8AeUDfMv5RmKC+nnOFe/GaYPV5X7VNmhQ9YO
	q6JA15GCDjmd1d+vsUx2ZrLRmUoJt1s92ByWgOLNTmYH/LcQ7Hwk+eX6BwhikMXy
	xYHlQIvz3ojre9JPmRp1+y4KkJbD60rsYNIJhHKqAVIm3cP4vgo8G6rjr6Ri0hW6
	FwZyMh3ffafjSYXTjtAs2oTeMbhs6r0bgBaDnqnuKHJOCKVI8LXX0q2336ja3dbA
	P0eiyHBLLrfjDA56x2UTWQqDO/GOGBeQERSzVCHH1+QmKMWmhHpzTCEwz1qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777985788; x=1778072188; bh=gW7JmqCHoz3dYlgyUErJP10NEvaywE/XJuW
	3tuBwZyU=; b=etOSOQUQvjr6dVLBPX4LcofUIKQphAWlN/7mirLO6BJj1tvikti
	gjbQ0KuS9NiOM/oxXjQNaWkqzAt/GJCd6f4MFIVsMm+u2A7gR0TQsfh/V1xp6LGH
	wdAxUaaJnKHCsrr2XjB+aYQvcxPgEApFF2irkiPqlxHIAnHpiEt83kKO7J78Py4Y
	l50RqpL9Am3oe8ORlbdEugm9shBasj8RK449ot1IRrrh+VsqfYe+cpuCoenjqugz
	utMP9NUqkhICLIEhFK3UrCYBV56P1kJFijZJvysgwX9asbUIkXe6oxPF0WzOE304
	npFKzAaGji8R6gcnaUuBIlRhHnOHsq+a6kQ==
X-ME-Sender: <xms:_Oj5aaGEyJVIM2LtyXLieEq4DBxpgmar92b7sgV1kn8r4EsDhdsqQg>
    <xme:_Oj5aSwWx4EMqoRE-RRKF9Mgbz07ZbgLXOWvA0E5dY1TNZL1tFtFGf5clvObArbTo
    kKJyI8IehQ6DYlF9SwwGTxLlWzC6efqkaLvuDgPn3j3DyDO24b_kg>
X-ME-Received: <xmr:_Oj5aRgBvuxE86GI68oUJ0iJvaG-KichHoNUxcfu9NSwNHcbWO3C7Nyg6_VdtqtXJHz6f-ZFE2cSKWCrWTuIoFtrzWASGPbJMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrshgsvggt
    khgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_Oj5adyKzDwe-m9Fmy0_dC2x5boTLhzNNQ8N7x7AgtVhKOgB9ByUUA>
    <xmx:_Oj5aUJDCt2Pf73eF0O2V2p1TfytFI7IL9vZDKS4ZHAzaMIK-949Rg>
    <xmx:_Oj5aURwNZ0q-L3fZH_x5AcZorZvoBYRjb4Z9lKuxK0_sjGe_-7MRQ>
    <xmx:_Oj5acruINelRX7uquAGYiau26i6SG6plkW0VauBuskaXOw1_t4g_Q>
    <xmx:_Oj5aYfqOW66AGajdzkHgDPolay5UDVPUttJQYxMUU_JO5aSqeELF3uc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 08:56:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: Question on Clean/Smudge Infrastructure
In-Reply-To: <079201dcdbe7$162d5430$4287fc90$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 4 May 2026 12:57:21 -0400")
References: <079201dcdbe7$162d5430$4287fc90$@nexbridge.com>
Date: Tue, 05 May 2026 21:56:27 +0900
Message-ID: <xmqqzf2em2v8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Hi Git,
>
> I have a edge use case that I would like to ask about.
>
> Given a directory with a large number, say 100, text files, and a few
> scattered
> binary files - specified in .gitattributes as binary, what does clean smudge
> do
> with the binary files if they match the filter specification pattern? Are
> they
> ignored or processed. I am not sure that passing binary via stdin is
> necessarily
> portable. However, I would like to be able to explicitly ignore the binary
> files
> in my clean/smudge filters - either by doing a copy stdin/stdout (as I said,
> probably
> not portable), or sending a non-zero exit code, or some other mechanism.
> The root of the use case is that the directory is subject to significant
> changes
> over time, and errors are sneaking in when people forget to update
> .gitattributes
> or name the files incorrectly. I would like to make their situation more
> stable
> to errors.
>
> Thanks,
> Randall
>
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.


* Passing binary via stdin is perfetly normal.  Otherwise, it would
  not work to set "exif" as the textconv filter on JPEG image files.

* The "filter" attribute is orthogonal to other attributes like
  "text" or "diff".  If "filter" somehow paid attention to
  binary-ness of the payload and refrained from working at all, then
  it would make it impossible to filter binary contents.

* If you want to apply your "filter" attribute to a subset of the
  files you have, you need to sift your files into two classes, ones
  that your filter would be used, and the other the remainder.  And
  they give your filter attribute only to the former.  Perhaps you
  only want *.txt to go through clean/smudge, and then you would
  have 

    *.txt filter=mytextfilter

  in your .gitattributes, and in your .git/config, you would have
  lines to speicify the executable you can use on each system.

   [filter "mytextfilter"]
	clean = ... your system specific command comes here ...
	smudge = ... your system specific command comes here ...

