Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6C3148A8
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696276; cv=none; b=RFfUv/r8dwdT5RvSNgPsdD7Jmt77UHAAUXWn2BxUDzwbcyeXGheoxxd+P5prPzT2XiNoOiQ50UFxB4R07rzboLk71oid19PNPwtQBD+edLpN10uBc4BmvX4DKyHriUDCCQOjWalh3U8TRgCvCCh/no6ePZXRNcA5rrelWBFZ5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696276; c=relaxed/simple;
	bh=SjbElb8PJCjMSHM8F1O4AWseousXgiF+J40TN8Mp0Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brI5sDoueB9iCma6c/ftABeCiEvG3OzFKXs+ZaVRYZKrjMuAFXBuGz+4NxJ4V88q9O10R8xK/L1xYZjz+eAAHhFx7GcHenj3d004pFucBv/z16wKdn1JTOfAXspgXxfmlvZiJZnmOQd/DSSPXu9I8YVjPy/UmOvHKVUhG1Kh2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBBVsfj4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxcFuR7a; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBBVsfj4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxcFuR7a"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2910C7A01B9;
	Thu,  5 Mar 2026 02:37:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 02:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772696273; x=1772782673; bh=rlHjLvfJFP
	+lTMKHd2aVvRwraxcUydOhW0Ck2W9h+RQ=; b=VBBVsfj4MD77aIn8gM5Yb/3NhQ
	B39FfzU4bpEaTYjtrE5S+nI0d28Ndt2Ri7Qim+R6fELrye+n4unAykM0DbWpcwTT
	iWT4vRpmeEiAXJ5HKOAEFvXst5mkTB5V4Hj0WRvBvyb2wGkcbcr8fM/DEoIT5oNt
	MaH6DMn35fAsMoh9pJJnTsxIpF+CrTa1OrU1Zf/ASZ/9CnYzv2mcPUASdLNBAXQi
	YL2hmb2P71z0ngnE/A4LCP+tpQ+02495Q88k7hbh1SLqehAaFwXOdqsPDhkidIfv
	svZYA5cLpxaLcIi8HLw1AzXOqSpndTvxjFSIfx5bztVsJZtdsQg2Yty1ZH2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772696273; x=1772782673; bh=rlHjLvfJFP+lTMKHd2aVvRwraxcUydOhW0C
	k2W9h+RQ=; b=QxcFuR7alpYA2HD9KxQxLR4BWvv546o+r8fAd53a95bNn53RlsR
	aK+Bc49rcFeFl+XWI2KnIJ1pBgDn1Yqb8TfdUzWK2XuU11FPI52rGc309THKMII3
	70DWQpU6S9lzXO0a18oFY3QYNcIHjg33MjMz5kP5baEybjN22/2qHLLkhJ8+ap76
	QCunXhuTaIVuUE+bdArP5cQ2BZ19ZYj/2baSPBxpJFgCm/pK+Dj7FqD5ucsE8SOF
	qlCWqZ3Pi+9EJkVnnAv+BrwUIvjJjRCUsj721cNb5WLZPFKnfrdBVsfKmwIvKIMT
	VCJL53fR2oGVzbEPq3ehGnEVDMc/rJcODcw==
X-ME-Sender: <xms:0TKpaYeDF-NGc3SWf6uOd2ZzkBUmqvW-GxjV_1m17s6rkfNW58zVfA>
    <xme:0TKpaRML0YbfFDF7dkqcPCluMde88E7PtcUGCIe4opuoRxhGyqkZ3botihUwZ_BvQ
    NyP6juDQJS7ySNwx88S-QmqU2wKn2w22kRUw6E5NCE3XVs7fpkLuA>
X-ME-Received: <xmr:0TKpaejWYlQwOX5PW2hW9CXv1iTQRxHoWv-vRAUDDNVOR1eh31oyC8Iwi2BUbYytAT0-Ci0tOJf2e_K2KPBS97ceYODJGIJCYDs6CD0BaM2P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesph
    gruhhlthgrrhhjrghnrdgtohhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgr
    ghgvvghkrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:0TKpac3-KeKb9lvsi-Qon3KSUiaTx-0Ecf5JA8jyWNH6TvDXAFZtqw>
    <xmx:0TKpaQjhCl_cYURZS7KqzNzay_YgQDkUuXNFrfdhQCw3VaaPZpek4w>
    <xmx:0TKpaUdOxe-q1DwUW21rwMjwkN5nWyWVVxrey4iZ1twne_uKaXHIcw>
    <xmx:0TKpabkxtZ4mMgza4L8yTR17_J8cI5jAEmsE0FoAQ4MGb21_RJ6Tlg>
    <xmx:0TKpaShbs1pga_1WHKdLBz1i88IglvyFqkUPu_dPGvsVVxl2JW5A-lNX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 02:37:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b01de56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 07:37:51 +0000 (UTC)
Date: Thu, 5 Mar 2026 08:37:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <paul@paultarjan.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v11 00/12] fsmonitor: implement filesystem change
 listener for Linux
Message-ID: <aakyzGksiC2fhhiD@pks.im>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
 <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>

On Thu, Mar 05, 2026 at 06:55:00AM +0000, Paul Tarjan via GitGitGadget wrote:
> Changes since v10:
> 
>  * Reverted pre_exec_cb callback back to simple close_fd_above_stderr flag
>    per Junio's clarification (same as v8)

One ask from my side: I would welcome it if you slowed down a bit with
sending out new versions. Sending three different versions within a
couple hours without any reviews in between makes me pause, as I have no
idea whether the current version is good to be reviewed or whether I
should expect another 5 rerolls.

So please take a bit more time to work feedback into your patch series
before sending out the next version. It's totally fine to wait a couple
days between iterations.

Also, could you please clarify whether the patch series has been written
by AI and if so, which parts of it are?

Thanks!

Patrick
