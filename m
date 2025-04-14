Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6632F42
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618412; cv=none; b=WYkb2ksMIS5y7S8PZdk+8YpDhB9UQwGYdhAbG4qLW9XnM1PRHYUgE1szdsKfu8ST+0T1EoNZWTiP/QLu2gpE8x45CK27IoUppuGgHpEbizADO4jzq415fLy+OtiA/KHFcX5MBqAhWEnNZFG3BvKtXgLRA1XrzlxrNqcfIkDXIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618412; c=relaxed/simple;
	bh=FL9VqAAmqU5cGKHYqes99TBWx52AYQDvtVy9jTf+cXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEBNzl1nbRoxFEpVDFcr/86MSYlwjgnIWXk9a+/H04bXAz8O/osWWeP8op6vRP+xHmXV9xFl4b6n1TSJ+YZ5x1DZuqEnWW/18GefFOeaHY4/93qz6tGG+NFs19C/SeWsncJRL6sx6osMsgPM6zqN8PFT6MIOMioR4UxdPAycPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=APKL71lN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xpQ1qTLq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="APKL71lN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xpQ1qTLq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A79325401EF;
	Mon, 14 Apr 2025 04:13:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 04:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744618409; x=1744704809; bh=OONoqBi7yD
	o+kOcuTHjxCBebrCs/LmN9fH6v0qLqJ5I=; b=APKL71lNUWQZ1lxg/0ILSaueq4
	1cB+qBZVEZQjjk7KeGktAVrWL7wTGtvjI7D4wLHHcZaCL2lh/aAd11a+0jLc/WUD
	nB9zrf6V8WOihvdDRqmKHkPPn+hpE0aCrWhFdqMPK1MOY/3V4HTidWtOKmrum8ox
	97/s59R+7ZjW9vEV0fQnDmFHEFbxSO3JvBd10V25+Qgpj1JDKJKbO5IZbvCAt9iZ
	ftZGb/GSHiCmIuuR5QPU6oCwVvj428GpG3hupHwnBsEo+DRgjgE+6DFWBLa5fh1/
	U/BzwtohJxrKJCARCX0FMm9Sz10QL/uMMLJXyB7IWIFaqGuPAIuSJY5Cuecg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744618409; x=1744704809; bh=OONoqBi7yDo+kOcuTHjxCBebrCs/LmN9fH6
	v0qLqJ5I=; b=xpQ1qTLqJodY2Yjapn2OnyROj8uVFJ1f+RlufV6jKMIbJzcVpHD
	ZMl6e7p18lQp3IRZxtMrvrpp/LMHoV+gP7FpED4GHkeU5W/YbamUAe9Axggw8Tos
	Wmft455dMcsDIfW8MbdgaJyRN78N4LqSzczQbEbXq/sQGJLEK353EUvTQNSIZSuC
	UhmfJ/2+rkqJ+Pucvv735VBpgXQI4fKpsSsGI30VXKgNUvg7J4iX14SVVEHd7vKn
	OSeLtxLCN1sRowiHr/+eVTa/KeDN9MF+h9gdKA3xMwuVA+VT1D5rH64ju5tHixV9
	QEHS/dAKLZsTfN6Gs3GUPLYgLWPKMDJQWvg==
X-ME-Sender: <xms:qcP8ZyEM2eor7TTunSKrQoBE4itjqB5vpTTtsL3JDa4WMJuTO5teSg>
    <xme:qcP8ZzXssRPdD--5_PmTrt0P2nG_KAn2eQx37tRDDj68p44_ATuWbnxVFiRuHtJN_
    6-rZPfiqjEcly20Kg>
X-ME-Received: <xmr:qcP8Z8KINeuw-YLtgB6ndMmHQcLW8LDEw-tV-ExxCZoeczdF9lxYDUYgr1lFI04H4BBAynHt89ssosRZRE-d_AkBjPjcw_5hxVamBXb79a4H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:qcP8Z8HyZNK2cU9T2FCqI8UvvUyphtlm1YAP2SWrzNNBZ0UazHWY0w>
    <xmx:qcP8Z4WGRKu4Gh7HsVtByfUY55Yx9Klo5dj6PwH3PRxOQRUdV4juWg>
    <xmx:qcP8Z_Ngi1aph1bR5IWqVA7IR2s97QH-u8Oav-nf4UARhCuv-fbbyA>
    <xmx:qcP8Z_0qFJ-5OTKWnE1XmUeGTjHoSGSRmhX0SIV9FK5K4Vcsrlyimg>
    <xmx:qcP8Z-HK0xwdMtbcEllNNaNourM3JYyXMPFNu42_UTzvuV-2eEoPm9TW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 04:13:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c74df438 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 08:13:27 +0000 (UTC)
Date: Mon, 14 Apr 2025 10:13:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
Message-ID: <Z_zDposxyFf3xPZD@pks.im>
References: <xmqqmscml2zq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmscml2zq.fsf@gitster.g>

On Fri, Apr 11, 2025 at 03:58:33PM -0700, Junio C Hamano wrote:
> * ps/object-file-cleanup (2025-04-11) 10 commits
>  - object-store: merge "object-store-ll.h" and "object-store.h"
>  - object-store: remove global array of cached objects
>  - object: split out functions relating to object store subsystem
>  - object-file: split out functions relating to index subsystem
>  - object-file: split up concerns of `HASH_*` flags
>  - object-file: split out functions relating to object store subsystem
>  - object-file: move `xmmap()` into "wrapper.c"
>  - object-file: move `git_open_cloexec()` to "compat/open.c"
>  - object-file: move `safe_create_leading_directories()` into "dir.c"
>  - Merge branch 'ps/object-wo-the-repository' into ps/object-file-cleanup
>  (this branch uses ps/object-wo-the-repository.)
> 
>  Code clean-up.
> 
>  Will merge to 'next'.
>  source: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>

Let's wait a bit with this one. There's been a couple more review
comments that I want to address before this is ready for next.

> * rj/build-tweaks (2025-04-09) 13 commits
>  - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
>  - config.mak.uname: add arc4random to the cygwin build
>  - config.mak.uname: add sysinfo() configuration for cygwin
>  - builtin/gc.c: correct RAM calculation when using sysinfo
>  - config.mak.uname: add clock_gettime() to the cygwin build
>  - config.mak.uname: add HAVE_GETDELIM to the cygwin section
>  - config.mak.uname: only set NO_REGEX on cygwin for v1.7
>  - config.mak.uname: add a note about NO_STRLCPY for Linux
>  - Makefile: remove NEEDS_LIBRT build variable
>  - meson.build: set default help format to html on windows
>  - meson.build: only set build variables for non-default values
>  - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
>  - meson.build: remove -DCURL_DISABLE_TYPECHECK
> 
>  Various build tweaks, including CSPRNG selection on some platforms.
> 
>  Comments?
>  source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>

I just reviewed this series. It looks mostly fine to me, but I do have
one question regarding one of the Meson patches.

Patrick
