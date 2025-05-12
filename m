Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB922838F
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060449; cv=none; b=N0lHkWSM8I2TUh45pWRjWxaG3YTacf8Bx4Qp9Kclf82YsuMr87obzH6ujNJFMiUaQiSOmY2rJ6B5Iu9LtflmBN26lb1kbNJ2gWVcjDNjFpIrWzC6PuErIWFuitQIJs54yXN2NKFa4WL3kzJW+E3UwUQkg6NFMND8KcERlT515V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060449; c=relaxed/simple;
	bh=obp1g2tU6QmYYL8x4likw8uj9HeE1k4Rp0Bh4D9Vmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKGHtHHFxD4W+kPZuHrIVgr3MWGHHGecYMUMyhFpy/uTvgymrKBanbo/7YLDWLMKC4LtTcVmE/wWYGrhl4K/fTkaLyTvN17YpyAhB+eSsigj7v3DkZ29+PlK3W6lc3WE+KXtpqlEPsh0WRbtxy49F0e2MTJBY0JxFH20mkBLGtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DYiCylof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GK0QWQxO; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DYiCylof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GK0QWQxO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BB3A1140180;
	Mon, 12 May 2025 10:34:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 10:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747060445; x=1747146845; bh=UhZEgC88ld
	ecnCCv2Tyms/BZ8dTMwrZuWM6G+bJaixI=; b=DYiCylofqbVqCkV95BFDEUQpNb
	bvbm+/WfaPeG1DLrEFdhlSTbBzukbExrTKTBjWRq3b+Ygvsv4oQQ8aGg7p7GJgwT
	njRxxBGWnM2XlGCHpn0ea8dcHIDKRfphn2ISlRUMqZ+mhluhaSMfwY6EH4ZVIzzc
	dNDJ2UGPIUdO4hA+KrpFjF+Ow6NgXtglsG9YLqx5qigUUAUF3sYTsEe+7JzEOwED
	RB77z8bxAVBovAsAMVL64gs5YMF3VADn4/OaKm6877Q75RKcBa4DUiZc70vCQGkW
	pQAtf3/s1qIEhFvDxo0UFqWHw3w4bUAeVutv91hkyLQLFD7Zhl8Sq2P2auoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747060445; x=1747146845; bh=UhZEgC88ldecnCCv2Tyms/BZ8dTMwrZuWM6
	G+bJaixI=; b=GK0QWQxOoKRSuDr+aAbwf+Z+wnUZpNTbSaCreSV+3Atb5sV9wxt
	oMRMbBlBIHVUqQxiPKC+ouM/nIyyyGFc7TCqrceZnz55FlFv4az2CSeyynmwHLDa
	LWIMctrRx/IXG9rT2TFZ06tnijChMGbPfAGPCI8Ulp03fPGS/Zw/QAqthVZy5LUQ
	bYu33SBthk1R0o2rXgucvvTPil3LOGf/9DOkRFQXjHz8OWxx5EiMvfTAXUl7C7PF
	kuNccgMyhlcuoCDhWow2c5FKSQL9FiBhh/N7nlzDR53LEOzjX1VgV1iMxTQGhWTp
	znlPF1jjp/KK3qEKkDqLlgGiAwoN76vbfZw==
X-ME-Sender: <xms:3AYiaIWsq8MQj73e6vfvkrrCNSBPdE6q9bFuF0yoEkwe71cIwTpm6Q>
    <xme:3AYiaMkOqjUTwDmm231Sj0ArniSyDAXmzu5pbdCvUsHkA7ssiEsxQVRmXjDYokOzF
    kGw9fsfeQTiFqD6nQ>
X-ME-Received: <xmr:3AYiaMY5XYlPI4v3t3SAu6RQjtCsDYUscEjUySg2VRG0NatbQNau3Is-woe2tresC8ofPn-O1giPvq5n0nGGtdxEfpEs-dM4LXuruEfgfwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3AYiaHXpBHoC_3ZhH-YPBq6fpOEBzVJ6cBdHrYQo_nL4Elc12wnoxg>
    <xmx:3AYiaClJ9kf5-5JbNyIR7-H4KTsBObro9CTCthE3nvPKJk8k09i4bQ>
    <xmx:3AYiaMeYSmpV5PVfM-vZiwC4AWAZ0EK1OEKAsQ_wUmIpqvs3gtgomw>
    <xmx:3AYiaEFoFyNRaCVbKb4chQpyJBsxAStam147K-i57Iw4i_Sy8ENa0w>
    <xmx:3QYiaMRvp2jgraCxqYJ8dWzYI5nEz0jiaMq53O2EaWImWpnJDzG5QS0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:34:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a425292c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 14:34:01 +0000 (UTC)
Date: Mon, 12 May 2025 16:34:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3 0/2] reftable/writer: fix memory leak when write fails
Message-ID: <aCIG2W60WbZtW8Lu@pks.im>
References: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
 <pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>

On Mon, May 12, 2025 at 12:49:02PM +0000, Lidong Yan via GitGitGadget wrote:
> Lidong Yan (2):
>   reftable/writer: fix memory leak when `padded_write()` fails
>   reftable/writer: fix memory leak when `writer_index_hash()` fails
> 
>  reftable/writer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Thanks, these look good to me.

Patrick
