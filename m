Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D178F2F
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705567; cv=none; b=GEL1bwsxf18at0tPLdFnO9LZGJipBUj10OrLZwj8EcJzOetuifVYTwJ5nKQOrI9fnSkwLuwbg2rkyJQiTzQzSaP4AhAYotMjgn4lmJXGLRmwOMeDKSnV2a93YcELFtgw1ZJ88gjaD9bjEZC/ZMadtQb4WZJgp6HsEf1Yug8zH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705567; c=relaxed/simple;
	bh=qXuavBIltjjxhrwHD1MuWp6xl2mjQelLiL33suBwkTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oavlegZvtw1bh1pmrKVUDaQI5QUPSeaJuWLxh6SDCfOQGWexvdTOAosIznAkSZjZE9Lg09YqqQj41m5EGJJGQhCnebTW6tNjl/RmEfbyX9z8a6VFngZmGX+4bKxlqj2Zp5s7KeNGj5ipnDphXanNc8VuBsd77fsD3thWRyeBVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1r4r5nmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6FCSI4g; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1r4r5nmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6FCSI4g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FC1AEC0277;
	Thu, 29 Jan 2026 11:52:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Jan 2026 11:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769705565; x=1769791965; bh=QF1j7VHkI6
	/P39q5nxXMSHriYEZaP1BaDZjm6pmpGDo=; b=1r4r5nmcX0SpVOkDcopS9foypw
	eD3D4ziDPMxL6G94uQXylVpq68HkzqJbKu7bx7qxJigs43fJqorzZ87Dcs70QyZn
	pg4fyGXno8NelP6PLcMf+UQCkH9QlZM59SdBiThrHYNohQKXPXKWOiV/bx1nQPrd
	QpQ/ce///JLu//QC7HdF7gabxfzHWLACQT7HwCBfSTE+2HhzpLIeD/3bDykQ7/Un
	ixxPSKgupXXMYDvg94bW6I1MFnBSfldAB0JNUbHC8OzKrg+gP/zz/vfaXwrML0KX
	0l9adPctTh4Qeri1PFVuQXUIKPdRVAfvPBwSccCfaLm7ObARdiVmEdCSIVlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769705565; x=1769791965; bh=QF1j7VHkI6/P39q5nxXMSHriYEZaP1BaDZj
	m6pmpGDo=; b=G6FCSI4g3/hiyDu9cLZHzC20RLCFW5BCXcPeei//27YPAb/88VJ
	HehkRJDCRIV4im6Qy89DdantQX+4zii/iIoSqjtEBwrkwhDMgzVRkZCEnRiSDlbp
	BvRVMUPpnBFfk258D+C1g3CHvA5oWge1L2K8HFW0Yk1o/FYaweM6eLzHI7Q6XLK3
	o7Gexxe2I1vfCEVxIJqY5CJNlbXLoJ5+ztwPBS+SzOb2htgKqddpkBMvzgExSDVM
	e2moVOhEW8X7cIMIBCqiPb9vDViUcQwNjtw4L6IEBvFMTanZxWyPww30AX7kRxe2
	NS0RbcacdcvUtWOKWOabmKh6LvVvM87mXBA==
X-ME-Sender: <xms:XZB7acmRlpShAdShRsSZSn-W35mvkoSpe-G0Y56CaRZCZfkyE4cqIw>
    <xme:XZB7aS1pkaESBE_vDiXlxSlbNnUdleA9xBEjXIExUUZoEYwjrSXZFs53dMaXCR_ot
    nMFGa2g4hUNcqsy8L5uVHbF_6CLgsAPVQs5t1CbrLPFVDUJrLTmXA>
X-ME-Received: <xmr:XZB7afpDzthOarTZS7DI8EEFYV20PCQ_GqY-LAxH6hJrs2KGnHMHeozVhWsCJlG2Cb7bTSiROXE7WMZWfzwOSLIcNkBlNg3NxT5OOI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XZB7aXebffBlXSVLgo8Oo_5rlB6mH7YCHuNekXKwZVxnOFV8a9vL8A>
    <xmx:XZB7aWpRHXBqftKA63TbiEJup4XViyfYV5ppW9sEXPZ8x9MrqVFjQQ>
    <xmx:XZB7aQE071vDweJk3scGYg0o4Wb54lkQ7KeFDQF7NfU7sWKWgHf4oQ>
    <xmx:XZB7aesdaWQsTUJhde5fypNuvYcOTqs7JOMO3DK0ABL-l__PuagcbQ>
    <xmx:XZB7aY7Xz2k3xzQcitBnVbDbf9naxAyE2ZHa8rIyY5f-knOUwhKZ8SJ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 11:52:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
In-Reply-To: <aXrGfGUJQ34JAmuz@nand.local> (Taylor Blau's message of "Wed, 28
	Jan 2026 21:31:24 -0500")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
	<aXrGfGUJQ34JAmuz@nand.local>
Date: Thu, 29 Jan 2026 08:52:43 -0800
Message-ID: <xmqq7bt0cqec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Looking at the implementation of bitmap_writer_select_commits(), we do
> not guarantee that *any* reference specified by pack.preferBitmapTips
> will receive a bitmap. That's because we don't necessarily enumerate the
> entire set of commits when determining which ones to bitmap.

Hmph.  Is this documented?

	... Goes and looks ...

Yes, it is documented.  We say "This is because ..." but it just
explains it as what the chosen design of the implementation happens
to do, without saying for what benefit the implementation was chosen,
so it is unclear if this is designed behaviour, or more importantly,
even if this were designed, what the rationale of choosing that
design was.

"When they are so close to fall into the same chunk, there is no
point having bitmaps individually for them, as their bitmaps will be
very similar anyway, so this design saves space without sacrificing
the quality of the resulting set of bitmaps" or something?


> At the very least, if we do end up going in this direction (and I am not
> necessarily advocating that we do, since I would prefer a more
> consistent set of behavior), we should at minimum document it in
> git-config(1).

The documentation says "... reference that is a suffix of any value
of this configuration".  Is "refs/heads/foobar" a "suffix" of
"refs/heads/foo"?  I actually find this phrasing fairly strange, as
I do not think of "refs/heads/main" be a "suffix" of "refs/heads/".

