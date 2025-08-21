Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19291347D0
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759657; cv=none; b=FHKtEuZipYFr1cGrRjOQPx16vmHboc0aLJGy6Kuyccq1OP+0j/WFDoDhkK/ffhJ5CIR/vbevLFNKUwzQ9VMQHaa7EwYX3hTXdIq0dflHzTf2s5wlxcVvZbRk/w+x9IQoPlBPUVpSo5xdNgqi2/bvFEIDk7Tmg1+Trzb6m15EjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759657; c=relaxed/simple;
	bh=kr+xRDU91sb8L2T4v2fm5uiMQkJMIgpvadDIiyZax20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKZQwUEvaoizmtAXaNMszc1Y7WAfGyUNeZGs7f3DpgueNsjhjq99zNfSgqZGEPCd8enQt5tnu49UeidN9AwPfmVWSUyBeSFgIpJVdm6yiuxLFnwesUVXj81UNA6X4NXx+YO8JLmq+ft2sYy/zq3GJ5IOdQ8QxNl0nCTvdDRHHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Woa321xJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Woa321xJ"
Received: (qmail 42063 invoked by uid 109); 21 Aug 2025 07:00:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kr+xRDU91sb8L2T4v2fm5uiMQkJMIgpvadDIiyZax20=; b=Woa321xJK9VEOvjfDzKXhdh7SL2htDScsis3vJ+PvDhF+Mwg/pfWJb6fAXi8/QTD2cl2arK7ocYBUaNyhlWczk6p9Frw3+185otDamuGGOvGKgK8R096nYq4yYxFTGUkqZfMZ0NFi+SbvjMaMv+57n6fpqYVh+EVSM9SSY0/3cz4qbS80cAkukvvftnK3pH0xpd3dcVeBSCk/sUBEdh7JBoqM2+muNlNqisUwX3u6kD2xJ3py8tw8W/vN2xcrt8qpfJ/lXSCst8O3JODpQOpCRAHngJn1zCN1rHi0lxs9za4kMrd2sPUWFnp6WY0V0cEtPdt/6+SCrgSSyhSIryWkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:00:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71944 invoked by uid 111); 21 Aug 2025 07:00:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:00:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:00:50 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <IsaacOscar@live.com.au>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Some subcommands ignore color.diff and color.ui in --patch
 mode
Message-ID: <20250821070050.GA3905042@coredump.intra.peff.net>
References: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <20250820220439.GA1668511@coredump.intra.peff.net>
 <SY4P282MB2965003F2D5DF18C6252978A8C33A@SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SY4P282MB2965003F2D5DF18C6252978A8C33A@SY4P282MB2965.AUSP282.PROD.OUTLOOK.COM>

On Wed, Aug 20, 2025 at 11:48:36PM +0000, Isaac Oscar Gariano wrote:

> > Have you tried setting interactive.diffFilter to "diff-highlight"?
> > That's what it was designed for.
> Wow thanks! that worked perfectly. You really should put that in the
> Readme (it only tells you to set pager.<cmd>).

Yes, I suspect that README hasn't been touched since well before the
config option was introduced. ;)

I'm preparing a few patches and will include that.

-Peff
