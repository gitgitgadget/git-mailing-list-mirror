Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F6191F62
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951030; cv=none; b=B/12zug+yJc4UIKe/IRoRDo6BCVciv0IzkxOwEr4qGBwL6wYeeROoP754t1rkdaYQ+tB00i0z1XqfiGmkEkQbVBiZAM4M+xyw5lkTuF6FuLa/wAYe8oOh7Q0Ikkes6VC7U5GfqQ/mLZ+OrtzbiKokODN0OpDVCWeC/5G7GPcuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951030; c=relaxed/simple;
	bh=6sPDCVGV53YJV/zkaNtdazrPbg7G1L78SJbTMNmRsio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJQVgt/p1hz0cIFj7NQHreYYiMywzTPyducdYHJ94IjyrcVwJfMzWiwXj18F6nni0UrEJqgz1HzOCK0+fLNZX7aCWZYdSyO9vuiGq2FD42IIDRoh4DpuNbKFtGo33skR/SmBvHbO9x8UAY1U3C3IOSctVTvwh57W8aH5Fqx9K/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DveS8Lk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHVnXK4y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DveS8Lk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHVnXK4y"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A36FC25401C7;
	Fri,  7 Feb 2025 12:57:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 07 Feb 2025 12:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738951027; x=1739037427; bh=5PhYZHdwrD
	UU0UMOl+ab67KzyvrsgWOJYdzmX/9AN9g=; b=DveS8Lk+QfvunAknCpH1XwpCou
	vrobrLYKC3t0s/PSkur0b16kNC8cwDd/TeLif24quDolCC3/UlRJhYf347cNlUaC
	bQTuaEKvz8xLeVlEEuKC6GF2dt5LUFUeDIo6dSkaMMaTDWJL1Ae/sxWsoAwOktkW
	5Z2PWbhNm88ox0oGstNG+H4sFSPut5AEXRv7mskOB5DxbTl/zP5zG+QrGWxwOEpO
	oMUQgkKHrC4oyrDXG8OY123Km5V5vF+szvlN+Ty2PFZLYsPn6z2SaqZ15V9KREPh
	lJ5VEYblRLD/6a6WuZ0Pfg2K7miUxjLMVZpCR6h7nLL6XbmR5e6vZ5SfdPiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738951027; x=1739037427; bh=5PhYZHdwrDUU0UMOl+ab67KzyvrsgWOJYdz
	mX/9AN9g=; b=AHVnXK4yTWCA72BIrH8hlOLnTRPCtVU9mK5l1qy4JhABuJPe0vf
	gbjm/qmw66xCsYw2wUHtjWWQyOZRMUQLGkV4co4ocXkV2aq36m4MwQDgT6JOIIzE
	7ZTtaAfh8dIbqNkut/2RM2Vgo6ieMQmbHybLaQMpWMBWbzkGircM8TC7My5MR6zW
	TC3PhopJ78DzwiaK89hsmdxcKUlJv2+MWR1mZ2IfQBpD8PLCgwZTe05I/D+DmQ6o
	jRH8aWECCT9cWgDGx1WULzVQg/FyFC4jeJpq7fkrPAa8aesdkv3Mv2iqAZysoEbo
	fru0dP2aBeAKkb0mWfpRUDIUihBuDNK2sBA==
X-ME-Sender: <xms:ckmmZ7X4-7QYvh3jGbK6S8mGm0zU-mfkQN7FFSk0CtIgnVOuiRjBVw>
    <xme:ckmmZzmfjfU3URVMGtqVtOGPP53AhMaFZdxlPrAA9rpOvyEYT7UuRMG-y4avr3h0R
    oLpORX1Ll_ZRr9o9A>
X-ME-Received: <xmr:ckmmZ3ZZRviM-eUtmZPtQNIuBaZ9DEuJnkwuWQpT5NcJR6fLDG4r2Sic0pwXrK0AHcMOdnnNHP-MU5LcHmt88S7pnc9qww2zQ_FR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:ckmmZ2WH__vGZGY6xU2XuBDwNoZes_I4hiERQiC-yxygawzmt0sFBA>
    <xmx:ckmmZ1ko0YJCzMt09lzWQUtD9JxymaAgSUqjilI5E-XAcn-hI-gs4w>
    <xmx:ckmmZzfAQH63F3UAPaNo9siqMat5xUAWipagB4KVDvihXILJIJfFKA>
    <xmx:ckmmZ_HSlEUR4K4TV7v1yXBfRg7CCFmkWj-pA1rXG4Ce7xmD4OKX7A>
    <xmx:c0mmZ49xT3AnClXJr6nvy5mOD9Scbtzirqdehtj8XvgKQuxs3bmo-Q2m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 12:57:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  Johannes.Schindelin@gmx.de,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/6] agent: advertise OS name via agent capability
In-Reply-To: <CAPSxiM_y6gUQVNt8kZXfrn2dxpM7RNNg5LZz0dZy+9nYy=hcgg@mail.gmail.com>
	(Usman Akinyemi's message of "Fri, 7 Feb 2025 22:57:19 +0530")
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
	<20250205185246.111447-1-usmanakinyemi202@gmail.com>
	<20250205185246.111447-7-usmanakinyemi202@gmail.com>
	<xmqqy0ykkqqc.fsf@gitster.g>
	<CAPSxiM9Yejt+Cgu_ekuQwhduf=JEmS1s+T+nc--SvNQqkQE82g@mail.gmail.com>
	<xmqqo6zfjec5.fsf@gitster.g>
	<CAPSxiM_y6gUQVNt8kZXfrn2dxpM7RNNg5LZz0dZy+9nYy=hcgg@mail.gmail.com>
Date: Fri, 07 Feb 2025 09:57:04 -0800
Message-ID: <xmqqy0yhfxjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> I was actually thinking about this inside the bathroom when it
> occurred to me that,
> according to the current implementation, GIT_USER_AGENT will not allow the user
> to specify an empty string at all. It is either you specify some value
> or we decide for
> you.

Yes.  GIT_USER_AGENT=ImNotTellingYou would work just fine for
privacy concious folks.

> I think we can add the config at a level that can disable the
> agent capability completely
> instead of only tweaking the (os) part.

Yes, go back to a few messages you received from me earlier; it is
already there ;-)

    If we were to give them an improvement in the area for privacy
    features, I would think it would be to add a configuration variable
    to turn the agent off, instead of having to leave GIT_USER_AGENT
    environment variable set in the environment of their processes.

