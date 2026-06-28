Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85BD2F12AC
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634690; cv=none; b=IaVGaKLCB828HPZsQYA3vu5DvmugTgnA8jGK8FiOAKN5mGQlvZkr8iksuRwyrFHfix/bkz4ozKwrT836BW+9Au4BoYVQU/gWxA008sX68C0YPwVxvnvkfTP6gxX7OjGRS9Vca/cRfvStwHOMLGSXwrmehmTmsDksJavbRB4upns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634690; c=relaxed/simple;
	bh=SGLNKPTCGBpho+dup5FEDp4xpyyAq6yqQu8i5avwaoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3IvWOiZRMjX8uV6fhG7P2FKFHgEUXm2vo9RbvZT935S7rnAHzaU4ykcBSD+670KMcLlFGVarErSq0AEbAqJE+kxQSEy/wXY4G3cYZqIWxKch2FY9Xoqr0uBBQJnBFalCXiVOnnztNfseA5M/s2mjnTKXAE2BDgy1eTQkxvujE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iW03cl6x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iW03cl6x"
Received: (qmail 52339 invoked by uid 106); 28 Jun 2026 08:18:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SGLNKPTCGBpho+dup5FEDp4xpyyAq6yqQu8i5avwaoI=; b=iW03cl6xLZEwrogwXzMAbYsmSbbNZxTnEXdtiIRLdnymfignnI1ZJd0UQCK/uxr/fLwavLfCTm3gx9nWPmnfzKpcCfTp4M73BjF46pOXyVFb62qUg8F5p3m5WFt+eZ1hF6tHPdWo82KdDdx538OWb7BuyFupGptOJExYY4IMXA5RnWSxTcBRVJ2bCwpO0gtMgsoC/Vf20+ug4R3f8TcyfLJHn9Kp6z6xnicfAvlAkgOKJ8NHsmAh4GmfK2OrSa4BuxIxfzF2M+BJRkuhRTldvS/3g6alu3LGCscUBPnJR3bGq3E5tTDlOWFoorkwSlUEqEOcwUt1UsX6ukT+HtEFVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:18:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111507 invoked by uid 111); 28 Jun 2026 08:18:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:18:07 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:18:06 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <20260628081806.GA3594700@coredump.intra.peff.net>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajjuoS5Qc3K0nCRl@pks.im>

On Mon, Jun 22, 2026 at 10:13:21AM +0200, Patrick Steinhardt wrote:

> > So I guess if we wanted to go further it would take some digging as to
> > how each platform behaves, and then flipping the config.make.uname knob
> > for ones where it can be argued that the behavior is always reasonable.
> 
> Yeah, it would be nice indeed to figure out whether these concerns still
> apply. If they do, I would argue that it might even make sense to remove
> the build option completely. It doesn't really make sense in my opinion
> to have a build option that nobody uses and that is subtly broken when
> enabled.

I suspect it works just fine on some platforms and some filesystems
(i.e., those that actually store nanoseconds on disk). So probably Linux
with ext4 is OK. That's just guessing, though.

If I understand the original problem correctly, then doing this:

  touch foo
  ls --full-time foo
  echo 3 | sudo tee /proc/sys/vm/drop_caches
  ls --full-time foo

should be instructive. If it shows the same time for both "ls" calls,
then USE_NSEC would be fine. If it doesn't, then the system is losing
the nanosecond information when it drops the cache and has to reload
from disk (and thus USE_NSEC would cause spurious stat mismatches).

On my ext4 system, I get the same answers. So far so good.

I get the same answers with a loopback-mounted ext2 system. Which
surprised me a bit, but even unmounting and remounting the filesystem,
the nanosecond times are still there. So...I guess ext2 supports
nanoseconds.

I tried with a vfat mount, and it also works: we don't have nanoseconds
either before or after. That makes sense, and implies that modern Linux
will always be OK (because it limits the cached VFS response to what the
underlying filesystem can handle).

So...maybe this is just a non-issue these days, at least on Linux?

> > But that's all outside the scope of your patch here.
> 
> Kind of, I guess. If we figure that this mechanism is still subtly broken
> then I'd argue that it doesn't make sense to expose the option via
> Meson.

True, but AFAICT it probably is safe these days, at least one some
platforms.

-Peff
