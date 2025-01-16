Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5271A38E1
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045624; cv=none; b=Xf46z9D+x2Nu/RiuWtTYbpkpN7wWxqHIPVzdz9kn5PAcriYHPrq9AX+AayNCvc1BUv1PHndPlGxPvazAgsqq359ZSuRG2zEhp5jO3ktYMFm2aXG6xBO5IOMYEIyWf/w5kURqPBnF/wEBUX/Z2qAYagQWqne7mwUsnTsbGSzIKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045624; c=relaxed/simple;
	bh=V31EvZV9h/1sUzMIXJ4ygQK01/vgUwMj8rDFr4g4WPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2itVd9Pb/VWaZii4ONe8V7szAcMPNUJtdSUvZ64lJSF65tephr4MkttEpjappOv2f8PX4U3+k5LR+zxJsrkJ5f3Da3aoY0WKZLm4f8yJ8cd6VHi+ljoIVKL/wobUoTOkwhW2HyUynJzKC5H/juhNQNeaTdpC4BVajcq77Qu/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PxvPrJ/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PW/1Xxwu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PxvPrJ/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PW/1Xxwu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 912AB11400EF;
	Thu, 16 Jan 2025 11:40:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jan 2025 11:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737045621; x=1737132021; bh=xIxDuotJw0
	l3FaCuH3Q8hMABtUFayQnUCxAC7ohOTCU=; b=PxvPrJ/sBrcMlSiqm+LaxE5lAO
	Kqn2uaK1XtDlD8mr5icyEkF3Y0f5tt8/TJ8CDk3Rup9xkEtBEVeZJvDfYO5GB5Yq
	fTJ4G53pmgmHr5D+AlV49I4w78w8ArEkC269CplwGep6STWRrWBV3e2MOoEoF+9J
	JtxfSrwhVEhG4E7PiJb1FSQMZ4P5170cEjbnJO6KN/bGLjDG7+8PBFzAhx1gw6wm
	V0enzRphiNI2nlMQKNbs6QBqKtG2F3X/yZIPeeEsSskZU3ijtOn4sxECak7yJrGE
	OpIKv5DD+Ot9xbD2RHM1Q+OLfOtH9de77AljdiINLJqAso1v8k9FtWeVSlXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737045621; x=1737132021; bh=xIxDuotJw0l3FaCuH3Q8hMABtUFayQnUCxA
	C7ohOTCU=; b=PW/1XxwuljYAVtGn9f9rONuLmO8ntia2IsDE80PVYUN2jSbitUf
	cuRypA+d2Jc4pE/v8iA92DdIm8M1HFyPV4c94qjNf4X1+OnvhBMHBzmMuEShqKsi
	Yxb26Q0TykxqPXWKyDi2Pe2vMkDPB9eHjsAJEK3F6yt1rsRccgRWyL79ll8TAs6b
	ayYyF1MBWXOOmUetvOy4FaFnvdIpuOAy1Z/331TNlmXM2wU/yl0uPEHZPcDqBeUh
	eT7gvG3tUU7wG3pMhYmAw4DsZYs9Tr7zzpzIMA0O3ymq+AclEyXGVn+XDV5bzU/u
	IQGnplzeoU3zxT01SI+Aa7vebbiNIMV1FSg==
X-ME-Sender: <xms:dTaJZ9ekLZF0LMmDuVW1fzLsVmTTdMgSWpLRd-t-VN3iG5EGfNPHjw>
    <xme:dTaJZ7N1soJYVKR2J-HEiTx52zFN5BXZYfqLnbIshNnKT36CZH5QoYfGny3QOUUsb
    X8wYJfM9c82kVe1dw>
X-ME-Received: <xmr:dTaJZ2hHH66asiVGEhPmaoBdKSff01T7yfF_XPMOTZBm6VWtGfdlJVyHwcnVNYbdUh2LF-83e4K1oBg8SgOpMEy95Yw4nfm2phPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghfihhnrghskhgrrhesiihohhhomhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dTaJZ29DPIYUobN_77nA8gNiQljxHRgO8eU1l6WosuMqS5qgznmmwA>
    <xmx:dTaJZ5s01vTzAbQAxeMzJrG2qV2c8IWhilm_1vyr2knCoNQtk2zdMg>
    <xmx:dTaJZ1FEQhy1ZtDQVnW47718GM9thO9yTjNXbscrHXUqeDj35hTzZw>
    <xmx:dTaJZwNu4TwyK9i1XaYZo8-kCrPyLDbP5QtWTFfHMtEB4GgTDC12cQ>
    <xmx:dTaJZ3WJMqp288p0HAPpv9uHQr9-ug8Ros4wFIe8fs4B3WUGGYItpzuO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 11:40:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Askar Safin
 <safinaskar@zohomail.com>,  git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
In-Reply-To: <20250116135227.GA2323616@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2025 08:52:27 -0500")
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
	<CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
	<20250116105246.GF773990@coredump.intra.peff.net>
	<20250116125313.GA2301268@coredump.intra.peff.net>
	<20250116135227.GA2323616@coredump.intra.peff.net>
Date: Thu, 16 Jan 2025 08:40:19 -0800
Message-ID: <xmqqo706u2z0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Oh nevermind, that won't work, as it double-counts commits that are
> reachable from each parent. Still, it feels like there ought to be a way
> to compute it with a single traversal.

It is somewhat embarrassing and amusing at the same time that the
"This is a truly stupid algorithm, but it's only used for bisection,
and we just don't care enough." comment Linus wrote long time ago is
still with us.  Many men tried, they did not die but failed.

> I think this is similar to the reachability bitmap computation, which
> computes a bitmap for each commit (and then the weight of each commit is
> the number of set bits, but we've removed the duplicates). We do that in
> a single traversal these days, but it's pretty complex and heavyweight.

The original algorithm was done way before any of the recent
auxiliary data structures were invented. There may be approaches we
haven't tried and can now try to improve bisection, expoliting newer
things like reachability bitmaps.
