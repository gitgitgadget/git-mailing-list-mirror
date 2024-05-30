Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BBDDA1
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057048; cv=none; b=F9fE4fPjKjxktrV62Kq6RLWhfITXluHv776c4JhL1kk++55vZPh34b2eWDnv0CqUmhGO2U5twaSGw/gD2G272TCcll+U/IKZz5BhLXY+djo9GkcxWJXBaa6rhxC3WpJs3dLmkUmMx4d/h2h/2zugBVfe3kzMJb4ZtyuI9X5PlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057048; c=relaxed/simple;
	bh=L4sPVujLF6Uzc1sljrNdoQXYRHRStGtE5hHtpg9fngo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehWNvP+LqjT3l+WsHLkmsgIGqmpP8TEQtzac+zkVpj9jTThWnX3LhfBOeKyw8YWtiJdopOuqE6SnOpRrUA3vaVA/U2Dhyz8x1twflJzJhA0JTJ5mhzYi5I67qMwoJRd06nNu5irysZlzggeWa55KbajIhX+ODXb2fO0EGZrcMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17409 invoked by uid 109); 30 May 2024 08:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 08:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28578 invoked by uid 111); 30 May 2024 08:17:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 04:17:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 04:17:25 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Joey Hess <id@joeyh.name>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <20240530081725.GH1949834@coredump.intra.peff.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
 <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
 <Zk2_mJpE7tJgqxSp@kitenet.net>
 <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
 <ZlU94wcstaAHv_HZ@kitenet.net>
 <20240529085401.GA1098944@coredump.intra.peff.net>
 <1cbdeb41-2ad3-05e4-ab27-1f84086b7f43@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cbdeb41-2ad3-05e4-ab27-1f84086b7f43@gmx.de>

On Wed, May 29, 2024 at 02:17:41PM +0200, Johannes Schindelin wrote:

> On Wed, 29 May 2024, Jeff King wrote:
> 
> > [...] But of course most sites just use the defaults, so all warnings
> > are effectively errors.
> 
> I wish that had been pointed out on the git-security mailing list when I
> offered this patch up for review.

Me too. But I agree with everything Junio already responded here.

> So this is what the fix-up patch would look like to make the code match my
> intention:
> 
> -- snipsnap --
> Subject: [PATCH] fsck: demote the newly-introduced symlink issues from WARN -> IGNORE

I think you mean s/IGNORE/INFO/ here and elsewhere in the commit
message? The actual code change looks correct.

-Peff
