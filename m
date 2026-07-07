Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605D188713
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399133; cv=none; b=JN/ELcw0J+xpr4xG2KVT1GXLB0BfCAN2B9bmjq1xMApTYbbz9EiBp8g7Y65BBEsV2we0vnb8AzB46El4k0F6lmG4mwHHKJKgG6y5t0+5Ivfg1zTsJNwrT0TgaDdbj/Ftym5eqGOGVDR5DQ9qz6ougzjSCZe6SnCyZqpPTBlfIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399133; c=relaxed/simple;
	bh=T61ZshXyBWkmLx/CdxvSkCU6RxAorbToupHEry9MZeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEDwmHs7zqbbnh5XQjHUCQE3hbnpQHEQGtANG4aECFbfsIUOHP6oY27DHVU0K+782UKwW3/e1AW3slXl4C+AHJyrXP2bFIFj1XCQU3ziqkxe5gkADQDdczeS3qvAYzHxY/SLD8/Mk3LDncDVMmBwC53evTW9tw7ZCujlnc/lXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J7iDdEt5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J7iDdEt5"
Received: (qmail 17259 invoked by uid 106); 7 Jul 2026 04:38:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=T61ZshXyBWkmLx/CdxvSkCU6RxAorbToupHEry9MZeo=; b=J7iDdEt5gcsV81NDqTEyX7rvg2+blnJX+929+vngvFOEc6F+ZLYd8D8Jkrlp/NifPdY255Fg2Sg8pO3++Cae6Xz4fXHFvVEABDSU6BO/yExBVJHJgTOL7X7gZygygZpOPYlunQR51dv5cje7+PzztHl3h17mcHa1dwfFWI35XF4RcScoyb5KVdKp0Ue1G1vpwIkIzl2RAx7rtwTA9fn0xv2WoW5H/9TPlKUoBkfWiX5i/9NUu6f8uY7ljgSjbxKaF6u0LXJveiIh3PyMNkI/Sz8ygMUr2Cvcii+NojCeZKxRUxZiX0m2pUKVlCq/cO4BJTTWGlL5vmYIHPdjVrLYvg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 04:38:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22101 invoked by uid 111); 7 Jul 2026 04:38:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 00:38:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 00:38:50 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <20260707043850.GC677056@coredump.intra.peff.net>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <CALnO6CDAG4e4A_Qn-3QVe0s4D9xB333Sp0QRntNATwMygNXmQg@mail.gmail.com>
 <aktOn-3K41Uhl9cr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aktOn-3K41Uhl9cr@pks.im>

On Mon, Jul 06, 2026 at 08:43:43AM +0200, Patrick Steinhardt wrote:

> > To summarize: If we're all leaning in the direction of a run-time flag
> > instead, I can noodle in that direction. That certainly involves a bit
> > more surgery than just giving Meson access to the option, but the
> > dynamism may be nice. I'm not too sure how we'd write a test case for
> > it, though.
> 
> I don't think we'd necessarily need a way to detect this. Our current
> build default is to have this disabled, so I'd keep it this way, but
> automatically compile nsec-support into Git if available. And then we
> provide a way for users to opt-in to the new behaviour via the config.

Yeah, agreed. Even if we eventually auto-detect, the first step is
adding the config at all. And then we can decide whether to stop there
or not.

I'm agnostic on whether we add USE_NSEC to meson in the meantime, if it
might eventually be ripped out of the Makefile. We _could_ retain
USE_NSEC to change the unconfigured default for a given build, but I'd
be inclined to just remove it entirely once the runtime config is
available.

-Peff
