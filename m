Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF77F7C0
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151037; cv=none; b=PB/gcUVzWHJhGJneqLF4at73enBWgbThCyv/FhTR+nK0MbvZh9p/nbCznC4hJeUaIPzj00QgfwalNZI8jEOp7IfW11ogEP1bWuLIZaJi8tKwzefNBNo+lkZsupDg/XBMtfqX1+t4boryTZQy0e42rmzyn/8lezEiyST9Kxvsw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151037; c=relaxed/simple;
	bh=6DvE1eMuaTU7tR1KgVv78jBDHLbo2D4aCSTXyTT/Wc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzSZo/k269jQNIGCzhDbVkDelRcjSjOUT2BNcnwpDUVz59OIFSV/SuzO3AMkqHNVhTblyBt5xSpDZwxRrU7YbxrzSzj2FAeuJ8XrzDv0X5ceqWNYL2etINIOnJF7XrvoG8NXKh5IARbHo9eCkoaGiOVqG8Fvv7Zh0ldRhuDYoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15545 invoked by uid 109); 22 Mar 2024 23:43:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Mar 2024 23:43:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12352 invoked by uid 111); 22 Mar 2024 23:43:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Mar 2024 19:43:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Mar 2024 19:43:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthew Rollings <admin@stealthcopter.com>,
	Stelian Pop <stelian@popies.net>, git@vger.kernel.org
Subject: Re: [PATCH] contrib: drop hg-to-git script
Message-ID: <20240322234354.GC2049941@coredump.intra.peff.net>
References: <20240320094824.GA2445978@coredump.intra.peff.net>
 <01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de>
 <xmqqjzlu2r8n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzlu2r8n.fsf@gitster.g>

On Fri, Mar 22, 2024 at 08:58:16AM -0700, Junio C Hamano wrote:

> Those with specific needs (e.g., "A project uses Mercuial; I want
> its history in Git because I am used to it more") will never come to
> our contrib/ as their first place to look, but they may still find
> us in https://letmegooglethat.com/?q=mercurial+to+git if we left an
> otherwise empty directory there.

Thanks, I was going to write something similar, but you did it much
better than I would have. :)

I was curious what results such a search _would_ turn up these days. The
top hits for me (keeping in mind that sometimes search results are
personalized, of course) are:

  - https://git-scm.com/book/en/v2/Git-and-Other-Systems-Migrating-to-Git

    which suggests hg-fast-export to git-fast-import for a one-time
    conversion.

  - https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/importing-a-mercurial-repository

    which does likewise.

  - https://www.alexpage.de/guides/convert-a-mercurial-hg-repository-to-git/

    which suggests using hg-git to push into the Git repository.

I suggested remote-hg or cinnabar, which is what I would have turned to.
But I guess those are more about continuous interoperability rather than
a one-shot conversion (and of course are based on fast-export/import
under the hood anyway).

Anyway, the important takeaway to me is that searches are not likely to
end up at contrib/hg-to-git, with people wondering where it went. They
will point directly to the alternatives.

-Peff
