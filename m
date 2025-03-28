Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F83010C
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140203; cv=none; b=fJR9pLvFmQWXyD9fXJ1XUAT9BI9vo2YDKyyF7xedSXF+4iw/dSWkSxATmtw31btCJOa4ABIgJokekO494F6Ueb52oTP4I/EU3MRB2oZa0L+wzZR0ZPOp1gAbtd7bfc6U5fTXj5OfRO/zORzSJls91lHjmOnt7fguHogj4EXbS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140203; c=relaxed/simple;
	bh=S/vkWURm+xtU2cd2S2K2F2EMugP9iGYXP+v5T6ox3Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtxTuRJoa2oUDs99iL7vO8l3duQ/239Y6VWWC2XxJZhaUROLRHVMt9mUKI6XWZ8xc0iiKJCWS1cp5pMSZO1U0IflK+8TIMTb2CFFiNmlp9DG2MEN8HicanJVUvbURQGaXVnPYnDTT3ISHqtjtTOAd5tMotqU8LhZL4RgYgl3yM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NTNEFSrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQxGHqFb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NTNEFSrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQxGHqFb"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C0AB2540201;
	Fri, 28 Mar 2025 01:36:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 01:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743140198; x=1743226598; bh=RQXFFl3Epg
	5HC6gdho9WqpFXvCY5Ikp0cr3d12hUSTU=; b=NTNEFSrD/rNxKliNIzHwfcJ2s8
	K1oeRsT84WGt2VNo56MArZ1buCyz6XB9+hFsv88a4gWFt4u+cFVr2zrJ/BdhmTtx
	UxUVJT9IeX1BQCFYbNPOvi2vXQJgvKA0GdIuKHsWcvABfuLneAFI+yKb02I3nDwM
	UMLdijYmCmgxhadH2neCmHWRl35QgqmRmGTqaIDJrioqEV6hxezsjO94nxoRNMHN
	Fh8Nv6Tjf7K2wT8LCSd4/ocgZdDSFJcXGtd/PNZaQuc3byRxc55xiYn3qvSXIeGB
	bj98NWG2enSrGvgyD/IMN9YwhksNHZ1/OzQOJBhR08yunplFTV3Dr014lK4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743140198; x=1743226598; bh=RQXFFl3Epg5HC6gdho9WqpFXvCY5Ikp0cr3
	d12hUSTU=; b=WQxGHqFbiALEDP0V2QTOr9jbVNtoxu4N5e4O88MEQ/y+cfUCkzI
	Q+JQcMRGw8fhkPaEPOHIPocPDQ9/o/wR3gB0xdI8Fz0LV1cqSTmJH+gTytwO5DFT
	R1bOXy4WIUeMLRkJyep7WY4sUqUp/6xEIZ6ZrSorLXXjlagVudO6D6776P7nYa1M
	jzceRKuNMx7wv6H7xTp1Rp4whgadAG8wS6qJAU2os9+1Nfp+h/qQUZqw4B+O95WE
	MDYBBf8UJmTAAO6V3hatsv53wa2RXJKLtc5nW1k1sZnTX7ppNQIMp18heQ0oZS51
	fxsCykRAuDNnPE7ovS3Ku6u5EEIe0UMEF4w==
X-ME-Sender: <xms:ZjXmZyvkeIfc2p0Kjv8LyYuqVoQIqq25FT9BJ2PvLk0dyOjzFeGbRg>
    <xme:ZjXmZ3fkETXFCXEK2r8ke95WBo3AoIk1jJFV0Z-cc3iH8UearBj_PJyxX3kHomJPa
    sy2uke9oooRJ3qKiQ>
X-ME-Received: <xmr:ZjXmZ9yI9XIuknA6dLcPH-N4EZRFzAwtigy5jZ6la-YL3ouStGRRQdkbzd6hKNf7y6fKr71FkZkFHMoEPPo6pn-4fuHevB2IX7CZJe8hApn_VLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvg
X-ME-Proxy: <xmx:ZjXmZ9NZNMOwZ-cti_g33OoqyGJ7tuYYXy3K7JeFMGNZyh6WkkaxKg>
    <xmx:ZjXmZy-VxSp3wlmqnCsV3nexyrW-gJ2Liy3rb-jcXhsC9mxfk6FDcQ>
    <xmx:ZjXmZ1VbY4Q9vVqM92u3uQhglt5WB_gvm9JYe1SnSKR_WtmjGhMGSw>
    <xmx:ZjXmZ7fSVf1wsV8SBeVbeVqjLYUgZ2H1K7HMmMxpwQ4hWSpj_QJQig>
    <xmx:ZjXmZ5b2eaoeWQ-AJ-6LaFU950dZ87Jal0jUmkDO0RDd_fVA7uMItm2s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 01:36:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3052a674 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 05:36:34 +0000 (UTC)
Date: Fri, 28 Mar 2025 06:36:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
Message-ID: <Z-Y1YbE2EVqLZhGO@pks.im>
References: <xmqq7c591sus.fsf@gitster.g>
 <Z8aeLc-xelujEjTE@pks.im>
 <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
 <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
 <Z8bL0HUuQqj7LlTp@pks.im>
 <Z8bQsflIqzZd3AMs@pks.im>
 <9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
 <xmqq34eyijbx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34eyijbx.fsf@gitster.g>

On Thu, Mar 27, 2025 at 08:28:34AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> Below patch addresses the issue.
> >>
> >> Patrick
> >>
> >> diff --git a/compat/posix.h b/compat/posix.h
> >> index b484029f751..5ad3539d55b 100644
> >> --- a/compat/posix.h
> >> +++ b/compat/posix.h
> >> @@ -176,6 +176,16 @@ typedef unsigned long uintptr_t;
> >>  #define _ALL_SOURCE 1
> >>  #endif
> >>
> >> +#ifdef USE_MIMALLOC
> >> +#include "mimalloc.h"
> >> +#define malloc mi_malloc
> >> +#define calloc mi_calloc
> >> +#define realloc mi_realloc
> >> +#define free mi_free
> >> +#define strdup mi_strdup
> >> +#define strndup mi_strndup
> >> +#endif
> >> +
> >>  #ifdef MKDIR_WO_TRAILING_SLASH
> >>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
> >>  int compat_mkdir_wo_trailing_slash(const char*, mode_t);
> >> diff --git a/git-compat-util.h b/git-compat-util.h
> >> index 8d2acf86670..a102a365592 100644
> >> --- a/git-compat-util.h
> >> +++ b/git-compat-util.h
> >> @@ -226,16 +226,6 @@ static inline const char *precompose_string_if_needed(const char *in)
> >>  # include <sys/sysinfo.h>
> >>  #endif
> >>
> >> -#ifdef USE_MIMALLOC
> >> -#include "mimalloc.h"
> >> -#define malloc mi_malloc
> >> -#define calloc mi_calloc
> >> -#define realloc mi_realloc
> >> -#define free mi_free
> >> -#define strdup mi_strdup
> >> -#define strndup mi_strndup
> >> -#endif
> >> -
> >>  #ifndef PATH_SEP
> >>  #define PATH_SEP ':'
> >>  #endif
> >
> > I integrated this into Git for Windows' `shears/seen` branch (i.e. the
> > continuously-rebased Git for Windows patches on top of the `seen` branch),
> > and for the first time in weeks, it passed the CI build:
> > https://github.com/git-for-windows/git/actions/runs/14087673643
> 
> Thanks.
> 
> So we'll see a final reroll with the above changes and the topic
> will finally be moving?  That's a great news.

The topic can be merged as-is. The relevant MIMALLOC code only exists
downstream in Git for Windows, so there is nothing that I can do about
it in this series.

Thanks all!

Patrick
