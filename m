Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DE376F1
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733089219; cv=none; b=gwQ07Ah4ehupN/IHfy7UL4x+/nEQWHbVTEX9GnMtbDAFbS4RWICVoFk2nkSvEpBQ2DXC9S2TFNM9JUpEjCZHIUoCGp4F2qMk+EU+e+TX7cNhJQQot9U9JKe930BPIpAWyRLLeEQdTVcyj1tlviterh66iZi7Eaau3/eFGJMU/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733089219; c=relaxed/simple;
	bh=ibQTNW2D2Ys2VAhm6EY1v300AXrChYIxKZ7yY5RuMzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNDfSodMigdZxZToC/byGadu7WhqfcYFoIhZA5WpPUsoacSnJ1ywT3/mtYZDxagN8rgwYDXdrGCGiWINneuQzdrCjln+Ia3v4pSWBcxwnlxmisbdt1WDCOHsel0L9oL6u5c5BpsWNXbcqqj4TNKlKkF69FCrCqfM+ojhT1qcGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GMK/+2v+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GMK/+2v+"
Received: (qmail 3647 invoked by uid 109); 1 Dec 2024 21:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ibQTNW2D2Ys2VAhm6EY1v300AXrChYIxKZ7yY5RuMzY=; b=GMK/+2v+KVUodzgCQavXIrdddmMeNMbPR9eD+aVg/IoXqv5oiWNylGz/TtJ+gC4lJE87HQU7JyUm5tnoN5J/Ev/wnhpALZKHvRkGBaOMs8g5hfu7XDIhZyf6c4ms452Lp+thSH+4BU31uXDkdNOhnYSIXXfAxFElljUToyI1GpymjQecCupcc9gvKWEFL2048d02JWEESfvIi44SJz/5FKVaNUNWltpTIchb04ilV+W2KzNRYmGKjc6t3SIgj7cChkyL4kK43MZ6u4Ppwczca9nhLwAmWJhKn5tC1pBBxXPFaVyexClT2JXRtDeyCuRMgZ3CWtPJs5cJNMH8nFegHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 21:40:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13909 invoked by uid 111); 1 Dec 2024 21:40:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 16:40:15 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 16:40:14 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow more path components
Message-ID: <20241201214014.GC145938@coredump.intra.peff.net>
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
 <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>

On Sat, Nov 30, 2024 at 01:09:29AM +0000, Elijah Newren via GitGitGadget wrote:

>     Changes since v1:
>     
>      * Moved the check to a higher level, as suggested by Peff.

Thanks, the code change looks good. Is it worth tweaking one of the
tests to do "R innocent-path .git/evil"? Otherwise I don't think there's
any coverage of the file_change_cr() call at all.

-Peff
