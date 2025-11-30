Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A917A2FC
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764525745; cv=none; b=n1r5dtXCiAqme6xABxAivRGw5XO/G8PFiisCY1GSiKLRYjRoKCthJ/ABTu9wHwQpGfp6UQms0O01u875PY6PHDetcs3sqdlp9X/135uRdfrFGAM4QsaelC37MdqIpQS/WMW2zs1Qu3z223zFJiEF+R4faBPE8G3YGeu4FfE6tyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764525745; c=relaxed/simple;
	bh=RrMAPf+Vc6VqXxqgDojDD7zDziyFqnnYD7s+DSEDKpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdNJdTFpQ22WMsvLV4w54dln6EcSID/l6ORZCwrWb8bFiyJcIfJE9xRIYl2XHNsQzNksR8vX6agjNPolsjdJ1eUNN+b5Ggjgieu8dFyImr2HfHW9BTXJNjXVP03liaK6Qe/7OzCwxPmwCTBvOb7gM+c2TD4q3MDPMBAyhOLboGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m/20rTgH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4CnAbAz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/20rTgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4CnAbAz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1078F7A0086;
	Sun, 30 Nov 2025 13:02:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 30 Nov 2025 13:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764525741;
	 x=1764612141; bh=QyR8Fuo1fwBs+54KzZLxbPfyj43aYgab3VgMFseTH+E=; b=
	m/20rTgHeZnsZrt5rcrSZ6XNRUcqzzzuEgqJwzUyPZazReHKYqilUZ14yMzvfifD
	47lWg88ij8JEJjpoYe4KoHcc2IS+j11TxAHrm4GMgyoa5kLhqFAtmbA2BTwlbTe1
	zHpP+b/rfWqCijUi3jzjBTqRBQ/tZDi2p4kOtHL44+Ncq7BKeiWD3r4Tsc/l78ls
	uKrqvk6PJzlXolUsAbEi0yYPKOjZVENI4AbDiSHT1fE0LVTA3Zhz3Efn8Z6o7Eei
	i5BXM9CPaO74keZ9HCbMtrHjhZQxWqHHeR6mCJLKU5Qqt6dqYlQ62q6A6CzqdmlH
	BeyW2B4Yg0Gd+TO7Sh5NJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764525741; x=
	1764612141; bh=QyR8Fuo1fwBs+54KzZLxbPfyj43aYgab3VgMFseTH+E=; b=c
	4CnAbAzB9fnkxHnY1gLgRzp/SBA3LBTivvCaaNQXU4YxKYYqfsiY4PpMez7wvdjy
	mc1AUNXKjKWY0TmC+RUFO7hu4chRF7ngjcv/OIGjXi0fnNMpy3uCtQjBABwMPt/D
	VmJMqaR7LdiBrELrPaLf03KSEVJi+6DfhHyTYvc0i9Qq/w813wzMFgF9OB3jCySS
	++DyTdk4OdFUyS6AbeOWld5JZVfR7UmY/Sduat/KgSrrSvJ6dhAT3iUxNx1fbBXJ
	SZ3Xv9IDHpYfS2/zqrYdXdQCAYuOGKwRcNj0xHxhMrP1Xp3q9Lh4VNU6UGb0gPXD
	hkAtsR4objIGofRERVhTw==
X-ME-Sender: <xms:rYYsacNkwJA5LROdp0D08dskRgHL0OuKluW0tmCKxX1GlQHeO9v4Rg>
    <xme:rYYsacSII14K9x12y6F3fK7lDSPTubGuO4qy3OefVeNa_A7lN0NPeAE5w6krjNMpo
    hqSR0-AiDp__F8RFSopmM636N8h0HQlMoMG_wYnpzsqUuuug9FKzQ>
X-ME-Received: <xmr:rYYsaagiJ3WihcwiJw1OHxVquO3Q0kXdFGJHv3GVvTRVodtGd0IuG3wgOJrMxkTJ3Fx49dej3Ymh6_5LGbHQKzkgud6f05OG74D8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rYYsaV_Q3Dyfi7b_RarraP7Bw5UJGLIkYtOp6VAhMx2IpggizRLwcw>
    <xmx:rYYsaRGJ1tRc9bsdZEC3vrbK5a7_LxwEvAg64W1tM4DEcm_UUlXcpg>
    <xmx:rYYsaYmm93YkjGv4TjQVsq9ldHynEk7zpJ42yq6zcj3sulb1KOu40w>
    <xmx:rYYsaVbaoGb9y-5b6edqHzBlaHISDT1FHMmEBQpbM4-ruTeDs4_NCw>
    <xmx:rYYsabzLsrTrDQ7KUosLpSdWG7MAakdB8V7s8-IaEoacrhFNZYKro_Ja>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 13:02:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] diff-index: don't queue unchanged filepairs with
 diff_change()
In-Reply-To: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 30 Nov 2025 12:47:17 +0100")
References: <aa28974b-ec73-4562-bfc8-4745ad58b55a@web.de>
Date: Sun, 30 Nov 2025 10:02:19 -0800
Message-ID: <xmqq5xarcsb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Add a new streamlined function for queuing unchanged filepairs and
> use it in show_modified(), which is called by diff_cache() via
> oneway_diff() and do_oneway_diff().  It allocates only a single filespec
> for each filepair and uses it twice with reference counting.  This has a
> measurable effect if there are a lot of them, like in the Linux repo:
>
> Benchmark 1: ./git_v2.52.0 -C ../linux diff --cached --find-copies-harder
>   Time (mean ± σ):      31.8 ms ±   0.2 ms    [User: 24.2 ms, System: 6.3 ms]
>   Range (min … max):    31.5 ms …  32.3 ms    85 runs
>
> Benchmark 2: ./git -C ../linux diff --cached --find-copies-harder
>   Time (mean ± σ):      23.9 ms ±   0.2 ms    [User: 18.1 ms, System: 4.6 ms]
>   Range (min … max):    23.5 ms …  24.4 ms    111 runs
>
> Summary
>   ./git -C ../linux diff --cached --find-copies-harder ran
>     1.33 ± 0.01 times faster than ./git_v2.52.0 -C ../linux diff --cached --find-copies-harder

Nice.  Is this technique only applicable to diff-index among the
three diff plumbing siblings?  I suspect diff-files is an oddball
in that on the working tree side we do not necessarily have the
blob object names, but it would apply to diff-tree, wouldn't it?

Will queue.  Thanks.
