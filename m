Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BD16F265
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808300; cv=none; b=KF+YWrMuIqBzeeDMF2Q1TZI9KN/r8q5mFLIiwUxMRheY5kwTpx+xgIfB4N+R0pd28Hv0V09DeXvBxZepFpDPqKFZOeNlffkQE/MqqWFDkwK0PAhQgCaGKmFsbGIM89c24hwaf9Nnu4kJhKr1MWfjPqqO8wtw/ItTt1uMoSJj/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808300; c=relaxed/simple;
	bh=x3gb1JAHyUC1UikljsyQEvEEaI8hkNnJE23H1QRAoPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIr3wKBXpuHEXBm7WmiW0MJMYiIzDlkV+K95OUvsgnitM52H2lUEMbKAK708rbQ1AuCUoAjejZDIy+pnimUSrPnX5UsEFHTvfD2rGbnt/wRABCop+snV8Zdzbqmv8QGlmWHhAlQr46R46lwqXzFRN7TSQmQ7i648/p29U1C++oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SnfhEuUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNr+gmSU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SnfhEuUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNr+gmSU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EF607EC0474;
	Tue,  2 Sep 2025 06:18:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756808297; x=1756894697; bh=Q0+nlqRvr6
	w08W9FaXFEGwYNb4oiSdPNQlGC1knqoVM=; b=SnfhEuUG50zf+yiefFFouAF7fd
	Vr7CRRMkC0aKGkwrvSyOAFPwkZabprZNGHFfMgaDYknR26OCMTy685BHP9NvdsvI
	K5NP8PuRrNThdU4XYJ1WvFso1F9t8EF+uVxSFXga4m7dcJx4/yIQnVSGdVmy3wRJ
	6p9UigbXx7mwtIdr7IjfWj6Fv5OqC47q0kcZL55hdnAqnM1o3I8oELTbIZWBQD2G
	tvwqYQpjQ7ukfDYLpLV+8QzPYN337A7bu/6vd8exEzzNhw6QWzYK34z0vTvezATz
	d0LJLY+m0+IFwDIv9YvIAwuUNE8lLgL6cQhtxQ5q40+nEo3ubOvSiDFm8KYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756808297; x=1756894697; bh=Q0+nlqRvr6w08W9FaXFEGwYNb4oiSdPNQlG
	C1knqoVM=; b=cNr+gmSUpyAnt5zz00Z+MMLvltfDh0edWhjCMo3v+sdAhG99AM/
	aKq3wLPP7Mr+P8p2YfCKPeN6qaBKgplVUbL8uo6e60wG0WkS16lE4OfBM3ySf5Q9
	E1mb+1T1BwmOb+6w1VVSYJhM5AEj/B/eoUYNgs+HF+2OokcD3QwUl0jtFcmsaa6M
	r722lg3Raa+9Ik3ilhXYVsYZXfCyrQi9MIEKgUXU/CTKogZIKsFcXCIpc7PEG2Bt
	ek1kqX/F5qwxgzcPDwT/1QsV9MKzUTHp5psApUz3i5pi8jPbRQsKE6LtstQDuBxI
	syvkXNPQiN9urcCWl0+3CaQ0/pWnOQp6lGg==
X-ME-Sender: <xms:acS2aC2upMUtDMpNErKTUzbM_pLll2_W9SxOpyLf46PC35mvqHdqng>
    <xme:acS2aIWflOcjwSk0ZYiAaaVwsbkEC92Jsvu20ICoPLG_d0Krdgs4X3kkZAjVXP0-0
    SfHa9lCgHzGB-eyIg>
X-ME-Received: <xmr:acS2aEXt_25wx-uEEUrmykDA0m7TeIIV1FgYlfJFqwQjXJFoBhBNJctIHmQBnus49oJwhYPIvlQhgzhPi8Q8o0Y4HYAWVSb12ouqFJ07Uqliag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghilhhouhht
    mecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvght
    shhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:acS2aPd_IS4w0VUYXVNO3ftLB9CM80zU-I2Zv4ojTBqYH45mNztuIw>
    <xmx:acS2aFXngPE3gnLap-RdjM8ZbvKba2hxnxh3Zs-E9qym8Ife323hmw>
    <xmx:acS2aAfn5wl_RpDJVfrfCXveEgJT8dGGgXbVSgHKja8pA1g2tznmxw>
    <xmx:acS2aJNo8ABjSF-FT16dzZZB2O1KY2R2K65TMgP-TOHmbdZ2e3e1aQ>
    <xmx:acS2aASKK-de1_vnSM78UBrJEt54EFnh9yQg90KhGN9p0rRVbyM9riyO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:18:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1a8628d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:18:16 +0000 (UTC)
Date: Tue, 2 Sep 2025 12:18:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 5/5] t: add test for git refs optimize subcommand
Message-ID: <aLbEZXusJEM9hohP@pks.im>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-6-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826073645.1074397-6-meetsoni3017@gmail.com>

On Tue, Aug 26, 2025 at 01:06:45PM +0530, Meet Soni wrote:
> diff --git a/t/meson.build b/t/meson.build
> index daf01fb5d0..48f83e12a7 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -210,6 +210,7 @@ integration_tests = [
>    't1451-fsck-buffer.sh',
>    't1460-refs-migrate.sh',
>    't1461-refs-list.sh',
> +  't1463-refs-optimize.sh',

What happened to t1462? Is this due to the parallel patch series that
introduces `git refs exists`?

Patrick
