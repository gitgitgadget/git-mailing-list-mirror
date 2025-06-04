Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67342A87
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045113; cv=none; b=IEiD4aeMX/RszPE5tp0aJcY+o7H4Qw6FJjs0/k3U4EjdEwv9YlFp87BdbYASUIh04ulJUjb/28EKAGPn5i4ifB7ks32YUwYyuuuBASIzczgKsDzKDMzpLc7id4ShTYh6D7wCRw0bhQG4cQ1e0e2kR9vKSYKroTFRWiXQHd5Yte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045113; c=relaxed/simple;
	bh=JxWirD6eCUinZ4AIa6oxbhxax2mB2Hhhvo4GFT4q7lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoJ2eU+Pu5JUFuXCIzXIwsCl83ALL6xQYzsh7a9feu7w5QbAT1pGdt2vcLeu/YRoolsuBlP8BABZV8CUyMU8/DDZeC5daYdhsF91f0MK3uGMAnOnN85gzEIQE5uDou3M34l1z5xhMtc5FjBOTNhJAzBwJPKt/Ax+VLuLGyT8mEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VWlwnS89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JW2+C3Mo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWlwnS89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JW2+C3Mo"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D9BC1140184;
	Wed,  4 Jun 2025 09:51:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 04 Jun 2025 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749045110; x=1749131510; bh=qcJLtJ0bc3
	g9SA+lDAJROmDRtz4dtZQeTcw4oJnDJ4Q=; b=VWlwnS89t6PchHQZJfP80vpE/k
	ZjA0aqLMQ1D9t0J3CTgsGzu23WQ0ioMdorOHZSFT4wIPSm36bx46YzNCcGVf5Z40
	muGioP1C4xqclEt6NOTOj6+8VrrnZeAgU07fTm9qFIZW9RX7NekOFjzLjRzVcSMN
	3+SdpZm/TEGdCNLpXDN9MJYXcHxCgpY9Y7VayVElJXQGa7ilZgXcD4kyCXh36yih
	CF6KKfW1si1obSNeT2PkWvi17qidT1RFhP6zH3HgaGrfisOvaPg/Eiz+P23uujzH
	YAI7GiTFz572vAFnAtTrUSo6jcHjh0eCNidPtEv1readM48tbWnxGnne7bog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749045110; x=1749131510; bh=qcJLtJ0bc3g9SA+lDAJROmDRtz4dtZQeTcw
	4oJnDJ4Q=; b=JW2+C3MoNwFkL7rJ4m9Na40ySuR4i8leCRqvs/2chiLukXn/ARN
	NRKav764MzsE9BqjMFkZJ9KSYE7OE7jOZgcCmNfvInv+lcwT/VLdEMhaOYqqHumF
	mYHloRHPz6B/tZe4kH6OvyCjDdVyzVl+fqx54UhuOWCAv/ulPIzKpjyZ7G+ecDhd
	nlEMQ8x9notWpP7W7ZImqfHBTbHNP/mQ7qPbQFuixRFFk1C+EGXre42H1/yp6xCR
	Te2+lW2hbkcoXdFyjerH03fuAQY2D0dRB9pPb5ergqyJlcNwjFsdPRLKpYCxDE7i
	zUa5wJ1k4eMJu5BVzetP9NASb6a9eGC7NdA==
X-ME-Sender: <xms:dU9AaDVjJpl1D5oimwcr7erX_Du3BWUemFfabEc10DdhkTGQAmI7Cw>
    <xme:dU9AaLn3S2VXyla1DqZ_KTg8kdWsdlnvbgdZ3IF_Aen8jn38naiY9w4PD19mSBk7P
    B5IerQVZXWeyWNrWQ>
X-ME-Received: <xmr:dU9AaPYH1SWP8O4cqYip7Z8QQ9cuiIB2saAkrIVAFc-upsfAd8X7bn8hcDHFEuLPxtT8QIqUprQPK6t55ZcXtjG07rWBgZXMIigxwPzjT02AqvwGHWe6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghulhhlihhnghgv
    rhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgveefveeihf
    ehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrdgtoh
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehr
    shgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:dU9AaOXThnD-fmbuzrN8bTrNODs1BHuXs4CfOch7yVLtjs55zXctMw>
    <xmx:dU9AaNm6JzXS_Qd7iw9qiQg9GsVDWQuVAWanQqq7SEBwvmvnCjaV5w>
    <xmx:dU9AaLcgvEJPUoaCqneCb58bDqnWOYWoLhGbVkj2BVPHskAf5xfqqA>
    <xmx:dU9AaHHpz7wUVQgZaOspznvvkuSANfBxqKi4rKyOW3ZDvnNwnfl2jg>
    <xmx:dk9AaJuBNC3KtbAT2DgwZ9am4M2xwOhMgMoESA-pz7XDUfdMgJGUUtZG>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 09:51:49 -0400 (EDT)
Date: Wed, 4 Jun 2025 09:51:48 -0400
From: Todd Zullinger <tmz@pobox.com>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Message-ID: <aEBPdFXpIca7lMls@teonanacatl.net>
References: <xmqqsekgn4gk.fsf@gitster.g>
 <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
 <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>

rsbecker@nexbridge.com wrote:
>>I hit a new issue during the test phase.
>>
>>Makefile:200: recipe for target 'lib/tclIndex' failed
>>
>>Is there any way to suppress this? I don't think we need TCL - don't have it anyway
>>on NonStop.
> 
> More info:
> 
> The actual more complete error is:
> 
> /usr/coreutils/bin/bash generate-git-gui.sh "git-gui.sh" "git-gui" ./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
> /usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS 
> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE> [<LIBFILE>...]
> Makefile:200: recipe for target 'lib/tclIndex' failed
> 
> This seems like a legit problem to be fixed rather than ignored.

If you don't have TCL, are you not setting NO_TCLTK for your
builds?

I don't think that's changed in ages, but perhaps something
has changed in the build process or your build system which
now exposes that you aren't setting it, which then tries to
build git-gui (and would surely try to build gitk as well).

-- 
Todd
