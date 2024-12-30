Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33E1442F4
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735533263; cv=none; b=VE8WlK6Te/+cC8JrSI9jI3xV+sclsad2GzyO+O3ezE+8kzykmgiQGOHIQONbxqG3v81yQhxVL9U3XG7qj45EdRLQRJPwkrbyqM2MbTc8dcVwqMdi2HpyUjfeXGRFYuNoI/EVGltesdMAHPOjcuVzdkS4VVX5wkYWgPikH7bl7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735533263; c=relaxed/simple;
	bh=GGsTcSZQDe+wSnsgag1zfy2WSnZUtif9Lxh/PuUase8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA7b17Jl8WbnccJp7vAB30KlGW5hIY1HZ94NQndZPI2SnxeWU9YPIIHj6bgQ2/9u/MTafz32cxkaDZwoldQly6iYHQ0iKQSYcTvAG2wjkjAQnLwM0iX7sTmm6X6LWTVgcnGaPkagZelptKSNME3ButEebg05bUbsfZCYVPXTFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=geyq+wip; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="geyq+wip"
Received: (qmail 14804 invoked by uid 109); 30 Dec 2024 04:34:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GGsTcSZQDe+wSnsgag1zfy2WSnZUtif9Lxh/PuUase8=; b=geyq+wipod5dNzAgcRKc1JGVrrGifAsCkRSONWQurXSutkhYQ+fi9jrrHqZurnhE/X2U9p8FAQaOQCK1EZDJrlNwZz83iJ4ou3s/5D7okOLSa/zVcqc7LKHK7ZNFYf3mymxm5srZupQvdWbpIJlDDfBsMRKFKeq2aZF6hAq93whsWyUg9LpJLGf8yKeg1uDcpQ9I6+0Ug2BT+3ag5TWP1G1rYCSYVAbvIIL96k5heB/VYs8hFqQrnRKm4F1j+fj0Yb2oVSFfxwo0dAku/9mIw3tdhib67eziIf/TeFDGNtOwL9N3x/UQIfkYNcPw4l06QmUr5/yPZ2L0K6g184cIIA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Dec 2024 04:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14384 invoked by uid 111); 30 Dec 2024 04:34:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2024 23:34:20 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 29 Dec 2024 23:34:19 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] test-lib: use individual lsan dir for --stress runs
Message-ID: <20241230043419.GB112402@coredump.intra.peff.net>
References: <20241230042325.GA112439@coredump.intra.peff.net>
 <20241230042401.GA113400@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230042401.GA113400@coredump.intra.peff.net>

On Sun, Dec 29, 2024 at 11:24:01PM -0500, Jeff King wrote:

> -- 
> bar

BTW, in case anybody is curious about this, it's because I still had:

  GIT_VERSION = bar

in my config.mak from testing Patrick's GIT-VERSION-GEN series. :)

Naturally "foo" was taken from testing:

  make GIT_VERSION=foo

-Peff
