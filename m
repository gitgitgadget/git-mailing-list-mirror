Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891E35944
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741069875; cv=none; b=Cvhck26odaU9iQ5T1CF2DFRqCkK83CCYpCpCZuKCC6mAa3hvrwxIcTH37GHZ3cbj4E/qCgYx2U4+Lp0M0r+7kRMPlbMGNUujvYRPX6LlwtvPg66m0V/WLUCozO6jaSAstA/fWMnXkVQX2QzxDAGavFBUPoNsCaJSvzZhrpQnwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741069875; c=relaxed/simple;
	bh=Pc8aYpfIbnfHEwPGtzn6rsI10b0FVlGtV/FZYb5dzZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQGI7Ebop+DV9KHxsdHCdu2S+NTGg7b0xGHMJZfnz98e9jEKClvD9uUG4vyjjHlTi7SP1iTwUxfqYEgE/6qxPhu8BQh8U7fGCwuHfmvsFylg+Z/AaJotEiB0DFHZGJXOaBzJ7JEapImRBy6NHxE50zhX4S/sLp8diXdyc0gjjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GZobp85K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgRzYOvM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GZobp85K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgRzYOvM"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 95A62138099A;
	Tue,  4 Mar 2025 01:31:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 04 Mar 2025 01:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741069872; x=1741156272; bh=VoyaSFP51q
	PF0cXKWl0+dOQamivv/LBEYM6SCLnotsM=; b=GZobp85KNnPP9TIIHunkZ88IG9
	Oy9o18SMZS+MrWywReQBwtg3HQs71AyYwHBtav4T33DrKG2CsclrkCjhglocibw9
	7J2ssOIrq8Ql3WdbA6PPVdBZS3OS2vy/wlcBEwYjROOi9GGWzU6gOM9EGDC2chWh
	TwVCe0mzFojQrpM8tkUFMRsaHqUWnerRuDB7P8WNhnQkCCAkdsfNuRa7W49MNP7i
	AAhm2MlWp3QmUARLnLdirLRo8lQmyIiNKn0dWjl5M9pAXqwSon2moGHyqu56W7jR
	fgXvLv0namkgiyMs8DuiV7xKujT98F7Ms7BCaFK5JNVJD+qnLnw3irDQ04IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741069872; x=1741156272; bh=VoyaSFP51qPF0cXKWl0+dOQamivv/LBEYM6
	SCLnotsM=; b=bgRzYOvMvLrVCmmPPqsy6CqJolLRIk9P80KAWI8L/zhJSNeot6j
	+bYo2Qp5c166S3woccCo9CvLYa+qEa6Tk/G5r/20m2HrGwykv8imdEpDkdh+xtbM
	FgD5c2QMp59glmPuVziMjVpxD1CgtA3OjUwtQaM9/YZt/APpRDCaD1QIjOrAOl17
	/vqEBUaSjihhzflEk7dD8YD4gGaBnCIIMmLuXMc10aN3T+N5hLkI4UpBegHc8tlW
	CPzFjmMN36msaC32uP/ghr9o43uqRDWp2JhY/+ZSSBpY41gcV4LxytjucrgQlYq3
	Npj7CMiwUc6KgeYxnkEknj98RDMDYYRVNJQ==
X-ME-Sender: <xms:MJ7GZ9AFW6PUodQN2ZApHhRunzhHj0QCmOkqzzQy4TkxmgosuYhrQw>
    <xme:MJ7GZ7h1sFhcV0MuQnNzgiZ30lfMdrOYI8OWnbx_LjJGGNsuvH-G5jEWtlWqANoFv
    2xJEqL3o8vTbTgvfQ>
X-ME-Received: <xmr:MJ7GZ4nH5Vl4HzEOvaGiHukgIxx363O4QNFur8vNBH8nlTETy_np3eUr-VmstBQXd_PpLMBbtZEzp06rHu4VnZHRzMs-2MRCo4RosXh47k9IOB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfeffleeutefgveekffefjeffheevffevveefuefg
    jeduveelkefhhedvudffuefhnecuffhomhgrihhnpegsvghlohifrdhpshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:MJ7GZ3x3Sr3gJPonkuesb3QUuNadYC2iwGT2oVWEgG63dOa7dreg4Q>
    <xmx:MJ7GZyQMomqG4T-lYYkwyZm4z8swLgIFCkfE__ViLIj-RlyPFt2f-w>
    <xmx:MJ7GZ6Yf_udTeL_avRfJtv7eVTxtXLcFvYg6Vx9ea_qRZJGQzVofig>
    <xmx:MJ7GZzQvSKt_QO1pjTRbtsU6kC1hRY8_4mHynSmgK05BNPN5cc8y2g>
    <xmx:MJ7GZweUEFC7WEev7vW_8P1bSnN_gC3CYx4skvjj6NZCf_2R60SZlQeM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 01:31:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43bc0f87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 06:31:10 +0000 (UTC)
Date: Tue, 4 Mar 2025 07:31:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
Message-ID: <Z8aeLc-xelujEjTE@pks.im>
References: <xmqq7c591sus.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c591sus.fsf@gitster.g>

On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
> * ps/reftable-sans-compat-util (2025-02-18) 18 commits
>  - Makefile: skip reftable library for Coccinelle
>  - reftable: decouple from Git codebase by pulling in "compat/posix.h"
>  - git-compat-util.h: split out POSIX-emulating bits
>  - compat/mingw: split out POSIX-related bits
>  - reftable/basics: introduce `REFTABLE_UNUSED` annotation
>  - reftable/basics: stop using `SWAP()` macro
>  - reftable/stack: stop using `sleep_millisec()`
>  - reftable/system: introduce `reftable_rand()`
>  - reftable/reader: stop using `ARRAY_SIZE()` macro
>  - reftable/basics: provide wrappers for big endian conversion
>  - reftable/basics: stop using `st_mult()` in array allocators
>  - reftable: stop using `BUG()` in trivial cases
>  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
>  - reftable/record: stop using `BUG()` in `reftable_record_init()`
>  - reftable/record: stop using `COPY_ARRAY()`
>  - reftable/blocksource: stop using `xmmap()`
>  - reftable/stack: stop using `write_in_full()`
>  - reftable/stack: stop using `read_in_full()`
>  (this branch is used by ps/reftable-windows-unlink-fix.)
> 
>  Make the code in reftable library less reliant on the service
>  routines it used to borrow from Git proper, to make it easier to
>  use by external users of the library.
> 
>  Waiting for Acks, especially for Windows bits?
>  source: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>

Johannes, did the new version of this patch series make your life any
easier? As far as I can see the conflicts in your "shears/seen" branch
seem to have been fixed, and the failing pipeline seems to be due to
other issues. If so, we would be able to move ahead with this patch
series and the dependent fix for Windows below.

> * ps/reftable-windows-unlink-fix (2025-02-18) 2 commits
>  - reftable: ignore file-in-use errors when unlink(3p) fails on Windows
>  - Merge branch 'ps/reftable-sans-compat-util' into ps/reftable-windows-unlink-fix
>  (this branch uses ps/reftable-sans-compat-util.)

Thanks!

Patrick
