Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC93266B72
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765583898; cv=none; b=JCZ+rB6T0qQFnBax51RO9lht1A0gmaDqmshoQO8oh9bEFMydA3rg73UTgOf1iyoK4NdWoLHNCrofQvQNG0xfuDmpMh7M99QH3d6cZrTPkkeL42de0UtOLwlQrlUUAdIFDpSXMRVewrFlvlFpSQrKwlfu9l5jtyjNrRPA41lO+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765583898; c=relaxed/simple;
	bh=dDNevxX0iO1mrkVGgUUIJLTxtH6miiTtyUTaXh01NUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayNLO4ppLrQmoGENWeza2R4+9K32jYN6/5Mfc+xfxGGaEtvIRIAITCQ5kcK/L61Qt4nHHqFjQm41v34rpsA0qDY9Od78MCNfOvfKTyHLmDbFcpFt2+i+pggy8/7mv3KBXuW20USLCmJtN+dCY7QRrdnkITYJVtLRGlQJhoILF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LU4lSBCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Azqm598o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LU4lSBCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Azqm598o"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D9767A00CB;
	Fri, 12 Dec 2025 18:58:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 12 Dec 2025 18:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765583895; x=1765670295; bh=AEyUUN70/3
	bVZrvgi+uIA36ayNwGiXmnoEQ0KbuZYfs=; b=LU4lSBCnX9oQ3sANvCNkFvDLIw
	X2+DCg91GCl5SH0yp03GT+EdQp/GApoRAbJmM+16zhxkKHnk1hyymVB46OFiwp4S
	99efATBPTLgwFiq4XsRivkUsxWCNw4OKT7WvCISSZO8Ap/ijJ4VRfnqHzHwmcxQZ
	XjjqrDpesI+GZpbxbno4YV8650MRlFXY5A0Gli37kYEFNYusmZ8Khi1M4rSf2fis
	Wa9jStOGCrcRDn0zEsodbPXqu376HQXv2YSV8FvEmMS4wb8b1b5s1NuFMmjX+4C+
	YH9Untf87/gpcgEmCUaS7Rx0BCU56KisgFbCnVWEL/vkLYbig36fIDQSoK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765583895; x=1765670295; bh=AEyUUN70/3bVZrvgi+uIA36ayNwGiXmnoEQ
	0KbuZYfs=; b=Azqm598oJQ1C7ns+WGkgMi7y6o2nVNgvBP9GQY4xRTvApBPl4PD
	4KACqSUYdJo6IR/7uD66MM2Pvoiy/KzObWlbjpJZC+xNUPHa763AVWLSOYew5RAk
	AFFRswXQfM4TZckaAjjguBvf7ZM6/q4Ajt180iTgkIkRVS3MCVv2W1SBF8N+zBEA
	DmhnyF2J9rMZTlUC/iKxdINJQCXTashE7VT3afrxEWDu6+R1C7GXEwS8ibzLS5OO
	866SbVW0JVNbhJ0FFOm0S2THY+tmw45GqTt/QVRzRhZTy9O6dgWk5XfPlJvvy/hM
	2GC3xosIZlkq6P5lMZrITGlg3jWhWgj5/Aw==
X-ME-Sender: <xms:F6w8aa-wcfkDgtcxx5J3WQmrNTY9kP_aIzLqemQr1TkZYO8Lbjjsmg>
    <xme:F6w8aRlbphjMHmDkApjsrKNaTvFcbrWyezRFF5zCXGJ9oLBwD92wESJu6BHLU9FPi
    RHt6AiJv1sgvR9cRLUHHYdbbJBaNUgftE2pOFrp27oCEPubm3q7Yw>
X-ME-Received: <xmr:F6w8aYXSy0Cpo2rXJMmi1O9kebB0RCiCntMrX7n9LY1oju6lI58T8yDz0iaryrE8rK7qhpJUTTp1E8vi6VfcsIWDmYmuniNrWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F6w8aeFKKaQU8VZKSmOm6S8BER6Fz4mBvH4jDGzIptO7OwVR0TsCtw>
    <xmx:F6w8acfEXFkfv0etfE-hfD1C-biqNLb2wsMNRL1HK_iMP60aUzuadA>
    <xmx:F6w8aXLsumLetzVovPf_IssRRNxrh70Q6qD5b7vUpAAKJLr6m2Xe3Q>
    <xmx:F6w8aZFgViXZiah_NnrGFZrCVmtXb4Zk5vjZwELUnQEGyLZ5d2voiw>
    <xmx:F6w8aVWwPHpGY9Iy0m6oOOe-mEjnlyLEZazOXTSqt6RBch0tBOfqEH87>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 18:58:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
In-Reply-To: <e5hsuevw5t37yt3zgp4hhtunusdyeg2lkph52pj4valpmlyrdt@7teicd67atbj>
	(Justin Tobler's message of "Fri, 12 Dec 2025 16:36:15 -0600")
References: <20251209225820.2861276-1-jltobler@gmail.com>
	<20251209225820.2861276-6-jltobler@gmail.com>
	<xmqqikeegz8q.fsf@gitster.g>
	<e5hsuevw5t37yt3zgp4hhtunusdyeg2lkph52pj4valpmlyrdt@7teicd67atbj>
Date: Sat, 13 Dec 2025 08:58:13 +0900
Message-ID: <xmqqa4znb6cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Just FYI, some of the test changes I made here are reverted in the next
> version since Patrick suggested a better way to test disk usage output.
> This should allow Lucas's changes to apply a bit more cleanly to this
> file.

Good.  I expect that Lucas's series would also be updated,
especially in the way the nul-delimited output is tested, so we'll
see what happens ;-).
