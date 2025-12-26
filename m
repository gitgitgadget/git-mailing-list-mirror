Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BA17A31C
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766715115; cv=none; b=QTZ8AeV98ra3bDYRAZ4TyabRM0RBUnmRmy9JvIFUoI1HBUVfClseJxHs1Z+dQGVI1Ly8H+VEB4Zy7cSN6TES+elXYyycgEBSdmgPHx/Cq4KrpD45QE2gcaumCTdokTppQ6+AUERMzB5Z2oM1biZ1jMqS8DmwHBA9tX0zLpvNUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766715115; c=relaxed/simple;
	bh=bziOUsyJcpQ9x+bDm2+Glf9CXE/CfPSfPuHP7oG6+uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFxPGI5O9CL1+gZJDdzwlDJXwI8LfHNRDL0oTw91C+YPGl8w6ksNIXQW/BYXq79ATzZv1pnbhir05bAPZ7Oj1T0r8NdB/xvLm0McPe5VHe9Mynbsr9rTXDqoarDKUwwLQSpsMQuDYwoeYPoSvJdkGedD9OUlX1HgpAgYxWhzR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NOXlXDBw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ertdwgvj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NOXlXDBw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ertdwgvj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C362C1D00030;
	Thu, 25 Dec 2025 21:11:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 25 Dec 2025 21:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766715110; x=1766801510; bh=GBuVjwIrEO
	WtGNXDhnvZT+tJh7zuZAeGjYl/DXu9PbI=; b=NOXlXDBwQUCzj8Txo3yk/ScYyN
	rs+lHAztxOfqyNastuBD0hdB+Fs8x8Oq4BrSUvD3hTVTVwgDb2tEow/rkd8y9ziR
	+ZlthCF0uBIiL/gPE5pXGXXXr+rdgdJkAxinwKFWeC6W+m5IrJIWSXRiFSijoF/p
	8NNipd6EYfwVQrHaemuB0Rki6t952fFMcvLxOsrfAw/cbrCiGUcT0zjCOuwndN4u
	65o6nivpvhDWeggLku6ibkRugsIyqcJQPC8fqiGSkScK90OgT9Pd+C9f70cF9R3B
	KGQcyrh228dkcbE1Z6udC4Pm0BpGYDqCGbOLTuXB5wPuNjGiPXZeXncBCl1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766715110; x=1766801510; bh=GBuVjwIrEOWtGNXDhnvZT+tJh7zuZAeGjYl
	/DXu9PbI=; b=ErtdwgvjZn+WaXGIvfOwYQrqlrd8YZDPKiOFdqUJn4PYRlAsOEj
	qcl2kOs6tuThm4oIo2/u7IYPj/wG3BAtyNijXdd1f3X8mgfWBDue0u0HcgUdQVHm
	FZ6YpnwDh9Tz4WrkN7ihYcxhie5n/4PDirhwpQYNpWJ06gEKZmVAeXcDInMbJ8vB
	vfTrwjdlr/w5jjBs5DbEuBkfntAFSZ+NfAExKKAhxQ8AYPhrWkvAvWJmMWZii9ZT
	K+sm3mZ+U9nB2Eo+D3bzEDkASwtkt4OzrrnI5c1mkuVD1ScOhjZrwWbjz+w9z/t8
	PAFMLshlIu9oIvUZlpEtN1ao5IUW7YMFLUA==
X-ME-Sender: <xms:5u5NaSC0vfvaeKBzGXHaEhvCSReAgBDPaFc3CDVrWE9jEhO_7BN1jQ>
    <xme:5u5NaT9p7B4u2B_dIXsnpSGNk7ZMTbLUoeu9XR7Y2XaW00O3O71YOWa9rmwOMR9cE
    dpjR7p7Y4xvaq8iaiSW7pxGveibTMPdnhxxUNGDByoU3uTnd8SX8h8>
X-ME-Received: <xmr:5u5NaS9yyW2Uc-ut51C8uUc0DeSx_etugTLBILe2jr6wuz-1tl3NlooWi3YRlrxmrl526FCTBrMt6MHnFCbP4zlAR2cFZzYtrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeijedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5u5Naadbeqk5ZXfp0hkx6jbGH4HoWNdIQ2dqVedWnuQ5NHanyxIojQ>
    <xmx:5u5NabGLxtESDOIAbla30DaEKTJiYOKr0ljMZc0ByyYkvy2SRzWODQ>
    <xmx:5u5NaYcByALbY43eoZWQmIYzETPCsKlJPNKLXI8wLsZi0iZXErLoiw>
    <xmx:5u5NaVH6zshSccR0z4j5P235XioNrLNyQjUYT2Neovzh6zeMJ96RZQ>
    <xmx:5u5NaT94o94NOf9w_InpQEk2hMx39HuW2IUCK-B3r8rnooxOBqN44MGZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 21:11:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Why git branch --show-current ignores -v?
In-Reply-To: <xmqq8qeqm1tp.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	26 Dec 2025 11:09:06 +0900")
References: <87h5tev918.fsf@osv.gnss.ru> <xmqq8qeqm1tp.fsf@gitster.g>
Date: Fri, 26 Dec 2025 11:11:49 +0900
Message-ID: <xmqq1pkim1p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> It looks useful and natural for "git branch --show-current -v[v]" to
>> verbosely describe current branch, similar to what --list does. Is there
>> sound reason why -v is not supported by --show-current?
>
> The "--show-current" feature was invented merely for those who
> somehow found it ugly to use "git symbolic-ref HEAD" when a user
> wants to learn what the current branch was.  If I have to guess,
> nobody thought about it as a way to get the same output as "--list"
> but restricted to the single current branch.  Hence nobody felt the
> need to support any option that the "--list" operation supported,
> including "-v".  IOW, nobody shared your "It looks useful" so far,
> especially among the people who knew where the "--show-current"
> option came from.
>
> I do not think anybody terribly objects if somebody teaches "-v" to
> make "git branch --show-current" more verbose, and other "--list"
> operations in general, but I suspect that the exact contents in the
> verbose output may have to be different from that of "--list".  For
> one thing, as "--show-current" limits its output to the current
> branch, the two-place indent "git branch --list" gives its output is
> not there, and "-v" would probably not want to add it.

Forgot to say something much more important.  

Commands should complain when users give them input that they do not
understand.  If "git branch --show-current -v" silently eats "-v", I
would say it is a bug.

Unless we define that the current output is already verbose, that
is.

Thanks.
