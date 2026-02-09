Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09316450F2
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620420; cv=none; b=V/8/oPuQ/m4rcP3l87ggZhqR8rt3wn5zRypMLgBEJoMPupQMoyqLKLPwd1D2JP8hDV7E6jCsj34X9z8mYGuTYS27PEVt9CM7ZYWV0ByOwpfbC00EYN6Mg5U7hkxE/QfM2Z3JphYOsJgfMzaSajbaI5TDu8c6kzVC04Glo74owqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620420; c=relaxed/simple;
	bh=zGW5ayRU3POBiyKx9BbM5HqwoWPFFQ0VSHHU2Yg5K8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srUCQW2Iw7WNbgLoqMlR8iP+uHeaLhysSHjRcxcLlOtR/63YEX/OXyVFDGU02vh2RLJALAKzZZsg/CIhkGbSS0sxhGzjuIXZsVH7X8xhx2wjJ3wIDyAI+A3ZbV6BYVNwMEUzYCxJBNlBr0b83HyQ1azHyPnCvtN84VnF3vuJUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EUuJC4Bm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EUuJC4Bm"
Received: (qmail 339363 invoked by uid 109); 9 Feb 2026 07:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zGW5ayRU3POBiyKx9BbM5HqwoWPFFQ0VSHHU2Yg5K8g=; b=EUuJC4BmBsMO+8J6nVqyfxsHBI4KgDOT51jzrOjXR7sqOva7OMTx7cVhhBqyhdtUJylJ2BB/4uEenbEHjw8dtrC/6cAoSZpBgdAByRDMFZWP4faePFRWJKaKnXin7qCitOpfylJcL/C2pi3YInfMrsDTLQY6FihHXFUc/XB892J3JRAPsgJKSRFwIwCZpPpMgEg+rwxUKS7BvB/7q18KnV3FFaAsGnm8x2QDolmW9Mq8QGEQ2Inxdj5FCLjWRKSrncnb3Lua3eYTmgbI6A9t795m9MhL/1p3KUEg6UhD6ea/UsThGQJeL5foDE+wumBhTXsndbUriaj5UZUTOLG4Ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Feb 2026 07:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 669923 invoked by uid 111); 9 Feb 2026 07:00:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Feb 2026 02:00:23 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Feb 2026 02:00:18 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator
 line
Message-ID: <20260209070018.GB585828@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
 <xmqqldh4b5y2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldh4b5y2.fsf@gitster.g>

On Sat, Feb 07, 2026 at 01:27:01PM -0800, Junio C Hamano wrote:

> I have no qualms about the topic up to the previous step, but I know
> one of the things that I sometimes do will be broken with the change
> in this step, namely, when I know what I want to write below the
> three-dash lines, I would commit with "---" and additional notes
> below it, so that I do not forget during "format-patch".
>
> When the commit is turned into a patch email, possibly with some
> other material like "--notes=<ref>" that adds notes there, the
> resulting message will have two three-dashes lines, but because "am"
> cuts at the first one, and "apply" knows that the garbage lines at
> front, including three-dash lines, do not matter until it sees "^diff",
> this works out perfectly well.
> 
> Admittedly, I myself do not send out so many patches as I used to,
> but I suspect that there are others who have discovered this trick
> independently, and they would be unhappy to be interrupted by
> commit-msg hook like this.

I do it, too, though not all that often. Once upon a time I had a patch
to teach git-commit to auto-convert lines after "---" into a note (which
would then be formatted back out via format-patch). But I found for my
git.git workflow that just letting the "---" ride along in the commit
object was simpler and easier (since I don't care about having pristine
commit objects, as their ultimate fate is to be dropped in favor of what
is applied upstream).

-Peff
