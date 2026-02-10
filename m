Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F72F3618
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706749; cv=none; b=LGNuoIXSTEiwhJ56LVL/6Gt7gPl66pP/t4++uXf3Y/EEl5EHmFoPQ/k6ptcbzeUu7IB9V2nnzfg2sSIy9mw/SEGCepfikPxW6FfV/bFGg9JLiKsQkcEWGazyjnYL+WdiIUzLlORWgr4DEiLtbNX2r6rva0p+d7Ch3R4Q+h982ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706749; c=relaxed/simple;
	bh=sALZh2LGyne+z5k4QPE84zpLPBniKGg1JUK6u5YAFrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJV2kH5d3+ybarrZXcPkpqLeqh0s4isWzZ9FICQLSlgUv34/Z9meD3i+9kBYfAjJM5yuqnssvtg55gnBtj/ES3hb5KXMutzAIpIqiVAWiaCsAikgjl6/UnkiOuPrx9/zvt8v3l+r4QESR/iIhLZbaFpxod9UsbLq0OEUZRXvANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=esxY7Z7G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="esxY7Z7G"
Received: (qmail 353460 invoked by uid 109); 10 Feb 2026 06:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=sALZh2LGyne+z5k4QPE84zpLPBniKGg1JUK6u5YAFrU=; b=esxY7Z7GPEZ2DndM0R3kCTmZ1ug3eqoWX1jxuv9xzYJx3ffMOBb7C6UjfZkVhzXAgskzx+U3zSdT1DVUZVBSZ4n3SCWUpayu/CNoa5Fitq7E1RcvKpWmfFpoUqLAg8VqZUUKIswV2uBrHS/ZUnjvdMYavzh3j0QO5sJKQbUIeW0BHyrE0TZptxbqU+jm+oPXpDO8SxfZ6gcAqSQW4q1hor/MLfS+ws4gjB5OC0bTIy35woknj1nWDor0S7X8k6t8OfmOxB662kwT+k+Q/2buuv745bYX2PDtCsXNUiw5TxYv5ekYrBjRe6twImxGQeXcTFB5JLA2+p5GhZhx67qIqw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 06:59:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 697955 invoked by uid 111); 10 Feb 2026 06:59:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 01:59:05 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 01:59:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Message-ID: <20260210065901.GD1756549@coredump.intra.peff.net>
References: <xmqqecmt33xk.fsf@gitster.g>
 <D96BCAD5-5482-4BD5-B22E-82D34EBC1F0A@gmail.com>
 <xmqqzf5h1ka5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzf5h1ka5.fsf@gitster.g>

On Mon, Feb 09, 2026 at 05:04:18PM -0800, Junio C Hamano wrote:

> Ben Knoble <ben.knoble@gmail.com> writes:
> 
> > In what way do alias names end up being pathname components? Or
> > did you mean to insert « treated like » (as in, normalized as
> > command arguments)?
> 
> Ah, they don't.  I somehow was confusing those custom commands you
> would throw into your ~/bin as "git-something" ;-).
> 
> But you're correct to point out that for a command line "git
> something", "something" would go through the same "undo macOS NFD
> for all argv[] elements".

It's not an issue for aliases, but pager.* (and a hypothetical
pager.*.command) does care about the on-disk representation of program
names (and that it matches what is fed from the command-line).

-Peff
