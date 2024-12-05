Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C10193
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430341; cv=none; b=ZJt1MHuGgLiwAWhSj/D3U6NpbtDML5eMprdju4dX/rXKA0EXhdfvFNToEdSfD9Rzy1v2MH+hUYCjjDgiO6OJe1hxjrJHBW28u8LSN18001O6SFoyIpButs2fSlNyc7Pt0etdI+i7hZMwlnuURbmRp4odF2M0NCRWJXHgQ69Fcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430341; c=relaxed/simple;
	bh=uXi5KtkgSWbqnIXpKCfP3SY8U5zqjJAxBmzQ1U0rqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvUg2TWnq2CEF3Dtb1aXAKKq3SmO5rIXWayiPtcgCGfUUUu5+1vg/OD3zBkSAHO2GSY+dUq4aFn2urc9lOngkJW1/gFRPpz+rbYbDq2IrvNpzQJO5E2lAESxQJTS1zOnxWFFGNigzpTOWzQiOEmcH8x7DOL+LNCFxG6MgM4+oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KVAHxh+k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KVAHxh+k"
Received: (qmail 32085 invoked by uid 109); 5 Dec 2024 20:25:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uXi5KtkgSWbqnIXpKCfP3SY8U5zqjJAxBmzQ1U0rqy4=; b=KVAHxh+kaxkGg2jTCUMXzXqEhgo0lHw3RAqz2Apy8Qil3xInvyHmjwzOzLikaeYJioH29C1ytYRo43YK2A8/HMcjZDJvjNlu5GWaA9zMNKRCuhNIlSalZa5Eql/hyTyjdPx6oPn5IcpL2GUTYNffdGkg3uGyXqEwRoIBbbK31ticPnEXqfczTBkdBPPcLxq4jkLZPHywSfgPwkmJJTTxkWMC0HIA+l7MvbT+zzeRe/8vTI3sHnaI0YlSwdniT+0ZJbgVeQTA9YqMDRD7oWCBxtHV37BOpozOtLGB+PmX4xtWGufkvLzU3DdQw1yPUSGWmZZqOMgH/PDrJo9dT4PttA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 20:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9636 invoked by uid 111); 5 Dec 2024 20:25:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 15:25:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 15:25:37 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 3/4] t5604: do not expect that HEAD is a valid tagname
Message-ID: <20241205202537.GD2629822@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-4-gitster@pobox.com>
 <477f0dbd-60ed-4f73-b945-cdbdaf9f510a@app.fastmail.com>
 <20241202210006.GE776185@coredump.intra.peff.net>
 <xmqq34j5h7v9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34j5h7v9.fsf@gitster.g>

On Tue, Dec 03, 2024 at 10:29:14AM +0900, Junio C Hamano wrote:

> I have "git one" (and "git who") aliased to this script:
> 
>     $ cat $(type --path git-onewho)
>     #!/bin/sh
>     if sha1=$(git rev-parse -q --verify "$1")
>     then
>             git show --date=short -s --abbrev=8 --pretty='format:%h (%s, %ad)' "$1"
>     else
>             git log -1 --format="%aN <%aE>" --author="$1" --all
>     fi | tr -d "\012"
>     $ git help one
>     'one' is aliased to 'onewho'
>     $ git help who
>     'who' is aliased to 'onewho'
>     
> so that I can say "\C-u ESC ! git one HEAD" (or "git one peff")
> while writing a piece of e-mail.  I can drop --abbrev=8 from there
> but the machinery knows to bust that limit if it is necessary to
> ensure uniqueness, so ...

Yeah, I have something similar. IMHO a manual --abbrev there is working
against your goal.

We do increase that to find a unique answer, but that is not very
future-proof; it is only extending by one character taking into account
what objects you have _now_. It might not be true for somebody else's
repo with more objects, or even your own repo in the near future.

The auto-scaling of core.abbrev done by default these days also suffers
from that problem (it can only count how many objects you have now, not
how many you expect to have a year from now). But I think our heuristics
there give a bit higher safety margin for future-proofing the values.

-Peff
